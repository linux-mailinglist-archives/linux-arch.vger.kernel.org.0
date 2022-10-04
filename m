Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F855F4A5B
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 22:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiJDUfO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 16:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiJDUfK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 16:35:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52A11B7B9;
        Tue,  4 Oct 2022 13:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664915708; x=1696451708;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Fh405HqIGzyTaiO7ljBSfovfkzLiWkpjbffxBTqkgis=;
  b=DyEp4/k9e2jwN1np/qs2E1k9PyX4unOzN7kgYF+4JslMjMF/YyyioCPt
   pArD87xEka5CrJUJAqDf4P4qP9qwkv+M61yNn8SmcPHmH8w5PaE08r8CU
   OCz3le4EtognUmAZqBIStcRoXJJmT508PK+8jmN43L5gDoQ551PlXmdKI
   8sqCgKTv6jdYjn9YFbBqfXrQ9HKBn7vdxUIamNUsHXxvgIkqjup8ahROa
   quSh1Rr/WuzIQZEcIEUzibG1Y/sGmiyyV1CigkZwFcFkmsh+gXMo9WKNU
   +UYEGae1bVwYs7lI987P9Wy4Rzb1rEk0MgZs0rrtbopqfHQH7TuMYY0BV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="290265175"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="290265175"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 13:35:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="686701824"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="686701824"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 04 Oct 2022 13:35:06 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 4 Oct 2022 13:35:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 4 Oct 2022 13:35:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 4 Oct 2022 13:35:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlglBmwJvPqrikpq2asNOySIpQpDcxlOGoIR2X9BtXdldd5ESs/0jajf4psunGdWhxUjLrTZU817lKQYlI/2gbdVkHAd7KtlxHRXaOmBY/f2v4xxZMvHiwOyq9Hzm7ohlt98C9FJRW5PbPnvK5ZP3geFUI+4ACnRGkqm+XAkJ87mg20XlsqusB5jKr7S21DN1nGATrFC7jJ+PwlR+0oe5GuMRqEbD0+8z0qKUc4C76y+/t4arXQbrIGWlPgl0tT5Hv2SZVvgCacV4osnAbZ25L53vDIumkgIkcp3r6DZJYaiH5DuLtQ4FfoHd3C3uzR4JuEXlOya8DrViO89fwRyvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fh405HqIGzyTaiO7ljBSfovfkzLiWkpjbffxBTqkgis=;
 b=DEUc8OIL5W6AyKPUSVg0KPjx2LZnseFhGXb9eyGri2gKa5CCK1jEbRNZITk664xmxZinDMefEk8M96SF3Mh+QvwnZbN+nOxF6V9ERyVCi6THOfMMMjrvXtIrUqextJKrpD2TiHFl1j1CfI9RHVQdy4CHQmSU3azIEDnarMhWQ0NzLinZaAxLSW6d4UqtJsKXotW3P9cAcvhINPZiK9He7XAjgIDnUNoBCG33hOcBC8G4VGvSGzxAFPWusjR4Trkw4QLrLP0Mzg24GqUovXyvvyUKugRg+RPO0w0ncFMVE3/OZ2WUUvKaC5KvURnkOI4HOgxjxCYts9wFY8EtISM1RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CH3PR11MB7275.namprd11.prod.outlook.com (2603:10b6:610:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Tue, 4 Oct
 2022 20:34:54 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.028; Tue, 4 Oct 2022
 20:34:54 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "nathan@kernel.org" <nathan@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "john.allen@amd.com" <john.allen@amd.com>
CC:     "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "babu.moger@amd.com" <babu.moger@amd.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 33/39] x86/cpufeatures: Limit shadow stack to Intel
 CPUs
Thread-Topic: [PATCH v2 33/39] x86/cpufeatures: Limit shadow stack to Intel
 CPUs
Thread-Index: AQHY1FMn8lBh+KlmckGpJ8Z/vQs/Tq39XyQAgAADPACAAE+7AIAAtm0AgABB7YCAAA5ogA==
Date:   Tue, 4 Oct 2022 20:34:54 +0000
Message-ID: <9e9396e207529af53b4755cce9d1744c0691e8b2.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-34-rick.p.edgecombe@intel.com>
         <202210031656.23FAA3195@keescook>
         <559f937f-cab4-d408-6d95-fc85b4809aa9@intel.com>
         <202210032147.ED1310CEA8@keescook> <YzxViiyfMRKrmoMY@dev-arch.thelio-3990X>
         <ae5fea4b-8c33-c523-9d6d-3f27a9ae03d0@amd.com>
In-Reply-To: <ae5fea4b-8c33-c523-9d6d-3f27a9ae03d0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|CH3PR11MB7275:EE_
x-ms-office365-filtering-correlation-id: 7e995b4f-a117-412d-a028-08daa647e4fa
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nb5tlbzTN0JLI9rG/WiZLEtV+ym9z7kjAG+0JrqzPo+1LquAgk79VrFbuVpm6N5fuEGPRIg4+WPKhH7QqNkjpj6YnQRe0q4/RcmoN/XIwQ/hTUfuBsrtroHvBwg7rm73Wwgrhr9I1BtKVq911zldRUexUnLyfB2/YsXEKodgjG15AIIc55rG/9A1AYb2dfzoyRjRejWlj+9ZpqWHXaxTBc4zhuG6iDTdpzUGs4xRopMSdnuzBtQccMVHJ31VoTHh5xHs+LfX2pIZttWKaK3WM9qe0gqKZutUScGocjul8aX9lLLsBwe3bJ2iPN7F4zL5B9RcfT4NJOH6/yFTG256K6nS3X4xkgNc/q0DkeUv9AiUgM7IlqSSoHyh4c+fbCupkhWmXdVcThYPBua1MihlBbERpqQ9hZ7Z5StiytZYzv8rsIKagbggheKStWYMMQmEOlrgFzm22tCPgfRyYpNbZGUG2SOlFS0du81+SEqSqniJArcL1CsqhmR0W/Q+VHXY2hdoELc/J73NJizo6XkuUeMOTVThtW1TQDWM8OepKHUKX6H0xKUcHi4QAZUnr3zSK9cgh4NCAW5+tekXxP0aXCQrf2yqI1pgHjT2cIZH3kOUOGK5K2/uV3Zv2r+mplFAPSJVgjIsZRgMD2WGlBosN0AWsw7Zh7E/YuYsU7GT2gQ8Bj0lTayvduf+s9R7jrVQHKEAnvktKTYSeGP9+ChDL5ErvKbCFnK3SRHExWaFCmnnZEDA01ZQomdEXnSXJyCs+WckEeOpwqQ6vWgQ5fSngnC6eOdH8AnSGqpG8D8TVW8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199015)(5660300002)(122000001)(82960400001)(38100700002)(66476007)(38070700005)(6506007)(6512007)(6486002)(8936002)(2906002)(71200400001)(7406005)(64756008)(53546011)(7416002)(36756003)(26005)(66556008)(54906003)(110136005)(8676002)(4326008)(83380400001)(41300700001)(478600001)(91956017)(86362001)(66446008)(76116006)(316002)(2616005)(186003)(66946007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnJQcVNDZTVvd1pENVhDSDQxZjBoS1VsLy8zRWRBSFFQQTcyKzJWMFFSSEhx?=
 =?utf-8?B?N1FOMjFSUzluR05tZC96c3EwbElxL3ZITllINWtnNHJGb1RKTnBQRVM3NWY0?=
 =?utf-8?B?VXBIdUxPai9lcmNiaXBFajQxalh0VW9lVVJFbWZYZ0FLUm9JK2s1SXRFUGJB?=
 =?utf-8?B?a1NXdHNDSmVzbVJZRG9yaTVjTjNpUVpKaEo3Qi80WTc0c09yYlA4c0t1T2ho?=
 =?utf-8?B?NFdFZFR1SUJ5N2FVK2FBTVJFRy83MFk4eW5teG9ia01uWkppVzFtNk5kM1Zq?=
 =?utf-8?B?ZjhtYXdCbWtVY1U1WGNmbnRFQmw0ZHJFTlBUN1RmU2VhNGVUc1UvZlFnbDFZ?=
 =?utf-8?B?dG9LbkdWaXUrWEszeTZRbkVIQVMranYxMGs3V3l3djZIRjlMU3NNa2lQMXVT?=
 =?utf-8?B?SVM0QTA5OVBTV1FSaWdxbGZwU2JVMEM4eDNsVG1FaHR4RjB3bTdLRnRabS9v?=
 =?utf-8?B?MFlsaHBrTi9JcVN0aUxJRUxhL21lUWh6dFZvK2prVE9nZ21vVnd5Y1l2L3ZO?=
 =?utf-8?B?UDE3NEppcWFvdnJwVjZHZncyMHZiSjBVUTBJZXBnRHcrYjFmTnlBVUFPMUJu?=
 =?utf-8?B?N1FSR2xxSWlrbE5zc3VoZThIVGcrV3pucDY0aWVnWlBzRFlWM2NnTUdpYUx3?=
 =?utf-8?B?ZHlKc1FUSGdsVkdpYWxVdFNKOW9YM0ZoYWtUYS8rb0g5SkNaN05OOXptSElC?=
 =?utf-8?B?ZkNDbnZxMVYva2JPL2pVNVpXSUNjWkJxcmN0SGYxR25UTVRxSm1iR1E0dksy?=
 =?utf-8?B?em0zTnVhUXM5cGpFT1ZTTFJrL2NVU0FjTEtxak1sNFZxd1MxN0c4VVJtYTRj?=
 =?utf-8?B?bGtPejk2bk5SVkYrNHY0dmRTU1E2TFNVd2FHN1JTVHMrTVp6eTVTL3hiWDdM?=
 =?utf-8?B?NFd5Z0VRTUkwVlhIM0N5U3BKRXpOeDNMdzR2SEc5WUpNUysvR2NxMTBvcldM?=
 =?utf-8?B?UHR4KzBaT3QrVWZLbHdaVGpPVVZOK0d6eFI5dlVVdkZpVjRLam9ZRU9KSlNN?=
 =?utf-8?B?dWpTeTFITlZWc2VDcFNqenBHQ2tMdTVjYlNrZjNVcDFuWkdJT2t4QTVTaENq?=
 =?utf-8?B?K1g5ZUMvT01jRjBIbXAxUUdyYjFBRlQzT2xUemFrcjNqWHQ4MjNmRmJPYXpR?=
 =?utf-8?B?dm05WWxLMXlMZTZSa3dvVnZiYkxEOHZLRXFqYnB5YmVZY1Z5OW5rWWFjNzU2?=
 =?utf-8?B?TUxNaGpkTVRNMk0ySWhCa3h5ZTdFY05XLzA1aFg4MVRSellwaWVYNVhMUG9K?=
 =?utf-8?B?aGQwVjF1aU5sakp5bVZySGc4T0U0dGpxZzIwY3hQSDZ3MjlGZXE1cHRaMms5?=
 =?utf-8?B?bCtQLzJvVUE0bWF5VUl6MUxZa09SaGRnM1B4bFRHc1dvTjJmN24rbHlNWndI?=
 =?utf-8?B?STNFWk5sVWRPMThmMDhXNnlTV2NodlpYdHdLLzAyekx3VWtIVi9OaHVlYitO?=
 =?utf-8?B?VDh2ampSOVRpKzJQOU82WVVvZVRBYmxRSlFUU0N1UmZRTTBLUS8zWE9QT241?=
 =?utf-8?B?K2hwR0h5VldPbjdPUUZkSUk2MStNaXhUSlpubk8xTDhWVmF3S21xalpVU1lJ?=
 =?utf-8?B?NzlmSWpyeGFoZ08rM3pKYTZ2SlBqMEhEek5wL3NDUlhZbk4vdFVieHBuV3Yw?=
 =?utf-8?B?SzhjaVZUWEtrWVhFZjExdmRzT2VSSW1SV0lOVUVRcEE4Zlh0OXJ2ZzAyR2RG?=
 =?utf-8?B?bXJBNytET3paajZ3aks0Sks1bGI3YmFtRlJ5b2Y0NlQ0Z3BoMVBTb1AyLzV1?=
 =?utf-8?B?UWhaL0dRdXdFWHFpejlROHBaTmQ5Z3lwTEtpYlNKdzd4ODFRczBiLzVZbG0r?=
 =?utf-8?B?RFlQZi9FMlZzWnc1MXluNEJWT0NZOTNWbFpPSmxtbE5VQUxPYWpMTFdzWmhY?=
 =?utf-8?B?dlc4bEZlSjcyVWdIZCtSdzZiRDdsTEh4bkRhMmFqTEpWa1NRKzRsVTZ6eVc5?=
 =?utf-8?B?bVRtOW1CclFHL2Z5dFRad1FnQWdJVmQvZy9tQXh2RkF5d0xOSitGSVYzSzVM?=
 =?utf-8?B?c1M3YzVYalBSVEtOV0t2V0l5Z3pWRnNVL0FZcFBMU1F3aVFYY1BJQ0hpTXJo?=
 =?utf-8?B?d1N3RlRmcFJVYUs1VFJQeE9nVmUyMG9jcHJQNjR2Um51NTFOVGRBTWR4ekM4?=
 =?utf-8?B?YWFzbXNTNFNmTU9FSjRZcC9jeVVaZFQvZGhnSGFDWDFReUFsdk1zSDBWY2Rz?=
 =?utf-8?Q?kLcpN1dEPvP8KNtD8T3VXR0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33FA7333148F5F478CE29BA3D31DD078@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e995b4f-a117-412d-a028-08daa647e4fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 20:34:54.0553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CJJ0jSl42Sdtm+0bMDbWuuIQVCQeRDDyJDjAr026MTG9ljnAVo5sMwQpWC7fQ8nkfqzL5Cy5aRMH4T/Ydr6LXSFWqrk1yabLXyqz2SyZUI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7275
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

T24gVHVlLCAyMDIyLTEwLTA0IGF0IDE0OjQzIC0wNTAwLCBKb2huIEFsbGVuIHdyb3RlOg0KPiBP
biAxMC80LzIyIDEwOjQ3IEFNLCBOYXRoYW4gQ2hhbmNlbGxvciB3cm90ZToNCj4gPiBIaSBLZWVz
LA0KPiA+IA0KPiA+IE9uIE1vbiwgT2N0IDAzLCAyMDIyIGF0IDA5OjU0OjI2UE0gLTA3MDAsIEtl
ZXMgQ29vayB3cm90ZToNCj4gPiA+IE9uIE1vbiwgT2N0IDAzLCAyMDIyIGF0IDA1OjA5OjA0UE0g
LTA3MDAsIERhdmUgSGFuc2VuIHdyb3RlOg0KPiA+ID4gPiBPbiAxMC8zLzIyIDE2OjU3LCBLZWVz
IENvb2sgd3JvdGU6DQo+ID4gPiA+ID4gT24gVGh1LCBTZXAgMjksIDIwMjIgYXQgMDM6Mjk6MzBQ
TSAtMDcwMCwgUmljayBFZGdlY29tYmUNCj4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+IFNo
YWRvdyBzdGFjayBpcyBzdXBwb3J0ZWQgb24gbmV3ZXIgQU1EIHByb2Nlc3NvcnMsIGJ1dCB0aGUN
Cj4gPiA+ID4gPiA+IGtlcm5lbA0KPiA+ID4gPiA+ID4gaW1wbGVtZW50YXRpb24gaGFzIG5vdCBi
ZWVuIHRlc3RlZCBvbiB0aGVtLiBQcmV2ZW50IGJhc2ljDQo+ID4gPiA+ID4gPiBpc3N1ZXMgZnJv
bQ0KPiA+ID4gPiA+ID4gc2hvd2luZyB1cCBmb3Igbm9ybWFsIHVzZXJzIGJ5IGRpc2FibGluZyBz
aGFkb3cgc3RhY2sgb24NCj4gPiA+ID4gPiA+IGFsbCBDUFVzIGV4Y2VwdA0KPiA+ID4gPiA+ID4g
SW50ZWwgdW50aWwgaXQgaGFzIGJlZW4gdGVzdGVkLiBBdCB3aGljaCBwb2ludCB0aGUNCj4gPiA+
ID4gPiA+IGxpbWl0YXRpb24gc2hvdWxkIGJlDQo+ID4gPiA+ID4gPiByZW1vdmVkLg0KPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5w
LmVkZ2Vjb21iZUBpbnRlbC5jb20+DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gU28gcnVubmluZyB0
aGUgc2VsZnRlc3RzIG9uIGFuIEFNRCBzeXN0ZW0gaXMgc3VmZmljaWVudCB0bw0KPiA+ID4gPiA+
IGRyb3AgdGhpcw0KPiA+ID4gPiA+IHBhdGNoPw0KPiA+ID4gPiANCj4gPiA+ID4gWWVzLCB0aGF0
J3MgZW5vdWdoLg0KPiA+ID4gPiANCj4gPiA+ID4gSSBfdGhvdWdodF8gdGhlIEFNRCBmb2xrcyBw
cm92aWRlZCBzb21lIHRlc3RlZC1ieSdzIGF0IHNvbWUNCj4gPiA+ID4gcG9pbnQgaW4gdGhlDQo+
ID4gPiA+IHBhc3QuICBCdXQsIG1heWJlIEknbSBjb25mdXNpbmcgdGhpcyBmb3Igb25lIG9mIHRo
ZSBvdGhlcg0KPiA+ID4gPiBzaGFyZWQNCj4gPiA+ID4gZmVhdHVyZXMuICBFaXRoZXIgd2F5LCBJ
J20gc3VyZSBubyB0ZXN0ZWQtYnkncyB3ZXJlIGRyb3BwZWQgb24NCj4gPiA+ID4gcHVycG9zZS4N
Cj4gPiA+ID4gDQo+ID4gPiA+IEknbSBzdXJlIFJpY2sgaXMgZWFnZXIgdG8gdHJpbSBkb3duIGhp
cyBzZXJpZXMgYW5kIHRoaXMgd291bGQNCj4gPiA+ID4gYmUgYSBncmVhdA0KPiA+ID4gPiBwYXRj
aCB0byBkcm9wLiAgRG9lcyBhbnlvbmUgd2FudCB0byBtYWtlIHRoYXQgZWFzeSBmb3IgUmljaz8N
Cj4gPiA+ID4gDQo+ID4gPiA+IDxoaW50PiA8aGludD4NCj4gPiA+IA0KPiA+ID4gSGV5IEd1c3Rh
dm8sIE5hdGhhbiwgb3IgTmljayEgSSBrbm93IHknYWxsIGhhdmUgc29tZSBmYW5jeSBBTUQNCj4g
PiA+IHRlc3RpbmcNCj4gPiA+IHJpZ3MuIEdvdCBhIG1vbWVudCB0byBzcGluIHVwIHRoaXMgc2Vy
aWVzIGFuZCBydW4gdGhlIHNlbGZ0ZXN0cz8NCj4gPiA+IDopDQo+ID4gDQo+ID4gSSBkbyBoYXZl
IGFjY2VzcyB0byBhIHN5c3RlbSB3aXRoIGFuIEVQWUMgNzUxMywgd2hpY2ggZG9lcyBoYXZlDQo+
ID4gU2hhZG93DQo+ID4gU3RhY2sgc3VwcG9ydCAoSSBjYW4gc2VlICdzaHN0aycgaW4gdGhlICJG
bGFncyIgc2VjdGlvbiBvZiBsc2NwdQ0KPiA+IHdpdGgNCj4gPiB0aGlzIHNlcmllcykuIEFzIGZh
ciBhcyBJIHVuZGVyc3RhbmQgaXQsIEFNRCBvbmx5IGFkZGVkIFNoYWRvdw0KPiA+IFN0YWNrDQo+
ID4gd2l0aCBaZW4gMzsgbXkgcmVndWxhciBBTUQgdGVzdCBzeXN0ZW0gaXMgWmVuIDIgKHByb2Jh
Ymx5IHNob3VsZA0KPiA+IGxvb2sgYXQNCj4gPiBwcm9jdXJyaW5nIGEgWmVuIDMgb3IgWmVuIDQg
b25lIGF0IHNvbWUgcG9pbnQpLg0KPiA+IA0KPiA+IEkgYXBwbGllZCB0aGlzIHNlcmllcyBvbiB0
b3Agb2YgNi4wIGFuZCByZXZlcnRlZCB0aGlzIGNoYW5nZSB0aGVuDQo+ID4gYm9vdGVkDQo+ID4g
aXQgb24gdGhhdCBzeXN0ZW0uIEFmdGVyIGJ1aWxkaW5nIHRoZSBzZWxmdGVzdCAod2hpY2ggZGlk
IHJlcXVpcmUNCj4gPiAnbWFrZSBoZWFkZXJzX2luc3RhbGwnIGFuZCBhIHNtYWxsIGFkZGl0aW9u
IHRvIG1ha2UgaXQgYnVpbGQgYmV5b25kDQo+ID4gdGhhdCwgc2VlIGJlbG93KSwgSSByYW4gaXQg
YW5kIHRoaXMgd2FzIHRoZSByZXN1bHQuIEkgYW0gbm90IHN1cmUNCj4gPiBpZg0KPiA+IHRoYXQg
aXMgZXhwZWN0ZWQgb3Igbm90IGJ1dCB0aGUgb3RoZXIgcmVzdWx0cyBzZWVtIHByb21pc2luZyBm
b3INCj4gPiBkcm9wcGluZyB0aGlzIHBhdGNoLg0KPiA+IA0KPiA+ICAgICQgLi90ZXN0X3NoYWRv
d19zdGFja182NA0KPiA+ICAgIFtJTkZPXSAgbmV3X3NzcCA9IDdmOGEzNmM5ZmZmOCwgKm5ld19z
c3AgPSA3ZjhhMzZjYTAwMDENCj4gPiAgICBbSU5GT10gIGNoYW5naW5nIHNzcCBmcm9tIDdmOGEz
NzRhMGZmMCB0byA3ZjhhMzZjOWZmZjgNCj4gPiAgICBbSU5GT10gIHNzcCBpcyBub3cgN2Y4YTM2
Y2EwMDAwDQo+ID4gICAgW09LXSAgICBTaGFkb3cgc3RhY2sgcGl2b3QNCj4gPiAgICBbT0tdICAg
IFNoYWRvdyBzdGFjayBmYXVsdHMNCj4gPiAgICBbSU5GT10gIENvcnJ1cHRpbmcgc2hhZG93IHN0
YWNrDQo+ID4gICAgW0lORk9dICBHZW5lcmF0ZWQgc2hhZG93IHN0YWNrIHZpb2xhdGlvbiBzdWNj
ZXNzZnVsbHkNCj4gPiAgICBbT0tdICAgIFNoYWRvdyBzdGFjayB2aW9sYXRpb24gdGVzdA0KPiA+
ICAgIFtJTkZPXSAgR3VwIHJlYWQgLT4gc2hzdGsgYWNjZXNzIHN1Y2Nlc3MNCj4gPiAgICBbSU5G
T10gIEd1cCB3cml0ZSAtPiBzaHN0ayBhY2Nlc3Mgc3VjY2Vzcw0KPiA+ICAgIFtJTkZPXSAgVmlv
bGF0aW9uIGZyb20gbm9ybWFsIHdyaXRlDQo+ID4gICAgW0lORk9dICBHdXAgcmVhZCAtPiB3cml0
ZSBhY2Nlc3Mgc3VjY2Vzcw0KPiA+ICAgIFtJTkZPXSAgVmlvbGF0aW9uIGZyb20gbm9ybWFsIHdy
aXRlDQo+ID4gICAgW0lORk9dICBHdXAgd3JpdGUgLT4gd3JpdGUgYWNjZXNzIHN1Y2Nlc3MNCj4g
PiAgICBbSU5GT10gIENvdyBndXAgd3JpdGUgLT4gd3JpdGUgYWNjZXNzIHN1Y2Nlc3MNCj4gPiAg
ICBbT0tdICAgIFNoYWRvdyBndXAgdGVzdA0KPiA+ICAgIFtJTkZPXSAgVmlvbGF0aW9uIGZyb20g
c2hzdGsgYWNjZXNzDQo+ID4gICAgW09LXSAgICBtcHJvdGVjdCgpIHRlc3QNCj4gPiAgICBbT0td
ICAgIFVzZXJmYXVsdGZkIHRlc3QNCj4gPiAgICBbRkFJTF0gIEFsdCBzaGFkb3cgc3RhY2sgdGVz
dA0KPiANCj4gVGhlIHNlbGZ0ZXN0IGlzIGxvb2tpbmcgT0sgb24gbXkgc3lzdGVtIChEZWxsIFBv
d2VyRWRnZSBSNjUxNSB3LyBFUFlDDQo+IDc3MTMpLiBJIGFsc28ganVzdCBwdWxsZWQgYSBmcmVz
aCA2LjAga2VybmVsIGFuZCBhcHBsaWVkIHRoZSBzZXJpZXMNCj4gaW5jbHVkaW5nIHRoZSBmaXgg
TmF0aGFuIG1lbnRpb25zIGJlbG93Lg0KPiANCj4gJCB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy94
ODYvdGVzdF9zaGFkb3dfc3RhY2tfNjQNCj4gW0lORk9dICBuZXdfc3NwID0gN2YzMGNjY2M1ZmY4
LCAqbmV3X3NzcCA9IDdmMzBjY2NjNjAwMQ0KPiBbSU5GT10gIGNoYW5naW5nIHNzcCBmcm9tIDdm
MzBjZDRjNmZmMCB0byA3ZjMwY2NjYzVmZjgNCj4gW0lORk9dICBzc3AgaXMgbm93IDdmMzBjY2Nj
NjAwMA0KPiBbT0tdICAgIFNoYWRvdyBzdGFjayBwaXZvdA0KPiBbT0tdICAgIFNoYWRvdyBzdGFj
ayBmYXVsdHMNCj4gW0lORk9dICBDb3JydXB0aW5nIHNoYWRvdyBzdGFjaw0KPiBbSU5GT10gIEdl
bmVyYXRlZCBzaGFkb3cgc3RhY2sgdmlvbGF0aW9uIHN1Y2Nlc3NmdWxseQ0KPiBbT0tdICAgIFNo
YWRvdyBzdGFjayB2aW9sYXRpb24gdGVzdA0KPiBbSU5GT10gIEd1cCByZWFkIC0+IHNoc3RrIGFj
Y2VzcyBzdWNjZXNzDQo+IFtJTkZPXSAgR3VwIHdyaXRlIC0+IHNoc3RrIGFjY2VzcyBzdWNjZXNz
DQo+IFtJTkZPXSAgVmlvbGF0aW9uIGZyb20gbm9ybWFsIHdyaXRlDQo+IFtJTkZPXSAgR3VwIHJl
YWQgLT4gd3JpdGUgYWNjZXNzIHN1Y2Nlc3MNCj4gW0lORk9dICBWaW9sYXRpb24gZnJvbSBub3Jt
YWwgd3JpdGUNCj4gW0lORk9dICBHdXAgd3JpdGUgLT4gd3JpdGUgYWNjZXNzIHN1Y2Nlc3MNCj4g
W0lORk9dICBDb3cgZ3VwIHdyaXRlIC0+IHdyaXRlIGFjY2VzcyBzdWNjZXNzDQo+IFtPS10gICAg
U2hhZG93IGd1cCB0ZXN0DQo+IFtJTkZPXSAgVmlvbGF0aW9uIGZyb20gc2hzdGsgYWNjZXNzDQo+
IFtPS10gICAgbXByb3RlY3QoKSB0ZXN0DQo+IFtPS10gICAgVXNlcmZhdWx0ZmQgdGVzdA0KPiBb
T0tdICAgIEFsdCBzaGFkb3cgc3RhY2sgdGVzdC4NCg0KVGhhbmtzIGZvciB0aGUgdGVzdGluZy4g
QmFzZWQgb24gdGhlIHRlc3QsIEkgd29uZGVyIGlmIHRoaXMgY291bGQgYmUgYQ0KU1cgYnVnLiBO
YXRoYW4sIGNvdWxkIEkgc2VuZCB5b3UgYSB0d2Vha2VkIHRlc3Qgd2l0aCBzb21lIG1vcmUgZGVi
dWcNCmluZm9ybWF0aW9uPw0KDQpKb2huLCBhcmUgd2Ugc3VyZSBBTUQgYW5kIEludGVsIHN5c3Rl
bXMgYmVoYXZlIHRoZSBzYW1lIHdpdGggcmVzcGVjdCB0bw0KQ1BVcyBub3QgY3JlYXRpbmcgRGly
dHk9MSxXcml0ZT0wIFBURXMgaW4gcmFyZSBzaXR1YXRpb25zPyBPciBhbnkgb3RoZXINCkNFVCBy
ZWxhdGVkIGRpZmZlcmVuY2VzIHdlIHNob3VsZCBoYXNoIG91dD8gT3RoZXJ3aXNlIEknbGwgZHJv
cCB0aGUNCnBhdGNoIGZvciB0aGUgbmV4dCB2ZXJzaW9uLiAoYW5kIGFzc3VtaW5nIHRoZSBpc3N1
ZSBOYXRoYW4gaGl0IGRvZXNuJ3QNCnR1cm4gdXAgYW55dGhpbmcgSFcgcmVsYXRlZCkuDQo=
