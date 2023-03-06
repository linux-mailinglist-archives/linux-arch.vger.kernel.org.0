Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D316ACBF3
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 19:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjCFSHH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 13:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCFSGy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 13:06:54 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476906F498;
        Mon,  6 Mar 2023 10:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678125994; x=1709661994;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rLg/kqfbyL1YQZzKhKNLaqe2TvD+Mwo4TMMRLbpi7N8=;
  b=AZbD8D+URhYS87DO5NNCba0mHl7Lv2Pu3FSZwzMmaGRVxIuahE4YFFVH
   DeL6P0/a5QKDpEQ66B7JbsLFNgu2ksxTbZz71e3p8BihxEco9vBS/cVr7
   QVlbXkM7hfSu/6klTdMBLL9QAOgDv57XTfH0DsnZQwY6z3JELcTpnj4jg
   xBx7zu1vIghT7kmHqnlIYIa/qBYrFtCF/2Y+2bZycRQEopN9REO8rYHSV
   jSxvLsyAGYg1QrM+91YAm8yfQzbigszNmHXYr6BD6cSKKjOu+V4HSvzT3
   eSbDKAZzhIF1juW9ni8Qjiw0OTI7Od3bBDMmyiymtvctYvmIc+zdiqlQZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="421905309"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="421905309"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:06:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="669542773"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="669542773"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 06 Mar 2023 10:05:43 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 10:05:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 6 Mar 2023 10:05:42 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 6 Mar 2023 10:05:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ub3uR2LR4g+x1KSEvsZu892ePI8f5aS9lmgROMUKyHG2onnqjx/Cl9ooKQKC7x8+LGoO8rvtoOwbPytWfGqzUU7ksmEemr/nEERBlkIHuhnGN8c0238Wf4g5QNkKD79Wz6NtOtWYKhn7PqNq5aYrzmW3jtxjGjMWCKbvQslHxIsu+aFwFDlbrhjQuc0dgaNfKK1TGq2En0PyxvkqTrISJ9Ji67/QwpymF7pCS8Si/zTR49TdDFFv7skmkBNirGn3jhWWIQanaKPT98+GE3Hyix4igPDlg+6cbU/SPsjFSmiVHREOBjBpmXqrR+bIOHBe5egGEEfsjisN2oqXkPCQJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLg/kqfbyL1YQZzKhKNLaqe2TvD+Mwo4TMMRLbpi7N8=;
 b=AfepzFNfp5apzjFdAFGoOItiUxFAeMS+c5/D9ig0zHt0v89+7HlaDik2mJrjCnOWi8YtW0WYqXIXbE31PSa4iX+vcXklGCVKPNYvYFODWiGAdOHfMIrlqPX2Gu6FxbM9NUrtAzZ+loRI3hc7VyXhmhg46bTT55QknZzjYTsV+SNAJXq3tX7z1s12XmchBGLNopyT7tvlApEhfdKtrTYPMua23O1wlVhSZHCWRum34o0Mx6r4AIEAA+FTSxwEsN1K8Iw73hRtf++PccHhlUTgxmKqwwn0Pe78FBqn40V0aTCSZzbLroanj+KLEc4Nv4N7BjP6Q5an+b48NQu/4CG/fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CO1PR11MB5060.namprd11.prod.outlook.com (2603:10b6:303:93::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Mon, 6 Mar
 2023 18:05:40 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 18:05:39 +0000
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
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "Liang, Kan" <kan.liang@intel.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>, "nd@arm.com" <nd@arm.com>
Subject: Re: [PATCH v7 01/41] Documentation/x86: Add CET shadow stack
 description
Thread-Topic: [PATCH v7 01/41] Documentation/x86: Add CET shadow stack
 description
Thread-Index: AQHZSvs0qmse+4pcp0Wr5jGCLtkFY67l/FKAgAA/GgCAAAb6AIABcWmAgAH3BYCABE53AIAAHUEA
Date:   Mon, 6 Mar 2023 18:05:39 +0000
Message-ID: <7b571c394839073cdc338b6718a363f44c9ba072.camel@intel.com>
References: <Y/9fdYQ8Cd0GI+8C@arm.com>
         <636de4a28a42a082f182e940fbd8e63ea23895cc.camel@intel.com>
         <df8ef3a9e5139655a223589c16a68393ab3f6d1d.camel@intel.com>
         <ZADQISkczejfgdoS@arm.com>
         <9714f724b53b04fdf69302c6850885f5dfbf3af5.camel@intel.com>
         <ZAYS6CHuZ0MiFvmE@arm.com>
In-Reply-To: <ZAYS6CHuZ0MiFvmE@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|CO1PR11MB5060:EE_
x-ms-office365-filtering-correlation-id: 1b20c0b3-ee7b-4226-ee9c-08db1e6d64da
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aI4kL0iiDH3WOGZoxh1MwMQSbH3FlturO6jtdT2s8z9lCsQeufkSyjtHer3Vur25qBphQwyaJe99JPw9yDyrk6tHuafY3lieIBdih28gwgIoJgDYZ72YN+2UHVHnxFr5Pkdfx61LuYGccOvqdSVJsvMKFhf3mBkjxQpSOwFU2Xoc+jYw7XR2q1xVqPdaTluAoTWJ7DVt0ygbcB2VbRRqxVzAagGizLOQPscUIsEXPk1SGLpaR4+GVuJDgW8PrTEdKrokoyfFABM8WWh1GpJWv3Q3I98KQSAwVSlZOpuUDL4Vg1YXK9M9gJoJWMbNPiuHgJGfceXzphxu1GBxR+C2l6AAUeLyebjnleZQ9IRXNgE7h8/m921/eAkI7sRXokTDceBPZ4CnYO6qq64aeXPo0Gc9ECD0ND2Q9v43qx7fTTIw4LVP3AuSzfp4+Rm8HJeCgFOvbKyh8hm4Slh+hEySTQsq0pBWm0zC5D87xaSVyto/ZaCQKJF784NqgPA8VSOSnVQajMfFlgnrEHcOxdwB84eWmcVLPwvNahcCcjdvA37UnYuaI1D+jKi66Col0GP5hX09oMpxi0c7S1BYAxA48KWh7nyH/mXPXPBey3wWPeaqLi94kWf3gppU3hyyaqMdLed2aYimfT9gTMWryrgcLSfxjDPDkMwbe4ugCqVV8mVZ+C6nzEexx+CPlde40Hj5Y3jtlcquhHXzg3ky+5QJssr+hSHxc6USkrB2fsk+1TF94eOtTbpsWkhF5XRkSSkj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199018)(8936002)(7406005)(7416002)(5660300002)(66446008)(66476007)(41300700001)(91956017)(66556008)(76116006)(66946007)(2906002)(64756008)(4326008)(8676002)(316002)(110136005)(54906003)(478600001)(71200400001)(36756003)(6506007)(6512007)(26005)(6486002)(186003)(2616005)(86362001)(122000001)(82960400001)(38070700005)(921005)(38100700002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTVvRUJCNnBsOVVXMFdlNkxPUkpuRmE0enlobzJUeURjVXByQXp2eDhpd2ZP?=
 =?utf-8?B?aVpEWmF0MGZSVUgxdXFVbThIWUIrcXNLSHlJR1IzZGcwaXVTdXlJS0RZL2Ra?=
 =?utf-8?B?VmZ0N1p1OS9GOURObDMrL29RUU9Ib1c2RjU2YUtpR0ptZVA4L1oxUUpUd3Iv?=
 =?utf-8?B?NDdwKy9NaFlWNkhkd1cyWVUxRFQ1MzZlR3o3U3RsZG1TYnZWSlE4VldKajl5?=
 =?utf-8?B?aDlVbC9seEhSR0xWUGp4SGtWK3FPbCs3NlNHYSt5NTlSZStJQXJFRkxHUVlM?=
 =?utf-8?B?ajFIL1dkQ3dWWGFvRjk2YnA1RStZVSsvY3ZNVmZLOVhMKzRaQTFuYlR4bEhY?=
 =?utf-8?B?MFM3UUdoNzhEWit5bWFZMTdUQzl6eUpaMzg2MkkxUXJVTE5rZkdqUHluOTQz?=
 =?utf-8?B?RFBuOEx6VkRsN3VVL2lGbFNzT2VqZjNtQVR6R1QvU2Z2QjZZSmV0d2Jkc0N1?=
 =?utf-8?B?d3lMQnZoVG00aVM5V2ROclJNNWdPb1BDY1ZzcjVoK2FPRU0xckNBZGtESEly?=
 =?utf-8?B?bW15NlhVWkJWV2wzWHBWbGttMkRPeE5INnArOEFBQ3lJZkk4ZEc0ME9GVHBs?=
 =?utf-8?B?UkkvZGxmOS9XeEdXYUI3Q0t3VWxYdHBuQjliWjg3Q2NEWllVWmlhWjZ0T1J5?=
 =?utf-8?B?aTZ3TkNZWC8xa0tLa0hDVExjWGhMWFdjdnVsd1BpSGhnL29CT3hLUUZjTnNE?=
 =?utf-8?B?ZytFWUlLNEpmdFlrSGxNWDU2ekV6OTc5R2JxSnQwdDJ1SDJJMm01VGVvUEh3?=
 =?utf-8?B?SnZDTVFVdExKcE9DekR0V3I2eEJwNG01YlRWbDIwUlgwZWVFcmRBcDNQSVR2?=
 =?utf-8?B?UjdCdGJpSkxUMmdnbDFrVFAyK0RyRUJYNlpYdFJnaHJ0aGtJeTdPR3Jab3di?=
 =?utf-8?B?R05qbFJNQ05LcTdVWTRlamlWcXliT1BDYmNycll0UnB0YXYxR2ZZYm0vL204?=
 =?utf-8?B?d3lwK3JoVTJTUGhGS1VXQjg3T09HSlg0S05QQlF2bW1ZU01UczIvYWhHdmhB?=
 =?utf-8?B?Mm9zSmlwSlhVL2lhdUlCem9pWDQra2N6WlRiSkVsRmw2d1ZUSzdGN2ZjSUov?=
 =?utf-8?B?OUlQNlBTWFNjdEpQYTBOR291Z0hLSGpDNFdpdjZXSjRsNEU5RXljbDlkUms3?=
 =?utf-8?B?S1NERVJNdDdRcHJJeWVuanFiSFFYT0R1WVdZN0JlckYrQWR3M3Y0bUg3TmdN?=
 =?utf-8?B?UlZQYlF0M3U4UkltMVJsMXZFN29Td3hxR3ZsOHlvZDJKd2VsQ2lKVnluR29Y?=
 =?utf-8?B?VEJjMWpJd0FBSHFhS0VkaW4vcjJHTGFVM0x2dGFyVXFTa2UvOHZqWlpLUE1J?=
 =?utf-8?B?ejUwdkQ2YnFkODhDVTRxNm5sRnpOa2VUSEM0aFJjdHVnT3BsdzNxeUx0WmhU?=
 =?utf-8?B?MXFRUlJKMHZqU3pWbGFaZitnNnpNV3pVakw3RmtGdUdsMmM4ZXdxRXlTdVh6?=
 =?utf-8?B?RFp4MXQzTDEweEM2ZWJsK2pxMElOSlQzQTZGZXFEd3doWnJraWowWnpSYnd2?=
 =?utf-8?B?bmxRVURDc3lSbmI4anVWZ1FXdWVMVkZwTGJDOHFpL2tpUUJhSnRzeUErcGlF?=
 =?utf-8?B?eEw1Unk3S0dWSldnMFpOV0tLNVBEMVp6ZmZEQXdlbEY3cU1ySWpXb09jZUlF?=
 =?utf-8?B?RjU0cFNKYkd5S2JGcjlCNHFoQUpkdzdheitweU5QOHl1MkkrRVdyV2NXS3M2?=
 =?utf-8?B?clpmRjJBVlhlUUVHMHNXQWEzallMbGgvTENXcEdvZUpPRDMrUm1CSWNnbUQ3?=
 =?utf-8?B?WVhVT0xoS0xUOW1pVFZTbzdHdCtIay9mS0JWSEtxUVZYMmVUa1ZDbWU4MExp?=
 =?utf-8?B?RFA4enN4enVialdQNzdvaUxCa1FSN1JtMVU1QUJSTEhPQStSVFRXS0pZaXJE?=
 =?utf-8?B?SGtTdVlkU3QwZXBicDMvMWpNeXZleFdZdVQxVVY0YldoNEkxbFFoZDBQWW5D?=
 =?utf-8?B?QkFiVm50R2VlNFFHTW5pb0p1aVI3S2VONnd4NThSNkpjc1M5WkM4UlpGV3Ro?=
 =?utf-8?B?eUFibzJWTVIzSXUrMXdJSFZ5V2wzK2x4dWd2T1J0ZzlBcjZ4L3FnWGJObWhU?=
 =?utf-8?B?T3pzeW1CRkx4YjdOSVI2d0FPaWQwKzlRcW44MXdIRDA2K3dBQmVCS0NFRUov?=
 =?utf-8?B?Qm9aSk1KWUNUZTY4Mm4wTVB1emxrTUI4b3Y2ZzZ2cStVUGV2M09ybnpBNUdS?=
 =?utf-8?Q?XS+xMhY7WPXje6mD20VnE60=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71B3A58B9F052545A99C31D8E09CF1ED@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b20c0b3-ee7b-4226-ee9c-08db1e6d64da
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 18:05:39.4926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FZrhZPgNxsv/sh5fi6wy4uUjopGBAsV9glT3dl1KazwqhFut5+c3HS31BsuoCaseZjjI9eLS7C7KOwte0bxdn+IbeaeJh3R5lwilmhiCzUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5060
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

K0thbiBmb3Igc2hhZG93IHN0YWNrIHBlcmYgZGlzY3Vzc2lvbi4NCg0KT24gTW9uLCAyMDIzLTAz
LTA2IGF0IDE2OjIwICswMDAwLCBzemFib2xjcy5uYWd5QGFybS5jb20gd3JvdGU6DQo+IFRoZSAw
My8wMy8yMDIzIDIyOjM1LCBFZGdlY29tYmUsIFJpY2sgUCB3cm90ZToNCj4gPiBJIHRoaW5rIEkg
c2xpZ2h0bHkgcHJlZmVyIHRoZSBmb3JtZXIgYXJjaF9wcmN0bCgpIGJhc2VkIHNvbHV0aW9uDQo+
ID4gZm9yIGENCj4gPiBmZXcgcmVhc29uczoNCj4gPiAgIC0gV2hlbiB5b3UgbmVlZCB0byBmaW5k
IHRoZSBzdGFydCBvciBlbmQgb2YgdGhlIHNoYWRvdyBzdGFjayBjYW4NCj4gPiB5b3UNCj4gPiBj
YW4ganVzdCBhc2sgZm9yIGl0IGluc3RlYWQgb2Ygc2VhcmNoaW5nLiBJdCBjYW4gYmUgZmFzdGVy
IGFuZA0KPiA+IHNpbXBsZXIuDQo+ID4gICAtIEl0IHNhdmVzIDggYnl0ZXMgb2YgbWVtb3J5IHBl
ciBzaGFkb3cgc3RhY2suDQo+ID4gDQo+ID4gSWYgdGhpcyB0dXJucyBvdXQgdG8gYmUgd3Jvbmcg
YW5kIHdlIHdhbnQgdG8gZG8gdGhlIG1hcmtlciBzb2x1dGlvbg0KPiA+IG11Y2ggbGF0ZXIgYXQg
c29tZSBwb2ludCwgdGhlIHNhZmVzdCBvcHRpb24gd291bGQgcHJvYmFibHkgYmUgdG8NCj4gPiBj
cmVhdGUNCj4gPiBuZXcgZmxhZ3MuDQo+IA0KPiBpIHNlZSB0d28gcHJvYmxlbXMgd2l0aCBhIGdl
dCBib3VuZHMgc3lzY2FsbDoNCj4gDQo+IC0gc3lzY2FsbCBvdmVyaGVhZC4NCj4gDQo+IC0gZGlz
Y29udGlub3VzIHNoYWRvdyBzdGFjayAoZS5nLiBhbHQgc2hhZG93IHN0YWNrIGVuZHMgd2l0aCBh
DQo+ICAgcG9pbnRlciB0byB0aGUgaW50ZXJydXB0ZWQgdGhyZWFkIHNoYWRvdyBzdGFjaywgc28g
c3RhY2sgdHJhY2UNCj4gICBjYW4gY29udGludWUgdGhlcmUsIGV4Y2VwdCB5b3UgZG9uJ3Qga25v
dyB0aGUgYm91bmRzIG9mIHRoYXQpLg0KPiANCj4gPiBCdXQganVzdCBkaXNjdXNzaW5nIHRoaXMg
d2l0aCBISiwgY2FuIHlvdSBzaGFyZSBtb3JlIG9uIHdoYXQgdGhlDQo+ID4gdXNhZ2UNCj4gPiBp
cz8gTGlrZSB3aGljaCBiYWNrdHJhY2luZyBvcGVyYXRpb24gc3BlY2lmaWNhbGx5IG5lZWRzIHRo
ZSBtYXJrZXI/DQo+ID4gSG93DQo+ID4gbXVjaCBkb2VzIGl0IGNhcmUgYWJvdXQgdGhlIHVjb250
ZXh0IGNhc2U/DQo+IA0KPiBpdCBjb3VsZCBiZSBhbiBvcHRpb24gZm9yIHBlcmYgb3IgcHRyYWNl
cnMgdG8gc2FtcGxlIHRoZSBzdGFjayB0cmFjZS4NCj4gDQo+IGluLXByb2Nlc3MgY29sbGVjdGlv
biBvZiBzdGFjayB0cmFjZSBmb3IgcHJvZmlsaW5nIG9yIGNyYXNoIHJlcG9ydGluZw0KPiAoZS5n
LiB3aGVuIHN0YWNrIGlzIGNvcnJ1cHRlZCkgb3IgY3Jvc3MgY2hlY2tpbmcgc3RhY2sgaW50ZWdy
aXR5IG1heQ0KPiB1c2UgaXQgdG9vLg0KPiANCj4gc29tZXRpbWVzIHBhcnNpbmcgL3Byb2Mvc2Vs
Zi9zbWFwcyBtYXliZSBlbm91Z2gsIGJ1dCB0aGUgaWRlYSB3YXMgdG8NCj4gZW5hYmxlIGxpZ2h0
LXdlaWdodCBiYWNrdHJhY2UgY29sbGVjdGlvbiBpbiBhbiBhc3luYy1zaWduYWwtc2FmZSB3YXku
DQo+IA0KPiBzeXNjYWxsIG92ZXJoZWFkIGluIGNhc2Ugb2YgZnJlcXVlbnQgc3RhY2sgdHJhY2Ug
Y29sbGVjdGlvbiBjYW4gYmUNCj4gYXZvaWRlZCBieSBjYWNoaW5nIChpbiB0bHMpIHdoZW4gc3Nw
IGZhbGxzIHdpdGhpbiB0aGUgdGhyZWFkIHNoYWRvdw0KPiBzdGFjayBib3VuZHMuIG90aGVyd2lz
ZSBjYWNoaW5nIGRvZXMgbm90IHdvcmsgYXMgdGhlIHNoYWRvdyBzdGFjayBtYXkNCj4gYmUgcmV1
c2VkIChhbHQgc2hhZG93IHN0YWNrIG9yIHVjb250ZXh0IGNhc2UpLg0KPiANCj4gdW5mb3J0dW5h
dGVseSBpIGRvbid0IGtub3cgaWYgc3lzY2FsbCBvdmVyaGVhZCBpcyBhY3R1YWxseSBhIHByb2Js
ZW0NCj4gKHByb2JhYmx5IG5vdCkgb3IgaWYgYmFja3RyYWNlIGFjcm9zcyBzaWduYWwgaGFuZGxl
cnMgbmVlZCB0byB3b3JrDQo+IHdpdGggYWx0IHNoYWRvdyBzdGFjayAoaSBndWVzcyBpdCBzaG91
bGQgd29yayBmb3IgY3Jhc2ggcmVwb3J0aW5nKS4NCg0KVGhlcmUgd2FzIGEgUE9DIGRvbmUgb2Yg
cGVyZiBpbnRlZ3JhdGlvbi4gSSdtIG5vdCB0b28ga25vd2xlZGdlYWJsZSBvbg0KcGVyZiwgYnV0
IHRoZSBwYXRjaCBpdHNlbGYgZGlkbid0IG5lZWQgYW55IG5ldyBzaGFkb3cgc3RhY2sgYm91bmRz
IEFCSS4NClNpbmNlIGl0IHdhcyBpbXBsZW1lbnRlZCBpbiB0aGUga2VybmVsLCBpdCBjb3VsZCBq
dXN0IHJlZmVyIHRvIHRoZQ0Ka2VybmVsJ3MgaW50ZXJuYWwgZGF0YSBmb3IgdGhlIHRocmVhZCdz
IHNoYWRvdyBzdGFjayBib3VuZHMuDQoNCkkgYXNrZWQgYWJvdXQgdWNvbnRleHQgKHNpbWlsYXIg
dG8gYWx0IHNoYWRvdyBzdGFja3MgaW4gcmVnYXJkcyB0byBsYWNrDQpvZiBib3VuZHMgQUJJKSwg
YW5kIGFwcGFyZW50bHkgcGVyZiB1c3VhbGx5IGZvY3VzZXMgb24gdGhlIHRocmVhZA0Kc3RhY2tz
LiBIb3BlZnVsbHkgS2FuIGNhbiBsZW5kIHNvbWUgbW9yZSBjb25maWRlbmNlIHRvIHRoYXQgYXNz
ZXJ0aW9uLg0K
