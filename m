Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A5F6328AE
	for <lists+linux-arch@lfdr.de>; Mon, 21 Nov 2022 16:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiKUPxe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Nov 2022 10:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiKUPxa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Nov 2022 10:53:30 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4834BCB6BA;
        Mon, 21 Nov 2022 07:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669046008; x=1700582008;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iNSCSyNkjNSdTDO+lgfA0a+TMTjzS9PVuCXO33uE6xA=;
  b=eS2A2uV18tupLYOlPNpDYiloKN88fIxJpVyNB0VH4QjEnM2fjpIbbNHj
   NEk/1wf5j+/Y5wt5us5o4E1mpTKMhazf6VdUiFzvY03z97VbPFYKnEiVm
   9whIm3LLGns85n7UvL3FtwH0qFvszEQrgT8XVgTNZQ+IOMU87oMk22LqU
   HIuowV/ea13hIHruSI6eOzhG3lCEwAMGdtXRyB+Zt6WMyazz/JjiGcxk7
   SYYLzQdRpJJAq4w6yjSwAvsGOPSBwLNh99NzP2UEjHrjfA4HIFPvWShR8
   TCtUu3dz4EICRq5M9ns4fEVgq6gP6CNxww2oY15jKCvHng4JPFB2V2gGg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="293979773"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="293979773"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 07:53:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="672135744"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="672135744"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 21 Nov 2022 07:53:27 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 07:53:26 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 21 Nov 2022 07:53:26 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 21 Nov 2022 07:53:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3hnmiVwCaHXixhMr8SgRZgpHJ/nhjgK8FBslRUecLnb/+15GPLRXiBeHzD2rQcPMrp2Tm3Z4rD1JYhy+aFO6jiclWXkQLninA2d8KcDPjR/4L1eGOaLsBVQupILOcQzUOSxe5M/z3pTp7jtPfJE8MP/Pu3x55Kx72OMwOfdqQkq/Sb/HePmc6sJNKG4MaogeDpK39mhWtv+4Eg4A+R3uWi+VSa5g0Ic019rnRrJ7QUoED2Civ40rS5y5HJaGRA7wi4z6i9m6xvKodFcPe0tO7W2nKSrBCHCGHwUBO0Vs0r170fH7o5iLXr+WHjduORCjcNgs5KDGUcd+IQjvbUEuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNSCSyNkjNSdTDO+lgfA0a+TMTjzS9PVuCXO33uE6xA=;
 b=Jv+D+b2z3JmOk578VsygeShp2oGIDWlnGpEP2iL2c6M3UcNTUkQVA0tiWAay4zKSSpereXLhg4cCxos8sHe01xGMRAjR3rLtNPUO0SGIQ0qqe/zjgQo6W1yd8upKcGOjr+dDG75Wd5pZYIFna7szygYU5CGXj76O0tvM4Utf12MzeDssnXaw8ekC4ugIAcqHSf4mOYQFPJaE+b+mNprdmbRlmGaD+1bZwctOIt8cAqhP2ETrr1P6fygwnruNPhy2ju2R4Th9QLGuk4mZ5ao1Zapfk0h8BM7Y9QXQPmddF2CUrNzlk9LIfJ8V2Ue71xcpOL5JpMf6onImno+fwoZK/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by IA1PR11MB7680.namprd11.prod.outlook.com (2603:10b6:208:3fb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 15:52:58 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3%5]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 15:52:58 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "rppt@kernel.org" <rppt@kernel.org>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
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
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v3 35/37] x86/cet: Add PTRACE interface for CET
Thread-Topic: [PATCH v3 35/37] x86/cet: Add PTRACE interface for CET
Thread-Index: AQHY8J5eaXgH6xugZk20MwPZdy8SOK5AIA2AgACAkACAAnwdkIAAf9AAgAV7KICAAIm3gA==
Date:   Mon, 21 Nov 2022 15:52:57 +0000
Message-ID: <dcbf087fb8082be8ff9be14c440a0efaee95cf93.camel@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
         <20221104223604.29615-36-rick.p.edgecombe@intel.com>
         <Y3Olme4Nl+VOkjAH@hirez.programming.kicks-ass.net>
         <223bf306716f5eb68e4f9fd660414c84cddd9886.camel@intel.com>
         <CY4PR11MB2005AD47BA1D97BC1A96A769F9069@CY4PR11MB2005.namprd11.prod.outlook.com>
         <a2c2552fcdba1a0fce0d02aeb519d33cac83bfd2.camel@intel.com>
         <Y3srU89TAwMURoEj@kernel.org>
In-Reply-To: <Y3srU89TAwMURoEj@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|IA1PR11MB7680:EE_
x-ms-office365-filtering-correlation-id: b162a528-e003-4c96-54e1-08dacbd875f7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1JWpqtnJi6cvO+De8m+p1dZbqYvH/cSjVm1paidzXrJe59+qe8ss/DRReSD/JELH6BVYb4+HFQ2/1mS2vNt1A7BEbDriurRsQ5NvOAwgDGoajb9ncJDAZg0h+i/7OJqQHO0QfmfQKHxw/F7FU6DV3ofnzIoGaKjMVZvMP+Kt5L8nZXf8E3jLiAiQqiWUU7ItwqsTs2wPM1/uy6T4ymcAM9fKe4oefpR4mEs0aFIgPI3XyVz89AO5/bJac99DO6suGBGGcicDYA4IHKiVYb7J3+zQXe118b77L6wtL7ffEOX++McUFqYcz7gaqAhCoIz7xN6/XBeMz4gpP2mg4ziGwy7ZLbgOS7yOYHo/E4ZuXmyoWnPG060M/ldsUBYGHhyNXRlkXtNRwDWuTGMm4v4UFrMESzX47qnDwTvY97Oiekxab7+5dZUBLLijVUTiPU287RGOK8jm9tNzB5TnytsjnZe17lGwP6bTzV6ddKvVs3u8ZVLwCp4OYcFf1Yn/CDyNgq4MtvUHSEi4yjEPnPhh1NKBNsy7Bez/fNizYKJa4YC56UEtwnTPA2izb3lyPTDHYy8LRA+3TGd0N4qoLUM6iY7vmNFYgwclJ7FbSZJOipfj0tr8EU5w/FmHieCQ2OVOqo50wdwOkDkAz3EkbWYwnKTtrUaY8QMm2jjg51xpHjol9luQyySiDKtPwprRH3qucMI/Ca0d6IZmpc8r67+KXlbV9CRLyGOJmmZfhSqDubk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199015)(36756003)(8676002)(86362001)(38070700005)(7416002)(7406005)(4326008)(2906002)(82960400001)(4001150100001)(8936002)(38100700002)(122000001)(83380400001)(6916009)(91956017)(316002)(54906003)(2616005)(66946007)(76116006)(6486002)(64756008)(186003)(478600001)(66556008)(66476007)(41300700001)(66446008)(5660300002)(6506007)(71200400001)(6512007)(26005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wmp3VUZaMVRTamo2WlphOXhPMHNMTEhnZ2RwWkc4dENMTG9TNkNzQ3d2VWhS?=
 =?utf-8?B?M2tnU1BIMEYxa1haekQ4UElFYVdteVZFalNFS0t1YnV6cFpCUGxNK0JpMFZo?=
 =?utf-8?B?T1JlbFd5NGhvOUhaTDZJeElxelg3RXNWRDY1QnBPYTdzUTgzL3A0QVVjM1Iw?=
 =?utf-8?B?RzRUWkx4OXdEckxYbXdiM0dDcHZwTjRJZ1BCMmRONFRiLzZFaEE5bkZTcWNF?=
 =?utf-8?B?MGNQVkdpZkszcUV6YUdWYUNTRW4xV29NMXc0VFBaeTJxam9YWG84bHlGSG9a?=
 =?utf-8?B?bUYrMk8wTWh1RDFmNEd3ei9QQmhNVUZPNDJnaXZXZG1DQTFtbWVQU0phTVZk?=
 =?utf-8?B?K0VqWFkxZkJWL3MzaHM5SjhZQXQ4ZjlsWVE4eG5ab0NnQVlCeXBIMHpuOTli?=
 =?utf-8?B?Vi96Z0xDdUZIOEovYVBldGlSZUxYbmsyUWlSNzJ6NWhTY2VzL2NsYjl2dC93?=
 =?utf-8?B?d1A2S1RhdXJ3RS9nUTVoN0tGOHNWWTBLSmZzb2RxUjcwZS9KRnRwa3dlWFhn?=
 =?utf-8?B?dFAzOFNIejVVamVsNDZTU2RRRUlZOENoR1ZhU2hoL1JTaFVaSmN6OEN0YW5H?=
 =?utf-8?B?NmQwYnFkTVUxVWxPdENMK2ZjQmFrZ1Q1N2EwczlER3p4ZHhtUzUvUzZZZ0Q0?=
 =?utf-8?B?VmltWmpqNHBhaWZSS1Q4UEVKeldFUmtYYVRsdEhvMEdpWnFEaU9vYnI2OHFK?=
 =?utf-8?B?U09GWjR4UCtTQjd4ZFlVUjE5bmloa1Y3Z3NUSTBQK1c4K3pIOXQ2SEhyRi81?=
 =?utf-8?B?aU1TajM2K0c2TVNNWENrQjdLQjlQcGZ1SUNpWTczL2NoU3NNUVpzSDNGc3Vn?=
 =?utf-8?B?TGVLbTJCemxrNVdZNU9RV21nK0d4UFlJTCtXTzEyYU5kei8weWdVKzVhQWFM?=
 =?utf-8?B?MktUWnRPT2g2RCtDalk5ckFKbXh6RjJKankrYXROcWFoNmt2a2c5eUtyZFNK?=
 =?utf-8?B?UURmZDJVRHpSSnhkQW50SXZ1SHFJWGdsNXVjdXB1ZlU2VjBJZkoyZkZNanVz?=
 =?utf-8?B?a05JTGxPak51Y2dUbkRKdzJCeDZMUTRBRzlVQTBXSElmR2F1WEZDMG9aalZS?=
 =?utf-8?B?VEdydmdIL1Q2Y1VxQXRKN29UbmVndGZKVXcwUzNIbjUydzY4amdIMHRYM3Vp?=
 =?utf-8?B?ZXM5U2NnOWhpVzhmZWZVQ3BLeWYvam05WHlQK0FiSGN2akM4MWFlckpDY01v?=
 =?utf-8?B?WWk5OUZzZlNTMU5VUnBZWGFhT3M0NkxpbGhaWDd2blU2MXFIb3U2cnBHT1Vl?=
 =?utf-8?B?Q002TFl1WFRkbXRYUGpBeUxYc2M4ZUdFREd2UkhsdjRibTB2eFRuY3l6WGNW?=
 =?utf-8?B?dVRlOUEvU1gxQzBjcTV1NVcwbTA4RkdYU3lhVU1laisvNXpCaS9zeG9YbWgw?=
 =?utf-8?B?M0gzcFJseEd3eHo5UXJNM1kzUU5KbG03anNFUS94a25UVGVRdHFleTVwUi8y?=
 =?utf-8?B?Vk8xQlFXeXZWVWtVTGhXNDQ5YVlPdFZrNzcwaDYwVGxFbkpDN2NPSk44R3B2?=
 =?utf-8?B?MVFLdkRFNWFjNFZTSHhtdDczQWxBR3d3WThURHNBZnlWZEdpblIyTmhMaDdj?=
 =?utf-8?B?SEY4ZTA0UzlLRnk3WURUQlFHYlZlSVdjY3ZXNXVKM0k0Wktock1aZWFwSmgr?=
 =?utf-8?B?L0JYbWY2Uy9rd3dVN2tidTRiTG5VdnhWT2ZkbWVIUWRaVVd0VWk3cjl1aDdW?=
 =?utf-8?B?cGQyT2VTN1RFbFRzd1U5aWRuajBKOGFndWNGMWtQWjVhMS9zdmxueGlUMkR2?=
 =?utf-8?B?dWJlVzFWQzNXbDJxQmU4NitpVlE1cEtkbkh0aHpmaFlXT2lvTEdqdHV4UHZl?=
 =?utf-8?B?NnpSTG02VTY4ekJkNHNDNHNoREcrVmVCS1JGM1JzUU1aaDFIME5DTzFXVEZr?=
 =?utf-8?B?UGtQVWFENW8vS1NFT1R6ZXgwQldMdXlzSVhwVGdvUFRQeEQ0WWdVdHZpTHha?=
 =?utf-8?B?R25kRnJ3azRNc0gwTi9QU1VPMkI3ZDlrb0x1NHZ6UkFlNjV1enZ0VmdpSWds?=
 =?utf-8?B?eDgwbFdQYko2N0NmZzJEVmlsamcrcXVzUDJqOWVhL1hsL3YyY3JmQ3Fna1p3?=
 =?utf-8?B?NG9peGRjbzIwQjJzdGVwUFhMZDJoVEpad25HdXplR3hMSlNBeDJkalQ0Mytx?=
 =?utf-8?B?Y3RaWkZyZEdWTEFOU0thdU9IVDJhWThlOGJIc0hqbm0xQUxTMy81Wkg5YTRF?=
 =?utf-8?Q?o6e/SX3S7WsMqnJWlPjEzJw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C2A3D61655715459DE01A86960DDDAC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b162a528-e003-4c96-54e1-08dacbd875f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 15:52:57.8395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DMFHIwGy6YJA4GOfRCIeRucCKFx0IaLOB/8E5XluV8j0PI9OngSJ48wsGnfyiU6ONfOvBKM3kAefQu930nDUnDlmzDNNSx0NunufJS3JAgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7680
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTExLTIxIGF0IDA5OjQwICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBPbiBUaHUsIE5vdiAxNywgMjAyMiBhdCAwNzo1Nzo1OVBNICswMDAwLCBFZGdlY29tYmUsIFJp
Y2sgUCB3cm90ZToNCj4gPiBPbiBUaHUsIDIwMjItMTEtMTcgYXQgMTI6MjUgKzAwMDAsIFNjaGlt
cGUsIENocmlzdGluYSB3cm90ZToNCj4gPiA+ID4gSG1tLCB3ZSBkZWZpbml0ZWx5IG5lZWQgdG8g
YmUgYWJsZSB0byBzZXQgdGhlIFNTUC4gQ2hyaXN0aW5hLA0KPiA+ID4gPiBkb2VzDQo+ID4gPiA+
IEdEQiBuZWVkDQo+ID4gPiA+IGFueXRoaW5nIGVsc2U/IEkgdGhvdWdodCBtYXliZSB0b2dnbGlu
ZyBTSFNUS19FTj8NCj4gPiA+IA0KPiA+ID4gSW4gYWRkaXRpb24gdG8gdGhlIFNTUCwgd2Ugd2Fu
dCB0byB3cml0ZSB0aGUgQ0VUIHN0YXRlLiBGb3INCj4gPiA+IGluc3RhbmNlDQo+ID4gPiBmb3Ig
aW5mZXJpb3IgY2FsbHMsDQo+ID4gPiB3ZSB3YW50IHRvIHJlc2V0IHRoZSBJQlQgYml0cy4NCj4g
PiA+IEhvd2V2ZXIsIHdlIHdvbid0IHdyaXRlIHN0YXRlcyB0aGF0IGFyZSBkaXNhbGxvd2VkIGJ5
IEhXLg0KPiA+IA0KPiA+IFNvcnJ5LCBJIHNob3VsZCBoYXZlIGdpdmVuIG1vcmUgYmFja2dyb3Vu
ZC4gUGV0ZXIgaXMgc2F5aW5nIHdlDQo+ID4gc2hvdWxkDQo+ID4gc3BsaXQgdGhlIHB0cmFjZSBp
bnRlcmZhY2Ugc28gdGhhdCBzaGFkb3cgc3RhY2sgYW5kIElCVCBhcmUNCj4gPiBzZXBhcmF0ZS4g
DQo+ID4gVGhleSB3b3VsZCBhbHNvIG5vIGxvbmdlciBuZWNlc3NhcmlseSBtaXJyb3IgdGhlIENF
VF9VIE1TUiBmb3JtYXQuDQo+ID4gSW5zdGVhZCB0aGUga2VybmVsIHdvdWxkIGV4cG9zZSBhIGtl
cm5lbCBzcGVjaWZpYyBmb3JtYXQgdGhhdCBoYXMNCj4gPiB0aGUNCj4gPiBuZWVkZWQgYml0cyBv
ZiBzaGFkb3cgc3RhY2sgc3VwcG9ydC4gQW5kIGEgc2VwYXJhdGUgb25lIGxhdGVyIGZvcg0KPiA+
IElCVC4NCj4gPiANCj4gPiBTbyB0aGUgcXVlc3Rpb24gaXMgd2hhdCBkb2VzIHNoYWRvdyBzdGFj
ayBuZWVkIHRvIHN1cHBvcnQgZm9yDQo+ID4gcHRyYWNlDQo+ID4gYmVzaWRlcyBTU1A/IElzIGl0
IG9ubHkgU1NQPyBUaGUgb3RoZXIgZmVhdHVyZXMgYXJlIFNIU1RLX0VOIGFuZA0KPiA+IFdSU1Nf
RU4uIEl0IG1pZ2h0IGFjdHVhbGx5IGJlIG5pY2UgdG8ga2VlcCBob3cgdGhlc2UgYml0cyBnZXQN
Cj4gPiBmbGlwcGVkDQo+ID4gbW9yZSBjb250cm9sbGVkIChyZW1vdmUgdGhlbSBmcm9tIHB0cmFj
ZSkuIEl0IGxvb2tzIGxpa2UgQ1JJVQ0KPiA+IGRpZG4ndA0KPiA+IG5lZWQgdGhlbS4NCj4gDQo+
ICANCj4gQ1JJVSByZWFkcyBDRVRfVSB3aXRoIHB0cmFjZShQVFJBQ0VfR0VUUkVHU0VULCBOVF9Y
ODZfQ0VUKS4gSXQncyBkb25lDQo+IGJlZm9yZSB0aGUgaW5qZWN0aW9uIG9mIHRoZSBwYXJhc2l0
ZS4gVGhlIHZhbHVlIG9mIFNIU1RLX0VOIGlzIHVzZWQNCj4gdGhlbiB0bw0KPiBkZXRlY3QgaWYg
c2hhZG93IHN0YWNrIGlzIGVuYWJsZWQgYW5kIHRvIHNldHVwIHZpY3RpbSdzIHNoYWRvdyBzdGFj
aw0KPiBmb3INCj4gc2lncmV0dXJuLg0KDQpIbW0sIGNhbiBpdCByZWFkIC9wcm9jL3BpZC9zdGF0
dXM/IEl0IGhhcyBzb21lIGxpbmVzIGxpa2UgdGhpczoNCng4Nl9UaHJlYWRfZmVhdHVyZXM6IHNo
c3RrIHdyc3MNCng4Nl9UaHJlYWRfZmVhdHVyZXNfbG9ja2VkOiBzaHN0ayB3cnNzDQoNCg==
