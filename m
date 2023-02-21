Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DFE69E8DE
	for <lists+linux-arch@lfdr.de>; Tue, 21 Feb 2023 21:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjBUUIp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Feb 2023 15:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjBUUIo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Feb 2023 15:08:44 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E194B2940E;
        Tue, 21 Feb 2023 12:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677010123; x=1708546123;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QVTFmqLH05ZzTfjOWEI7R+sJ7obm+2qudA/OLKAY6p0=;
  b=HZNrd3oFBcJ4hIlFBiul3H44uvhC9aGpYs+n2NQHPQ7OsvGrIp2uKkf2
   UhjmXlpiwlUOPXuMIk6jVRsym3tUTk9qhiVBg8wL8war340JkDEeDQ8c/
   o8G1LF3sQQ16exnlvNbyp1Mk8EughcIAzBYXVXmma4PqLvmpP/bPY6BTt
   XAN/3ddR3M9+EjRcQnXs34eexvPDYf2/ZqVDkk56VFrkzz87aqYdfBM/i
   4XJKAFxXOxobNJaGDPMKpSG+1VHt6/IJl0U/vlkQY8PN5+7nlzXmGzuOn
   iJq5Mq5xHHX3ukuCYlfFG1daC820JrX03xPF8/16Oim4K/UC6GmhK7Irj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="313114898"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="313114898"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 12:08:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="845838082"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="845838082"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 21 Feb 2023 12:08:34 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 12:08:34 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 12:08:33 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 21 Feb 2023 12:08:33 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 21 Feb 2023 12:08:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hk5Cc9K+j1ZhD/PczQ/OkkqkXZrfxy7P59e0GwfKjbZIyfEj2xkju2UJVHAeXU5J5P81b09h8COiCJ52AkDc+7OA6ZK69Ggzh2CBT4U9k4TfjhkhWBMS3T1HNaWvvB3uwAKIBiSGxvu92EUSQX0dLykmYmTEqAA6V6bHoqj6sZri25ghQufYLt4URbO+1G5tziiGNLyarr/qkpwUaAZSv8gt3b4kHEGfQdx4v88wgUjEhLBpcsO0zkdfzxn/kNt9Mtgs4x2Nho2Y4tsrAwvjlcf81TraYtDxD3aGHvEExMTgQSCewphGetwTQeBsNtpQLtRfNRpzludIxIRrkTWp8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVTFmqLH05ZzTfjOWEI7R+sJ7obm+2qudA/OLKAY6p0=;
 b=C6aGrQKMuBKW5FOgEqOKdQqQaG+NZrnLF3GjRUclKb06t7wVoK5GNTWuivprWsxuitkLeqAAueCU9Z1DoJ9q+M+vwW+Tdse16CPdAX+Gmbi02A9s2spWmbjQ15bgYkZ17PjscGPtx/MSVE72rf7UFHL6phWpvJ1iuUocT5GIdM2L2wlrf1OOhXveei6fheuSZ6H/yUTpu5CkTHrRTnOzW/hprcoVoq6b8xZwMIIR6LUublmiRvk89FONvkheJR5casgHGxo5KpDkLWdcuUgYUUf6pKrxFqaGEfPxz2dCbvqakiKVVed6JwTC9bJLQxTTErN74NZ/hhvt41hbUcAyDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 20:08:25 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 20:08:25 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v6 14/41] x86/mm: Introduce _PAGE_SAVED_DIRTY
Thread-Topic: [PATCH v6 14/41] x86/mm: Introduce _PAGE_SAVED_DIRTY
Thread-Index: AQHZQ95AseCELEMbPEKUKa6WOvZcWa7XtimAgACpbgCAALhnAIAAwMWA
Date:   Tue, 21 Feb 2023 20:08:24 +0000
Message-ID: <982781d9cde9173a95939b0216351ec9d97014bb.camel@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
         <20230218211433.26859-15-rick.p.edgecombe@intel.com>
         <70681787-0d33-a9ed-7f2a-747be1490932@redhat.com>
         <6f19d7c7ad9f61fa8f6c9bd09d24524dbe17463f.camel@intel.com>
         <6e1201f5-da25-6040-8230-c84856221838@redhat.com>
In-Reply-To: <6e1201f5-da25-6040-8230-c84856221838@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|CO1PR11MB4835:EE_
x-ms-office365-filtering-correlation-id: fc33bce1-49e7-4f3b-5893-08db1447636b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XRvWyQL8HvNhFLid1/7p6s1gMvvBAAuTOKc2C/BNEnW+Awu7tK2TjB72iw6J0xJjTONmVW/aLSjmEfYwxZgPcIyBDmulUEZER5IRtrU5LqvQOr4YVrcgRNi8WMRwpTiJpOV/no3yrsoi9KGrgAFWusTky43MaWh4kfdeLxneUq0BcvtX6xHSdSFob1iWyJBOpSAQVI2vx2AAjmjCpvmBfTju1PooTm8+rSxahEzWMCN/QgB9OY+v+4D/oQH/MHI3Z4J4EWWuT+v0s4/7gCRIRFHf7muyQPqqG1vV4yhJj5X55dMNKoAEMLBBk+1H2SW8LYvxC6ca1Hx561sJdwQd5u/aEGO6chu6jHL4vVXvA0vxhlm61giIQB4/6ru4FPGWwTEUzaColfhWw6aMxgmjceXdK9OtNWzOk8ruEaNvC4nc8g/qMNLGRmelMMG+BTTFn+BIqH+v37JCWxR9Cx2C0GMWZTncmSaapovF72BVxw+rd5nYDRtye+xoW5FjDsCDSZ5ZCLYbddnUzqcphUNE7cMyKWOoAjma5G++n1vBRAYp00DKucjg3yftmiLbv8ioPHnwbl2hDbi4T8BxOCEeiMJHTQyDql2UDKukjmhXMB7/VoedKKai87K2KE6r5ZbksumSQ0pugJppfpqinp3Z/ahwjBjYEB3x1qJrxGDQe5NkmI1JxelQ+B5XFvMxAX/0WWmB5L0f874wZ7y7uqu0MgQsDBYyBIgwdxT6U0AP+mO4wh0J5yTT+Q5AD265O4OLVwQdq8qLK93ixtBuzki9Cg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199018)(38100700002)(122000001)(82960400001)(921005)(38070700005)(36756003)(86362001)(8936002)(2906002)(5660300002)(41300700001)(4744005)(7406005)(7416002)(316002)(186003)(26005)(6512007)(6506007)(2616005)(4326008)(91956017)(76116006)(66446008)(66946007)(66556008)(66476007)(478600001)(71200400001)(6486002)(8676002)(110136005)(64756008)(99106002)(14143004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3NPTzRpcWgxWk5SVlRRZWs2bVM4TThIb01ESmc0WGtPeUQ0ZEQ4YTViTWJI?=
 =?utf-8?B?Z2xyaC9IRkVNN01pNTM3WUxuRXprYzkrZHZMek1oVVZCN0JidXAwRWlLL0Fo?=
 =?utf-8?B?OVJYazhJZlhoTmtnai9Tam9rUi82eVlpRm9PT0JYVjh0RnVBUVhESFBzbXp6?=
 =?utf-8?B?V2NPazFiMy92Rnd1b2wyaFVKNERCSzNLV1hyWXUvb1lYeGEwTXJ1aC9OZy9T?=
 =?utf-8?B?bklpYlpXU1ZsemhuaWhpeFh5enlXcDArSnZXNldGNzlvNEdPOVA1RjlpOG4r?=
 =?utf-8?B?eFErOERQVHZDQnNCOFpRSFNQUnVpNGhxb1pWQXgwcVVqSFFzck1hMEY0VFNV?=
 =?utf-8?B?NmZ5VUhzL2pxUXZjSEdER2tLZ0psaU5YZkN6OGNHYlhVa2R2eFBGSmtPWjR1?=
 =?utf-8?B?M0RkaHhvTXoxWlVzMHV4Q0lBdDRFdVY5RmhaVHdDSkhmVWlZUGdqMDJERFo2?=
 =?utf-8?B?VlBiOE1uZndlWGNtenlXb3dCT2JJaXJHQmdVYlVzTWFHa1JJdE9GOHo4cW1Z?=
 =?utf-8?B?ZkZMN2dPdWpBMVllWGhiMm9rVlhFQWtXdTRyZ2NiZUVGNHNZTktDQlJsV3hO?=
 =?utf-8?B?ZEo0UUdxQWo0S1M3TGlIY2YwQ2RXcERqL2hTczh1NDcrYVUrY1Y0YmxUbW5V?=
 =?utf-8?B?TTJTenp1RVRmRGZWTks1cjFxWVpRazJLL0k4QUlPMmFkWUs1VitSUFU2OE5n?=
 =?utf-8?B?RVZacU9hYU1iK2lNdW8yajJLL3EyZDZNVm02VjdiNWhhZ1luUXVSelZ2WGY2?=
 =?utf-8?B?T2FWSEx4QkkzeXY2aEZIczJZTkd1NDNrOHF1WlNiKzVSV0k2NzFqczJZODgv?=
 =?utf-8?B?aVN5SUVJNjlqSStLSnEzTnBDb3Q2ZnNBV0N4TFBBTUtFamtMRkRZWm1Md21y?=
 =?utf-8?B?dTYwL3kyVzVZWGZxUXd5dUpzTVBKVzZRdnI1a3Rac09PL3U4ZGJtcmo1TDBT?=
 =?utf-8?B?SkNDVjlyV1lRY2F5SjZOL09aM3BPWmRvYmpTMHJkUVdCMTlGSFFsdFBmaGcx?=
 =?utf-8?B?dlV2WWZYdHVTSjRucnI3VmNZQXJuayswWHdyUTlxeGpxUDVvV3J2VE02VjRw?=
 =?utf-8?B?dWtGM0ZHQnVBbE45RFZVOEJ0MjJjTXFYelNXQlpHS0JEemkyZFhrUHY0dDZk?=
 =?utf-8?B?STRlV2xOYlg4QzNjRW03cU9iR0NKcWhwTWJtMEIydlJWZnpaRjR3L1Vjb0tS?=
 =?utf-8?B?NTFBYjBsUnJzVGJVWVdGYVRZdmhOT3ZKWVE3VzE4dGZRWE1yR0VpbHV1NnZB?=
 =?utf-8?B?bUNRYm9BWmlqTUtZb1hEZFVlSGtpZEFETFZIL3NJZmN3d2t2amZRM0JjaVR6?=
 =?utf-8?B?eXBWTS9UaHJ1L2ViVVZTTFdDdU85aS8yMFgrOEJTOGZRVzRuWFhmUk8zL2gr?=
 =?utf-8?B?R3cyK3pnTWRmcUdUd3hQZW1hNGhHWE1qNFZMUUlMNWJvT0pZanZMUnBCWXBZ?=
 =?utf-8?B?eUxmRHV5emcvNVFqbFZHL1hJSkF5OEw1dE9hWWR1U0FGQjRxb0JaOWdDL3F6?=
 =?utf-8?B?SFg5dTdlY1pPRjY3Tmw5QVBKQXNQVlFwdkMwZ0U0K2I1TXVPems1Z0RCMkh3?=
 =?utf-8?B?bkpCRnJvUXE2ZVBhQTRZRkhLcnpwT2lRODRkcXNjelFYTVlzdHE4Tng0emhr?=
 =?utf-8?B?akJsZThVWm5MTmFsVUV1OFFyZ084bFdMWDdsMFpSalVnZVRrS2pTbGVnc3FW?=
 =?utf-8?B?ZWFxWEJvc045UHgrWGVXZkNrYlh6RUNFRFRoeU9kT00zMlhld0hsZ3ZTNGZD?=
 =?utf-8?B?dzhmbGUyZE5HUk9uVXB6MjBob2hvQkxvV1o3d0RTZWl3QjJteUxnbitkN0JC?=
 =?utf-8?B?TWNZWk1ITWZ3L1g5d2lQb3Y2Y3ZFaFdNQUlWTDRYa04xMUVDWmRLY0ZpaklR?=
 =?utf-8?B?bFZKRnd6Z2xEOElFa1R0MUh0aFlCZkVHT2NyTTNyZjc5WURwdXIrekdmUGR5?=
 =?utf-8?B?bDcwc1N6enYwNzRrOFZhYXltZm5WUWRJYXdKMGlWcmdENUJDNmJROG5OdnNi?=
 =?utf-8?B?bHVhcHNGVkNKWlNmdzRYdVdMTGVNSG5Yb0tGWGEvUGNWck8xSUlNNDhNU0NP?=
 =?utf-8?B?V2xWWDRvV1JwMmI0dHZHalYycTh6cnNxMDAwZFQ5RFlpNWJ5S0tDc0N1SjB6?=
 =?utf-8?B?WEl4Uk13YUVBRDRObVhwUFBySldZNGx1RmpEV0tuT29yakZSbHRyTVlhZktX?=
 =?utf-8?Q?yonUf3hqPbYpvGxLvLb+0aE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DAB9AC5625330F468A5542A5925B3666@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc33bce1-49e7-4f3b-5893-08db1447636b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 20:08:24.5801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dHosFF1dUO37azL9lVHB+wFK0kqY6GufWbHOp4Z5cDacXqYLbS//7LGunolk5208UEuEM3AoR6ItY2FgUXSMgQEUKn7qw3ykWOvfiBRIdAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4835
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIzLTAyLTIxIGF0IDA5OjM4ICswMTAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gQWdhaW4sIEknZCBub3Qgc3BlY2lhbGl6ZSBvbiBDT1cgaW4gYWxsIHBhdGNoZXMgdG8g
bXVjaCAoSU1ITywgaXQgDQo+IGNyZWF0ZXMgbW9yZSBjb25mdXNpb24gdGhhbiBpdCBhY3R1YWxs
eSBoZWxwcyBmb3IgdW5kZXJzdGFuZGluZw0KPiB3aGF0J3MgDQo+IGhhcHBlbmluZykgYW5kIGp1
c3QgY2FsbCBpdCBhIHJlYWQtb25seSBQVEUgdGhhdCBpcyBkaXJ0eS4gU2ltcGxlIGFzIA0KPiB0
aGF0LiBBbmQgaXQncyBlYXN5IHRvIHNlZSB3aHkgdGhhdCdzIHByb2JsZW1hdGljLCBiZWNhdXNl
IHJlYWQtb25seSANCj4gUFRFcyB0aGF0IGFyZSBkaXJ0eSB3b3VsZCBiZSBpZGVudGlmaWVkIGFz
IHNoYWRvdyBzdGFjayBQVEVzLCB3aGljaA0KPiB3ZSANCj4gd2FudCB0byB3b3JrIGFyb3VuZC4N
Cj4gDQo+IEFnYWluLCBqdXN0IG15IDIgY2VudHMuIEknbSBub3QgYW4geDg2IG1haW50YWluZXIg
OykNCg0KUmlnaHQsIEkgc2VlIHRoZSBwb2ludC4gTGV0J3Mgc2VlIGlmIHRoZXkgaGF2ZSBhbnkg
b3Bpbmlvbi4gVGhlcmUgaXMgYQ0KYml0IG9mIGEgaGlzdG9yaWNhbCByZWFzb24gZm9yIHRoZSBm
b2N1cyBvbiBDT1cuIEFzIHlvdSB3ZWxsIGtub3cgdGhlDQpkaXJ0eSBiaXQgdXNlZCB0byBiZSBp
bXBvcnRhbnQgZm9yIHRoYXQgY2FzZS4gQnV0IEkgdGhpbmsgaXQncyBzdGlsbA0Kbm90IGEgdGVy
cmlibGUgZXhhbXBsZS4gSXQgY292ZXJzIHNvbWUgdHlwaWNhbCBjYXNlcywgYnV0IHllcyB3ZSBk
b24ndA0Kd2FudCB0byBtaXNsZWFkIHRoZSByZWFkZXIgdGhhdCBpdCBpcyBhIENvdyBvbmx5IHNj
ZW5hcmlvLg0K
