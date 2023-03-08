Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043786B168F
	for <lists+linux-arch@lfdr.de>; Thu,  9 Mar 2023 00:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCHXgD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Mar 2023 18:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCHXgB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Mar 2023 18:36:01 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62745274A5;
        Wed,  8 Mar 2023 15:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678318560; x=1709854560;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iv2ZWh0ImD8BdSiIP4zL1gJc6ED+hQupri+nJ8vrc00=;
  b=TfviqNnb9tFGK/csiGKvXCOAeJyfs22HmhdDcNhr3tkVp3lrB4Y9893S
   zHmssdKpCVhD1Ggecn8Bwld8BFXBTCQyT5r4rKn/60n2Bfvs/a+zK3uNG
   6laxtjkuJAiOugt+A7eFdIdxoKnoKTDM9de+Mde1U96Yba92PJBDT7UYq
   PozYc6Cl9yyPA2cKltlpg9Ypqwcb0reM45nwj/yB4SDlvl2R/9XplYwrH
   QiGjT1VS9z86DH/81vfptBDCubWfgesx3EosQnlbK1aYcmuWf3sJCHQVH
   a7r+KAGGJR2JgO9Ezwh09wgPWrTQpHMMumIPDzYlNJm58XFWkVQGuhA1/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="320134412"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="320134412"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 15:35:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="800953954"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="800953954"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 08 Mar 2023 15:35:49 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 15:35:49 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 15:35:48 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 8 Mar 2023 15:35:48 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 8 Mar 2023 15:35:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuluKiKd6/OjYB09HfoqRacJI9XnHOTGGnUjFVW9Ioe252eofWDLABZNmHfi2SxzLoJiO6+GEgGpxCzzXXQbPP8kjVOUnoYQrtilMNoPvsqIkzY0clv0BGSsztqHFimsXm6D67sEfbB5yylm4oAnrcoNullrB63HOgQ2Lrpged5Z8ERNzpaQhjA/tjVCIS5LVKGY3g4FyTMk4IPOsQGP/vzb3mVTZ4KXcMEYYCHYkxmP1Tr5mtJJkW7lkGJ5PDmqsQORSMIXR0ZX8DY3ywkb419S99uiWGSBVkCt/o6Bx4NFmZp9qmR9bQcfB4CY96yHa/08vG2diA2QNrdLCTcl+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iv2ZWh0ImD8BdSiIP4zL1gJc6ED+hQupri+nJ8vrc00=;
 b=e5LwQxLkS/1bERxOMriTmimMPWdrFYFiNZiruV2Xw+d6T4zNTrGWQaTASAK6AlC0nZ4BSD1oBYcayBNqAg2Jeuk6OTgZtSxhZitgQmkhfiGlJJlL++55wAE8Lr90242qTpQHkdTV4MaXRWcsHvZWckpBE9ertx39EPSQPXNVUa2c6AfhuRPoRA0Xo2BcdRKY4qsYS0iqb25ppun8of1p02LCw8m8suy8MH3QGk9WOz2HEh4phF6fz7/uQ07FK07gpjPqsBYpwi80vaV1pj4QGh+Fy5ScyokqAo8btyaktzEw0Yi1Tyir16FtKicPTgAvsXE/Rjz/EVjsGqiVzS82AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SA0PR11MB4701.namprd11.prod.outlook.com (2603:10b6:806:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16; Wed, 8 Mar
 2023 23:35:38 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6178.017; Wed, 8 Mar 2023
 23:35:38 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "david@redhat.com" <david@redhat.com>,
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
Subject: Re: [PATCH v7 27/41] x86/mm: Warn if create Write=0,Dirty=1 with raw
 prot
Thread-Topic: [PATCH v7 27/41] x86/mm: Warn if create Write=0,Dirty=1 with raw
 prot
Thread-Index: AQHZSvtBJLNDapCTNkyHHSMgHb1KOa7wqU0AgADuGgA=
Date:   Wed, 8 Mar 2023 23:35:37 +0000
Message-ID: <4f8aeb7be0bb71ea55dc375bc8cd77b5f5116384.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-28-rick.p.edgecombe@intel.com>
         <ZAhUDE+6F71onz0W@zn.tnic>
In-Reply-To: <ZAhUDE+6F71onz0W@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SA0PR11MB4701:EE_
x-ms-office365-filtering-correlation-id: 93e503a6-dc7d-4687-50d7-08db202dd24d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GHhSs+6PVWYV9AjvC6cJSomfWccqrKub+ugxIFwrzgd66MGo2lsoXwzHxiGBs7ZbIgUj2cENiG5asy0jnqMlr23+XWgb6gSyIeXBRrHEf6P5YdEadEVfYDyDtms7UE3CwKIlYbBSlrqtQhW/6IHuRuxypSCtZ+NZDA8qjvL00GUTrDdoVNKZ+BSo7sQKHkRtwJP4SSgEPfSKtzKz8cd/02byuaFnqswSGT7GqGnM65qxnMwm3Reyuo5k/2BCOF5pZ7/ISsyRKzUpps0d0KsTM0HP6KzfRJmb4GG4A1bj/IV7pwuxQcaWit+YHgf7EVVV3+XespTGtRlJC/R18qNn08w9r/CXhcbo6LdJ4cvUv/9WAnwyDG5v0uPkY8qvVwmF0N/+pN6R86+acLolVLgPyhoSSLujOMiP4EeiwGCHHK9s2SeixD8gZKWuG5SDzHeltSlpHJDbIPc3BtENij+cHpbufId5dLPuAuozm6LDk5bTrFoZzf8mCaGtePrlDBGeNV5oZpzN7dCYLxXZE2rP3LBLMdkVB9E8XFmK7CKwx/73iXpe1uQM8yH5OK1UFR227Dc0x8WzOHpXuclIVyjYO8+7QONcFxq6jrXHswgIyaFBvWvK7V3cdADEjDMWj+Te+hRgYstKYho8IoDPXoSa0bjDpAbe5APstLszkMlMkcNPo91Gh2tNAFG+fK+rmJnFAmkRjMH02qMw+0WVx++e9ANRsxAq3FQeZ699EMggPJJiIBugO5MoaKf+andGQd3e
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199018)(2906002)(71200400001)(6486002)(186003)(38100700002)(26005)(6512007)(83380400001)(6506007)(66946007)(41300700001)(91956017)(86362001)(76116006)(66446008)(66556008)(64756008)(66476007)(4326008)(8676002)(478600001)(38070700005)(54906003)(316002)(6916009)(2616005)(7416002)(122000001)(36756003)(7406005)(82960400001)(8936002)(5660300002)(99106002)(14143004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjNPcm0rTFNORGQ0M1ZXNm1sN2NiSFVtNVZmMDNZNWErWjNuMkhTUTVjc2w2?=
 =?utf-8?B?YTU1NzlrSGdIZ3UxcDIvNGdBTU5lRnJ5eEQ1MTZrVDJNTlN6VDJMbE9zTEEw?=
 =?utf-8?B?anNHTHVYVjFSb0lUTGNvd294Y3hpUitNbCtqR3h1VFRwNHFRWFVkaFBsa3o3?=
 =?utf-8?B?SUtzR1hsajJnTDVyMkZDVkhxWnI5Vk50c0U5cUhtKzBLRm02NUlJQzJhRTM1?=
 =?utf-8?B?N0xSUnVQdzBlTHVRazY2R0VxMlZPN21WNDRWUU5IZXVyTEVrSWQ0OXZ5RHpx?=
 =?utf-8?B?YUQ3dHpjZVVYMnpvUSt2TDQ5RVdsNHpnNnd3RFp6VEh5VHFkNnFWS2U2ZkJr?=
 =?utf-8?B?cllsdFB4WVpkQlliK1BocWE3MnpiS21TMGRuRG5DWEU5enZIcHNUUk9VL2Ny?=
 =?utf-8?B?WDFxUGtCZllhS3B4ZmFoZDZZWGVSeFhPZ1paQXVEczJmK2hEMHhsZmp2RW9o?=
 =?utf-8?B?U21LaG9KeGRTQk1IdnhUQ2hCMy9xR3NYWDl6OGJDaU0rd01vUWpkRXhCdEdL?=
 =?utf-8?B?dEo0RnNnRkZkV1JQNy9LcFhhcEIzWVRxYURIckl0SkhLczJqeXZTNyttenRI?=
 =?utf-8?B?OENvQm9jWGdFRStHMUwwa29qRHU4RUNVYWxFbXI5ZC85MWc5TnZTSWdHMHFV?=
 =?utf-8?B?NGd2OTUyaU5BYXdHeEEwSmUxVmYzb3R5YXhuNUR6WjZHQUo0WVo1OEtDek5k?=
 =?utf-8?B?aFIrbjdXNDU3d3I0TDVaWGk5NUtsOWRPY3F0TzRzVEcyZ21FTUR5ZEduTVd3?=
 =?utf-8?B?T29EVjQvdU1XUW4veUNET3d0QktvTnhXRTN4amFrZWQ2YVN5cSt5K29mTWJT?=
 =?utf-8?B?eUdZb3hvNUZOVkhDY2E1dWRaYWNhUDAva2VGeTNOdUMxSDVwTTVXT1hGdVh0?=
 =?utf-8?B?VENSRkFneVd4bmVnWCtlclNOelNpNm5zVk9kWlJNSFF3bVYvN1JzNHFlZURq?=
 =?utf-8?B?VDl5MjhuKzhsckdHeFczZmJaU1B0OHFHNGYrZEJFdiswUUhFcE5tSHoxSVQy?=
 =?utf-8?B?NFNsb3FGUTZEWjhZeUtjSlE5L3NJRjBEdkdSTFpOUFpsa1RneG1jZVd5SjFq?=
 =?utf-8?B?QVFkdDVQWVRXTGN2QUE2UW5RNjlvRUs4QzNxby8rTVpBdGFXd1lhVzc0Und1?=
 =?utf-8?B?Zlh3RWUyZ0JFejlhYUFxOEJVYnhtNU1mUHVsWW00d1U3MFphd2Q1RWExcmlM?=
 =?utf-8?B?ZjRmVlNHTno4NFUrZUZ1eG43RnBhSit3aWpnTGplNXhFczlJak1Gbi9iZVlC?=
 =?utf-8?B?eGVKdllRd21CcE1NU0gzTEYwaVUwaGM5M1FGenYvSzRhcUdiU0RzNGwrYk1B?=
 =?utf-8?B?KzhsQzJMa1k4c2p3dzlnQlZoa1pJTk82NzdNRFU3UURia0pIdVZYU1NKd0FU?=
 =?utf-8?B?aDJLTHdLS2NDZ3NXVTFwMXN3MU9CdWlXVmZ5bXhvV3hvUW0yTVdkeFBvTUx4?=
 =?utf-8?B?ek9UWmNZejNXYWhXanBvcndzMzJEOHh6Q29FQlcyKzFnWmtGN1BjZTVPTlc5?=
 =?utf-8?B?eE4rRTNWUWJUb2IwVm5MalVZZjZvQ1NIMlBZcXhONzdGR3RXbkQ2bGp6a2Z4?=
 =?utf-8?B?dWZHR0p2S2pLWERUalo1UTUraGdPS3BIYWxKM3pSL0dOSTlRSWVXM3dRd0ZY?=
 =?utf-8?B?RUxaR0ZvdHYwaGVOQUNlQVVQTDNud0ZEM3FmYzdzcWpObDJ2M3pXSmU4b1M4?=
 =?utf-8?B?M3FqYUtnMG9MajJoU0pmTlIrQzZqcCtlYVhzK3EzMU1kRWdlc0pTQ3UxRCtL?=
 =?utf-8?B?ai80dXVJQ3FzWnhWTW95RUUwbXZ6SUV3WXlSb3UwU1UwYWZlN0NLN2EwNk9K?=
 =?utf-8?B?dkh4eHAwQVgyOXpvRW9RRWhFRkJ2Mko5KzV3T0J4Uys5cXRIb2xZbGdDYzJi?=
 =?utf-8?B?bFd2azVNcFJHaGtGRWU2Rm1ob1hCNS8yYjQ4Vk1rK2hJajVBNjh4WG5iWU9y?=
 =?utf-8?B?bmVRbWRvNVJFYXJlSkl3azlvNUtzeENNL1gxeno4WUpWUWV1aEVhSSswMWRh?=
 =?utf-8?B?RnlQM09pc1dNRWNpS0lQNzJPRWp2NUtJYnRZemQzeUdTMzIvZ0ozZFozMHZm?=
 =?utf-8?B?NHd4YUJrS1Znd1VWY1VYSTJIekFKRWg5T3ZlMWhjYlJrQlZlbnNwdW9HTDRN?=
 =?utf-8?B?V2NxelZRVXUwZTNZcVV6ZDFMZE40UVRRNyszdkRuSVZTM2pDbzZtTk16MkZj?=
 =?utf-8?Q?AkfA4B99UhiEGxUkK7zOzvg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A61E31AAEC98045B326B2C808969B0B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e503a6-dc7d-4687-50d7-08db202dd24d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 23:35:37.6331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bS7taHb0X4B5csuN+T4ig2dEcTjq0clrNFqRzMwlW6B4CRmWRaVUx0khE7xmFEyFjiGA2PI9jmKrWwDC2khSQBSjcg6UI3OVqFR2q2vaUIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4701
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gV2VkLCAyMDIzLTAzLTA4IGF0IDEwOjIzICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIE1vbiwgRmViIDI3LCAyMDIzIGF0IDAyOjI5OjQzUE0gLTA4MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+IFdoZW4gdXNlciBzaGFkb3cgc3RhY2sgaXMgdXNlLCBXcml0ZT0wLERp
cnR5PTEgaXMgdHJlYXRlZCBieSB0aGUNCj4gPiBDUFUgYXMNCj4gDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIF4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgaW4NCg0KT29wcywg
eWVzLg0KPiANCj4gPiBzaGFkb3cgc3RhY2sgbWVtb3J5LiBTbyBmb3Igc2hhZG93IHN0YWNrIG1l
bW9yeSB0aGlzIGJpdA0KPiA+IGNvbWJpbmF0aW9uIGlzDQo+ID4gdmFsaWQsIGJ1dCB3aGVuIERp
cnR5PTEsV3JpdGU9MSAoY29udmVudGlvbmFsbHkgd3JpdGFibGUpIG1lbW9yeSBpcw0KPiA+IGJl
aW5nDQo+ID4gd3JpdGUgcHJvdGVjdGVkLCB0aGUga2VybmVsIGhhcyBiZWVuIHRhdWdodCB0byB0
cmFuc2l0aW9uIHRoZQ0KPiA+IERpcnR5PTENCj4gPiBiaXQgdG8gU2F2ZWREaXJ0eT0xLCB0byBh
dm9pZCBpbmFkdmVydGVudGx5IGNyZWF0aW5nIHNoYWRvdyBzdGFjaw0KPiA+IG1lbW9yeS4gSXQg
ZG9lcyB0aGlzIGluc2lkZSBwdGVfd3Jwcm90ZWN0KCkgYmVjYXVzZSBpdCBrbm93cyB0aGUNCj4g
PiBQVEUgaXMNCj4gPiBub3QgaW50ZW5kZWQgdG8gYmUgYSB3cml0YWJsZSBzaGFkb3cgc3RhY2sg
ZW50cnksIGl0IGlzIHN1cHBvc2VkIHRvDQo+ID4gYmUNCj4gPiB3cml0ZSBwcm90ZWN0ZWQuDQo+
IA0KPiANCj4gPiANCj4gPiBIb3dldmVyLCB3aGVuIGEgUFRFIGlzIGNyZWF0ZWQgYnkgYSByYXcg
cHJvdCB1c2luZyBta19wdGUoKSwNCj4gPiBta19wdGUoKQ0KPiA+IGNhbid0IGtub3cgd2hldGhl
ciB0byBhZGp1c3QgRGlydHk9MSB0byBTYXZlZERpcnR5PTEuIEl0IGNhbid0DQo+ID4gZGlzdGlu
Z3Vpc2ggYmV0d2VlbiB0aGUgY2FsbGVyIGludGVuZGluZyB0byBjcmVhdGUgYSBzaGFkb3cgc3Rh
Y2sNCj4gPiBQVEUgb3INCj4gPiBuZWVkaW5nIHRoZSBTYXZlZERpcnR5IHNoaWZ0Lg0KPiA+IA0K
PiA+IFRoZSBrZXJuZWwgaGFzIGJlZW4gdXBkYXRlZCB0byBub3QgZG8gdGhpcywgYW5kIHNvIFdy
aXRlPTAsRGlydHk9MQ0KPiA+IG1lbW9yeSBzaG91bGQgb25seSBiZSBjcmVhdGVkIGJ5IHRoZSBw
dGVfbWtmb28oKSBoZWxwZXJzLiBBZGQgYQ0KPiA+IHdhcm5pbmcNCj4gPiB0byBtYWtlIHN1cmUg
bm8gbmV3IG1rX3B0ZSgpIHN0YXJ0IGRvaW5nIHRoaXMuDQo+IA0KPiBNaWdodCB3YW5uYSBhZGQg
dGhlIG5vdGUgZnJvbSBiZWxvdyBoZXJlOg0KPiANCj4gIi4uLiBzdGFydCBkb2luZyB0aGlzLCBs
aWtlLCBmb3IgZXhhbXBsZSwgc2V0X21lbW9yeV9yb3goKSBkaWQuIg0KDQpGaW5lIGJ5IG1lLg0K
DQpUaGFua3MuDQo=
