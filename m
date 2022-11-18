Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B051162FB2D
	for <lists+linux-arch@lfdr.de>; Fri, 18 Nov 2022 18:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbiKRRJZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Nov 2022 12:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbiKRRJX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Nov 2022 12:09:23 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C758A16D;
        Fri, 18 Nov 2022 09:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668791358; x=1700327358;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QG2eliHdsJ4OQX9hcLYTZrMCRATDpoIzrKiRjfsMGT8=;
  b=W0kk32Je5KlREXWSNO9fVUFdLoRk+cDC4IJ40xxjHRaFYLlGPL3SVSyd
   pULP3qsdLxDc1nvEfShUffgRI4t0O9XeKYxW6ITze4ost6sGTD27/17ti
   M9u+Qruj68zTtRNQHDTdF613YLs8aH2DMVlgHtMyNhVnmtk+e5nX6Bmrm
   pX/KpojBGiJYR8CN7m5XwCPqnpmUTP6AiFW0g6fyyo4HFzHr6E84YlHls
   Q6zJ+ZsfANHORURqij5w+p4Ev3QkjnZGE15ES+CGUgswD+kO2nxSewNNy
   3BInxdMSc2zk0j4XoJr0UWJXi12LNA7WJg8T16ChlC7gnZwqU6X70kt4J
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="300719557"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="300719557"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 09:05:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="729291584"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="729291584"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Nov 2022 09:05:22 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 09:05:22 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 09:05:21 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 18 Nov 2022 09:05:21 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 18 Nov 2022 09:05:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHZkZmxdQ9GbDlIJKsPJvZ48DCRHtwUZRSBcPubx+vXmrSR3JsFSI4iqZUIzSPBkGnYmpTMvfBLDEtigEVvZPtdjGBe///CAV54xj1wkYcxXqRWJhNwMWLjx8Gn2/exWxKMgZTm+P7X4Y5bBJTvz7MtpAIQY/K2Gbci30jSMW6L/x7XxaNuWn+9TAwZ7Ydk+u96Fb7e2n5XypP1NXs6PLolPXaWZ0HFgSUIISjnBUE1kWe37euhBPC2tYmv+oUZzBl5YkKQdeOntaMYaVZamOs2suX36M695IMgu5Zw8y0t3j7xohjeR0Cwy6yadShr7CZaqdaeMpiULfA3o5iKjFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QG2eliHdsJ4OQX9hcLYTZrMCRATDpoIzrKiRjfsMGT8=;
 b=llKPmWDaCf7lcBaXko8PP2HIPj0cGwUjqZafjWgiFyIp1B5gUQwKOgEQOI3NDMIeP950b4auweezaW9CNKLEh2xSfjGHjm/CsYJVZkgA4USp9QzgUs2gmH2FRNvfH/Rc31Bbs2/zH2DMhAldjY9QdDJmnl0M1Ty+XWI8vPGg6fv+XusncC1PGCJWiXmKYJlQcDZ2NK/xACEoY+wsvhYjt0YXbYeVb2UwSNbpN1KadkFdGcoxqwpU1JMZin/Tp2Wed5Pzda5ZCSGjJZTquK8XseM+XS2G3ur8okwylnXV8cN6bpYmAR6M37RJAXSHmZKoPLgxklU9l4IKsc9zlFcy2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BN9PR11MB5257.namprd11.prod.outlook.com (2603:10b6:408:132::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Fri, 18 Nov
 2022 17:05:10 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3%5]) with mapi id 15.20.5813.020; Fri, 18 Nov 2022
 17:05:10 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 27/37] x86/shstk: Introduce routines modifying shstk
Thread-Topic: [PATCH v3 27/37] x86/shstk: Introduce routines modifying shstk
Thread-Index: AQHY8J5fUoAN1KmpVkaYCSerQ8NxVK5AGQKAgACdrICAALGtAIAAzqYAgAEGdQCAAcEiAA==
Date:   Fri, 18 Nov 2022 17:05:10 +0000
Message-ID: <8a38a9cd777a4b615f0200b67b6b6a93fd50e88e.camel@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
         <20221104223604.29615-28-rick.p.edgecombe@intel.com>
         <Y3OfsZI0jFRoUw02@hirez.programming.kicks-ass.net>
         <be65a66baf94cebf0bc8d726a704238787195837.camel@intel.com>
         <Y3S5AKhLaU+YuUpQ@hirez.programming.kicks-ass.net>
         <cb4c70dd57f43fd46a47e0bf7d3c759b0b313f83.camel@intel.com>
         <Y3ZChDNwybrNKFX2@hirez.programming.kicks-ass.net>
In-Reply-To: <Y3ZChDNwybrNKFX2@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|BN9PR11MB5257:EE_
x-ms-office365-filtering-correlation-id: ac6dc91d-e6dd-4883-7dfd-08dac9870d4e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q4w0cNzuiG3CHQQfV2AfwzwdhG3UNaYnoPgbqcR54GM+X/V8jR4gxgnLOMtci6dFqRJNeRt0QrjZU3MDgf/t6AKorfpcBwap8r/NM3j842NEO50Wkw/lmcHzXyPOOhZzt06UJyUOjhAd3+EhkxMoUj4/y7AyNUhmnxImg80MlblGtjR1tHAJ88t8ukHWd6UCWfavqSRvh2f2Nt2IjKe0lWsNic4rdjSg892pgnonZp7wfomlFkfGQ0NYtUc4CTuRufm8ETdYQhKEGtPa+iJXuNMoN3mwqFKvtbJHsvehiDXYh/e56OJHtMawmReR1T9djpJagwQZCVe4s/FCowLIu3gyFpedDauAdL79JeHmGR9gasv1yLfIFfLXqBCziJ39q2ClBF6XtOlzrJeMn7xFkuhsqXwPOtPrUBbjZOJ7hgN8Vyuww4HHSIgdlgTqN8spNu4ARNn3z3G1haNpMscFZi0vvCKwGZ4o7gJDmQy4yPl6kK3EFKn/Fr3Swrqv/FPiLgIe5u3iRoEA/S0wxVSAEcrwbyinosQ9uPAz1iaxUxYxl0xKMhHw0JiMI04c9jmnnPOYbp2RPo1WlzRe132jHlr5wwuWB7oaNKLe19ULOCJk5DnuJ/IzoHk+Lw09uULNKJ3Id5zRTfRKUfZUtlzVod0vNTU/1fQs4nguHH0Ke1wNWQ8wGkf9nOspFxV9CB0Je9PUeCJ1a1cPL7sKDNiwLzQX9sWNXfxZLGugyXRKRID6PcEcUsIqACMKNlp+pg4w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199015)(71200400001)(478600001)(5660300002)(7416002)(7406005)(6916009)(316002)(6486002)(91956017)(8676002)(4326008)(64756008)(66556008)(66476007)(66446008)(76116006)(66946007)(41300700001)(8936002)(186003)(4001150100001)(2906002)(26005)(6512007)(2616005)(83380400001)(36756003)(6506007)(38070700005)(54906003)(122000001)(86362001)(82960400001)(38100700002)(99106002)(17423001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dSt4OEFlNU15aVZOOUpwWnI5V2JaSCswZFRwMmxiZ1FPWktIa240SnJmdFcx?=
 =?utf-8?B?NTFFWit3UDBPbU04TEk3dzFrdi9CYjdMSmF0Y1o3SWRmYkIxcFd1THVQd3Mw?=
 =?utf-8?B?TWJIdGlhNWxFaGl1bUVsNWprcm5HbzNUQVdFcHF0MWpjZlM4ZG9RbmYyNk1p?=
 =?utf-8?B?Zk9KSWora1BTY3JmOGxrSnovb3RybXZSdHNKM2RGUEcyYlQ1dWpqalIxR0tM?=
 =?utf-8?B?b0hzNHZwRXJGZytlTlhwRm9rY1F3UGNFZXptWWgrQnZuTi9yQy9jOXZjYnV5?=
 =?utf-8?B?SkVTS3o2WGg1TnhDMXlQVllaeEVYd1pqWWRSMWEyNU9hMFRuRzEyUGtDeGFt?=
 =?utf-8?B?c0pqQUs5UkZhZE9DdHJkc0JHUkcyeWI4OVVTdlpwb2s1c2N2NjBCZnZmbi9m?=
 =?utf-8?B?d0FuUWRvb1dBMkNhcUcwV0Z2ejlJaWZDemRTVGJMamlGek4zTERBSnI3Z1Yv?=
 =?utf-8?B?ZHducEY2YUd1SFFqUEhmOWxNY0NsRzgxcDZhUk1qYVFNVTQ4c2t3QnNhV2Zs?=
 =?utf-8?B?SnpOQUdVRzNjZWgwcGNaWlJZTXFOVjltUkdjNWtLWFdVZlFOTzg1SEtINWhs?=
 =?utf-8?B?emdrSHFJd3p1TlNaczI2clVYUnRtOGowNlVLWnhFdkRudXlsNEVZaW1pSnB4?=
 =?utf-8?B?cnlsekZLYVdOL2RxUGtsSDJEZVYvSlpOcmw4SzdqYVhFMTU0M2RldVpHVEtB?=
 =?utf-8?B?UHFldVQ4aU5hcytKOWNsVmQ0OTZkbFU2V1B1VzBvaE0vTHZYTUdES0ZwK2Jh?=
 =?utf-8?B?YUlUSjVhc1FlMnVuU3dVM284Z1Y0bUNlaDdXbEJoWGlwOGFCb3NycHFkWjJ4?=
 =?utf-8?B?TDJkNi9MSTF0dVEySjl4aW4yTlZ3Y2s2U1ZicVh6RGl4ZndCYnEyRm9EbHl3?=
 =?utf-8?B?TmV4aVcyZ05qbEl3dFpES0ZzYkNVVE5BTHVaK1RFTmhrVUNOTHJjd2ZuQXdn?=
 =?utf-8?B?YjBvRnQySUhEL1Rqd1ZqT252MW93dGs0Z2QxUVVMcTV5RFFCcXY1VlExa3VF?=
 =?utf-8?B?TUpSTTFBV2ppQ0trcGlMSUloQXpMK3NYZS9Wc2tpZXAwaFdCNEJwMUhhYnpz?=
 =?utf-8?B?TG5qK21Wc1ZNMUJlL3dyeCt4MUxJUnRkSzNOMU5NTHEzZVMvWTlYdzdKRDZE?=
 =?utf-8?B?MHFMNHB0dXlKUHkyOUI4RTJBa0Nac09ua09lbkVPNUhydk4rWXBtNlhlZ2NP?=
 =?utf-8?B?a3pjbllVTjdDYlNudUN4WXhnbzgySlN5bkVpOEEzajg1b2hwT3NVeGxyTlFK?=
 =?utf-8?B?NWptR25kRDVrcHE3WlZkQzQ1aEhWaFF6KzA5V1NSQUJac0JzTGs2eks0Tno3?=
 =?utf-8?B?N2lsSGNUcU0zdnJYVXd1Ym5vTlZJQ3JZVDJuNDlwZ2VkRlM2TFQzNmNFUkh0?=
 =?utf-8?B?MUY0SFBFWGZMSnFXN3RGZkpkbDZyeklxdDNTRFNXQndzSVlKM01Mc25XMHZy?=
 =?utf-8?B?YzA4Sm9PdWFVcC8zTWJmcDRGdUJ0M1BDL2NFTzJZcWRSQktteFdwNW92aDMv?=
 =?utf-8?B?RTMrZEhhVkNmanZJckw5cVdHODF4R05KdWNTZXlkZXFyUHZ0VVJ1STN4N1h0?=
 =?utf-8?B?djI4YnZLRmZJUWw0MmpZOGhISlo4ZllsaWNaY0lMb3R1RW52MVFsc21LYlBK?=
 =?utf-8?B?RWJDMjNwVDJYUllTWWFXWkE2L2Z6d0hzZlZjNk5DZXhROE5WZWFoOTFoYzcw?=
 =?utf-8?B?VUZlVVFqUldkRkhob3hqNmw0Yit5eWVEVHhvMm05MnhmSWs3VEZvbnY0eVhy?=
 =?utf-8?B?YU16NGd1UmFweC9VL3dTNjNvZWo1bDkyRGs2YTUzbGZmN2JCeFdnNjZSazRy?=
 =?utf-8?B?ZlBQcUJHbWx5U2VHd01TYTJmdVdOVEtOK1hlUXRuVU9kbmxFRE40Vk1JbkZH?=
 =?utf-8?B?S0x2K1dTbXRpSkxGc2ViY28wZEx2VEpET0E4TUwzRGJyTFJIUHZ5Y1NPRTdQ?=
 =?utf-8?B?b29PL3J0bjBOOGVmVkh1TGVIV01pRGNxdmlweW11OTNVcGZ5b1oxUTZZZElo?=
 =?utf-8?B?dVhBVXJxUlRUcWkwbXlXT002VkJmQXdMOU5EUlExem5xbG1hR21mOHFXNFhm?=
 =?utf-8?B?TUZhMmZORHZPcDF2anVrdXVkWGROTjhxOFJnZTc1TVduQmdXdVBJUVFHUmNF?=
 =?utf-8?B?R21xWTRpNDFZWDFxVzRuanlZcWVuaEZSTElQWlkxZUlXaGw3R1AxR0JsMlFq?=
 =?utf-8?Q?r0LscHSDMJ+mFU5Uy8sc36I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F06BC3F02000F64EB0F417DC2D499D0F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6dc91d-e6dd-4883-7dfd-08dac9870d4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 17:05:10.7206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SK0GhU3UByQ//btdIoiFTW8/8+Pe8QrYSQF391T8lvTUuEKWbh/tGBu+bqQZHChDZw9+i4HpZAvydDJ+j7WseJTBHG9tkyeMn+CfMgctK+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5257
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIyLTExLTE3IGF0IDE1OjE3ICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gV2VkLCBOb3YgMTYsIDIwMjIgYXQgMTA6Mzg6MTlQTSArMDAwMCwgRWRnZWNvbWJlLCBS
aWNrIFAgd3JvdGU6DQo+ID4gT24gV2VkLCAyMDIyLTExLTE2IGF0IDExOjE4ICswMTAwLCBQZXRl
ciBaaWpsc3RyYSB3cm90ZToNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBTaG91bGQgeW91IHdyaXRl
IGEgNjRiaXQgdmFsdWUgZXZlbiBpZiB0aGUgdGFzayByZWNlaXZpbmcgYQ0KPiA+ID4gPiA+IHNp
Z25hbCBpcw0KPiA+ID4gPiA+IDMyYml0ID8NCj4gPiA+ID4gDQo+ID4gPiA+IDMyIGJpdCBzdXBw
b3J0IHdhcyBhbHNvIGRyb3BwZWQuDQo+ID4gPiANCj4gPiA+IEhvdz8gVGFzayBjb3VsZCBzdGFy
dCBsaWZlIGFzIDY0Yml0LCBmcm9iIExEVCB0byBzZXQgdXAgMzJiaXQNCj4gPiA+IGNvZGUNCj4g
PiA+IHNlZ21lbnQgYW5kIGp1bXAgaW50byBpdCBhbmQgc3RhcnQgZG9pbmcgMzJiaXQgc3lzY2Fs
bHMsIHRoZW4NCj4gPiA+IHdoYXQ/DQo+ID4gPiANCj4gPiA+IEFGQUlDVCB0aG9zZSAzMmJpdCBz
eXNjYWxscyB3aWxsIGVuZCB1cCBkb2luZyBTQV9JQTMyX0FCSQ0KPiA+ID4gc2lnZnJhbWVzLg0K
PiA+IA0KPiA+IEhtbSwgZ29vZCBwb2ludC4gVGhpcyBzZXJpZXMgdXNlZCB0byBzdXBwb3J0IG5v
cm1hbCAzMiBiaXQgYXBwcyB2aWENCj4gPiBpYTMyIGVtdWxhdGlvbiB3aGljaCB3b3VsZCBoYXZl
IGhhbmRsZWQgdGhpcy4gQnV0IEkgcmVtb3ZlZCBpdA0KPiA+IChibG9ja2VkDQo+ID4gaW4gdGhl
IGVuYWJsaW5nIGxvZ2ljKSBiZWNhdXNlIGl0IGRpZG4ndCBzZWVtIGxpa2UgaXQgd291bGQgZ2V0
DQo+ID4gZW5vdWdoDQo+ID4gdXNlIHRvIGp1c3RpZnkgdGhlIGV4dHJhIGNvZGUuIFRoYXQgZG9l
c24ndCBibG9jayB0aGlzIHNjZW5hcmlvDQo+ID4gaGVyZQ0KPiA+IHRob3VnaC4NCj4gPiANCj4g
PiBQYXJkb24gdGhlIHBvc3NpYmx5IG5haXZlIHF1ZXN0aW9uLCBidXQgaXMgdGhpcyAzMi82NCBi
aXQgbWl4aW5nDQo+ID4gc29tZXRoaW5nIGFueSBub3JtYWwsIHNoc3RrLWRlc2lyaW5nLCBhcHBs
aWNhdGlvbnMgd291bGQgYWN0dWFsbHkNCj4gPiBkbz8gTw0KPiA+IHIgbW9yZSB0aGF0IHRoZXkg
Y291bGQgZG8/DQo+IA0KPiBJdCBpcyBub3Qgc29tZXRoaW5nIGNvbW1vbiwgYnV0IGl0IGlzIHNv
bWV0aGluZyB0aGF0IHRoaW5ncyBsaWtlIFdpbmUNCj4gZG8gSUlSQywgYW5kIGl0IHdvdWxkIGJl
IGEgcmVhbCBzaGFtZSBpZiBXaW5lIGNvdWxkIG5vdCB1c2Ugc2hhZG93DQo+IHN0YWNrcyBvciBz
b21ldGhpbmcsIHJpZ2h0IDstKQ0KDQpTaW5jZSB3aW5kb3dzIGhhcyBzaGFkb3cgc3RhY2sgc3Vw
cG9ydCwgSSBndWVzcy4gQnV0IGl0IGxvb2tzIGxpa2UgaXQNCmRvZXNuJ3Qgc3VwcG9ydCBzaGFk
b3cgc3RhY2tzIG9uIDMyIGJpdCBlaXRoZXIuIFNvIGZvciB0aGUgdGltZSBiZWluZywNCml0IHNl
ZW1zIFdpbmUgd291bGRuJ3QgdXNlIHRoaXMgZWl0aGVyLi4uIEkgdGhpbmsuLi4NCg0KPiANCj4g
QnV0IG1vcmUgdG8gdGhlIHBvaW50OyBzaW5jZSB0aGUga2VybmVsIGNhbm5vdCBmb3JiaXQgdGhp
cyBzY2VuYXJpbw0KPiAoYXNpZGUgZnJvbSB0YWtpbmcgYXdheSB0aGUgTERUIGVudGlyZWx5KSBp
dCBpcyBzb21ldGhpbmcgdGhhdCBuZWVkcw0KPiBoYW5kbGluZy4NCg0KSSdtIGhhdmluZyB0byBn
byBlZHVjYXRlIG15c2VsZiBhIGJpdCBvbiB0aGlzIGtpbmQgb2YgY29kZSBtaXhpbmcgYW5kDQpl
eGlzdGluZyBBQkkgZXhwZWN0YXRpb25zLiBJdCBzZWVtcyB5b3UgY291bGQgYWxzbyBqdXN0IG1h
a2UgMzIgYml0DQpzeXNjYWxscyBmcm9tIDY0IGJpdCBjb2RlIHRvIHRyaWdnZXIgdGhlIHNhbWUg
YmVoYXZpb3IuDQoNCk9uIG9uZSBoYW5kIGlmIHdlIHRoaW5rIHRoYXQgbm8gb25lIHdpbGwgdXNl
IHRoaXMsIGl0IHdvdWxkIGJlIGEgc2hhbWUNCnRvIGhhdmUgdG8gbWFpbnRhaW4gMzIgYml0IHNo
YWRvdyBzdGFjayBzdXBwb3J0LiBCdXQgb24gdGhlIG90aGVyIGhhbmQsDQp3ZSBoYXZlIGFsbCB0
aGVzZSBhcHBzIGJlaW5nIGF1dG9tYXRpY2FsbHkgbWFya2VkIGFzIHN1cHBvcnRpbmcgc2hhZG93
DQpzdGFjay4gSWYgdGhpcyB3YXMgbm90IHRoZSBjYXNlLCBJIHdvdWxkIHRoaW5rIGp1c3QgZGVj
bGFyaW5nIHRoaXMNCnVuc3VwcG9ydGVkIHdvdWxkIGJlIHRoZSBiZXN0Lg0KDQpGb3IgYnJpbmdp
bmcgYmFjayAzMiBiaXQgc3VwcG9ydCwgdGhlIHRyaWNreSBwYXJ0IG1pZ2h0IGJlIGEgMzIgYml0
DQppbXBsZW1lbnRhdGlvbiBvZiB0aGUgbmV3IHNoYWRvdyBzdGFjayBzaWdmcmFtZSBkZXNpZ24g
dGhhdCBzdXBwb3J0cw0KYWx0IHNoYWRvdyBzdGFja3MuIFNldHRpbmcgdGhlIGhpZ2ggYml0IHRv
IGd1YXJhbnRlZSB0aGUgZnJhbWUgd2lsbCBub3QNCnBvaW50IHRvIHVzZXIgc3BhY2Ugd29uJ3Qg
d29yayBmb3IgMzIgYml0LiBCdXQgaWYgd2UgYXJlIG1vc3RseSB3b3JyaWVkDQphYm91dCBtYWtp
bmcgc3VyZSBpdCBpcyBzdGlsbCBmdW5jdGlvbmFsIHdlIGNvdWxkIG1heWJlIGp1c3QgaGF2ZSBh
DQpzbGlnaHRseSBsZXNzIHByb3RlY3RpdmUgZm9ybWF0IGZvciB0aGUgc2hhZG93IHN0YWNrIHNp
Z2ZyYW1lIGZvciAzMg0KYml0LiBJdCB3b3VsZCBub3QgaGF2ZSB0aGUgc2FtZSBTUk9QIHByb3Rl
Y3Rpb25zLiBIYXZlIHRvIHRoaW5rIGlmIHRoaXMNCmlzIGEgc2VjdXJpdHkgaG9sZSBmb3IgNjQg
Yml0IHRob3VnaC4NCg0KQW55d2F5LCBJJ20gc3RpbGwgZGlnZ2luZyBvbiB0aGlzIG9uZSwgYW5k
IGp1c3Qgd2FudGVkIHRvIGxldCB5b3Uga25vdw0Kd2hlcmUgSSB3YXMgYXQuDQo=
