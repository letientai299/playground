using System.ComponentModel;
using Xamarin.Forms;
using x1.ViewModels;

namespace x1.Views
{
    public partial class ItemDetailPage : ContentPage
    {
        public ItemDetailPage()
        {
            InitializeComponent();
            BindingContext = new ItemDetailViewModel();
        }
    }
}