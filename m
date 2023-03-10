Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691126B4E50
	for <lists+linux-arch@lfdr.de>; Fri, 10 Mar 2023 18:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCJRQy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Mar 2023 12:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjCJRQt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Mar 2023 12:16:49 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42877A42ED;
        Fri, 10 Mar 2023 09:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678468606; x=1710004606;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cvht6ZU4d7dJIPLzUJ7MLddIk72LeaPXb8IeDkiBUkQ=;
  b=PZNRMR8xt8w42mb4Le/9wXcfYxz3W62clzOGbcibDrCC35+aVx+W6GWz
   +iJt+N7sRZIFCmf6vm3BKaG+eDfjNpzi9Yo++nI47XqfIC+3Mi5NyyITM
   aZd9aw7GE7S3Lc+9I++IMu508+0rhpmbbTB6EG8U+ODhFbzdu1VcwDBf6
   /yd/tM/B2XVziF282/DrVZ+In0Od31r6GzAcHiFJvNY0V1iruDGU+HpBi
   lvvvANz/YJ9icWwyTgDqQY4SLk+8TmmE+7OSWsazN61ozJOFfbRo7gOGN
   X0/IQ59CXY1s/6cBg76fshHlTE3S/bfu0Quk2nDV0ygR0QTNTcgWI/ump
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="325133414"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="325133414"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 09:16:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="788087352"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="788087352"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 10 Mar 2023 09:16:21 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 09:16:19 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 09:16:19 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 10 Mar 2023 09:16:19 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 10 Mar 2023 09:16:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JccFGeTE0i1+CQRETcRJcVKSp67rXyymVRjUnLmxX2csG9M+nvpD/j07KO1sU6GcwuxN9Y6O5040gd7qnMIPT8SB24MN+sOnZjSG17xhJuGjteiia7HtYn0UQJvZ/PAnOKCDPGaKjkcQUu3EkFonGWQAcGLJmYc3kJ/mQtAzYec3+WjS+O+E3Y6acFmESkE5qNeBOhmz13mmy3A2YSr4efNCxG8TQRc3CwxC+qLKEpPRdi+PI4TnNQSUgALdAQ0fA3ZVs9srwxIDj15J9c1EtC4De6/faroPQ52SKJ5JItcuoAwBo3NB1BSNAV2QIFDWs37QPiEMH5DmskWeHOKA5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvht6ZU4d7dJIPLzUJ7MLddIk72LeaPXb8IeDkiBUkQ=;
 b=JnUCMM5ghQZAF98bPbpO/siEtSUrVKmMqK2mpW03VJqr0GVtdXWg2zwdSG05ZIwo9/R4E+jF4gGPr2/2OO5yEMHozotCH8Ajlwt/xrI04mrxucqEN4xWzP01iIwX5+I6B2yaf4rB7LyZuoe1XY3auAbHRfD4OptfTYQSBuLbRqRqwWKsfYD4msruKvCLd1v5YkYVRzYDvGddGzAXxvonkylmOOqb1jsBINH+32iGHy6nUhHTEdHbQTwmoREvDzKhmr4qLj7+sYuoKFcG6pE8Dtl7lZ59LAgMg6IzPIBGN36IEaLy4IUGy9PIUjoDzxycRGKcF+CNCv4Ucuy3P+Z5yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SJ0PR11MB5165.namprd11.prod.outlook.com (2603:10b6:a03:2ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 17:16:16 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 17:16:16 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "david@redhat.com" <david@redhat.com>,
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
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v7 34/41] x86/shstk: Support WRSS for userspace
Thread-Topic: [PATCH v7 34/41] x86/shstk: Support WRSS for userspace
Thread-Index: AQHZSvtHy+VhnkpPZkiNefGCzp08Va70SVEAgAAIwoA=
Date:   Fri, 10 Mar 2023 17:16:16 +0000
Message-ID: <b21c8e9865653def0a6b495489f35aa5a42e82e8.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-35-rick.p.edgecombe@intel.com>
         <ZAtehgwB5/jGL9dC@zn.tnic>
In-Reply-To: <ZAtehgwB5/jGL9dC@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SJ0PR11MB5165:EE_
x-ms-office365-filtering-correlation-id: b3dba71a-e734-4473-9318-08db218b2852
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PJzdJrHKGMEBiq/IQ3TLdGApV/JFNHXMZyZV4Qbk9o6dEeBlzWOE7VUehOgVn55kcp607rpJXoTKTG7AyqS8tdxzhERXG3uGA04d5NqHutrsJwV71R17CwS83CESfk4FVmJV82apnXKR6OdFVa4MJ5Tf1PuTBn8WbxeK79dnPu5NHWCBzyJjSbLWzKQ9hO3+d2TaWEmrlY2nJIWFXPID2fwK+7QkiWcUfai8UOiWsekWg9RofIJ3+t3jNywehV0NmPHqVEwc8/D6r/VBIJWVzffcvkqNMgi7QoWUiWw618LUMSPfUlp+rIS99++2AJvNWL15dnOF3g1beuobeYKd0CC4q5X5xZBR7RzZoc2Gst7BjLVMZAeZqiKaPYS/OvhiWJeagWqrfnhkXZJ3vOpkbTaELdZ9qc4+mPDB4FJEjXUHkLwR4ZRbiBfAa4kVWxZZKUGNK11zyqEbWFJIuKYTUFIDIuIknU1vD5hzVIBnaQ0+yc7wHdkbM9pG3GXIrHD+S1ATYvaTawVGcg3Jf1JYBtV9uW+1EzZNMcCJIwX9CkACTSdr2cujyLTi+xtf4gS2Zt5ZH+NW84MYAR/IvaSCnd6X8In1mWpHpO2I9hQVV9y0UKGJFjvuybqhFnv8UNVwfU5S3u5sM4y793ukm3GRCeK9ezBsTeSAW9U81IPhhd7Vv8fvxcmBMYJGX7R3ZPIZG1Kcfps9o9YrWc7hbe88wI66CLb/jwhugzr4FJ7A/YQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199018)(4744005)(36756003)(7406005)(5660300002)(7416002)(26005)(8936002)(6506007)(82960400001)(6512007)(122000001)(38100700002)(186003)(91956017)(2616005)(64756008)(8676002)(86362001)(54906003)(316002)(4326008)(66946007)(41300700001)(66556008)(6916009)(66446008)(76116006)(6486002)(71200400001)(478600001)(38070700005)(2906002)(66476007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzdUQ0ZIcE02anEzOHBBcy93U3RzOWU0bFNYZzRKVExFZ0ViVGdmcEdhNzJL?=
 =?utf-8?B?QVk4b1FXSzRWbmNQeTRlOE9nejZobEMyQktFOU91VnRxamZZcHVFUFJDcEdF?=
 =?utf-8?B?NE5QWDF1Z3BBLzI3NXdoYTVTZnNhMklnM0M4QlFtMTBxMlAraDZCWWtuY3dW?=
 =?utf-8?B?dit2Kzl1am9XVG4yUVJXUzQxN3VrL1dwM0Y0SXhhenFZeUZhdWRjZWpVUUdD?=
 =?utf-8?B?cnliUHJhdWRPdGZhZEJKK1RmUzBLR2RsRWN4Wi9aODZoTDM5U0xDNnMrcjM2?=
 =?utf-8?B?YlRnUVU2emV4NWk4RkpERHNOYlRocW9zOExFV0tHOXd1SE5uQWdhbnU1T0tj?=
 =?utf-8?B?eVpvK1RQTWFmalV1eHJpU3VsenJYWTZmTDRzdUlTUTJDUHVNL1k1Z3RJTUtT?=
 =?utf-8?B?NzFRUFV3NS8wZDN0T1ZZOVl3WHdvL0V4WGIrbnFEM2dzTy8vOEFCTVg4UjhN?=
 =?utf-8?B?b0Y5QjFBY3FVbC9IaU9hL09acDNqUkU4YWMzaU11RVhtSW1lbEdDb0tabTdU?=
 =?utf-8?B?UWg0Z3l2eWJQc09wOG9Gd25Ga0RTV0ZsamI2M0hQdi9Felh5a251SnpNMU42?=
 =?utf-8?B?ZmFUSWZVRGpjNHlMZjl4RytQRWVlbHNnMDRTdjRYZ1h5L1JSWXF6MEQ3MUxX?=
 =?utf-8?B?WEZiK21GcThaZE9ZakEzMkxBVFNFc1VLNFFiaGpwZmxuZWFOcUY4YmpPMGtw?=
 =?utf-8?B?MEVybk1ENC9DdDNLZXBSakx3YkdmNTNvZmpKMVRXUG1FUnJQbWw1c0IyTDJO?=
 =?utf-8?B?VEJTb003Q2MrWXd1bGMvUTBweGVTbnhycXBOQXRRS01ZTkdUcFk3MUtTdWwy?=
 =?utf-8?B?T2VlRWtPZzlZNTRuVGc3eXM3OXZoTmtGY29WN0hHTjNMaEZidVVHVnM4MXhj?=
 =?utf-8?B?VGRwMXZ2eTJTOEJvTGpvZkFKNi8vUTNnaUlrMThib0NIUGlDdnI0TDRlaml0?=
 =?utf-8?B?T2Y2TVdySlhMZjNVZnNZbkZSV2Q5MGVSODgwS0VRZU1QNlExRnYxZTdpVGM2?=
 =?utf-8?B?cElpL0tsZ1dOVmdPdmE1QWc1ZUU3TG1UbFI0LzRhTFIyUDB2Z0VWNC8wT2ZT?=
 =?utf-8?B?endhUmZQTTIxd3EycVhublZFbldaMmkzdTZIa3ZzSFZGRDUzeWdaVjE4VVJB?=
 =?utf-8?B?elFWWlY2MTduZFlSdnF4NVJOZFV5VUcvUy9nTnNidGQ4T0NOT1ZoM2dVN0xG?=
 =?utf-8?B?bjhTUTN3SmxCa1ptckxkSXVZeVR3VDJWSTY1clJiR3RXTUkzcElQMFN2T1Vu?=
 =?utf-8?B?R3p3ZmJDZVNqUWd4UDhpbWNLd2J3bDEwbE9xbUxhWC9aM1N3anFPSkpEeUNq?=
 =?utf-8?B?SDAvQTUvUkMrU3drM2pNdWtzMVFaU0l1TndaNWJ0OFc5S1Y0WlUrOWwwQ2pv?=
 =?utf-8?B?V1Fhak1kTXIzRzlWS3lQY2s0UTVQa3dqTEk3K0hvNXpQUTFSYjl3QUtPSjRJ?=
 =?utf-8?B?dkIxSXQ5aEwzMGg1WVFKOHFJQmc4TGlPaWJrYTJ2azNZdk5na1FhaWc3bG1k?=
 =?utf-8?B?dnNBZ0xPWlRyM09KWjkvcUxZeWdqa0lMSUV6SFZ4ck5SaUhZeDBvbjJHNXpj?=
 =?utf-8?B?TG5POFlGS1ZFd2dXYTYrODBiWFlHbmxtb29aam9OcmxVaGY0L1R2UUEyWjBJ?=
 =?utf-8?B?NDFiRS9pTVFEVTN6ODZJWHQ0OHp0eHRMTDlsS29nM2pMUEhXWFpGc2ZMbzdm?=
 =?utf-8?B?V2VoT3pFZWlxMnFsWHZwTWJYdlRpNEZKZmVCeFQ3bWZMeXVjR1I0Tk1Tb3Fy?=
 =?utf-8?B?eGhKdW9VeGxqem9aMi9ZVWVqVzZOTUZTWVRzL2ZlNGRtaW40MENKbXBiRVAr?=
 =?utf-8?B?UGtWM1NuQmZBc0hSQ05SWVNhNDJSTDJlRFI0VHhvUStXa1BHMkxndmhJKzNB?=
 =?utf-8?B?dmg4UVppOWJucUtPMjhneUZVV3hkOWtrYzBkQW5Vd3FxRE9vSWRUa2FYRll6?=
 =?utf-8?B?WVVRUlBGU0FtTGtad0VPRGlmc0JvNmY5TTFhMk1mME42NkExNVhTdGJEZWty?=
 =?utf-8?B?dHAwMFdmTkxNcS9JbE5ORjFUNVRqMzRxRi9UaCtmcm1lQzI3bkRGdTNVVG80?=
 =?utf-8?B?TU0xV1k0RXNkM214aTdvK0VZUWRzdVlIZDBKbG1hWHI2S09Xa1Y3RnBqajBU?=
 =?utf-8?B?ZnFmUXBLV2dzVHAxNXlsdVc3YzhWVStaWTdHWTRTSmVMVVpFNnRKRG1HOWc2?=
 =?utf-8?Q?0GLTC6jjgD5dF3faChIadp0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A69B932C8667145A20E3254D06AA615@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3dba71a-e734-4473-9318-08db218b2852
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 17:16:16.3103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sPeT0bTZoLg7I2zp2FYz5s1Cod+5DYmd/Y2Onc7RLBzLo1KpdFfv7ZLtzq3raUfkyO7RpuTgresb++auv2SwLlKZFYIX1+X1PjHJ4Ak1yZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5165
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIzLTAzLTEwIGF0IDE3OjQ0ICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQoNClRoYW5rcyBvbiB0ZXh0IGVkaXRzLg0KDQo+ID4gICANCj4gPiArLyogSGVscGVyIHRoYXQg
Y2FuIG5ldmVyIGdldCBhY2NpZGVudGFsbHkgdW4taW5saW5lZC4gKi8NCj4gPiArI2RlZmluZSBz
ZXRfY2xyX2JpdHNfbXNybChtc3IsIHNldCwgY2xlYXIpICAgZG8geyAgICBcDQo+IA0KPiBVZmYs
IHBscyBraWxsIHRoaXMgdGhpbmcuDQo+IA0KPiBPdXIgTVNSIGludGVyZmFjZXMgdW5pdmVyc2Ug
aXMgYWxyZWFkeSBpbnNhbmUgYW5kIGFyY2gveDg2L2xpYi9tc3IuYw0KPiBhbHJlYWR5IGhhcyBz
aW1pbGFyIGF0dGVtcHRzIHRvIHdoYXQgeW91J3JlIGRvaW5nIGhlcmUgaW4gYWRkaXRpb24gdG8N
Cj4gYWxsIHRoZSBvdGhlciBndW5rIGluIG1zci5oLg0KPiANCj4gSSBoaWdobHkgZG91YnQgdGhp
cyBjYW4ndCBiZSBkb25lIHRoZSB1c3VhbCB3YXksIGxlbW1lIHNlZS4uLg0KDQpTZWVtcyByZWFz
b25hYmxlLg0K
