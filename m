Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCFA74073F
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jun 2023 02:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjF1Ahs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jun 2023 20:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjF1Ahr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jun 2023 20:37:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB1F2943;
        Tue, 27 Jun 2023 17:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687912666; x=1719448666;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XzGp74iFUJmQDTM6x4Wac3fE9uuqBCeSuWtefb2q5Hs=;
  b=oGBaFbYJVPyFrvy7Y7NuXuCEarvt13/pTsWE21G2L2VmW1OPpzIknpun
   7sVwd/jH2/KJ1ehij12VT7Iw99wL7M4CvofjBT15xzs/tNXYtKjsZBpjh
   EUxH9hABHrkpjql261yg6WJhFLK1hWtQAEuzCkUucBHoX6ckFtSQe1Jjq
   qfKizG4cXRgiyGgLjA0Ffnf+mDqAvIbaQ+7BpAyb9i1Uo7blqIsDyYhdJ
   d5DhL2CIuQXMoRMBVeqJ4rb6GYHsYXZ2o4Akw3NxPGvTLdNmoAP1KPdQ7
   2sVrGscqWaxxdKI/bVbMMp2KSwnIPsPRjjD16I0HbhgbeKp5mAISQf0/j
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="359211103"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="359211103"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 17:37:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="694090843"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="694090843"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 27 Jun 2023 17:37:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 17:37:26 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 27 Jun 2023 17:37:26 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 27 Jun 2023 17:37:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PryLZTvJxGNNbcJB0E1OXmpxL2j5+cmsMrAkm1ZLzfMb2QG2y0WEiNXYTBl8CfcLdUql2gvbZ+P85n0xnZulH433gN+GKt1Xdr/x+wn1gKaYYKISb/P5Uqg2iX03KjRsg076tJ8uPCMcIj/q/hmeverafpc5ILPPYw7mkm/7hzSYBpz1rn+6jgWDa9nyfOoKz6miN9mcfj9JDJwdFdZtgHcPdydshuPi3v++qDkDa5DaABw91HrGnwfscuY3H0Gz0ef37qCVl4+LTghAsbxr0EL9aC9O0aGKQ8spvL0Addfhe2wOoZdmJhfdO0gpnIp+2xNDUtfhGanJAvfvFszkmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzGp74iFUJmQDTM6x4Wac3fE9uuqBCeSuWtefb2q5Hs=;
 b=Zm0OalT0hPSzRMtpP4UnriH03R0MlhAtMWSu49rnKj2A6AJlxh3ev3weIGhLz5iXNsk+zzWGTBZQccElpZA6KAULaWF+vQmqm1mMoFy2uiuSHBhUBX7ee4sYCjuztNRkAvJU/ESiqx3yJ2Uwhg2JtalazifWkiTnQ6/MKI1mJuMrWIWHIQtVKvkEyS4gDS9wmoN6I1D1ih2SkIC/snfA1BXAtuNsbbeBoY+/nIc+Ut4/RWc0Y9fQPyJxEK9w3q7JMZYvqj8JgKC7012eBQfajz2g9UOk/EPbO2I/RvFa1VMCWJIeWNjdHRakS0SAd2SIS9kPq6uqqdsGKCTIRTOc8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH0PR11MB4822.namprd11.prod.outlook.com (2603:10b6:510:39::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Wed, 28 Jun
 2023 00:37:22 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 00:37:22 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 28/42] x86/shstk: Add user-mode shadow stack support
Thread-Topic: [PATCH v9 28/42] x86/shstk: Add user-mode shadow stack support
Thread-Index: AQHZnYvStATdX36Iakijy8LvFgaml6+e/DWAgABrwACAAA5ZgA==
Date:   Wed, 28 Jun 2023 00:37:22 +0000
Message-ID: <6a2309340a17070fd39a1b049ce71188bfb5eba7.camel@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
         <20230613001108.3040476-29-rick.p.edgecombe@intel.com>
         <76a87cdf-4d4f-4b3f-b01f-0540eab71ac7@sirena.org.uk>
         <fb9b4f10-b824-4e3c-d29f-f8bbb030cd96@intel.com>
In-Reply-To: <fb9b4f10-b824-4e3c-d29f-f8bbb030cd96@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH0PR11MB4822:EE_
x-ms-office365-filtering-correlation-id: 7446b2b9-c095-4013-b0db-08db776fd658
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NVhsWgSfCr1escGucAWyeh93w+mYjQ+1BUSbkCOlRxgoF1/UKUtdBNodt4krai6Pkpbf9UYQjup6P7/4X8XxyBlRynZk8R2ROHO8xMnk/HXc0Vsoz7cma2e8u64aSSHDDbgIeq60uiT74Is1CpVSJ7NiJnFbEvmR7J2d89sMczSUKVNa8zQfRanRLwr4y1X8yzr0kPQXSYoiZzXBw4VU6Xsmr+pKcd9PKuPxD8oTuv81xWxe0YEU+vKlUKgW1iNk30sbXxodsa004vsv5FVO8KwE1syVpJSbdDPqQaobp13QlOfH0xm6YxsZczc1FHanXDaNyY/IweCodKHRQvcIi1CWJrMhkFrwgHOnf4lUZFlo4yLJYgT1tICaBHsEI/AFGI84VVthTBYkGfWFDzarHqNbwpKvf/yCrmB8hnPv4qhA64cAc6GMn9/t+B8c8yaIBR87HJEe4Rn5iVq8rKembOgqW7xLMrAk1jFRCdFJ/zfDxi37LPavlYOQGwLnmJFyXbzcQG56nojGog6OcAqn/cG7jsb8py6gKoNTpAwsywf2W2PG8Ku0dPAwzyjLZ7MCVHgJdiUKLR7EnEDKo88voS8Ugqq1WD2z2UNOK6Zpc+0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199021)(76116006)(38070700005)(82960400001)(38100700002)(122000001)(36756003)(86362001)(6486002)(41300700001)(966005)(8676002)(7406005)(7416002)(5660300002)(8936002)(6506007)(26005)(6512007)(478600001)(2616005)(186003)(2906002)(316002)(6636002)(4326008)(91956017)(66946007)(54906003)(110136005)(71200400001)(66476007)(66556008)(64756008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlluWmJmYUdWaXNYcWZIWmt2N2F6cE82NitrbGh0Zml2ZFBxV0pJckJDK1pM?=
 =?utf-8?B?SGltRWg4TWRHalZXZzZDTVU1R2doTnZsMko3LzFkNGV3NWJTQ0RuS1h1MUoz?=
 =?utf-8?B?L0hKUk55QmZ3TlJrbmh5V3JNT2g4YVprNHJ1ODBFcm1LbHkzMUlBckQxaElH?=
 =?utf-8?B?aW43VXpZbEw3WFRKVTRUblVNZ0t0VTd3K3hPTE9kcDdRTnZ3bFpEL3dWaVNN?=
 =?utf-8?B?WkNCcXZxOStxQ2ZjQUR1bDJUK3RWQ1NkOTNXN0JMRTE0TzBManM2MTRFL283?=
 =?utf-8?B?VWVmenhrSWpDWVpKVk9FRE9NQTRsenllY3VpL1VxZnpwVVhmNW1zSS9MM3l0?=
 =?utf-8?B?ZkRtYjR6dmVkelZ0TU1RYzZqZDNOSENGYmdSZUdHZFJNd2dSbWg5eUozeWFw?=
 =?utf-8?B?bWZxSzF1dVFWUmFDbzlVZ0NRNWNLTDd3dVYvQnR5ZHRYMFRycG1hL29GMnds?=
 =?utf-8?B?ZDRUdVRGSGJUc3RmdXVGNUkvVmJ3RXBVVERBNVM1dkp1M2owWGlxdTlVaHQ3?=
 =?utf-8?B?c1ZNdktXaCtOVWUya0U3VU03VmZZbVJyMnJ5VGtOZnlxWmhoaG1pY1pqdmxX?=
 =?utf-8?B?RTJHdDNtVVFyNHVYN08rdDhVeEZVZUs2TUgrRHdHWUFDakNabjQ3U3hHbU9W?=
 =?utf-8?B?dDNRYVRtWXlteGFiYjlpdkkvZm1GVE1ZM1RucmFGTWF3amxkT2JZZCs1SGJh?=
 =?utf-8?B?UGRNMjlzNHJqbG43SndpN1FJdEdxbWR0WXBPMXAxbk56WWNGekVCQ1hHZS9w?=
 =?utf-8?B?SldtVGdoUjVNN3RIU0RYdEtWenQyY2dWWnpsNGZhYXhLcXYyNkZYd2NSTzYv?=
 =?utf-8?B?ZDhwYlVlYTBGVHVVSUR5UTJ5YVZvSTlrTDFBUVB2WDEvYjl5bGlhTmZDOEJM?=
 =?utf-8?B?L3dzemN2TXhpU2xxWWR6bzEvaGRVY2oxYTUxdWZqWEpWV0xDRWg3bG5kWjdu?=
 =?utf-8?B?VGpYY2h0VW1wcGhrM2xsM0s5TitJajNQZEVpYXZ2Wlk1dWROVkhqMllhaGNF?=
 =?utf-8?B?S0xUbkttM0JNR0NyYW5QSVpEZWRueFZMSTU4UEdma1dsUVY0S1laT2tmdVNJ?=
 =?utf-8?B?UzJkWnhsWXdKVi81eW9WaFJ0QzR4SjBwQjhPZlJiSWhodUZYWjhGM2ZPaFBs?=
 =?utf-8?B?RnhuR00rZm1Za0NCTFlHL05oR3VoZk9DLy9JUEF1Z042a2VweVk4UW5zNFVn?=
 =?utf-8?B?K0daWklLZXJSOE45cnNraWplRlN5VTRkczhjWGljYzBvckNDT0RIZHczSitT?=
 =?utf-8?B?and1REsvaC9adENlYjVpdWdESE9kYUZUUFRmdWxBaHUzcll4bEl3dytYbjdP?=
 =?utf-8?B?VUpCQUJEQkpmUW00MFFaek54U2Y0VnVEVkl4UTBxa2NTMlpNcUViKzFnOE1p?=
 =?utf-8?B?alBYYTRqMmp5b2NGTUlybGpyUXY2N0pUWEcrUERmODlNeG0wUkY2RTBmY1gv?=
 =?utf-8?B?UmRCejE5Rzg4OUFVbWFTS2ptSm5pQ3lZWmdWZEJvL05yQzdRN1pYUllPK0xS?=
 =?utf-8?B?QndtZlBtQU9DL2FYaUpCQk1JbDJRQ2oraTI0dytKeDZkSFl6cWQvSEY0OGR2?=
 =?utf-8?B?SmtDM1owMEFFQlZXQlNweUM0N0RHVjhtdVpvdVFYbFo5dC95Q281eE5PSjJz?=
 =?utf-8?B?OXpUNUJObE1lazJZeW1UaDFSTkJRR1k1Wk4xTmxrR3pMVjFIdGtzOFFCbm9I?=
 =?utf-8?B?K2Nodis3eTB0cjhUd3EycG8rcVV1ZGFPejB2Y1Z5aSt4NjJkMHQ1MU1MYUtD?=
 =?utf-8?B?bFRYK2R5OWVtM1l6U3lzWWlud0ZJbEZYc2tJUDlqQ3RUK2RhYktlMGh1SW5G?=
 =?utf-8?B?eEQwcVFwOUpRWVhnaE4yYVd5YnJkUkhOV1N4UGJ4eS9iTloweGNMUFU2dTgz?=
 =?utf-8?B?b3VCNWZVbnd1RFRVTEtiTWdncGpTWHZ0YnZHM2VOZ1RwUytQTjNIcXp1U0hB?=
 =?utf-8?B?Rmw5dVpQS2Nka2kvTUZrczZneDRISDhRbS96TWFpMENXZVl6MFJPbXBwL3BN?=
 =?utf-8?B?LzNRRldzbjJJSGo2eGVMYk8zb09vWEVQVEtvc0NvcW5UY09RZTFWa2dycVBH?=
 =?utf-8?B?U0N0bXVGb1pGS3drM2xWNW83em9Vd29hRlB5c1d3dnZER1lSVlQweEdiL1JC?=
 =?utf-8?B?cmtQNGJVSGVmNG5vek1ITGZxUkluTjEyVVhRVERJNm1qL1VlWHFWVllreUth?=
 =?utf-8?B?WGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D93B9AA90A7D74C9B5AA891DF457BB7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7446b2b9-c095-4013-b0db-08db776fd658
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 00:37:22.3818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DZ12ceFnPvf9jncElS5/nWmByYINLMX42vq6XW++xo0qCBjirmR0KOe4hY04xLsbtcFGUaXMRFOPw6zbtnaB1nfySuB9JN7z9tWhhPp0DUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4822
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIzLTA2LTI3IGF0IDE2OjQ2IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
PiBUaGlzIGxvb2tzIGdlbmVyaWMsIG5vdCBldmVuIHNoYWRvdyBzdGFjayBzcGVjaWZpYyAtIHdh
cyB0aGVyZSBhbnkNCj4gPiBkaXNjdXNzaW9uIG9mIG1ha2luZyBpdCBhIHZtX211bm1hcF9yZXRy
eSgpICh0aGF0J3Mgbm90IGEgZ3JlYXQNCj4gPiBuYW1lLi4uKQ0KPiA+IG9yIHNpbWlsYXI/wqAg
SSBkaWRuJ3Qgc2VlIGFueSBpbiBvbGQgdmVyc2lvbnMgb2YgdGhlIHRocmVhZCBidXQgSQ0KPiA+
IG1pZ2h0J3ZlIG1pc3NlZCBzb21ldGhpbmcuDQo+IA0KPiBZZWFoLCB0aGF0IGxvb2tzIG9kZC7C
oCBBbHNvIG9kZCBpcyB0aGF0IG5vbmUgb2YgdGhlIG90aGVyIHVzZXJzIG9mDQo+IHZtX211bm1h
cCgpIGJvdGhlciB0byBjaGVjayB0aGUgcmV0dXJuIHZhbHVlIChleGNlcHQgZm9yIG9uZQ0KPiBw
YXNzdGhyb3VnaA0KPiBpbiB0aGUgbm9tbXUgY29kZSkuDQo+IA0KPiBJIGRvbid0IHRoaW5rIHRo
ZSBFSU5UUiBoYXBwZW5zIGR1cmluZyBjb250ZW50aW9uLCB0aG91Z2guwqAgSXQncyByZWFsbHkN
Cj4gdGhlcmUgdG8gYmUgYWJsZSBicmVhayBvdXQgaW4gdGhlIGZhY2Ugb2YgU0lHS0lMTC7CoCBJ
IHRoaW5rIHRoYXQncyB3aHkNCj4gbm9ib2R5IGhhbmRsZXMgaXQ6IHRoZSB0YXNrIGlzIGR5aW5n
IGFueXdheSBhbmQgbm9ib2R5IGNhcmVzLg0KPiANCj4gUmljaywgd2FzIHRoaXMgaHVuayBoZXJl
IGZvciBhIHNwZWNpZmljIHJlYXNvbiBvciB3ZXJlIHlvdSBqdXN0IHRyeWluZw0KPiB0byBiZSBk
aWxpZ2VudCBpbiBoYW5kbGluZyBlcnJvcnM/DQoNCkknbSBub3QgYXdhcmUgb2YgYW55IHNwZWNp
ZmljIHJlcXVpcmVkIGNhc2VzLiBJIHRoaW5rIGl0IGlzIGp1c3QgcHVyZQ0KZGlsbGlnZW5jZSwg
b3JpZ2luYXRpbmcgZnJvbSB0aGlzIGNvbW1lbnQ6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9s
a21sLzk4NDc4NDVhLTc0OWQtNDdhMy0yYTFkLWJjYzdjMzVmMWJkZEBpbnRlbC5jb20vI3QNCg0K
SSBkaWRuJ3Qgc2VlIGEgbmVlZCB0byByZW1vdmUgaXQuwqANCg0KVGhlIFNJR0tJTEwgY2VydGFp
bnRseSBzb3VuZHMgbGlrZSBzb21ldGhpbmcgbW9yZSB0cnVlIHRoYW4gdGhlDQpjb21tZW50LCBi
dXQgSSBjYW4ndCBkbyBtdWNoIG9mIGRpdmUgdW50aWwgbmV4dCB3ZWVrLiBJIHdvdWxkIHRoaW5r
IHdlDQpuZWVkIHRvIGhhbmRsZSBFSU5UUiBkaWZmZXJlbnRseSB0byBub3QgV0FSTiBhdCBsZWFz
dC4NCg0KWWVhLCBzb21lIG9mIGl0IGRvZXMgc2VlbSBsaWtlIHRoZSBraW5kIG9mIHRoaW5nIHRo
YXQgY291bGQgbGl2ZQ0Kb3V0c2lkZSBvZiB4ODYgc2hzdGsuYy4gQnV0IEknbSBub3Qgc3VyZSBh
Ym91dCB0aGUgV0FSTiBwYXJ0LiBUaGF0DQpzaG91bGQgcHJvYmFibHkgbGl2ZSBpbiB0aGUgY2Fs
bGVyLiBJIGd1ZXNzIHNvbWVkYXkgd2UgbWlnaHQgZXZlbiBmaW5kDQpzb21lIHNoYWRvdyBzdGFj
ayBzcGVjaWZpYyBsb2dpYyB0aGF0IGNvdWxkIGJlIGNyb3NzLWFyY2guDQoNCg==
