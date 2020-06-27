// https://gitlab.gnome.org/GNOME/gtk/-/blob/master/tests/simple.c
// gcc -o simplegtk3 simplegtk3.c `pkg-config --libs --cflags gtk+-3.0`

#include <gtk/gtk.h>

static void
hello (void)
{
  g_print ("hello world\n");
}


int
main (int argc, char *argv[])
{
  GtkWidget *window, *button;
  gtk_init(&argc, &argv);
  window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
  gtk_window_set_title (GTK_WINDOW (window), "hello world");
  gtk_window_set_resizable (GTK_WINDOW (window), FALSE);
  g_signal_connect(window, "destroy", G_CALLBACK(gtk_main_quit), NULL);  
  button = gtk_button_new ();
  gtk_button_set_label (GTK_BUTTON (button), "hello world");
  gtk_widget_set_margin_top (button, 10);
  gtk_widget_set_margin_bottom (button, 10);
  gtk_widget_set_margin_start (button, 10);
  gtk_widget_set_margin_end (button, 10);
  g_signal_connect (button, "clicked", G_CALLBACK (hello), NULL);
  gtk_container_add (GTK_CONTAINER (window), button);
  gtk_widget_show_all (window);
  gtk_main();
  return 0;
}
