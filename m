Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE5E744F8F
	for <lists+linux-arch@lfdr.de>; Sun,  2 Jul 2023 20:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjGBSD6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 2 Jul 2023 14:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjGBSD5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 2 Jul 2023 14:03:57 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9479F9B;
        Sun,  2 Jul 2023 11:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688321035; x=1719857035;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=P+kStWn8Gn8PCsJXNmKEEvyKLL49Rg0INvzkxeDvQT4=;
  b=DTI5mLCT4e983a8QWeXyDU+nvbYgCvEpe5uO0URVjL7SroOAz+QP6xaL
   TLDoXonF/h6nOLK1LfIkL2px6iegzZM9v1+q2m4/A0hJTPmKjT/NKWSr9
   nu0opxKbfYA4QGS7wwIJdM4CNZQ5fvx3eOqkDmvLzpEurVMWhu4vs4Asn
   TEqup4QcimWaCjp6x4d9zH1imz5UJbTDO+2EfOWgoAOEUh3uyTm6842GV
   iX7hAxMjB46uwTiRPcP+zXmDu9LTDXNKmADgOU3lvNKdySVOmZpUkV6NO
   9dMiqoUyQwIqPJcW1sAZryn0bWiuLNQK3oL2z/NG/0HhjIIac9VUN0hyl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="393463606"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="393463606"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2023 11:03:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="964935329"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="964935329"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jul 2023 11:03:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 2 Jul 2023 11:03:53 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 2 Jul 2023 11:03:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 2 Jul 2023 11:03:53 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 2 Jul 2023 11:03:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQ+rJ/6+Aa2/KZyn8Wm934UtLSSgi5Cqe36X0K9scbxKratROXAovykKZDDviEFO95YbrlSGJbnPQOcdjPBHVorBaHlH/vTbv0D02qcJCXR6SpTDHqCAVYHKHT2u5L/sOJLFFCmy8syjYRRcNfn7oPZk0MDztgHHoj0ajrpTYdvJta1H592m2Yk0kcnE7ZZivHvqkRAo/zNJkg3CMctcLD9fSWwf0pF7Q+ju5kBiT1I8jGKTkNEYk7vmllXIha2wWOFspsYkpY9UIT8mUlYPJpwf9bgVXBf31UIlz03P53RLqfgB6gi7YMyodo9+V0GO0Uh0tGdCwxZOkEFppGZURw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+kStWn8Gn8PCsJXNmKEEvyKLL49Rg0INvzkxeDvQT4=;
 b=CatIJJrOU8s0gdXidbHe49imfpBmYx6MOWe38F0ulZd3KyXfplRu3Ne1ehBb/En3AHaeIznk1u3UlUWrKt8VfBb4idU1UJYe0ywZ9ZvGmvVSF0+OXKe3i8ATvPqUCkmXjD1W1pnDRbRJxbO+MbfukC8ELg6BywgJRPHtTuQ3uPkfDHopZ1mWBrYyIKsNuwbgkluz1zJJo56afLRiEznVam8B2t2m8Y91ZknE2VklXy9XU2V4LFrE3/tBDpVi9IKry86TuDT87YfE9OqZIcvF/emlTkZngoJBKHTlYHXiPaosYTfcZN2De2RBJmsjAtMq0qF83br4Mi0WNOqC5S+8nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH7PR11MB5981.namprd11.prod.outlook.com (2603:10b6:510:1e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Sun, 2 Jul
 2023 18:03:43 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6544.024; Sun, 2 Jul 2023
 18:03:43 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "Lutomirski, Andy" <luto@kernel.org>
CC:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Thread-Topic: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Thread-Index: AQHZnYvD++9jHqJtDEOZ5j0eN4/f+6+IoOQAgAALyMOAACwFgIAAIG6AgAAMtoCAACGsAIAA96CAgABofQCAB1K5gIAAhUGAgAEVRoCAAKx+AIABDK+AgAB6bICAAPF/AIAAZrmAgAAVNICAAG62AIAKh/oAgATXZwA=
Date:   Sun, 2 Jul 2023 18:03:42 +0000
Message-ID: <e057de9dd9e9fe48981afb4ded4b337e8a83fabf.camel@intel.com>
References: <ZJAWMSLfSaHOD1+X@arm.com>
         <5794e4024a01e9c25f0951a7386cac69310dbd0f.camel@intel.com>
         <ZJFukYxRbU1MZlQn@arm.com>
         <e676c4878c51ab4b6018c9426b5edacdb95f2168.camel@intel.com>
         <ZJLgp29mM3BLb3xa@arm.com>
         <c5ae83588a7e107beaf858ab04961e70d16fe32c.camel@intel.com>
         <ZJQR7slVHvjeCQG8@arm.com>
         <CALCETrW+30_a2QQE-yw9djVFPxSxm7-c2FZFwZ50dOEmnmkeDA@mail.gmail.com>
         <ZJR545en+dYx399c@arm.com>
         <1cd67ae45fc379fd82d2745190e4caf74e67499e.camel@intel.com>
         <ZJ2sTu9QRmiWNISy@arm.com>
In-Reply-To: <ZJ2sTu9QRmiWNISy@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH7PR11MB5981:EE_
x-ms-office365-filtering-correlation-id: eb84b92e-3cae-4792-d40b-08db7b26ac2b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8+xSNO0ivd4v34XZeUptJcG+a5PjmXGY3AzG9ytVH8A6gzYPUXR+FcVQk9KpIHZme/e1DrguxbkbnjBSsEohaRn0SwhBuL4hLUil0sB+Mnou8VqTr/2PCvW0pf7SbKwUfZyq+52VJx8yumEWkLp6LFDNFoqmMBPrzL65LJZY/1ggvaYuX9Wg4QTDCLcCyoT/HMqlGBJ4uj4rv6T0OfExQlp/H9SYjBKBQ3eSpYUGTet04Sh8zo1w1Jn8ZsNi4/Ty7CKZnN32Huc6vxjqdb4oS4Zoo5ey87KHgrVVXDnaYvT/wyRBI82x4dPUdmtHy39z/pKqcPkJWYNTRnjWYAIF6RhaghFBBKWCDfHcC+eTOx1OsA6kYVfUObdChKdwvvb3zmkhiCfdJQgGuZMcesXVX6E6FHRqGBJ30rfIel1lWau0dMO9Mt7sZf0eB/e9V6fNN2thcO4Gn7nfX7EkwEcdfWNsyq5ZJXj3Bk9coojCvN6umnPGbpcObtokad2KGUjeZ5LKP9B4A1ieBhjqM+S18hvAGtoXeojQQR0EfWJS+kgBT55ttHNzOAZfL/eRd2SnIiMi1b44u2mSX8T6iv8VzzQskV/eODaIn95z0Pmrto8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199021)(7406005)(7416002)(64756008)(66446008)(4326008)(91956017)(66476007)(66556008)(66946007)(76116006)(316002)(478600001)(2906002)(36756003)(8676002)(8936002)(66899021)(5660300002)(41300700001)(6512007)(966005)(86362001)(110136005)(54906003)(38070700005)(38100700002)(6486002)(30864003)(6506007)(26005)(186003)(82960400001)(71200400001)(83380400001)(122000001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0xsVDhzRHY3TEo2UmxJSVNSQmRUaHZHekxiWnhiSGNGaW9rVVFMSndBTS9F?=
 =?utf-8?B?Sk9jSVZFdDZMQlovYlpPQnRUV2R2MmJvdWZoaDl4RnM1SnN4dXFYaXhWZlpk?=
 =?utf-8?B?ajR3bVRDcVM0NUs1Mi9Xb25BdDhsUUt1L3VCa2NjSytuTC9FN3YwUlJoQXRR?=
 =?utf-8?B?RTBzbXI2R3Q3cThNR0RselhEWDY4bXlaNWpVcjVCRlZ0eEJnT2MvNkl3ZzhU?=
 =?utf-8?B?MVZmLzkwWnlmcmJXbXpQbzcwSzdkaE5VckF3K0t4VWFiT0lBMWJqQmdqNUIv?=
 =?utf-8?B?TzF4ci9mczhkMXg1ZmJycTB6RUZ1SmtobzFXdUx0bktMaUpNMFpWZ2hURThl?=
 =?utf-8?B?d0ZUT20zc1V1QnhlQko0TWVlZ0NBSDBocGVMWThDQTdiWmpSVjdsVjBjN0Jt?=
 =?utf-8?B?ejdjODIxdW9HdkVGbEhJM2xlbTJBOGpTWXczc0V3M1hUT1ltaEhlMzJuSFlt?=
 =?utf-8?B?OW12L0ViUk84N2JGREV1WlROU2VJUlRsbUMveXc0OWUzM3ZQdExEVWpDQWlh?=
 =?utf-8?B?TVU1djBRNjNaWnpFdDJHbWNVSmdwRFlLaWJUZk4yUEp3aTNTMDZMTGRYSlBI?=
 =?utf-8?B?Um9QTEFzQ3NZdnkxTldXcUtJMEtFa3NvNkwrbnJ2dTZKcFE2K3hTWEp6UE9p?=
 =?utf-8?B?N0hiaU1Wcld0ZmJEVmdYc1cvWTdaRCtHT3BHNm5kMFRRRUhWbU80UFFsQmJk?=
 =?utf-8?B?UDZ3Z0ZPOVhuUlVlNGxzdmlpM1pkTHFCdGJhelJWV210ZGhIekZGRitSRC96?=
 =?utf-8?B?dXZyamwzTjZOZXlCcEdOWWxxNVQvSE1nQ0x6Z2ZCTC8wQURXeHl3cVFqVVR5?=
 =?utf-8?B?ejhMSlJEUmwrWmFEVlI3elJYSng4dElZdTVENUNlT01COTZEYnQxbVNmSmJ5?=
 =?utf-8?B?eTFZTWNUcjlNVzNyclg2d0wzd1o2ZW1OV1RTS1Q1RU5LME9USm1xbVovakZD?=
 =?utf-8?B?azJ6QU1Kb29vUzBmNEs1QzQ3MHNOY1JPRGttbENvbjRjOHJnSDc5V2Z2MnBl?=
 =?utf-8?B?NjQxTnJLbjlSQnV5bHBzSnR2YVZ3SW9NZTFIc0tIcTY1Nm1SK1VDRWk5VHZp?=
 =?utf-8?B?eHlNUGw5bTI4bmpteGpjeWNuSjBGMHF5eStualJhcGw5amxyVGJxMXFiNzly?=
 =?utf-8?B?am1GWjBYSmdZcnE5eFRrb2xRQnc4WVpCencxUjlKenRSb1lUa29hZ0hSWjdq?=
 =?utf-8?B?d0RLTzgyRlBTWGI5d2lKc2FLelNkL0NYSGFPKytmV3BScGhpRTd5WTVZak1R?=
 =?utf-8?B?ZGhOSDY3aWlHNVRPbVhNMlBzbDR0aXUyQ2xZMmh3WThwanF2c2lJOWxkbTBU?=
 =?utf-8?B?Q2JxM3U5aVcraE5iM2E5Z3g5SGlHS2ZuTzQrZXV4b3dpc0lYb3kyVlhJOTdS?=
 =?utf-8?B?cGo1b25vOXBnYk1OeTAraWNKaDBpYUswYjcwMHo2NDdkM1dLaEpxNGVOaysz?=
 =?utf-8?B?OU1EaEtQZFQxZ0F5Um5XdmtROUg1bHBOcDRnSEdYREljUXFKL0JBYk52ai8z?=
 =?utf-8?B?R29kN0hRUlI0WFFid2I1OUVVaDdTTDJCRmw5VEpNRFFHYUk3QlZvYWZHcGsx?=
 =?utf-8?B?Qm5vdVN0aExjUGhYcUNuMDd5K1NQWmJRcXhTa0RxdUdEREJ2SEd4ZHZnVWRt?=
 =?utf-8?B?ZmRWWnhmVmR1R2hId1JGNnFoZzNYMHEzUFlOQys3QlJrWjRyOTJpU1hGdnpU?=
 =?utf-8?B?c0xJbzZwUHkwSEhwaWxJOEdZNzdaWUdDYnhZNVU2VDRVYXBmclQvYytML0xk?=
 =?utf-8?B?QkNjODUvSG96UHErNXpQUGQ2UTFnRHNtZStuVU15QkYwd0FSdXlqN3ZxTXEw?=
 =?utf-8?B?ZUNiNEpIRm8rQWFJYVRWNjczcjBJTnAzcStIdGZyQ3lJOEMxeTd4NHVDQUJ5?=
 =?utf-8?B?OFNyY2hMcE50TldOSzFzTHFQUmNHUTcvTlJLUEMrVlFKM1pBK1UrYlUrYjQw?=
 =?utf-8?B?R0pjaTBxTjF1bzlpQ1pPWk1yMDhPM3JpU3hzcVRGeFROOHJRL2czbGM2Ymxn?=
 =?utf-8?B?bUk0ZThXTmRUQ2Qxa2xXU294V0xOaWYvOWhRMEIwdGJtUitOMnJheW84bmVH?=
 =?utf-8?B?RmswWjZXVTN5aWk0ZDdFeS9qNjJmMWh4eUtZbEFCemFZSDFvWmNIdnpzMUpX?=
 =?utf-8?B?QkMwallqMzFsS21VSzNjclF0dFAvRW1mTkNWdGRtSGdvVm9xME1JeUJDcUtj?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35642C285807AC4587282A04632BCD50@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb84b92e-3cae-4792-d40b-08db7b26ac2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2023 18:03:43.0099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VcZ1V4aUTnvTu8Gjr0GzQFk+O2wZzU+t0fteJk11PPUKaybQJEDJG+hG75L0xdtDzgYxQPsUMoc7+txKTDgxgdwrewkOjbS3UuCXGphple0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5981
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

T24gVGh1LCAyMDIzLTA2LTI5IGF0IDE3OjA3ICswMTAwLCBzemFib2xjcy5uYWd5QGFybS5jb20g
d3JvdGU6DQo+IFRoZSAwNi8yMi8yMDIzIDIzOjE4LCBFZGdlY29tYmUsIFJpY2sgUCB3cm90ZToN
Cj4gPiBJJ2QgYWxzbyBhcHByZWNpYXRlIGlmIHlvdSBjb3VsZCBzcGVsbCBvdXQgZXhhY3RseSB3
aGljaDoNCj4gPiDCoC0gdWNvbnRleHQNCj4gPiDCoC0gc2lnbmFsDQo+ID4gwqAtIGxvbmdqbXAN
Cj4gPiDCoC0gY3VzdG9tIGxpYnJhcnkgc3RhY2sgc3dpdGNoaW5nDQo+ID4gDQo+ID4gcGF0dGVy
bnMgeW91IHRoaW5rIHNoYWRvdyBzdGFjayBzaG91bGQgc3VwcG9ydCB3b3JraW5nIHRvZ2V0aGVy
Lg0KPiA+IEJlY2F1c2UgZXZlbiBhZnRlciBhbGwgdGhlc2UgbWFpbHMsIEknbSBzdGlsbCBub3Qg
c3VyZSBleGFjdGx5IHdoYXQNCj4gPiB5b3UNCj4gPiBhcmUgdHJ5aW5nIHRvIGFjaGlldmUuDQoN
CkhpIFN6YWJsb2NzLA0KDQpUaGFua3MgZm9yIHdyaXRpbmcgYWxsIHRoaXMgdXAuIEl0IGlzIGhl
bHBmdWwgdG8gdW5kZXJzdGFuZCB3aGVyZSB5b3UNCmFyZSBjb21pbmcgZnJvbS4gUGxlYXNlIGRv
bid0IG1pc3MgbXkgcG9pbnQgYXQgdGhlIHZlcnkgYm90dG9tIG9mIHRoaXMNCnJlc3BvbnNlLg0K
DQo+IA0KPiBpJ20gdHJ5aW5nIHRvIHN1cHBvcnQgdHdvIG9wZXJhdGlvbnMgKGluIGFueSBjb21i
aW5hdGlvbik6DQo+IA0KPiAoMSkganVtcCB1cCB0aGUgY3VycmVudCAoYWN0aXZlKSBzdGFjay4N
Cj4gDQo+ICgyKSBqdW1wIHRvIGEgbGl2ZSBmcmFtZSBpbiBhIGRpZmZlcmVudCBpbmFjdGl2ZSBi
dXQgbGl2ZSBzdGFjay4NCj4gwqDCoMKgIHRoZSBvbGQgc3RhY2sgYmVjb21lcyBpbmFjdGl2ZSAo
PSBubyB0YXNrIGV4ZWN1dGVzIG9uIGl0KQ0KPiDCoMKgwqAgYW5kIGxpdmUgKD0gaGFzIHZhbGlk
IGZyYW1lcyB0byBqdW1wIHRvKS4NCj4gDQo+IHdpdGgNCj4gDQo+ICgzKSB0aGUgcnVudGltZSBt
dXN0IG1hbmFnZSB0aGUgc2hhZG93IHN0YWNrcyB0cmFuc3BhcmVudGx5Lg0KPiDCoMKgwqAgKD0g
cG9ydGFibGUgYyBjb2RlIGRvZXMgbm90IG5lZWQgbW9kaWZpY2F0aW9ucykNCj4gDQo+IG1hcHBp
bmcgdGhpcyB0byBjIGFwaXM6DQo+IA0KPiAtIHN3YXBjb250ZXh0LCBzZXRjb250ZXh0LCBsb25n
am1wLCBjdXN0b20gc3RhY2sgc3dpdGNoaW5nIGFyZSBqdW1wDQo+IMKgIG9wZXJhdGlvbnMuICh0
aGVyZSBhcmUgY29uZGl0aW9ucyB1bmRlciB3aGljaCAoMSkgYW5kICgyKSBtdXN0DQo+IHdvcmss
DQo+IMKgIGZ1cnRoZXIgZGV0YWlscyBkb24ndCBtYXR0ZXIuKQ0KPiANCj4gLSBtYWtlY29udGV4
dCBjcmVhdGVzIGFuIGluYWN0aXZlIGxpdmUgc3RhY2suDQo+IA0KPiAtIHNpZ25hbCBpcyBvbmx5
IHNwZWNpYWwgaWYgaXQgZXhlY3V0ZXMgb24gYW4gYWx0IHN0YWNrOiBvbiBzaWduYWwNCj4gwqAg
ZW50cnkgdGhlIGFsdCBzdGFjayBiZWNvbWVzIGFjdGl2ZSBhbmQgdGhlIGludGVycnVwdGVkIHN0
YWNrDQo+IMKgIGluYWN0aXZlIGJ1dCBsaXZlLiAobmVzdGVkIHNpZ25hbHMgZXhlY3V0ZSBvbiB0
aGUgYWx0IHN0YWNrIHVudGlsDQo+IMKgIHRoYXQgaXMgbGVmdCBlaXRoZXIgdmlhIGEganVtcCBv
ciBzaWduYWwgcmV0dXJuLikNCj4gDQo+IC0gdW53aW5kaW5nIGNhbiBiZSBpbXBsZW1lbnRlZCB3
aXRoIGp1bXAgb3BlcmF0aW9ucyAoaXQgbmVlZHMgc29tZQ0KPiDCoCBvdGhlciB0aGluZ3MgYnV0
IHRoYXQncyBvdXQgb2Ygc2NvcGUgaGVyZSkuDQo+IA0KPiB0aGUgcGF0dGVybnMgdGhhdCBzaGFk
b3cgc3RhY2sgc2hvdWxkIHN1cHBvcnQgZmFsbHMgb3V0IG9mIHRoaXMNCj4gbW9kZWwuDQo+IChl
LmcuIHBvc2l4IGRvZXMgbm90IGFsbG93IGp1bXBpbmcgZnJvbSBvbmUgdGhyZWFkIHRvIHRoZSBz
dGFjayBvZiBhDQo+IGRpZmZlcmVudCB0aHJlYWQsIGJ1dCB0aGUgbW9kZWwgZG9lcyBub3QgY2Fy
ZSBhYm91dCB0aGF0LCBpdCBvbmx5DQo+IGNhcmVzIGlmIHRoZSB0YXJnZXQgc3RhY2sgaXMgaW5h
Y3RpdmUgYW5kIGxpdmUgdGhlbiBqdW1wIHNob3VsZA0KPiB3b3JrLikNCj4gDQo+IHNvbWUgb2Jz
ZXJ2YXRpb25zOg0KPiANCj4gLSBpdCBpcyBuZWNlc3NhcnkgZm9yIGp1bXAgdG8gZGV0ZWN0IGNh
c2UgKDIpIGFuZCB0aGVuIHN3aXRjaCB0byB0aGUNCj4gwqAgdGFyZ2V0IHNoYWRvdyBzdGFjay4g
dGhpcyBpcyBhbHNvIHN1ZmZpY2llbnQgdG8gaW1wbGVtZW50IGl0Lg0KPiAobm90ZToNCj4gwqAg
dGhlIHJlc3RvcmUgdG9rZW4gY2FuIGJlIHVzZWQgZm9yIGRldGVjdGlvbiBzaW5jZSB0aGF0IGlz
DQo+IGd1YXJhbnRlZWQNCj4gwqAgdG8gYmUgcHJlc2VudCB3aGVuIHVzZXIgY29kZSBjcmVhdGVz
IGFuIGluYWN0aXZlIGxpdmUgc3RhY2sgYW5kIGlzDQo+IMKgIG5vdCBwcmVzZW50IGFueXdoZXJl
IGVsc2UgYnkgZGVzaWduLiBhIGRpZmZlcmVudCBtYXJraW5nIGNhbiBiZQ0KPiB1c2VkDQo+IMKg
IGlmIHRoZSBpbmFjdGl2ZSBsaXZlIHN0YWNrIGlzIGNyZWF0ZWQgYnkgdGhlIGtlcm5lbCwgYnV0
IHRoZW4gdGhlDQo+IMKgIGtlcm5lbCBoYXMgdG8gcHJvdmlkZSBhIHN3aXRjaCBtZXRob2QsIGUu
Zy4gc3lzY2FsbC4gdGhpcyBzaG91bGQNCj4gbm90DQo+IMKgIGJlIGNvbnRyb3ZlcnNpYWwuKQ0K
DQpGb3IgeDg2J3Mgc2hhZG93IHN0YWNrIHlvdSBjYW4ganVtcCB0byBhIG5ldyBzdGFjayB3aXRo
b3V0IGxlYXZpbmcgYQ0KdG9rZW4gYmVoaW5kLiBJIGRvbid0IGtub3cgaWYgbWF5YmUgd2UgY291
bGQgbWFrZSBpdCBhIHJ1bGUgaW4gdGhlDQp4ODZfNjQgQUJJIHRoYXQgeW91IHNob3VsZCBhbHdh
eXMgbGVhdmUgYSB0b2tlbiBpZiB5b3UgYXJlIGdvaW5nIHRvDQptYXJrIHRoZSBTSFNUSyBlbGYg
Yml0LiBCdXQgaWYgYW55dGhpbmcgZGlkIHRoaXMsIHRoZW4gbG9uZ2ptcCgpIGNvdWxkDQpuZXZl
ciBtYWtlIGl0IGJhY2sgdG8gdGhlIHN0YWNrIHdoZXJlIHNldGptcCgpIHdhcyBjYWxsZWQgd2l0
aG91dA0Ka2VybmVsIGhlbHAuDQoNCj4gDQo+IC0gaW4gdGhpcyBtb2RlbCB0d28gbGl2ZSBzdGFj
a3MgY2Fubm90IHVzZSB0aGUgc2FtZSBzaGFkb3cgc3RhY2sNCj4gc2luY2UNCj4gwqAganVtcGlu
ZyBiZXR3ZWVuIHRoZSB0d28gc3RhY2tzIGlzIGFsbG93ZWQgaW4gYm90aCBkaXJlY3Rpb25zLCBi
dXQNCj4gwqAganVtcGluZyB3aXRoaW4gYSBzaGFkb3cgc3RhY2sgb25seSB3b3JrcyBpbiBvbmUg
ZGlyZWN0aW9uLiAoYWxzbw0KPiB0d28NCj4gwqAgdGFza3MgY291bGQgZXhlY3V0ZSBvbiB0aGUg
c2FtZSBzaGFkb3cgc3RhY2sgdGhlbi4gYW5kIGl0IG1ha2VzDQo+IMKgIHNoYWRvdyBzdGFjayBz
aXplIGFjY291bnRpbmcgcHJvYmxlbWF0aWMuKQ0KPiANCj4gLSBzbyBzaGFyaW5nIHNoYWRvdyBz
dGFjayB3aXRoIGFsdCBzdGFjayBpcyBicm9rZW4uICh0aGUgbW9kZWwgaXMNCj4gwqAgcmlnaHQg
aW4gdGhlIHNlbnNlIHRoYXQgdmFsaWQgcG9zaXggY29kZSBjYW4gdHJpZ2dlciB0aGUgaXNzdWUu
DQoNCkNvdWxkIHlvdSBzcGVsbCBvdXQgd2hhdCAidGhlIGlzc3VlIiBpcyB0aGF0IGNhbiBiZSB0
cmlnZ2VyZWQ/DQoNCj4gIHdlDQo+IMKgIGNhbiBpZ25vcmUgdGhhdCBjb3JuZXIgY2FzZSBhbmQg
YWRqdXN0IHRoZSBtb2RlbCBzbyB0aGUgc2hhcmVkDQo+IMKgIHNoYWRvdyBzdGFjayB3b3JrcyBm
b3IgYWx0IHN0YWNrLCBidXQgaXQgbGlrZWx5IGRvZXMgbm90IGNoYW5nZSB0aGUNCj4gwqAganVt
cCBkZXNpZ246IGV2ZW50dWFsbHkgd2Ugd2FudCBhbHQgc2hhZG93IHN0YWNrLikNCg0KQXMgd2Ug
ZGlzY3Vzc2VkIHByZXZpb3VzbHksIGFsdCBzaGFkb3cgc3RhY2sgY2FuJ3Qgd29yayB0cmFuc3Bh
cmVudGx5DQp3aXRoIGV4aXN0aW5nIGNvZGUgZHVlIHRvIHRoZSBzaWdhbHRzdGFjayBBUEkuIEkg
d29uZGVyIGlmIG1heWJlIHlvdQ0KYXJlIHRyeWluZyB0byBnZXQgYXQgc29tZXRoaW5nIGVsc2Us
IGFuZCBJJ20gbm90IGZvbGxvd2luZy4NCg0KPiANCj4gLSBzaGFkb3cgc3RhY2sgY2Fubm90IGFs
d2F5cyBiZSBtYW5hZ2VkIGJ5IHRoZSBydW50aW1lIHRyYW5zcGFyZW50bHk6DQo+IMKgIGl0IGhh
cyB0byBiZSBhbGxvY2F0ZWQgZm9yIG1ha2Vjb250ZXh0IGFuZCBhbHQgc3RhY2sgaW4gc2l0dWF0
aW9ucw0KPiDCoCB3aGVyZSBhbGxvY2F0aW9uIGZhaWx1cmUgY2Fubm90IGJlIGhhbmRsZWQuIG1v
cmUgYWxhcm1pbmdseSB0aGUNCj4gwqAgZGVzdHJ1Y3Rpb24gb2Ygc3RhY2tzIG1heSBub3QgYmUg
dmlzaWJsZSB0byB0aGUgcnVudGltZSBzbyB0aGUNCj4gwqAgY29ycmVzcG9uZGluZyBzaGFkb3cg
c3RhY2tzIGxlYWsuIG15IHByZWZlcnJlZCB3YXkgdG8gZml4IHRoaXMgaXMNCj4gwqAgbmV3IGFw
aXMgdGhhdCBhcmUgc2hhZG93IHN0YWNrIGNvbXBhdGlibGUgKGUuZy4gc2hhZG93X21ha2Vjb250
ZXh0DQo+IMKgIHdpdGggc2hhZG93X2ZyZWVjb250ZXh0KSBhbmQgbWFya2luZyB0aGUgaW5jb21w
YXRpYmxlIGFwaXMgYXMgc3VjaC4NCj4gwqAgcG9ydGFibGUgY29kZSB0aGVuIGNhbiBkZWNpZGUg
dG8gdXBkYXRlIHRvIG5ldyBhcGlzLCBydW4gd2l0aCBzaHN0aw0KPiDCoCBkaXNhYmxlZCBvciBh
Y2NlcHQgdGhlIGxlYWtzIGFuZCBPT00gZmFpbHVyZXMuIHRoZSBjdXJyZW50IGFwcHJvYWNoDQo+
IMKgIG5lZWRzIGlmZGVmIF9fQ0VUX18gaW4gdXNlciBjb2RlIGZvciBtYWtlY29udGV4dCBhbmQg
c2lnYWx0c3RhY2sNCj4gwqAgaGFzIG1hbnkgaXNzdWVzLg0KDQpUaGlzIHNvdW5kcyByZWFzb25h
YmxlIHRvIG1lIG9uIHRoZSBmYWNlIG9mIGl0LiBJdCBzZWVtcyBtb3N0bHkNCnVucmVsYXRlZCB0
byB0aGUga2VybmVsIEFCSSBhbmQgcHVyZWx5IGEgdXNlcnNwYWNlIHRoaW5nLg0KDQo+IA0KPiAt
IGknbSBzdGlsbCBub3QgaGFwcHkgd2l0aCB0aGUgc2hhZG93IHN0YWNrIHNpemluZy4gYW5kIHdv
dWxkIGxpa2UgdG8NCj4gwqAgaGF2ZSBhIHRva2VuIGF0IHRoZSBlbmQgb2YgdGhlIHNoYWRvdyBz
dGFjayB0byBhbGxvdyBzY2FubmluZy4gYW5kDQo+IMKgIGl0IHdvdWxkIGJlIG5pY2UgdG8gZGVh
bCB3aXRoIHNoYWRvdyBzdGFjayBvdmVyZmxvdy4gYW5kIHRoZXJlIGlzDQo+IMKgIGFzeW5jIGRp
c2FibGUgb24gZGxvcGVuLiBzbyB0aGVyZSBhcmUgdGhpbmdzIHRvIHdvcmsgb24uDQoNCkkgd2Fz
IGltYWdpbmluZyB0aGF0IGZvciB0cmFjaW5nLW9ubHkgdXNlcnMsIGl0IG1pZ2h0IG1ha2Ugc2Vu
c2UgdG8gcnVuDQp3aXRoIFdSU1MgZW5hYmxlZC4gVGhpcyBjb3VsZCBtZWFuIGxpYmMncyBjb3Vs
ZCB3cml0ZSB0aGVpciBvd24gcmVzdG9yZQ0KdG9rZW5zLiBJbiB0aGUgY2FzZSBvZiBsb25nam1w
KCkgaXQgY291bGQgYmUgc2ltcGxlIGFuZCBmYXN0LiBUaGUNCmltcGxlbWVudGF0aW9uIGNvdWxk
IGp1c3Qgd3JpdGUgYSB0b2tlbiBhdCB0aGUgdGFyZ2V0IFNTUCBhbmQgc3dpdGNoIHRvDQppdC4g
Tm9uIEMgcnVudGltZXMgdGhhdCB3YW50IHRvIHVzZSBpZiBmb3IgYmFja3RyYWNpbmcgY291bGQg
YWxzbyB3cml0ZQ0KdGhlaXIgb3duIHByZWZlcnJlZCBzdGFjayBtYXJrZXJzIG9yIG90aGVyIGRh
dGEuIEl0IGFsc28gaXMgd2hvbGUNCmRpZmZlcmVudCBzb2x1dGlvbiB0byB3aGF0IGlzIGJlaW5n
IGRpc2N1c3NlZC4NCg0KQnV0IG92ZXIgdGhlIGNvdXJzZSBvZiB0aGlzIHRocmVhZCwgSSBjb3Vs
ZCBpbWFnaW5lIGEgbGl0dGxlIG1vcmUgbm93DQpob3cgYSB0b3Agb2Ygc3RhY2sgbWFya2VyIGNv
dWxkIHBvc3NpYmx5IGJlIHVzZWZ1bCBmb3Igbm9uLXRyYWNpbmcNCnVzYWdlcy4gSSBoYXZlIGEg
cGF0Y2ggcHJlcGFyZWQgZm9yIHRoaXMgYW5kIEkgaGFkIHRlc3RlZCB0byBzZWUgaWYNCmFkZGlu
ZyB0aGlzIGxhdGVyIGNvdWxkIGRpc3R1cmIgYW55dGhpbmcgaW4gdXNlcnNwYWNlLiBUaGUgb25s
eSB0aGluZw0KdGhhdCBJIGZvdW5kIHdhcyB0aGF0IGdkYiBtaWdodCBvdXRwdXQgYSBzbGlnaHRs
eSBkaWZmZXJlbnQgc3RhY2sNCnRyYWNlLiBTbyBpdCB3b3VsZCBiZSBhIHVzZXIgdmlzaWJsZSBj
aGFuZ2UsIGlmIG5vdCBhIHJlZ3Jlc3Npb24uDQoNCk9uZSByZWFzb24gSSBoZWxkIG9mZiBvbiBp
dCBzdGlsbCwgaXMgdGhhdCB0aGUgcGxhbiBmb3IgdGhlIGV4cGFuZGVkDQpzaGFkb3cgc3RhY2sg
c2lnbmFsIGZyYW1lIGluY2x1ZGVzIHVzaW5nIGEgMCBmcmFtZSwgdG8gYXZvaWQgYSBmb3JnZXJ5
DQpzY2VuYXJpby4gVGhlIHRva2VuIHRoYXQgbWFrZXMgc2Vuc2UgZm9yIHRoZSBlbmQgb2Ygc3Rh
Y2sgbWFya2VyIGlzDQphbHNvIGEgMCBmcmFtZS4gU28gaWYgdXNlcnNwYWNlIHRoYXQgbG9va3Mg
Zm9yIHRoZSBlbmQgb2Ygc3RhY2sgbWFya2VyDQpzY2FucyBmb3IgdGhlIDAgZnJhbWUgd2l0aG91
dCBjaGVja2luZyBpZiBpdCBpcyBwYXJ0IG9mIGFuIGV4cGFuZGVkDQpzaGFkb3cgc3RhY2sgc2ln
bmFsIGZyYW1lLCB0aGVuIGl0IGNvdWxkIG1ha2UgbW9yZSB0cm91YmxlIGZvciBhbHQNCnNoYWRv
dyBzdGFjay4NCg0KU28gc2luY2UgdGhleSBhcmUgdGllZCB0b2dldGhlciwgYW5kIEkgdGhvdWdo
dCB0byBob2xkIG9mZiBvbiBpdCBmb3INCm5vdy4gSSBkb24ndCB3YW50IHRvIHRyeSB0byBzcXVl
ZXplIGFyb3VuZCB0aGUgdXBzdHJlYW0gdXNlcnNwYWNlLCBJDQp0aGluayBhIHZlcnNpb24gMiBz
aG91bGQgYmUgYSBjbGVhbiBzbGF0ZSBvbiBhIG5ldyBlbGYgYml0Lg0KDQo+IA0KPiBpIHVuZGVy
c3RhbmQgdGhhdCB0aGUgcHJvcG9zZWQgbGludXggYWJpIG1ha2VzIG1vc3QgZXhpc3RpbmcgYmlu
YXJpZXMNCj4gd2l0aCBzaHN0ayBtYXJraW5nIHdvcmssIHdoaWNoIGlzIHJlbGV2YW50IGZvciB4
ODYuDQo+IA0KPiBmb3IgYSB3aGlsZSBpIHRob3VnaHQgd2UgY2FuIGZpeCB0aGUgcmVtYWluaW5n
IGlzc3VlcyBldmVuIGlmIHRoYXQNCj4gbWVhbnMgYnJlYWtpbmcgZXhpc3Rpbmcgc2hzdGsgYmlu
YXJpZXMgKGp1c3QgYnVtcCB0aGUgYWJpIG1hcmtpbmcpLg0KPiBub3cgaXQgc2VlbXMgdGhlIGlz
c3VlcyBjYW4gb25seSBiZSBhZGRyZXNzZWQgaW4gYSBmdXR1cmUgYWJpIGJyZWFrLg0KDQpBZGRp
bmcgYSBuZXcgYXJjaF9wcmN0bCgpIEVOQUJMRSB2YWx1ZSB3YXMgdGhlIHBsYW4uIE5vdCBzdXJl
IHdoYXQgeW91DQptZWFuIGJ5IEFCSSBicmVhayB2cyB2ZXJzaW9uIGJ1bXAuIFRoZSBwbGFuIHdh
cyB0byBhZGQgdGhlIG5ldyBmZWF0dXJlcw0Kd2l0aG91dCB1c2Vyc3BhY2UgcmVncmVzc2lvbiBi
eSBwdXR0aW5nIGFueSBiZWhhdmlvciBiZWhpbmQgYSBkaWZmZXJlbnQNCmVuYWJsZSBvcHRpb24u
IFRoaXMgcmVsaWVzIG9uIHVzZXJzcGFjZSB0byBhZGQgYSBuZXcgZWxmIGJpdCwgYW5kIHRvDQp1
c2UgaXQuDQoNCj4gDQo+IHdoaWNoIG1lYW5zIHg4NiBsaW51eCB3aWxsIGxpa2VseSBlbmQgdXAg
bWFpbnRhaW5pbmcgdHdvIGluY29tcGF0aWJsZQ0KPiBhYmlzIGFuZCB0aGUgZnV0dXJlIG9uZSB3
aWxsIG5lZWQgdXNlciBjb2RlIGFuZCBidWlsZCBzeXN0ZW0gY2hhbmdlcywNCj4gbm90IGp1c3Qg
cnVudGltZSBjaGFuZ2VzLiBpdCBpcyBub3QgYSBzbWFsbCBpbmNyZW1lbnRhbCBjaGFuZ2UgdG8g
YWRkDQo+IGFsdCBzaGFkb3cgc3RhY2sgc3VwcG9ydCBmb3IgZXhhbXBsZS4NCj4gDQo+IGkgZG9u
J3QgdGhpbmsgdGhlIG1haW50ZW5hbmNlIGJ1cmRlbiBvZiB0d28gc2hhZG93IHN0YWNrIGFiaXMg
aXMgdGhlDQo+IHJpZ2h0IHBhdGggZm9yIGFybTY0IHRvIGZvbGxvdywgc28gdGhlIHNoYWRvdyBz
dGFjayBzZW1hbnRpY3Mgd2lsbA0KPiBsaWtlbHkgYmVjb21lIGRpdmVyZ2VudCBub3QgY29tbW9u
IGFjcm9zcyB0YXJnZXRzLg0KDQpVbmZvcnR1bmF0ZWx5IHdlIGFyZSBhdCBhIGJpdCBvZiBhbiBp
bmZvcm1hdGlvbiBhc3ltbWV0cnkgaGVyZSBiZWNhdXNlDQp0aGUgQVJNIHNwZWMgYW5kIHBhdGNo
ZXMgYXJlIG5vdCBwdWJsaWMuIEl0IG1heSBiZSBwYXJ0IG9mIHRoZSBjYXVzZSBvZg0KdGhlIGNv
bmZ1c2lvbi4NCg0KPiANCj4gaSBob3BlIG15IHBvc2l0aW9uIGlzIG5vdyBjbGVhcmVyLg0KDQpJ
dCBraW5kIG9mIHNvdW5kcyBsaWtlIHlvdSBkb24ndCBsaWtlIHRoZSB4ODYgZ2xpYmMgaW1wbGVt
ZW50YXRpb24uIEFuZA0KeW91IHdhbnQgdG8gbWFrZSBzdXJlIHRoZSBrZXJuZWwgY2FuIHN1cHBv
cnQgd2hhdGV2ZXIgYSBuZXcgc29sdXRpb24gaXMNCnRoYXQgeW91IGFyZSB3b3JraW5nIG9uLiBJ
IGFtIG9uIGJvYXJkIHdpdGggdGhlIGdvYWwgb2YgaGF2aW5nIHNvbWUNCmdlbmVyaWMgc2V0IG9m
IHJ1bGVzIHRvIG1ha2UgcG9ydGFibGUgY29kZSB3b3JrIGZvciBvdGhlciBhcmNoaXRlY3R1cmVz
DQpzaGFkb3cgc3RhY2tzLiBCdXQgSSB0aGluayBob3cgY2xvc2Ugd2UgY2FuIGdldCB0byB0aGF0
IGdvYWwgb3Igd2hhdCBpdA0KbG9va3MgbGlrZSBpcyBhbiBvcGVuIHF1ZXN0aW9uLiBGb3Igc2V2
ZXJhbCByZWFzb25zOg0KIDEuIE5vdCBldmVyeW9uZSBjYW4gc2VlIGFsbCB0aGUgc3BlY3MNCiAy
LiBObyBQT0NzIGhhdmUgYmVlbiBkb25lIChvciBhdCBsZWFzdCBzaGFyZWQpDQogMy4gSXQncyBu
b3QgY2xlYXIgd2hhdCBuZWVkcyB0byBiZSBzdXBwb3J0ZWQgKHllcywgSSBrbm93IHlvdSBoYXZl
wqANCiAgICBtYWRlIGEgcm91Z2ggcHJvcG9zYWwgaGVyZSwgYnV0IGl0IHNvdW5kcyBsaWtlIG9u
IHRoZSB4ODYgZ2xpYmPCoA0KICAgIHNpZGUgYXQgbGVhc3QgaXQncyBub3QgZXZlbiBjbGVhciB3
aGF0IG5vbi1zaGFkb3cgc3RhY2sgc3RhY2vCoA0KICAgIHN3aXRjaGluZ8Kgb3BlcmF0aW9ucyBj
YW4gd29yayB0b2dldGhlcikNCg0KQnV0IHRvd2FyZHMgdGhlc2UgZ29hbHMsIEkgdGhpbmsgeW91
ciB0ZWNobmljYWwgcmVxdWVzdHMgYXJlOg0KDQoxLiBMZWF2ZSBhIHRva2VuIG9uIHN3aXRjaGlu
ZyB0byBhbiBhbHQgc2hhZG93IHN0YWNrLiBBcyBkaXNjdXNzZWQNCmVhcmxpZXIsIHdlIGNhbid0
IGRvIHRoaXMgYmVjYXVzZSBvZiB0aGUgb3ZlcmZsb3cgaXNzdWVzLiBBbHNvIHNpbmNlLA0KYWx0
IHNoYWRvdyBzdGFjayBjYW5ub3QgYmUgdHJhbnNwYXJlbnQgdG8gZXhpc3Rpbmcgc29mdHdhcmUg
YW55d2F5LCBpdA0Kc2hvdWxkIGJlIG9rIHRvIGludHJvZHVjZSBsaW1pdGF0aW9ucy4gU28gSSB0
aGluayB0aGlzIG9uZSBpcyBhIG5vLg0KV2hhdCB3ZSBjb3VsZCBkbyBpcyBpbnRyb2R1Y2Ugc2Vj
dXJpdHkgd2Vha2VuaW5nIGtlcm5lbCBoZWxwZXJzLCBidXQNCnRoaXMgd291bGQgbWFrZSBzZW5z
ZSB0byBjb21lIHdpdGggYWx0IHNoYWRvdyBzdGFjayBzdXBwb3J0Lg0KMi4gQWRkIGFuIGVuZCB0
b2tlbiBhdCB0aGUgdG9wIG9mIHRoZSBzaGFkb3cgc3RhY2suIEJlY2F1c2Ugb2YgdGhlDQpleGlz
dGluZyB1c2Vyc3BhY2UgcmVzdHJpY3Rpb24gaW50ZXJhY3Rpb25zLCB0aGlzIGlzIGNvbXBsaWNh
dGVkIHRvDQpldmFsdWF0ZSBidXQgSSB0aGluayB3ZSAqY291bGQqIGRvIHRoaXMgbm93LiBUaGVy
ZSBhcmUgcHJvcyBhbmQgY29ucy4NCjMuIFN1cHBvcnQgbW9yZSBvcHRpb25zIGZvciBzaGFkb3cg
c3RhY2sgc2l6aW5nLiAoSSB0aGluayB5b3UgYXJlDQpyZWZlcnJpbmcgdG8gdGhpcyBjb252ZXJz
YXRpb246DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL1pBSWdyWFE0NjcwZ3hsRTRAYXJt
LmNvbS8pLiBJIGRvbid0IHNlZQ0Kd2h5IHRoaXMgaXMgbmVlZGVkIGZvciB0aGUgYmFzZSBpbXBs
ZW1lbnRhdGlvbi4gSWYgQVJNIHdhbnRzIHRvIGFkZCBhDQpuZXcgcmxpbWl0IG9yIGNsb25lIHZh
cmlhbnQsIEkgZG9uJ3Qgc2VlIHdoeSB4ODYgY2FuJ3Qgc3VwcG9ydCBpdA0KbGF0ZXIuDQoNClNv
IGlmIHdlIGFkZCAyLCBhcmUgeW91IHNhdGlzZmllZD8gT3Igb3RoZXJ3aXNlLCBvbiB0aGUgbm9u
LXRlY2huaWNhbA0KcmVxdWVzdCBzaWRlLCBhcmUgeW91IGFza2luZyB0byBob2xkIG9mZiBvbiB4
ODYgc2hhZG93IHN0YWNrLCBpbiBvcmRlcg0KdG8gY28tZGV2ZWxvcCBhIHVuaWZpZWQgc29sdXRp
b24/DQoNCkkgdGhpbmsgdGhlIGV4aXN0aW5nIHNvbHV0aW9uIHdpbGwgc2VlIHVzZSBpbiB0aGUg
bWVhbnRpbWUsIGluY2x1ZGluZw0KZm9yIHRoZSBkZXZlbG9wbWVudCBvZiBhbGwgdGhlIHg4NiBz
cGVjaWZpYyBKSVQgaW1wbGVtZW50YXRpb25zLg0KDQoNCkFuZCBmaW5hbGx5LCB3aGF0IEkgdGhp
bmsgaXMgdGhlIG1vc3QgaW1wb3J0YW50IHBvaW50IGluIGFsbCBvZiB0aGlzOg0KDQpJIHRoaW5r
IHRoYXQgKmhvdyogaXQgZ2V0cyB1c2VkIHdpbGwgYmUgYSBiZXR0ZXIgZ3VpZGUgZm9yIGZ1cnRo
ZXINCmRldmVsb3BtZW50IHRoYW4gdXMgZGViYXRpbmcuIEZvciBleGFtcGxlIHRoZSBtYWluIHBh
aW4gcG9pbnQgdGhhdCBoYXMNCmNvbWUgdXAgc28gZmFyIGlzIHRoZSBwcm9ibGVtcyBhcm91bmQg
ZGxvcGVuKCkuIEFuZCB0aGUgZnV0dXJlIHdvcmsNCnRoYXQgaGFzIGJlZW4gc2NvcGVkIGhhcyBi
ZWVuIGZvciB0aGUga2VybmVsIHRvIGhlbHAgb3V0IGluIHRoaXMgYXJlYS4NClRoaXMgaXMgYmFz
ZWQgb24gX3VzZXJfIChkaXN0cm8pIHJlcXVlc3RzLg0KDQpBbnkgYXBwcyB0aGF0IGRvbid0IHdv
cmsgd2l0aCBzaGFkb3cgc3RhY2sgbGltaXRhdGlvbnMgY2FuIHNpbXBseSBub3QNCmVuYWJsZSBz
aGFkb3cgc3RhY2suIFlvdSBhbmQgbWUgYXJlIGRlYmF0aW5nIHRoZXNlIHNwZWNpZmljIEFQSQ0K
Y29tYmluYXRpb25zLCBidXQgd2UgY2FuJ3Qga25vdyB3aGV0aGVyIHRoZXkgYXJlIGFjdHVhbGx5
IHRoZSBiZXN0DQpwbGFjZSB0byBmb2N1cyBkZXZlbG9wbWVudCBlZmZvcnRzLiBBbmQgdGhlIGVh
cmx5IHNpZ25zIGFyZSB0aGlzIGlzIE5PVA0KdGhlIG1vc3QgaW1wb3J0YW50IHByb2JsZW0gdG8g
c29sdmUuDQoNCg==
