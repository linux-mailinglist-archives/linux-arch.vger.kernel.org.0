Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D795C42D95C
	for <lists+linux-arch@lfdr.de>; Thu, 14 Oct 2021 14:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhJNMgE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Oct 2021 08:36:04 -0400
Received: from mga09.intel.com ([134.134.136.24]:15553 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230177AbhJNMgD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 Oct 2021 08:36:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="227563458"
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="227563458"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 05:33:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="626783598"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga001.fm.intel.com with ESMTP; 14 Oct 2021 05:33:58 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 14 Oct 2021 05:33:57 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 14 Oct 2021 05:33:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 14 Oct 2021 05:33:57 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 14 Oct 2021 05:33:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmssFszxjrRU4rp0VAoefaF6kzYGjzixtVoz39jBymfL1QBVnFsnenuISQkl4Td8Z8VnNtE9wU5mdguKCbmxchTESLsjvtYPUTcxNNXtpKEGHoHrbYR538FehFSlAHvdUlBPPsshpTjtWmLSMW9gfKdngXaRl8/NXptZv4jfO0L8COIbltXTROiBwrU2xDXWZTytloVLofIYiKr2d/IqJmpg29DMqP8nKmz9IyKqnWFFXVCsZ7ZVKoNCLdq/DxIJPFDwOnpwUH/GLmwLWJFqvLS7u+tPp56domONK8Y4LJumAVmX/rGa9EqZlekTrtHAtyG4Wn8bnT+d/5tVL4kC3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FOJuvoJJ48oW+x03tB/D7zCX3mQvKdh2r2mpBn2R+A=;
 b=cr75bv+wrrf6m7zNjDJn1LEgKkBsom/m2VHXl4j37ZTPyKZpcPCoV3AN3upF9vvaP8rmuS1ZsL9J47PGM3nUIch3scUaAlz11uJDrR1OZbclw7iIEpgfMPZavO2OSwG7UMldow8XYI3lhkR4q3o7lyJaoeI0JMe6rlz5u9nR0IR0wJHfOaXLbZwxnXBYzP4q0w5DpTQ7BZ4YdBcC+ZWvhnPlAmmk8JwJekFpCJwjOg+V0JUv7dpLhkgDZG5M+P5FZiIvHy4cfzd3LvBcl2kwRfjaPB6ZlXMyaoIvYzubwyRmHVR+KkO4Ky30Dim2N+HASqVbeKO0nLfk1k9OdBiU8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FOJuvoJJ48oW+x03tB/D7zCX3mQvKdh2r2mpBn2R+A=;
 b=lIlD8uzNvoZpN8s/ICg7hXLqZIjfp7i+C+E9IrL2z+eTPVWU+1Z/wePWgfUu6WJHkgshG2O55lHI3nfRgz61uGRP+tLT1M2rmm2XVUi1GF48uyf3mI+kQIDTpCt0tuZ+1cU9wE8rfo/G7RP9qX0op1d2SbNv4kbXqHkmm4ys3Iw=
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 DM6PR11MB3324.namprd11.prod.outlook.com (2603:10b6:5:59::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.22; Thu, 14 Oct 2021 12:33:49 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::e52d:425f:5db8:9742]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::e52d:425f:5db8:9742%6]) with mapi id 15.20.4608.016; Thu, 14 Oct 2021
 12:33:49 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Andi Kleen <ak@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E J Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter H Anvin <hpa@zytor.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
Thread-Topic: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
Thread-Index: AQHXvKYONYCiLR7qcUWwBEZSAUzHCavKbb0AgAC0m4CAAavhgIAC4/bggAAwBACAAi5lAIAAB66AgAAFYFCAACQlAIAAMccw
Date:   Thu, 14 Oct 2021 12:33:49 +0000
Message-ID: <DM8PR11MB57505AAA1E1209F7FCA69C11E7B89@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053103-mutt-send-email-mst@kernel.org>
 <CAPcyv4hDhjRXYCX_aiOboLF0eaTo6VySbZDa5NQu2ed9Ty2Ekw@mail.gmail.com>
 <0e6664ac-cbb2-96ff-0106-9301735c0836@linux.intel.com>
 <DM8PR11MB57501C8F8F5C8B315726882EE7B69@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20211012171016-mutt-send-email-mst@kernel.org>
 <DM8PR11MB5750A40FAA6AFF6A29CF70DAE7B89@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20211014025514-mutt-send-email-mst@kernel.org>
 <DM8PR11MB57500B2D821E8AAF93EB66CEE7B89@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20211014052605-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211014052605-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b04597d9-b085-4083-7728-08d98f0edfcd
x-ms-traffictypediagnostic: DM6PR11MB3324:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3324FB0C8EC537B26FF4ECF6E7B89@DM6PR11MB3324.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3m8v3e0x3XrQUi5iJ+Fg3rkLkP0uIk77ylZL96WgNFJZx7eqlOkKxLi2LA06ePOLMZ88UYJgX4LKWkqqQs5C7KOLZwJZVFIeXhZT+fnG1W0jI9JY5i1FTsu9Nxl2gH4wVYbeVDyRz0pI/XyHCHGrWkVrIyAAKKQ2a1S2TO+RTdqLEXMmPY7R3buAjxssbeqC79X9nbVSz0+hSNWtarF6f3oJbeNpp1hLV+8qNNPogPuRa1n8ITe82vAMrreHL2hFEr2kFy8R6bVZXcTwqllicLyjGeeEWpzIdL0X8+O8rBt3y0EdlzWURQWnujRThd02Yigrxj2ln7ad3/Q4G0XDQJ0ctsFwnWQKrKCanibpaQb1MVkPs5X/hCJR2Z/R4sWMLcNTGLFNbzw81wmPtWphI4QpqPtTakMZdd5jpUGkMXRbB9VOh5VUOE7FafBpPHt2IqiyotlO1fAJ/5yFNR6toMW1qezcL7lkvwyXi80fi1Bxk7ABjGUaPgxPhK21SE6pJ/+z3ujebIe6nEPlm0IGheRqY38H2LuOstXRrZdVbbCJ5HdxQTf8D0GVH32VEF3soo3M5DdSSOkAhRRayetAwIhL4M36tQxyRNTSgw57La/IGmwG/+rShHoQ9l6qV/lltA1KUOyFxiJjP15y+VwRXZ4xMcR6LPJxpZO0iEl4SGf53HCdX61YRym3FEbRNrVcFNqpxzhwcmp3sAzzmdX5lov8vz4yLtFmD9WR5mH6dktdPwYueDEaQKts4ISlalBc5TdGA0ViFj8c1xkYp+HXNlU5TiQ8HQY1OZeGQphHbAQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(8936002)(186003)(4326008)(52536014)(9686003)(122000001)(7696005)(71200400001)(82960400001)(54906003)(316002)(7406005)(6506007)(26005)(66476007)(7416002)(8676002)(966005)(76116006)(33656002)(66946007)(38070700005)(55016002)(2906002)(508600001)(66446008)(83380400001)(66556008)(64756008)(86362001)(6916009)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TKchS+CtpIbIejaxdFhTslNG8Ao9xJ8rabsvj8olrXWoI/Ww6ASMY3gImaLH?=
 =?us-ascii?Q?5l1AX3d+j25thnn4ZyBcnT3szd6uYNO/k8zubJW83v7yD7axOwxL59Vn8iqK?=
 =?us-ascii?Q?4P5yboUnoKkhG4tgtezSoDy1YbIzFf4ntwxqPzbeIyfN0m1henwUHjxI3dAD?=
 =?us-ascii?Q?+L3JNDAGV7fZMCNgTf/B00wYmph0RU6ds7wyCTNdKSaqpduehuRZJ+xEaKvu?=
 =?us-ascii?Q?/Z/rlJ00lLfrG56hrxR5Qx9kufB4wtYqya5ize1jhh5ChOawwmW75+VhlItj?=
 =?us-ascii?Q?vMKqviij3xAtIAl6zde8jgf4+kdfqBBSo73E3SKDulGTchtUGoHVjpcU312T?=
 =?us-ascii?Q?vD8TVgwD1NSBYPcWEYQ1/3EgduG/74fUwUEFmKk1VW1K7kZXVgp7s/aGoVzX?=
 =?us-ascii?Q?EtxP7dtw2VMLdNHEO+SfMZ6bzhLbm0OnxQBaaDQG/8HeQFpvEPrIErJO5MoF?=
 =?us-ascii?Q?7eLytMrB3YutHQvs7LSBidCiqF0WGvapmVfwuuYr37OLfbU3U1b3pEM/SSw0?=
 =?us-ascii?Q?a694enm2Baswb0Yb4DfbweW5PH2D2TuqbtpLTgIApxRhXPOiSbs0QnCzmNcT?=
 =?us-ascii?Q?PkXbyC0l3A994zriwOlZAreVjqHav6uM74F67fP6rKXRlY9U/cCmOEVgeRSb?=
 =?us-ascii?Q?o/meW9jgGtSyMHi1vXCDLVIew9BSUNKYCFbcCJE3FOglQb1RFM+vkU7yidJm?=
 =?us-ascii?Q?GTXbRNrcIYK2FtTKgkEr+AAryglDbWu6G/TGCX10qTIUl8MVwX3SD34lolB2?=
 =?us-ascii?Q?Y9RRTif7Rfy5PaQbUpoIpzxfAiYif5fMW44C6H6oInc/pyMJAYIZOrW1gkym?=
 =?us-ascii?Q?J465DM4sVcnaNMvglqJ6kRqu77vfvbept0BQ6TUrI28T4SxZkKdNdBT1dAjr?=
 =?us-ascii?Q?yTJurh+SZf8vX4iynw1pPMYynXZmRSx+VhLpQ3uePtiloSROKp/Eday3K+Zk?=
 =?us-ascii?Q?WRaJYM+G7lLZz3FWyZxwTWx3KyaMlZZ396o7b8QzYsxweoEEI1r7KHBcxEiP?=
 =?us-ascii?Q?erbe1lDymLQidmbhFNMcn5Gv8KRmd8fPgpjJilPlC1t4+I4ELyAMWCID5iZb?=
 =?us-ascii?Q?pVR4gHbb+miqzyrI0cpxsg5wB717KPyshifU5CcQ3NkcyxJOZ9m9nvUmplUp?=
 =?us-ascii?Q?GNur3TAxFZXKpVpdfAIJZzZbyR7kOq57eCOJEaCtYgwCOmVSkDS+L0GuPxAl?=
 =?us-ascii?Q?BTUYpjTiTLLkHYvZNKjfR+gFTm5m9o/sL/rI3fZe3GBxqvSoQpfs/UuJdPMK?=
 =?us-ascii?Q?WMXfm1rmuN/UhKtoUTsgET9SPi+U0TbjHH+gvyYoduYLtsU6txdEIeQnbm56?=
 =?us-ascii?Q?MPZQkmHF76mUlN6PsXQ5SdFw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b04597d9-b085-4083-7728-08d98f0edfcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2021 12:33:49.5748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hZWs78Amc/ow0Nik+zEumk5poPkItCNwL3eGpt5WvY+2Hv4Vs8aIAm4bBI3d570nJTHvZsvowvLnohtNMkqytmGwnT/a4ltHiS+cMNfETx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3324
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> On Thu, Oct 14, 2021 at 07:27:42AM +0000, Reshetova, Elena wrote:
> > > On Thu, Oct 14, 2021 at 06:32:32AM +0000, Reshetova, Elena wrote:
> > > > > On Tue, Oct 12, 2021 at 06:36:16PM +0000, Reshetova, Elena wrote:
> > > > > > > The 5.15 tree has something like ~2.4k IO accesses (including=
 MMIO and
> > > > > > > others) in init functions that also register drivers (thanks =
Elena for
> > > > > > > the number)
> > > > > >
> > > > > > To provide more numbers on this. What I can see so far from a s=
match-
> based
> > > > > > analysis, we have 409 __init style functions (.probe & builtin/=
module_
> > > > > > _platform_driver_probe excluded) for 5.15 with allyesconfig.
> > > > >
> > > > > I don't think we care about allyesconfig at all though.
> > > > > Just don't do that.
> > > > > How about allmodconfig? This is closer to what distros actually d=
o.
> > > >
> > > > It does not make any difference really for the content of the /driv=
ers/*:
> > > > gives 408 __init style functions doing IO (.probe & builtin/module_
> > > > > > _platform_driver_probe excluded) for 5.15 with allmodconfig:
> > > >
> > > > ['doc200x_ident_chip',
> > > > 'doc_probe', 'doc2001_init', 'mtd_speedtest_init',
> > > > 'mtd_nandbiterrs_init', 'mtd_oobtest_init', 'mtd_pagetest_init',
> > > > 'tort_init', 'mtd_subpagetest_init', 'fixup_pmc551',
> > > > 'doc_set_driver_info', 'init_amd76xrom', 'init_l440gx',
> > > > 'init_sc520cdp', 'init_ichxrom', 'init_ck804xrom', 'init_esb2rom',
> > > > 'probe_acpi_namespace_devices', 'amd_iommu_init_pci', 'state_next',
> > > > 'arm_v7s_do_selftests', 'arm_lpae_run_tests', 'init_iommu_one',
> > >
> > > Um. ARM? Which architecture is this build for?
> >
> > The list of smatch IO findings is built for x86, but the smatch cross f=
unction
> > database covers all archs, so when queried for all potential function c=
allers,
> > it would show non x86 arch call chains also.
> >
> > Here is the original x86 finding and call chain for the 'arm_v7s_do_sel=
ftests':
> >
> >   Detected low-level IO from arm_v7s_do_selftests in fun
> > __iommu_queue_command_sync
> >
> > drivers/iommu/amd/iommu.c:1025 __iommu_queue_command_sync() error:
> > {15002074744551330002}
> >     'check_host_input' read from the host using function 'readl' to a
> > member of the structure 'iommu->cmd_buf_head';
> >
> > __iommu_queue_command_sync()
> >   iommu_completion_wait()
> >     amd_iommu_domain_flush_complete()
> >       iommu_v1_map_page()
> >         arm_v7s_do_selftests()
> >
> > So, the results can be further filtered if you want a specified arch.
>=20
> So what is it just for x86? Could you tell?

I can probably figure out how to do additional filtering here, but does
it really matter for the case that is being discussed here? Andi's point wa=
s
that there quite many existing places in the kernel when low-level IO
happens before the probe stage. So I brought these numbers here.
What do you plan to do with the pure x86 results?=20

And here are the full results for allyesconfig, if anyone is interested (ju=
st got permission to create
the repository today):
https://github.com/intel/ccc-linux-guest-hardening/tree/master/audit/sample=
_output/5.15-rc1
We will be pushing to this repo all the scripts and fuzzing setups we use a=
s part of
our Linux guest hardening effort for confidential cloud computing, but it i=
s going to take
some time to get all the approvals collected. =20

Best Regards,
Elena.
