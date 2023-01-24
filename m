Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5AC67A0F8
	for <lists+linux-arch@lfdr.de>; Tue, 24 Jan 2023 19:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbjAXSOj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Jan 2023 13:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjAXSOi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Jan 2023 13:14:38 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB23A18A9C;
        Tue, 24 Jan 2023 10:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674584076; x=1706120076;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yT5LuNfka3w8cCej8Nb8gY6bRzZBWyluTyfMmp96L6o=;
  b=DV9gV3gNjWRz510FEivP6r7+SwrInbeptzFe3/NRGTN+M2AfumqLvBnX
   Uwumak88JMJPBUh5ZD8vUH8HM/NdjHo8PV5jbWoUKD5WBxcBCFXYmt6h7
   Hc8QFiQ/AbWGnKoLf7uE0Zc178U8Y8sQLH6IvdZmgS1VJf22P3sIqsCsz
   AAj/h72a81rDvmqSfaumI1AqEbmk1rrvXAzx4SBjN9xL2Im00rYupdkUu
   nsaTb/BWdeHdPJQG1ptCqyDbGt2nUifJS/pBCfyC2KLvrBs98H5ZvPjhe
   N5gdg5FJSV89A+QF6BX6cb92w5ORa6b9wlE9Pu6RZqXY7No7MShrfBQEn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="390869614"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="390869614"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 10:14:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="639665573"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="639665573"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 24 Jan 2023 10:14:34 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 24 Jan 2023 10:14:34 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 24 Jan 2023 10:14:34 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 24 Jan 2023 10:14:34 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 24 Jan 2023 10:14:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPNVhhu3fu+ZzCKh4tHxRUs5xpO24/GFZADuHqQ/pAL1BIHsdVgrkLWqAYYPxJuUh9VCBgM2+VP7m3EfIPDEVT5PGLJbwECgihM/YgXU26TYDS5rzRt5ELmIJgMUiRonFzzOV2cznt6FIC4nWV4bL1TQSFVwOxlM3/BhNCq/ySxwcjMANvMec++fDYEiSlQ2PQ0ycwO/n+8P+0hTDq3KxpbG0WkPt5BJnq+7+idcDZhPNZIJd/S7ZcYnv6T/bJraBHIvWPsKKqJ7bvDtq4SZ6DZz8a364aVhTs0mexWuRgaXT2m5v2/tEORmwHGreVDlMcmaCq7zMtA/IsD94GehFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yT5LuNfka3w8cCej8Nb8gY6bRzZBWyluTyfMmp96L6o=;
 b=i/pB7pF62dD5yvljzq/r0HMzRz62VCh26V/WoBUWP+4O4SD79mzCem7f0Mwtl/Y3SaQiE0z97D9C0xfVYjVmadF5+bYMwAHepzV6RGOfE30wu8MsMQDjDUyhTDnNeQWtyjEFVkmdfow7mkRGR8YVeIPkYHwdEUUc+RLIjLgx1v0xlzmSFUzt8RKCoYIjeHH7sr0dnKQVy2+lIicr5YZtGHckfRAhQ9UrMHF88YWxNRdAfeNutfbH4NN6dSm1DU3yd/o7lqUeV6Mo8nhIKsEe+ceBtYcCbg6cxeWGZE6K5bAg73G0aDgm0aKKLSm7ltSFOrKzRlllEJp4h62V/BJTFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM8PR11MB5688.namprd11.prod.outlook.com (2603:10b6:8:23::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 18:14:31 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 18:14:31 +0000
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
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v5 18/39] mm: Handle faultless write upgrades for shstk
Thread-Topic: [PATCH v5 18/39] mm: Handle faultless write upgrades for shstk
Thread-Index: AQHZLExgp79hLxaTJUWnXCRef2z2Ua6rx5SAgAC3h4CAAUjWAIAAHt0A
Date:   Tue, 24 Jan 2023 18:14:31 +0000
Message-ID: <8c3820ae1448de4baffe7c476b4b5d9ba0a309ff.camel@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
         <20230119212317.8324-19-rick.p.edgecombe@intel.com>
         <7f63d13d-7940-afb6-8b25-26fdf3804e00@redhat.com>
         <50cf64932507ba60639eca28692e7df285bcc0a7.camel@intel.com>
         <1327c608-1473-af4f-d962-c24f04f3952c@redhat.com>
In-Reply-To: <1327c608-1473-af4f-d962-c24f04f3952c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|DM8PR11MB5688:EE_
x-ms-office365-filtering-correlation-id: 5f84f13e-320d-44c1-f766-08dafe36d6d3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B6P/qx1AB9ierz6QXLK8ppFqVPBVmkH2CT2BwVTAbJ+X+MRzMyzTWdaSkUXfWuq9ctuhHSHdP2EVQYa2kjyMV6dQf47jkcIoI7ptbk6F4AzYCGFJJYKxWMnOb+n60UWmg6uQQTeBmWqLjLmgEPsa5LFzQHEz/ABLvtcJPeOw8QrzBuL1qURF+L1BbdLpciywx8WHH01PtWGwUUc7qZhMNxz1pcHgTHvVYxbUQNb7X+6f7sgp6FK0zQBnTh3B/lU2dQ5UlCPUnnQbyAH/Tjxqd0Lev2wWEe3Had7bqhv8qjqPlS7OZY3JDjI/bfCwc8i0QnA3jxE2G6lsUHPQ4IACOxtuKCZUxxvmNfBSL0Amx8dPV6pjtaZKJifQOMzyQVlcty5ejwlVX+glsAiMFzpKFr+TNxlKawWffSs1/yJwOF49liDXyXBtkaXIWqQqpWhAgR51NbOUD0kToH3ZEKQ+q0cav5uE8mZBJuiHPbQmjw4q+42T7oPttncacQO6lx4yQrHPp43ZsBqfUw2CVeNkvWOfMfP9pNgj5+HE7coCj3xsJE0N4s/Ji6fYmFyQMwIM4jud+LxmnR+nIpk+gjHj9BWQOPWzf3jA3TJwKJ8a3yxQLqVtTF4ZUeAQkg2lLZgbIxRVMQdzDd5TEzKPWrbSs334rxUgxb67cQZnptuYue+6NijmgJY4J6gMU6OzuZktw25BPCmQHHzLLsHhcncab7P1IJNLI0HSCV7r8kTo1s7Q1/UYyTRtopqKIX8FUYcFO/CyUiW5C/+TeogDveL61w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199015)(36756003)(316002)(71200400001)(64756008)(76116006)(86362001)(66946007)(4326008)(91956017)(66476007)(66446008)(66556008)(110136005)(26005)(8676002)(6512007)(186003)(53546011)(83380400001)(6506007)(921005)(6486002)(478600001)(82960400001)(2616005)(38070700005)(7416002)(7406005)(5660300002)(122000001)(8936002)(41300700001)(2906002)(38100700002)(99106002)(17423001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDdYUGZVSE5FMEQrNHNHZm1qVDI3WExrMmJmT0JHRFA4OXhkY3NMNW1ud0pF?=
 =?utf-8?B?Vkx6YTlxMmM4TXNUaExjamx2aVhHUkR0TUlZS1JaSU9VeXVQUEI3akRQek9u?=
 =?utf-8?B?dVVlNzUyL25MNC9ZZ3RMMVEzVW14M0w3NmNmdkdLcTVzR012RkhuNEZwU250?=
 =?utf-8?B?SldQTmU1RTJaQVE5YzR0ME5uaUh4MWpsOFJqVXErK1JpM1dVNmYxREk1dGRC?=
 =?utf-8?B?elgvREV5Si9JWk9qTmQ0T0V0Qm4xVlorVWRUaTVwV1ZHa2lPREJJdVhlaVlw?=
 =?utf-8?B?aDFmMkU0WnR6bmx3UUR4eUVqUkVBV0syRTdOM01BMVFkU3E0NWN4Q25tYmtr?=
 =?utf-8?B?am1VT1FIcElFeGc4ZWs0KyswcmVkZUljQko5L09CekFlYW02YnNtaW9HZ0Rr?=
 =?utf-8?B?cTJubEZaRkJMQlJXUE9BN3RzSnV5NkwyK2NqZnVOR0h5OFc0dVJHZ0VpVXVU?=
 =?utf-8?B?b2FuNExvVmxCZHlEaDdJelg2Ry93THlaTkpOWlZ0azV3RnY5UkJLeTR2OXl4?=
 =?utf-8?B?QnJPNTk4UHF5dll3WVRwVXcvcnF2SWNESHpTUnJ4N2Q4R05jQlRaajhXM2d5?=
 =?utf-8?B?SG1SL3pjTWZVeGw5amY2VEc5emg0NXVoUWxKZ1VNTDFaNG1Kek9Sd3hBSm5s?=
 =?utf-8?B?UFdQWXZ5Y2dmamVTa0FXMDdmVnYxaWNaR05wUmNIS1JXaVNsVndJbXdOYVVx?=
 =?utf-8?B?WGJpWk1kSkxlYUpzaTZjZXl5V2Z0ZTB4cUwrNzNkVE5BQ2JvS2lySnBadE1j?=
 =?utf-8?B?aXhzR2tkTk9zZStKZFVFZW9ZT3FZWlBwWGo2RnBYYUVMSlMweDRzV1h1QUlp?=
 =?utf-8?B?MDFqU3ZneUpKNzZ4eWpDeU53YUtlQURpT1BUeTZ3bUlDWEtaZGMvMmJRY1ps?=
 =?utf-8?B?LzI2LzM5bytXMlBmY0VrWVhyZU1LcEdJK3Z2YzMvaWNxZVVoUUptci9hYUNa?=
 =?utf-8?B?TStzejREbGtsajMvcGNmc255S2ZVaGpzR3JqbG9IUndaWXFMajJ1bHA4U1Z1?=
 =?utf-8?B?SURDc0dvbGtzQkRpUnFLc0swOGpmWklOd0wzNEYyOHcyUlJlTWp5eHlRZDZw?=
 =?utf-8?B?VzNzb1h0RnhWYUEyRVFYMkoxaTN1ckVMbUYzYzFBWnZNVy82SGV2OUJiK09l?=
 =?utf-8?B?MVU2TSsxQStFNzUzTG5uU3gxT1lUUFp4M0pXOUdiMThVYk9qeTZPUUFHRWpk?=
 =?utf-8?B?alpMbVFldnVJNm1WYU9tYnlwSnljZm04YVh1TG5ISHRNYkhZc3JsM3o1YmN4?=
 =?utf-8?B?YjlxdUVISW5PZDd4VFpQT1FmWWlIWVp5eUx2Y2NFMllQekJGVXpQY3hhbkxj?=
 =?utf-8?B?cFVqTXhqby94MUJxN0pwcHg4UU13TDZCZFZuSk5EcUgvaisrbXBBNDRhczdC?=
 =?utf-8?B?ME56WFhnd2NXRGFnYkZtQm1CVEZ1eDl1cEQwbmxSRDlodWlsRGVYUE9PaVJ3?=
 =?utf-8?B?RHc2bGFKbVlDU2VEQnRvQWRvc3VERjhjWG5mRkY2WUMvT2ZIUWZyaHo2S1gy?=
 =?utf-8?B?MmduSWUvd1daVXpyQ2JVbFk1WDNSekU2eGVWL05mNkJkeGI0MlVnbGlaN1Nj?=
 =?utf-8?B?WUhhUEdFbFhUSWRiUFY2alhZaXN1QmRMVFVReEF0WFdSZEJ0eDNic1AvQVR0?=
 =?utf-8?B?VzZPSzcvRUt0RE1HQnZxU2N5SHhFMHZBcHhkVVRjWUIrR29RZWM3aGVDWDNn?=
 =?utf-8?B?eXhVOEQrMFRlcEs4WXZoczdSSTQvSzJ3LzhEeVkwdUlCNFRlZVZBanlqTVh6?=
 =?utf-8?B?RVowQjU3TCtJOFRROW5iWk5QNlhrY3ByMDJFR2hHZHBZZkRkYk1jb1NxSWVR?=
 =?utf-8?B?eE5la0J5eXQyNGwxZkxhM2RmUnBubUhUT2lYUldlSFRIUTRyOWVudk9hdita?=
 =?utf-8?B?a2ZqQlJ0dTRDVndYc2FiSkc2MXBNN2NFSWtuSlpHUFVwUEJmdGpZN1E5ZWcw?=
 =?utf-8?B?aGo4cEhOaG90TW5jdEZLcGVvUnR4YlhNRDQ1ei9sd2V2SmczOGg4N3FnZEhZ?=
 =?utf-8?B?VzZPSXZQMlExL21HdVZEWm83QU1HL1VLV01uQllxYXJJTXYyQ0dUd3hNK1Jp?=
 =?utf-8?B?VmR6NnA3M3JBS1czYXlkOVdDRTYrd0tOb1BvVTROaTZEUTZIdXhRMUdrYlg1?=
 =?utf-8?B?YkJ5cUhOV2U5OXZ1eHNVeS9GMWZYU1VlcEV0UzZpdnVNdWNnZW1xK21EalhP?=
 =?utf-8?Q?bcyH1FL93MjE1ckq9J2AZ1s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01F04E87B882634F8BFEDCD68054DC18@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f84f13e-320d-44c1-f766-08dafe36d6d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 18:14:31.2095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nRQjos5MFyahZttVMc9OP1pC02DhJjaDvY7t1N/kigK6wb9OVB34GXs9/iL4rB620SccPJQXqv2Bhi4rruhHo1mT+P5brD6trBAUz7ajajs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5688
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIzLTAxLTI0IGF0IDE3OjI0ICswMTAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gT24gMjMuMDEuMjMgMjE6NDcsIEVkZ2Vjb21iZSwgUmljayBQIHdyb3RlOg0KPiA+IE9u
IE1vbiwgMjAyMy0wMS0yMyBhdCAxMDo1MCArMDEwMCwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6
DQo+ID4gPiBPbiAxOS4wMS4yMyAyMjoyMiwgUmljayBFZGdlY29tYmUgd3JvdGU6DQo+ID4gPiA+
IFRoZSB4ODYgQ29udHJvbC1mbG93IEVuZm9yY2VtZW50IFRlY2hub2xvZ3kgKENFVCkgZmVhdHVy
ZQ0KPiA+ID4gPiBpbmNsdWRlcw0KPiA+ID4gPiBhIG5ldw0KPiA+ID4gPiB0eXBlIG9mIG1lbW9y
eSBjYWxsZWQgc2hhZG93IHN0YWNrLiBUaGlzIHNoYWRvdyBzdGFjayBtZW1vcnkNCj4gPiA+ID4g
aGFzDQo+ID4gPiA+IHNvbWUNCj4gPiA+ID4gdW51c3VhbCBwcm9wZXJ0aWVzLCB3aGljaCByZXF1
aXJlcyBzb21lIGNvcmUgbW0gY2hhbmdlcyB0bw0KPiA+ID4gPiBmdW5jdGlvbg0KPiA+ID4gPiBw
cm9wZXJseS4NCj4gPiA+ID4gDQo+ID4gPiA+IFNpbmNlIHNoYWRvdyBzdGFjayBtZW1vcnkgY2Fu
IGJlIGNoYW5nZWQgZnJvbSB1c2Vyc3BhY2UsIGlzDQo+ID4gPiA+IGJvdGgNCj4gPiA+ID4gVk1f
U0hBRE9XX1NUQUNLIGFuZCBWTV9XUklURS4gQnV0IGl0IHNob3VsZCBub3QgYmUgbWFkZQ0KPiA+
ID4gPiBjb252ZW50aW9uYWxseQ0KPiA+ID4gPiB3cml0YWJsZSAoaS5lLiBwdGVfbWt3cml0ZSgp
KS4gU28gc29tZSBjb2RlIHRoYXQgY2FsbHMNCj4gPiA+ID4gcHRlX21rd3JpdGUoKSBuZWVkcw0K
PiA+ID4gPiB0byBiZSBhZGp1c3RlZC4NCj4gPiA+ID4gDQo+ID4gPiA+IE9uZSBzdWNoIGNhc2Ug
aXMgd2hlbiBtZW1vcnkgaXMgbWFkZSB3cml0YWJsZSB3aXRob3V0IGFuIGFjdHVhbA0KPiA+ID4g
PiB3cml0ZQ0KPiA+ID4gPiBmYXVsdC4gVGhpcyBoYXBwZW5zIGluIHNvbWUgbXByb3RlY3Qgb3Bl
cmF0aW9ucywgYW5kIGFsc28NCj4gPiA+ID4gcHJvdF9udW1hDQo+ID4gPiA+IGZhdWx0cy4NCj4g
PiA+ID4gSW4gYm90aCBjYXNlcyBjb2RlIGNoZWNrcyB3aGV0aGVyIGl0IHNob3VsZCBiZSBtYWRl
DQo+ID4gPiA+IChjb252ZW50aW9uYWxseSkNCj4gPiA+ID4gd3JpdGFibGUgYnkgY2FsbGluZyB2
bWFfd2FudHNfbWFudWFsX3B0ZV93cml0ZV91cGdyYWRlKCkuDQo+ID4gPiA+IA0KPiA+ID4gPiBP
bmUgd2F5IHRvIGZpeCB0aGlzIHdvdWxkIGJlIGhhdmUgY29kZSBhY3R1YWxseSBjaGVjayBpZiBt
ZW1vcnkNCj4gPiA+ID4gaXMNCj4gPiA+ID4gYWxzbw0KPiA+ID4gPiBWTV9TSEFET1dfU1RBQ0sg
YW5kIGluIHRoYXQgY2FzZSBjYWxsIHB0ZV9ta3dyaXRlX3Noc3RrKCkuIEJ1dA0KPiA+ID4gPiBz
aW5jZQ0KPiA+ID4gPiBtb3N0IG1lbW9yeSB3b24ndCBiZSBzaGFkb3cgc3RhY2ssIGp1c3QgaGF2
ZSBzaW1wbGVyIGxvZ2ljIGFuZA0KPiA+ID4gPiBza2lwDQo+ID4gPiA+IHRoaXMNCj4gPiA+ID4g
b3B0aW1pemF0aW9uIGJ5IGNoYW5naW5nIHZtYV93YW50c19tYW51YWxfcHRlX3dyaXRlX3VwZ3Jh
ZGUoKQ0KPiA+ID4gPiB0bw0KPiA+ID4gPiBub3QNCj4gPiA+ID4gcmV0dXJuIHRydWUgZm9yIFZN
X1NIQURPV19TVEFDS19NRU1PUlkuIFRoaXMgd2lsbCBzaW1wbHkgaGFuZGxlDQo+ID4gPiA+IGFs
bA0KPiA+ID4gPiBjYXNlcyBvZiB0aGlzIHR5cGUuDQo+ID4gPiA+IA0KPiA+ID4gPiBDYzogRGF2
aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQo+ID4gPiA+IFRlc3RlZC1ieTogUGVu
Z2ZlaSBYdSA8cGVuZ2ZlaS54dUBpbnRlbC5jb20+DQo+ID4gPiA+IFRlc3RlZC1ieTogSm9obiBB
bGxlbiA8am9obi5hbGxlbkBhbWQuY29tPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZdS1jaGVu
ZyBZdSA8eXUtY2hlbmcueXVAaW50ZWwuY29tPg0KPiA+ID4gPiBSZXZpZXdlZC1ieTogS2lyaWxs
IEEuIFNodXRlbW92IDwNCj4gPiA+ID4ga2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbT4N
Cj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVA
aW50ZWwuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+IA0KPiA+ID4gSW5zdGVhZCBvZiBoYXZpbmcg
dGhlc2UgeDg2LXNoYWRvdyBzdGFjayBkZXRhaWxzIGFsbCBvdmVyIHRoZSBNTQ0KPiA+ID4gc3Bh
Y2UsDQo+ID4gPiB3YXMgdGhlIG9wdGlvbiBleHBsb3JlZCB0byBoYW5kbGUgdGhpcyBtb3JlIGlu
IGFyY2ggc3BlY2lmaWMNCj4gPiA+IGNvZGU/DQo+ID4gPiANCj4gPiA+IElJVUMsIG9uZSB3YXkg
dG8gZ2V0IGl0IHdvcmtpbmcgd291bGQgYmUNCj4gPiA+IA0KPiA+ID4gMSkgSGF2ZSBhIFNXICJz
aGFkb3dzdGFjayIgUFRFIGZsYWcuDQo+ID4gPiAyKSBIYXZlIGFuICJTVy1kaXJ0eSIgUFRFIGZs
YWcsIHRvIHN0b3JlICJkaXJ0eT0xIiB3aGVuDQo+ID4gPiAid3JpdGU9MCIuDQo+ID4gDQo+ID4g
SSBkb24ndCB0aGluayB0aGF0IGlkZWEgY2FtZSB1cC4gU28gdm1hLT52bV9wYWdlX3Byb3Qgd291
bGQgaGF2ZQ0KPiA+IHRoZSBTVw0KPiA+IHNoYWRvdyBzdGFjayBmbGFnIGZvciBWTV9TSEFET1df
U1RBQ0ssIGFuZCBwdGVfbWt3cml0ZSgpIGNvdWxkIGRvDQo+ID4gV3JpdGU9MCxEaXJ0eT0xIHBh
cnQuIEl0IHNlZW1zIGxpa2UgaXQgc2hvdWxkIHdvcmsuDQo+ID4gDQo+IA0KPiBSaWdodCwgaWYg
d2UgaW5jbHVkZSBpdCBpbiB2bWEtPnZtX3BhZ2VfcHJvdCwgd2UnZCBpbW1lZGlhdGVseSBsZXQg
DQo+IG1rX3B0ZSgpIGp1c3QgaGFuZGxlIHRoYXQuDQo+IA0KPiBPdGhlcndpc2UsIHdlJ2QgaGF2
ZSB0byByZWZhY3RvciBlLmcuLCBta19wdGUoKSB0byBjb25zdW1lIGEgdm1hDQo+IGluc3RlYWQg
DQo+IG9mIHRoZSB2bWEtPnZtX3BhZ2VfcHJvdC4gTGV0J3Mgc2VlIGlmIHdlIGNhbiBhdm9pZCB0
aGF0IGZvciBub3cuDQo+IA0KPiA+ID4gDQo+ID4gPiBwdGVfbWt3cml0ZSgpLCBwdGVfd3JpdGUo
KSwgcHRlX2RpcnR5IC4uLiBjYW4gdGhlbiBtYWtlIGRlY2lzaW9ucw0KPiA+ID4gYmFzZWQNCj4g
PiA+IG9uIHRoZSAic2hhZG93c3RhY2siIFBURSBmbGFnIGFuZCBoaWRlIGFsbCB0aGVzZSBkZXRh
aWxzIGZyb20NCj4gPiA+IGNvcmUtDQo+ID4gPiBtbS4NCj4gPiA+IA0KPiA+ID4gV2hlbiBtYXBw
aW5nIGEgc2hhZG93c3RhY2sgcGFnZSAobmV3IHBhZ2UsIG1pZ3JhdGlvbiwgc3dhcGluLA0KPiA+
ID4gLi4uKSwNCj4gPiA+IHdoaWNoIGNhbiBiZSBvYnRhaW5lZCBieSBsb29raW5nIGF0IHRoZSBW
TUEgZmxhZ3MsIHRoZSBmaXJzdA0KPiA+ID4gdGhpbmcNCj4gPiA+IHlvdSdkDQo+ID4gPiBkbyBp
cyBzZXQgdGhlICJzaGFkb3dzdGFjayIgUFRFIGZsYWcuDQo+ID4gDQo+ID4gSSBndWVzcyB0aGUg
ZG93bnNpZGUgaXMgdGhhdCBpdCB1c2VzIGFuIGV4dHJhIHNvZnR3YXJlIGJpdC4gQnV0IHRoZQ0K
PiA+IG90aGVyIHBvc2l0aXZlIGlzIHRoYXQgaXQncyBsZXNzIGVycm9yIHByb25lLCBzbyB0aGF0
IHNvbWVvbmUNCj4gPiB3cml0aW5nDQo+ID4gY29yZS1tbSBjb2RlIHdvbid0IGludHJvZHVjZSBh
IGNoYW5nZSB0aGF0IG1ha2VzIHNoYWRvdyBzdGFjayBWTUFzDQo+ID4gV3JpdGU9MSBpZiB0aGV5
IGRvbid0IGtub3cgdG8gYWxzbyBjaGVjayBmb3IgVk1fU0hBRE9XX1NUQUNLLg0KPiANCj4gUmln
aHQuIEFuZCBJIHRoaW5rIHRoaXMgbWltaWNzIHRoZSB3aGF0IEkgd291bGQgaGF2ZSBleHBlY3Rl
ZCBIVyB0byANCj4gcHJvdmlkZTogYSBkZWRpY2F0ZWQgSFcgYml0LCBub3Qgc29tZWhvdyBtYW5n
bGluZyB0aGlzIGludG8gc2VtYW50aWNzDQo+IG9mIA0KPiBleGlzdGluZyBiaXRzLg0KDQpZZWEu
DQoNCj4gDQo+IFJvdWdobHkgc3BlYWtpbmc6IGlmIHdlIGFic3RyYWN0IGl0IHRoYXQgd2F5IGFu
ZCBnZXQgYWxsIG9mIHRoZSAiaG93DQo+IHRvIA0KPiBzZXQgaXQgd3JpdGFibGUgbm93PyIgb3V0
IG9mIGNvcmUtTU0sIGl0IG5vdCBvbmx5IGlzIGNsZWFuZXIgYW5kDQo+IGxlc3MgDQo+IGVycm9y
IHByb25lLCBpdCBtaWdodCBldmVuIGFsbG93IG90aGVyIGFyY2hpdGVjdHVyZXMgdGhhdCBpbXBs
ZW1lbnQgDQo+IHNvbWV0aGluZyBjb21wYXJhYmxlIChlLmcuLCB1c2luZyBhIGRlZGljYXRlZCBI
VyBiaXQpIHRvIGFjdHVhbGx5DQo+IHJldXNlIA0KPiBzb21lIG9mIHRoYXQgd29yay4gT3RoZXJ3
aXNlIG1vc3Qgb2YgdGhhdCAic2hzdGsiIGlzIHJlYWxseSBqdXN0IHg4NiANCj4gc3BlY2lmaWMg
Li4uDQo+IA0KPiBJIGd1ZXNzIHRoZSBvbmx5IGNhc2VzIHdlIGhhdmUgdG8gc3BlY2lhbCBjYXNl
IHdvdWxkIGJlIHBhZ2UgcGlubmluZyANCj4gY29kZSB3aGVyZSBwdGVfd3JpdGUoKSB3b3VsZCBp
bmRpY2F0ZSB0aGF0IHRoZSBQVEUgaXMgd3JpdGFibGUgKHdlbGwsDQo+IGl0IA0KPiBpcywganVz
dCBub3QgYnkgIm9yZGluYXJ5IENQVSBpbnN0cnVjdGlvbiIgY29udGV4dCBkaXJlY3RseSk6IGJ1
dCB5b3UNCj4gZG8gDQo+IHRoYXQgYWxyZWFkeSwgc28gLi4uIDopDQo+IA0KPiBTb3JyeSBmb3Ig
c3R1bWJsaW5nIG92ZXIgdGhhdCB0aGlzIGxhdGUsIEkgb25seSBzdGFydGVkIGxvb2tpbmcgaW50
byANCj4gdGhpcyB3aGVuIHlvdSBDQ2VkIG1lIG9uIHRoYXQgb25lIHBhdGNoLg0KDQpTb3JyeSBm
b3Igbm90IGNhbGxpbmcgbW9yZSBhdHRlbnRpb24gdG8gaXQgZWFybGllci4gQXBwcmVjaWF0ZSB5
b3VyDQpjb21tZW50cy4NCg0KUHJldmlvdXNseSB2ZXJzaW9ucyBvZiB0aGlzIHNlcmllcyBoYWQg
Y2hhbmdlZCBzb21lIG9mIHRoZXNlDQpwdGVfbWt3cml0ZSgpIGNhbGxzIHRvIG1heWJlX21rd3Jp
dGUoKSwgd2hpY2ggb2YgY291cnNlIHRha2VzIGEgdm1hLg0KVGhpcyB3YXkgYW4geDg2IGltcGxl
bWVudGF0aW9uIGNvdWxkIHVzZSB0aGUgVk1fU0hBRE9XX1NUQUNLIHZtYSBmbGFnDQp0byBkZWNp
ZGUgYmV0d2VlbiBwdGVfbWt3cml0ZSgpIGFuZCBwdGVfbWt3cml0ZV9zaHN0aygpLiBUaGUgZmVl
ZGJhY2sNCndhcyB0aGF0IGluIHNvbWUgb2YgdGhlc2UgY29kZSBwYXRocyAibWF5YmUiIGlzbid0
IHJlYWxseSBhbiBvcHRpb24sIGl0DQoqbmVlZHMqIHRvIG1ha2UgaXQgd3JpdGFibGUuIEV2ZW4g
dGhvdWdoIHRoZSBsb2dpYyB3YXMgdGhlIHNhbWUsIHRoZQ0KbmFtZSBvZiB0aGUgZnVuY3Rpb24g
bWFkZSBpdCBsb29rIHdyb25nLg0KDQpCdXQgYW5vdGhlciBvcHRpb24gY291bGQgYmUgdG8gY2hh
bmdlIHB0ZV9ta3dyaXRlKCkgdG8gdGFrZSBhIHZtYS4gVGhpcw0Kd291bGQgc2F2ZSB1c2luZyBh
bm90aGVyIHNvZnR3YXJlIGJpdCBvbiB4ODYsIGJ1dCBpbnN0ZWFkIHJlcXVpcmVzIGENCnNtYWxs
IGNoYW5nZSB0byBlYWNoIGFyY2gncyBwdGVfbWt3cml0ZSgpLg0KDQp4ODYncyBwdGVfbWt3cml0
ZSgpIHdvdWxkIHRoZW4gYmUgcHJldHR5IGNsb3NlIHRvIG1heWJlX21rd3JpdGUoKSwgYnV0DQpt
YXliZSBpdCBjb3VsZCBhZGRpdGlvbmFsbHkgd2FybiBpZiB0aGUgdm1hIGlzIG5vdCB3cml0YWJs
ZS4gSXQgYWxzbw0Kc2VlbXMgbW9yZSBhbGlnbmVkIHdpdGggeW91ciBjaGFuZ2VzIHRvIHN0b3Ag
dGFraW5nIGhpbnRzIGZyb20gUFRFIGJpdHMNCmFuZCBqdXN0IGxvb2sgYXQgdGhlIFZNQT8gKEkn
bSB0aGlua2luZyBhYm91dCB0aGUgZHJvcHBpbmcgb2YgdGhlIGRpcnR5DQpjaGVjayBpbiBHVVAg
YW5kIGRyb3BwaW5nIHB0ZV9zYXZlZF93cml0ZSgpKQ0KDQo=
