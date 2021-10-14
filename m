Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFB142D2B7
	for <lists+linux-arch@lfdr.de>; Thu, 14 Oct 2021 08:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhJNGel (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Oct 2021 02:34:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:1246 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhJNGej (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 Oct 2021 02:34:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="225064431"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="225064431"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 23:32:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="626697345"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 13 Oct 2021 23:32:34 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 13 Oct 2021 23:32:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 13 Oct 2021 23:32:34 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 13 Oct 2021 23:32:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPdloaoMuEznRJlv4pByy5NGA8vygIJuluav0az00DamYfdy7WUUWvujnfbetaNVcGA10YFmRIY88cayrZ2iE/D1g0ojZymX7+7Cx+UL2JtGBXy/vVU3aPy59EtzFYFyzmMiz6mpJdnwhixz5cq+c/zWUJizLGoHVPdSg6gK2FWF97RI7P/CkLA0GSSPRjSVjyEb58Dpd2jdAeSGg55t8BDsw9g8DUp5fyRwo2qdL8ZyofZVArNusuwYaHoe1REaUoGR71/6zdTezlfVGo5qTGtzvh4Ei6/lPRdMiQoh5brd1GL4ru7ywW0ome9Dg4vAycGsdupzqPjZm3oAF/631g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUlF+vIpJPksBf/jHeBxQCSLTt+qqIQq1UXu1sD1yrs=;
 b=g5DebDXyXJIpE0zTSrJ5TW3T4ftRWpbCfEUjLA3lZe5jywjVsjbKbZ/AW2QoHy9Gk6p/Px950JE71Vlzem358Xi3ZIu9/YubdlgS3mpoOzbC5J9Rit6nmwFQHbglwzZhuen8BcoNXG6RgcvLIu0TDk4h0QfKnYZ9kpzY7g76hvj4Ru5yJqu2PZ8v9mc11wY/oZxH3KsVDpchECJ53dGZdDcAXkqFieRx888tpBwfIUTwWTh6dOKrY1GdQwfMuC9OpZFUSkCWBUl9vZ7mlJSH1Ti+qARhwnOObl8HRTtZhTH8h0I7QIs7uqIPIjRwtuIg6eBdTjZRoDppSo5V6/uyGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUlF+vIpJPksBf/jHeBxQCSLTt+qqIQq1UXu1sD1yrs=;
 b=UtOW/wuDh7eW0EcBSiSPGT9oRlKyAd18UVOSGlbxCi5fQNOBuM3IombNNJTnhwlBR4vylIKP3BmisYZ4WbaWvUUWGyFvW9ID1meZtIpJzf+u1DI1MFHkWyyPjrGU1DymQPAkFkcr70NoFsf/9UaAdDlM7Z8J3KjU/SiFlR4BYZw=
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 DM6PR11MB3180.namprd11.prod.outlook.com (2603:10b6:5:9::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.22; Thu, 14 Oct 2021 06:32:32 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::e52d:425f:5db8:9742]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::e52d:425f:5db8:9742%6]) with mapi id 15.20.4608.016; Thu, 14 Oct 2021
 06:32:32 +0000
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
Thread-Index: AQHXvKYONYCiLR7qcUWwBEZSAUzHCavKbb0AgAC0m4CAAavhgIAC4/bggAAwBACAAi5lAA==
Date:   Thu, 14 Oct 2021 06:32:32 +0000
Message-ID: <DM8PR11MB5750A40FAA6AFF6A29CF70DAE7B89@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053103-mutt-send-email-mst@kernel.org>
 <CAPcyv4hDhjRXYCX_aiOboLF0eaTo6VySbZDa5NQu2ed9Ty2Ekw@mail.gmail.com>
 <0e6664ac-cbb2-96ff-0106-9301735c0836@linux.intel.com>
 <DM8PR11MB57501C8F8F5C8B315726882EE7B69@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20211012171016-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211012171016-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1747431-ac57-4bbc-f2c9-08d98edc6704
x-ms-traffictypediagnostic: DM6PR11MB3180:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3180C979080F8A65D04B6F81E7B89@DM6PR11MB3180.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3wkqqsg05X9VpH6d9EVtQqnFgqdVBxHbKzo/1Fbgo9UV/OAkmvgMoJmWaIkJPdqtXUtClpePS242/wmffD9QdCLyxFHErappewg5/YjcQwdrYFNQTSzbHuG09gcOjxaFv86DODOziDyEvJGTX66OkwA2e2Ru90bGKOWq+ZnAK3ZMTwDFynpytnOjsxdrGgWTFeGMgjCN9dQKx39un7/UZ9kLNPkyfZnrlDijFStARon5bxdXAYzzC6kPnoks25ZRDmX9iCauSVxbONDcqkULnlPydNQ4sKjyIH5tqtHJ4NhKnsfMNqyB12pFidZiYa1eD/A1+YxyZhgFLimmRcuC84wKgAaDTadtgKfMEcTgjsJT6vsOvnshvxgjkaa6LPKpWCD8Eh6CAiHMfPcrgTyijeNgpusuJgwYKG7sai0ARWltmwDrKF/s2UtAMFm+SGfw6IB0JjZJ0nIoNQhpAUuuNKdyvnphzfJxLEj5c6J+VSDfFmAyx05Fo+7eGwEeV2Br+UEQKdTQvtljcg+5luXbmMMAPEMfnPBksbljiqL/obnqZmskLPd7vatPVNv9T4LsGFwk5Lz5y9RITCF0bmArC5D0slABai3m7eitUivT3+2v5oDw6nSIs3Dt90ArPjJ1btdzwq2BZ5+vbcWnU5zNT+5XBSKpF/5Z5e+aC5c0Iphc2sNVqdYcTWlpFVMQWxtMFaaoieP7laNfA2hjK5cn5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38070700005)(38100700002)(2906002)(186003)(316002)(71200400001)(7696005)(26005)(66556008)(66446008)(64756008)(66476007)(7416002)(122000001)(54906003)(82960400001)(6506007)(5660300002)(33656002)(7406005)(6916009)(8676002)(52536014)(86362001)(8936002)(83380400001)(4326008)(9686003)(76116006)(66946007)(55016002)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SxvED7rnXFigoywq/7Hvt/5g+QMhCRQ0l7SrTjqMsUE9G+7nb4vaxp4CaaSu?=
 =?us-ascii?Q?P32trg/uxFSsT1gp3RTaxXp4LxT9JNMvw39ABoOhIWnOFXPJkrSYFD+axB/p?=
 =?us-ascii?Q?FmDsbwtFO+mj4oQKP5rfUFPiCPe9VOONSQSMim6MNAykj/FT4fZvogAUZCPe?=
 =?us-ascii?Q?wdG1K0ANm6GlsSobedezPKL2f6DqVy+ehFrlsZbNsSzTQfBUbZnPrFwpn/Z8?=
 =?us-ascii?Q?FOQovS3SPM4/yoG9PlYp/ThcxVwCYPDmcz/Hx7rj7zXB/poQdACeNzpisq82?=
 =?us-ascii?Q?yfN+RZBJUQpKUupI2HllK9z7PX6fZ1NG4doqqm+k2J/kclV3IRT6IOpNMVf/?=
 =?us-ascii?Q?3KG84dVfitTAPbzXpj4Oea+aM3bmFxFeEqhPdXUPjoufSMdgyU9h0fkjUbOB?=
 =?us-ascii?Q?D1EiAAlSaW8uOk4Wn7pnmoDgkdE0NUY2NYt0OsHFbG8RA3gM2XZP6wWtKlv7?=
 =?us-ascii?Q?T7mWi2QLZbckt1pLwKaddmldxnQe+AQH/Vh7htIiTwW1AEWsrrLCebuNJyLW?=
 =?us-ascii?Q?n1hN6G84qexrTjQcZybS2Nb7p8+0re/mFWFjw9osq26mHecq7OM60F5oJZNa?=
 =?us-ascii?Q?J188E7w5O2ZykW7t95iUIo+gzItab4GMasSnlhDAi0DtocCddHFviPDbY/0U?=
 =?us-ascii?Q?EpEEJ/YANVJfed6pFI2etYFdS8d6kRpc2fKklrCKjc8ln964UGBauT9qIh0g?=
 =?us-ascii?Q?i+aTGm9CAErY6E9QQza+dg+02yVREWc58+FzTsetAMEn1BKgPrS5nT1L8TBi?=
 =?us-ascii?Q?MUOnoPQ581s5WUDVbQz/vUBXsqyxJP9AaRsPd+jhSz9q07Kf5IGlqLlzdiiq?=
 =?us-ascii?Q?RrC7OthdZ3Re8vZVuRieyuZY/0p8D1G/r7c49KuegUBZTrOy9EwATHIW/pZE?=
 =?us-ascii?Q?HwIcSE0bEplnGqPjofErvznzgERqNcLsT3MhZWqTsWldaTCSPas+ucjpykr+?=
 =?us-ascii?Q?atX39j2WT/A1HibLRiF52MpLLBBE/NM3xb3lAiDeHSdrszokCVWl6d9rnkdF?=
 =?us-ascii?Q?7aCCDpeagFI/x+2SEDHfu6itlfcp1cjITSNurBkVuL8mlljN7ak52xFSoUx5?=
 =?us-ascii?Q?1HaDUsn1QsNvBbL8B9VebjlH9XVk4ymlmWe8K/1/OJ3crSQ2J8Zr/O0xY54t?=
 =?us-ascii?Q?YUw250ONTN47HrEsfKX2M0Uvf6A6jQvkSKFVhlgoG1ZjaAodYtPxi4NYOKXr?=
 =?us-ascii?Q?BA9SIJKfDSPiBiBY19WmnXhsC+oi+/InNrV9kX2uIAsaDjh4w1sTxewM0hYA?=
 =?us-ascii?Q?0Yz0y8buHWXXaJsKQed16qeYd+UFGRkWqTGXz8rNHwRwrVK/hGb+vRi6LRdc?=
 =?us-ascii?Q?4aQtWIns3C+P+6Z5skQBiUx5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1747431-ac57-4bbc-f2c9-08d98edc6704
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2021 06:32:32.0777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KE1GBgNEmyH6i05SFtXykXbhk2PsEpDcGcU7S2/s0sq4y+ejtmp5UXe9BrWbnSpndic5chA03BWCwuLCrTS2t9nzHFspUh1GUnqZyKEjNwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3180
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> On Tue, Oct 12, 2021 at 06:36:16PM +0000, Reshetova, Elena wrote:
> > > The 5.15 tree has something like ~2.4k IO accesses (including MMIO an=
d
> > > others) in init functions that also register drivers (thanks Elena fo=
r
> > > the number)
> >
> > To provide more numbers on this. What I can see so far from a smatch-ba=
sed
> > analysis, we have 409 __init style functions (.probe & builtin/module_
> > _platform_driver_probe excluded) for 5.15 with allyesconfig.
>=20
> I don't think we care about allyesconfig at all though.
> Just don't do that.
> How about allmodconfig? This is closer to what distros actually do.

It does not make any difference really for the content of the /drivers/*:
gives 408 __init style functions doing IO (.probe & builtin/module_
> > _platform_driver_probe excluded) for 5.15 with allmodconfig:

['doc200x_ident_chip',
'doc_probe', 'doc2001_init', 'mtd_speedtest_init',
'mtd_nandbiterrs_init', 'mtd_oobtest_init', 'mtd_pagetest_init',
'tort_init', 'mtd_subpagetest_init', 'fixup_pmc551',
'doc_set_driver_info', 'init_amd76xrom', 'init_l440gx',
'init_sc520cdp', 'init_ichxrom', 'init_ck804xrom', 'init_esb2rom',
'probe_acpi_namespace_devices', 'amd_iommu_init_pci', 'state_next',
'arm_v7s_do_selftests', 'arm_lpae_run_tests', 'init_iommu_one',
'init_dmars', 'iommu_init_pci', 'early_amd_iommu_init',
'late_iommu_features_init', 'detect_ivrs',
'intel_prepare_irq_remapping', 'intel_enable_irq_remapping',
'intel_cleanup_irq_remapping', 'detect_intel_iommu',
'parse_ioapics_under_ir', 'si_domain_init', 'ubi_init',
'fb_console_init', 'xenbus_probe_backend_init',
'xenbus_probe_frontend_init', 'setup_vcpu_hotplug_event',
'balloon_init', 'intel_iommu_init', 'intel_rng_mod_init',
'check_tylersburg_isoch', 'dmar_table_init',
'enable_drhd_fault_handling', 'init_acpi_pm_clocksource',
'ostm_init_clksrc', 'ftm_clockevent_init', 'ftm_clocksource_init',
'kona_timer_init', 'mtk_gpt_init', 'samsung_clockevent_init',
'samsung_clocksource_init', 'sysctr_timer_init', 'mxs_timer_init',
'sun4i_timer_init', 'at91sam926x_pit_dt_init', 'owl_timer_init',
'sun5i_setup_clockevent', 'ubi_gluebi_init', 'ubiblock_init',
'hv_init_tsc_clocksource', 'hv_init_clocksource', 'mt7621_clk_init',
'samsung_clk_register_mux', 'samsung_clk_register_gate',
'samsung_clk_register_fixed_rate', 'clk_boston_setup',
'gemini_cc_init', 'aspeed_ast2400_cc', 'aspeed_ast2500_cc',
'sun6i_rtc_clk_init', 'phy_init', 'ingenic_ost_register_clock',
'meson6_timer_init', 'atcpit100_timer_init',
'npcm7xx_clocksource_init', 'clksrc_dbx500_prcmu_init', 'skx_init',
'i10nm_init', 'sbridge_init', 'i82975x_init', 'i3000_init',
'x38_init', 'ie31200_init', 'i3200_init', 'amd64_edac_init',
'pnd2_init', 'edac_init', 'adummy_init', 'mtd_stresstest_init',
'bxt_idle_state_table_update', 'sklh_idle_state_table_update',
'skx_idle_state_table_update',
'acpi_gpio_handle_deferred_request_irqs', 'smc_findirq', 'ltpc_probe',
'com90io_probe', 'com90xx_probe', 'pcnet32_init_module',
'it87_gpio_init', 'f7188x_find', 'it8712f_wdt_find', 'f71808e_find',
'it87_wdt_init', 'f71882fg_find', 'it87_find', 'f71805f_find',
'parport_pc_init', 'asic3_irq_probe', 'sch311x_detect',
'amd_gpio_init', 'dvb_init', 'dvb_register', 'em28xx_alsa_register',
'em28xx_dvb_register', 'em28xx_rc_register', 'em28xx_video_register',
'blackbird_init', 'bttv_check_chipset', 'ivtvfb_callback_init',
'init_control', 'con_init', 'cr_pll_init',
'clk_disable_unused_subtree', 'fmi_init', 'cadet_init', 'pcm20_init',
'airo_init_module', 'bnx2i_mod_init', 'bnx2fc_mod_init',
'timer_of_irq_exit', 'init', 'kempld_init', 'ivtvfb_init',
'brcmf_core_init', 'comedi_test_init', 'tlan_eisa_probe',
'timer_probe', 'of_clk_init', '__reserved_mem_init_node',
'of_irq_init', 'mace_init', 'vortex_eisa_init', 'reset_chip',
'atp_init', 'atp_probe1', 'smc_probe', 'osi_setup', 'led_init',
'el3_init_module', 'clk_sp810_of_setup', 'ltpc_probe_dma',
'com90io_found', 'check_mirror', 'arcrimi_found', 'com90xx_found',
'intel_soc_thermal_init', 'thermal_register_governors',
'thermal_unregister_governors', 'therm_lvt_init', 'tcc_cooling_init',
'powerclamp_probe', 'intel_init', 'qcom_geni_serial_earlycon_setup',
'kgdboc_early_init', 'lpuart_console_setup', 'speakup_init',
'early_console_setup', 'init_port', 'early_serial8250_setup',
'linflex_console_setup', 'register_earlycon', 'of_setup_earlycon',
'slgt_init', 'moxa_init', 'parport_pc_init_superio',
'parport_pc_find_ports', 'mousedev_init', 'ses_init', 'riocm_init',
'efi_rci2_sysfs_init', 'blogic_probe', 'blogic_init',
'blogic_init_mm_probeinfo', 'blogic_init_probeinfo_list',
'blogic_checkadapter', 'blogic_rdconfig', 'blogic_inquiry',
'adpt_init', 'clk_unprepare_unused_subtree', 'aspeed_socinfo_init',
'rcar_sysc_pd_setup', 'r8a779a0_sysc_pd_setup', 'renesas_soc_init',
'rcar_rst_init', 'rmobile_setup_pm_domain', 'mcp_write_pairing_set',
'a72_b53_rac_enable_all', 'mcp_a72_b53_set',
'brcmstb_soc_device_early_init', 'imx8mq_soc_revision',
'imx8mm_soc_uid', 'imx8mm_soc_revision', 'qe_init',
'exynos5x_clk_init', 'exynos5250_clk_init', 'exynos4_get_xom',
'create_one_cmux', 'create_one_pll', 'p2041_init_periph',
'p4080_init_periph', 'p5020_init_periph', 'p5040_init_periph',
'r9a06g032_clocks_probe', 'r8a73a4_cpg_clocks_init',
'sh73a0_cpg_clocks_init', 'cpg_div6_register',
'r8a7740_cpg_clocks_init', 'cpg_mssr_register_mod_clk',
'cpg_mssr_register_core_clk', 'rcar_gen3_cpg_clk_register',
'cpg_sd_clk_register', 'r7s9210_update_clk_table',
'rz_cpg_read_mode_pins', 'rz_cpg_clocks_init',
'rcar_r8a779a0_cpg_clk_register', 'rcar_gen2_cpg_clk_register',
'sun8i_a33_ccu_setup', 'sun8i_a23_ccu_setup', 'sun5i_ccu_init',
'suniv_f1c100s_ccu_setup', 'sun6i_a31_ccu_setup',
'sun8i_v3_v3s_ccu_init', 'sun50i_h616_ccu_setup',
'sunxi_h3_h5_ccu_init', 'sun4i_ccu_init', 'kona_ccu_init',
'ns2_genpll_scr_clk_init', 'ns2_genpll_sw_clk_init',
'ns2_lcpll_ddr_clk_init', 'ns2_lcpll_ports_clk_init',
'nsp_genpll_clk_init', 'nsp_lcpll0_clk_init',
'cygnus_genpll_clk_init', 'cygnus_lcpll0_clk_init',
'cygnus_mipipll_clk_init', 'cygnus_audiopll_clk_init',
'of_fixed_mmio_clk_setup', 'xdbc_map_pci_mmio', 'xdbc_find_dbgp',
'xdbc_bios_handoff', 'xdbc_early_setup', 'ehci_setup',
'early_xdbc_parse_parameter', 'find_cap', '__find_dbgp',
'nvidia_set_debug_port', 'detect_set_debug_port',
'early_ehci_bios_handoff', 'early_dbgp_init', 'dbgp_init',
'ulpi_init', 'hidg_init', 'xdbc_init', 'brcmstb_usb_pinmap_probe',
'dell_init', 'eisa_init_device', 'mlxcpld_led_probe', 'nas_gpio_init',
'asic3_mfd_probe', 'asic3_probe', 'watchdog_init', 'ssb_modinit',
'pt_init', 'thinkpad_acpi_module_init', 'kbd_init', 'joydev_init',
'evdev_init', 'evbug_init', 'input_leds_init', 'mk712_init',
'l4_add_card', 'ns558_init', 'apanel_init', 'ct82c710_detect',
'i8042_check_aux', 'i8042_check_mux', 'i8042_probe', 'i8042_init',
'i8042_aux_test_irq', 'ocrdma_init_module', 'input_apanel_init',
'cs5535_mfgpt_init', 'geodewdt_probe', 'duramar2150_c2port_init',
'init_ohci1394_dma_on_all_controllers', 'init_ohci1394_controller',
'rionet_init', 'nonstatic_sysfs_init', 'init_pcmcia_bus',
'devlink_class_init', 'switchtec_ntb_init', 'mport_init',
'drivetemp_init', 'omap_vout_probe', 'probe_opti_vlb',
'probe_chip_type', 'legacy_check_special_cases',
'qdi65_identify_port', 'probe_qdi_vlb', 'comedi_init', 'hv_acpi_init',
'pcistub_init_devices_late', 'bcma_host_soc_register',
'bcma_bus_early_register', 'vga_arb_device_init',
'vga_arb_select_default_device', 'zf_init',
'watchdog_deferred_registration', 'wb_smsc_wdt_init',
'w83977f_wdt_init', 'ali_find_watchdog', 'pc87413_init',
'alim7101_wdt_init', 'at91_wdt_init', 'sc1200wdt_probe',
'asr_get_base_address', 'dmi_walk_early', 'dmi_sysfs_init',
'dell_smbios_init', 'acer_wmi_init', 'get_thinkpad_model_data',
'dmi_scan_machine', 'pci_assign_unassigned_resources',
'cpcihp_generic_init', 'pnpacpi_init', 'acpi_early_processor_osc',
'acpi_processor_check_duplicates', 'acpi_early_processor_set_pdc',
'acpi_ec_dsdt_probe', 'cros_ec_lpc_init', 'tpacpi_acpi_handle_locate',
'ks_pcie_init_id', 'ks_pcie_host_init', 'pci_apply_final_quirks',
'intel_uncore_init', 'qedr_init_module', 'isapnp_peek',
'isapnp_isolate', 'init_ipmi_si', 'isapnp_build_device_list',
'pnpacpi_add_device', 'erst_init', 'intel_idle_acpi_cst_extract',
'xen_acpi_processor_init', 'acpi_scan_init', 's3_wmi_probe',
'intel_opregion_present', 'extlog_init', 'intel_pstate_init',
'via_rng_mod_init', 'amd_rng_mod_init', 'ccp_init', 'init_nsc',
'init_atmel', 'intel_rng_hw_init', 'intel_init_hw_struct',
'tlclk_init', 'mwave_init', 'applicom_init', 'hdaps_init',
'tink_board_init', 'ibm_rtl_init', 'samsung_sabi_init',
'samsung_init', 'samsung_backlight_init', 'samsung_rfkill_init_swsmi',
'samsung_lid_handling_init', 'samsung_leds_init', 'samsung_sabi_diag',
'samsung_sabi_infos', 'isst_if_mbox_init', 'pmc_atom_init',
'abituguru_detect', 'hwmon_pci_quirks', 'applesmc_init',
'abituguru3_detect', 'w83627ehf_probe', 'dme1737_isa_detect',
'smsc47m1_probe', 'pcc_cpufreq_init', 'cpufreq_p4_init',
'centrino_init', 'acpi_cpufreq_init', 'pcc_cpufreq_probe',
'intel_pstate_msrs_not_valid',
'intel_pstate_platform_pwr_mgmt_exists', 'acpi_cpufreq_boost_init',
'amd_freq_sensitivity_init', 'gic_fixup_resource', 'do_floppy_init',
'get_fdc_version', 'pf_init', 'pg_init', 'pd_init', 'pcd_init',
'rio_basic_attach']
