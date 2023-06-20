Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A37737521
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jun 2023 21:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjFTTel (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jun 2023 15:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjFTTej (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jun 2023 15:34:39 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA72E58;
        Tue, 20 Jun 2023 12:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687289678; x=1718825678;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EBa4avmo0F7ucAhUAOBWnx/LI8SeaaqRXthB8iDnXEo=;
  b=Ch9eUPfPrgHpLbbyH7cR8ml/RFOYYdzQEDnl5XKfDsQhNoBj1QrcdQqb
   81dPrfz0AB+YUrhtN/NYPp487P+GUPkiOGory1D7WdxXW5pJB2IdAWR/u
   1cN1qq2DPYIgPQQyAvomz9oxVjD3qbgIWNCYpzct0Zam6bCht6Fm80Sas
   U8NB86kXMJqvKMvWXlsofEhPwRPjujTyq+h+Gng3biz8aQ+SGR9l9TPCm
   cYUeVQmK0sbU7kw37hM9Itkd2rs+6zQWjCpxfjuFQozTVNS1t70uzy0Ho
   0iO/2oAh/rLCv5SxVvl+UcwH/GHVDnM1VYrNuuiOFATsIUatKvEwa69dh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="349696478"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="349696478"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 12:34:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="779563939"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="779563939"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 20 Jun 2023 12:34:36 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 12:34:36 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 12:34:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 20 Jun 2023 12:34:35 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 20 Jun 2023 12:34:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBoiHilT7vedGcuDUbOeVetPEBpjNWZCHlDcF/PueUtYVzZ2cTk9IRS3z9DQ7fVCWRGbfLp9630tn2vAcCY4yqtHy/fNlRZINLi/1LB94VgtPAwMIj/v4SlqS2WQ2jDkZlF4xnFO5fHkZRIYr6FbWPwkEuwqMM0bTjEAqb7utTyEzfuK74lwxPmiATWu/ifYvgZS5N1LuiiQyoT1wu6JssuBpISguafa/32LL5XVIQyyd7V85IHfntyA1/XmeRBYgdbTb6LzD7PTaiSsgJeGOGwUVoKaNF3aiO0m/oYh0K/ikuIfKx1GjXyE5Q3/ge6gdtMndhhu0Lt4EBPAARt+qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBa4avmo0F7ucAhUAOBWnx/LI8SeaaqRXthB8iDnXEo=;
 b=Cj6zpyQ+Nv7/kmnGayQDmTCGZ7dPYY756F/RZp2u5++cseqnGkbCer+lP57yi57kFn48NLyzwIQc3Ktrg4faiNwQVJD3b1AQP3gkPrpeaYeKPWz6SU/yVlVzbw6GLsXRIjyHh9oJj7QXMyJSpd3168WbDE2ZANsqDCRtnIJepwxbtjm8qUmP6W5XkIiNkeFGTtr8Ilgbq3mW5+x72ihhFEqn3hhilWZvZ2L6hEbEfRvqZFPNQow2R28NiUsbW58HcRkmQF/QMLayj2EqZiGDatdthBaJsSyizuSe7NNRLDKyx/4BRL/xZ2uPZrsmis+h/mRufPfJUHJubzgEQBc+2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MW3PR11MB4761.namprd11.prod.outlook.com (2603:10b6:303:53::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 19:34:31 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 19:34:31 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>
CC:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nd@arm.com" <nd@arm.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Thread-Topic: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Thread-Index: AQHZnYvD++9jHqJtDEOZ5j0eN4/f+6+IoOQAgAALyMOAACwFgIAAIG6AgAAMtoCAACGsAIAA96CAgABofQCAB1K5gIAAhUGAgAEVRoCAAKx+AA==
Date:   Tue, 20 Jun 2023 19:34:31 +0000
Message-ID: <e676c4878c51ab4b6018c9426b5edacdb95f2168.camel@intel.com>
References: <0b7cae2a-ae5b-40d8-9ae7-10aea5a57fd6@sirena.org.uk>
         <87y1knh729.fsf@oldenburg.str.redhat.com>
         <1f04fa59-6ca9-4f18-b138-6c33e164b6c2@sirena.org.uk>
         <49eabafa97032dec8ace7361bccae72c6ecf3860.camel@intel.com>
         <fc2ebfcf-8d91-4f07-a119-2aaec3aa099f@sirena.org.uk>
         <a0f1da840ad21fae99479288f5d74c7ab9095bb6.camel@intel.com>
         <ZImZ6eUxf5DdLYpe@arm.com>
         <64837d2af3ae39bafd025b3141a04f04f4323205.camel@intel.com>
         <ZJAWMSLfSaHOD1+X@arm.com>
         <5794e4024a01e9c25f0951a7386cac69310dbd0f.camel@intel.com>
         <ZJFukYxRbU1MZlQn@arm.com>
In-Reply-To: <ZJFukYxRbU1MZlQn@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MW3PR11MB4761:EE_
x-ms-office365-filtering-correlation-id: 2157eab0-457b-49ad-e6c6-08db71c55e8d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ECECvftWyedKFV480huuBDncNfsDRdIhpx98ZUVFfp0Y0ZC2LfS/xazgjgjJCcecNpf/le/X4RWt1kqPxNEWYRSfFr/Ra1cf95KF111iA7ifVC34XXK+R8XN1kebZHXkXyzekgglocMxHPVsZNNQd49mJysUeqk5o4I/wcHZzOw5gxoMxCTGiB29dGr+ivirOpEk176h8+D+gHiQ0DINv2LJPCQ5IMab4VfzgR0PnwyMB2O7osIJPW0ttl2Weyg5fCdtzW/OgkRtaFwwpobgrXWPFluwvOCBRKzdaWDIsrBU5D6vvDPG3VxPrKU1BflZJS+Trj0FGf5VSAtk11FSiLR6l41cYkHpMnN89ra2jZ70W49eaK3fCumFwBORmPQfMLHlRLKdlqyv4+Xq0dG8FwkSGdYQqZFFd18fJ7K/sNE3wecLJN5tVyIV9NypvOvv6KdjFjd8V0osFuEBi9iVwCpmH2g++K+4LrRYlv5G6kcpJKvSYRTh/Ir0qrYjEp85eKC6tcv2AxzUrDi1GiiIqH9UbAkgbNp5A/pa9edm7S8O4PtCOBFNBIXiWJ13bwggYHdb/ALIgrpCOHFDDKisualugMKwjzfM/7Mu4lDp1dikdmydR8PKOaZyS2883H1a
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199021)(41300700001)(5660300002)(54906003)(71200400001)(2906002)(316002)(7406005)(7416002)(8936002)(8676002)(66899021)(66946007)(64756008)(66556008)(66476007)(66446008)(4326008)(91956017)(76116006)(36756003)(478600001)(6486002)(110136005)(38100700002)(86362001)(2616005)(122000001)(82960400001)(83380400001)(186003)(26005)(6512007)(6506007)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1VETjViamhSc2pFM3dockw4YTBKN3BDdXVBNWVmbzZzQllCTmlLMlZEc0tR?=
 =?utf-8?B?eU92ZmJwQVk4TkkvZFh6a3o1Z05mN1FjWFJLVEI0ZDRNSHpoV3NrYklZMS9P?=
 =?utf-8?B?OE9XQWFEbWxzaFVzN0p0ZjJUMWNNYlhwcXRmOVF6MWoyWlo4TU9sbDJLQnNm?=
 =?utf-8?B?QU16VXJVTm5ZK3U5WmVtajB0SGZwZVphbWNXOEF5cGJZclh1SzY4Tmw2WWF3?=
 =?utf-8?B?Kzg0ejYwMGl6dWxlNk1Pcm0xVS9ENDhyUW8xalZiRnBnSUFJWGlSUVhFdmN3?=
 =?utf-8?B?Ymc5NDdOMExPajF6VFFPSWZIZzN3eDIrN3QydzZHeVdvUGtBcUhhVVhnUEdi?=
 =?utf-8?B?WXdsOFRZNS9QTWVVeHNVWGNOdExxdGhQemMzSGxScytKVDhQL3dyajYvWGFK?=
 =?utf-8?B?cXdSRWhYYTBaN3VwcVM0eW5tbFIyMStVWDJSM1RNVVliVDZuYU94MGFmeDda?=
 =?utf-8?B?NWsySlFUN0Z4RXh2clNqQXZ0VVVqeEtzY3dDYUc0aTZ6MzF3a1FpZDFCc0lE?=
 =?utf-8?B?c0NZek5MUmgvZlR2bWF3TnRMc2dVV0JnQ2lhTVZQQytvaGU2ckU3MytRZUxG?=
 =?utf-8?B?Nk9FdUxZTjJyQnhRN0lPN2kvQnJxcCtUdTcrZERDR0NCSWZrTUc4Y2dsemhL?=
 =?utf-8?B?S0paTDAzZDZjN3ZUVnNiU2xMTU5qTFV0d0VqaGRHK3lXRnJDZUVYSUpSRHR3?=
 =?utf-8?B?dDduTGxTd0x3M1hWMmx0MGc5M0trNzZkYWVkU2ZMNUNwSDJXclBxQ2dIaVFZ?=
 =?utf-8?B?RWwraVN6RHMxNVNkbGhERVpuNVJnS2ZaWE9RQlRHZU53Y3kwVGhrdVZOVVZQ?=
 =?utf-8?B?Tk01a25kZXRFR2Zld1MybGVjNlA3ZmQyM0FZNWx2c28yNFI5aFlicHNodWlX?=
 =?utf-8?B?ZEhRRlcrd2xWLzBGZG01c0RZb0hrTlN5d3BXZERaN0s0bFZxN3NnZS9QZTlo?=
 =?utf-8?B?RmVxU3QzT3VtTTF2MnJTZ2I4UEhNWjV6Ylh3V3pqUnZXZUh1OVBXUVJZN1Nh?=
 =?utf-8?B?QzJJUFJpMjRtM1Y5anNHanlCaXVNY0lCdFF6VlVtZGRLb3VJTFZ4TEtERG1x?=
 =?utf-8?B?YUVBWEExeHZYdDBEK1UvNktkYnBxRnVNTk91U3BqQ3YxS2xRNE9nMFpEeFhw?=
 =?utf-8?B?a2JSd21Qem40dnBqaTdkdE1zQjU1eThCSDhlb0toYXJGb3dtSVVnYitWSFlr?=
 =?utf-8?B?WjArbjh5VmQraEdvdTh3eTg2Z25MOW5IazhPZE5sU0pUNnBmYnF1TXpLRnNs?=
 =?utf-8?B?US8wSXlSdzNKdm5qKzg2dHJjSHBud3JBK2M1Q3pWcGdSZnRtT2FKaXJkZk5N?=
 =?utf-8?B?ZDVaNGdxbnM3N3VsYVh0NlNKWWNHZ3BvaDY3cnl4cEdleEZQeVJLTWRyaWp1?=
 =?utf-8?B?UXQ0UFR1VzlvVmRVWTZuaFdsenVmSTJma3NLc3dsNWZOMEd0MmFGaERDOWpn?=
 =?utf-8?B?RmlwZDMxWWZURzhMMVIvdi90RysrdzRWdDZXNFBNMnhkUFprZjNqOWRlSTd1?=
 =?utf-8?B?amg2M29iazVmTVJIeTlDWlRLVE85c2NjcFg5cEl6ZVZFZTRmeTlwc3hPd3E4?=
 =?utf-8?B?czJROFROSVprbmlpdnhMNk9pRW91K2V4YmJXZ3J6aUFrT1RINlUzV0ZGTzhl?=
 =?utf-8?B?MkVPbU5mQWVGUFFqbEtlWk80c0ppUFlSVVR2TXFQZkpycEsydXJOOGl1RVls?=
 =?utf-8?B?NjlrcEJSRkVTK0U5a1VnbktFZXMwaTg0cDZRQ2NTQmhFM0YvNExlL3dXWnUv?=
 =?utf-8?B?ajFwV3hjZGMxK3FoSjJjK0tlZFRpQVg5TW1DN2dqendrYjZlUXF2WXo0ZmRv?=
 =?utf-8?B?RjhQMjAxd0R6RDIzY0JhUFdxT05SaWxGR0k3NnVvMjl2eDlXOEJaa0pxdlZJ?=
 =?utf-8?B?ekhJY25Qc0dqVEp3YUZmc3N5TEdaWW03SmQ0NkhpOXUydHhYMkN0bkRvTnIx?=
 =?utf-8?B?dUhFeUtMWnh6Z1I5bnMrRlhBMFNabXBhRmRQZmhnajUwZkdNczM2cXlQUFZF?=
 =?utf-8?B?b0UvME95YTExMll5QS9Na01FZ0dHUzlNUWhTVEF5aWhPa21TSm4rRExEQi9Z?=
 =?utf-8?B?NkUrWTJNK1d6Qko2WWFLN3BwTm5qQm1ZZk1UcUFQa1cxNHpvYS9UNUMrdGdP?=
 =?utf-8?B?VEpNaHdXSW5BZUF6bGRzODFtVUxzTGFNTzl5YzdIL0orSm9oNUdVY01WMVpl?=
 =?utf-8?B?Q3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF923997C985E2438BC80A970649D215@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2157eab0-457b-49ad-e6c6-08db71c55e8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 19:34:31.1363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 72Tsd/1setVDjlpGU9lwiKZjOhQ/WYnfO+LyetB58BPk/wYsxEGyl+NmQAyPY9+f5m8gTfSXrnXtLQGdGywL6tRgh50eBBsyodcdeL1U3MI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4761
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIzLTA2LTIwIGF0IDEwOjE3ICswMTAwLCBzemFib2xjcy5uYWd5QGFybS5jb20g
d3JvdGU6DQo+IGlmIHRoZXJlIGlzIGEgZml4IHRoYXQncyBnb29kLCBpIGhhdmVuJ3Qgc2VlbiBp
dC4NCj4gDQo+IG15IHBvaW50IHdhcyB0aGF0IHRoZSBjdXJyZW50IHVud2luZGVyIHdvcmtzIHdp
dGggY3VycmVudCBrZXJuZWwNCj4gcGF0Y2hlcywgYnV0IGRvZXMgbm90IGFsbG93IGZ1dHVyZSBl
eHRlbnNpb25zIHdoaWNoIHByZXZlbnRzDQo+IHNpZ2FsdHNoc3RrIHRvIHdvcmsuIHRoZSB1bndp
bmRlciBpcyBub3QgdmVyc2lvbmVkIHNvIHRoaXMgY2Fubm90DQo+IGJlIGZpeGVkIGxhdGVyLiBp
dCBvbmx5IHdvcmtzIGlmIGRpc3Ryb3MgZW5zdXJlIHNoc3RrIGlzIGRpc2FibGVkDQo+IHVudGls
IHRoZSB1bndpbmRlciBpcyBmaXhlZC4gKGhvd2V2ZXIgdGhlcmUgaXMgbm8gd2F5IHRvIGRldGVj
dA0KPiBvbGQgdW53aW5kZXIgaWYgc29tZWJvZHkgYnVpbGRzIGdjYyBmcm9tIHNvdXJjZS4pDQoN
ClRoaXMgaXMgYSBwcm9ibGVtIHRoZSBrZXJuZWwgaXMgaGF2aW5nIHRvIGRlYWwgd2l0aCwgbm90
IGNhdXNpbmcuIFRoZQ0KdXNlcnNwYWNlIGNoYW5nZXMgd2VyZSB1cHN0cmVhbWVkIGJlZm9yZSB0
aGUga2VybmVsLiBVc2Vyc3BhY2UgZm9sa3MNCmFyZSBhZGFtYW50bHkgYWdhaW5zdCBtb3Zpbmcg
dG8gYSBuZXcgZWxmIGJpdCwgdG8gc3RhcnQgb3ZlciB3aXRoIGENCmNsZWFuIHNsYXRlLiBJIHRy
aWVkIGV2ZXJ5dGhpbmcgdG8gaW5mbHVlbmNlIHRoaXMgYW5kIHdhcyBub3QNCnN1Y2Nlc3NmdWwu
IFNvIEknbSBzdGlsbCBub3Qgc3VyZSB3aGF0IHRoZSBwcm9wb3NhbCBoZXJlIGlzIGZvciB0aGUN
Cmtlcm5lbC4NCg0KSSBhbSBndWVzc2luZyB0aGF0IHRoZSBmbm9uLWNhbGwtZXhjZXB0aW9ucy9l
eHBhbmRlZCBmcmFtZSBzaXplDQppbmNvbXBhdGliaWxpdGllcyBjb3VsZCBlbmQgdXAgY2F1c2lu
ZyBzb21ldGhpbmcgdG8gZ3JvdyBhbiBvcHQtaW4gYXQNCnNvbWUgcG9pbnQuDQoNCj4gDQo+IGFs
c28gbm90ZSB0aGF0IHRoZXJlIGlzIGdlbmVyaWMgY29kZSBpbiB0aGUgdW53aW5kZXIgdGhhdCB3
aWxsDQo+IGRlYWwgd2l0aCB0aGlzIGFuZCBsaWtlbHkgdGhlIHg4NiBwYXRjaGVzIHdpbGwgY29u
ZmxpY3Qgd2l0aA0KPiBhcm0gYW5kIHJpc2N2IGV0YyBwYXRjaGVzIHRoYXQgdHJ5IHRvIGZpeCB0
aGUgc2FtZSBpc3N1ZS4uDQo+IHNvIHBvc3RpbmcgcGF0Y2hlcyBvbiB0aGUgdG9vbHMgc2lkZSBv
ZiB0aGUgYWJpIHdvdWxkIGJlIHVzZWZ1bA0KPiBhdCB0aGlzIHBvaW50Lg0KDQpUaGUgZ2xpYmMg
cGF0Y2hlcyBhcmUgdW5mb3J0dW5hdGVseSBtb3N0bHkgdXBzdHJlYW0gYWxyZWFkeS4gU2VlIEhK
IGZvcg0KdGhlIGRpZmYgdGhhdCB0YXJnZXRzIHRoZSBuZXcgZW5hYmxpbmcgaW50ZXJmYWNlLiBG
cm9tIGxlc3NvbnMgbGVhcm5lZA0KZWFybGllciBpbiB0aGlzIGVmZm9ydCwgaGUgd2FzIG5vdCBn
b2luZyBwdXNoIHRob3NlIGNoYW5nZXMgYmVmb3JlIHRoZQ0Ka2VybmVsIHN1cHBvcnQgd2FzIHVw
c3RyZWFtLiBUaGVyZSBzaG91bGRuJ3QgYmUgYW55IGdsaWJjIGNoYW5nZXMgdG8NCnNpZ25hbCBv
ciBsb25nam1wIHN0dWZmIGluIHRob3NlIEFGQUlLIHRob3VnaC4NCg0KWyBzbmlwIF0NCg0KPiBo
b3cgZG9lcyAiZml4ZWQgc2hhZG93IHN0YWNrIHNpZ25hbCBmcmFtZSBzaXplIiByZWxhdGVzIHRv
DQo+ICItZm5vbi1jYWxsLWV4Y2VwdGlvbnMiPw0KPiANCj4gaWYgdGhlcmUgd2VyZSBpbnN0cnVj
dGlvbiBib3VuZGFyaWVzIHdpdGhpbiBhIGZ1bmN0aW9uIHdoZXJlIHRoZQ0KPiByZXQgYWRkciBp
cyBub3QgeWV0IHB1c2hlZCBvciBhbHJlYWR5IHBvcGVkIGZyb20gdGhlIHNoc3RrIHRoZW4NCj4g
dGhlIGZsYWcgd291bGQgYmUgcmVsZXZhbnQsIGJ1dCBzaW5jZSBwdXNoL3BvcCBoYXBwZW5zIGF0
b21pY2FsbHkNCj4gYXQgZnVuY3Rpb24gZW50cnkvcmV0dXJuIC1mbm9uLWNhbGwtZXhjZXB0aW9u
cyBtYWtlcyBubw0KPiBkaWZmZXJlbmNlIGFzIGZhciBhcyBzaHN0ayB1bndpbmRpbmcgaXMgY29u
Y2VybmVkLg0KDQpBcyBJIHNhaWQsIHRoZSBleGlzdGluZyB1bndpbmRpbmcgY29kZSBmb3IgZm5v
bi1jYWxsLWV4Y2VjcHRpb25zDQphc3N1bWVzIGEgZml4ZWQgc2hhZG93IHN0YWNrIHNpZ25hbCBm
cmFtZSBzaXplIG9mIDggYnl0ZXMuIFNpbmNlIHRoZQ0KZXhjZXB0aW9uIGlzIHRocm93biBvdXQg
b2YgYSBzaWduYWwsIGl0IG5lZWRzIHRvIGtub3cgaG93IHRvIHVud2luZA0KdGhyb3VnaCB0aGUg
c2hhZG93IHN0YWNrIHNpZ25hbCBmcmFtZS4NCg0KWyBzbmlwIF0NCg0KPiB0aGVyZSBpcyBubyBt
YWdpYywgbG9uZ2ptcCBzaG91bGQgYmUgaW1wbGVtZW50ZWQgYXM6DQo+IA0KPiDCoMKgwqDCoMKg
wqDCoMKgdGFyZ2V0X3NzcCA9IHJlYWQgZnJvbSBqbXBidWY7DQo+IMKgwqDCoMKgwqDCoMKgwqBj
dXJyZW50X3NzcCA9IHJlYWQgc3NwOw0KPiDCoMKgwqDCoMKgwqDCoMKgZm9yIChwID0gdGFyZ2V0
X3NzcDsgcCAhPSBjdXJyZW50X3NzcDsgcC0tKSB7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgaWYgKCpwID09IHJlc3RvcmUtdG9rZW4pIHsNCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLy8gdGFyZ2V0X3NzcCBpcyBvbiBhIGRpZmZl
cmVudCBzaHN0ay4NCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgc3dpdGNoX3Noc3RrX3RvKHApOw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBicmVhazsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqB9DQo+IMKgwqDCoMKgwqDCoMKgwqB9DQo+IMKgwqDCoMKgwqDCoMKgwqBmb3IgKDsgcCAh
PSB0YXJnZXRfc3NwOyBwKyspDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLy8g
c3NwIGlzIG5vdyBvbiB0aGUgc2FtZSBzaHN0ayBhcyB0YXJnZXQuDQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgaW5jX3NzcCgpOw0KPiANCj4gdGhpcyBpcyB3aGF0IHNldGNvbnRl
eHQgaXMgZG9pbmcgYW5kIGxvbmdqbXAgY2FuIGRvIHRoZSBzYW1lOg0KPiBmb3IgcHJvZ3JhbXMg
dGhhdCBhbHdheXMgbG9uZ2ptcCB3aXRoaW4gdGhlIHNhbWUgc2hzdGsgdGhlIGZpcnN0DQo+IGxv
b3AgaXMganVzdCBwID0gY3VycmVudF9zc3AsIGJ1dCBpdCBhbHNvIHdvcmtzIHdoZW4gbG9uZ2pt
cA0KPiB0YXJnZXQgaXMgb24gYSBkaWZmZXJlbnQgc2hzdGsgYXNzdW1pbmcgbm90aGluZyBpcyBy
dW5uaW5nIG9uDQo+IHRoYXQgc2hzdGssIHdoaWNoIGlzIG9ubHkgcG9zc2libGUgaWYgdGhlcmUg
aXMgYSByZXN0b3JlIHRva2VuDQo+IG9uIHRvcC4NCj4gDQo+IHRoaXMgaW1wbGllcyBpZiB0aGUg
a2VybmVsIHN3aXRjaGVzIHNoc3RrIG9uIHNpZ25hbCBlbnRyeSBpdCBoYXMNCj4gdG8gYWRkIGEg
cmVzdG9yZS10b2tlbiBvbiB0aGUgc3dpdGNoZWQgYXdheSBzaHN0ay4NCg0KSSBhY3R1YWxseSBk
aWQgYSBQT0MgZm9yIHRoaXMsIGJ1dCByZWplY3RlZCBpdC4gVGhlIHByb2JsZW0gaXMsIGlmDQp0
aGVyZSBpcyBhIHNoYWRvdyBzdGFjayBvdmVyZmxvdyBhdCB0aGF0IHBvaW50IHRoZW4gdGhlIGtl
cm5lbCBjYW4ndA0KcHVzaCB0aGUgc2hhZG93IHN0YWNrIHRva2VuIHRvIHRoZSBvbGQgc3RhY2su
IEFuZCBzaGFkb3cgc3RhY2sgb3ZlcmZsb3cNCmlzIGV4YWN0bHkgdGhlIGFsdCBzaGFkb3cgc3Rh
Y2sgdXNlIGNhc2UuIFNvIGl0IGRvZXNuJ3QgcmVhbGx5IHNvbHZlDQp0aGUgcHJvYmxlbS4NCg0K
VGhpcyByZWFzb25pbmcgd2FzIGFjdHVhbGx5IGVsYWJvcmF0ZWQgb24gd2hlbiB0aGUgYWx0IHNo
YWRvdyBzdGFjaw0KcGF0Y2hlcyB3ZXJlIHBvc3RlZC4gQW5kIGl0IGxvb2tzIGxpa2UgSSBwcmV2
aW91c2x5IHBvaW50ZWQgeW91IGF0IGl0Lg0KDQpUaGlzIGhpc3RvcnkgaGVyZSBpcyBxdWl0ZSBs
b25nIGFuZCBjb21wbGljYXRlZCwgYnV0IEnigJl2ZSBkb25lIG15IGJlc3QNCnRvIHN1bW1hcml6
ZSBpdCBpbiB0aGUgY292ZXJsZXR0ZXJzLiBJdCB3b3VsZCBiZSBoZWxwZnVsIGlmIHlvdSBjb3Vs
ZA0KcmV2aWV3IHRob3NlIGxpbmtzLg0KDQpbIHNuaXAgXQ0KDQo+IGkgdGhpbmsgbG9uZ2ptcCBz
aG91bGQgcmVhbGx5IGJlIGRpc2N1c3NlZCB3aXRoIGxpYmMgZGV2cywNCj4gbm90IG9uIHRoZSBr
ZXJuZWwgbGlzdCwgc2luY2UgdGhleSBrbm93IHRoZSBwcmFjdGljYWwNCj4gY29uc3RyYWludHMg
YW5kIHRyYWRlLW9mZnMgYmV0dGVyLiBob3dldmVyIGxvbmdqbXAgaXMNCj4gcmVsZXZhbnQgZm9y
IHRoZSBzaWduYWwgYWJpIGRlc2lnbiBzbyBpdCdzIG5vdCBpZGVhbCB0bw0KPiBwdXNoIGEgbGlu
dXggYWJpIGFuZCB0aGVuIGhhdmUgdGhlIGxpYmMgc2lkZSBkaXNjdXNzaW9uDQo+IGxhdGVyLi4N
Cg0KSXQgc291bmRzIGxpa2UgeW91IGFyZSBhd2FyZSBvZiB0aGUgbGltaXRhdGlvbnMgdGhlIHBy
ZS1leGlzdGluZw0KdXBzdHJlYW0gdXNlcnNwYWNlIHBsYWNlcyBvbiB0aGUgc2hhZG93IHN0YWNr
IHNpZ25hbCBmcmFtZS4gV2UgYWxzbw0KcHJldmlvdXNseSBkaXNjdXNzZWQgaG93IHRoZSBrZXJu
ZWwgaGFkIHRvIHdvcmsgYXJvdW5kIG90aGVyIGFzcGVjdHMgb2YNCnVwc3RyZWFtIHVzZXJzcGFj
ZSB0aGF0IGFzc3VtZWQgdW5kZWNpZGVkIGtlcm5lbCBBQkkuIEhvdyBvbiBlYXJ0aCBhcmUNCnlv
dSBnZXR0aW5nIHRoYXQgdGhlIGtlcm5lbCBBQkkgaXMgYmVpbmcgcHVzaGVkIGJlZm9yZSBpbnB1
dCBmcm9tIHRoZQ0KdXNlcnNwYWNlIHNpZGU/IFRoZSBzaXR1YXRpb24gaXMgdGhlIG9wcG9zaXRl
Lg0K
