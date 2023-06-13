Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD1B72E86A
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 18:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242814AbjFMQWg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 12:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240290AbjFMQWf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 12:22:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E42E4A;
        Tue, 13 Jun 2023 09:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686673331; x=1718209331;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Am2rh5aD4FsvdKjKq80ZYt+IjZr26KIbUkJDR5nglZ4=;
  b=mEY6uir7rPsxYVzi9mHp4NSS2TC+FNlqIVxL43HvHQUA4NiwyycDQ4se
   eCrgWiik51dfDXr3r+okZ6QgOUQ/NQu8kKAQ2oHd1MFyhiNjfVgIM01HA
   AfNl2eiy44C+Grx6GD2qvo6BZ0Aoy+N3HAp++RFz1hIbnoa4uU5w1yZp6
   ffXBy2sQKKljJrVWLIYDHQd+cLCDD2+xT5J9V0YRGI+t1IXPrtW24G0a7
   u5cqPEoQIgFzLhiF1Tw2IeZ5YgoyGjQti5Z7+6XRk5BQ/yCy12AcNt3mK
   6iZIv5wabsC6VZuvYS8W0V9xl0Nty1NkL5O4IppbLP46fw2EKrNDZYC7D
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="343073481"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="343073481"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 09:22:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="885907026"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="885907026"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 13 Jun 2023 09:22:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 09:22:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 09:22:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 09:22:02 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 09:22:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asOxeCY6RsFgtE/NHNj+QA+FHuyJx+PWeW+4ZFy7bvalLZsA1JBPSHCq2cbdp7ZP9sAbqSiGYdSrA/p2hlD86o7WaS8fU6tSF/smKpeAVZeIkFerbxLOiuzHv8wAQYFVsOCBcLTFBR8cFx3njrimhKpEO5xWUt+WsrDdAkiENDeLryXxodcGdzUtDcDWJbL0H8dgT6P85GfdOOBsXhvIrZjVxUNJbFLgD5/hwkcVExmTgsG30E7ea3JprE8UNKZyQUHJWXw6PxvMUf0T+OwdlG8IE4nyF9wrZwQ+we5nyBPAMejsRrTYQ+jkCs9Wx4VhaokzxnextdRw8MATwgkNog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Am2rh5aD4FsvdKjKq80ZYt+IjZr26KIbUkJDR5nglZ4=;
 b=TPEJNC8OVWMtcWF1N770jPugxrxY7k87lrc4k1W9RR6LTTYEcYUnmf4eypj+Kn9BVMik9W+uuJImaPunHIMmedeEuwv8dP7/zDCZaZbG5KYqhXNN8Hze3rqLRjMTFeu7vEl+V3GrbZOe04bToDHJjMradunE0xrkQ6SFnOMcsSG+WAxfRQ2FvnGs1hzRFxYw+896OpcuibV0Z50cosdhQW889xjFp0pTI6PQSkvC4IRJWH/3v5WBBYFscDU4dKncfpUPSR5tT7bYwwXdeeDQubmsinXGeKp7zQ4u0uhLJ//ho5W4XfrSOCQ+GUFFBP+JuFKFrnI3YX+l7uwkwj4zNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.29; Tue, 13 Jun 2023 16:21:58 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 16:21:58 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 03/42] mm: Make pte_mkwrite() take a VMA
Thread-Topic: [PATCH v9 03/42] mm: Make pte_mkwrite() take a VMA
Thread-Index: AQHZnYvLI3qZgQAfOkuOCJG2PT9bba+IqfOAgABBTwA=
Date:   Tue, 13 Jun 2023 16:21:58 +0000
Message-ID: <ba9b5ab8670205986e42fdb489a66d1e836e705d.camel@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
         <20230613001108.3040476-4-rick.p.edgecombe@intel.com>
         <65805965-c6a2-ce0c-fb11-5277e5976120@redhat.com>
In-Reply-To: <65805965-c6a2-ce0c-fb11-5277e5976120@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DM8PR11MB5573:EE_
x-ms-office365-filtering-correlation-id: 08fb2a4d-7fb6-4f25-81c2-08db6c2a4fee
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pg1Q+FQZ+Xz4xR2Azxb/vRw4ejl8BV9RoNIaDBe1ZQPEr3o12bAQydECU+qgsN61S6seP4csz6E3IGS+AkoO8zP+Rt4rDb3arjrBnwXzEyn0AS2UAMy+e60SKOAXCKeSASDnGPohUWJwSk8420m0nq4YnfWFQlooPdABucOpYqttsOZ8i1CEGxJUHdV4vL20zNmK2581wFHFfpInQyBW0D+wLzUzfKEInaXNaXF+uScQrDHCb/ycaA4Kz5TKLzD3F0mvWHSUnNDz48tpjfdILmyewf00HezFzVuoKLT4mIpMHrQboapO/9aCYDYtMtkw6gKiF34GjwOCD13qFmzP3fAJqdl+LcmRc7L6j9/GkHKy1jLr9NEi4TAH5JulPN5WXubQu+g0aeKw68+ecj30u8TR+DjqAbrFKX1iQL2umXqSvUkkil7YjVucxshNQq2RyoqEmm28p+enfocymzqGBewUlYGko2mzmLegWUWhu/kq1sEBGWLpMEnprQOjCXfskECZ6xnh2EVp6CLgOklgKTXaFEuPq60Bt8bDeRflZUmsu0l3vIZijVxg32i8E5ZM1+5yWF46x7nFTT3spsxTMR7hP3TK8B1c3COB7bLHWduLTTuAGxWdmFHnBewGOFOW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199021)(66946007)(76116006)(91956017)(66446008)(66556008)(64756008)(36756003)(186003)(478600001)(110136005)(2616005)(2906002)(66476007)(8676002)(316002)(41300700001)(86362001)(6486002)(7406005)(7416002)(921005)(6506007)(558084003)(38070700005)(122000001)(71200400001)(8936002)(82960400001)(26005)(5660300002)(38100700002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHI5b0NkbHVCMUFDOHZtTWF4UFd3d1BvUXZzZEJrMytqb3lGUGRzQjIwNVVm?=
 =?utf-8?B?OWZybFlyUEJVQk91UnJ1Y084dUo4U0dhaVo1K0FpUTFXL0NpanQ2Vlhra0Nz?=
 =?utf-8?B?Y2FwMjkyMFZvQWV3VWZQUGk3MFBoT1RzV1pwNFZCV3hxQTRhc05pUURFYUZX?=
 =?utf-8?B?RmZYM0tEZE5NOEZzd0J3akdrSmZMMFUwZ2NyNHh6Zis5R1psRTJ4TXhCTmYr?=
 =?utf-8?B?VFFUdldtRTJTZEtMdU8zN1lEV2NCSmQ4cmFUc0ZiWkI4eXVLVGVoSFRsYnVQ?=
 =?utf-8?B?VnlORHYyRW8zYWdjNjBZZzJSMHNJMTN1d21tZG11Mzk1ZHh2clhMOTE2cDMz?=
 =?utf-8?B?QjdsQ0tzRnNwc212Y0N3dDE1SzdBVEpDM3lyQmhmQlVqZ1FYdFhNNE5CMy9H?=
 =?utf-8?B?azlPSWtqbmhndlV2RHdaK2k4ZXd4eHFtaVcyTnlybTFkQTkyTy9GQnNDdGxP?=
 =?utf-8?B?M2RieUROUGFmdXp5Nlo3YjhYYTYxUWFyK2Zmb2JmeGI0UjhNQXpGTGQ3bFYz?=
 =?utf-8?B?bE9Qc3R1TEt4ckVQbEZFSitRd0JJZDJGb0xLYUI4OHBPUGoxZk45dHBFdXRG?=
 =?utf-8?B?VDJUbzEvUkxqb0JvT0Z3TDI5WWZFNFNraEVvVmFNMFhQTUcvZkJ4VStRQzZy?=
 =?utf-8?B?cTc5NXJxd2pwbFpqc05mWEtPVEM4L3EzNTZkMmQ2SzloWVhISWFpM2c4VFpq?=
 =?utf-8?B?bEIrejdvTVBlUWlBbjVaaytVWGQ5eGdwVlVlR0U2WDQzVVRBV2hNb3g4dFY4?=
 =?utf-8?B?VEdaVXRyNDhrdW1jSjZRWVBDM3g5REl1NHREMHlmUW1BYjZMNXRmUThRdmlu?=
 =?utf-8?B?ZkRHRW9SSkNVd25rcUw3N2ZSd0lzYld3RjdHc2paZ2dYMjZxYjM4cVAxQXFr?=
 =?utf-8?B?TmgwRzFxcXpQU3cwYk95cG1URDY5LzJsMkRFTGhET3NLeTQ0RjZHVk5IMmJK?=
 =?utf-8?B?UGQ5Q1ZTMHVUQldFS3pzUHU5cXlTOEs2ZFpYenlHbGFaMFRqZjc2cmtLQ2xz?=
 =?utf-8?B?TkJmdWV3dUl4VGFRbWtFVDQyQklOOFpyQjVxaWVCd0Z0SlU4SXl5Z2xkMEo1?=
 =?utf-8?B?T1R6TTZWWjQvaCtnZXhTQzdZQVB0NVFWV3BjZFN1OXoxVndINGhTSjZYUGJz?=
 =?utf-8?B?TnZBbEZDNUE4aE1pV2pXSnliRlhQZzZWSkdnRXJhM2lHQ2YxNXBhZFdlRW13?=
 =?utf-8?B?SkNDL29Zd095N29pK1JzcmIxbHh0cmJqTUEwTnNTb2UxSWNOZG1GTzlaRW55?=
 =?utf-8?B?YjN2c0tqQ3RjcU4zK05jaGYvRXVFMktPblVhMGNzbmQraUsrTVNNNVRlTVRG?=
 =?utf-8?B?T1M5WmpJUSttRUpFQ2MvNk0wWnEyVktna3Uwb3lEL1Fab20zTzlRQ0ZTczZW?=
 =?utf-8?B?a3ZnVkdXR3pCQUE1Mm91a0tpTlBpbTZiWjl3N1pQdzIzbUlqYWpNSlB3VnZU?=
 =?utf-8?B?b1lTSUMxYXYzSVc5UHNXVkVTK1dDSFR6MzRTNXF2N01TaDgxei9VbFZVYVVX?=
 =?utf-8?B?OGxjT2E5T0JodWdacVV6WE1jczZQNjFRd1pxL2Vndmw3UmFqNm9hd1ZWMWJ1?=
 =?utf-8?B?SkloVjA4NmQ2UGlrQXBMVEU5cm5CMFRkbXJvSUJPaWRxZG9MM3B0RjlFL2Nz?=
 =?utf-8?B?U1lnb3E5NjVmVkY5UEJIUHlpOGVFM1Via24wMXViRnIwLzZWSlo5WEZJWGd5?=
 =?utf-8?B?eHIveWI0SVZyVVA2am1MZlM2cStHaDc5MlRLU0hzYjI3TVFFaXNKaklPZmdh?=
 =?utf-8?B?bCtqOVpNSHRpVS9Eb1l4Q3psaVc3TTVXV1FhUFVZbWNjOE9EWEIwRTZJR1Zy?=
 =?utf-8?B?ZTl0cXpuRkdlcllkVGlmVjZUZTl1ZDBjdXgvSXdQOTJvVTM0R3NxWUZVV2Fi?=
 =?utf-8?B?Q0RBdStaRTBJNWNITER4OWpaMHp0NDJHaUpsZ0xzODJySytBNlpxZGlZNWhL?=
 =?utf-8?B?M3Z3M1JRdUM0NkYvMkpERHk3ODNaV29JNlZJWUZQODdFY0R1cTk1RjlhdVd5?=
 =?utf-8?B?TDUzcFA5WGhhSUNpalg5T1cwK0gyV2xVR1VmcGVkeXdYRGhacDZEeWUwN1I1?=
 =?utf-8?B?TUV6MGlrVDRRSkNWRXgvZmhHU01TYzB4cjF1VDBlVUNzRVBzTFJlbDVsUXV3?=
 =?utf-8?B?bWg0L0t0V1BrcEtnVG5MbDlob3F3K2VhTm5lTXpYdVJJRHAxUjhlemZiT24z?=
 =?utf-8?B?d3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E22895A2D118CA47B837FB86C487BE34@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08fb2a4d-7fb6-4f25-81c2-08db6c2a4fee
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 16:21:58.8079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WF9QPoQ6Coj5HRIjscX6o1J/9w2FbZE34ov5ow+EU61Zm7fLfz6VVYKVcVcLPzEBhp2k+6SYk+BNscQyxc2HPyiSiH1SSg10hqIpZU7yT1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5573
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIzLTA2LTEzIGF0IDE0OjI4ICswMjAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gDQo+IEFja2VkLWJ5OiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4N
Cg0KVGhhbmtzIQ0KDQo+IA0KPiBIb3BlZnVsbHkgd2UnbGwgZ2V0IHRoaXMgbGFuZGVkIHNvb24g
OikNCg0KTWUgdG9vLiBUaGFua3MgZm9yIHlvdXIgaGVscCBvbiBjb21pbmcgdXAgd2l0aCB0aGUg
aWRlYSB0byBwYXNzIHRoZSBWTUENCmluLg0K
