Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E1B4AE400
	for <lists+linux-arch@lfdr.de>; Tue,  8 Feb 2022 23:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387575AbiBHWZT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Feb 2022 17:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386399AbiBHUXa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Feb 2022 15:23:30 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D473C0613CB;
        Tue,  8 Feb 2022 12:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644351808; x=1675887808;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WqU6zu/piZ7pErZnk7XAOAepB5mxM3G9Dv3lFzsvKNE=;
  b=Ii1gwbRSJDn8E66SVaP9yNC/311B+BYkpCjAQeP+/saOpKEg26azw9ed
   yq7Wd8u7JzPFpyTua+QPHH9xjPZaNl14evt/Df9UtPZ5iW6AL68JaLzuF
   jKtepI34a+LbjZa+DKN24ER9jYM3s6m5+MF540Vh0g2Is5soqj+5qXaB6
   tnBakGdHot6AG9r6WnsaLIVUp05YirCryvCw5NBi8cQyrr2RLWiHmeBbS
   A4igP6P+NrkFdBK8KPf0WUcZTa5Z0BwFpsZpYOsIE5XYLnXd7iL2iL8Fs
   3a2yf+209/m+Up5mQyySyLPUBId2Zkg//kE3uvyvHf/ExdNj0Rqh2VsZ5
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="248993782"
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="248993782"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 12:23:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="525694951"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga007.jf.intel.com with ESMTP; 08 Feb 2022 12:23:28 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 8 Feb 2022 12:23:27 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 8 Feb 2022 12:23:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 8 Feb 2022 12:23:27 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 8 Feb 2022 12:23:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiHsNJla0wjULPMGyimQqXfL5WZvb/Z6WvSQWZFPtnjDB9QnUs4boKFT5gFWrcQ3IVn7xsxQzk0H4NahhRFhAAz52vIBS0DNHru5IvMz0UN/ifZpZPfE6Sih0Ya58JCtC5/EioUSgJbAM3GmGFNFbDBRhirP8fKxf3aasNhxrjBPJPcKiCg21mnmHYeou3A5LjwfCIJf19pYr+pCf1d4E2fn0dK9str7PT8BICKYUykiypS+ThGK/EHHgHLllvmuVR4uL5Yk5mFEiCvN5ThbkTP8UzTmXIl6Yz2noza6jeDuUkjg+pDxz/uHxVD5MdVho/kzzelh1yCfC8uDKLcxkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqU6zu/piZ7pErZnk7XAOAepB5mxM3G9Dv3lFzsvKNE=;
 b=ZoJs3JNEIUfpMDnhL5X85WrBUES47YA7T4SUUMvq9YtwoxWKcnhn0/X6g+2A4/B/Jx/tqM9uwLfZqmIHKRIrHQwIBzA/fAO9c4FWQO4GexOZ/jlYZE9RBFhAlf8v6rObOZCPfUb8nLIXyMtQAUcIks/ko6h8D4rO8Z5XKRkjxplYuwyUDiHBJMd+MUz27LxytJO0k2EG+h0N/LcluvIr9JfzeWKh8lYZx9+bobHuRaKj6tMxRkD44reIzkj4oOa78sMRXWpYPO4zxEsUiv7UYbqf3/6kP4f0QdsxVq03z7/jgQVNVmOQi2cbmzAEgxzb1h8+KfiH7dBULlvKIpjZfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM6PR11MB3866.namprd11.prod.outlook.com (2603:10b6:5:199::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 20:23:24 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 20:23:24 +0000
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
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: Re: [PATCH 03/35] x86/cpufeatures: Add CET CPU feature flags for
 Control-flow Enforcement Technology (CET)
Thread-Topic: [PATCH 03/35] x86/cpufeatures: Add CET CPU feature flags for
 Control-flow Enforcement Technology (CET)
Thread-Index: AQHYFh9qehmK3wcY5UaZCHx6w6958KyIvI0AgAFqpIA=
Date:   Tue, 8 Feb 2022 20:23:24 +0000
Message-ID: <f1fe9c992131dfa989c6d321097642cce5f4830a.camel@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
         <20220130211838.8382-4-rick.p.edgecombe@intel.com>
         <b9d48ed0-699b-585c-a52c-46d789c11dc9@intel.com>
In-Reply-To: <b9d48ed0-699b-585c-a52c-46d789c11dc9@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9cbcf59-abb1-4213-a6ff-08d9eb40db9b
x-ms-traffictypediagnostic: DM6PR11MB3866:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB38669BE51DE221200A73C268C92D9@DM6PR11MB3866.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UhhsW7hc4wyQ8eAetO1XjGUOTG4Z0ACnB20Z50r9xwLzzo7jl5IX0E1g2dvdEdeo9muEq0EPZVSG/KTok9pBKBCZg2pTZOVRk9EsNx1kWNIiSoAaCVfFrrRWjeTzhJAQQPMAi0FmWDWxqzAHJk/rvEVm9fzujOyPnTXWKhHHE2AyTjQbAEZI+pdMb76JhuUOcR3wZMtiavtn52uShf8FhRmpCb3O8lT39ClUhRDkhYdzWtj6oqdUkEO76hUKTAGrnikjGRwRmk2I1fV0MkiKnUyCvsJBbX+Fn3hNo5hwm0R2zTZp9iUwUoLL+UkeVM90q+LmTyi5cYyObJ0qTCWXFP3DtJXRcTQmqXW2ox25VJpfK4xkslL7zH9aTSFg8uTerS2Ma6vZONKK9ugVGAaZgZQBxilRWEV+J3xC4835LXpgkmMbTCC0NfOVm716/kv4gW5l3HUQwoMHUDMoM+OhUS2+WxfEcCwhplBbmcVHLyzKCA2cz8Ac2JPvXoBVUq1RhuWfsWF1yO8C6C1HKkSfciiSzqgjEXkhEbujUXMSoficoihgLB3zjMu6VJdmbdx09fBPwBRQ5/MvGH1r8BtHsA20ZpLC+LxUAowOqXAWwv+pERWa+X3nBdgEAJJWOYCWfjHw6oDYPd/QFjjypvpgfIW1eVhqjxySTRQWlOCbPFRY6EtZvnGD5fKFeDwoNqGm5JEuIPvhg3v1gbCwbAJ5PgYXGzwsF1ZQNhmWJeV8MMKcQP8sR8712tVEFYTJbso3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(5660300002)(316002)(71200400001)(83380400001)(6506007)(7406005)(7416002)(6512007)(66476007)(38100700002)(26005)(76116006)(66556008)(66946007)(8936002)(8676002)(4326008)(66446008)(86362001)(64756008)(2906002)(122000001)(36756003)(6486002)(508600001)(2616005)(921005)(38070700005)(82960400001)(4744005)(110136005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWdPQmRtT0ZCbURROGQ2NEFRTVg2L1BzWGIwSklZQ3B4NmtuRFpmNVBkcmV1?=
 =?utf-8?B?dzZXaFpaV3h0aDlOWndPZXlmQnB2NUd0SWt6cjR3eEJDTHhlRmE5cHR3c056?=
 =?utf-8?B?NDNHZTRBOXF2Sm1hVDVBbVFnV1pJZGlJQUVwK3RZeEtFaytVTTJPZjlZaXVV?=
 =?utf-8?B?c1VlcTUxb0p0RTdoUmxqNVJrTkl4QUdydXlkY3FoYlc3Yit4Zmk3ZDczdFNZ?=
 =?utf-8?B?eXd2ZHFmaFZJU3dZaExEYWY1UTRKYmRObHRPVXBkTmd4ckk0WGtRTUdwUEhE?=
 =?utf-8?B?Tmw1Vm0waCtrNVpSUktZOXJKd1BwdGJ2UW0ySHczclpQRC9mekhsWjhRb2RT?=
 =?utf-8?B?eG9HOEFnZFNad0JtZFRPN1E3UldPSWpUREU2NGFJR0hFMEtkczdCNGVFNVhH?=
 =?utf-8?B?cXMrclBrUzRMQkMySU1zTUUzOXpMZmpPUjVRdlFIRU1KRDVqTDlQa3ZWNEdB?=
 =?utf-8?B?bFFEVTZSbHBFRVg2NytZeEVIY1JaaVAxU0d0cTRwMmlOb2VoVVlVWCtkR09k?=
 =?utf-8?B?cDdPUjhYbFhqdGYyekh3akI3Vk5zdVdVM0xBc1VocjhPeHpBQkFoYXFzdlpG?=
 =?utf-8?B?eWFtcHovYzlWT1V0dVZCL2RSWVZaOE5NWHFPUnd5K3RndFZuQ3o4TjVnd1Ux?=
 =?utf-8?B?OGFHUkxteGZKYnpzWkFRMUtxWHRzZTZxYWdiSnM3eXFuZDl4TFZLQkk4TWZi?=
 =?utf-8?B?SUFKc2xoaWZPVGpBUGErQytmR1lUQTJZUEE0NE1MaWRLWjBzZFJHc1d1RStx?=
 =?utf-8?B?bDdES05SWlZOT3dOUnU5OVMwR2lqVmZGWFJaZ0tSRm8rUTZkNW5WR3RKL0Yr?=
 =?utf-8?B?WVFJaWJqTGgyaWlQRUo1dURqOU02c0g2TEpjSkV2YWhwcUJOZTVkclpyUnhz?=
 =?utf-8?B?QURBT0pZTURIVHAzUDM1Rlc1NnZ0dlk2THo2bUFUbHhyUXkxTW5tV1hwUDIr?=
 =?utf-8?B?SlZaSnp5QUYwTnZ6NG5NM0x2ZTZtVGhwYTluQW03a0RGclJLQ2ZuSkNaaG1P?=
 =?utf-8?B?dW5Wb29UcnhhODMrOERFTXpjWTdrQ0xxZFJyamhuY3pZb1V0dUt3cWN5SG13?=
 =?utf-8?B?WHZPSGhVV2NkdzRYV0dHVDAySVFNRGxqWWdoZDlGWWZjWklkU3hhUTdROVcr?=
 =?utf-8?B?NG0zS2loREZPOGRpOUFLRmppbnNZRkJnSlNKMWVWSkNTQjVKbFdYdGpPQjU2?=
 =?utf-8?B?V1VlZkFXaUdRSXBJRDlyNmJrRlhqSHdoZW4rR3VXem1QR1RESEx3V1ZVUG1T?=
 =?utf-8?B?bTlFSG0rWXVRczZwMmZ4MG01YUdaSjFnNjFtcGZNQ2ZCY0lsUVRZUTFLN3JJ?=
 =?utf-8?B?SnNUZThFelh5TUtxMHNTK3kyNTRKWkM1d1pIZzFLRk5NWVpiY0xOYjZnUllm?=
 =?utf-8?B?UmJTRTdFZU94RE5EK1o4Nk5oc2o1aWNVditDWGJ5RHdGaWRDV1Q3YWF4ZDFk?=
 =?utf-8?B?TkpaTUZkSDBSVHBZZlBPNDU2SysxK2E5M3VVSkZqaUNFYktZMFhXNDFleEo2?=
 =?utf-8?B?STFFY0I3UGJLUHJwY2VCR0xkYXh4MU5uNTdFNnNqSGlJdTNJbE1tZEJkQlln?=
 =?utf-8?B?M095RUN0d3AxM2dtT2lCQ0JvaE9Ld2o4Ym5GaklwOFdKWnBMMUJoT2NycnRs?=
 =?utf-8?B?aUIxTWordmoyU3g3elA1ZjZhaEdQL0dGRnNCMXpFUHVPa25xQkJhMlc0ZGJs?=
 =?utf-8?B?WE81Mm1yZTBmWjAwdFNjdGRYU1M3SCtLVTc5bytBU2t6amhISWcyUmhzaFds?=
 =?utf-8?B?MVZWNGFXRWdMT1FZTm9sc3AyaURpUVBHOXlnREtjVUlJblNOREhHTTVWb1R0?=
 =?utf-8?B?VDUxWVd0UllDaXV4R1VNMUliU2tYdVIrUmhkUERzck91cUFCWEFKdG84UGxF?=
 =?utf-8?B?aVM0MStFVC9tc0E4bi9YWkptT0N5U1pzdng0RlZ1TUlWOWdvNkwxb0wwckJT?=
 =?utf-8?B?dEFtcTJUN250K0lsNnd2Njh5aTMzemZ2QW5uQlhKMEtuN0JHb2xVZlRlcCtU?=
 =?utf-8?B?UkovWER0QWp2Z0FQQ296ZHE2U2dSUTBTNXBEVzlaRG1kSUhHTXk3NDFCV0c1?=
 =?utf-8?B?dHZjeHQvNThpZ3d5Y0UzbXhCYTI4dEtaSE04WDF6aXRaOTB6U0Z2Vk9sMith?=
 =?utf-8?B?d0ovYk91UFBaaEN2NmJWQU8ydmZ5cmZJTDdXUU42U09YSVFVa0dzRnBxdUtP?=
 =?utf-8?B?L29YNHpRVzVNdEVJemQvWEpnRnBFRmsvZ1VrZzY0K0xzelJGWjZ6ZkRxclRt?=
 =?utf-8?Q?AngwxVRvh8a/z/IyZdvVMWl3nC1gwjTyUd9aRxP6tg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E70C5EB498AEB479A8EAE5C219F6942@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9cbcf59-abb1-4213-a6ff-08d9eb40db9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 20:23:24.3231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Jq4mlOe6jtvhB5kvEzg+xmvJkSuB0jKzxiUXwBBk+0GWwuUc4JazxS/7SAuW6EyTowRM91pyBuoT49pRAQfHngMLSjrXFWkwFCKfeC2IBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3866
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

T24gTW9uLCAyMDIyLTAyLTA3IGF0IDE0OjQ1IC0wODAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
UGxlYXNlIGFkZCBhIGNodW5rIHRvIHRoZSBjaGFuZ2Vsb2cgdGhhdCBleHBsYWlucyB0aGUgZGVw
ZW5kZW5jeS4gDQo+IFRoaXMNCj4gd291bGQgc3VmZmljZToNCj4gDQo+ICAgICAgICAgVG8gcHJv
dGVjdCBzaGFkb3cgc3RhY2sgc3RhdGUgZnJvbSBtYWxpY2lvdXMgbW9kaWZpY2F0aW9uLA0KPiB0
aGUNCj4gICAgICAgICByZWdpc3RlcnMgYXJlIG9ubHkgYWNjZXNzaWJsZSBpbiBzdXBlcnZpc29y
IG1vZGUuICBUaGlzDQo+ICAgICAgICAgaW1wbGVtZW50YXRpb24gY29udGV4dC1zd2l0Y2hlcyB0
aGUgcmVnaXN0ZXJzIHdpdGggWFNBVkVTLiANCj4gTWFrZQ0KPiAgICAgICAgIFg4Nl9GRUFUVVJF
X1NIU1RLIGRlcGVuZCBvbiBYU0FWRVMuDQoNClRoYW5rcy4gWWVhLCBJIGRvbid0IHRoaW5rIHRo
YXQgcGFydCBvZiB0aGUgZGVzaWduIGlzIHJlYWxseSBlbGFib3JhdGVkDQpvbiBhbnl3aGVyZS4g
SXQgY2FuIGJlIHNvbWUgZm9yZXNoYWRvd2luZyBmb3IgdGhlIHNpZ25hbCBzdHVmZiBsYXRlcg0K
dG9vLg0K
