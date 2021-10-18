Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDAD4310FA
	for <lists+linux-arch@lfdr.de>; Mon, 18 Oct 2021 09:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhJRHFu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Oct 2021 03:05:50 -0400
Received: from mga18.intel.com ([134.134.136.126]:15529 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230246AbhJRHFs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 Oct 2021 03:05:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10140"; a="215112941"
X-IronPort-AV: E=Sophos;i="5.85,381,1624345200"; 
   d="scan'208";a="215112941"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 00:03:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,381,1624345200"; 
   d="scan'208";a="493467726"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga008.jf.intel.com with ESMTP; 18 Oct 2021 00:03:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 18 Oct 2021 00:03:36 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 18 Oct 2021 00:03:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Mon, 18 Oct 2021 00:03:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Mon, 18 Oct 2021 00:03:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtZuYqP4YaiHzsE9u5SO6iOwjcoBCV/5z2ooYE4aEd0mKwTMTHfh7X/gUqVYmq7D5ZWpkY8mxgBycbGC35pvfFEr41zYi01aSgdbgN4u+mYo8fqjLPKVeW5El7zYFKqpPTZkIaRW1FA5JDfq8alKO3d94K0EQjp7ety0KNzJKtG7QFhg26MjNlR6n5avvWs0LHG+Vowvci+rtLxrsaFRWF40GTvQ4h62RwqZOWAEM8Cp3OkoapDeDMIeZUPKt1zUn5c36ymJEa4ris3ObxcgYk97j75STmUIr+DsdxkeJmcrJlfbl6Ra2tdchrv/qAO0Xv20EV6VpGoOyTN0GKdQCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRYljniKx/iieGHOJQ49ofrGDx7fY4YeEUn1Wdr1aG4=;
 b=SwVPjDwacKcwrCtF1YoFbRuEHy1EAO2w4fmm5B+Vkc8KwMKwJ8iftQz6ILILxn1s8u8y+Cit2yCJI0spGgG1DwLI0PIuJUrgyIEKcPPUYprE56ShWrGMw9N76LMfMf8rvXeAPqlNSNcqKEf9HjNPI3k1dVUpwtZbI7JiV7JNWQCLkbDVlAfDndEThYa1+PTDH/iUE68PBblzfD65c/wAsHVVYFFKiBTYrpjrvcQn0+gfcQUk7F4LCxeq+yLtW0X5yO5Tkte9ot+qQTYXV6+sjy9KuOiXD0NgMwlxj/7S9/a9dCAOEonxTLMcg1tgv5NRwWAnXR+dD5TKRuPykkC0YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRYljniKx/iieGHOJQ49ofrGDx7fY4YeEUn1Wdr1aG4=;
 b=JEtwztJ5nCvXhezUqpBoOpU8E+wDxrBjs7TcobhbryUF8kDQL0XmDZ8Pemxo0gCIDrNCbuvli1jmYUCuiGG0awyig7APGvgq77ANMeaVUVtHpDQKl7eJa3TQM5KjKVtAYP9GY4M/FJUOQPQ7F6sFrMXKFQLXInJQnLj+6pnAuDI=
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 DM6PR11MB3913.namprd11.prod.outlook.com (2603:10b6:5:193::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18; Mon, 18 Oct 2021 07:03:30 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::e52d:425f:5db8:9742]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::e52d:425f:5db8:9742%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 07:03:30 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>
CC:     Andi Kleen <ak@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        James E J Bottomley <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "David Hildenbrand" <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        Peter H Anvin <hpa@zytor.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Kirill Shutemov" <kirill.shutemov@linux.intel.com>,
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
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
Thread-Topic: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
Thread-Index: AQHXvKYONYCiLR7qcUWwBEZSAUzHCavKbb0AgAC0m4CAAavhgIAC4/bggAAwBACAAi5lAIAFuLoAgACKNaA=
Date:   Mon, 18 Oct 2021 07:03:30 +0000
Message-ID: <DM8PR11MB57500987A12AFA645337CDBAE7BC9@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053103-mutt-send-email-mst@kernel.org>
 <CAPcyv4hDhjRXYCX_aiOboLF0eaTo6VySbZDa5NQu2ed9Ty2Ekw@mail.gmail.com>
 <0e6664ac-cbb2-96ff-0106-9301735c0836@linux.intel.com>
 <DM8PR11MB57501C8F8F5C8B315726882EE7B69@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20211012171016-mutt-send-email-mst@kernel.org>
 <DM8PR11MB5750A40FAA6AFF6A29CF70DAE7B89@DM8PR11MB5750.namprd11.prod.outlook.com>
 <87r1cj2uad.ffs@tglx>
In-Reply-To: <87r1cj2uad.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79a5bac1-a918-4c54-6c26-08d99205648a
x-ms-traffictypediagnostic: DM6PR11MB3913:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3913EB236A0ED560C86103C7E7BC9@DM6PR11MB3913.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6F+iJV3YwloaymanZoBrJ30mKbK2G12v90095f7jDSjlnDeFutanbX0aGU9syDJK/6A+LrTy+GcLcm/SB5LidkDfy9PtA0SMDZJI5+h+lwo9uPu1TXbvs3KfYJFFPpCICN6ZDWn2va9ii0oLTcBOxMox8y5dKS+p52jWnm6TU/MBOvUCkPavrcFfZ7SB0W2D6Kj74MrQIsG4Pgb7teU/apuXj9cOAVAn8whHTt3rrO7QzbJ+zKtO+jW31Fd70JHKLqdpJbtJbL18B0XINeAnGAiOp0zEmGYi+OyCV7NG+ZQgI3QgpI41uKeGBj3ugek80TTIc83OFoQ8qmrgBcK0dv5Vr06U9YwSTqFIcwB1pm2sEePAjPo0ySxqj1sdnfRzqoUT3916QE7sWlkwimN5BrynzzBF0jTOgvsyjkHIrm2htxpU2/rd4B6SUDb+JRUpp4Um8z/P2q8ejFcpS/IAt2XmaGCpTAcgSK6mlWjHBN6vepV3xppajqcIrRBPRb6V6LdDZmmmnE7kJxEujoLHWMN0GTr/jhTNjURsLtQrQfCDSpJj5kMA3tSjZyJd4srcVa8Y7zrpLWO7iFI5TC94S5m/Z2Sx3iyadwFdAd9bbzw4O+lfdnZPQ+EjCNLdN7H4u5e0B02Mu//twCFCIQqimKcfrvs/Gfit76umQPvRzMEQA3dAgHjidbr7v8vzVwnHLD8uqk+7hvO8WHLr1CYDiIIXxBLcXI6hD7X2vmZ2Yc4ffSrOm3WF/8f6VeLQLqshQSd6rXP/8Y1ksK83mrcOI8cYjb2uyeIOSPmvXd9UgEo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33656002)(4326008)(966005)(8936002)(7696005)(9686003)(508600001)(7416002)(66946007)(66556008)(66476007)(38100700002)(82960400001)(86362001)(66446008)(55016002)(122000001)(8676002)(26005)(76116006)(64756008)(71200400001)(6506007)(316002)(7406005)(2906002)(83380400001)(110136005)(186003)(52536014)(5660300002)(54906003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UqyEUtCIJec84Uxkfc/KAmkjp424h6UvVHzpM2ks/58RjFJHSKXdJXEKkcRY?=
 =?us-ascii?Q?npHY/xCGGnjWhowixPr0+gDqOMCx80b8wAOtVFWD8qYnoKhSClPh6z7TsK/s?=
 =?us-ascii?Q?xitXeo+g1C2qweA7yzV+7lqHF7rGF5AfgHyyXBrjEQv+53PfGv5+9K9E6VXP?=
 =?us-ascii?Q?LGMsJqOW9JUkeEB7F0tLUsa1GWGasXBZCogpY9ekiRPlx/+g+Gw8A6V/0bXA?=
 =?us-ascii?Q?YZr1zgNdTCTvRl8/JXoGuHLbCyPwnwHdGZsYzjylitPiRqoJjoOa28YZx/qT?=
 =?us-ascii?Q?8+dlQLYY7J+zGLudo1gHDPkD5g0jGDNTSpboV8TaEFzR1CU8P3c65UKdOBCb?=
 =?us-ascii?Q?JuAj9vFApi/Eklr+mjAtfik10uT/xFA5kBOTEVmWtVGmdehL5j2bhIM6GDCd?=
 =?us-ascii?Q?E7MnCtGyR69Z0AFJSnM/E794E83wyGFhElFpeFcfjy3TR9L2eG1v4bQi63A5?=
 =?us-ascii?Q?MHUpPBrRmKgASJCkdEHqmrTdjIFdLnqnE5VIMUA1CHXbF27XuD9obVxBqPZv?=
 =?us-ascii?Q?n54VCKY+2p+SGEPDx5OY/eo9GC6AS3asRqeIXme8ALddpk0pTJHJRgD42snd?=
 =?us-ascii?Q?lBZUnciZfWtthWPvq1mxIb8I5QlkTUmEHBheCyOADxjoBSgf/ILjTolLSO2y?=
 =?us-ascii?Q?dUYvyXaLPmiIpowHqcBd2N0WFfoHEcLB8CmUpS9mEdRV4rhtxSIRl7Kyk6VO?=
 =?us-ascii?Q?dFKlc+nidiLcUlCbRueSbnWSd4yFrh6G/jMQ71EG433N1AsdDS9mB/nQusJN?=
 =?us-ascii?Q?dIxUiHHdVi8+rmV/1rrCgFd5TWhdpUKhajWEdkmX9KwTYW196hJwdiSWYWI5?=
 =?us-ascii?Q?X9hOYFVLAItStMCMsq58juKwSitnCGlLHZqyTFh57+J6PxAW8/58gIKgqiqr?=
 =?us-ascii?Q?D0BIQQmNC66BHu6Yo2nxZQMP/cow9BRwYrWTNIDXuw54r3gg5pDpYxuS/JOs?=
 =?us-ascii?Q?+x/usRBurzRU5ZKdE0lWzrYvPFuToVrakQqqeW8skP/Fiu1IGatsVb42s3nI?=
 =?us-ascii?Q?hkmIj8AIjVZSxIdpmrKQgrWWC5RzFy9cFzE84RGg1dV2pdx1ljB7dZaYyCQ8?=
 =?us-ascii?Q?7huBSMy+NOwLLkrUpfFNNzYV6hIUPdeH/LSfzkVbGGOb9WVRnjdpqbsjZNKN?=
 =?us-ascii?Q?vHSI2jDbfNqCjpI8AE9R6x9tMq90SlV2k1sbGmge1xo8ki5nhqquOltfBW/u?=
 =?us-ascii?Q?paUDtdFsdAp4qg0rknvzl6iPNCUO6jEhyM2mPbksPxSgN87Mkte8q0lzmOSf?=
 =?us-ascii?Q?q08Rxkxvgq0NdXaGkWwJBUSvebf2MH15uhDCJYwVzyGNXrCx+6spdCPCAnBD?=
 =?us-ascii?Q?W+aKfQf++WRqvnIQAwTNsmGc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a5bac1-a918-4c54-6c26-08d99205648a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2021 07:03:30.7288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UdQxzMeUdrn2TJyjwLvpidrItY/C6zzbTrST61yu17X6WqziBrgWONbi5jlI+k8ODOlBHgR2mu8h7Pwwlwa6J7nh+cjNbb1FUBUnJni1ztQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3913
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thank Thomas for your review, please see my responses/comments inline.

> > 'ostm_init_clksrc', 'ftm_clockevent_init', 'ftm_clocksource_init',
> > 'kona_timer_init', 'mtk_gpt_init', 'samsung_clockevent_init',
> > 'samsung_clocksource_init', 'sysctr_timer_init', 'mxs_timer_init',
> > 'sun4i_timer_init', 'at91sam926x_pit_dt_init', 'owl_timer_init',
> > 'sun5i_setup_clockevent',
> > 'mt7621_clk_init',
> > 'samsung_clk_register_mux', 'samsung_clk_register_gate',
> > 'samsung_clk_register_fixed_rate', 'clk_boston_setup',
> > 'gemini_cc_init', 'aspeed_ast2400_cc', 'aspeed_ast2500_cc',
> > 'sun6i_rtc_clk_init', 'phy_init', 'ingenic_ost_register_clock',
> > 'meson6_timer_init', 'atcpit100_timer_init',
> > 'npcm7xx_clocksource_init', 'clksrc_dbx500_prcmu_init',
> > 'rcar_sysc_pd_setup', 'r8a779a0_sysc_pd_setup', 'renesas_soc_init',
> > 'rcar_rst_init', 'rmobile_setup_pm_domain', 'mcp_write_pairing_set',
> > 'a72_b53_rac_enable_all', 'mcp_a72_b53_set',
> > 'brcmstb_soc_device_early_init', 'imx8mq_soc_revision',
> > 'imx8mm_soc_uid', 'imx8mm_soc_revision', 'qe_init',
> > 'exynos5x_clk_init', 'exynos5250_clk_init', 'exynos4_get_xom',
> > 'create_one_cmux', 'create_one_pll', 'p2041_init_periph',
> > 'p4080_init_periph', 'p5020_init_periph', 'p5040_init_periph',
> > 'r9a06g032_clocks_probe', 'r8a73a4_cpg_clocks_init',
> > 'sh73a0_cpg_clocks_init', 'cpg_div6_register',
> > 'r8a7740_cpg_clocks_init', 'cpg_mssr_register_mod_clk',
> > 'cpg_mssr_register_core_clk', 'rcar_gen3_cpg_clk_register',
> > 'cpg_sd_clk_register', 'r7s9210_update_clk_table',
> > 'rz_cpg_read_mode_pins', 'rz_cpg_clocks_init',
> > 'rcar_r8a779a0_cpg_clk_register', 'rcar_gen2_cpg_clk_register',
> > 'sun8i_a33_ccu_setup', 'sun8i_a23_ccu_setup', 'sun5i_ccu_init',
> > 'suniv_f1c100s_ccu_setup', 'sun6i_a31_ccu_setup',
> > 'sun8i_v3_v3s_ccu_init', 'sun50i_h616_ccu_setup',
> > 'sunxi_h3_h5_ccu_init', 'sun4i_ccu_init', 'kona_ccu_init',
> > 'ns2_genpll_scr_clk_init', 'ns2_genpll_sw_clk_init',
> > 'ns2_lcpll_ddr_clk_init', 'ns2_lcpll_ports_clk_init',
> > 'nsp_genpll_clk_init', 'nsp_lcpll0_clk_init',
> > 'cygnus_genpll_clk_init', 'cygnus_lcpll0_clk_init',
> > 'cygnus_mipipll_clk_init', 'cygnus_audiopll_clk_init',
> > 'of_fixed_mmio_clk_setup',
> > 'arm_v7s_do_selftests', 'arm_lpae_run_tests', 'init_iommu_one',
>=20
> ARM based drivers are initialized on x86 in which way?

As I already explained to Michael the reason why ARM code is included
into this list is the fact that that smatch cross function database contain=
s
all code paths, so when querying up for the possible ones you get everythin=
g.
I will filter this list to x86 and provide results since this seems to be i=
mportant.
The reason why I don't see this as important is that the threat model we ar=
e
trying to protect against here (malicious VMM/host) is not TDX specific and=
=20
I see no reason why in some near or further future ARM arch would also have
a confidential cloud computing solution and they would need to do exactly t=
he
same thing.=20

>=20
> > 'hv_init_tsc_clocksource', 'hv_init_clocksource',
>=20
> HyperV. See XEN
>=20
> > 'skx_init',
> > 'i10nm_init', 'sbridge_init', 'i82975x_init', 'i3000_init',
> > 'x38_init', 'ie31200_init', 'i3200_init', 'amd64_edac_init',
> > 'pnd2_init', 'edac_init', 'adummy_init',
>=20
> EDAC has already hypervisor checks
>=20
> > 'init_acpi_pm_clocksource',
>=20
> Requires ACPI table entry or command line override
>=20
> > 'intel_rng_mod_init',
>=20
> Has an old style PCI table which is searched via pci_get_device(). Could
> do with a cleanup which converts it to proper PCI probing.
>=20
> <SNIP>
>=20
> So I stop here, because it would be way simpler to have the file names
> but so far I could identify all of it from the top of my head.
>=20
> So what are you trying to tell me? That you found tons of ioremaps in
> __init functions which are completely irrelevant.
>=20
> Please stop making arguments based on completely nonsensical data. It
> took me less than 5 minutes to eliminate more than 50% of that list and
> I'm pretty sure that I could have eliminated the bulk of the rest as
> well.
>=20
> The fact that a large part of this is ARM only, the fact that nobody
> bothered to look at how e.g. IOMMU detection works and whether those
> ioremaps actually can't be reached is hillarious.
>=20
> So of these 400 instances are at least 30% ARM specific and those
> cannot be reached on ARM nilly willy either because they are either
> device tree or ACPI enumerated.
>=20
> Claiming that it is soo much work to analyze 400 at least to the point:

Please bear in mind that the 400 function list is not complete by any means=
.
Many drivers define driver-specific wrappers for low-level IO and then use
these wrappers through their code. For the drivers we have audited (like vi=
rtIO)
we have manually read the code of each driver, identified these wrapper=20
functions (like virtio_cread*) and then added them into the static analyzer
to track the all the invocations of these functions. How do you propose to
repeat this exercise for all the Linux kernel driver/module codebase?

>=20
>   - whether they are relevant for x86 and therefore potentially TDX at
>     all
>=20
>   - whether they have some form of enumeration or detection which makes
>     the ioremaps unreachable when the trusted BIOS is implemented
>     correctly
>=20
> Ijust can laugh at that, really:
>=20
>   Two of my engineers have done an inventory of hundreds of cpu hotplug
>   notifier instances in a couple of days some years ago. Ditto for a
>   couple of hundred seqcount and a couple of hundred tasklet usage
>   sites.
>=20
> Sure, but it makes more security handwaving and a nice presentation to
> tell people how much unsecure code there is based on half thought out
> static analysis. To do a proper static analysis of this, you really
> have to do a proper brain based analysis first of:
>=20
>   1) Which code is relevant for x86
>=20
>   2) What are the mechanisms which are used across the X86 relevant
>      driver space to make these ioremap/MSR accesses actually reachable.
>=20
> And of course this will not be complete, but this eliminates the vast
> majority of your list. And looking at the remaining ones is not rocket
> science either.
>=20
> I can't take that serious at all. Come back when you have a properly
> compiled list of drivers which:
>=20
>   1) Can even be built for X86
>=20
>   2) Do ioremap/MSR based poking unconditionally.
>=20
>   3) Cannot be easily guarded off at the subsystem level

I see two main problems with this approach (in addition to the above fact t=
hat
we need to spend *a lot of time* building the complete list of such functio=
ns first):

1. It is very error prone since it would involve a lot of manual code
audit done by humans. And here each mistake is a potential new CVE for the =
kernel
in the scope of confidential computing threat model.=20

2. It would require a lot of expertise from people who would want to run
a secure protected guest kernel to make sure that their particular setup is=
 secure.
Essentially they would need to completely repeat the hardening exercise fro=
m scratch
and verify all the involved code paths to make sure for their build, certai=
n code is=20
indeed disabled, guarded at the subsystem level, not reachable because of c=
upid bits, etc. etc.
Not everyone has resources to do such an analysis (I would say little do), =
so we will end up
with a lot of unsecure production kernels, because time to market pressure =
would win over the
security if doing it means so much work.=20

Speaking in security terms what you propose is to start from day one analyz=
ing the whole
existing and waste attack surface, fix all the security issues in it manual=
ly one by one and then
somewhere in 20 years from now be done with it (or maybe never because ther=
e is always
new code coming in, and some would introduce new problems).

What we are proposing is first to try to minimize the attack surface as muc=
h as possible with a simple
and well understood set of controls and then spend realistic amount of time=
 securing this minimized
surface. Again, this is not TDX specific attack surface, but generic to any=
 guest kernel that wants to be
secure under confidential cloud computing threat model. So, it is not us wh=
o is pushing smth into the
kernel for the sake of TDX, but we seems to be the first ones so far who ca=
res about the whole picture
and not just to provide HW means to run a protected guest. And given that m=
ost of the drivers
have never been written with this confidential cloud computing  threat mode=
l in mind, it is going to
take time to fix all of them. This really should be a community effort and =
a long-running task.
Take a look on this paper for example: https://arxiv.org/pdf/2109.10660.pdf=
 They have tried to
fuzz just small set of 22 drivers from this attack surface and found 50 sec=
urity relevant bugs.
And fuzzing is of course no ultimate security testing technique. So, I don'=
t see how without the
drastically reducing the scope of security hardening first we can end up wi=
th a secure setup.
And then as the time goes and more people looking into this attack surface,=
 we can (hopefully)
gradually open it up.=20

Best Regards,
Elena.

