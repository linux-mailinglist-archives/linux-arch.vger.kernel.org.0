Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B1C6633AC
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jan 2023 23:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbjAIWHF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Jan 2023 17:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237669AbjAIWG6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jan 2023 17:06:58 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11795395DD;
        Mon,  9 Jan 2023 14:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673302017; x=1704838017;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=o7ks9SzE1MgI3tFUlpmKbvyK8NXAx0DHQt6tYOQ+omM=;
  b=k4hsSerZnwe/nPJrRXtYtXi9jUWMrAv2phF60F4GEQysqPcVDg7pibGV
   4Qla7rjgW0vAXTE0g2ftQyOnvkCDABWkSpU+hefhq6z7XCsmH5c5SyLk/
   YaeXSxyVP9Ld+TDIf1S86bYTnos21jaGbpiQ6U3efphWiBgnm5HiOaUEq
   X3Mjzwx1mvjmr1OMoZ2DdWIVIqbHndUyq7ur1YxaRLLvtL9VcAutTVeAy
   6XtrLkBBtfMN+PTGM+AzbSwe23WnvssKWSH+5WEWK14d+Zv6Ws2almGHF
   XytMEfvoNx4RQ4nuQOsBFHz8luTkMWZgGHNlk8tMTQuS8Yc7Y9KncbqFD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="324236777"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="324236777"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 14:06:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="687350977"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="687350977"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 09 Jan 2023 14:06:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 14:06:52 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 9 Jan 2023 14:06:52 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 9 Jan 2023 14:06:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpEKu2G8BEhqLJxcGdpTE7mFjlCKDyngqZ2vvi7mUOK+A9QKd/jgBSYuUDG7hYUAXHLqpKdc07j/QQ7ge7QISmPh0S6Sd+syXdz8yayFqvt29zRwydx4YVnqBpkSYt9Xuyjjc3Q+3eSL57pEMU/ksvca+lZGSNyiP9fDCT9uMJeAQwnbVqXTAxvhYxa5qA9pzBnlZ39Xrx658rNnifwnCINItAIyS1lnwPFVyUws+/D7FtwkuNXVpaOE9VtQabna/ri82lzajWFxcAggRtoC9CqvkMKIuttUHF4+QCVBcIJFo3LQmNhiJp0i5H4deX1rj3Grk/XDim2y7KFnuvqDlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5qpPUlp3xGS29UGVw2c54OJ5p0phbgOxb+LFXiuj4o=;
 b=J1JTeplKV3zsd1mpV6ep7Dc83QkE2tX+up5MNmRzzx1tu4uCntQrVtUUloj0rZtxrF7ttXf+tT3gV1eRyzbj4zF+tplNB7i+CQcoozMQoibpyxUB0FTAVcmJ4FRu0vyDHvT+m4G4fLJ9EOcaGhslk4GIDNvKoJldbbBIFdWX5etALanMegAClJ190Ciof1kRW2tlc9+wFewct/y3RRkW8+2bRY49DA2ZeOxZnxgKiCGmTL/yiKwB8ZGRmzmyD5ZwNDUzsFJuxqC55C6jSOW0R/PqFlSr2K13as8L6DzPzY47CIRusqrgyVB7RAr3QUdF4JkIQ15nrSCe0bailRB8yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM4PR11MB5328.namprd11.prod.outlook.com
 (2603:10b6:5:393::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 22:06:42 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::8dee:cc20:8c44:42dd]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::8dee:cc20:8c44:42dd%5]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 22:06:41 +0000
Date:   Mon, 9 Jan 2023 14:06:36 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Alexander Potapenko <glider@google.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Marco Elver <elver@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        "Andy Lutomirski" <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>, Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Ilya Leoshkevich" <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 10/45] libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE
Message-ID: <63bc8fec4744a_5178e29467@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220701142310.2188015-1-glider@google.com>
 <20220701142310.2188015-11-glider@google.com>
 <CANpmjNOYqXSw5+Sxt0+=oOUQ1iQKVtEYHv20=sh_9nywxXUyWw@mail.gmail.com>
 <CAG_fn=W2EUjS8AX1Odunq1==dV178s_-w3hQpyrFBr=Auo-Q-A@mail.gmail.com>
 <63b74a6e6a909_c81f0294a5@dwillia2-xfh.jf.intel.com.notmuch>
 <CAG_fn=WjrzaHLfgw7ByFvguHA8z0MA-ZB3Kd0d6CYwmZWVEgjA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAG_fn=WjrzaHLfgw7ByFvguHA8z0MA-ZB3Kd0d6CYwmZWVEgjA@mail.gmail.com>
X-ClientProxiedBy: BY5PR16CA0011.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::24) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|DM4PR11MB5328:EE_
X-MS-Office365-Filtering-Correlation-Id: 4365cf67-db4a-4fcb-df29-08daf28dc922
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8T93iRK9OKoHEZbrRuxIJVJquXJdcwscb7LLB6Tki6jluLPSHSFy91L7dg1lp+VddzhaYnHC/I8OVzAdOw5j/n2Ylj8ReyPq85/166AYcqKCwx05tlIT7ilPsqp3WjEHgiKWD00ZIkdII9zZiT+YuPt7s0QcZNLb4RdIK6JULUg1sABFBNLiP3cKXdCN++Um6rexGA/69bXsTwjNIv7L0DUZxUNJo2Y68XOydiOjKnov9yCsD4VHEHYAv36M3iG86LdLFU7VyY2O+QLfpJv14/6IarSniNwezBcVqfgT6Pk0KKtl3m7O9AqZC+0LySbANdf5VUg4ZfL6g0w2S4bupbuNjxqsjANlLh9oUd45IzQsl5z5/8Pz3u7+ByCBwgAv0rHBMqPpxh5WkvJDp9mq1zZ4imQISHfTtn8I7kRvnbhAfP/3tpemEXR4iTzqk3feiUW42Bj/j+osehfOrB7phMR3gxIpNbJ0+vVthibeMXoHEjef4YCu9Ovwmz87E2EsoNr30YeCJ4fuA1og4EW4DFdLAmo73vyiaJPs2792ir9sz9DFy/iFdeZw76zukqbubG1XoDB9iLIQToLjeua3A2BZh8zCCsUSH/yhQ42g0ARZSJuJtLhFsj1M71wcaxEk17TbavLv3NaNa4IpP212Qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199015)(6506007)(38100700002)(82960400001)(6666004)(53546011)(2906002)(478600001)(6486002)(7406005)(7416002)(6512007)(26005)(9686003)(316002)(5660300002)(186003)(83380400001)(8936002)(86362001)(41300700001)(8676002)(110136005)(66476007)(54906003)(66946007)(4326008)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4aV3WEPbeKpYxaYV9qEJIfTdIXogU129CHhNgDrGl5w5l5ebGkFBMHmnOG2F?=
 =?us-ascii?Q?Zs80EuelT/giKzx70+hsXYuA7MLKRSF0Bj0FaypzHureImuPea36Mi4I9kPn?=
 =?us-ascii?Q?ET3KVcYRTFK8EcP+WDfu0VHTI59ic5BH7AZILMrkWbs0dfv6wi5pKEC5yqeR?=
 =?us-ascii?Q?yPA6Uru+J9l8HX5vpnXkZCWoIr6F65wb8Gtj+8zlu/ff5gwCqBK0uL4aNB5E?=
 =?us-ascii?Q?58oRDqyLqL22GdNzZDbVo+B1Ag/RjWF3Co+5G4D6qq99eDAr7R6SufdrD+0x?=
 =?us-ascii?Q?lDUC7FZTWh2InwrLYkZric8ODPBtj8P265hPBnyXTUjBZ7xjotuIRVGpvQfU?=
 =?us-ascii?Q?Y3p+79D6mdjs/seCj8/ojloU6P8pK/1x3DmJzum94MdxLYbsM6Zl+czi/omg?=
 =?us-ascii?Q?uy6N+FyerneRj2Tpa/iBaJK+poNxAXe4epqrOWZvUNXFEcEaYC0nKJf4LyTs?=
 =?us-ascii?Q?1dszqqIvRIGOYV0WN8NDfIcw6EU2lyQlejOzpbET/f0akr0THw7+qZ9YsrsD?=
 =?us-ascii?Q?GIViikbRCct+NRwjNbJlRG5O3wDPmGCZaUekaMzNyP5nXgypIEL+Q9TodSOE?=
 =?us-ascii?Q?BjBJgOmtyinW0XbmvJvxIqa9Qh3Hd2+HqoO6ev5qGVN7N2ELEsbYHn4k/0xD?=
 =?us-ascii?Q?BUy4OOaNZbfHvpSjCL2E7gIAn59Gx/AWVoEmSfiVnYSamEGJKYihJfVOPehv?=
 =?us-ascii?Q?sRDEXaF0KvmjztfRbo/KGAq/oUWheCFL0qkmXDTtTlL1aWg66rSoULTtHjax?=
 =?us-ascii?Q?iivHf22iix0UYdZJsoN0tX0iOnDxxMJM6BiU0PFlUV6zry3rv01Xm+g1BG+H?=
 =?us-ascii?Q?Wufz6ndSg0C9l6uA31Qm1HGq4pOzfLQpMs9/0XkY8L3AalZjgLouQQoKoYj6?=
 =?us-ascii?Q?cFvUrfcF95BdKQw97p35jLcpC4cFPgsHiG1cAXtZjVSMP+pxjJdQnW6Ou59C?=
 =?us-ascii?Q?1JfXUFAqeh316SJT4smKM8YOl74HhblQ1yqI6ctjsz7EFXqRT9CVqlu8rmEA?=
 =?us-ascii?Q?/kTxN2BPaJTBIWw5JHRRDeBphgiiXdRdaXBW8cIa+lVFyYYNV0Zc7nro0g2z?=
 =?us-ascii?Q?CZeD6SglZbRZxS6eAK1q7fiaG7vXcMcMZnz4XnOAtzjoyUvp1AwBn1wy65Id?=
 =?us-ascii?Q?ESRRAZcXbHJVlE7F+61AuTAHrVFs5XrPXKQH8VOy8AJw8NZrsry4oQ8gxh4m?=
 =?us-ascii?Q?UEtxIPRbL8+kbJKmRrEtOzL9c7SASpth5WOCurEpR52oP+3ChrWwmK/2isrJ?=
 =?us-ascii?Q?fAOnhEPTasSvtuN7nt1jNr0/Y/Cx+zajV5gMN21Zvj4SzX7YbFPXfYI6in0T?=
 =?us-ascii?Q?xPbRBaWuLiWzP4P+sJTo5PY9gcQaxQvoNbt5G2jkWg+HwO8576tlmX7pHDGc?=
 =?us-ascii?Q?D4yT/NnNgjBnaxx/J7V71LdeJ+DbebIIE586yvzHukql9n+4KfC27hyElqU2?=
 =?us-ascii?Q?qA1fBbOZnWN+LPna17Uo+iLvWDtH1yLokO2nh/uwwkWQFHSey1xTk16zOhTa?=
 =?us-ascii?Q?IuEztT6vY4fbrdqOTjaB9QBeYyrY6s+5H0JJaXAujFwrgZzykWzarZBG8nNY?=
 =?us-ascii?Q?BnN5YK59kQ2nSM2/ruY4b5Y+ltjnUJH6xydlONjoTOQ48XI/X2J1h1eqylom?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4365cf67-db4a-4fcb-df29-08daf28dc922
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 22:06:41.2193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bkUFJT69gW2LAVWvGX8+tTPzY129NzQumq/sMAE3sL8SVj1wvwjvdMbzhFRO1zZT972S+xCQfKUZldxTZoiN9yRnIezqomwoAeO2dgYrRb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5328
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Alexander Potapenko wrote:
> On Thu, Jan 5, 2023 at 11:09 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > Alexander Potapenko wrote:
> > > (+ Dan Williams)
> > > (resending with patch context included)
> > >
> > > On Mon, Jul 11, 2022 at 6:27 PM Marco Elver <elver@google.com> wrote:
> > > >
> > > > On Fri, 1 Jul 2022 at 16:23, Alexander Potapenko <glider@google.com> wrote:
> > > > >
> > > > > KMSAN adds extra metadata fields to struct page, so it does not fit into
> > > > > 64 bytes anymore.
> > > >
> > > > Does this somehow cause extra space being used in all kernel configs?
> > > > If not, it would be good to note this in the commit message.
> > > >
> > > I actually couldn't verify this on QEMU, because the driver never got loaded.
> > > Looks like this increases the amount of memory used by the nvdimm
> > > driver in all kernel configs that enable it (including those that
> > > don't use KMSAN), but I am not sure how much is that.
> > >
> > > Dan, do you know how bad increasing MAX_STRUCT_PAGE_SIZE can be?
> >
> > Apologies I missed this several months ago. The answer is that this
> > causes everyone creating PMEM namespaces on v6.1+ to lose double the
> > capacity of their namespace even when not using KMSAN which is too
> > wasteful to tolerate. So, I think "6e9f05dc66f9 libnvdimm/pfn_dev:
> > increase MAX_STRUCT_PAGE_SIZE" needs to be reverted and replaced with
> > something like:
> >
> > diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
> > index 79d93126453d..5693869b720b 100644
> > --- a/drivers/nvdimm/Kconfig
> > +++ b/drivers/nvdimm/Kconfig
> > @@ -63,6 +63,7 @@ config NVDIMM_PFN
> >         bool "PFN: Map persistent (device) memory"
> >         default LIBNVDIMM
> >         depends on ZONE_DEVICE
> > +       depends on !KMSAN
> >         select ND_CLAIM
> >         help
> >           Map persistent memory, i.e. advertise it to the memory
> >
> >
> > ...otherwise, what was the rationale for increasing this value? Were you
> > actually trying to use KMSAN for DAX pages?
> 
> I was just building the kernel with nvdimm driver and KMSAN enabled.
> Because KMSAN adds extra data to every struct page, it immediately hit
> the following assert:
> 
> drivers/nvdimm/pfn_devs.c:796:3: error: call to
> __compiletime_assert_330 declared with 'error' attribute: BUILD_BUG_ON
> fE
>                 BUILD_BUG_ON(sizeof(struct page) > MAX_STRUCT_PAGE_SIZE);
> 
> The comment before MAX_STRUCT_PAGE_SIZE declaration says "max struct
> page size independent of kernel config", but maybe we can afford
> making it dependent on CONFIG_KMSAN (and possibly other config options
> that increase struct page size)?
> 
> I don't mind disabling the driver under KMSAN, but having an extra
> ifdef to keep KMSAN support sounds reasonable, WDYT?

How about a module parameter to opt-in to the increased permanent
capacity loss?

-- >8 --
From 693563817dea3fd8f293f9b69ec78066ab1d96d2 Mon Sep 17 00:00:00 2001
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 5 Jan 2023 13:27:34 -0800
Subject: [PATCH] nvdimm: Support sizeof(struct page) > MAX_STRUCT_PAGE_SIZE

Commit 6e9f05dc66f9 ("libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE")

...updated MAX_STRUCT_PAGE_SIZE to account for sizeof(struct page)
potentially doubling in the case of CONFIG_KMSAN=y. Unfortunately this
doubles the amount of capacity stolen from user addressable capacity for
everyone, regardless of whether they are using the debug option. Revert
that change, mandate that MAX_STRUCT_PAGE_SIZE never exceed 64, but
allow for debug scenarios to proceed with creating debug sized page maps
with a new 'libnvdimm.page_struct_override' module parameter.

Note that this only applies to cases where the page map is permanent,
i.e. stored in a reservation of the pmem itself ("--map=dev" in "ndctl
create-namespace" terms). For the "--map=mem" case, since the allocation
is ephemeral for the lifespan of the namespace, there are no explicit
restriction. However, the implicit restriction, of having enough
available "System RAM" to store the page map for the typically large
pmem, still applies.

Fixes: 6e9f05dc66f9 ("libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE")
Cc: <stable@vger.kernel.org>
Cc: Alexander Potapenko <glider@google.com>
Cc: Marco Elver <elver@google.com>
Reported-by: Jeff Moyer <jmoyer@redhat.com>
---
 drivers/nvdimm/nd.h       |  2 +-
 drivers/nvdimm/pfn_devs.c | 45 ++++++++++++++++++++++++++-------------
 2 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index 85ca5b4da3cf..ec5219680092 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -652,7 +652,7 @@ void devm_namespace_disable(struct device *dev,
 		struct nd_namespace_common *ndns);
 #if IS_ENABLED(CONFIG_ND_CLAIM)
 /* max struct page size independent of kernel config */
-#define MAX_STRUCT_PAGE_SIZE 128
+#define MAX_STRUCT_PAGE_SIZE 64
 int nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap);
 #else
 static inline int nvdimm_setup_pfn(struct nd_pfn *nd_pfn,
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 61af072ac98f..978d63559c0e 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -13,6 +13,11 @@
 #include "pfn.h"
 #include "nd.h"
 
+static bool page_struct_override;
+module_param(page_struct_override, bool, 0644);
+MODULE_PARM_DESC(page_struct_override,
+		 "Force namespace creation in the presence of mm-debug.");
+
 static void nd_pfn_release(struct device *dev)
 {
 	struct nd_region *nd_region = to_nd_region(dev->parent);
@@ -758,12 +763,6 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
 		return -ENXIO;
 	}
 
-	/*
-	 * Note, we use 64 here for the standard size of struct page,
-	 * debugging options may cause it to be larger in which case the
-	 * implementation will limit the pfns advertised through
-	 * ->direct_access() to those that are included in the memmap.
-	 */
 	start = nsio->res.start;
 	size = resource_size(&nsio->res);
 	npfns = PHYS_PFN(size - SZ_8K);
@@ -782,20 +781,33 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
 	}
 	end_trunc = start + size - ALIGN_DOWN(start + size, align);
 	if (nd_pfn->mode == PFN_MODE_PMEM) {
+		unsigned long page_map_size = MAX_STRUCT_PAGE_SIZE * npfns;
+
 		/*
 		 * The altmap should be padded out to the block size used
 		 * when populating the vmemmap. This *should* be equal to
 		 * PMD_SIZE for most architectures.
 		 *
-		 * Also make sure size of struct page is less than 128. We
-		 * want to make sure we use large enough size here so that
-		 * we don't have a dynamic reserve space depending on
-		 * struct page size. But we also want to make sure we notice
-		 * when we end up adding new elements to struct page.
+		 * Also make sure size of struct page is less than
+		 * MAX_STRUCT_PAGE_SIZE. The goal here is compatibility in the
+		 * face of production kernel configurations that reduce the
+		 * 'struct page' size below MAX_STRUCT_PAGE_SIZE. For debug
+		 * kernel configurations that increase the 'struct page' size
+		 * above MAX_STRUCT_PAGE_SIZE, the page_struct_override allows
+		 * for continuing with the capacity that will be wasted when
+		 * reverting to a production kernel configuration. Otherwise,
+		 * those configurations are blocked by default.
 		 */
-		BUILD_BUG_ON(sizeof(struct page) > MAX_STRUCT_PAGE_SIZE);
-		offset = ALIGN(start + SZ_8K + MAX_STRUCT_PAGE_SIZE * npfns, align)
-			- start;
+		if (sizeof(struct page) > MAX_STRUCT_PAGE_SIZE) {
+			if (page_struct_override)
+				page_map_size = sizeof(struct page) * npfns;
+			else {
+				dev_err(&nd_pfn->dev,
+					"Memory debug options prevent using pmem for the page map\n");
+				return -EINVAL;
+			}
+		}
+		offset = ALIGN(start + SZ_8K + page_map_size, align) - start;
 	} else if (nd_pfn->mode == PFN_MODE_RAM)
 		offset = ALIGN(start + SZ_8K, align) - start;
 	else
@@ -818,7 +830,10 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
 	pfn_sb->version_minor = cpu_to_le16(4);
 	pfn_sb->end_trunc = cpu_to_le32(end_trunc);
 	pfn_sb->align = cpu_to_le32(nd_pfn->align);
-	pfn_sb->page_struct_size = cpu_to_le16(MAX_STRUCT_PAGE_SIZE);
+	if (sizeof(struct page) > MAX_STRUCT_PAGE_SIZE && page_struct_override)
+		pfn_sb->page_struct_size = cpu_to_le16(sizeof(struct page));
+	else
+		pfn_sb->page_struct_size = cpu_to_le16(MAX_STRUCT_PAGE_SIZE);
 	pfn_sb->page_size = cpu_to_le32(PAGE_SIZE);
 	checksum = nd_sb_checksum((struct nd_gen_sb *) pfn_sb);
 	pfn_sb->checksum = cpu_to_le64(checksum);
-- 
2.38.1
