Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BAD5F5CE3
	for <lists+linux-arch@lfdr.de>; Thu,  6 Oct 2022 00:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJEWr0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Oct 2022 18:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJEWrY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Oct 2022 18:47:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A19804B7;
        Wed,  5 Oct 2022 15:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665010044; x=1696546044;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=j0sSOxjeUy7zwW3nL5WnNa96xtsBTo9aMrE6uDnwTyo=;
  b=VxaDZQI6PTlrkh+g3m1ANmyDGqTL1YP99Q+9JEk5mytatIYaUEl7i2Oa
   CNdSxU/Aejw+5BX4bUulYHThiV12AJOPLWSJlJX14RDOVAzBcrgcLSyhf
   smjRfl/MxwJnrIA886jB0pIjWKSvcHOTkAt7E8K31fAmEx3sNhetvDmpb
   x9CdJJ00Svhaae1yNt5VV9HmTUhTKazby0qvnSdztvcR14F1a7kXqz+AW
   fX5pA4nTZofSWfazLYl1McL8BNKAidKOdP9wKLvFRKDUA3y+jwOQsCMgp
   2TeXe4dh98c2TdMBXfvgvzkwQ1/anjroFbZVLxyu00toUhn0IPG+24RqB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="290549793"
X-IronPort-AV: E=Sophos;i="5.95,162,1661842800"; 
   d="scan'208";a="290549793"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 15:47:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="655362399"
X-IronPort-AV: E=Sophos;i="5.95,162,1661842800"; 
   d="scan'208";a="655362399"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 05 Oct 2022 15:47:23 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 5 Oct 2022 15:47:22 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 5 Oct 2022 15:47:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 5 Oct 2022 15:47:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 5 Oct 2022 15:47:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1MJMShOAqOHGaZhgutJRQSf/yVSPvpO7CEwx2WWljfUiUXflYweeplJF7KvoWAV10MhYJOcvdj4kO2Y3dhre3nLkX/UxvnGn1BIqlBWQ2vnFnDJ0FTm3OmUaotVtWEE9O5qrZquo2gSva3NfguSQTJE9YYPh5+RpOjm2D7EeLvNGBKIpqiF9OaZyO0pwFTnjlqaaB8Fe6mSrLnd2gb+xGHci0LSOt4mhntYZ4ZE9YkDIpiljlXNGabHwzSttZl9qcc/5h3FeW1cvTXcWuQqZzC9BAirZocC5hsE1Yw4FuSl7JqCxen4A/DbCwBIOOgnD7UcAbHxj8TWRFeNruxDLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0sSOxjeUy7zwW3nL5WnNa96xtsBTo9aMrE6uDnwTyo=;
 b=al0gjGrtWtPYOaAU10YP8NkzH/n4GnOVjib/bPb02A7FM5OCb/Q3MJqIZn2cnPxEdfgAiqjGgK0QRtuhcf4DiJhenn+HkJCL0gClsK9Z8Nr2+P6C+3MVqnI4usTrpUjveRanqPSXw3ZPjjVHTR2599PoHDEbTeT6lfCo/i7SKJ7SbNOhSW2K+0hZnbQROwhWrZBTPdnMGTTKAZ39xxLf00eNZVxnvnYZyaZZqgs0L79w06k0/7byV4SKFapit6fosdpaX6Wy13MCciXbbvI6Je+rsoWBmRmNMrPzAJgzWuQ5kzpcZd9vhnfoVbz/I5l5aUDbZnr96Uykq+4yD02WYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by IA1PR11MB6370.namprd11.prod.outlook.com (2603:10b6:208:3ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Wed, 5 Oct
 2022 22:47:12 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.034; Wed, 5 Oct 2022
 22:47:12 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
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
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 26/39] x86/cet/shstk: Introduce routines modifying
 shstk
Thread-Topic: [PATCH v2 26/39] x86/cet/shstk: Introduce routines modifying
 shstk
Thread-Index: AQHY1FMi0mGJj2nvSk6XePU1fP3/w63/H8cAgAFQYoA=
Date:   Wed, 5 Oct 2022 22:47:11 +0000
Message-ID: <fe5d52cebe4aaca0234856f789b3153f202eb9cf.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-27-rick.p.edgecombe@intel.com>
         <052e3e8c-0bb0-fd2d-9f67-08801a72261c@citrix.com>
In-Reply-To: <052e3e8c-0bb0-fd2d-9f67-08801a72261c@citrix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|IA1PR11MB6370:EE_
x-ms-office365-filtering-correlation-id: 8a041d7b-8fd8-4a22-0d72-08daa7238aad
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lw/LSL1B23qUgEettF4MVQSbZGhtBjG5CsR0WU05a33ZfWlFYo5pSQlu+J9JgFKZqmQ4JGFWjkrDX0Dovnm4rXXZXO485Gt8b/CBE4usYGxJekMpQuKSHdpT5BW1dqFf9TkgkUt/iz0VEBsOzSYWadYc5ODWIVJ4ctj7RIYA6L91tCx1nWfZoxZPJNE9CEKgmgEpal/zEUhC99alcMzI1xwWcDGS0vaOrM/i3xiOTtiIPXCUq9i4mNnK1GwLaJGNGE2/vyoEB6YhceFMOB9EsqAAr84tlAlaW1CMBRV8X9TgcTkFqcZkIK0abpNlBVBiG7iOiBdEv49FUzPKvC4d0ADPNvN/jk0pxQanrsxzxxkB1V8mnXAyBZnTWmZzYok+RRe7SdyikYMJ+Aegk6fQhAHLIqLr7IzGrVtI4AFM/5NJV57fKZGliyEUNEjAMU02czTtV3yIq9YM+M1ae4UgcYw3SWd24bie7P1BO9iaahQGEq8uCKcjRLBOWEvTACpQ402UM1BBwZ/fhxZzqKY2NkUU6GFXKFDC0cIv1VYbd/z3Jv81xFc5ew8PfvXg/EfuAryQN/0vC4u2qpQx8wgfvDQF17auNhmf83pc1DSQk54zbM5WDz2j80haSOai6d5FXPSdU2eXqweBnLHtgyrcuNdEFeLpakf560cQuI9ZBaUW2P+Yl051QQ06KJgKiE3PpfaDOG4AWGPXcCxVd5kduly40aNp5zj0coLAijCVUGD8wH+441Di4UN8UmFeGCYPA7tp+Ub34hrptiHwYanEQkQJFGKWhNNu72PPRkGw7H5l8elbDfMsKGtpSPVOisPdy3+45vsr8IJ0bRpdzkVJQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199015)(82960400001)(36756003)(86362001)(66446008)(921005)(8676002)(66556008)(38070700005)(66476007)(91956017)(64756008)(66946007)(38100700002)(4326008)(76116006)(7416002)(8936002)(2906002)(110136005)(186003)(4744005)(41300700001)(7406005)(478600001)(5660300002)(2616005)(71200400001)(53546011)(6512007)(6486002)(122000001)(316002)(26005)(6506007)(99106002)(17423001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3FTakN6MUtJTEZMU21rRVFhWkZHbUxBYU15Qk9OV1hvOTZEaDlTOXJ0Ukp6?=
 =?utf-8?B?VWlOaVJzQ0VnYkllMmU5ZXJjemNJMlZwWTVhczI1K2RjS0pQZ3NuZTVWYmdI?=
 =?utf-8?B?VkNWc2xoQkcrdnhLaVdVQTk4L2xPbzI0RCtQYjRPcWY5YVNGRkdZUWE3dndC?=
 =?utf-8?B?NFl6eS9TaXhraUlVbFJjZ003MnN4MGZkTEFYWnJjZzI1SXNHWUVwMzdtWGVQ?=
 =?utf-8?B?MzFjeGtsOW9WRnJMSVhyMW5teU1EanMzanQ4TSs3UHBkM2MwYngzaDdhaC9C?=
 =?utf-8?B?RWFCSGhOSEUxaCt0QU1kWUlMRFVuL0ZCT3QrQm5kVkNkZzY0NWlIeHp6R3Uz?=
 =?utf-8?B?cjR6azFWeGN5QUhVVktZOTJPWGFSYjlmaHVhcUQvcW1SdUZTb1hnMnZ2emhP?=
 =?utf-8?B?d3dHdjk5YnpMcW9pcFBUbyt2emNtMWV3bm9vdCtkd1dEY0ZGY3JqcHpiT3hs?=
 =?utf-8?B?UkFyR3hLWmRVSlh5WjNUNFBZTGJuM0ZGb3k4c0JWWTNCVXlsdEsyMU8rYWNC?=
 =?utf-8?B?VzAxREtkcUpzcTVWYmdhdUxNVTArbUNnRVNuaTVicVZKd3BtYngwSUxTOFIr?=
 =?utf-8?B?NytNbjZhbWZKVWphRjFqa3ZvQURWaFVIbnNWNGV1OWZ0OVI4SDZ5VlpzL1Qz?=
 =?utf-8?B?R2t4MkVWTnBSRzhOZjZ5QldlSENVNDhhMUI5OEtFY2p0WEJRdDJZWHZlaGxZ?=
 =?utf-8?B?eDVnWFZLZEVYUzBFM0MxN0J0dStnczBhNWJFMndLNEd6TnJxK0FMOENnNSsv?=
 =?utf-8?B?ajZSbVFZNWMvMlNkZ3lyL1RkOTdZS1VNK0lOUTJBYkdtbnY1Um00QTRNQXdY?=
 =?utf-8?B?Q2YzYUxBZy9ldmJlMVZlUHhETHhRdU9sclZEQ0x1NFVIMGx4dlNhT2pTMXdU?=
 =?utf-8?B?NjBDOWoyY2ZSTlNZZUFZN1BvVDlGYklQc3BFazNTRVQ3MHJtVEFZKzlJK243?=
 =?utf-8?B?YnNESkliMXVUUWNtOC9vRG9OcWNrQ256c0hIc21NVjFDaEVXVHNHWFI3SFAw?=
 =?utf-8?B?N051TjgxVThKR3J4ZzVoNnNxbVh4aWZXU05yQUZabXlXdndaNG9HdExOSzM4?=
 =?utf-8?B?MnRwdVFwNHF6UVZEWlVPRnQ2N1VhT2FPWlM0ek5LZlR0aE5Fb2dWYzMyM1Vl?=
 =?utf-8?B?NCtKUmJPaktQMTM0bTlIUWU1TlRTU2tyQ1pUbGhRR1ZRbS8yVzZmT1BnbXlj?=
 =?utf-8?B?RDNvSG1HQmFRQ1pKRWd6Z05aNXRjQy9YWjE4NGY3Z2wzTHYzMjN3WDBBRk1D?=
 =?utf-8?B?QldGRllMTFV0L3pQQXlPRFRWTnBnczRnTXhwcllWYjZtcFBmWGt1Y3dORS9h?=
 =?utf-8?B?cTFXQmFsSFRHS1JiUVRMbzluMUl1R1JEbkEwL3JnamQ3WXpEUWRiaDNselAz?=
 =?utf-8?B?TEJSMEtYMGp0NDdvMDIvR3RHSCtkMGR2THc0TFpKM1dvNkUwZlRHdUVQOHpy?=
 =?utf-8?B?MjQwc2NQbkcyUlNTb0pmcGJLTVBmWDlTMC9vMDdNN3NaTmNyL0l5V3JwNGRs?=
 =?utf-8?B?d2pWK3pHNmpiT0c0VFFad1FoQzB6WlpHK1p3b3lKRlJhcHU3RnVjd2M5aXVv?=
 =?utf-8?B?OHNzU3lpUDNzZDltZ1YyOWM5NDIyaDJYbnV0WlJUcWVnVThnTGROTEF2d2Rp?=
 =?utf-8?B?MEtJZ3RXUXhKNTRMNDlGUXpSR285cUtROG1nSjFYYkNlbVBGRjVqNEhiQWNx?=
 =?utf-8?B?Y050U0FkOFVsU3VMKzZybFBwQ0N5T3BVaTRMQ3QxSW5wMStPSU9YaWExb1NU?=
 =?utf-8?B?TUZ5WEZvUkR3K2t0azVyd09pMGh2VVJCRElwaDVrOGZnTEltRTAxQmxZaGtt?=
 =?utf-8?B?bDUvQkFENFlKRUFhYnFyWDlVM3YvSiswQmtCZE9NeHBRSTdaUWY0MTZhZTYr?=
 =?utf-8?B?aW4xNm1aYlQzeVNjUkZZTGtHVS91VE5hbzJaeGg5UndtZTFIeWs5eFdSWXJ6?=
 =?utf-8?B?UmJHYnAvVFZ6aGNYQnlIMXdpTlBpa2lMRTZyVFE4MFZMUnpuU3ZaTDYxUkhY?=
 =?utf-8?B?WUhBS0xHWE0rUDZDTHhlOFBMb3h3YnlBblRwd2g5NXc1Q0h5Qjhib2crNmtz?=
 =?utf-8?B?N2F3ajRxWE1LVHdrM0Izb1djUjRYZjYvbGtac0VldllIeVNZNTdsanBmcTBD?=
 =?utf-8?B?b0gydkY2V2lSZDFyZjdzMVNGcVB3emxwdEpDWlFiV1p3eEpCakJQOGlSRU9O?=
 =?utf-8?Q?Z9gHiUOJ0Bd9502aQf01yF4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <618CDFDB8B3A194BB87087CC3B67211C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a041d7b-8fd8-4a22-0d72-08daa7238aad
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 22:47:11.8324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ssDPtB171hAgYyaPhOzEfKqn+dTgDOrgTPju1h1aJPEtKPXkEC7R2cdEEqimsgggGf5pU1j3jWXiwXjPg4+56a+UGW72zIOt9odDoqIeOFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6370
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

T24gV2VkLCAyMDIyLTEwLTA1IGF0IDAyOjQzICswMDAwLCBBbmRyZXcgQ29vcGVyIHdyb3RlOg0K
PiBPbiAyOS8wOS8yMDIyIDIzOjI5LCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToNCj4gPiBkaWZmIC0t
Z2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vc3BlY2lhbF9pbnNucy5oDQo+ID4gYi9hcmNoL3g4
Ni9pbmNsdWRlL2FzbS9zcGVjaWFsX2luc25zLmgNCj4gPiBpbmRleCAzNWY3MDlmNjE5ZmIuLmYw
OTZmNTJiZDA1OSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zcGVjaWFs
X2luc25zLmgNCj4gPiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zcGVjaWFsX2luc25zLmgN
Cj4gPiBAQCAtMjIzLDYgKzIyMywxOSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgY2x3Yih2b2xhdGls
ZSB2b2lkICpfX3ApDQo+ID4gICAgICAgICAgICAgICAgOiBbcGF4XSAiYSIgKHApKTsNCj4gPiAg
IH0NCj4gPiAgIA0KPiA+ICsjaWZkZWYgQ09ORklHX1g4Nl9TSEFET1dfU1RBQ0sNCj4gPiArc3Rh
dGljIGlubGluZSBpbnQgd3JpdGVfdXNlcl9zaHN0a182NCh1NjQgX191c2VyICphZGRyLCB1NjQg
dmFsKQ0KPiA+ICt7DQo+ID4gKyAgICAgYXNtX3ZvbGF0aWxlX2dvdG8oIjE6IHdydXNzcSAlW3Zh
bF0sICglW2FkZHJdKVxuIg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIF9BU01fRVhUQUJM
RSgxYiwgJWxbZmFpbF0pDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgOjogW2FkZHJdICJy
IiAoYWRkciksIFt2YWxdICJyIiAodmFsKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIDo6
IGZhaWwpOw0KPiANCj4gIjE6IHdyc3NxICVbdmFsXSwgJVthZGRyXVxuIg0KPiBfQVNNX0VYVEFC
TEUoMWIsICVsW2ZhaWxdKQ0KPiA6IFthZGRyXSAiK20iICgqYWRkcikNCj4gOiBbdmFsXSAiciIg
KHZhbCkNCj4gOjogZmFpbA0KPiANCj4gT3RoZXJ3aXNlIHlvdSd2ZSBmYWlsZWQgdG8gdGVsbCB0
aGUgY29tcGlsZXIgdGhhdCB5b3Ugd3JvdGUgdG8gKmFkZHIuDQo+IA0KPiBXaXRoIHRoYXQgZml4
ZWQsIGl0J3Mgbm90IHZvbGF0aWxlIGJlY2F1c2UgdGhlcmUgYXJlIG5vIHVuZXhwcmVzc2VkDQo+
IHNpZGUNCj4gZWZmZWN0cy4NCg0KT2ssIHRoYW5rcyENCg==
