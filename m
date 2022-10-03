Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC44B5F36B1
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 21:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiJCTub (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 15:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiJCTu3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 15:50:29 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237A41B9E0;
        Mon,  3 Oct 2022 12:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664826628; x=1696362628;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LIoZ91ceanE79Z8K70rhWC025m0RP5R+dUPNvM4gTT8=;
  b=F8myd76GcteQGTkFGUnGUeWOZKoqY6gIc0IjWcyvQJSij8trWmu/UToG
   MvmxK9e/7s9BlA46kNnAxEj3gPhQ1A3/SXh0YfeozqZE3oqZ6nJIdYdxp
   5iagCZatY8eRxpFaXQVYNHFNyoDOoQSMnVIcPmKwS4oTT5gL7ehCb5bJJ
   tACDA2VUWa16Fv0C/P4/vWYnPVF8/T88W+H3HEb5uUr465scykyHe/oDT
   qPjiFkpQuWfMGCS80wLQT7AJDPiVvV0BaK+xISX4BzC0ue+FYrhT0TfUh
   3gFDCWapkDcNuWMgneb2CHwvp/F1+dipsnL+14BYPNxGaiVFixwY+4U3D
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="300346757"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="300346757"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 12:50:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="623674539"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="623674539"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 03 Oct 2022 12:50:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 12:50:25 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 12:50:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 3 Oct 2022 12:50:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 3 Oct 2022 12:50:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsVdcxbgG7s39r+H/af3ybIDMO5Uwr+oCdai0TPwhdTozklqotkANIuwnF+oy2HAOR8pE6d3XaapH//tlkN9TIHGN3n6DSH9d0bXQHBJfefprMltBtahWkKSIzDxoWIctPS8s1C9ipZDYQxWMPhvMnAogrYaVt5cR+MCRzq1/5G8OZTFInzlDy7EFcXP+OPXK2hQPIKkAPAySkrRF+ziltxeWHs5/539YeFQynqipV4WxgEHFVyS+wUxTS7KA2WKilB9E9t3VfCf4598WPEk4sXRnz007jlzjFjN+EbllN55LIpwO+Y+SyEgzvLfbIEnK6i82HsoCyhbnJhZsUZQdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIoZ91ceanE79Z8K70rhWC025m0RP5R+dUPNvM4gTT8=;
 b=Na9iBfG4kUk1n6WlPn9dzriCToUTiTaY6c8Q4ZPkBnkeIy1O8YQRUr2kBPqRqafiRl3r6pAx4ZEL3HBNuD7yOdY2xIg2r0ayyozCOQ6Iy0SiMBqyfWy+m0CPI/jglUjdfKUZKtKVtaM5pch8zB1BQTkwxZpf55rJkgwYkz9nOYUE3SyXZ4OJfdCzFbRxqwMhyy/mq7YxfG15CrJu3aYlB8IddtmJc2cJMVSP8NCRGPx72VbDXbR/4HJhEywL+YuA1CLSpaSm4Ae0DayTN0p5JKPfGVNOsLGjmjp2D3Moo8OrVuRk5kfseIK8TQJXqfnbqt7t52VCCD5RNB4v9cqJ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SN7PR11MB6604.namprd11.prod.outlook.com (2603:10b6:806:270::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 3 Oct
 2022 19:50:17 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 19:50:17 +0000
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
Subject: Re: [PATCH v2 02/39] x86/cet/shstk: Add Kconfig option for Shadow
 Stack
Thread-Topic: [PATCH v2 02/39] x86/cet/shstk: Add Kconfig option for Shadow
 Stack
Thread-Index: AQHY1FMAO2++jn8eSkiiPpemqAqzVa39F9GAgAACQAA=
Date:   Mon, 3 Oct 2022 19:50:17 +0000
Message-ID: <3fa6ce91abbfa2a45308acc13df831d5497bfa7c.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-3-rick.p.edgecombe@intel.com>
         <18be9cae-91e7-c6f6-a5a7-ec7ceefa5523@intel.com>
In-Reply-To: <18be9cae-91e7-c6f6-a5a7-ec7ceefa5523@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SN7PR11MB6604:EE_
x-ms-office365-filtering-correlation-id: 9a873cb4-a437-40e5-6700-08daa5787f36
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ex62mBzHHMJMmgNKcmYeu26ZAoG4TP8IMcKiScg5pu0OuaQG/trNh4300G97LjOvYq17axX0fhyePPfBejse4DC4bGHxpUZGhUq2LhlrHQYqSaGgsa+AYgXsH8EB2MBGw3t3ODqTve7DpZEv0sTImyFvGuUVRUN2sl4ug0ibICn1YI+zkXL9crzFYssjAs9Ue4vYA6O4dxs2HTG5tCWSitLnoeFLpMlC8wVL62gnHHHBtITmkaON1XFwVym0HKQUeo4Ik/Z+Gbwb6WcOPgrHkQJStQhEGrFmnP0W2DGR4wh3ALFkH73pyFvUyz3JOQg/Zq2xiSHy4N1gN6SOdN20ierb3pJXR8XS1KdM3WpH6lkRRggQdIlC7SeiitFQ+C8yB5CcfT+KvpCaq7sNEfXDuhLDh3VybZeomApkDzu2GdK1n/mRFID5xBlQqKJsNOmFe3Su3z9kePiFbDffaSMUZQ26i7kYfXP9bBXwFKRzZVq53GxREw52TgAoU6xUZtA323CTFxrAhqWxdyTlAQ19jJmB0GXO8luhUtMem0dJqgFBMwW5z8tnbw7vSnVSND+qVdOr00F4eEv1J9ZpbAju+djvZDJdefsgBr8k3BfoxXYxYz+GYiiEwtZ3NakB/dTAbY51FbmtnjgS6FKW0evVFG8HRv3ugVeClOcynOdqrQ0/P8GtNfRB87h4C6XDATXMFwPBKozVoC2wjszHNHSuvxNnVGS+VmaF3V8oP56IQMIwZ5bqqrvMCZ4XPha7iT0pb/mVuCW/YhwUchqH5Cq3EEXcvWihrG6gHdxe6pyHcPLBEOtfQjXq2ZtdYmhbtFrM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199015)(38100700002)(122000001)(82960400001)(6512007)(7416002)(5660300002)(7406005)(6506007)(2616005)(186003)(2906002)(8936002)(921005)(36756003)(4744005)(110136005)(316002)(91956017)(71200400001)(41300700001)(6486002)(83380400001)(26005)(86362001)(478600001)(38070700005)(53546011)(66446008)(76116006)(66476007)(4326008)(66946007)(8676002)(66556008)(64756008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R01adlZ6b1VHNTdIUWR3Qk9Cc3hQUjRZbnd1bVAzbXVnaDFXMGlJN1pkNmdK?=
 =?utf-8?B?b2FUUjhqRUpuMzRyLytOK0cyelhVNjhqbUNtNnZ2TTFYRSsxbkRNa3NSYTdW?=
 =?utf-8?B?RG1qMlJJN2ZYa0VvQXIzbGZBTE9hM0tiUnFLd1NHQTNGc2pCZjV2TDdiYnJs?=
 =?utf-8?B?dnFxOVAwcjgzenJSb0FDTFJKNXBWRkFzQVhZMjErTmMrNk9SZ1A3K1kyTVc2?=
 =?utf-8?B?NXBHRFMrQTBBejZyYkh5UlBpRDZkL2hBL0tZeGF3MEVmTDhuK2k5anQxOWZw?=
 =?utf-8?B?aG1oZEM1WS83LzhXUkN0QzNIdkoySGhjNHRnNGt1STNoUGVGSFVUTVppblZM?=
 =?utf-8?B?SThWQlN2WEIxT0hQZGlZOFV0ZXBvdDlmZmVVWHBLL2hMMjlrakx3eVRkMk5V?=
 =?utf-8?B?RzRySlJpUkFUZDA0R3drcUN4M2QwSXFGc2x4bWg0K29vQ3pERG4zMU85dzc2?=
 =?utf-8?B?dkdPOFpycUxPaDBzVmdmL3hQdVl2d0F6eWUyK1NaSEs3NEZzTXJPcCtkVGNF?=
 =?utf-8?B?Y0U2YkQ1eFpvYkszM3VWcy9oT3dGT1lTMGI5VzJmd0c5c21rbGp3MlU3blhK?=
 =?utf-8?B?SHdCNks4UzYvd3ZaOHhYcnZzQzF2QWZCU2E0b0dzMUtGdjBhaWo0SmdydG9r?=
 =?utf-8?B?ZzBLVzYwRDQyRGRLOERxdGp3RVVLbWJ0OWFMOHZSeTVXWmVPcElvMCtuTFpL?=
 =?utf-8?B?TmZVUUhEcE1uTnRwN3pkNzhOc2FaWkI1bXcrNjk1c3VCd2RkRGFZNElRMnFa?=
 =?utf-8?B?ZFZNQVl0OG1kTGIvWFRaZklzM0dtbkltTGN2UHo1V2tBU0ZpMjd4OVQyWHZM?=
 =?utf-8?B?bkIvRXl1bjZnOVVoclQzRzNJREMwbms4V0tCNWExMm1BNm52TmVSSnZwRW0z?=
 =?utf-8?B?Z2pKUzZVWW10ODdMTkVlc1JOVC9yQXZRK1JqemdGc1FxQlhqQWhnOXRIVGg4?=
 =?utf-8?B?WWRVTzExZnZqVjd6K1N6bGlmbGlySGtpZTNQNnY5S2lTT1JqckVYYXdCRFpp?=
 =?utf-8?B?VldwczNyQjAxbDN0ZlRlbDJaZmhSbDNaQUJ4RXJabVNDRDJjdHFobFhUeTFB?=
 =?utf-8?B?QmpKSVljckNiNHNXalhXaEhldmtJRGZjZW0rRlN5OE00YzdjN3VSN3p0NS9I?=
 =?utf-8?B?bzcxMlJyMmtXeHdrQkJSckhMNjl4c1ZqR01lc3JCemJzNjg3M1A5T2ozTk5H?=
 =?utf-8?B?WUxOSnBTaFdhNHZPNVdhYTE0UU54R1VhaGI2YkthOGhheS9kdFVDb2lidUZi?=
 =?utf-8?B?V2srcTE3M3BENWhLVUdFS29kZmgyaVJnWDZLWTdxVFZMemtYRGtZTmRFVHNw?=
 =?utf-8?B?cVBWb2Q3QWl6UXlLRVAwakI1N1FrQ3hxS0pHRjBCcWJDTTh3dWpLSkJkY0JX?=
 =?utf-8?B?RzQrZmQwa1RaSXMveG9UQzE1bXZIb0ZJZVJGRUp1eWZpZ1I4dld6NHhIRysx?=
 =?utf-8?B?bUlDZDhvbGo5bnlvM3JUYmk5RFpiRGJiU3Y2UjRYSnlWYnY2bmQ3ZlZHOUQ5?=
 =?utf-8?B?NkhtcUpKajJBcGNSL2wvbWZXUHdEeTc2S2RyNk5td2EzK0dZK2hKSllxZStR?=
 =?utf-8?B?TVlWbXc1Unl0S3NVbkRWMXp1WDVET25hZk1KRXJLU0pYWjVXajhoZVBwNklY?=
 =?utf-8?B?dk9vQWl2UHpJWm53Uzd0bFoxdy84YUhOUEVjbkFTTTZxZlorZ0tSa0F6cUJI?=
 =?utf-8?B?MEpUUHh5V3NVQXlTZ25xRUxnZXFjYytnVGUyNEdxM1VNd0dTL09GeFMrOXRk?=
 =?utf-8?B?a2lZbGU4T2h5M1dqaFYrWXkrOXY5Ylg4SzlhckVDczVPU1F4aVE2eGNLQXFH?=
 =?utf-8?B?dWJBODFiYjJ3VXBTdXFzMlJOTXNKNTNTb01PYkZFWmJyOWFMbHo4Z2llTGJO?=
 =?utf-8?B?c3N5MlZJUFdQR3RLRk5CQm1RRDV3QnlKMXdpTGx5S3ZiSVRaUUk2N3cwYkdo?=
 =?utf-8?B?VGVPZVhJT0FBYXBUWnhIZEVLVHBzRXd5TWU1aHpraWRrQjlHcHBES1hWV0t3?=
 =?utf-8?B?YlUwTU83YlJtcWttTDExOTc1MUV5aFQ4em1qZThqODU4VGx1UWVBWjVJWkpi?=
 =?utf-8?B?ajBUNUh4TFdDSndiaG1IT3FGU2dlWFlMUFZWWHgyYzc2QjhMUXU0dDVKa1hj?=
 =?utf-8?B?b3A0eDg3cGI4U2QwZVRCSUdUNmRDcG84RW1mOWhhdTUzeS9Ea1UvNVprR2gy?=
 =?utf-8?Q?4qld+TWuY8bsSTbNDgqcgoc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E90A42CFA988C44CA5C8EC286CEB9283@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a873cb4-a437-40e5-6700-08daa5787f36
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 19:50:17.5120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PQ5ZJS/3KyctY9u4aUZ1MBovE86Wcg9LYpwNAWDRJYHY5STGauf29zbiwFsfeAdu73c5Ruff9CL+Yu3NiQFgNmTXuKYs+KeSaGoAlF+tpZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6604
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTAzIGF0IDEyOjQyIC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gOS8yOS8yMiAxNToyOCwgUmljayBFZGdlY29tYmUgd3JvdGU6DQo+ID4gK2NvbmZpZyBYODZf
U0hBRE9XX1NUQUNLDQo+ID4gKyAgICAgcHJvbXB0ICJYODYgU2hhZG93IFN0YWNrIg0KPiA+ICsg
ICAgIGRlZl9ib29sIG4NCj4gPiArICAgICBkZXBlbmRzIG9uIEFSQ0hfSEFTX1NIQURPV19TVEFD
Sw0KPiA+ICsgICAgIHNlbGVjdCBBUkNIX1VTRVNfSElHSF9WTUFfRkxBR1MNCj4gPiArICAgICBo
ZWxwDQo+ID4gKyAgICAgICBTaGFkb3cgU3RhY2sgcHJvdGVjdGlvbiBpcyBhIGhhcmR3YXJlIGZl
YXR1cmUgdGhhdCBkZXRlY3RzDQo+ID4gZnVuY3Rpb24NCj4gPiArICAgICAgIHJldHVybiBhZGRy
ZXNzIGNvcnJ1cHRpb24uIFRvZGF5IHRoZSBrZXJuZWwncyBzdXBwb3J0IGlzDQo+ID4gbGltaXRl
ZCB0bw0KPiA+ICsgICAgICAgdmlydHVhbGl6aW5nIGl0IGluIEtWTSBndWVzdHMuDQo+ID4gKw0K
PiANCj4gSXMgdGhpcyBoZWxwIHRleHQgdXAgdG8gZGF0ZT8gIEl0IHNlZW1zIGEgYml0IGF0IG9k
ZHMgd2l0aCB0aGUgc2VyaWVzDQo+IHRpdGxlLg0KDQpBcmcsIHllcy4gVGhpcyBwYXRjaCBnb3Qg
c2NyZXdlZCB1cCB3aGVuIEkgY29udmVydGVkIGl0IGJhY2sgYW5kIGZvcnRoDQpmb3IgdGhlIEtW
TSBzZXJpZXMuDQo=
