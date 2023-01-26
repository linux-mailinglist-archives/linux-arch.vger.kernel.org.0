Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC0067D608
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 21:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjAZUQw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Jan 2023 15:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjAZUQv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2023 15:16:51 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0113EC56;
        Thu, 26 Jan 2023 12:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674764209; x=1706300209;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bBsNjPYUXpPnGBf/NJf77qYc6twFHf5RbRFxbANhjPc=;
  b=jxieqBu6JTcRtVWpMdS1nxHJG9JI0BP4uj1UvWRyGIoIGnUlsoRxlib8
   3/viOpF78T2Sym30c2d0q592mNLcBh/pSEwtgcvEbXFf9jObgUyHoUf3P
   aYjglQZpW8xTJoPVMNn24QQPmuK5bExSh0XoXApqfhW4qfhJg2tcKQXoB
   caElbG8VU73opMerZg0iqAK2+mpyqpaN0WJZ/ajmHl+wh42/ZidycRlsC
   HSEFPNQ0Haek19lcvP1QVmKOqyS9g8zlxDU25GjUHmnPjZnXsB0SMjug0
   kzA+OcSppNWyKz6gPGSsqFL09ryfVH9I1yINoV+nwRIvNzQZWYYF5k4ZT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="354230187"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="354230187"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 12:16:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="751720911"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="751720911"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Jan 2023 12:16:47 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 12:16:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 26 Jan 2023 12:16:47 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 26 Jan 2023 12:16:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxplV9nzcEJ6fMkfKojwqjRAj1w8tqH1siOIC//ZxdAvPHgvP5VA5XM023QV3kAGEbhM5p7TiMSgvaAu5JAQtAPNoPw5fc4cojd6lWpvewY8UtbIoT1J0KA/eGmvp2T9Zl66AT5XoFnNILP2jNE5HwyXh6CYIhqq6rmbyHv1wwqvUEkiRbgRnZqJz7YkMej8hqfBSpXurLO3RWYui45ugCRwprySAtxp1BVEvM8lmgixbqZBfjH/vQkTqyxqHq/WbbssMuGhBUqXF5J8subRnc+gl65r6Eg/0lh9rKpNgjes/8T4q8pCGFN1IljyzWCaFRkNl9BrV+XvqXelheojPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBsNjPYUXpPnGBf/NJf77qYc6twFHf5RbRFxbANhjPc=;
 b=CfmK1KdmGKdYIpdGAWbmoM8w1In1TqwL5W9F5OUjb7inbVIAQRjHcfxEIZWmH1p2ao74tJ75lbPTEyPKYiRyUw3dwBHVmiVjBndFztHMH2M5223aXtAEvmlhlkyM/kHOBftxbQIGNC6PFgvZJ7vsEyQncfFnLYDFxTiHU9uwygHQnYNTjCo+DBX7Cqt1oCydtBWK5VoEPza5KNxmG0US4pWRvbzW1/wGYzWOqP+Ew/nEvI+OtPJDAPNs4Z56A5YluHxHcbeETVM/Bz0EvO7Pn+lTu+EnCaRydmJ2B/yJgH17r+okqxBGY7WOpJhnPdIBiFhj53MPkORR/RFuGYC8cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SJ0PR11MB5118.namprd11.prod.outlook.com (2603:10b6:a03:2dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 20:16:34 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 20:16:34 +0000
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
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
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
Thread-Index: AQHZLExgp79hLxaTJUWnXCRef2z2Ua6rx5SAgAC3h4CAAUjWAIAAHt0AgAD++ACAAJuKAIAA7oSAgAC9vYA=
Date:   Thu, 26 Jan 2023 20:16:34 +0000
Message-ID: <4ebbdd643853ff02c930baee817ba6f515595224.camel@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
         <20230119212317.8324-19-rick.p.edgecombe@intel.com>
         <7f63d13d-7940-afb6-8b25-26fdf3804e00@redhat.com>
         <50cf64932507ba60639eca28692e7df285bcc0a7.camel@intel.com>
         <1327c608-1473-af4f-d962-c24f04f3952c@redhat.com>
         <8c3820ae1448de4baffe7c476b4b5d9ba0a309ff.camel@intel.com>
         <4d224020-f26f-60a4-c7ab-721a024c7a6d@redhat.com>
         <dd06b54291ad5721da392a42f2d8e5636301ffef.camel@intel.com>
         <79e0a85e-1ec4-e359-649d-618ca79c36f7@redhat.com>
In-Reply-To: <79e0a85e-1ec4-e359-649d-618ca79c36f7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SJ0PR11MB5118:EE_
x-ms-office365-filtering-correlation-id: 6b8d0151-624e-4de0-cd74-08daffda3868
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n2CQsldZoDgW7r0FDq/poWsS/3LskWciCqGJznrYnUxjc3PRPwELytxtLJ1JxHDhyHuaVQzD/riNbg06B5PSsFoJ1zZJCQIv0PiMF+q+nISI2pEPTR571cm/2mIToew3d/DiLTWs4USvD2FmOgwfYepCnmrGvBhC3NuqH+MOt8/33nyAAZmE2aUt4WgE3YBInu2nHFLSrttZfkWQWB2QdRLuyi2T+PWlfXppBqfO8Ktv438xs4Sslih4Ljw3nn0ibkAniHBDTp/GP/H7FYX4wAwVx+3szbkNK+nFKZKIEXoOZ2Lm9dCUeLH6ke0UScsszA+cfJIxHx7dQjoBfsQvRknjQUzp0D6njquD2Qt/5PUxfolZzrY27UAF8nepepfGaciLSW2RD5gMXCWcfYY606yaKwRb1Uawo7Myd845fiILoa77buk8WTk3tRdAb7f/TetklhIDVuOtXPUcAUNao5BjByvbkhqQmMjtHb+ZnmDR3LyHockn4NU4ThkAVQZ0uzoEtI+akyefwRnxgMWXok/wn4emrpOBP71/pgdnzTsoGIPEfhywFF62niVGjtvUOdBL0XNjXOYrWGteGMbNVemUonr9ND/g4z4qXzARCgwotFaV+umfk9qyM/3/ITonqmrI9izjicjwNxVi/GmzkEIGpnzUpvPnnF79SBZqVvqn6BeeQ9hLrJ8RKgOThUv4oItkSq1LfUX691fr8N4ff9r4bsd+jJ+SisaVKPkr2OB0aWI2DxMBkjidwEI1A+x7xAevLMWuUKbCm63E+XQkTiofZR9eo1aJSdj8QOnHVjIY6XNsqBITqJX8q4KDpmySizCFWTfNWPtkgvNBw7aRZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199018)(122000001)(2906002)(38100700002)(38070700005)(6486002)(921005)(2616005)(6512007)(6506007)(186003)(26005)(53546011)(86362001)(83380400001)(76116006)(82960400001)(64756008)(66476007)(66446008)(66556008)(4326008)(7406005)(7416002)(5660300002)(66946007)(8676002)(36756003)(41300700001)(316002)(71200400001)(110136005)(966005)(8936002)(66899018)(478600001)(99106002)(17423001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NisvdXhLaE1kY2g4alZXTnJOcDBxTzR5QjJ2K1NSUG8xUjdKN0VUYXczeVVG?=
 =?utf-8?B?SFI0aTBnanlTYllHZW9tanhreU1RUXBJRDVCYXBYc1hUdW5Iak1DMDhYTjd3?=
 =?utf-8?B?ME1GdW9LbktQUHVKV3ZpS09VNTYvQmlIR0tyUEd3VVk0K3hKNGxjdVJyUloy?=
 =?utf-8?B?SldJZlVEUGRVSENNZ0tzeE1GR0E4NFBEclhyMURGcGZxR0N6VHhMUTFXc0F3?=
 =?utf-8?B?MmFpRFpoVHJ6UVN2amRlMEt5UlF0QW1Id1dQVEJ0Ym9tU2RCSXJab3FGR2wx?=
 =?utf-8?B?TW5zcFVwblA0VVBmdzArcCtOT0diWDQ2dkRVRFFuYko4OGMzdElDODRZVFV3?=
 =?utf-8?B?TzlCL0tJYnJBUXlVZ1d6SGZUTWxESDlrQng2dkl4RWErZ0JWZTNFWnFkZU1v?=
 =?utf-8?B?d0FNd0hQcFUxZzczSnlKQlVXTjF6aXprN29LQysyQWJ1SHM0QityWWF6ajJB?=
 =?utf-8?B?dHB4TVZhVEx5NlI1UVJEZHJueFdsVEZ6TldFZWpGRXc1RnBVNFl5UDdKaEsx?=
 =?utf-8?B?TlFWbFdtYWY3R2Fnbm12QkRQZGxXMmg1WjhQTWx1OVh6eWF5UCs1TXV2QUNM?=
 =?utf-8?B?QTBLR096S0lud1JjMFJRQnppdkRnOUlXNjhiUi9DdDdKYlNtUlZWaFVnRGxT?=
 =?utf-8?B?T2s1RUlGeVFQV1c3S00ySjJLUFQ5VkpPVWMrWE5Db01vSkVSTU1EY0VkZHp3?=
 =?utf-8?B?TWtFQWtuSEZhdFI2SUoxSCsvbFBZQ3B2aFRKRmw0b3ZPQnBiYlE1NVNraDBO?=
 =?utf-8?B?dnQyMGxkOEE5N203Q3lLNzVIZHpZbklSTG51Y2NiM09hTXlEL0lxYlg2MTNy?=
 =?utf-8?B?RmFhL1RvaUtLRWkyTlNLQ0xUODBiSUZvQzRURXVhdEhQQXlXV1d0VzVTM3pO?=
 =?utf-8?B?MmFxSDh0VnIwOUtNdlN3cmE0UGcyNndxeU1IQjc3ZFZKdHpyZ0J4cjRWakY5?=
 =?utf-8?B?dDJvaiszL3BlaWdyclZwSGdjRVZVK0xqR1NXS3ozOXlHMEQ0ZWxSNWdmN2Fh?=
 =?utf-8?B?M0lvMDZlTm9Sa1dENE1mdU1GWUNIRWpXY0NrY0sxSzhvcHNWcFpxS2VlQ3lu?=
 =?utf-8?B?a3o1RmNJb2J6cU5EWVIycHFzKyt5OWEwOUhST0ZlZlJEOGxwakM0aHQ1UFNi?=
 =?utf-8?B?cDZ4T0hJdjh4M1I0b1VRUzZVcDNSK1hTcWFmSEdYb0NoczBkVy9SS09qOW9u?=
 =?utf-8?B?WnozSWR4UnFtL1BpdTdBZlYzejN2a1pSNjVJVW5SN1VZMnozRmQzemhtMThS?=
 =?utf-8?B?Q0VNRzB6UUdaUnR0aG5FYWg0ZUVUUnhvOFpTNG5RQ3V1SHl3THoyU3ZUVENR?=
 =?utf-8?B?OWY4T01KRDY4b0s1bWU1TCtDcUkvUXR5MnhwQ2VDZmZkWC9YSVdCL3oxRVNR?=
 =?utf-8?B?UWo0T1psUTZvcHdVM3FaOWRVTmRndVI0aXVHR2xRZzIwRDh6RklMYXNVaHdw?=
 =?utf-8?B?UEx2SmJObVdpVVhMS21vSTBDb1hIbkdLdXZGbVdEUkNUS0Q4cU11K3pKbnZt?=
 =?utf-8?B?LzhQcDFTVFJaUjcyME1oZithSDZtTFovWFhKTUtlVzRHL01YOXdnc2krak43?=
 =?utf-8?B?UFBGZmdlOVNvc1l3eDNLRit5NXkxeTVNTStSTlpvVjdpZkxDMlp2OXJsbkFX?=
 =?utf-8?B?b2M5VWdwc3l2VDFyeFhoV3d0ZU1OVUVaUHRjNGtTRXRZWHU5cy9NQTZlaERa?=
 =?utf-8?B?RzFSYWF5NFlEMU51NGoreCtUd3M0aVR0SGRyV3NIRDB1UldNUm1XNDh5Wmhm?=
 =?utf-8?B?TkN0VHhPN1lybVJUaGtCZ2tETUFEakZsOXRTQTVXRlBydURZVmJuZTc2RVBa?=
 =?utf-8?B?WW9wVjliNEdNMk5wd2craTlnam9uMEs2NDR1S3dJVFFWRjNPK284RDVWdjJs?=
 =?utf-8?B?anVsNHNaUXV0RTJFK3dFdk1XZGpzekdhS0hiZzlHcHJlNTNmWUJkNklRZW9H?=
 =?utf-8?B?cjBXNW9hUGl1SmgxMmpCVDU3ZmZMeUN4UUhiR3ZrR3F0QUsrZnRCRFFldmd5?=
 =?utf-8?B?R2VwMEt1MU9BT0haZTN1WGw1cGlBdHI1TDlLS0RQMHN4bUZud2xBQWIwL1p3?=
 =?utf-8?B?K3VuNDVtTm84VUdiNEFKdE5zNGVscXpzUXJwYWpBakFpY1Nhak9XcWZRMStL?=
 =?utf-8?B?QTVBcmNyUGRHSnBnamVPYVVOUHcrT0p3clM0djJuUEZkTzZXeVBGQmFhcjA4?=
 =?utf-8?Q?qHzUZuWbPy506x5uCG7ENQY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04394FBBEA1C894CB8A60F59CACE4B4F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8d0151-624e-4de0-cd74-08daffda3868
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2023 20:16:34.0536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x4ZgexJSTiGZKQDCeYZyA6b58F4XbBD8CdJU5LVDncFVg3TKGjSmG43oEK03amTSgrU1i6Ma0Ff0zlHA7OX5w4Vd8oeSh9lV6QY6+3hh6Cs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5118
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

T24gVGh1LCAyMDIzLTAxLTI2IGF0IDA5OjU3ICswMTAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gT24gMjUuMDEuMjMgMTk6NDMsIEVkZ2Vjb21iZSwgUmljayBQIHdyb3RlOg0KPiA+IE9u
IFdlZCwgMjAyMy0wMS0yNSBhdCAxMDoyNyArMDEwMCwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6
DQo+ID4gPiA+ID4gUm91Z2hseSBzcGVha2luZzogaWYgd2UgYWJzdHJhY3QgaXQgdGhhdCB3YXkg
YW5kIGdldCBhbGwgb2YNCj4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiAiaG93DQo+ID4gPiA+ID4g
dG8NCj4gPiA+ID4gPiBzZXQgaXQgd3JpdGFibGUgbm93PyIgb3V0IG9mIGNvcmUtTU0sIGl0IG5v
dCBvbmx5IGlzIGNsZWFuZXINCj4gPiA+ID4gPiBhbmQNCj4gPiA+ID4gPiBsZXNzDQo+ID4gPiA+
ID4gZXJyb3IgcHJvbmUsIGl0IG1pZ2h0IGV2ZW4gYWxsb3cgb3RoZXIgYXJjaGl0ZWN0dXJlcyB0
aGF0DQo+ID4gPiA+ID4gaW1wbGVtZW50DQo+ID4gPiA+ID4gc29tZXRoaW5nIGNvbXBhcmFibGUg
KGUuZy4sIHVzaW5nIGEgZGVkaWNhdGVkIEhXIGJpdCkgdG8NCj4gPiA+ID4gPiBhY3R1YWxseQ0K
PiA+ID4gPiA+IHJldXNlDQo+ID4gPiA+ID4gc29tZSBvZiB0aGF0IHdvcmsuIE90aGVyd2lzZSBt
b3N0IG9mIHRoYXQgInNoc3RrIiBpcyByZWFsbHkNCj4gPiA+ID4gPiBqdXN0DQo+ID4gPiA+ID4g
eDg2DQo+ID4gPiA+ID4gc3BlY2lmaWMgLi4uDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSSBndWVz
cyB0aGUgb25seSBjYXNlcyB3ZSBoYXZlIHRvIHNwZWNpYWwgY2FzZSB3b3VsZCBiZSBwYWdlDQo+
ID4gPiA+ID4gcGlubmluZw0KPiA+ID4gPiA+IGNvZGUgd2hlcmUgcHRlX3dyaXRlKCkgd291bGQg
aW5kaWNhdGUgdGhhdCB0aGUgUFRFIGlzDQo+ID4gPiA+ID4gd3JpdGFibGUNCj4gPiA+ID4gPiAo
d2VsbCwNCj4gPiA+ID4gPiBpdA0KPiA+ID4gPiA+IGlzLCBqdXN0IG5vdCBieSAib3JkaW5hcnkg
Q1BVIGluc3RydWN0aW9uIiBjb250ZXh0IGRpcmVjdGx5KToNCj4gPiA+ID4gPiBidXQNCj4gPiA+
ID4gPiB5b3UNCj4gPiA+ID4gPiBkbw0KPiA+ID4gPiA+IHRoYXQgYWxyZWFkeSwgc28gLi4uIDop
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gU29ycnkgZm9yIHN0dW1ibGluZyBvdmVyIHRoYXQgdGhp
cyBsYXRlLCBJIG9ubHkgc3RhcnRlZA0KPiA+ID4gPiA+IGxvb2tpbmcNCj4gPiA+ID4gPiBpbnRv
DQo+ID4gPiA+ID4gdGhpcyB3aGVuIHlvdSBDQ2VkIG1lIG9uIHRoYXQgb25lIHBhdGNoLg0KPiA+
ID4gPiANCj4gPiA+ID4gU29ycnkgZm9yIG5vdCBjYWxsaW5nIG1vcmUgYXR0ZW50aW9uIHRvIGl0
IGVhcmxpZXIuIEFwcHJlY2lhdGUNCj4gPiA+ID4geW91cg0KPiA+ID4gPiBjb21tZW50cy4NCj4g
PiA+ID4gDQo+ID4gPiA+IFByZXZpb3VzbHkgdmVyc2lvbnMgb2YgdGhpcyBzZXJpZXMgaGFkIGNo
YW5nZWQgc29tZSBvZiB0aGVzZQ0KPiA+ID4gPiBwdGVfbWt3cml0ZSgpIGNhbGxzIHRvIG1heWJl
X21rd3JpdGUoKSwgd2hpY2ggb2YgY291cnNlIHRha2VzIGENCj4gPiA+ID4gdm1hLg0KPiA+ID4g
PiBUaGlzIHdheSBhbiB4ODYgaW1wbGVtZW50YXRpb24gY291bGQgdXNlIHRoZSBWTV9TSEFET1df
U1RBQ0sNCj4gPiA+ID4gdm1hDQo+ID4gPiA+IGZsYWcNCj4gPiA+ID4gdG8gZGVjaWRlIGJldHdl
ZW4gcHRlX21rd3JpdGUoKSBhbmQgcHRlX21rd3JpdGVfc2hzdGsoKS4gVGhlDQo+ID4gPiA+IGZl
ZWRiYWNrDQo+ID4gPiA+IHdhcyB0aGF0IGluIHNvbWUgb2YgdGhlc2UgY29kZSBwYXRocyAibWF5
YmUiIGlzbid0IHJlYWxseSBhbg0KPiA+ID4gPiBvcHRpb24sIGl0DQo+ID4gPiA+ICpuZWVkcyog
dG8gbWFrZSBpdCB3cml0YWJsZS4gRXZlbiB0aG91Z2ggdGhlIGxvZ2ljIHdhcyB0aGUNCj4gPiA+
ID4gc2FtZSwNCj4gPiA+ID4gdGhlDQo+ID4gPiA+IG5hbWUgb2YgdGhlIGZ1bmN0aW9uIG1hZGUg
aXQgbG9vayB3cm9uZy4NCj4gPiA+ID4gDQo+ID4gPiA+IEJ1dCBhbm90aGVyIG9wdGlvbiBjb3Vs
ZCBiZSB0byBjaGFuZ2UgcHRlX21rd3JpdGUoKSB0byB0YWtlIGENCj4gPiA+ID4gdm1hLg0KPiA+
ID4gPiBUaGlzDQo+ID4gPiA+IHdvdWxkIHNhdmUgdXNpbmcgYW5vdGhlciBzb2Z0d2FyZSBiaXQg
b24geDg2LCBidXQgaW5zdGVhZA0KPiA+ID4gPiByZXF1aXJlcw0KPiA+ID4gPiBhDQo+ID4gPiA+
IHNtYWxsIGNoYW5nZSB0byBlYWNoIGFyY2gncyBwdGVfbWt3cml0ZSgpLg0KPiA+ID4gDQo+ID4g
PiBJIHBsYXllZCB3aXRoIHRoYXQgaWRlYSBzaG9ydGx5IGFzIHdlbGwsIGJ1dCBkaXNjYXJkZWQg
aXQuIEkgd2FzDQo+ID4gPiBub3QNCj4gPiA+IGFibGUgdG8gY29udmluY2UgbXlzZWxmIHRoYXQg
aXQgd291bGRuJ3QgYmUgcmVxdWlyZWQgdG8gcGFzcyBpbg0KPiA+ID4gdGhlDQo+ID4gPiBWTUEN
Cj4gPiA+IGFzIHdlbGwgZm9yIHRoaW5ncyBsaWtlIHB0ZV9kaXJ0eSgpLCBwdGVfbWtkaXJ0eSgp
LCBwdGVfd3JpdGUoKSwNCj4gPiA+IC4uLg0KPiA+ID4gd2hpY2ggd291bGQgZW5kIHVwIGZhaXJs
eSB1Z2x5IChvciBldmVuIGltcG9zc2libGUgaW4gdGhpbmcgc2xpa2UNCj4gPiA+IEdVUC1mYXN0
KS4NCj4gPiA+IA0KPiA+ID4gRm9yIGV4YW1wbGUsIEkgd29uZGVyIGhvdyB3ZSdkIGJlIGhhbmRs
aW5nIHN0dWZmIGxpa2UNCj4gPiA+IGRvX251bWFfcGFnZSgpDQo+ID4gPiBjbGVhbmx5IGNvcnJl
Y3RseSwgd2hlcmUgd2UgdXNlIHB0ZV9tb2RpZnkoKSArIHB0ZV9ta3dyaXRlKCksIGFuZA0KPiA+
ID4gZWl0aGVyDQo+ID4gPiBjYWxsIG1pZ2h0IHNldCB0aGUgUFRFIHdyaXRhYmxlIGFuZCBtYWlu
dGFpbiBkaXJ0eSBiaXQgLi4uDQo+ID4gDQo+ID4gcHRlX21vZGlmeSgpIGlzIGhhbmRsZWQgbGlr
ZSB0aGlzIGN1cnJlbnRseToNCj4gPiANCj4gPiANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xr
bWwvMjAyMzAxMTkyMTIzMTcuODMyNC0xMi1yaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbS8NCj4g
PiANCj4gPiBUaGVyZSBoYXMgYmVlbiBhIGNvdXBsZSBpdGVyYXRpb25zIG9uIHRoYXQuIFRoZSBj
dXJyZW50IHNvbHV0aW9uIGlzDQo+ID4gdG8NCj4gPiBkbyB0aGUgRGlydHktPlNhdmVkRGlydHkg
Zml4dXAgaWYgbmVlZGVkIGFmdGVyIHRoZSBuZXcgcHJvdHMgYXJlDQo+ID4gYWRkZWQuDQo+ID4g
DQo+ID4gT2YgY291cnNlIHB0ZV9tb2RpZnkoKSBjYW4ndCBrbm93IHdoZXRoZXIgeW91IGFyZSBh
cmUgYXR0ZW1wdGluZyB0bw0KPiA+IGNyZWF0ZSBhIHNoYWRvdyBzdGFjayBQVEUgd2l0aCB0aGUg
cHJvdCB5b3UgYXJlIHBhc3NpbmcgaW4uIEJ1dCB0aGUNCj4gPiBjYWxsZXJzIHRvZGF5IGV4cGxp
Y2l0bHkgY2FsbCBwdGVfbWt3cml0ZSgpIGFmdGVyIGZpbGxpbmcgaW4gdGhlDQo+ID4gb3RoZXIN
Cj4gPiBiaXRzIHdpdGggcHRlX21vZGlmeSgpLg0KPiANCj4gU2VlIGJlbG93IG9uIG15IE1BUF9Q
UklWQVRFIHZzLiBNQVBfU0hBUkVEIGNvbW1lbnQuDQoNClllcCwgTUFQX1NIQVJFRCBzdXBwb3J0
IHdhcyBkcm9wcGVkIHdpdGggdGhlIHJlYm9vdCBvZiB0aGUgc2VyaWVzLiBJdA0KZGlkIGhhdmUg
c29tZSBwcm9ibGVtcyBJSVJDLg0KDQpOb3cgc2hhZG93IHN0YWNrIG1lbW9yeSBjcmVhdGlvbiBp
cyB0aWdodGx5IGNvbnRyb2xsZWQuIEVpdGhlciBjcmVhdGVkDQp2aWEgc3BlY2lhbCBzeXNjYWxs
IG9yIGF1dG9tYXRpY2FsbHkgd2l0aCBhIG5ldyB0aHJlYWQuDQoNCj4gDQo+ID4gVG9kYXkgdGhp
cyBwYXRjaCBjYXVzZXMgdGhlIHB0ZV9ta3dyaXRlKCkgdG8gYmUNCj4gPiBza2lwcGVkIGFuZCBh
bm90aGVyIGZhdWx0IG1heSBiZSByZXF1aXJlZCBpbiB0aGUgbXByb3RlY3QoKSBhbmQNCj4gPiBu
dW1hDQo+ID4gY2FzZXMsIGJ1dCBpZiB3ZSBjaGFuZ2UgcHRlX21rd3JpdGUoKSB0byB0YWtlIGEg
Vk1BIHdlIGNhbiBqdXN0DQo+ID4gbWFrZSBpdA0KPiA+IHNoYWRvdyBzdGFjayB0byBzdGFydC4N
Cj4gPiANCj4gPiBJdCBtaWdodCBiZSB3b3J0aCBtZW50aW9uaW5nLCB0aGVyZSB3YXMgYSBzdWdn
ZXN0aW9uIGluIHRoZSBwYXN0IHRvDQo+ID4gdHJ5DQo+ID4gdG8gaGF2ZSB0aGUgc2hhZG93IHN0
YWNrIGJpdHMgY29tZSBvdXQgb2Ygdm1fZ2V0X3BhZ2VfcHJvdCgpLCBidXQNCj4gPiBNTQ0KPiA+
IGNvZGUgd291bGQgdGhlbiB0cnkgdG8gbWFwIHRoZSB6ZXJvIHBhZ2UgYXMgKHNoYWRvdyBzdGFj
aykgd3JpdGFibGUNCj4gPiB3aGVuIHRoZXJlIHdhcyBhIG5vcm1hbCAobm9uLXNoYWRvdyBzdGFj
aykgcmVhZCBhY2Nlc3MuIFNvIEkgaGFkIHRvDQo+ID4gYWJhbmRvbiB0aGF0IGFwcHJvYWNoIGFu
ZCByZWx5IG9uIGV4cGxpY2l0IGNhbGxzIHRvDQo+ID4gcHRlX21rd3JpdGUvc2hzdGsoKQ0KPiA+
IHRvIG1ha2UgaXQgc2hhZG93IHN0YWNrLg0KPiANCj4gVGhhbmtzLCBkbyB5b3UgaGF2ZSBhIHBv
aW50ZXI/DQoNCkkgbmV2ZXIgcG9zdGVkIGl0IGJlY2F1c2UgaXQgZGlkbid0IHdvcmsgb3V0LiBU
aGlzIHdhcyB0aGUgY29tbWVudCB0aGF0DQpwcm9tcHRlZCB0aGUgZXhwbG9yYXRpb24gaW4gdGhh
dCBkaXJlY3Rpb246DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvODA2NWMzMzMtMDkx
MS0wNGEyLWY5MWUtN2MyZTBjYzdlYzUxQGludGVsLmNvbS8NCg0KU2hhZG93IHN0YWNrIG1lbW9y
eSBhbHNvIHVzZWQgdG8gbm90IGJlIFZNX1dSSVRFIChWTV9TSEFET1dfU1RBQ0sNCm9ubHkpLCBi
dXQgdGhpcyB3YXMgY2hhbmdlZCBmb3Igb3RoZXIgcmVhc29ucy4gSW4gdjIgdGhlcmUgd2VyZSBz
b21lDQp1cGRhdGVzIHRvIGhvdyBzaGFkb3cgc3RhY2sgbWVtb3J5IHdhcyBoYW5kbGVkLCBhbmQg
dGhlIGNvdmVyIGxldHRlcg0KaGFkIGEgd3JpdGV1cCBvZiB0aGUgcmVhc29ucyBhbmQgZ2VuZXJh
bCBkZXNpZ246DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMjA5MjkyMjI5MzYu
MTQ1ODQtMS1yaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbS8NCg0KPiANCj4gPiANCj4gPiA+IA0K
PiA+ID4gSGF2aW5nIHRoYXQgc2FpZCwgbWF5YmUgaXQgY291bGQgd29yayB3aXRoIG9ubHkgYSBz
aW5nbGUgc2F2ZWQtDQo+ID4gPiBkaXJ0eQ0KPiA+ID4gYml0DQo+ID4gPiBhbmQgcGFzc2luZyBp
biB0aGUgVk1BIGZvciBwdGVfbWt3cml0ZSgpIG9ubHkuDQo+ID4gPiANCj4gPiA+IHB0ZV93cnBy
b3RlY3QoKSB3b3VsZCBkZXRlY3QgIndyaXRhYmxlPTAsZGlydHk9MSIgYW5kIG1vdmUgdGhlDQo+
ID4gPiBkaXJ0eQ0KPiA+ID4gYml0DQo+ID4gPiB0byB0aGUgc29mdC1kaXJ0eSBiaXQgaW5zdGVh
ZCwgcmVzdWx0aW5nIGluDQo+ID4gPiAid3JpdGFibGU9MCxkaXJ0eT0wLHNhdmVkLWRpcnR5PTEi
LA0KPiA+ID4gDQo+ID4gPiBwdGVfZGlydHkoKSB3b3VsZCByZXR1cm4gZGlydHk9PTF8fHNhdmVk
LWRpcnR5PT0xLg0KPiA+ID4gDQo+ID4gPiBwdGVfbWtkaXJ0eSgpIHdvdWxkIHNldCBlaXRoZXIg
c2V0IGRpcnR5PTEgb3Igc2F2ZWQtZGlydHk9MSwNCj4gPiA+IGRlcGVuZGluZw0KPiA+ID4gb24g
dGhlIHdyaXRhYmxlIGJpdC4NCj4gPiA+IA0KPiA+ID4gcHRlX21rY2xlYW4oKSB3b3VsZCBjbGVh
biBib3RoIGJpdHMuDQo+ID4gPiANCj4gPiA+IHB0ZV93cml0ZSgpIHdvdWxkIGRldGVjdCAid3Jp
dGFibGUgPT0gMSB8fCAod3JpdGFibGU9PTAgJiYNCj4gPiA+IGRpcnR5PT0xKSINCj4gPiA+IA0K
PiA+ID4gcHRlX21rd3JpdGUoKSB3b3VsZCBhY3QgYWNjb3JkaW5nIHRvIHRoZSBWTUEsIGFuZCBp
biBhZGRpdGlvbiwNCj4gPiA+IG1lcmdlDQo+ID4gPiB0aGUNCj4gPiA+IHNhdmVkLWRpcnR5IGJp
dCBpbnRvIHRoZSBkaXJ0eSBiaXQuDQo+ID4gPiANCj4gPiA+IHB0ZV9tb2RpZnkoKSBhbmQgbWtf
cHRlKCkgLi4uLiB3b3VsZCByZXF1aXJlIG1vcmUgdGhvdWdodCAuLi4NCj4gPiANCj4gPiBOb3Qg
c3VyZSBJJ20gZm9sbG93aW5nIHdoYXQgdGhlIG1rX3B0ZSgpIHByb2JsZW0gd291bGQgYmUuIFlv
dSBtZWFuDQo+ID4gaWYNCj4gPiBXcml0ZT0wLERpcnR5PTEgaXMgbWFudWFsbHkgYWRkZWQgdG8g
dGhlIHByb3Q/DQo+ID4gDQo+ID4gU2hvdWxkbid0IHBlb3BsZSBnZW5lcmFsbHkgdXNlIHRoZSBw
dGVfbWt3cml0ZSgpIGhlbHBlcnMgdW5sZXNzDQo+ID4gdGhleQ0KPiA+IGFyZSBkcmF3aW5nIGZy
b20gYSBwcm90IHRoYXQgd2FzIGFscmVhZHkgY3JlYXRlZCB3aXRoIHRoZSBoZWxwZXJzDQo+ID4g
b3INCj4gPiB2bV9nZXRfcGFnZV9wcm90KCk/DQo+IA0KPiBwdGVfbWt3cml0ZSgpIGlzIG1vc3Rs
eSBvbmx5IHVzZWQgKGV4Y2VwdCBmb3Igd3JpdGVub3RpZnkgLi4uKSBmb3IgDQo+IE1BUF9QUklW
QVRFIG1lbW9yeSAoIkNPVy1hYmxlIikuIEZvciBNQVBfU0hBUkVEIG1lbW9yeSwgDQo+IHZtYS0+
dm1fcGFnZV9wcm90IGluIGEgVk1fV1JJVEUgbWFwcGluZyBhbHJlYWR5IGNvbnRhaW5zIHRoZSB3
cml0ZSANCj4gcGVybWlzc2lvbnMuIHB0ZV9ta3dyaXRlKCkgaXMgbm90IG5lY2Vzc2FyeSAoYWdh
aW4sIHVubGVzcw0KPiB3cml0ZW5vdGlmeSANCj4gaXMgYWN0aXZlKS4NCg0KT2gsIGludGVyZXN0
aW5nLg0KDQo+IA0KPiBJIGFzc3VtZSBzaHN0ayBWTUFzIGRvbid0IGFwcGx5IHRvIE1BUF9TSEFS
RUQgVk1Bcywgd2hpY2ggaXMgd2h5IHlvdSANCj4gZGlkbid0IHN0dW1ibGUgb3ZlciB0aGF0IGlz
c3VlIHlldD8gQmVjYXVzZSBJIGRvbid0IHNlZSBob3cgaXQgY291bGQgDQo+IHdvcmsgd2l0aCBN
QVBfU0hBUkVEIFZNQXMuDQoNClllcCwgaXQgZG9lc24ndCBzdXBwb3J0IE1BUF9TSEFSRUQuDQoN
Cj4gDQo+IA0KPiBUaGUgb3RoZXIgdGhpbmcgSSBoYWQgaW4gbWluZCB3YXMgdGhhdCB3ZSBoYXZl
IHRvIG1ha2Ugc3VyZSB0aGF0DQo+IHdlJ3JlIA0KPiBub3QgYWNjaWRlbnRhbGx5IHNldHRpbmcg
IldyaXRlPTAsRGlydHk9MSIgaW4gbWtfcHRlKCkgLw0KPiBwdGVfbW9kaWZ5KCkuDQo+IA0KPiBB
c3N1bWUgd2UgaGFkIGEgIldyaXRlPTEsRGlydHk9MSIgUFRFLCBhbmQgd2UgZWZmZWN0aXZlbHkg
d3Jwcm90ZWN0IA0KPiB1c2luZyBwdGVfbW9kaWZ5KCksIHdlIGhhdmUgdG8gbWFrZSBzdXJlIHRv
IG1vdmUgdGhlIGRpcnR5IGJpdCB0bw0KPiB0aGUgDQo+IHNhdmVkX2RpcnR5IGJpdC4NCg0KRm9y
IHRoZSBta19wdGUoKSBjYXNlLCBJIGRvbid0IHRoaW5rIGEgV3JpdGU9MCxEaXJ0eT0xIHByb3Qg
Y291bGQgY29tZQ0KZnJvbSBhbnl3aGVyZS4gSSBndWVzcyB0aGUgTUFQX1NIQVJFRCBjYXNlIGlz
IGEgbGl0dGxlIGxlc3MgYm91bmRlZC4gV2UNCmNvdWxkIG1heWJlIGFkZCBhIHdhcm5pbmcgZm9y
IHRoaXMgY2FzZS4NCg0KRm9yIHRoZSBwdGVfbW9kaWZ5KCkgY2FzZSwgdGhpcyBkb2VzIGhhcHBl
bi4gVGhlcmUgYXJlIHR3byBzY2VuYXJpb3MNCmNvbnNpZGVyZWQ6DQoxLiBBIFdyaXRlPTAsRGly
dHk9MCBQVEUgaXMgbWFkZSBkaXJ0eS4gVGhpcyBjYW4ndCBoYXBwZW4gdG9kYXkgYXMNCkRpcnR5
IGlzIGZpbHRlcmVkIHZpYSBfUEFHRV9DSEdfTUFTSy4gQmFzaWNhbGx5IHB0ZV9tb2RpZnkoKSBk
b2Vzbid0DQpzdXBwb3J0IGl0Lg0KMi4gQSBXcml0ZT0xLERpcnR5PTEgUFRFIGdldHMgd3JpdGUg
cHJvdGVjdGVkLiBUaGlzIGRvZXMgaGFwcGVuIGJlY2F1c2UNCnRoZSBXcml0ZT0wIHByb3QgY29t
ZXMgZnJvbSBwcm90ZWN0aW9uX21hcCwgYW5kIHB0ZV9tb2RpZnkoKSB3b3VsZA0KbGVhdmUgdGhl
IERpcnR5PTEgYml0IGFsb25lLiBUaGUgbWFpbiBjYXNlIEkga25vdyBvZiBpcyBtcHJvdGVjdCgp
LiBJdA0KaXMgaGFuZGxlZCBieSBjaGFuZ2VzIHRvIHB0ZV9tb2RpZnkoKSBieSBkb2luZyB0aGUg
RGlydHktPlNvZnREaXJ0eQ0KZml4dXAgaWYgbmVlZGVkLg0KDQpTbyBwdGVfbW9kaWZ5KClzIGpv
YiBzaG91bGQgbm90IGJlIHRvbyB0cmlja3kuIFdoYXQgeW91IGNhbid0IGRvIHdpdGgNCml0IHRo
b3VnaCwgaXMgY3JlYXRlIHNoYWRvdyBzdGFjayBQVEVzLiBCdXQgaXQgaXMgb2sgZm9yIG91ciB1
c2VzDQpiZWNhdXNlIG9mIHRoZSBleHBsaWNpdCBta3dyaXRlKCkuDQoNCj4gDQo+ID4gSSB0aGlu
ayB0aGV5IGNhbid0IG1hbnVhbGx5IGNyZWF0ZSBwcm90J3MgZnJvbSBiaXRzDQo+ID4gaW4gY29y
ZSBtbSBjb2RlLCByaWdodD8gQW5kIHg4NiBhcmNoIGNvZGUgYWxyZWFkeSBoYXMgdG8gYmUgYXdh
cmUNCj4gPiBvZg0KPiA+IHNoYWRvdyBzdGFjay4gSXQncyBhIGJpdCBvZiBhbiBhc3N1bXB0aW9u
IEkgZ3Vlc3MsIGJ1dCBJIHRoaW5rDQo+ID4gbWF5YmUNCj4gPiBub3QgdG9vIGNyYXp5IG9mIG9u
ZT8NCj4gDQo+IEkgdGhpbmsgdGhhdCdzIHRydWUuIEFyY2ggY29kZSBpcyBzdXBwb3NlZCB0byBk
ZWFsIHdpdGggdGhhdCBJSVJDLg0KPiANCj4gPiANCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBGdXJ0
aGVyLCBwdGVwX21vZGlmeV9wcm90X2NvbW1pdCgpIG1pZ2h0IGhhdmUgdG8gYmUgYWRqdXN0ZWQg
dG8NCj4gPiA+IHByb3Blcmx5DQo+ID4gPiBmbHVzaCBpbiBhbGwgcmVsZXZhbnQgY2FzZXMgSUlS
Qy4NCj4gPiANCj4gPiBTb3JyeSwgSSdtIG5vdCBmb2xsb3dpbmcuIENhbiB5b3UgZWxhYm9yYXRl
PyBUaGVyZSBpcyBhbiBhZGp1c3RtZW50DQo+ID4gbWFkZSBpbiBwdGVfZmxhZ3NfbmVlZF9mbHVz
aCgpLg0KPiANCj4gTm90ZSB0aGF0IEkgZGlkIG5vdCBmdWxseSByZXZpZXcgYWxsIGJpdHMgb2Yg
dGhpcyBwYXRjaCBzZXQsIGp1c3QgDQo+IHRocm93aW5nIG91dCB3aGF0IHdhcyBvbiBteSBtaW5k
LiBJZiBhbHJlYWR5IGhhbmRsZWQsIGdyZWF0Lg0KPiANCj4gPiANCj4gPiA+IA0KPiA+ID4gPiAN
Cj4gPiA+ID4geDg2J3MgcHRlX21rd3JpdGUoKSB3b3VsZCB0aGVuIGJlIHByZXR0eSBjbG9zZSB0
bw0KPiA+ID4gPiBtYXliZV9ta3dyaXRlKCksDQo+ID4gPiA+IGJ1dA0KPiA+ID4gPiBtYXliZSBp
dCBjb3VsZCBhZGRpdGlvbmFsbHkgd2FybiBpZiB0aGUgdm1hIGlzIG5vdCB3cml0YWJsZS4gSXQN
Cj4gPiA+ID4gYWxzbw0KPiA+ID4gPiBzZWVtcyBtb3JlIGFsaWduZWQgd2l0aCB5b3VyIGNoYW5n
ZXMgdG8gc3RvcCB0YWtpbmcgaGludHMgZnJvbQ0KPiA+ID4gPiBQVEUNCj4gPiA+ID4gYml0cw0K
PiA+ID4gPiBhbmQganVzdCBsb29rIGF0IHRoZSBWTUE/IChJJ20gdGhpbmtpbmcgYWJvdXQgdGhl
IGRyb3BwaW5nIG9mDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiBkaXJ0eQ0KPiA+ID4gPiBjaGVjayBp
biBHVVAgYW5kIGRyb3BwaW5nIHB0ZV9zYXZlZF93cml0ZSgpKQ0KPiA+ID4gDQo+ID4gPiBUaGUg
c29mdC1zaHN0ayBiaXQgd291bGRuJ3QgYmUgYSBoaW50LCBpdCB3b3VsZCBiZSBsb2dpY2FsbHkN
Cj4gPiA+IGNoYW5naW5nDQo+ID4gPiB0aGUgInR5cGUiIG9mIHRoZSBQVEUgc3VjaCB0aGF0IGFu
eSBvdGhlciBQVEUgZnVuY3Rpb25zIGNhbiBkbw0KPiA+ID4gdGhlDQo+ID4gPiByaWdodA0KPiA+
ID4gdGhpbmcgd2l0aG91dCBoYXZpbmcgdG8gY29uc3VtZSB0aGUgVk1BLg0KPiA+IA0KPiA+IFll
YSwgdHJ1ZS4NCj4gPiANCj4gPiBUaGFua3MgZm9yIHlvdXIgY29tbWVudHMgYW5kIGlkZWFzIGhl
cmUsIEknbGwgZ2l2ZSB0aGU6DQo+ID4gcHRlX3QgcHRlX21rd3JpdGUoc3RydWN0IHZtX2FyZWFf
c3RydWN0ICp2bWEsIHB0ZV90IHB0ZSkNCj4gPiAuLi5zb2x1dGlvbiBhIHRyeS4NCj4gDQo+IEdv
b2QhDQo+IA0K
