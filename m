Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F76D6B1686
	for <lists+linux-arch@lfdr.de>; Thu,  9 Mar 2023 00:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjCHXcp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Mar 2023 18:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCHXcn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Mar 2023 18:32:43 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E7A92708;
        Wed,  8 Mar 2023 15:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678318362; x=1709854362;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2da5QWxIwghsocE4wAqhHV2gx/tAc6HTxLJuG5h1E6Y=;
  b=IJKqcSXTWtJmn+x1Tg6TunxynH7ElcCZNtQU3ZqI1zKIWuXEYnSx42YX
   nBVBiw2uMaTmmxG0100gogwxP2WmPZZ4tofgOqhsbJeXGDjCCXgk5Mzfv
   CkNRz+eMh9exM3Vnp292sU8VNXvEWgote/Vrt4vRXb8kmPLr06psWqupW
   ms8jk3+GBXU5aLNoEq1eA44Q+3qeLSPvhJDYb4xFj+cmccOYaBpHC9L46
   hemG31gqUOQpL1Qaaa/xs32nPkXPhVL1n7dcgDtrWgxcEYsSGE/pwIZn6
   I97GcmgZfNfJ+fb0LegvO2E8rJT9NaGcebqB2yDMvqEZ3YbtOYKkeDxnW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="422576088"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="422576088"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 15:32:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="741315291"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="741315291"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 08 Mar 2023 15:32:40 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 15:32:40 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 15:32:40 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 8 Mar 2023 15:32:40 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 8 Mar 2023 15:32:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHS0PzMxBikNU94/d6mk4T9wUueEq8A8gquWa4KebFKt8Y/hARrAvpsYn81UgxKbE1MlYE9agC6ZWrlUlWzxAdDlwx0Cs9JwiMLFyKoOIG9spw2Yjj0zOoKoYLOB5F8DaDnP2AcfLrnEEvsGC4tx2iUajFNiBNLnmi4gCIEDl+zS3Stg+opetGsW+dpfA42DBVX6cRNNDEbeP3gYKgW8MXASCln3PxghSoTg8sFvk2N/UbS66Db/LW2cezFMlWfitU7671Sg4MKfWJfzmnkvd54sy8KOXhXNUVoeYQr7vCzbJi8BFndiPAeukXvlKge2L54xWzhjCdYbnFcXaAQY2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2da5QWxIwghsocE4wAqhHV2gx/tAc6HTxLJuG5h1E6Y=;
 b=TZC15dvP1IZ64md+CgGzNpM/1HncZrZEI55jvM6ukCt8xYWFa452Jq93Zg86xQTtD6hurrTsYhhH5vRLDzItebsbfRcP1z15Jk/437/PmM3k6+G0CMMp3sD9jU88edg2jK/Ymo9YN3XfQMWw4FJSbLLgg1R1SibFQGywAlIa96Ex+AOgEiCSmPxYn3kcvI/N/e+XTCQtGCTzf4fs7gwToqssaO55HFbbm441Tq2U/+tMhTLDtCYt01UZf8nXmdxAsPXH6WUledU7FYOn4u2PWaA4lczGASmzs/AWw6ddR4BZciKuq/Ao1hnrgCJJ2WaJ7jE2VNjBKNcAhN/vAkPfXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BN9PR11MB5227.namprd11.prod.outlook.com (2603:10b6:408:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Wed, 8 Mar
 2023 23:32:37 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6178.017; Wed, 8 Mar 2023
 23:32:37 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
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
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v7 28/41] x86: Introduce userspace API for shadow stack
Thread-Topic: [PATCH v7 28/41] x86: Introduce userspace API for shadow stack
Thread-Index: AQHZSvtC0qoWAoXd0kKURn+giTskNK7wu1QAgADbO4A=
Date:   Wed, 8 Mar 2023 23:32:36 +0000
Message-ID: <9e00b2a3d988f7b24d274a108d31f5f0096eeaae.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-29-rick.p.edgecombe@intel.com>
         <ZAhjLAIm91rJ2Lpr@zn.tnic>
In-Reply-To: <ZAhjLAIm91rJ2Lpr@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|BN9PR11MB5227:EE_
x-ms-office365-filtering-correlation-id: 9fa7c8be-5245-4230-d5db-08db202d6678
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7LBnrNsibJKJMrLCDT5vd4eF1JHHXk9k/fY9w0aqXmAqghCuNW7hETha9wEu/WNdv5ZHPck618ETT9NBBPiorCKLmTWCiNndmir2M2cayAq86Kl+qz9BRSM0o7hy6tp+X60102M1lkYy909nYPvdosZk8cBMq1PtnwKwFhK1teKXtNNbcukbdAk1jUlrzJccV0QqOoHw6aS2OO4Hjkfaxlu+whGz3ErOaio82d71Pzdc5IKpVEeh870ghJMfB0EQcUiVt/nQTZy2YhXlkSmMgGM2IG4Pc10U7h4iFWc1HMWoy8KKPZHw2PCFx2+yjuTgh6HIJ/WBkZfkXbUskcTr7R5lV1m6RrPh7pXcXOepBLE3iokVJHq6XQnoaHk52ZNxgIt11z8B97t/r4m2eNy/cNi+CJSuE3uMm6DZEdzGm2mu3EDPavNY0yF/bzUYZiK6l+TlkBe2M5UpgNQ4dhPspSdUT81DXDYAsc+TdUDZT4ei72hLy06Ze5egQnRCC+nCkVvT9WV9MFpaEjE9UdPVGNhjfQuMS8gfv7SgpSUr5p3nWlVWjwz39fb5dYPjfVoOsNtibggXJ+ZNWmn4tAT73DAr7OXb9x8NXBiU1XK8E+6FYSMmTQ5shBWAHpFBqodG855uRH+TnbjNbOWD321RhT19ntPo1N+FnOLCr3d1inlBbaQA1755vTcgNDGJ18dsjK3H7hIYwThonQjPRHdnf/OKJfEQzhv7YgzyTkVY6tE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199018)(8936002)(7406005)(5660300002)(7416002)(64756008)(76116006)(6916009)(8676002)(4326008)(91956017)(66446008)(86362001)(66946007)(66556008)(83380400001)(36756003)(54906003)(71200400001)(478600001)(316002)(41300700001)(66476007)(6486002)(82960400001)(186003)(2906002)(38100700002)(122000001)(6506007)(6512007)(26005)(2616005)(38070700005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkJ4dVR2MlMyUVl0K3g0YXQ5SmNtUTkwMXRBdldiLzRzYUY4ckNnRU9SSWlC?=
 =?utf-8?B?SlpXR1p5YzVIRk8wQXhvV1hvRFM4UXo1SWovN3VtMHBWcEp3cC9XbEFQQkt3?=
 =?utf-8?B?THZCdzdiSU1pWGtucXFHNng0L0NqZmRJSEtJZ1ppNlRlK0hrb3FGampHNGdZ?=
 =?utf-8?B?ZE9zRHREWU5rWUxTWGFWSHVvSmFremtYZlVNVi9rdm9zbmJYS2wrcDEyY0xG?=
 =?utf-8?B?NTVDbUJZdVREVys1S1FNOGVYcS90VmUvYkcvSDF2TjBLbFJscytOT1J4WVRm?=
 =?utf-8?B?K29SczlFenhKT2E4UmxHVWoxOVp1Vzc4MXYwU3Z6cUhFcVhzREI5Y3JrSlVs?=
 =?utf-8?B?Vk10TWhFRmpScC8wcHBwemF0Y3M4d1NOWVpwMDNURGZESDZVNGl1S3NBUWx6?=
 =?utf-8?B?M0RXWm5KSnFHZlNjSmFCZ1M4OFJQYWljdjJ4VWl5dkFWcG1Rcm82MDNLMXFR?=
 =?utf-8?B?cWpGV1I0c0RYZUE4WGV1a2taeXpibVRKeXA1ZzgrN1lBd1ZhcDR2WUhYL1Zm?=
 =?utf-8?B?dGkyZ3FGNm54ZnppTjNYdWs5dWhIS2lCWFlZT1YvaXVBTWxvMnVSQWNzVDU3?=
 =?utf-8?B?SzcvMjFwWFAvWCtyZ0JZZHFSa1NpVW9wbDUrVzBnSDcyNm0zY1o4eGJVc3p5?=
 =?utf-8?B?TUZVNXlNRS8rbkRTdytjU0tKa3gvdVFzaWNlUnd4Q1UzZGhFN3BtTVpHbkpF?=
 =?utf-8?B?ZUFnWnV6V1o2MmNqOUhTSGErM2JibUZBenh3SlExckpFbFdOM2lBenZ0ZkQ0?=
 =?utf-8?B?L1RwVGNuU1RQVlEzQWhYOGtNdldnUUJYTUpSUVFxdk9sTDNZT3ZrKzJrOXVy?=
 =?utf-8?B?Y3pBSmVZSFQwbUZGNFJldGs3Y0xtbHU4Znd0V1BudnpIZHdNaCtBMGwxUnM0?=
 =?utf-8?B?Y1FXcDB2RlBwQ2Z5cGdWK2pqSFR5V21wQVNiYWV4azQwRlVueTd1V1MxNndQ?=
 =?utf-8?B?dXRvWFFmU0JqMWx0NFFkRlpIU0dFTnBKV0ZjT1JUeW9qNWZ5ZURlVjA2RFV5?=
 =?utf-8?B?eWJ5ZDF0bG9MM1JWbVdoNUY0T0dEU1Y0aittbGhkZUNRRWtKZ1BDRzNsbzhC?=
 =?utf-8?B?MXpQSlN3R3lFRWQwaFdWelk2MEdkdjlUaEc3bE9XMnVlWENqSzBYVktqNFQ2?=
 =?utf-8?B?SjNER1FGRSs4NWRiQXR6dnpYYWdoSW5WcDVsQ1plWUk2RENMa3pLcFZlS3lt?=
 =?utf-8?B?TnlSL0tlV2RiamxsQkFXR3A5ZEgyRFl2YUhDdDBpOFUzSFRHakN1UkVKYzBm?=
 =?utf-8?B?UnpEclVXb2prTkdBUUFuZkN2d2NHVXF1ZHh3Y3pDZEh5SUpkc1VNdzlFcjcy?=
 =?utf-8?B?UUdrbGY5K2lRZkg5c0w5OWFDMWZMWGx2U3cwSys4dW1RRXA3aDhBbExpYVUx?=
 =?utf-8?B?K1NIYXQxYnVSSDBYNVZJZm5KQWJRZ01RbUovMkNwRnovbW1mM0JkRlZnSklv?=
 =?utf-8?B?NU9zaGp5SlVncnJkNkRMZGVCdEJ0RURYYUFWYUFaQ0h2b05pV2RjbDc5ZW1K?=
 =?utf-8?B?WDdqS3RZYnhXUnkySGtGU0lJT3RGSFNzMWFGYzJ2c29DWlFOVEtSYjVuV1Bq?=
 =?utf-8?B?ODJNZkNxMFg0cTFrYzZ2UE84b0hvSVF0WWV5djdsQUVQQUQ4azZCQk9MUHlN?=
 =?utf-8?B?cGVOZ3RqVzdZVkUvR1phL3lhQmZ2OC9KV29PeTFqandRWVdYVFludnhHMHh1?=
 =?utf-8?B?UEdodTZpTkJJZnZwY1N2VCsrMnk5Vk82dWpkOTJrMXRacXZlK3NKcnBPTHZJ?=
 =?utf-8?B?T3p2cFk4Q1BHM0hiQk41RjNqYXVFOFZubG93NUl3MHBIaFZGSXJBUW4yUERZ?=
 =?utf-8?B?aDJUNWtkbzZic1piWElUQ1lDY3VMUkQ1Z2QrY0FFYWIyZDJlSVJQeEU2QnN2?=
 =?utf-8?B?Rk9BdGUzNG9Ka2JIQTVnMkxLTWo4TVE0THlZWVBnaU9HbFh5bE9PbUE1ZVNr?=
 =?utf-8?B?YnVuMGNZWFFYQ0Q0bEs4VE55blpyM3d6ODh3Nk03K1pnOCsrZHBIVHBweDhq?=
 =?utf-8?B?dmNyWFpneDN4MVllOFovZis0OEtkaVNXd1p1M2lyeWJNRnFVMGdxK2xRc3NZ?=
 =?utf-8?B?RUhHaHdnTm9jSFptT0FQS0l2UDBNQmxGeEhaSmFmVEc5c0l2VGNjMmVQN1ZP?=
 =?utf-8?B?Wlhlam5hMDBOTm5Eb3doWll1dUJLbExFbHl1aTRYVjhiVWI2Ui9pRnBIQlFE?=
 =?utf-8?Q?+oyMK8Bn29XP3SMB26ZDkL8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <881405FAE6351647A849C47372AE3E72@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa7c8be-5245-4230-d5db-08db202d6678
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 23:32:36.7556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YhzYvgRFR55YcuZXU+fC5qCTTqZKWnaiKGOyyAtZPo0LQ6pM+AYyBCmb05ghCOT7TE/uiC2/ksFBVqDObDAuBD0LH0v5WjfOHbDc39Qy44Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5227
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gV2VkLCAyMDIzLTAzLTA4IGF0IDExOjI3ICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIE1vbiwgRmViIDI3LCAyMDIzIGF0IDAyOjI5OjQ0UE0gLTA4MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+IEZyb206ICJLaXJpbGwgQS4gU2h1dGVtb3YiIDxraXJpbGwuc2h1dGVt
b3ZAbGludXguaW50ZWwuY29tPg0KPiA+IA0KPiA+IEFkZCB0aHJlZSBuZXcgYXJjaF9wcmN0bCgp
IGhhbmRsZXM6DQo+ID4gDQo+ID4gIC0gQVJDSF9TSFNUS19FTkFCTEUvRElTQUJMRSBlbmFibGVz
IG9yIGRpc2FibGVzIHRoZSBzcGVjaWZpZWQNCj4gPiAgICBmZWF0dXJlLiBSZXR1cm5zIDAgb24g
c3VjY2VzcyBvciBhbiBlcnJvci4NCj4gDQo+ICIuLi4gb3IgYSBuZWdhdGl2ZSB2YWx1ZSBvbiBl
cnJvci4iDQoNClN1cmUuDQoNCj4gDQo+ID4gIC0gQVJDSF9TSFNUS19MT0NLIHByZXZlbnRzIGZ1
dHVyZSBkaXNhYmxpbmcgb3IgZW5hYmxpbmcgb2YgdGhlDQo+ID4gICAgc3BlY2lmaWVkIGZlYXR1
cmUuIFJldHVybnMgMCBvbiBzdWNjZXNzIG9yIGFuIGVycm9yDQo+IA0KPiBkaXR0by4NCj4gDQo+
IFdoYXQgaXMgdGhlIHVzZSBjYXNlIG9mIHRoZSBmZWF0dXJlIGxvY2tpbmc/DQo+IA0KPiBJJ20g
dW5kZXIgdGhlIHNpbXBsZSBhc3N1bXB0aW9uIHRoYXQgb25jZSBzaHN0ayBpcyBlbmFibGVkIGZv
ciBhbg0KPiBhcHAsDQo+IGl0IHJlbWFpbnMgc28uIEkgZ3Vlc3MgbXkgcXVlc3Rpb24gaXMgcmF0
aGVyLCB3aGF0J3MgdGhlIHVzZSBjYXNlIGZvcg0KPiBlbmFibGluZyBzaGFkb3cgc3RhY2sgYW5k
IHRoZW4gZGlzYWJsaW5nIGl0IGxhdGVyIGZvciBhbiBhcHAuLi4/DQoNClRoaXMgd291bGQgYmUg
Zm9yIHRoaW5ncyBsaWtlIHRoZSAicGVybWlzc2l2ZSBtb2RlIiwgd2hlcmUgZ2xpYmMNCmRldGVy
bWluZXMgdGhhdCBpdCBoYXMgdG8gZG8gc29tZXRoaW5nIGxpa2UgZGxvcGVuKCkgYW4gdW5zdXBw
b3J0aW5nDQpEU08gbXVjaCBsYXRlci4NCg0KQnV0IGJlaW5nIGFibGUgdG8gbGF0ZSBsb2NrIHRo
ZSBmZWF0dXJlcyBpcyByZXF1aXJlZCBmb3IgdGhlIHdvcmtpbmcNCmJlaGF2aW9yIG9mIGdsaWJj
IGFzIHdlbGwuIEdsaWJjIGVuYWJsZXMgc2hhZG93IHN0YWNrIHZlcnkgZWFybHksIHRoZW4NCmRp
c2FibGVzIGl0IGxhdGVyIGlmIGl0IGZpbmRzIHRoYXQgYW55IG9mIHRoZSBub3JtYWwgZHluYW1p
YyBsaWJyYXJpZXMNCmRvbid0IHN1cHBvcnQgaXQuIEl0IG9ubHkgbG9ja3Mgc2hhZG93IHN0YWNr
IGFmdGVyIHRoaXMgcG9pbnQgZXZlbiBpbg0Kbm9uLXBlcm1pc3NpdmUgbW9kZS4NCg0KVGhlIHNl
bGZ0ZXN0IGFsc28gZG9lcyBhIGxvdCBvZiBlbmFibGluZyBhbmQgZGlzYWJsaW5nLg0KDQo+IA0K
PiA+IFRoZSBmZWF0dXJlcyBhcmUgaGFuZGxlZCBwZXItdGhyZWFkIGFuZCBpbmhlcml0ZWQgb3Zl
cg0KPiA+IGZvcmsoMikvY2xvbmUoMiksDQo+ID4gYnV0IHJlc2V0IG9uIGV4ZWMoKS4NCj4gPiAN
Cj4gPiBUaGlzIGlzIHByZXBhcmF0aW9uIHBhdGNoLiBJdCBkb2VzIG5vdCBpbXBsZW1lbnQgYW55
IGZlYXR1cmVzLg0KPiANCj4gVGhhdCBiZWxvbmdzIHVuZGVyIHRoZSAiLS0tIiBsaW5lIEkgZ3Vl
c3MuDQoNCk9oLCB5ZXMuDQoNCj4gDQo+ID4gVGVzdGVkLWJ5OiBQZW5nZmVpIFh1IDxwZW5nZmVp
Lnh1QGludGVsLmNvbT4NCj4gPiBUZXN0ZWQtYnk6IEpvaG4gQWxsZW4gPGpvaG4uYWxsZW5AYW1k
LmNvbT4NCj4gPiBUZXN0ZWQtYnk6IEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPg0K
PiA+IEFja2VkLWJ5OiBNaWtlIFJhcG9wb3J0IChJQk0pIDxycHB0QGtlcm5lbC5vcmc+DQo+ID4g
UmV2aWV3ZWQtYnk6IEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEtpcmlsbCBBLiBTaHV0ZW1vdiA8a2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVs
LmNvbT4NCj4gPiBbdHdlYWtlZCB3aXRoIGZlZWRiYWNrIGZyb20gdGdseF0NCj4gPiBDby1kZXZl
bG9wZWQtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5j
b20+DQo+ID4gDQo+ID4gLS0tDQo+ID4gdjQ6DQo+ID4gIC0gUmVtb3ZlIHJlZmVyZW5jZXMgdG8g
Q0VUIGFuZCByZXBsYWNlIHdpdGggc2hhZG93IHN0YWNrIChQZXRlcnopDQo+ID4gDQo+ID4gdjM6
DQo+ID4gIC0gTW92ZSBzaHN0ay5jIE1ha2VmaWxlIGNoYW5nZXMgZWFybGllciAoS2VlcykNCj4g
PiAgLSBBZGQgI2lmZGVmIGFyb3VuZCBmZWF0dXJlc19sb2NrZWQgYW5kIGZlYXR1cmVzIChLZWVz
KQ0KPiA+ICAtIEVuY2Fwc3VsYXRlIGZlYXR1cmVzIHJlc2V0IGVhcmxpZXIgaW4gcmVzZXRfdGhy
ZWFkX2ZlYXR1cmVzKCkgc28NCj4gPiAgICBmZWF0dXJlcyBhbmQgZmVhdHVyZXNfbG9ja2VkIGFy
ZSBub3QgcmVmZXJlbmNlZCBpbiBjb2RlIHRoYXQNCj4gPiB3b3VsZCBiZQ0KPiA+ICAgIGNvbXBp
bGVkICFDT05GSUdfWDg2X1VTRVJfU0hBRE9XX1NUQUNLLiAoS2VlcykNCj4gPiAgLSBGaXggdHlw
byBpbiBjb21taXQgbG9nIChLZWVzKQ0KPiA+ICAtIFN3aXRjaCBhcmNoX3ByY3RsKCkgbnVtYmVy
cyB0byBhdm9pZCBjb25mbGljdCB3aXRoIExBTQ0KPiA+IA0KPiA+IHYyOg0KPiA+ICAtIE9ubHkg
YWxsb3cgb25lIGVuYWJsZS9kaXNhYmxlIHBlciBjYWxsICh0Z2x4KQ0KPiA+ICAtIFJldHVybiBl
cnJvciBjb2RlIGxpa2UgYSBub3JtYWwgYXJjaF9wcmN0bCgpIChBbGV4YW5kZXINCj4gPiBQb3Rh
cGVua28pDQo+ID4gIC0gTWFrZSBDRVQgb25seSAodGdseCkNCj4gPiAtLS0NCj4gPiAgYXJjaC94
ODYvaW5jbHVkZS9hc20vcHJvY2Vzc29yLmggIHwgIDYgKysrKysNCj4gPiAgYXJjaC94ODYvaW5j
bHVkZS9hc20vc2hzdGsuaCAgICAgIHwgMjEgKysrKysrKysrKysrKysrDQo+ID4gIGFyY2gveDg2
L2luY2x1ZGUvdWFwaS9hc20vcHJjdGwuaCB8ICA2ICsrKysrDQo+ID4gIGFyY2gveDg2L2tlcm5l
bC9NYWtlZmlsZSAgICAgICAgICB8ICAyICsrDQo+ID4gIGFyY2gveDg2L2tlcm5lbC9wcm9jZXNz
XzY0LmMgICAgICB8ICA3ICsrKystDQo+ID4gIGFyY2gveDg2L2tlcm5lbC9zaHN0ay5jICAgICAg
ICAgICB8IDQ0DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICA2IGZp
bGVzIGNoYW5nZWQsIDg1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGFyY2gveDg2L2luY2x1ZGUvYXNtL3Noc3RrLmgNCj4gPiAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGFyY2gveDg2L2tlcm5lbC9zaHN0ay5jDQo+IA0KPiAuLi4NCj4gDQo+ID4gK2xv
bmcgc2hzdGtfcHJjdGwoc3RydWN0IHRhc2tfc3RydWN0ICp0YXNrLCBpbnQgb3B0aW9uLCB1bnNp
Z25lZA0KPiA+IGxvbmcgZmVhdHVyZXMpDQo+ID4gK3sNCj4gPiArCWlmIChvcHRpb24gPT0gQVJD
SF9TSFNUS19MT0NLKSB7DQo+ID4gKwkJdGFzay0+dGhyZWFkLmZlYXR1cmVzX2xvY2tlZCB8PSBm
ZWF0dXJlczsNCj4gPiArCQlyZXR1cm4gMDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwkvKiBEb24n
dCBhbGxvdyB2aWEgcHRyYWNlICovDQo+ID4gKwlpZiAodGFzayAhPSBjdXJyZW50KQ0KPiA+ICsJ
CXJldHVybiAtRUlOVkFMOw0KPiA+ICsNCj4gPiArCS8qIERvIG5vdCBhbGxvdyB0byBjaGFuZ2Ug
bG9ja2VkIGZlYXR1cmVzICovDQo+ID4gKwlpZiAoZmVhdHVyZXMgJiB0YXNrLT50aHJlYWQuZmVh
dHVyZXNfbG9ja2VkKQ0KPiA+ICsJCXJldHVybiAtRVBFUk07DQo+ID4gKw0KPiA+ICsJLyogT25s
eSBzdXBwb3J0IGVuYWJsaW5nL2Rpc2FibGluZyBvbmUgZmVhdHVyZSBhdCBhIHRpbWUuICovDQo+
ID4gKwlpZiAoaHdlaWdodF9sb25nKGZlYXR1cmVzKSA+IDEpDQo+ID4gKwkJcmV0dXJuIC1FSU5W
QUw7DQo+ID4gKw0KPiA+ICsJaWYgKG9wdGlvbiA9PSBBUkNIX1NIU1RLX0RJU0FCTEUpIHsNCj4g
PiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArCX0NCj4gDQo+IHt9IGJyYWNlcyBsZWZ0IG92ZXIg
ZnJvbSBzb21lIHByZXZpb3VzIHZlcnNpb24uIENhbiBnbyBub3cuDQo+IA0KDQpUaGlzIHdhcyBp
bnRlbnRpb25hbCwgYnV0IEkgd2Fzbid0IHN1cmUgb24gaXQuIEl0IG1ha2VzIHRoZSBkaWZmDQpj
bGVhbmVyIGluIGxhdGVyIHBhdGNoZXMsIGlzIHRoZSByZWFzb24uDQo=
