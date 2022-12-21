Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BE8653846
	for <lists+linux-arch@lfdr.de>; Wed, 21 Dec 2022 22:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbiLUVnD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Dec 2022 16:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiLUVm7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Dec 2022 16:42:59 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAAF9FF7;
        Wed, 21 Dec 2022 13:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671658976; x=1703194976;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TvlUnu3C6op7wG4ST++somBZ6d6xEHGhdoKUuYrzNgA=;
  b=lZd1+61z+PF6mSjWb/VsbvqMLuqVte+QcyXE45kcff0kSo+V9qx+MIFL
   TnLQlTSr9i29ey28P9R/2Jxss6uWazCHtvx2RdSkPCIHZj7fU5mbGzBnb
   UlUtvcQndnQF6moukC0T4zKiDO7F/CjkxyZp5aqY9YCxm2hskB5sv016d
   4tAY89A123/znADYZJObYWdUw2mq4YQKACnu60e8weDETs6+X1XdD/KtC
   hfcpW0sC5akvH238spn4raCX2jtP00w0G54YBqIcP8Bg4v/L31pzRzl58
   L2INLCvCSSe6gshKsrYd0PX4ukMaQuq4OS15oPby87E2mLs6kUQFQl/ld
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="317617063"
X-IronPort-AV: E=Sophos;i="5.96,263,1665471600"; 
   d="scan'208";a="317617063"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 13:42:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="714942331"
X-IronPort-AV: E=Sophos;i="5.96,263,1665471600"; 
   d="scan'208";a="714942331"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 21 Dec 2022 13:42:54 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 21 Dec 2022 13:42:54 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 21 Dec 2022 13:42:54 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 21 Dec 2022 13:42:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOahL5+WYVgR4fa0ucreSSk6+ExrLZMzPPTLPfzZcv07nmoteb2GWssplDRPAy3WRABa0+A+tlKUwI4D7/APK4Qbe9l4LOR7BdIe7zug2qoHuC0fPbPcwCU5b6iyOSvC/oqmYKfVL8mBKi5hGoPCsbHcidHJPNY5JYdPQvS6/xMEoRM5CgHTT3hPm3HdsR++tOATLPfSjzAIP1hJ3V+wErfQP8JMt1FtNyToUh2z7Yp2Xs8zYrUmHLC+HWj8zMFdGSmFu0CdP6zwiUbsVBgmldNidxqrc2VJlGpMIKRRUnL1Gx3mUIrzCUVZ3kSbQbcrxgz+DtmzdBpkARzfB75Nkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvlUnu3C6op7wG4ST++somBZ6d6xEHGhdoKUuYrzNgA=;
 b=dGSC2/7Epk4TWj8o7JAqVixuAvRsdp0MwiUG2Lvh1L50CLScyx80Ba7VYjfmUKxCJgYVEQ/xUqbhmgq0JRiQLllXktEFRKYOwmvwT3PtIWM3zFTXona0iGSwiOY0SPUGl8+929POK8Az8KCjh0sMyQLyRCDTjkxlwWFqShodWZS7kmH2tKMdqyG6pZJpVfECtyEDBaOT8nQSgSDutVR0KfLiwqT9X74tFtC90I8etCImd2DMUunVZGT2RytvDPflc/So3O6/5Cl73wl/81KEDJcXEGdxf8uuQ7770b3euoOW7hkm1yOc1f+GzCOjx5h4H8v3T8wQjTgujjBSHkbn6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MW4PR11MB7102.namprd11.prod.outlook.com (2603:10b6:303:22b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 21 Dec
 2022 21:42:50 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff%5]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 21:42:50 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "x86@kernel.org" <x86@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v4 07/39] x86: Add user control-protection fault handler
Thread-Topic: [PATCH v4 07/39] x86: Add user control-protection fault handler
Thread-Index: AQHZBq9UGJ4pSWbilUqMOVDoCgC2J653EFAAgACLOQCAAKjLAIAAuKSA
Date:   Wed, 21 Dec 2022 21:42:50 +0000
Message-ID: <0e529db5f814ef7af7b197962c752a1454510a49.camel@intel.com>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
         <20221203003606.6838-8-rick.p.edgecombe@intel.com>
         <Y6HglBhrccduDTQA@zn.tnic>
         <3aaf1b0d67492415acb9b3d06bb97e916cb7b77a.camel@intel.com>
         <Y6Li9oIl/tK96KUf@zn.tnic>
In-Reply-To: <Y6Li9oIl/tK96KUf@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MW4PR11MB7102:EE_
x-ms-office365-filtering-correlation-id: a9f12bed-1c68-443e-dd0c-08dae39c4ecf
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2D9lnY+zboBODME/SkjiEvRx8i1LP/7oOcLSMz9d9RFYB4Akb8fav2u2qcRy+lMfTRO5G7jt5ezB68hSie8GlGnfvZ0UV2XchXbP6diGFI1Azb6JvJp1iedH+tBzk3mV+X1P77kZ9zX3mfnfC4JZyAUGCNOLhfvfwa+SzZEaNRjWQ/DX1vQ/BelIx4VRy3a0D/GMd1I0074PvnkpBrYXSXfLzQwq1S/1bqgIuOfrI8We/Xe46PCZHBlFtwpe9P+/fGO4k2xICdA/mXQ+FOjRLxdjNyR0wZY4zDHu3Wo/vYFyw9P2sjIkJXtFChExvGpdLbBCLD6fkZJHkLJNXuYpmb3kgmvlfmVRTEwf6PNpnd4UIDWoH2EWsVaeAeMKB01wS57dVlGjX+/odwB5BPjM5xltOk13fLjRh5rukFCbs6rNQCEuMEgbsOKbe+8ypsn0A47oC6GHZ2k6bMKq0nBJRGIUzflFzqDxr8Zbf2qA2wwumSIzeXTCNG9WegGMhYuBOB0eTBAKO4IT4fRdGCRYs9O2IiWqK4JgswjpXa1mlYYbddnuPb3fz9zCk/n28uiWTmceM/CMMHhMavGZbkgwqJVaw8uqb/zHSZyb5iZDFZnk2YojXH87YI3Be+nJolAe4APkUc43SUqD0Z/5MCnLPCCkSOqyC3sn18SHiFoU00dZPE9CBO1svweHi/jYlJHz1IPkSKtOoWIO4MoymIzsAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199015)(64756008)(2616005)(66946007)(66446008)(4326008)(91956017)(76116006)(66476007)(8676002)(38070700005)(7416002)(2906002)(4001150100001)(316002)(5660300002)(7406005)(86362001)(54906003)(41300700001)(82960400001)(38100700002)(122000001)(6916009)(8936002)(36756003)(6512007)(83380400001)(478600001)(71200400001)(186003)(6486002)(66899015)(26005)(66556008)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enBncXZ0Rk54L0RqWHdyT1UvY29YV2VKV1JleWNkUVhKUlNZd01aWkJ0NXRL?=
 =?utf-8?B?YWVDUVphWS9uRXVSclVVWEJoUUJtaE5TWWhKNnMwMTFWSHJqdDlJcW92MUE3?=
 =?utf-8?B?ZzJDWUlIRW4yb1EreXppZnBPR0RTVUUzT1NidDFzeGt6VHg5KzdVbkNRV0I4?=
 =?utf-8?B?YUhhMHNCT1NTdHI5TktqV2krV3NSbEFmN1h4WUMyRXBzU2U4SGdNbnc1cU8v?=
 =?utf-8?B?M1g3WnhsMUlmWDFSR25jNDhoeGE1NFpzUUJXRklISXJTSUVSSDlkK3hLOHkr?=
 =?utf-8?B?NUVQU254TFo4QVpBL3FFWVBFVkt6aGdiWFI1Z21Lakdka3V6WWxmckZOSHZ5?=
 =?utf-8?B?UHNNdlIrZjFENUdrV2cyT2pjSlpidlZJTk42aHY0UGQ5ZlVKT3laaDlsVkR3?=
 =?utf-8?B?a3pISVp0czdWbDRoSVJOYVlDTXkrWnRYKys1dE5tQlEva01vc1pVSWJ3VjdB?=
 =?utf-8?B?MGh0aG5lcmUyM2g0UkVCSU5BamFlcU5LOS9OSkJCUlNReDY2MTBYMEdMM1h3?=
 =?utf-8?B?NWM3QVRHZ1llUXVYWHNucnpGKzd4QXZsdkJNT0crd05pREdwNWRXalRZUUpk?=
 =?utf-8?B?WUM5RE11cE5qa2h2MUU4eU4zWlRrb1JvMWVrRUUyV1V1aS9qRDk3VVA0MDR0?=
 =?utf-8?B?NEJiSmYxcmphdGhIWkpISG4veWgwd2ZlMVNGWmh3R1hKdE1aUGUrcjRVbjE1?=
 =?utf-8?B?dkJkNzA2VmJuSC95TDNsejd6eUxFVVFpS1c0aTJEQ3YyQVpXb3diWStmMHdk?=
 =?utf-8?B?VnRZeitYdmkzU0hEOU1wYVc0Mld2Y0JBZkZhb1dTUzNtUFlvbXF4eDBac1Rx?=
 =?utf-8?B?Ny9SNzlsZ3JzQU0yYjVEOEdJU0YvVklCR1RkNjN6Z0RRTTBPZFFHZWVDL2hD?=
 =?utf-8?B?N3paZTREdVVrQ0w0TEg1Qm5EaXVmdjNPRXp4Tm5oOWRVZDdJZlVGUnE0azRR?=
 =?utf-8?B?MWwxeFhzWjlhaVVKWWM4TFBnd1Eva0JtNmh3T1RMUVBxQnN0OXVxY1F5VjBw?=
 =?utf-8?B?R1c5V0RHcHVqREJkcjgwNmQxc242QUc2OGVuTlBlVWRGLy9sMnEwcmtHa2xi?=
 =?utf-8?B?MElIa2NhWlNnMnJRaGxqU1duZFhaQ3NiYU5KeTQ1ZzNnOWJHREljajU0K25w?=
 =?utf-8?B?aFppNEV4YzE2LytBT3hWcXg5Z0tVd1JnSUV2VFdqemNVaHVDT0toWG5DcUQr?=
 =?utf-8?B?TzhCbGRTeXlFS0tKL3kzSmI0U0E3RUloV3pFZ24xcHBaQWZwbjJXaWtieE1U?=
 =?utf-8?B?Um82em5tdmxnaERQYU5xN2JMMG9qRzNmcFJmQmRraFdUQ2RvZlBjNWZnb21l?=
 =?utf-8?B?SGZOZ095LzZPalBPRmZraWJmNnlUVnlnRHR0TnVGNnVoSGgvS2FRT0k5UWVG?=
 =?utf-8?B?R2xxSDJ1aWcyUGhWRWtTL2haeFBBM0I0dnZ2cTZQT2EyRWVMWGhoTDZJemNu?=
 =?utf-8?B?TlBrRDk1S04zbk9KOU1aQ3d2blJEcldkMHNlcWJWZjFLeTVtYnJrclRpZ3hV?=
 =?utf-8?B?MWlDVEhYaHdtMXIwMHhCdG8xRmZsRmVWVzYrUE9BVHZpdE1QYzlnVmZJZGlo?=
 =?utf-8?B?NGV3bWxuc3I5WlRwTE5NUUNSWGE5di9sYTdsVHc4V2paemo3N1prbjNlN0pB?=
 =?utf-8?B?aHE3ekNOcHFvS0FrV0xFcGUyRnJ2L09lamIyd2lTckdSdU5Qd3djdWhaMW85?=
 =?utf-8?B?NnZncDVzTE8rRERXTkUwb3J3TVBnYmhxemtaelhqTmhzUE1xOXQ5L1FUSFZp?=
 =?utf-8?B?NkN4Y2x2RGpjQ0VoemFic0RWMDlYVmhnSURuTm1Sc1pGRTUzSWcwbkljQS9Z?=
 =?utf-8?B?L3RWdHd6WHl1TEFYcjVwaFl3OTFDNXFrVHRSUjQrQzdaalB6cklNM2lPSmNh?=
 =?utf-8?B?QThjU3FzRTBWUFhlZWl0YW9ReHRNR3JGMjJwaGlwSlFNVjR5MGJSWkJoU2xU?=
 =?utf-8?B?a3Fob1FyRXYxTVJjTU1aaXB4Qnl0ZXo2SGlSQTkvbEJ6QW5CWXBnUDVQWHA1?=
 =?utf-8?B?Yk5nTnpMei8raFhNY1crL3dOK1kzSDdiVHJWTGlFbTQxdlRQRXJOUUtRbjBE?=
 =?utf-8?B?K2hld1hvOG1pSWlLY2Zaa09MK3BVK0FNbUdOVEZVNmM4N0VwbHp6RmVCTHlS?=
 =?utf-8?B?OXliNTJpcUcxZmpUUUZsMmt0MjhKOTBPQlZHcWFQRTZzYlVLanM3REJaUFdK?=
 =?utf-8?Q?/s69lqEnrR0Gm6YXcKgexzA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6A6C1475B33EA49BC9CAA3F8DA3C5D2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f12bed-1c68-443e-dd0c-08dae39c4ecf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2022 21:42:50.2526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oIxEhjaWS+3un1gPttK7PMrrc5j24oHM+ZrZMnqR+fgs4tzQ5zJRzWIULEWFv1LLVmjKNK20EzjAj5wICTE/5U5AF3FCEP8RifqtojMaweM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7102
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gV2VkLCAyMDIyLTEyLTIxIGF0IDExOjQxICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFdlZCwgRGVjIDIxLCAyMDIyIGF0IDEyOjM3OjUxQU0gKzAwMDAsIEVkZ2Vjb21iZSwg
UmljayBQIHdyb3RlOg0KPiA+IFlvdSBtZWFuIGhhdmluZyBzZXBhcmF0ZSBwYXRocyBmb3Iga2Vy
bmVsIElCVCBhbmQgdXNlciBzaGFkb3cgc3RhY2sNCj4gPiB0aGF0IGNvbXBpbGUgb3V0PyBJIGd1
ZXNzIGl0IGNvdWxkIGp1c3QgYWxsIGJlIGluIHBsYWNlIGlmDQo+ID4gQ09ORklHX1g4Nl9DRVQg
aXMgaW4gcGxhY2UuDQo+ID4gDQo+ID4gSSBkb24ndCBrbm93LCBJIHRob3VnaHQgaXQgd2FzIHJl
bGF0aXZlbHkgY2xlYW4sIGJ1dCBJIGNhbiByZW1vdmUNCj4gPiBpdC4NCj4gDQo+IFllYWgsIEkn
bSB3b25kZXJpbmcgaWYgd2UgcmVhbGx5IG5lZWQgdGhlIGlmZGVmZmVyeS4gSSBhbHdheXMNCj4g
cXVlc3Rpb24NCj4gaWZkZWZmZXJ5IGJlY2F1c2UgaXQgaXMgYSkgdWdseSwgYikgYSBtZXNzIHRv
IGRlYWwgd2l0aCBhbmQgaGF2aW5nIGl0DQo+IGlzDQo+IG5vdCByZWFsbHkgd29ydGggaXQuIFll
YWgsIHdlIHNhdmUgYSBjb3VwbGUgb2YgS0JzLCBiaWcgZGVhbC4NCj4gDQo+IFdoYXQgd291bGQg
cHJhY3RpY2FsbHkgaGFwcGVuIGlzLCBzaGFkb3cgc3RhY2sgd2lsbCBiZSBkZWZhdWx0LQ0KPiBl
bmFibGVkDQo+IG9uIHRoZSBtYWpvcml0eSBvZiBrZXJuZWxzIG91dCB0aGVyZSAtIGRpc3RybyBv
bmVzIC0gc28gaXQgd2lsbCBiZQ0KPiBlbmFibGVkIHByYWN0aWNhbGx5IGV2ZXJ5d2hlcmUuDQo+
IA0KPiBBbmQgaXQnbGwgYmUgb2ZmIG9ubHkgaW4gc29tZSBzZWxmLWJ1aWx0IGtlcm5lbHMgd2hp
Y2ggYXJlIHRoZSB2ZXJ5DQo+IHNtYWxsIG1pbm9yaXR5Lg0KPiANCj4gQW5kIGhvdyBtdWNoIGFy
ZSB0aGUgc3BhY2Ugc2F2aW5ncyB3aXRoIHRoZSB3aG9sZSBzZXQgYXBwbGllZCwgd2l0aA0KPiBh
bmQNCj4gd2l0aG91dCB0aGUgS2NvbmZpZyBpdGVtIGVuYWJsZWQ/IFByb2JhYmx5IG9ubHkgYSBj
b3VwbGUgb2YgS0JzLg0KDQpPaCwgeW91IG1lYW4gdGhlIHdob2xlIEtjb25maWcgdGhpbmcuIFll
YSwgSSBtZWFuIEkgc2VlIHRoZSBwb2ludCBhYm91dA0KdHlwaWNhbCBjb25maWdzLiBCdXQgYXQg
bGVhc3QgQ09ORklHX1g4Nl9DRVQgc2VlbXMgY29uc2lzdGVudCB3aXRoDQpDT05GSUdfSU5URUxf
VERYX0dVRVNULCBDT05GSUdfSU9NTVVfU1ZBLCBldGMuDQoNCldoYXQgYWJvdXQgbW92aW5nIGl0
IG91dCBvZiB0cmFwcy5jIHRvIGEgY2V0LmMsIGxpa2UNCmV4Y192bW1fY29tbXVuaWNhdGlvbiBm
b3IgQ09ORklHX0FNRF9NRU1fRU5DUlQ/IFRoZW4gdGhlIGluY2x1c2lvbg0KbG9naWMgbGl2ZXMg
aW4gdGhlIGJ1aWxkIGZpbGVzLCBpbnN0ZWFkIG9mIGFuIGlmZGVmLg0KDQo+IA0KPiBBbmQgaWYg
c28sIEknbSB0aGlua2luZyB3ZSBjb3VsZCBhdCBsZWFzdCBtYWtlIHRoZSB0cmFwcy5jIHN0dWZm
DQo+IHVuY29uZGl0aW9uYWwgLSBpdCdsbCBiZSB0aGVyZSBidXQgd29uJ3QgcnVuLiBVbmxlc3Mg
d2UgZ2V0IHNvbWUNCj4gd2VpcmQNCj4gI0NQIGJ1dCBpdCdsbCBiZSBjYXVnaHQgYnkgZG9fdW5l
eHBlY3RlZF9jcCgpLg0KPiANCj4gQW5kIHlvdSBoYXZlIGZlYXR1cmUgdGVzdHMgZXZlcnl3aGVy
ZSBzbyBpdCdzIG5vdCBsaWtlIGl0J2xsIGdldA0KPiAibWlzdXNlZCIuDQo+IA0KPiBBbmQgd2hl
biB5b3UgZG8gdGhhdCwgeW91J2xsIGhhdmUgZXZlcnl0aGluZyBhIGxvdCBzaW1wbGVyLCBhIGxv
dA0KPiBsZXNzDQo+IEtjb25maWcgaXRlbXMgdG8gYnVpbGQtdGVzdCBhbmQgYWxsIGdvb2QuDQo+
IA0KPiBSaWdodD8NCj4gDQo+IE9yIGFtIEkgY29tcGxldGVseSB3YXkgb2ZmIGludG8gdGhlIHdl
ZWRzIGhlcmUgYW5kIGFtIG1pc3NpbmcgYW4NCj4gaW1wb3J0YW50IGFzcGVjdC4uLj8NCj4gDQoN
Ck9uZSBhc3BlY3QgdGhhdCBoYXMgY29tZSB1cCBhIGNvdXBsZSBvZiB0aW1lcywgaXMgaG93IGNs
b3NlbHkgcmVsYXRlZA0KYWxsIHRoZXNlIENFVCBmZWF0dXJlcyBhcmUgKG9yIGFyZW4ndCkuIFNo
YWRvdyBzdGFjayBhbmQgSUJUIGFyZSBtb3N0bHkNCnNlcGFyYXRlLCBidXQgZG8gc2hhcmUgYW4g
eGZlYXR1cmUgYW5kIGFuIGV4Y2VwdGlvbiB0eXBlLiBTaW1pbGFybHkgZm9yDQpzdXBlcnZpc29y
IGFuZCB1c2VyIG1vZGUgc3VwcG9ydCBmb3IgZWl0aGVyIG9mIHRoZSBDRVQgZmVhdHVyZXMuIFNv
DQptYXliZSB0aGF0IGlzIHdoYXQgaXMgdW51c3VhbCBoZXJlLiBUaGVyZSBhcmUgc29tZSBhc3Bl
Y3RzIHRoYXQgbWFrZQ0KdGhlbSBsb29rIGxpa2Ugc2VwYXJhdGUgZmVhdHVyZXMsIHdoaWNoIGxl
YWRzIHBlb3BsZSB0byB0aGluayB0aGV5DQpzaG91bGQgYmUgc2VwYXJhdGUgaW4gdGhlIGNvZGUu
IEJ1dCBhY3R1YWxseSBzZXBhcmF0aW5nIHRoZW0gbGVhZHMgdG8NCmV4Y2VzcyBpZmRlZmVyeS4N
Cg0KVG8gbWUsIHB1dHRpbmcgdGhlIHdob2xlIGhhbmRsZXIgaW4gZXZlbiBpZiB0aGVyZSBhcmUg
bm8gQ0VUIGZlYXR1cmVzDQpzZWVtcyBsaWtlIHRvbyBtdWNoLiBMZWF2aW5nIGl0IGluIHVuY29u
ZGl0aW9uYWxseSBpcyBhcHBhcmVudGx5IGFsc28NCmluY29uc2lzdGVudCB3aXRoIHNvbWUgb2Yg
dGhlIHByZXZpb3VzIHRyYXBzLmMgZGVjaXNpb25zLiBTbyBJJ2QgbGVhdmUNCkNPTkZJR19YODZf
Q0VUIGF0IGxlYXN0IGFuZCBpdCBjYW4gaGVscCBhbnlvbmUgYnVpbGRpbmcgc3VwZXIgc3RyaXBw
ZWQNCmRvd24ga2VybmVscy4gQnV0IEknbSBvayB3aXRoIHdoYXRldmVyIHBlb3BsZSB0aGluay4N
Cg0K
