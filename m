Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D05F62AF99
	for <lists+linux-arch@lfdr.de>; Wed, 16 Nov 2022 00:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiKOXm4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Nov 2022 18:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiKOXmz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Nov 2022 18:42:55 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A438DBCBD;
        Tue, 15 Nov 2022 15:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668555773; x=1700091773;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qRwoGQj1H/uKlqOo0BpfQfQ7lVaGcQc6lNvz1FpDQ4w=;
  b=crLibVY2Pww2eDMQIKefSEfFzOoZrZhVZMZBwin68Ew8J9uHR3mTFuJV
   cnrhkidRykm8G7Zx/QUJaU2/uJoezLtoAO+6WDfs5AbbWMdWuKLzPl3OR
   kNZ1LczgoPfjbjtHkEokRV5hcTzbtPRB+q7RNHwV14n7k2kF9OMKzTVSC
   WiF3puW8JmDZ2YMK941LeaVW0kIHFzSvxx2szYD7pitJ1dMhI6ZESIrag
   GyePGKSeTIpoO9bkJsPlXTRrX2lHYUupJLOH++GB6RMXemOu1gUKFMjaw
   ZFfPBxObMN2DC4/AFXeQ+1bLVrTO1ZkBM3ncu1x1gBrWNU/s8+PhXNHk4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="312404172"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="312404172"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 15:42:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="672179770"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="672179770"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 15 Nov 2022 15:42:52 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 15:42:51 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 15:42:51 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 15:42:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nB6PJy3fk7j/NJtDmEBds+sU8W62gECGo8q6me1iwmeafImhaphv46whS9DeP+DyFwYkWCqg4RPAW0JwclPF0iqpfJlVNUfXDp8s00ZnGhAlJRDo0VZ1GVJeC+eBnsESEzG9w9g4mDYUiW8KO12c34IuLEv8zzg0ww9E9z3LZwmls6CNKY7YtTlu1oe0XvhRDqMqH6GrR7PbDGGmWSu9qiGZdgj2W+CVIvTezlD/jaPeU/WuO8oPd62IMvqaO7t75biWS6fDwgs/uLye6LEUbRjYsaX98I0wcSKUIdjnqatSiG7mAlNj6GqGTVGOh0QaQMSVrjO5vL4uzZCSwVjKBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRwoGQj1H/uKlqOo0BpfQfQ7lVaGcQc6lNvz1FpDQ4w=;
 b=j8/omycJQV2uJrybAsQtrbR+BjCLelUIsHnWkaSCA/j2dSrm0DLsCrTzZObb6K2MpLpzn1rk0pkRTAlLr/Nv9wrnVZJbZJbSj/vZnzJ72k1Z5arRz3YrMAVXOPdcuTUlENh4zfRh2RXaOUbOJVPG6yP//l5mJyM/SQstV1OW1uS+Lch1xDt+223uLLJAa99AxQ64M/NvkpSX3vNwC/6I26Q7bOdWrEkki/lU3PWJ1o1/ltXzYrA1u5U1DvWIjLqVpo9EYnWYvhuOu6aulqnNh9t2r76t3+RLvX8R5j0pBkODraNrrp+UfBhu7jgrGL9THTq3gJK8M9snRw/bk0yIkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SA2PR11MB4905.namprd11.prod.outlook.com (2603:10b6:806:117::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 23:42:46 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3%5]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 23:42:46 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
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
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 27/37] x86/shstk: Introduce routines modifying shstk
Thread-Topic: [PATCH v3 27/37] x86/shstk: Introduce routines modifying shstk
Thread-Index: AQHY8J5fUoAN1KmpVkaYCSerQ8NxVK5AGQKAgACdrIA=
Date:   Tue, 15 Nov 2022 23:42:46 +0000
Message-ID: <be65a66baf94cebf0bc8d726a704238787195837.camel@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
         <20221104223604.29615-28-rick.p.edgecombe@intel.com>
         <Y3OfsZI0jFRoUw02@hirez.programming.kicks-ass.net>
In-Reply-To: <Y3OfsZI0jFRoUw02@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SA2PR11MB4905:EE_
x-ms-office365-filtering-correlation-id: e3e0d44c-47ac-4d25-2615-08dac763192e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Le7kUY0Jb3P5whfWZzcex7jFA08LTlQMbM6IPQdS0PoxiF/cIiCViK/86Hn2OmPMOYB/LThz9Vl/SEVaybkalngsovsyrYjwnMb2M4ld2VZuJLAv7G2TMyNaF5O9wA8K8oHRo5wYtkTaN6OqmAdn16a/DNX8izXMRmYi+9/Q3R1Dv2OZ8GSeexB6Za4or+fIvXMTbXxG8qeZIayU86dNFQOpiDuDBMs5TqXCc1YP5eUORYFZsTQlRL7wY4qEdrw3dZZLr+lvYDN9jPCobyLwWPUDB43Y3lC7HB6iE52IKJxUuVDjpUc5p6S6L9NA/XMc2K1Qz68ThfwkJV8OhD4Dzuh1a1JnZE1O9ozdKZwlvHvZzoLA+Otso6XT8Klf9IRaG4YIwfcMU+gB0mgTxqpJw2h1qy7tG2MXt2QPmJq5spJczAdldmG/RopFbh9IzMzLmZ6b60HvyakoG4pdyHuygw/3lyhefzWr20gr+kglmgoqa9oaZJB7ZtScwjLnDiAd8lq+uTjerZp3fvtHN7SQ6XNCN4W0GMK3JtFkO4Gpv7qTp7belqt0m6fPr2o2sZIIdiDAMKu0MRwExb/Y/kvNvbxyF0Pl7RkSSUAC4dI3GXYbHr7Oa32zejQKr6wCG4HgXe4V0Q6gk8uRiN1BvZ9qQnUI6FtJAlByV8BajGEJ8vj5JFQQmZnlRhhaXrdMxC8JItoL0wmXRcXNcCQLx4fldXF2O/VGj/syPZOgky77ZNbGKqQU3eO5j7uYqO68hwGuGsG5ljdTmmQX4WZkL3Wvdvme4LKO/FabHfd4VuoTVDs7DRZcFRgnPID5CiUWgVya
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199015)(316002)(26005)(66446008)(5660300002)(186003)(2616005)(36756003)(7406005)(7416002)(8936002)(41300700001)(76116006)(8676002)(4001150100001)(91956017)(2906002)(6512007)(66946007)(66556008)(4326008)(66476007)(64756008)(82960400001)(86362001)(38070700005)(122000001)(38100700002)(83380400001)(71200400001)(478600001)(6916009)(54906003)(6506007)(6486002)(99106002)(17423001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVVkQ1VFZG5MYkZQdHNTdWlzdW9vcHJRM3IwYS9YUGRlM2lTYlBqMFQ2VWor?=
 =?utf-8?B?aW00NktpSXN0SGErZ2ZQT0tNWU96eW1YQXRmZk0xdmxDcHdHYkxMaUh6Z2FO?=
 =?utf-8?B?d1JQRTNaeGx3MXh5NmVhdG9nZmR1ZkgweUZsU0lkSmMyNENUQjF0eGJQcGNK?=
 =?utf-8?B?VnRrOXA4MCtnbzY1RTZWNGFEZGxwNE1yMHBDM0JyZFlxQUFUT3R5YklUTE45?=
 =?utf-8?B?TXozRjRDZ0RhUVF3Q1RER2FQM2xWek9vYjRvNVVzN1ZZWnE3RDcrcmI3NGJZ?=
 =?utf-8?B?YzZkd0NpbzRJb0wwb1B0RW0xbGpwcmgyRTdvNVlpTmxFb3Jzc00vbUdYTzBk?=
 =?utf-8?B?d2ZRQU1QL0MrZ2FaaE45dTE2TlFKTkNVUlRCUW16Y1RuelJ0Q3pudWl1MzNs?=
 =?utf-8?B?MTRNTVlPS2pMTkI1cnBhTFZJc2ZiK09rdnFDNEN6UTYwYXk5a2Z4ZUlGbldj?=
 =?utf-8?B?Ri96a3R6UWxZcWpFc01OV3dCWHZDcFNwZ3JYa1Q1czlEWWNSR0JxdTZ3bFVo?=
 =?utf-8?B?Uk5BeXZxalFHNDE4QnJPRHczQzZONER3a0VQbkRBMGd0MUZXUWZZbFViYmVo?=
 =?utf-8?B?aEpMMURUUStPRHZPa05OaUdlVDBJSE9FdDhBNXgzRFREcFBsUWFlWWFpSCtz?=
 =?utf-8?B?czU1cHVqaVloUEo2RC9vNkFqRjcrYW1WaWNzanlLNUhxTlk0dkMxcHlaWlpC?=
 =?utf-8?B?UlFHalBwOGZTM2dtVUtVRjhYTDMzdEh2RVlac0o5Qmp0KzY1Unp6dStDMHNu?=
 =?utf-8?B?dFgwWWhzdDRXYlZrZEF2UEk3ZkZaRlAxYVc4cEg0UFhYUlhQbncrRlljb01M?=
 =?utf-8?B?bTlFVUFVbTk4b0xqYTVUUXN4NkZvT2x1ZlVBWnhINzNLMEZ1RUVJRWZIRVh3?=
 =?utf-8?B?cnFCZXZPTXl0VjNPSEhBcHBYaWR6ZWVFaEdpMlRGSEhnSVd3UHBRVnFtYVFY?=
 =?utf-8?B?b2pSeC85R0RpcHdsZWR4ZEhQZFZ4WmpBbzZhS3dDUHg2VVVsZG1mbjcxZVVN?=
 =?utf-8?B?WHhTdjdhU3hiMlRHeWt6eFpXa0FQKzhkcittQzhibHFHWEQzbHV4K01CRkdO?=
 =?utf-8?B?RC81LzdwTTF0L2FnZzRUaXhYZXE0VVBUMTl0dUIxaXM1QTBya1ZGU1pRWVFp?=
 =?utf-8?B?WUJsMUVZemt6ekI5NDFXMmlBUUdVeGx2RFNyaW8zaW02WEc4OWk3dytRSDZR?=
 =?utf-8?B?bkpaY3lyclRhMjE2SG83aGVmQmJhNVNmWXU1MHBjaDhEd2dpY1FVMlBmYXFB?=
 =?utf-8?B?YTZkSW9aWVl4cUNPSVF1RkQvNExLWXI1MWpLSFU0K3NqTTVkWE5MZEJhQ05m?=
 =?utf-8?B?RnVLWDZDcDV1R090amZRdmxQdFZIU0dkbDQyS1dsUDlLblBRVEtIcWFWNElM?=
 =?utf-8?B?ZnZhbm9mQUVaNE5BUVo2Sjg0MExITWZLcU1tNkc2MDh0NTkwUUZNK2lPN1NU?=
 =?utf-8?B?STBJMlRqTHdLNjZ1QU1WWngrSGUwbE8rQXg1cmZvbDFEeTBTTkx1eEFBRGtC?=
 =?utf-8?B?VGdlMlZxWXBaMjVkZTRXYzBheFNVTWtNRG9OUHN6djRjdS81aC92NGM4M1VY?=
 =?utf-8?B?dFhNQmJ1NHArd2tUTEpsaVowQlR3anQrYmdSTmdsdWo2NDlmbmpaL0Vqb2h5?=
 =?utf-8?B?RDY4SzBsQnpvRE9ablRBNStIc1VhQWZ6NHRyb1hTTWpZOVhYekFqMm96SVM5?=
 =?utf-8?B?U1JtOWpveS9uT1BNb2d4TjVlelAzVGpOTko0RTlxZndXcDhHL1JEejhOM2tB?=
 =?utf-8?B?VU9PQkxoZlRXWndZa1pDZjNSbDN3c2trcXd3YXo5WkNlaTVSMWNHcit3NEZR?=
 =?utf-8?B?T0tyNFhiNUJ2clpxVERQTEprU1Azd3pHbjVyY29zUmoycjE1ZzRCV20xNUFK?=
 =?utf-8?B?V2RmcmV1R0hTN0QwejZKSWRtWHNla0ZvLzlmdGY4d2hvRmRXRWd4cVV4S05N?=
 =?utf-8?B?MHQyNytmNGRKUWZMNzNMemF4ODNXSDBqcjByODFoNEdSdDJ2Y2txTXhnOUtZ?=
 =?utf-8?B?QWZQbTluRFZhS1NhTzVVaDVBTDlZd2ZjMXZhQ0FsaEZkcjVrOHduNW41MTJC?=
 =?utf-8?B?MXBZNzM4QXcvbVVkanVneTZJS2tlSTBhR1hOZ29HWS9wZFpxL2RHcjVZMUs3?=
 =?utf-8?B?eEFEOTJseXZvdm5Va3RBdCs0UFd3UmdmNXdhNkxHRnY3bUVJQ1NCN3JjeU5L?=
 =?utf-8?Q?koC36fCw2Fqm7t8UA8XbR+c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E2D28A7D7C7C046BED9454A3DECFDAA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e0d44c-47ac-4d25-2615-08dac763192e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 23:42:46.4022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xNf4rtg9jM5djsX0+L4yGJCTqPS2ZC2hgVbuzEZSxTHkypdbSDtQd0rMi48yu+3UYbVrwdcbDPPx8YiSn4f/8NjDkiuCt/uzKSZD15HjCH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4905
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTE1IGF0IDE1OjE4ICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gRnJpLCBOb3YgMDQsIDIwMjIgYXQgMDM6MzU6NTRQTSAtMDcwMCwgUmljayBFZGdlY29t
YmUgd3JvdGU6DQo+IA0KPiA+ICsjaWZkZWYgQ09ORklHX1g4Nl9VU0VSX1NIQURPV19TVEFDSw0K
PiA+ICtzdGF0aWMgaW5saW5lIGludCB3cml0ZV91c2VyX3Noc3RrXzY0KHU2NCBfX3VzZXIgKmFk
ZHIsIHU2NCB2YWwpDQo+ID4gK3sNCj4gPiArICAgICBhc21fdm9sYXRpbGVfZ290bygiMTogd3J1
c3NxICVbdmFsXSwgKCVbYWRkcl0pXG4iDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgX0FT
TV9FWFRBQkxFKDFiLCAlbFtmYWlsXSkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICA6OiBb
YWRkcl0gInIiIChhZGRyKSwgW3ZhbF0gInIiICh2YWwpDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgOjogZmFpbCk7DQo+ID4gKyAgICAgcmV0dXJuIDA7DQo+ID4gK2ZhaWw6DQo+ID4gKyAg
ICAgcmV0dXJuIC1FRkFVTFQ7DQo+ID4gK30NCj4gPiArI2VuZGlmIC8qIENPTkZJR19YODZfVVNF
Ul9TSEFET1dfU1RBQ0sgKi8NCj4gDQo+IFdoeSBpc24ndCB0aGlzIG1vZGVsbGVkIGFmdGVyIHB1
dF91c2VyKCkgPw0KDQpZb3UgbWVhbiBhcyBmYXIgYXMgc3VwcG9ydGluZyBtdWx0aXBsZSBzaXpl
cz8gSXQganVzdCBpc24ndCByZWFsbHkNCm5lZWRlZCB5ZXQuIFdlIGFyZSBvbmx5IHdyaXRpbmcg
c2luZ2xlIGZyYW1lcy4gSSBzdXBwb3NlIGl0IG1pZ2h0IG1ha2UNCm1vcmUgc2Vuc2Ugd2l0aCB0
aGUgYWx0IHNoYWRvdyBzdGFjayBzdXBwb3J0LCBidXQgdGhhdCBpcyBkcm9wcGVkIGZvcg0Kbm93
Lg0KDQpUaGUgb3RoZXIgZGlmZmVyZW5jZSBoZXJlIGlzIHRoYXQgV1JVU1MgaXMgYSB3ZWlyZCBp
bnN0cnVjdGlvbiB0aGF0IGlzDQp0cmVhdGVkIGFzIGEgdXNlciBhY2Nlc3MgZXZlbiBpZiBpdCBj
b21lcyBmcm9tIHRoZSBrZXJuZWwgbW9kZS4gU28gaXQncw0KZG9lc24ndCBuZWVkIHRvIHN0YWMv
Y2xhYy4NCg0KPiANCj4gU2hvdWxkIHlvdSB3cml0ZSBhIDY0Yml0IHZhbHVlIGV2ZW4gaWYgdGhl
IHRhc2sgcmVjZWl2aW5nIGEgc2lnbmFsIGlzDQo+IDMyYml0ID8NCg0KMzIgYml0IHN1cHBvcnQg
d2FzIGFsc28gZHJvcHBlZC4NCg==
