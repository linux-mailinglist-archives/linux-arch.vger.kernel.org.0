Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA09B5F4900
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 20:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiJDSFA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 14:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiJDSE6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 14:04:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FE113D30;
        Tue,  4 Oct 2022 11:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664906696; x=1696442696;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=0FQVWGikN4BsSKjM4JNqqi2XGIkpEfLsj2zaU5P+2/I=;
  b=DpVKCJ20+kcXk6sbSJ31eZ9cKXDc5lMPlwJfv+atB0pHrm7y/ZQk0n9A
   Cw5O9fR7mWQ3UQjB789JckZdY4xv57aWDHkQTe5ovKPE0HOfOhKg4nosJ
   9jjx5yOhI62qiWjKixf1dwZLkwxHexO28hY+gYirCb0xC3AbOksdo5DdE
   SoIand62nnRYr82W/9f262t3Cvjm50udulX8tePzEahEGcXf3EBrObaAU
   Evuj3QSJlKThp1W0KUV+BPkJkPjD9zuj1pe5AKb5oH9/+pMAcZp0aRVJf
   SzrsEkFPzn9DHXp7anNEKrwf1a4xyja31mdfZ4pcAGGuCCX5ek2MCPM39
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="283353233"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="283353233"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 11:04:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="728330686"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="728330686"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 04 Oct 2022 11:04:55 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 4 Oct 2022 11:04:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 4 Oct 2022 11:04:54 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 4 Oct 2022 11:04:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAxznXUpqfdbmTcunnEQuLSKmKYJl1HRWh9Ko2OlY3wZd0qvsJvAI3pj+vfEiHYtMLWZ3amwuZ5cnt8cAOndzdu+NtyhWAM0soJSWkdZe8M2ci7guVTnjFl1Kx5ZX/dnNENsA7Q07EESymyvj4uvyFzfxEGGRroXjZuOWWbNsa45lsyBYMn3IOVExrOu504Zv8sKSSl7LYsKa3dKHpR7cmw+Cv89jO2gcvR/qJJu57+lEhWFR80OLDg6oklUjlrnzbB9wxtEwHGFNCh7uWtTd24ITGk9JxkjaNifBi3zKt+n5fwtaBY7q5k+N8fNI2Bh4FZiEo85o0zLioO+nWqTlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FQVWGikN4BsSKjM4JNqqi2XGIkpEfLsj2zaU5P+2/I=;
 b=MDfxU03E5WYIuZbMXLpTiLWIg84eZpip4RSqmQrHH8xUpOSZ4Lt/K6WDY/w3qu+2FKjCRfa8MOIrt6LHc61hvL36e2jZd1qL5Koa7pWJsTlvtEtoMtb9LcpGfjnazgiEV0uYE5F3RpcFNuI1vOi/+tLsA3xza1sJl4e4rBla9wdlpLMCKb7vD7/M2mcAf+/o+mm/fh0q5FJ+V3XP/SS/rrPUI6bWZ5WhbEN1MsKHZcZArbyNWZSHrMrXoaAMFWwrQDaCCkPymyCBirC//4Fg7qdu9SVbIGSYzKpsZiHruPRaPPowBa46hGvVduUKB7qa5Du4A5/WKKECYn0L/fdp9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SA0PR11MB4735.namprd11.prod.outlook.com (2603:10b6:806:92::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Tue, 4 Oct
 2022 18:04:52 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.028; Tue, 4 Oct 2022
 18:04:52 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
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
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
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
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [OPTIONAL/RFC v2 39/39] x86: Add alt shadow stack support
Thread-Topic: [OPTIONAL/RFC v2 39/39] x86: Add alt shadow stack support
Thread-Index: AQHY1FMw46i7QamtHEWiYkKxbJ7BUq39VQ+AgAEangCAABoVgIAABTCA
Date:   Tue, 4 Oct 2022 18:04:51 +0000
Message-ID: <1ff55bc4da14df8d133f44987d4778fcc9d2951d.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-40-rick.p.edgecombe@intel.com>
         <ed5f3a95-2854-8b36-7ed9-f1d7ad0a2e51@kernel.org>
         <b22748f80c4993192bc7113b2ed28231dfaee94f.camel@intel.com>
         <dbc11c79-44bd-48aa-8548-21d86ac8fc0f@app.fastmail.com>
In-Reply-To: <dbc11c79-44bd-48aa-8548-21d86ac8fc0f@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SA0PR11MB4735:EE_
x-ms-office365-filtering-correlation-id: 7cc30a80-4fb7-4688-5d86-08daa632ef38
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V/JbMKYdF2E+BbyCEuV3P5VX4gPhxPCXWaE4QHlRB5KsNTQDvRbj5PXsfAg7EZuZrKa/xnR2ve+9FNqnciBbIPCo2fZoq1xIfMiVY9tmXLyogR7cTLo1Z2ahI/5X/BLK+fHAVO3cClXbnHIcYill/Ad8qn1PtYzGOM02RLMy6FPOUr1ZeBe/8U2h+G+YRJchkUtZcwnOlqwAcxmW7uXWoJJmq5SuqEI+3vmedpkTMGkmyaIh+jR7oifqXnZFqJ8aluObKcYhdzY6rAl9bT5ea01lDHkYbSKUx7459Uh5YtJor/7brumFtvM5XQtdZs8r9+ZoMGCyRBj5ndE45cDO7T3Vd6gGriQSzo+f3hzMMTlKUP2v/U45zSgULuZTyA1pTEo1V59D9N0x39PFdaBW+5wU7sUX+OHjy97mv/goHRIcAhshQwETgm4lUCiPyAJFsU8NnjGnOWEdAdrOIW5DSNGl8SUqOPBWDY3Q7+cO++u/IGfPAEjXXYPkoRzgfyGLona5kdi8TstxcdmiAAMZ43uFixEOg4Ht+ndw2W3GVcuoVvNnb+cgK0MRrZTbh2j05hip/vPjx1SMGH/Mt2g1ABPcwJa0sZzwzY0e/XGeFY5UUjoRlW4QVzbv5CuqgQ4BuDwyX5kHPYBaMnaVK/Gvqjjhe+QeD92SWvN615zrMVZExIhQ2itdKmM4bocN+k7vep84eZkSrXQbnhX8rSQ2wTUwLaEIPU5h1rLmZWHO4PAoGyAs/PLFNez/KGb5acYHydrZO5p/4TXbfWzi3h9fNhGqnjxH+0yJrokZcCCKy5cROlxJ8IeRiQBroK+tXM42
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199015)(66899015)(26005)(6512007)(316002)(110136005)(86362001)(82960400001)(6486002)(8676002)(71200400001)(36756003)(122000001)(38100700002)(64756008)(921005)(38070700005)(2616005)(6506007)(91956017)(8936002)(66556008)(66476007)(66446008)(5660300002)(66946007)(7416002)(7406005)(186003)(76116006)(478600001)(2906002)(41300700001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0ZTb1Z3TllZTmZITEdxSVlYVGIvcCtFMXkyQUZ5M3ZLbi85clRQcEhLVUVX?=
 =?utf-8?B?R1IwVmpBRmVrY1o4UmRNdzJnMEtyZkdjUk5uWktGV0dZYzFRSmVsTER4bDl3?=
 =?utf-8?B?c0xTeDU4WUhoVjRhSkQ1RWp0VFVQaklJZ1pFUTQ4Tjc4eUs1TTBNWTZkazBt?=
 =?utf-8?B?d1FpREYvMHVjU2REYWdBR2RpV3IwZTZHdmt6YlFwYjlUeFYwTTNQZTl6enUv?=
 =?utf-8?B?OHlidWlqNmJ5UGpBV2tkS2E5dEpmZVJxYnB5UkNJZXAzakYvbkdyaEg2SWhI?=
 =?utf-8?B?aGp0U2czVGdFelFsbmpvOEx1cE1oYlJwYkNpcmZPWkpPaVNZYW5SYmlDVlR0?=
 =?utf-8?B?WEJkSTlIUHk2Y0kxOEpkKy9adGlhMWNDK2JIZ2tQU1RBN2VMVmZINDY3dWl0?=
 =?utf-8?B?dDV5WC9WUWpGdm0xRmdRdU5kR1drUE9OeEJQV2xJaHFsUWlpenhQVHNvcXRV?=
 =?utf-8?B?UXV3dlFlWGcyaG9oVWIvdFJRTmlvZUNBbW5XcElXMG1KK3dsZmNPV2ViK3NT?=
 =?utf-8?B?ZjdrMnNRUkpTeGdFS2xLSWR4V01EV0U5Q3BSSzdQL0IvOUxDQ2JxZHl2NTRU?=
 =?utf-8?B?dWJHcGhtekJjSTZhNW80bXlPV1dWVnk3TWxSWUZwWmlldkhDNzFoQ0F2aFd6?=
 =?utf-8?B?QlgrbnNzV3pWdlVIa25hZGZwc2J6T1Q2YkM0cm5XNC9WS0laNEt4dW1Pd2lE?=
 =?utf-8?B?WjNMWnAvbHRYRXkrTDBEWGx5akg5T1Zzam94R054b0FiZEc5S1FQaktOcStK?=
 =?utf-8?B?dTNjZm5UVGhDcHZTbmQ0Q1lKTmZzS0p6Nk9zNjFUNXBKN1l3Uzg5SWo5QUNj?=
 =?utf-8?B?Zmp3b0swWDlVTWg0RHBuSzJIZDYyR3VpTXEyK0NQR2FtbmtqVzBlNS9RQUFP?=
 =?utf-8?B?WkhCT3NHR3ZycmRMUHo2cjI5K1ZQUmVuVDI3bVROUm02NjRkOGovbm0zT3c3?=
 =?utf-8?B?S3diOW5GdHlyTURQcC83bWFpMVhBNjZobVRwNlNFNEdvdjErSFBkV0ZveU4x?=
 =?utf-8?B?bkpzUCtBWTB5Tml6SzRsQzI4Wkd4OHhrMCt5YkZIeU12Y255dXJSeENjdmdB?=
 =?utf-8?B?NTFyMUdUQ1EyQkcxdlZpUUxWODVjaG92VGhEMmM2QXR6YzhPY0ZmNDdYZ2s3?=
 =?utf-8?B?dWRGTzZSWm5ZZDMzbTQ0VCtyc1Mzd0N2cldIWGpFZGt3dVZMUEhEVGRmSzNF?=
 =?utf-8?B?ZGs1aVM4bmlQUWt6ZjZEUm12SlBFcjh4Um1ZL2l0UlJqUy93bldNZ3RwQnFT?=
 =?utf-8?B?VTU1RmJNeVpHOWlPTnlHeWxlVy9TU2tFR2hrbC9HVFZNM3J4WmNJdU9laVND?=
 =?utf-8?B?bzNhTWRuKzYwaEFWVWx4cVc4aDI2Zzc4OXFXWGR1ZmlDdUZNZ2NHRHhibTdI?=
 =?utf-8?B?Vkloa3Q4djdkRGhRRXdVMTk3cjU2eVhIa3RkajcreEwxQVR2aldCT3NreWwv?=
 =?utf-8?B?Vjl4NDh4SmZpU29VZjRJU0NObGRlcit2elR5eWxsbmNtZHB5SHdpQ1RqWDVN?=
 =?utf-8?B?UHJ1OWhUdzRJUVQ0enRHTTY1NXpmMmxIUEhmbHhGU0xhbWJROTYxQXFyQW1i?=
 =?utf-8?B?aDQzdjdVRzdiaVJDMVRDbEFKWVE0WU14bEhLQStGdVNTT2dYOEQyL2F5SHRh?=
 =?utf-8?B?TWdHeTd6eXhFU3R4MmREMzRkalEvU0NyM3MzV2kxN1NHOG0xU2N1T2VaS0NB?=
 =?utf-8?B?Z3MyeXBXbjRNM1pHd3VkTk1jWnIzWnBCT3pkZlNsVjl5WFNNV0Rlc3I1TFQ3?=
 =?utf-8?B?QW9TTEZCUjBnZE9jM1VNQ3dSaUlyMWdMdnRqZC9aUEw1VUVzL2hQNy9udE1u?=
 =?utf-8?B?amFTc3lSZFU0WVlvTElMd0Y5aEw4YU92bFVLaHpwVXRiakNTMXdUQWFaNVVQ?=
 =?utf-8?B?ZE9TQmVJYzU5RXNleHZjRGJWVUlSdHFJN2kxbEltSDZnOVB3VkMxTXpTRE11?=
 =?utf-8?B?TElOaFBnOW5PamhCUDM4aWJmZDVEUEpBQ3hsaGFKcU1nM0VJZmFwS1dLVm1Q?=
 =?utf-8?B?ZGNjMXlQd2w2THg1Slh0R0Q5U2phaXpmZUFRQURKbVhhRDZEcldCNklIQ3Zs?=
 =?utf-8?B?dU4yWTd1cTJTQjhCUWFRLzROSm5QR1dWQWNoeEhDOExsNE04T3NFYlh0Q1Q5?=
 =?utf-8?B?eWxobzdOQlVySXMvR09vcFRkbHo5UmJZRTdxNENDakFKV09admJ0TjhMQWg2?=
 =?utf-8?Q?lSD4aRAgi3rLCU8PiJbbHSs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <565E7685A5DA454C9B3E7277F6063581@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc30a80-4fb7-4688-5d86-08daa632ef38
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 18:04:51.8058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nEhOFdZqaRZgrIuBHn7tWuBFtsR4CD/QK1NnBzKhDaKuf0ScVQNsr+512FCoYrJ9KeUKCf48L6k9fWHbLv5XUrHTrNrRO4ZzRpu9uRu2tuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4735
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIyLTEwLTA0IGF0IDEwOjQ2IC0wNzAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6
DQo+ID4gVGhlIGJ1c3ktbGlrZSBiaXQgaW4gdGhlIFJTVE9SU1NQLXR5cGUgdG9rZW4gaXMgbm90
IGNhbGxlZCBvdXQgYXMgYQ0KPiA+IGJ1c3kgYml0LCBidXQgaW5zdGVhZCBkZWZpbmVkIGFzIHJl
c2VydmVkIChtdXN0IGJlIDApIGluIHNvbWUNCj4gPiBzdGF0ZXMuDQo+ID4gKE5vdGUsIGl0IGlz
IGRpZmZlcmVudCB0aGFuIHRoZSBzdXBlcnZpc29yIHNoYWRvdyBzdGFjayBmb3JtYXQpLg0KPiA+
IFllYSwNCj4gPiB3ZSBjb3VsZCBqdXN0IHByb2JhYmx5IHVzZSBpdCBsaWtlIFJTVE9SU1NQIGRv
ZXMgZm9yIHRoaXMNCj4gPiBvcGVyYXRpb24uDQo+ID4gDQo+ID4gT3IganVzdCBpbnZlbnQgYW5v
dGhlciBuZXcgdG9rZW4gZm9ybWF0IGFuZCBzdGF5IGF3YXkgZnJvbSBiaXRzDQo+ID4gbWFya2Vk
DQo+ID4gcmVzZXJ2ZWQuIFRoZW4gaXQgd291bGRuJ3QgaGF2ZSB0byBiZSBhdG9taWMgZWl0aGVy
LCBzaW5jZQ0KPiA+IHVzZXJzcGFjZQ0KPiA+IGNvdWxkbid0IHVzZSBpdC4NCj4gDQo+IEJ1dCB1
c2Vyc3BhY2UgKmNhbiogdXNlIGl0IGJ5IGRlbGl2ZXJpbmcgYSBzaWduYWwuICBJIGNvbnNpZGVy
IHRoZQ0KPiBzY2VuYXJpbyB3aGVyZSB0d28gdXNlciB0aHJlYWRzIHNldCB1cCB0aGUgc2FtZSBh
bHRzaHN0ayBhbmQgdGFrZQ0KPiBzaWduYWxzIGNvbmN1cnJlbnRseSB0byBiZSBhYm91dCBhcyBk
YW5nZXJvdXMgYW5kIGFib3V0IGFzIGxpa2VseQ0KPiAodW5kZXIgYWNjaWRlbnRhbCBvciBtYWxp
Y2lvdXMgY29uZGl0aW9ucykgYXMgdHdvIHVzZXIgdGhyZWFkcyBkb2luZw0KPiBSU1RPUlNTUCBh
dCB0aGUgc2FtZSB0aW1lLiAgU29tZW9uZSBhdCBJbnRlbCB0aG91Z2h0IHRoZSBsYXR0ZXIgd2Fz
IGENCj4gYmlnIGRlYWwsIHNvIG1heWJlIHdlIHNob3VsZCBtYXRjaCBpdHMgYmVoYXZpb3IuDQoN
ClJpZ2h0LCBmb3IgYWx0IHNoYWRvdyBzdGFjayB0aGVyZSBzaG91bGQgYmUgc29tZSBidXN5IGxp
a2UgY2hlY2tpbmcgb3INCnRoYXQgY291bGQgaGFwcGVuLiBGb3IgcmVndWxhciBvbi10aHJlYWQg
c3RhY2sgc2lnbmFscyAoZWFybGllciBpbiB0aGlzDQpzZXJpZXMpIHdlIGRvbid0IG5lZWQgYSBi
dXN5IGJpdC4NCg==
