import UIKit

class ViewController: UIViewController {
    
    var model: RankinglistModel?
    //请求参数
    
    let pi = 1
    let pz = 1
    
    lazy var segment: UISegmentedControl = {
        let tempView = UISegmentedControl(items: ["moya", "链式", "AFN式"])
        tempView.frame = CGRect(x:0, y: 40, width: self.view.frame.width, height: 40)
        tempView.selectedSegmentIndex = 0
//        tempView.addTarget(self, action: #selector(clickSegment), for: .valueChanged)
        tempView.rx.controlEvent(.valueChanged).subscribe({_ in
            print("点击 Segment")
        })
        return tempView
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect(x:0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 100), style: .plain)
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 120
        
        table.delegate = self
        table.dataSource = self
        table.register(DMCell.self, forCellReuseIdentifier: "DMCell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addSubview(tableView)
        
        loadDataByMoay()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.rankinglist?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DMCell = tableView.dequeueReusableCell(withIdentifier: "DMCell", for: indexPath) as! DMCell
        cell.model = model?.rankinglist?[indexPath.row]
        return cell
    }
}

extension ViewController {
    
    /// moya请求
    func loadDataByMoay() {
        XYHttpRequest.request(XYApi.rankList, model: RankinglistModel.self) { (model) in
            self.model = model
            self.tableView.reloadData()
        }

    }
}
