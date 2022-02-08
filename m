Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C65F4AE500
	for <lists+linux-arch@lfdr.de>; Tue,  8 Feb 2022 23:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiBHWxg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Feb 2022 17:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiBHWxP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Feb 2022 17:53:15 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C112BC07D8E5;
        Tue,  8 Feb 2022 14:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644360754; x=1675896754;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3rwTJhRqT7qkRvU+N6a5pCNmUKldEfzIq0eMlDLsR4E=;
  b=hBtaRtbVfq4vRdAnvfQD/P9vjsQTqVp6vUEu6bxhGVO2+97SlVjNgyoG
   jYWYpnaw3yMMOB4gaUcELYLNHqs+i0vNin1yPY9MNx8Bp0FHibxWLCYu5
   WdoPlyWoc9FYydqb+rxFvAfoExyr7H/bz8Tz/7xJDV6te0fVrVsgKzuHq
   PTAy2VuHSU7pP6oCu2qBgCgIEg1cZ3v4fzmNJwlKAlpSQOcy2/LqKhLXw
   2SrnQjsw+qaQkVgFZOnuV0KXYc6DyjBXC4Z61HuWwNYeC7fmuhgFzXSry
   ADiEBdUulTZircO9j6Aw7vap5pIRFlLFFJx6RcwZCW0H/eG+BXH6iNJ4w
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="248831390"
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="248831390"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 14:52:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="771141833"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga006.fm.intel.com with ESMTP; 08 Feb 2022 14:52:33 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 8 Feb 2022 14:52:33 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 8 Feb 2022 14:52:33 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 8 Feb 2022 14:52:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzT2Xk7ry50+0FN5CdaDyAP93Sv1sLvRnFt9p56oSfcN2+GbGRgMH6YQgghZVhdTGbavOhRhrzDbBV6ky47smZrortvsB3OAFM6QaiIdVzB78l7je6Qfs7cfSU2cOVcUVfikFXJN5yYfKL8GDDG2wW755vmvoOYSwZ2efwwnFPsQl6BtQGpuOZLxaJGrCHk49ANghTe38+UCC14tAuXHDcmSZiCHzhXxWgNM8DOB71x1H29mcEzxgo1VRQdMIAyHRo7YYwhsbmeF0JLs6bkWbAXpZo2GN3fSmgdzH8abhakeAptuibye/6wiwUGzzelCKvxdRppe8/oOCGfUgq0Lpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rwTJhRqT7qkRvU+N6a5pCNmUKldEfzIq0eMlDLsR4E=;
 b=ZX7blTEN1GcW7bMqsx3TfqbC+4Wd3zeudpyAXIQMF5gf3pK6sDdLD8t7U/gWDX/9aOm/jNAnm2T5tWlPgIBPgIbG62888bMnBfNMHWz2vjt2lAsocwOrqQ0xxIC7ewqrfbSA2EYAj5nWecZ3/+B0lH/8oJp8qSyUD5IP0gZS7UjJ+Idp8Chspa8m5ofa+ZnYj7UHLLuesZ0XnEZlEJJgqH7r/ja2WQ8rZr9IWeuUL5Z5m77YlJfi95ZEhkqr/tEiW+JsREYl0q9G2d9AnetbbS0u4Y/aycJ15MsCFly0kMyQlFctCm+gDWxvMFcWsm9kNXYQFmMJTaR92/QBziyxrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM5PR1101MB2250.namprd11.prod.outlook.com (2603:10b6:4:4d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Tue, 8 Feb
 2022 22:52:30 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 22:52:30 +0000
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
CC:     "hch@lst.de" <hch@lst.de>, "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: Re: [PATCH 07/35] x86/mm: Remove _PAGE_DIRTY from kernel RO pages
Thread-Topic: [PATCH 07/35] x86/mm: Remove _PAGE_DIRTY from kernel RO pages
Thread-Index: AQHYFh9tcGX9TNyOYECDo+sBHPRXAqyI1TmAgAF7oYA=
Date:   Tue, 8 Feb 2022 22:52:29 +0000
Message-ID: <bdb2711ae5ff0fc204ffcfd8ddccf3c2e105f297.camel@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
         <20220130211838.8382-8-rick.p.edgecombe@intel.com>
         <672fa390-c88c-4e2a-aa42-52d171acfd62@intel.com>
In-Reply-To: <672fa390-c88c-4e2a-aa42-52d171acfd62@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17c750bb-7158-44ed-d041-08d9eb55afc4
x-ms-traffictypediagnostic: DM5PR1101MB2250:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR1101MB22501B4338717608D72F5455C92D9@DM5PR1101MB2250.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gKeJjLMrymF6qfCBcF9972G7tJcdbbyqjS3ltbPBy3wdpi0mZKoNLQD6lAgy26DojO9d2+UcrkGllM+TA1dNB8wlctGMp2f71gStq1t/TIJbttvsLBvp+mGJUzhIfSg099PT5VScnynpMG4x65l5KvDtaWWaiFrPAF/Mauv5DtKhOlFNm5jfENawWg+Fyew+n21LLXRZLmeo9T63QtNneVg7nVnZrJaC/z7aJgea4aDw/XRaK83+zzd/clmBw9jzEd3RJLfZLT6KfyE2UkaRd7WwtRyg6MF1SdS5FYK6JM7YDoZA+1MtFOmCgr0A9/9Guww1Lyj3wNSvhnMdCNL6Ye787nYvKIlRDlWkd16jYNVPKdTAdXFjVFjZZRZCLZ+lDqbQ4vIh2kLWScdETpbUrqihiHizJ4STFzTTBgY31CKco1crp4VVNJyiYtgP1hClP8pCdhgMQHmFb1LNisaVaK+O3azsAcD/n+9kWH+tn0GLzOKjuQr0OLs3eOcc/wJMiAk7n0Or5VKGsIDMRa36qJzLJY1ZMDT6vMwJu6J7RZpNbu4oIaL+NcpXBjSp7siJKeW5GkmdvG5P1pxaqZO+ktt717A3lrAQdQqvM+mGsJeSPyM5cFbHqBmefBfFB7Grndh84vD8MwV6C1oMTJffqQIpXyYnVk7SiEnpeJT//wliR8QT4E/U6cw5YUNbusyZ40s9jnE3KnB0qDO1sy22E9XRpLczy4iG2lA0igFAU6q7ELPK8a6tS6dQ+6ZKO5GBN5YXXiBnTedhZs07JQt//g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(82960400001)(36756003)(122000001)(54906003)(38070700005)(7406005)(5660300002)(921005)(7416002)(110136005)(71200400001)(2616005)(38100700002)(186003)(26005)(316002)(508600001)(66446008)(66556008)(66476007)(4326008)(8676002)(86362001)(64756008)(2906002)(6486002)(76116006)(53546011)(6512007)(6506007)(66946007)(83380400001)(8936002)(99106002)(14143004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFJjdlBqQndKUmhldmtURzIvemtkR3E4NFhFU1I3ZXpMeS9tN1J1eTlpcld4?=
 =?utf-8?B?L3Vqb0s0eE5nNWxVdWNDOXlUVTlHMUp5UWVqelMyclBBRitPNmw3RXVsYXJi?=
 =?utf-8?B?TFl4WWVDL3JZY1FacnYwdXZ6U0ZPMmZRZ2hXT3NKUXZ1NUxtajVpNU5DUjhD?=
 =?utf-8?B?Q1UvclA0REVKNGZncVh1NHIzZDQwaEZQYTJIci8wczFYWWZha09wWFIxdTRY?=
 =?utf-8?B?SUpMRjRNNU1BWUtrR1NWTDk5YlBnN29pbFFiMTlhMUk5d0VINXhCemdmbkVI?=
 =?utf-8?B?VW1JMUYrZ01MRUNDK0oxemtIaDRHLzN1aTAzY0h3T2ltRkFHQTNjTEpkWTFY?=
 =?utf-8?B?cHJYZm5QZXBjZXM3dXE2cU5jaEhacEZiQU9uaEEzUC9lSzlrMzFZaE5wODNK?=
 =?utf-8?B?ZnJ0R1ZWNktrUkswYmRRUzF0MTVTWk9OL2pUUGcwREp6WkNDQzZSdTd3cnRH?=
 =?utf-8?B?ODNBL3BwbTZRa0NuMkladkE3b2NTd05GeG1tZVI0NEg4SUcvaDBaVktpUkRT?=
 =?utf-8?B?cnBrUXl2NGF1WnpSb0gyYzM1R1RCTmNmeVZ2NnQxSUJlRGlHMytkY1ArSVcv?=
 =?utf-8?B?UEpaZU5jK1hDcVNEQVRUc05CcHVVMTU0ZHRDeW9BZWcvNFRzdERpeGxEem5z?=
 =?utf-8?B?eTVLZENxL3VVTDl4U0J4ZlRrUW90cnovK0c4V2FPUlVabE1TWFphSjRseXg1?=
 =?utf-8?B?ZnZTMkdyQngxZElnSUJXTWJQeFVQKy9jbjA1M3VZQWN0MzFtQm0zc2dlQ1hB?=
 =?utf-8?B?R3ViR0QvYk5hdzg3RVBFa2JiZnVEQklGUjVLSUFRdk5YWU9LTkJjbml0VU9S?=
 =?utf-8?B?UFVzaVRVd0EyMlVaTWo2MDBBVXZHUzNvWmkzTkh5NXNmN3hIakZMZysrREF1?=
 =?utf-8?B?ODdJN2ZFRUFML21Ta05WdWJSaGFhaHNJK1BwUnorU1RrcVVoOGFQaXZTd3NW?=
 =?utf-8?B?M01RWW14c0JmZjZxckQvd1pxT3k4aUh5ajB3Y2h2bTZaQWtiWDZjM1pwelg0?=
 =?utf-8?B?ekJoSzV5UnpwZTByUXNZUmxqTUgvMGZhSUg5QUMwR0crSHNIWCtQQnB6WVBl?=
 =?utf-8?B?eEEwU253YXk4LzZtNkZ6czJJelNmMjFkRG1obm54MGlXd25iRElIWi9SMlcz?=
 =?utf-8?B?UmhmMk1vUFVWaVRicXN5YjM1ZllGS2YyNGtXUzJ3UFZ2VW5PK2FYT3M2c2oy?=
 =?utf-8?B?bzY0akdSY0hSV2VvczJWYXVmL1BOOTZiUlg4RFJlTG9HM1FtcWRaZWNRTExS?=
 =?utf-8?B?dGdLSUVXdHpwLzlkbXVEYUkyUy9jZk53M0lYanpseFhlcTBqZklYaG5oWkFU?=
 =?utf-8?B?Y0g5dSt2RHdQZmZxVi9tV21tcElZNHpHQy9WTDVrYjh6cDlYRXNESmxod3Bn?=
 =?utf-8?B?ZUJQbGoyS3RTNTVKWW1EQXNUaFFubEdEamNlZi84RkRBQy9zU2pZMGZwQmhn?=
 =?utf-8?B?TjF1UmlmR2g4cTJMdE1sVzhaWlJDQjVxc25NVjI2bFptSUVBN2xmVjRjVWVF?=
 =?utf-8?B?TU5xUEpYd2VNRS9GRkx5dlFsUFlNNVN0TndIR0ZMM1pDaVdYK0w2QmJSSXNH?=
 =?utf-8?B?Q2I3TDgyK0NaTlRyYmRrNUFyd0Z2T1hoWDFSSzdPWjhLb0VPbk1COTU0VUs4?=
 =?utf-8?B?MWt4OGNINWd6VnJ3d0VtNUFFY2lnZEcvNTdxangvWXVFY3poWDBPV3AzTTBS?=
 =?utf-8?B?Y1lQMUdQb0M2S1hyd0hJZFd5VkNRZVdyQ2FpRWgxcEx1WmNhK3owZmpjWG5v?=
 =?utf-8?B?SXRjemRYcUEvY2lBREhXWm9Wc2hGMjMxcStSNU90b09EMlJZcGIydXdzRTF4?=
 =?utf-8?B?bXJDWFpkb1RRTDdhWGdqQ2xOK2R0eXNobzBBQ1ltSElZWVR6aStWbmpzcEc2?=
 =?utf-8?B?d1JlWUQ4WVlBL3JISndwWlRmSVcxT0FXMlhRcmRTVUg2VTBkbjNwTy8ydGZw?=
 =?utf-8?B?NFNzdTlVUHBLNWFyc0hKY0x6eERMem52M3RqRndGanNyNHl5c0w2cjB2L2xK?=
 =?utf-8?B?eW0zNHpvNHBYL25EcXZXcVI3eHdNWGpNU0Z4SFRPU01sN0lPUkV1cXJRRlow?=
 =?utf-8?B?cXpUZ0M4ai9DRjJYbWY1a0piUUV4VVQ0ZDdwZnk4c0JqUXkvMmd5M01VYk5J?=
 =?utf-8?B?RmlEak1pVkJzK3E5U0lWTVZCT3JmZTB0YnFDd0NERlljZ0JtdnVRZk5TSTJW?=
 =?utf-8?B?UHRMb29mTGZVUlRQUGJneFhOZE9FWWgzbEsxOWsrV1NwUS9NcW1wdlVUL0Vo?=
 =?utf-8?Q?FHmJzLurldI6WxYnhikZxxtgWsvc0/YfiJ7bdDa5hg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1293B90985506458DD6E8082EE647C8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c750bb-7158-44ed-d041-08d9eb55afc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 22:52:30.0325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U5AqntrZM9mViXRbLzehbsn/Sfbsyw0X08aDQJMckftFhgdiznyapU6k3N1NiilZxebOjgFxCdFi68JJ3QlFtrZzpfctzGZiZ0dvCaO5N08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2250
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTAyLTA3IGF0IDE2OjEzIC0wODAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gMS8zMC8yMiAxMzoxOCwgUmljayBFZGdlY29tYmUgd3JvdGU6DQo+ID4gVGhlIHg4NiBmYW1p
bHkgb2YgcHJvY2Vzc29ycyBkbyBub3QgZGlyZWN0bHkgY3JlYXRlIHJlYWQtb25seSBhbmQNCj4g
PiBEaXJ0eQ0KPiA+IFBURXMuICBUaGVzZSBQVEVzIGFyZSBjcmVhdGVkIGJ5IHNvZnR3YXJlLg0K
PiANCj4gVGhhdCdzIG5vdCBzdHJpY3RseSBjb3JyZWN0Lg0KPiANCj4gVGhlcmUncyBub3RoaW5n
IGluIHRoZSBhcmNoaXRlY3R1cmUgdG9kYXkgdG8gcHJldmVudCB0aGUgQ1BVIGZyb20NCj4gY3Jl
YXRpbmcgV3JpdGU9MCxEaXJ0eT0xIFBURXMuICBJbiBmYWN0LCBzb21lIENQVXMgZG8gdGhpcyBp
biB3ZWlyZA0KPiBzaXR1YXRpb25zLiAgSXQgd291bGRuJ3QgYmUgd3JvbmcgdG8gc2F5Og0KPiAN
Cj4gCVByb2Nlc3NvcnMgc29tZXRpbWVzIGRpcmVjdGx5IGNyZWF0ZSByZWFkLW9ubHkgYW5kIERp
cnR5IFBURXMuDQo+IA0KPiB3aGljaCBpcyB0aGUgb3Bwb3NpdGUgb2Ygd2hhdCBpcyB3cml0dGVu
IGFib3ZlLiAgVGhpcyBpcyB3aHkgdGhlIENFVA0KPiBzcGVjIGhhcyB0aGUgYmx1cmIgYWJvdXQg
c2hhZG93LXN0YWNrLXN1cHBvcnRpbmcgQ1BVcyBwcm9taXNlIG5vdCB0bw0KPiBkbw0KPiB0aGlz
IGFueSBtb3JlLg0KDQpZZWEsIGl0J3Mgd3JvbmcuIFRoZSB3aG9sZSBwb2ludCBvZiB0aGUgbmV3
IGFzc3VyYW5jZSBpcyB0aGF0IGl0IGNvdWxkDQpiZWZvcmUgYXMgeW91IHNheS4NCg0KPiANCj4g
PiBPbmUgc3VjaCBjYXNlIGlzIHRoYXQga2VybmVsDQo+ID4gcmVhZC1vbmx5IHBhZ2VzIGFyZSBo
aXN0b3JpY2FsbHkgc2V0dXAgYXMgRGlydHkuDQo+IA0KPiAJCQkJICAgXiBzZXQgdXANCj4gDQo+
ID4gTmV3IHByb2Nlc3NvcnMgdGhhdCBzdXBwb3J0IFNoYWRvdyBTdGFjayByZWdhcmQgcmVhZC1v
bmx5IGFuZCBEaXJ0eQ0KPiA+IFBURXMgYXMNCj4gPiBzaGFkb3cgc3RhY2sgcGFnZXMuDQo+IA0K
PiBUaGlzIGFsc28gaXNuJ3QgKnF1aXRlKiBjb3JyZWN0LiAgSXQncyBub3QganVzdCBoYXZpbmcg
YSBuZXcNCj4gcHJvY2Vzc29yLA0KPiBpdCBpbmNsdWRlcyBlbmFibGluZyBzaGFkb3cgc3RhY2tz
Lg0KDQpSaWdodC4NCg0KPiANCj4gPiBUaGlzIHJlc3VsdHMgaW4gYW1iaWd1aXR5IGJldHdlZW4g
c2hhZG93IHN0YWNrIGFuZCBrZXJuZWwgcmVhZC1vbmx5DQo+ID4gcGFnZXMuICBUbyByZXNvbHZl
IHRoaXMsIHJlbW92ZWQgRGlydHkgZnJvbSBrZXJuZWwgcmVhZC0gb25seQ0KPiA+IHBhZ2VzLg0K
PiANCj4gT25lIHRoaW5nIHRoYXQncyBub3QgY2xlYXIgZnJvbSB0aGUgc3BlYzogZG9lcyB0aGlz
IGNhdXNlIGFuICphY3R1YWwqDQo+IHByb2JsZW0/ICBGb3IgaW5zdGFuY2UsIGRvZXMgc2V0dGlu
ZzoNCj4gDQo+IAlJQTMyX1VfQ0VULlNIX1NUS19FTj0xDQo+IGJ1dA0KPiAJSUEzMl9TX0NFVC5T
SF9TVEtfRU49MA0KPiANCj4gbWVhbnMgdGhhdCBzaGFkb3cgc3RhY2tzIGFyZSBlbmZvcmNlZCBp
biB1c2VyICpNT0RFKiBvciBvbg0KPiB1c2VyLXBhZ2luZy1wZXJtaXNzaW9uIChVPTApIFBURXM/
DQo+IA0KPiBJIHRoaW5rIGl0J3MgbW9kZXMsIGJ1dCBpdCB3b3VsZCBiZSBuaWNlIHRvIGJlIGNs
ZWFyLiAgKkJVVCosIGlmIHRoaXMNCj4gaXMNCj4gYWNjdXJhdGUsIGRvZXNuJ3QgaXQgYWxzbyBt
ZWFuIHRoYXQgdGhpcyBwYXRjaCBpcyBub3Qgc3RyaWN0bHkNCj4gbmVjZXNzYXJ5Pw0KPiANCj4g
RG9uJ3QgZ2V0IG1lIHdyb25nLCB0aGUgcGF0Y2ggaXMgcHJvYmFibHkgc3RpbGwgYSBnb29kIGlk
ZWEsIGJ1dA0KPiBsZXQncw0KPiBtYWtlIHN1cmUgd2UgZ2V0IHRoZSBleGFjdCByZWFzb25pbmcg
Y2xlYXIuDQoNClllYSwgSSB0aGluayB0aGlzIGlzIGp1c3QgYSB0eWluZyB1cCBsb29zZSBlbmRz
IHRoaW5nLiBJdCBpcyBub3QNCmZ1bmN0aW9uYWxseSBuZWVkZWQgdW50aWwgdGhlcmUgd291bGQg
YmUgc2hhZG93IHN0YWNrIG1vZGUgZm9yIGtlcm5lbC4NCkknbGwgdXBkYXRlIHRoZSBwYXRjaCB0
byBtYWtlIHRoaXMgY2xlYXIuDQo=
