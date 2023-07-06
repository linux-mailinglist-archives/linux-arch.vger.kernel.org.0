Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D187074A2B8
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jul 2023 18:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjGFQ7v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jul 2023 12:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGFQ7u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jul 2023 12:59:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FC9171D;
        Thu,  6 Jul 2023 09:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688662789; x=1720198789;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=drrptbnFqb0Ef9VpUjFjTzV8DjHHJQzTS/mKK3xIrf4=;
  b=GMyDU83G/qhBCNxQcMsYcnXdUb8qb31b7rBUBUvc4rZu+oU0i2qIFN6U
   X+eFDhHEX8vVFY8Z3EinWmGkjYnaTUkqlqaZ0gIm3dJvQThy2EO99YbgY
   4m1/814roRFa23X5O/wnPJ5uDQK78trTNwmLWPR8YH0ebr9XbsY6xIyxA
   Tbfz3xtUks1jsNlH6HCBBpcD5uGh6v3jCheLZz5bhPQFIshw5jGMuuV8F
   2RTJjby46YCJWqI9cyvb4HUGZ+OqGQCM5bZZfcMyQEK8ECE78RKMJc3Z2
   xvE2YCqh1iM/nDgar0pg/Au1a4306tQGvYbDRt9eYulTjopJaqDPA39uL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="361133806"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="361133806"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 09:59:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="864178666"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="864178666"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 06 Jul 2023 09:59:48 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 09:59:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 09:59:47 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 09:59:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 09:59:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQk6x9nZYdErLKkuWTo9sgOGRI3CbawWvz5YSCSbu9zcEXgmVWXOtEtqKZGEx9qOsRqzRYUqb2elXW50SpIMKxXsfcxRdYecc18mJxVSRAhdlhIRE91v0pUV1591lKAs1c7Bu09R50Ou5tp9Gp4undOJwEV8InP8f3Xwx42ReCY+jVpSE5yeVR0R51QEs5C6CSmcOhXgJAMzdIb52fqVEpUqjjPoogDnBLl68lKuTJHAhTTshfygF0wbpGy+2Wner+YxaYpgeTVJmQEeXn9D9YGIGkjCSCwE+Fm73RR3WjIU/Ns4G7Y9woSENnLSSiHNzhO9wDMuLZ3nJZJnUjUYrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drrptbnFqb0Ef9VpUjFjTzV8DjHHJQzTS/mKK3xIrf4=;
 b=kAosE+M7ELBfGgyLjsnkx3teUewlxhw8tb27S+yzK/RVrf7PBSdnrpR/MJiR0jXysMJsyXVxDqBM6L2Ymsv+YkIIF018nPBI/RrWBeTK0buwBH6h6zkITQulP+YcX45irmSvpVOJEVvMFDT6kyln8y+F099vekfgu8Cwky4RdgAvA6MNk6TG9VsabG1gNKILNpa4hDe2w0UEaPu1Er/nIxcDpEdlEsnup+hTNHvyZYO77HiMHYLiz3Pw9i/ZVRSAY5WOFWVqBlQD3Y3IjXYx+Ui0xj9yd3srwzi9uChXdMW0c8djaATklzQJF0dS9WKIk4aKV7muoCoOXXVGKBjJrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Thu, 6 Jul
 2023 16:59:45 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 16:59:45 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>
CC:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Thread-Topic: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Thread-Index: AQHZnYvD++9jHqJtDEOZ5j0eN4/f+6+IoOQAgAALyMOAACwFgIAAIG6AgAAMtoCAACGsAIAA96CAgABofQCAB1K5gIAAhUGAgAEVRoCAAKx+AIABDK+AgAB6bICAAPF/AIAAZrmAgAAVNICAAG62AIAKh/oAgATXZwCAAZabAIADLBsAgAAG/ACAAAHjgIAAA12AgAEpoACAABN+AIAAK2OA
Date:   Thu, 6 Jul 2023 16:59:45 +0000
Message-ID: <a7f312b1e712b87f4932d6295e6f6d28f41afd8f.camel@intel.com>
References: <eda8b2c4b2471529954aadbe04592da1ddae906d.camel@intel.com>
         <2a30ac58-d970-45c3-87d2-55396c0a83f9@sirena.org.uk>
         <0a9ade13b989ea881fd43fabbe5de1d248cf4218.camel@intel.com>
         <ccce9d4a-90fe-465a-88ae-ea1416770c77@sirena.org.uk>
         <ZKa+QFKHSyqMlriG@arm.com>
         <e9a377ce-7ce4-47b0-b30e-56a5aae18544@sirena.org.uk>
In-Reply-To: <e9a377ce-7ce4-47b0-b30e-56a5aae18544@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CO6PR11MB5602:EE_
x-ms-office365-filtering-correlation-id: 187631ab-8233-401d-a9fe-08db7e42668d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YfHbs8ZkON6hxzMj9PeQ8mG2uBjccbVcfN4aJEujKreVadju20LkNXwao3wslYjlUxFqNc4847u5eCRGQkiwtfvjxYofs6Kf3KdK5nut8W2K4EQ42AZIU7zZ88K80hRXkQvaeHQaqv4nzQgbXO1fdH1jTT2BGCiZ7SuttF4K9Dx5mn+sTSM9XXHSh8mDX3XaNdjqYqGcLDIk7M/P5ngMYoT/VqLUWwfvaan4QTLqQnyqfeu4SpkIk2YvXt2DHfSiyBrUQ+aWL8vzZRYeB6EqEFns9bNFEeWTGuV7Fq8l3ufMwzjgRP/Dvam/37O8PTw0F2snhLvMI4Em9qMVq+v4/UkmnGovELETmRM7v9F7qe2oNRaQ3JUESehw0U0nlCr9y9hNfTpbmTuPiY9QRR1LPPS2XfE0FZ4keJqGNV6jl6/EQY8YhJFZfJtFj3THBvFvizzyC3W2nfc2oby3zohBaOsXPzC/YioVqxymI6p9UNYAesmEJV0XKgT1DaljsL06Iv4RYKZSEpV3tV5ZOrebMRKIGF2F07QOWzntmq7xO1QshwviTzcr1qAhXGxU4YuSRFK0wCNVVeaPIZxJSYfLql+RTY3nSlpzZzVrHX5lb4GO8faoW/ZJdiGAsd+CXZyD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199021)(8936002)(8676002)(7406005)(7416002)(54906003)(4744005)(2906002)(91956017)(76116006)(110136005)(478600001)(66946007)(66446008)(64756008)(66556008)(4326008)(316002)(66476007)(6512007)(5660300002)(41300700001)(186003)(26005)(6506007)(2616005)(38100700002)(122000001)(82960400001)(86362001)(71200400001)(6486002)(38070700005)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjdSNkJwci9sajZyNXIxV3cyVnR4N2xKZDNiL3RIeGJZZXpHa2FnMHpoMjh3?=
 =?utf-8?B?dE4rVFNOVTN1YndUZFU1Ny81d3ViODhlOGRxbTJiQUFTZFlmQktHYTRiekhL?=
 =?utf-8?B?RlM3Wm03Mm1NaGhVWC9oN1pvUDdwV3YxU0dvUXJQRGxzVkJrcWVPU3IxR3VL?=
 =?utf-8?B?eHlnbnAvb2xKTlFKSXBPN0RDVGg5Q2pxaUhXWXB4VStZMFRiZVZDTnJyQnpu?=
 =?utf-8?B?MDZjQVJ1NUYwQzU4Um1KcmZ4VmdxNGd3YmdzRkJDb2hwa1BzREFyUDBpK1RJ?=
 =?utf-8?B?QVNUdkxzQVhzV1lWdzRKZjdwM2h2OEpmd3VseXFtYlNuaE91ZVczaElnVkd3?=
 =?utf-8?B?R0xWVUNZbExPK1AxVThOUXJTS2c4eUNnMmk1Tzk1ZmozL0tBZUNsMEswWUQx?=
 =?utf-8?B?QVpwZVZiTllFQmhsQ0kyUHpOclFkaFpmM2pjOGJMOTN5c3ladmlobTBvNFo4?=
 =?utf-8?B?bEVlT2dxQlpqbmhLTzNyT0NuQXNham1IRGZLY1JoYk5oczdVcldBRk1RZkp2?=
 =?utf-8?B?QWQ5TEF1U1hGaWVMVU9LVmhMRCtKYUVza3UvdTFGb1NzMWVUVW9KR1ZNazd4?=
 =?utf-8?B?TW5WYWtaU1NqVjRVYkRrd3VaK01NSkxhMFJTTkF6OWZoMDdQNWt6UXZFSWN6?=
 =?utf-8?B?U21jeU5BYXR3WU1DRExNV2gvZ3RnanpLcnJhNDl6RGZscnVTY01nOStKSEx4?=
 =?utf-8?B?ei9uTituWVJXSU90OC9wcXgvdTgwc3RiN0s0L01oeHh4YTlxcURGeWFpVXMv?=
 =?utf-8?B?WGNJYjJCU1k3akExTVNWYlk1cVJkYnRlWGN6RlRrOU9jc3JublpxU2ZjRUNH?=
 =?utf-8?B?SndjQjJlVVpSOWRwaHUwekF6QnUrYlI0Z3BSaVFGNUhyQnIwQzNvMytJb1p0?=
 =?utf-8?B?d21IMDZCbHh3T3V5WEU2Nlh5dXhGZHhhcUd6K2xCU29wSVBoL3VSZE44YUpw?=
 =?utf-8?B?bSs1VDc2S2Fod0gyNGh1Ky9MZ0ZBR2hTcTI0VzFZaEErNUtzTEFXRTJJeThC?=
 =?utf-8?B?ZnpQOEZONm9FU0lhc2ZuNklycVc3bTd3cHY1Zy91TWNQZ3RlRCtqWGlCanFK?=
 =?utf-8?B?QVFlT0NCMkMyMFFrUEdFV0QzTS9FMTl6TXZuU24wR1FOeWhGWURqVk1QdnZF?=
 =?utf-8?B?bnppREtmejh6ZGVnQUNSTlYxMU1XS0ErQWJmK2JnM1JtNG45UHRDbitMUXVO?=
 =?utf-8?B?UU1tdW9JbU4wSnBBTmwyZFBlWWh3dWc1ekEvajR6U2dvdENHUEFBa0liUHY5?=
 =?utf-8?B?ZTNVdFJ1ZjR0U2hMajZJdWY2N0tKOG5kV3k1WmxHL2xiMVZ1T1BVbjd3aTk2?=
 =?utf-8?B?Ny8vcC94NDhxUExvandJRWhFMWd4aU5hb1hkcTBWTXIvbkt0NDJ5aUk1R2I5?=
 =?utf-8?B?ZitxRFAwSHB4NjJkRjdOWnVNRGV1UjIwTTN3ZlVXMnMvWFZuWk84SUxWMWp6?=
 =?utf-8?B?TjYwZnFJaTB6czJpYk9VclNsdU5sRFhxaWd0c1puaWVsYUIyT0NGZWpDWjlK?=
 =?utf-8?B?TTc5NXkwTFU3TGMzUjl0K0ZpdnNtSUlZOFgrdGt5TzJIbytBYTNhSE1uZzhW?=
 =?utf-8?B?Z21MdHVEQ2tXVzZIR1pTZFpYZ216a2hsSXU2SmdWTktaZ3JzWXJoK1RVakg5?=
 =?utf-8?B?UGR0ZkpnZUpSeFlJRTlHSHVYaXFELzJpRmFQc2dMaFYwNDRUc1RJamwrRnk0?=
 =?utf-8?B?a2lHM0toblIzSTRGa0xxREtsVEZuSndoN3FoVUxtT0ZyalJUMVZpRDdlc1ZB?=
 =?utf-8?B?eTkrZWVjbzJZejF0bW1CSUpYaGtBanlibXVWSHJxZ2tWdmxwLyt0UjhISERQ?=
 =?utf-8?B?akpJVXo2WUMwamVtK09TZmdCZjdzUmpGNU1mRS96bFhsdUtad3dYUUJHdG1D?=
 =?utf-8?B?NUJjNmgyeko3VEZUTWFkMjNjcDltMG44bzVvY3l2cVFZTmEvNmo3blhBeW1w?=
 =?utf-8?B?dkhENmdSNmc1NUVRbXJwOUFhWTR6SmNIRjdQMzhZL2tEUGphTUtYTEVqTTNR?=
 =?utf-8?B?L0orNlE3MGp3MjVWbFlXS2lIakFCRVNVdUJlSms4V1V3d0VzRlpVUWE5NEp3?=
 =?utf-8?B?WmJ1UWlwOXl6R3E5a3cwQ2NPeFBVQmMrem8vVHUrMEJZUFYyZFI5VFBLTysw?=
 =?utf-8?B?QnVxVTFQNVpBZTZRNDIrUVF6Ry96Wk5nTDR2UW9FcjR5VHR3NzRET0lKZC9X?=
 =?utf-8?Q?ypYvAmQw90BHaJbDcFtgo24=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E6FE8D8902E204E95453666D6DA2525@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 187631ab-8233-401d-a9fe-08db7e42668d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 16:59:45.6451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J9xWf17h7OLgU7cM5NqsGWt+WxRbdiGX4gfF0cKOHs+4cYYGH3xgIs2Kcz3TdCdLzKxTl46yNoIsfRRC2TLiT+1ZioGvlq0x2i+EaMu3agQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5602
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIzLTA3LTA2IGF0IDE1OjI0ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBUaHUsIEp1bCAwNiwgMjAyMyBhdCAwMjoxNDo0MFBNICswMTAwLA0KPiBzemFib2xjcy5uYWd5
QGFybS5jb23CoHdyb3RlOg0KPiA+IFRoZSAwNy8wNS8yMDIzIDIwOjI5LCBNYXJrIEJyb3duIHdy
b3RlOg0KPiANCj4gPiA+IFB1c2ggYW5kIHBvcCBhcmUgb25lIGNvbnRyb2wsIHlvdSBnZXQgYm90
aCBvciBuZWl0aGVyLg0KPiANCj4gPiBnY3Nwb3BtIGlzIGFsd2F5cyBhdmFpbGFibGUgKGVzZW50
aWFsbHkgKnNzcCsrLCB0aGlzIGlzIHVzZWQNCj4gPiBmb3IgbG9uZ2ptcCkuDQo+IA0KPiBBaCwg
c29ycnkgLSBJIG1pc3JlbWVtYmVyZWQgdGhlcmUuwqAgWW91J3JlIHJpZ2h0LCBpdCdzIG9ubHkg
cHVzaCB0aGF0DQo+IHdlDQo+IGhhdmUgY29udHJvbCBvdmVyLg0KDQpBaCwgb2shIFNvIGlmIHlv
dSBhcmUgbm90IHBsYW5uaW5nIHRvIGVuYWJsZSB0aGUgcHVzaCBtb2RlIHRoZW4gdGhlDQpmZWF0
dXJlcyBhcmUgcHJldHR5IHdlbGwgYWxpZ25lZCwgZXhjZXB0Og0KIC0gT24geDg2IGl0IGlzIHBv
c3NpYmxlIHRvIHN3aXRjaCBzdGFja3Mgd2l0aG91dCBsZWF2aW5nIGEgdG9rZW7CoA0KICAgYmVo
aW5kLg0KIC0gVGhlIEdDU1BPUE0vSU5DU1NQIGxvb3BpbmcgbWF5IHJlcXVpcmUgbG9uZ2VyIGxv
b3BzIG9uIEFSTcKgDQogICBiZWNhdXNlIGl0IG9ubHkgcG9wcyBvbmUgYXQgYXQgdGltZS4NCg0K
SWYgeW91IGFyZSBub3QgZ29pbmcgdG8gdXNlIEdDU1BVU0hNIGJ5IGRlZmF1bHQsIHRoZW4gSSB0
aGluayB3ZQ0KKnNob3VsZCogYmUgYWJsZSB0byBoYXZlIHNvbWUgdW5pZmllZCBzZXQgb2YgcnVs
ZXMgZm9yIGRldmVsb3BlcnMgZm9yDQpnbGliYyBiZWhhdmlvcnMgYXQgbGVhc3QuDQoNCg==
