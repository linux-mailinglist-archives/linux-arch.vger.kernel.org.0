Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566AA72E914
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 19:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjFMRLn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 13:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjFMRLl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 13:11:41 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DC319B1;
        Tue, 13 Jun 2023 10:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686676300; x=1718212300;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=m7PwVpDCdZ9+85mW/EiPGHeGzPT5xCuIQ/7NyUx9jOE=;
  b=Nk36z2RY9v7m+1S/i5nrZS8BY65azEybtZpbn9hssRo9m5OHpdqrc74o
   oOYDdJbXuaempxmANgMnN5DnPKDVvQ1y/dsdnbf6YFMGSOdrm1J9Na0kh
   KvJDDhZy+xDsVNRl/9KnMt4kZzFkHu5cwe2QtUJZfutNUmqqF58ceBJVP
   jRMLdfBBdkir6ygYpa9tWpZER/W7GHmPLM3vRqK+kf3MDe8Rfd3vDVRBC
   WQeR+m/7Gqt5GVFe9vGcc4UNUqVPJXLThKZetTPSgWiEehg4+TDB5qNAJ
   yFPtOalsC7eBA7Q0SFQn+4p2DGeLvC8UmNssZwZ5AYOfeYRuDTsFwvds1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="343089554"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="343089554"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 10:11:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="856184002"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="856184002"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jun 2023 10:11:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 10:11:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 10:11:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 10:11:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/nwjgl0Y1kGuJHWHLty2GOWh4UbXZlaWFVNK7JB04fNFnx5dyBgPPv7VdjwldIrgA+QCRP/cHH1BTbRRcE9qZMEHJvQzQppc4r1ddI2iM0Gpn5p1TCArrLGdF6r5Q7eiViCVfMDEd/pKnAwyS8nNiLrEDAx/A0T4LLBF10VVcviBCx1r+IDgDUluO4/Arsmp8MtMzeHh6JQHTMZNv1YD6RkAGgi/6K2g3oN4mEYXGPhmKI9kiI0CQezSOcxfV+uMoaVMF7iRABWsu77D1F3cYcvGOR9ynNWbrsiMMBOnoIl7GqKfrtdNSLZQeq2e0ZpZ+AE4jJZLWzXJ9MlzyTHHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7PwVpDCdZ9+85mW/EiPGHeGzPT5xCuIQ/7NyUx9jOE=;
 b=e/Gn+voxj+8iHbIhtfe3tSYLTIac2QE7v+pW90VmF1lcb9NEpT3jtmMqnsfLrLm8V8jvmLy8KlR7aMIjHHXoampEyH+laZSLUbMGSQZJLEFvL6gnlz1yB1o6etpZg4+aUk+H/256KSD4xC5ZOABCboxNogTI8yrQWTxbawQ/4ejAgV1OuWNH6Hth1GDXT/CeZOKbadHCa3dMLPb9HZO1dMPKuUHNH8hf2P8lJ6sgCkEnSQIPmrGW8kQz6O1h9rcCzOgVTcCEVYIUG/d1hbbw0IpO9dB7ggqtYbmSCJE3l5+ZPas+ks3HBcp7rNPklaIYuOUJ1Sz9rITRM4xtth4Pfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA1PR11MB8199.namprd11.prod.outlook.com (2603:10b6:208:455::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 17:11:36 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 17:11:35 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "fweimer@redhat.com" <fweimer@redhat.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
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
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
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
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Thread-Topic: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Thread-Index: AQHZnYvD++9jHqJtDEOZ5j0eN4/f+6+IoOQAgAALyMOAACwFgIAAIG6A
Date:   Tue, 13 Jun 2023 17:11:35 +0000
Message-ID: <49eabafa97032dec8ace7361bccae72c6ecf3860.camel@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
         <20230613001108.3040476-24-rick.p.edgecombe@intel.com>
         <0b7cae2a-ae5b-40d8-9ae7-10aea5a57fd6@sirena.org.uk>
         <87y1knh729.fsf@oldenburg.str.redhat.com>
         <1f04fa59-6ca9-4f18-b138-6c33e164b6c2@sirena.org.uk>
In-Reply-To: <1f04fa59-6ca9-4f18-b138-6c33e164b6c2@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA1PR11MB8199:EE_
x-ms-office365-filtering-correlation-id: 02d12b7c-2111-44fb-d1da-08db6c313e63
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ETSdne9U+GWl3MJN9697YLyuC1UyvrpVLbcPs/BJTHmsC1/LJ+U09uQ0s46+uyIVj8S3mxpOSxZwD9FCthchtCI4yZetLOq/QMCyz//Rlp0W/RAfXgW3gU8NTnQKUm7NiQVKQUs4xGpPRX6AAdo2uuyfirRiRrvYIOHES7c82Xc7WUXVA74QuCX48JKg7pqU0fOG6PNEUxobBnFazmFM36+AXmenNYTZ51X2Qes6CxhwJtn58KU6L9dFMquW1oZhAxCTmzZxCfEGPPNCfCW2f9wMv6eXOGn6l7l9VSdrTMDCvFdA5wECe15h+h+iJyTlAD4TFnWjj6ykbpTaoq0vNIlRf5DZnT//xALfv53dPALD9iPJcIVFTr7rHCF09G2Rw96helQ3jFHbeREs8FXg58lJVZnb7TSLhLawy8yDcfji1OmYho3mRBfsNXZV7HfHd40FftJWFgDadTZlTwZh7k+ENgVlYog9gq8SwlmDYYQLkbgqFh4vWkmJvrHU7nd1dxRGYxKetZLUKTl/lS8HAxVCKtGqXQd7m6aAU+4D3FT2DTI9piZDqbvQmG1b8QsgrFY+7d4dEnr5V5iF24C1Sr4fMpd3H0cQPNUEFO/py31k6l6kSQd418GwC4kHaglR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199021)(86362001)(36756003)(38100700002)(122000001)(82960400001)(38070700005)(6486002)(478600001)(110136005)(54906003)(8936002)(8676002)(76116006)(7406005)(5660300002)(7416002)(4326008)(66946007)(66556008)(66446008)(64756008)(41300700001)(91956017)(316002)(2906002)(71200400001)(2616005)(83380400001)(6506007)(66476007)(26005)(6512007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3RzVUlzbi9xQTdIeTlUaUpHQ0cyOVBYbjNWUWlKbkFJYVBRZGpkZkVVVlVU?=
 =?utf-8?B?ZWkrZ09EUjFlS0xndFhUNEYzRi81dkkwT2xablRpTmgzdXZoNlNaclFsRmVB?=
 =?utf-8?B?NlJIM2NZeDdYNUdhUGtOMC9DYzRTbGp3eXJ0RExkWlp2MkVkb2NSVHdrMG9l?=
 =?utf-8?B?Y0I1eGg5U0g1VjYzUnorRVorQWkzUm4vZ2VIMjR4TlNTMm5rVDFLdC9KNFYw?=
 =?utf-8?B?enBOV0M0RS9KNW9ETHM4V3Q2TjlRWHFZeGhMMFVxMENhVElBWUd5aHlNTUZI?=
 =?utf-8?B?SFFoRTF6SWphODF3RTl6YWVxb0FTaW1nbE5rUTZiUkJ1SmJNREh0Z2Q5RWpU?=
 =?utf-8?B?NWFCQ2RWQlV2bVlnblN5MHhKSHlKTDFuSXVuem05R0VaZWltc29GaUZWdVda?=
 =?utf-8?B?SHpaalRXcXBVR1daU3c1V3ZpeFNVcms1WmlQelgzSitmdkVLd1pLTGJWS2Jw?=
 =?utf-8?B?OVhKWXo2QVFwM3lwLzlOSCtocVgxVjBoSUJsSDJCNWxFbGdwU1dZclVWUllj?=
 =?utf-8?B?ekdvckRzbHZmM3VWK1Z5UWljLzlEVklGSlZEcHBncXJyaHRWMmVPTEZlUzdh?=
 =?utf-8?B?WGZUa3VVZUgyMGR1Q3hhaC9NYTdmNmxuQXZ4cEF0U2tSMnBWdkdVeGplQzlL?=
 =?utf-8?B?RGxOSHp4Rk5pTHE2QXBBclFPdlFHVVEvR29hOGJhQmxxeUZNS0RTTnVYeGl0?=
 =?utf-8?B?OWhlNWZWdFN5SCtNMmY1b3V3dzd2VDJnbk1CQ0lnQ09KN1hvWUdNYTBYN20r?=
 =?utf-8?B?M3NEMFQxZnpHTEtKYlZZYjZhTFVGMU5uMGk2RnFkOGpKMDZ5VVNuNU5rQk13?=
 =?utf-8?B?bUxSTDNsT1BUTmhGZnZlN1FvZy9uZk9ZV0hRd1lpY3QvNUJON1l0WGh0TWtV?=
 =?utf-8?B?U2dEcmFBV2NRRXl4RGIxODgrWDdjS3RlQ0JrQ1R1QUIwYWVaVU1NTzFycW1i?=
 =?utf-8?B?Wm9uajdRbDVocFNnYkdoT3NzaDFHL2lOdHhqNmY0WWhtSVA1WE5hVzNUeTMz?=
 =?utf-8?B?QUF4Smk2aStJeVBFNlJCZ3dFelpYRm9WWUhSNlg2S00rYzhPYzFlMmFkWmNG?=
 =?utf-8?B?TDRQLzNYdTJ4em1rb2hJVDd5ME9HNWhnREk0cXdQTURadkkzNlYrNWJGRFhT?=
 =?utf-8?B?YTAvbTVZRWZxYUtDTytEOWFXS1BKTjVpTUhDMWtaZ1VrY0pJM2xla3JqYXla?=
 =?utf-8?B?c3IwcmF1bWtYamY4bGVBVVJaMC9BWWFqK0c1dHRRZGppS1RSY2l2UzB1N3A5?=
 =?utf-8?B?dGV3cXpjeFM2UCtpdXJPYWZnbWExSG1xbDVrOTd2YmgvdEhBSjdzK2c0eEdv?=
 =?utf-8?B?Qk42cjI0RkFocUZJTlJTbzBTWTRGN2l6d0llSTFHZU91ZDVsZ2lOaDYwTXZp?=
 =?utf-8?B?bm5WdnQvajBtcDVGdDZPalVwZkI1UjBrY3B0bytrQUJIOXNKOER3V25NQUQz?=
 =?utf-8?B?R0IvMGNsN3NrajMwSDlsTDFTNjVjaWR5MEhFeHdXcDY4QnRFOWp0dUxDUERr?=
 =?utf-8?B?Yk5FWWxET04rdGlyLzZBY1cwTHVPTTEyOURwQmIxL1AyRkxWVU83My9aVllr?=
 =?utf-8?B?OGlNVSswZ20yWWpnUnRVcG9jTjNYdS92aVFtM3RGRzdXUnhIYkdZc3YyOXZy?=
 =?utf-8?B?WGtOeUpqcTJuelNKeGp2UmNJNzNsa0NPaW9HdkRsMGhsTFhaYWI4TjhSZ3ll?=
 =?utf-8?B?Ny94MG8waEorakFGdmQ3eEJmVVMvTWJMRXNTUWd5eDd2L0tIck9mQVd1QkZK?=
 =?utf-8?B?dHZWYUVMdVVIeVJhYzFBRW1PeXZGMjMzNllSQzFPYTA0S1hXNWIycnpUK3Ny?=
 =?utf-8?B?eE0xeWdDRlFSVmFFUFdhZUwrUjZXMmhVS0pwRXFVM0dkUTYrZlAwMm1VNkJl?=
 =?utf-8?B?b0tha24rQ2JNZS9ENjZxeVhVLzdRU05pMVhvN3lWQzMzUXFOL2NnZ2M0UklF?=
 =?utf-8?B?SGFuNjhaZ1pFQmJvZms3SzNiMHdpTTVsQ2xYYm9hSkgvTjIwMkZ3aFVWRHhy?=
 =?utf-8?B?dlBWUW1hdzZTK3cxNlVUSTgwNS9kWnViTjc3RFNDcFQvYlM1cGZFV1VIRVM1?=
 =?utf-8?B?TjNwR2hDbDkySlorakZnaHdLclN1NGJ0cVhpVS9nMkhudkk0QUg5ZW9wdWw5?=
 =?utf-8?B?b1ZrODFoR3VZaHl2UEtncGs2bjlOU0dFNVlLemNjSGM3UmQ2R211c1VPVXAx?=
 =?utf-8?Q?tJnlTwG00mQULMzFgyxg8BQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A353D8F8C5AE2047BE5CACB3D217CA6B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d12b7c-2111-44fb-d1da-08db6c313e63
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 17:11:35.8390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ++qMOPpcfhOp0E0gO53Gp55vcG9/tySpV8w5Tse1w86CattSV6m6ql4JpQTIkdwehh7uEaEjtkTm+q5Leg+yCJu3B025eGgsMMUJNJyNGaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8199
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIzLTA2LTEzIGF0IDE2OjE1ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiA+
IEkgd291bGQgZXhwZWN0IHRoZSBpbnRlZ3JhdGlvbiB3aXRoIHN0YWNrIHN3aXRjaGluZyBhbmQg
dW53aW5kaW5nDQo+ID4gZGlmZmVycyBiZXR3ZWVuIGFyY2hpdGVjdHVyZXMgZXZlbiBpZiB0aGUg
Y29yZSBtZWNoYW5pc20gaXMNCj4gPiBzaW1pbGFyLg0KPiA+IEl0J3MgcHJvYmFibHkgdGVtcHRp
bmcgdG8gaGFuZGxlIHNoYWRvdyBzdGFjayBwbGFjZW1lbnQNCj4gPiBkaWZmZXJlbnRseSwNCj4g
PiB0b28uDQo+IA0KPiBZZWFoLCB0aGVyZSdzIGxpa2VseSB0byBiZSBzb21lIGRpZmZlcmVuY2Vz
ICh0aG91Z2ggZ2l2ZW4gdGhlIGFtb3VudA0KPiBvZg0KPiBkaXNjdXNzaW9uIG9uIHRoZSB4ODYg
aW1wbGVtZW50YXRpb24gSSdtIHRyeWluZyB0byBmb2xsb3cgdGhlDQo+IGRlY2lzaW9ucw0KPiB0
aGVyZSBhcyBtdWNoIGFzIHJlYXNvbmFibGUgb24gdGhlIGJhc2lzIHRoYXQgd2Ugc2hvdWxkIGhv
cGVmdWxseQ0KPiBjb21lDQo+IHRvIHRoZSBzYW1lIGNvbmNsdXNpb25zKS7CoCBJdCBzZWVtZWQg
d29ydGggbWVudGlvbmluZyBhcyBhIG5lZWRsZXNzDQo+IGJ1bXAsIE9UT0ggSSBkZWZuaW5pdGVs
eSBkb24ndCBzZWUgaXQgYXMgY3JpdGljYWwuDQoNClR3byB0aGluZ3MgdGhhdCBjYW1lIHVwIGFz
IGZhciBhcyB1bmlmeWluZyB0aGUgaW50ZXJmYWNlIHdlcmU6DQoxLiBUaGUgbWFwX3NoYWRvd19z
dGFjayBzeXNjYWxsDQp4ODYgc2hhZG93IHN0YWNrIGRvZXMgc29tZSBvcHRpb25hbCBwcmUtcG9w
dWxhdGluZyBvZiB0aGUgc2hhZG93IHN0YWNrDQptZW1vcnkuIEFuZCBpbiBhZGRpdGlvbmFsIG5v
dCBhbGwgdHlwZXMgb2YgbWVtb3J5IGFyZSBzdXBwb3J0ZWQNCihwcml2YXRlIGFub255bW91cyBv
bmx5KS4gVGhpcyBpcyBwYXJ0bHkgdG8gc3RyZW5ndGhlbiB0aGUgc2VjdXJpdHkNCih3aGljaCBt
aWdodCBiZSBhIGNyb3NzLWFyY2ggdGhpbmcpIGFuZCBhbHNvIHBhcnRseSBkdWUgdG8geDg2J3MN
CldyaXRlPTAsRGlydHk9MSBQVEUgYml0IGNvbWJpbmF0aW9uLiBTbyBhIG5ldyBzeXNjYWxsIGZp
dCBiZXR0ZXIuIFNvbWUNCmNvcmUtbW0gZm9sa3Mgd2VyZSBub3Qgc3VwZXIga2VlbiBvbiBvdmVy
bG9hZGluZyBtbWFwKCkgdG8gc3RhcnQgZG9pbmcNCnRoaW5ncyBsaWtlIHdyaXRpbmcgdG8gdGhl
IG1lbW9yeSBiZWluZyBtYXBwZWQsIGFzIHdlbGwuDQoNCjIuIFRoZSBhcmNoX3ByY3RsKCkgaW50
ZXJmYWNlDQpXaGlsZSBlbmFibGUgYW5kIGRpc2FibGUgbWlnaHQgYmUgc2hhcmVkLCB0aGVyZSBh
cmUgc29tZSBhcmNoLXNwZWNpZmljDQpzdHVmZiBmb3IgeDg2IGxpa2UgZW5hYmxpbmcgdGhlIFdS
U1MgaW5zdHJ1Y3Rpb24uDQoNCkZvciB4ODYgYWxsIG9mIHRoZSBleGVyY2lzaW5nIG9mIHRoZSBr
ZXJuZWwgaW50ZXJmYWNlIHdhcyBpbiBhcmNoDQpzcGVjaWZpYyBjb2RlLCBzbyB1bmlmeWluZyB0
aGUga2VybmVsIGludGVyZmFjZSBkaWRuJ3Qgc2F2ZSBtdWNoIG9uIHRoZQ0KdXNlciBzaWRlLiBJ
ZiB0aGVyZSB0dXJucyBvdXQgdG8gYmUgc29tZSB1bmlmaWNhdGlvbiBvcHBvcnR1bml0aWVzIHdo
ZW4NCmV2ZXJ5dGhpbmcgaXMgZXhwbG9yZWQgYW5kIGRlY2lkZWQgb24sIHdlIGNvdWxkIGhhdmUg
dGhlIG9wdGlvbiBvZg0KdHlpbmcgeDg2J3MgZmVhdHVyZSBpbnRvIGl0IGxhdGVyLg0KDQpJIHRo
aW5rIHRoZSBtYXBfc2hhZG93X3N0YWNrIHN5c2NhbGwgaGFkIHRoZSBtb3N0IGRlYmF0ZS4gQnV0
IHRoZQ0KYXJjaF9wcmN0bCgpIHdhcyBtb3N0bHkgYWdyZWVkIG9uIElJUkMuIFRoZSBkZWJhdGUg
d2FzIG1vc3RseSB3aXRoDQpnbGliYyBmb2xrcyBhbmQgdGhlIHJpc2N2IHNoYWRvdyBzdGFjayBk
ZXZlbG9wZXIuDQoNCg0KRm9yIG15IHBhcnQsIHRoZSB0aGluZyBJIHdvdWxkIHJlYWxseSBsaWtl
IHRvIHNlZSB1bmlmaWVkIGFzIG11Y2ggYXMNCnBvc3NpYmxlIGlzIGF0IHRoZSBhcHAgZGV2ZWxv
cGVyJ3MgaW50ZXJmYWNlIChnbGliYy9nY2MpLiBUaGUgaWRlYQ0Kd291bGQgYmUgdG8gbWFrZSBp
dCBlYXN5IGZvciBhcHAgZGV2ZWxvcGVycyB0byBrbm93IGlmIHRoZWlyIGFwcA0Kc3VwcG9ydHMg
c2hhZG93IHN0YWNrLiBUaGVyZSB3aWxsIHByb2JhYmx5IGJlIHNvbWUgZGlmZmVyZW5jZXMsIGJ1
dCBpdA0Kd291bGQgYmUgZ3JlYXQgaWYgdGhlcmUgd2FzIG1vc3RseSB0aGUgc2FtZSBiZWhhdmlv
ciBhbmQgYSBzbWFsbCBsaXN0DQpvZiBkaWZmZXJlbmNlcy4gSSdtIHRoaW5raW5nIGFib3V0IHRo
ZSBiZWhhdmlvciBvZiBsb25nam1wKCksDQpzd2FwY29udGV4dCgpLCBldGMuDQo=
