Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FB9652A45
	for <lists+linux-arch@lfdr.de>; Wed, 21 Dec 2022 01:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbiLUAGi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Dec 2022 19:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbiLUAGL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Dec 2022 19:06:11 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F311205F3;
        Tue, 20 Dec 2022 16:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671581084; x=1703117084;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qs9DblBFv3QG+wIg4IZDHSgU7Sr+uHoEFuMcMRurMRM=;
  b=QsAnFQGOernOTFJFhB0hRM+czb0R2nJHBdcPWTiOdvjNn3UVvlsr5fBL
   DjyfZ3evL1dP1FS3mpxBsbzIYqEliwreSsulAGRWjyCBHVN67LdH1/J1Y
   21YWDD3iKunCo5dd8cn9HucLt91vcOSn+YkeLPjL99IBtJjZTADKlKd6C
   RQ/5MH5rYxczo1DfPR0XxodYzYXta/Czsbo+H39qONZ0r0TmVoYoXYZlP
   DImPcavO8hj/sgIvv5+NC7BJtSdPs7blzh5O74z1ykSpip9kHj+BDWmLy
   h9dEVYes50sSzKbDWtaPmEzM+SeW6nyvQ+wXNROl839zzwiAX4Lr20ag3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="299421169"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="299421169"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 16:04:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="644645650"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="644645650"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 20 Dec 2022 16:03:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 20 Dec 2022 16:03:55 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 20 Dec 2022 16:03:55 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 20 Dec 2022 16:03:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MC9YmM15uKQzthXKp5QJFswYGo6fDRSe5+tQJNS7ug2xc/gkIJOgr7zmuqBAl5FFLJK9Iqtc2/cWd/d4HJHEUfoai6t3CmP3uyz78tSRHaVhYO+T/umGIJ2C3N5iLJ4/OpWaYG9qQQ6sZwk52Kic9eM8Ho9XKpWQz6ipdf+nHIYtUO8dcBWYfhIGqDXaU8ap9/i2wwgyqhw2wzRZPMlXJRn+kxMRMTB4rqwemvMxuiswHP1dH4mQAkRGPUZbuCj7A2aOaiX7YjHruGD//qAb9pfWfbmxuOSfKQHCQKo9n6eVK3iy9SuAJhvT/aegOjPyzx993LKHGxF7R7wKFl+Fvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qs9DblBFv3QG+wIg4IZDHSgU7Sr+uHoEFuMcMRurMRM=;
 b=dWtRTtOVBWpCskATLxY/P4hJo6GNvqj5LKXzYCOQ6BvtKRTkWZ6keooKZ/hNnFSoe8iakVFLR4kPyndelxTu5dSL1zCbYHozBvuCynuDusMLzbgTQiEj1C0+Fji0Zg7qJ65N2B7ObUBefGJ6UtFlTtGaJG3g+FyWioBB+myhpZNwC74Jex1lB8Vo7hLL/KWHwzs+TGLgY9ndTcZd2ZZG/BrEKf2+Av0/aM9tsRBfrn0JQopxiCLV5cE63sl8hniEJ9mn9B6BNVWj4kxpaOXKqvYNg7EDBVPiZHNAMXzAYPsld7qFBKCj5Z8VeV7YJ0E4ydsqjx05phm5M9Kwn80Jcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SJ1PR11MB6202.namprd11.prod.outlook.com (2603:10b6:a03:45b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 00:03:40 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff%5]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 00:03:40 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v4 06/39] x86/fpu: Add helper for modifying xstate
Thread-Topic: [PATCH v4 06/39] x86/fpu: Add helper for modifying xstate
Thread-Index: AQHZBq9TBYEQYQQ6ekKdB9Mwo7Cguq52yRYAgADI5QA=
Date:   Wed, 21 Dec 2022 00:03:39 +0000
Message-ID: <25b0158a998a280b508200fa50995aad657ef520.camel@intel.com>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
         <20221203003606.6838-7-rick.p.edgecombe@intel.com>
         <Y6Gk1CcK/dHWqaVA@zn.tnic>
In-Reply-To: <Y6Gk1CcK/dHWqaVA@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SJ1PR11MB6202:EE_
x-ms-office365-filtering-correlation-id: c03cb986-88d7-453d-a0e6-08dae2e6d0c5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tar8YG7uEqfCoBJET1Xmgk4GQiSfLIxTkygq52Z+jW4RMpKoWzVBYbNGM6XCE3Cmwm7s18wu/fspacZHAPlDc+zlYsOK6EhAIYbHmBUOBmBbbFXuFw3u5eqCrstiTYM5Rt7RJCo23yte+9sv3fgElpiuyAmhcweqaQ4m36SbOyv8KjaXrG2r3QMqfC4E1fR7nzPqa0eENDFZYEC714lXOJ1RaekSSmMquPJG2o3vf4uCyxyG9J7EtjxcTTQ1b58bvocI6wnNgtTUOtxLQtqRRJCYpQtiNeJcHoBBNt1ooYIlYoAVf4xIx7sxY6byBz4AkQPPnMStBHllUu8dCj1pAvjCqkYfnm7urLzn3h/UgGcBWek1LHH5vb/q/mXebNCymRHCQIa11dleYFUDFnDSkugpbkOA/xbK8qS7VmKJAHSHhszilhgS9ItNXaU9T4DuWu7AxcSY87duacyKrEcikOwcR70+1Oe1nLdm3m2iX6j+RJSxCCVGupV1g13ZpgeOorJWmUUBVgrZr3ZIqRG5R8GZ3OZKYpvGZaV2sPJEFfB2pnJOW9rlZPylm03PscGDEXZqduKzaLCa4AfMl9tYlrRWttxKX/U5ky7zfDXdqlmMhPUMIWNMi3tQZsc6rwnt13q5WJJH3IblqCKKJFQ7ZppArc0XmcmXRy0MTe7W2wDH1gL7+JtMFSYuFPaFsKr4Eoh0cChTVPURCdjOEugiOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199015)(82960400001)(38100700002)(41300700001)(8936002)(122000001)(66476007)(5660300002)(91956017)(7406005)(66946007)(66446008)(76116006)(64756008)(66556008)(8676002)(4326008)(7416002)(54906003)(6486002)(83380400001)(478600001)(6916009)(36756003)(38070700005)(4001150100001)(2906002)(316002)(26005)(71200400001)(186003)(6512007)(86362001)(6506007)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVZuV0poT0JhQ0M2VHZtVDBZd2FlNG0vY3RndVI2TS80SVdPY3BSU24xUDlY?=
 =?utf-8?B?a08zR1lTYmk3K2JXa1U0bGhETGU2R2lESkc1WFFjUWpvVFBYMWVCQ2VyRkZG?=
 =?utf-8?B?NGFRbjJ6UVFJUitDMDE4bzIwSkViLzNaNks1bVg3ajlNOFMxUWcyazJYNXVS?=
 =?utf-8?B?b09odXIwTkhTVTUzamp2WU5lQkZpYWpkV0Vha2o0cThCVi9taHYwbWZjTUE1?=
 =?utf-8?B?SEJJUFF0Z0gyQlNteUhUdmJ3NnMyOVQrdkZ5bW5lc2JQV2x3OW1hMVlRV0Jj?=
 =?utf-8?B?ZTh2ZUkwVnZDVG95MDhPOXd6SHdFcnZIREw5M2RmV0NjdTZRUWRZT2t6K1F0?=
 =?utf-8?B?bUsrYjZjVmQxTWo4WjU1dzFIS1duakpIaytIR1BvUnZUenJ2K2xEQ2hiOUht?=
 =?utf-8?B?anlPbXNMdllIbnBRY3FXMW5qYVl6MUdZVHJaWW1LRXpOOXBRYlNXSWp2TXZY?=
 =?utf-8?B?QTl4M2pXcmpyTkFSZzBvY3lnMFQxYU4rSHh3Sm9PQTcraytraHVpN3BXeVVu?=
 =?utf-8?B?MTNkYmd3Q1M0VTNZS2s0MlByTWRacVNlQmtkQ3R2V2hvVE5MUXR2ZncxcXIr?=
 =?utf-8?B?UXpxaDZXYkFYTDIrUjJFNWpVUzRRYnAyYkUyT3JSbnlsZGRhc1FBNldtdlBU?=
 =?utf-8?B?NHk1WlpWbWpZVGptd1ZWWlROcFBSV1h2d0l0eHpzc0pTcmw0QTdxQVdkV2tz?=
 =?utf-8?B?KzBWUGNiNTNDZlc3aGk2YlZXL2IxT21ZcnBSSms2TTRwQ2FWQ09LRVVTYWZ0?=
 =?utf-8?B?b21vSTB6dmpHd05ENnFtTkMyUUQwangwZHVNQ1hzT2NOT1NIZDFWek5LUERr?=
 =?utf-8?B?bmd2UzBkalhRS05aVW0rajA3Y1UwcDQ3WnhoeHYxMG9lenYvNVFLNGhRZUg3?=
 =?utf-8?B?NEIvQUNIdkRvNXZwSVo2TGkzVjMxUE5ERWVhbXRlaVRsbm9PZVphSTlzcFBB?=
 =?utf-8?B?ckxqS3dpb0t6NGxIMzN2c1NsVjBpdmI4ekJld3ZsU3Z0MzlNb0xpM1IxUEVP?=
 =?utf-8?B?L0NoSVVXOFAzSi96NEdEZko0bDFYVzNyYzZyVHdZaVVCcDF5VkFtY1RvYjlC?=
 =?utf-8?B?NEtkcEhLb2ZjVFlUSS9ET2RrQTN2UkZmZFh4SXZVdkxoMUVjSjZ1Q0dRMDhS?=
 =?utf-8?B?WDNNS2E5Qk5pTjlIMnFRckorTVJQcjZpUm1CNHdLYkZhbEU4VGdMLzdNem9I?=
 =?utf-8?B?UFVWT3hrdTQxbGNuYjQ4dnNRd3FTZmQ2TnBhdytIT1FURHN1eDA1U0cveVB5?=
 =?utf-8?B?dEdGczZ2RzFuOW5XRlhwTDJlemNNYW9wQ2xTaE81NUxHQVBhcnFnV1d5SXht?=
 =?utf-8?B?S3dHRDJCYnFodmNBWFBhczMxSnVJdUg0ODZIMXNHSlBPK1pPUlZieHFXakFn?=
 =?utf-8?B?YmNLaVkyN2llTkVhaDUra2ZPeGszTkUxeGJ1eGswUXcxMXg4aFNWeDhZQUFR?=
 =?utf-8?B?V0ViV0RNc01LajRpOWVNVTdqZFpOQ1BzT0pBNFhTSEdiSFVYMjNxMjV2aUJG?=
 =?utf-8?B?M2tBeW1SZFlUTUkwVmpXMlUxelBBQkhyZ2lSWTRRRTRhQzF6MmFMMktUaXM3?=
 =?utf-8?B?eVg4RE5OenZUQzl4RXF5OWpRNEpZaWpZRXVpdU5zTzVPSVR1aW51YVUwSXZT?=
 =?utf-8?B?TFdvSFdTbHVYMkFHeCtXcWMyUXdiMFNhNk56eDFpS1lGQnE4WExrWk1qa21v?=
 =?utf-8?B?MHl6U1A0N2hydnhzMWhmMFJITE04OVEwQ0ZITVBDMUFvNEN1ZzNxN2tnUXU3?=
 =?utf-8?B?eG9oQ2V2YTVLRW5uUEpQZ1hvbHNSc2ZyanAzaWh2Z1lFd2hsbWNZbDFQdjVl?=
 =?utf-8?B?dlhSUlN6Rk1aNzJBbE0xR2VNQUpWL2g5QlFZdlhQU1loMmZoajd4b0lGaytW?=
 =?utf-8?B?UC9sYnJkTk1wVVpISWkxd0sxTnJjVXp6eFVxc1RDYk00TEJjVTFiU0RiNUMx?=
 =?utf-8?B?bTJSWjByR25pNUVBb2N0MmxKQU1oVnpnWE1kNE9Nd3UyYS9GaE00V1dWTVh6?=
 =?utf-8?B?WXdreFM2WklDY0lzNTQ2RUVleHlOSWFiUTdTOEVWVU81QWJEYzYrekZTYUFn?=
 =?utf-8?B?ZGNtazVweTN6V2h4RmhGMXFZa2VnZkNlS3g3R3JZMEdhQXUwT1N0NzdYOWtn?=
 =?utf-8?B?Nld4U0h4V0p1Tnh2ZDVFdWpLNFY3RklRRFhacjZXK1ZlZG9xZTZ3SE84R0VR?=
 =?utf-8?Q?lVNvzwC4+PhoyXoMTRhTEsA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDBB731E6B1DA04CBA833C090215FA03@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c03cb986-88d7-453d-a0e6-08dae2e6d0c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2022 00:03:39.9002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RebpiEKzlKDlnN+dltrwfUXvL8M+MLl3TFti33NUUsflKN4Pr2lSgxmhBQuz4k+5+vU6+TUUi14Zz4hOR7Wgtp5tAzJd0EXOQUPrul+tELg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6202
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIyLTEyLTIwIGF0IDEzOjA0ICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIEZyaSwgRGVjIDAyLCAyMDIyIGF0IDA0OjM1OjMzUE0gLTA4MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+ICt2b2lkIGZwcmVnc19sb2NrX2FuZF9sb2FkKHZvaWQpDQo+IA0KPiBG
dW4gbmFtaW5nIDopDQoNClllYS4gU3VnZ2VzdGVkIGJ5IFRob21hcy4NCg0KPiANCj4gPiArew0K
PiA+ICvCoMKgwqDCoMKgwqDCoC8qDQo+ID4gK8KgwqDCoMKgwqDCoMKgICogZnByZWdzX2xvY2so
KSBvbmx5IGRpc2FibGVzIHByZWVtcHRpb24gKG1vc3RseSkuIFNvDQo+ID4gbW9kaWZpbmcgc3Rh
dGUNCj4gDQo+IFVua25vd24gd29yZCBbbW9kaWZpbmddIGluIGNvbW1lbnQuDQo+IFN1Z2dlc3Rp
b25zOiBbJ21vZGlmeWluZycsLi4uDQoNClNvcnJ5IGFib3V0IHRoaXMgYW5kIHRoZSBvdGhlcnMu
IEkgZ2V0IHNwZWxsaW5nIGVycm9ycyBpbiBjaGVja3BhdGNoLA0Kc28gSSBtdXN0IGhhdmUgZGlj
dGlvbmFyeSBpc3N1ZXMgb3Igc29tZXRoaW5nLg0KDQo+IA0KPiA+ICvCoMKgwqDCoMKgwqDCoCAq
IGluIGFuIGludGVycnVwdCBjb3VsZCBzY3JldyB1cCBzb21lIGluIHByb2dyZXNzIGZwcmVncw0K
PiA+IG9wZXJhdGlvbiwNCj4gPiArwqDCoMKgwqDCoMKgwqAgKiBidXQgYXBwZWFyIHRvIHdvcmsu
IFdhcm4gYWJvdXQgaXQuDQo+ID4gK8KgwqDCoMKgwqDCoMKgICovDQo+ID4gK8KgwqDCoMKgwqDC
oMKgV0FSTl9PTl9PTkNFKCFpcnFfZnB1X3VzYWJsZSgpKTsNCj4gPiArwqDCoMKgwqDCoMKgwqBX
QVJOX09OX09OQ0UoY3VycmVudC0+ZmxhZ3MgJiBQRl9LVEhSRUFEKTsNCj4gPiArDQo+ID4gK8Kg
wqDCoMKgwqDCoMKgZnByZWdzX2xvY2soKTsNCj4gDQo+IFNvIGl0IGxvY2tzIHRoZW0gaGVyZS4u
Lg0KPiANCj4gL21lIGdvZXMgZnVydGhlciBpbnRvIHRoZSBwYXRjaHNldA0KPiBhaGEsIGFuZCB0
aGUgY291bnRlcnBhcnQgb2YgdGhpcyBmdW5jdGlvbiBpcyBmcHJlZ3NfdW5sb2NrKCkgc28NCj4g
ZXZlcnl0aGluZyBnZXRzIHNhbmR3aXRjaGVkIGJldHdlZW4gdGhlIHR3by4NCj4gDQo+IE9rLCBJ
IGd1ZXNzLg0KPiANCj4gPiArRVhQT1JUX1NZTUJPTF9HUEwoZnByZWdzX2xvY2tfYW5kX2xvYWQp
Ow0KPiANCj4gRXhwb3J0ZWQgZm9yIEtWTT8NCj4gDQpZZXMsIHRoZSBLVk0gc2VyaWVzIG5lZWRl
ZCBpdC4gUGFydCBvZiB0aGUgcmVhc29uaW5nIGhlcmUgd2FzIHRvDQpwcm92aWRlIHNvbWUgaGVs
cGVycyB0byBhdm9pZCBtaXN0YWtlcyBpbiBtb2RpZnlpbmcgeHN0YXRlLCBzbyB0aGUNCmdlbmVy
YWwgaWRlYSB3YXMgdGhhdCBpdCBzaG91bGQgYmUgYXZhaWxhYmxlLiBJIHN1cHBvc2UgdGhhdCBz
ZXJpZXMNCmNvdWxkIGFkZCB0aGUgZXhwb3J0IHRob3VnaD8NCg==
