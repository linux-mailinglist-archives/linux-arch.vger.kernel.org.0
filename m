Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03B35F4785
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 18:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiJDQ0C (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 12:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiJDQZm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 12:25:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B051A5AA06;
        Tue,  4 Oct 2022 09:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664900734; x=1696436734;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+a+KjVbOoemU0UqNuKD0vjbPUFeAYuafduyYrTYo378=;
  b=Qo34e5w6VEQ4zz+e12YU44E+ijyFqEENuIvtjypO6NqVVsA4+/w3qLB7
   Vn7fOUoGckb6y28NOrlv0kb2KrH6Aixxmfc+YXnQ/Rj1+9L6SSYHoYG+r
   EMpsJfXrJx4FnOqsrFsp+CtglNjzJhYrwCylJQZ/fWPTDleg1B/HPNPSQ
   Om6OQ4c/o8t5cTDTwbvTVqI8wfefTXM7dvj2CnpbAgcCTwuiJZANY4ZHC
   OSZZR8yFdQ0L1qxXAj80cM7Q1a+GxiKuZfD0U8OBhAqIXcIc1Iv9mS33c
   iE4x+mAsBoU7A2G+YY5zA19B3f5xJH/I1Nu1107mg40F6/i11PceP1cuw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="286146105"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="286146105"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 09:25:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="601675539"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="601675539"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 04 Oct 2022 09:25:33 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 4 Oct 2022 09:25:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 4 Oct 2022 09:25:32 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 4 Oct 2022 09:25:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agANY48sXdCvGf+zFWwgRyAmxEGNiKe91WpO964ahUq0NR9XOn2yGVqJzbPubgWwETpc/zg68XPQkPrx3nHd2bpbWhzkG9HGX9qBVNzJ+xY0TOQ7Qkte4+u+5Fq1XvcCLtYMdHOxq49JsZLxTB/E020gXFwVIoQJDPEl2NyjTUtRG0AopCWnVFiFRkGpbO3QIGjGe7wefQB0aIOqib/E8zimFNicqZ6AFh8mzHQHGkrvhE0ck0Ue9NVapcArlAFACWvN/JBP8OPhHdfB/a2CTj4QJpnkke2y+xzS3j3Hc2ywj0f/ZnojBpyY3pdRQEFM8X52DXQb1OsYoEkh/xpKQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+a+KjVbOoemU0UqNuKD0vjbPUFeAYuafduyYrTYo378=;
 b=cqOHp+byTVe3a3GEt+c8s3ZDep7WD0lOFZEMIXKgZbSGP3slDjqPIXKQVjMZR1KHxg6sGDRhi7nThxPMonRpHSawuLMcjAqsZevIZJS1/qYW1vWZhJeXIZgR1+1hu9MfcToBDsTJWMc+YC2lx2fXjsWK7AGXlgSWwBA217mlHylV32+wYIuxHWx517AuHbHjKEPecN+4dnk6UioKBLb8P7+a7fQ975sq05jx4fkcZqB9LstIfLye1gleZetwEcD0NTZSxUX0r/wZ3+qaKNC6wdfuboed5YJ5E1HG4N5mxDIDOHezxAwbKHT5G2DKpp1D8hYfL/yA4n32rOcLXiaUPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH8PR11MB6755.namprd11.prod.outlook.com (2603:10b6:510:1ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 4 Oct
 2022 16:25:28 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.028; Tue, 4 Oct 2022
 16:25:28 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "keescook@chromium.org" <keescook@chromium.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
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
Subject: Re: [PATCH v2 24/39] x86/cet/shstk: Add user-mode shadow stack
 support
Thread-Topic: [PATCH v2 24/39] x86/cet/shstk: Add user-mode shadow stack
 support
Thread-Index: AQHY1FMhfYHsd4bOok+fj02ID3Hgq639GE2AgAAFxoCAAIXwAIAAzymA
Date:   Tue, 4 Oct 2022 16:25:27 +0000
Message-ID: <873bdf6d09c1d48c61cc0b3e867ccc69c9a08d80.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-25-rick.p.edgecombe@intel.com>
         <202210031203.EB0DC0B7DD@keescook>
         <474d3aca-0cf0-8962-432b-77ac914cc563@intel.com>
         <202210032101.A33914E4@keescook>
In-Reply-To: <202210032101.A33914E4@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH8PR11MB6755:EE_
x-ms-office365-filtering-correlation-id: a0e41a12-21ad-48c5-5f64-08daa6250c6f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tsCYQ9xlnwlL8h7lmEuR0hlqvhhI9sgnQzTl7ccP84vHvVTesqI2jcEuA6Qyw2No35lNQGHdLLewzvnpPPuBvMa0ZrNQSYfnuVqzL30S5ZBpKve9osjLS0kt9IrUz6rV160AdZxZ6spek2lEkKHMzAThsBhYcGyf/JlexkVYf0EFxSI25oO+okide+AWVTLR3hkueLihi4b4wh8tweV2HFjlT70ub+Y5noIobhAPhNZP7FZQjdYqDZRHifJInMH/5zH6ZRry7ArWwil4lu7GK4nY0ovBPGT3TdG6AnZznuc9YL1nuegxkdqJtKXi5BjM+i2QnD0vOtMxMwlDIR9x06kd9T7DVGFP1sLMmNULPITesGoen5VV6k5KJ0JztYCfQqz11uFRwCLc16m3JpCuyGGQMDn1wq0zTtGEHi0xwp0Zx2sZ+wxmPCRh3ZPt/rV7fKFEPalp1HxDrvdSz8wZoucVtoKDlFbZB9FS3N90XlPAujbg2l7C10t5gKpl1awZl2M+l3HpYPHlDLod369ShI3Z8EMp02XAxLmp+SelgW7WbbbpMxs6EFYrZiAcDhMfJmbiYK7sQTsTI2LpxVKN61fSbUsZnyzlwmh4im43fpcNau7veKNxg5PPXLnPCBifVD8GCcb5JE3roDgNYLoFBbWyRiW9/nyIKpPcxQiBSeHx8k0iw5DOmjpIc70hmiAU7/jzaw4cYaf8ZqOCp42RVHvhGGhe+aZOjRFQq/VVewByBUiUy/XHc9LD951+mbLQpFe2bnGuvVlL95qRnYR/x1AQ1Pv1pUwpqP6rEPu94J0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199015)(36756003)(26005)(86362001)(6512007)(2616005)(82960400001)(6506007)(186003)(110136005)(41300700001)(6486002)(6636002)(2906002)(54906003)(478600001)(38070700005)(316002)(71200400001)(5660300002)(8936002)(91956017)(38100700002)(66946007)(7406005)(66446008)(4744005)(122000001)(64756008)(7416002)(76116006)(8676002)(66476007)(4326008)(66556008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGswbkdNTW92Ly94SG1JcGZvdkNzYVRvdXZteFBDVXZYWHNGUGMvclFoMzVY?=
 =?utf-8?B?YThpVHNycWVpRThZeS8ybFhVV2ZuUnZQRTdOOTJPdXdBYWdHUWljdnpuZkZy?=
 =?utf-8?B?b0J3V1ZWUS9DOWhXc0RZZC85Sk9la3lRQVhLbmZhRS9hYjJ2aXllNVJFd3JN?=
 =?utf-8?B?SEtDU2RESUJtUUoyRFRMM0d4Y1l0MzdyUURWN1U4MVNOYmsvZGM1NTN5MjIv?=
 =?utf-8?B?OG03TllPcnFOaU9FMUJyLzZWR2JudDR3K2FHa3V6VlFsY0JDdlliRVdBM1ov?=
 =?utf-8?B?c0RRS1l2em94cC9PSy9lRmJHNHNSLzVqSUhNWGRxZmxVejB3bzdZUTJxQzll?=
 =?utf-8?B?clh1Wko1UHJUWEdkcFE1U3p5d2JkbFpNVkd0WU4vdWI5VVNqNjExdkNBdEFZ?=
 =?utf-8?B?dlEwV1BBeFNpREMwSFRmRE1HQnJydlo3bUc5UW1kZ25vTGtyMlo0TGhSUmx6?=
 =?utf-8?B?ajFRU2ZRMnBYdEFVQjNFOGFFZ1RVdFBhN1A4NHFLOUlWbFEyMXFkUkhvWERI?=
 =?utf-8?B?ZWk1WnZiSVdvSzcyeWo1WGdrTVVnZFI0ZjYxSmx6YWQ1VWlmSnBzWHhsWDFq?=
 =?utf-8?B?U3BDNVVLbG5rOTU4LzNNdUhsQ05FSVJ6ZUI4a1RRcTFqYmFVYVc2YlFaSm81?=
 =?utf-8?B?bXNrMlNtZnRrZ1piVWJucUpXczZycTNqdWlMVHEvVTJUd1M4NHNlWEdsdGp0?=
 =?utf-8?B?TDEyNGpSQ2xLTDNiYUhTNUF0WVVQYkJxZkgwOFFYaGptb1pWQ0pQN2g1eFJy?=
 =?utf-8?B?dnI3TDRMOUhNeTVwVWZ0QnpOQTVySmQ5UjVHZkc4UGVYV1kzb290QnhFaVVz?=
 =?utf-8?B?ZEhRczFlNkZucmFwNmczbzZpVzhYYkd3K3ZzYW42RDNHNEhHQXRVU0NkZ3B2?=
 =?utf-8?B?QjZ4em8xYXd2SHp3SFF6cFd6ejBucVZUZTZGMjFJWXRVWFFTRWtha0wxZnpR?=
 =?utf-8?B?VEJ2U1RqTmtEcllvWDcxa3RWZVdIMkxET1FTajIrQ1NKdWxVcDdNSW80SGJv?=
 =?utf-8?B?RE9SSGhKK29oVDkreE0rZVpnTFk0V3VVKzVUU3NRQkJPL3lQWEpkNjBlbThS?=
 =?utf-8?B?YThDNk9SN0o5RkF3UWwwMUF2UWR0TFNnS1FxLzFldGRzWUhlM2lBVmZ2ZHN5?=
 =?utf-8?B?ckxrVmg4UmdCcW5KR1U0RkMyVDEzd0FVZTkza1VwTTZRazF6UVB2TnREM0l0?=
 =?utf-8?B?ajFyWHNDd3I4dDNPTHhjcTBSOVBkdkxUbHNuMXVrNmZ0V2U4dFBoTWRJeG5R?=
 =?utf-8?B?TnlrNERaelJDbmdiZXZqMUV6bVdiZlVyM0E5WWc1VE41S1l3MlFVbHBaRXZ5?=
 =?utf-8?B?bHMzLzB3cktmd0pjdjlHWkc3MUQyTnViZVdDT25ueU8zRkxIczIrUGJmcDZO?=
 =?utf-8?B?UEFrd3djTEFaK2U3bGZmNXJYTEloZFdDQzF3U0NsVFREazZEYXFFSzUwekVG?=
 =?utf-8?B?alg0ZW8vOHc5YVNUV2kyTVMxblR3SzlYYWtRcEd2ZEtleVFYS2lmWVoxSEVh?=
 =?utf-8?B?Mm1ZSnlPWWxsam1SSWhxYlVueEk4V0p2TlV6YmJPckxFSVc1VkNrVk5Bci93?=
 =?utf-8?B?S2Z0dHlyL1hneENTZEZsa0RzeVBFditCQ2lBUUtjQmkzMG0xeEpSak8zTmhy?=
 =?utf-8?B?Sjd2ODRVWFRxQzAzZGRuN2tmU2pJdmZlZjNBZzNCR2h2Y2Ixc3NzbU1Gekwy?=
 =?utf-8?B?a0ZSZFY1My83UU5nT2QxdVpuZ2NIaFo0ZGE2elV1Q1BBYytLTkRoeUlMbUpx?=
 =?utf-8?B?YlF6c3ZPck1kb3JiMEhXb21KZVYwS3BLUEpLQlZOZnFoRERHUm9tdE44YzRv?=
 =?utf-8?B?L3ZuQm5CWVRMU0tXRDRaVStZRUFJM01qbFNsaGR3Rk5ZZGYwanhMZTJYRS9h?=
 =?utf-8?B?a1RIU2ZPMlBwM3hzTHZuVVZaYW5qMGhYTzA4UjlTU1NGUXoxbEtpRFBsSyt0?=
 =?utf-8?B?ZFlpTzdzVEUyWmdvOGZNWFpleFhRZUUzb1V4Mm5hcWdpWnZmZ0R2dVhXa2Vu?=
 =?utf-8?B?bVJOeDBoNmhySnN3UGpVOHc4ZTVxY0lQNExaZDJNMnpTOTBwdVBsT0Zhc2JU?=
 =?utf-8?B?bm5VYngxRlc4WGdFME51dE1uWFVhLzZDNGpYKytabU14ekxRbk9DVk1kOVJS?=
 =?utf-8?B?U0ZDS0RGVitsL3lLODByNkd1NVVhbXhVWnJEbkJhbkR5NXkwWHJVNXovandO?=
 =?utf-8?Q?TU3Dqs2/A3iD6cehulFzVhk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C4ECF7A3EF9F744982FC35CA048C28B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e41a12-21ad-48c5-5f64-08daa6250c6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 16:25:27.8816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6qixXRgpA230+BeElX80K4cAiufUUvV841/hPyj1+dnLPbEbTswkzxPgO4JDYZ2jao/fxa55lm8rQTUOhP92OM2dBjDr1ose2wyLYiNmsEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6755
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTAzIGF0IDIxOjA0IC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+ID4g
SSBkb24ndCBfbGlrZV8gdGhlICNkZWZpbmVzLCBidXQgZG9pbmcgb25lIGhlcmUgZG9lc24ndCBz
ZWVtIHRvbw0KPiA+IG9uZXJvdXMNCj4gPiBjb25zaWRlcmluZyBob3cgY3JpdGljYWwgTVNScyBh
cmUuDQo+IA0KPiBJIGJldCB0aGVyZSBhcmUgb3RoZXJzLCBidXQgdGhpcyBqdXN0IHdlaXJkZWQg
bWUgb3V0LiBJJ2xsIGxpdmUgd2l0aA0KPiBhDQo+IG1hY3JvLCBlc3BlY2lhbGx5IHNpbmNlIHRo
ZSBjaGFuY2Ugb2YgaXQgbXV0YXRpbmcgaW4gYSBub24taW5saW5lIGlzDQo+IHZlcnkgc21hbGws
IGJ1dCBJIGZpZ3VyZWQgSSdkIG1lbnRpb24gdGhlIGlkZWEuDQoNCk1ha2VzIHNlbnNlLiBJJ2xs
IGNoYW5nZSBpdCB0byBhIGRlZmluZS4NCg==
