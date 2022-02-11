Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AAD4B1F22
	for <lists+linux-arch@lfdr.de>; Fri, 11 Feb 2022 08:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347625AbiBKHNe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Feb 2022 02:13:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347637AbiBKHNb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Feb 2022 02:13:31 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6DE26DA;
        Thu, 10 Feb 2022 23:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644563610; x=1676099610;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/oB7FEmr5+ASP9zzwErhYu8t9QkruYMPn8R8d183EeI=;
  b=RnURZQxUlOXg4FWSbNKGKEe4D0dpMdYIkPmQlNqgx/WSFoT1Uc/PwZgE
   GM4NWebDDy/mUD2L/zjPZ7t9GOf+miM2qXsCjR8yehp4wBI3HYqquxMw4
   T66WtQDJXZuIZFPTHHky/Aveq/miVaZ3Iuv3+yQjdEG+dTg787cMZs6ne
   g/S2AGx8j5GwAzYgJFbdh0lbWGqXFNmCRgTNC6K1OYX+PVg0w8FPlOoXW
   OJmx2Myw0MhD6pRf6JdHt6pnDug/acK57ng8mXC0Rx7mGv+u7YfxQxtV5
   ha9G6EGhAtCjXLGU5YZ+YglsfoexbmIeJ1YvX2QmlCCXAEyeCDHJ9Y2Uq
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="310414059"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="310414059"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 23:13:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="633988156"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga004.jf.intel.com with ESMTP; 10 Feb 2022 23:13:29 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 10 Feb 2022 23:13:29 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 10 Feb 2022 23:13:29 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 10 Feb 2022 23:13:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RG3a8WheimDhuPRkrHKkkSWX5WGlOtYfuqmvR44Kpj7MyVPPHKdLpJeE5g5dphCkv1LAzC3Un1MMFvnESW/icNohhjjjJbYOfxC6zoKL2dgPOGXeosiFjxsaXcI16vfH1cmcrLNYelBwMhFdk0o1q8c7mdFtJ/z0YBwf735lbz8qJwmNkydVxz7iZmOuC/dw1v+CedkvKaVUNFYYR3i/o/K7laqhOqDNsnwntdyH/HX/d9WZfzvXCSQ81K6Hh9TocxPo1hqLDbhFWu8TZ3BforWz5op+oXfYqX/NdYiHmeZ1xxxJNfb71pPe/bwXlQRGG/BUFWsCyl3j6NO83yy0lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oB7FEmr5+ASP9zzwErhYu8t9QkruYMPn8R8d183EeI=;
 b=FKiTu/j437zofEVSDbOQZP7WTtAPIaFOm8KIHH3iqedNmZtrbZ8Nftvtb4K/iXK2XwHbLsdbwNfxeR8jKU1/xrqGK0ovgfzYmXFKwsgAhujh5g0vNsHoXpVSKcP2vd/3AYiM+UsJ0wJrkkJv+ny/7h7Gnt1hfUQHhZaLESM/IgKvuXWx+w/pJBbk6kylKv5R5d1Q/IkbCtb25mQbZ4PHDG/tsz9oHDhzs3kLbZS/3vhNiCnqwXqjzcJw6aeBzaeNL/pNtR311HVrcGOXaPGNjhpqk5u7LC2JJLnefCPFJSsFrJUAZEgo9IvdNNCs7coLIXeWOZYkAvqIfkEc6f/L5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DM4PR11MB5549.namprd11.prod.outlook.com (2603:10b6:5:388::7) by
 CH2PR11MB4310.namprd11.prod.outlook.com (2603:10b6:610:3d::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.15; Fri, 11 Feb 2022 07:13:26 +0000
Received: from DM4PR11MB5549.namprd11.prod.outlook.com
 ([fe80::897e:762a:f772:1c34]) by DM4PR11MB5549.namprd11.prod.outlook.com
 ([fe80::897e:762a:f772:1c34%7]) with mapi id 15.20.4975.015; Fri, 11 Feb 2022
 07:13:26 +0000
From:   "Wang, Zhi A" <zhi.a.wang@intel.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
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
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
Subject: Re: [PATCH 10/35] drm/i915/gvt: Change _PAGE_DIRTY to
 _PAGE_DIRTY_BITS
Thread-Topic: [PATCH 10/35] drm/i915/gvt: Change _PAGE_DIRTY to
 _PAGE_DIRTY_BITS
Thread-Index: AQHYFh9vdpI2Dp3uMkuusgHzYKuAHKyLgDcAgAIj1ICAAF1ugA==
Date:   Fri, 11 Feb 2022 07:13:26 +0000
Message-ID: <37652390-1645-8801-05de-a83a7dcfba7a@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <20220130211838.8382-11-rick.p.edgecombe@intel.com>
 <a5bb32b8-8bd7-ac98-5c4c-5af604ac8256@intel.com>
 <04cbcff2e28e378ece76ab1735a81b945583ad7b.camel@intel.com>
In-Reply-To: <04cbcff2e28e378ece76ab1735a81b945583ad7b.camel@intel.com>
Accept-Language: en-FI, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ec5b732-bb5e-4cea-67a5-08d9ed2dff88
x-ms-traffictypediagnostic: CH2PR11MB4310:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CH2PR11MB431076449F189A8B53770924CA309@CH2PR11MB4310.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v2+dVKQhh1zf7x/+tiU/9uTBJdoyOn0OmwAwnGxQ6rv03aMeP5d0aesuz1fj5FXIn5HzbZZhfr1ROwG8mUCtza+yBEbD2xPWVrYx605nbx7JTtYJWnaZsGzZ+C7goQMhH3LboQjh0g/Cno22LIT/GWlYpnC2u0iGAXAMC88bdTPI72AaVrlB6Dl2vjIWtytDK6O/FB8fRkmNnAds+AZv88nKcsWypFonHliniT5yipnx+nkurs8EMuyhhq/+2r3Px4rKLbFHWgfv6xkLzTuERecreI2xpn6fIwLLSYbOsoj+/oJ4qjPXUFr97jqh77RCz8ooL09AOmwuT/Cb9WPi8/tCxhHrgLSlpfeRgsGVb5uOgB2ViaV9kFm9LzJpz3O8rq2qamtY4hQXZ7HpRktbQofnXuKhkiFIqYRA9Ctr/PIZ6olG/XuIgMIylW8jE1pYk0ZBdYTFFiyuay4xidA31hh3GjuupoCdGccDBA+7AIHT8SoMOzCz+aWejNx6UQWESusZrXTx4ANwRv8MJxq9D3GGO8TlzqAHRPuXZ9BVnM1Q6uDy5SxRkYpDUIVno/ZN7IoPSFXoghENNaPOZSaYgEZQwuozW6PtT0f5ciyIhfJ3741UX4qowtcsUAlKAWiqn2o55IP8Et8JBCbJ521W56DPtlpnLBhQxcUS/9h0dFBlsi8INCuywusqcGyZZj42ob60l73mYrnAfXqq5Ac588wmxPbKcisI2973iR23UDR/wzmQa0s/9IvDxHbOyx+N2euplJJrGkgc5uh26Tqf7DEErSA7EGLHeJeEk93A3k3jswLpV5g50td1iJ4/SyHgZDBaGZbXOgX8RiTLtG3/uGf4D0oZkkbwshE4OIo+7dTzrdZFy23bPOfls+PS8+3aLj+p9GA+EQw4uNlnqsQ8Tl0o42iFtk9z6cdo6pc5O3M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5549.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7416002)(7406005)(5660300002)(2616005)(38070700005)(31686004)(6486002)(966005)(6512007)(31696002)(508600001)(8936002)(83380400001)(36756003)(71200400001)(53546011)(186003)(26005)(6506007)(82960400001)(86362001)(2906002)(38100700002)(91956017)(921005)(54906003)(110136005)(316002)(8676002)(76116006)(66946007)(4326008)(66556008)(64756008)(66476007)(66446008)(122000001)(14143004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkVTNzN3R2FieEp3NHhrOUp3RlJ6TWFZSWFpRHQ4Nkd5MmNkL0ZSeG42b2dR?=
 =?utf-8?B?MkRnMmh6L1EwNEU2OURxRmJIK0VOcmVGVlcwbHdOZVo5TVZzVGF6R1JYaFo0?=
 =?utf-8?B?K2xxcGd6MjVnTjJ4VXZZOEhnVVc5QklWUWwrSTh1MFJYaVhJUHpCcEpqdWtv?=
 =?utf-8?B?SUwxa2RqMFcyS0RLRlliRXRTZ2hPU1JIM2VNT0NGMWNKT3pNQkQzY2h3OWNX?=
 =?utf-8?B?Q1h1ZThwNUtYbnlZVkV1V0NNeVcwVndXSUV5endyK1VIVlFJSWV3eXJXR0FJ?=
 =?utf-8?B?dUM3NWhybEowcEk3STR3eExvYVR6SlFPaVN3bi82dWNtSU5jVE93UFh0TDVY?=
 =?utf-8?B?RjBOcDhKWnNmMDV1bm9SR0JxSk9yMmQvb2RwcGVyUDdWZ0h2TGNYYmlsVHlN?=
 =?utf-8?B?M3ByR3NXTWVxeFM0SitOZXlUQ1Y0akswckJWeUUzbTA4UWU3TU9tcXpPR25K?=
 =?utf-8?B?Z21DUjRaY2VJbnc4QnAwVDVSV2RYZVp5aTh4OXNYcVgvVkw2WjBZcVFycDhw?=
 =?utf-8?B?YlRIOHpPRDQzN3dzUU9VZytZV0N4MW0vNFowRFNicEdTMlNKbjZtdkZlOWNt?=
 =?utf-8?B?amkxOTdoUHF2QUg3U2dNNC9ZZEV6MmoxR3dsUzFiYkdMZHFGZEJqc0RlV0d3?=
 =?utf-8?B?QXVJQUFyOHpKaVU4aEF1TVM2dGpUdEo5dkc0cXVDMndXQllvNm9WVVpXSE5G?=
 =?utf-8?B?SC92NGVxS1JuY2hDaW5VOE0yZ0lDTCszRjRCQnlDOUF6NXNiVzFaN0xUNUtm?=
 =?utf-8?B?ZGdUaTRYeHNvMmcxK2pscjZ0VWVZd3RwMWtHdDQrcjUzZ2lObmtBVTRUc1pr?=
 =?utf-8?B?MHovSytNTGErNEFWbElXUXRSalhWN0FPTGVwWXlpWlVMbkgzUEx5RFFaSFlF?=
 =?utf-8?B?aGdTVyttb1h2c2dGRlJHR1p2VmlMTWlWS3VNTDgvYkF1V1BRQlZCTXdmd2Vy?=
 =?utf-8?B?Y20wRjNXaUlpckhzbmhRbldRcE9DYU9DcWlDV0dSUHhVNUVyVVM5eXN0akNk?=
 =?utf-8?B?SmszaUc4UTdhSy9TUnQ4cVNKbGtmOURuRkM2MHdDczh2L1RTN090VEJnVnF2?=
 =?utf-8?B?NjE3M3UvUkRFVEplK0hNb3plK2llZ0lSUlNHL3dKc1dTdlpKckx5dWs5SXV2?=
 =?utf-8?B?TERSL0laR0dRR0QrL0ZyS1NNWEtnc2pxTndhQjBKRHpycHFtb0JWdzBMV0dC?=
 =?utf-8?B?UVhtY0tWY2xIRnBHTU0xVnRtbW1JN0F6bnJlUVNlZVNTdVFlUXlBUHZ1d25M?=
 =?utf-8?B?NDJIbm1GU0wydElPem5Cd09ZcHJtQTd2VCtPaFJ6bDhMcjc3MU9TZVNLY2xa?=
 =?utf-8?B?aHk1K05YaXNZMUQ5UUdlVU8xdUp2UEJkcnJWZTJCc2dSbGdZYUp3QVdPSm9K?=
 =?utf-8?B?aWpsdjRVMG9oY1FZOXdsWlF2eGM0STl3QjBwNkIwckhaL0l2dEV1ZU1RWG5J?=
 =?utf-8?B?aUowVllUWi9LeVkrcm5XYjlJdHc4VDh6U3YyQ3Bza29GRUNnRXc5Qlh5c3RM?=
 =?utf-8?B?TEZuS05IMzV1UUM2Ynh2Vi9qelhGcjRPSmtaVFA2Ykt4ZWp1c1dtZVhZNEZK?=
 =?utf-8?B?V3IxTU0yb3VuZnpOTGRud3dSWnZadTJXanE5VVI0MnZsNHNnQ3krZVVnOTVV?=
 =?utf-8?B?a1BOQXlIUXZjSG5DYUwyb3RnRGZYaU5nbFlJK21rMDRhNDJweU1uTjlqMElW?=
 =?utf-8?B?NGxDdGFqd2dRSktTYVJpMG0vNmszemhVMFJDR1J1MnhjVUlTUVMwSXprR2xh?=
 =?utf-8?B?WXIxMzE5WStmUis0WUhpaXU0dk8vbEZMcnRXR1FJdWNFdlpvYVI5SzhyTEFh?=
 =?utf-8?B?N1VuRGQ0SEI4dlEwemNBd2k4azNLWU41cmcvTkVMMWpOUGxMZllwak5jZ283?=
 =?utf-8?B?SXVubFpldUR1YkpYSWNvMUcwMTFmWlVJT05xYkw3Zk1RR1pwQTdkK3c0aExI?=
 =?utf-8?B?VEMxRDVqM2JJdFdvaGZOd0U3cThaQXd3bWoxRERFeHFzWU81MkVCYXVEMzEz?=
 =?utf-8?B?bGtHaFIyUi90ZVZsaGpvYjhPTitudXFQNGd6MHBKbVVseUJaTDJJVVZaWHpv?=
 =?utf-8?B?QjJXYUFXdEFPbDczRFg1MHBrRHFyUzhrbyt5a21iRzZxTWNCazFaR3EvNDB3?=
 =?utf-8?B?cUZkbnoyYkt1QVBKbUVkY1NjVFROVmJIMEo4bC9pN1NhRmVKeEVTMmdKUisz?=
 =?utf-8?Q?7l6rn9bIWCjnSzW1h4AKGxQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FC6334371123341B0CB162CA51CDF64@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5549.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec5b732-bb5e-4cea-67a5-08d9ed2dff88
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 07:13:26.4983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FuI/e+hAEenykBLEyYR5U9sOYzjpneVY2n+RoQ9vDYD9b/YoUIyCeuOZX502gABoBhdxGpfbRC7M3jhVai+t6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4310
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMi8xMS8yMiAxOjM5IEFNLCBFZGdlY29tYmUsIFJpY2sgUCB3cm90ZToNCj4gQ0MgaW50ZWwt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiANCj4gVGhyZWFkOiANCj4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGttbC9hNWJiMzJiOC04YmQ3LWFjOTgtNWM0Yy01YWY2MDRhYzgyNTZAaW50
ZWwuY29tLw0KPiANCj4gT24gV2VkLCAyMDIyLTAyLTA5IGF0IDA4OjU4IC0wODAwLCBEYXZlIEhh
bnNlbiB3cm90ZToNCj4+IE9uIDEvMzAvMjIgMTM6MTgsIFJpY2sgRWRnZWNvbWJlIHdyb3RlOg0K
Pj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2d2dC9ndHQuYw0KPj4+
IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ3Z0L2d0dC5jDQo+Pj4gaW5kZXggOTlkMTc4MWZhNWYw
Li43NWNlNGU4MjM5MDIgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ3Z0
L2d0dC5jDQo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ3Z0L2d0dC5jDQo+Pj4gQEAg
LTEyMTAsNyArMTIxMCw3IEBAIHN0YXRpYyBpbnQgc3BsaXRfMk1CX2d0dF9lbnRyeShzdHJ1Y3QN
Cj4+PiBpbnRlbF92Z3B1ICp2Z3B1LA0KPj4+ICAJfQ0KPj4+ICANCj4+PiAgCS8qIENsZWFyIGRp
cnR5IGZpZWxkLiAqLw0KPj4+IC0Jc2UtPnZhbDY0ICY9IH5fUEFHRV9ESVJUWTsNCj4+PiArCXNl
LT52YWw2NCAmPSB+X1BBR0VfRElSVFlfQklUUzsNCj4+PiAgDQo+Pj4gIAlvcHMtPmNsZWFyX3Bz
ZShzZSk7DQo+Pj4gIAlvcHMtPmNsZWFyX2lwcyhzZSk7DQo+Pg0KPj4gQXJlIHRoZXNlIHg4NiBD
UFUgcGFnZSB0YWJsZSB2YWx1ZXM/ICBJIHNlZSAtPnZhbDY0IGJlaW5nIHVzZWQgbGlrZQ0KPj4g
dGhpczoNCj4+DQo+PiAgICAgICAgIGUtPnZhbDY0ICY9IH5HRU44X1BBR0VfUFJFU0VOVDsNCj4+
IGFuZA0KPj4gCXNlLnZhbDY0IHw9IEdFTjhfUEFHRV9QUkVTRU5UIHwgR0VOOF9QQUdFX1JXOw0K
Pj4NCj4+IHdoZXJlIHdlIGFsc28gaGF2ZToNCj4+DQo+PiAjZGVmaW5lIEdFTjhfUEFHRV9QUkVT
RU5UICAgICAgICAgICAgICAgQklUX1VMTCgwKQ0KPj4gI2RlZmluZSBHRU44X1BBR0VfUlcgICAg
ICAgICAgICAgICAgICAgIEJJVF9VTEwoMSkNCj4+DQo+PiBXaGljaCB0ZWxscyBtZSB0aGF0IHRo
ZXNlIGFyZSBwcm9iYWJseSAqY2xvc2UqIHRvIHRoZSBDUFUncyBwYWdlDQo+PiB0YWJsZXMuDQo+
PiAgQnV0LCBJIGhvbmVzdGx5IGRvbid0IGtub3cgd2hpY2ggZm9ybWF0IHRoZXkgYXJlLiAgSSBk
b24ndCBrbm93IGlmDQo+PiBfUEFHRV9DT1cgaXMgc3RpbGwgYSBzb2Z0d2FyZSBiaXQgaW4gdGhh
dCBmb3JtYXQgb3Igbm90Lg0KPj4NCj4+IEVpdGhlciB3YXksIEkgZG9uJ3QgdGhpbmsgd2Ugc2hv
dWxkIGJlIG1lc3Npbmcgd2l0aCBpOTE1IGRldmljZSBwYWdlDQo+PiB0YWJsZXMuDQo+Pg0KPj4g
T3IsIGFyZSB0aGVzZSBzb21laG93IG1hZ2ljYWxseSBzaGFyZWQgd2l0aCB0aGUgQ1BVIGluIHNv
bWUgd2F5IEkNCj4+IGRvbid0DQo+PiBrbm93IGFib3V0Pw0KPj4NCj4+IFsgSWYgdGhlc2UgYXJl
IGRldmljZS1vbmx5IHBhZ2UgdGFibGVzLCBpdCB3b3VsZCBwcm9iYWJseSBiZSBuaWNlIHRvDQo+
PiAgIHN0b3AgdXNpbmcgX1BBR0VfRk9PIGZvciB0aGVtLiAgSXQgd291bGQgYXZvaWQgY29uZnVz
aW9uIGxpa2UgdGhpcy4NCj4+IF0NCj4gDQo+IFRoZSB0d28gUmV2aWV3ZWQtYnkgdGFncyBhcmUg
Z2l2aW5nIG1lIHBhdXNlLCBidXQgYXMgZmFyIGFzIEkgY2FuIHRlbGwNCj4gdGhpcyBzaG91bGQg
bm90IGJlIHNldHRpbmcgX1BBR0VfRElSVFlfQklUUy4gVGhpcyBjb2RlIHNlZW1zIHRvIGJlDQo+
IHNoYWRvd2luZyBndWVzdCBwYWdlIHRhYmxlcywgYW5kIHRoZSBjaGFuZ2Ugd291bGQgY2xlYXIg
dGhlIENPVw0KPiBzb2Z0d2FyZSBiaXQgaW4gdGhlIGd1ZXN0IHBhZ2UgdGFibGVzLiBTbywgeWVz
LCBJIHRoaW5rIHRoaXMgc2hvdWxkIGJlDQo+IGRyb3BwZWQuDQo+IA0KDQpIaToNCg0KQWNjb3Jk
aW5nIHRvIHRoZSBQUk0gaHR0cHM6Ly8wMS5vcmcvc2l0ZXMvZGVmYXVsdC9maWxlcy9kb2N1bWVu
dGF0aW9uL2ludGVsLWdmeC1wcm0tb3NyYy1sa2Ytdm9sMDYtbWVtb3J5X3ZpZXdzLnBkZiBwLjI4
LA0KdGhlIEdQVSBwYWdlIHRhYmxlIGlzIElBLWxpa2UgYW5kIHRoZXJlIHdpbGwgYmUgc2NlbmFy
aW9zIHdoZW4gSUEgYW5kDQpncHUgc2hhcmluZyBhIHBhZ2UgdGFibGUuIFRoYXQncyB3aHkgdGhl
eSBhcmUgc2hhcmluZyBwYXJ0IG9mIHRoZQ0KZGVmaW5pdGlvbnMuIEJ1dCB0aGUgZGlydHkgYml0
cyB3aWxsIGJlIGlnbm9yZWQgaW4gdGhlIEhXIHdoaWNoIEdWVC1nDQpzdXBwb3J0cy4gVGhlIGNv
ZGUgc2hvdWxkIGNvcHkgdGhlIGJpdHMgZnJvbSB0aGUgZ3Vlc3QgUERQRSAyTSBlbnRyeQ0KYW5k
IHRoZW4gY2xlYW5zIHNvbWUgdW51c2VkIGJpdHMuIFNvIHRoZSBfUEFHRV9ESVJUWV8gaXMgbWlz
dXNlZCBoZXJlLg0KDQpJIHdvdWxkIHN1Z2dlc3QgeW91IGNhbiByZW1vdmUgdGhhdCBsaW5lIGlu
IHlvdXIgcGF0Y2ggYW5kIEkgd2lsbCBjbGVhbg0KdGhpcyBmdW5jdGlvbiBhZnRlciB5b3VyIHBh
dGNoZXMgZ290IG1lcmdlZC4NCg0KVGhhbmtzLA0KWmhpLg0K
