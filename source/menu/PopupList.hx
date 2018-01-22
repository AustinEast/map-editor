package menu;

class PopupList extends Popup {

    public function new (text:String, path:String, relative = true) {
        super(text);
        //add content items
        init_menu();
    }
}