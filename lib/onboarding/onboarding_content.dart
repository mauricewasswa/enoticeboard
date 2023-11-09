class OnBoardingContent {
  late String image;
  late String title;
  late String description;

  OnBoardingContent({required this.image,required this.title,required this.description});
}

List<OnBoardingContent> contents =[
  OnBoardingContent(
      image: "assets/first_img.svg",
      title: 'Awareness Re-imagined',
      description:"Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
      "Ut viverra sed enim ut scelerisque. Mauris mollis velit consequat vulputate vulputate. "
      "Donec non dictum nunc, sit amet rhoncus eros. Integer ornare felis quis leo interdum, "
      "eget interdum velit finibus. Vestibulum id dictum elit. Sed in mi dignissim, egestas enim ut, "
      "efficitur mauris. Maecenas varius porta lorem, vel suscipit felis feugiat nec.",
  ),

  OnBoardingContent(
    image: "assets/second_img.svg",
    title: 'Get Information Anytime',
    description:"Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
        "Ut viverra sed enim ut scelerisque. Mauris mollis velit consequat vulputate vulputate. "
        "Donec non dictum nunc, sit amet rhoncus eros. Integer ornare felis quis leo interdum, "
        "eget interdum velit finibus. Vestibulum id dictum elit. Sed in mi dignissim, egestas enim ut, "
        "efficitur mauris. Maecenas varius porta lorem, vel suscipit felis feugiat nec.",
  ),

  OnBoardingContent(
    image: "assets/third_img.svg",
    title: 'Give Feedback',
    description:"Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
        "Ut viverra sed enim ut scelerisque. Mauris mollis velit consequat vulputate vulputate. "
        "Donec non dictum nunc, sit amet rhoncus eros. Integer ornare felis quis leo interdum, "
        "eget interdum velit finibus. Vestibulum id dictum elit. Sed in mi dignissim, egestas enim ut, "
        "efficitur mauris. Maecenas varius porta lorem, vel suscipit felis feugiat nec.",
  )
];