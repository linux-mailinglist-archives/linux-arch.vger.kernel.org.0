Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A0662CDCD
	for <lists+linux-arch@lfdr.de>; Wed, 16 Nov 2022 23:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbiKPWi2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Nov 2022 17:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiKPWi1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Nov 2022 17:38:27 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37FC5592;
        Wed, 16 Nov 2022 14:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668638305; x=1700174305;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PYlpqSiprfKyPnNLmQ+l0tlcc7zdVZyWJsnaJbMan6c=;
  b=SBwapnx8SHdhhV3P2RtcLPvG7oVqEVwp1NGZ01888oU2JZomPNjymEeD
   5s3f/kHu9jU+ZahaFyup4O+GFiMN+V9jzD8i71jU45EczBtpx96FaThtB
   jIFkMSgfvTtuzn2ftcGLE/pItPMf0fv1sBdN1hnXjpNtoggg64+Zst2y5
   3Dqhew9lNZcNLNOGJEOqZpeoel4yP5VyoOHwu9c2ld2UdUUt0QuqZBdnN
   7Ip/Dg38tJu8Pwr/B11lc0Eb6VeIJutemEaQejZ7G+Ah5osbqIxVWtV/J
   9DToNP7c2QPXGNxmNMUbOi9Tnur7gk3YaVtcf/hG7OmLKuI3ujM/HBtlJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="313836975"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="313836975"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 14:38:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="814260148"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="814260148"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 16 Nov 2022 14:38:24 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 14:38:24 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 14:38:24 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 14:38:24 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 14:38:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMwk8Q19hRuR97RJd1dU5zCF4pkfRAUH7mihJODxk6IGQQ3OuwmhXrxeRfQNNY+Pv8Rfildlywv/tyzepauQk6Ou3sDTwUJiBL6jW6xbA0gnwyWtuAtaLh0GI4jSOHySIyRVFXjpLcQKxSL10BvCtkY5ViD/CTq2FPhXufxZ/dYi1FoPvtic9Fz8EhJS2CXJPlwU2bbXzGAkEnov4Co6LdmhzTzKFGcfmysFL7aiRisyz7xZX6RoGLm5dt2mvfLB/K/eXOtO5ENGbbFvzHJOfhDscBJCdEAYeE5eDZCSQ0KOTMf8b+qwHPigNnQELQx4sCl2F6tUjjzBCBT2xE6BaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYlpqSiprfKyPnNLmQ+l0tlcc7zdVZyWJsnaJbMan6c=;
 b=CEKx2hEmEqtQJT+J11whY3jYzvyss/mvAGRWvQgmYQSMndTaB5dMM7YbNPcVNEA5MxA/Osk5Avg3ZW9EnE4Lnha3CCazjrz9CQcc0G0oZaGNQnYiu20RwnSgO3jeXttOnHDcwX0ls2obKTS+FQku/yG2//n/irKjHHk5zMaV3D/bKmIggA0tSfxquiCSMo0q1Vja79TI/kzJBO/Xu1Zy3r9uhY/bTjTs8KjileRraB6SIOZB4G3XrjfMrnWt8STZR909D7Ta4lyp7Behb02jN5f3AgoA1yBbPycgSkTNfRg47BsijQ4PMuB1vYGup6E5V0n1YmDopAFHlGLoIUKNsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM6PR11MB4564.namprd11.prod.outlook.com (2603:10b6:5:2a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 22:38:19 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3%5]) with mapi id 15.20.5813.018; Wed, 16 Nov 2022
 22:38:19 +0000
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
Thread-Index: AQHY8J5fUoAN1KmpVkaYCSerQ8NxVK5AGQKAgACdrICAALGtAIAAzqYA
Date:   Wed, 16 Nov 2022 22:38:19 +0000
Message-ID: <cb4c70dd57f43fd46a47e0bf7d3c759b0b313f83.camel@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
         <20221104223604.29615-28-rick.p.edgecombe@intel.com>
         <Y3OfsZI0jFRoUw02@hirez.programming.kicks-ass.net>
         <be65a66baf94cebf0bc8d726a704238787195837.camel@intel.com>
         <Y3S5AKhLaU+YuUpQ@hirez.programming.kicks-ass.net>
In-Reply-To: <Y3S5AKhLaU+YuUpQ@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|DM6PR11MB4564:EE_
x-ms-office365-filtering-correlation-id: e637ae30-f18f-464d-4363-08dac82342d3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 64Hs+Y+Q8azQ5HPpVcdOQpcVK+PAfhzG40Y+luL5v4uBZDQte8Iw2dZ5Wii/bXdtOaJLtYhcTbiNmfHYAP+RIxebcHZB2An3xhLwUN+pdI0WPUcdoFoJPN7+Pqtj/WCXyGTUdQqZ3q/555jov5sI1HgutHcoCvjfelgH9RaGLQsmndOdHiWIuk52OatNlZH8jiVqWJy8O5zadG2RtgueqwZfGeXdRdnfu0sgb37hYMlDpKUZRWc/w3yCNsU7/R4QJry0Myor/5hsBqb1PngKlDhjtu0qmwY9xn73JDtTPS8EeyqXmSaMwD2gKRt1bT0RagjVX90tzO7Au9piQdsujVf6+Vy/GKN2tmwI2V2hyh4MfgYjXSGb+okpTRVqvRpP1sYInaBSTutzytZZHrgDB0zD09nrMuQXqn2ZBs79CfhR7aPSaQr+y2cLlxwF3zM+J9/1fRGnjLllaK3AgMBvk/Fq7RuMmdA2eqAbN0soRvrYGsDpPKs/I/oJ0laqPfJSrbCnM+YD0/jaWVEixH/B7rBISWWCOZQTkCJMqMVTfp73bUzofdwx0eCheOChpSgo1DfIXLeROBDJf2P0srYB4ClVmzx1gqG13fnLmmtL3dgfXgzUxxos98xGZ8NH4alnvJF2OKmrWH7QDHnriOtzz20kvKlY25Itc+93Xsm5kGEzmrAGe0e11gXJpoA11AFbeSFz/WtCuoTF49eeJYiW9XBVk/aF33ddlMiJkqIynzozodYBQt3TKTPXLDtvKiKZXhiwNcFw67vTo3z6TSp0BpCJFgsCPAY9lmz97eGieX9zXJwNp9/VqcpwxmL5Tmem
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199015)(83380400001)(86362001)(76116006)(36756003)(38100700002)(478600001)(122000001)(38070700005)(82960400001)(6486002)(71200400001)(6506007)(66556008)(66476007)(66446008)(64756008)(8676002)(66946007)(4326008)(41300700001)(316002)(6916009)(54906003)(2616005)(91956017)(26005)(6512007)(4001150100001)(186003)(4744005)(7416002)(8936002)(5660300002)(2906002)(7406005)(99106002)(17423001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzZNdUowZFNpN2swK1BMcnc3eEFaOU1TelRiajl5eXBhMlZJdktXVGExbGxY?=
 =?utf-8?B?bzRHVlNjQ2RqeUEzMnFsSW13dyt5a3JLdUYrYkJJdVh5a0lrNXdKb0dGMFNO?=
 =?utf-8?B?SjY1aTl6dDkyUk1INHBtbGZURDJyNDNsOTU4KzcxNEZjblcwSjRhZENDQVA0?=
 =?utf-8?B?bWJEaGt4c004M2t5R29LdG1ETkNCMFlneHlqSUEzL3F3dkhOWDNSanVIbm1m?=
 =?utf-8?B?YnZ2TEhZWmpINldCZTZzVlEycTdOVGx0WG53bEFyc1ZKbSthZ2JkZHhIenJN?=
 =?utf-8?B?OVg4YTU5SXdsS2YrbVM1TklPV0Z0WjZIRWY4UURDYzA4WkJETkp5QmR4alRk?=
 =?utf-8?B?UUo5aFBmd1hpZitVelBpc1IrbmE3bUdWYUFoTTRFU1Q2NEJ5QWViVHJ1YStq?=
 =?utf-8?B?T0NYVi85VXJ3b2VRaEM2d3F5eFZXSlVSVUR4Y0tQQ3NWM2hRUnVnaGVXSmhG?=
 =?utf-8?B?T3pWM1prQk1hYy84Snd5a0g5Y0xmTExRdUFxQTIxZGpzTWFrUURDVVVtNU9u?=
 =?utf-8?B?TWhWMGd1L3ZVb1NpalZIL2NkWEQ0VUFiVm9BTXdzUEE0UE1obDdsd2FOQWMr?=
 =?utf-8?B?NTROMHVoM1RFZjRvNCs5SVNpNDAzd1BCODNyQ215ajRJQktDdVJrbzFjNHBr?=
 =?utf-8?B?VC93V2RtTkthY0RWYURvYTFnNGhLZG9QQUJvWEttR3p3WFRWOElQNTBFS0xp?=
 =?utf-8?B?VEMyYXhwbmZwenRZckRhdythbS9VY2xEcHc5SFVnRWdXMW1kc2JCZmRIUGZG?=
 =?utf-8?B?WCt2RjNTdWVnb0w5eEZTUjFEOWtVVjd0MmNMWjdwV0FRbEF5SE8weTNMc01U?=
 =?utf-8?B?Q0JZcVpMaXJzakF3dGg4bW5DdENoTGIvaWptOUlkbG9OdTJaT3FmSDlydTFG?=
 =?utf-8?B?Ni85U2xXWFU4cFJKaGd0VzU2QXRPQmZ5RWw2cDZob2VLaGVMVlhNOFlacTFp?=
 =?utf-8?B?ZVFScjRLcDVBOTZGcUdhM3I1N1FybU5pdHNKQkFzYVRlcFpyTDFVYjRqekQ4?=
 =?utf-8?B?djNjK3pzcXh2aHBQMHZEcGhlUy9WYU9jazNuMmhadzZUZXdBYzNWOHhJNFlC?=
 =?utf-8?B?c001OER1MlJycHhEV2Zkemp3RTRrcmc3UHY4TFdwZDBJNmxIUzNaK3o5aWwr?=
 =?utf-8?B?WkxQSEQySHgyTHF5Q1Z4R1Q2V2RXNTl1dDFsNEkwaXV2dDl2blRQUTUwS2o1?=
 =?utf-8?B?UmRGVXJNYzVKU3dTcWJtV3NxNDhCODdZRHY5MU9LYnpqWk5yelF6cnNpZTRn?=
 =?utf-8?B?UVFUaUJ0MVhteXlqL2RwVUpXc1hSMlBwY29BUEVCSE83eVc5dFNLQlA3d0pi?=
 =?utf-8?B?ZWlwNEVackxnY0RRVmwvUjJ0WFZSS2cvZ09nbk5naE9hTUtCc1QwSDU0OHg0?=
 =?utf-8?B?UU93cW9lV1ZVMWFYRE5ROEJ1cm4xSkkvMnIram5KY1JrY1luUWVpaHlla0FN?=
 =?utf-8?B?Lzk1TU1nVlU3KzlHa09YZThnRmhFWjBjUytDTVhlZzhjdjkwNm9JQi9XbUZL?=
 =?utf-8?B?b0hHUVgzNTkwWENJNEJoRmR5YjNSM2MwQ0VvUXF2K0FkWVNpN1BnNTRrU3Vq?=
 =?utf-8?B?eTdNaktJSXh5a3loOVc3OE5RaDY3eVdHQkhwS0E1clFXWThxa3U0LzNXbWU2?=
 =?utf-8?B?NUdKbEpsVU1xMmF0UnpuVmxSM3d6bzFkZU8ya0w1bWRHVU56Smt4dCtUNlhr?=
 =?utf-8?B?eWpkQkJDWGl5QWZTVjdBbkpUa0Nsa2h4UUJWMlF5dThFbmRrQTUzaDhaSVI4?=
 =?utf-8?B?Z3RTMTh4Q0EzSlRMZkx2VERhOXFwNGpTSkZla0d6bTJYVnlHYlpLYnRsa28v?=
 =?utf-8?B?T3ptNXUvWXEvQmpkMkNsdWluazE0L0xNdzdQWmt3VTArV3BRVC90Tlo1clhB?=
 =?utf-8?B?WjRydzZtQmdzWDdnL05IMHZBb0lDSmZURVU4c01FS2N4UklOdkpxQTdKZUg5?=
 =?utf-8?B?KzRRQVppRjRMMktqZlpmdFlTU0hvSkhCTmFPRXVJUzJjY0thVTIzNk1ETEt3?=
 =?utf-8?B?SE1ia3hRTkR6c0R5bkIyWUw2ZEh2MGJUaE5oUzhuMnpKSGc5VXBtaHR0MHo0?=
 =?utf-8?B?OTdYTFliS2hPQldrWFRtck56b2FTYlB1TEZuV2ZWQmxJZTNHM0luWGk5a0w3?=
 =?utf-8?B?QzVIc3hVN2J5bmsvWmpMcThPMmdEa1FUbm02cmhDeVBuenRzUzN0aE9Tb0F2?=
 =?utf-8?Q?stE3HN19tgqqSqtjh/eYeDc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E70591BBB7D47B48AA6178A7500F36D5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e637ae30-f18f-464d-4363-08dac82342d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 22:38:19.6586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZFEpYhiDXmjOouu3uu8AekrJYE4A799gLIPd4MYdNa2cTAf69Jf96m4e6MsJY7ftKSHJQRblpBFwosvsykOLciam2DLoqSlGmZ76rmcHuCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4564
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

T24gV2VkLCAyMDIyLTExLTE2IGF0IDExOjE4ICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gPiA+IA0KPiA+ID4gU2hvdWxkIHlvdSB3cml0ZSBhIDY0Yml0IHZhbHVlIGV2ZW4gaWYgdGhl
IHRhc2sgcmVjZWl2aW5nIGENCj4gPiA+IHNpZ25hbCBpcw0KPiA+ID4gMzJiaXQgPw0KPiA+IA0K
PiA+IDMyIGJpdCBzdXBwb3J0IHdhcyBhbHNvIGRyb3BwZWQuDQo+IA0KPiBIb3c/IFRhc2sgY291
bGQgc3RhcnQgbGlmZSBhcyA2NGJpdCwgZnJvYiBMRFQgdG8gc2V0IHVwIDMyYml0IGNvZGUNCj4g
c2VnbWVudCBhbmQganVtcCBpbnRvIGl0IGFuZCBzdGFydCBkb2luZyAzMmJpdCBzeXNjYWxscywg
dGhlbiB3aGF0Pw0KPiANCj4gQUZBSUNUIHRob3NlIDMyYml0IHN5c2NhbGxzIHdpbGwgZW5kIHVw
IGRvaW5nIFNBX0lBMzJfQUJJIHNpZ2ZyYW1lcy4NCg0KSG1tLCBnb29kIHBvaW50LiBUaGlzIHNl
cmllcyB1c2VkIHRvIHN1cHBvcnQgbm9ybWFsIDMyIGJpdCBhcHBzIHZpYQ0KaWEzMiBlbXVsYXRp
b24gd2hpY2ggd291bGQgaGF2ZSBoYW5kbGVkIHRoaXMuIEJ1dCBJIHJlbW92ZWQgaXQgKGJsb2Nr
ZWQNCmluIHRoZSBlbmFibGluZyBsb2dpYykgYmVjYXVzZSBpdCBkaWRuJ3Qgc2VlbSBsaWtlIGl0
IHdvdWxkIGdldCBlbm91Z2gNCnVzZSB0byBqdXN0aWZ5IHRoZSBleHRyYSBjb2RlLiBUaGF0IGRv
ZXNuJ3QgYmxvY2sgdGhpcyBzY2VuYXJpbyBoZXJlDQp0aG91Z2guDQoNClBhcmRvbiB0aGUgcG9z
c2libHkgbmFpdmUgcXVlc3Rpb24sIGJ1dCBpcyB0aGlzIDMyLzY0IGJpdCBtaXhpbmcNCnNvbWV0
aGluZyBhbnkgbm9ybWFsLCBzaHN0ay1kZXNpcmluZywgYXBwbGljYXRpb25zIHdvdWxkIGFjdHVh
bGx5IGRvPyBPDQpyIG1vcmUgdGhhdCB0aGV5IGNvdWxkIGRvPw0KDQpUaGFua3MsDQoNClJpY2sN
Cg==
