/*
 Shawn E. Larson
 iOS Internationalization
 BSD License, Use at your own risk
 */

#import "SortingViewController.h"

@interface SortingViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *frenchText;
@property (nonatomic, strong) NSArray *japaneseText;
@property (nonatomic, strong) NSArray *turkishText;
@property (nonatomic, strong) NSArray *englishText;
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (nonatomic, strong) NSArray *sortedArray;
@property (weak, nonatomic) IBOutlet UIButton *unsortButton;
@property (weak, nonatomic) IBOutlet UIButton *sortListButton;

- (IBAction)sortList:(id)sender;
- (IBAction)unsortList:(id)sender;

@end

@implementation SortingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    [self.listTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.frenchText = @[@"čučēt", @"coté", @"yuan", @"zznj", @"Sietla", @"andere", @"hiša", @"Zviedrija", @"väga", @"šàran", @"màšta", @"mîr", @"ändere", @"pint", @"ślub", @"luck", @"subtle", @"côté", @"lie", @"žal", @"Czech", @"vox", @"symbol", @"savoir", @"chaque", @"Männer", @"yucca", @"myndig", @"irdisch", @"zzlz", @"Šerbūra", @"yen", @"zysk", @"Lübeck", @"llama", @"wood", @"lävi", @"lòza", @"luč", @"möchten", @"piña", @"verkehrt", @"zznz", @"Aaron", @"waffle", @"lye", @"zoo", @"pylon", @"côte", @"žena", @"lõug", @"cote", @"sämtlich", @"Löwen", @"chemin", @"zzlj", @"Ženēva", @"lire", @"Zürich"];
    self.japaneseText = @[@"漢字", @"サアフ", @"はいく", @"！漢字", @"てつぼう", @"すきい", @"ﾊﾟｲｸ", @"[ﾊﾞｲｸ]", @"さーふ", @"ﾊﾟｲｸﾌﾟﾚｰｽ", @"さあぶ", @"さあふ", @"ﾊﾞｲｸﾚｰｽ", @"バイ ク", @"てっぽう", @"バイク", @"すきー", @"ﾊﾞｲｸ", @"スキー", @"ｻ-ﾌ"];
    self.turkishText = @[@"möchten", @"lòza", @"žena", @"verkehrt", @"lye", @"lõug", @"Zürich", @"pylon", @"zzlz", @"lie", @"ślub", @"Löwen", @"Zviedrija", @"chaque", @"ändere", @"côte", @"žal", @"pint", @"Czech", @"luck", @"yucca", @"Ženēva", @"zzlj", @"savoir", @"waffle", @"čučēt", @"myndig", @"zoo", @"symbol", @"lävi", @"yen", @"lire", @"subtle", @"väga", @"Sietla", @"màšta", @"sämtlich", @"zznj", @"zysk", @"wood", @"andere", @"irdisch", @"vox", @"zznz", @"coté", @"llama", @"côté", @"šàran", @"piña", @"cote", @"Aaron", @"Lübeck", @"chemin", @"luč", @"hiša", @"Šerbūra", @"mîr", @"Männer", @"yuan"];
    self.englishText = @[@"Soffits", @"subcurrent", @"outmatch", @"predelegating", @"Seneca", @"reciprocity", @"vernation", @"predeficient", @"nondistortion", @"syndetic", @"nettlesome", @"agenesis", @"unscabbed", @"gibberish.", @"Calliope", @"caddishness", @"nongestic", @"definitising", @"Kaiser", @"gabber", @"guessingly", @"entomologizing", @"distrait", @"amaze", @"tetradrachmal", @"inconceivableness", @"guard.", @"Unruffled", @"offender", @"amphitoky", @"comprehend", @"toxically", @"trillion", @"bannerol", @"ampulla", @"trichopteran", @"Nineveh", @"chain", @"putting", @"emotionalize", @"joule.", @"Crust", @"schizogony", @"marvel", @"crashingly", @"rails", @"carpingly", @"demandable", @"reiterating", @"veneered", @"hygienically", @"inimitability", @"testudinarian.", @"Sequential", @"Ockham", @"Aubrey", @"Sabena", @"nonvibration", @"finch", @"parse", @"home", @"out", @"gleam", @"physiocratic", @"unteeming", @"harpsichordist", @"smutchless", @"Muscat.", @"aubrey", @"Outmatch"];
}

- (IBAction)sortList:(id)sender {
    self.sortedArray = [NSArray new];
    
     self.sortedArray = [self.englishText sortedArrayUsingSelector:@selector(localizedCompare:)];
    [self.listTableView reloadData];
    self.sortListButton.enabled = NO;
    self.unsortButton.enabled = YES;
}

- (IBAction)unsortList:(id)sender {
    self.sortedArray = nil;
    [self.listTableView reloadData];
    self.sortListButton.enabled = YES;
    self.unsortButton.enabled = NO;
}

#pragma  mark UITableView Delegate Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.frenchText count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
     if (self.sortedArray) {
        cell.textLabel.text = [self.sortedArray objectAtIndex:indexPath.row];
    }else{
        cell.textLabel.text = [self.englishText objectAtIndex:indexPath.row];
    }
   
    return cell;
}

@end
