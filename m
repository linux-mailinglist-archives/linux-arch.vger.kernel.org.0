Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2476B2BDA
	for <lists+linux-arch@lfdr.de>; Thu,  9 Mar 2023 18:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjCIRTE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Mar 2023 12:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCIRS2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Mar 2023 12:18:28 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA71F0FDA;
        Thu,  9 Mar 2023 09:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678382212; x=1709918212;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=krUPKZ8T/JbWkIp0tv3zyln7tTjbXKliYnXEpSPqMgE=;
  b=RccCy3Zm71JeyFXc6InHD15BulFiH85bZJGaOv6KMEqbSolFNBxEHVmI
   l/6kJ0Y2yEC9QYur7XORFqjqn9jhtuRIyak/wTSxnhEZ5AbAxOgjUxnbE
   ClO8NQDObQnSWwEJAudOdNgEuXAF3f4bm+MlqH1cKSP0O4gBPBeyNirAt
   g60LkSUxDe/cmtrrqLZt+mTtjHt4+Nu29iK/E1a4TTC4SA3niuwW9RhYU
   Oa0T5ckafDnWfnT75XEvSH0U5KtTsmA2Fm+Lfxzd5tQ2gGqWQioVKOq8r
   blCdQ2C7RMf/Qc/DFzIQDqpzy+070BAHLjH2YouNkMhAfmqNkf+Llz/6A
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="335209037"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="335209037"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 09:16:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="746399337"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="746399337"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 09 Mar 2023 09:16:50 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Mar 2023 09:16:50 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Mar 2023 09:16:50 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 9 Mar 2023 09:16:50 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 9 Mar 2023 09:16:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlYClPpOFUgscJiwcR/x0ysJ/VaZoHoOG63iQwTpeBrCgxOn9maXUlo0lAu0CQrE9KEQ41zURrNUBa2C8rFuqgJCA0VHTMt+Kn2hCviKTloN/lUmdk8neijixIAQvMbf33dHUKnkaTh68hGTj7hN2RlRo92ZnRGrGSHG470un8owBSC6Y6jtox830i01momTpvWCyndvZdddEFBZWg17uuSXnQ1gsjmykwz1x7wK8Cx0Wgmmlls9Tdo+bMDHIGmB8lI8sI6uAyiSDtptdkBmbC8uTb+5Rh0nO64jYe0GuBPlzaORdl9pAsM04pp7aN/O8TbYLlbYceMfKAAJ4jjuWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krUPKZ8T/JbWkIp0tv3zyln7tTjbXKliYnXEpSPqMgE=;
 b=Ph8b2CFAlSGrhTWpg0tl6f2NQovaLfsbgVOZ/VT6GcXywN4KJc0W5kexJKYUJG5mc3nLSvi4bfEIdQmEJs4e7QbbxrJU8zzqV6wQjWCS7yXWEUx5m8K09pb4AYZY2NWiTRvW/gb6G5jqShmhk1suN9lXaAbVzzxIi28n4ijOS8gEdlYccPFnmdubXeaMjO63E13dllCKUP0WNLNOmq03I+SIXWFO8B9nTZifHyTp8IS5M7tG5UH6rmP0KbZ1paXkJ/TzeNzJ1G6N6YMJ3wPuobkyKGgx8jdPaQi3N7g9ta7Nkfx9SuyhtArAe2Js7g2PsKF/6gAPMo74PkFqHc1GdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by IA1PR11MB8200.namprd11.prod.outlook.com (2603:10b6:208:454::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Thu, 9 Mar
 2023 17:16:43 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 17:16:43 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
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
Subject: Re: [PATCH v7 32/41] x86/shstk: Handle signals for shadow stack
Thread-Topic: [PATCH v7 32/41] x86/shstk: Handle signals for shadow stack
Thread-Index: AQHZSvtE/kXYLBcN0kysltITsUPy2a7yu+OAgAAD+oA=
Date:   Thu, 9 Mar 2023 17:16:42 +0000
Message-ID: <20faf06156782664690af6b4680c581640db53dd.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-33-rick.p.edgecombe@intel.com>
         <ZAoRI8J9MjOf58+r@zn.tnic>
In-Reply-To: <ZAoRI8J9MjOf58+r@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|IA1PR11MB8200:EE_
x-ms-office365-filtering-correlation-id: a387e6d2-e7ab-4549-d883-08db20c20d99
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /PbSHZFVM0ZGFt1ef5f+Whbrtj0iLKDBlYjaEA8jEAmePg8YihoKQOJorPRQHpoS6RFDFr0bTJgF6jBpSF8i9jWZbl/HJefgyQDANKd4IcewEAml8KAHduX6T2DnIZS0HRmHJm3lvVE3oKMcJfLgpD53bvaRZFi4eyeKT0EFBmj/b1OTMQ/r3UfOKN0oej/Copj0eI7FkFgmo0FB8V/k+O8lv7atemXJ7uxkSHCknWum4SqKdD543/PTQa1gUPrli52Jp4kK86VZlXBl4CvjF66jikwUJY+ffwceIE9lDTTB1WuSXZZjZZQGd1CeY2gQ5pFP+EzvPXg7y3MTwbRTRbjUjk6pfTA0l+QJQidtndVp/CTeg/3Z8yljJx6Y5t8VGrxUg+pPvdYi8Y81b3uyPzlJ0hvhlnlxk/o0Lm53Xg2+4bCLO6impuAbvv2ZKZBDfoo+F5gIg7vLo/H7NjQQVxIJF2++YVpZIgv/VeOEl2FAvUSoknDGzz+agtPqExw8jIL0D1+ggbJpdChkiHJDc40wPyGOiLHSHB6Gs+6PzSfgPJxfrLIYzjILdMatxKHpQmPzZaJH1Ix2Ddd+oQW2YvXXtgilTStdAs3+S4J9wXQ0rx9hN0XsdBtM2F251Yxted9Q+gb1aPCeKHzwqV5TcL39JV6OQ/ojrM4QAS2u2KgooBjB1eyB3TR8f2AR1JJrW+KN0azs9QvGNRkbMZN92Eb/ecUC8NA1N79uHo9CBew=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199018)(122000001)(26005)(91956017)(36756003)(8676002)(2906002)(82960400001)(316002)(38100700002)(4326008)(6512007)(66946007)(86362001)(66476007)(66556008)(186003)(64756008)(6916009)(6506007)(76116006)(38070700005)(66446008)(6486002)(41300700001)(7416002)(83380400001)(7406005)(8936002)(5660300002)(478600001)(2616005)(54906003)(71200400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0pIQmx5dElWM0xsbXVUanBHcTA1dE11Wk1LS2RqZS8vRDVtNjZ3eXV2VC9X?=
 =?utf-8?B?VGFqOFBiK1lUQi8wSy9aN0VLalIrYkVEclpvN3ZuQ21mZi8yOHV4ZHB5Qk9t?=
 =?utf-8?B?WDduamFaZzRZUzM4aFdMUnRBN3FheTd1bDAyeGJHNlFYYmxDYy9abHJpWmZB?=
 =?utf-8?B?cFVES0k1M3cvNDF5TTZ0emlQMTBtbmpTUUhXUXdCT2w4VUxSVW5BZklhMm42?=
 =?utf-8?B?RkNUODVSZllkR1RyNHdDMWJIaVVsVUpHbnlyT1lEMVpQaGJXa0JFRnBNV0w2?=
 =?utf-8?B?cElMWEY2MkE1eEFvazQvMTZXVWF2TXM3VW9qSy9Pd01rck9sNWgwQVNIRWpk?=
 =?utf-8?B?UlZSbC9KREd4TzRYZVdNU0Y1UU9KU2tYdFRxL0xsaGVlR0U5d2s5cExscnJG?=
 =?utf-8?B?cm1Tb0JNWXQ4VmZSTi8vbEl5ejhBcFVnaTRuZXVFNnZaQ1NoS2o4Y25VYnM3?=
 =?utf-8?B?K0x4cXpKbjJkaDFOZmtSVDArTENCWVcya3pqSUlsRXJGa0pLU3B2cFQwVCtJ?=
 =?utf-8?B?eFQ1WnByQmN5M3lETnZOeGRCUlhIYUp1UGhtUW15NXRiUzF1Wi94NzllRk9w?=
 =?utf-8?B?NVlGQ2dCaWZvZmNyRG5ndW1zK1lhalk1L2YzVnJOSVIzY3h6ZFNscTZuNC9m?=
 =?utf-8?B?a3ROZ3ZYRndpaEdGSHg2eGdPNXJHdkpmMUw5bjBJbHZnWnBPQTJ1UFRRam9H?=
 =?utf-8?B?TTJ1T0Y5djhJbXE3NCttdHl0aUdBT0hlSXFEdThaMFE3U0x4V2V3ZDZUVFpp?=
 =?utf-8?B?QU5sNlZOTGFRc3JsSnZqODJOeHlkWmU4U0djN3oxcUFNZzVpK3U4RjBxakJB?=
 =?utf-8?B?WXVWT1FlNU1GVDNITFBnWVJlbWl6dE9lNUhFaGp5dk5WM1RscUtVbVRSSVVx?=
 =?utf-8?B?NTdwMlBBVFp6ZDhiQWJyVzMrMTdtSWx0dlk5cmhOUGh4Wnl4RWF6RU9yeEly?=
 =?utf-8?B?c3piUmx0Ti9DRzZwZHNTKzFFdEpONTF5SnRUc3AzZGNTL0E3aFJUQjAzVEpF?=
 =?utf-8?B?Mm9sNjBrbWVqU1JBcHFLVk53YWlQWVU4eDlxQ0tUcWFvZXlRNEZaaEl5Uk9K?=
 =?utf-8?B?ZitLSVlQYTVsaWhVL3NjTVhTZHErUXEwcmtQaFgrTmtkbEp5Wms0TEo3K2M2?=
 =?utf-8?B?RFNLeG5WTWdza3hsZGZRS1BxOUxBMThYTi9yZ1h6VlU1Q0s5Yjk4KzlwbGJR?=
 =?utf-8?B?Y2FXOUMrQTdxUGZHcTRGQXE3Q01wc0hCWmNVUnAxdHNYUVdkMVcrRkQ4eGw0?=
 =?utf-8?B?cG5uMmV2bUJWWU1ISnBMa0JWcjJXNGQ3UFRRd3dnRFZEVWN2dWF2cnZJaE5I?=
 =?utf-8?B?cXh3d3NjQ3pmOWEvR1ZyajJ2L1VtenVhMWY0Qk9tTTE3QldyckhvMDJEN3do?=
 =?utf-8?B?M1NVbmtROGhWK0d4YUtaMlhsVFMzT0xlcUIydjRlWkJtNzI2SFpoenJRNEhu?=
 =?utf-8?B?NnZFVVl1czFWM2lJN0VPYmZqbmhJdkZhbkJwSDRheWhHdEhmMVVCNzdjbHVE?=
 =?utf-8?B?eTAwbFJ1VEQrdGJlVDg0MzJGaFQ2TFF2S2NQR094QlR4MWpmRGxkOU42Kzlk?=
 =?utf-8?B?SGFOUmhKWnJwNVc5aXNhZ0ovMzcrRXVrZkFkYUlWaGtiZ1J0T3NFeFRjd0FN?=
 =?utf-8?B?em44QXIzOGJFR2NmdUhDOHlnUks3TzVERHM4N3ZBaDdHbWNjV0ZmSGN2ald1?=
 =?utf-8?B?SVZkaFNrNkRxNjB2Tjd6a0tqMEVEc0F2aCtvdXpMR1daMElidTZCOW9ZV3o5?=
 =?utf-8?B?SnpuVFYxcGRNQW5TblplZWVuNDQ4a1QreDBxUzBOWTBYZWJ2ZjhjWGFaT3Fo?=
 =?utf-8?B?OGtDZ3V3VUkxSDQwVUVVcGM1WVY3SGZqd0JaT0daTkVWblY4TU9LNUVYZTd2?=
 =?utf-8?B?Z0g2b0p3Yis3Ui9menZRcXJQeTYyOHlZdnl0T0ZlbHROVEc2UGVqSVU3MEtI?=
 =?utf-8?B?SGl4NzNXMVBxUFEyVjNmVzRWMkxKSHBoTkEyT3dNcEhxTFJNdlhOcmRmVGR6?=
 =?utf-8?B?eFNUcThxVGRSR3ltMUxacEYzeFNab2x5ODQ4TWJGQ0pXbEJNL3lPejIyVklB?=
 =?utf-8?B?RGdyYkFpZVNCc3BZTGdXaStva25veDBlVDJtcUE4dmtmcmRndUdVbGF2TG9T?=
 =?utf-8?B?RWpYY3I3Q3VuTEMvcmxJZXNtczNvM2lZNnpwMkNUUXVzQ1ROdnM0bUM2OWp4?=
 =?utf-8?Q?helPwsylhlPykgHWy7oOMwA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E13883870523E41A4803CE74F666D62@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a387e6d2-e7ab-4549-d883-08db20c20d99
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 17:16:42.6987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r+G1VesyK6KLmlRkJJZPINpyFR4mL0wDqsOhrAgC681sLGuAXT3/XyCssKUYoq3AZy2sbrSJBt6+aQcEKw1KwsuFP3A7JKbfKH7hkojZy20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8200
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIzLTAzLTA5IGF0IDE4OjAyICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIE1vbiwgRmViIDI3LCAyMDIzIGF0IDAyOjI5OjQ4UE0gLTA4MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+IEZyb206IFl1LWNoZW5nIFl1IDx5dS1jaGVuZy55dUBpbnRlbC5jb20+
DQo+ID4gDQo+ID4gV2hlbiBhIHNpZ25hbCBpcyBoYW5kbGVkIG5vcm1hbGx5IHRoZSBjb250ZXh0
IGlzIHB1c2hlZCB0byB0aGUNCj4gPiBzdGFjaw0KPiANCj4gcy9ub3JtYWxseSAvLw0KDQpJdCBp
cyB0cnlpbmcgdG8gc2F5ICJXaGVuIGEgc2lnbmFsIGlzIGhhbmRsZWQgd2l0aG91dCBzaGFkb3cg
c3RhY2ssIHRoZQ0KY29udGV4dCBpcyBwdXNoZWQgdG8gdGhlIHN0YWNrIg0KDQo+IA0KPiA+IGJl
Zm9yZSBoYW5kbGluZyBpdC4gRm9yIHNoYWRvdyBzdGFja3MsIHNpbmNlIHRoZSBzaGFkb3cgc3Rh
Y2sgb25seQ0KPiA+IHRyYWNrJ3MNCj4gDQo+ICJ0cmFja3MiDQoNClJpZ2h0Lg0KDQo+IA0KPiA+
IHJldHVybiBhZGRyZXNzZXMsIHRoZXJlIGlzbid0IGFueSBzdGF0ZSB0aGF0IG5lZWRzIHRvIGJl
IHB1c2hlZC4NCj4gPiBIb3dldmVyLA0KPiA+IHRoZXJlIGFyZSBzdGlsbCBhIGZldyB0aGluZ3Mg
dGhhdCBuZWVkIHRvIGJlIGRvbmUuIFRoZXNlIHRoaW5ncyBhcmUNCj4gPiB1c2Vyc3BhY2Ugdmlz
aWJsZSBhbmQgd2hpY2ggd2lsbCBiZSBrZXJuZWwgQUJJIGZvciBzaGFkb3cgc3RhY2tzLg0KPiAN
Cj4gInZpc2libGUgdG8gdXNlcnNwYWNlIg0KDQpTdXJlLg0KDQo+IA0KPiBzL3doaWNoIC8vDQoN
Ck9rLg0KDQo+IA0KPiA+IE9uZSBpcyB0byBtYWtlIHN1cmUgdGhlIHJlc3RvcmVyIGFkZHJlc3Mg
aXMgd3JpdHRlbiB0byBzaGFkb3cNCj4gPiBzdGFjaywgc2luY2UNCj4gPiB0aGUgc2lnbmFsIGhh
bmRsZXIgKGlmIG5vdCBjaGFuZ2luZyB1Y29udGV4dCkgcmV0dXJucyB0byB0aGUNCj4gPiByZXN0
b3JlciwgYW5kDQo+ID4gdGhlIHJlc3RvcmVyIGNhbGxzIHNpZ3JldHVybi4gU28gYWRkIHRoZSBy
ZXN0b3JlciBvbiB0aGUgc2hhZG93DQo+ID4gc3RhY2sNCj4gPiBiZWZvcmUgaGFuZGxpbmcgdGhl
IHNpZ25hbCwgc28gdGhlcmUgaXMgbm90IGEgY29uZmxpY3Qgd2hlbiB0aGUNCj4gPiBzaWduYWwN
Cj4gPiBoYW5kbGVyIHJldHVybnMgdG8gdGhlIHJlc3RvcmVyLg0KPiA+IA0KPiA+IFRoZSBvdGhl
ciB0aGluZyB0byBkbyBpcyB0byBwbGFjZSBzb21lIHR5cGUgb2YgY2hlY2thYmxlIHRva2VuIG9u
DQo+ID4gdGhlDQo+ID4gdGhyZWFkJ3Mgc2hhZG93IHN0YWNrIGJlZm9yZSBoYW5kbGluZyB0aGUg
c2lnbmFsIGFuZCBjaGVjayBpdA0KPiA+IGR1cmluZw0KPiA+IHNpZ3JldHVybi4gVGhpcyBpcyBh
biBleHRyYSBsYXllciBvZiBwcm90ZWN0aW9uIHRvIGhhbXBlciBhdHRhY2tlcnMNCj4gPiBjYWxs
aW5nIHNpZ3JldHVybiBtYW51YWxseSBhcyBpbiBTUk9QLWxpa2UgYXR0YWNrcy4NCj4gPiANCj4g
PiBGb3IgdGhpcyB0b2tlbiB3ZSBjYW4gdXNlIHRoZSBzaGFkb3cgc3RhY2sgZGF0YSBmb3JtYXQg
ZGVmaW5lZA0KPiA+IGVhcmxpZXIuDQo+IA0KPiAJCV5eXg0KPiANCj4gUGxlYXNlIHVzZSBwYXNz
aXZlIHZvaWNlIGluIHlvdXIgY29tbWl0IG1lc3NhZ2U6IG5vICJ3ZSIgb3IgIkkiLCBldGMuDQoN
CkFyZ2gsIHJpZ2h0LiBBbmQgaXQgbG9va3MgbGlrZSBJIHdyb3RlIHRoaXMgb25lLg0KDQo+IA0K
PiA+IEhhdmUgdGhlIGRhdGEgcHVzaGVkIGJlIHRoZSBwcmV2aW91cyBTU1AuIEluIHRoZSBmdXR1
cmUgdGhlDQo+ID4gc2lncmV0dXJuDQo+ID4gbWlnaHQgd2FudCB0byByZXR1cm4gYmFjayB0byBh
IGRpZmZlcmVudCBzdGFjay4gU3RvcmluZyB0aGUgU1NQDQo+ID4gKGluc3RlYWQNCj4gPiBvZiBh
IHJlc3RvcmUgb2Zmc2V0IG9yIHNvbWV0aGluZykgYWxsb3dzIGZvciBmdXR1cmUgZnVuY3Rpb25h
bGl0eQ0KPiA+IHRoYXQNCj4gPiBtYXkgd2FudCB0byByZXN0b3JlIHRvIGEgZGlmZmVyZW50IHN0
YWNrLg0KPiA+IA0KPiA+IFNvLCB3aGVuIGhhbmRsaW5nIGEgc2lnbmFsIHB1c2gNCj4gPiAgLSB0
aGUgU1NQIHBvaW50aW5nIGluIHRoZSBzaGFkb3cgc3RhY2sgZGF0YSBmb3JtYXQNCj4gPiAgLSB0
aGUgcmVzdG9yZXIgYWRkcmVzcyBiZWxvdyB0aGUgcmVzdG9yZSB0b2tlbi4NCj4gPiANCj4gPiBJ
biBzaWdyZXR1cm4sIHZlcmlmeSBTU1AgaXMgc3RvcmVkIGluIHRoZSBkYXRhIGZvcm1hdCBhbmQg
cG9wIHRoZQ0KPiA+IHNoYWRvdw0KPiA+IHN0YWNrLg0KPiANCj4gLi4uDQo+IA0KPiA+IGRpZmYg
LS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvc2hzdGsuYyBiL2FyY2gveDg2L2tlcm5lbC9zaHN0ay5j
DQo+ID4gaW5kZXggMTNjMDI3NDczODZmLi40MGYwYTU1NzYyYTkgMTAwNjQ0DQo+ID4gLS0tIGEv
YXJjaC94ODYva2VybmVsL3Noc3RrLmMNCj4gPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvc2hzdGsu
Yw0KPiA+IEBAIC0yMzIsNiArMjMyLDEwNCBAQCBzdGF0aWMgaW50IGdldF9zaHN0a19kYXRhKHVu
c2lnbmVkIGxvbmcNCj4gPiAqZGF0YSwgdW5zaWduZWQgbG9uZyBfX3VzZXIgKmFkZHIpDQo+ID4g
IAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+ICANCj4gPiArc3RhdGljIGludCBzaHN0a19wdXNoX3Np
Z2ZyYW1lKHVuc2lnbmVkIGxvbmcgKnNzcCkNCj4gPiArew0KPiA+ICsJdW5zaWduZWQgbG9uZyB0
YXJnZXRfc3NwID0gKnNzcDsNCj4gPiArDQo+ID4gKwkvKiBUb2tlbiBtdXN0IGJlIGFsaWduZWQg
Ki8NCj4gPiArCWlmICghSVNfQUxJR05FRCgqc3NwLCA4KSkNCj4gPiArCQlyZXR1cm4gLUVJTlZB
TDsNCj4gPiArDQo+ID4gKwlpZiAoIUlTX0FMSUdORUQodGFyZ2V0X3NzcCwgOCkpDQo+ID4gKwkJ
cmV0dXJuIC1FSU5WQUw7DQo+IA0KPiBUaG9zZSB0d28gc3RhdGVtZW50cyBhcmUgaWRlbnRpY2Fs
IEFGQUlDVC4NCg0KVWhoLCB5ZXMgdGhleSBhcmUuIE5vdCBzdXJlIHdoYXQgaGFwcGVuZWQgaGVy
ZS4NCg0KPiANCj4gPiArCSpzc3AgLT0gU1NfRlJBTUVfU0laRTsNCj4gPiArCWlmIChwdXRfc2hz
dGtfZGF0YSgodm9pZCAqX191c2VyKSpzc3AsIHRhcmdldF9zc3ApKQ0KPiA+ICsJCXJldHVybiAt
RUZBVUxUOw0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+IA0KPiANCg==
