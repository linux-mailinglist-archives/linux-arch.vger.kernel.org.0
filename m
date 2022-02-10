Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACAF4B0F64
	for <lists+linux-arch@lfdr.de>; Thu, 10 Feb 2022 14:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239611AbiBJNwt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Feb 2022 08:52:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238274AbiBJNws (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Feb 2022 08:52:48 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B557EBAE;
        Thu, 10 Feb 2022 05:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644501168; x=1676037168;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=W1NIQyYKXOc6+AYo0R2oQXyREC6mjDhheeeJb51+YXs=;
  b=VTsfaD7Mb40cL85gsyc2UNXW4SGPKSAhazDTiOmswGoQta4JkOQJh1ZT
   3YbWmu0jLhQPP+e1301j4+dGsbvUw7fjKnTkmQl3Jpnn2o7v+ix85fV0m
   VuXaCyuGjgb9hOVAg4cf+Qedk80J1QNjWPhbxCXJVD6t7+JyL/TINHGg0
   fKmW5hWK6y9Vgy6vsmalaIPWgoHpoWOINdNfnDF/rp2CbcI3f2za+BAJ5
   yqbAYhfp8LIbPPAUkYEogMOlYl8sA5XYS1KsnDhwElcwDqm0+D5WuUceX
   N8tlQjAlpn/DzRLzckpgOj130Cow3G0lAN24xlDn5Qbq+khnHqQ/qnoPA
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="236896353"
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="236896353"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 05:52:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="568657679"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga001.jf.intel.com with ESMTP; 10 Feb 2022 05:52:48 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 10 Feb 2022 05:52:47 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 10 Feb 2022 05:52:47 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 10 Feb 2022 05:52:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwRs7xJgWmCV5e3nkFf+2DvdDH2yvaNTy8Hohm1vXGKaguloIO/Vl/REtNvrMoft/S4tPzTKDwI2Y8mTowJ2bPc96nPMAvMLenDfudQBunb5v7c56Lw/gvSueo6Dj0fdaPRmClYiDJSlvaFtMz4oxF+aGe5CbZTZHpqQQkibhjtnz814l7Kng6PEvjuptRrP9LNT26FCd9aILQjmBmCZvUkcz8Lyl+UOsh8wSp+mx6O22E5Ab9rm7fA7eQRKElt+oB0vCfX093VJACYrY/ol+Xz8E6iM6TMvqKCRFKZlpFMb7uLanDFEskJQw35rZc4nIQwYAZgeExrYLcnslDMEvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1T2FXIKtzSFb9h6hSq1GaEkQMZk/u/gct1dM9Pdf6ic=;
 b=frsf6aPhTZKAVPMPYOVXk2sw5EMWPq+O8XEPvECTtAv390sAyfx4+FnAOoGJCDOPbQb4MIYhEGMkrhddtWJzzHG9AmoQKFV4aiWOSHv6m7DMGrnNvoiVBg30D7cnv2DyCMXMUJ3LLvYVozLEbqzSKyTZIkDotvkHbPsAq3mUGozmvI3XFrqNHzMWQNjcC/DWDNDeiG+fpqmEHo+UAKX8vVG7OyWSKJ08XZ05zWcC95kXoWSeOGyWPYF8IMRhoY359aRhY8kY9Pm5Zx52uuDbuDqk/H/g8tMdOZ9VDztaEi2HHmk6PeEP9l6RnoeBHmJUFZgtolG1C4o6TJUxG7l1rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SA0PR11MB4574.namprd11.prod.outlook.com (2603:10b6:806:71::11)
 by DM5PR11MB1945.namprd11.prod.outlook.com (2603:10b6:3:10b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 13:52:45 +0000
Received: from SA0PR11MB4574.namprd11.prod.outlook.com
 ([fe80::c52a:9d30:b5fa:1098]) by SA0PR11MB4574.namprd11.prod.outlook.com
 ([fe80::c52a:9d30:b5fa:1098%4]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 13:52:45 +0000
From:   "Willgerodt, Felix" <felix.willgerodt@intel.com>
To:     "H.J. Lu" <hjl.tools@gmail.com>,
        "Lutomirski, Andy" <luto@kernel.org>
CC:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "adrian@lisas.de" <adrian@lisas.de>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "avagin@gmail.com" <avagin@gmail.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>
Subject: RE: [PATCH 00/35] Shadow stacks for userspace
Thread-Topic: [PATCH 00/35] Shadow stacks for userspace
Thread-Index: AQHYHimCH9dgxil1n0ySs5G7yCEoKKyMe9kg
Date:   Thu, 10 Feb 2022 13:52:44 +0000
Message-ID: <SA0PR11MB45740379EEEBE9F2BFF0D1428E2F9@SA0PR11MB4574.namprd11.prod.outlook.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <YgAWVSGQg8FPCeba@kernel.org> <YgDIIpCm3UITk896@lisas.de>
 <8f96c2a6-9c03-f97a-df52-73ffc1d87957@intel.com>
 <YgI1A0CtfmT7GMIp@kernel.org> <YgI37n+3JfLSNQCQ@grain>
 <357664de-b089-4617-99d1-de5098953c80@www.fastmail.com>
 <YgKiKEcsNt7mpMHN@grain>
 <8e36f20723ca175db49ed3cc73e42e8aa28d2615.camel@intel.com>
 <9d664c91-2116-42cc-ef8d-e6d236de43d0@kernel.org>
 <CAMe9rOo+RbmK5GyFKe2q3GGFP4Oi3o16x9xVpD7HpoEn=v0mfQ@mail.gmail.com>
In-Reply-To: <CAMe9rOo+RbmK5GyFKe2q3GGFP4Oi3o16x9xVpD7HpoEn=v0mfQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.200.16
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e75bd5e-7379-410a-49dd-08d9ec9c9d81
x-ms-traffictypediagnostic: DM5PR11MB1945:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR11MB1945D7BEB4A8453723C826378E2F9@DM5PR11MB1945.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: moI5xJgNaythEs8HxFYSkI6fbnpI/t8WGStpyVZw9gbMFK8mCYbhkiVyciad+VV4dDDuWywlg4CU1UjGI/VS21Nzx+HnmgpPyC65AowEiII9bUBCOtdD64fKHcZAni08yZxDFySyyZjKMWEn8jisoFsRYL+jEhI4v4g3O5yVwllDQRouVxSMiIKmlJUogeYnFZqii9jYDCYCorXnDm2fSXWqOgJHy2OBUk8QMkxp5L9ZF+8G9n86RXkLL4jxxF1rIFjTP5DwlDz8/UdFevv9s/OFK9dK3/rm36FjYbLrfI5dK1/5SYKpNpYfQBADK8aU/Zfws05Kw6z3mjAR+eYOa7B+QBowh3VEABoh6TNNN4aTrPvVT93vlvs/rgRL+cO1IT1pOBC2j+0dyCguycAIEFI5BNEVbIhnhcJ2pSoqgHf4MzrKvfv3k9elDc5Srq+tv5vnCZoEly+/irhYUpnm7+YrZZulKjwaLBO7ny0wu2zRpczt9WPHQD8OUe1VuZowylPTzg2gF7qDQWe8lGWeItSpOtfavmxuA1i3JlNi1f54M4/wFelwRAZ/kDMZitAatN+fE+KkaqUyeit2v9VkCwb8gOIUfqdZDKbwlX26TkwnHVToxVKMwIvM4SxL2ytzrlt5UAegG4GEaiclRt9+QXS5LhXTsj56nk0z3yfPRw9jyy7J9+RjzEtAmYGSdem6sP0YXXebF8MD6t41rrnvRw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4574.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52536014)(7406005)(26005)(83380400001)(122000001)(4326008)(186003)(2906002)(7416002)(38100700002)(82960400001)(38070700005)(66446008)(53546011)(76116006)(71200400001)(7696005)(6506007)(66946007)(55016003)(110136005)(508600001)(33656002)(54906003)(64756008)(316002)(66556008)(9686003)(66476007)(86362001)(8936002)(5660300002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZG03QkpzelgvaGFIcFhxVW02aDFZN0xxWGJJcWNPM0d6NmNKaUFERGdWSysy?=
 =?utf-8?B?RVgwMGlkY1JSbnZUbWxuTkYzeXEwQStmRkhxWTlxWWFkZVBSMjdGR0lrc3BZ?=
 =?utf-8?B?MU5Bc2NNdzJmOUpHRWo1R1pnaEQyenBwVWhNTTEzd211MFhwZmZiZFduV0VP?=
 =?utf-8?B?L1A1NTE3T011bVpQaE1UL1p0SXgrZytpcjFJZmFQV2ZmWGoxUUIxenJyampa?=
 =?utf-8?B?U3gxb0J6SEVUS0UyN2Vwa0JnOHpDTjRGRkZrQzZLQkZBNzJrY3BINk9wczV4?=
 =?utf-8?B?aEhXcmFpS0xoTU5Bd2hVdXN3N0w5NmIvb3Q0LzVzeU5hTVdzSS85aDRsZ0Zp?=
 =?utf-8?B?dVZlNWV5c2drNHB3WmdpSnd6eUdzOUpwRS9CNGRta2pTM2V4eVJGbmVZRHRu?=
 =?utf-8?B?RWRVWFcvUEF0UGpFK1dKaVhEd3QrL0ZHVE01SWtzMXBQSitVdjhaWEZkaFI5?=
 =?utf-8?B?eGVCQVVwd3VwdDdPclROa1lZZXJoVjkvREdoR0gxS2FJRGY3OHE2R2p5bWhR?=
 =?utf-8?B?bUU5YlNtVklTWFZRZ1pWNXp4aThVNVJhSWROajZ6ak56bkJ6TXdnMGpxSzhB?=
 =?utf-8?B?WjFwYnVKVnB0NDVNVEx1RkFJb1VxdFBlcVhZVjhPOGxqN3N4NVZDeG1BREdh?=
 =?utf-8?B?dnB5cVVZQ2gvVU9sMWVZWTJJNUkrQXAxNTJTZEZYeXZKYVI3MjJJV3ZEY3F3?=
 =?utf-8?B?RU0wTjh6U2U3eW03UWI1emhNM2FGN0ZRYXhyWk5oTGdKUnhYYnRtMEgycnNJ?=
 =?utf-8?B?aGZVSkgxUlBRa2hMM2hmSEMxVTJudW9QQXlQV2Noai9KK2dKK3VhUitJbWdJ?=
 =?utf-8?B?ekl5cGV3U0hWbGFaMm5jOTc0ZTNPYnZiVGxkQlhyUXlGZ0JlcG9CSk1HS0hs?=
 =?utf-8?B?ckxhMm1VWWtqMWNZaGxwSXN3K2ZneXNXYlRaVEVUeTBDMFNaZ2tidHVmT1lK?=
 =?utf-8?B?Wmc1K0ZzaHpJbzZOVVhSL3pzbnMvODBpd3ZrRjlzbm1yb3AxL1NhZE5mbmlF?=
 =?utf-8?B?b3pIVHdMWUowaEpJM05DWnBHaFpWdU5ZbkZzcE1lZUZtbU4rYWRZZlZRT3NP?=
 =?utf-8?B?Q0tHMldTYXhXMFdYaytTajN5VEpzVW5IUmpSQkUvdDdROERHNXdNeVluR2Jt?=
 =?utf-8?B?SmQ2TFM2aVdzZVVFYW9wM0xEMllNdk02bTVEVXpCbGhoYkJHbEtDSjBGOXJl?=
 =?utf-8?B?RG5VQVN3ZnFyN1NLZHg4azdmNE5DcUszTlk2MndyTUNwN1J5bHJYN083bXRw?=
 =?utf-8?B?cmxlWi9TL05mZ0s0MnozVzBkajFKYVR3bUtWVWswQVUvV2JBMlJWaVlpL2NT?=
 =?utf-8?B?MU1NL3lsN2lYNjRHUXhiZk5kd0FualhxQXlMY01vZjB6SnNEVVBSYzR6VmVp?=
 =?utf-8?B?RWFldWE1QXBPd2pZYXM5alVBRWtyM3F1dmpvVG10UUZyUlMrVmoyOGRaaGxt?=
 =?utf-8?B?STVQZCs3dW5hY0JBUDJXaEdyNk1ocGpzOUNxSmRoNituUkNiV1l2TmFNakdS?=
 =?utf-8?B?WXZRcWJUT2VpTTFqSXZUa1ZEOVVuN2ZHQ2tQY1ZiZU02TkdhK21lR09HOWVx?=
 =?utf-8?B?bGFGUDRnTE1WQ2FhN25sMjhCTUFSR0F3Yk5TNlFDK2dnczVhNmNRNDlKMlJK?=
 =?utf-8?B?RWwwejAvTDdRdTRVZUdocnBpZ09JQmk3alRzRUh3T1hRSENhUkJjbVhzbi9D?=
 =?utf-8?B?RG9BWXoyQTBCY3NOYzdOWWFBZnZlTVZ4Wm5KVnBWRWx4Q0tla0FEdTZEWTQ0?=
 =?utf-8?B?T29hUnFlVHUwUmFDWVZ1MGs3RzJyeDBoRWZ1OElrSjhrblMwa0RkVFdrbmFw?=
 =?utf-8?B?U3dESkt6OWJ5YUVqaFNLWENTZ0crWVdvVmZUQzBVN0RjKzljdjUxV1lqWXNk?=
 =?utf-8?B?VE5GOHF4SENwUDc5b3liSHJmd0NwUFlMUklZa0VIM05SQkRCNWl0T0pyLzQ1?=
 =?utf-8?B?d2NYdHZ2SjVWNGFYM0hOTUtKcnhkd2VZWTBxbjRYUkEzR2tvWTdXSzJXMFdy?=
 =?utf-8?B?bUIyZXFCVGZtbGpUVnF1NDN5cXRLQkdBcWJEVXN5L3RrL0YvWnBzdmFWdDJP?=
 =?utf-8?B?R3R6TnpLMXB0MHBsRlpsYmIwR2hjQlA2ZGxxQ0tiL1VudG9QVldZVDNnZWtt?=
 =?utf-8?B?eml6YmxrYk13ZHVJVkwvTWVITEtmNnBGWXNlZ29iOEk5UnZpQ2VCNGlLMCs4?=
 =?utf-8?B?QmRrV1BzYkpsRFRLTXV5L0RqYVU0SzQ5UmVTa1dOaTU1NUowVHVQbXh1N0xX?=
 =?utf-8?B?eWhrdVlUazEvZUc2eTVwa29wVm5BPT0=?=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4574.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e75bd5e-7379-410a-49dd-08d9ec9c9d81
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 13:52:44.9622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JcTkLEfa58swf5iL+uxcA3G4r7YSfdX64kUcw5zEy7FWvdSGqsCZdYAE2fCEDODlJ5uQMpsTSH0u6HADas/GxTc/CWrmsLUzeqUrxuxsjOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1945
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBILkouIEx1IDxoamwudG9vbHNA
Z21haWwuY29tPg0KPiBTZW50OiBEb25uZXJzdGFnLCAxMC4gRmVicnVhciAyMDIyIDAzOjU0DQo+
IFRvOiBMdXRvbWlyc2tpLCBBbmR5IDxsdXRvQGtlcm5lbC5vcmc+OyBXaWxsZ2Vyb2R0LCBGZWxp
eA0KPiA8ZmVsaXgud2lsbGdlcm9kdEBpbnRlbC5jb20+DQo+IENjOiBFZGdlY29tYmUsIFJpY2sg
UCA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+OyBnb3JjdW5vdkBnbWFpbC5jb207DQo+IGJz
aW5naGFyb3JhQGdtYWlsLmNvbTsgaHBhQHp5dG9yLmNvbTsgU3lyb21pYXRuaWtvdiwgRXVnZW5l
DQo+IDxlc3lyQHJlZGhhdC5jb20+OyBwZXRlcnpAaW5mcmFkZWFkLm9yZzsgcmR1bmxhcEBpbmZy
YWRlYWQub3JnOw0KPiBrZWVzY29va0BjaHJvbWl1bS5vcmc7IDB4N2Y0NTRjNDZAZ21haWwuY29t
Ow0KPiBkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb207IGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5p
bnRlbC5jb207IEVyYW5pYW4sDQo+IFN0ZXBoYW5lIDxlcmFuaWFuQGdvb2dsZS5jb20+OyBsaW51
eC1tbUBrdmFjay5vcmc7IGFkcmlhbkBsaXNhcy5kZTsNCj4gZndlaW1lckByZWRoYXQuY29tOyBu
YWRhdi5hbWl0QGdtYWlsLmNvbTsgamFubmhAZ29vZ2xlLmNvbTsNCj4gYXZhZ2luQGdtYWlsLmNv
bTsgbGludXgtYXJjaEB2Z2VyLmtlcm5lbC5vcmc7IGtjY0Bnb29nbGUuY29tOw0KPiBicEBhbGll
bjguZGU7IG9sZWdAcmVkaGF0LmNvbTsgcGF2ZWxAdWN3LmN6OyBsaW51eC1kb2NAdmdlci5rZXJu
ZWwub3JnOw0KPiBhcm5kQGFybmRiLmRlOyBNb3JlaXJhLCBKb2FvIDxqb2FvLm1vcmVpcmFAaW50
ZWwuY29tPjsgdGdseEBsaW51dHJvbml4LmRlOw0KPiBtaWtlLmtyYXZldHpAb3JhY2xlLmNvbTsg
eDg2QGtlcm5lbC5vcmc7IFlhbmcsIFdlaWppYW5nDQo+IDx3ZWlqaWFuZy55YW5nQGludGVsLmNv
bT47IHJwcHRAa2VybmVsLm9yZzsgRGF2ZS5NYXJ0aW5AYXJtLmNvbTsNCj4gam9obi5hbGxlbkBh
bWQuY29tOyBtaW5nb0ByZWRoYXQuY29tOyBIYW5zZW4sIERhdmUNCj4gPGRhdmUuaGFuc2VuQGlu
dGVsLmNvbT47IGNvcmJldEBsd24ubmV0OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0K
PiBsaW51eC1hcGlAdmdlci5rZXJuZWwub3JnOyBTaGFua2FyLCBSYXZpIFYgPHJhdmkudi5zaGFu
a2FyQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwMC8zNV0gU2hhZG93IHN0YWNr
cyBmb3IgdXNlcnNwYWNlDQo+IA0KPiBPbiBXZWQsIEZlYiA5LCAyMDIyIGF0IDY6MzcgUE0gQW5k
eSBMdXRvbWlyc2tpIDxsdXRvQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gT24gMi84LzIy
IDE4OjE4LCBFZGdlY29tYmUsIFJpY2sgUCB3cm90ZToNCj4gPiA+IE9uIFR1ZSwgMjAyMi0wMi0w
OCBhdCAyMDowMiArMDMwMCwgQ3lyaWxsIEdvcmN1bm92IHdyb3RlOg0KPiA+ID4+IE9uIFR1ZSwg
RmViIDA4LCAyMDIyIGF0IDA4OjIxOjIwQU0gLTA4MDAsIEFuZHkgTHV0b21pcnNraSB3cm90ZToN
Cj4gPiA+Pj4+PiBCdXQgc3VjaCBhIGtub2Igd2lsbCBpbW1lZGlhdGVseSByZWR1Y2UgdGhlIHNl
Y3VyaXR5IHZhbHVlIG9mDQo+ID4gPj4+Pj4gdGhlIGVudGlyZQ0KPiA+ID4+Pj4+IHRoaW5nLCBh
bmQgSSBkb24ndCBoYXZlIGdvb2QgaWRlYXMgaG93IHRvIGRlYWwgd2l0aCBpdCA6KA0KPiA+ID4+
Pj4NCj4gPiA+Pj4+IFByb2JhYmx5IGEga2luZCBvZiBsYXRjaCBpbiB0aGUgdGFza19zdHJ1Y3Qg
d2hpY2ggd291bGQgdHJpZ2dlcg0KPiA+ID4+Pj4gb2ZmIG9uY2UNCj4gPiA+Pj4+IHJldHVydCB0
byBhIGRpZmZlcmVudCBhZGRyZXNzIGhhcHBlbmVkLCB0aHVzIHdlIHdvdWxkIGJlIGFibGUgdG8N
Cj4gPiA+Pj4+IGp1bXAgaW5zaWRlDQo+ID4gPj4+PiBwYXJhdGl0ZSBjb2RlLiBPZiBjb3Vyc2Ug
c3VjaCB0cmlnZ2VyIHNob3VsZCBiZSBhdmFpbGFibGUgdW5kZXINCj4gPiA+Pj4+IHByb3Blcg0K
PiA+ID4+Pj4gY2FwYWJpbGl0eSBvbmx5Lg0KPiA+ID4+Pg0KPiA+ID4+PiBJJ20gbm90IGZ1bGx5
IGluIHRvdWNoIHdpdGggaG93IHBhcmFzaXRlLCBldGMgd29ya3MuICBBcmUgd2UNCj4gPiA+Pj4g
dGFsa2luZyBhYm91dCBzYXZlIG9yIHJlc3RvcmU/DQo+ID4gPj4NCj4gPiA+PiBXZSB1c2UgcGFy
YXNpdGUgY29kZSBpbiBxdWVzdGlvbiBkdXJpbmcgY2hlY2twb2ludCBwaGFzZSBhcyBmYXIgYXMg
SQ0KPiA+ID4+IHJlbWVtYmVyLg0KPiA+ID4+IHB1c2ggYWRkci9scmV0IHRyaWNrIGlzIHVzZWQg
dG8gcnVuICJpbmplY3RlZCIgY29kZSAoY29kZSBpbmplY3Rpb24NCj4gPiA+PiBpdHNlbGYgaXMN
Cj4gPiA+PiBkb25lIHZpYSBwdHJhY2UpIGluIGNvbXBhdCBtb2RlIGF0IGxlYXN0LiBEaW1hLCBB
bmRyZWksIEkgZGlkbid0IGxvb2sNCj4gPiA+PiBpbnRvIHRoaXMgY29kZQ0KPiA+ID4+IGZvciB5
ZWFycyBhbHJlYWR5LCBkbyB3ZSBzdGlsbCBuZWVkIHRvIHN1cHBvcnQgY29tcGF0IG1vZGUgYXQg
YWxsPw0KPiA+ID4+DQo+ID4gPj4+IElmIGl0J3MgcmVzdG9yZSwgd2hhdCBleGFjdGx5IGRvZXMg
Q1JJVSBuZWVkIHRvIGRvPyAgSXMgaXQganVzdA0KPiA+ID4+PiB0aGF0IENSSVUgbmVlZHMgdG8g
cmV0dXJuDQo+ID4gPj4+IG91dCBmcm9tIGl0cyByZXN1bWUgY29kZSBpbnRvIHRoZSB0by1iZS1y
ZXN1bWVkIHByb2dyYW0gd2l0aG91dA0KPiA+ID4+PiB0cmlwcGluZyBDRVQ/ICBXb3VsZCBpdA0K
PiA+ID4+PiBiZSBhY2NlcHRhYmxlIGZvciBDUklVIHRvIHJlcXVpcmUgdGhhdCBhdCBsZWFzdCBv
bmUgc2hzdGsgc2xvdCBiZQ0KPiA+ID4+PiBmcmVlIGF0IHNhdmUgdGltZT8NCj4gPiA+Pj4gT3Ig
ZG8gd2UgbmVlZCBhIG1lY2hhbmlzbSB0byBhdG9taWNhbGx5IHN3aXRjaCB0byBhIGNvbXBsZXRl
bHkgZnVsbA0KPiA+ID4+PiBzaGFkb3cgc3RhY2sgYXQgcmVzdW1lPw0KPiA+ID4+Pg0KPiA+ID4+
PiBPZmYgdGhlIHRvcCBvZiBteSBoZWFkLCBhIHNpZ3JldHVybiAob3Igc2lncmV0dXJuLWxpa2Ug
bWVjaGFuaXNtKQ0KPiA+ID4+PiB0aGF0IGlzIGludGVuZGVkIGZvcg0KPiA+ID4+PiB1c2UgZm9y
IGFsdHNoYWRvd3N0YWNrIGNvdWxkIHNhZmVseSB2ZXJpZnkgYSB0b2tlbiBvbiB0aGUNCj4gPiA+
Pj4gYWx0c2hkb3dzdGFjaywgcG9zc2libHkNCj4gPiA+Pj4gY29tcGFyZSB0byBzb21ldGhpbmcg
aW4gdWNvbnRleHQgKG9yIG5vdCAtLSB0aGlzIGlzbid0IGNsZWFybHkNCj4gPiA+Pj4gbmVjZXNz
YXJ5KSBhbmQgc3dpdGNoDQo+ID4gPj4+IGJhY2sgdG8gdGhlIHByZXZpb3VzIHN0YWNrLiAgQ1JJ
VSBjb3VsZCB1c2UgdGhhdCB0b28uICBPYnZpb3VzbHkNCj4gPiA+Pj4gQ1JJVSB3aWxsIG5lZWQg
YSB3YXkNCj4gPiA+Pj4gdG8gcG9wdWxhdGUgdGhlIHJlbGV2YW50IHN0YWNrcywgYnV0IFdSVVNT
IGNhbiBiZSB1c2VkIGZvciB0aGF0LA0KPiA+ID4+PiBhbmQgSSB0aGluayB0aGlzDQo+ID4gPj4+
IGlzIGEgZnVuZGFtZW50YWwgcmVxdWlyZW1lbnQgZm9yIENSSVUgLS0gQ1JJVSByZXN0b3JlIGFi
c29sdXRlbHkNCj4gPiA+Pj4gbmVlZHMgYSB3YXkgdG8gd3JpdGUNCj4gPiA+Pj4gdGhlIHNhdmVk
IHNoYWRvdyBzdGFjayBkYXRhIGludG8gdGhlIHNoYWRvdyBzdGFjay4NCj4gPiA+DQo+ID4gPiBT
dGlsbCB3cmFwcGluZyBteSBoZWFkIGFyb3VuZCB0aGUgQ1JJVSBzYXZlIGFuZCByZXN0b3JlIHN0
ZXBzLCBidXQNCj4gPiA+IGFub3RoZXIgZ2VuZXJhbCBhcHByb2FjaCBtaWdodCBiZSB0byBnaXZl
IHB0cmFjZSB0aGUgYWJpbGl0eSB0bw0KPiA+ID4gdGVtcG9yYXJpbHkgcGF1c2UvcmVzdW1lL3Nl
dCBDRVQgZW5hYmxlbWVudCBhbmQgU1NQIGZvciBhIHN0b3BwZWQNCj4gPiA+IHRocmVhZC4gVGhl
biBpbmplY3RlZCBjb2RlIGRvZXNuJ3QgbmVlZCB0byBqdW1wIHRocm91Z2ggYW55IGhvb3BzIG9y
DQo+ID4gPiBwb3NzaWJseSBydW4gaW50byByb2FkIGJsb2Nrcy4gSSdtIG5vdCBzdXJlIGhvdyBt
dWNoIHRoaXMgb3BlbnMgdGhpbmdzDQo+ID4gPiB1cCBpZiB0aGUgdGhyZWFkIGhhcyB0byBiZSBz
dG9wcGVkLi4uDQo+ID4NCj4gPiBIbW0sIHRoYXQncyBtYXliZSBub3QgaW5zYW5lLg0KPiA+DQo+
ID4gQW4gYWx0ZXJuYXRpdmUgd291bGQgYmUgdG8gYWRkIGEgYm9uYSBmaWRlIHB0cmFjZSBjYWxs
LWEtZnVuY3Rpb24NCj4gPiBtZWNoYW5pc20uICBJIGNhbiB0aGluayBvZiB0d28gcG90ZW50aWFs
bHkgdXNhYmxlIHZhcmlhbnRzOg0KPiA+DQo+ID4gMS4gU3RyYWlnaHQgY2FsbC4gIFBUUkFDRV9D
QUxMX0ZVTkNUSU9OKGFkZHIpIGp1c3QgZW11bGF0ZXMgQ0FMTCBhZGRyLA0KPiA+IHNoYWRvdyBz
dGFjayBwdXNoIGFuZCBhbGwuDQo+ID4NCj4gPiAyLiBTaWduYWwtc3R5bGUuICBQVFJBQ0VfQ0FM
TF9GVU5DVElPTl9TSUdGUkFNRSBpbmplY3RzIGFuIGFjdHVhbCBzaWduYWwNCj4gPiBmcmFtZSBq
dXN0IGxpa2UgYSByZWFsIHNpZ25hbCBpcyBiZWluZyBkZWxpdmVyZWQgd2l0aCB0aGUgc3BlY2lm
aWVkDQo+ID4gaGFuZGxlci4gIFRoZXJlIGNvdWxkIGJlIGEgdmFyaWFudCB0byBvcHQtaW4gdG8g
YWxzbyB1c2luZyBhIHNwZWNpZmllZA0KPiA+IGFsdHN0YWNrIGFuZCBhbHRzaGFkb3dzdGFjay4N
Cj4gPg0KPiA+IDIgd291bGQgYmUgbW9yZSBleHBlbnNpdmUgYnV0IHdvdWxkIGF2b2lkIHRoZSBu
ZWVkIGZvciBtdWNoIGluIHRoZSB3YXkNCj4gPiBvZiBhc20gbWFnaWMuICBUaGUgaW5qZWN0ZWQg
Y29kZSBjb3VsZCBiZSBwbGFpbiBDIChvciBSdXN0IG9yIFppZyBvcg0KPiA+IHdoYXRldmVyKS4N
Cj4gPg0KPiA+IEFsbCBvZiB0aGlzIG9ubHkgcmVhbGx5IGhhbmRsZXMgc2F2ZSwgbm90IHJlc3Rv
cmUuICBJIGRvbid0IHVuZGVyc3RhbmQNCj4gPiByZXN0b3JlIGVub3VnaCB0byBmdWxseSB1bmRl
cnN0YW5kIHRoZSBpc3N1ZS4NCj4gDQo+IEZXSVcsIENFVCBlbmFibGVkIEdEQiBjYW4gY2FsbCBh
IGZ1bmN0aW9uIGluIGEgQ0VUIGVuYWJsZWQgcHJvY2Vzcy4NCj4gQWRkaW5nIEZlbGl4IHdobyBt
YXkga25vdyBtb3JlIGFib3V0IGl0Lg0KPiANCj4gDQo+IC0tDQo+IEguSi4NCg0KSSBkb24ndCBr
bm93IG11Y2ggYWJvdXQgQ1JJVSBvciBrZXJuZWwgY29kZSwgc28gSSB3aWxsIHN0aWNrIHRvIGV4
cGxhaW5pbmcNCndoYXQgb3VyIEdEQiBwYXRjaGVzIGZvciBDRVQgKG5vdCB1cHN0cmVhbSB5ZXQp
IGN1cnJlbnRseSBkby4NCg0KR0RCIGRvZXMgaW5mZXJpb3IgY2FsbHMgYnkgc2V0dGluZyB0aGUg
UEMgdG8gdGhlIGZ1bmN0aW9uIGl0IHdhbnRzIHRvIGNhbGwNCmFuZCBieSBtYW5pcHVsYXRpbmcg
dGhlIHJldHVybiBhZGRyZXNzLiBJdCBiYXNpY2FsbHkgY3JlYXRlcyBhIGR1bW15DQpmcmFtZSBh
bmQgcnVucyB0aGF0IG9uIHRvcCBvZiB3aGVyZSBpdCBjdXJyZW50bHkgaXMuDQoNClRvIGVuYWJs
ZSB0aGlzIGZvciBDRVQsIG91ciBHREIgQ0VUIHBhdGNoZXMgcHVzaCBvbnRvIHRoZSBzaHN0ayBv
ZiB0aGUNCmluZmVyaW9yIGJ5IHdyaXRpbmcgdG8gdGhlIGluZmVyaW9ycyBtZW1vcnksIGlmIGl0
IGlzbid0IG91dCBvZiByYW5nZSwNCmFuZCBieSBpbmNyZW1lbnRpbmcgdGhlIFNTUCAodXNpbmcg
TlRfWDg2X0NFVCksIGJvdGggdmlhIHB0cmFjZS4NCg0KKEdEQiBhbHNvIGhhcyBhIGNvbW1hbmQg
Y2FsbGVkICdyZXR1cm4nLCB3aGljaCBiYXNpY2FsbHkgcmV0dXJucyBlYXJseSBmcm9tDQphIGZ1
bmN0aW9uLiBIZXJlIEdEQiBqdXN0IGRlY3JlbWVudHMgdGhlIFNTUCB2aWEgcHRyYWNlLikNCg0K
VGhpcyB3YXMgYmFzZWQgb24gZWFybGllciB2ZXJzaW9ucyBvZiB0aGUga2VybmVsIHBhdGNoZXMu
DQpJZiB0aGUgaW50ZXJmYWNlIG5lZWRzIHRvIGNoYW5nZSBvciBpZiBuZXcgaW50ZXJmYWNlcyB3
b3VsZCBiZSBhdmFpbGFibGUgdG8NCmRvIHRoaXMgYmV0dGVyLCB0aGF0IGlzIGZpbmUgZnJvbSBv
dXIgcG92LiBXZSBkaWRuJ3QgdXBzdHJlYW0gdGhpcyB5ZXQuDQoNCkFsc28sIGlmIHlvdSBoYXZl
IGFueSBjb25jZXJucyB3aXRoIHRoaXMgYXBwcm9hY2ggcGxlYXNlIGxldCBtZSBrbm93Lg0KDQpS
ZWdhcmRzLA0KRmVsaXgNCg0KSW50ZWwgRGV1dHNjaGxhbmQgR21iSApSZWdpc3RlcmVkIEFkZHJl
c3M6IEFtIENhbXBlb24gMTAsIDg1NTc5IE5ldWJpYmVyZywgR2VybWFueQpUZWw6ICs0OSA4OSA5
OSA4ODUzLTAsIHd3dy5pbnRlbC5kZSA8aHR0cDovL3d3dy5pbnRlbC5kZT4KTWFuYWdpbmcgRGly
ZWN0b3JzOiBDaHJpc3RpbiBFaXNlbnNjaG1pZCwgU2hhcm9uIEhlY2ssIFRpZmZhbnkgRG9vbiBT
aWx2YSAgCkNoYWlycGVyc29uIG9mIHRoZSBTdXBlcnZpc29yeSBCb2FyZDogTmljb2xlIExhdQpS
ZWdpc3RlcmVkIE9mZmljZTogTXVuaWNoCkNvbW1lcmNpYWwgUmVnaXN0ZXI6IEFtdHNnZXJpY2h0
IE11ZW5jaGVuIEhSQiAxODY5MjgK

