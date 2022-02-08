Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9A84AE3FE
	for <lists+linux-arch@lfdr.de>; Tue,  8 Feb 2022 23:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357698AbiBHWZV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Feb 2022 17:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386386AbiBHUU5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Feb 2022 15:20:57 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B1CC0613CB;
        Tue,  8 Feb 2022 12:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644351653; x=1675887653;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vWwjJPHqpo4WC1y4/aAzAVE2rzMSHZvFTwkc+cNDZAQ=;
  b=dxMXo+VYhARkSWvdO8qz8UzlmGfwWkcr4Qx1zCUrWkWJcZYjYfQuYHni
   +vjdJ3TmTNbTQFsY1H13A7BH3ivd2sFJ+uSlqEOxYSWDpSPe45JtdkEOs
   nQfx8PCt4nqtIK8PqBV8RKsXLQvar/U/IK//p5xBGIQEVExg5hjvPjssU
   L0mVY8X7QRKozndCB54b5QLN8SJIBSVdKa+FOsglu5GEw5TI+gGUBfRxf
   M4M0ZDNXB8lNPyjyIZnhpVkZvSv6efEOW4rNTAPZoMug54KhYks6E9x5U
   HpEumPpq+pxx7jO8XclfTVs6NtTuc9fSHQ7ScJZ8ZbrFLq2PfuGVE949B
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="232610857"
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="232610857"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 12:20:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="771105441"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 08 Feb 2022 12:20:51 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 8 Feb 2022 12:20:50 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 8 Feb 2022 12:20:50 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 8 Feb 2022 12:20:50 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 8 Feb 2022 12:20:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuBGGk7B/XrP6HzA+zcaK7NVVtZ9dKwvDPI61gmQuQ6/onxdAIFkEBjeo9P5+uwcWbMXdyE9iHbY6qNHBTsTkTruPZuw6QDjzten1kAOzFu2IxsnFPB7/bzZRm8+FbPJbg+s9Ow1R5QpyuKCHLc2rqXUXhhGC4+1mWnXwUbhLlAU7ErZG47t8stfZY+e1Le94JAWN5zZvVqtR08T9FjMkUfZKUMbpZdO5Rpfx+i5/23YUFQpGp6YDjgUfavSK0vmvK57/k1GdDWC+r9wj4FXA30H8pH7Rf/rC6cIhgSLAZYQvM4t/NryWO5NpoCLp36cdY5Hh89GScDeXVEw8lp7Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWwjJPHqpo4WC1y4/aAzAVE2rzMSHZvFTwkc+cNDZAQ=;
 b=ew6XFmO/HoTNaSoEws9Rm8S1cKAqO6Zr99Gkg6IIe/D/zOMoDUIsHK4c9RbaglQay8I57GEFKnm1XmXHSYTK1qAjLIdbD/9Uosib/wlGwi5dhEOwCsaz915sw19nS/GOQZsDbV87Ngo1zvlzjVEXXz8GakmiZweijEXDK3xKsbOARKfoymOMTb/H1MkUXYUJDEV/eQkGN2vk86lFK0SFg+FuRBdTNfG5tmmln9jjxnRXu+HxzkMC2xOHtp4uA/mLpha6cjAazAX5+UJUOCLbbKw2HvDylNanRDhg47hBkTmsyik53asqSBIAnv3pXf21Bp3WDJ8/SqtkJXpDH2EItQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BL0PR11MB3058.namprd11.prod.outlook.com (2603:10b6:208:7b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 20:20:47 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 20:20:46 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: Re: [PATCH 02/35] x86/cet/shstk: Add Kconfig option for Shadow Stack
Thread-Topic: [PATCH 02/35] x86/cet/shstk: Add Kconfig option for Shadow Stack
Thread-Index: AQHYFh9oqWuEZjX+PEO8VnQiZDqsKKyIuwSAgACn9gCAAMN6AA==
Date:   Tue, 8 Feb 2022 20:20:46 +0000
Message-ID: <89283631b471b3f77c5ccca682e45f35484975c2.camel@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
         <20220130211838.8382-3-rick.p.edgecombe@intel.com>
         <248ef880-025d-54ce-f3ce-fed0e50a0445@intel.com> <87sfstvjh9.ffs@tglx>
In-Reply-To: <87sfstvjh9.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2827d407-b814-4827-4196-08d9eb407dbd
x-ms-traffictypediagnostic: BL0PR11MB3058:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BL0PR11MB305800E4C601929DFBCF5E9BC92D9@BL0PR11MB3058.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cfugNZG2PoBkjHSCd4CwjOeeBTzoWSSa11AChK9nBL2fY2HV1vDXjr3A/LawaHX2Z8l/H/F1VjmwkDLPRflnzEkwbB2KLyuk6m4FeLpMbsdHREyhSa8uLcgZfiewMflEbuCPLDnTu66j9kwH6P/NoFJ5RJ/XSy+0QsyMIlVTHZlZKe3lnmqdtNwJAP5FMQ5qvCZtAqJZTnehV9RgBCJOIrC5N/SjU52AbW8luc2s5R/s3AFH/7mjN56B03THfdUETE9TykdOrud9crIsaFhvCm+28beboh4kvC040O7rdjUZUKKA3CErH2TWtoyoGcurL8wmExOevcz/J0NV94Cnp0ews5z1Z4l+GMjqarlqN3a0tZGO87stjfweW8bwReoMeWlASIBgWrd3hNh1kSjX+zjW63WTw6Zy+HE/BcQZrVXiMa9cKUyR9hYqKvqUAFJ0rsf0VnfiX51fkJRMqkrCKtta/gEXw2t0QcbrWNDafG3+Ji0dQcEDpiMqKuwwLHNUTYxJO0ihfMfNbH2nghUXPLpKJWVnkpb9h/YD/C8K+7unckSAUbrBXrxlWe6UZ1GaMfjUXe7gYGr156TmdfMuNfMRCyiamDgrGOUl5jLMK5RhVIAQq081NYVEtppgChmGE3VE8fN8sFfwbWXtshpFzDv5hJn6hLV6FhRRsJFSd32ZzaBy0l8bAHZIbAd/Hr0kizlg68V/rw7CtmaZ72SJx9noFawdOcAPMtbhsH7KnIdhPSvl/xKnIM3T/u79jRVG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(82960400001)(66446008)(66946007)(921005)(71200400001)(26005)(76116006)(83380400001)(6486002)(186003)(5660300002)(66476007)(66556008)(38070700005)(64756008)(38100700002)(8676002)(8936002)(2906002)(6506007)(36756003)(508600001)(7416002)(86362001)(316002)(122000001)(4326008)(110136005)(2616005)(6512007)(53546011)(7406005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1ZBNlpkT1RZaVFDSStQZ2JNT01TaGl6dnBpdXNVb0YzdHhtY1dYRElDTm1R?=
 =?utf-8?B?bXJ2MHpXdmV0anhkWnhQbUo1eFBVUUlBQXZQU0JSS0FBQzRyeHF0L0ZRQi9S?=
 =?utf-8?B?YkNINWRlVzkxdlpMZitrZFQwTW9WRVBkcW1RSnh0cWlHZ3FmOG8vcnFUVHZw?=
 =?utf-8?B?WHQ5cFV2UDlkQ2dsamFQR1o0VlE2QVRoYjdNemhYS1dmczJKRmF2MkNjTGw1?=
 =?utf-8?B?WnBmRVJ2RjZjbGJGenRvVlloMUdEY3hLMWpWVWJSSDNCRU1EVzlCZlN2VlRt?=
 =?utf-8?B?YnRtdkdVNHMxR2VmQW9NS21abFRoaGcxS3VNK3VXWGZwbjVSWEZJRE9XVWFY?=
 =?utf-8?B?THlkd3JXUytzQk9pK2FxNGJCWHNaTUZaRzJXUGRSN1M5OXVET1BRRFp3NGUz?=
 =?utf-8?B?S05lYlBrZG1objFZQVpXVmJBaVU4U3FKNVJlNERZRlZXV3lWVEZwSW9WNyt5?=
 =?utf-8?B?SUlqeU1WVkRzVGhiRVlxZGR6TmtpcEcxazM2YXk3NFRsaDJsSCt4WnkrekJi?=
 =?utf-8?B?bGhQVmF2NEppSkUzM2xQVmd1UFVtNDE1M294NEd5ZXA5WElzWGk4TU1TWHEx?=
 =?utf-8?B?K2ZLeXJrbDI1L2g0UXhBODlZTzhJUGhRYzEvendSL0tGVnkrOThaUzVkY0dv?=
 =?utf-8?B?NEU2aVhjSEEwOGw3NnNZZ2p3Uk9tR2h4L25HYjlsRnlzS1dMWWQyVEZDUnZs?=
 =?utf-8?B?bC9PaUdMOUhHcnhaUy8zakd4bEZsWEgyU2xlQ3NlTTNhdEhJbVdObW84am5i?=
 =?utf-8?B?dDdiU1pwSlZvNi96TmJiek5ZMGhadW1ZL3A4NFR1YWxJa0F4TmNuN2RhN2V4?=
 =?utf-8?B?dGorSUszTHl1dVJranJEOHRXNTVpdkhUajU2YmhnUFpySU5oMXVWQytaRkdX?=
 =?utf-8?B?NVN1YXpmNGZTQXFETFRKRDh4djlHTEJxWjM4V1lycVQ3Y056aUxhSkpuZWk3?=
 =?utf-8?B?NzJ6aCt1eTFYSlJOM20wdUFjbFZ3UnNDMFlMOStIcnBiMUFCQS9BdXRvV0d5?=
 =?utf-8?B?S3I1Nm1jbEVqellra1NhZXZyeVVIWVZ3U2o4RXA4aytQQXhVdmd4aFdVTUIz?=
 =?utf-8?B?bXFuMVJqbHFvTzc2d1FKZkN5dk92dXo3aVVDYk02aHRmRlMvbk96RXhpU01D?=
 =?utf-8?B?MkpSdW5kVlZQdDNtLzZrUm9SUkp5eHBEOW9MNFQzT1ZlbHo3azNhYk5NeUhY?=
 =?utf-8?B?V2Z6ME4rRE8ycGZmdGtQT2JIU1pGNW82dHNWMHpaSlk1N0NkSjNlY2xONm5s?=
 =?utf-8?B?bkdkL2hTRVZFNmVDbUNiQUZ1cEJyRjlZRjRnN3JBZEJSL0sxUldES1ZvTlRq?=
 =?utf-8?B?dC9KZmlwUVVSQUhJVU9CNXJwcUs1L2w5OEYxSXE2WEZhOU92Nk85dlk0d1dB?=
 =?utf-8?B?NGZ0Q0FRallhTU16VlMzSHpObExLNlhrZzZEaExZRmtmSVZhS0hXR0ZDSmVu?=
 =?utf-8?B?R3ZwWjl5UllJMndncFNNWHpndVc0d1Q4bjBsYWVZWENPMFhWN3FaQ3ZOS1pS?=
 =?utf-8?B?Y1dYWDJDMHFqTDJUQ1BsZUI0Zmk3NEdVelkydnVNRjhqK04wRXJvdDNnK0NJ?=
 =?utf-8?B?M1BRaEg2clJlUlBIZzYyTSsxV0FTRTdqdVBCVHppNnlKTkNna1ZOL2l3UW8r?=
 =?utf-8?B?RlBkclJuK1NGN2xsSFBobld3ZHJhVUxKVk5yQ1FJWjJKMUN4bGF1RDBGSzhH?=
 =?utf-8?B?ODYzYUdYUzdYVkx6UjNlN045bVdtUkFNdjdud3NXcEh3cjNKTi85ZW1DdmN5?=
 =?utf-8?B?VnlHdWNJMmlXbitBQWJKOEpqVzQ2WjQzYUVEUEIycXRENng2OTFHN21UNmU2?=
 =?utf-8?B?dGF1dVkzaVp4K2E2V1Vpc3RORVUzeE5ValRsOXNLcTFiSWFmN1VTTHdxYzNV?=
 =?utf-8?B?Yy9jTDd1SWZCV3dHYWF6YzROK2QvU25Dazd1eTFSNHEvWHVnOGdBbkVxL3dM?=
 =?utf-8?B?VU1PdTRoWjBmV2pzUGlpM3pCYjBralZzSmxhUSt6L0hSSjY3cnRzdFg4cG5T?=
 =?utf-8?B?TU9NamI0cDVwT0IvOVAyWEVvdHRKelBFOFZDL2FSc2t4a1MrZUxZMUlRY2pJ?=
 =?utf-8?B?M3VZTmp0ZngxbWtQSW4zaWwrMndpYUFUQjVjZmo5UTQ1Q1NaV2pBKzBxUTB4?=
 =?utf-8?B?Ylo0SU43ckhkRnFFQktrMXErRlR4dGdWOUI5MGxFdGdQd010aWlwMDhDeml1?=
 =?utf-8?B?Q1Q3OVdaek5YRGFuSk90bktHSEQ3dEcwT2hhSzZYWjR5emxRbit2ZmZRYTBU?=
 =?utf-8?Q?ZF1fCoUHL3pwDf/VQc/IldqebQJhw9Yx/ehPN6Lx9Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BC4108BE759E24A8879219E7B4BD0CF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2827d407-b814-4827-4196-08d9eb407dbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 20:20:46.0718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LbdapZQir3L3tTtPKW0XVK0jvWUSD7Q+tv4E0emNJLnu8G4dxTpUi0YRI4JujK5s5DY7ifxNWJboG85wdzHqt47Qkb17nLJxgVEuFKaaYYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3058
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIyLTAyLTA4IGF0IDA5OjQxICswMTAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IE9uIE1vbiwgRmViIDA3IDIwMjIgYXQgMTQ6MzksIERhdmUgSGFuc2VuIHdyb3RlOg0KPiAN
Cj4gPiBPbiAxLzMwLzIyIDEzOjE4LCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToNCj4gPiA+ICtjb25m
aWcgWDg2X1NIQURPV19TVEFDSw0KPiA+ID4gKyAgICBwcm9tcHQgIkludGVsIFNoYWRvdyBTdGFj
ayINCj4gPiA+ICsgICAgZGVmX2Jvb2wgbg0KPiA+ID4gKyAgICBkZXBlbmRzIG9uIEFTX1dSVVNT
DQo+ID4gPiArICAgIGRlcGVuZHMgb24gQVJDSF9IQVNfU0hBRE9XX1NUQUNLDQo+ID4gPiArICAg
IHNlbGVjdCBBUkNIX1VTRVNfSElHSF9WTUFfRkxBR1MNCj4gPiA+ICsgICAgaGVscA0KPiA+ID4g
KyAgICAgIFNoYWRvdyBTdGFjayBwcm90ZWN0aW9uIGlzIGEgaGFyZHdhcmUgZmVhdHVyZSB0aGF0
IGRldGVjdHMNCj4gPiA+IGZ1bmN0aW9uDQo+ID4gPiArICAgICAgcmV0dXJuIGFkZHJlc3MgY29y
cnVwdGlvbi4gIFRoaXMgaGVscHMgbWl0aWdhdGUgUk9QDQo+ID4gPiBhdHRhY2tzLg0KPiA+ID4g
KyAgICAgIEFwcGxpY2F0aW9ucyBtdXN0IGJlIGVuYWJsZWQgdG8gdXNlIGl0LCBhbmQgb2xkIHVz
ZXJzcGFjZQ0KPiA+ID4gZG9lcyBub3QNCj4gPiA+ICsgICAgICBnZXQgcHJvdGVjdGlvbiAiZm9y
IGZyZWUiLg0KPiA+ID4gKyAgICAgIFN1cHBvcnQgZm9yIHRoaXMgZmVhdHVyZSBpcyBwcmVzZW50
IG9uIFRpZ2VyIExha2UgZmFtaWx5DQo+ID4gPiBvZg0KPiA+ID4gKyAgICAgIHByb2Nlc3NvcnMg
cmVsZWFzZWQgaW4gMjAyMCBvciBsYXRlci4gIEVuYWJsaW5nIHRoaXMNCj4gPiA+IGZlYXR1cmUN
Cj4gPiA+ICsgICAgICBpbmNyZWFzZXMga2VybmVsIHRleHQgc2l6ZSBieSAzLjcgS0IuDQo+ID4g
DQo+ID4gSSBndWVzcyB0aGUgIjIwMjAiIGNvbW1lbnQgaXMgc3RpbGwgT0suICBCdXQsIGdpdmVu
IHRoYXQgaXQncyBvbg0KPiA+IEFNRCBhbmQNCj4gPiBhIGNvdWxkIG9mIG90aGVyIEludGVsIG1v
ZGVscywgbWF5YmUgd2Ugc2hvdWxkIGp1c3QgbGVhdmUgdGhpcyBhdDoNCj4gPiANCj4gPiAgICAg
ICAgQ1BVcyBzdXBwb3J0aW5nIHNoYWRvdyBzdGFja3Mgd2VyZSBmaXJzdCByZWxlYXNlZCBpbiAy
MDIwLg0KPiANCj4gWWVzLg0KPiANCj4gPiBJZiB3ZSBzYXkgYW55dGhpbmcuICBXZSBtb3N0bHkg
d2FudCBmb2xrcyB0byBqdXN0IGdvIHJlYWQgdGhlDQo+ID4gZG9jdW1lbnRhdGlvbiBpZiB0aGV5
IG5lZWRzIG1vcmUgZGV0YWlscy4NCj4gDQo+IEFsc28gdGhlIGtlcm5lbCB0ZXh0IHNpemUgaW5j
cmVhc2UgYmx1cmIgaXMgcHJldHR5IHVzZWxlc3MgYXMgdGhhdCdzDQo+IGENCj4gbnVtYmVyIHdo
aWNoIGlzIHdyb25nIGZyb20gZGF5IG9uZS4NCg0KTWFrZXMgc2Vuc2UuIFRoYW5rcy4NCg==
