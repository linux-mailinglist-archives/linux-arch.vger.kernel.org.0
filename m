Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE034AE462
	for <lists+linux-arch@lfdr.de>; Tue,  8 Feb 2022 23:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236636AbiBHW3e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Feb 2022 17:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386327AbiBHW1X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Feb 2022 17:27:23 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C83C03C1B4;
        Tue,  8 Feb 2022 14:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644359020; x=1675895020;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=P4N+pyHntkZkdrwguKkwcBDCy4CGt8pNVYKWHjW06BQ=;
  b=AyeS0td1iBKdyS32uAEH3wvy2+pbqsgs3iNSYWX4jwGyLtCFtyCDljoF
   xPqYrRXsNS/2k4V9/Ch3WUXC4UMD3cMx5OEqRFAAMrHlGicJaJRyb0H/h
   khNgdcQZhQk7wM3C/gq01g0+zB2t3VXUhwmbo2Tg3zvifuDLRlUB71eTW
   VcTRBY3GngvIVP8t52jzF7wDFN4Xt0rwWKsvUc09DCI1KENfE+I6048wx
   KTEjlOIuD8owxKkv45F8zecv4Z/vRaCPlgCJXXukCdSfkBQWJ6lNgUJRw
   gCDBi9R7ENX+5o323OhyRAXdzV8sb2c3kHM5/+Zc4gZluOPVd4f4uEbO1
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="248826983"
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="248826983"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 14:23:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="484977675"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 08 Feb 2022 14:23:39 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 8 Feb 2022 14:23:38 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 8 Feb 2022 14:23:38 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 8 Feb 2022 14:23:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrTjI6a1+N9myFrtN0cXzqk1tDyHq3Cnm4ZGQWFtioZzp5ZFGvftRBW6q9oho9LOL52YmFjnHaePZYar7EILg44sUnZQ0kFbOUCofPPO43NFVZ0uzY2Hpa/PEjsiL7L7YlZGG/iSnmOWVg4zRO/01e03cBh33z1h9JbOvalBETPp+A5DmxooAYutWDTgwy9/MgFrv4tInRU3tMOAamJUDG5N4offUXpO6pLc+DwdhmVsAjEJnxaS/tEKDtfmu/9Ky+rZmOEtorU7clZQrVc+ASw7+RTCdxiw6KpQYYe/NxdmskETqRpgFrbQjNdWqXoxWS6sHlAuZL+R8425HxrjgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4N+pyHntkZkdrwguKkwcBDCy4CGt8pNVYKWHjW06BQ=;
 b=ELi+7+9nJ1HahRaGDkp+9gYeNbtJqzEZWBOyju8gUjRAWgiOxE2GBWY6tphV3jOTmFXunf5PbJxIkkb1XNPeKEtZyuO6yuoYTq46QwDTs649DENCCFfZWym0yHgyX44tAhYhwbr14pIQbkdGyl2G9xuw5pJT2nsRBVGzYUeaHkwyNqkgj9B5BjVkoyOHBdtvHnlne9Kc+3pxTYGIRk6gReDZveiZAeRa443sjX4ejZOIpF+YLJaBgwiscbIG/pU+09dUsRzSpbeUaTQOSjF2ZE0eM6soZeV/2AeSuaTrRXdtDjwoR+xpFO6TwbMxHPoRPN2hr34BM8G8SyM8gKnEIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 22:23:34 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 22:23:34 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
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
        "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>
Subject: Re: [PATCH 06/35] x86/cet: Add control-protection fault handler
Thread-Topic: [PATCH 06/35] x86/cet: Add control-protection fault handler
Thread-Index: AQHYFh9vUlIRV3FZNE+RCJh1wFMYXayI0HEAgAF4U4A=
Date:   Tue, 8 Feb 2022 22:23:33 +0000
Message-ID: <d9ab95ded2c51ead24ebb4167d8ce77ae4a3594f.camel@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
         <20220130211838.8382-7-rick.p.edgecombe@intel.com>
         <40453c9d-f08c-e419-3d04-22605e219594@intel.com>
In-Reply-To: <40453c9d-f08c-e419-3d04-22605e219594@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da779fa8-b6cd-4de7-0582-08d9eb51a4ec
x-ms-traffictypediagnostic: DM6PR11MB3625:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB362533FF5ED5A6710ECB149AC92D9@DM6PR11MB3625.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pMskYqNcsAGjj3tRNpeig91hixVEip/R9BH0PuJ+pXiZGjzUHqRTZ6oBeKBzrnLTGXDmtEO4bcStH0tThhEjZ6cck6FKAciW0M+t838X61GFuYLP5yCCNaG8BZjN0OZRSUs/kXyNUd5DCNub1Ml2GURQHzCnXd4EdwXkxEE4vjqcYXAMP9PFl4n5SPOaN7Wrll/wQlRXtJ044cNr0B6fGhsUyWS8Eea/bfCFJJvXYYUx9+gjUDaSz8DiEjMD2NemAZYp2sSM9xVrc+ABQ4ZynlJs/7zwQNy/VgCFD9BZBkhXugm6nbrR5wOXnVCjSXr8yddSLtzWfQZ/vI2OLir5cnPXMIEhpDqem3qN0jQGnxxOU5dZsFPYd8GS0sn6jqBP5BuJ9RYj7vL7De9hPzrCldrmlhzLtrForxkZkrJLD/PVPukdfQo4K55KWGB+hjgNY2Na9jDOz7KdMCGLm24Z96Ai/Vu6SfAZ9d+x0Y7d5yZqH1yonHCjCSKecANfoMo0F5pDwnCYDriBKQ0F8DuhN08iHeqNFLxbIniCmg70HwPTtD7v2J3ek6jHkDwNSNBR0BpmtK9/6aMbmYazIDaiYf1gDDzxviNPRD7ZVwYl6pgCfEEZyEPGs3OK1HxccUZIZGkQp8iGfFtDgsnFlY8eMP92FC1F3YGLonWAZb+o5xhQh4H+SYISHTx4D+RNSlDmqupWgUoWYVl3lX9IMN29qLNDLAXOUUhA966qPVprI5Jfhlc4YEHEhYhekqr6yIh9uyrljXQIZoPNl4AYIjGpsBcgwoX2BuG+nB0oPYjyDHqOSlWkhnPzFr5eVoLGNwClWQ8bm0dgep1Gs8FernPfWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(82960400001)(122000001)(508600001)(83380400001)(66556008)(38070700005)(8936002)(8676002)(4326008)(186003)(54906003)(38100700002)(76116006)(921005)(26005)(6506007)(86362001)(7416002)(5660300002)(71200400001)(966005)(6486002)(2616005)(316002)(110136005)(66476007)(64756008)(66446008)(53546011)(7406005)(2906002)(6512007)(36756003)(30864003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0VGK00wTkp4bHlVNnZqc0lpQWEvY280ZjZVQ1dZYUttRnBIbFlUNFZPWXE2?=
 =?utf-8?B?ZW8vL2NZcE9qZzRHNUFxUDhsdmxySFlOWVpOaFhPWWJrV0twR0JJRC9QdWI0?=
 =?utf-8?B?SjZMd1FqSTZpRndJQ2xMdkZZUW5uaTJZZlMxcEpuTnpUSXdtVXRucmhFQldK?=
 =?utf-8?B?T2dUWitJTzlqYmNPR0E1ajhZVXJIVnZVMmsvN3N2NlBra2ZjUXNvZmJqWUpG?=
 =?utf-8?B?c00rWXdBTzY1YU1NeFp4ZnQvZHQxQ1QwRi9WTENITzg3ekFPODRrZ2NGOUVV?=
 =?utf-8?B?ZWJMbXJIT0FETVJGWEtWZHZkMFlZeFRveGxxbDBBYTFlZjFSMnVFYkZIN1cy?=
 =?utf-8?B?bFlyeHZLTm14czBVQTNWRVdRMUNDcmNIcmc3RkxzU0dwZzhpem5DZldPbEtE?=
 =?utf-8?B?eVZmbUU0aXZ4QjJCMEVtY1ZPMG95QnQ2TXFXSURSOEYzUWp1dDdwYnZsYTBo?=
 =?utf-8?B?anBJUUwxb3B4TVRsTkpUWTVNTWNBaFNPUTM0OEFmckFMcnlUOTJORHBLQ2dI?=
 =?utf-8?B?SXBzSWlpa1lnM0tTNnBVdksvNDZHZzA1YUV1MlpocDhEdDNIUFRyNnFXell3?=
 =?utf-8?B?WVdlZjRudWsxMjQ2TC9GWnNFSFBZTjh0UWF2RFc3Q0ZCVnRZb2hNeHdRRitD?=
 =?utf-8?B?M2VwN0dSQ2NMc25jZE5OZTVNMXNGblZmRWpoVmRlSC9obyt6UG5ZaTh0Tjkz?=
 =?utf-8?B?RnhSZkxUS3BYNjgyQmZmczc2MWFhbFZtRVBjc0k3V01LSElyOGRlc3AyS2lj?=
 =?utf-8?B?NS9xVmJmdG92aE9kNDJ2Y3pMbDFsWmx3YXFuZlJQR3pJUUtMR1NLUEtNZnlE?=
 =?utf-8?B?QlFxRXFHUkNmbVAwN3hvTzNTdU56dG8yQUNvczEwWTZacUdKUk5LMFg5S251?=
 =?utf-8?B?dTNRZEErQ2EyWDlEZmpHaExXRHFqZ29XMzdtaml3YldWQXEvbkYrUExxQnJN?=
 =?utf-8?B?UzlwUUVjaENMWUFIaXMyNlc4OHNlWVBTRXdjTnB6M3R3c2dKaTQ3QUpFZE5K?=
 =?utf-8?B?OFFOQUdHRk1OUGkzQjRrenh2bEp3NzErbXFXVTdNYm9kUXpVd29kYW9WWUFP?=
 =?utf-8?B?Yml3NzdFKzhLdURzZHd4WUpWTjJBcUlKZkVwOFhEVE9nM0hDSkZvanVxa0tz?=
 =?utf-8?B?VEdiTUwyOGhyWWZnZHJNQjVScWJ5Ukc4bXM3ZHpRTDUzQkhIakZ5VHJFRUx2?=
 =?utf-8?B?ZTFkbktrbnNvY1JZVy9CalFnRXlIOXd1dkVRWlRPdTZoeEZQVThzNXAyS3hj?=
 =?utf-8?B?cGZxa0tpanp3SUl2dit4SkwwamkwakJTREkyNjlqQTlIWXA2RjVzdTZJL21v?=
 =?utf-8?B?aTM5RHNNZ3hsRWM3cXQyTFN4NWREekx0QldPNjF5OFVsTFJ5Q3FEQ1pRZnVm?=
 =?utf-8?B?RGM4ZlVsakZYRHJzalI1TmxCQUtrQXVMMHBSZXZXczZLV1ZnUHN0ZFFrQ3ZW?=
 =?utf-8?B?MGdEY0dXbisvTWFUejU0VjIySjNkaVdrUVB3dUhsMnRoOFkwMy9zeGloZkND?=
 =?utf-8?B?NHAwTlM5djZ4VW52UGZaMWRaNUMzaGFXZFVOUWxEUjFSdWhrZDlibXgrKzYv?=
 =?utf-8?B?M1RBY2JXeFJaby9wZGFScVg1OHBXR3hDays2bE9KdHlxZzNRUHN2RzR0VFJ2?=
 =?utf-8?B?WmpzeWhkVlFLRFhFUkYwYnNlNXBxbnFKSzZNbmc0WFB4aEJoZGp6U1poUzZy?=
 =?utf-8?B?K05CdktZQ0tkaUU2d1MralJ5UkJpQk16QkMvSGNJOUdkblMxY2FPelIrdTdj?=
 =?utf-8?B?YkwvcHJ0Z0liNEJZdVZoV2IxZVROYm12WTJQQWgzZWg0UXNMV041TytGNFlN?=
 =?utf-8?B?cjdVT1A1dUtYSE5OS1ppNDBTS3UwTG4yWlJYWUxJd3ZKeFJlY3MvSkM3TjVk?=
 =?utf-8?B?SkVrb1JvM2UySVRibmFKQnVGN2txZUZKL3FvbG55eVpramtNVjdxc0pYOGxF?=
 =?utf-8?B?SEd2c2FmcmNVVlgreDVteG42SCtuenhOcU1jR3F0UjhFdVZIRnVVVHdYTnN5?=
 =?utf-8?B?L0V5Nk9KR3lPeDk0dlY5NEgxQzdnamN0bzVmTG94WmpDVGc4aVM2SllwQy95?=
 =?utf-8?B?UTRUSHNhbHFzNWRrTkUvRWpaeW9nME00bi8wQTFOaGdndnpUdFdxNVFEYUlo?=
 =?utf-8?B?ZU9PempQU0g1MEZUOWtSTUhSOThGNTNIT0RFSUo3YU9lSW00ODZQMU5Yd0ky?=
 =?utf-8?B?R04rZEFEbm1UdXp3eGdFSWZiMGcxQmtKZTg0Z0RSUXpEeEI1bG52ajVPZ0pP?=
 =?utf-8?Q?WV/SZvR+yBQZIWogBAHtJ4ogN0AgXjKS4VtuwwswO4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5CE18F290050E4B820EC36874A8EF20@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da779fa8-b6cd-4de7-0582-08d9eb51a4ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 22:23:33.8320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +3a2hL8fFhZq+3M7iGQ+B8U7kkhcHVJuoqxu6lcNeRl+Jsy5oQMO/m0x4wF0vOF3zT5+K644KnB5Ba5kkHDEWDUVYCvmGQ3zRWQLvYtUdsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3625
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTAyLTA3IGF0IDE1OjU2IC0wODAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gMS8zMC8yMiAxMzoxOCwgUmljayBFZGdlY29tYmUgd3JvdGU6DQo+ID4gQSBjb250cm9sLXBy
b3RlY3Rpb24gZmF1bHQgaXMgdHJpZ2dlcmVkIHdoZW4gYSBjb250cm9sLWZsb3cNCj4gPiB0cmFu
c2Zlcg0KPiA+IGF0dGVtcHQgdmlvbGF0ZXMgU2hhZG93IFN0YWNrIG9yIEluZGlyZWN0IEJyYW5j
aCBUcmFja2luZw0KPiA+IGNvbnN0cmFpbnRzLg0KPiA+IEZvciBleGFtcGxlLCB0aGUgcmV0dXJu
IGFkZHJlc3MgZm9yIGEgUkVUIGluc3RydWN0aW9uIGRpZmZlcnMgZnJvbQ0KPiA+IHRoZSBjb3B5
DQo+ID4gb24gdGhlIHNoYWRvdyBzdGFjazsgb3IgYW4gaW5kaXJlY3QgSk1QIGluc3RydWN0aW9u
LCB3aXRob3V0IHRoZQ0KPiA+IE5PVFJBQ0sNCj4gPiBwcmVmaXgsIGFycml2ZXMgYXQgYSBub24t
RU5EQlIgb3Bjb2RlLg0KPiA+IA0KPiA+IFRoZSBjb250cm9sLXByb3RlY3Rpb24gZmF1bHQgaGFu
ZGxlciB3b3JrcyBpbiBhIHNpbWlsYXIgd2F5IGFzIHRoZQ0KPiA+IGdlbmVyYWwNCj4gPiBwcm90
ZWN0aW9uIGZhdWx0IGhhbmRsZXIuICBJdCBwcm92aWRlcyB0aGUgc2lfY29kZSBTRUdWX0NQRVJS
IHRvDQo+ID4gdGhlIHNpZ25hbA0KPiA+IGhhbmRsZXIuDQo+IA0KPiBJdCdzIG5vdCBhIGJpZyBk
ZWFsLCBidXQgd2Ugc2hvdWxkIHByb2JhYmx5IGp1c3QgcmVtb3ZlIElCVCBmcm9tIHRoZQ0KPiBj
aGFuZ2Vsb2dzIGZvciBub3cuDQoNCk1ha2VzIHNlbnNlLiBJIHNob3VsZCBoYXZlIHNjcnViYmVk
IHRoZXNlIGJldHRlciBmb3IgSUJULg0KDQo+IA0KPiA+ICBhcmNoL2FybS9rZXJuZWwvc2lnbmFs
LmMgICAgICAgICAgIHwgIDIgKy0NCj4gPiAgYXJjaC9hcm02NC9rZXJuZWwvc2lnbmFsLmMgICAg
ICAgICB8ICAyICstDQo+ID4gIGFyY2gvYXJtNjQva2VybmVsL3NpZ25hbDMyLmMgICAgICAgfCAg
MiArLQ0KPiA+ICBhcmNoL3NwYXJjL2tlcm5lbC9zaWduYWwzMi5jICAgICAgIHwgIDIgKy0NCj4g
PiAgYXJjaC9zcGFyYy9rZXJuZWwvc2lnbmFsXzY0LmMgICAgICB8ICAyICstDQo+ID4gIGFyY2gv
eDg2L2luY2x1ZGUvYXNtL2lkdGVudHJ5LmggICAgfCAgNCArKw0KPiA+ICBhcmNoL3g4Ni9rZXJu
ZWwvaWR0LmMgICAgICAgICAgICAgIHwgIDQgKysNCj4gPiAgYXJjaC94ODYva2VybmVsL3NpZ25h
bF9jb21wYXQuYyAgICB8ICAyICstDQo+ID4gIGFyY2gveDg2L2tlcm5lbC90cmFwcy5jICAgICAg
ICAgICAgfCA2Mg0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICBpbmNs
dWRlL3VhcGkvYXNtLWdlbmVyaWMvc2lnaW5mby5oIHwgIDMgKy0NCj4gPiAgMTAgZmlsZXMgY2hh
bmdlZCwgNzggaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm0va2VybmVsL3NpZ25hbC5jIGIvYXJjaC9hcm0va2VybmVsL3NpZ25hbC5j
DQo+ID4gaW5kZXggYzUzMmE2MDQxMDY2Li41OWFhYWRjZTlkNTIgMTAwNjQ0DQo+ID4gLS0tIGEv
YXJjaC9hcm0va2VybmVsL3NpZ25hbC5jDQo+ID4gKysrIGIvYXJjaC9hcm0va2VybmVsL3NpZ25h
bC5jDQo+ID4gQEAgLTY4MSw3ICs2ODEsNyBAQCBhc21saW5rYWdlIHZvaWQgZG9fcnNlcV9zeXNj
YWxsKHN0cnVjdCBwdF9yZWdzDQo+ID4gKnJlZ3MpDQo+ID4gICAqLw0KPiA+ICBzdGF0aWNfYXNz
ZXJ0KE5TSUdJTEwJPT0gMTEpOw0KPiA+ICBzdGF0aWNfYXNzZXJ0KE5TSUdGUEUJPT0gMTUpOw0K
PiA+IC1zdGF0aWNfYXNzZXJ0KE5TSUdTRUdWCT09IDkpOw0KPiA+ICtzdGF0aWNfYXNzZXJ0KE5T
SUdTRUdWCT09IDEwKTsNCj4gPiAgc3RhdGljX2Fzc2VydChOU0lHQlVTCT09IDUpOw0KPiA+ICBz
dGF0aWNfYXNzZXJ0KE5TSUdUUkFQCT09IDYpOw0KPiA+ICBzdGF0aWNfYXNzZXJ0KE5TSUdDSExE
CT09IDYpOw0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2tlcm5lbC9zaWduYWwuYw0KPiA+
IGIvYXJjaC9hcm02NC9rZXJuZWwvc2lnbmFsLmMNCj4gPiBpbmRleCBkOGFhZjRiNmY0MzIuLmQy
ZGE1N2M0MTViOCAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2tlcm5lbC9zaWduYWwuYw0K
PiA+ICsrKyBiL2FyY2gvYXJtNjQva2VybmVsL3NpZ25hbC5jDQo+ID4gQEAgLTk4Myw3ICs5ODMs
NyBAQCB2b2lkIF9faW5pdCBtaW5zaWdzdGtzel9zZXR1cCh2b2lkKQ0KPiA+ICAgKi8NCj4gPiAg
c3RhdGljX2Fzc2VydChOU0lHSUxMCT09IDExKTsNCj4gPiAgc3RhdGljX2Fzc2VydChOU0lHRlBF
CT09IDE1KTsNCj4gPiAtc3RhdGljX2Fzc2VydChOU0lHU0VHVgk9PSA5KTsNCj4gPiArc3RhdGlj
X2Fzc2VydChOU0lHU0VHVgk9PSAxMCk7DQo+ID4gIHN0YXRpY19hc3NlcnQoTlNJR0JVUwk9PSA1
KTsNCj4gPiAgc3RhdGljX2Fzc2VydChOU0lHVFJBUAk9PSA2KTsNCj4gPiAgc3RhdGljX2Fzc2Vy
dChOU0lHQ0hMRAk9PSA2KTsNCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9rZXJuZWwvc2ln
bmFsMzIuYw0KPiA+IGIvYXJjaC9hcm02NC9rZXJuZWwvc2lnbmFsMzIuYw0KPiA+IGluZGV4IGQ5
ODQyODJiOTc5Zi4uODc3NmEzNGM2NDQ0IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQva2Vy
bmVsL3NpZ25hbDMyLmMNCj4gPiArKysgYi9hcmNoL2FybTY0L2tlcm5lbC9zaWduYWwzMi5jDQo+
ID4gQEAgLTQ2MCw3ICs0NjAsNyBAQCB2b2lkIGNvbXBhdF9zZXR1cF9yZXN0YXJ0X3N5c2NhbGwo
c3RydWN0DQo+ID4gcHRfcmVncyAqcmVncykNCj4gPiAgICovDQo+ID4gIHN0YXRpY19hc3NlcnQo
TlNJR0lMTAk9PSAxMSk7DQo+ID4gIHN0YXRpY19hc3NlcnQoTlNJR0ZQRQk9PSAxNSk7DQo+ID4g
LXN0YXRpY19hc3NlcnQoTlNJR1NFR1YJPT0gOSk7DQo+ID4gK3N0YXRpY19hc3NlcnQoTlNJR1NF
R1YJPT0gMTApOw0KPiA+ICBzdGF0aWNfYXNzZXJ0KE5TSUdCVVMJPT0gNSk7DQo+ID4gIHN0YXRp
Y19hc3NlcnQoTlNJR1RSQVAJPT0gNik7DQo+ID4gIHN0YXRpY19hc3NlcnQoTlNJR0NITEQJPT0g
Nik7DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvc3BhcmMva2VybmVsL3NpZ25hbDMyLmMNCj4gPiBi
L2FyY2gvc3BhcmMva2VybmVsL3NpZ25hbDMyLmMNCj4gPiBpbmRleCA2Y2MxMjRhM2JiOTguLmRj
NTBiMmE3ODY5MiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3NwYXJjL2tlcm5lbC9zaWduYWwzMi5j
DQo+ID4gKysrIGIvYXJjaC9zcGFyYy9rZXJuZWwvc2lnbmFsMzIuYw0KPiA+IEBAIC03NTIsNyAr
NzUyLDcgQEAgYXNtbGlua2FnZSBpbnQgZG9fc3lzMzJfc2lnc3RhY2sodTMyIHVfc3NwdHIsDQo+
ID4gdTMyIHVfb3NzcHRyLCB1bnNpZ25lZCBsb25nIHNwKQ0KPiA+ICAgKi8NCj4gPiAgc3RhdGlj
X2Fzc2VydChOU0lHSUxMCT09IDExKTsNCj4gPiAgc3RhdGljX2Fzc2VydChOU0lHRlBFCT09IDE1
KTsNCj4gPiAtc3RhdGljX2Fzc2VydChOU0lHU0VHVgk9PSA5KTsNCj4gPiArc3RhdGljX2Fzc2Vy
dChOU0lHU0VHVgk9PSAxMCk7DQo+ID4gIHN0YXRpY19hc3NlcnQoTlNJR0JVUwk9PSA1KTsNCj4g
PiAgc3RhdGljX2Fzc2VydChOU0lHVFJBUAk9PSA2KTsNCj4gPiAgc3RhdGljX2Fzc2VydChOU0lH
Q0hMRAk9PSA2KTsNCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9zcGFyYy9rZXJuZWwvc2lnbmFsXzY0
LmMNCj4gPiBiL2FyY2gvc3BhcmMva2VybmVsL3NpZ25hbF82NC5jDQo+ID4gaW5kZXggMmE3OGQy
YWYxMjY1Li43ZmUyYmQzN2JkMWEgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9zcGFyYy9rZXJuZWwv
c2lnbmFsXzY0LmMNCj4gPiArKysgYi9hcmNoL3NwYXJjL2tlcm5lbC9zaWduYWxfNjQuYw0KPiA+
IEBAIC01NjIsNyArNTYyLDcgQEAgdm9pZCBkb19ub3RpZnlfcmVzdW1lKHN0cnVjdCBwdF9yZWdz
ICpyZWdzLA0KPiA+IHVuc2lnbmVkIGxvbmcgb3JpZ19pMCwgdW5zaWduZWQgbG9uZw0KPiA+ICAg
Ki8NCj4gPiAgc3RhdGljX2Fzc2VydChOU0lHSUxMCT09IDExKTsNCj4gPiAgc3RhdGljX2Fzc2Vy
dChOU0lHRlBFCT09IDE1KTsNCj4gPiAtc3RhdGljX2Fzc2VydChOU0lHU0VHVgk9PSA5KTsNCj4g
PiArc3RhdGljX2Fzc2VydChOU0lHU0VHVgk9PSAxMCk7DQo+ID4gIHN0YXRpY19hc3NlcnQoTlNJ
R0JVUwk9PSA1KTsNCj4gPiAgc3RhdGljX2Fzc2VydChOU0lHVFJBUAk9PSA2KTsNCj4gPiAgc3Rh
dGljX2Fzc2VydChOU0lHQ0hMRAk9PSA2KTsNCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5j
bHVkZS9hc20vaWR0ZW50cnkuaA0KPiA+IGIvYXJjaC94ODYvaW5jbHVkZS9hc20vaWR0ZW50cnku
aA0KPiA+IGluZGV4IDEzNDUwODhlOTkwMi4uYTkwNzkxNDMzMTUyIDEwMDY0NA0KPiA+IC0tLSBh
L2FyY2gveDg2L2luY2x1ZGUvYXNtL2lkdGVudHJ5LmgNCj4gPiArKysgYi9hcmNoL3g4Ni9pbmNs
dWRlL2FzbS9pZHRlbnRyeS5oDQo+ID4gQEAgLTU2Miw2ICs1NjIsMTAgQEAgREVDTEFSRV9JRFRF
TlRSWV9FUlJPUkNPREUoWDg2X1RSQVBfU1MsCQ0KPiA+IGV4Y19zdGFja19zZWdtZW50KTsNCj4g
PiAgREVDTEFSRV9JRFRFTlRSWV9FUlJPUkNPREUoWDg2X1RSQVBfR1AsCWV4Y19nZW5lcmFsX3By
b3RlY3Rpb24pDQo+ID4gOw0KPiA+ICBERUNMQVJFX0lEVEVOVFJZX0VSUk9SQ09ERShYODZfVFJB
UF9BQywJZXhjX2FsaWdubWVudF9jaGVjayk7DQo+ID4gIA0KPiA+ICsjaWZkZWYgQ09ORklHX1g4
Nl9TSEFET1dfU1RBQ0sNCj4gPiArREVDTEFSRV9JRFRFTlRSWV9FUlJPUkNPREUoWDg2X1RSQVBf
Q1AsIGV4Y19jb250cm9sX3Byb3RlY3Rpb24pOw0KPiA+ICsjZW5kaWYNCj4gPiArDQo+ID4gIC8q
IFJhdyBleGNlcHRpb24gZW50cmllcyB3aGljaCBuZWVkIGV4dHJhIHdvcmsgKi8NCj4gPiAgREVD
TEFSRV9JRFRFTlRSWV9SQVcoWDg2X1RSQVBfVUQsCQlleGNfaW52YWxpZF9vcCk7DQo+ID4gIERF
Q0xBUkVfSURURU5UUllfUkFXKFg4Nl9UUkFQX0JQLAkJZXhjX2ludDMpOw0KPiA+IGRpZmYgLS1n
aXQgYS9hcmNoL3g4Ni9rZXJuZWwvaWR0LmMgYi9hcmNoL3g4Ni9rZXJuZWwvaWR0LmMNCj4gPiBp
bmRleCBkZjBmYTY5NWJiMDkuLjlmMWJkYWFiYzI0NiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4
Ni9rZXJuZWwvaWR0LmMNCj4gPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvaWR0LmMNCj4gPiBAQCAt
MTEzLDYgKzExMywxMCBAQCBzdGF0aWMgY29uc3QgX19pbml0Y29uc3Qgc3RydWN0IGlkdF9kYXRh
DQo+ID4gZGVmX2lkdHNbXSA9IHsNCj4gPiAgI2VsaWYgZGVmaW5lZChDT05GSUdfWDg2XzMyKQ0K
PiA+ICAJU1lTRyhJQTMyX1NZU0NBTExfVkVDVE9SLAllbnRyeV9JTlQ4MF8zMiksDQo+ID4gICNl
bmRpZg0KPiA+ICsNCj4gPiArI2lmZGVmIENPTkZJR19YODZfU0hBRE9XX1NUQUNLDQo+ID4gKwlJ
TlRHKFg4Nl9UUkFQX0NQLAkJYXNtX2V4Y19jb250cm9sX3Byb3RlY3Rpb24pLA0KPiA+ICsjZW5k
aWYNCj4gPiAgfTsNCj4gPiAgDQo+ID4gIC8qDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tl
cm5lbC9zaWduYWxfY29tcGF0LmMNCj4gPiBiL2FyY2gveDg2L2tlcm5lbC9zaWduYWxfY29tcGF0
LmMNCj4gPiBpbmRleCBiNTI0MDdjNTYwMDAuLmZmNTBjZDk3OGVhNSAxMDA2NDQNCj4gPiAtLS0g
YS9hcmNoL3g4Ni9rZXJuZWwvc2lnbmFsX2NvbXBhdC5jDQo+ID4gKysrIGIvYXJjaC94ODYva2Vy
bmVsL3NpZ25hbF9jb21wYXQuYw0KPiA+IEBAIC0yNyw3ICsyNyw3IEBAIHN0YXRpYyBpbmxpbmUg
dm9pZA0KPiA+IHNpZ25hbF9jb21wYXRfYnVpbGRfdGVzdHModm9pZCkNCj4gPiAgCSAqLw0KPiA+
ICAJQlVJTERfQlVHX09OKE5TSUdJTEwgICE9IDExKTsNCj4gPiAgCUJVSUxEX0JVR19PTihOU0lH
RlBFICAhPSAxNSk7DQo+ID4gLQlCVUlMRF9CVUdfT04oTlNJR1NFR1YgIT0gOSk7DQo+ID4gKwlC
VUlMRF9CVUdfT04oTlNJR1NFR1YgIT0gMTApOw0KPiA+ICAJQlVJTERfQlVHX09OKE5TSUdCVVMg
ICE9IDUpOw0KPiA+ICAJQlVJTERfQlVHX09OKE5TSUdUUkFQICE9IDYpOw0KPiA+ICAJQlVJTERf
QlVHX09OKE5TSUdDSExEICE9IDYpOw0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwv
dHJhcHMuYyBiL2FyY2gveDg2L2tlcm5lbC90cmFwcy5jDQo+ID4gaW5kZXggYzlkNTY2ZGNmODlh
Li41NGI3YTE0NmZkNWUgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYva2VybmVsL3RyYXBzLmMN
Cj4gPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvdHJhcHMuYw0KPiA+IEBAIC0zOSw2ICszOSw3IEBA
DQo+ID4gICNpbmNsdWRlIDxsaW51eC9pby5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvaGFyZGly
cS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvYXRvbWljLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51
eC9ub3NwZWMuaD4NCj4gPiAgDQo+ID4gICNpbmNsdWRlIDxhc20vc3RhY2t0cmFjZS5oPg0KPiA+
ICAjaW5jbHVkZSA8YXNtL3Byb2Nlc3Nvci5oPg0KPiA+IEBAIC02NDEsNiArNjQyLDY3IEBADQo+
ID4gREVGSU5FX0lEVEVOVFJZX0VSUk9SQ09ERShleGNfZ2VuZXJhbF9wcm90ZWN0aW9uKQ0KPiA+
ICAJY29uZF9sb2NhbF9pcnFfZGlzYWJsZShyZWdzKTsNCj4gPiAgfQ0KPiA+ICANCj4gPiArI2lm
ZGVmIENPTkZJR19YODZfU0hBRE9XX1NUQUNLDQo+ID4gK3N0YXRpYyBjb25zdCBjaGFyICogY29u
c3QgY29udHJvbF9wcm90ZWN0aW9uX2VycltdID0gew0KPiA+ICsJInVua25vd24iLA0KPiA+ICsJ
Im5lYXItcmV0IiwNCj4gPiArCSJmYXItcmV0L2lyZXQiLA0KPiA+ICsJImVuZGJyYW5jaCIsDQo+
ID4gKwkicnN0b3Jzc3AiLA0KPiA+ICsJInNldHNzYnN5IiwNCj4gPiArCSJ1bmtub3duIiwNCj4g
PiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBERUZJTkVfUkFURUxJTUlUX1NUQVRFKGNwZl9yYXRl
LA0KPiA+IERFRkFVTFRfUkFURUxJTUlUX0lOVEVSVkFMLA0KPiA+ICsJCQkgICAgICBERUZBVUxU
X1JBVEVMSU1JVF9CVVJTVCk7DQo+ID4gKw0KPiA+ICsvKg0KPiA+ICsgKiBXaGVuIGEgY29udHJv
bCBwcm90ZWN0aW9uIGV4Y2VwdGlvbiBvY2N1cnMsIHNlbmQgYSBzaWduYWwgdG8NCj4gPiB0aGUg
cmVzcG9uc2libGUNCj4gPiArICogYXBwbGljYXRpb24uICBDdXJyZW50bHksIGNvbnRyb2wgcHJv
dGVjdGlvbiBpcyBvbmx5IGVuYWJsZWQgZm9yDQo+ID4gdXNlciBtb2RlLg0KPiA+ICsgKiBUaGlz
IGV4Y2VwdGlvbiBzaG91bGQgbm90IGNvbWUgZnJvbSBrZXJuZWwgbW9kZS4NCj4gPiArICovDQo+
IA0KPiBQbGVhc2UgbW92ZSB0aGF0IGxhc3Qgc2VudGVuY2UgdG8gdGhlIGNvZGUgd2hpY2ggZW5m
b3JjZXMgdGhhdA0KPiBleHBlY3RhdGlvbi4NCg0KT2suDQoNCj4gDQo+ID4gK0RFRklORV9JRFRF
TlRSWV9FUlJPUkNPREUoZXhjX2NvbnRyb2xfcHJvdGVjdGlvbikNCj4gPiArew0KPiA+ICsJc3Ry
dWN0IHRhc2tfc3RydWN0ICp0c2s7DQo+ID4gKw0KPiA+ICsJaWYgKCF1c2VyX21vZGUocmVncykp
IHsNCj4gPiArCQlkaWUoImtlcm5lbCBjb250cm9sIHByb3RlY3Rpb24gZmF1bHQiLCByZWdzLA0K
PiA+IGVycm9yX2NvZGUpOw0KPiA+ICsJCXBhbmljKCJVbmV4cGVjdGVkIGtlcm5lbCBjb250cm9s
IHByb3RlY3Rpb24NCj4gPiBmYXVsdC4gIE1hY2hpbmUgaGFsdGVkLiIpOw0KPiA+ICsJfQ0KPiAN
Cj4gcy8gIE1hY2hpbmUgaGFsdGVkLi8vDQo+IA0KPiBJIHRoaW5rIHRoZXknbGwgZ2V0IHRoZSBw
b2ludCB3aGVuIHRoZXkgc2VlICJrZXJuZWwgcGFuaWMiLg0KDQpPay4NCg0KPiANCj4gPiArDQo+
ID4gKwljb25kX2xvY2FsX2lycV9lbmFibGUocmVncyk7DQo+ID4gKw0KPiA+ICsJaWYgKCFjcHVf
ZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX1NIU1RLKSkNCj4gPiArCQlXQVJOX09OQ0UoMSwg
IkNvbnRyb2wgcHJvdGVjdGlvbiBmYXVsdCB3aXRoIENFVCBzdXBwb3J0DQo+ID4gZGlzYWJsZWRc
biIpOw0KPiA+ICsNCj4gPiArCXRzayA9IGN1cnJlbnQ7DQo+ID4gKwl0c2stPnRocmVhZC5lcnJv
cl9jb2RlID0gZXJyb3JfY29kZTsNCj4gPiArCXRzay0+dGhyZWFkLnRyYXBfbnIgPSBYODZfVFJB
UF9DUDsNCj4gPiArDQo+ID4gKwkvKg0KPiA+ICsJICogUmF0ZWxpbWl0IHRvIHByZXZlbnQgbG9n
IHNwYW1taW5nLg0KPiA+ICsJICovDQo+ID4gKwlpZiAoc2hvd191bmhhbmRsZWRfc2lnbmFscyAm
JiB1bmhhbmRsZWRfc2lnbmFsKHRzaywgU0lHU0VHVikgJiYNCj4gPiArCSAgICBfX3JhdGVsaW1p
dCgmY3BmX3JhdGUpKSB7DQo+ID4gKwkJdW5zaWduZWQgbG9uZyBzc3A7DQo+ID4gKwkJaW50IGNw
Zl90eXBlOw0KPiA+ICsNCj4gPiArCQljcGZfdHlwZSA9IGFycmF5X2luZGV4X25vc3BlYyhlcnJv
cl9jb2RlLA0KPiA+IEFSUkFZX1NJWkUoY29udHJvbF9wcm90ZWN0aW9uX2VycikpOw0KPiANCj4g
SXNuJ3QgJ2Vycm9yX2NvZGUnIGdlbmVyYXRlZCBieSB0aGUgaGFyZHdhcmU/ICBJcyB0aGlzIGRl
ZmVuZGluZw0KPiBhZ2FpbnN0DQo+IHVzZXJzcGFjZSB3aGljaCBjYW4gc29tZWhvdyBnZXQgdHJp
Z2dlciB0aGlzIHdpdGggYW4gYXJiaXRyYXJ5DQo+ICdlcnJvcl9jb2RlJz8NCj4gDQo+IEknbSBh
bHNvIG5vdCBzdXJlIEkgbGlrZSB1c2luZyBhcnJheV9pbmRleF9ub3NwZWMoKSBhcyB0aGUgKm9u
bHkqDQo+IGJvdW5kcw0KPiBjaGVja2luZyBvbiB0aGUgYXJyYXkuICBJcyB0aGF0IHRoZSB3YXkg
Zm9sa3MgYXJlIHVzaW5nIGl0IHRoZXNlDQo+IGRheXM/DQoNClllYSwgSSB3YXMgd29uZGVyaW5n
IGFib3V0IHRoYXQgdG9vLiBJdCBsb29rcyBsaWtlIGl0IGNhbWUgZnJvbSB0aGlzDQpjb21tZW50
Og0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIxMDIwNDEyMDEuQzJCOTNGOEQ4QUBr
ZWVzY29vay8NCi4uLndoaWNoIGRpZG4ndCByYWlzZSBhbnkgc3BlY3VsYXRpb24gY29uY2VybnMu
IFdoYXQgaXQgZG9lcyBkbyB0aG91Z2gsDQppcyBtYXNzYWdlIHRoZSBpbmRleCB0byAwIGlmIGl0
IGlzIG91dCBvZiBib3VuZHMsIGxlYWRpbmcgdG8gdGhlDQoidW5rbm93biIgbWVzc2FnZSBiZWlu
ZyBzZWxlY3RlZCBmb3Igb3V0IG9mIGJvdW5kcyBlcnJvciBjb2Rlcy4gSWYNCnRoYXQncyB0aGUg
cHVycG9zZSB0aG91Z2gsIEknbSBub3Qgc3VyZSB3aHkgInVua25vd24iIGlzIGFsc28gdGhlIGxh
c3QNCmVsZW1lbnQgb2YgdGhlIGFycmF5IHRob3VnaC4NCg0KSSB0aGluayBtYXliZSB0aGlzIHdp
bGwgbm90IHR5cGljYWxseSBiZSBhIGZhc3QgcGF0aCwgYW5kIHNvDQpjb25kaXRpb25hbCBsb2dp
YyB3b3VsZCBiZSBlYXNpZXIgdG8gcmVhZCBhbmQgYmV0dGVyIG9uIGJhbGFuY2UuDQoNCkknbSBu
b3cgcmVhbGl6aW5nIHRoYXQgdGhpcyBpcyBtaXNzaW5nIHRoZSAiRU5DTCIgZXJyb3IgY29kZSBi
aXQgKDE1KQ0Kd2hpY2ggZGVub3RlcyAjQ1AgZHVyaW5nIGVuY2xhdmUgZXhlY3V0aW9uLg0KDQo+
IEV2ZW4gdGhlIGNvbW1lbnQgYWJvdmUgaXQgaGFzIGEgcGF0dGVybiBsaWtlIHRoaXM6DQo+IA0K
PiA+ICAqICAgICBpZiAoaW5kZXggPCBzaXplKSB7DQo+ID4gICogICAgICAgICBpbmRleCA9IGFy
cmF5X2luZGV4X25vc3BlYyhpbmRleCwgc2l6ZSk7DQo+ID4gICogICAgICAgICB2YWwgPSBhcnJh
eVtpbmRleF07DQo+ID4gICogICAgIH0NCj4gDQo+IA0KPiA+ICsJCXJkbXNybChNU1JfSUEzMl9Q
TDNfU1NQLCBzc3ApOw0KPiA+ICsJCXByX2VtZXJnKCIlc1slZF0gY29udHJvbCBwcm90ZWN0aW9u
IGlwOiVseCBzcDolbHgNCj4gPiBzc3A6JWx4IGVycm9yOiVseCglcykiLA0KPiA+ICsJCQkgdHNr
LT5jb21tLCB0YXNrX3BpZF9ucih0c2spLA0KPiA+ICsJCQkgcmVncy0+aXAsIHJlZ3MtPnNwLCBz
c3AsIGVycm9yX2NvZGUsDQo+ID4gKwkJCSBjb250cm9sX3Byb3RlY3Rpb25fZXJyW2NwZl90eXBl
XSk7DQo+ID4gKwkJcHJpbnRfdm1hX2FkZHIoS0VSTl9DT05UICIgaW4gIiwgcmVncy0+aXApOw0K
PiA+ICsJCXByX2NvbnQoIlxuIik7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJZm9yY2Vfc2lnX2Zh
dWx0KFNJR1NFR1YsIFNFR1ZfQ1BFUlIsICh2b2lkIF9fdXNlciAqKTApOw0KPiA+ICsJY29uZF9s
b2NhbF9pcnFfZGlzYWJsZShyZWdzKTsNCj4gPiArfQ0KPiA+ICsjZW5kaWYNCj4gPiArDQo+ID4g
IHN0YXRpYyBib29sIGRvX2ludDMoc3RydWN0IHB0X3JlZ3MgKnJlZ3MpDQo+ID4gIHsNCj4gPiAg
CWludCByZXM7DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9hc20tZ2VuZXJpYy9zaWdp
bmZvLmggYi9pbmNsdWRlL3VhcGkvYXNtLQ0KPiA+IGdlbmVyaWMvc2lnaW5mby5oDQo+ID4gaW5k
ZXggM2JhMTgwZjU1MGQ3Li4wODFmNGIzN2QyMmMgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS91
YXBpL2FzbS1nZW5lcmljL3NpZ2luZm8uaA0KPiA+ICsrKyBiL2luY2x1ZGUvdWFwaS9hc20tZ2Vu
ZXJpYy9zaWdpbmZvLmgNCj4gPiBAQCAtMjQwLDcgKzI0MCw4IEBAIHR5cGVkZWYgc3RydWN0IHNp
Z2luZm8gew0KPiA+ICAjZGVmaW5lIFNFR1ZfQURJUEVSUgk3CS8qIFByZWNpc2UgTUNEIGV4Y2Vw
dGlvbiAqLw0KPiA+ICAjZGVmaW5lIFNFR1ZfTVRFQUVSUgk4CS8qIEFzeW5jaHJvbm91cyBBUk0g
TVRFIGVycm9yICovDQo+ID4gICNkZWZpbmUgU0VHVl9NVEVTRVJSCTkJLyogU3luY2hyb25vdXMg
QVJNIE1URSBleGNlcHRpb24gKi8NCj4gPiAtI2RlZmluZSBOU0lHU0VHVgk5DQo+ID4gKyNkZWZp
bmUgU0VHVl9DUEVSUgkxMAkvKiBDb250cm9sIHByb3RlY3Rpb24gZmF1bHQgKi8NCj4gPiArI2Rl
ZmluZSBOU0lHU0VHVgkxMA0KPiA+ICANCj4gPiAgLyoNCj4gPiAgICogU0lHQlVTIHNpX2NvZGVz
DQo+IA0KPiANCg==
