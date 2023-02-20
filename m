Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D6569D657
	for <lists+linux-arch@lfdr.de>; Mon, 20 Feb 2023 23:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjBTWcs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Feb 2023 17:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjBTWcr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Feb 2023 17:32:47 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C0E1E1FC;
        Mon, 20 Feb 2023 14:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676932366; x=1708468366;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HwjGaJcgfiEiIv/woYKEJLQD/lQyLMqMfHK0bPTjPYI=;
  b=bxlLmSGiXBZaZ7n9Q6c0C/ql495+5H8cU0b8PCupwonREuBqdpl3tO+I
   KFqgmXzNmmaHRoYjVb706MrpdgB7x1+issicYsZFhQtq7ZL9DGay3LwuN
   gUy5FsDlWuU+QSwzvuhonGIoFW8uRO8dvt2Z3LgKrKVFnvZ6k/hHJDBu9
   4NnGUQXapdfiWcpkzBHLU2CTzR904DJ2f7rbfq1CC//cj/zov+TohlwrH
   A1zK6q2kyoyPRG9FtNtTfR883FmWnjpZ6v1sW1D4FHJ8PggVlUmP/+Ynw
   KPgGwA0LWbZ8pzDMgfpUZD4qvimd8R0zxTCJ9UqgSZIrk2EmNyZH0iKbB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="359970022"
X-IronPort-AV: E=Sophos;i="5.97,313,1669104000"; 
   d="scan'208";a="359970022"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 14:32:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="664757298"
X-IronPort-AV: E=Sophos;i="5.97,313,1669104000"; 
   d="scan'208";a="664757298"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 20 Feb 2023 14:32:44 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 20 Feb 2023 14:32:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 20 Feb 2023 14:32:43 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 20 Feb 2023 14:32:43 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 20 Feb 2023 14:32:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egvzwQhCYMV9f+CggeKlflkr7A7CfzGYSznQCnnlLlTTqqPXvn3P4rcLqO9zfi2M9oC1UeFHRxT9U8baC2U+eg3amxjHyYQYBa3KIbkD0R2dY/Xr9u+JMusKjp7Rg44nN9TdLvfga0rlbxjcKCacGu8MYuBxG6DiRmHjk5wghJ5BqQL5mcceUl3dNi8JtHV9nG0U9xY4EGAnb3w/1CWtSgBzvUKYwjYdMAVnGmY66jAz+1ip6IT+7T+BgHKA+deLTXVQAX0SS3CUIfnvXnIS3X0HWvUTxuvtxxdcQn6NSaLd+GjSyIca4GMr/brD0gTYIv/MqaozwZyt5yMvPE/x3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwjGaJcgfiEiIv/woYKEJLQD/lQyLMqMfHK0bPTjPYI=;
 b=CMBpvFajI261nylmw774UhysbFqGn+4ypJxRIae7+I2Z7XboA1M1+nXKnonXAhWEua9Bdu3NyNt4NulD5zohuIP2dCjRC9aI1rtcxIC0y2pXo13tXFe9WL4S0blab/rA9tTeOtY1KEHSazhEA3LnGNVtjZXxmL0Yw1sZ+b2oP5/RE3Bke+daWfp993U/lG+3qDNNdTvneXhuy3gR+SskL97a8dTlEgzBW/VM6dd5fdSlvDwx14dqU+t8tJ6LTjTpFvEY+9BNJ3l42b4rhThuBczcq5+WLCXp1jHfFKjihOMQQCAzliWG2hHaBP0aIS1w9z1U2JX4dDhic3byA7ZCPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CH0PR11MB8235.namprd11.prod.outlook.com (2603:10b6:610:187::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 22:32:39 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6111.019; Mon, 20 Feb 2023
 22:32:39 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "keescook@chromium.org" <keescook@chromium.org>
CC:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v6 27/41] x86/mm: Warn if create Write=0,Dirty=1 with raw
 prot
Thread-Topic: [PATCH v6 27/41] x86/mm: Warn if create Write=0,Dirty=1 with raw
 prot
Thread-Index: AQHZQ95CKgn/Vb6LqUS4OtOnwKenRa7WvlQAgAGwaAA=
Date:   Mon, 20 Feb 2023 22:32:39 +0000
Message-ID: <50fc4d60914d2df4c03ff02ef1b756cc1b1c3a30.camel@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
         <20230218211433.26859-28-rick.p.edgecombe@intel.com>
         <63f28a4c.620a0220.cf190.b2fa@mx.google.com>
In-Reply-To: <63f28a4c.620a0220.cf190.b2fa@mx.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|CH0PR11MB8235:EE_
x-ms-office365-filtering-correlation-id: 2e5d4410-244f-469a-1200-08db13925f8c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T4GafmTEHmXNmIqp66A+OJ3r2bn2odAWg7mm91CUXzApQqsKoMXFE3o2x9DVQrQ6P4AI/PpMZLvcY/2GwuCigB4ya5IcjPZd6zIRy4st24keQ+ceI54JLyH8zBDX3FeCUkXg1A89kosgXmAwfMozb51FHdVHoN6sKMhmtrvjPBM1co3CIRVtQWoBAwubHNkSLQKtP37GBIZttT445dL8BQQjeiYO8iKjW2KhmM0ONYWEmnRtomlV1F/f+/zCwDkRUDEprme8/sIFF1OWnYRrxn/gYijuD7sd+2b1BJOw/LV7j3QXPZ+bxtcM4RZlw/whQOfDmzhHi3M2ldcpxCFXIoomfWI4VQAk0eSJqFcnHD7RhVN1UkMtfrtYbxqgrp3BS6vgZevAZsY151JxAX1JOKDz+fvuWXKpIFEcbGVdTzoa7Ka6KTXFU6UpJSUwAZsH1ojHFchT35y+f0YV226s8inzrn91IuYR4zHyAoMj0lIfIoSPTNK1cXk0vaaZZBagJtNT1D82sIoizW3p5oqK8mSj8OFTY9x6iNQW7HoCsynWSgteaHqr3Bsxc7pTZ7ZydFy7qUsWHdWj6tHPp5h0l4/iunxOTZjUg8SmaxB1/r97u58o7ItOdZHfh3hS4F6ObGHG92uFDdPNJ1Ps/RcCTMFhUBuMz6RQJIwntJqDD+etFZFfA8AFhT+T4orWePXw13hKbnqUO7XzqyDJRxSyHEZfk8cKrHKYFwqKBK1ovKIyzpjRnXJDF7gH8LqT36HW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199018)(83380400001)(66946007)(76116006)(66556008)(66446008)(8676002)(64756008)(66476007)(71200400001)(54906003)(478600001)(316002)(6512007)(6506007)(186003)(26005)(38070700005)(8936002)(7406005)(7416002)(2616005)(6486002)(36756003)(4326008)(6916009)(41300700001)(5660300002)(38100700002)(86362001)(122000001)(82960400001)(2906002)(99106002)(14143004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wm5GUkl4WnRpVDlpWThLdUw4OUYzSjFUYy9HSFVrWDFGTHdYbWV2TVI0TUl4?=
 =?utf-8?B?R205TS85UjhoLzlTa3JQa01kN2VtdXlDeU8rcFI2WkovMHQrWmg3MWRvVzA1?=
 =?utf-8?B?dDJhYk1oRVY2RGRJV2Z2SWxZdCs0OFY1YjI0M0pydFAwL3d2UE1aWjUvWWJQ?=
 =?utf-8?B?K01MYmJ2c2dBSFk3dE9Nbkdjd1EwMHVuMEVDdm9xeUZQSWhtTTF3ZHdyQmcr?=
 =?utf-8?B?d051cytvRkN6MzM4VEk0eW1FWDNjL2sranRLRWJGdnNJT1RZb1F1QjVqc0NY?=
 =?utf-8?B?NVFaRFJ3VDN6a0h2emtJYlhjYXI0Ykg3WnN3MEE5QW5lMFZsbnAvaXJPMXpO?=
 =?utf-8?B?WEgzVlovOHFmREVDQmlWK3BJN1ZtK0dwUDBTbGgrVUdMVUFKMlpQcnFuNlZa?=
 =?utf-8?B?cjNGVk5tODlBR0Z2d0FXQTNPaWp0YUkxMVRSUXI2ZnNSajhLM09rRGtoeWo1?=
 =?utf-8?B?OThhcHhtUTNrQ0x0eTA2SUFKVENlOWRQdW1oTHY5L0dKYy8vZzg5NXNUM1hx?=
 =?utf-8?B?c1lIODRUNk9yVDIrWFJ2RXFQaERRaEdWTVlDWXl5R3JOckRGdUxoUW1TZmcz?=
 =?utf-8?B?ZnhJeTgyUGpNNGs1cXI3cklpMGl1SUNodlJqMXZjUnhvdjBJSGx5MDQ0KzdI?=
 =?utf-8?B?QnRtSFB6c1NpVm42RzJCWEVsZGRwOEdoTjhvSjBWUGViTXhLSUdFMUxNeEJE?=
 =?utf-8?B?UDYrbEJyUFJjV0FxNmlWUHBsWE9zTVZseTVVUERBV0orTWE4ODJjb2ZEelBm?=
 =?utf-8?B?RG1qWUcyVGRwdFlrUVhvcTVGMHluTHBvUWE2b3lhWjYxMEE1cVNrV2dwNmo2?=
 =?utf-8?B?UzF0YnRNQ3dxLzJLb0I0c2J1UUhHbHJOdWpqVFVGNzNIS1YzUGsxRFh4VUVq?=
 =?utf-8?B?b3JBNWZoWW4zd2JyY0EzSmMrTGpNZU84Wi9GRVFUc2xoZWpjcld3WmswU1NZ?=
 =?utf-8?B?Wk0rWVVqRXlsYTJpeHQ3WkY5SDI0U1pmby8yMXh3enFKTGFNVmpXSnRJZVZt?=
 =?utf-8?B?L2VXRUNtcTJJK2RhRndSVnhrbDhxSXlkN3oxbUhMNXZtSTErY1R0clpybFJG?=
 =?utf-8?B?MFBBOW9NUzZLcWRYVTloNTlqbVN5L3cxWU44L0VvZjVCR045RW1Kd0Raa3pw?=
 =?utf-8?B?Q3grajJjQ1Y5MnB6U0RRU3FrTlJkVW54VUYyYmswR3JYNlIxbXJjYXFjY0dI?=
 =?utf-8?B?U1diWVUvS2ROd3Z6TUN1eEpqUklXWEhmUlkvWHIvd0ErWFJxcWhXRzcvVWVu?=
 =?utf-8?B?UGNLaEd6R0xGSExTcTk3RWRjZ2RwZnhGRjNRZFllbmRkVXZPWVFpc1lqd0xQ?=
 =?utf-8?B?Qk9GZFFzcUpoN0pKWG81QmxPdVJFeTdVMlMveEZPbHhKRzN2QTBpWXhzNG0y?=
 =?utf-8?B?WkM4NGJHM2lEbko3amsrWHhVTmJDWFdZYjNhSGlNSXVRKzZzbGttdEhsRE1Q?=
 =?utf-8?B?QWQ1K2o5enV6dDNldTlqY29xZ2UxRTZvdWlmYi8xTFl4UnpuMDMraWhvdko2?=
 =?utf-8?B?VThVQys0TlNKVEJ3ZkYxcm93aFo2L1YyYTFNWXl5N2hXNzNLaENIa3haWlo0?=
 =?utf-8?B?WkhXZ01BVE5BdTZUOXFUZG9xaWZpSk16OHphanNZN3ZRT2hObVdMZzlTRzBk?=
 =?utf-8?B?dm4yK2o3ZVY0M1RIa2pSRFVHZ2cwZHZmcUlwY0JrYUhFU0VkY3h3TjM3TldM?=
 =?utf-8?B?OWlqZ2swQlBUTGYyOFpxdEw4TUhTcW1IWmNzNCtqT1pEZFhpSkpBVXRSK3or?=
 =?utf-8?B?dUVSc3E4ZVk1U09SdS9vQTczc09MR0ZZNEVrQlBldGFVTGFsWVVEL2UzWlBs?=
 =?utf-8?B?dS9ld21SZW95REFydDNIV1NaRVYwUEFpcjA3ZWs0SXEzS1ZOaHpMdDg1aGNm?=
 =?utf-8?B?QnJBOC9SczZDdzZSRFluRFpIeW41SmVVQlNPdG14Yy93bXpSU1M3YTFsT1U4?=
 =?utf-8?B?RFNZdUo4SStOY0gvR0xrdzl4UjF5WXhMeEthOWdYQXRFQW4vbTZuVVdUSnM4?=
 =?utf-8?B?bEtlQVVhQzJqTVErTXU1a2NiSGZDZFdWTVhObWZuRG1Ob1ZWYlVCVFl0WGJC?=
 =?utf-8?B?czVMYVJ1WmNNUXNqclNydlBBaDVtakJvSUhFTFhqVzcxaXZlTUJ6cnQxYXRC?=
 =?utf-8?B?TzdFSnE5MUpVMGY3YzgxeWdUaUlaa01KZ0ZsU1dnYXFBcnlIeTd1S1NYSnZX?=
 =?utf-8?Q?pihOQwiRMfuWIyZLHnq5Md0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <042E1B0BEEEED74C99C7E5AEC652071D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5d4410-244f-469a-1200-08db13925f8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 22:32:39.2069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L7onIFlIWPQrAGFe9Hzn8jLctPgKaVLY8dTjdTy0XWFHQ8qorYxvJVIgrDH/BoOL8jY+7frga5A0x45ekJYt3F/gzAU8Y09JyKc5Nr+I48Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8235
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

T24gU3VuLCAyMDIzLTAyLTE5IGF0IDEyOjQ1IC0wODAwLCBLZWVzIENvb2sgd3JvdGU6DQo+ID4g
ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BndGFibGUuaA0KPiA+IGIvYXJjaC94
ODYvaW5jbHVkZS9hc20vcGd0YWJsZS5oDQo+ID4gaW5kZXggZjNkYzE2ZmM0Mzg5Li5kYjhmZTU1
MTFjNzQgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vcGd0YWJsZS5oDQo+
ID4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vcGd0YWJsZS5oDQo+ID4gQEAgLTEwMzIsNyAr
MTAzMiwxNSBAQCBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGxvbmcNCj4gPiBwbWRfcGFnZV92YWRk
cihwbWRfdCBwbWQpDQo+ID4gICAgKiAoQ3VycmVudGx5IHN0dWNrIGFzIGEgbWFjcm8gYmVjYXVz
ZSBvZiBpbmRpcmVjdCBmb3J3YXJkDQo+ID4gcmVmZXJlbmNlDQo+ID4gICAgKiB0byBsaW51eC9t
bS5oOnBhZ2VfdG9fbmlkKCkpDQo+ID4gICAgKi8NCj4gPiAtI2RlZmluZSBta19wdGUocGFnZSwg
cGdwcm90KSAgIHBmbl9wdGUocGFnZV90b19wZm4ocGFnZSksDQo+ID4gKHBncHJvdCkpDQo+ID4g
KyNkZWZpbmUgbWtfcHRlKHBhZ2UsDQo+ID4gcGdwcm90KSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFwNCj4gPiArKHsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQo+ID4gICAgIFwNCj4gPiArICAg
ICBwZ3Byb3RfdCBfX3BncHJvdCA9DQo+ID4gcGdwcm90OyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCj4gPiAgICAgXA0KPiA+ICsgICAgIFdB
Uk5fT05fT05DRShjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX1VTRVJfU0hTVEspDQo+
ID4gJiYgICAgICBcDQo+ID4gKyAgICAgICAgICAgICAgICAgKHBncHJvdF92YWwoX19wZ3Byb3Qp
ICYgKF9QQUdFX0RJUlRZIHwgX1BBR0VfUlcpKQ0KPiA+ID09IFwNCj4gPiArICAgICAgICAgICAg
ICAgIA0KPiA+IF9QQUdFX0RJUlRZKTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXA0KPiA+ICsgICAgIHBmbl9wdGUocGFnZV90b19wZm4ocGFnZSksDQo+ID4gX19wZ3By
b3QpOyAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ID4gK30pDQo+IA0KPiBUaGlzIG9u
bHkgd2FybnM/IFNob3VsZCBpdCBhbHNvIGVuZm9yY2UgdGhlIHN0YXRlPw0KDQpIbW0sIHlvdSBt
ZWFuIHNvbWV0aGluZyBsaWtlIGZvcmNpbmcgRGlydHk9MCBpZiBXcml0ZT0wPyANCg0KVGhlIHRo
aW5nIHdlIGFyZSB3b3JyaWVkIGFib3V0IGhlcmUgaXMgc29tZSBuZXcgeDg2IGNvZGUgdGhhdCBj
cmVhdGVzDQpXcml0ZT0wLERpcnR5PTEgUFRFcyBkaXJlY3RseSBiZWNhdXNlIHRoZSBkZXZlbG9w
ZXIgaXMgdW5hd2FyZSBvcg0KZm9yZ290IGFib3V0IHNoYWRvdyBzdGFjay4gVGhlIGlzc3VlIHRo
ZSB3YXJuaW5nIGFjdHVhbGx5IGNhdWdodCB3YXMNCmtlcm5lbCBtZW1vcnkgYmVpbmcgbWFya2Vk
IFdyaXRlPTAsRGlydHk9MSwgd2hpY2ggdG9kYXkgaXMgbW9yZSBhYm91dA0KY29uc2lzdGVuY3kg
dGhhbiBhbnkgZnVuY3Rpb25hbCBpc3N1ZS4gQnV0IGlmIHNvbWUgZnV0dXJlIGh5cG90aGV0aWNh
bA0KY29kZSB3YXMgY3JlYXRpbmcgYSB1c2Vyc3BhY2UgUFRFIGxpa2UgdGhpcywgYW5kIGRlcGVu
ZGluZyBvbiB0aGUNCm1lbW9yeSBiZWluZyByZWFkLW9ubHksIHRoZW4gdGhlIGVuZm9yY2VtZW50
IHdvdWxkIGJlIHVzZWZ1bCBhbmQNCnBvdGVudGlhbGx5IHNhdmUgdGhlIGRheS4NCg0KVGhlIGRv
d25zaWRlIGlzIHRoYXQgaXQgYWRkcyB0cmlja3kgbG9naWMgaW50byBhIGxvdyBsZXZlbCBoZWxw
ZXIgdGhhdA0Kc2hvdWxkbid0IGJlIHJlcXVpcmVkIHVubGVzcyBzdHJhbmdlIGFuZCB3cm9uZyBu
ZXcgY29kZSBpcyBhZGRlZCBpbiB0aGUNCmZ1dHVyZS4gQW5kIHRoZW4gaXQgaXMgc3RpbGwgb25s
eSB1c2VmdWwgaWYgdGhlIHdhcm5pbmcgZG9lc24ndCBjYXRjaA0KdGhlIGlzc3VlIGluIHRlc3Rp
bmcuIEFuZCB0aGVuIHRoZXJlIHdvdWxkIGJlIHNvbWUgc2xpZ2h0IHJpc2sgdGhhdCB0aGUNCkRp
cnR5IGJpdCB3YXMgZXhwZWN0ZWQgdG8gYmUgdGhlcmUgaW4gc29tZSBQVEUgd2l0aG91dCBzaGFk
b3cgc3RhY2sNCmV4cG9zdXJlLCBhbmQgYSBmdW5jdGlvbmFsIGJ1ZyB3b3VsZCBiZSBpbnRyb2R1
Y2VkLg0KDQpJJ20gd2FmZmxpbmcgaGVyZS4gSSBjb3VsZCBiZSBjb252aW5jZWQgZWl0aGVyIHdh
eS4gSG9wZWZ1bGx5IHRoYXQNCmhlbHBzIGNoYXJhY3Rlcml6ZSB0aGUgZGlsZW1tYSBhdCBsZWFz
dC4NCg==
