Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465C95F5D14
	for <lists+linux-arch@lfdr.de>; Thu,  6 Oct 2022 01:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiJEXHN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Oct 2022 19:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJEXHJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Oct 2022 19:07:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557D7857E5;
        Wed,  5 Oct 2022 16:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665011227; x=1696547227;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QHkplrlxZkqhRf7zEJjgr1bB9nVQroO2UBxxsO5G0dU=;
  b=cqwS+tXHYvr7ROyydF0N+XccY2B/f7q02PE7RBp6Snvcd4ihCTxdbFcH
   TxU6mHTDpES8mPXbSdeFyTZ2JzyCLMtlEpkwKBmwoQAQ7Ln9PAAJvpcde
   q6BPqVw86visVTYEH77pXCctJyctLvaWX/5MXCO8NCuRH3ZEwDDHoIK/L
   JgCISB8OJbCTOaQNi6iYX6EGEnHchIoolXXFMch/C4tF1NulhqtIZMd16
   hc8KqjKGlWTVpQ5qKP77cPKHwCJn8/25mAW5lRBnANKcmrISI9z4NmuFN
   ugoKIthFncG89Dkssl4BaPRffaH+NZGL7mq392jjiX7Z5vPHQU7Vyyigy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="389583536"
X-IronPort-AV: E=Sophos;i="5.95,162,1661842800"; 
   d="scan'208";a="389583536"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 16:07:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="799676347"
X-IronPort-AV: E=Sophos;i="5.95,162,1661842800"; 
   d="scan'208";a="799676347"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 05 Oct 2022 16:07:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 5 Oct 2022 16:06:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 5 Oct 2022 16:06:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 5 Oct 2022 16:06:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/TPOsNZ6lQNy+wGOsAX2KmSbZiePfch68oMwP7mwTBBRsCFFciICQ4JaywbgQ5jpF5q6S2BCwb+TEYM28HNT1il0INcLKukkYmSzEnai9Eoi61FXUayxYN42kcLAbuJnf0DieSqgjP36VBaAXBretM3GT4ZCD+24KaCZB47jqFxtdoi9SjXQ/234FGUq4isE7PwASWeGXGy9NbGtzqffsp9gtTSC9USXMyKKNJZrDzj87PgOMhjVYyDPWm7dLgCDxQIaK2HuDXBy1wRcx+HY8zu31CqYsDbPJGRQPtkvXETvlIrzzs1bCy8dOnmQN3dhVg2pb7q2o2XF1wL+NYmpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHkplrlxZkqhRf7zEJjgr1bB9nVQroO2UBxxsO5G0dU=;
 b=nIB7qtH6ECYLY46JhQIjFHTttYWfaRlZw46nceH8VDj1wMBbYkVSvmCCy+SJpFKfi53I79i1Cn+kklfizuXvRGi2qnbAfJibwGp958kii+9zPKmPitdzdAFmazr9XqBafD+X1NmABy0rCitowBrrDXD89X+XI73h2g8zxiiRjzpeWlm+L+bSqEz47mwD7laPTAN9HdEsyuZ0G2d5Fb5y0km0cckF09QRGA6+PfYjA6inrMuRzIEPMeDmjuVAG7F3NBSkcGCixmX373SDaVxROpu0f1y3B3lqCuBICcByWY3WCSyyA6sUXUmSKFNHKV5mA5qy+F51pADdlVZqlDoRSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SN7PR11MB6799.namprd11.prod.outlook.com (2603:10b6:806:261::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Wed, 5 Oct
 2022 23:06:53 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.034; Wed, 5 Oct 2022
 23:06:53 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
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
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
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
        "Hansen, Dave" <dave.hansen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 10/39] x86/mm: Introduce _PAGE_COW
Thread-Topic: [PATCH v2 10/39] x86/mm: Introduce _PAGE_COW
Thread-Index: AQHY1FMOaUlv/a8lEUG05TjT32eaO63/GJkAgADGk4CAAJZ7gA==
Date:   Wed, 5 Oct 2022 23:06:53 +0000
Message-ID: <16d478e7ba6948eac69c0025080df52cb3f484df.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-11-rick.p.edgecombe@intel.com>
         <54cdad9f-b810-7966-5928-9320d970a43d@citrix.com>
         <715095e6-6c4e-62dd-6631-b096db2cd92c@intel.com>
In-Reply-To: <715095e6-6c4e-62dd-6631-b096db2cd92c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SN7PR11MB6799:EE_
x-ms-office365-filtering-correlation-id: bb5f9bef-c84d-433c-7537-08daa7264ace
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hTPgyY58cEnG5/E+x4w4lPMx8XvFe5vA52oe/2JJqTUW04sPD5m3m5x+2+m0jDRWXMm3c9bMjYDBn5EITnqRN14uW1igDXFBga7HUzHMinBybpHDbHlRH86a1m83pDBwbiLIawY0CJcDGRt0aW1NiYYRwITuKA/f0RuxLrIZqc2plVfhtxrB8wNRnxRl5Qp8doD2335ILWsmfIARzlGh2zNv9tut2mqPo0P1czGbWMDTk0k19wDicHaJZGD12r8yQfLbma8ZoyNYdLleBXjCp7V8Cv7alXK1oAaJR2cV7D9s3jG06Z4OjdkbgWA2l51vIHRgjywWpaO2F8WD9MWBCUQTy4BQ4GDKJjKMWkHterWfXz71zXftYkI8CFZgyNu/lzgoeF8wbsVglNaCh55lHAERAGJ7Q9rz5OokXiKrqJc5qeWExVob4P8kiHnf2HMK0yV73d9qwyiSrAD+oyMgEE1topYC+zLVkIAi1REkQKRx9UG+ECpARQdoMPIyVcDvaK8h1sRSSfdB5s6mAdUkVIyCsBTQxqSQwmnTIa6ycTKkYAsNuv6LRTXj40HArrlsKHpGMEXwfmcIA8MepIVimLnyfyZuyNbywOCPbSb7SjE5mvbbC7Hs+asS2Kbk+r3mqhHtg4l0CBg6VXB+3KCleyEEvz5Q8IKt4y/TyIPrDWgVRxv7fQlqYza6rf57zGnq8trrxIXufngCMmQFESctwVKx1jzP5VpES0pD3uME9u3K9Lo8LTsYZruwUV9bj2ZIARddyMORWXUcGn+COlcyCeXcKcDUotZ5ZPTSnF5w4ziCMxrGF9E0YMJgazoUkyY5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(366004)(376002)(396003)(451199015)(122000001)(921005)(478600001)(53546011)(86362001)(6486002)(6506007)(71200400001)(6512007)(26005)(38070700005)(36756003)(82960400001)(38100700002)(186003)(8676002)(7406005)(41300700001)(66476007)(7416002)(66446008)(2906002)(8936002)(4326008)(66946007)(66556008)(2616005)(91956017)(76116006)(64756008)(316002)(5660300002)(110136005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWNpQ21ZdTh2NjJJYkVrSnBxMGJtRndHbGpuOVVqTGJnN2VNVnZ5WXdxRVJL?=
 =?utf-8?B?K1BEUHFQSlcvSWptNThTSUhOa24rT2R5TGhoQWFoblk2RGNsVmtMK3Q5MGNl?=
 =?utf-8?B?TjVsdGw3NEVpcHNVSFdlUjRWeEZKbnExVmdpRHVZSkRpTXIvT21HNEFjT2Nm?=
 =?utf-8?B?RC9FUENoWGFkdHMvQVZhVkdrWnplMGxVK0lEbTQrbE1PTEtiSFZuUStQN2E4?=
 =?utf-8?B?a1NWQmdhL3JydFZMZCtOejlLR282RVBoQTB3aXdxaE52RHBwWDE5a0RFUFNn?=
 =?utf-8?B?aEd1N2ZmcGpJbjdFcEJBT0F2RFFhNDc1ZmkxL1pPUEdqemxacnJIS2dTY3Jn?=
 =?utf-8?B?MlVLcmgyMnFwZ203ZFRpYXE3Qzc5T3F2SDZZRWg4WjJvT2RKTXlvY0J2NHYv?=
 =?utf-8?B?NXhaaHVDcVlXa2xsd3lTVERoakE3T2lPNmQvR0hvNjlrMEFqWmpoWlkvOUh3?=
 =?utf-8?B?UlA1MUJlcS84VW45aXlBNHlZWlR2OWsvZ3ZvRHJ3eVJBV1lXM1o3NGNxUDFh?=
 =?utf-8?B?K2YweXN6eFNqZUJRWC9wZThaY25oV1pqRDA4dFdQcWVQVGNraXVHZjRwWVN2?=
 =?utf-8?B?ZHlBUTdEcXk0Y2Z3ZFl5OW1wbWpUOER1Q1BlVk9tT2FzOFpIMUZPZXpIYVBt?=
 =?utf-8?B?SllKTnlCdWluMCtJcTJCUzhvWVB4cW9VckZmVjdVUFZUTjB4N0k4L0pNbzJk?=
 =?utf-8?B?SUtCRERkQzNMaTlURUcyVTNTcnZwV0QrOUhmUDRTSHFiY2tQOFhoUVRNRW9l?=
 =?utf-8?B?a2pmaXdZM2wyclhTRmZiazU3YkViSGUzMU44VnhGd1cxWWNZWGtKZG1IZE05?=
 =?utf-8?B?WXFxakJyTEVrU3ArOWhtbEE0VTkvdnJHQU51c29jTlZtWWdEZzJLWDdKOUlG?=
 =?utf-8?B?aDZsYjdmZGN2NEwyYVR1QjFTSTJGdDZyZUJETVgvQ25EWE5kS1JDMkZMcFpP?=
 =?utf-8?B?ZHMyVzJUVlRQVDMyaWYvMnZhOUlkR2o5RFpIbkxSRkIrK2lFN21iMWRoN2Mz?=
 =?utf-8?B?ZjlhcVliVDlmUTFpYUtZZEtzZ3RuM2VXN3BpYldpdHBxZjluZU5GOUNvNUNv?=
 =?utf-8?B?RUlROG9BbkRBQ1lMZCtqTDhhTFFCNmxRUitKOVppZ2gwdzVWL2ExMkd6ZnNZ?=
 =?utf-8?B?MGViaTVsSUVSZGFvRXJ1VzhpUzNudGN6SnVmQkIxOTRIcjd5N0ZRZk55NlY4?=
 =?utf-8?B?NTNBWUJzZVNjQWhaTnM0ekw5SzNaaEF1eHhYME8vRDNiNTIxa0RiTGxJRWUx?=
 =?utf-8?B?ODZVbVlTSEdPMXlyVEg0MTBNazN0WWRGSlJmS25aYnptVEhadG1qM1hMbnFh?=
 =?utf-8?B?aHZmNFlrcEw0cHVRUmxQYjk4bFdZRTFDakpDUWZxTlFIU0NCRkJLejFZRE9O?=
 =?utf-8?B?ckZ5NzRaVmtDVjc0Rnljb082ZWxyKy9PRy9kUEFqYVVOQXVabHQvNzVQSURx?=
 =?utf-8?B?bFBhVEpXTU1FOWRjWld4aE90NnBiam44blVEa3VyTDNJVG5WUWlQT0dsdUpi?=
 =?utf-8?B?NFVabjZUWG1oandJMjNhVmlhYSt2WXlkM25GeXRpZ3ZlTFBqQjAyMS84bTAr?=
 =?utf-8?B?dFBQVzRJUURBL0FPYWFaMTlRWHd6d2JGb1JLazNjUEJUUU95c2VZOUNkSW1u?=
 =?utf-8?B?cUFGZ0xqODhoTmlab0VNdEpxUjZZUlc5MmF4b0FQR0FmSHZQWTJSSUZhamdC?=
 =?utf-8?B?VmRtUEdXQ1RtUzAzOFJndHBvZHU3SWJKVVk4VkNRK1hsU0NKNndET0xFZVA0?=
 =?utf-8?B?SkdkME5zSU9INXFRQU45WHA3cUdudU5DbXlJMnVNbVlGZXhWZnNqU1ZHY2ZB?=
 =?utf-8?B?aGFtaEVNSEl2UmlWc3E3SXRoSDhkTitPYjdhemR6c2J0T0VUajVERGZVMEJV?=
 =?utf-8?B?a2JNT3hraXd2dzdhZVE2RUlLZHRKa1NDeUhvOW5pTVlQclNBR1NobVd4ME9z?=
 =?utf-8?B?djdkd1A3dU9odWhqaldHRGluK0dyeHptS0lYSkNRaGl3cUQ4T3doUWpuR2Na?=
 =?utf-8?B?ci8vNllRMWlWcjFodi9UZHZ6dDR4VXp4ZE9NWXVISjdtTWlNeS9ZUCtFUVYx?=
 =?utf-8?B?NmcvSlZnbkpNTnl4TnVGMGV3cFMvWGNiS3VLRzVKZ3ZzelhpNzdnR2RxczlY?=
 =?utf-8?B?TkhndnZwcnFRUm1SSlBlL3hoemQ2K2lNWFczemtuM1BsM0lTeEcrSlN6bFQ2?=
 =?utf-8?Q?hAeAh018Nvoc6CepyAnUqUk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3416C3BDF80744CA9ABDB31DFE1360E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5f9bef-c84d-433c-7537-08daa7264ace
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 23:06:53.1518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: etYliywauGkj3Yw0lhcpwn+a7qJnVJYmavIhFC4LvSz/XQ0MeiyDDF0bmFfd70RgySij/dRo3OZSsVpHrv+NozhY9FjduCKSdRJj18xI3V8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6799
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gV2VkLCAyMDIyLTEwLTA1IGF0IDA3OjA4IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gMTAvNC8yMiAxOToxNywgQW5kcmV3IENvb3BlciB3cm90ZToNCj4gPiBPbiAyOS8wOS8yMDIy
IDIzOjI5LCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToNCj4gPiA+IEZyb206IFl1LWNoZW5nIFl1IDx5
dS1jaGVuZy55dUBpbnRlbC5jb20+DQo+ID4gPiANCj4gPiA+IFRoZXJlIGlzIGVzc2VudGlhbGx5
IG5vIHJvb20gbGVmdCBpbiB0aGUgeDg2IGhhcmR3YXJlIFBURXMgb24NCj4gPiA+IHNvbWUgT1Nl
cw0KPiA+ID4gKG5vdCBMaW51eCkuIFRoYXQgbGVmdCB0aGUgaGFyZHdhcmUgYXJjaGl0ZWN0cyBs
b29raW5nIGZvciBhIHdheQ0KPiA+ID4gdG8NCj4gPiA+IHJlcHJlc2VudCBhIG5ldyBtZW1vcnkg
dHlwZSAoc2hhZG93IHN0YWNrKSB3aXRoaW4gdGhlIGV4aXN0aW5nDQo+ID4gPiBiaXRzLg0KPiA+
ID4gVGhleSBjaG9zZSB0byByZXB1cnBvc2UgYSBsaWdodGx5LXVzZWQgc3RhdGU6IFdyaXRlPTAs
RGlydHk9MS4NCj4gPiANCj4gPiBIb3cgZG9lcyAiU29tZSBPU2VzIGhhdmUgYSBncmVhdGVyIGRl
cGVuZGVuY2Ugb24gc29mdHdhcmUgYXZhaWxhYmxlDQo+ID4gYml0cw0KPiA+IGluIFBURXMgdGhh
biBMaW51eCIgc291bmQ/DQo+ID4gDQo+ID4gPiBUaGUgcmVhc29uIGl0J3MgbGlnaHRseSB1c2Vk
IGlzIHRoYXQgRGlydHk9MSBpcyBub3JtYWxseSBzZXQNCj4gPiA+IF9iZWZvcmVfIGENCj4gPiA+
IHdyaXRlLiBBIHdyaXRlIHdpdGggYSBXcml0ZT0wIFBURSB3b3VsZCB0eXBpY2FsbHkgb25seSBn
ZW5lcmF0ZSBhDQo+ID4gPiBmYXVsdCwNCj4gPiA+IG5vdCBzZXQgRGlydHk9MS4gSGFyZHdhcmUg
Y2FuIChyYXJlbHkpIGJvdGggc2V0IFdyaXRlPTEgKmFuZCoNCj4gPiA+IGdlbmVyYXRlIHRoZQ0K
PiA+ID4gZmF1bHQsIHJlc3VsdGluZyBpbiBhIERpcnR5PTAsV3JpdGU9MSBQVEUuIEhhcmR3YXJl
IHdoaWNoDQo+ID4gPiBzdXBwb3J0cyBzaGFkb3cNCj4gPiA+IHN0YWNrcyB3aWxsIG5vIGxvbmdl
ciBleGhpYml0IHRoaXMgb2RkaXR5Lg0KPiA+IA0KPiA+IEFnYWluLCBhbiBpbnRlcmVzdGluZyBh
bmVjZG90ZSBidXQgbm90IHNhbGllbnQgaW5mb3JtYXRpb24gaGVyZS4NCj4gDQo+IEFzIG11Y2gg
YXMgSSBsaWtlIHRoZSBzb3VuZCBvZiBteSBvd24gdm9pY2UgKGFuZCBhbmVjZG90ZXMpLCBJIGFn
cmVlDQo+IHRoYXQgdGhpcyBpcyBhIGJpdCBvYmxpcXVlIGZvciB0aGUgcGF0Y2guICBNYXliZSB0
aGlzIGFuZWNkb3RlIHNob3VsZA0KPiBnZXQgYmFuaXNoZWQgZWxzZXdoZXJlLg0KPiANCj4gVGhl
IGNoYW5nZWxvZyBoZXJlIGNvdWxkIGRlZmluaXRlbHkgZ2V0IHRvIHRoZSBwb2ludCBmYXN0ZXIu
DQoNCkFsdGhvdWdoIHRoaXMgdGV4dCB3YXMgaW5oZXJpdGVkLCBJIHRob3VnaHQgaXQgd2FzIHVz
ZWZ1bCB0byBkaXNwZXJzZQ0KYW55ICJodWgsIEkgd29uZGVyIHdoeSIgdGhvdWdodHMgdGhhdCBt
YXkgYmUgbGluZ2VyaW5nIGluIHRoZSByZWFkZXJzDQpoZWFkIGFzIHRoZXkgdHJ5IHRvIGdyb2sg
dGhlIHJlc3Qgb2YgdGhlIHRleHQuIEknbGwgc2hvcnRlbiBpdCBhcw0Kc3VnZ2VzdGVkLiBUaGFu
a3MgYWxsLg0K
