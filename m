Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E5567F34F
	for <lists+linux-arch@lfdr.de>; Sat, 28 Jan 2023 01:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjA1AvM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Jan 2023 19:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjA1AvK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Jan 2023 19:51:10 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495FE7D2AC;
        Fri, 27 Jan 2023 16:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674867068; x=1706403068;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZcfTGC1EEdG9DgPCBYXJNOJiZZXC91zvRLthmynGjPA=;
  b=Ne4uzQFgsPh4guv/dmTs1pWsFbbb1HXggWA/uCJEk4LBFRWZGRrwPrEy
   1u21MQ+Rsver5KTxH5LBhitcYoKPi/7Dnl03JESxnhTPxYPQsOcQMv4fq
   /Ev3uJ4brJsxcRhtw4xn52GW19x4jkvuhwykEf4Gajn6cTGUdlOMs+8ge
   Ctba0nIKrJznNbJAAE0gbloy3XBQ+wmZuRf4hyBiEBYTG+xz1LU41quaA
   agbRlxa8eziccYnCLygREUxj/LzNc0U6RA+lCVv1sNrKJWA0bSIj9bN3Y
   lM7z9xMF3+7Oxlap2nJlYX0ksvfQ2rIo/uHl5IorbWvnvvD/Cm2H2sBEE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="413459099"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="413459099"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 16:51:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="613382077"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="613382077"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 27 Jan 2023 16:51:07 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 16:51:06 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 27 Jan 2023 16:51:06 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 27 Jan 2023 16:51:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKJjSIr748wuuq4t04A95PnKBYjXBjQu70oQSV3AQXXGF7nY3W9L02fjx0cH3shJ1NH4r5+EBgYwReKgZmtTZbv4slXQ3lo8y0E9+2lsOP/Vh82wM1g3mFRe3s1vr5++qyWhKRc8PcHCF0Y3KdvAKbeIQSGV2AZVsVUFYM3RUwtsD9vqc66zGiFp4P+TeGpX9mkNHrfE7tuCRokqou1YeTUsjhJIhFBy+s3ImkpCbtrpf3LolqrMeWlGxWIZJa0nOyMEuj/JCfR00ROzVl4nA65luaj6ngXgOHUVQnHRee0eUZ0LrLmrYireU1O5uSlu9n3N4LUY8XyegLJLqjW/BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcfTGC1EEdG9DgPCBYXJNOJiZZXC91zvRLthmynGjPA=;
 b=TdL0kB08i2YmjLv2+CKVxv06GTQGAnZ9VJ0RUWqzA7Mn/haKhsIXNrAGIC+uQKyzhxICjBjnDWY56hY5YWeTjJ4Af+RXqTVImUb+GmoeS9pYtASgGVFBcRpW4XiqJQcc4J1ZG9gZ7IvqMJOEWAUc1DcVCydyqA4MxKlpqehhleDhC/ZguQVbQ2Q9QOq6wtHFDCO+XPtygg5OlGsBGjOMvYyPd61g5udzLNKUsWqsHLhllPgEMm8LZtrNYOfw0fzdKGouD9sZnQSHuvg8og+WsG/FRB+m5Wfj1mP0eko8bkmvtYdBDfoVFXv7t3E3tsnFILgO7kY5tayEVkg5UgaElg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SA2PR11MB4809.namprd11.prod.outlook.com (2603:10b6:806:112::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Sat, 28 Jan
 2023 00:51:01 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6043.023; Sat, 28 Jan 2023
 00:51:01 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
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
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v5 18/39] mm: Handle faultless write upgrades for shstk
Thread-Topic: [PATCH v5 18/39] mm: Handle faultless write upgrades for shstk
Thread-Index: AQHZLExgp79hLxaTJUWnXCRef2z2Ua6rx5SAgAC3h4CAAUjWAIAAHt0AgAD++ACAAJuKAIAAaOSAgACChICAAMGNAIABTW0AgACQ4gA=
Date:   Sat, 28 Jan 2023 00:51:00 +0000
Message-ID: <6a38779c1539c2bcfeb6bc8251ed04aa9b06802e.camel@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
         <20230119212317.8324-19-rick.p.edgecombe@intel.com>
         <7f63d13d-7940-afb6-8b25-26fdf3804e00@redhat.com>
         <50cf64932507ba60639eca28692e7df285bcc0a7.camel@intel.com>
         <1327c608-1473-af4f-d962-c24f04f3952c@redhat.com>
         <8c3820ae1448de4baffe7c476b4b5d9ba0a309ff.camel@intel.com>
         <4d224020-f26f-60a4-c7ab-721a024c7a6d@redhat.com>
         <dd06b54291ad5721da392a42f2d8e5636301ffef.camel@intel.com>
         <899d8f3baaf45b896cf335dec2143cd0969a2d8a.camel@intel.com>
         <ad7d94dd-f0aa-bf21-38c3-58ef1e9e46dc@redhat.com>
         <27b141c06c37da78afca7214ec7efeaf730162d9.camel@intel.com>
         <f4b62ed9-21a9-4b23-567e-51b339a643ac@redhat.com>
In-Reply-To: <f4b62ed9-21a9-4b23-567e-51b339a643ac@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SA2PR11MB4809:EE_
x-ms-office365-filtering-correlation-id: b60ae6ef-b274-4c51-82d7-08db00c9b9f1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rUX5f+EKo6uTfBAG+0kqNLs9y7VrouWcWaGZgaubZ/YNGJl++OGVD5tNscG1a7496LCI1aoagZLPwSHyQW5i2JpKwEHc6tIzC3hpacRAdPqBqNPYYkQKTa/SAM6csPD1G0SOWMJEWjnXr+KjhUlMNHez63ivDeM+nrYq+Vtl3M2VwYxk4uqxnqTn3nz1Ul5cLxMTAgbSC/wPtQqdrUOsy9qIPZ6wKm28NpDWd+yyJMhW53QNuYN6Jco9w4lTEvtcSTklmPl8vsB8R9dRP2ZWNUTrg6EMjztZEKl1SddGr1M7ec1N5H8MGKW/htyBSTq9kaabTw1HskvBYAip9OOI7nXSBMJftryhfBWhz0pnSBS1S2xpmTs/X8i6mTV9LpMGbbDL9oOf7DKbLLHgFabuYv5ftCzNTLUl6j0UZhiSwGujEBvkmGjP6urcTkTEQQFPLnrXFtSFw8z+ucfXOK4FJCCq6o9d+5n0PN/2RrnW36fQ9tXqT1q+/NKo6O0cpBwXwfFYIaarLc63IBA0WKGKhXzlKrs9klOkznB4JGMFF6p06LOTPp4lT0u4pvXq9ZP3tesM2CLcFC24lEwSfMLpdkMEnYy47H7Y+JI/b6b+qljMDfT38ffFfiHm1u2gY/OvzhCpt1qpy9/n7zVoGzXjb+AXJxAFQOje3paPs1plT/W0DDhCncSlUGPeqaDLOIgySSgmyg9oQC7i9PBVaXEz/5caGbEOff7+Z5L8syxKIWd+jpW/tff8WlE/oQ+7v4vC5gmWoPAAWNpf1z2z9mLAhA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199018)(110136005)(38100700002)(8936002)(2906002)(38070700005)(5660300002)(7406005)(921005)(83380400001)(36756003)(82960400001)(4326008)(86362001)(7416002)(41300700001)(122000001)(6486002)(8676002)(66476007)(66446008)(478600001)(71200400001)(26005)(91956017)(53546011)(66946007)(186003)(64756008)(66556008)(6506007)(316002)(2616005)(76116006)(6512007)(99106002)(17423001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTU3MVo4OVhKdFV1R094ckJMb1RBTkVvU1NMWDYxL1BrMENsb3VnNm9IdE45?=
 =?utf-8?B?VHpEQUFrQlRONGdOOFdUcVExTXh4ek9uZDhUSisvdE4xU2Iya2RIQW5yRTlM?=
 =?utf-8?B?MGNZUU13cUxoMmpnQlE5alFwTjZUNUV3TEJzMkZpS2Y4aHRjMEphOE1oN3Jk?=
 =?utf-8?B?NTdreGo2UDVpZmt6eWgwTjcyUG5QcjVBQXRiU0VtVW8yU1B5UnhST0g3TWFM?=
 =?utf-8?B?UnQ3dDlwemhmbFRZWEZsSXpzVy9uQnlQQXZyNjRwQUpmNHIxbzNITWJobWJE?=
 =?utf-8?B?K1QwWHNYekR1QVRmTUEwbXpNMnlhWXBMTFczTGdtS1psS29LUkUxQU4ybmV2?=
 =?utf-8?B?RzJuUFR1cGJjaXIxZGVMZGRYTlNMdTdwdjZsNTdCRUpPcDRtMDU0QnNiekd6?=
 =?utf-8?B?dXVVNVV2dllEM2lPOVpvR2l3RnR1QXAxMHVLbVNwaWdiU3FmT0dNdi85c1JN?=
 =?utf-8?B?dHhVNGtaVjhBKzBObWtvYlNLa0p0UHFhWXAzSC8zcStmakFCSURlTnJlcy9W?=
 =?utf-8?B?Tk9Zc29NMTVCb3lWM3M2SUdKNXhmSnFPMFdzRHZMd3Z5RVJ4NTZIcmFQdWtz?=
 =?utf-8?B?dUJseWo1WThBTHRZaFowNkwvalF1d1QwRnA0b0MxK1Y3bnB0UTdERGlWdndX?=
 =?utf-8?B?TTlRL1kvK3VtRVhta2Z6cHBubVVqRHNzWnpxY2llcFJlcy9kMXpybCtmMTJ1?=
 =?utf-8?B?WURuVW51RlhiaTQvK25hYzg1dFVJMXpETEdUNmFWc2ZBRlViSjkzOVM0Rkpo?=
 =?utf-8?B?cStSK3RERldCOWc1R2pNd0w5b2E0Vks0UHIvb0RVVkRQSjdUZnJJdFhiQ1dr?=
 =?utf-8?B?WGd0ajdzS0Z0enFkMzBHVnlmUkVlVDUyV1NpcGdpcHVINXFGcVNBdzNidjg2?=
 =?utf-8?B?R0hSVjZiamVzbnRHb21mek9nRitNNXFFT2l1Sk8vaHNCbDNJdDRERlRhbGYw?=
 =?utf-8?B?UmFlN05Tb1lYb2xWbUNPdVZ1T0VHQzAvUFpkb0Zua052NHlaeFBxdElFckg5?=
 =?utf-8?B?NVozYjJmWXhiNkMrYnlVRSs4Y3NJcDZraHJFOXU5TnlDdTd0c2tpNlZaSGFX?=
 =?utf-8?B?ZU9nOHN6S0N4RzN6bXl4MkVaYnREU3Q5ZW9wbXlZalROUWxpYW1aczZXWE9J?=
 =?utf-8?B?UGRZaEwrdDNXSm03Q3JiRHkyRFN2bFNVMEE1TnM2WXRjbFhZNmtlNEo0S0lx?=
 =?utf-8?B?VklaSCtkR0ZVWHJ5NW1pcXRMRmFna3ZsRUt3dGlkbyswRFJPZm9PNHhEVkRy?=
 =?utf-8?B?c0s0Tm9uc2JLWEwwN0dtbEVxRHZqNTROb2pydTh3NlVObGU5V1d6d29jb2tT?=
 =?utf-8?B?YjhlWE9wTXExczdLbmJzd0ZPMldmTkZjeHV5dU1kNUlVQktqaFBWMDFhQUNQ?=
 =?utf-8?B?WVdKQnVvcktXWW9pRlRIa3RPNUwwa2tyZ29lK1ZGeFY5S1ZVMDJoRGgrL3JK?=
 =?utf-8?B?NDcwMi9IWTB0d3NMMFROcUJHWTh6Ly9HM2FicS9vNDl4U0dzN21WSUFVamxO?=
 =?utf-8?B?Q0UrMkZsQ2FDZzllaXRjOW1GaXpNdit6N3FxaW8rakJlQW9aYkhJOHREVjA3?=
 =?utf-8?B?b0pyQkZlUHlqcFdvOW1LQTF1T3RWZEpUeHN4MXEySk81MUdXZVNFbXV6VVZ0?=
 =?utf-8?B?amp4SG5HRFNSMlNXaDVpYThZSXdtQ2xlVzg3b1VuaDdScW8vUjdZbnFVOGtB?=
 =?utf-8?B?MkxOQkpVUTErOHZzTlVnYmFFaXNwUVo0bXU4aUJkbFdRWkRhd21HWVVEQ2ZR?=
 =?utf-8?B?ODAydDlVZHlkeFZHcXJlU1NTSFZKSlNNdUMydGxsR0doODVlbTJmaFVKamkw?=
 =?utf-8?B?TmlzUzUxYUZPeUlrOUwvS2ZjQTM0WEFFRG9KYjBCYng1RElqSUQzR3BWc25G?=
 =?utf-8?B?LzhNNzh1S0VDT0cvVEM5cDRnOXR3dlRhQzEyekZUc1FmS0dMNzI0Y1hYai8x?=
 =?utf-8?B?Y291VmcrL1JGUHZmMFluWHZkbVVleGRpeERqYi9Mam1jbTJxMnFBRnAvQzJt?=
 =?utf-8?B?Wlo4Y1RmcDRZN3NNbkhld0IyVkpsbXhnb0NvR3VUa2pIRW8yUkRtZEFSOGtw?=
 =?utf-8?B?WEVPak9tYmpXU2QyUTB5Sm5JSGhFY3JSRmVIdGdiOWVKL0VGSmkvRlMwSWdQ?=
 =?utf-8?B?VFp4b052S0Q3Q05VMmZRRW03UzdNTEM4YTdMRlhxMVlPYm12YVlXVjVyMUVP?=
 =?utf-8?Q?uuQ2Rksu931t4bGXNQNbwoc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89E5DA60F1980E40AA2F0552037D73F3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b60ae6ef-b274-4c51-82d7-08db00c9b9f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2023 00:51:01.0627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JrmaO0zaz+uyzP7vecbU8MM8QFJ/IRQBS0Cwz9tT7atdVsDN3d1xFMkbiWE6w/nxjWxEoGhFubDsT5XTv3+B4/6X+wXnm4nMt4ofbVY1rEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4809
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIzLTAxLTI3IGF0IDE3OjEyICswMTAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gT24gMjYuMDEuMjMgMjE6MTksIEVkZ2Vjb21iZSwgUmljayBQIHdyb3RlOg0KPiA+IE9u
IFRodSwgMjAyMy0wMS0yNiBhdCAwOTo0NiArMDEwMCwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6
DQo+ID4gPiBPbiAyNi4wMS4yMyAwMTo1OSwgRWRnZWNvbWJlLCBSaWNrIFAgd3JvdGU6DQo+ID4g
PiA+IE9uIFdlZCwgMjAyMy0wMS0yNSBhdCAxMDo0MyAtMDgwMCwgUmljayBFZGdlY29tYmUgd3Jv
dGU6DQo+ID4gPiA+ID4gVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzIGFuZCBpZGVhcyBoZXJlLCBJ
J2xsIGdpdmUgdGhlOg0KPiA+ID4gPiA+IHB0ZV90IHB0ZV9ta3dyaXRlKHN0cnVjdCB2bV9hcmVh
X3N0cnVjdCAqdm1hLCBwdGVfdCBwdGUpDQo+ID4gPiA+ID4gLi4uc29sdXRpb24gYSB0cnkuDQo+
ID4gPiA+IA0KPiA+ID4gPiBXZWxsLCBpdCB0dXJucyBvdXQgdGhlcmUgYXJlIHNvbWUgcHRlX21r
d3JpdGUoKSBjYWxsZXJzIGluDQo+ID4gPiA+IG90aGVyDQo+ID4gPiA+IGFyY2gncw0KPiA+ID4g
PiB0aGF0IG9wZXJhdGUgb24ga2VybmVsIG1lbW9yeSBhbmQgZG9uJ3QgaGF2ZSBhIFZNQS4gU28g
aXQNCj4gPiA+ID4gbmVlZGVkIGENCj4gPiA+ID4gbmV3DQo+ID4gPiANCj4gPiA+IFdoeSBub3Qg
cGFzcyBpbiBOVUxMIGFzIFZNQSB0aGVuIGFuZCBkb2N1bWVudCB0aGUgc2VtYW50aWNzPyBUaGUN
Cj4gPiA+IGxlc3MNCj4gPiA+IHNpbWlsYXJseSBuYW1lZCBidXQgc2xpZ2h0bHkgZGlmZmVyZW50
IGZ1bmN0aW9ucywgdGhlIGJldHRlciA6KQ0KPiA+IA0KPiA+IEhtbS4gVGhlIHg4NiBhbmQgZ2Vu
ZXJpYyB2ZXJzaW9ucyBzaG91bGQgcHJvYmFibHkgaGF2ZSB0aGUgc2FtZQ0KPiA+IHNlbWFudGlj
cywgc28gdGhlbiBpZiB5b3UgcGFzcyBhIE5VTEwsIGl0IHdvdWxkIGRvIGEgcmVndWxhcg0KPiA+
IHB0ZV9ta3dyaXRlKCkgSSBndWVzcz8NCj4gPiANCj4gPiBJIHNlZSBhbm90aGVyIGJlbmVmaXQg
b2YgcmVxdWlyaW5nIHRoZSB2bWEgYXJndW1lbnQsIHN1Y2ggdGhhdCByYXcNCj4gPiBwdGVfbWt3
cml0ZSgpcyBhcmUgbGVzcyBsaWtlbHkgdG8gYXBwZWFyIGluIGNvcmUgTU0gY29kZS4gQnV0IEkN
Cj4gPiB0aGluaw0KPiA+IHRoZSBOVUxMIGlzIGF3a3dhcmQgYmVjYXVzZSBpdCdzIG5vdCBvYnZp
b3VzLCB0byBtZSBhdCBsZWFzdCwgd2hhdA0KPiA+IHRoZQ0KPiA+IGltcGxpY2F0aW9ucyBvZiB0
aGF0IHNob3VsZCBiZS4NCj4gPiANCj4gPiBTbyBpdCB3aWxsIGJlIGNvbmZ1c2luZyB0byByZWFk
IGluIHRoZSBOVUxMIGNhc2VzIGZvciB0aGUgb3RoZXINCj4gPiBhcmNocy4NCj4gPiBXZSBhbHNv
IGhhdmUgc29tZSB3YXJuaW5ncyB0byBjYXRjaCBtaXNzIGNhc2VzIGluIHRoZSBQVEUgdGVhciBk
b3duDQo+ID4gY29kZSwgc28gdGhlIHNjZW5hcmlvIG9mIG5ldyBjb2RlIGFjY2lkZW50YWxseSBt
YXJraW5nIHNoYWRvdyBzdGFjaw0KPiA+IFBURXMgYXMgd3JpdGFibGUgaXMgbm90IHRvdGFsbHkg
dW5jaGVja2VkLg0KPiA+IA0KPiA+IFRoZSB0aHJlZSBmdW5jdGlvbnMgdGhhdCBkbyBzbGlnaHRs
eSBkaWZmZXJlbnQgdGhpbmdzIGFyZToNCj4gPiANCj4gPiBwdGVfbWt3cml0ZSgpOg0KPiA+IE1h
a2VzIGEgUFRFIGNvbnZlbnRpb25hbGx5IHdyaXRhYmxlLCBvbmx5IHRha2VzIGEgUFRFLiBWZXJ5
IGNsZWFyDQo+ID4gdGhhdA0KPiA+IGl0IGlzIGEgbG93IGxldmVsIGhlbHBlciBhbmQgd2hhdCBp
dCBkb2VzLg0KPiA+IA0KPiA+IG1heWJlX21rd3JpdGUoKToNCj4gPiBNaWdodCBtYWtlIGEgUFRF
IHdyaXRhYmxlIGlmIHRoZSBWTUEgYWxsb3dzIGl0Lg0KPiA+IA0KPiA+IHB0ZV9ta3dyaXRlX3Zt
YSgpOg0KPiA+IE1ha2VzIGEgUFRFIHdyaXRhYmxlIGluIGEgc3BlY2lmaWMgd2F5IGRlcGVuZGlu
ZyBvbiB0aGUgVk1BDQo+ID4gDQo+ID4gSSB3b25kZXIgaWYgdGhlIG5hbWUgcHRlX21rd3JpdGVf
dm1hKCkgaXMgbWF5YmUganVzdCBub3QgY2xlYXINCj4gPiBlbm91Z2guDQo+ID4gSXQgdGFrZXMg
YSBWTUEsIHllcywgYnV0IHdoYXQgZG9lcyBpdCBkbyB3aXRoIGl0Pw0KPiA+IA0KPiA+IFdoYXQg
aWYgaXQgd2FzIGNhbGxlZCBwdGVfbWt3cml0ZV90eXBlKCkgaW5zdGVhZD8gU29tZSBhcmNoJ3Mg
aGF2ZQ0KPiA+IGFkZGl0aW9uYWwgdHlwZXMgb2Ygd3JpdGFibGUgbWVtb3J5IGFuZCB0aGlzIGZ1
bmN0aW9uIGNyZWF0ZXMgdGhlbS4NCj4gPiBPZg0KPiA+IGNvdXJzZSB0aGV5IGFsc28gaGF2ZSB0
aGUgbm9ybWFsIHR5cGUgb2Ygd3JpdGFibGUgbWVtb3J5LCBhbmQNCj4gPiBwdGVfbWt3cml0ZSgp
IGNyZWF0ZXMgdGhhdCBsaWtlIHVzdWFsLiBEb2Vzbid0IGl0IHNlZW0gbW9yZQ0KPiA+IHJlYWRh
YmxlPw0KPiANCj4gVGhlIGlzc3VlIGlzLCB0aGUgbW9yZSB2YXJpYW50cyB3ZSBwcm92aWRlIHRo
ZSBlYXNpZXIgaXQgaXMgdG8gbWFrZSANCj4gbWlzdGFrZXMgYW5kIGludHJvZHVjZSBuZXcgYnVn
Z3kgY29kZS4NCj4gDQo+IEl0J3MgdGVtcHRpbmcgdG8gc2ltcGx5IHVzZSBwdGVfbWt3cml0ZSgp
IGFuZCBjYWxsIGl0IGEgZGF5LCB3aGVyZSANCj4gcGVvcGxlIGFjdHVhbGx5IHNob3VsZCB1c2Ug
cHRlX21rd3JpdGVfdm1hKCkuDQo+IA0KPiBUaGVuLCB0aGV5IGF0IGxlYXN0IGhhdmUgdG8gaW52
ZXN0aWdhdGUgd2hhdCB0byBkbyBhYm91dCB0aGUgc2Vjb25kDQo+IFZNQSANCj4gcGFyYW1ldGVy
Lg0KDQpPaywgSSdsbCBnaXZlIGl0IGEgc3Bpbi4gU28gZmFyIGl0IGxvb2tzIG9rLiBUaGUgZG93
bnNpZGUgaXMgdGhlIGdpYW50DQp0cmVlLXdpZGUgcHRlX21rd3JpdGUoKSBzaWduYXR1cmUgY2hh
bmdlLCBidXQgb25jZSB0aGF0IGlzIG92ZXIgd2l0aA0KdGhlcmUgYXJlIG90aGVyIGFkdmFudGFn
ZXMuIExpa2UgZ2V0dGluZyByaWQgb2YgbWF5YmVfbWt3cml0ZSgpJ3MNCmF3YXJlbmVzcyBvZiBz
aGFkb3cgc3RhY2sgc28gdGhlIGxvZ2ljIGlzIG1vcmUgY2VudHJhbGl6ZWQuIFBsZWFzZSBsZXQN
Cm1lIGtub3cgaWYgeW91IGRvbid0IGZlZWwgY29tZm9ydGFibGUgd2l0aCBhIHN1Z2dlc3RlZC1i
eSBjcmVkaXQgdGFnLg0KDQpUaGFua3MsDQpSaWNrDQo=
