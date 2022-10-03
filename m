Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7A35F372A
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 22:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiJCUeD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 16:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJCUeB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 16:34:01 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE7A36841;
        Mon,  3 Oct 2022 13:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664829240; x=1696365240;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nilTpKCQIkA2sNC0MKw2LXpoIyp6TImckSLF0tDGQII=;
  b=TCIkV7uhGgSM5I/vhZKkjAw8kY6Sfb8SRUdjcPFhgAKWRiwAO4eJyG9Q
   dDW6109wAMZw+MH0XT6k/3x9Q4PumMK/hBdGiz8WxNs5l7LjKR5/2Pjr8
   RIFRPfsDp2Jy47MujovouKZaHN9yvTiBIoQ1C7qY+YeaUnTUNTtatTWUt
   HP5VRhpCjcLuAZu8LksCmPQ3BLzrM5w5Jj1hCf5abe9RlYp/Wetb3C5Qx
   NAk7Dehki1r4PaTGRqjUgIWVln8YlK/t9U2VUxdlJsIPeMgg4XeH/hQkG
   QR7VWwZtMTtjvj4IFWsQ0yB6KOCFnXs2ufUPUFbiOnPyKJRQKU7Hs6vHY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="389044079"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="389044079"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 13:33:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="798878105"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="798878105"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 03 Oct 2022 13:33:59 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 13:33:59 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 13:33:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 3 Oct 2022 13:33:58 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 3 Oct 2022 13:33:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFK2UNCnUaHRy43WLFc4xQ+kbrXTGSfVvF6otpu0VpKcdWS7+gtFpzo6Um+Y+4F0sDXsR4BzqZvIYBlbs0VsyNUfxEurzNEPN6fl97czGLchs8yvsMam0lFb+Q+k0vkk0gW5Y1V3E8yx16o1FoD32yGG+dRdbtbwJI+CVKMdYfZyv+e6kPevl/9U7dcxUplx/qnCbT4CL5oYzqt3PZj0pfc8xEmYm1uIryN9EVbq8hr9+OiK7uk3qpqvzqpmWrmrD8+k9Y1+j5GCct0jBD+fhJqbiRPfgJ40EJ95D/b6q9XhD8V4IdFpOLbe1shetazc2hd8rK41AyQWEWUeCkdzxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nilTpKCQIkA2sNC0MKw2LXpoIyp6TImckSLF0tDGQII=;
 b=kShCBOZY9Uzd1dRqqW7VXXUcjMlQI5E1/+GIGJRpvZteFE6DQJpY+bH/OI07BM+Pa+syo/wWgt1GuijACRPO72qNf7gm9NPF6N7EqbqgC81j5zBab4AQsb0cTVsoUAuaN5KGw52CA8zbMhZTG7IhFpYpX7S2Gbp61vqakN1ks9EZnxSmVyXlIIoE/Cl7XkNuQkLuInIbjfGOvVKe7ZyILdGBnU9O6l5zjoN5iOYOyiN3eh14M/dvoJ9Yqqq3/U6lPkNF9dEYKqcqX00/xH2rFS7duaRWr70LU7dHWio1H8Hp8l9dTF1+bLV4uz33xRAWQj1zUcZrHW8ZLbkUsr6Mvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MN2PR11MB4517.namprd11.prod.outlook.com (2603:10b6:208:24e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Mon, 3 Oct
 2022 20:33:42 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 20:33:42 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "keescook@chromium.org" <keescook@chromium.org>
CC:     "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
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
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 07/39] x86/cet: Add user control-protection fault
 handler
Thread-Topic: [PATCH v2 07/39] x86/cet: Add user control-protection fault
 handler
Thread-Index: AQHY1FMIU7BZJQMEy0SHUZZeq6SSP638/IGAgAApsoA=
Date:   Mon, 3 Oct 2022 20:33:42 +0000
Message-ID: <9dcd47faf6f5ebeb56703b0a5036ee173fa0595e.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-8-rick.p.edgecombe@intel.com>
         <202210031055.62E60F6BBE@keescook>
In-Reply-To: <202210031055.62E60F6BBE@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MN2PR11MB4517:EE_
x-ms-office365-filtering-correlation-id: 02dce1af-afc6-4d04-2089-08daa57e8fca
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B+04LlZkIOzdCm1lbvdUgxhGRZW2G9F8AtGFuRpSoTdDZFZwbRitVKHjMnMc1udIEZzPwH67Ow/jpipyKxJNQzGjVCyBZECMcVAOaQKvV3rNWPJyCFktubI0ROk6EavsPa7BQ55oa1Muam6wkXvweB97mSwgLdE3hvx7QeldY7dIaxz99xONiE8bbCy7HGeF0ntT/EGo8IsTOMsO7ezRb9eXzqWrZARIXqOd2yfWQZsSAdYQXeL93P7QK/11EK/TizO35Yc9VL/35t7lw1afFRpNiWvCv88jJU00OmAX8AXeoDEa+IVp+nffScWf/Q/Infw13eiIHrZva+nUr/959AzRLA8Z3vf2EnDO1+0E222TEvH06oWut2G7FuipajY5u/CKvZ8WRSVUp/DUpn0oRt3fHkYgK2mLeOkXzquAeH6/detshPARdeLnrzqa12E1TEue8gXYiKo4H31yas+OjKctJsYSHHqUP9tanUPH5waOvJ4Sj8WXYlsYc7wLedYvJJM0dAhriCutHiGf7LiiDFiOno5WbaRcl8XjUN9hIoKmmCezyJG2CI9k+iFybdm6MjRgO2LXL/5H1BTZT+3rlh+nT+UsYFreCneP+lY0zSEqljY/x3JiwrJXeOIcWulncQ+tMlUCvOl17w5+NMcG7S0XNWPY6SivLSTOe5dxlPn0Pk9qVn26UNbOwr8F3d0RPsP1aqKrfat7Grk1S/nGP+BMuCpBkHBTBFiZGX8tyIYB1dhyw1CS/zGkqLW1a+3nV2jEmGJZgOSjXtMbaMSutATEwyPLGyICSjXQ0t8N43w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(376002)(39860400002)(346002)(366004)(451199015)(6512007)(26005)(316002)(6916009)(82960400001)(38100700002)(54906003)(6486002)(8676002)(71200400001)(122000001)(36756003)(38070700005)(86362001)(64756008)(2616005)(4326008)(6506007)(186003)(91956017)(4744005)(5660300002)(66946007)(66556008)(66446008)(66476007)(8936002)(7416002)(7406005)(2906002)(76116006)(41300700001)(478600001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVl1TjZKbG4vbW5zYU16clhjUTByUFRDOTJQTTFvMGxidy91d3RhU1hjZXR3?=
 =?utf-8?B?WEttZXZ4TUpoWGJaamtYV1lhWGc1TkxqbDFZS0F2SFpmay9iRWhINVNac25I?=
 =?utf-8?B?a2JQbXFyb0lBYzZSK2hLM1IxUzBlRCtUbGJQMEQzR1JoUlNWd1NaN0tWcE4v?=
 =?utf-8?B?SU13QTlvQ1JWUy85dzdtMW8wdUxFWUxSdnJVbzRkV3N1SnZEVmgzS2NscUtI?=
 =?utf-8?B?amQ2NU1lcmorZjRqckQvQXN0b3RMbHNVL0dLVjRsUXQvS1ZIQkRmL21vaDVa?=
 =?utf-8?B?ckxZTFJkRlVscy9BTmpJNkt3bjdMR3Nqd1dJYThQRm9pemxoOG1YcmFnTkNR?=
 =?utf-8?B?SGJ3NXU5UjlKSmZySXlMZ0h6ek5vcmZaak1seW1pLy9WNXVSZklud2QzNHhJ?=
 =?utf-8?B?NFJhT3NOakVlK3V6Uk1GbHcrZEsxdksyYVRKNENZZVVzRnNmbFlxS3JBRmJF?=
 =?utf-8?B?eDQ5WFBTazhrWVkrNUFOS3ZveVhNOTJ0UGlmRzJabEJDOGgwUGFQN3NPMStK?=
 =?utf-8?B?YVR3THJnTFBFamVBRFVMV09UbmFDWERmSTdyUG5tZ2RzTzJ1c1VYYnpkMHdi?=
 =?utf-8?B?ZEdwUktDSHNiNFBLMmFlNjRVUUhsQTlTQ2ZvTkoyYnpYTE5tR1lCNHB4c05x?=
 =?utf-8?B?TnZZeWhleGU2RlR3Y1ovUjVKK01tWDBXNjltcEJBLzRrM2xVYVVTbmpoaWhP?=
 =?utf-8?B?dTZHNnJGQmlpUEsxK3M2RGd3SWY3NGlmZ2MvR1VXUEwwbzhneXFQMnNoYkNK?=
 =?utf-8?B?dnFHc2UyM01vb3pnUHVaNzRVZ3VXRTc4aXhVZkJ2MXhabEtKZnZPdyt2QWZB?=
 =?utf-8?B?T3BwNGtrWXJIeUR5YWluZGVRZjF3Q2FFa2lYSlRxWjNjenBCWkF1MnByRi9E?=
 =?utf-8?B?dFEvVDNJbXczckw0TDZWd0dyb1ByeG01d2puSnh0eFVKaXArVENEVFZMSDFS?=
 =?utf-8?B?NjEycGpra2R0bFZta000RXdiRmpFRHVOK0N3djM3TGFFQzJzZkpscGw4REJ1?=
 =?utf-8?B?V3FYdDBQYlNXS0o4U0tKOWx6MEduTlpIdmFYWWZqcUxIQU9JUURIZCsyQTR5?=
 =?utf-8?B?eGtVVUhVZGwxcGg4ZHJtbjhVR3J4MUZsTXppWHNyUFlJQWNtU2Mxb28zSlRu?=
 =?utf-8?B?UlQwZ0JJcWJCVWVIUUJPSmxxM2t4MWFyYXV5VHVKSC9haXdabjE4N2d3b2R2?=
 =?utf-8?B?b2JMa21ocU10T3dDUDRiZUN0L0dObGtCTVZLTlhFK04rN3BuY01FdnJGSXc3?=
 =?utf-8?B?L2tMYTYvenNXNm5teTZ6V3phY0grelkxY0Voam5HZHNJc1ZSSy9jY1VUU0c3?=
 =?utf-8?B?VDJyUCsyNUlsZC9NQVhuY2o0SG9Fa01US3BkTUI0SFlGSEluWmhtQU9ERVhs?=
 =?utf-8?B?V2ROMEhnam1tVEdEK2FaZFN5alhJQTFIY3dnRVlFRExRK0lpK1hnQ0laQ1Qw?=
 =?utf-8?B?SjdGYnMyNk5GREovcEoxTitkdXByZW9MVDRZWE5oUGJ1UWZMbmZEbkZ0aE5i?=
 =?utf-8?B?VDhLRjBsRlB4cVR6S0ZkTGUxczYvMnpNNVRQcmJ3Q1A1K0tIUWc1OGl0WGdF?=
 =?utf-8?B?M3VNLzNNMmNTN25LOVVMRHNGOFNlUFYvNFhEMnI3RHJVR3lNakozSzdHY2Yz?=
 =?utf-8?B?NENmanVQT29PMkZRZ1QxcnNHcWNmd3FISEg1TkRtNTBGNVEvZWw2M3pkaGpD?=
 =?utf-8?B?VGJFU0dIV01mR0NtbzVTVzZicEdXdmI5YkIwaHhBQWczVTR0NzltN3RmRU9J?=
 =?utf-8?B?LzB6eTlPQXFDenphMUhUK1U0SE1SYUJBbHhRa3RJWjI3TFdQd21YV2lQeE85?=
 =?utf-8?B?YlRoY0pHY2dnekM1OTdSYUxYczVYUHhvT3hVcWR5UFR5dlJ4dSttekFGdVJz?=
 =?utf-8?B?elIvVGJKaEs0a01wSElDODc4MW10ZS9yL2NlRVk2ek1sTFlIV1luQ0RlUnBo?=
 =?utf-8?B?Z1dOQTZxMFBaT3ZIdG41amo2MGt3TXc0MGFHcktBeFJDTUJSSmZTNHlrUGRL?=
 =?utf-8?B?NnRMcGFoVjhjUTc1bGRGaVV5bWVsbTBsWWJhUENJZmhOODVwUGc1ZG13S3JS?=
 =?utf-8?B?TUpSb1lPTGxmL25ML3FRWWQyYzdxN1BGTzlLMFc5RVdYak5ZSmpXSTk3OXNv?=
 =?utf-8?B?Nk53Qi9FUVVZZ1cyallqekx2cldTN3lIWmRKNGhHNFI3TUxnSW9Lc0dnZ1Bq?=
 =?utf-8?Q?vL/O5IAhMN5dBN6OEaxKhFk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <984B9E3F9B43B94DB7F0EE3E30F1934A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02dce1af-afc6-4d04-2089-08daa57e8fca
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 20:33:42.2884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SZJq2yjJ9ehNrWNq/gDQizlwM978o8nuk6UE27Hwf8ekwShR0YCfp2ZlVZ9kZfZS9VWylINq3mC6P81t9eMv1ZBgCQ7Bolt1SVQs0bc73PQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4517
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTAzIGF0IDExOjA0IC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IE9u
IFRodSwgU2VwIDI5LCAyMDIyIGF0IDAzOjI5OjA0UE0gLTA3MDAsIFJpY2sgRWRnZWNvbWJlIHdy
b3RlOg0KPiA+IFsuLi5dDQo+ID4gLSNpZmRlZiBDT05GSUdfWDg2X0tFUk5FTF9JQlQNCj4gPiAr
I2lmIGRlZmluZWQoQ09ORklHX1g4Nl9LRVJORUxfSUJUKSB8fA0KPiA+IGRlZmluZWQoQ09ORklH
X1g4Nl9TSEFET1dfU1RBQ0spDQo+IA0KPiBUaGlzIHBhdHRlcm4gaXMgcmVwZWF0ZWQgc2V2ZXJh
bCB0aW1lcy4gUGVyaGFwcyB0aGVyZSBuZWVkcyB0byBiZSBhDQo+IENPTkZJR19YODZfQ0VUIHRv
IG1ha2UgdGhpcyBtb3JlIHJlYWRhYmxlPyBSZWFsbHkganVzdCBhIHN0eWxlDQo+IHF1ZXN0aW9u
Lg0KDQpIbW0sIGdvb2QgaWRlYS4gVGhhbmtzLg0K
