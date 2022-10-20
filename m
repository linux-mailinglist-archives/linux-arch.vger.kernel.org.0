Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6013D606A50
	for <lists+linux-arch@lfdr.de>; Thu, 20 Oct 2022 23:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiJTV3v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Oct 2022 17:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiJTV3u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Oct 2022 17:29:50 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4307124F;
        Thu, 20 Oct 2022 14:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666301387; x=1697837387;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mXCu+6IfYv2NiZZFO3yikF3/zh8kAbx9xVyXBm0a2OE=;
  b=amG1SOlLbawC8zsalQGkQ2vjG38uV+aCN9HxIFl8c4ynkJ57zIWAz9CN
   jEgQc4lfGC9F+sKh8loaJVRFZBtOPIUFDlsHNuZTeDAvEm/PHFvSlummo
   qeK5mxn/kfp5SOsSnmoFmrA2oderLM+mUBAxVzyDzQEMhIn+qTH5kqvdX
   i25t5O78GrHC/7sYWKMBpqbgKsWdv3/ZhOFNVnEuuCvuVUeTv2yQ2JFqr
   6DfQPoDCWZRwbcHB0YvJPfcfXdNdVLJVMekXHn9DrEsG4a18ijcCNvciN
   gL0JbkiE0d1Zbwgi23T/EecqV8yOmsvnEQFJkSVuWV9Z1yM10/qEUjRwx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="287244506"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="287244506"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 14:29:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="607937804"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="607937804"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 20 Oct 2022 14:29:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 14:29:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 20 Oct 2022 14:29:45 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 20 Oct 2022 14:29:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HREmLz5C4Up8yT+36yT/CRSUCZXB7DzsEoOjU092KoE1xr1GNdUbgqQdMeIwexosmuhOc7ilh2E/Y7VW1SI/gCIkJRycGsmnmKnFYNIEvESwPXTyQSyd/ma6zkAP/SwGtVsORmk9KBlS6L0+c3n930r9moBjGaxTTfmtLooJVt/XPfrJ569uj/M618pTaiEuXfb7YY5bRyiCqnFGdBP9DkmGKIqgFj6BPX6YjGB8Mo8YC9NDjwXoBVl54vi9vvLlkRZtPZIaM6aWC53ZT19n7beYWADn2g2hLlKP4b3uUNJTU1gBlpvz1qVV0KYoEDy3hUJVsfek43I2VOrUiqyhuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXCu+6IfYv2NiZZFO3yikF3/zh8kAbx9xVyXBm0a2OE=;
 b=KZ1D+wV5WHLZ3SizCj4w5WJhjkrw4df1e/msOEEm3Mraob1EtktpWuAcAPtx6wL3Q7hATJOw52FT4dOVmJdSJULrXNTIybffYJG5hvLh/EMnKWt1RS3ZHzzSeLVC8AD2/QdNfDsYDW3z7zfn6GRNnz/WyxEIdx7di9z5EQ1e/ia+1Lpyb4rbwuGzfTII8LfcP0mtgklAOYI2/YhbKNAeC+mMlROXKUT6SewL5M57Zoxzbk2MwceSNQ2ChD23ZMTIlTmuPU3xp4bJKDieGiJeOZFK4WN9ZX8YC82+ubs32/U9w7PODLenjnss/XRgva5HCDmPWXLfXixnKwWf8FWsvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DS0PR11MB6397.namprd11.prod.outlook.com (2603:10b6:8:ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Thu, 20 Oct
 2022 21:29:40 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 21:29:38 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "keescook@chromium.org" <keescook@chromium.org>
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
Thread-Index: AQHY1FMhfYHsd4bOok+fj02ID3Hgq639GE2AgBrVKIA=
Date:   Thu, 20 Oct 2022 21:29:38 +0000
Message-ID: <d555c95554996acaf22c407e11a3daca5db141f7.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-25-rick.p.edgecombe@intel.com>
         <202210031203.EB0DC0B7DD@keescook>
In-Reply-To: <202210031203.EB0DC0B7DD@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|DS0PR11MB6397:EE_
x-ms-office365-filtering-correlation-id: 30f51e5c-22a7-4483-cfc8-08dab2e2315c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zVQkX3XO79uDZ8dmoZJn3snU9rJ7+LJb4uK4zKvirroPGygwT1rFvYmwuCcsP7I8dVQR10uf6dexdF4Nr5//p2j9AZRrYCqyBW2cfBBPz8P6AUF+VOHAZgLbZCai2MfahGJMHYnsTcwPyxjyvHirczQVxv2vfmRSnpfCfs3UFBG+/aXJ7vd55kM9jDTLAPN3kEvbQHhc0CQDo/wSBS+BInPF985R6vPhy6Lzq8CEQa2fNi1qXLH/FaYwJxqKGjSknMczK6j28nOUYq9xz06f8zAYABfOAEnHkOUDXkchWYlgvm5BUE5kEnKiV3Qd9tVGDyRuAYu3VICD5VRl2UPkDJTYFhgb5NeEuVDorRbPBBJpiwgBpXweI9Cd7hGtomJw84I5cypTJaf56FUEGXw6WvxK2HEDIjQ1g+n0G7NuMUVT8u7VGCY1TnTQc/pxQ8NV3IRMuXrzDDBGrvy37TxbAVKK0VrxYQX3hboSKduZjdsBxWYysAqp/BcFKdM4YkrXQH9vpFBnuVEM8Lf62FaPeRZHCHv5FLVyR0b913qNb23ZbiqsvcW4NcgGokNVS8mGXFPqntr46y+MwxAZXtnNDdJuwN6J4SumVSaYtZKKyv5vcynczZuZ/YYhxrh8pm41SIwQsC0vqUqQu838UHt2JeKdXO+UVOHlEm0J6SSpoYSX/tmkcW+HC8yC4l3wP8TMNDvufnDspr/t6DkWzlfbRaARCqhSro3LiTRbAcmchKqfQnw5z6HB84Q0pXAGxD7ZGJn5A4KQnrtCLUoQ96eErhol+QWyYem0YMrYl62anT8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199015)(66446008)(36756003)(6512007)(71200400001)(76116006)(54906003)(26005)(7406005)(316002)(91956017)(478600001)(6486002)(8936002)(186003)(8676002)(66946007)(2616005)(41300700001)(66556008)(4326008)(66476007)(2906002)(6916009)(83380400001)(5660300002)(122000001)(86362001)(38100700002)(64756008)(38070700005)(82960400001)(7416002)(6506007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SW85RW0vdE1nWmo1MzdiYjRoRkZua0tLVUkzVTMzVE5jKzZ6QW9jc2EyS01w?=
 =?utf-8?B?a0xsSEcrbEF5VkhKUG1JU1k0d0ZDQVNJTUNoZjZRMnlLRDNScFRHQjZYMVZn?=
 =?utf-8?B?Y0hFWDFvb3hFN05wRGlsblJJQlJkV05uOFVXVFl2cUU5aUtXSU5IMmsrbU50?=
 =?utf-8?B?d0puMlpiQ3FGcHhrMkw2S0wzNDlFN0Q0c05obHRqZE5pN21YTWdiY3RKWTBh?=
 =?utf-8?B?Rm5DK0thT09SbFcrY3ZHemhFcGNnNHk1b2ZYUlBJZHFEenVxMTMyZzR6eDN0?=
 =?utf-8?B?ZEtjdEQ3cmFIY1J4cUE2Yk9VV1p1ZDR6MTJHWVZNQ1Q1YWUzTVZPNWdXMXYx?=
 =?utf-8?B?bXVVQVh5MnNsM285VlNwaFYwU3MzeG1iUTNiUWFlOGpuVk5WQkdnbm40RVZp?=
 =?utf-8?B?WWl6K1MydlB1V2xFanN0SW1oMzduaklUZnhqMW4rL0plcHFwK0NNYVgvTzZK?=
 =?utf-8?B?ZUJFb3d4ckpMK3YyWlFROGxaclBacGtmejJERHhCZHp0MzFHdmNDbGthSi8y?=
 =?utf-8?B?UlRUSG5RSzkvcmYzMDNXcGUvRmpEMXpPemVZZ1JhVkVIVm8xd2hSRVZ4Q21D?=
 =?utf-8?B?U2laWUZQcVdkWXB1ck5pTjA3R01CVmF2RmhoVkd4UXlER2VkMmM0NE83Qm5U?=
 =?utf-8?B?TWRPbDJNT2xvb1lScFlxNUdjUXlJWkJ3bm9KcEVDVlZiKzFuM250Z0wwS2lR?=
 =?utf-8?B?cmw4ZHdzekpXbUl6OG52eUgzZXlKdThHTklzWXQ2QzBiNG50ZXc4Y1huMUJs?=
 =?utf-8?B?Rm53ejJ6THgxZkpBaEhDNzNPN2ZuUzk5ekljTFRLYXNxM09Ld3UyUTEwMDVX?=
 =?utf-8?B?N0RNT2dnOVZKY0ZLMGpLK1k1aHZ3dzFidmM2QjVYeWpPOVM5SW9zL1hMTGt2?=
 =?utf-8?B?Wjl2ODJhYzY2U0l4blV3b3g2M0hXSXlvOFhjNU40c3VMMTdNalZ2RlJhRjJD?=
 =?utf-8?B?OGpMWm9TOGEwRjVOZmlBSzBEMk9JamN5WDVWZy8vZU9VVDlaREY3M1dNZit6?=
 =?utf-8?B?WG9pc2MyaHZyVnlmSXBPb3lFZTVRbGl1SnRaVnBQcjFKS0MxRVpDd0dBTXFq?=
 =?utf-8?B?QS9iQkxhdW95a2huNnRCa1BYUkxaNGc4a2YvWlZLQ0NQcUxWT21KemcvTmF0?=
 =?utf-8?B?SVFTOEhCMVN3SVRHKzFGV01IdXdYa0lTMWkwUHpabCs2RXUwTGErcWFvRXFu?=
 =?utf-8?B?cFExc3Jvd2I1OHlNb3ppYzNGUkJKeGFqWjhWMjVqZjZLZC82dCtzQk93NWh1?=
 =?utf-8?B?STZBR0ljWUpFdWVQV3dnNEViMzJBNTFQWjA1ZWhGZDJoRmE0ekg0TExGdnpQ?=
 =?utf-8?B?YUt0WHpNbjllaG9aMUR1M1pCcmh5QStRTUxkb0VMQmI4MW1ZL1VwdW5rN1Zz?=
 =?utf-8?B?ZzNsdyttaFdacnVRS1dpa3g4czVWMmE5YjRKRVRiZncwSm9CZitDdGJuNkZP?=
 =?utf-8?B?c3dISTZYTnM4b3l0OEVyS0Uyb2pJVnl2bWxlUjFNK3BSS01OOFJ1Q3BkN3Vk?=
 =?utf-8?B?aEhTbVR5NFFUVWJYeEN1KzFwQTQwTk83V241YkhlaGF3KytTQ3JKVWNKcVRy?=
 =?utf-8?B?ZXQrN0xtUGNGTDVYQVdMS240SEtsTUV4alc0OGRnY3F2UE5TWUMxMUVUVGVV?=
 =?utf-8?B?RmpaZnZOejNhbXpYNUMySTJla0dIYWhaUkhWeXdCMFRnOWRSMjhLMHN6ODBr?=
 =?utf-8?B?U25rVkIvZWd5U2MxdkpvNFBQbkdQZ3hoejBuNmpzNDJFR0dTSmFZZHZOcTdz?=
 =?utf-8?B?ZlhpQ3U4R2RBb1FFRkFwYXQzS21QRWZXK1JITkZiaG92N28vYk15aXRsRFg1?=
 =?utf-8?B?Y2V3VnQwY3kvZUQrS0cxMnZ6NHlDcWhHMFF2bzk2UGdIQ2pOb2Z5dEh5YnJM?=
 =?utf-8?B?bUJvRTl0NUwzbkJwUUpERXo3MU11MWx4VnJNOVNvbldYOFNocC9kZjd4Y25m?=
 =?utf-8?B?anRwZU1YUEhxVGlJSFFFSHBsMzJSclJndlp4Z1JwK0lCemJIaHhVRDZIQW8y?=
 =?utf-8?B?QW9XOXg0NWppaEJUWnE5VHE0YklOVnlIRUpqNWx2T04zTWRqTy9sTTJnUDJ1?=
 =?utf-8?B?L2N1Tm44cnpFVmhXblRiK29NWkRCaUdpc2U4RVdhK1FzNXJCVWNVeDl2dnZE?=
 =?utf-8?B?ZlpHemVKVXFmeHpacFlpKzRXRm4vNmJCSC9hMmlTNm5JVjFYTVU2bEFvbVNH?=
 =?utf-8?Q?EQX8cdj6EFE0yDBFvi64Dvw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3A3306D0DCF0D49B3AFF930F221582F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f51e5c-22a7-4483-cfc8-08dab2e2315c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 21:29:38.6396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zcIUaxu5nLh0jUuHyH8rntMSNOQ+69F7vjUBWG2AYPndSiKcRCpQXrncVj8aleifLQ8MGYk7swRAg5XHkIVP3144PVYDgqNoQ4JQu8Y/B5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6397
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

SnVzdCBub3cgcmVhbGl6aW5nLCBJIG5ldmVyIHJlc3BvbmRlZCB0byBtb3N0IG9mIHRoaXMgZmVl
ZGJhY2sgYXMgdGhlDQpsYXRlciBjb252ZXJzYXRpb24gZm9jdXNlZCBpbiBvbiBvbmUgYXJlYS4g
QWxsIHNlZW1zIGdvb2QgKHRoYW5rcyEpLA0KZXhjZXB0IG5vdCBzdXJlIGFib3V0IHRoZSBiZWxv
dzoNCg0KT24gTW9uLCAyMDIyLTEwLTAzIGF0IDEyOjQzIC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6
DQo+IE9uIFRodSwgU2VwIDI5LCAyMDIyIGF0IDAzOjI5OjIxUE0gLTA3MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+ICsNCj4gPiArCW1tYXBfd3JpdGVfbG9jayhtbSk7DQo+ID4gKwlhZGRy
ID0gZG9fbW1hcChOVUxMLCBhZGRyLCBzaXplLCBQUk9UX1JFQUQsIGZsYWdzLA0KPiA+ICsJCSAg
ICAgICBWTV9TSEFET1dfU1RBQ0sgfCBWTV9XUklURSwgMCwgJnVudXNlZCwgTlVMTCk7DQo+IA0K
PiBUaGlzIHdpbGwgdXNlIHRoZSBtbWFwIGJhc2UgYWRkcmVzcyBvZmZzZXQgcmFuZG9taXphdGlv
biwgSSBndWVzcz8NCg0KWWVzLg0KDQo+IA0KPiA+ICsNCj4gPiArCW1tYXBfd3JpdGVfdW5sb2Nr
KG1tKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gYWRkcjsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3Rh
dGljIHZvaWQgdW5tYXBfc2hhZG93X3N0YWNrKHU2NCBiYXNlLCB1NjQgc2l6ZSkNCj4gPiArew0K
PiA+ICsJd2hpbGUgKDEpIHsNCj4gPiArCQlpbnQgcjsNCj4gPiArDQo+ID4gKwkJciA9IHZtX211
bm1hcChiYXNlLCBzaXplKTsNCj4gPiArDQo+ID4gKwkJLyoNCj4gPiArCQkgKiB2bV9tdW5tYXAo
KSByZXR1cm5zIC1FSU5UUiB3aGVuIG1tYXBfbG9jayBpcyBoZWxkIGJ5DQo+ID4gKwkJICogc29t
ZXRoaW5nIGVsc2UsIGFuZCB0aGF0IGxvY2sgc2hvdWxkIG5vdCBiZSBoZWxkIGZvcg0KPiA+IGEN
Cj4gPiArCQkgKiBsb25nIHRpbWUuICBSZXRyeSBpdCBmb3IgdGhlIGNhc2UuDQo+ID4gKwkJICov
DQo+ID4gKwkJaWYgKHIgPT0gLUVJTlRSKSB7DQo+ID4gKwkJCWNvbmRfcmVzY2hlZCgpOw0KPiA+
ICsJCQljb250aW51ZTsNCj4gPiArCQl9DQo+ID4gKw0KPiA+ICsJCS8qDQo+ID4gKwkJICogRm9y
IGFsbCBvdGhlciB0eXBlcyBvZiB2bV9tdW5tYXAoKSBmYWlsdXJlLCBlaXRoZXINCj4gPiB0aGUN
Cj4gPiArCQkgKiBzeXN0ZW0gaXMgb3V0IG9mIG1lbW9yeSBvciB0aGVyZSBpcyBidWcuDQo+ID4g
KwkJICovDQo+ID4gKwkJV0FSTl9PTl9PTkNFKHIpOw0KPiA+ICsJCWJyZWFrOw0KPiA+ICsJfQ0K
PiA+ICt9DQo+ID4gKw0KPiA+ICtpbnQgc2hzdGtfc2V0dXAodm9pZCkNCj4gDQo+IE9ubHkgY2Fs
bGVkIGxvY2FsLiBNYWtlIHN0YXRpYz8NCj4gDQo+ID4gK3sNCj4gPiArCXN0cnVjdCB0aHJlYWRf
c2hzdGsgKnNoc3RrID0gJmN1cnJlbnQtPnRocmVhZC5zaHN0azsNCj4gPiArCXVuc2lnbmVkIGxv
bmcgYWRkciwgc2l6ZTsNCj4gPiArDQo+ID4gKwkvKiBBbHJlYWR5IGVuYWJsZWQgKi8NCj4gPiAr
CWlmIChmZWF0dXJlX2VuYWJsZWQoQ0VUX1NIU1RLKSkNCj4gPiArCQlyZXR1cm4gMDsNCj4gPiAr
DQo+ID4gKwkvKiBBbHNvIG5vdCBzdXBwb3J0ZWQgZm9yIDMyIGJpdCAqLw0KPiA+ICsJaWYgKCFj
cHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX1NIU1RLKSB8fA0KPiA+IGluX2lhMzJfc3lz
Y2FsbCgpKQ0KPiA+ICsJCXJldHVybiAtRU9QTk9UU1VQUDsNCj4gPiArDQo+ID4gKwlzaXplID0g
UEFHRV9BTElHTihtaW5fdCh1bnNpZ25lZCBsb25nIGxvbmcsDQo+ID4gcmxpbWl0KFJMSU1JVF9T
VEFDSyksIFNaXzRHKSk7DQo+ID4gKwlhZGRyID0gYWxsb2Nfc2hzdGsoc2l6ZSk7DQo+ID4gKwlp
ZiAoSVNfRVJSX1ZBTFVFKGFkZHIpKQ0KPiA+ICsJCXJldHVybiBQVFJfRVJSKCh2b2lkICopYWRk
cik7DQo+ID4gKw0KPiA+ICsJZnB1X2xvY2tfYW5kX2xvYWQoKTsNCj4gPiArCXdybXNybChNU1Jf
SUEzMl9QTDNfU1NQLCBhZGRyICsgc2l6ZSk7DQo+ID4gKwl3cm1zcmwoTVNSX0lBMzJfVV9DRVQs
IENFVF9TSFNUS19FTik7DQo+ID4gKwlmcHJlZ3NfdW5sb2NrKCk7DQo+ID4gKw0KPiA+ICsJc2hz
dGstPmJhc2UgPSBhZGRyOw0KPiA+ICsJc2hzdGstPnNpemUgPSBzaXplOw0KPiA+ICsJZmVhdHVy
ZV9zZXQoQ0VUX1NIU1RLKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsN
Cj4gPiArdm9pZCByZXNldF90aHJlYWRfc2hzdGsodm9pZCkNCj4gPiArew0KPiA+ICsJbWVtc2V0
KCZjdXJyZW50LT50aHJlYWQuc2hzdGssIDAsIHNpemVvZihzdHJ1Y3QgdGhyZWFkX3Noc3RrKSk7
DQo+ID4gKwljdXJyZW50LT50aHJlYWQuZmVhdHVyZXMgPSAwOw0KPiA+ICsJY3VycmVudC0+dGhy
ZWFkLmZlYXR1cmVzX2xvY2tlZCA9IDA7DQo+ID4gK30NCj4gDQo+IElmIGZlYXR1cmVzIGlzIGFs
d2F5cyBnb2luZyB0byBiZSB0aWVkIHRvIHNoc3RrLCB3aHkgbm90IHB1dCB0aGVtIGluDQo+IHRo
ZQ0KPiBzaHN0ayBzdHJ1Y3Q/DQoNCkNFVCBhbmQgTEFNIHVzZWQgdG8gc2hhcmUgYW4gZW5hYmxp
bmcgaW50ZXJmYWNlIGFuZCBhbHNvIGtlcm5lbCBzaWRlDQplbmFibGVtZW50IHN0YXRlIHRyYWNr
aW5nLiBCdXQgaW4gdGhlIGVuZCBMQU0gZ290IGl0cyBvd24gZW5hYmxpbmcNCmludGVyZmFjZS4g
VGhvbWFzIGhhZCBzdWdnZXN0ZWQgdGhhdCB0aGV5IGNvdWxkIHNoYXJlIGEgc3RhdGUgZmllbGQg
b24NCnRoZSBrZXJuZWwgc2lkZS4gQnV0IHRoZW4gTEFNIGFscmVhZHkgaGFkIGVub3VnaCBzdGF0
ZSB0cmFja2luZyBmb3INCml0J3MgbmVlZHMuDQoNClNoYWRvdyBzdGFjayB1c2VkIHRvIHRyYWNr
IGVuYWJsaW5nIHdpdGggdGhlIGZpZWxkcyBpbiB0aGUgc2hzdGsgc3RydWN0DQp0aGF0IGtlZXAg
dHJhY2sgb2YgdGhlIHRocmVhZHMgc2hhZG93IHN0YWNrLiBCdXQgdGhlbiB3ZSBhZGRlZCBXUlNT
DQp3aGljaCBuZWVkcyBhbm90aGVyIGZpZWxkIHRvIGtlZXAgdHJhY2sgb2YgdGhlIHN0YXR1cy4g
U28gSSB0aG91Z2h0IHRvDQpsZWF2ZSB0aGUgJ2ZlYXR1cmVzJyBmaWVsZCBhbmQgdXNlIGl0IGZv
ciBhbGwgdGhlIENFVCBmZWF0dXJlcw0KdHJhY2tpbmcuIEkgbGVmdCBpdCBvdXRzaWRlIG9mIHRo
ZSBzaHN0ayBzdHJ1Y3Qgc28gaXQgbG9va3MgdXNhYmxlIGZvcg0KYW55IG90aGVyIGZlYXR1cmVz
IHRoYXQgbWlnaHQgYmUgbG9va2luZyBmb3IgYW4gc3RhdHVzIGJpdC4gSSBjYW4NCmRlZmluaXRl
bHkgY29tcGlsZSBpdCBvdXQgd2hlbiB0aGVyZSBpcyBubyB1c2VyIHNoYWRvdyBzdGFjay4NCg0K
c25pcA0KDQoNCj4gPiArDQo+ID4gK3ZvaWQgc2hzdGtfZnJlZShzdHJ1Y3QgdGFza19zdHJ1Y3Qg
KnRzaykNCj4gPiArew0KPiA+ICsJc3RydWN0IHRocmVhZF9zaHN0ayAqc2hzdGsgPSAmdHNrLT50
aHJlYWQuc2hzdGs7DQo+ID4gKw0KPiA+ICsJaWYgKCFjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9G
RUFUVVJFX1NIU1RLKSB8fA0KPiA+ICsJICAgICFmZWF0dXJlX2VuYWJsZWQoQ0VUX1NIU1RLKSkN
Cj4gPiArCQlyZXR1cm47DQo+ID4gKw0KPiA+ICsJaWYgKCF0c2stPm1tKQ0KPiA+ICsJCXJldHVy
bjsNCj4gPiArDQo+ID4gKwl1bm1hcF9zaGFkb3dfc3RhY2soc2hzdGstPmJhc2UsIHNoc3RrLT5z
aXplKTsNCj4gDQo+IEkgZmVlbCBsaWtlIGJhc2UgYW5kIHNpemUgc2hvdWxkIGJlIHplcm9lZCBo
ZXJlPw0KPiANCg0KVGhlIGNvZGUgdXNlZCB0byB1c2Ugc2hzdGstPmJhc2UgYW5kIHNoc3RrLT5z
aXplIHRvIGtlZXAgdHJhY2sgb2YgaWYNCnNoYWRvdyBzdGFjayB3YXMgZW5hYmxlZC4gSSdtIG5v
dCBzdXJlIHdoeSB0byB6ZXJvIGl0IG5vdy4gSnVzdA0KZGVmZW5zaXZlbHkgb3IgZGlkIHlvdSBz
ZWUgYSBjb25jcmV0ZSBpc3N1ZT8NCg==
