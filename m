Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7BE6AD43B
	for <lists+linux-arch@lfdr.de>; Tue,  7 Mar 2023 02:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCGBre (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 20:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjCGBrc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 20:47:32 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9915A46AF;
        Mon,  6 Mar 2023 17:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678153651; x=1709689651;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ySh+YdmPmExMtCLNEvGTlzlpsDPYBZAFoeGVs3sZTOw=;
  b=kVgZCPAcoHtjQ6zYKMuy1B467pmrmSfFxB8Dj7IIChAC1t+if9nZmVa7
   ZJM+41tm0n//iFzPp+rHuGCAtIvD10G6idIT1AKtaQpXbUR7pOFaNtRPV
   dTCCHe/tcUncaw2CmMlw8aVZmy93Mf1YVTcGPez2Os1XfMLQpNLdm8xi6
   mQs2KPKTP6ykNdZ59omFGEf9CH1cuZ4J3B74ddZeUGxmXctAyLf+zU2S2
   8ZT8AfOm60vN2Q1OoHWsH/DvlgqVT03XFtfzYGsACGLUc8DCPj3QVcAe/
   GD4lqLhL/gI6liM24acICmt5Gno2Mp6qcsnHXnAitHDk/e/u0BTQ044f0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="400557375"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="400557375"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 17:47:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="669680176"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="669680176"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 06 Mar 2023 17:47:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 17:47:25 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 6 Mar 2023 17:47:25 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 6 Mar 2023 17:47:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvBJVSjlvFgei+PZ4dqQa3r6938t6fS2rBOektbmKCsHTw4KwDTPflIsITvmqlATfca3X7HcomA19oY3m1F8ZZ9qw/QWDUeywtE0tG9v28pdF9JI5EiFPkdENKn0sfzDcFOQgtvKr03XRwJI5FXm5l00FdIJINO/ZLCer7KeWEy6BEW2j+xx6qu0IFQEVc6riYqTXm0Q9x5rcYBXfgvtqlBxmVMcvd4DWEY3qmZI+cMEWIlraA2c05MGxjvtzkIIwjEX33Bczd88e6rA+R6DQMLo10fB/KdRZPPCgQjZXuFH2kK3yol6spq868pcNhI05/eLRjlKoOeoLQlYviT0hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySh+YdmPmExMtCLNEvGTlzlpsDPYBZAFoeGVs3sZTOw=;
 b=kenAuQFDDad63bQ0JRmC92ZtZgABDXsfNZd9RrvKh9sx2DFngszKPTDmqVNM3nDuuQYsQZT0Rnyl0AaUlicetWs6fgmoKJLnwo2vO1zJ5a/OUmcb+fI8DmirDdQmUJEsxU2E0MMlGJX0jcvcYQ7KgB4hTo1dwLDfX9rb41fIegqDsz2NyAVRTUpoAfjekvRp0HD/jCQrMwVsYC5lNhGQO/HiU+fy1RnlVVukvlqrd6q45ckODopdevnTkqaTXKPsZpQEOeRzFQpGrAD+hVw0N3Zsg7vx+o+3UnBFOHfd1lGuQ2scOMC1HqXhyID4jXcjdJOO6nk8Jb4m6K1Bk6fy7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SA1PR11MB5779.namprd11.prod.outlook.com (2603:10b6:806:232::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 01:47:21 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 01:47:21 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Lutomirski, Andy" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>
CC:     "david@redhat.com" <david@redhat.com>,
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
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v7 24/41] mm: Don't allow write GUPs to shadow stack
 memory
Thread-Topic: [PATCH v7 24/41] mm: Don't allow write GUPs to shadow stack
 memory
Thread-Index: AQHZSvtA9HShWDZSHU6zwVvYYuImzq7txAeAgABVMoCAAAUggIAABpQAgABynYA=
Date:   Tue, 7 Mar 2023 01:47:20 +0000
Message-ID: <f34a1122386197a39dffdc176fcd2c1fa4243e58.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-25-rick.p.edgecombe@intel.com>
         <ZAXmOZYcoR3hq/CH@zn.tnic>
         <CALCETrViDpTbuBk+9wQa-PNzKZerwk=4MmKMXw2v3Ysxuv2k3A@mail.gmail.com>
         <c3e21d54fdc025c8e09f90b57dd3de0751cefbfd.camel@intel.com>
         <2361d4e2-c8c9-4dc4-b925-ab6543ba3404@app.fastmail.com>
In-Reply-To: <2361d4e2-c8c9-4dc4-b925-ab6543ba3404@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SA1PR11MB5779:EE_
x-ms-office365-filtering-correlation-id: 95dbb6bb-db16-441a-edfd-08db1eade3fa
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zxwv1yCcmeWkY5e/0LJHvQKG9/zL58kTIQiakFkserOakpjeFABmAQjt3hM/vVPZv1s1WdLipFRTBgWKviugzFJFAzAmkcidDkRX1Nya4QT5KcgVCyJ4S4PT2IoR0i8UDUSGG5o473boGPkx1u/83yyNQOFGwxdQrwuOdji3OQhLNrQqRtu2vcjnptBCmDi5C1/kfmncHtHzQ7mll5zJ8E9ClZxLM4bld9nsdlVAB3sdteexd0Y/+7sLOVe7u1SIGuL5J++JlZY91vr9TZ9umdfiTxuWge0IPdQ4qM239yUeSNenDmjw0TdLekiTLjOxGIxqVFv2A0YmJaQ5hSUGB6Mma8+Ad+3K+f8AQUl6EAvibuBWUMbbwm+zoQR9ucn9VPbMGi4UdplIkfB2JAbhezvwSmTrpGION4CZdzawjrvuOPqlX5qf+mSiuK2nM+PMf8Zye+43whZJXzAprR3dy87w6t+EAn3nyUPwqhGBBhZG6yXy6eYDbNqfFM+PWEOtUQQQ9rd6uhBjHIkvno4HSdsOiJPY6IRciG6VvNkPoOXgOHgATnv0blyNNsW7kwpcQplKmUO/piYXKHc2rmsWaalQRDJblUr308m3tvVbk9zMGE5fjxobbOYqsbiJa1N+eIKx5pJFxnXZ3/4Ics4qursmnxU6DRQb3NsYD6+lJd7lZj09WedqCJYI+9tyJPHa2/y+8km6pNs2q1Xx9Y3bcrHIz7GVk+vPLU7Pqp4wilY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199018)(4326008)(8676002)(66446008)(54906003)(66946007)(83380400001)(91956017)(110136005)(76116006)(8936002)(5660300002)(64756008)(66556008)(41300700001)(2616005)(316002)(26005)(66476007)(6512007)(6506007)(53546011)(186003)(478600001)(6486002)(71200400001)(36756003)(82960400001)(7416002)(7406005)(2906002)(122000001)(38070700005)(38100700002)(86362001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vncybm1aOXhlN0RBSk9kQ2tLQ0dVRmZCTlFZSExvaHByVXlWQWtzZmJlbkJl?=
 =?utf-8?B?VWxISXZXWGVWSHB5M0t4SEkrTlFrenVhQmd5Y0VsRXo0VEFQaC9yb1BmaVNs?=
 =?utf-8?B?NlhRVGh0RmRXcnoyVlBTdFI2SHVtZXlmRytyaDkrUWIrSC9lRTM5TWhSTzd6?=
 =?utf-8?B?WXFBTmVVTmlZS3ZUWFFTLzVGeFJ4QmdNTDY4bGdXUHBMVkxONUlycWptTlA5?=
 =?utf-8?B?a29ZYVhmcWhSMGJ2aEdLTGJNZEhCaWlZV1ZFK08wLzVQOVM2Qy9LVnRoUFdB?=
 =?utf-8?B?Q0xvV05jRXNuajM3VDhycGYyR0JTOXh3TkRpY1Qwa2VBRE5QR0p4MWlxcHA1?=
 =?utf-8?B?a0s4VjM0T2p6dEh2b3hkOXI1bkJraUdRaTdNU2dYK2YyYTBNY1AxTWhFbXVE?=
 =?utf-8?B?dUJSSmxRVXdiblhxSmtoRi9UdGhwL3RwcGhyOHZTMXI1MVdVM2VaTURjK0Vs?=
 =?utf-8?B?S1dwWnJYdWRXUWFIWjIvWTViaE5YM0Y5RS9zcTErU1NiSm9tNDZ5MFgrWDhO?=
 =?utf-8?B?WGtrR283cmhKbHBUZ0lYbHFhOHM0RjBGYTFncWQrdkFCOFd2RjhoWkVic21V?=
 =?utf-8?B?RlM1KzIvc0t5THBLcmpvTVlDZHVaRW1DdWF6eXQ3RmxXQjZmZkNRQkQ3YW41?=
 =?utf-8?B?TUord1gwV2FyZGRGZ29uNVhQcGNOZ21rYngxTFV4aStUcXBYK2xhZGhpak8v?=
 =?utf-8?B?UC84enplRUpWdW5hMGFManpDL2dobFU4dTc5NnUyc24wVGpSNzBDZUJTNkpF?=
 =?utf-8?B?dHNudkt4ZVNRNWJTQXQ4MHdNVHJDamZTTFlmTmUxVDhoR29JQTFYcGhBYlUz?=
 =?utf-8?B?Rm5mbU5IVXo4OU9CNXBMMjh3Wm9ROWNSK3c3S0RUb3p3aWlpbno5UUV4Mmho?=
 =?utf-8?B?TDBxcFVsVWZnTGxmcEo5MHlBbUMyYnBGMHBXWjh4bzVNYWNtbDBSSTFkcWQ1?=
 =?utf-8?B?clpKM0E1RytXTlV2WjZwU1V3YmRKLzhENFQ2dTJLdjFhUmR2bFVEVE12ZlRP?=
 =?utf-8?B?L1BoMjRvUERPT1VRWk9hd3RiMi9ORTBEak9YUUFQQWE4ckZoYjBFdlJnd3JP?=
 =?utf-8?B?ZWVpNXA3eWtMUzB4RDlHckh4TlFBbTB6czBjcXYvUDlpRkxVV2ZSVHBZYVh2?=
 =?utf-8?B?QUhMdHZaRWpxTm5nUHFDMGN2RUpzUVpjditqUUNlMWpadjdmaThRSHRUOGN4?=
 =?utf-8?B?bUJPYk1RaFZxNFRDcS9SWE5XRVJsQ01tUEdZU0hYdFA4Zy9lRFNadlJUUUY1?=
 =?utf-8?B?OENKSU5PYVBJbjNqRThZaVlhOUtOUjZaSnhZZlc3dU9NcFhLUXlSL2psckVh?=
 =?utf-8?B?R200Sk9WbnRja21KSVY0ZTYxUm1KbVRqVFBJaXpUZGRyMDNtL2cyTnRNSCt5?=
 =?utf-8?B?c1pGY0hzNVJRTExDSkN5VW9vb1NxcWRPSjU5dSs2cUFNanFMcUFUQklFaXQ5?=
 =?utf-8?B?VDU1bnZtNjJzelY5S2V3cTMydzMrbG1MYVE5NEdJWTF5SkVicm54WHBBNE5Z?=
 =?utf-8?B?dHFmVlZGcFNiK2xyb0Ywa25vcXpva2RkSU1peGFpNlJjSmxEZ0FUQ3ZJMnFE?=
 =?utf-8?B?MSt4NHJNV2I3RzdDL0crMmFrQXNrVlF5ZnVpTEZSTjBiNnRKb3dvYUUvdHow?=
 =?utf-8?B?YmV4d0wraGhOQmRVSkpKUFpselZ5azRkTWlLU1ppdEpjVjRJU2kxWGFpRDJv?=
 =?utf-8?B?a3YvaVQyUXp4YmQ3Y3R5aHNaNlZJTi9hN1FTYUdmTm50MG9NWEhSMlhCcmE4?=
 =?utf-8?B?YmZkQ3htKzJwOU4ybEhaajhWMnFwVHRTZUtPbFNsYXRaQjA0MkgwOFp4d29N?=
 =?utf-8?B?dzlodHhhQUtJSlVzZzNlc3I0RlFlVXJmMGZzWVV3MUNPTCtHdy9NNU8rcG1x?=
 =?utf-8?B?V1gvZEFyMXJtbEdqcGxaVXlYNGVPa0xOb2hIZzNRbmVRV0gyTTUyc3BsSjZq?=
 =?utf-8?B?UEhEeklmRXNQVlFCSHdPOXI0SE5iVzlxTXphOXR4QW1XbXU2UzJ2Z0ZaeHBR?=
 =?utf-8?B?NUxKRnljSDgvTUgvemUzWFA2NHRFWTFSZnh5dkdoWWVBR29GR01hRWdYdUFj?=
 =?utf-8?B?QlY0YUQraEtaeFNuUFUwVStWSkY2cjY4SFdNdlpuc3BQSFMyMUNsRCtFKzBy?=
 =?utf-8?B?UVBSdDBJNjhCdm9WbE5RWWxVVTVNWlZUSnQwRnA5R0ZwUDRBbFNoMUhleVhH?=
 =?utf-8?Q?gaed8m1qVKNpjcOTaqNhcfg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D258E65642EA246BB254426F34B5FE7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95dbb6bb-db16-441a-edfd-08db1eade3fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 01:47:20.5168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EFx7PUgiKrNFCuqm7vhKLV2tT9Eoe+5N+pLtVqn0WwV4CJF0KSUjihMb4cCOxOMzcKbgJnCUxYvFC3tMBRO+oYkl1j+39hdDRJ+BJQMLl9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5779
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIzLTAzLTA2IGF0IDEwOjU3IC0wODAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6
DQo+IE9uIE1vbiwgTWFyIDYsIDIwMjMsIGF0IDEwOjMzIEFNLCBFZGdlY29tYmUsIFJpY2sgUCB3
cm90ZToNCj4gPiBPbiBNb24sIDIwMjMtMDMtMDYgYXQgMTA6MTUgLTA4MDAsIEFuZHkgTHV0b21p
cnNraSB3cm90ZToNCj4gPiA+IE9uIE1vbiwgTWFyIDYsIDIwMjMgYXQgNToxMOKAr0FNIEJvcmlz
bGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPg0KPiA+ID4gd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4g
PiBPbiBNb24sIEZlYiAyNywgMjAyMyBhdCAwMjoyOTo0MFBNIC0wODAwLCBSaWNrIEVkZ2Vjb21i
ZSB3cm90ZToNCj4gPiA+ID4gPiBUaGUgeDg2IENvbnRyb2wtZmxvdyBFbmZvcmNlbWVudCBUZWNo
bm9sb2d5IChDRVQpIGZlYXR1cmUNCj4gPiA+ID4gPiBpbmNsdWRlcyBhIG5ldw0KPiA+ID4gPiA+
IHR5cGUgb2YgbWVtb3J5IGNhbGxlZCBzaGFkb3cgc3RhY2suIFRoaXMgc2hhZG93IHN0YWNrIG1l
bW9yeQ0KPiA+ID4gPiA+IGhhcw0KPiA+ID4gPiA+IHNvbWUNCj4gPiA+ID4gPiB1bnVzdWFsIHBy
b3BlcnRpZXMsIHdoaWNoIHJlcXVpcmVzIHNvbWUgY29yZSBtbSBjaGFuZ2VzIHRvDQo+ID4gPiA+
ID4gZnVuY3Rpb24NCj4gPiA+ID4gPiBwcm9wZXJseS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBT
aGFkb3cgc3RhY2sgbWVtb3J5IGlzIHdyaXRhYmxlIG9ubHkgaW4gdmVyeSBzcGVjaWZpYywNCj4g
PiA+ID4gPiBjb250cm9sbGVkDQo+ID4gPiA+ID4gd2F5cy4NCj4gPiA+ID4gPiBIb3dldmVyLCBz
aW5jZSBpdCBpcyB3cml0YWJsZSwgdGhlIGtlcm5lbCB0cmVhdHMgaXQgYXMgc3VjaC4NCj4gPiA+
ID4gPiBBcyBhDQo+ID4gPiA+ID4gcmVzdWx0DQo+ID4gPiA+IA0KPiA+ID4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCj4g
PiA+ID4gICAgICANCj4gPiA+ID4gICAgICAgICAgXg0KPiA+ID4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCj4gPiA+ID4g
ICAgICANCj4gPiA+ID4gICAgICAgICAgLA0KPiA+ID4gPiANCj4gPiA+ID4gPiB0aGVyZSByZW1h
aW4gbWFueSB3YXlzIGZvciB1c2Vyc3BhY2UgdG8gdHJpZ2dlciB0aGUga2VybmVsIHRvDQo+ID4g
PiA+ID4gd3JpdGUgdG8NCj4gPiA+ID4gPiBzaGFkb3cgc3RhY2sncyB2aWEgZ2V0X3VzZXJfcGFn
ZXMoLCBGT0xMX1dSSVRFKSBvcGVyYXRpb25zLg0KPiA+ID4gPiA+IFRvDQo+ID4gPiA+ID4gbWFr
ZSB0aGlzIGENCj4gPiA+IA0KPiA+ID4gSXMgdGhlcmUgYW4gYWx0ZXJuYXRlIG1lY2hhbmlzbSwg
b3IgZG8gd2Ugc3RpbGwgd2FudCB0byBhbGxvdw0KPiA+ID4gRk9MTF9GT1JDRSBzbyB0aGF0IGRl
YnVnZ2VycyBjYW4gd3JpdGUgaXQ/DQo+ID4gDQo+ID4gWWVzLCBHREIgc2hhZG93IHN0YWNrIHN1
cHBvcnQgdXNlcyBpdCB2aWEgYm90aCBwdHJhY2UgcG9rZSBhbmQNCj4gPiAvcHJvYy9waWQvbWVt
IGFwcGFyZW50bHkuIFNvIHNvbWUgYWJpbGl0eSB0byB3cml0ZSB0aHJvdWdoIGlzDQo+ID4gbmVl
ZGVkDQo+ID4gZm9yIGRlYnVnZ2Vycy4gQnV0IG5vdCBDUklVIGFjdHVhbGx5LiBJdCB1c2VzIFdS
U1MuDQo+ID4gDQo+ID4gVGhlcmUgd2FzIGFsc28gc29tZSBkaXNjdXNzaW9uWzBdIHByZXZpb3Vz
bHkgYWJvdXQgaG93IGFwcHMgbWlnaHQNCj4gPiBwcmVmZXIgdG8gYmxvY2sgL3Byb2Mvc2VsZi9t
ZW0gZm9yIGdlbmVyYWwgc2VjdXJpdHkgcmVhc29ucy4NCj4gPiBCbG9ja2luZw0KPiA+IHNoYWRv
dyBzdGFjayB3cml0ZXMgd2hpbGUgeW91IGFsbG93IHRleHQgd3JpdGVzIGlzIHByb2JhYmx5IG5v
dA0KPiA+IHRoYXQNCj4gPiBpbXBhY3RmdWwgc2VjdXJpdHktd2lzZS4gU28gSSB0aG91Z2h0IGl0
IHdvdWxkIGJlIGJldHRlciB0byBsZWF2ZQ0KPiA+IHRoZQ0KPiA+IGxvZ2ljIHNpbXBsZXIuIFRo
ZW4gd2hlbiAvcHJvYy9zZWxmL21lbSBjb3VsZCBiZSBsb2NrZWQgZG93biBwZXINCj4gPiB0aGUN
Cj4gPiBkaXNjdXNzaW9uLCBzaGFkb3cgc3RhY2sgY2FuIGJlIGxvY2tlZCBkb3duIHRoZSBzYW1l
IHdheS4NCj4gDQo+IEFoLCBJIGFtIGd1aWx0eSBvZiByZWFkaW5nIHlvdXIgY2hhbmdlbG9nIGJ1
dCBub3QgdGhlIGNvZGUuDQo+IA0KPiBZb3Ugc2FpZDoNCj4gDQo+IFNoYWRvdyBzdGFjayBtZW1v
cnkgaXMgd3JpdGFibGUgb25seSBpbiB2ZXJ5IHNwZWNpZmljLCBjb250cm9sbGVkDQo+IHdheXMu
DQo+IEhvd2V2ZXIsIHNpbmNlIGl0IGlzIHdyaXRhYmxlLCB0aGUga2VybmVsIHRyZWF0cyBpdCBh
cyBzdWNoLiBBcyBhDQo+IHJlc3VsdA0KPiB0aGVyZSByZW1haW4gbWFueSB3YXlzIGZvciB1c2Vy
c3BhY2UgdG8gdHJpZ2dlciB0aGUga2VybmVsIHRvIHdyaXRlDQo+IHRvDQo+IHNoYWRvdyBzdGFj
aydzIHZpYSBnZXRfdXNlcl9wYWdlcygsIEZPTExfV1JJVEUpIG9wZXJhdGlvbnMuIFRvIG1ha2UN
Cj4gdGhpcyBhDQo+IGxpdHRsZSBsZXNzIGV4cG9zZWQsIGJsb2NrIHdyaXRhYmxlIEdVUHMgZm9y
IHNoYWRvdyBzdGFjayBWTUFzLg0KPiANCj4gSSByZWFkIHRoYXQgYXMgKmRlbnlpbmcqIEZPTExf
Rk9SQ0UuICBNYXliZSBjbGFyaWZ5IHRoZSBjaGFuZ2Vsb2c/DQoNCkkgdGhpbmsgbWF5YmUgc29t
ZSBoZWxwZnVsIHRleHQgbWlzc2VkIHRoZSBxdW90ZSBpbiBCb3JpcyBjb21tZW50IGFib3V0DQpv
dGhlciBpc3N1ZXM6ICJTdGlsbCBhbGxvdyBGT0xMX0ZPUkNFIHRvIHdyaXRlIHRocm91Z2ggc2hh
ZG93IHN0YWNrDQpwcm90ZWN0aW9ucywgYXMgaXQgZG9lcyBmb3IgcmVhZC1vbmx5IHByb3RlY3Rp
b25zLiINCg0KQnV0LCB5ZWEsIHRoZSB0ZW5zZXMgYXJlIGhhcmQgdG8gcGFyc2UuIE1heWJlIHNv
bWV0aGluZyBsaWtlIHRoaXM6DQpUaGUgeDg2IENvbnRyb2wtZmxvdyBFbmZvcmNlbWVudCBUZWNo
bm9sb2d5IChDRVQpIGZlYXR1cmUgaW5jbHVkZXMgYQ0KbmV3IHR5cGUgb2YgbWVtb3J5IGNhbGxl
ZCBzaGFkb3cgc3RhY2suIFRoaXMgc2hhZG93IHN0YWNrIG1lbW9yeSBoYXMNCnNvbWUgdW51c3Vh
bCBwcm9wZXJ0aWVzLCB3aGljaCByZXF1aXJlcyBzb21lIGNvcmUgbW0gY2hhbmdlcyB0bw0KZnVu
Y3Rpb24gcHJvcGVybHkuDQoNCkluIHVzZXJzcGFjZSwgc2hhZG93IHN0YWNrIG1lbW9yeSBpcyB3
cml0YWJsZSBvbmx5IGluIHZlcnkgc3BlY2lmaWMsDQpjb250cm9sbGVkIHdheXMuIEhvd2V2ZXIs
IHNpbmNlIHVzZXJzcGFjZSBjYW4sIGV2ZW4gaW4gdGhlIGxpbWl0ZWQNCndheXMsIG1vZGlmeSBz
aGFkb3cgc3RhY2sgY29udGVudHMsIHRoZSBrZXJuZWwgdHJlYXRzIGl0IGFzIHdyaXRhYmxlDQpt
ZW1vcnkuIEFzIGEgcmVzdWx0LCB3aXRob3V0IGFkZGl0aW9uYWwgd29yayB0aGVyZSB3b3VsZCBy
ZW1haW4gbWFueQ0Kd2F5cyBmb3IgdXNlcnNwYWNlIHRvIHRyaWdnZXIgdGhlIGtlcm5lbCB0byB3
cml0ZSBhcmJpdHJhcnkgZGF0YSB0bw0Kc2hhZG93IHN0YWNrcyB2aWEgZ2V0X3VzZXJfcGFnZXMo
LCBGT0xMX1dSSVRFKSBiYXNlZCBvcGVyYXRpb25zLiBUbw0KaGVscCB1c2Vyc3BhY2UgcHJvdGVj
dCB0aGVpciBzaGFkb3cgc3RhY2tzLCBtYWtlIHRoaXMgYSBsaXR0bGUgbGVzcw0KZXhwb3NlZCBi
eSBibG9ja2luZyB3cml0YWJsZSBnZXRfdXNlcl9wYWdlcygpIG9wZXJhdGlvbnMgZm9yIHNoYWRv
dw0Kc3RhY2sgVk1Bcy4NCg0KU3RpbGwgYWxsb3cgRk9MTF9GT1JDRSB0byB3cml0ZSB0aHJvdWdo
IHNoYWRvdyBzdGFjayBwcm90ZWN0aW9ucywgYXMgaXQNCmRvZXMgZm9yIHJlYWQtb25seSBwcm90
ZWN0aW9ucy4gVGhpcyBpcyByZXF1aXJlZCBmb3IgZGVidWdnaW5nIHVzZQ0KY2FzZXMuDQoNCg==
