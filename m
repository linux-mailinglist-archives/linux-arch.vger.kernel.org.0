Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEDC61FEBC
	for <lists+linux-arch@lfdr.de>; Mon,  7 Nov 2022 20:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiKGTdj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Nov 2022 14:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbiKGTde (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Nov 2022 14:33:34 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C207109B;
        Mon,  7 Nov 2022 11:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667849611; x=1699385611;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VuJP546Ztqu0QH+kFtV0nCvdTGkhlvm3YWW09KfSyWM=;
  b=kIuNdwSMSjskI28DNAXtVhfOOHzb2lSJ08Ntb28zG6AL+GMN8jIx423w
   ipbXC7nvNr5SRtJ3rUj7DR8fxyw7rw7Vmo+jdnvLo7z5ALcmYU+bT1EsA
   8NGdc44PeUrVcaynoseDyFBm1r+r0dILv7L5FeLT9i06C6FbAI103MW3O
   yc7W4ix4IDSn3o3BFSWsniBd5gRNsYdrwwo3dx2KMES76y/bw5UuelgCY
   8+ky7caNdOQmfs9TEbRwnEhwXzd406NbN7a5GLMrR+Dhh/KwOtUI1KEB1
   sZnOq+O95YDn93q9TcCwnCuGTTNxc56yj/W0cr7KtZQQS+re2DIgB3KBg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="337225705"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="337225705"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 11:33:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="965292711"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="965292711"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 07 Nov 2022 11:33:23 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 11:33:23 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 11:33:23 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 7 Nov 2022 11:33:23 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 7 Nov 2022 11:33:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCbikC4twt82GklDBcZIktJzUOhQUYDdpjODXJ5lXqEl5T8i7gVE2g2mzNDNLluAPnugqfdfh/dSFwxpcnO9W8iTYY/czZqUNJSeRgI4QrD7wyYXB87NDyi1iJBPXIBNTl5DdQ7m3PNXQgA13vHLYBI+8fCyDYF1Khj2gx6RyykAajwaGcWL1w4AcRGMDsaQK4GRYbPMfvAawgrI7e2Y/lADd2AEf02Zp+RmgNqNtTrw/ngqsAaRe5TrMd0l8mZ3/I0BO3I/ZQ+ch6UUCgH3dgGRNczeM/2XBx9HpwrNMHE+SrFAG6KyfauPkjTicL1cCN5LRMtY81p+NIxFCo491A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuJP546Ztqu0QH+kFtV0nCvdTGkhlvm3YWW09KfSyWM=;
 b=Y/yx01PbUvJOk9FeWZB6kV+mBp82gV6AoOAMLi2P+9++XwstZ6coTIYInHUWQaCDL+Q8YHdH+z/o5bEZtXcYK5TtNeQZf7GjYuSKHBvpT3Bw3R2/MjlkgBW4xDUZchIILfPdi7n/4jOVfxGQCtzyaO450A3czhIjPb9W+7p8RlKR1i2miW2/lfLUFc8F60KlKq9dagmhZKDEDOoj3iXwC1YkO0SGMvwOETlVepsEGgu/Tw7uh5crBISvcNnj54hb3BTjoq2QABahARuxAQ4U39iXxvOPUc2Tp9TXzZg7RTfpEB3fWXDvHYQhM9lE2NfrnIdsuoJ92I62kOiAiuH8xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM4PR11MB5568.namprd11.prod.outlook.com (2603:10b6:5:388::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 19:33:14 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5791.027; Mon, 7 Nov 2022
 19:33:14 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
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
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 04/37] x86/cpufeatures: Enable CET CR4 bit for shadow
 stack
Thread-Topic: [PATCH v3 04/37] x86/cpufeatures: Enable CET CR4 bit for shadow
 stack
Thread-Index: AQHY8J5NR6vBThIFiE2muQ7xksETCK4zxHGAgAAFWQCAAATlgIAAC8AAgAADP4CAAAChAA==
Date:   Mon, 7 Nov 2022 19:33:13 +0000
Message-ID: <e038e652691a20a2e38ca4b1b3cb6a9eb581d144.camel@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
         <20221104223604.29615-5-rick.p.edgecombe@intel.com>
         <Y2lHxb5BnbQi499s@zn.tnic>
         <14b4c6e3d5b7b259e832ff44e64597f1cf344ffe.camel@intel.com>
         <Y2lQXXCQRTiYljIg@zn.tnic>
         <48643073afcca661971bd7475c04659e453113cb.camel@intel.com>
         <Y2lc8bhBtBFw4CLW@zn.tnic>
In-Reply-To: <Y2lc8bhBtBFw4CLW@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|DM4PR11MB5568:EE_
x-ms-office365-filtering-correlation-id: b090adaf-3d80-4937-5090-08dac0f6e993
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NLAUq1OVyD0Dl/YTMouklis4RpZkcS/AknqtKQq5e3skK98vPLpPPGqpSFMYjL+HX8Xf7tVlRnMAcUyGPUVcgk2hlJIQszjEFrSW5DB40e+gjvYefYYEd8AT2bVJol3DLvyuk3U8ryblTO8mjKOCmdoBCmMT7DKo2KeR8VyMSy5CQq/XBiDJpw2W/TjpZpGbrlqbRoyKAfAiWxSE8pnMcMGtkXZeDZpw8Fa1gFyi7+o6oieYC9afFHiWgFLm5cFAizQiFrfI65QzM0HboBgcQoEyFhmRrroURK2uE1w4VAcTLgF7/Kaa8f+xFP/rlopo6WSzMiMCVOoRjiyI25ad/Fh0sx4nKuAutifikDpZX9xmrP8w6QFVqRW6zcDRsMC1X2acFJObQE18hLWWhcufbbbcdCAyGALDNwuA3xgnMnvVGSeh/1M+d3st4dw0+R4qTY+teTBAZn6p14rS67aq5grbOhka1HHD2j1kBjbsrxQpSwWaTpNKOk1dHVqxesCz0QKj/3zcUQHFYvsDqXf8mPvoSSnT6lVp7aJBBHINOTuSwOfbHNsqsNs724ZQrDCluTQM5jNy4zzJGBl7rfOIUrHOgPRVCO5vypgnBxRrjbsrEzKRTQ29bfEH7RPqZNEB3PXBuzZFh7K4Eqz4A6wV/mJQCI28wi84nT23Ej/2pN488NZP68zdX9GPYdkbaBy1fPrF/PRA9O7meV9yuZ28yOq8cWFcyB09apXjo78PY9jYGa+ny8j6Xp8COB+/lnJBfMEYug7/gU/65UyLo2qBIBCIJrMg2IAmAsq1za9gCkg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199015)(36756003)(86362001)(82960400001)(38070700005)(2906002)(4744005)(2616005)(26005)(186003)(6512007)(122000001)(6506007)(64756008)(66476007)(66556008)(66946007)(8676002)(6916009)(54906003)(478600001)(7406005)(66446008)(7416002)(71200400001)(8936002)(4326008)(76116006)(316002)(38100700002)(6486002)(5660300002)(41300700001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDJwUWpGSUJmV0hjZlBRMmEyelNkOVB1Qk9uTkZyM2U2NFg1dmZtNTVDZ28y?=
 =?utf-8?B?WjNzRVhHdHpuY2FXVmJjY2xYbDZESDI3bUkwWTMwcGV5cDFaRG9iWUpqV2g0?=
 =?utf-8?B?NTUwYXFzSFpzVjA2OXJwNGNSY0dFSjFRK3FhL0tPTGV6V0pSNXF5Q3I0TlJx?=
 =?utf-8?B?a0NKajBhVjh3a1lWaTJiNnZRdTBPbE1UVTQ4bTJiUWJtclF6dTNQOXVvY1hh?=
 =?utf-8?B?czAvd2czY3NyOGtoamRBa0JtUTFrK0xBVUxQem51eG5hQW8zV3RYSzRkSTZC?=
 =?utf-8?B?Q001aWpKVy9KZW42c3dQTytvM0lOMlNVMjQ4b1YzeVNMK0JtQnoraUR6VXRi?=
 =?utf-8?B?Q0hwVnhydGJBT3BNNjFNVVZnMXFRZmhYZ1Vzc245MGdpcnM5Rmt1NnZBdHYv?=
 =?utf-8?B?U0gzZE5wa3dqZ0xNU01DdVB6cEg2Vk8zZU5ya2RuS2dhSURZTUFJa2FkeGhO?=
 =?utf-8?B?VkROK211RkMxaVl1UzBocDNTalY4Uzc4cXRwM2N1UkdxSGxtcDZYK2MvWkVr?=
 =?utf-8?B?eHlRcVpBcmpIc080TzB6TGJZbnFFb2ptcFVDdENieUY1U0lYNlJOSVVZODM0?=
 =?utf-8?B?d0cwM2hXYkV4MEhiMWVTU1k4ZXNjQUxDS1ZuSEx4U3pUZHFobS9QNGpodTBK?=
 =?utf-8?B?cVFkdHQ1cmRuTEYwNHQ5MFdRcWY4Y3V4U3dKTjM0cDBFZ3VNM3N5VHAvTTBq?=
 =?utf-8?B?aFk4SHZzeTdHRURrWXE0MHBaeFJKQmlBRTk5M293WUhYdzdXNUJ0NDlPRExi?=
 =?utf-8?B?bG1xOWczTW1KSEY2MW4yenVtY3cweDZYbDl6N1U1NlROVU9xVG5ZR0l6SVhY?=
 =?utf-8?B?VncvQVZ3YmhJWVo5dkdoZGVSMEtKTUxGUHJNV3JSaTU1d1JieitOWlJ1d0hK?=
 =?utf-8?B?R2tBb1lQZ2hUNXJZdzBPc2ZBMkRCVE9SS0MxVllrQ0dwRXh0LzBrR3lHSWI0?=
 =?utf-8?B?c0gydGRhUnJTVDA3d3hzS3BSZm5zdDBKdCtyaklxc0VtRnJUTHRyVGZsWWV4?=
 =?utf-8?B?bFYxaHNDWGxXNnNVbTlrbzZHNTFuSTMxZHprM21vWHlFSXpNRit6MDk3b3o0?=
 =?utf-8?B?ek9LWERsR1NMN3BKZkJpOTFIQVBGYU9tK0Q0R0h3dW5qV24xSlRKcGhMQ212?=
 =?utf-8?B?UFRuOUdmMlAwaWMzbXI3ZmZiYzA5UW40KzltU1VxNmxFazZyTVZhMk8vWVF3?=
 =?utf-8?B?dU9iSXQ2QkV0M1NVSGxhdmV1ZTYrRmFUT28vdllPZUlJbDQxQlFOVEZ6Wndy?=
 =?utf-8?B?S056eW1kalg1ZTk2Um11dTdiVWZuV3F1V3J5MDBHUitNdTVZY3ZYL3Rsbm0v?=
 =?utf-8?B?OFV3REVpRVV3Wm81eVBTVmpzNnNIMFhqdnNQQjFYd2llOHZOc3VjVnB3cEZr?=
 =?utf-8?B?cEpFbWg3aW96eER3cDJOaW54UjBFZFc3OFlRcUFqNmhDcVJocjVybHY1ODN4?=
 =?utf-8?B?WkpOcWp3VytLVzJUemhDR2ZDTXR6VWwwWHJLWk9mMFZBVkUrdjF6ZUZuUmQx?=
 =?utf-8?B?RitzVkVXTndtK1gwQ3NtOHBWZXVMZEhwaE1iVVRFeUVQWE50MHU0bkVaTU1N?=
 =?utf-8?B?dys5VHVjcG5LcUlEdmtyQ3FUUDBUUTFISkxCTGMweVdiUGxJVEhCKzZDN3c1?=
 =?utf-8?B?UmF2SjVscFhrWVdtTlVaMkt2bm15eXRTTGE0SFRNcURxVlZCVis1QXplVGIy?=
 =?utf-8?B?M1QyZWlsNDhBeWxGR1JwUGNsR0NrK0xDR2xTZ1k4QXhES1VZS1ExblVKUkxI?=
 =?utf-8?B?RVQ3bEI4ZVpxZ0g5dEdFbSt5elBldDA3Zm5rL0YvcVdPUWphWlFnYjVYR0VJ?=
 =?utf-8?B?NkRvNUd2SWI4OUY3V2V6eHV0cUJhcEVPdlZMdjJOWldOaW1vZXM3VjRneTlM?=
 =?utf-8?B?aVZjSENzR1RvcnN4VndWMkFDYVk5SnE3UkNBWVNvdHVCdXo0SEVrVEhsMEt2?=
 =?utf-8?B?OW5ycTJuOENYNzR3SkNsditOdEtpMzBkQy94ZXVsWVNtRG45UHVSVWJQMkM5?=
 =?utf-8?B?K0YzSGVzcU9kNDhrOFkrOFlFQm9xT1gzUkZyVy90d3VkREMzY0NlNFBhRjdD?=
 =?utf-8?B?bklHKzhsdndORDdBVHhrOTdCQ0JmQWs0cEZXcFFjN2JYV2Zic0c3Qy9WQzJh?=
 =?utf-8?B?ME9iN3Q5dHRkNTZjb3IwSExOaExhWHdvWDVodzlaMjhqM2RqMUFLck41TUEz?=
 =?utf-8?Q?KP0prAGUZ/NskDWDbFQMIKU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <94579863069C5647AA59B980747FD767@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b090adaf-3d80-4937-5090-08dac0f6e993
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 19:33:13.8955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OLcmBiQ0krYbXkkfQPqLdyzEtISDiG7u+LbtEtm4MNbQqWyLu1GLOMWYCYRnrBr8U+vaGpvR4KOZUJDaaeTbD238flvR9P6/0m4iZRmPfbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5568
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTExLTA3IGF0IDIwOjMwICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIE1vbiwgTm92IDA3LCAyMDIyIGF0IDA3OjE5OjIxUE0gKzAwMDAsIEVkZ2Vjb21iZSwg
UmljayBQIHdyb3RlOg0KPiA+IFRoZXJlIHdhcyBhdCBvbmUgcG9pbnQsIGJ1dCB0aGVyZSB3YXMg
YSBzdWdnZXN0aW9uIHRvIHJlbW92ZSBpbg0KPiA+IGZhdm9yDQo+ID4gb2YgY2xlYXJjcHVpZC4g
SSBjYW4gYWRkIGl0IGJhY2suDQo+IA0KPiBTb3VuZHMgbGlrZSBJIG5lZWQgdG8gc2Nob29sIHRo
YXQgInN1Z2dlc3RvciIgYWJvdXQgY2xlYXJjcHVpZC4gOikNCj4gDQo+IEZvciBleGFtcGxlLCB3
aGVuIGRvaW5nIHRoaXM6DQo+IA0KPiAgIDE2MjVjODMzZGI5MyAoIng4Ni9jcHU6IEFsbG93IGZl
YXR1cmUgYml0IG5hbWVzIGZyb20gL3Byb2MvY3B1aW5mbw0KPiBpbiBjbGVhcmNwdWlkPSIpDQo+
IA0KPiBJIGV2ZW4gbWFuYWdlZCB0byBwcmV2ZW50IHRoZSBrZXJuZWwgZnJvbSBib290aW5nLiBT
byBjbGVhcmNwdWlkPSBpcw0KPiBkZWZpbml0ZWx5IG5vdCBmb3IgZ2VuZXJhbCBjb25zdW1wdGlv
bi4NCj4gDQo+IFNvIGFzIHNhaWQsIHBsZWFzZSByZW1vdmUgaXQgZnJvbSB5b3VyIHdob2xlIHBh
dGNoc2V0J3MgdGV4dC4NCg0KV2lsbCBkbywgdGhhbmtzLg0K
