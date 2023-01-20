Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3924E675B43
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 18:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjATR1l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Jan 2023 12:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjATR1k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jan 2023 12:27:40 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7BD10276;
        Fri, 20 Jan 2023 09:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674235658; x=1705771658;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vu7nc4fDMyk210KCwi8qXd86KdF3SXHs2MIlBdSGxgo=;
  b=OmZHtPbLF6eTLGt3GKL0LeCnXyHna1pGpY3nzTKb0tNbrCB9+nr8rICW
   Mc046NdTa4jx2m7u27MywgMfk+7mvJEAw+UGi/xE0Q0to0GKVY+y6tL4k
   DrKtWdyjQOuaYe9+huE+0ljutyXtgdwXsmmILnnINw9RMGlC0Tkrm588f
   HSmZysjrSe1CkkLmQbQI1GLr+IoxbEoqITzdBYjDVSQoYJcdKCUFqIZeL
   9J5N/lijl8OHjHoUBXNaBHu/3R35gjr+fRkUODkirP6b46FGQxWt3BTJ+
   0DtpStCNuAFEjSxgqX/pcm6W++OjyaRuXqeE1ii83G1izyzQw/Vx5svaa
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="324327205"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="324327205"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 09:27:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="653858413"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="653858413"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 20 Jan 2023 09:27:34 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 09:27:34 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 09:27:34 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 20 Jan 2023 09:27:34 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 20 Jan 2023 09:27:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvLIaz11vh08NPTMkoxTKG0pZXaScdGJl3FAqVGrTJVj9LnX+vrhOLodRXW/NvFPQ0uS4ZShNnZ12lINmjJ1xf946IqYGiNkghBuMj2oETxTxPCmWkz974S0vDt7ZecgQc8+rm1sZ3Eyc9YPDdz93tCPBWYMvgDv8CBpT0A/Wz2bF78mw54Lb1zblrWA50YreMgHCNLKPtecTMItmySKzdt9aBHuDoYm/cg7bZf5TcVKQ0IuHLUFN2/o0o0hIyiIIsb0jL5TeaXcMGMJ9sETuUu5xI51Y5IT93Cy2tPfZlfMU4bzd11qvRJnHA8W1hQOKFKRf2/Ai/J5us6aP8PHJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vu7nc4fDMyk210KCwi8qXd86KdF3SXHs2MIlBdSGxgo=;
 b=dmEmX+0gk4tz+VMa/LrVr6WAbJ9it7EIsN4Tlrl51mLSQT52mWpY7GCg2q5lewoJ5jfTgQFYaX7WJ7ppExVbD/QlEQmUY18zGVGgYDIIQHwYXwKyCUGBoLkcOjQZOuVE+GZXYPY/UG7V8ufga+T0rCSLwmgJw2c++xbnOQp0tGsOh5sYWzCS6ZGUGVIAYEMUIUztHYNbfiRlBPvyQ0c/R1ckVw4iAVANZndFagowBqBRmnpif67JhJFb8gYrqIIw6Ro/ZcU9EGYpKspkvmC5SJPmtQbYtgXNkKGQoe9W1lgWTOudntUKEaVl28DDqM+k9BHqsC6RRfxpq7ARtpKbCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by IA0PR11MB7259.namprd11.prod.outlook.com (2603:10b6:208:43c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Fri, 20 Jan
 2023 17:27:30 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6002.027; Fri, 20 Jan 2023
 17:27:30 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
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
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v5 00/39] Shadow stacks for userspace
Thread-Topic: [PATCH v5 00/39] Shadow stacks for userspace
Thread-Index: AQHZLExFkDaYZ4rA9keHNDvD4qL75a6mUW0AgAE+64A=
Date:   Fri, 20 Jan 2023 17:27:30 +0000
Message-ID: <b6d88208b987c9cbbdb194b344d2a537dbd76914.camel@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
         <20230119142602.97b24f3cdba75f20f97786d3@linux-foundation.org>
In-Reply-To: <20230119142602.97b24f3cdba75f20f97786d3@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|IA0PR11MB7259:EE_
x-ms-office365-filtering-correlation-id: f0251706-19cd-49bc-59f3-08dafb0b9bfc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 33Cc8DkHOGEVOkO+Cy1iOhv2sIi2UKh76jSEM9Xx2n+xkGa9YJo7pVLwtLwbtCJJU7EaWtqeUqiLHrhK8nWKdedAKR8/zpIOCDT5qCNfzIu5a0pde63aLN90jWL8eyyBlDj/J/sGse0YQ4SfWOwJbLznzVzlIfyTmu4L3wV5dJwhy4MN+uZ0BSNDPdGDkERCpVfzefxyfRxenAhtN/bPzeGHLMAUj0JCU4h3BbAvB306Qu3P0jbb+5EG5n8/bql/9743Cl5g2yHcjjVeJg190RfIGe52MyL3V97vz/MvM3uVFA/evDPA3ZzjnqewgE1CmzDtZ2GptTfW4RnL2a70FZeCkJdjZurNDD/aOZEHDGNyUVcK/yxsq8dKu9hXXONtspiIEtpducD7OZ+UObdrI0fMKvz4p9l7VcbgVYLABjiuyi5cuXBDT37Y+Xp34ki9i6CypmMxkQAsBcrsrLIyjmPM9xHvTLvqKybf4pQVbVDITByMbIwVdATuryMGG6YQmuduke9MZmEOQmtzW3AhOgBmFqFdAzMLv2oof/9F12qBMrfX3NsvcxypwBCm+1cm5tjENi7D3tg1Eu0gZT+HyAlvxO8zUgldLddMSH1N8vToA5Uke7uH62lLUBk9+s3LtwPItrEwbq393Cj678kf2zhngXxyRQM38T8HrvTcMmCprTqBueBtnJJl4GWHo8jV/QVv6BdxG7R24gJUVbBw5ihbBYK1UK9xcT9UVades0M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199015)(8936002)(316002)(122000001)(5660300002)(71200400001)(86362001)(6486002)(478600001)(36756003)(6506007)(2906002)(2616005)(6512007)(54906003)(38070700005)(7406005)(66446008)(6916009)(4326008)(8676002)(66556008)(82960400001)(64756008)(7416002)(186003)(66946007)(26005)(66476007)(76116006)(91956017)(4744005)(38100700002)(41300700001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWJuM0NoU3lFT2pYWno0R1hZTlpmNjRzNWVweFRKSCtkOU5Mc0tEZEc3Tzcy?=
 =?utf-8?B?TFo0ZjN2bEJIWk5ESWhreUhoVFZFVGdvQkN2d2pPQUxxNVQ1MTZFNTFRN2oy?=
 =?utf-8?B?SWR1TGpIOFd1UjVXSitRSkxoSXBoMm1TQzdadXptZnpBWHM4V1JaOU5FcURJ?=
 =?utf-8?B?aUhRMUpzZWtmNVo3RXplMjdtNnRueC8wcitvMDBFeXplZGQxdWtUMTVETmdV?=
 =?utf-8?B?eG15TEEzWHlYV04zZGx4OVRZU3JOTVVnYjd3Z3NlMEthRUlBcVJ5UDhUTmgz?=
 =?utf-8?B?WnREYjlheWVzY2xlaUNEWFdHcGwySE1DN2lNU0JtSEJZaGowY2puWkRqOGQz?=
 =?utf-8?B?S1R2WEc3bWs5YW5IaDJrVUVMcFFwU3ZDSXM2ZUJQUzBTTDNiQmF0R2ZoOHA3?=
 =?utf-8?B?QnFRL3BNK2FFQWViRUw5dkhDTFpBcWphZjVteVhROEl1NHEva2YzaGFpeHJV?=
 =?utf-8?B?SEhDNWtTbE1VRlNGWldFL3BiQ2s5YUhSOHA5QitURmVwM1F5bFkzRGp5UVph?=
 =?utf-8?B?ZkNzSDdmbU12NkRaWnk2TXFaTkhLSkFGbGdMbGxmdGIzRFFTUWlFV3VWK0xz?=
 =?utf-8?B?RGs1eitDZXA3MjFpSzdja0R6WUNjUXZGc054VXJGcFhLcWNUMHNCV1pkU2xR?=
 =?utf-8?B?RnRwY0gvQnhRVnpsbnkvVEJxd0JGRytKNTQxMUE5b2JZVEFOWnd1U05reDNC?=
 =?utf-8?B?NHBxOHpFRjRGSTdSZzlkM093TzlTWkRidXBxWnJtNlNGdmcyVVZlQXlnQ0NV?=
 =?utf-8?B?SmgyN1FlVWtKdG54bVA2UUREYUd0MzdETWdsWVdHbHBHa3VJN3pwcVBDckVD?=
 =?utf-8?B?dnZ3eVFaZ2V1TS9adCtXVmZ0ZCtVbkFrSnIvNlFUZXFpVWkxdHdqdjh4M2Nu?=
 =?utf-8?B?azNheENvdnNIMWlEem1TL2UwT3ZjMklTTXN5SUR4Unk2TGRla011bHY2SnRq?=
 =?utf-8?B?UlVlaGsvQmZnVGpmYWRBN3BERmRuMmROVzFzL2dlZW5kRzJzR1hTSG5ma0tB?=
 =?utf-8?B?eHkyeUhHQi9ScXBSejlaNFZ1cUFmQUJKVzQwdnR0Z1VjcHdmWmc1eVNMS0RS?=
 =?utf-8?B?MWdTN1JIbVZabWpCT1Ewa1orUThoREtZRS91OVlvbmRuTmVmM0lydUNjdTZ5?=
 =?utf-8?B?VzBwY25aVFFnR0lkT0dZdDM0Vzh1S0tmMXJnUW9TdDBDVlkya21jYi9kR25p?=
 =?utf-8?B?b04ydmQyYTNIRzhhRTRYSlExeGgycXY3SHJVSXJ4TDJUOEc2Rk9Ic3FRK01C?=
 =?utf-8?B?Sk5KQmJSY29PUW5jbE5rTnRuSVAwK0dqVG5ZZFl5eGNpNG5idzAwc3pLbVhv?=
 =?utf-8?B?NXBKY1NjZjBrRFFpNGZUNGJzY001RXM5bmFUbDhJVnZSekd0VG1rQkZkTk9M?=
 =?utf-8?B?Z0U0VUFwR3I0Zmk5b0h4enQwaGJkL0NOVEpMUy8wcWVwZ2k4TUlCQUZMS2pL?=
 =?utf-8?B?V1QrbS9tRjNRWVpLM2NwbElWN2lYTHFZZ2VncE84OG5ueGdEc3dMOG9RNHhz?=
 =?utf-8?B?OW83SlVYdzNhd3FuSWdOU1hOeEUwajltcWU5dUZxbE1ZYTdhQ1k5ZUYwNVRF?=
 =?utf-8?B?WHhJV0RjRWlYcTQ2T09xamhhNDNZbmNXYXBvT0YwbnFYYjJyZ3FDTk1EUktk?=
 =?utf-8?B?MnJZNzFpV0xKRXJVemRldzNkbkZoSW5XM1hCNXBzMEdnQlBhN0dBTE5FZlo1?=
 =?utf-8?B?MW01Y2pta0QzeHNXM1J3SEZQdVRoelNvTFZkTzd0RjJYSThtbUNpTFFQSWpw?=
 =?utf-8?B?YS9RYitCbFNOVUlVRllrclptUi9zS3BzUmh5L01hcDJlQW1KRjZKM29Ba0JX?=
 =?utf-8?B?S2hKMXRFYldMVmFQYkprRXJmMUFKMjliNmpOWnNpUTRvbVFXNHd5bDZrK0ZU?=
 =?utf-8?B?bjI2eXI2Y2dTVUpkdFJxNjJQSVZrMDVCWmpVV2k2bm95SjAyS0VpZnV4WW01?=
 =?utf-8?B?dXB6ZlZQVG5leTRvaE84ajVCRm5rQ3Q5MXhOL2NUMytWdTVJODRZVzZJaE1I?=
 =?utf-8?B?R3BEUXdZZ3E3V050a0VKRzBhdU0rVk5QTGFITHgycVB5clVLSnR5eDVydWsr?=
 =?utf-8?B?UWYxUHVsdkdITWZoUWtWL3FuOW9neFFoUVVpZjZNRSsrb0dZUHJ2Y09mMnM2?=
 =?utf-8?B?NG5RQmNJSTFmNDVyRm95SGYwTkZxamdDNVhVQmt0T21WbUZMYUJzSmoxSGlK?=
 =?utf-8?Q?/AiSPBDfI1giRfHLvhpAXe4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <446D2BDF85DAA54D8B11347C44A323DC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0251706-19cd-49bc-59f3-08dafb0b9bfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2023 17:27:30.6096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +vDLmsoZt3iALI0kT8cFX89dTmiH3yszQpUa/28mIONFj37HeA+HKAlQO5KbJCSSzgeTfanp29VLfpjM01GmjVPYwqMr2d3BougKR67cFho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7259
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIzLTAxLTE5IGF0IDE0OjI2IC0wODAwLCBBbmRyZXcgTW9ydG9uIHdyb3RlOg0K
PiBPbiBUaHUsIDE5IEphbiAyMDIzIDEzOjIyOjM4IC0wODAwIFJpY2sgRWRnZWNvbWJlIDwNCj4g
cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gPiBTSFNUSw0KPiANCj4g
U291bmRzIGxpa2UgbWUgdHJ5aW5nIHRvIHN3ZWFyIGluIFJ1c3NpYW4gd2hpbGUgZHJ1bmsuDQo+
IA0KPiBJcyB0aGVyZSBhbnkgY2hhbmNlIG9mIHMvc2hzdGsvc2hhZG93X3N0YWNrL2c/DQoNCkkn
bSBmaW5lIHdpdGggdGhlIG5hbWUgY2hhbmdlLiBJIHRoaW5rIHNoc3RrIGdvdCBkZWJhdGVkIGFu
ZCBwaWNrZWQNCmVhcmx5IGluIHRoZSBoaXN0b3J5IG9mIHRoZSBzZXJpZXMgYmVmb3JlIEkgZ290
IGludm9sdmVkLiAic2hzdGsiIGlzDQpuaWNlIGFuZCBzaG9ydCwgYnV0IGl0J3Mgbm90IGNvbXBs
ZXRlbHkgY2xlYXIgd2hhdCBpdCBpcyB1bmxlc3MgeW91DQphbHJlYWR5IGtub3cgYWJvdXQgc2hh
ZG93IHN0YWNrLiBTbyB0aGVyZSBpcyBhIHRyYWRlb2ZmIG9mIGNsYXJpdHkgYW5kDQpsaW5lIGxl
bmd0aC93cmFwcGluZy4gRG9lcyBhbnlvbmUgZWxzZSBoYXZlIGFueSBzdHJvbmcgb3BpbmlvbnM/
DQo=
