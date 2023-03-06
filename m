Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1806ACC15
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 19:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjCFSLY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 13:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjCFSLW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 13:11:22 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED4C4BEBB;
        Mon,  6 Mar 2023 10:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678126258; x=1709662258;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+euXGHoIXHXdJ+xyeGR7pHb14HG/2lOXEIBTvmopmnw=;
  b=ftcMWSlCTQzzJ6DLMU0pGLVAIcj2OL5lvuBq1CT6V4KGfjZOw0D3TJ8B
   3UoZs/XiPY3DscnOSK1gshrFcQKGe3Sy1JjK8ON+rA7c6oSswiCt6zNcc
   Bhp5MtuaZ+DnUod4WUzbcHcEDSnHB1YERMt0HpCUHfPDpM6tSd+z4wnL7
   gj5EQonHP3vKd6Ya4ClWw8bdhvikL1x9it5qe3IPprIMT05PDBYrsJdv9
   A3eXI3C4M7G5Byq9ooJWRS1O4s3JU5QYmh5iXvT/t0qzwwI6GYOLY8lo4
   HZQwkIwDFTlLuydneF8dtSPQZ+DNn3zm4Js5txeswiRJ0lN7MQnnf4O4T
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="421906349"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="421906349"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:08:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="922032751"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="922032751"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 06 Mar 2023 10:08:39 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 10:08:39 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 6 Mar 2023 10:08:39 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 6 Mar 2023 10:08:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGHHH8X9Y8pPED3M804CscJLx+qBIrgs97UWd6riXlLs93W9L9l0JUUGWD1CNBESGyV6n4kOlwyrU/P1DA6AZ+kkFAbvz5SWssCJYu5g7EI5h5s6TuNo5LewcwNKHjb7LGOiSUz/u41F2lH9OdpuQ6mSnobRtH0YSYbf9DQMhj/h3x6uBVXazQi3x6NCrG7tIRlWVhxwr16OK98Ps/nYmM1yT5nXeqpJwIYCiMZwbrIvQUG1KjL/caQZv6LWUPmxrTpbFvQdW3N7dBjJ7pbMchRH1p7A9ZlsktU/5Xj51UKyOkPBJQpzS90A+7WOIS3DkSVxAngbYEIvmc7AAv06xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+euXGHoIXHXdJ+xyeGR7pHb14HG/2lOXEIBTvmopmnw=;
 b=E0vb7dHwnsOnzHPHdZe3SwFEP1KUbXaXhiGbPEJQt5caOTBCMjYrbsifFAvZrIDnYNwAmazDxRvwW7CZbB/lxPPV0PDX4vbZu8U36Hl0ZTfDcjFfUwjOOIoOrD81tbxSWtRTUBxRaPUZfEd4a5Gtc3yysydhlKiiEVgmAglAECAc/0J+r1RZG4rc8jEpJ1Vu+anxZOPnL/pgAj38oAYfRH0KcHzFhSkhq53Giiw++uQp0cVhw9ea5fhFKUoxBtt4BXeKuKdZf2MmhE1zIqCiz7KgE/Jr3Zp+ZC9tV1r6xOShJxbpDoAX5TsmCDIU4jX14DEYbeAIWrzSF2reN/gYLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM4PR11MB5277.namprd11.prod.outlook.com (2603:10b6:5:388::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 18:08:36 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 18:08:36 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "fweimer@redhat.com" <fweimer@redhat.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>
CC:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
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
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>, "nd@arm.com" <nd@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 01/41] Documentation/x86: Add CET shadow stack
 description
Thread-Topic: [PATCH v7 01/41] Documentation/x86: Add CET shadow stack
 description
Thread-Index: AQHZSvs0qmse+4pcp0Wr5jGCLtkFY67l/FKAgAA/GgCAAAb6AIABcWmAgAH3BYCABE53AIAAAyxegAAa5wA=
Date:   Mon, 6 Mar 2023 18:08:35 +0000
Message-ID: <a205aed2171a0a463e3bb7179e8dd63bd4012e7e.camel@intel.com>
References: <Y/9fdYQ8Cd0GI+8C@arm.com>
         <636de4a28a42a082f182e940fbd8e63ea23895cc.camel@intel.com>
         <df8ef3a9e5139655a223589c16a68393ab3f6d1d.camel@intel.com>
         <ZADQISkczejfgdoS@arm.com>
         <9714f724b53b04fdf69302c6850885f5dfbf3af5.camel@intel.com>
         <ZAYS6CHuZ0MiFvmE@arm.com> <87wn3tsuxf.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87wn3tsuxf.fsf@oldenburg.str.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|DM4PR11MB5277:EE_
x-ms-office365-filtering-correlation-id: ab264411-5d6f-45f3-2a9a-08db1e6dcde4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hyPLj2mVuRmntzdZIsMNq6lYZG6XMXTgUphtEw9NlbQKycW9FwS7iP7BKuAmoJvjnGxEyHaUmoavzZIoJOyqDdACathYwRQejTdDDU7N947D224ceMfKJqBv8yE5kKQo1WqxyNSvQfp2ZykYkLpJtb2/gUDFdRc/nh6/TbMKliR9dv05E+5M57xCoUz7WxH2yE4Mf3cwW+OwD0VlyWY4OhNv8WdUCqQCjFESyQAC2FUwxAZaSS24ZBP6kVYVi81a+XEpDsxJ1eS0XIkhaWzOA46AjhceUs8oKp6aH6vP3k8Hi++0HMZYFSPWftgT2bRjm0dWeiCnFylUEg1Ktm6Ig60h7P6qfvHS2wshzkZdpchZWKFiU/Cf2nVlOf/qKAYalFjx76T+Q9bk+4dOoizyaO8Yt/yf1RzoAny+d/lalMGL8pKMUn8ma06bMOgUy+skzVnAy/MFtRRSSLg82Xyy6y66O1qvQWqCW3K9813gXmOR29LSxCD6L5QdMg4vpQHIR3oWJflkbPKZFV67HHvG1UrLYs1FGBAygaS2B+nudmcV05mYW0oOqMrzk4p3FNKCmqzcqlzCy0lEks9JRFooKaPI799CeEdctWeSS2xmF6n1wzaF/ugvbHWRgoGojGegyE+3H26H8EaiZieLqaq/911yXL9K91uogqlOMRnE9zQ2rVyNIL8Skam97HTX7fXzzxZrw1GfiDV2XEP+U+Flmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199018)(5660300002)(7406005)(7416002)(8936002)(66476007)(66446008)(41300700001)(91956017)(66556008)(66946007)(2906002)(76116006)(8676002)(64756008)(4326008)(66899018)(54906003)(110136005)(316002)(478600001)(71200400001)(36756003)(26005)(966005)(6486002)(6506007)(6512007)(186003)(2616005)(122000001)(82960400001)(86362001)(38070700005)(38100700002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0RBalNTQXpmZzhNTE9yR0NRMTZBM0tDWkZoSzUzRXVYSVpWL3YvWDA2ZCt2?=
 =?utf-8?B?M2MvelFnUlN6T2kvWndTYWFHa0VteGVNVTc5djJpTkRRYVE3enlEU2dhY3R3?=
 =?utf-8?B?QWxmMnFrQWkwSExOZFJzTmd4YUlsZGJWWGM0R0txQ1dxejJqMm9RZzZwR2VW?=
 =?utf-8?B?T3VKSnJreWM5VitTeVhTd1NaNmJCeUo0cXU5NUtENkNuazlYNzF3OXVERDlR?=
 =?utf-8?B?Q2l0VGpOT1ZRVzNCSFo2aW5QN2xuOE53ekpGQkhWaHhNOFFQVzc4M3Z1Zlgy?=
 =?utf-8?B?L05qdk1kM1ZTMHhEeE0rd3YzRDZkQ1JJTDRJM2xBdVAxOXlRS0ZOU2hITGhY?=
 =?utf-8?B?TVFqTGgxTHN1TGg3VmVENTBSOCtIaC94LzRmWFhOREtBMFZyUm9QT1AxTmpw?=
 =?utf-8?B?Vk9XT21GbVVWcEhpUlV5bnB0SSt6ZVM0N3VnNnlDMWJVL3JGdVRrL09yT2sw?=
 =?utf-8?B?aVBvamRuQU5mNm9LQnFTTEFTNUYrY0Iwald1NzNjYWc5Y1BNY2dNYXdGWlpI?=
 =?utf-8?B?bG83U3E1YXdSbjI2VlFEWHNwU2F2VG5Ib2x2RDF3eXJrQXUrNXBNUWFNM1dF?=
 =?utf-8?B?U3lEZkRZb3lxVWU2c0t2eGMvb1VZVVJQWldJT3RUeXp3M0pkRExNb2poajhK?=
 =?utf-8?B?dGR0ditaME1lYTVzK3p5Ty82Nzk3MkU0dGM1bm5XRnViTVlrRC9XbjlWWFhU?=
 =?utf-8?B?SWZqTlFRM2FPK05WYW43cHVFZnlIS1B3eGVZanpVQ1VPUVIzdkVoRy95K1hX?=
 =?utf-8?B?c2F1WlljS1FiMEY2OWVnRDBycnd4cWpmSG9rZ0VQYmdCQXNRc1p3RmlHMHFq?=
 =?utf-8?B?aVk1bE4ycDY1SHlxRlNreEJ1SXo0ejhFZHhlTXc3d2VoQk9qeUtzQVZrbk9u?=
 =?utf-8?B?Zlg0WUZhNzZIb0ZRY2pjMDlZZDM5Q3N0em1ZdzgvczAvaW9ZRHhPNm4zKytC?=
 =?utf-8?B?WUx4M2lYU3Z2RlRLMWRBYTVMT2toM2g4U3BnVXVOb3M5TkVqWks0YVFPbS9k?=
 =?utf-8?B?akR3aGpoZFZibW1jN3BXcmwzbjdTejRTMUJkbWJlZEJLWThNTGVtcTFYcnpE?=
 =?utf-8?B?TUw3aTNwdXpuMXYxYitMZ2I4MFpDZ05MYmMxNnFtZVpuU2lIT09HcVZmZWl2?=
 =?utf-8?B?RDUyT291RGdza29PdlBYM3JSMmZGT0U0TGEzcXEwMHF0ZTJ3TXRYYXlWL25r?=
 =?utf-8?B?VnpaRkhmVXdrMVQ2aVY4bmxlWkFvV2NoWlB6SlN3WHozc0lVa2QwZWNkSThC?=
 =?utf-8?B?TzJZelBRSDk1ck11Z09pOUEySUhoQ1N2TS9MV3FxVWVrQ1czTk4rSE5oaVc1?=
 =?utf-8?B?b290L1FBaUNRekNHQTFzbE1NVVRuSnROa3o2VVluMFFDWkQwTDJaQmttQVhi?=
 =?utf-8?B?Y3JJbWlBbGo0bkFzdllza0kxSDUyaGcreUJORVNacGhVUzk4azZMaGtacEJi?=
 =?utf-8?B?UlI1QVRqcm9oT3VlV0dIejViSStORmd6WVhVTy9qMXczd0RNWkowSitrYy9z?=
 =?utf-8?B?Zk1ldlUydWlPKy9CZkZGVGo1WFB0YWpjT21HT2g3cy8wMkYxbVpXOTJORENv?=
 =?utf-8?B?azlvZWs2MlZOcHdySFRQQVVEU3o5bWtpMFkvMEhIYzdkc0lwL3kxV3RqVFNj?=
 =?utf-8?B?T21yeHgzRHJMSTBDNE9wMDZOL2xXZkYzMzFIVjMvd3BhRFNqRzJZaThZTDA1?=
 =?utf-8?B?OVgvSGdiTVJjREJ4VVMwMGl5eFNRTUhiOTQ4WW44ZlpsOHlLRDdZRFN6Mi9P?=
 =?utf-8?B?SWZua0cxZ0J6NXpBd201dGNnUGszMml1Q0hQa1dTOGdURFJyUnRPYVR2aVc4?=
 =?utf-8?B?WWVQd1o2YmtldVUrUEtiamlhalBqWW13MW1Lc3NTMWtnTHNpRGhFUHlFTXlr?=
 =?utf-8?B?UU1QaWFIK3RtRW5QcWtPbzVzRlRUVWYvZk5oQk9LY2cvTm1ZamtadTBZTmc2?=
 =?utf-8?B?VEFtVGdnWkg4eDRicEc4WW9YVjBuaDdDaC9JbVVkTFhYUDBnaS9kL2V1Qk9F?=
 =?utf-8?B?YTlWbzFtVWVHdFFGcTlHSXhETmV1b2NSYlBnMWZzbUZoTllBMmVjMzZ0bTJD?=
 =?utf-8?B?Nk5YZUJXWlZiNUpwKzhnd3NSR3dxeTJDdGFwT1NUY2Z1UU91bnllQmpvUTd6?=
 =?utf-8?B?dDQ4Mis1QWd2cWlRTzQyMWRmZG0xYmhtTm5tUGNNUjl1akpESW9vS3RIcXhu?=
 =?utf-8?Q?OJsQQoyWjtfEWuzpNyouQbQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2B90DEB88348C48A38F0FA04206E3C1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab264411-5d6f-45f3-2a9a-08db1e6dcde4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 18:08:35.7451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PQ9pGJojODzpWWLgRDbz0kNfK6M+LGpkKny9wydeEmNmhgiS+NQBgStjw3peVwjQG0prH3oSD1HLAFc5IvQfj+Urm3h2i9KPh9S1Ayv76gk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5277
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIzLTAzLTA2IGF0IDE3OjMxICswMTAwLCBGbG9yaWFuIFdlaW1lciB3cm90ZToN
Cj4gSWRlYWxseSwgd2Ugd291bGQgaW1wbGVtZW50IHRoZSBiYWNrdHJhY2UgZnVuY3Rpb24gKGlu
IGdsaWJjKSBhcyBqdXN0DQo+IGENCj4gc2hhZG93IHN0YWNrIGNvcHkuICBCdXQgdGhpcyBuZWVk
cyB0byBmb2xsb3cgdGhlIGNoYWluIG9mIGFsdGVybmF0ZQ0KPiBzdGFja3MsIGFuZCBpdCBtYXkg
YWxzbyBuZWVkIHNvbWUgZm9ybSBvZiBtYXJrdXAgZm9yIHNpZ25hbCBoYW5kbGVyDQo+IGZyYW1l
cyAod2hpY2ggbmVlZCBwcm9ncmFtIGNvdW50ZXIgYWRqdXN0bWVudCB0byByZWZsZWN0IHRoYXQg
YQ0KPiAqbm9uLXNpZ25hbCogZnJhbWUgaXMgY29uY2VwdHVhbGx5IG5lc3RlZCB3aXRoaW4gdGhl
IHByZXZpb3VzDQo+IGluc3RydWN0aW9uLCBhbmQgbm90IHRoZSBmdW5jdGlvbiB0aGUgcmV0dXJu
IGFkZHJlc3MgcG9pbnRzIHRvKS4NCg0KSW4gdGhlIGFsdCBzaGFkb3cgc3RhY2sgY2FzZSwgdGhl
IHNoYWRvdyBzdGFjayBzaWdmcmFtZSB3aWxsIGhhdmUgYQ0Kc3BlY2lhbCBzaGFkb3cgc3RhY2sg
ZnJhbWUgd2l0aCBhIHBvaW50ZXIgdG8gdGhlIHNoYWRvdyBzdGFjayBzdGFjayBpdA0KY2FtZSBm
cm9tLiBUaGlzIG1heSBiZSBhIHRocmVhZCBzdGFjaywgb3Igc29tZSBvdGhlciBzdGFjay4gVGhp
cw0Kd3JpdGV1cCBpbiB0aGUgdjIgb2YgdGhlIHNlcmllcyBoYXMgbW9yZSBkZXRhaWxzIGFuZCBh
bmFseXNpcyBvbiB0aGUNCnNpZ25hbCBwaWVjZToNCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGttbC8yMDIyMDkyOTIyMjkzNi4xNDU4NC0xLXJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tLw0K
DQpTbyBpbiB0aGF0IGRlc2lnbiwgeW91IHNob3VsZCBiZSBhYmxlIHRvIGJhY2t0cmFjZSBvdXQg
b2YgYSBjaGFpbiBvZg0KYWx0IHN0YWNrcy4NCg0KPiAgIEJ1dCBJDQo+IHRoaW5rIHdlIGNhbiBh
ZGQgc3VwcG9ydCBmb3IgdGhpcyBpbmNyZW1lbnRhbGx5Lg0KDQpZZWEsIEkgdGhpbmsgc28gdG9v
Lg0KDQo+IA0KPiBJIGFzc3VtZSB0aGVyZSBpcyBubyBkZXNpcmUgYXQgYWxsIG9uIHRoZSBrZXJu
ZWwgc2lkZSB0aGF0DQo+IHNpZ2FsdHN0YWNrDQo+IHRyYW5zcGFyZW50bHkgYWxsb2NhdGVzIHRo
ZSBzaGFkb3cgc3RhY2s/ICANCg0KSXQgY291bGQgaGF2ZSBzb21lIG5pY2UgYmVuZWZpdCBmb3Ig
c29tZSBhcHBzLCBzbyBJIGRpZCBsb29rIGludG8gaXQuDQoNCj4gQmVjYXVzZSB0aGVyZSBpcyBu
bw0KPiBkZWFsbG9jYXRpb24gZnVuY3Rpb24gdG9kYXkgZm9yIHNpZ2FsdHN0YWNrPw0KDQpZZWEs
IHRoaXMgaXMgd2h5IHdlIGNhbid0IGRvIGl0IHRyYW5zcGFyZW50bHkuIFRoZXJlIHdhcyBzb21l
DQpkaXNjdXNzaW9uIHVwIHRoZSB0aHJlYWQgb24gdGhpcy4NCg==
