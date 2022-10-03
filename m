Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316BC5F38BA
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 00:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiJCWUr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 18:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiJCWUq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 18:20:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE2B52E49;
        Mon,  3 Oct 2022 15:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664835644; x=1696371644;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fzQP40Xk77O3OheaSOHjbyOE7OQvMSlKMArekNbbDig=;
  b=ZA3T+fxUo211nL6y5ptchRgM2nvbIWf08wRVyl9R9l5KLtahuIYkCa7z
   hh5IERF+J9PUGZemRDEDB25a3is7a7Jn9FTjFL13W4XY9xma3zGCZ0Zp3
   58hiGiaHw2gngEkBFr21nCH6ZVGDnrLRITCzKff6StC0M6TRQPmqHwm5y
   RV6zDanJaJpKZUguS0dX2n8s2nZCgfpowvb6au/CYFrHyDtkk8iYh8LYM
   kMXhhqSMzX1HLK4/FdBiybtyMYLpNyVcd/YMxJMljncZhPxADXI5xC5Wc
   0q8AD8FO4z/LSouzFFWPnGpRpjlTJomJn4wEq+HjneSwo8oy5YWPfO7Fm
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="300375191"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="300375191"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 15:20:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="868784027"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="868784027"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 03 Oct 2022 15:20:26 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 15:20:26 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 15:20:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 3 Oct 2022 15:20:25 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 3 Oct 2022 15:20:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nblFrrkJH3Art9GSQeLS3Q6eVG9yMBhsIhHyOzNJsyWGDa2rzUG472oQE9dvZdqGYUwtOUw7B7iv/R9DbZRugc4aiOtBthsFEagMA5tJFc2YzgYb9mY7q5GQUi/lCsfvuPQB4kWT1D4bnQoDuY6vi9RriUUH/JDZgtsCm/ZMFslNS+g2lvLtt1TTw+cObnHwIaHbiSDJ2uYfN++UoR1Mxp1fW208VbMc/XO3tRYrval7B3pgaKrBtyNeOPOJOOgTEdGO6xSL7vxr7gdRjoQcaxYKPrsEA1UtqfZJlz501FFjrQhMV/HywbJg3CbKZb4YmSCxZxFQxOtX0fidcW927w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzQP40Xk77O3OheaSOHjbyOE7OQvMSlKMArekNbbDig=;
 b=A4X+30AaAesYWyd7D9OW/Gi+RJDvZ1Zskd9Diep1hnjsH/ezC3w4sA4V6OiHYYcv8DDfWUYfXGo2uRqsBU4hQAPSA7ligprLCEMfSFc/ZbdPSEWsrZiF/AIA5NXL9LMBDkcbSZn9Xj8Ntzj1eHTOArDejO8PBVK3isp66zMDZkWbbpgFKvwQ7AHt7Z8L7Op7cdK56xT/nkC7F5fGKlPkhzlkS3U5rpG9aZvAkBXIljwXD5CwI9/XF8InLU3lZHclezcnomEdOfNXUNnralBUHDAXNTAJgq+ZIRtUvOXOmbXAWp+Qbvp2Y9g5zu3pZ6uY8uf7euYSmwDZhAlRqH9CHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 3 Oct
 2022 22:20:21 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 22:20:20 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "jannh@google.com" <jannh@google.com>
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
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 10/39] x86/mm: Introduce _PAGE_COW
Thread-Topic: [PATCH v2 10/39] x86/mm: Introduce _PAGE_COW
Thread-Index: AQHY1FMOaUlv/a8lEUG05TjT32eaO6384Q6AgABWmICAAAUGgIAAB1GA
Date:   Mon, 3 Oct 2022 22:20:20 +0000
Message-ID: <685728bda0fdd33d9f27111384828a6cbdc537db.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-11-rick.p.edgecombe@intel.com>
         <20221003162613.2yvhvb6hmnae2awz@box.shutemov.name>
         <9e9f2ce8193ea2e86474ab999ad2a034c49d8b22.camel@intel.com>
         <CAG48ez1S+zN1tLKYuPL-yBu-ZxT7AMm5faWypi3J-XtnQCUiEg@mail.gmail.com>
In-Reply-To: <CAG48ez1S+zN1tLKYuPL-yBu-ZxT7AMm5faWypi3J-XtnQCUiEg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SA1PR11MB5825:EE_
x-ms-office365-filtering-correlation-id: ace2a40d-87e9-4a2b-8caf-08daa58d757a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q7EZWJFSd01s1jYeTO74DDHEmuydHpB1M9jYiZ9b2KxHHTHycVx57DpmYK6EhIrsBNuV+3HjlQNLwB4De1afWA74UDOZEdJv/n9mIRZ3NmqpPTdntFkcBNcw8Xy+r6c0rc6J0PuqcnQzsn/qwjME7WBB6oHDS4pGozla+yz770amDEzPNtXkJ/ky8y+ELz8VGqzy9c+vhhZ37PzveVlIeT85yl6d3KMNjemKzWnBjCJgSkTItjtQN97+c+ynZW/+rkvQdG5RF5+ROmn39VT8h2BVrqvYmoBnhFirGHOt74i9eoOKMB9TeLkZ3e7CnknPC25TRyqdRrP4ubY5KA4fuP7ilnDO6+9JmzI1FV8MQFdn6VCBIKGZ8vHr3a4gUT4ncDnWLAuXyo5Tu0PWXpKVtRLJoUoJbrRfxRAg9w15OId5QP0x0B6PeBwOGn11SB8fcLmF/VEucQdJbAAILFfyPD0x3QVAUVNbsHcGq1FLQYoKi3E96/Xg9lvQmB8TcWHPRnJm5DVu11iJxPqIiYms1M/7KTbdN/Youw56aMoSRYTFOOVLn0Y1fr7ydp10cTHTi3rlyWCsPF5nyeTwFMsvcoq9cBuWB19ZJH1MbmuKdFV6atIZafq3Pgd2uPanm5VmqzJhAWDv0Y+cVyjM+aFKZRULa1O1SkkSgROosK8A9AbQOojT1iSlM+aUgnq50AV4ReMR7wFfSZVRq6SqBrRYuaxUK2oKtWgLdHyAyPuMbQLaYup55NDpj+H21wf/v4EubvE9yaWZGg/uPSdHi+GzvY6RX3N2A9oi4wT2UN2yjeY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199015)(2616005)(38070700005)(82960400001)(86362001)(41300700001)(122000001)(5660300002)(38100700002)(7406005)(8936002)(66946007)(76116006)(64756008)(7416002)(66556008)(66476007)(66446008)(4326008)(54906003)(2906002)(6512007)(26005)(6506007)(478600001)(186003)(71200400001)(316002)(8676002)(6916009)(6486002)(36756003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z25iUnpLYjNVaXZIQ2VreHZNRlE0OEJkYWR1enpXS0NPWFBpdC9qL3JLWVdP?=
 =?utf-8?B?TnVPdDVQbWt2MmFWc3JJZVYrTjFoT3BUKzdKaHlsVXFvQTR2R1Z4T3hoUHVN?=
 =?utf-8?B?RzhYdTM0QnBjeHE1YS9KU3dPQVRaUmowbXNtOUk5VmhNVmVTUk85YndZNnZq?=
 =?utf-8?B?MERMNUtaenZieU1FUHRmaDJHblBIK0lSV3Q0aTFwSUtTS3daR0pXTklCMlZi?=
 =?utf-8?B?Q3RMK3k3NWdqWGdVNERYT0Q1VlduOTB0OCtjZUp1ZkpUSEdBc3FNWkg5aHZN?=
 =?utf-8?B?V2JXZ2R0Z1hSS1VEZjRYTHVjL3JPTU1oTkhnaytwVUE5OFc5TWJGRVhuQ3Z2?=
 =?utf-8?B?QkQ1NmRTcmlqVk5SVlIySkh6a0lBR0tXYWcxc3lOYzNabFFVZnVuVXJKZjk3?=
 =?utf-8?B?S0YwLzk4RGZlYVI2OWNZQmdwME1vRVdINllyMHp1VWtySVBOVThNUUZ3QnFS?=
 =?utf-8?B?d016Uk9BaU02cVpPWjBJSXdIMUx6R2pRZnYxakRjcU16VE1Jb3J2TlBXdkNF?=
 =?utf-8?B?SXhrTEVQeFFmaFdjOVo1dVhBa0VNSkF1Mkx2aGF6bm5hNTlucTgxZ2F4VXJU?=
 =?utf-8?B?TFh0dGhtbnBxbkdReGswcjR2UHNneEdHOTlmdHN2eHZGU3NIdWhkcWI2MktZ?=
 =?utf-8?B?SFJ0UE5hRWRZWERvWG04VW1FQ0NWcjVTcWl1a0JicjlPbi9qT2kzK1RwT2pW?=
 =?utf-8?B?TzN5RzBEQmxHM2cySCtHaE1CVGcvdnZKd2lsVkZxMjE5TTgvQnlOYW9tWVYz?=
 =?utf-8?B?ajJGT2tCMXI3UnBvSEtveVJwaHErMVp4cWxuZEZ6RmNGa0hlRWVxZWRwQldy?=
 =?utf-8?B?MXcvcmFPSG53aTVDNmloOWdEeGdISFNjbnFjLy8xUjk4T2FMYjQrSXZ3SlFB?=
 =?utf-8?B?THVkaHRSTk9OVWpFSG50S3FXOC9RQ24wa3crMFFDM3plL3pEa05BRGEvSFc2?=
 =?utf-8?B?OWdZRWI4WDZSU2VhTmJEaHI4bVZzdXhUUjFXSHFIQm1JTVNKdGtRZXplZUI4?=
 =?utf-8?B?SHRRVjczKzN0cVEwVEM1eWZkS09iOW1MYXA1cHpteFY1TWFJL0NWT240NUw3?=
 =?utf-8?B?Z1NjYWx3dUs0eGhIZzV4OGRDZkpTVHpORFBJQ0tzaEVFMVF1K09xWVBFMnVJ?=
 =?utf-8?B?R2c4Y2NZMGFtT3poSElDVEJ2eVVtVFRId09BWlV6VjRaYkY5LzhGa2IxQ3Qz?=
 =?utf-8?B?S2g2M2VPNndBSThZUE81N0RQM1hFK1preXNic0xjalVDSWttcm4vcjI1Qmxk?=
 =?utf-8?B?OWdTVEhxQk5sNU9wVzdiT09kSUJEZkZVTGwvR2NTeXhNbzRTbVIxVk53ZlFi?=
 =?utf-8?B?aFJVNm5SNERkbnN5Qk8wZTlWSlIwb1kzb2hSSkR3TkpKNGEzQWppZjlVR0VF?=
 =?utf-8?B?S0VOTXBTQmxQMVEydWYrd1lZbnE1RWNBWjFzRU1QQnZ0cDdmbjMvWGg0dzBr?=
 =?utf-8?B?TDJjMGJqNExIamdDSUV2VEEwd010R2U3Y1JJa3hzNkNQSU54SW1tT1N5QlVX?=
 =?utf-8?B?cVlDb1Fya0tyaERPZEEwVnhUbFlaV2kwa3NxWHUwd0tlSmxmUEtzUnV1ZGw5?=
 =?utf-8?B?Z01Hak5obXZSZjAxSTBiT3FXNVhaS1hmaWZVSzBRVHlrNDdnUndhN2dPcXFp?=
 =?utf-8?B?elpIOTVqVEVmUnNhbjJKOFZWeHdyMUdyZFg5UlFublhPNDVvaS9pNmQzenBW?=
 =?utf-8?B?UTJ5LzhMMlZ1cHBhU2d2YnBiN2Foc0JUSm5KeHYzcHBxYmtYemk5MXJMVFZu?=
 =?utf-8?B?aXVvRFExSElzNjZSbDdHeEtOd3E1bmhMenY5NnQrMEMwMmxnYjV2L01hNjdV?=
 =?utf-8?B?VGIzUXZpWHMyNXRmdjVsSzgvcUIvaWM0ajU4Q1FVOCtabTFtOFc3WUhyaVFz?=
 =?utf-8?B?eXNYSWYvU05uNnVKNHlvUkZpb3VyNXFOZGlUNFJUbG52eU9MaU9mWVRkUFlR?=
 =?utf-8?B?cGRwaDhFL3BBamRRaEQzell6U2VlSFc4T3RkeWtkQ0F0TVYySTV4bU1DcjFw?=
 =?utf-8?B?eUExc2dPZVlsMHovWmVEZWxTek9RUmZDaHlKTEhCS3R1cUo2OU1WdmlFTlI0?=
 =?utf-8?B?UGZ6R3l4a2V6VmJCNy9HcmdXZGdVYks2Q3EyV1JKbkZTTFJ3YlcwT1RrTWtB?=
 =?utf-8?B?RG9waVBKNnZrV05RY0VTeVJVS2U0K1g5dUJMMDBPdWRCSUt3YmhmWnNQRjBa?=
 =?utf-8?Q?NlMYaNPzdPdahiJ1kMKiIBI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15431DF6238EA847B1B88BABB23B2051@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace2a40d-87e9-4a2b-8caf-08daa58d757a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 22:20:20.5502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l7n5cwBZMSbf7ksWtmStjXnJmEh0M/QbFyd1Ym2lPDvug0N0C7ldFsbC0lbchvSRYWBmhlJN4PcVAx0Lt9uGG6nyHZuvb3O77/wl8+JDBgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5825
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTAzIGF0IDIzOjU0ICswMjAwLCBKYW5uIEhvcm4gd3JvdGU6DQo+ID4g
PiBUaGVzZSBYODZfRkVBVFVSRV9TSFNUSyBjaGVja3MgbWFrZSBtZSB1bmVhc3kuIE1heWJlIHVz
ZSB0aGUNCj4gPiA+IF9QQUdFX0NPVw0KPiA+ID4gbG9naWMgZm9yIGFsbCBtYWNoaW5lcyB3aXRo
IDY0LWJpdCBlbnRyaWVzLiBJdCB3aWxsIGdldCB5b3UgbXVjaA0KPiA+ID4gbW9yZQ0KPiA+ID4g
Y292ZXJhZ2UgYW5kIG1vcmUgdW5pdmVyc2FsIHJ1bGVzLg0KPiA+IA0KPiA+IFllcywgSSBkaWRu
J3QgbGlrZSB0aGVtIGVpdGhlciBhdCBmaXJzdC4gVGhlIHJlYXNvbmluZyBvcmlnaW5hbGx5DQo+
ID4gd2FzDQo+ID4gdGhhdCBfUEFHRV9DT1cgaXMgYSBiaXQgbW9yZSB3b3JrIGFuZCBpdCBtaWdo
dCBzaG93IHVwIGZvciBzb21lDQo+ID4gYmVuY2htYXJrLg0KPiA+IA0KPiA+IExvb2tpbmcgYXQg
dGhpcyBhZ2FpbiB0aG91Z2gsIGl0IGlzIGp1c3QgYSBmZXcgbW9yZSBvcGVyYXRpb25zIG9uDQo+
ID4gbWVtb3J5IHRoYXQgaXMgYWxyZWFkeSBnZXR0aW5nIHRvdWNoZWQgZWl0aGVyIHdheS4gSXQg
bXVzdCBiZSBhDQo+ID4gdmVyeQ0KPiA+IHRpbnkgYW1vdW50IG9mIGltcGFjdCBpZiBhbnkuIEkn
bSBmaW5lIHJlbW92aW5nIHRoZW0uIEhhdmluZyBqdXN0DQo+ID4gb25lDQo+ID4gc2V0IG9mIGxv
Z2ljIGFyb3VuZCB0aGlzIHdvdWxkIG1ha2UgaXQgZWFzaWVyIHRvIHJlYXNvbiBhYm91dC4NCj4g
PiANCj4gPiBEYXZlLCBhbnkgdGhvdWdodHMgb24gdGhpcz8NCj4gDQo+IEJ1dCB0aGUgcnVsZXMg
d291bGRuJ3QgYWN0dWFsbHkgYmUgdW5pdmVyc2FsIC0geW91J2Qgc3RpbGwgaGF2ZSB0bw0KPiBs
b29rIGF0IFg4Nl9GRUFUVVJFX1NIU1RLIGluIGNvZGUgdGhhdCB3YW50cyB0byBmaWd1cmUgb3V0
IHdoZXRoZXIgYQ0KPiBQVEUgaXMgc2hhZG93IHN0YWNrIChvbiBhIG5ld2VyIENQVSkgb3IgcmVh
ZG9ubHkgZGlydHkgKG9uIGFuIG9sZGVyDQo+IENQVSB0aGF0IGNhbiBzZXQgZGlydHkgYml0cyBv
biBub24tcHJlc2VudCBQVEVzKSwgcmlnaHQ/DQoNCkdvb2QgcG9pbnQuIEl0IHN0aWxsIHdvdWxk
IG5lZWQgYSBjaGVjayBpbiBwdGVfc2hzdGsoKSBvciBwdGVfd3JpdGUoKSwNCnNvIHB0ZV93cml0
ZSgpIGRvZXNuJ3QgdGhpbmsgQ1BVIGNyZWF0ZWQgV3JpdGU9MCxEaXJ0eT0xIG1lbW9yeSBpcw0K
d3JpdGFibGUuIFdoaWNoIHRoZW4gcGVyY29sYXRlcyB0byBtb3N0IG9mIHRoZSBvdGhlciBjaGVj
a3MgYW55d2F5Lg0K
