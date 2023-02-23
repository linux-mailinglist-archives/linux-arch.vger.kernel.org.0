Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBF06A0EEF
	for <lists+linux-arch@lfdr.de>; Thu, 23 Feb 2023 18:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjBWRzJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Feb 2023 12:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBWRzI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Feb 2023 12:55:08 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB80957D35;
        Thu, 23 Feb 2023 09:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677174902; x=1708710902;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9EX8joASCuGU+RKSZgY7h83sTIh7WvVuhxizVzYJkjU=;
  b=FYymwYYjLmm836CZyvUk/X2srvFbIYHrvjA5wCrpDTY3kiOGcHByM0Ib
   jhtaOKRUMW3j/sPptcfI/tCvfal4ZePwJC7y9z7G+PUFMNWEX1XcBrclO
   zYdJGlNqpft+dRxOsAUrbK1FQolNyUR0k7GYF/d6O/mMHTWiRfF0CJODc
   WP8AloyZMgzQW2IFFKmgGazn6hLGZZHrOss4Sue9ZoUZFdghJQCJbn4XJ
   tFsHCONMKmIgZYSdnzhKKQHF5fWEcDMa4Ov/1NOTuHUnTVdhf+fBT2MHy
   VJxQNoo5llhEIXJrwV1kmyMulkl6e2/AkRO9BD38mvkLgufeh4L/uK5ud
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="313658417"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="313658417"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 09:55:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="704928881"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="704928881"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 23 Feb 2023 09:55:00 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Feb 2023 09:55:00 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 23 Feb 2023 09:55:00 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 23 Feb 2023 09:54:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Si8ZsU+SF+3+xm1/2EpZgy9LiOFd0CeAVOGIoEpEwpsMScjmBHFeevgsyhqfEsxOyJlq6/9ZHBAZqdxJnRoJZLUsAJ+N2W2RmCDI/A5QMZmVMWh00SPAOsec3GmgMuB350IgZhqlnNgiRwZfXakV2ziXGCH92pa2OqNtvVgQ/jg8gktiTz9OgyXW/qipB1DNh/FwdCMVos/2Cv2rmelAU3i9oI55dIV+uHbxNPRQUP9ljXt6w4xpFMFQdasiLvXKZqVGE0RoQDEHItCkVT6g4fHUyOwxabrF2To5s8i7ME28lC4S8mGoDLaXVZOE3qBguaLb0URWNbVks0DVRO8+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EX8joASCuGU+RKSZgY7h83sTIh7WvVuhxizVzYJkjU=;
 b=FigLmKVA0vH54CXO/T0IAR+bM/Xds9rhczXaJqGM6VZzEoow9HRTX0NpMjxEz//leAvxUFi24LfUArUZ/NqiueOkMdx4lYmH4mVtV5JADvlDaQm1FDMtWYWPcNgYa3Q/VPBR72n+mUTEx3hkmIznGFZcTDttXGrHeIqeuVVrDXCnsmn8d9fmkG11EqUNMCWDV76hkewdvYzDxyr7smkIfhDTYOyjzAHtzOtNbl1/F6ppJT1wAiNZMJ23zlOuJkFwOe8S1iXKkj3vbdPLtGcJjz1qqZA12SX9Kf2WLAHubUIXrXihSUjKmQvskWeFOh8QMFeMubtdZFIt56TnD9DcyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MN0PR11MB6230.namprd11.prod.outlook.com (2603:10b6:208:3c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 23 Feb
 2023 17:54:56 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6134.021; Thu, 23 Feb 2023
 17:54:56 +0000
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
Subject: Re: [PATCH v6 37/41] selftests/x86: Add shadow stack test
Thread-Topic: [PATCH v6 37/41] selftests/x86: Add shadow stack test
Thread-Index: AQHZQ95ICJxsx2cypUapk1OQ308pxa7ckxuAgABFBgA=
Date:   Thu, 23 Feb 2023 17:54:55 +0000
Message-ID: <5fe0874655a7190a6ea5a070584d2603522f4395.camel@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
         <20230218211433.26859-38-rick.p.edgecombe@intel.com>
         <Y/duhySUieqUWoGX@zn.tnic>
In-Reply-To: <Y/duhySUieqUWoGX@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MN0PR11MB6230:EE_
x-ms-office365-filtering-correlation-id: 7945f40c-f9eb-4931-a33d-08db15c7128a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jDm8Cg/98IqnzfYWYQf+0Lrd9pfKvXfCqSGYpgsFlEYsAzuFFMJOdMrCVm9Y80vTNgxYkZY7PFVLFx7SFOZww0LA/98jWCZwvvVeNrX6iZiVyiWGgHk5yVmiTIoxnvQgw5y+wqRfbkQvKVDFB1OLXK2NFnC37EzPM3cIO7WgGRuxtS+LItHWsd2OfRk6/Wod4LByo1m9LqpeIqSGA+DjXh7VeQN/veuCoXGF/3YMFZxa6/REnmxNm+ryTA/7AHNC8kHE7/y+W4/3N14V3AULmvh+Rd1k3oWlNoLqIDQ7aDUURW6rWo8dU35ZEL2r3LswWCTShwm9vbpFJDzONXS7PrgJqR23GQ5gR+win+hDYseuk0ZJhBeyRMazSogj0338b/+/ysv1Ah3zlcFtfMz8t+JAnaKx6ZHFHUvLSDSqsPu1/G4GCSLBhRgrLaX8vThmvEiyy9cMNafCNqsb6k7ohWr+wfUntXaL7aH3GR1NY4Jc8ix1l/z9sXvOCLcnPdvKCUyLxsBqlz8GXwu5l93H7AD23luYtZz/dWyqKWgwYlT8sLdFJS1sEWJG9AjfI+PnoxjFamr93poN+r0HCm0+VjY4lpDvHDRHLTcfrN9yGJxWy1iVfa6dtHWsx3rRxsFTEa87DBmBGB4cr9dw+ZxWPOYHiVmrRhmw3oUCv3tZibbYKGGprvwp4/p94Y+te4TESRwUQCTZ4WtSYARnWVgP/13Btf9ZEKvFeuWv0/aapKw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199018)(82960400001)(38070700005)(41300700001)(316002)(186003)(26005)(7406005)(7416002)(122000001)(2616005)(8936002)(5660300002)(6486002)(54906003)(6506007)(6512007)(6916009)(8676002)(64756008)(66476007)(66446008)(66556008)(76116006)(66946007)(91956017)(4326008)(71200400001)(478600001)(38100700002)(83380400001)(86362001)(36756003)(2906002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEpwdTJWdTM1NVhqcFlZK3lWbTMxbnZ3UllCcS9TTEtTd0RqTE5USEVKZmpR?=
 =?utf-8?B?UmRUUUE3UkY4d3o5RTluN2VEUnJJMy93cExsT1pvUHgySWZqWWtBKzY0QmlE?=
 =?utf-8?B?UTJsbVlJQis1V2VSY01Gc1ZUVjBENGREKzVlVjhKLzBpSDcvT1VGZmNiTVR4?=
 =?utf-8?B?QTIyQytFYWJ6NlJyb1Z6YzVxZ3NLZ1NXNXg2NzBhenVhSGRkY1ZVUmMwVEdW?=
 =?utf-8?B?ZUN6OGI5eWFHZmZ4NFdpcFREaTFnUDl4TUdBM2tCejRwVDN4WW1BRmxzcDZQ?=
 =?utf-8?B?QmNzWTU1cExyM1QzL0ZuRy8waHFmSlpQdjloSW9mYmZRaUR1MGx5ZFk2RFFa?=
 =?utf-8?B?Z0djTndJUWFOS1RmWmNtRkpCbTh1ejAzdXRsbVVGb1Yrb2JOZXVha3JYSVhx?=
 =?utf-8?B?YjFXdE0zZ2R4bmYxUzZNU2NlSXJaVXZncFAxeFR1Vk1uMU1iN2RpOXFmRWlQ?=
 =?utf-8?B?NHZsOUF0K0pReHk2eXJXM21JTlhNdVlVQmcvZWxYb1duOHVwVlFIVVFmQUxU?=
 =?utf-8?B?YXUrTHZha2N0T3VoVWpOR1lTM3Q4cU5hQ0l4NzhKaitTRDhkVC9uUThXRG5t?=
 =?utf-8?B?Ry91UkcvT01mVUhlZWptUG40Nyt1OU5CMnZmR2hyR05WeHlGUmRTMEpIZG9G?=
 =?utf-8?B?VElFUitMZFJmUmp3QzhKQmQrQlBVRGFtcjJPVGpOaUpGVys4Q2J3OXZUMkFp?=
 =?utf-8?B?OEsxalNibXlWNnhLYUtQN1NDMjIzek9NamNhTWY1eGt5dG5Ra2RLU0VkVWla?=
 =?utf-8?B?RDlVR29tRWtkaGd6ajI4S0M1VWVTb3V5SHRJNDgzeERxR1M3RkFRMWVxWmVO?=
 =?utf-8?B?WXVVU2l5dEJMeCt1NzJsVkUrOFA3THB1VDR3d0laZllvYmVHMkFZTlJHMXR1?=
 =?utf-8?B?d0k4VkRPSjJwZ2JFdTlVQ2V6VVZONTdDenYva1BBTkxtNEw0Rk44dXhXeUM5?=
 =?utf-8?B?TzloZjdWUU05Tmg0enVDQTJocUQ4aFVxdWdIdkZ3c1poT2x3MUpuai9JY1dD?=
 =?utf-8?B?NDNMRzkrZGFuN2FYZHJ2UDFTU3l0WVVsTnhXZ3VPcU13NUk1STN5cy9na2hw?=
 =?utf-8?B?U1pBV2t6ZGhqOGFpWDZORUJzVk5ObkpBQ2taU2pZbEFLdTVZc3UydFBXZlZy?=
 =?utf-8?B?ZUU5ZGZKR0NWWlBIMHhhTjAvV0QyOTBkZVc0cW5LSE1naExNaEd4aUI2QjQx?=
 =?utf-8?B?MFphVC9OS0hhZlM0ai9vd2ZtTmNlY1k3cVd5N3pLNHc4TzF5R0QxMUZNQTll?=
 =?utf-8?B?Q2lwVGYxWVRxT2xUWktPaVJSeHVuQ2R4MWZtblBYMXBJaU1KaDE1K2dzZ3ZO?=
 =?utf-8?B?d2ttSWJKRi9xeU5GamRyNE5aVWo2QkNkZGlCaUcwK1lYM0VNa0d5Mml1MFhr?=
 =?utf-8?B?cXZHdEZWMmVYa0ZIZnZ3clg1bm1wbXcva1lzT1pWMUJKbHN2TVZwMC93YmlK?=
 =?utf-8?B?Vk1VNkxzSVc2bWZ3cVkxY0RialV0V3VvVkFHdVVKdlQyOE83Y1pRWVZSOGxs?=
 =?utf-8?B?aEh1MWp2aUhFTEIxbkVZckFsdDBjSTQvTHdMSUx5OVBVejJ3M0tHaWFIM3Ri?=
 =?utf-8?B?Mm1IM3E0cFRWVjBYMFlYdzkrcDlxdEE1Q0Z0SU5QU25NUVNTeDIzWUxWSGZ0?=
 =?utf-8?B?ZHVkRjhpSU1WRVMzWVNwbSsybjl4SStXeTZwVGNTbndnVlZnamRyOHRqQjFn?=
 =?utf-8?B?NGZFVy9vdGl4aG56UmFkNTdiWTBMYTJhNldxbzBLZTBIbU9ydyt1OVFRMWND?=
 =?utf-8?B?KytyRkpNQ0MrUkZpdmRzZVBmTEJWcTFkekVKeTdNTXZRZVJTWjkxZlhJN0tS?=
 =?utf-8?B?Q1NpaGJnalkvUG80WDNmV2FrOEFpbmV4M1Q5TzZsQkVYcHFwZ2lmT25QcUZN?=
 =?utf-8?B?VTQ4WGhCWWxGY1ZPSno2dDROYUxQczFpVmppcVQ3RnVzdGlKNVg0b2tEU2N1?=
 =?utf-8?B?Y3AxcDhaMi9Kb01PbEt1VThNL01OMjBVYVIyaWlEVytBMFNCQ2pNME42eGhs?=
 =?utf-8?B?Ukw4NWxjOS9OaEZjS09kMFBlZ0xSb1NtMUt4V3RoOW1rck5VeUJ5S2h1alFn?=
 =?utf-8?B?VTcyOTNQMTd4bTNyZ21RYWt6aXJIRDdwZ25JUGttY3JZQ3l6Qm85NXZ1N21h?=
 =?utf-8?B?MTBpS2NQWmFyN1BpNHpCSUllL1lSNXVRR0x6TEVUdXlqNnJDc25wQWx0VFl2?=
 =?utf-8?Q?KtnF9UxKdu8gKkU+9dx0mHE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EAB0727778DAD24E8A2B58B5F06B01D3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7945f40c-f9eb-4931-a33d-08db15c7128a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 17:54:55.6495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KgfErcLctvKyoup852GIpFoEbg11O/rijE6a/3A56yiuVqoNywQrr7adG0nbDhjTjvDQ5t8bjA/Fx1ozuFVfy6bAAQueNNgRj1cGDpfYvpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6230
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIzLTAyLTIzIGF0IDE0OjQ3ICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFNhdCwgRmViIDE4LCAyMDIzIGF0IDAxOjE0OjI5UE0gLTA4MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+IFNpbmNlIHRoaXMgdGVzdCBleGVyY2lzZXMgYSByZWNlbnRseSBhZGRl
ZCBzeXNjYWxsIG1hbnVhbGx5LCBpdA0KPiA+IG5lZWRzDQo+ID4gdG8gZmluZCB0aGUgYXV0b21h
dGljYWxseSBjcmVhdGVkIF9fTlJfZm9vIGRlZmluZXMuIFBlciB0aGUNCj4gPiBzZWxmdGVzdA0K
PiA+IGRvY3VtZW50YXRpb24sIEtIRFJfSU5DTFVERVMgY2FuIGJlIHVzZWQgdG8gaGVscCB0aGUg
c2VsZnRlc3QNCj4gPiBNYWtlZmlsZSdzDQo+IA0KPiBXZWxsLCB3aHkgZG9uJ3QgeW91IG1ha2Ug
aXQgZWFzaWVyIGZvciB0aGUgdXNlciBvZiB0aGlzIHRvIG5vdCBoYXZlDQo+IHRvDQo+IGp1bXAg
dGhyb3VnaCBob29wcyB0byBnZXQgdGhlIHRlc3QgYnVpbHQ/DQo+IA0KPiBJT1csIHNvbWV0aGlu
ZyBsaWtlIHRoZSBiZWxvdyBvbnRvcC4NCj4gDQo+IEl0IHdvcmtzIGlmIEkgZG8NCj4gDQo+ICQg
bWFrZSAtajxudW0+IHRlc3Rfc2hhZG93X3N0YWNrXzY0DQo+IA0KPiBJdCB3b3VsZCBvbmx5IG5l
ZWQgdG8gYmUgZml4ZWQgdG8gd29yayB3aGVuIHlvdSBkbw0KPiANCj4gJCBtYWtlIC1qPG51bT4N
Cj4gDQo+IHdpdGhvdXQgYXJndW1lbnRzIGFzIHRoZW4gbWFrZSBkb2VzIGEgcGFyYWxsZWwgYnVp
bGQuDQo+IA0KPiBJIGd1ZXNzIHNvbWV0aGluZyBsaWtlDQo+IA0KPiBpZm5lcSAoJChmaWx0ZXIg
dGVzdF9zaGFkb3dfc3RhY2tfNjQsICQoTUFLRUNNREdPQUxTKSksKQ0KPiAuTk9UUEFSQUxMRUw6
DQo+IGVuZGlmDQo+IA0KPiBuZWVkcyB0byBoYXBwZW4gYnV0IEknbSBub3Qgc3VyZS4uLg0KDQpB
aCwgSSBzZWUuIEkgaGFkIGJ1aWx0IHRoZSBrZXJuZWwgd2l0aCBDT05GSUdfSEVBREVSU19JTlNU
QUxMIGFuZCBzbw0KdGhpcyB3YXMgYWxyZWFkeSBkb25lIGZvciBtZS4NCg0KVGhlIHByb3Bvc2Vk
IE1ha2VmaWxlIHNvbHV0aW9uIHNlZW1zIGEgYml0IHVudXN1YWwuIFdoYXQgYWJvdXQgdGhpcw0K
bGVzcyBjb21wbGljYXRlZCBzb2x1dGlvbiB0byBqdXN0IG1ha2UgdGhpcyBjYXNlIHdvcms/DQpk
aWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMveDg2L3Rlc3Rfc2hhZG93X3N0YWNr
LmMNCmIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMveDg2L3Rlc3Rfc2hhZG93X3N0YWNrLmMNCmlu
ZGV4IDcxZGUzNTI3YzY3YS4uMDJmZTFiMTM1YmE4IDEwMDY0NA0KLS0tIGEvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMveDg2L3Rlc3Rfc2hhZG93X3N0YWNrLmMNCisrKyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL3g4Ni90ZXN0X3NoYWRvd19zdGFjay5jDQpAQCAtMzQsNiArMzQsMjQgQEANCiAN
CiAjZGVmaW5lIFNTX1NJWkUgMHgyMDAwMDANCiANCisvKg0KKyAqIERlZmluZSB0aGUgQUJJIGRl
ZmluZXMgaWYgbmVlZGVkLCBzbyBwZW9wbGUgY2FuIHJ1biB0aGUgdGVzdHMNCisgKiB3aXRob3V0
IGJ1aWxkaW5nIHRoZSBoZWFkZXJzLg0KKyAqLw0KKyNpZm5kZWYgX19OUl9tYXBfc2hhZG93X3N0
YWNrDQorI2RlZmluZSBfX05SX21hcF9zaGFkb3dfc3RhY2sgICAgICAgICAgNDUxDQorI2RlZmlu
ZSBTSEFET1dfU1RBQ0tfU0VUX1RPS0VOICAgICAgICAgKDFVTEwgPDwgMCkNCisNCisjZGVmaW5l
IEFSQ0hfU0hTVEtfRU5BQkxFICAgICAgICAgICAgICAweDUwMDENCisjZGVmaW5lIEFSQ0hfU0hT
VEtfRElTQUJMRSAgICAgICAgICAgICAweDUwMDINCisjZGVmaW5lIEFSQ0hfU0hTVEtfTE9DSyAg
ICAgICAgICAgICAgICAgICAgICAgIDB4NTAwMw0KKyNkZWZpbmUgQVJDSF9TSFNUS19VTkxPQ0sg
ICAgICAgICAgICAgIDB4NTAwNA0KKyNkZWZpbmUgQVJDSF9TSFNUS19TVEFUVVMgICAgICAgICAg
ICAgIDB4NTAwNQ0KKw0KKyNkZWZpbmUgQVJDSF9TSFNUS19TSFNUSyAgICAgICAgICAgICAgICgx
VUxMIDw8ICAwKQ0KKyNkZWZpbmUgQVJDSF9TSFNUS19XUlNTICAgICAgICAgICAgICAgICAgICAg
ICAgKDFVTEwgPDwgIDEpDQorI2VuZGlmDQorDQogI2lmIChfX0dOVUNfXyA8IDgpIHx8IChfX0dO
VUNfXyA9PSA4ICYmIF9fR05VQ19NSU5PUl9fIDwgNSkNCiBpbnQgbWFpbihpbnQgYXJnYywgY2hh
ciAqYXJndltdKQ0KIHsNCg0KDQpJIHdhcyBhIGJpdCBzdXJwcmlzZWQgdGhpcyB3YXMgZXZlbiBh
cyB0cmlja3kgYXMgdGhlIEtIRFJfSU5DTFVERVMNCnBhcnQuIFRoZSBvdGhlciB0ZXN0cyBzZWVt
IHRvIGJlIGZpbmUgb25seSBiZWNhdXNlIHRoZXkgdXNlIG9sZCBoZWFkZXINCmRlZmluaXRpb25z
IHRoYXQgaGF2ZSBiZWVuIHRoZXJlIGZvcmV2ZXIuIFNvIGl0IHNlZW1zIGxpa2UgdGhlIHByb3Bl
cg0Kd2F5IHRvIGJ1aWxkIHRoZSBzZWxmdGVzdHMgc2hvdWxkIGludm9sdmUgYnVpbGRpbmcgdGhl
IGhlYWRlcnMuIFNvDQphbHRlcm5hdGl2ZWx5LCB3aHkgbm90IGp1c3QgYWx3YXlzIGVuY291cmFn
ZSBidWlsZGluZyB0aGUgaGVhZGVycw0KYmVmb3JlIHJ1bm5pbmcgdGhlIHNlbGZ0ZXN0cyBieSB3
YXJuaW5nIGlmDQoke2Fic19zcmN0cmVlfS91c3IvaW5jbHVkZS9saW51eCBpcyBub3QgZm91bmQ/
DQoNCkRvIGVpdGhlciBvZiB0aG9zZSBzZWVtIGFueSBiZXR0ZXI/DQoNCg==
