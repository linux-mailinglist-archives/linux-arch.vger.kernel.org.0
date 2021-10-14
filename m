Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD9E42D399
	for <lists+linux-arch@lfdr.de>; Thu, 14 Oct 2021 09:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbhJNH34 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Oct 2021 03:29:56 -0400
Received: from mga05.intel.com ([192.55.52.43]:9476 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229910AbhJNH3z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 Oct 2021 03:29:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="313818614"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="313818614"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 00:27:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="524953231"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga001.jf.intel.com with ESMTP; 14 Oct 2021 00:27:50 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 14 Oct 2021 00:27:50 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 14 Oct 2021 00:27:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 14 Oct 2021 00:27:50 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 14 Oct 2021 00:27:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8HarC+uSP6ckikfSrvAZaCXWiPjPAzWEYOWxUrV072OeF5BJ1uc5kHUh0z+zF+SfGZ80IHjcf/YCpDwwRU13t9CZtkP1XAYV8siDyovvV/MCmFGwb6uYgySWA7U4W4b3nXx3N8mcuv8RkddpRE/szZLJmf3xW/HpmY9R2AuCdw0iZJ6AGJUJ/zHSDuOWxgaUECWqI36cp9y7nGX+6CVhzswYuubtluCP1XkG4ESxkM9ggghwuzCOoTsn/QbsOndqXC5op7aDWjpVr/qHWsqjyP3iaokHwisxVkGRr5Cob9PxbsqqsaTF4v1snJUSUXNyVi8PmCO1DO1QUCnXjdX5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1qFz9iThRNhjnA6fORHVzwcENuT6UmEvron0Xtw+CU=;
 b=PPp2uWidtnRnecV+AOywPlsBp/EuVHp1Ghevq+3uk9NQCcC3g7WsrZfXO8EGf5fBDCYn2W1dWCD1ewbEIPcb6Qa4Zn0QR/8pnJmrzbEbS93BL7UKaGdotdfV6erUgKBQrMEJEkcMJRoF4OnDhgCzysK62Az1uhkCNTRnwCmJOxZCzToGwX0tCUG7/Zf9Q36tC2JbF1nKxBIEzceL9XeD9rMBFknYj8rqROEQpihfOVVUopUmHx9C+u1PA4QR0PZC79HFJPaonwZ+KN0dSIeHwwWtGzZbzLS8J/FgQJWCo/1WpMmXS5jYXENgNi9Oj1bl8iOfMEV3YkupmDW4HiWI7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1qFz9iThRNhjnA6fORHVzwcENuT6UmEvron0Xtw+CU=;
 b=SL0XAgdvgGMGnJcJ4FUZmrbu9VJQNeZvCiHel1isHHNtJoeGUHUuFBO2FWlxBfreVRkJBKLsBwaPVeNBlsrZWzm8C0IpE59o9Yn6KrDo4VMKOMzhx3QFouuWIwe590qTdiR061X9IDAF37onSuDyevjwRK365bI1WruS9dNSG6s=
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 DM6PR11MB2666.namprd11.prod.outlook.com (2603:10b6:5:c9::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.25; Thu, 14 Oct 2021 07:27:42 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::e52d:425f:5db8:9742]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::e52d:425f:5db8:9742%6]) with mapi id 15.20.4608.016; Thu, 14 Oct 2021
 07:27:42 +0000
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
Thread-Index: AQHXvKYONYCiLR7qcUWwBEZSAUzHCavKbb0AgAC0m4CAAavhgIAC4/bggAAwBACAAi5lAIAAB66AgAAFYFA=
Date:   Thu, 14 Oct 2021 07:27:42 +0000
Message-ID: <DM8PR11MB57500B2D821E8AAF93EB66CEE7B89@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053103-mutt-send-email-mst@kernel.org>
 <CAPcyv4hDhjRXYCX_aiOboLF0eaTo6VySbZDa5NQu2ed9Ty2Ekw@mail.gmail.com>
 <0e6664ac-cbb2-96ff-0106-9301735c0836@linux.intel.com>
 <DM8PR11MB57501C8F8F5C8B315726882EE7B69@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20211012171016-mutt-send-email-mst@kernel.org>
 <DM8PR11MB5750A40FAA6AFF6A29CF70DAE7B89@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20211014025514-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211014025514-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e10446c-e4ba-4d9b-597f-08d98ee41c3b
x-ms-traffictypediagnostic: DM6PR11MB2666:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2666CDE8896B250213FEE5F6E7B89@DM6PR11MB2666.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xMZ42Hi61v2A+GBeldc6VJI95RNg6NMu9frO+LGKes0OOyAOoO0JW1sR/W/H/1KkPmvvq/ruGGUuyB3gThYwS3zduc5rluZUGmh55/D3okv/jqLEtB+4fZfnzT8QB8kvoHg58Pu7sGaGiOo0EY9Vzsg+QrNQtyQeQLZYJJ2RAzODUqfwuf9UFFvayYG9ve9Rm+8lJQ4hoSEU3iRd6jigj+8QHdmrWy9Mx4PKEPxcD88/naQK0qa7+33dzFm5xFzegtvSG4W79GSYTkw7CGjM1BXkcdXwT+k516wQBCKMLug33selhBwv/xZd3Esw4CT1rJyyaVdecvTOeo6H/NwOZZMiYOzfpKJF6y8rTs68EiOdX1kJyGWmsUF+flvhNXJ9W87dfo923SLsM1581yw6ZGitG+FkJIg7A7nzpAP3Y9Sc5jnz/gNkfxa0F8H9qPb8wbcT9OYrq6YYuQqb9CZ3MApCzdiAROlgOhWuplMlGqh9Qi90s8jb+izphn5oAFr+PCxon7/TJw/AF/2c9FH+Fi1d3iz3nHmT1Mq0a9Rm0S6pIzpHBXvM7OUhmttylan6ugDmVb92DoonepL+QCp57Ml9fT6cG8Eg8S1e+XRdzH5EhDWg651MpwzMXlo74JaV7lmD82c1QxtuBB+TgMHJUv8NQpabENdu3pFFUySOX8JFnpduqJkXSpWHkKNMZbjMIPDedyRJMLDYW/+Nri9OzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(4326008)(66946007)(83380400001)(5660300002)(52536014)(55016002)(7406005)(316002)(64756008)(66446008)(76116006)(38070700005)(66556008)(26005)(7696005)(508600001)(9686003)(82960400001)(86362001)(6916009)(186003)(33656002)(8936002)(8676002)(54906003)(71200400001)(122000001)(6506007)(38100700002)(2906002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UjUWj1dUs5wcPHRd4nvF78veLhfv2gPdxIAXsdeLyOcKC7DcWgmmCXTF2OOI?=
 =?us-ascii?Q?rlHhmz1ldyfPmZAoGfKehfzmVANoyQq3KwTsjyUq321lG28YD8SQQGeI3ukD?=
 =?us-ascii?Q?gUg3S5MGxg7QzT5ogK6F1iik5ZRILUmrDned+nJa2GA8Xc51arolYsSgdHDu?=
 =?us-ascii?Q?UhhU8gCLxB/E1TBsxrKypD0c7wbKzCHJ/j5UvKpK2VqFoFJMIk+dAuHGy12i?=
 =?us-ascii?Q?BP2Ay12+L2+6PAucVeutOvNhwCH1uVZeE3SVuN6vwlyHZoUcBZe7XicQ6BQ/?=
 =?us-ascii?Q?KBsjs8LRHAmDrjDbahlsyyaBM5nOI5NbRop+lkxNU0xHe1R5RCsJPF/02v7/?=
 =?us-ascii?Q?qqu1XMa4EtBOD51SlpZp4ODet+pLXKWGUeVlaJScssit3PGZ2OnYLhqRgJLD?=
 =?us-ascii?Q?j7jBUSotAWuLjbjGNwxhuCg8yZET4Bxs3iyWib7Wl1vBPf+JWX4NljLSML7s?=
 =?us-ascii?Q?q8BlRIUi2rFpZDsTgEZIkQjfNFuqTmsiIukWMS7DW9lxHx53ITbRAiXnbczT?=
 =?us-ascii?Q?yn69kec6V8v6W3mgQheoRQJDlpM24pDnqVVSh3mpMjv+ZP/4LkkCa9/fC34D?=
 =?us-ascii?Q?duA7PzBcIrcSG5qJdKNJDxxfj6m2WyX0hC7Y8w7NVlYKsX6MMTIPNUpTdoDF?=
 =?us-ascii?Q?EGVvEnW0qGKZUPRiLEzVYOkW9SHJRgc6NiV0j6n1p0agc6JE1jYgIPsI6VZX?=
 =?us-ascii?Q?51F2XzSkRdADpw5z/QHhtDGNl32fzxXWD7Hc0pkDjbTykVipaJXVvhm9ykr6?=
 =?us-ascii?Q?/C/ATecRDeK+4J7BW+6fy/E7ImqQ6fRApGkgRt7ZHFrirAIT2vC7TAliRXHf?=
 =?us-ascii?Q?j0hSEsydbuWyokz5mkka6u1AzOOB3TLBQr+fXOvGxMBrEU7ow9nV+xl9x96V?=
 =?us-ascii?Q?gEfMgymNIeIweUYUSdyruMYoFdOQ4yQ1wSkYD17FpDVW2kZQEJRcIz/XA2Pl?=
 =?us-ascii?Q?J6g5+FUHKVyyekr0/s2lP5czdDzlvZ3xi9YIM5yszzmz8/IZvU7gxOSAxv9A?=
 =?us-ascii?Q?jaXaSDFYx5VjBefwvaYEO47h3YVqo2ahpwZZ8a7ekj4ev0PDPsREtjyTunze?=
 =?us-ascii?Q?epj7K2mhgXhuoKtByUeN9ef+ogLHi9ZeqzVm9e2werJn6WChzqqPvtosn/Fl?=
 =?us-ascii?Q?ggLpA9J9vFpt3kBFw3uSHip+U7jLMdNeXz6Cth+l8tUeAIm47xASnoRqZyOg?=
 =?us-ascii?Q?AI5hTiDtphzV0nRb8QVSCZG0ChWN86gop9kHL3Ab3r8nDaVdQ0Syn/Ow4sJt?=
 =?us-ascii?Q?X8AqRoP3MnbSspY9W16V39GqBpWpUF4oznpSPkw+kU8RaQvtt9l+iMPIAJIT?=
 =?us-ascii?Q?IF9xWUdVLQFEcqodWOiWlcFm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e10446c-e4ba-4d9b-597f-08d98ee41c3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2021 07:27:42.5113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NwZ53KBd8ZdJ1eL1OmeNhKhtn4ZJhvHCWTgWMfc04E0AAJqtsHWdBKL2nRz+vZ7LpDUXngzuYL1Q5MlrIQeh3zI5xRimnR2mqyd7axRa1Q4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2666
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> On Thu, Oct 14, 2021 at 06:32:32AM +0000, Reshetova, Elena wrote:
> > > On Tue, Oct 12, 2021 at 06:36:16PM +0000, Reshetova, Elena wrote:
> > > > > The 5.15 tree has something like ~2.4k IO accesses (including MMI=
O and
> > > > > others) in init functions that also register drivers (thanks Elen=
a for
> > > > > the number)
> > > >
> > > > To provide more numbers on this. What I can see so far from a smatc=
h-based
> > > > analysis, we have 409 __init style functions (.probe & builtin/modu=
le_
> > > > _platform_driver_probe excluded) for 5.15 with allyesconfig.
> > >
> > > I don't think we care about allyesconfig at all though.
> > > Just don't do that.
> > > How about allmodconfig? This is closer to what distros actually do.
> >
> > It does not make any difference really for the content of the /drivers/=
*:
> > gives 408 __init style functions doing IO (.probe & builtin/module_
> > > > _platform_driver_probe excluded) for 5.15 with allmodconfig:
> >
> > ['doc200x_ident_chip',
> > 'doc_probe', 'doc2001_init', 'mtd_speedtest_init',
> > 'mtd_nandbiterrs_init', 'mtd_oobtest_init', 'mtd_pagetest_init',
> > 'tort_init', 'mtd_subpagetest_init', 'fixup_pmc551',
> > 'doc_set_driver_info', 'init_amd76xrom', 'init_l440gx',
> > 'init_sc520cdp', 'init_ichxrom', 'init_ck804xrom', 'init_esb2rom',
> > 'probe_acpi_namespace_devices', 'amd_iommu_init_pci', 'state_next',
> > 'arm_v7s_do_selftests', 'arm_lpae_run_tests', 'init_iommu_one',
>=20
> Um. ARM? Which architecture is this build for?

The list of smatch IO findings is built for x86, but the smatch cross funct=
ion
database covers all archs, so when queried for all potential function calle=
rs,
it would show non x86 arch call chains also.=20

Here is the original x86 finding and call chain for the 'arm_v7s_do_selftes=
ts':

  Detected low-level IO from arm_v7s_do_selftests in fun
__iommu_queue_command_sync

drivers/iommu/amd/iommu.c:1025 __iommu_queue_command_sync() error:
{15002074744551330002}
    'check_host_input' read from the host using function 'readl' to a
member of the structure 'iommu->cmd_buf_head';

__iommu_queue_command_sync()
  iommu_completion_wait()
    amd_iommu_domain_flush_complete()
      iommu_v1_map_page()
        arm_v7s_do_selftests()

So, the results can be further filtered if you want a specified arch.=20
