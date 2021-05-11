using System;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;
using x1.Services;
using x1.Views;

namespace x1
{
    public partial class App : Application
    {

        public App()
        {
            InitializeComponent();

            DependencyService.Register<MockDataStore>();
            MainPage = new AppShell();
        }

        protected override void OnStart() { }

        protected override void OnSleep() { }

        protected override void OnResume() { }
    }
}
