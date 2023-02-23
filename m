Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFE56A0070
	for <lists+linux-arch@lfdr.de>; Thu, 23 Feb 2023 02:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjBWBL4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Feb 2023 20:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjBWBLz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Feb 2023 20:11:55 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C6FA244;
        Wed, 22 Feb 2023 17:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677114712; x=1708650712;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2BKT3ocdcaxwhRrqh7W22Ztde2sDi5er/cb2ZfHywyU=;
  b=VJqhimnWey5vU+FY8Hb+RLibDyZ7xLx4FPnl4tdd/NLDvsdTEOZnMXii
   9PLjmvhqa6rovBTmqL6xaNHgpHZXs/C9Iu1AL2z/m6ltMzZR4Fml9IzV9
   DTFHPdGdbGJp5rb27HWdl2alAG6chHGAXJnSK8DlJuuh68IFaKzt2nEnb
   ULAja1MDYcCIUFzw76iiQfFuVp7SfkuLqWdTzF3NaJZzzudDU2M3HXS+s
   /oczXTR84Q0b1TKa2yJSO41DpSbjkT3asrcIMqIhJFym4qzTkFyg78XQ8
   Q4+ZhxifW+IgRQPoTVPUl7gCyljduqoYUeW5lCwf3HqnvIUsIvXNhsSBA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="333086314"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="333086314"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 17:11:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="622140998"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="622140998"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 22 Feb 2023 17:11:18 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 22 Feb 2023 17:11:16 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 22 Feb 2023 17:11:15 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 22 Feb 2023 17:11:15 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 22 Feb 2023 17:11:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBrnXW00azUqnT8NB4Z8qZ6sV1mjOrtT2xnH4iGYhyjeZqgvjjCnEjg6m4urTUpn4K9tlQaGb95UWBOp3Tg3E6LbQttBTyb2XlCUpDbiFN7tsg7z9A/euqNXa1pd1cZVGK/6qxSpfZcKpsK1mGMegVRQWNc6GExb/joyrso6px2Q8R61X855XajeJ+IrrHt/RSfAW7WF3O5SagZdB8OGfj4GI6I4wBcY8ZCTXUv/1uFC6rwW/MbsqV3yxeT2cyakn4ms8WiLpRkjUDkXHpkecNKCzB/McthkO28CDPTw3fGeFmvwULTId5BxTvYfiHT4M6d4qUqeHFDekS9N/BFEbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BKT3ocdcaxwhRrqh7W22Ztde2sDi5er/cb2ZfHywyU=;
 b=KPyohCY3nI8AgAGQAE1Bxw4tqDdDycJjU7YKdVJ/8Sbj4MDZc5BG+/lhBS/g30DcB/uwtGoE3Jbmf6PqPoPpBuGRI7oICo8UjJFc8ZPTkk0saHSbIodICKUSc6nhrxJ/Uq3gyIHpWlDOqNWirT3sdkSNl4/cE2Oqi2WS+1EoUV02gspwvqsMakJuhamNfJs2Pqg8Z8tfYbW72P/0w8UzxmNRzLXpDhvuuZPhyLTzOlmhrzsLahUAsWo6J6LBrhiF+h0fnfk/UtnyiitE7PnIxo8xmnEv90wPL3h/EFxsIBXr7FMfYKNI9XkqNQ2JTf1MILOihXtC0ghTLKiLaJ3aCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 01:11:03 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 01:11:02 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "debug@rivosinc.com" <debug@rivosinc.com>
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
Subject: Re: [PATCH v6 33/41] x86/shstk: Introduce map_shadow_stack syscall
Thread-Topic: [PATCH v6 33/41] x86/shstk: Introduce map_shadow_stack syscall
Thread-Index: AQHZQ95FnziH/18UIkugiXvZUjmnPK7brNUAgAAS0YA=
Date:   Thu, 23 Feb 2023 01:11:02 +0000
Message-ID: <49a151d5a704487d541e421699cf798c87a80ca5.camel@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
         <20230218211433.26859-34-rick.p.edgecombe@intel.com>
         <20230223000340.GB945966@debug.ba.rivosinc.com>
In-Reply-To: <20230223000340.GB945966@debug.ba.rivosinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|BN9PR11MB5276:EE_
x-ms-office365-filtering-correlation-id: 106cbae9-a8cd-4ec9-1172-08db153ad4b9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hCjnrvG/HmSShks8nWun/+mqoUntmEyYaMjqvJWJlVRQkkVJbEOeBt/XNvbnf8vEiJOseza6oV4nPXRb58xMTLTvX5sb+QjXkG6qUwJphD9+jRJ5Dn0TgP4PvIP0cA04bYTyMi7tBaCrbCURS0u3rBELgOcWc0x5leDMlSoGBclGbuCRLaZ6hzUlEZwDC9rpOtZHjz7Pks1+1DkgE7Sls45zvR40ina7hOO2OuFfQ0vgGwV3BYt6tjdNjycGFvSo6knrBzA1+ZcW/WDAb0XltVHOgGe4s0FUpdvCtj57Iw50E096Cg7UdngV5aEmWVTUBrqCVc5EFsrygnOWIiJ9n7rOtFX+PRTHNQ9uAVLoFulvyp8JmYyoEPpFk9WvztYmdD+Ng60FzNxOtxWRQiVqofQrUUPtigMor/1BPnAALzRLJQntQLDSb6MLy2h1HAQrv/vZ0MNuuYJbKHg450RKnOFWnHUj4oEJEXhzvv4UlsmXcIcFldlElydE6WTser3v0XMXBHT824wf3/SN5gXXj7EDB0pmYvGHuH2c4UQNQANxbAOStlL9YVW11wJq0UNnfNFxLm3Zk2US0KQ4CkEb1xvkjBxg5yO6EX1MT+78KbzOTa56EYEJjzEdr3qvZn3n4Tn/PDbrCYEUavHoqip9aeDOfglNqORpKkXwHdIcboSd9G7HY0/cNSb8MP2kwAfh+BdMPke0IBs18phkdBXNya/LgH+Gfdda69/u0DmMD6Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199018)(82960400001)(66899018)(38100700002)(122000001)(83380400001)(2616005)(316002)(8936002)(54906003)(64756008)(8676002)(6916009)(5660300002)(66556008)(4326008)(66446008)(7406005)(7416002)(71200400001)(6486002)(76116006)(478600001)(86362001)(38070700005)(36756003)(66946007)(41300700001)(66476007)(6512007)(186003)(2906002)(26005)(6506007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2JhbEpWU1pQK1JjZjlLbjFOcldUeDlMRjUwaXEwek9qL3NHNWliRU8zbVZa?=
 =?utf-8?B?UUYrdDVPWG9pZmN2MVB0TVhHQWdWV1B3eHo0VEJZajEyS2hnclF2ODJtZTBC?=
 =?utf-8?B?bE84U3IybjJDdW4wU1lrdGJnRGMvV21EcjNaVmg1Vmo1ZHpnTjFpWmtNc2Jl?=
 =?utf-8?B?Y2pyd0pncGpRYU9sQjU3OE1RK2RsQnVNRWlxdGZQZzY0RmVoSHVUZ2JETjIr?=
 =?utf-8?B?ZDhvWHlSSlV6dXoyZDFvOWwxMTl0SDV5TE1XYm85ZEtmcTZZVVNQTkVJeU5z?=
 =?utf-8?B?eDczd3V4TkQ5UktzVnAzSVA2Q1hsbm1JWkVYL2lSOGVMN0JYeDIwREIxZkt3?=
 =?utf-8?B?ODEwM2pwYVBUcmRwdzJEQ3V0ZGxtakNra2dRdnJNakZDOFVWRi9jSUVUdGJS?=
 =?utf-8?B?ZU9KTEhFNHhIYXJFc0ZWY0RUZytjTkFGQVBVMDE2WDVkUDJPVFJ2Y0JadTI4?=
 =?utf-8?B?OExRMkV6K3YrcnZaQ1lzdmpIaE96LzR1RnhoU2w5ckUyUGFNd0VYaFRLdDFu?=
 =?utf-8?B?cUM5V3hlL1VMSFA2OEUzeU5OVjZESGJURjRWQkMrNVdhT0N0ZjVycGQwU1RM?=
 =?utf-8?B?TjYrbjNvTmxGb3ViMDloaWhKZ2U4emVtMUtFWmY2T2JXVC9rQUI5dnBUdXly?=
 =?utf-8?B?L042NlJLVFVhRW5IbklhV28ycE9CZ3RXUGRGcXBVYnM2dzV6WUZ2VVB0Q3hO?=
 =?utf-8?B?d0pJMGdveGI3Q3dLVTFtTTdnbzNuTy9haVB4c0dVZE9yc1JjaTlCQXBzUTRk?=
 =?utf-8?B?Z0Z2akxYMVlZNHR6dkJ1MWdqMXB0TWFhMEY4eG5rUy9QOUtZbjlwK0lWbDhW?=
 =?utf-8?B?QkM2cWJ1LzRublFvNHlPQm9mQmtaa2lsUE1naEI0RXpjdi9UTnViN0pwbGFn?=
 =?utf-8?B?YzNNWnlXajl4TFRpQ2ZTVFNNYmQ4ZjhsKzdUUnFBTDJERXp2Z254YW0rS0dT?=
 =?utf-8?B?KzFia3BMQ05sRjJrWVRqdHZpalJVazluWTBTYTQ2MFRzblNKbXJqbEVCSGdm?=
 =?utf-8?B?cXRjbVRIblhiQnVrTzFLNGJXbXduSENMWTNOWmJpOWNJUHBUMVp1Q0RIaGFL?=
 =?utf-8?B?QjhBRDdScGhnaEQzNnBnWm4rb2wwMVoyT1daYlozc0dyV3VqVjBpSlBpcHVP?=
 =?utf-8?B?aTRNUEhiUTVqYUtJeGxNd3Q5d29CM0V5ZFBNK20wMFM3V1c3VlpoMGgzSGhO?=
 =?utf-8?B?S1p4NlhUL09UK3BFNkYyUUtFK1phZGFFbXc3a1FYVEgrOFBvNmVwYmdMYUpJ?=
 =?utf-8?B?T2QvY1VxRldzd3pCdzV4bFFqUHFGRlJ4QUd3NTM1UEl1aytBVDg0K0Ztekk0?=
 =?utf-8?B?RFhTdGEvVS83RkFDd2tUS2QxM3JGZFZDQnV4NWNFMm8vQUdSazNYTTZJN3RW?=
 =?utf-8?B?S3hocWJSckV4clh3NXNiZGhHcmNqckdLUlJOazJmMmV1SXVJcjFidURoNmpM?=
 =?utf-8?B?LzRaZlQxbU9MVmFNYk1IYTUrblhPV1hqUDRtSjUwaTRlRDJsY3NoR2JFYlRX?=
 =?utf-8?B?S2VPMisvdFBLbzA2aVU2ZE5MZDA4OTFrNXlzMzMzV0EwbzFjR1ZqbGpBYUc5?=
 =?utf-8?B?ZjVwNkhTY0k5OElBK1kzOHpmc0lzVWtOVjlEaGhYdFJnTmFuRllKd1RGYWVI?=
 =?utf-8?B?YlI1blA4c2ZUdUZzS3dkMXVmZmx5N0NXMDhtVDl5NDUxU2pvM3lKaStqUS9w?=
 =?utf-8?B?OEFLMjRqZXVnUGJ0UTZXZWo4MHYvWGFkWE1qVHFvM05semRkYmp4amlDR092?=
 =?utf-8?B?SHJlbjJlL3JSSlNNV2h1V1VXWGdoVTRoTm84bGo1cW51eTM3V0hFYTVyM1JL?=
 =?utf-8?B?MXhJTmRLVFI0aFVveTZJUTZRWmpyRnVOUXZXYjNXS2ZSV3RMNU1IN3kxRTdR?=
 =?utf-8?B?R3Y1cW1jSElCb0NKS1lveEllTmYxUStJNmhJbHNCcXh5QnZiQkZNVEYrbHhZ?=
 =?utf-8?B?SnNwWHRiZ1NNaXQ3Rk4zTTFpNFVTVnpZVjdBUzVMdXkrRjZZdWNKWWg3emNz?=
 =?utf-8?B?Tmp5eGdjdTYvMzdMdC9Uc1dOSmF3L2xLTW5wK1NkRFNobDNrRWFzN2xRd2gr?=
 =?utf-8?B?Mjl6YUNvd0dycW9wRnBWQlhZU3ZmZjdob1JidkwxcWVTY1ZrV1hZMmxXdTJY?=
 =?utf-8?B?VXo2Y3ZQcGdyRUh0dUNiajBEb0I2RGM1ZGQ2ckpveElOUHFoWGVzMHMzWEpL?=
 =?utf-8?Q?kkf8vR9/7bS0y+jy/I2fo0k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8EDE72B379C3C4E9976484D4D55D2D3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 106cbae9-a8cd-4ec9-1172-08db153ad4b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 01:11:02.3929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pf3TMhzJ1ysDtC2SA97RCKp07DS8omUpuYHNuUs9o0rQdlpvnjSCD8+ql+xI4oGhH8b2+sU+pPlakUfjF9geRdjmO6jsE6cTRuxgBQLDWSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5276
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gV2VkLCAyMDIzLTAyLTIyIGF0IDE2OjAzIC0wODAwLCBEZWVwYWsgR3VwdGEgd3JvdGU6DQo+
IE9uIFNhdCwgRmViIDE4LCAyMDIzIGF0IDAxOjE0OjI1UE0gLTA4MDAsIFJpY2sgRWRnZWNvbWJl
IHdyb3RlOg0KPiA+IFdoZW4gb3BlcmF0aW5nIHdpdGggc2hhZG93IHN0YWNrcyBlbmFibGVkLCB0
aGUga2VybmVsIHdpbGwNCj4gPiBhdXRvbWF0aWNhbGx5DQo+ID4gYWxsb2NhdGUgc2hhZG93IHN0
YWNrcyBmb3IgbmV3IHRocmVhZHMsIGhvd2V2ZXIgaW4gc29tZSBjYXNlcw0KPiA+IHVzZXJzcGFj
ZQ0KPiA+IHdpbGwgbmVlZCBhZGRpdGlvbmFsIHNoYWRvdyBzdGFja3MuIFRoZSBtYWluIGV4YW1w
bGUgb2YgdGhpcyBpcyB0aGUNCj4gPiB1Y29udGV4dCBmYW1pbHkgb2YgZnVuY3Rpb25zLCB3aGlj
aCByZXF1aXJlIHVzZXJzcGFjZSBhbGxvY2F0aW5nDQo+ID4gYW5kDQo+ID4gcGl2b3RpbmcgdG8g
dXNlcnNwYWNlIG1hbmFnZWQgc3RhY2tzLg0KPiA+IA0KPiA+IFVubGlrZSBtb3N0IG90aGVyIHVz
ZXIgbWVtb3J5IHBlcm1pc3Npb25zLCBzaGFkb3cgc3RhY2tzIG5lZWQgdG8gYmUNCj4gPiBwcm92
aXNpb25lZCB3aXRoIHNwZWNpYWwgZGF0YSBpbiBvcmRlciB0byBiZSB1c2VmdWwuIFRoZXkgbmVl
ZCB0bw0KPiA+IGJlIHNldHVwDQo+ID4gd2l0aCBhIHJlc3RvcmUgdG9rZW4gc28gdGhhdCB1c2Vy
c3BhY2UgY2FuIHBpdm90IHRvIHRoZW0gdmlhIHRoZQ0KPiA+IFJTVE9SU1NQDQo+ID4gaW5zdHJ1
Y3Rpb24uIEJ1dCwgdGhlIHNlY3VyaXR5IGRlc2lnbiBvZiBzaGFkb3cgc3RhY2sncyBpcyB0aGF0
DQo+ID4gdGhleQ0KPiA+IHNob3VsZCBub3QgYmUgd3JpdHRlbiB0byBleGNlcHQgaW4gbGltaXRl
ZCBjaXJjdW1zdGFuY2VzLiBUaGlzDQo+ID4gcHJlc2VudHMgYQ0KPiA+IHByb2JsZW0gZm9yIHVz
ZXJzcGFjZSwgYXMgdG8gaG93IHVzZXJzcGFjZSBjYW4gcHJvdmlzaW9uIHRoaXMNCj4gPiBzcGVj
aWFsDQo+ID4gZGF0YSwgd2l0aG91dCBhbGxvd2luZyBmb3IgdGhlIHNoYWRvdyBzdGFjayB0byBi
ZSBnZW5lcmFsbHkNCj4gPiB3cml0YWJsZS4NCj4gPiANCj4gPiBQcmV2aW91c2x5LCBhIG5ldyBQ
Uk9UX1NIQURPV19TVEFDSyB3YXMgYXR0ZW1wdGVkLCB3aGljaCBjb3VsZCBiZQ0KPiA+IG1wcm90
ZWN0KCllZCBmcm9tIFJXIHBlcm1pc3Npb25zIGFmdGVyIHRoZSBkYXRhIHdhcyBwcm92aXNpb25l
ZC4NCj4gPiBUaGlzIHdhcw0KPiA+IGZvdW5kIHRvIG5vdCBiZSBzZWN1cmUgZW5vdWdoLCBhcyBv
dGhlciB0aHJlYWQncyBjb3VsZCB3cml0ZSB0byB0aGUNCj4gPiBzaGFkb3cgc3RhY2sgZHVyaW5n
IHRoZSB3cml0YWJsZSB3aW5kb3cuDQo+ID4gDQo+ID4gVGhlIGtlcm5lbCBjYW4gdXNlIGEgc3Bl
Y2lhbCBpbnN0cnVjdGlvbiwgV1JVU1MsIHRvIHdyaXRlIGRpcmVjdGx5DQo+ID4gdG8NCj4gPiB1
c2Vyc3BhY2Ugc2hhZG93IHN0YWNrcy4gU28gdGhlIHNvbHV0aW9uIGNhbiBiZSB0aGF0IG1lbW9y
eSBjYW4gYmUNCj4gPiBtYXBwZWQNCj4gPiBhcyBzaGFkb3cgc3RhY2sgcGVybWlzc2lvbnMgZnJv
bSB0aGUgYmVnaW5uaW5nIChuZXZlciBnZW5lcmFsbHkNCj4gPiB3cml0YWJsZQ0KPiA+IGluIHVz
ZXJzcGFjZSksIGFuZCB0aGUga2VybmVsIGl0c2VsZiBjYW4gd3JpdGUgdGhlIHJlc3RvcmUgdG9r
ZW4uDQo+ID4gDQo+ID4gRmlyc3QsIGEgbmV3IG1hZHZpc2UoKSBmbGFnIHdhcyBleHBsb3JlZCwg
d2hpY2ggY291bGQgb3BlcmF0ZSBvbg0KPiA+IHRoZQ0KPiA+IFBST1RfU0hBRE9XX1NUQUNLIG1l
bW9yeS4gVGhpcyBoYWQgYSBjb3VwbGUgZG93bnNpZGVzOg0KPiA+IDEuIEV4dHJhIGNoZWNrcyB3
ZXJlIG5lZWRlZCBpbiBtcHJvdGVjdCgpIHRvIHByZXZlbnQgd3JpdGFibGUNCj4gPiBtZW1vcnkg
ZnJvbQ0KPiA+ICAgIGV2ZXIgYmVjb21pbmcgUFJPVF9TSEFET1dfU1RBQ0suDQo+ID4gMi4gRXh0
cmEgY2hlY2tzL3ZtYSBzdGF0ZSB3ZXJlIG5lZWRlZCBpbiB0aGUgbmV3IG1hZHZpc2UoKSB0bw0K
PiA+IHByZXZlbnQNCj4gPiAgICByZXN0b3JlIHRva2VucyBiZWluZyB3cml0dGVuIGludG8gdGhl
IG1pZGRsZSBvZiBwcmUtdXNlZCBzaGFkb3cNCj4gPiBzdGFja3MuDQo+ID4gICAgSXQgaXMgaWRl
YWwgdG8gcHJldmVudCByZXN0b3JlIHRva2VucyBiZWluZyBhZGRlZCBhdCBhcmJpdHJhcnkNCj4g
PiAgICBsb2NhdGlvbnMsIHNvIHRoZSBjaGVjayB3YXMgdG8gbWFrZSBzdXJlIHRoZSBzaGFkb3cg
c3RhY2sgaGFkDQo+ID4gbmV2ZXIgYmVlbg0KPiA+ICAgIHdyaXR0ZW4gdG8uDQo+ID4gMy4gSXQg
c3Rvb2Qgb3V0IGZyb20gdGhlIHJlc3Qgb2YgdGhlIG1hZHZpc2UgZmxhZ3MsIGFzIG1vcmUgb2YN
Cj4gPiBkaXJlY3QNCj4gPiAgICBhY3Rpb24gdGhhbiBhIGhpbnQgYXQgZnV0dXJlIGRlc2lyZWQg
YmVoYXZpb3IuDQo+ID4gDQo+ID4gU28gcmF0aGVyIHRoYW4gcmVwdXJwb3NlIHR3byBleGlzdGlu
ZyBzeXNjYWxscyAobW1hcCwgbWFkdmlzZSkgdGhhdA0KPiA+IGRvbid0DQo+ID4gcXVpdGUgZml0
LCBqdXN0IGltcGxlbWVudCBhIG5ldyBtYXBfc2hhZG93X3N0YWNrIHN5c2NhbGwgdG8gYWxsb3cN
Cj4gPiB1c2Vyc3BhY2UgdG8gbWFwIGFuZCBzZXR1cCBuZXcgc2hhZG93IHN0YWNrcyBpbiBvbmUg
c3RlcC4gV2hpbGUNCj4gPiB1Y29udGV4dA0KPiA+IGlzIHRoZSBwcmltYXJ5IG1vdGl2YXRvciwg
dXNlcnNwYWNlIG1heSBoYXZlIG90aGVyIHVuZm9yZXNlZW4NCj4gPiByZWFzb25zIHRvDQo+ID4g
c2V0dXAgaXQncyBvd24gc2hhZG93IHN0YWNrcyB1c2luZyB0aGUgV1JTUyBpbnN0cnVjdGlvbi4g
VG93YXJkcw0KPiA+IHRoaXMNCj4gPiBwcm92aWRlIGEgZmxhZyBzbyB0aGF0IHN0YWNrcyBjYW4g
YmUgb3B0aW9uYWxseSBzZXR1cCBzZWN1cmVseSBmb3INCj4gPiB0aGUNCj4gPiBjb21tb24gY2Fz
ZSBvZiB1Y29udGV4dCB3aXRob3V0IGVuYWJsaW5nIFdSU1MuIE9yIHBvdGVudGlhbGx5IGhhdmUN
Cj4gPiB0aGUNCj4gPiBrZXJuZWwgc2V0IHVwIHRoZSBzaGFkb3cgc3RhY2sgaW4gc29tZSBuZXcg
d2F5Lg0KPiANCj4gV2FzIGZvbGxvd2luZyBldmVyIGF0dGVtcHRlZD8NCj4gDQo+IHZvaWQgKnNo
c3RrID0gbW1hcCgwLCBzaXplLCBQUk9UX1NIQURPV1NUQUNLLCAuLi4pOw0KPiAtIGxpbWl0IFBS
T1RfU0hBRE9XU1RBQ0sgcHJvdGVjdGlvbiBmbGFnIHRvIG9ubHkgbW1hcCAoYW5kIHRodXMNCj4g
bXByb3RlY3QgY2FuJ3QNCj4gICAgY29udmVydCBtZW1vcnkgZnJvbSBzaGFkb3cgc3RhY2sgdG8g
bm9uLXNoYWRvdyBzdGFjayB0eXBlIG9yIHZpY2UNCj4gdmVyc2EpDQo+IC0gbGltaXQgUFJPVF9T
SEFET1dTVEFDSyBwcm90ZWN0aW9uIGZsYWcgdG8gYW5vbnltb3VzIG1lbW9yeSBvbmx5Lg0KPiAt
IHRvcCBsZXZlbCBtbWFwIGhhbmRsZXIgdG8gcHV0IGEgdG9rZW4gYXQgdGhlIGJhc2UgdXNpbmcg
V1JVU1MgaWYNCj4gcHJvdCA9PSBQUk9UX1NIQURPV1NUQUNLDQo+IA0KPiBZb3UgZXNzZW50aWFs
bHkgd291bGQgZ2V0IHNoYWRvdyBzdGFjayBtYW51ZmFjdHVyaW5nIHdpdGggZXhpc3RpbmcNCj4g
KHNpbmdsZSkgc3lzY2FsbC4NCj4gQWN0aW5nIGEgYml0IHNlbGZpc2ggaGVyZSwgdGhpcyBhbGxv
d3Mgb3RoZXIgYXJjaGl0ZWN0dXJlcyBhcyB3ZWxsIHRvDQo+IHJlLXVzZSB0aGlzIGFuZCANCj4g
ZG8gdGhlaXIgb3duIGltcGxlbWVudGF0aW9uIG9mIG1hcHBpbmcgYW5kIHBsYWNpbmcgdGhlIHRv
a2VuIGF0IHRoZQ0KPiBiYXNlLg0KDQpZZXMsIEkgbG9va2VkIGF0IGl0LiBZb3UgZW5kIHVwIHdp
dGggYSBwaWxlIG9mIGNoZWNrcyBhbmQgaG9va3MgYWRkZWQNCnRvIG1tYXAoKSBhbmQgdmFyaW91
cyBvdGhlciBwbGFjZXMgYXMgeW91IG91dGxpbmUuIFdlIGFsc28gbm93IGhhdmUgdGhlDQpNQVBf
QUJPVkU0RyBsaW1pdGF0aW9uIGZvciB4ODYgc2hhZG93IHN0YWNrIHRoYXQgd291bGQgbmVlZCBj
aGVja2luZw0KZm9yIHRvby4gSXQncyBub3QgZXhhY3RseSBhIGNsZWFuIGZpdC4gVGhlbiwgY2Fs
bGVycyB3b3VsZCBoYXZlIHRvIHBhc3MNCnNwZWNpYWwgeDg2IGZsYWdzIGluIGFueXdheS4NCg0K
SXQgZG9lc24ndCBzZWVtIGxpa2UgdGhlIGNvbXBsZXhpdHkgb2YgdGhlIGNoZWNrcyBpcyB3b3J0
aCBzYXZpbmcgdGhlDQp0aW55IHN5c2NhbGwuIElzIHRoZXJlIHNvbWUgcmVhc29uIHdoeSByaXNj
diBjYW4ndCB1c2UgdGhlIHNhbWUgc3lzY2FsbA0Kc3R1Yj8gSXQgZG9lc24ndCBuZWVkIHRvIGxp
dmUgZm9yZXZlciBpbiB4ODYgY29kZS4gTm90IHN1cmUgd2hhdCB0aGUNCnNhdmluZ3MgYXJlIGZv
ciByaXNjdiBvZiB0aGUgbW1hcCtjaGVja3MgYXBwcm9hY2ggYXJlIGVpdGhlci4uLg0KDQpJIGRp
ZCB3b25kZXIgaWYgdGhlcmUgY291bGQgYmUgc29tZSBzb3J0IG9mIG1vcmUgZ2VuZXJhbCBzeXNj
YWxsIGZvcg0KbWFwcGluZyBhbmQgcHJvdmlzaW9uaW5nIHNwZWNpYWwgc2VjdXJpdHktdHlwZSBt
ZW1vcnkuIEJ1dCB3ZSBwcm9iYWJseQ0KbmVlZCBhIGZldyBtb3JlIG5vbi1zaGFkb3cgc3RhY2sg
ZXhhbXBsZXMgdG8gZ2V0IGFuIGlkZWEgb2Ygd2hhdCB0aGF0DQp3b3VsZCBsb29rIGxpa2UuDQo=
