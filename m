Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF01A69D680
	for <lists+linux-arch@lfdr.de>; Mon, 20 Feb 2023 23:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjBTWyM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Feb 2023 17:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBTWyL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Feb 2023 17:54:11 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9431EBCE;
        Mon, 20 Feb 2023 14:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676933650; x=1708469650;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=M7jPzMWVA3bjYg8PcHXiL8sEk0p0POlUTn4+0V6she8=;
  b=V2SwXbAHSf7/F35O7a9auBXYNn36iCyyAhfjDXEux8wqFiMwJyQOI8vm
   f4UGTl5mhWJGVTTWoTkiTsO8i9bozaHXdjPXcCTtbP1w+vbDe6SpoEqrF
   wVIccsEGIkdo4agDLx2s2r0yAuFGG8MviA+VktF5lOZXtwXm7XtxoGIQT
   QEJVVE6Zr+/0od/YqyNh/sVX/KxbuOWMyBNmy+bQLFGM2ldkqiTR+tns+
   Zth1pB4+IoUWRYTsSER0BZuUMCLz1HzaqzezziwNCtqlCtaQSPNATv/XG
   2BlOdW5GMJkr988rV6HLVMs4rurDKXkQGSb+dC34FSWgmeIDv6eHOyh7G
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="359972332"
X-IronPort-AV: E=Sophos;i="5.97,313,1669104000"; 
   d="scan'208";a="359972332"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 14:54:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="735262332"
X-IronPort-AV: E=Sophos;i="5.97,313,1669104000"; 
   d="scan'208";a="735262332"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 20 Feb 2023 14:54:08 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 20 Feb 2023 14:54:08 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 20 Feb 2023 14:54:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 20 Feb 2023 14:54:07 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 20 Feb 2023 14:54:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHftE6cA3bwdbcFEZGZKamybYDIYBrc8i4DQlHypGWsptnaVnf5VuUKhpYjM1OvqoA6olhpDH07adkc52g4z3kzB+H/AGt1qTqE6LH5hb9bmSA0kWKQrTkVA18QCD1FN0GWNFOmDLlrd7TQ9X0alRIEwVSqj237bkioasQVORBFwl2Ca4x2Iq8Px4McQ1a4K3Udwd+lnK8NYl4mZ4nQXejLsGaUOrkzOBKnujkdByENPQsyIHVX+IQE6G0zKE7sBdhUQ1RxU2Hp5midNDK/z7gL9TQSAK71AdzBIF6EAZsiRaV+ES0TuoDb8oTMThqwVGFHZVzjqSP8xxyqjHY/SJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7jPzMWVA3bjYg8PcHXiL8sEk0p0POlUTn4+0V6she8=;
 b=AiMSPLWZlcEFOzN5AmtPLVaG58//68rfcG7keqSsNkPiQUvERWBt0+/4cIYKhYx89Lu54WY9AuxDucWya2Yn2gDCX8mxLM84pTSr+zD9d9U/HX2tUnXPe+XJrJLBkr2PMrzzSqS3SSsQjYKiwjnTPU2S7EPyLgR5h2ZUa68LBk8XPHrWzKOgAHreV8gN+PxIG0z6LxJOR/kdijnKolv6TRl0W01nfj1tzL7AtN8LqI3EoYL21YhazLykTuTOHF07Jcm2FsF5aJR3juhgXjmPYXcd/Va7UxzDc9iCPd1ZLGPGa2WJ0Ec0hJONsXjdmdKvvAqozsHMPkilEbUDLoHDpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BL3PR11MB6506.namprd11.prod.outlook.com (2603:10b6:208:38d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 22:54:05 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6111.019; Mon, 20 Feb 2023
 22:54:04 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "keescook@chromium.org" <keescook@chromium.org>
CC:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v6 00/41] Shadow stacks for userspace
Thread-Topic: [PATCH v6 00/41] Shadow stacks for userspace
Thread-Index: AQHZQ94zC/f+ziZRo0mOlVOyPZwhw67XMuuAgAFBzYA=
Date:   Mon, 20 Feb 2023 22:54:04 +0000
Message-ID: <829e3b6b7aa34921e450f5eeb4ac9b0c0472e0fb.camel@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
         <63f2ec1a.a70a0220.bb3e0.bb19@mx.google.com>
In-Reply-To: <63f2ec1a.a70a0220.bb3e0.bb19@mx.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|BL3PR11MB6506:EE_
x-ms-office365-filtering-correlation-id: 06de15b2-6943-4dcf-6098-08db13955d9d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: onTpn9fyG3JLQVm9/M49i3y0GkUWhpzNPHVrpA24e74Zz4Qo0xlxn4sGMPlL/BZXKeEkq7sqrL4sxvqKW+t7hf2jtOwI6upocv8HOsTe0IKQDxcQ4/pEZonRsl5bSANvKUi3Z6TnoHj0Jv5oIZMm4/1jFr6HewaG9FFGjxc1zKNbggouFosoxdu41ZqBN7UAAJvDvN+WvkTjFCACgwG284d+2R3xwf9MBOL5YICgyGKtO//Sbg0fUq3WPLPgsyNd6w7rxUeWNfs8MNYnSUC0K3fPrdHacbKf3ecqUDjDH0MgWzKIfztbYb82vY/5FmTiFl5uShSXpGVsd+LJ+eLuF+fujjrHFhi01tnOGO2q1H11YNBCTKiMvY0OCmmsCxgNI9c95DVwVZdwW/Yz2d/To4Tue+ZLIou2Z0cytjCZr5dAXFteNinmYiOHRKNN6yvdgJBnXa3P+Ne/G/SW9qoZTHzZ+5nlEhg1fEUXXbBzlnIWivJOsH2Jkb62fdRnjLjANRGuDMJFi562aWfQIyyBVAw3Kw54eBvZhyJRgYB0RSV3YnJRFGXVk2QYqOhi8KLhoZMYnkbspzfJ+7SUkZOTPRmmjLrIudmUyzwf4CwCSLdIG7tp78dVlkDiZTUwHYLk4CYUPsN1zlfPKKhu3KuEqHhNOcRJfgpxVc3XUYhkO3DbZSfLq1U42a8x4f53ge2xjWItjtV1zUmlKfqo5suYU8Jn5rI02Ocaf7ULErrOC+U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199018)(122000001)(86362001)(2906002)(82960400001)(38100700002)(6512007)(6486002)(71200400001)(6506007)(186003)(26005)(478600001)(36756003)(38070700005)(66946007)(76116006)(66476007)(64756008)(66446008)(83380400001)(66556008)(316002)(41300700001)(54906003)(8676002)(6916009)(4326008)(2616005)(8936002)(7406005)(5660300002)(7416002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qm1VSjB5MVozTVAydXlhWWtNRVJyZjJScGp0dlFzNThOZkVhTFhjcVExV2ky?=
 =?utf-8?B?VUMrdHgzcEtRTWhaS3UvQUxEeDhlaDVQM2tEbUQrSXBaSVdkL29UUmFuODVt?=
 =?utf-8?B?ZTlMZzFYOSt1QmVrd0EwNmdadEYzYmtYZzN2bk1RM0RkRkJKSGxOdVNDVTlK?=
 =?utf-8?B?T1F0d1dWOFkxUllndW5VUGRZZjFOWmQ0N3JrNURlNVdudG8wNW1aSklRcUU3?=
 =?utf-8?B?QkNUbFZsdjkreElvSnFkVW9xOGg5azkzTU9kUXR2OFRRK0hKeW1mRzdkS0FV?=
 =?utf-8?B?cHRwckpuZVd0R2hLTmJuZDZRWGRsZGlCa3NQZ0pOa2F4SkM0TUg2L0cybi93?=
 =?utf-8?B?NTE4bUtVL0tZaXhmdllXV2x0OEgxUFdFWUNQNVEyMW5nUmFEZE9PSmQ0ZGIw?=
 =?utf-8?B?RnUyUHlXWDZ6dmdYVWRvZ2IxRlcwWnBLQlVXNXhaNnEyOWlBMElHcTlsWlBL?=
 =?utf-8?B?MGlVVXh4QmdFYkpBQjdpeFVHQm0zamtpemU4TG9JdnVmczdjQk01R2pMdWlZ?=
 =?utf-8?B?NU5MMXFsbEVLQ1JreEJxRSt1Nk1zRDkwZC9qeTBzczA1eGh0ZW1TV3hWTUpr?=
 =?utf-8?B?TTF5Zm9UT2dwaGZUMVZ4eWRoYXpnRXBjWWJIZEJsMjdqVlFheUMyN2dFMGU2?=
 =?utf-8?B?OVNIM3Vha0dqUGhGaDNLNWN5ZktseGVNS3VkcU9WbUo1VzJhaGJUc0hOVUR4?=
 =?utf-8?B?S0FCejJvejBHdEl1Uko0ME9TQlNWUTZlRHkvQlJOdjd4bWlFNjhvY1lVRnpp?=
 =?utf-8?B?NTREQnBDQUlWUkNlY1NVY09kcGZkNEJKTUYvRjdUY3NiMDJrZlprZitJQzVl?=
 =?utf-8?B?cThQL2ttWUxkY05oTTA4dURHdEN4VGppVTZsS2FKd0d1K2ROTkdaSW82RVJQ?=
 =?utf-8?B?THBBVHVFUVVUelNjaUl1UW9hWEpxVzlHY2IwZjBCYWxIWlRjRllQN3loL3NI?=
 =?utf-8?B?eEF5MjBaWGQ2L2JHb0JybW55L1J1SERtdGFhQ1JlcHh1MzllSHU0UFJyOXBz?=
 =?utf-8?B?bjhpaHdOaTB0L1dVRDNIanBvQklmNlFhbDg3SnA5a0MzRjJKRGtHVVZTN2hQ?=
 =?utf-8?B?V2pxc0gra2VWZHFlUlR3dDlMZmJyNk9TVU5QclVudGlkbUxQa0IyMDBCRnJY?=
 =?utf-8?B?TXdvVUFUMWdjNm82di9ocHZDNXJzN2c5Rm45TzhmRzRFdEk5QVk2NGVucld1?=
 =?utf-8?B?bWJwb0wyT0hiSW1GdHkvbjZlV21ueGc1QlRNZFp6WXl6ZEE3Zm9nYzhTZGRG?=
 =?utf-8?B?NWdxRDA4Y0xvZXZTMURhTEk4WnFWVmhDcDJJUnVLcFpjeTdzNW1NWEN2b2ls?=
 =?utf-8?B?YUdSZjlFR3lzdmdXK3AvWndRa1Y4RUxvZFZmTVdLR2dHclBraWNic2ZNcHdM?=
 =?utf-8?B?RGltQW1lLzloTUhLcWFNeEw5eC9kL3czZzFucDcrVEg5aEEzSkxFZG5Nc0J6?=
 =?utf-8?B?cWdmQ2o1Z0hpOWNYNkJKb0xqN0NGYlFPakk1Z1g4M0FlaTdXWlo2ejZyOVJN?=
 =?utf-8?B?RTlrN3pMak4zNHNaWGgvVDhvRlRDelZPS2VqZi9GQVBJcXdIY0lpc3Jid21u?=
 =?utf-8?B?SGR3RUtFZWhsamtpUThzbHR5d0M4c3JsclY0NVkxK1RHTmFMVTdwN2g2OWZm?=
 =?utf-8?B?REhtODVJb3NOQ0hhcHQxUklLMGptd1pua2tLWnoxSXJuZGxobVRSM01saUVo?=
 =?utf-8?B?dlZXcGJNcUhCTllMY0N5QUVIb2h2UFMzaTJ4eXIxNmhhdC8xeStRYzBzcjFa?=
 =?utf-8?B?R2JFTkYwclE3bWs2RjVvZUZDd3FmT2JJRWZFR1pldkE3QzBYZERDZTYwRHpv?=
 =?utf-8?B?UG5KWC9CUWNJZWg2aUZOcTF3QXBVT25xc2loeDdYT3g1VU4xVkYvOFFERkNq?=
 =?utf-8?B?dEVoMm1BUTFaV1JaZkR5L2ZXOExQTUo0elBjWjQ1RHcrbDV1SVlwWHdiWFhE?=
 =?utf-8?B?U1pRNXdobzF1dmw1Nmd6NTB3T0FLdmliaEpDdC95Ny8zRnJ3OWN1MkRVdktB?=
 =?utf-8?B?VmRSb3RwN21iWHJaTnFMUnVsOStEWUpyT1owQ0dTL2c2WGEzNHZGd08ySFJX?=
 =?utf-8?B?ckxSc2h2NGYzVEhXd2l3S1ZUbXZyYjl1cGFIS2EvZnZLOGRkOUpOc3dVemQ5?=
 =?utf-8?B?VU1iZkR0NFhHQmpwZk44YXJaazVTOFl1NHA5WVhQYkNvaHJGR0VHWHh2RHJx?=
 =?utf-8?Q?/ZP22C1z+axt/beYrBwuyDI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9639978E4C86D949B4DDC8FA2AE62DFC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06de15b2-6943-4dcf-6098-08db13955d9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 22:54:04.4238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ognjjEyurm9kVKImO2UpMm8pnlBMYG5J5r5jqVaqEjvk2M/4oQ0LlispEJ7GE1tR2cBsbIKZh3rvlUk+lcPE6r0jqsiHECCNxjtVnoW+h8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6506
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gU3VuLCAyMDIzLTAyLTE5IGF0IDE5OjQyIC0wODAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IE9u
IFNhdCwgRmViIDE4LCAyMDIzIGF0IDAxOjEzOjUyUE0gLTA4MDAsIFJpY2sgRWRnZWNvbWJlIHdy
b3RlOg0KPiA+IFRoaXMgc2VyaWVzIGltcGxlbWVudHMgU2hhZG93IFN0YWNrcyBmb3IgdXNlcnNw
YWNlIHVzaW5nIHg4NidzDQo+ID4gQ29udHJvbC1mbG93IA0KPiA+IEVuZm9yY2VtZW50IFRlY2hu
b2xvZ3kgKENFVCkuIENFVCBjb25zaXN0cyBvZiB0d28gcmVsYXRlZCBzZWN1cml0eQ0KPiA+IGZl
YXR1cmVzOiANCj4gPiBzaGFkb3cgc3RhY2tzIGFuZCBpbmRpcmVjdCBicmFuY2ggdHJhY2tpbmcu
IFRoaXMgc2VyaWVzIGltcGxlbWVudHMNCj4gPiBqdXN0IHRoZSANCj4gPiBzaGFkb3cgc3RhY2sg
cGFydCBvZiB0aGlzIGZlYXR1cmUsIGFuZCBqdXN0IGZvciB1c2Vyc3BhY2UuDQo+IA0KPiBPa2F5
LCBJJ3ZlIGRvbmUgc29tZSBiYXJlIG1ldGFsIHRlc3RpbmcsIGFuZCBpdCBhbGwgbG9va3MgaGFw
cHkuIFRoZQ0KPiBzZWxmdGVzdCBwYXNzZXMsIGFuZCBJIGNhbiBjYW4gc2VlIHRoZSBzdGFjayBh
ZGRyZXNzIG1pc21hdGNoIGdldA0KPiBkZXRlY3RlZCBpZiBJIGV4cGxpY2l0bHkgcmV3cml0ZSB0
aGUgc2F2ZWQgZnVuY3Rpb24gcG9pbnRlciBvbiB0aGUNCj4gc3RhY2s6DQo+IA0KPiBbSU5GT10g
V2FudCBub3JtYWwgZmxvdw0KPiBbSU5GT10gRm91bmQgMHg0MDE4OTAgQCAweDdmZmY0N2NmMmVm
OA0KPiBbSU5GT10gTm9ybWFsIGV4ZWN1dGlvbiBmbG93DQo+IFtJTkZPXSBXYW50IHRvIHJlZGly
ZWN0DQo+IFtJTkZPXSBGb3VuZCAweDQwMTg5MCBAIDB4N2ZmZjQ3Y2YyZWY4DQo+IFtJTkZPXSBI
aWphY2tlZCBleGVjdXRpb24gZmxvdw0KPiBbSU5GT10gRW5hYmxpbmcgc2hhZG93IHN0YWNrDQo+
IFtJTkZPXSBXYW50IHRvIHJlZGlyZWN0DQo+IFtJTkZPXSBGb3VuZCAweDQwMTg5MCBAIDB4N2Zm
ZjQ3Y2YyZWY4DQo+IFNlZ21lbnRhdGlvbiBmYXVsdCAoY29yZSBkdW1wZWQpDQo+IA0KPiBUZXN0
ZWQtYnk6IEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPg0KDQpUaGFua3MgYW5kIGZv
ciB0aGUgb3RoZXIgdGFncyENCg==
