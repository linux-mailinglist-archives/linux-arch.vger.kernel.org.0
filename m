Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1323620140
	for <lists+linux-arch@lfdr.de>; Mon,  7 Nov 2022 22:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbiKGVfD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Nov 2022 16:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbiKGVeo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Nov 2022 16:34:44 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B118631206;
        Mon,  7 Nov 2022 13:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667856850; x=1699392850;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=g8I9/uWZp0xzDiaK1UYLjjLRBTlf+gdESqu61e0cK2c=;
  b=MyUHJgyK9h/uA9Z0e6ff9dL2GKRsB8b1eKl2Lk15aAqOh56VOho353yU
   B207nPL5sae2PAq0dOJBGRRgUR+T31MfPSnhj3qdP1G/RKEh0JQU1bBAs
   eGVH/Slcl1TqQERuhOHgEifVeJjvmAaTdncAQWPdsr//2HtTl3CdBv90a
   PHVRMpqD4VUIHZQ771SwjXGMO1WgOobJW0t4Xz4AEm9qW7mHVlH0tncO+
   vaz+ebuDKqvOJWf5mcLA5AKYwZmoAhLqCzZoXwhMo9kWqNEWNACyXmsOE
   34GFYvsnxnjx+TjO8tXsAfC79udeNq4F7aoB11slLUFbFFECqZyaoGihD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="374801390"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="374801390"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 13:34:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="630636173"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="630636173"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 07 Nov 2022 13:34:09 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 13:34:08 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 13:34:08 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 7 Nov 2022 13:34:08 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 7 Nov 2022 13:34:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSYnYxGL9rOty03JPG6MnWvBCmSrNIo9EaYEdoFu7vL63hJVUnh5fSFVj1pEzf1YVuXy/Ch2FzZVagMsJTAiXttodR61wDitS5OVI/h1ENwPVbKT+CAD1UwdBUk5iqN3sCGdP/zAG7pv0JSi5RR+K5z3DYmaI7sxe4ooVNVMyNevswfnkX4RQi8/gpW6T712CUAudIM8RZEbaUskeMheRJL+Muwde/pH/8Dlbzzqb5thWczKzZEI3jhxPmCwDbvspNUY7OveQHkMBfNHYy+B74sxGNRWb5pE7zgNnFgScJ5CQ63Gk+URCiQFSly9CDEa+V0agoGAi11ISvWaeFTtLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8I9/uWZp0xzDiaK1UYLjjLRBTlf+gdESqu61e0cK2c=;
 b=BqlMc3nVh6xobpl7MBgf3JYdXB97S2BiRdxJjhW+s914Y1KfgJ84/Q3+++UViGVbdT6mbDyf58d6osGo1aEtiz7Y4Q3be5q3bzaUnf9xvpeCK4H2bGkwXKa9fgL2uOWIJcyZUW+XEatYn1C4WsdwzpCR85MYGKsaYI+WSaxQPcnpbUqimL5dup9YY6gPOyVoR2Sp9tbJXEt/cWn8tdnIykWd/mbKHf/eohBvoPZLNSnf1E812mf1MykBA0UCJEfmPIrS5kxfaurUYPBKzP36PzPGtqYaTUc+m60QCtsTJAUc3hNlMj/UlNO+Knr46YZnJC2qqS/ckIgHZlw1e8IhJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BL3PR11MB6387.namprd11.prod.outlook.com (2603:10b6:208:3b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 21:34:05 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5791.027; Mon, 7 Nov 2022
 21:34:05 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "hjl.tools@gmail.com" <hjl.tools@gmail.com>
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
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [RFC 37/37] fs/binfmt_elf: Block old shstk elf bit
Thread-Topic: [RFC 37/37] fs/binfmt_elf: Block old shstk elf bit
Thread-Index: AQHY8J5g32apAoMYh0aArgmkU40OVa4vYA0AgAJEZxCAAgw+gIAAAcpVgAALa4CAABn9AIAAIbOAgAADEYCAAANrgA==
Date:   Mon, 7 Nov 2022 21:34:05 +0000
Message-ID: <31b5284ce7930835b055e4207059e4bea32367be.camel@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
         <20221104223604.29615-38-rick.p.edgecombe@intel.com>
         <CAMe9rOpfSccXVWmgK6E0Y0DXC=VX3PpdxXookN1Ty8soeAxrKw@mail.gmail.com>
         <87iljs4ecp.fsf@oldenburg.str.redhat.com>
         <ca106fe1b5005f54525e7a644684108f6a823e14.camel@intel.com>
         <87h6zaiu05.fsf@oldenburg.str.redhat.com>
         <f60f1138813f850d52dd92bc6b3df067c021a197.camel@intel.com>
         <CAMe9rOpVUwCccRb5DAyraEKO48rix+Xfiamfp_Vc_aHhjp7=LQ@mail.gmail.com>
         <73b8f726c424db1af1c10a48e101bf74703a186a.camel@intel.com>
         <CAMe9rOo6+Di5-mdWa6rviZ7zdO3yMgFPeTw-CXxXZNSQc=-8Wg@mail.gmail.com>
In-Reply-To: <CAMe9rOo6+Di5-mdWa6rviZ7zdO3yMgFPeTw-CXxXZNSQc=-8Wg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|BL3PR11MB6387:EE_
x-ms-office365-filtering-correlation-id: b8671196-1c1d-4504-6284-08dac107cbcd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A0TUbkFgy1O0DDjML0rLdU8rPKE+Pl8Ct8xOi7nnHypTZNBa2ZI360SQsZFMnC00Anz88XO9qhJWiMaSHuiJUL/UIrXO4MJNKBITleqHcKVc0Mns9GWChCG6FssGx5gOfBkbf9VNWSF07Ys3B+Ri95ERIAg1vgktKRrxSwTDhJVDLMiI6ZL1T18PyNEmNrddzTD1zxnNKiSyTSkX3nWwRZPf+EILRVFEKNpvYP4RKXWW5N8psjzDvNs0fYzEe+61/hUWIPEQvP/ehI5EIukctZTlizaJmA49Cq9VW5gKfqI305Z5N8eZP8jDMEGkExwbaeUaiHVmAMP8wBh1m4cGBCfr+LRFteVe6fa48lClVnEeXvFbtu+KOoyhKaSTqGybaglSUoX4J3s/WuXV07A2tOZcJUJp9VsUY3KhIjcg3qz8YihxX+DOzhwqjEDCGwnvB9V/pDyfrtdUfPH/xPPf9bGwSze+5P9MIGPnKypLojkCKUj8rRZ+0IsKFzp6bkkKrNZHpuZqQkMA+fWaioI8ncbSx3M+5PmCRR7oA1vNmlBuFvJMqTIGSWPyFEWYpnIhkrXjIWwwr+5dcHx/ZonetmoAIlDTjdSujYWXVPcs9NyS0Wnjky9bhQJjsA0cRSJG822fzck7TENfiMPVGCaTrpghgd5Jmtzl0MdxG90sVSnI1Fj3kkItNvf3/j9KOY+FduM+QkNwFUhus1aNq/zqFoub/jN6ET93p5W40vgMPgPBE8CnbQeDZEf/RTRnoV5Jc0IrAlw/Ck6aoqhOVqsouHUoFbEL4Xjn6YeKfm654cQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(396003)(346002)(366004)(451199015)(186003)(2616005)(6916009)(316002)(54906003)(122000001)(38070700005)(86362001)(36756003)(82960400001)(8936002)(26005)(83380400001)(6506007)(6512007)(7406005)(38100700002)(6486002)(5660300002)(7416002)(478600001)(66476007)(66946007)(66446008)(76116006)(64756008)(41300700001)(66556008)(8676002)(71200400001)(2906002)(4326008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1RNMGlod2xWZWxjdStYU0lCL29BRHA4NklVcU1WTWFJaEFxTUV6bUZqQ2dm?=
 =?utf-8?B?SDlNQTZWYVZYZE1zTzVSMExGcWlBNUFQQThNeW9DUHI5cW05VFFRYWh6Mlkv?=
 =?utf-8?B?UzlyOFk0VmR1dElBdGVTU1E5ZGtZMlBTN29CQWFGbGprUkxlOWE0NEdaTEp4?=
 =?utf-8?B?bGFTZVFzaS9Zd1V2cngwb3kyUld2YVVmVGphQWEyQkJyTzlhUlhkSWdFZnA1?=
 =?utf-8?B?ZEpoZlNMR2d5Z3R6VndQR21BSmkwNUpydmowaVhEbndZdHlCQitvQlNBWGFW?=
 =?utf-8?B?eGh6bTdOTWo1R1pPY01kNXJKRmYrQzZ5ZERIQjg4ZmR6T2xXL2F1MFFBVUtk?=
 =?utf-8?B?bDhlVW1mbVpvMjRoZlhCLzhiVFlRekR5QVovM3FOQzU2TWI1WUFTVFRBZkpq?=
 =?utf-8?B?WStHSjdyWUJUTHg2cUpJN2pqWnVKdHlwMWtKbnQxOG4zR1ZUeTF0ZnNiNGFq?=
 =?utf-8?B?V2lTY3RUTUc0R1BKZS9CVlc0VHlUN1hsbHc1bVRML0Q5eENkYldaMUQ1dytI?=
 =?utf-8?B?L2MydnBUbFBoSCtxVnpWa2g4Sno5SENKZjZGUDdlb3doWHpPWmQ5ZWxyR1hV?=
 =?utf-8?B?K1JuZW9XY3psVEVtOW14bkxTalRMeTlXemZVbjhWNWdVSDBOVUhwWFJvVmhD?=
 =?utf-8?B?Y0RLMkZGd0Z1QStmSDlHbGVaY1Z3UGZpMFNYaWIzRUJGSUdHSHVSTkFIYXVQ?=
 =?utf-8?B?ais4ZXZncjdTS1E0dTNFYkZ0Z29Xckw1ZG9PdlFLcDdiMDN5cW8vbzZ1aXZU?=
 =?utf-8?B?THN2ODFCMmRSemN5c0p0cVJwb29LMk1XYWc0Nk9IM3Y5Titld09wMEc3cWVK?=
 =?utf-8?B?aTdCenhEZCtTTDFXMzVOYUlIYll6cGpNdDFwbDF4elRDQVE4MXBKN2lOOTJo?=
 =?utf-8?B?UnBNL0RkZGt4NUwxQnlNL3N5eURZVUg1S2xTQ2g5MEdwSDAyOFZBZGhWNlJN?=
 =?utf-8?B?eldiajlZdG9oY3FQaHhCb3pHcnl1VU9RL2lXVGxLTWJmYVlUOHQ0aEw4WUUv?=
 =?utf-8?B?bjVwazVoa0ErWWFnc0xJU0dCckV2Tk81RzNMblZKZ1BoRFN1WHBmOVVUM2ZY?=
 =?utf-8?B?RXoxay9PRVZxQ3JhL0ZUUjNmYjlDSkw2TkpnL0NBNzNLSVZSMW1qRk9QRUwx?=
 =?utf-8?B?NkNHT3hoc1NsVnpJMWIyd0xNdUJ0VVdNakpsZzVhbCtaTzZnVStGeXhDRjZ0?=
 =?utf-8?B?dDdad2RaWW1LTUNFdFR1cjU2SlU3MzNnUGZaak5VR2NXbHRZTHdvU1NZN1RI?=
 =?utf-8?B?KzBBaDZqaGlpVFVnNjVrM0FzRXlHUmkwWlpUTEdMaittaUx6bCtrOU83TmhN?=
 =?utf-8?B?dkQwREQzYjlXVDlaRkZOQTNLV2VjNUlUU2RZamNtbGdsQVZWNmkzL0RXSVVa?=
 =?utf-8?B?TEpFajM4VEkvdUg4Z2RMVjFTNlZ4U0w2NlhiTnRLYjZWdmF6ZGRxckx4aGhO?=
 =?utf-8?B?dlJUREdjcDZGaGsrUUxMblN0aWQwV3FPVVNVOTlPSkw0SkY5Y2VTZ0FhUzVP?=
 =?utf-8?B?MStvckwycGFMdDFtcU0yb0NKclhvam9hK0ttanpiU1ZDenBTVWp2dHpuUEgr?=
 =?utf-8?B?OE5OZS9EZGI2WTZhdUxLQ3l1dktmMy9RZUlCOXFVeU1FNUtrVno2SG1JUmFs?=
 =?utf-8?B?MzJ6VGFjUi9pQVpUNit6ZDN6Qnk0bVRhQUt6b0dpR3pDUU1PUkRNNnkvVm82?=
 =?utf-8?B?RnA1dU5oMXpGU2RLOXo1eEFmRUdvSit5SnppZmZkNnJxcmN4amJEUjZTTHlM?=
 =?utf-8?B?dG00S1BmRlBaNEdqYndLYStTQWNUbzJ0UXdnMk9PSE5uK0pCNjY1cTRyT21U?=
 =?utf-8?B?QTZ0WE1DZGw3S2RlOTF5YTJpSUtVdkl5dDEzMW5YRHhyMFJRa2xueWhId1Vs?=
 =?utf-8?B?ZUpTYjhzRVN0bXJKZThsai93VW5UQ0ZDaGhOYUhOQktMenNCbkpxSnVkVnZB?=
 =?utf-8?B?ekNNOEdKY1RSb3N4bmRUTkF2c05Nc1V3WFVIcHpCM2s4eEJZZ2xRRmZpbnhG?=
 =?utf-8?B?Q0tsN1NXSkZnNVhvQWhseHpFcVFDTTBCUXBOd0trenBibmxIenBVMnIydVBT?=
 =?utf-8?B?cWg0d3dvam1OTVNOV1RrQjRrbnlvazg1TjlZbzUwalJVZGMwcHNETHVBdFNy?=
 =?utf-8?B?RGlUdUx5d0lhb0U1RS96UWpXYXhra28raFVLU1d2eWdJVXB4VGFCUFBrOUYv?=
 =?utf-8?Q?lrDl1ROpGwJqUGnnIYrGv3Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4336BA671B2E7945AD0AB10DAF601A14@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8671196-1c1d-4504-6284-08dac107cbcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 21:34:05.3888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SxS3fWBnXjiNOGt3a+jkZrCFQyCqMP/MVDurk5Euu6kPRw+irB94Tao11uFd+KliakdJW+JJPo1w6lCd+cVkvtBaUNe5uOOoXE6OS7+Bpow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6387
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTExLTA3IGF0IDEzOjIxIC0wODAwLCBILkouIEx1IHdyb3RlOg0KPiA+ID4g
U29tZSBhcHBsaWNhdGlvbnMgYW5kIGxpYnJhcmllcyBhcmUgY29tcGlsZWQgd2l0aCAtZmNmLQ0K
PiA+ID4gcHJvdGVjdGlvbiwNCj4gPiA+IGJ1dA0KPiA+ID4gdGhleSBtYW5pcHVsYXRlIHRoZSBz
dGFjayBpbiBzdWNoIGEgd2F5IHRoYXQgdGhleSBhcmVuJ3QNCj4gPiA+IGNvbXBhdGlibGUNCj4g
PiA+IHdpdGggdGhlIHNoYWRvdyBzdGFjay4gICBIb3dldmVyLCBpZiB0aGUgYnVpbGQvdGVzdCBz
ZXR1cCBkb2Vzbid0DQo+ID4gPiBzdXBwb3J0DQo+ID4gPiBzaGFkb3cgc3RhY2ssIGl0IGlzIGlt
cG9zc2libGUgdG8gdmFsaWRhdGUuDQo+ID4gPiANCj4gPiANCj4gPiBXaGVuIHdlIGhhdmUgZXZl
cnl0aGluZyBpbiBwbGFjZSwgdGhlIHByb2JsZW1zIHdvdWxkIGJlIG11Y2ggbW9yZQ0KPiA+IG9i
dmlvdXMgd2hlbiBkaXN0cm9zIHN0YXJ0ZWQgdHVybmluZyBpdCBvbi4gQnV0IHdlIGNhbid0IHR1
cm4gaXQgb24NCj4gPiBhcw0KPiANCj4gTm90IG5lY2Vzc2FyaWx5LiAgVGhlIHByb2JsZW0gd2ls
bCBzaG93IHVwIG9ubHkgaW4gYSBDRVQgZW5hYmxlZA0KPiBlbnZpcm9ubWVudCBzaW5jZSBidWls
ZC90ZXN0IHNldHVwIG1heSBub3QgYmUgb24gYSBDRVQgY2FwYWJsZQ0KPiBoYXJkd2FyZS4NCg0K
V2VsbCwgSSdtIG5vdCBzdXJlIG9mIHRoZSBkZXRhaWxzIG9mIGRpc3RybyB0ZXN0aW5nLCBidXQg
dGhlcmUgYXJlDQpwbGVudHkgb2YgVEdMIGFuZCBsYXRlciBzeXN0ZW1zIG91dCB0aGVyZSB0b2Rh
eS4gV2l0aCBrZXJuZWwgc3VwcG9ydCwgDQpJJ20gdGhpbmtpbmcgdGhlc2UgdHlwZXMgb2YgcHJv
YmxlbXMgY291bGRuJ3QgbHVyayBmb3IgeWVhcnMgbGlrZSB0aGV5DQpoYXZlLg0KDQo+IA0KPiA+
IHBsYW5uZWQgd2l0aG91dCBicmVha2luZyB0aGluZ3MgZm9yIGV4aXN0aW5nIGJpbmFyaWVzLiBX
ZSBjYW4gaGF2ZQ0KPiA+IGJvdGgNCj4gPiBieToNCj4gPiAxLiBDaG9vc2luZyBhIG5ldyBiaXQs
IGFkZGluZyBpdCB0byB0aGUgdG9vbHMsIGFuZCBuZXZlciBzdXBwb3J0aW5nDQo+ID4gdGhlDQo+
ID4gb2xkIGJpdCBpbiBnbGliYy4NCj4gPiAyLiBQcm92aWRpbmcgdGhlIG9wdGlvbiB0byBoYXZl
IHRoZSBrZXJuZWwgYmxvY2sgdGhlIG9sZCBiaXQsIHNvDQo+ID4gdXBncmFkZWQgdXNlcnMgY2Fu
IGRlY2lkZSB3aGF0IGV4cGVyaWVuY2UgdGhleSB3b3VsZCBsaWtlLiBUaGVuDQo+ID4gZGlzdHJv
cw0KPiA+IGNhbiBmaW5kIHRoZSBwcm9ibGVtcyBhbmQgYWRqdXN0IHRoZWlyIHBhY2thZ2VzLiBJ
J20gc3RhcnRpbmcgdG8NCj4gPiB0aGluaw0KPiA+IGEgZGVmYXVsdCBvZmYgc3lzY3RsIHRvZ2ds
ZSBtaWdodCBiZSBiZXR0ZXIgdGhhbiBhIEtjb25maWcuDQo+ID4gMy4gQW55IG90aGVyIGlkZWFz
Pw0KPiANCj4gRG9uJ3QgZW5hYmxlIENFVCBpbiBnbGliYyB1bnRpbCB3ZSBjYW4gdmFsaWRhdGUg
Q0VUIGZ1bmN0aW9uYWxpdHkuDQoNCkNhbiB5b3UgZWxhYm9yYXRlIG9uIHdoYXQgeW91IG1lYW4g
YnkgdGhpcz8gTm90IHVwc3RyZWFtIGdsaWJjIENFVA0Kc3VwcG9ydD8gT3IgaGF2ZSB1c2VycyBu
b3QgZW5hYmxlIGl0PyBJZiB0aGUgbGF0dGVyLCBob3cgd291bGQgdGhleQ0Ka25vdyBhYm91dCBh
bGwgdGhlc2UgcHJvYmxlbXMuDQoNCkFuZCB3aGF0IGlzIHdyb25nIHdpdGggdGhlIGNsZWFuZXN0
IG9wdGlvbiwgbnVtYmVyIDE/IFRoZSBBQkkgZG9jdW1lbnQgDQpjYW4gYmUgdXBkYXRlZC4NCg==
