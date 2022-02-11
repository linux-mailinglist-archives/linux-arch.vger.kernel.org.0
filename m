Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC914B1BF2
	for <lists+linux-arch@lfdr.de>; Fri, 11 Feb 2022 03:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347122AbiBKCJo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Feb 2022 21:09:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242403AbiBKCJn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Feb 2022 21:09:43 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC655FAE;
        Thu, 10 Feb 2022 18:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644545383; x=1676081383;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fF8HtLwdc3SseUF0BhEMTiRVTDJdgoih5hd+E4uVp0k=;
  b=GhODXAwrjBMktouDJy+C3wnva2gQKA/msrhsBJIFJtLnkle0mn1j35q5
   VT5GVSXL9cQz3++GhLBVYHeDLMXtCSffNVKII5qQ8rbLWGRYXypOR//BC
   hRMinm1kfDJs97Z+8o6Y8xdUlCVNxxOvPh4naq8xwu+OlSXUd2XL9OOhV
   kcsDfedTnayXgd72HbqjR9XTSvZ7LmIUyvWuN03pMVLMa64LWhLkJA4ri
   K7RWWuS633A2Li4yKZRFrjGEPIN/0ZXjZVkmhY/4TZjJ2BpZr8QgNIeaY
   iZQcKI1Cpjl89qvCP8akcBCKiPoZdkjjml8PdjJP7FcCbMfgEfoPFCDCv
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="248471357"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="248471357"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 18:09:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="701926615"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 10 Feb 2022 18:09:42 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 10 Feb 2022 18:09:42 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 10 Feb 2022 18:09:41 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 10 Feb 2022 18:09:41 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 10 Feb 2022 18:09:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMY3niSm3Gp651Z5jMaIb7wlfAaKwFdG8OrY3etfBXF0wm1sL7kJDuLu2PrhVXFbs/ynYLcxt2BS2JtEhUECbpe/2Wgq+ZbJS++iFgj2J7hY0pqxXs1LpuuCTgm0ZXHb8kpSUEmlq2mibjYMLzK+msT0ThCCjlW2KsTwkHYxAe8WDQ6Z+2UQBSMBhfdl/SGRdIezDcSxZDv6LodhOtrY6mGNHIOJWmXrBwwwOLsCM2kLStXtXNmdGwrxWAiGWW0AlXxbwxCanwiUWs8kMNiQZtgnnl7ZA2BZlzaWvYxKNvJrd86DpHP++611k8vSzkuGvhOr3gN/dsJEf8aERFaNeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fF8HtLwdc3SseUF0BhEMTiRVTDJdgoih5hd+E4uVp0k=;
 b=VVxNV7loYJbaCSNzgu5+LStykv9cYYkBrEDv3HmhpiQpSAa7fnwsBwUTw6Hp7KEolns1X85EeKgj5raiwFFCTvSjaAjuD5XmTpcQ+/2107Vhzas+TYYHbeRiKKnZph/pVMt02eSgypxXOfn9V8Xa1JOEPynMjgnIy5p3cUjk4Hrfgt5bKc4jmjE7/q2Wk1dErdaAjZnjFO8Es2d5wfWKXw0yelDpqKMojMKPWsa8Z+tGp39KufDYOqarOydBaRrUwQmcM+RiKYC6vO9kcJU8+A3otBDOO2HW2exJgZGHlGKheDpLJ31IzlDZCaPRlt2q7D1puEZWgjzKQLPOYSfASg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MN2PR11MB4416.namprd11.prod.outlook.com (2603:10b6:208:188::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Fri, 11 Feb
 2022 02:09:38 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15%4]) with mapi id 15.20.4951.021; Fri, 11 Feb 2022
 02:09:38 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
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
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: Re: [PATCH 26/35] x86/process: Change copy_thread() argument 'arg' to
 'stack_size'
Thread-Topic: [PATCH 26/35] x86/process: Change copy_thread() argument 'arg'
 to 'stack_size'
Thread-Index: AQHYFh91Rj66tgwW7EWlgeEMY1b8B6yJYjIAgARKZwA=
Date:   Fri, 11 Feb 2022 02:09:38 +0000
Message-ID: <062173c3525481f5dff28787dc9d818fe97bbfa0.camel@intel.com>
References: <87y22lvjlx.ffs@tglx>
In-Reply-To: <87y22lvjlx.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71efa6c4-0a37-401c-4fcc-08d9ed038eef
x-ms-traffictypediagnostic: MN2PR11MB4416:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MN2PR11MB441649481AB697CF5C0162BDC9309@MN2PR11MB4416.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zmB4Plar80Atr4czXl6oaPMMSDzbiqAzyQUkeaYMb0biksEQuupj9p8jBAJEGbSQDcSL1MzItUfGO102F0CZbJsjWWmxyzVpS0cNfMKFhz7G1TGKieI0pFgEy3r+NDl3zBb03bPICVjGqSZBlw13144NA+BxDSXifx4J0xRL88nxnarK1ousoDg1dhW+Y/e0KvEqQjPy2iKGCTBAkRJQgKZcbb8NRpfiQJf0mM6264zko8rcdsqGpFQo0uOvyKsS0/HMsnQbkoOuhha9y/jNaZNRLGkp2AgafZQmBtpv4/zmreG/v38iDW0j6NcP7S3L21GBqu7urzauEjegDCbGeXZ4oKAlxoLsn3P1NWj1pwShpVZHk5acX+jrNz74YigEZc4qjpSi0wqhw2ZiMAIQ0ba92BsdJ+6rzOQSUE51LrjIKIwNpg+827X1y7LK/Xw9tFZaZ3rAZdMTmi1rnFxBtVYwAN5BqRGhE2EGDf0Gt9HF09SV0QZ2lnA0MXln2nrnwt07n8eJbXlMKNxnveu9xQBRFnYlgSkscfaZy+4SLXqjLCneGOqu4irPS9LcCCBR3z4prTFGMWqiP2flLukSFhCO6sbFBj3ZhecaldgEWkflmHEnr+le7wx49TAtoaQTd1w1rjrkWz21UkswZpL0d9Go493F+Ru5XxGOGdb5uQhdczqWULHLVe29eb/xWsR6u4KEqFzNJYf8+cTwSM+8BDVlSO+CZAKF57XhFBMYjO1EI1JE9DzgpPyGFYHQbLDo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7416002)(8676002)(122000001)(5660300002)(6512007)(2906002)(6506007)(36756003)(7406005)(4326008)(6486002)(86362001)(71200400001)(2616005)(38070700005)(66556008)(921005)(38100700002)(76116006)(66476007)(110136005)(66946007)(316002)(8936002)(66446008)(64756008)(508600001)(186003)(26005)(82960400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGtlVlFnUnQwenQ1bkVJa3RnK1N4YjNuNmFsY1VSSEttdWs0RW5kS2M4SHcw?=
 =?utf-8?B?TVNnbGloQmhVQUJvelFtd1NrQ3NOazBkYWRLbE9PVk9wNjYxcDVSKzBCc1BB?=
 =?utf-8?B?VXcrSVVTb2ZrVkxhZ2hNVGFVOGczazVvK2VYc3ZlQUFzbEFYZkRJTEVPZDU1?=
 =?utf-8?B?ZFRzUGlOaUdxblJoeGtwMUpzcVNaaTUvalZEQ2dSRDYxbnhabHRJODYyU29Q?=
 =?utf-8?B?L3R1a054bXpKUHBCOHozUkI5MVAya3YwWkdxYmpEb2txRE9DWHpxalVQTXNo?=
 =?utf-8?B?Z2hJSnRMYXZGYzRRNEhuaG96NWxuZzNSa25KL1B5RmFOREUxSnB0ekE5dFZw?=
 =?utf-8?B?aHNSdnk1WkFLaDYvMDVGZUtWaHBNZTRvSjBJbkNjbFROMHl6WGxYb1E3L2dp?=
 =?utf-8?B?S0VsS29ucTA3aWtmbWtrTW9VZnA2RnhrZUtxdzFPWW9TRVFma3hGQXFnVVpB?=
 =?utf-8?B?MFdzQ3pNWkpRbnBCZHNhVVlVQUtTb2ZyWXdLK3pKVjRYK0w1T0I4QXNsVlZO?=
 =?utf-8?B?NlhNZkF3QXo4SlJuZmpMYWczY1AwZUkrWDZMYW9OazZFcVQrbnM0WnpSZ1RY?=
 =?utf-8?B?amFWZDVrUmt1QXZoaVNpdzEyQ2pWKzlrbWN6cnNHNlZwRGtvM3ZPSEhHV2N3?=
 =?utf-8?B?c1dyR1BxbFVSY1dUc1VpRDFCdmp4WVB1bWQrWlhFQjJrNE5LdFpHUUxLZi9m?=
 =?utf-8?B?eXljdlp6Ykp5cnliQXh5QWxySTluajhBQVk1ZXYzaitTWkNIYU92bUliTzRQ?=
 =?utf-8?B?LzlCWGphQU5iSDd3cEx5YlFOVnREc25zT0VxMExVTWV1M05pU3Iyd3Q3YnlO?=
 =?utf-8?B?OEhrY1ZIY2U5T0RJRnVUYmg5aG1JdDM4ME9SQUlrMHpCUUlvRXVOK056QzFP?=
 =?utf-8?B?Q0N5aDhOT2xZeEU5WXlQMTR4NFk5M21HVUgvQkpCbWpRVWNaMXN1MjI1K0dl?=
 =?utf-8?B?aUgxa3ZlbXI4VGp4TTAweDRSNnJRbnZzbDNtNWZGY2pTWXdvK1lyM095MWNa?=
 =?utf-8?B?VWpMaVJXc1lVUjlMQWRtYnk1eUhJQlJsaCtBN3pMbXJMMEw4OTVNT1c2cTNC?=
 =?utf-8?B?eGtvNUpuUXdMWWhCejRxWElpWG5HWjhyZTFoR29zT0ZOKzVsRUZNZHRBQllN?=
 =?utf-8?B?R255MXNSUDRmVXFkTk9jRUwvRWJ3TjVxd2thVUVFNjZOaDk1MEw2WHZQVHZM?=
 =?utf-8?B?ZDU5c0g0WmNic0YrbzAxem8rU3RnMEhCaE5KMW1nNDV5b3RXMXhGRlB4My9w?=
 =?utf-8?B?dTBocG1vRTFUblhzTkxRS3MrNk9McGVQZ09oUUdiSnBFWGJROTFzTHRLM2dz?=
 =?utf-8?B?aVFNN3VGcXFycHhjSW9La3RzdmpuZXg3NFVTWHZoaVJwN0dibzRUUkt0elcz?=
 =?utf-8?B?amhEeDNPa0pNVzZieHZMUHpkWXRCOHFZTzlERFhYZXFXUWdKcnZVMFdrQ1RV?=
 =?utf-8?B?cS9JTE83bWVhZzNCWnR6VlFDdEdZNE1DT1owcmJNUUNlOWJUeEE2eXR1eFp1?=
 =?utf-8?B?TENVb1VwcTFGZGQxWFlsWHVybUl3VVg5K2lYZFRlWjc4bEczKzRmUTZydk16?=
 =?utf-8?B?WGFwbkp4RzI1VGMyUC9CMEtkQkc0WW8ySVpaMFBYck13TXhDQUNha01KMmVJ?=
 =?utf-8?B?MEI2NVNQUHFlZjdDUHlrRytBOElZOWRVQlhwQmUxNmF1dklIc240YmZ2WS90?=
 =?utf-8?B?SnBLWnUxZk0vWmpUVGN2Y0NBdHRkRHZ3QXBtS2dnS010QXB3a3dKV0daQzA0?=
 =?utf-8?B?Wi9TaUFHdkxPMWtZemE4dzdNL1VUMmlvMk5GNnA3dVMwUVpIb3RiMlNDcEJ3?=
 =?utf-8?B?dlVoTjQydzRCcTVhMGJtQnlkMy9HMXZRaHpmY1JhOWo1UWRCS3JaMlNYdFNt?=
 =?utf-8?B?TDkrQ1ViVlRwOUpUNjI0LzVmcmVaREJKaTZVRmIxSjFwVzZwZkkyZzNmSnBL?=
 =?utf-8?B?ME1TTTd4MkhHeTdzZTd1M1Z6eUlIVUJHWW45WmJFMWZPZnQ1UFpHZXBGNnF4?=
 =?utf-8?B?T1IwNU05ODhLVk9iaWhYTnhmSlRaSFJLb1NIWkhSYk4zOWRSMW93UEJjU0FW?=
 =?utf-8?B?QjNYaG5qMDJETE4zZWF6TmovNnYvVVdjVTVsTlBjcWRMODhkWFQ0eUM5cUtB?=
 =?utf-8?B?VHlHUmhtWEF6MkUzOFJrczEwcjRNOXpZMW1weEJnczVVQzM5WFNRQW9XN0VI?=
 =?utf-8?B?VkowZ2l1WDhmYk1wQXZpNEhQblliTklrUVVzVjJlVDJqOUJxYWNqY2VIN2h1?=
 =?utf-8?Q?IN6apeWKi93FkPj587c4/uK/HkB7x+qxBBP1fhHTz4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E29D8AE23B96DE4799DD5184EFD33FB0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71efa6c4-0a37-401c-4fcc-08d9ed038eef
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 02:09:38.5868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ImA6K8x57Mugscexa+81cEMcEHphyVvplsIEKJyRImWW6thIlGkH1wpMlGjkcSItzVR6x4dhmw4AnPwlNuerzqlGRy+6Z1kBVcCM9FbQAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4416
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIyLTAyLTA4IGF0IDA5OjM4ICswMTAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IE9uIFN1biwgSmFuIDMwIDIwMjIgYXQgMTM6MTgsIFJpY2sgRWRnZWNvbWJlIHdyb3RlOg0K
PiA+IC1pbnQgY29weV90aHJlYWQodW5zaWduZWQgbG9uZyBjbG9uZV9mbGFncywgdW5zaWduZWQg
bG9uZyBzcCwNCj4gPiB1bnNpZ25lZCBsb25nIGFyZywNCj4gPiAtICAgICAgICAgICAgIHN0cnVj
dCB0YXNrX3N0cnVjdCAqcCwgdW5zaWduZWQgbG9uZyB0bHMpDQo+ID4gK2ludCBjb3B5X3RocmVh
ZCh1bnNpZ25lZCBsb25nIGNsb25lX2ZsYWdzLCB1bnNpZ25lZCBsb25nIHNwLA0KPiA+ICsgICAg
ICAgICAgICAgdW5zaWduZWQgbG9uZyBzdGFja19zaXplLCBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAs
DQo+ID4gKyAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIHRscykNCj4gPiAgIHsNCj4gPiAgICAg
ICAgc3RydWN0IGluYWN0aXZlX3Rhc2tfZnJhbWUgKmZyYW1lOw0KPiA+ICAgICAgICBzdHJ1Y3Qg
Zm9ya19mcmFtZSAqZm9ya19mcmFtZTsNCj4gPiBAQCAtMTc1LDcgKzE3Niw3IEBAIGludCBjb3B5
X3RocmVhZCh1bnNpZ25lZCBsb25nIGNsb25lX2ZsYWdzLA0KPiA+IHVuc2lnbmVkIGxvbmcgc3As
IHVuc2lnbmVkIGxvbmcgYXJnLA0KPiA+ICAgICAgICBpZiAodW5saWtlbHkocC0+ZmxhZ3MgJiBQ
Rl9LVEhSRUFEKSkgew0KPiA+ICAgICAgICAgICAgICAgIHAtPnRocmVhZC5wa3J1ID0gcGtydV9n
ZXRfaW5pdF92YWx1ZSgpOw0KPiA+ICAgICAgICAgICAgICAgIG1lbXNldChjaGlsZHJlZ3MsIDAs
IHNpemVvZihzdHJ1Y3QgcHRfcmVncykpOw0KPiA+IC0gICAgICAgICAgICAga3RocmVhZF9mcmFt
ZV9pbml0KGZyYW1lLCBzcCwgYXJnKTsNCj4gPiArICAgICAgICAgICAgIGt0aHJlYWRfZnJhbWVf
aW5pdChmcmFtZSwgc3AsIHN0YWNrX3NpemUpOw0KPiA+ICAgICAgICAgICAgICAgIHJldHVybiAw
Ow0KPiA+ICAgICAgICB9DQo+ID4gICANCj4gPiBAQCAtMjA4LDcgKzIwOSw3IEBAIGludCBjb3B5
X3RocmVhZCh1bnNpZ25lZCBsb25nIGNsb25lX2ZsYWdzLA0KPiA+IHVuc2lnbmVkIGxvbmcgc3As
IHVuc2lnbmVkIGxvbmcgYXJnLA0KPiA+ICAgICAgICAgICAgICAgICAqLw0KPiA+ICAgICAgICAg
ICAgICAgIGNoaWxkcmVncy0+c3AgPSAwOw0KPiA+ICAgICAgICAgICAgICAgIGNoaWxkcmVncy0+
aXAgPSAwOw0KPiA+IC0gICAgICAgICAgICAga3RocmVhZF9mcmFtZV9pbml0KGZyYW1lLCBzcCwg
YXJnKTsNCj4gPiArICAgICAgICAgICAgIGt0aHJlYWRfZnJhbWVfaW5pdChmcmFtZSwgc3AsIHN0
YWNrX3NpemUpOw0KPiA+ICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+ICAgICAgICB9DQo+
IA0KPiBDYW4geW91IHBsZWFzZSBjaGFuZ2UgdGhlIHByb3RvdHlwZXMgdG9vIGZvciBjb21wbGV0
ZW5lc3Mgc2FrZT8NCg0KSW4gdGhlIGhlYWRlciBpdCdzOg0KZXh0ZXJuIGludCBjb3B5X3RocmVh
ZCh1bnNpZ25lZCBsb25nLCB1bnNpZ25lZCBsb25nLCB1bnNpZ25lZCBsb25nLA0KCQkgICAgICAg
c3RydWN0IHRhc2tfc3RydWN0ICosIHVuc2lnbmVkIGxvbmcpOw0KDQpBbmQgdGhlIHZhcmlvdXMg
YXJjaCBpbXBsZW1lbnRhdGlvbnMgY2FsbCB0aGUgc3RhY2sgc2l6ZTogYXJnLA0Ka3RocmVhZF9h
cmcsIHN0a19zeiwgZXRjLg0KDQpBZGRpbmcgbmFtZXMgdG8gdGhlIHByb3RvdHlwZSB3b3VsZCBj
b25mbGljdCB3aXRoIHRoZSBzb21lIGFyY2gncyBuYW1lcw0KdW5sZXNzIHRoZXkgd2VyZSBhbGwg
dW5pZmllZC4gSXMgaXQgYSB3b3J0aHdoaWxlIHJlZmFjdG9yPw0KDQoNCg==
