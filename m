Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFBD6451CF
	for <lists+linux-arch@lfdr.de>; Wed,  7 Dec 2022 03:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiLGCPB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Dec 2022 21:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiLGCO7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Dec 2022 21:14:59 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0063153EF0
        for <linux-arch@vger.kernel.org>; Tue,  6 Dec 2022 18:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670379295; x=1701915295;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=GsL1t5MFOp1Y5daaKuiN7kf3extTIo1Tk7fwAu33eaI=;
  b=cITWMrWiceLHZm9bzlAVL9m0vD1O7qslm2R0I2jqmrzcryW2OnKc7miq
   JJqcSFYDuSPNZvBOSaG1TGddGkTdDELJkiB5rjjJqgSFYl6ymTHit2uib
   VnTRavK3zBe8hs/jH8SQlKS0/EhGmn54u92GLPEFJSOscJ2wJLDyxs2v5
   9ZtntGllajHFuC63vfeSZWFnUlipjRZypGdo8PMse1OvKjb4dHnMcxh42
   JsxjBk8tHqzcF3hTMm7imInvbyiXDmzfAiBZTFGv4/bMu+mFVb2GT4lum
   BcE1uo7HDANxS1fss5OfAYjXFDOEiGwEcXRcTNaDzwKtYibJYj+wviRAg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="296478472"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="296478472"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 18:14:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="975291030"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="975291030"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 06 Dec 2022 18:14:55 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 6 Dec 2022 18:14:54 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 6 Dec 2022 18:14:54 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 6 Dec 2022 18:14:54 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 6 Dec 2022 18:14:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODx64fZB4S3T/bUdVTY3GJSYQ4DjrLeRqmt+mMPNyddenwD4xta4hp4btGIFO4S5nrgvms+FxR2TrSdvYh/oXFjjLtWcvNFvA8RZdxI8VM08qXwlWeaITOqD8ok2SezzoIkU4cmX3JZ7nBDX/KYo8nxBc69W1G6dhSi2Jdw/mRulpgtONENdheJQ9gn9k+1IQa8laIfQTEZN4YSne6/qedU21AUM6alfjTKCeam7lObQf0uap1peVHbOQMsxYw2EgvASQhMRXZlp2FHApf7O1hZ35m9gqEaCuIbVJCteAaejCF09fcaA9xxunp6Y44z9dLi3ViPNOVTu0OrjXACUTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9BoxkhaQIif+tEyDwnyIP8b+gQQqgBS5Cx/vlCk/qM=;
 b=BQX6sBn7h1z/tkGFBrwZEKy1SvjG1mVjgMgo+FUEStu5YqjnTZVC2kjHqrQSgHsPCIotKy2goafj1X1SbqbzdvUxeMphrdP4GwOgrsM/DK4M9MsLOF9IARRLRFa52Z/3JWML1Umi5QGkHeMTRkXg3hE4hNYdw3Ao7mmNpUGMDILopVhgFZaDTQ8JapyxlJJGbOJxHk2PffOEDEXWjgcKRfIbrhxVquKE61k7IcWcQJWJ7k1Y3f045K4rvnTkOo80NUY8cQt5gmVHdAlA8CpNwqG7fH6QmSBHqIFXjPpfCVCqW78cJtin3Z1GvC8C8bYAvuN9V0PioNXe0I8y81VTNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by DM8PR11MB5670.namprd11.prod.outlook.com (2603:10b6:8:37::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 02:14:48 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::513a:f91a:b65c:be1d]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::513a:f91a:b65c:be1d%4]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 02:14:48 +0000
Date:   Wed, 7 Dec 2022 10:12:45 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Hugh Dickins" <hughd@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        "Linux Memory Management List" <linux-mm@kvack.org>,
        <linux-arch@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <zhengjun.xing@linux.intel.com>,
        <fengwei.yin@intel.com>
Subject: Re: [linux-next:master] [mm] 5df397dec7:
 will-it-scale.per_thread_ops -53.3% regression
Message-ID: <Y4/2nZoYtDufIMSK@yujie-X299>
References: <202212051534.852804af-yujie.liu@intel.com>
 <CAHk-=wg330wAAxwSaJBPUtL5Rrn7PoQK3ksJw2OLvBxA0NGg+g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wg330wAAxwSaJBPUtL5Rrn7PoQK3ksJw2OLvBxA0NGg+g@mail.gmail.com>
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|DM8PR11MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: 189967f9-3f22-4c59-944b-08dad7f8d081
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j78jdeQKbUa4blZYO4v7yHKA7XgfIByyIqF2v2DFsGQbO6Gu+oHrtq8/RB4dkl6m3L8YNjP9S5Mpo8jEwdgRveFpJLTF7GAVF5Jyagv1O3pW+sR5f1+Tl17GFE1O8I1BkD/EGcxsOCKU2h5/KbEF04J3g9FB7cqBZSq3Gn584QFVTjlB+xcKdJSFO5OHGrd/Ge40S4Y+cVKyfJYujvUQnaH3dD2wjl/11mi8ugyVSJ/XfvHFg3kyYSV5Xq+Ljbzvmep9AdKYFr8ZVm3kSK+Ya3yoIHxN6daQHIwI4FD9eypLA7MqSDyO+R5ye4fuK9EDaXB7BmuUlKKyazk6iz3rsr9plU6ajuzOurLu9iywOk3hG2JQVQKMY89TiDyUtooiMeu/2WPML7AEi/2qoai3+bGTljWnJF8+rlrgCegRHEQ9sPD92j9Qv9kR7f92xOMTk/zuffcjpQDstiY3AZguxjfxNAGAKlCgOldk3yY8djyJlIi7PBh5XBc2BNva0kFjaMIdd0ISVhKUlYNgP6gDxKKLy7G4M6FJOc/PLgmFk7VwOQZcGJSSKCoNxu7heYHWjP7I8PD5WUqe42Ns6+j/9FuXgmeAxBe6P0+3A9QhFStQ3bpREOI0gXI1SKhl6gjUtmpqIzah8/EWDTUbb/mITQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199015)(54906003)(38100700002)(30864003)(86362001)(8936002)(41300700001)(2906002)(4326008)(44832011)(5660300002)(83380400001)(478600001)(66556008)(316002)(6486002)(66946007)(19627235002)(6916009)(82960400001)(33716001)(8676002)(6506007)(6666004)(26005)(186003)(9686003)(53546011)(6512007)(66476007)(579004)(559001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGpHTjVvWTd5OFBjWnlvK3ZBT1Qvc2lNQk5aRlNUMWZCT1NYUG1ocFNHWEs1?=
 =?utf-8?B?aDhYVlRVbzFIQjZtS2VMSWMyVTE3ZURqUVlhdUF6YzdPOUd0ZERoVEhuaW1M?=
 =?utf-8?B?cjdCUmUwZ0VGeVkxM2R2UTJQZXZFOGdBeEdlR3FkY1JCckdyQjJ4SitwbWJJ?=
 =?utf-8?B?YVYxcjJDTXRIZzBEUU1tUGpDZGVFVE5sZkxiWjBDZitMOWpLL2xKc2p5MzFK?=
 =?utf-8?B?UldRQ3JlbW9ZbUZuUW1xcnRiSm01Yys0VTlLRkwwM1ZMTk5TVkk1emorWG9C?=
 =?utf-8?B?UWFLUEYvZm5LZktreElvaC9NbkZJdnptamVsMzlWVStHSFhkMjdNaGVzaGpr?=
 =?utf-8?B?K1E1eUZiREpOTG1mY1RVSG96SUdmeWg1elFSZG0zaE9GMWxhbkczdHl0YVg3?=
 =?utf-8?B?b1NpL1Y3ek9vc2d5a2RjRjlXQTJGb2ZrUEFyOHk2c2k3VWpteWlERVZFdTQr?=
 =?utf-8?B?T283T2hZSmZCZFBZVnpVd2xBMVp1cXNSK1JMZFVqeWY2TDVVWUQxeCtQNlJV?=
 =?utf-8?B?M0FRRFJBZWUvTkpGd0x4VGFmOCtnZjQ1d1JBTGNnR1c1aW5NdzRaRCs1UVZk?=
 =?utf-8?B?cmdKTXplMkpGeXROai9lc1RQRHZweW10RDJkMzZaQTNuWnhmTFBzcHdWL0la?=
 =?utf-8?B?Q0pYUHBEUExJamtaQjNuTXBYY1hYdXV6NE5NN0ZMaWk4V0ZJb2ZqTlFjQllh?=
 =?utf-8?B?TE5nMmFVM1B6UE1XYXdIdHloTXFibmZIdUhHRnNiY0VnUU5BbFU0azVuKzlP?=
 =?utf-8?B?ZVR1VXVWMVBaWjYxenh3bmFnMWk0dSs2ekVjT0FXbXJOV3p2dXNvUWpPSHR4?=
 =?utf-8?B?N3FXNEN0V2YzZEllUTNhWEFIM3VrU0FZZzFtZ0hKSnJKWjMrSmxJdjh6MHd3?=
 =?utf-8?B?WHJzMDRPQ1lkYlk4eVFjRGExTmJ0U0llWlJ6MDVpSDR4bkYxcmZiSXhjTlFF?=
 =?utf-8?B?TEl2NWFyTkpoRS9VWlgxa01zcTRtK2FJd1pBQSs3RnlHdjdKSE40aUMxVjVq?=
 =?utf-8?B?Zmk2cDdGVkkxbXBreUxJemZpLy9YSTBWSWVicXhMeEVVb2xqbWdEK0lQYmhq?=
 =?utf-8?B?bVR1NlB0VDhJNTJWcTU0VGVmU3Q4aDMwY2RTbmNJaG02alArTFFEVzB6QUc3?=
 =?utf-8?B?OWhaTnV6alczNko5bFlCL2xVSFd4ci9NeWFCejgxQ2xtUnBsTktmUlJ4Ui8r?=
 =?utf-8?B?S0tKZnpuWlNUN0thT3ppMGZPUm1aMWRvTi9uUzdTVmJHY1F0aTNwajNPVGk4?=
 =?utf-8?B?VTdTSENaTXR2bjdTd0JhY084R1dzZ3ByV0xlZ3A2ZkFkTzA0OUUwRFlWOEx0?=
 =?utf-8?B?WEphbUg0THEzeGp6eHVlb0ErTXZpYm5NdXFlWUMvYVlhc0VKNGF1OTNIZzFJ?=
 =?utf-8?B?dGh4d053TU5FRjdJTHZGU1NGQThlL1RKTTJXZ1lWREx2d2czSkluRmdVaXdL?=
 =?utf-8?B?QUduejN4NTRVNk1GVVJXWlM1aVloRklGZlR2eGI5RUJydmRJcUxiSlNmSk4x?=
 =?utf-8?B?TVhzbTA2cnJkUGVGOTBPeFVMYWh5WEV3Rk40MVMvNDB1a0FOUklPWUhMUXpa?=
 =?utf-8?B?M1lWZWxwU2JZRGxvS2llUERiNitXQ1YrQTNjeXBuK2dGTEw1RjhnNGgyb2Rz?=
 =?utf-8?B?YnR1emZ2MWJqKzIvcHZsSW05Z0NjSE5ETzZEbE1XM0tXYXdrakY5S0l3RWZj?=
 =?utf-8?B?d0Q5Z01EaTJ6UGdSRU1CRkw5aldwY3BIVlFpMTN6TFkzeUdTU0ZYRWVMWjk3?=
 =?utf-8?B?VzdZNmVra0FIdkwrYmt2NWV0dURSTk9keUowWU55R21XTktFMWFMd2REc21K?=
 =?utf-8?B?UnVlMElsRkRvUkdRSGRoTDB2NzdUZ05ITnh4aG1EY21PMEpKejAvb1FRRDVK?=
 =?utf-8?B?a294OFZ1cFloaEtnNnQyRUNuK095cTVqTXg4NVQ4d2JKNzB1ZUQvWDdETGJt?=
 =?utf-8?B?ZEorMTZ1VDZUV2FUNEU1VFZic3FrRWpoR3dscjF6enJ4eEJjbjFYSGFZR05q?=
 =?utf-8?B?bmlBdzYyOFh1VHBJQkN6aTB6aFhMaWs4SzhlYzR3Sy9ERG91cTEzeUh6M1dQ?=
 =?utf-8?B?aU5PQlozNnJ0TE5tU0hWMGoxejM5N1NTQWY3ZW0xUko0VVNVdEVJSGdkSmlw?=
 =?utf-8?B?a3d6bmtJY2tYVE5Ga2duRUhYZjQ3NGduVHFvbDIwY1NpOTBVVzhLTnZIN20x?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 189967f9-3f22-4c59-944b-08dad7f8d081
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 02:14:48.0746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hvC/rivnbyJItI92F30g2+CLOfyuBBpHP4Xg1GXmYmiAIWefnw++11fSaq4YZjqg++Q4bptOTBD2gxmcBhJblw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5670
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 05, 2022 at 12:43:37PM -0800, Linus Torvalds wrote:
> On Mon, Dec 5, 2022 at 1:02 AM kernel test robot <yujie.liu@intel.com> wrote:
> >
> > FYI, we noticed a -53.3% regression of will-it-scale.per_thread_ops due to commit:
> > 5df397dec7c4 ("mm: delay page_remove_rmap() until after the TLB has been flushed")
> 
> Sadly, I think this may be at least partially expected.
> 
> The code fundamentally moves one "loop over pages" and splits it up
> (with the TLB flush in between).
> 
> Which can't be great for locality, but it's kind of fundamental for
> the fix - but some of it might be due to the batch limit logic.
> 
> I wouldn't have expected it to actually show up in any real loads, but:
> 
> > in testcase: will-it-scale
> >         test: page_fault3
> 
> I assume that this test is doing a lot of mmap/munmap on dirty shared
> memory regions (both because of the regression, and because of the
> name of that test ;)
> 
> So this is hopefully an extreme case.
> 
> Now, it's likely that this particular case probably also triggers that
> 
>         /* No more batching if we have delayed rmaps pending */
> 
> which means that the loops in between the TLB flushes will be smaller,
> since we don't batch up as many pages as we used to before we force a
> TLB (and rmap) flush and free them.
> 
> If it's due to that batching issue it may be fixable - I'll think
> about this some more, but
> 
> > Details are as below:
> 
> The bug it fixes ends up meaning that we run that rmap removal code
> _after_ the TLB flush, and it looks like this (probably combined with
> the batching limit) then causes some nasty iTLB load issues:
> 
> >    2291312 ą  2%   +1452.8%   35580378 ą  4%  perf-stat.i.iTLB-loads
> 
> although it also does look like it's at least partly due to some irq
> timing issue (and/or bad NUMA/CPU migration luck):
> 
> >    388169          +267.4%    1426305 ą  6%  vmstat.system.in
> >     161.37           +84.9%     298.43 ą  6%  perf-stat.ps.cpu-migrations
> >    172442 ą  4%     +26.9%     218745 ą  8%  perf-stat.ps.node-load-misses
> 
> so it might be that some of the regression comes down to "bad luck" -
> it happened to run really nicely on that particular machine, and then
> the timing changes caused some random "phase change" to the load.
> 
> The profile doesn't actually seem to show all that much more IPI
> overhead, so maybe these incidental issues are what then causes that
> big regression.
> 
> It would be lovely to hear if you see this on other machines and/or loads.

FYI, we ran this "will-it-scale page_fault3" testcase on two other x86
platforms and observed similar performance regressions. We haven't
seen regressions from other benchmarks/workloads yet.


96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake)
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-11/performance/x86_64-rhel-8.3/thread/16/debian-11.1-x86_64-20220510.cgz/lkp-csl-2sp7/page_fault3/will-it-scale

commit:
  7cc8f9c7146a5 ("mm: mmu_gather: prepare to gather encoded page pointers with flags")
  5df397dec7c4c ("mm: delay page_remove_rmap() until after the TLB has been flushed")

7cc8f9c7146a5                  5df397dec7c4c
---------------- ------------ --------------
         %stddev     %change         %stddev
             \          |                \
   5292018           -41.6%    3090618 ±  2%  will-it-scale.16.threads
     84.04            +5.5%      88.64        will-it-scale.16.threads_idle
    330750           -41.6%     193163 ±  2%  will-it-scale.per_thread_ops
   5292018           -41.6%    3090618 ±  2%  will-it-scale.workload
   3777076           -33.9%    2496224        numa-numastat.node0.local_node
   3834886           -33.7%    2541691        numa-numastat.node0.numa_hit
      1.17 ±  9%      +1.2        2.39 ±  8%  mpstat.cpu.all.irq%
     13.50 ±  2%      -5.3        8.17        mpstat.cpu.all.sys%
      1.14 ± 39%      -0.5        0.64        mpstat.cpu.all.usr%
     83.83            +6.0%      88.83        vmstat.cpu.id
     13.83 ±  2%     -32.5%       9.33 ±  5%  vmstat.procs.r.
      9325 ±  3%     -46.2%       5018        vmstat.system.cs
    298875          +422.0%    1560096        vmstat.system.in
    160279 ± 23%     +36.5%     218776 ± 12%  numa-meminfo.node0.AnonPages
    166313 ± 21%     +34.5%     223688 ± 11%  numa-meminfo.node0.Inactive
    164286 ± 22%     +35.9%     223228 ± 11%  numa-meminfo.node0.Inactive(anon)
      4048 ±  6%     +14.1%       4620 ±  5%  numa-meminfo.node0.PageTables
    247964 ± 16%     -28.7%     176690 ± 17%  numa-meminfo.node1.AnonPages.max
     40074 ± 23%     +36.5%      54693 ± 12%  numa-vmstat.node0.nr_anon_pages
     41076 ± 22%     +35.9%      55806 ± 11%  numa-vmstat.node0.nr_inactive_anon
      1012 ±  6%     +14.0%       1154 ±  5%  numa-vmstat.node0.nr_page_table_pages
     41076 ± 22%     +35.9%      55806 ± 11%  numa-vmstat.node0.nr_zone_inactive_anon
   3834883           -33.7%    2541696        numa-vmstat.node0.numa_hit
   3777072           -33.9%    2496229        numa-vmstat.node0.numa_local
    442.00           -29.3%     312.67 ±  2%  turbostat.Avg_MHz
     16.87 ±  2%      -4.5       12.33 ±  4%  turbostat.Busy%
    611287 ± 13%     -91.1%      54248 ± 13%  turbostat.C1
      0.27 ± 16%      -0.3        0.01        turbostat.C1%
 1.238e+08          +624.2%  8.965e+08        turbostat.IRQ
    167.40            -6.5%     156.53        turbostat.PkgWatt
    270220            +1.8%     275170        proc-vmstat.nr_mapped
   4434671           -29.9%    3110296        proc-vmstat.numa_hit
   4348904           -30.5%    3023405        proc-vmstat.numa_local
    548152            -1.4%     540422        proc-vmstat.pgactivate
   4512817           -29.2%    3193199        proc-vmstat.pgalloc_normal
 1.594e+09           -41.6%  9.308e+08 ±  2%  proc-vmstat.pgfault
   4490607           -29.4%    3171990        proc-vmstat.pgfree
      0.42 ±  4%     -12.7%       0.36 ±  7%  sched_debug.cfs_rq:/.h_nr_running.stddev
     78690 ±  2%     +78.7%     140636 ± 46%  sched_debug.cfs_rq:/.load.max
     30480 ±  5%     +31.9%      40209 ± 15%  sched_debug.cfs_rq:/.load.stddev
    317962 ±  8%     -48.8%     162930 ± 15%  sched_debug.cfs_rq:/.min_vruntime.avg
   1279285 ± 12%     -56.3%     558508 ± 11%  sched_debug.cfs_rq:/.min_vruntime.max
    404116 ± 10%     -57.3%     172730 ± 10%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.42 ±  5%     -12.6%       0.36 ±  7%  sched_debug.cfs_rq:/.nr_running.stddev
    231.45 ±  7%     -23.5%     177.15 ±  6%  sched_debug.cfs_rq:/.runnable_avg.avg
    854.02 ±  3%     -15.8%     719.28 ±  7%  sched_debug.cfs_rq:/.runnable_avg.max
    315.94 ±  4%     -27.2%     229.91 ±  2%  sched_debug.cfs_rq:/.runnable_avg.stddev
    681750 ± 31%     -50.1%     340262 ± 13%  sched_debug.cfs_rq:/.spread0.max
   -577443           -66.6%    -193080        sched_debug.cfs_rq:/.spread0.min
    404120 ± 10%     -57.3%     172733 ± 10%  sched_debug.cfs_rq:/.spread0.stddev
    231.41 ±  7%     -23.5%     177.11 ±  6%  sched_debug.cfs_rq:/.util_avg.avg
    853.96 ±  3%     -15.8%     719.22 ±  7%  sched_debug.cfs_rq:/.util_avg.max
    315.91 ±  4%     -27.2%     229.88 ±  2%  sched_debug.cfs_rq:/.util_avg.stddev
    155.50 ±  9%     -49.7%      78.27 ± 26%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    781.56 ±  2%     -22.9%     602.36 ±  5%  sched_debug.cfs_rq:/.util_est_enqueued.max
    267.82 ±  5%     -39.1%     163.05 ± 10%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    151897 ± 35%     +76.2%     267629 ± 33%  sched_debug.cpu.avg_idle.min
    215458 ± 12%     -41.9%     125119 ±  7%  sched_debug.cpu.avg_idle.stddev
      1645 ±  9%     +85.1%       3044 ±  6%  sched_debug.cpu.clock_task.stddev
    872.08 ±  4%     -28.3%     624.97 ± 12%  sched_debug.cpu.curr->pid.avg
      1962 ±  2%     -14.7%       1674 ±  6%  sched_debug.cpu.curr->pid.stddev
      0.17 ±  5%     -27.9%       0.12 ± 12%  sched_debug.cpu.nr_running.avg
      0.37 ±  2%     -16.5%       0.31 ±  6%  sched_debug.cpu.nr_running.stddev
     16252 ±  9%     -38.7%       9956 ±  7%  sched_debug.cpu.nr_switches.avg
     18638 ± 12%     -43.9%      10451 ± 19%  sched_debug.cpu.nr_switches.stddev
 3.315e+09           -29.4%   2.34e+09        perf-stat.i.branch-instructions
      0.30 ± 21%      +0.2        0.50 ± 24%  perf-stat.i.branch-miss-rate%
   8341916 ± 11%     -31.9%    5682680 ± 15%  perf-stat.i.cache-misses
      9303 ±  3%     -46.8%       4949        perf-stat.i.context-switches
 4.193e+10           -29.8%  2.944e+10 ±  2%  perf-stat.i.cpu-cycles
 4.344e+09           -28.1%  3.122e+09        perf-stat.i.dTLB-loads
      5.87            -1.0        4.85        perf-stat.i.dTLB-store-miss-rate%
 1.477e+08           -41.7%   86041370 ±  2%  perf-stat.i.dTLB-store-misses
 2.369e+09           -28.9%  1.685e+09        perf-stat.i.dTLB-stores
     86.29           -60.2       26.04        perf-stat.i.iTLB-load-miss-rate%
  10635919 ± 17%     -15.9%    8947125        perf-stat.i.iTLB-load-misses
   1651323 ±  6%   +1441.1%   25448763        perf-stat.i.iTLB-loads
 1.593e+10           -29.2%  1.128e+10        perf-stat.i.instructions
      0.44           -29.8%       0.31 ±  2%  perf-stat.i.metric.GHz
    450.64 ± 78%    +335.6%       1963 ± 15%  perf-stat.i.metric.K/sec
    106.83           -30.1%      74.65        perf-stat.i.metric.M/sec
   5278281           -41.7%    3075728 ±  2%  perf-stat.i.minor-faults
      0.48 ± 14%      +0.5        0.94 ± 22%  perf-stat.i.node-store-miss-rate%
   5329558           -41.5%    3115251 ±  2%  perf-stat.i.node-stores
   5278281           -41.7%    3075729 ±  2%  perf-stat.i.page-faults
      0.32 ± 20%      +0.2        0.53 ± 22%  perf-stat.overall.branch-miss-rate%
      5.87            -1.0        4.86        perf-stat.overall.dTLB-store-miss-rate%
     86.34           -60.3       26.01        perf-stat.overall.iTLB-load-miss-rate%
      0.47 ± 14%      +0.3        0.81 ± 23%  perf-stat.overall.node-store-miss-rate%
    909203           +21.4%    1104227        perf-stat.overall.path-length
 3.304e+09           -29.4%  2.333e+09        perf-stat.ps.branch-instructions
   8314122 ± 11%     -31.9%    5663748 ± 15%  perf-stat.ps.cache-misses
      9272 ±  3%     -46.8%       4933        perf-stat.ps.context-switches
 4.179e+10           -29.8%  2.935e+10 ±  2%  perf-stat.ps.cpu-cycles
  4.33e+09           -28.1%  3.111e+09        perf-stat.ps.dTLB-loads
 1.472e+08           -41.8%   85755366 ±  2%  perf-stat.ps.dTLB-store-misses
 2.361e+09           -28.9%  1.679e+09        perf-stat.ps.dTLB-stores
  10601230 ± 17%     -15.9%    8917293        perf-stat.ps.iTLB-load-misses
   1645797 ±  6%   +1441.2%   25364210        perf-stat.ps.iTLB-loads
 1.588e+10           -29.2%  1.124e+10        perf-stat.ps.instructions
   5260752           -41.7%    3065504 ±  2%  perf-stat.ps.minor-faults
   5311793           -41.5%    3104889 ±  2%  perf-stat.ps.node-stores
   5260753           -41.7%    3065504 ±  2%  perf-stat.ps.page-faults
 4.812e+12           -29.1%  3.412e+12        perf-stat.total.instructions
     22.05 ±  8%      -4.7       17.34 ± 11%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     11.90 ±  8%      -4.0        7.95 ±  9%  perf-profile.calltrace.cycles-pp.up_read.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     15.06 ±  8%      -2.9       12.11 ±  9%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     11.63 ±  7%      -2.3        9.32 ±  9%  perf-profile.calltrace.cycles-pp.down_read_trylock.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      0.00            +0.6        0.59 ± 11%  perf-profile.calltrace.cycles-pp.llist_add_batch.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range.zap_pte_range
      0.00            +0.6        0.62 ± 10%  perf-profile.calltrace.cycles-pp.sysvec_call_function.asm_sysvec_call_function.testcase
      0.00            +0.6        0.62 ± 11%  perf-profile.calltrace.cycles-pp.page_remove_rmap.tlb_flush_rmaps.zap_pte_range.zap_pmd_range.unmap_page_range
      0.00            +0.7        0.66 ± 10%  perf-profile.calltrace.cycles-pp.tlb_flush_rmaps.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.00            +0.8        0.78 ±  9%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.testcase
      0.00            +0.8        0.85 ± 11%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.__handle_mm_fault
      0.00            +0.9        0.85 ± 11%  perf-profile.calltrace.cycles-pp.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.__handle_mm_fault.handle_mm_fault
      0.00            +0.9        0.89 ±  9%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.down_read_trylock
      0.00            +0.9        0.90 ±  9%  perf-profile.calltrace.cycles-pp.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.down_read_trylock.do_user_addr_fault
      0.00            +0.9        0.90 ± 11%  perf-profile.calltrace.cycles-pp.sysvec_call_function.asm_sysvec_call_function.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.00            +0.9        0.93 ±  7%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.up_read
      0.00            +0.9        0.94 ±  6%  perf-profile.calltrace.cycles-pp.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.up_read.do_user_addr_fault
      0.00            +0.9        0.95 ±  9%  perf-profile.calltrace.cycles-pp.sysvec_call_function.asm_sysvec_call_function.down_read_trylock.do_user_addr_fault.exc_page_fault
      0.00            +1.0        1.00 ±  6%  perf-profile.calltrace.cycles-pp.sysvec_call_function.asm_sysvec_call_function.up_read.do_user_addr_fault.exc_page_fault
      0.00            +1.0        1.00 ± 36%  perf-profile.calltrace.cycles-pp.native_flush_tlb_one_user.flush_tlb_func.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range
      0.00            +1.1        1.05 ± 36%  perf-profile.calltrace.cycles-pp.flush_tlb_func.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range.zap_pte_range
      0.00            +1.1        1.10 ± 11%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.00            +1.1        1.15 ±  8%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.down_read_trylock.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +1.2        1.20 ±  7%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.up_read.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +1.5        1.48 ±  7%  perf-profile.calltrace.cycles-pp.__default_send_IPI_dest_field.default_send_IPI_mask_sequence_phys.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range
      0.00            +1.5        1.52 ±  7%  perf-profile.calltrace.cycles-pp.default_send_IPI_mask_sequence_phys.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range.zap_pte_range
      0.00            +1.7        1.71 ± 10%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.do_user_addr_fault
      0.00            +1.7        1.72 ± 10%  perf-profile.calltrace.cycles-pp.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.do_user_addr_fault.exc_page_fault
      0.00            +1.8        1.82 ± 10%  perf-profile.calltrace.cycles-pp.sysvec_call_function.asm_sysvec_call_function.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +3.1        3.14 ± 10%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      0.00            +3.6        3.61 ± 15%  perf-profile.calltrace.cycles-pp.native_flush_tlb_one_user.flush_tlb_func.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function
      0.00            +3.8        3.85 ±  7%  perf-profile.calltrace.cycles-pp.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range.zap_pte_range.zap_pmd_range
      0.00            +3.9        3.87 ±  7%  perf-profile.calltrace.cycles-pp.on_each_cpu_cond_mask.flush_tlb_mm_range.zap_pte_range.zap_pmd_range.unmap_page_range
      0.00            +4.2        4.22 ± 20%  perf-profile.calltrace.cycles-pp.flush_tlb_func.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function
      1.96 ±  7%      +4.3        6.27 ±  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
      1.96 ±  7%      +4.3        6.27 ±  7%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      1.96 ±  7%      +4.3        6.27 ±  7%  perf-profile.calltrace.cycles-pp.__munmap
      1.96 ±  7%      +4.3        6.27 ±  7%  perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      1.96 ±  7%      +4.3        6.27 ±  7%  perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      1.94 ±  7%      +4.3        6.25 ±  7%  perf-profile.calltrace.cycles-pp.do_mas_align_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.91 ±  7%      +4.3        6.23 ±  7%  perf-profile.calltrace.cycles-pp.unmap_region.do_mas_align_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      1.89 ±  7%      +4.3        6.22 ±  7%  perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_mas_align_munmap.__vm_munmap.__x64_sys_munmap
      1.89 ±  7%      +4.3        6.22 ±  7%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_mas_align_munmap.__vm_munmap
      1.89 ±  7%      +4.3        6.22 ±  7%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_mas_align_munmap
      1.86 ±  7%      +4.3        6.21 ±  7%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
      0.00            +4.6        4.56 ±  7%  perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
     30.20 ± 17%      +6.8       37.04 ± 15%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     30.64 ± 16%      +7.0       37.60 ± 14%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     30.73 ± 16%      +7.0       37.70 ± 14%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     30.73 ± 16%      +7.0       37.71 ± 14%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     30.73 ± 16%      +7.0       37.71 ± 14%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     22.10 ±  8%      -4.6       17.48 ± 11%  perf-profile.children.cycles-pp.handle_mm_fault
     11.92 ±  8%      -3.8        8.15 ±  8%  perf-profile.children.cycles-pp.up_read
     11.65 ±  7%      -2.1        9.51 ±  9%  perf-profile.children.cycles-pp.down_read_trylock
      0.16 ± 21%      -0.1        0.09 ± 26%  perf-profile.children.cycles-pp.process_simple
      0.13 ± 14%      -0.1        0.07 ± 10%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      0.14 ± 21%      -0.1        0.08 ± 22%  perf-profile.children.cycles-pp.queue_event
      0.14 ± 21%      -0.1        0.08 ± 26%  perf-profile.children.cycles-pp.ordered_events__queue
      0.14 ± 14%      -0.0        0.10 ± 10%  perf-profile.children.cycles-pp.__schedule
      0.10 ± 10%      -0.0        0.06 ± 19%  perf-profile.children.cycles-pp.schedule
      0.02 ±141%      +0.0        0.06 ± 13%  perf-profile.children.cycles-pp.ret_from_fork
      0.02 ±141%      +0.0        0.06 ± 13%  perf-profile.children.cycles-pp.kthread
      0.16 ± 21%      +0.1        0.22 ± 10%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.00            +0.1        0.09 ±  7%  perf-profile.children.cycles-pp._find_next_bit
      0.08 ± 10%      +0.2        0.25 ± 15%  perf-profile.children.cycles-pp.native_sched_clock
      0.08 ±  8%      +0.2        0.29 ± 14%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.20 ± 12%      +0.2        0.43 ± 13%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.07 ± 11%      +0.2        0.31 ± 10%  perf-profile.children.cycles-pp.irqtime_account_irq
      1.46 ±  8%      +0.3        1.77 ± 10%  perf-profile.children.cycles-pp.__filemap_get_folio
      1.71 ±  8%      +0.3        2.02 ± 10%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.00            +0.4        0.43 ± 10%  perf-profile.children.cycles-pp.llist_reverse_order
      0.00            +0.6        0.59 ± 11%  perf-profile.children.cycles-pp.llist_add_batch
      0.00            +0.7        0.67 ± 10%  perf-profile.children.cycles-pp.tlb_flush_rmaps
      0.09 ± 15%      +1.4        1.48 ±  7%  perf-profile.children.cycles-pp.__default_send_IPI_dest_field
      0.09 ± 14%      +1.4        1.53 ±  7%  perf-profile.children.cycles-pp.default_send_IPI_mask_sequence_phys
      0.19 ±  8%      +3.7        3.87 ±  7%  perf-profile.children.cycles-pp.smp_call_function_many_cond
      0.19 ±  8%      +3.7        3.87 ±  7%  perf-profile.children.cycles-pp.on_each_cpu_cond_mask
      2.19 ±  7%      +4.3        6.49 ±  7%  perf-profile.children.cycles-pp.do_syscall_64
      2.19 ±  7%      +4.3        6.49 ±  7%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.97 ±  7%      +4.3        6.27 ±  7%  perf-profile.children.cycles-pp.__vm_munmap
      1.96 ±  7%      +4.3        6.27 ±  7%  perf-profile.children.cycles-pp.__x64_sys_munmap
      1.96 ±  7%      +4.3        6.27 ±  7%  perf-profile.children.cycles-pp.__munmap
      1.94 ±  7%      +4.3        6.25 ±  7%  perf-profile.children.cycles-pp.do_mas_align_munmap
      1.92 ±  7%      +4.3        6.24 ±  7%  perf-profile.children.cycles-pp.unmap_region
      1.90 ±  7%      +4.3        6.23 ±  7%  perf-profile.children.cycles-pp.unmap_vmas
      1.90 ±  7%      +4.3        6.23 ±  7%  perf-profile.children.cycles-pp.unmap_page_range
      1.90 ±  7%      +4.3        6.23 ±  7%  perf-profile.children.cycles-pp.zap_pmd_range
      1.90 ±  7%      +4.3        6.23 ±  7%  perf-profile.children.cycles-pp.zap_pte_range
      0.19 ±  8%      +4.4        4.56 ±  7%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.14 ± 11%      +6.5        6.64 ±  9%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.14 ± 11%      +6.5        6.69 ±  9%  perf-profile.children.cycles-pp.__sysvec_call_function
      0.00            +6.8        6.84 ±  9%  perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.17 ± 11%      +6.9        7.09 ±  9%  perf-profile.children.cycles-pp.sysvec_call_function
     30.73 ± 16%      +7.0       37.71 ± 14%  perf-profile.children.cycles-pp.start_secondary
      0.08 ± 13%      +7.3        7.39 ±  9%  perf-profile.children.cycles-pp.flush_tlb_func
      0.30 ± 12%      +8.7        8.96 ±  8%  perf-profile.children.cycles-pp.asm_sysvec_call_function
     11.80 ±  8%      -4.8        6.96 ±  9%  perf-profile.self.cycles-pp.up_read
     10.49 ±  7%      -4.1        6.38 ±  9%  perf-profile.self.cycles-pp.__handle_mm_fault
     11.55 ±  7%      -3.2        8.38 ±  9%  perf-profile.self.cycles-pp.down_read_trylock
      6.15 ± 11%      -2.4        3.74 ± 23%  perf-profile.self.cycles-pp.handle_mm_fault
      9.08 ±  7%      -1.8        7.24 ±  9%  perf-profile.self.cycles-pp.testcase
      0.32 ±  8%      -0.1        0.23 ± 10%  perf-profile.self.cycles-pp.page_remove_rmap
      0.14 ± 21%      -0.1        0.08 ± 22%  perf-profile.self.cycles-pp.queue_event
      0.26 ±  9%      -0.0        0.21 ±  8%  perf-profile.self.cycles-pp.page_add_file_rmap
      0.15 ±  7%      -0.0        0.12 ± 10%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.12 ±  9%      -0.0        0.09 ± 11%  perf-profile.self.cycles-pp.do_fault
      0.10 ±  9%      -0.0        0.07 ± 17%  perf-profile.self.cycles-pp.__count_memcg_events
      0.00            +0.1        0.06 ± 15%  perf-profile.self.cycles-pp.flush_tlb_mm_range
      0.00            +0.1        0.07 ± 10%  perf-profile.self.cycles-pp.sysvec_call_function
      0.00            +0.1        0.08 ± 12%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.00            +0.1        0.08 ± 10%  perf-profile.self.cycles-pp._find_next_bit
      0.00            +0.1        0.10 ±  9%  perf-profile.self.cycles-pp.asm_sysvec_call_function
      0.64 ±  8%      +0.1        0.77 ±  8%  perf-profile.self.cycles-pp.__filemap_get_folio
      0.07 ± 12%      +0.2        0.24 ± 16%  perf-profile.self.cycles-pp.native_sched_clock
      0.00            +0.4        0.42 ± 10%  perf-profile.self.cycles-pp.llist_reverse_order
      0.00            +0.5        0.51 ±  6%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.42 ±  7%      +0.6        0.97 ± 10%  perf-profile.self.cycles-pp.do_user_addr_fault
      0.03 ±100%      +0.6        0.58 ±  4%  perf-profile.self.cycles-pp.smp_call_function_many_cond
      0.00            +0.6        0.57 ±  9%  perf-profile.self.cycles-pp.flush_tlb_func
      0.00            +0.6        0.59 ± 10%  perf-profile.self.cycles-pp.llist_add_batch
      0.09 ± 15%      +1.4        1.48 ±  7%  perf-profile.self.cycles-pp.__default_send_IPI_dest_field
      0.00            +6.8        6.82 ±  9%  perf-profile.self.cycles-pp.native_flush_tlb_one_user


128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake)
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-11/performance/x86_64-rhel-8.3/thread/16/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp5/page_fault3/will-it-scale

commit:
  7cc8f9c7146a5 ("mm: mmu_gather: prepare to gather encoded page pointers with flags")
  5df397dec7c4c ("mm: delay page_remove_rmap() until after the TLB has been flushed")

7cc8f9c7146a5                  5df397dec7c4c
---------------- ------------ --------------
         %stddev     %change         %stddev
             \          |                \
   6221506 ±  5%     -44.7%    3439127 ±  2%  will-it-scale.16.threads
     87.20            +4.3%      90.98        will-it-scale.16.threads_idle
    388843 ±  5%     -44.7%     214944 ±  2%  will-it-scale.per_thread_ops
   6221506 ±  5%     -44.7%    3439127 ±  2%  will-it-scale.workload
      1.23 ±  8%      +1.3        2.54 ± 19%  mpstat.cpu.all.irq%
     10.86            -4.9        5.96 ±  2%  mpstat.cpu.all.sys%
      0.61 ±  6%      -0.2        0.40 ±  3%  mpstat.cpu.all.usr%
   4388857 ±  5%     -36.6%    2782588 ±  2%  numa-numastat.node0.local_node
   4446685 ±  4%     -36.3%    2833518 ±  2%  numa-numastat.node0.numa_hit
    618831 ±  3%     -10.3%     554830 ±  4%  numa-numastat.node1.local_node
     14.50 ±  3%     -39.1%       8.83 ±  7%  vmstat.procs.r
     10336 ±  8%     -45.7%       5616        vmstat.system.cs
    390901 ±  3%    +350.1%    1759451 ±  2%  vmstat.system.in
    410.83           -31.2%     282.50 ±  4%  turbostat.Avg_MHz
     13.65            -3.6       10.06 ±  8%  turbostat.Busy%
 1.603e+08 ±  5%    +524.0%      1e+09 ±  2%  turbostat.IRQ
     60.67            -7.1%      56.33 ±  5%  turbostat.PkgTmp
    274.70            -8.6%     251.09 ±  6%  turbostat.PkgWatt
    126930 ± 15%     -35.2%      82187 ± 25%  numa-meminfo.node0.AnonHugePages
    248450 ±  9%     -19.6%     199671 ± 25%  numa-meminfo.node0.AnonPages
    255089 ±  9%     -19.6%     205148 ± 24%  numa-meminfo.node0.Inactive
    254353 ±  9%     -19.4%     204910 ± 24%  numa-meminfo.node0.Inactive(anon)
     22546 ± 12%     -24.4%      17051 ±  9%  numa-meminfo.node1.Active
     22116 ± 11%     -25.2%      16539 ± 10%  numa-meminfo.node1.Active(anon)
     24956 ± 10%     -24.9%      18736 ±  9%  numa-meminfo.node1.Shmem
    264468            +3.9%     274871        proc-vmstat.nr_mapped
   5125804 ±  4%     -32.6%    3455449        proc-vmstat.numa_hit
   5010073 ±  4%     -33.3%    3339738        proc-vmstat.numa_local
    551502            -1.7%     542068        proc-vmstat.pgactivate
   5213112 ±  4%     -32.1%    3539426        proc-vmstat.pgalloc_normal
 1.874e+09 ±  5%     -44.7%  1.036e+09 ±  2%  proc-vmstat.pgfault
   5251524 ±  4%     -31.8%    3580764        proc-vmstat.pgfree
     62112 ±  9%     -19.6%      49917 ± 25%  numa-vmstat.node0.nr_anon_pages
     63588 ±  9%     -19.4%      51227 ± 24%  numa-vmstat.node0.nr_inactive_anon
     63588 ±  9%     -19.4%      51227 ± 24%  numa-vmstat.node0.nr_zone_inactive_anon
   4446807 ±  4%     -36.3%    2833561 ±  2%  numa-vmstat.node0.numa_hit
   4388978 ±  5%     -36.6%    2782630 ±  2%  numa-vmstat.node0.numa_local
      5529 ± 11%     -25.2%       4134 ± 10%  numa-vmstat.node1.nr_active_anon
      6238 ± 10%     -24.9%       4684 ±  9%  numa-vmstat.node1.nr_shmem
      5529 ± 11%     -25.2%       4134 ± 10%  numa-vmstat.node1.nr_zone_active_anon
    618919 ±  3%     -10.4%     554861 ±  4%  numa-vmstat.node1.numa_local
      0.30 ± 12%     -57.3%       0.13 ± 16%  sched_debug.cfs_rq:/.h_nr_running.avg
      0.42 ±  3%     -24.8%       0.32 ±  7%  sched_debug.cfs_rq:/.h_nr_running.stddev
     17954 ± 13%     -38.2%      11093 ± 20%  sched_debug.cfs_rq:/.load.avg
     59044 ±  2%     +55.1%      91605 ±  3%  sched_debug.cfs_rq:/.load.max
     35.12 ± 14%     -38.9%      21.45 ± 12%  sched_debug.cfs_rq:/.load_avg.avg
    425478 ±  9%     -58.9%     175030 ± 14%  sched_debug.cfs_rq:/.min_vruntime.avg
   1451058 ± 13%     -68.9%     451040 ±  3%  sched_debug.cfs_rq:/.min_vruntime.max
    511538 ± 10%     -66.3%     172194 ±  7%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.30 ± 12%     -57.3%       0.13 ± 16%  sched_debug.cfs_rq:/.nr_running.avg
      0.42 ±  3%     -25.0%       0.32 ±  7%  sched_debug.cfs_rq:/.nr_running.stddev
    316.29 ± 10%     -51.8%     152.57 ± 11%  sched_debug.cfs_rq:/.runnable_avg.avg
      1011 ±  2%     -26.9%     739.47 ±  4%  sched_debug.cfs_rq:/.runnable_avg.max
    396.72 ±  2%     -38.9%     242.26 ±  4%  sched_debug.cfs_rq:/.runnable_avg.stddev
   -550745           -65.2%    -191612        sched_debug.cfs_rq:/.spread0.avg
    474857 ± 58%     -82.2%      84412 ± 28%  sched_debug.cfs_rq:/.spread0.max
   -956414           -63.9%    -345608        sched_debug.cfs_rq:/.spread0.min
    511547 ± 10%     -66.3%     172197 ±  7%  sched_debug.cfs_rq:/.spread0.stddev
    316.22 ± 10%     -51.8%     152.49 ± 11%  sched_debug.cfs_rq:/.util_avg.avg
      1010 ±  2%     -26.9%     739.42 ±  4%  sched_debug.cfs_rq:/.util_avg.max
    396.65 ±  2%     -38.9%     242.22 ±  4%  sched_debug.cfs_rq:/.util_avg.stddev
    237.99 ± 14%     -75.7%      57.81 ± 16%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    962.81 ±  2%     -27.2%     701.03 ±  2%  sched_debug.cfs_rq:/.util_est_enqueued.max
    359.62 ±  5%     -54.3%     164.36 ±  7%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    242264 ±  6%     -51.7%     116978 ±  7%  sched_debug.cpu.avg_idle.stddev
      1801 ±  6%     +58.5%       2855 ±  3%  sched_debug.cpu.clock_task.stddev
    711.81 ±  4%     -35.4%     459.59 ±  7%  sched_debug.cpu.curr->pid.avg
      1909           -16.7%       1589 ±  4%  sched_debug.cpu.curr->pid.stddev
      0.13 ±  4%     -35.4%       0.08 ±  6%  sched_debug.cpu.nr_running.avg
      0.33 ±  2%     -20.1%       0.26 ±  3%  sched_debug.cpu.nr_running.stddev
     13910 ±  6%     -36.7%       8800        sched_debug.cpu.nr_switches.avg
     18507 ± 12%     -40.5%      11004 ± 14%  sched_debug.cpu.nr_switches.stddev
      4.30 ± 13%     +95.0%       8.38 ± 39%  perf-stat.i.MPKI
  3.88e+09 ±  5%     -32.4%  2.621e+09        perf-stat.i.branch-instructions
      0.07 ±  8%      +0.3        0.38 ± 81%  perf-stat.i.branch-miss-rate%
   2747085 ± 10%    +269.7%   10156358 ± 79%  perf-stat.i.branch-misses
      8.60 ± 12%      -3.3        5.34 ± 20%  perf-stat.i.cache-miss-rate%
   6857924 ±  5%     -23.2%    5265295 ± 16%  perf-stat.i.cache-misses
     10324 ±  8%     -46.2%       5552        perf-stat.i.context-switches
 5.216e+10           -32.0%  3.545e+10 ±  4%  perf-stat.i.cpu-cycles
    139.62           +48.4%     207.16 ±  4%  perf-stat.i.cpu-migrations
 5.128e+09 ±  5%     -31.6%  3.508e+09        perf-stat.i.dTLB-loads
      7.55            -1.3        6.25        perf-stat.i.dTLB-store-miss-rate%
 2.287e+08 ±  5%     -44.8%  1.262e+08 ±  2%  perf-stat.i.dTLB-store-misses
 2.798e+09 ±  5%     -32.4%  1.893e+09        perf-stat.i.dTLB-stores
 1.876e+10 ±  5%     -32.4%  1.269e+10        perf-stat.i.instructions
      0.41           -32.0%       0.28 ±  4%  perf-stat.i.metric.GHz
     94.02 ±  5%     -32.5%      63.48 ±  2%  perf-stat.i.metric.M/sec
   6207930 ±  5%     -44.7%    3430475 ±  2%  perf-stat.i.minor-faults
     55974 ±  8%     +39.7%      78180 ±  8%  perf-stat.i.node-load-misses
   6339958 ±  5%     -42.7%    3633731 ±  3%  perf-stat.i.node-stores
   6207930 ±  5%     -44.7%    3430475 ±  2%  perf-stat.i.page-faults
      4.30 ± 13%     +94.4%       8.35 ± 38%  perf-stat.overall.MPKI
      0.07 ±  7%      +0.3        0.39 ± 79%  perf-stat.overall.branch-miss-rate%
      8.65 ± 12%      -3.3        5.39 ± 20%  perf-stat.overall.cache-miss-rate%
      7.55            -1.3        6.25        perf-stat.overall.dTLB-store-miss-rate%
      0.27 ± 37%      +0.4        0.66 ± 31%  perf-stat.overall.node-store-miss-rate%
    910167           +22.4%    1114007        perf-stat.overall.path-length
 3.867e+09 ±  5%     -32.5%  2.612e+09        perf-stat.ps.branch-instructions
   2739799 ±  9%    +269.3%   10116762 ± 80%  perf-stat.ps.branch-misses
   6834912 ±  5%     -23.2%    5246515 ± 16%  perf-stat.ps.cache-misses
     10291 ±  8%     -46.2%       5533        perf-stat.ps.context-switches
 5.198e+10           -32.0%  3.534e+10 ±  4%  perf-stat.ps.cpu-cycles
    139.18           +48.4%     206.52 ±  4%  perf-stat.ps.cpu-migrations
 5.111e+09 ±  5%     -31.6%  3.496e+09        perf-stat.ps.dTLB-loads
 2.279e+08 ±  5%     -44.8%  1.258e+08 ±  2%  perf-stat.ps.dTLB-store-misses
 2.789e+09 ±  5%     -32.4%  1.887e+09        perf-stat.ps.dTLB-stores
  1.87e+10 ±  5%     -32.4%  1.264e+10        perf-stat.ps.instructions
   6187409 ±  5%     -44.7%    3418985 ±  2%  perf-stat.ps.minor-faults
     55825 ±  8%     +39.6%      77936 ±  8%  perf-stat.ps.node-load-misses
   6318444 ±  5%     -42.7%    3620465 ±  3%  perf-stat.ps.node-stores
   6187409 ±  5%     -44.7%    3418985 ±  2%  perf-stat.ps.page-faults
 5.662e+12 ±  5%     -32.4%   3.83e+12        perf-stat.total.instructions
     92.72           -14.8       77.93 ±  3%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.testcase
     69.44 ±  2%     -11.5       57.91 ±  4%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     82.34           -11.4       70.95 ±  3%  perf-profile.calltrace.cycles-pp.testcase
     69.74 ±  2%     -10.5       59.24 ±  4%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.testcase
     26.90            -6.0       20.87 ±  5%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     20.44 ±  4%      -5.8       14.62 ±  5%  perf-profile.calltrace.cycles-pp.up_read.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     18.29 ±  3%      -5.0       13.33 ±  4%  perf-profile.calltrace.cycles-pp.down_read_trylock.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     27.60 ±  2%      -4.9       22.73 ±  3%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      4.19 ±  5%      -0.7        3.50 ±  5%  perf-profile.calltrace.cycles-pp.error_entry.testcase
      3.93 ±  5%      -0.6        3.28 ±  5%  perf-profile.calltrace.cycles-pp.sync_regs.error_entry.testcase
      1.15 ±  8%      +0.3        1.42 ±  5%  perf-profile.calltrace.cycles-pp.do_set_pte.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault
      1.68 ±  7%      +0.3        1.96 ±  5%  perf-profile.calltrace.cycles-pp.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      4.58 ±  5%      +0.5        5.05 ±  4%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.00            +0.5        0.54 ±  4%  perf-profile.calltrace.cycles-pp.__perf_sw_event.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.09 ±223%      +0.6        0.65 ±  4%  perf-profile.calltrace.cycles-pp.__perf_sw_event.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      0.20 ±141%      +0.7        0.88 ± 40%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.00            +0.7        0.72 ±  7%  perf-profile.calltrace.cycles-pp.page_remove_rmap.tlb_flush_rmaps.zap_pte_range.zap_pmd_range.unmap_page_range
      0.00            +0.8        0.79 ±  6%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.testcase
      0.00            +0.8        0.79 ±  5%  perf-profile.calltrace.cycles-pp.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.testcase
      0.00            +0.8        0.80 ±  6%  perf-profile.calltrace.cycles-pp.tlb_flush_rmaps.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.00            +0.8        0.82 ±  6%  perf-profile.calltrace.cycles-pp.sysvec_call_function.asm_sysvec_call_function.testcase
      0.81 ± 20%      +0.9        1.70 ± 43%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.82 ± 20%      +0.9        1.74 ± 44%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.10 ±223%      +1.0        1.13 ± 60%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +1.0        1.04 ±  5%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.testcase
      1.28 ± 20%      +1.4        2.68 ± 41%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      1.55 ± 19%      +1.6        3.14 ± 37%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00            +1.6        1.63 ±  7%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.down_read_trylock
      0.00            +1.6        1.64 ±  7%  perf-profile.calltrace.cycles-pp.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.down_read_trylock.do_user_addr_fault
      0.00            +1.7        1.72 ±  7%  perf-profile.calltrace.cycles-pp.sysvec_call_function.asm_sysvec_call_function.down_read_trylock.do_user_addr_fault.exc_page_fault
      0.00            +1.8        1.76 ± 44%  perf-profile.calltrace.cycles-pp.native_flush_tlb_one_user.flush_tlb_func.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range
      0.00            +1.9        1.85 ± 43%  perf-profile.calltrace.cycles-pp.flush_tlb_func.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range.zap_pte_range
      0.00            +2.1        2.08 ±  7%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.down_read_trylock.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +2.1        2.09 ±  8%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.up_read
      0.00            +2.1        2.09 ±  8%  perf-profile.calltrace.cycles-pp.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.up_read.do_user_addr_fault
      0.00            +2.1        2.15 ±  6%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.__handle_mm_fault
      0.00            +2.2        2.16 ±  6%  perf-profile.calltrace.cycles-pp.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.__handle_mm_fault.handle_mm_fault
      0.00            +2.2        2.19 ±  8%  perf-profile.calltrace.cycles-pp.sysvec_call_function.asm_sysvec_call_function.up_read.do_user_addr_fault.exc_page_fault
      0.00            +2.3        2.25 ±  6%  perf-profile.calltrace.cycles-pp.sysvec_call_function.asm_sysvec_call_function.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.00            +2.5        2.53 ±  4%  perf-profile.calltrace.cycles-pp.__default_send_IPI_dest_field.default_send_IPI_mask_sequence_phys.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range
      0.00            +2.6        2.59 ±  4%  perf-profile.calltrace.cycles-pp.default_send_IPI_mask_sequence_phys.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range.zap_pte_range
      0.00            +2.6        2.63 ±  8%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.up_read.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +2.7        2.70 ±  4%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.do_user_addr_fault
      0.00            +2.7        2.71 ±  4%  perf-profile.calltrace.cycles-pp.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.do_user_addr_fault.exc_page_fault
      0.00            +2.7        2.72 ±  6%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.00            +2.8        2.84 ±  4%  perf-profile.calltrace.cycles-pp.sysvec_call_function.asm_sysvec_call_function.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      4.34 ± 11%      +3.0        7.38 ± 16%  perf-profile.calltrace.cycles-pp.mwait_idle_with_hints.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      4.36 ± 11%      +3.1        7.42 ± 16%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      6.20 ± 12%      +4.9       11.08 ± 22%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      6.43 ± 12%      +5.0       11.48 ± 21%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.00            +5.2        5.18 ±  3%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      6.94 ± 13%      +5.6       12.54 ± 23%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      7.04 ± 13%      +5.7       12.75 ± 23%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      7.05 ± 13%      +5.7       12.77 ± 23%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      7.05 ± 13%      +5.7       12.77 ± 23%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      0.00            +5.8        5.77 ± 17%  perf-profile.calltrace.cycles-pp.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range.zap_pte_range.zap_pmd_range
      7.10 ± 13%      +5.8       12.88 ± 23%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      0.00            +5.8        5.81 ± 17%  perf-profile.calltrace.cycles-pp.on_each_cpu_cond_mask.flush_tlb_mm_range.zap_pte_range.zap_pmd_range.unmap_page_range
      0.00            +6.8        6.82 ±  4%  perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      2.05 ±  5%      +7.1        9.11 ±  3%  perf-profile.calltrace.cycles-pp.__munmap
      2.04 ±  5%      +7.1        9.11 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
      2.04 ±  5%      +7.1        9.11 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      2.04 ±  5%      +7.1        9.11 ±  3%  perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      2.04 ±  5%      +7.1        9.11 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      2.01 ±  5%      +7.1        9.08 ±  3%  perf-profile.calltrace.cycles-pp.do_mas_align_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.99 ±  5%      +7.1        9.06 ±  3%  perf-profile.calltrace.cycles-pp.unmap_region.do_mas_align_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      1.96 ±  5%      +7.1        9.04 ±  3%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_mas_align_munmap
      1.96 ±  5%      +7.1        9.04 ±  3%  perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_mas_align_munmap.__vm_munmap.__x64_sys_munmap
      1.96 ±  5%      +7.1        9.04 ±  3%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_mas_align_munmap.__vm_munmap
      1.89 ±  5%      +7.1        8.99 ±  3%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
      0.00            +7.3        7.30 ±  4%  perf-profile.calltrace.cycles-pp.native_flush_tlb_one_user.flush_tlb_func.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function
      0.00            +7.9        7.92 ±  4%  perf-profile.calltrace.cycles-pp.flush_tlb_func.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function
     90.30           -12.9       77.37 ±  3%  perf-profile.children.cycles-pp.testcase
     81.56           -12.7       68.87 ±  3%  perf-profile.children.cycles-pp.asm_exc_page_fault
     69.82 ±  2%     -10.5       59.30 ±  4%  perf-profile.children.cycles-pp.exc_page_fault
     69.67 ±  2%     -10.5       59.18 ±  4%  perf-profile.children.cycles-pp.do_user_addr_fault
     26.76            -5.6       21.20 ±  4%  perf-profile.children.cycles-pp.__handle_mm_fault
     20.49 ±  4%      -5.5       15.03 ±  5%  perf-profile.children.cycles-pp.up_read
     28.06            -4.7       23.34 ±  4%  perf-profile.children.cycles-pp.handle_mm_fault
     18.33 ±  3%      -4.7       13.66 ±  4%  perf-profile.children.cycles-pp.down_read_trylock
      3.94 ±  5%      -0.6        3.30 ±  5%  perf-profile.children.cycles-pp.sync_regs
      4.36 ±  5%      -0.6        3.77 ±  5%  perf-profile.children.cycles-pp.error_entry
      0.14 ± 12%      -0.0        0.10 ± 16%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      0.14 ±  7%      -0.0        0.11 ±  9%  perf-profile.children.cycles-pp.folio_memcg_lock
      0.07 ±  8%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.__tlb_remove_page_size
      0.17 ±  6%      -0.0        0.14 ±  9%  perf-profile.children.cycles-pp.__irqentry_text_end
      0.07 ±  6%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.noop_dirty_folio
      0.08 ±  6%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.perf_callchain_user
      0.05 ±  7%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.07 ± 20%      +0.0        0.12 ± 22%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.21 ±  5%      +0.0        0.26 ±  7%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.10 ± 14%      +0.1        0.16 ± 17%  perf-profile.children.cycles-pp.read_tsc
      0.04 ± 45%      +0.1        0.10 ± 52%  perf-profile.children.cycles-pp.update_rq_clock
      0.05 ± 46%      +0.1        0.11 ± 18%  perf-profile.children.cycles-pp.start_kernel
      0.05 ± 46%      +0.1        0.11 ± 18%  perf-profile.children.cycles-pp.arch_call_rest_init
      0.05 ± 46%      +0.1        0.11 ± 18%  perf-profile.children.cycles-pp.rest_init
      0.12 ± 11%      +0.1        0.18 ± 11%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.00            +0.1        0.06 ± 17%  perf-profile.children.cycles-pp.restore_regs_and_return_to_kernel
      0.06 ± 11%      +0.1        0.12 ± 22%  perf-profile.children.cycles-pp.find_busiest_group
      0.04 ± 47%      +0.1        0.11 ± 32%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.05 ± 45%      +0.1        0.11 ± 26%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.04 ± 44%      +0.1        0.11 ± 29%  perf-profile.children.cycles-pp.irqentry_enter
      0.02 ±141%      +0.1        0.08 ± 42%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.46 ±  5%      +0.1        0.52 ±  4%  perf-profile.children.cycles-pp.__might_resched
      0.01 ±223%      +0.1        0.08 ± 23%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.00            +0.1        0.07 ± 12%  perf-profile.children.cycles-pp.idle_cpu
      0.20 ±  4%      +0.1        0.27 ±  6%  perf-profile.children.cycles-pp.__cond_resched
      0.12 ±  9%      +0.1        0.20 ±  6%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.02 ± 99%      +0.1        0.11 ± 19%  perf-profile.children.cycles-pp.ret_from_fork
      0.02 ± 99%      +0.1        0.11 ± 19%  perf-profile.children.cycles-pp.kthread
      0.08 ± 11%      +0.1        0.17 ± 28%  perf-profile.children.cycles-pp.load_balance
      0.35 ±  7%      +0.1        0.44 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock
      0.00            +0.1        0.10 ± 35%  perf-profile.children.cycles-pp.update_blocked_averages
      0.12 ± 15%      +0.1        0.22 ± 25%  perf-profile.children.cycles-pp.rebalance_domains
      0.00            +0.1        0.10 ± 39%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.21 ±  5%      +0.1        0.31 ±  6%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.12 ± 10%      +0.1        0.22 ± 30%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.69 ±  5%      +0.1        0.79 ±  6%  perf-profile.children.cycles-pp.page_remove_rmap
      0.32 ±  6%      +0.1        0.44 ±  3%  perf-profile.children.cycles-pp.tlb_batch_pages_flush
      0.12 ± 60%      +0.1        0.25 ± 42%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.26 ± 32%      +0.1        0.40 ± 25%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.65 ±  6%      +0.2        0.82 ±  4%  perf-profile.children.cycles-pp.___perf_sw_event
      0.56 ±  4%      +0.2        0.73 ±  6%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.36 ±  5%      +0.2        0.54 ± 30%  perf-profile.children.cycles-pp.scheduler_tick
      0.00            +0.2        0.19 ± 28%  perf-profile.children.cycles-pp._find_next_bit
      0.00            +0.2        0.19 ±  6%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.20 ± 14%      +0.2        0.40 ± 29%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.00            +0.2        0.22 ±  5%  perf-profile.children.cycles-pp.error_return
      0.00            +0.2        0.24 ±  9%  perf-profile.children.cycles-pp.llist_add_batch
      0.22 ± 30%      +0.3        0.48 ±  9%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      1.19 ±  8%      +0.3        1.46 ±  5%  perf-profile.children.cycles-pp.do_set_pte
      0.12 ± 12%      +0.3        0.40 ± 12%  perf-profile.children.cycles-pp.native_sched_clock
      1.72 ±  7%      +0.3        2.01 ±  5%  perf-profile.children.cycles-pp.finish_fault
      0.14 ± 10%      +0.3        0.49 ± 10%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.44 ±  8%      +0.4        0.81 ± 46%  perf-profile.children.cycles-pp.update_process_times
      0.09 ± 10%      +0.4        0.47 ±  6%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.86 ±  6%      +0.4        1.26 ±  4%  perf-profile.children.cycles-pp.__perf_sw_event
      0.45 ±  8%      +0.4        0.87 ± 51%  perf-profile.children.cycles-pp.tick_sched_handle
      0.52 ± 13%      +0.5        0.97 ± 46%  perf-profile.children.cycles-pp.tick_sched_timer
      4.65 ±  5%      +0.5        5.11 ±  4%  perf-profile.children.cycles-pp.do_fault
      0.43 ± 29%      +0.5        0.90 ± 40%  perf-profile.children.cycles-pp.menu_select
      0.28 ± 11%      +0.5        0.80 ± 18%  perf-profile.children.cycles-pp.__irq_exit_rcu
      3.58 ±  6%      +0.6        4.22 ±  7%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.02 ± 99%      +0.7        0.72 ±  3%  perf-profile.children.cycles-pp.llist_reverse_order
      0.72 ± 11%      +0.7        1.43 ± 48%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.00            +0.8        0.82 ±  6%  perf-profile.children.cycles-pp.tlb_flush_rmaps
      1.18 ± 18%      +0.9        2.06 ± 35%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.18 ± 18%      +0.9        2.10 ± 36%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      1.70 ± 18%      +1.4        3.09 ± 36%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      2.05 ± 17%      +1.6        3.62 ± 31%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.16 ± 14%      +2.4        2.54 ±  4%  perf-profile.children.cycles-pp.__default_send_IPI_dest_field
      0.16 ± 14%      +2.4        2.60 ±  4%  perf-profile.children.cycles-pp.default_send_IPI_mask_sequence_phys
      4.42 ± 10%      +3.1        7.50 ± 15%  perf-profile.children.cycles-pp.mwait_idle_with_hints
      4.40 ± 10%      +3.1        7.50 ± 16%  perf-profile.children.cycles-pp.intel_idle
      6.47 ± 12%      +5.1       11.57 ± 21%  perf-profile.children.cycles-pp.cpuidle_enter_state
      6.48 ± 12%      +5.1       11.58 ± 21%  perf-profile.children.cycles-pp.cpuidle_enter
      0.26 ± 11%      +5.5        5.81 ± 17%  perf-profile.children.cycles-pp.smp_call_function_many_cond
      0.26 ± 11%      +5.6        5.82 ± 17%  perf-profile.children.cycles-pp.on_each_cpu_cond_mask
      6.99 ± 13%      +5.7       12.65 ± 23%  perf-profile.children.cycles-pp.cpuidle_idle_call
      7.05 ± 13%      +5.7       12.77 ± 23%  perf-profile.children.cycles-pp.start_secondary
      7.10 ± 13%      +5.8       12.88 ± 23%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      7.10 ± 13%      +5.8       12.88 ± 23%  perf-profile.children.cycles-pp.cpu_startup_entry
      7.10 ± 13%      +5.8       12.88 ± 23%  perf-profile.children.cycles-pp.do_idle
      0.27 ± 11%      +6.6        6.83 ±  4%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      2.05 ±  5%      +7.1        9.11 ±  3%  perf-profile.children.cycles-pp.__munmap
      2.05 ±  5%      +7.1        9.11 ±  3%  perf-profile.children.cycles-pp.__vm_munmap
      2.05 ±  5%      +7.1        9.11 ±  3%  perf-profile.children.cycles-pp.__x64_sys_munmap
      2.02 ±  5%      +7.1        9.08 ±  3%  perf-profile.children.cycles-pp.do_mas_align_munmap
      1.99 ±  5%      +7.1        9.06 ±  3%  perf-profile.children.cycles-pp.unmap_region
      1.97 ±  5%      +7.1        9.05 ±  3%  perf-profile.children.cycles-pp.unmap_vmas
      1.96 ±  5%      +7.1        9.05 ±  3%  perf-profile.children.cycles-pp.unmap_page_range
      1.96 ±  5%      +7.1        9.05 ±  3%  perf-profile.children.cycles-pp.zap_pmd_range
      1.96 ±  5%      +7.1        9.05 ±  3%  perf-profile.children.cycles-pp.zap_pte_range
      2.26 ±  5%      +7.1        9.37 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.26 ±  5%      +7.1        9.37 ±  3%  perf-profile.children.cycles-pp.do_syscall_64
      0.20 ± 11%     +10.6       10.77 ±  4%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.20 ± 11%     +10.6       10.79 ±  4%  perf-profile.children.cycles-pp.__sysvec_call_function
      0.00           +11.1       11.09 ±  3%  perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.23 ± 11%     +11.3       11.49 ±  4%  perf-profile.children.cycles-pp.sysvec_call_function
      0.10 ± 13%     +11.8       11.89 ±  3%  perf-profile.children.cycles-pp.flush_tlb_func
      0.43 ± 12%     +14.0       14.47 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_call_function
     21.36 ±  4%      -8.6       12.74 ±  5%  perf-profile.self.cycles-pp.__handle_mm_fault
     20.32 ±  4%      -7.9       12.42 ±  5%  perf-profile.self.cycles-pp.up_read
     18.17 ±  3%      -6.6       11.61 ±  4%  perf-profile.self.cycles-pp.down_read_trylock
     12.27 ±  4%      -2.1       10.17 ±  5%  perf-profile.self.cycles-pp.testcase
      3.88 ±  5%      -0.6        3.24 ±  5%  perf-profile.self.cycles-pp.sync_regs
      1.01 ± 11%      -0.2        0.80 ±  7%  perf-profile.self.cycles-pp.mt_find
      0.65 ±  4%      -0.1        0.56 ±  4%  perf-profile.self.cycles-pp.__filemap_get_folio
      0.30 ±  6%      -0.1        0.24 ±  4%  perf-profile.self.cycles-pp.page_add_file_rmap
      0.29 ±  3%      -0.0        0.24 ±  3%  perf-profile.self.cycles-pp.asm_exc_page_fault
      0.24 ±  5%      -0.0        0.20 ±  6%  perf-profile.self.cycles-pp.do_set_pte
      0.07 ±  5%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.lock_page_memcg
      0.27 ±  2%      -0.0        0.24 ±  5%  perf-profile.self.cycles-pp.xas_load
      0.15 ±  4%      -0.0        0.14 ±  6%  perf-profile.self.cycles-pp.handle_pte_fault
      0.04 ± 45%      +0.0        0.07 ± 11%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.06 ±  8%      +0.0        0.08 ±  8%  perf-profile.self.cycles-pp.find_vma
      0.13 ±  9%      +0.0        0.16 ±  6%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.13 ±  5%      +0.0        0.16 ±  9%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.09 ±  7%      +0.0        0.12 ± 11%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.12 ±  4%      +0.0        0.16 ±  5%  perf-profile.self.cycles-pp.__cond_resched
      0.07 ± 20%      +0.0        0.12 ± 22%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.06 ± 13%      +0.0        0.10 ± 28%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.10 ±  7%      +0.1        0.16 ±  6%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.10 ± 14%      +0.1        0.16 ± 17%  perf-profile.self.cycles-pp.read_tsc
      0.12 ± 11%      +0.1        0.18 ± 11%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.00            +0.1        0.06 ± 21%  perf-profile.self.cycles-pp.irqentry_enter
      0.00            +0.1        0.07 ± 10%  perf-profile.self.cycles-pp.idle_cpu
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.error_return
      0.00            +0.1        0.09 ±  7%  perf-profile.self.cycles-pp.flush_tlb_mm_range
      0.00            +0.1        0.13 ± 18%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.23 ±  6%      +0.1        0.38 ±  3%  perf-profile.self.cycles-pp.__perf_sw_event
      0.00            +0.2        0.16 ± 31%  perf-profile.self.cycles-pp._find_next_bit
      0.44 ±  4%      +0.2        0.61 ±  5%  perf-profile.self.cycles-pp.zap_pte_range
      0.19 ± 33%      +0.2        0.39 ±  8%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.00            +0.2        0.21 ±  6%  perf-profile.self.cycles-pp.asm_sysvec_call_function
      0.00            +0.2        0.24 ±  8%  perf-profile.self.cycles-pp.llist_add_batch
      0.00            +0.2        0.24 ±  7%  perf-profile.self.cycles-pp.sysvec_call_function
      0.15 ± 35%      +0.3        0.41 ± 48%  perf-profile.self.cycles-pp.menu_select
      0.37 ± 14%      +0.3        0.64 ± 20%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.11 ± 12%      +0.3        0.38 ± 10%  perf-profile.self.cycles-pp.native_sched_clock
      3.58 ±  6%      +0.6        4.21 ±  7%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.02 ± 99%      +0.7        0.72 ±  3%  perf-profile.self.cycles-pp.llist_reverse_order
      0.00            +0.8        0.84 ±  3%  perf-profile.self.cycles-pp.flush_tlb_func
      0.07 ± 12%      +0.8        0.92 ±  6%  perf-profile.self.cycles-pp.smp_call_function_many_cond
      0.06 ± 13%      +0.9        0.93 ±  4%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.61 ±  6%      +1.0        1.60 ±  3%  perf-profile.self.cycles-pp.do_user_addr_fault
      0.16 ± 14%      +2.4        2.54 ±  4%  perf-profile.self.cycles-pp.__default_send_IPI_dest_field
      4.40 ± 10%      +3.1        7.48 ± 15%  perf-profile.self.cycles-pp.mwait_idle_with_hints
      0.00           +11.0       11.04 ±  3%  perf-profile.self.cycles-pp.native_flush_tlb_one_user


The fix patch is under testing. We will send the result once the test is
done.

Best Regards,
Yujie

> Because if it's a one-off, it's probably best ignored. If it shows up
> elsewhere, I think that batching logic might need looking at.
> 
>                Linus
