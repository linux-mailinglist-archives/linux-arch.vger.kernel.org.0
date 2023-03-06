Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9F76ACC1E
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 19:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjCFSNS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 13:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjCFSMz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 13:12:55 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E1270401;
        Mon,  6 Mar 2023 10:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678126340; x=1709662340;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vk4tIthrL4NbQ3Y4p6CCLTGzAm/STVXwfL3dS/1wZGE=;
  b=JNhCmk0UE66FNekrWyGYnNGEynPBJMbGP8IXQ3wqc1RqU2HNIkBA6F/z
   4Upx1k6Y3HNmbOaU42wQ6UK2EqblZI3WjfUn9MW/CVfzXl2VQL4UxmsEq
   OBqeTLHeCumPwDeWKc+lZ8LYoPWQWBuf2/YemU3IVCJZ/zpMxgMB8MEkx
   02JZx0/uM9I99oGzcN7kAW0R16KJhXmJj0J95v/sCZ2ZVw99RX09XIzEk
   uMxm6NgUC/KwgOiA0Ty8jOAFqHfGh7BhXSgyVdaWW5ycpABJCmbUBhSnI
   g6N5Ebi3YVsRt+u5uq4MfJ5XxMdZVa/T6AgAAkQJXZ2c0pubMI4tTarMD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="334350167"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="334350167"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:11:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="745164463"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="745164463"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 06 Mar 2023 10:11:35 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 10:11:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 10:11:35 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 6 Mar 2023 10:11:35 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 6 Mar 2023 10:11:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+1nRZJlYoNPmwm0J46ULTiXwlfVyFikCHjgpvE6LsmiOlUvs1h0QQ1wcxFjQ3whkHbAc6Ye5RGLiXt1c7zoQGYiaK5B7KOSKp5bXtcRvhXzm7YdqChJBrcC+9meWxqCH2DGTtY1fZSDXVgfZ8vv6cTZJArO4Ts/VA7J5VTP1ROya4JjEvCMws8IVB0ZB0yIJAQYaCL3NhqmFiDGdWxtg4UOpYaPbCQ4kTgiV8Ulym+V4t3DtFb9Sg4nu9CnDugdfo8TJyuBpghYJByDtgTlEdx1jj4qk/Rs7jWe/fXn9RoLFjtHBji9C5KMNXOFkVLNq4cH57SEAk+K+BycqQMbkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk4tIthrL4NbQ3Y4p6CCLTGzAm/STVXwfL3dS/1wZGE=;
 b=bJxqwXZQAmxFtVbvA6b4mEhmQmIQeIMISa2ayPDZRne9kICaTN8xLv79g0unFhjvLvoKUnSgv9aQNqrHM1oi5BOpIgUvBOzNzgstCYJR34wrc58rPZQ73bMmoqyuZq6eqIl76GyFxhJR1RWb+wG7LVcozfSye64jdViEAoORwG7hVq0TFjbSChBOGzPWGckQdYZ4NbjuFBnofWIzNfzSyDqx1+SUYt3KtIL4KOX7Bs57rJ5ziYyuU1sn3yTqZylPpjQte2b6w4RHR/T1S/7gPacObazDfdOrPdYBadlO1TyFzsaDu5t8v7AP/HZS05sJNzY2Au2Z5zE1zIblvjZJ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CO1PR11MB5124.namprd11.prod.outlook.com (2603:10b6:303:92::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 18:11:32 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 18:11:32 +0000
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
Subject: Re: [PATCH v7 22/41] mm/mmap: Add shadow stack pages to memory
 accounting
Thread-Topic: [PATCH v7 22/41] mm/mmap: Add shadow stack pages to memory
 accounting
Thread-Index: AQHZSvtDnv17MMU3fEOPp7Q4ORkHzq7twXEAgABWvYA=
Date:   Mon, 6 Mar 2023 18:11:32 +0000
Message-ID: <acdfaf37e2afc0616c394fb979f117d0102519d1.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-23-rick.p.edgecombe@intel.com>
         <ZAXkDgmGFYpPoXTg@zn.tnic>
In-Reply-To: <ZAXkDgmGFYpPoXTg@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|CO1PR11MB5124:EE_
x-ms-office365-filtering-correlation-id: 8246e92c-a2c7-4326-64d9-08db1e6e370c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VfPYpjEPJAtMJZY7OgWJqxb6mGsTLAGfJQAzeELKpqbDW1juHRqnDSeQ+ORVrmeND25Z8gAtc4CdEFityxyoneVVr9sSGw3zurhZ70wAlh4NJ18pCSSz28vK2WqFvQJLq7QYqBufLn+HaTpppv/uvJgHEF7CN5NW3QOZJl7relVAXiK93h6XnzN/PyXX7PHeXpsFAIUw6B476DXB6GceevACX9dtYc3mdM+GDLyWlQBBe5R58PFI1CwCgV69uZ+q4b0umsp2pfZFrjTjiGuik2CfHFgVZYnlLnIlaGehyxlVLvi8e1PEAnLlHoiJOJix7RxD8Uw0IMJFNz1Y9JejaB22EN2AVNtqqH6R8rheJAnSOtb9YzOOoqgL0qorehd4Qysw+gZefoaETqUjf++t+M7x4h65ETe5RCzvo9BrIaFz34yAOuyzqMzKCfS8nFyg86XHrbQtuGq7YF878Lx+q9xVWInZ6X651/UcNthlYlsZOQoRsv2oIImtdw0mTqNUlDVZyEJwmN5G0Sax0yj6LF5wslK9v3q7WFPBotEi3lpnnfzvN2ENnAU5VUmzkkbxXwxOZ/btFhblMvJAPP+ynSjIpXH6bhcIEM1kMqhHODBBwH/ajjU7er5cMEa5VduZw/7GyqSSQePnSxBJvMybSRyAs65u8wsnTMwuRrksDk03B0AxdQU8r/VHczBrOK5PR/vrDbyCfd07yOYVe3iDjy1ZeC+dh4CXXczYdI0qdsk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199018)(82960400001)(83380400001)(36756003)(54906003)(478600001)(38070700005)(316002)(38100700002)(122000001)(2616005)(5660300002)(6486002)(6512007)(6506007)(186003)(26005)(41300700001)(15650500001)(7406005)(7416002)(66476007)(71200400001)(4744005)(6916009)(66446008)(66946007)(76116006)(8936002)(64756008)(66556008)(2906002)(86362001)(91956017)(4326008)(8676002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmhYZXgrNkQ0WXM2eWVaR2YyTWdqMy9JWDNRQmUvaFpMT1U4aTZIcXpFbk9B?=
 =?utf-8?B?UERmb05LYU95U0RKYXRUUHpHc2tYa3p5dGxYVWVYdUlKQm9MUWVxQlBNYUxu?=
 =?utf-8?B?R0hvQldWM3JBeVFxais5UGpZWFBMVmphUmFqR0NldW1STkdPUnd2Sm1PZE41?=
 =?utf-8?B?QUdINlIvMzQ1aDhuWmxQeFZoZkZldGN2bDN5UVhJZDY1ZmwxSUZmZ000Slkr?=
 =?utf-8?B?Z3dscUJhdDFXa3NPL0pQeWg4U09UUC9NUTNINUQxZWdaMFJOV2NlYUxKRktF?=
 =?utf-8?B?cEhrTklzQ0pYMUZXQTdxbkphTTE0dzFVTS9qYkdIODRmTFhDajUvb3A1a2lE?=
 =?utf-8?B?Z2VNVVJIRWlTUXp1eVd4RXVycWVWbkZCRnY1UXlPOW8wcGg2UUNNZWNNQ1M1?=
 =?utf-8?B?dnlFK2Q1c0tqT0VBUTlGNHM2TWYxc1NGem8zaHowK2NDa2VRSjlUbHlEclZC?=
 =?utf-8?B?c2xYeW5nUmFFeEc2QzI2Y0pDL0lPWTlLbHN1L3BFek9JUE51Wlh5OFQzSEtj?=
 =?utf-8?B?SEpsUXFCd1M3NFN0ZTZla3hUb3d5cDRUb1RqWFpqSnZER09Ia0REeWJTQnhr?=
 =?utf-8?B?S0xwSXQwd3JhY3lZR2pHUlpKSFRKVTZDdnFGOG1aWE9vam91SjJGUStScmg5?=
 =?utf-8?B?WVk3a0NFT1QxOFhLaFRNaklCUEZXYVB4SDk0N21MUGlNQ0tRdkxzaWlQWWlU?=
 =?utf-8?B?WTdNZGJ3VnBCYWEyQVBCTkUwODlSUFFHVVpGS2lKYWszQkdFbi9aa2FpcVZw?=
 =?utf-8?B?eEF1WnhSRmxhNkNrYndxRFd0cEhCNHRGUjNZTU8zL1ZaVFRMVGZRZnFWNVR1?=
 =?utf-8?B?Vmx2VXlIMFMrTWN5Q1dqcTQxRWZIbGR0S0s3YWcvLzJzemVTdU43MmtmZ29x?=
 =?utf-8?B?SXdJelR0dTZOZVJBeEZXRk5FN2ZtMlZmcWpBNmI2MjMxbi9lNlNBSGxUQlZr?=
 =?utf-8?B?NExkSENQZTNBZ1Z3TGlZUUxsWGYrVTFqU2xrV2k4SDZCUk5VTnkzdk9LWGZw?=
 =?utf-8?B?YzdFS0szamczOFNHK1RPeHBxMThtRUIvSHFjbVVmYkhPeTNVTnd5ZDY2UWFH?=
 =?utf-8?B?Sm1ZTjFqekNOaG1US29WRkIyMlhDa2x0QXdKMHdiTHljRFlWNmJNRFUxL3hN?=
 =?utf-8?B?c2V1SVJ4L1hVcE1OZWZkVzFtQnpJSS9FZ0JpOFlEV1NvTFRxTzQ3STg1Rytk?=
 =?utf-8?B?RXZxMXhHT0sxQ3RVTXRxVmdXUHE4S1BwQ0IzekFheFNpSzFPZThXYlhUZUhn?=
 =?utf-8?B?RE9OMjhVejZXVGZkN2FiMy9YK0Y4OEIyZGduMjhMSDJpc2xhY09JUElQUHFY?=
 =?utf-8?B?RUJ3VnlPYXdobFdrdVdxZzRyTjF0OG84aUZoUXo3RnNCcENnT2grcXJBU3JF?=
 =?utf-8?B?SlBMMEg1WWo5MWt4TWhlcUpPbEVzNGxiYkxDVzFxT3BKSnJzL1B2WmhDT21Z?=
 =?utf-8?B?T3A2cExBT01vUVYwSFM0R1ZHZTFEenBVK2NsL1gyVGpRa3Z4MVR0QlNHTElV?=
 =?utf-8?B?ODlqSGFnTzRZV09idzBYTXVlUkJUWm01S0NzWkF6UVNVRTdZNHhkNStzL292?=
 =?utf-8?B?Tjc3c05TN3hHV1R1YzZNVVA5aW1IYnA5eXBPUjRwQWprcVJxNkJqc2gvK3ZO?=
 =?utf-8?B?TlhOVkZTa0dnTS84Sml1cjhnVEJZZnYwT09IdEZqenB1QU42VXdkNXMzUjB1?=
 =?utf-8?B?dDV4blF6Z2Z4dGRVMmpaclF2RXpLR0x1d2VSZUdMNENDV0lPc1I5Y05CeFBy?=
 =?utf-8?B?RU8zMHErdVVqWFVBTHgvMmlqelFObWtlbXNlYmt0TThhd0haaTNBTHdtT1FE?=
 =?utf-8?B?dUlGaTR3TWpyODNVS1dwajU3bGJ0MUR3ak8yQWhtd1BNQjNnM0QyYThVRW1j?=
 =?utf-8?B?Wk5maXNhbjZYckp5b0hpN1BRbGtQMm9PbWU2T3hxRkVOUVhhNjYzWUhySVl3?=
 =?utf-8?B?OWM0dGU2ZXBOcFFnSTMyRURmeFk4a3ZVOUd2b2NPVUh6YkNhVGh6eFlVMUNq?=
 =?utf-8?B?b1daNlBLU25FaGdMSDlIeFFuTXBDYXg3VitwdVdRYXQySXR4MS9ORncxSEMv?=
 =?utf-8?B?dVNoalptSkdsRnRsbEc1Y3Z6UnZ0Y21zZWhOSndyRGttVTJHQW9RY0VuRmNi?=
 =?utf-8?B?TXl0SlZDY2hNeXF0U1d5N1Q5cUZxbW9tUHMydFFTRkM4b1kwaFBjclNXU1Q4?=
 =?utf-8?Q?YvXbgmFo5IEE+2sjlPtRmdA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A4BA71077E7274DAE6BEF6216445429@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8246e92c-a2c7-4326-64d9-08db1e6e370c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 18:11:32.1539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YGasf8s3UaUqAWnvl+w00UVPzjabf7dUoH5j9YNMRserV2i4HR6nGSgstIDskK39x1yDzFZCENLwFHFFTd9E6PxBiIC79xeSj5s8vN4UY8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5124
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIzLTAzLTA2IGF0IDE0OjAxICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIE1vbiwgRmViIDI3LCAyMDIzIGF0IDAyOjI5OjM4UE0gLTA4MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+IEZyb206IFl1LWNoZW5nIFl1IDx5dS1jaGVuZy55dUBpbnRlbC5jb20+
DQo+ID4gDQo+ID4gVGhlIHg4NiBDb250cm9sLWZsb3cgRW5mb3JjZW1lbnQgVGVjaG5vbG9neSAo
Q0VUKSBmZWF0dXJlIGluY2x1ZGVzDQo+ID4gYSBuZXcNCj4gPiB0eXBlIG9mIG1lbW9yeSBjYWxs
ZWQgc2hhZG93IHN0YWNrLiBUaGlzIHNoYWRvdyBzdGFjayBtZW1vcnkgaGFzDQo+ID4gc29tZQ0K
PiA+IHVudXN1YWwgcHJvcGVydGllcywgd2hpY2ggcmVxdWlyZXMgc29tZSBjb3JlIG1tIGNoYW5n
ZXMgdG8gZnVuY3Rpb24NCj4gPiBwcm9wZXJseS4NCj4gPiANCj4gPiBBY2NvdW50IHNoYWRvdyBz
dGFjayBwYWdlcyB0byBzdGFjayBtZW1vcnkuIERvIHRoaXMgYnkgYWRkaW5nIGENCj4gPiBWTV9T
SEFET1dfU1RBQ0sgY2hlY2sgaW4gaXNfc3RhY2tfbWFwcGluZygpLg0KPiANCj4gVGhhdCBsYXN0
IHNlbnRlbmNlIGlzIHN1cGVyZmx1b3VzLg0KDQpCZWZvcmUgdGhpcyB2ZXJzaW9uIGl0IHdhcyBv
cGVuIGNvZGVkLCBidXQgRGF2aWQgSGlsZGVuYnJhbmQgc3VnZ2VzdGVkDQp0aGlzIGlzX3N0YWNr
X21hcHBpbmcoKSBzb2x1dGlvbi4gU2hvdWxkIGl0IGJlIGV4cGxhaW5lZCBtb3JlLCBvciBqdXN0
DQpkcm9wcGVkPw0K
