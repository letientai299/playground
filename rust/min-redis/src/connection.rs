use crate::helper::Result;
use bytes::BytesMut;
use tokio::{io::AsyncReadExt, net::TcpStream};

use crate::Frame;

pub struct Connection {
    stream: TcpStream,
    buffer: BytesMut,
}

impl Connection {
    pub fn new(stream: TcpStream) -> Self {
        Self {
            stream,
            buffer: BytesMut::with_capacity(1024),
        }
    }
    pub async fn read_frame(&mut self) -> Result<Option<Frame>> {
        loop {
            if let Some(frame) = self.parse_frame()? {
                return Ok(Some(frame));
            }

            if 0 == self.stream.read_buf(&mut self.buffer).await? {
                if self.buffer.is_empty() {
                    return Ok(None);
                }

                return Err("connection reset by peer".into());
            }
        }
    }

    pub async fn write_frame(&mut self, _f: &Frame) -> Result<()> {
        unimplemented!()
    }

    // Attempt to parse frame from butter data.
    fn parse_frame(&mut self) -> Result<Option<Frame>> {
        Ok(Some(Frame::Simple("some".into())))
    }
}
