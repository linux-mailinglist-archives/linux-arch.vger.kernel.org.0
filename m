Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B48772EC62
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 21:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjFMT5o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 15:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjFMT5n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 15:57:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7F8118;
        Tue, 13 Jun 2023 12:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686686261; x=1718222261;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nls7zoOai9scj/gEWWEEqP9zE/r4ugnprRVDMS2XzFE=;
  b=XXvULABTlpcOHvVGAsiVf/WQfSx5zbpHGeT2BQuMCyKHsNN7wwyLv0Ph
   fAa1hlFh5ufzmRrv9YYa+1+yZKUZexwGhBSXeN15csz6Yxmx7UChdZNfV
   oMXP5vKb/y5dq8o945i18UVGFN2pLgTEuvX5+1hk38ocT+bM1zboSurXJ
   IkBROGOD71w/FD1PJsDgqXlfpijxhEZ1N/cLir26hwnUileHwBUy5Ni3v
   5OZ7AqEfHaQ8omw5quRtxp9S9FNguYPpiKZLuh8TpOGft2xy6NfNtQmzM
   8TvY7XkHcpZ2D1rNKotQozNOH7vM2zTPks4/z8Sg6neqa2rDS4pvl5A7H
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="422037508"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="422037508"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 12:57:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="705951413"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="705951413"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 13 Jun 2023 12:57:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 12:57:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 12:57:40 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 12:57:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VP5vxhjBUa4NXft+ArrMuoH/3jtVd2/+80NIpaMvpvVOFVW8oK48l7TErsYpizFyibc/iIR5ou+qj+gXiXl6F6DqFGS2Ch88zwlYteciRPeelLekmFfJfeIzF2SPJBx6j0WTk99tAQa9rh/GggdT1zqrGcIuaX+qtdrKh9zVo1YFHm7vMUDpbmJqrju0heVAh1JNgx2H09r1961DnIwHy4xlPrmrx/YDpBexm6Nn5ozZQA2v5MKxe2RmMr3S623oJiYmzb2gkh0MnLfotZPeLD8s5Uki3ErlObHTNc3QSzGmBXyms5ZMNYRksm+rvMH1SoiYP70XunOnuOEZ/53Pfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nls7zoOai9scj/gEWWEEqP9zE/r4ugnprRVDMS2XzFE=;
 b=TluH6gCvxki2Dt6UX4Nfg701IShGeNIzquqjzabliR4H43C0WsEaPOhM1oFZAXI7W1jCgVtJwKeaXokQwoIb5lj98LSE+cea+ADrSTTb6yrUmrXSy5ZEiLvdihsCYEKugSqe1+LvnqDu4h1VewkleomREy2Q+hfay5uCIgEnnLOUjwLlQE56X3BTELykIg6GMmjMGyqxM3xjqCCKpRWhi7keMUO6BdxXeAEaXDKpq/FMAmBK/BsgLUQXapU8gzUf1CZ0F3KKmujthOh8jMkQQCA3qZVsQ/M0gxh7KE7o9qB19bx7UD3WAayCXKhTLRzmE/ZFCzvykJ8mjScaGC37Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CY8PR11MB7136.namprd11.prod.outlook.com (2603:10b6:930:60::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 19:57:37 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 19:57:37 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Thread-Topic: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Thread-Index: AQHZnYvD++9jHqJtDEOZ5j0eN4/f+6+IoOQAgAALyMOAACwFgIAAIG6AgAAMtoCAACGsAA==
Date:   Tue, 13 Jun 2023 19:57:37 +0000
Message-ID: <a0f1da840ad21fae99479288f5d74c7ab9095bb6.camel@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
         <20230613001108.3040476-24-rick.p.edgecombe@intel.com>
         <0b7cae2a-ae5b-40d8-9ae7-10aea5a57fd6@sirena.org.uk>
         <87y1knh729.fsf@oldenburg.str.redhat.com>
         <1f04fa59-6ca9-4f18-b138-6c33e164b6c2@sirena.org.uk>
         <49eabafa97032dec8ace7361bccae72c6ecf3860.camel@intel.com>
         <fc2ebfcf-8d91-4f07-a119-2aaec3aa099f@sirena.org.uk>
In-Reply-To: <fc2ebfcf-8d91-4f07-a119-2aaec3aa099f@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CY8PR11MB7136:EE_
x-ms-office365-filtering-correlation-id: 27a2c641-e78b-4dda-3e5e-08db6c486fbe
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sT27f7kEdLYY6iNYupKMPot9HwGJzR/aUtVcn0wR6Dp28KH3MXFsvJ0jCkMyZ22aNR89KWSc90jIeUB3O/WD0GJzjdoRG5hUhplFXld6bE9OkuoLO7WbWVYTffuJwZGNBUWEn114tVXjQ8aevtWoKX8Bh1s46mSCV6kGrDCfxfbxPpr9qOvtlbhyyjSoVmg8tNSNFsfElI86R2NGMqgc2TGhqUIs5T1flAee8BoibKH8RgH8x0VjDv80B1xy6683Dz9v/rA9/wSmelLNVHbUtMWUu6f7jew7JkqcgtgQcxz87dxhtnNE6uGUBViK89Poy/m5N25TqSUpHM/sZphlyfe58qb0s4I57CUxYf9yx10YLW/5y9QlB5QMpDiRO4xIODRuvNYRJBp0upoP0rz8CYOkzv98AGOhg4w23VyudDco9sYEQ7CVnZmA5QmiPp3xSc6EkNd3GKedRDjMxQz86Tvg5QDq/jAVsnt3/xQAfvDWkUtfEPNSqTFyYOlpIKZyhI4AKiTcurvFis5dWrT+UEY8agHDXphnZFTX4ewH1MkpegF8T3K7Zp648h+1YXZF9EcV0sLU4XESuZXyqUQe5apKaj1qYNPhazg7bgfFDPs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199021)(2616005)(82960400001)(86362001)(122000001)(38070700005)(36756003)(38100700002)(478600001)(54906003)(4326008)(966005)(71200400001)(6486002)(8936002)(8676002)(2906002)(5660300002)(7406005)(66446008)(64756008)(66476007)(66556008)(66946007)(91956017)(76116006)(7416002)(41300700001)(316002)(6916009)(186003)(6506007)(26005)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QU5WTEwxc29ZWU9TN2JSQXprWXU1ZWpRa0VKejRNYVkxb2hVM3UyL0FxT1Jv?=
 =?utf-8?B?eFhxTnVoWi9rWG1GNHhWekFDeUEycDFnc1JDczU0eG1neVRlczg0cTFrdWxa?=
 =?utf-8?B?VUdld1JVejhUZTFoSjhZaFpCMFQ5UEdCWEJIRFRDdFVhN0lSb3hEczRhRjN2?=
 =?utf-8?B?OWRDN3pDZ3pGdEtnQUFldDdtSUZ4NmZ2a3p0UFJra1MxSUtHNVc1WU1QN29B?=
 =?utf-8?B?aWMvcFR0ODVRVGlwMmJlRmdrZ2FGdys2NlQ3UUNxSjZVeFluWmFFS2JzbHBR?=
 =?utf-8?B?WnkwdE9ZN0FSdHRBTm1ldjlrZzk3VWNOajdSNWs1YzBwSURhVEFqMXlhVVdF?=
 =?utf-8?B?ekZoaG40N0tqY0JWcTE4a2YvS3NCeUpNbnBHaEhCeGlHSUxBSDdFQXBXbnA0?=
 =?utf-8?B?T05CZEJaeTArS20zZUFFYjBRUm9zRHlRVFlMWW9kemo2cEkxV2MvcFNrNTJ3?=
 =?utf-8?B?Z0VpSXBYTW1nK3JJNm9QWmp1UmxOazNJeWNuTXNOVmlocE5WSXZTVTZvckRy?=
 =?utf-8?B?dFdBcHFtdlVkTE1EY2tYVnBiWDJoUE04ekloSm9ZalFvZFVObzAwZDI4N3VV?=
 =?utf-8?B?d2NrUGxzQWY5TlAwVHNPSmVDWmtyR1RvTFVpMk80bVI4cm1uQnFmb1FxUlRo?=
 =?utf-8?B?MFZiUnVYdzUyZEJ6MnZ6UTJYUmswRDZscHdwaDBaZE9MeXBOVnlwKzBqbk9L?=
 =?utf-8?B?QVJNODRkT3dqTzhiMVp2MCtVUy9DYjV1L0x1WWVmaG42YUhHRDNxcHVDaWt0?=
 =?utf-8?B?YlBhSmcvUHJ2ZVdWZVJ3SXE0dHhnVDBFRWpCajFpa0hhUWRpUzV2NlZPRDIr?=
 =?utf-8?B?dlFIME9zai9nd2ZrVGlKUGp1amsyejlyYm5DZjc5Ny9Db250NFhYaFg0cTNK?=
 =?utf-8?B?NXJIRktTbk1lQnovejYxeXhhYnZ3UkQrL2dJSGtWV3dTa284QU9FMHhzUzNI?=
 =?utf-8?B?emc3TzhVYkpaS1hhdE1kdFQvUEQrTGxhQ1R0aVh6NjZ5Si8zVHNpMWJxSFhY?=
 =?utf-8?B?VlcwS280NEFyZEdtVTg0TmRYSDZmTTdKSW45Q2R4SkxtMlNqb1hQYmo3QW5i?=
 =?utf-8?B?dVRxVGVDOWRZd01UM1hiM1V1WHJ1UEg4VWluc1VXMmNCVG5LUUFpdGd1M3lh?=
 =?utf-8?B?THNqNjZIdjBFZXBKVGdVNDVOaGhYcTExMWs2eUFKcmRaVW1BRkdPR0E4cTk0?=
 =?utf-8?B?VUxreWpzNEM1R2kvNHBid2hpYm5nV0w1dnJobVc5T2pXaVVpWkxHdVRINjNk?=
 =?utf-8?B?dk5sbnVVNXovd2huWE1HbXU3YXRQUWtjdGxZY3JXTHloTEdXQ2YxVExaSUEy?=
 =?utf-8?B?dnMvc0plL3ZhWnRPNjBvM0dlbGxTUlJ1dGdrWUR4VGllYXJGQVFvbU8wZUF6?=
 =?utf-8?B?M3hMV29TY0swemVrWkFvQTc1K1NzeEJlZXVkN1dPTkFXV0QxZXg3Tk42MFl1?=
 =?utf-8?B?Rkx0YTU3bEd4MWFMM2JJWkRZWDl2aWpSbUg4SzVPdER3OGFCMGFvY1pPNWtm?=
 =?utf-8?B?VkZIc3FqK20weG91Uld2eEZNdXFpbnZaQytSQytwbVNVcUxWRTB6ZllMU3Zr?=
 =?utf-8?B?RUk3bXhSbWlmUTdtVkxjNjFYdWUwWXRDUFNUWmRmYnprR1RRcGdncUZVc1BO?=
 =?utf-8?B?UUtObCtPK0Z2dDBhV24xaE14bS9HT3pIQXNkY0w4NGw2NTRqSUVnc0hCVUFq?=
 =?utf-8?B?UTJLcUpzdXFKVmhBMTJvcGlFZUFWZEFBbU1Wc1lKQW9tVCt2b0twdUprNFJo?=
 =?utf-8?B?QW5OTGd0MmZLSDQ2c3N6QTZaUHpRaHlRMmtDazZZWGtvL0xRNnYvMFBPZGN4?=
 =?utf-8?B?SVJkb2szRTh4V2tySWZ2UXdQWGtIQzYrQ1hZY0tXUXZ3MFh6TWpTUS94Wk5S?=
 =?utf-8?B?ckhLNFN2TVJQU2pJVFV1QktwYTdjeVgwYnRJNHB5Nk9XS1dpbzlESWVuUGNH?=
 =?utf-8?B?dnJ0cEJHNkpJTjhSNkFyQWdjdW5hbXFVZ1hWVHRzWWFXM2t4K3JtY3pDOEpq?=
 =?utf-8?B?RktTNTU5TUdQZUswaWNWeHpFWkw2SnI2QUo2R0lZK0ZWWTlhNWNXQWZoZldW?=
 =?utf-8?B?YWUxbW1IaXhXUnRVbU9tWUVMZG1hLzV4Njc1bjBlZnpHTFVDS25yRVM4OHFT?=
 =?utf-8?B?OE5rYU9VQXlwTTFlN1R0RlVHY1hBM0ZzczRTSE1BZ1IzRXJxVnV2NjFXVWNK?=
 =?utf-8?Q?gWvVWNP6tJyMxDu3NofXjJU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F5B88EF20B4C34DA1558A787140AB3C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a2c641-e78b-4dda-3e5e-08db6c486fbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 19:57:37.0843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fgYMZ7Z9BAKO+T2SY1gkn+zaZ0NuZ9uThKs6bRfqc00iSpvq9oO5yUid/4VRdQNZOs/WXFRn24jSI8FFiKE5uJ5ffxTSimBVWtEI0axKD8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7136
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIzLTA2LTEzIGF0IDE4OjU3ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiA+
ID4gPiBGb3IgbXkgcGFydCwgdGhlIHRoaW5nIEkgd291bGQgcmVhbGx5IGxpa2UgdG8gc2VlIHVu
aWZpZWQgYXMNCj4gPiA+ID4gbXVjaCA+ID4gYXMNCj4gPiA+ID4gcG9zc2libGUgaXMgYXQgdGhl
IGFwcCBkZXZlbG9wZXIncyBpbnRlcmZhY2UgKGdsaWJjL2djYykuIFRoZQ0KPiA+ID4gPiBpZGVh
DQo+ID4gPiA+IHdvdWxkIGJlIHRvIG1ha2UgaXQgZWFzeSBmb3IgYXBwIGRldmVsb3BlcnMgdG8g
a25vdyBpZiB0aGVpcg0KPiA+ID4gPiBhcHANCj4gPiA+ID4gc3VwcG9ydHMgc2hhZG93IHN0YWNr
LiBUaGVyZSB3aWxsIHByb2JhYmx5IGJlIHNvbWUgZGlmZmVyZW5jZXMsDQo+ID4gPiA+IGJ1dCA+
ID4gaXQNCj4gPiA+ID4gd291bGQgYmUgZ3JlYXQgaWYgdGhlcmUgd2FzIG1vc3RseSB0aGUgc2Ft
ZSBiZWhhdmlvciBhbmQgYQ0KPiA+ID4gPiBzbWFsbCA+ID4gbGlzdA0KPiA+ID4gPiBvZiBkaWZm
ZXJlbmNlcy4gSSdtIHRoaW5raW5nIGFib3V0IHRoZSBiZWhhdmlvciBvZiBsb25nam1wKCksDQo+
ID4gPiA+IHN3YXBjb250ZXh0KCksIGV0Yy4NCj4gPiANCj4gPiBZZXMsIHZlcnkgbXVjaCBzby7C
oCBzaWdhbHRjb250ZXh0KCkgdG9vLg0KDQpGb3IgYWx0IHNoYWRvdyBzdGFjaydzLCB0aGlzIGlz
IHdoYXQgSSBjYW1lIHVwIHdpdGg6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjIw
OTI5MjIyOTM2LjE0NTg0LTQwLXJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tLw0KDQpVbmZvcnR1
bmF0ZWx5IGl0IGNhbid0IHdvcmsgYXV0b21hdGljYWxseSB3aXRoIHNpZ2FsdHN0YWNrKCkuIFNp
bmNlIGl0DQpoYXMgdG8gYmUgYSBuZXcgdGhpbmcgYW55d2F5LCBpdCdzIGJlZW4gbGVmdCBmb3Ig
dGhlIGZ1dHVyZS4gSSBndWVzcw0KdGhhdCBtaWdodCBoYXZlIGEgYmV0dGVyIGNoYW5jZSBvZiBi
ZWluZyBjcm9zcyBhcmNoLg0KDQoNCkJUVywgbGFzdCB0aW1lIHRoaXMgc2VyaWVzIGFjY2lkZW50
YWxseSBicm9rZSBhbiBhcm0gY29uZmlnIGFuZCBtYWRlIGl0DQphbGwgdGhlIHdheSB0aHJvdWdo
IHRoZSByb2JvdHMgdXAgdG8gTGludXMuIFdvdWxkIHlvdSBtaW5kIGdpdmluZw0KcGF0Y2hlcyAx
LTMgYSBjaGVjaz8NCg0KVGhhbmtzLA0KDQpSaWNrDQo=
