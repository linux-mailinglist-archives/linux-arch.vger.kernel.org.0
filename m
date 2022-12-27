Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924FE657034
	for <lists+linux-arch@lfdr.de>; Tue, 27 Dec 2022 23:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiL0W0p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Dec 2022 17:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiL0W0o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Dec 2022 17:26:44 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57929E65;
        Tue, 27 Dec 2022 14:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672180003; x=1703716003;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zBnkeoZjXNjob+PadMy3AUwGw8amHwPTWLMHJBRGCXg=;
  b=TRpAnbhZAGm3hwQzkI+DKPJkdPC4LM1MYPymi+cRYWFDZzUJaFfKII4R
   Mp4PSqJgmefnv4qNGA3am6tNjAVEYUzrbsHqNH10gNIRsiyx4lXI2zvrV
   +oyoglqf2QCvuQf0LvSgi3AiXyNZLdgHv3gJXzlZeKz1WLW6+pskxOB2x
   TPiOm5h10wc/2QSCFDwtCqXGl7tOW6fcXeibVQLo/lZhGD9Q1KCuvFqw3
   eak0T476d1KSnNgy50ktYdVykgSloZai4aUwIy5tJOBIw/w5KWaWYpdME
   fFHqWCA0wBMX+X1PnW+QmksyUyG5qO74NJ3ljhXHNavKSgYHOtcVEsocp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="322746199"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="322746199"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 14:26:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="683734900"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="683734900"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 27 Dec 2022 14:26:42 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 27 Dec 2022 14:26:41 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 27 Dec 2022 14:26:41 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 27 Dec 2022 14:26:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIBOTjDigTFYVwCZVeiz3ZDMtfdy6b2SJWrBGgaJJL4qwk2X+tvIhkMxbpUbNG5bpLi35bLhMD8KvGq3jiWoD28euVvnZzpLcK21ITHXvE1nfaxaPCzEni43+VcRDxWeXdT9kuMJjaZ09ZMlBhb87h+rjnRkwRhhdEcB99uaiGlPQhi+IItSZfaxJd9xs31DwBWMoFxY/xjxK/R6C5j/KUS1YvAuFRItHKqWw6edU5GJfEGwp6SGgiGOsgo4B794N3ENe+im3MmDXNIXGAUdrXOuf8qeNMN5qoNuuoHur48ByoVOyHAIc8exk0qlNgn2VudPY8vKNAxB5rPmnwrWdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBnkeoZjXNjob+PadMy3AUwGw8amHwPTWLMHJBRGCXg=;
 b=HxDCRiJBntuQ4pPI1Ajmd89ruaoho8sBUyzkqddGdjSYoet1VDzvJfDbHAU9E8LMZelLOGepTUTfS0ZSeUoCedNHLRp4VZnr3Q8uWp2DOfX7mQzBbIJncRPjZ1ht2YlUVrsccNaUonXjYaRlzGFicLmGRcsWZA3SejPq536vuytIz6a7dGTQGvZ+FKejbZhgiK08yqKk8jtkCiO1AFT0EiSXNyAjX9+u9/O+ijGF+o3GE8N36b00acCnVxFSqZxjD8gH2AyppILLfoKCN+MSbzk+ubIZae7J9wyPY9sCRbuuewYGfUo7SkYvuBYaZyjJqgkfcc+O5jDRScDQg/q7aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SA3PR11MB7556.namprd11.prod.outlook.com (2603:10b6:806:31f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.13; Tue, 27 Dec
 2022 22:26:34 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff%5]) with mapi id 15.20.5944.016; Tue, 27 Dec 2022
 22:26:33 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v4 12/39] x86/mm: Update ptep_set_wrprotect() and
 pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
Thread-Topic: [PATCH v4 12/39] x86/mm: Update ptep_set_wrprotect() and
 pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
Thread-Index: AQHZBq9eJTneA8qhgEiI6LYLoGyDqa6B4EoAgACW5YA=
Date:   Tue, 27 Dec 2022 22:26:33 +0000
Message-ID: <6b4b96ec7a1cc53541f25c5a5ee8fa310b693ccc.camel@intel.com>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
         <20221203003606.6838-13-rick.p.edgecombe@intel.com>
         <Y6ryhvE3ev485oYC@zn.tnic>
In-Reply-To: <Y6ryhvE3ev485oYC@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SA3PR11MB7556:EE_
x-ms-office365-filtering-correlation-id: 04edbd92-b833-43ac-372c-08dae8596906
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 17sXALoKIRaLGSPn9Kg7bX3e85TixB+ouJhL4Q1ss4uCcQ+htYuJNCKieRY4OeZFRDJnOT3fOUOfFOkcIXAG3n6llWlddbUcIkvRMxoJeOBSvD/RxsgqPtLEbaJncWQuuOYPjR7Ytammb8DJqRZHQd2STRDwXNJKPjtK4jbP5eTrhCerHZXQ5F90q4OfJsX2yc2u/AXvVbJWUXeU3yKPahLEPXaickLd8j9pRnQ4vCdmS8gURFNFC1ONe9Y9STv7Vmx+1kT0RuluLAqqMC9kH6jgQNObNitpxeUIcs/uePI+P8QnmN2oL/4uZuV1nY46zciD77wZEPC/4t0uKL5aHNWcApiaGdtf2L7yyVp1ODDyOChJ1OgFxe45Y5FyplvqYrYNWxrmiYx/CtxEbFgo23+ZVofZLtKnxRtU4ka3o6JUp6hN2vy9U0fB/3Hu2Qp05Y413uUT32V9V38ZSHrWh8w1lMMV7RkQhZa55d5fHl8wkKm6cyIWc3+VyZXNFWSZtjHripg26rS5S5xIuxiX92wcck9wVPzhLEVh+yIjRkJkity6KRngOQtt8AHwyY2d12sw/qLPTG4Z/Ge01Fwuq7B62R1z5mW371KyCVLoQ09WBXU6/wCY+rZQBYjGzTO87FmLpxOqO+zbE1ITc3JN6rjttVOf0Cm0OkJFseislRwIStbhHtrBPaI/I4Riabzyf4QwIJUZi1btDLu7Lplb1dwqx/PbBAKx8jrs66yy4wM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199015)(2906002)(5660300002)(8936002)(7406005)(7416002)(36756003)(4744005)(316002)(6916009)(41300700001)(4001150100001)(76116006)(66556008)(64756008)(8676002)(4326008)(66946007)(66476007)(91956017)(66446008)(38100700002)(6486002)(82960400001)(122000001)(186003)(26005)(6512007)(6506007)(478600001)(71200400001)(38070700005)(86362001)(2616005)(54906003)(14143004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnZvWjRpdWFHbTVySW9LZkkrV2hEZVZ0NmluY2pFWXA4dTh0dEIrcjBpcnR6?=
 =?utf-8?B?VDBzT01wRzRlUERBWFVLV1pSWFFxQ2lpc05DdmNzZkx5ZDFsc1R2Rnd4Y2h6?=
 =?utf-8?B?TTVrRld1dExhS0tkbGxENkp5Wnk2anB3ZlF1VVNUNk5hNjJBSmFHRWY2dE5n?=
 =?utf-8?B?cElRUnVrRUtCMjdjL05mNzUzUFRyMGpXeGlkTjFBSVQ4NU11SHJ3WmdTTUtV?=
 =?utf-8?B?TFYrTVJGOVhDYUp5Q0VaVzdkUWx6QkdxWWpUdm5QSFdxUElUWlIrQUk2Lys3?=
 =?utf-8?B?ZVJDU0hXVWhzeUxoY0JaZXdLbnN3WXZIS2Fza3NldC82Wkd0cUs0RGdHejAw?=
 =?utf-8?B?NkduQVhEakpjc01XZXM0N0Jjd2pzSU5wRTlJZHBnQVFML2tyUDVrcDRhdllJ?=
 =?utf-8?B?ckxOai9jSDZ3Rmc1YzdEUzdLTjNZbkFMaFpWOXdieVFTZ2ZlN0I1aXJyNVMx?=
 =?utf-8?B?ZU80U2x0UDdoZnFOcDZMN2trRWtLUWFUTW9GblJ4U0pIR09yU2drVUt3NGZV?=
 =?utf-8?B?VzZIQTgvVW9oaUNsbVB3TEdDaTFpNUV0U29DSGVpMlg0L0YrZXpJWklIME04?=
 =?utf-8?B?VlhzY1Z6eGFtaTQxaisyc21WclhqNVcrY25kRmNFQSszNy9DSGt6dFpZRVBr?=
 =?utf-8?B?WUlGTTQrckEyTzNoRHRZVlpDTjYzdnlvMWFXSnRMc3V5RjB5c1Z6MERjQnVC?=
 =?utf-8?B?QUtaOWx0VzNnZ3BTOEhjMW9WeWpWYmxDNGJNMVJiS2t4aTlMdElvSkp2ZVM2?=
 =?utf-8?B?REc3VXM0RnROTEc0a3FEZTVXTi9nWVg2QWN3WjVKYzkybXZkWFN6T3pkN1dH?=
 =?utf-8?B?cW1aRHF1Ris0VXVZcS9yRU93VmFCSVBxNmZuUjAvSU5JNkljSFlkcWRjR0FH?=
 =?utf-8?B?WGJBRHkwclJvSUdaNXZkeUVuZEhxMkFkaER2cnNObGlLQmViSFcvbk9mek1V?=
 =?utf-8?B?UzBTUEprQVd4czJKZ2NKd2hVbGJSV296YjJLN1B5bUJMM0VEWE1FTEFJMEJz?=
 =?utf-8?B?enRqSGM5d0pJVFVLTmJaZldLVGVPWTJlazg4TXFjUWJJUDRUK0tUTnNPRE9U?=
 =?utf-8?B?elZTR2VVOFliOWRaYzRYWGkvYnEvcjlBY215ajhqczhpVjUralcrUmNmMk9M?=
 =?utf-8?B?RVYxcWo3ay9Ha2ttbFBXQU8vQm10ZFR1UTNiS3hpSUV0a0ZLbStZa1lxUEQ1?=
 =?utf-8?B?RkE2Ym5aVEtNQi96aU9tNmdjUU1ra1ozdVpqQzA5SzQrb0p1QkM0VE9KbkV3?=
 =?utf-8?B?T3c0bmxpM0RxWUwybkFodzlwbHBXdUE5QkkxYmhrbmNvcU1ySlI3M0ZjM2FV?=
 =?utf-8?B?citTMHRwNWRkbDdHY0VMOG16NHJFd09CTXoxamRxa1Vka1pJRzhvbTJMM2Y1?=
 =?utf-8?B?U0V3ZUN5SWxGRHNSMGVNRTBFbHBxOTMybzV4SGEvdU1PZTlVeXdwZ1ZwbDlP?=
 =?utf-8?B?R2w2OC84d3pVN0RRcGMwa2FhS3E0TFY2b3ZxVWxwVjFKQThsREFhZVREQ2NV?=
 =?utf-8?B?RkV5MWpsZFFQWWxneWR4TG8xbG5pcXAxQzYvay81ejFINTgxWjFzMTVtLzUx?=
 =?utf-8?B?dUowZk02ZVlxTVVoU2Q4dHhTbGZRRCsxdHkzZGozRitGMm9GdWV5ZE5xVmlE?=
 =?utf-8?B?dStOZ1MveTVSSW5yWFIrY1F5cWJrd3FWakYzZmU5UmtwZnBaNElCZHJYaVVp?=
 =?utf-8?B?NUhZMHJJa1c4NEZoVzd0TGZwaUJJVUx3NFpBTzArMUFmcTRlRjhOYnZsdEFu?=
 =?utf-8?B?SVMwTVNIM2tkNzdIaVczR1BONXQwdGpIMWhHU00rd1VxN0owM1p0U1NJTkRq?=
 =?utf-8?B?UXlZak1zSldQc3ZIMFJmTWhYZUlKWFZoR2V6b0lGUjhkN2ZpWkpHNkRNcTBP?=
 =?utf-8?B?TVJhbHk5WmU5bXM1d0NVaUZ1Zi9IWVZheVhGOStJWnFqRElUSU5XN0RRYmJS?=
 =?utf-8?B?cUNvUUY3K2tLZ001bWtNQmFXTXoxVktZTVg3eS8vdWJzdUhmZE9JbnoyS0Ex?=
 =?utf-8?B?bkgzamNzbzc3N0dGNWpMLzNXMWNOL1ZCR25rS0VSNWV2eGozWmR0YnpxdkJY?=
 =?utf-8?B?SEptR2lPdnlkUGdhY2NiUVVFSEduWkV4K3FjRzhUZlcyMXc4bEhYeS9pOG5t?=
 =?utf-8?B?ckcxYTNPVTdHeCs0dk1idVpOODJCa0diRjBFeTBjSEloVUhUNDkvMk00NWRq?=
 =?utf-8?Q?rnQxOizszZFG1cBfo5Ra0JE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57DC0D1206A1D64387FA137649A6B082@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04edbd92-b833-43ac-372c-08dae8596906
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2022 22:26:33.7782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JVizIaA7NJ8ahXnxES2t493bFTvAyS0JSFKtMD9WwDaox7mReEazlf16fc87v1H8v0hr3mRM3sGgkLCQN2kmUywbnCyR5TeKsNXLG6lpijU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7556
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIyLTEyLTI3IGF0IDE0OjI2ICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IEp1c3QgdGV4dHVhbCBpbXByb3ZlbWVudHM6DQo+IA0KPiBPbiBGcmksIERlYyAwMiwgMjAy
MiBhdCAwNDozNTozOVBNIC0wODAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToNCj4gPiBGcm9tOiBZ
dS1jaGVuZyBZdSA8eXUtY2hlbmcueXVAaW50ZWwuY29tPg0KPiA+IA0KPiA+IFdoZW4gU2hhZG93
IFN0YWNrIGlzIGluIHVzZSwgV3JpdGU9MCxEaXJ0eT0xIFBURSBhcmUgcmVzZXJ2ZWQgZm9yDQo+
ID4gc2hhZG93DQo+IA0KPiBQbHMsIG5vIGNhcHMuDQoNClN1cmUgb24gIlNoYWRvdyBTdGFjayIu
IEZvciBXcml0ZT0wLERpcnR5PTEgdGhlcmUgd2FzIGEgcHJldmlvdXMNCnN1Z2dlc3Rpb24gdG8g
c3RhbmRhcmRpemUgb24gaG93IHRoZXNlIGJpdHMgYXJlIHJlZmVycmVkIHRvIGFjcm9zcyB0aGUN
CnNlcmllcyBpbiBib3RoIHRoZSBjb21tZW50cyBhbmQgY29tbWl0IGxvZ3MuIEkgdGhpbmsgdGhl
IGNhcGl0YWxpemF0aW9uDQpoZWxwcyBkaWZmZXJlbnRpYXRlIGJldHdlZW4gdGhlIGNvbmNlcHRz
IG9mIHdyaXRlIGFuZCBkaXJ0eSBhbmQgdGhlDQphY3R1YWwgUFRFIGJpdHMgd2l0aCB0aG9zZSBu
YW1lcy4gRXNwZWNpYWxseSBzaW5jZSBzaGFkb3cgc3RhY2sgbXVkZGllcw0KdGhlIGNvbmNlcHRz
IG9mIHdyaXRhYmxlIGFuZCBkaXJ0eSBtZW1vcnksIEkgdGhvdWdodCBpdCB3YXMgYSBoZWxwZnVs
DQpkaXN0aW5jdGlvbi4gSXMgaXQgb2s/DQoNClRoZSBvdGhlciBzdWdnZXN0aW9ucyBzZWVtIGdv
b2QuDQoNClRoYW5rcywNCg0KUmljaw0K
