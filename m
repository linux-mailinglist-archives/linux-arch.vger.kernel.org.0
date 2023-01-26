Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BFC67C21D
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 01:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbjAZA7q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Jan 2023 19:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjAZA7p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jan 2023 19:59:45 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B714A5CFF6;
        Wed, 25 Jan 2023 16:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674694784; x=1706230784;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zL14gX0JolSX8fkFiS4fpcJ9v3DpCht2+JYFFWolJFM=;
  b=Vs310XMW6QBAx2/tSctsYn9EJm4HO7n0P2tRxoLjiaNeexOT7aJPRMUB
   6v2t8CiDd1N/aQw8grTuUS2iUQDduQq2fwaC78CKmBW3u+j3AE6eKBW1i
   2qBs0lrxHopEyU6gENVzuOuC+fPM8mgcMYD+Uhdo97TLmAop3roVwzNUo
   9B3MExOobqVqZHfMTdCnovEMa1BbcDwhso2/Dn7+yGldFUC4mY0q1/esV
   ESVZ+B9EJ2G9t7p3FQxX0Pp8wehHQQtb5coiHdsE7biKmyI4SIbBIH/ii
   anU8xMKFDj/tej0lch4F0vyfCmPuNWI/DY8pFuY/Pfas+lsjmCcB1M+ZE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="324427194"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="324427194"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 16:59:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="726098403"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="726098403"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jan 2023 16:59:17 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 16:59:15 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 16:59:15 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 16:59:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ap2FdPtx+CCm0rJ4DL3fQrOyn77oHz81cl4mOcgmJ/BOMkgh/WPQPvUo+b69AFAVYNqkO/LkPsHZ5gHW/pADAb2rvo/0iN0Vv7t32P0Gj5fPYhi3Ak1rh32G2sBNVeSA2HMY4T2PkGNB6H1mnUfxU3ou3dKvxC5hWeE6MR6XGvZVfjrbfTsavsmnEEVr5qnUu7qxfWW1gbA92Fp5U3jXZAkAl7Xu+wlWHAb11AR/2eCHy0/GFFTxGgCAh/9Y/CVWcmQOM6TX9GTdzUVoD4bPIAFm0UHM7fTAl46B/F8D+K3z2nSv2WOY8ldmVne1VqvQjzgitox/fF72sU0MpYXAbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zL14gX0JolSX8fkFiS4fpcJ9v3DpCht2+JYFFWolJFM=;
 b=bg8sHLOlh1aAovRHHs3QAkZOzj5DxzEv+d6NDWcQNP5KJeDMcXZ1lBtah6cHn6XMoWcJuWhQOEiJxpbqwQEh7q7WeicG1MLW0yS4AP4DpJwej5nLxd4wIfEvjJan+dF8W+Uicu8LFlXl8h5dHSFfYhFZAONMKitpnWgm1HxmdFPeKpnUf8/Sb7p11mpVle8g1NEsqJXWA48Kh8bnZ2hH9bwes5JHcbv+F60nKOkYfswLhzl1f90xdKZZdzNb8m0rUwRY99T/DN3VRObtK7KrJgN7SB/gPZ/oWj+1AAVMrgX4Xm4fNvRGHRCpZG0sMfOX0mHUXW/UdmDD0zwP4wkbKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SJ2PR11MB7475.namprd11.prod.outlook.com (2603:10b6:a03:4c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Thu, 26 Jan
 2023 00:59:12 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6043.021; Thu, 26 Jan 2023
 00:59:12 +0000
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
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v5 18/39] mm: Handle faultless write upgrades for shstk
Thread-Topic: [PATCH v5 18/39] mm: Handle faultless write upgrades for shstk
Thread-Index: AQHZLExgp79hLxaTJUWnXCRef2z2Ua6rx5SAgAC3h4CAAUjWAIAAHt0AgAD++ACAAJuKAIAAaOSA
Date:   Thu, 26 Jan 2023 00:59:11 +0000
Message-ID: <899d8f3baaf45b896cf335dec2143cd0969a2d8a.camel@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
         <20230119212317.8324-19-rick.p.edgecombe@intel.com>
         <7f63d13d-7940-afb6-8b25-26fdf3804e00@redhat.com>
         <50cf64932507ba60639eca28692e7df285bcc0a7.camel@intel.com>
         <1327c608-1473-af4f-d962-c24f04f3952c@redhat.com>
         <8c3820ae1448de4baffe7c476b4b5d9ba0a309ff.camel@intel.com>
         <4d224020-f26f-60a4-c7ab-721a024c7a6d@redhat.com>
         <dd06b54291ad5721da392a42f2d8e5636301ffef.camel@intel.com>
In-Reply-To: <dd06b54291ad5721da392a42f2d8e5636301ffef.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SJ2PR11MB7475:EE_
x-ms-office365-filtering-correlation-id: ac09988a-385d-4da1-4f2c-08daff3889b7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mKdNLX0Niny9wQqs556LZuPNN9aPhrpvvrMyqkui8sIJGnEHz9gO3/yXLso/WFyDIYLn5u8YQCEjj0Cmfnrpr8HwIHaPaS3IG6q2y4+rgZ8sXZ2zZJSQlWaMD0GSzcN+EMTAhEZ3l921wgxqs1bDjThSHJcUpo+jVMh/WDmBkWph0xSppeI2JqV8U5mOTe23XXNi3/IJ+SDzDKLx3ggfFixrixv9PqiWxxtsIumaS5AUUAnN4T3IaDoFgrLvNN1ACQpkf3lG6jVlHeGlVGuzTBZpTc/60J/dm47zL/GoZhD/tGSMIlSsiSQjIRclI1m73bIX+RkTipA0FeKj914F8g+LS974peib/GCnpnr9X39sXdhOU8Js+SjsbU0NWRCOlkcwltxsfsgYJvp+lhW8xOt/cWuEDcaFhhikqKtIWH9mWGShCmydnZUYAq06/jOzovdxJjsGaxElZMXAig7H8gUEVlO+wCHMADj7RAS7+xTvqPojKBKa2Mpj1k1N3sHhDzN5GZ7jE5UGZc+/agps517EI+KFYo4ZpBQtaJIWiylXCSpwNDCCg2no+4aee0/7wQTwDB451285BrBzQr4ibbZFnpnQaswddkhl4x3embXRuKERjen4DOOtkt0eoTHBNlm1o3HtgK6qTY43S0lCt9RNhe05QF/5yah1meeH3H2J10rgxI9iwVfsBQjVtJDq5cMCzal+XhAidUR+reOS3qhkUj9YBkAhkNG1eyo9l8LxIJ+EZFoSsvNPr5bmCtlXK26YdkIDN4NfzRTolte1x6NALL6L4a/owAiQxS+mBWhl2IduV42aNLLg3OaCWUXS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199018)(86362001)(36756003)(478600001)(316002)(71200400001)(966005)(110136005)(5660300002)(6486002)(66476007)(7406005)(2906002)(8936002)(66946007)(8676002)(4326008)(64756008)(66556008)(41300700001)(66446008)(7416002)(76116006)(38070700005)(2616005)(6512007)(6506007)(82960400001)(38100700002)(186003)(122000001)(921005)(83380400001)(26005)(99106002)(17423001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1lDUTB5VFNObHVTYjhwMHBYN3h3aVBhYThtMEk3elRxYWN0Tktyd1hkOUN4?=
 =?utf-8?B?N0txcGdOZ3l5MGJxRXJCK3VWRHhEcGIzRmhXcE5OSlBhcDJQeEpJRlNUUU9q?=
 =?utf-8?B?SXN5MjlLakptbXByc3hSbHBkZDRGSTljM1B0YjlnUjVUUjFSSjBySVJ3SXQ4?=
 =?utf-8?B?SUgrcXRzQ0JjcDJqancxWGZjSlFMMDlmVTBlbFpBemFWSU1uNmhTY0NXSHFn?=
 =?utf-8?B?cGMwZTd0dmZLSmJCRzNyZXR2ZFBobEVGbmpWZGR6RmdGR3dsRTZtYUZMc1lC?=
 =?utf-8?B?a0ZFS0J1bytHY2dGODRveVdhUUpaditiVW9lSEx1YkdieFZDTDBtZml5YitL?=
 =?utf-8?B?SnVkeDVNUUlVWTIwWC9oN0tFMEdvSXVCY0ZpeWhNZDQwblE0ckJ1WDRKaEtx?=
 =?utf-8?B?UFlXd2phM0laNFpFeXpjQjk4THRCV2sxVUN0NWtwMVVuZ0wxVWJyT2VpUnYr?=
 =?utf-8?B?NVRuZTN5cGRjK3hzZ3BjdW0yc2JVU1l3T28yaE02OHFUOVo0ZTUrc21YNjNk?=
 =?utf-8?B?dXptMGNhZE1wQm9GL1JqcXZuWVhnZDJETlJKaHlOVHRsbDUrZGZhYzQzYStW?=
 =?utf-8?B?WnBsNXRvYUtRbW5QbHFSY2N4Sy9RNXE1WlpJV1VQYnlVM1Q1a2xhYXdKMUZy?=
 =?utf-8?B?V1NtYjdic3RXNlNueHBqaW9WTXlCVWNER2MzdVlyVDR6RHZBK29BWjBJazBK?=
 =?utf-8?B?QW5VeWlad0pMTUM3ZW5WSGV6dkY1RFBJanpKT3NKSFU5cUlObU0weWZJUDBI?=
 =?utf-8?B?aGdsZmVFNVFvVE9QbEUrYTY3Y2REcWgyUzJobkpINHE5cUhxQmtyYzE0anU2?=
 =?utf-8?B?N3RxcThhWUJYY0R2ZVMyK3UzaDBJRXExQkFpbVIrU0xmWnhDZXdtNDdjVGxQ?=
 =?utf-8?B?U2pFcnpnZTZBSDlPYS9qZGduRG1BdVRLTFlCQjRQaXduYmFPVXZyT3lZeHgy?=
 =?utf-8?B?TElGbUpaaE9MaTczMTU1cEZpZUJKR25zcTNhQ1JvQlFkQ05BRzcyZHlrMWZs?=
 =?utf-8?B?R2VnZjNuUUV5L29ZeGFwOUkzcmhKaENBMWNzdzJWVXNqd2pheGJPY2wrMGFr?=
 =?utf-8?B?anoya0tjRTVqRE55Ni9SK09mVytlRDd0eU9uaklHRUdxVDVXMEd2dmJxMXZ5?=
 =?utf-8?B?TWlrV2dBSTJDMTVQOHlGeTMzVWpFVEx5djNOT0ZUOG9INHJzNitycisySisw?=
 =?utf-8?B?UzQvRnNrdTJYaStjM0x2ejZwWDM3V2lZcml4SWhXQmlodHgyaDZRaTgwVVUr?=
 =?utf-8?B?b01KOHdpQ0VqeDhPNURCWXdkMWNqay9GVU4xb3NFTWwrVEhzWHFQZWM0OWtj?=
 =?utf-8?B?VURaY21seFZlSk9YejA4S1BQOXFOSGU3M3M0NlFXekhXd2tzaTdtN1E3TnBa?=
 =?utf-8?B?eTA5dm1MRDVzV2NRMWVpUlhFZ2dWZGdFQmVmMWtlYlVPOEt3SHNhamhBQXl6?=
 =?utf-8?B?N2tqSGR6WXV3WFhZcWhhVmRQU0oxS0xwNldpT1lROHFSRmdQb2tjK2FOb01M?=
 =?utf-8?B?UzJWd055eExhTWNlNElGWEJxQzQxWGtRaGlpRktjTjFXMU0vQzBFc0VxNmV2?=
 =?utf-8?B?cWRBeDBxd281b29qZ1BBVStTUG11SE83WHNwSHFNclM5K25TZTNCZ1NrcGJj?=
 =?utf-8?B?QTA1QWlrZHI1QXF6VEpDRjJWdXM5YlQwc01uOTBOc2t0ZHNMR2ZZV0xNK2c4?=
 =?utf-8?B?WTVDQ3NNdGcvckxCam83U2toUWRYRW9wcHB3eEppbnJINVJQWGs2VUFGNGVz?=
 =?utf-8?B?S2hBcWMxVEVkT01TdU1kYW1uQy9MbXJzK0lpVmJSKzF6MjBHRkM2VjFDemMz?=
 =?utf-8?B?VGhxRUZkcms4cS9sTEtVQ2lxU1gzQmRteU1lWTUwSWFHMlY1NzRrRkZaWHlo?=
 =?utf-8?B?UWhNd0NhTzd1a0w3OFBsZmNybTV5SjNpcjRoZ1JKM2JQUUJrMUlGTEMwbnFP?=
 =?utf-8?B?THExZ2h4Q1RIbmtXclVxejFtYmpuOWZLSjlOZlBCK2UxQmRBYlpYWEFmaDc3?=
 =?utf-8?B?eVFpcHlxd0gvWUhpUmxkYTlJemdkMXFGdGZSa2l3TFZLT21BN08xejRYWUwy?=
 =?utf-8?B?WXljV3pSMklxQ1o4cFJURGNLa3daZHBtTjdwOVcxR0w5R1NXNndWWjNBcitw?=
 =?utf-8?B?VGlkMU8rSWVuaWduV29kaTY3VTRONjJ0ZDRGbVBHMG1PN0JaQjVzYmdWR3JP?=
 =?utf-8?Q?Si3PCR0USnkxuVhBiqGmnvw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD14679EDC43CB4FA150A842A7060951@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac09988a-385d-4da1-4f2c-08daff3889b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2023 00:59:11.9621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uQh2yP24pkaQctkGMGdlTW/x1IkFqbPLJ/S7QWn0G+fVG6Fghm2ifZ5E4LkPy2zcZJ8VqGCSQtcjaAnNud8QQEoAa6teq3F5rAxaafPsuPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7475
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gV2VkLCAyMDIzLTAxLTI1IGF0IDEwOjQzIC0wODAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzIGFuZCBpZGVhcyBoZXJlLCBJJ2xsIGdpdmUgdGhl
Og0KPiBwdGVfdCBwdGVfbWt3cml0ZShzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwgcHRlX3Qg
cHRlKQ0KPiAuLi5zb2x1dGlvbiBhIHRyeS4NCg0KV2VsbCwgaXQgdHVybnMgb3V0IHRoZXJlIGFy
ZSBzb21lIHB0ZV9ta3dyaXRlKCkgY2FsbGVycyBpbiBvdGhlciBhcmNoJ3MNCnRoYXQgb3BlcmF0
ZSBvbiBrZXJuZWwgbWVtb3J5IGFuZCBkb24ndCBoYXZlIGEgVk1BLiBTbyBpdCBuZWVkZWQgYSBu
ZXcgDQpmdW5jdGlvbiB0aGF0IGNhbiBiZSBvdmVycmlkZGVuIGluIGFyY2ggY29kZS4gSSBlbmRl
ZCB1cCB3aXRoIHg4Ng0KdmVyc2lvbnMgb2YgdGhlc2UsIGxpa2UgdGhpczoNCnB0ZV90IG1heWJl
X21rd3JpdGUocHRlX3QgcHRlLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSkNCnsNCglpZiAo
ISh2bWEtPnZtX2ZsYWdzICYgVk1fV1JJVEUpKQ0KCQlyZXR1cm4gcHRlOw0KDQoJaWYgKHZtYS0+
dm1fZmxhZ3MgJiBWTV9TSEFET1dfU1RBQ0spDQoJCXJldHVybiBwdGVfbWt3cml0ZV9zaHN0ayhw
dGUpOw0KDQoJcmV0dXJuIHB0ZV9ta3dyaXRlKHB0ZSk7DQp9DQoNCnB0ZV90IHB0ZV9ta3dyaXRl
X3ZtYShwdGVfdCBwdGUsIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKQ0Kew0KCWlmICh2bWEt
PnZtX2ZsYWdzICYgVk1fU0hBRE9XX1NUQUNLKQ0KCQlyZXR1cm4gcHRlX21rd3JpdGVfc2hzdGso
cHRlKTsNCg0KCXJldHVybiBwdGVfbWt3cml0ZShwdGUpOw0KfQ0KDQojaWZkZWYgQ09ORklHX1RS
QU5TUEFSRU5UX0hVR0VQQUdFDQpwbWRfdCBtYXliZV9wbWRfbWt3cml0ZShwbWRfdCBwbWQsIHN0
cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKQ0Kew0KCWlmICghKHZtYS0+dm1fZmxhZ3MgJiBWTV9X
UklURSkpDQoJCXJldHVybiBwbWQ7DQoNCglpZiAodm1hLT52bV9mbGFncyAmIFZNX1NIQURPV19T
VEFDSykNCgkJcmV0dXJuIHBtZF9ta3dyaXRlX3Noc3RrKHBtZCk7DQoNCglyZXR1cm4gcG1kX21r
d3JpdGUocG1kKTsNCn0NCiNlbmRpZiAvKiBDT05GSUdfVFJBTlNQQVJFTlRfSFVHRVBBR0UgKi8N
Cg0KQWxsIHRoZSBvdGhlciBwdGVfbWtkaXJ0eSgpcywgZXRjIHJlbWFpbiB0aGUgc2FtZS4NCg0K
UHJldmlvdXNseSwgdGhlcmUgd2FzIGEgc3VnZ2VzdGlvbiB0byBub3Qgb3ZlcnJpZGUgdGhlDQpt
YXliZV9ta3dyaXRlKCkncyBhbmQgcHV0IHRoZSBsb2dpYyBpbiBjb3JlIE1NIGJ5IGhhdmluZyBh
IGdlbmVyaWMNCnZlcnNpb24gb2YgcHRlX21rd3JpdGVfc2hzdGsoKSB0aGF0IGRvZXMgbm90aGlu
Zy4gQnV0IGdpdmVuIHdoYXQgd2UgYXJlDQp0cnlpbmcgdG8gZG8gd2l0aCBwdGVfbWt3cml0ZV92
bWEoKSBpdCBzZWVtZWQgYmV0dGVyIHRvIGhpZGUgYWxsIHRoZQ0Kc2hhZG93IHN0YWNrIFBURSBj
aGFuZ2VzIGluIGFyY2ggY29kZSBhZ2Fpbi4NCg0KQWZ0ZXIgdGhlIGNoYW5nZXMsIHRoZSBvbmx5
IHNoYWRvdyBzdGFjayBzcGVjaWZpYyBiaXRzIGluIGNvcmUgbW0gYXJlDQp0aGUgYml0IGluIEdV
UCB0byByZXF1aXJlIEZPTExfRk9SQ0UsIHRoZSBtZW1vcnkgYWNjb3VudGluZywgYW5kIHRoZXNl
DQp3YXJuaW5nczoNCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMDExOTIxMjMx
Ny44MzI0LTI2LXJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tLw0KDQo=
