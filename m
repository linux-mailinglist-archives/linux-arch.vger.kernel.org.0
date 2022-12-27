Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D264E65714B
	for <lists+linux-arch@lfdr.de>; Wed, 28 Dec 2022 00:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbiL0Xgb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Dec 2022 18:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiL0XgJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Dec 2022 18:36:09 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF0ADF2E;
        Tue, 27 Dec 2022 15:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672183951; x=1703719951;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=C0ISVSZmiHrPnsdw/bp4qNy0TFlSPvtn168wqt27n3g=;
  b=SlhZf0qLSC0E2NoYgK8Y7eekiz1zss5XOgRwhHxtgREoNph1mWXnYLDB
   7Y8Q3Yur+i3qteU3vUUjgVHsa9/V7GXQ8FIG/23HACVFxQX2vqDHPbIXA
   hyonf74zXX7okpwaoKmFf36e2gfBAYafxTfjXm0xzXVYhm03VIrrWRfR9
   KdkI/e4yTK0j9QfXrtgllBkNXqFu/EaD8T7XmgpnyhFupIzJc8ecuYFrC
   Z0iJHUyzDT9/BxQJAsscq2R4Zcb+Bm9k6amDBR4J30ogJTJHXpSfpVvV0
   sOjTvp4oohqnl/J8B0yDEIDKLu2Lc5RFPillv9Ea7et8p0cnbyLo2HLaW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="319496448"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="319496448"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 15:31:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="721628472"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="721628472"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 27 Dec 2022 15:31:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 27 Dec 2022 15:31:40 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 27 Dec 2022 15:31:40 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 27 Dec 2022 15:31:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFp9W/bvPtikufpvwMV929X6tWOVt5jA+iQ/hVDasxBaXV322HbmLtWLENVA+U4MzAbJTUYZLfB0bIJ6caQw2IXgtIpu7HCieK+l8jTRTg05Yt/EncpvI91ncQK41e+RidIZCg2pngRWHGfGokuh2x8BnfEp62eCEvvWkM7eSHOHHC5B5ck0DUqbpgNyKAcpZoHoTtZqsdgYjJ2w/qDdAqT4rduAG6wVz81TKz1fX1HEnUMmsJscS8koGG2Iqt5xj+Z4fuo4OLcb+xByRFk4hhy48waDvmTx/KEoxT7YAxswkv36xnW0GLwu5GwAgq4lGkAOQHIdD2/6SnYaqfbuuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0ISVSZmiHrPnsdw/bp4qNy0TFlSPvtn168wqt27n3g=;
 b=LfFRA6GxamLgHwvv1Msa+BmX6rh7kKjf2z+WPSbX3hx4lIIhU1qXg8JA8g/LVobSvrr8BWIPBkEylYyurvq8Z7tdLFnDM38OI1EKv/Dk/fcDpxSN4UXL45rzy35NJ22BFvJh4abWs05Kj8M8SsSHKrXJEP7PMrHuV4Fceg4fDYcZFTcIbqAhNB8Fan51i2SdzipCYm1Y1HKcf7XWGWPwtiPtqwXPyrx7i637ui0qGepoqwkGVbN3jUnu/fECHyztkC0NtR5EvGfr5KXBGDXc+Y7qVVKmqpebd0lgLYNHTv2WcLMk0Xr9rzS79eQRsKKVng/pdBnPDT6LWhEwdPb4EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CY5PR11MB6090.namprd11.prod.outlook.com (2603:10b6:930:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12; Tue, 27 Dec
 2022 23:31:37 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff%5]) with mapi id 15.20.5944.016; Tue, 27 Dec 2022
 23:31:37 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v4 11/39] x86/mm: Update pte_modify for _PAGE_COW
Thread-Topic: [PATCH v4 11/39] x86/mm: Update pte_modify for _PAGE_COW
Thread-Index: AQHZBq9emZWK0Ia1IEy8YRukVHWfCa6BwyUAgADGMgA=
Date:   Tue, 27 Dec 2022 23:31:37 +0000
Message-ID: <060f1009199b09b7f8b9698e9f6f8375d9d1b66d.camel@intel.com>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
         <20221203003606.6838-12-rick.p.edgecombe@intel.com>
         <Y6raFBB+oVx+2WXl@zn.tnic>
In-Reply-To: <Y6raFBB+oVx+2WXl@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|CY5PR11MB6090:EE_
x-ms-office365-filtering-correlation-id: 2b2478a1-cd87-46dc-d760-08dae8627f9d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pdgn2lfFTuqnUOeUzYMLgsve0H8tfLa56Bmab0FGIqYK5aI7OE3IwHA4dMFRqjQhNB5f+e3+OiEuyX+5yfWpOj3NBW9zj6Ann+o5VLfVfT4JW9E3is7XUdnR3YC8D3ftUPmfCuSvCjqwkT/GH8BGQ/4Gq/1wOrSpbcMna6Tla8aEEvxZN7+QO7WS8kiXujYqLlS8kycxYRW3tiYyEmJfXi97K0tno+sk4GF8JVt3T5AoUQRPDi7bCiAKo35q2tb9kSOTYi10B3DrisZmj2hWHjTUqdUGLaHny73PzlWBeueQEQugmBZOIT2j/n3cklfgUfxVHz91bDyd8SMHjWrWwCaI4A2P6KpN6Qogz7649VnGcUbvdxN7wwn9+udzw4A9DDkxLOQRRlgxJar33BNxss0KuzP0nIGuC9yiLJnlrKVjCBrRKhGgCBGgetV140ciP8Y2IbxxEPpOMkifztGbsygZth+AUEH0BOTcUo4cmn9bwZQwI/VUPtLSgCvkSE/Al1oNcfxyH9Mr3ws7hqHY0vkX+2zPRkmS1rw5MK3s8DJN2j929hV+qp+AcfsNMrAsjH5H2wTDMQsIvGwnVvXr7Is3T0N8OevOl7z9JiAJqfs9uuYQyei8MP90dxfmGKJAvBvEEYIutBR6nHaRgFOtzEaq/HGB4uJ/vHhe/QpBkuiYlY24NC7HoVNu8N/ukZSNi3DW9l9sYuDqv48tmRg1qg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199015)(6486002)(41300700001)(8936002)(2616005)(71200400001)(36756003)(478600001)(5660300002)(7416002)(7406005)(82960400001)(38070700005)(4001150100001)(38100700002)(122000001)(2906002)(91956017)(83380400001)(6916009)(316002)(54906003)(86362001)(66476007)(64756008)(66946007)(4326008)(66556008)(66446008)(8676002)(6512007)(26005)(76116006)(6506007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2JQb2g1SHViNk5INE8zUWNjNy9mYmtKYWg2YVd1MTF3MXR5cVVxd2k5WVRK?=
 =?utf-8?B?bkNFZ1hiSWJuemM0MTBiK2N6bEsxZTlYcjQ3NUdHamhkRk5oU01VdEtKQU1E?=
 =?utf-8?B?ZnkrRXNabUlMckRkOWZjVHBhSFhJa1BGbEYyOWVTUVBZT1pTZGpSMkNVTmZk?=
 =?utf-8?B?clpoeVpIVWd3Z3k1NVF5QVZBMVVZZE8yNXh3Yjg2NjMxMWtaRDBRR2JyV0lI?=
 =?utf-8?B?ZTZOUnhBSnIyV0M1Z2lKVldFNEw1NzcxUmtNVkNMb2czSkRQSlFnUDlaWnov?=
 =?utf-8?B?WGxSczB1SUhRK0RYeEF3SFFiMGxQUHVpalVLWUVTUkZUUGNEcHJmU004NWVp?=
 =?utf-8?B?UklJY3JhcERVRGdjSVlqWXlHWlNZSzcvQk9DblN5Vjd2eTBhb2dnSTJuamtR?=
 =?utf-8?B?QzcxYy9HcEU3MEtTUmN5SGZCWGtydDU1eGE5Tkp2bml3Wi9RNjVnUUpCNG5P?=
 =?utf-8?B?Q1JTZkZvbEVBMjdXd3hPUmx3d0hRR1BEUWZWbHJWamxueFk3VUNkN09keWgr?=
 =?utf-8?B?Ukp3U21EUjNleC9jSGErbC9HQ3FJemQ2R3RRYUcza0pQODdKZHp5TUN4SVFz?=
 =?utf-8?B?NVlHUENxK1hldVpabWhOL1BLbExtak9TMnBzY3dyM0g5RVVYaDNUWmc0enhw?=
 =?utf-8?B?VUhuZ2w1UGx3NzBLa05wVFlXK1V0WmR5K1NjWkVncTRQMG1ZTnFMbGlyVUJY?=
 =?utf-8?B?VDZSeUhWMXRINThraUJOZXo4VVFYZVpoVFlmWE5zWm83WlhxbWt1eUh1bnNx?=
 =?utf-8?B?VDRYbEF6cHZVa09FS1V0RUlack5uaU51ODRTRTZGSVMzVmNoRzZadjIrRG96?=
 =?utf-8?B?SmxUTmhBOWhhQjgxVFBVT0l2MUN3RzA1UUxNMHNKSW4zSTFtZFRJK2VqYWFy?=
 =?utf-8?B?Mmt4a0dCWWxDczMwL09SNmhXeU1jWW52enppdlRuOTZIb2JlZ1ljakN4b2cr?=
 =?utf-8?B?bllFWUtUQUxhRWxiL3RUbDlOYkt3YXU2Y0RYUkhEcFhHeTAxQVdXTHBYMGp5?=
 =?utf-8?B?OVpocXlLTWNRZjRpV3d6ZXJ4WXFZRUwyMkJXTGJvai8zM0dGT1RwdXExa1Y5?=
 =?utf-8?B?cVBGS3NaeEVTYUozdFI4MEJmc3VFdFo2aHYvanVOSHJDYlZkU2hKL1k0U3dP?=
 =?utf-8?B?d201bGtmanRRYXV4ZjFwUkhtOFFYdjgvNXI3OWczNVhmMXQzS0t1aXB6U2NK?=
 =?utf-8?B?eTdEMFNGcUdzcjJXczRTUGk1SnpEZVowTHFkWXFLbnp4dU5FdkpOdGJ0Z05m?=
 =?utf-8?B?SjdqU0dFQ2pXNkJBQXErMUtmb2gxQ0IvdEhKa0VyeFllZ2ZlVDVFRzc5Y1U0?=
 =?utf-8?B?TTJDUjc0azF0TnlER2tuSVpYcStOK29OaEphc3VJYXlTNE1KRzR3QlhJMTJH?=
 =?utf-8?B?RVdHTnFya3M3WEJUc2szUTJxcmlTWHRzVmlnYXNVaWV6bmFONUpuSmRtZVRQ?=
 =?utf-8?B?VVg2SkdZMjk3akV5L2lvNXdHbURRdG5GQU9sbFNRK2RlVm5CWC9ob2FzaUtj?=
 =?utf-8?B?UGtRWG1DS3ZDUy9IOHNjeTgzcW5hRVlaZEJYN3BMRkE2alJSSVBKY2NkNFVN?=
 =?utf-8?B?MisvWTBOSTM4K0xYS2Y1VTd5b1JsaEVnNCtRdnRpK0FEOEdzdExiVXpoanJs?=
 =?utf-8?B?L0ltMURjMWVyUWJERUk1Z2dtVVR1WVNkTnZSTS9WenloMVJoU2c3MGRGUTB0?=
 =?utf-8?B?Yk1NL0tNRHdwaWI2WnE3VGVSSWIxaGpPekMwTGZ5SWZicGN5V2h4NGUvZjRu?=
 =?utf-8?B?czdHY3JjTmxCeFNFMGF1cFJMb3ExSEtkQ3BSUXVUY1BxZ1VKd0xneHdxM3Jr?=
 =?utf-8?B?VnpwdG0wQy9OVGdINVIreVNQRXhQN2hnMFllblUzYTJONEg2THQ5dGxvM2ZD?=
 =?utf-8?B?cUV1dHB6K3lTeHJ3Qjc4Y3ZTVjFDK2drdjVYeWhPVVRqeSthUGFOSGx4Lzh0?=
 =?utf-8?B?eUJLYks3dTBBTkd0ZEhwaGV1cVc5czVGM3d5cWFwVWRCNnpqdW0zbzdkK3lt?=
 =?utf-8?B?OXNreHNsdXdicUozRFlyMGFQMDgrT0xLWDBqSVJyNVVrbXcyTmgrbnQ4cUZk?=
 =?utf-8?B?aXhURlNNR05FVDFuemxHWWcyaTIzcCtrR2lCNTJtMEkwYVhHeE1jVk0rMDlS?=
 =?utf-8?B?K0ZhZ2t0azh3Z2M3Z1FMTzBMRFh5SkVwZUJ5a3VRZ2FUQUY1eEhSR3RCczAv?=
 =?utf-8?Q?jlV3lasS9N+C6Xyv0AGlZuc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18A945B9940B2542BD812B371C2F9104@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2478a1-cd87-46dc-d760-08dae8627f9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2022 23:31:37.1367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KPQI959kB0nKhwB1huprTx7VLBMdb5C11BrNbfZRuawW7ifjfpWSRUulmH41AyY4ojKP9awmNydiCrCSdc5GdSBwsfQWvcw0fjagP85hFiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6090
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIyLTEyLTI3IGF0IDEyOjQyICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIEZyaSwgRGVjIDAyLCAyMDIyIGF0IDA0OjM1OjM4UE0gLTA4MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+IMKgc3RhdGljIGlubGluZSBwdGVfdCBwdGVfbW9kaWZ5KHB0ZV90IHB0
ZSwgcGdwcm90X3QgbmV3cHJvdCkNCj4gPiDCoHsNCj4gPiArwqDCoMKgwqDCoMKgwqBwdGV2YWxf
dCBfcGFnZV9jaGdfbWFza19ub19kaXJ0eSA9IF9QQUdFX0NIR19NQVNLICYNCj4gPiB+X1BBR0Vf
RElSVFk7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoHB0ZXZhbF90IHZhbCA9IHB0ZV92YWwocHRlKSwg
b2xkdmFsID0gdmFsOw0KPiA+ICvCoMKgwqDCoMKgwqDCoHB0ZV90IHB0ZV9yZXN1bHQ7DQo+ID4g
wqANCj4gPiDCoMKgwqDCoMKgwqDCoMKgLyoNCj4gPiDCoMKgwqDCoMKgwqDCoMKgICogQ2hvcCBv
ZmYgdGhlIE5YIGJpdCAoaWYgcHJlc2VudCksIGFuZCBhZGQgdGhlIE5YIHBvcnRpb24NCj4gPiBv
Zg0KPiA+IMKgwqDCoMKgwqDCoMKgwqAgKiB0aGUgbmV3cHJvdCAoaWYgcHJlc2VudCk6DQo+ID4g
wqDCoMKgwqDCoMKgwqDCoCAqLw0KPiA+IC3CoMKgwqDCoMKgwqDCoHZhbCAmPSBfUEFHRV9DSEdf
TUFTSzsNCj4gPiAtwqDCoMKgwqDCoMKgwqB2YWwgfD0gY2hlY2tfcGdwcm90KG5ld3Byb3QpICYg
fl9QQUdFX0NIR19NQVNLOw0KPiA+ICvCoMKgwqDCoMKgwqDCoHZhbCAmPSBfcGFnZV9jaGdfbWFz
a19ub19kaXJ0eTsNCj4gPiArwqDCoMKgwqDCoMKgwqB2YWwgfD0gY2hlY2tfcGdwcm90KG5ld3By
b3QpICYgfl9wYWdlX2NoZ19tYXNrX25vX2RpcnR5Ow0KPiA+IMKgwqDCoMKgwqDCoMKgwqB2YWwg
PSBmbGlwX3Byb3Rub25lX2d1YXJkKG9sZHZhbCwgdmFsLCBQVEVfUEZOX01BU0spOw0KPiA+IC3C
oMKgwqDCoMKgwqDCoHJldHVybiBfX3B0ZSh2YWwpOw0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoMKg
wqBwdGVfcmVzdWx0ID0gX19wdGUodmFsKTsNCj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoMKgLyoN
Cj4gPiArwqDCoMKgwqDCoMKgwqAgKiBEaXJ0eSBiaXQgaXMgbm90IHByZXNlcnZlZCBhYm92ZSBz
byBpdCBjYW4gYmUgZG9uZQ0KPiANCj4gSnVzdCBmb3IgbXkgb3duIHVuZGVyc3RhbmRpbmc6IGFy
ZSB5b3Ugc2F5aW5nIGhlcmUgdGhhdA0KPiBmbGlwX3Byb3Rub25lX2d1YXJkKCkgbWlnaHQgZW5k
IHVwIHNldHRpbmcgX1BBR0VfRElSVFkgaW4gdmFsLi4uDQo+IA0KPiA+ICvCoMKgwqDCoMKgwqDC
oCAqIGluIGEgc3BlY2lhbCB3YXkgZm9yIHRoZSBzaGFkb3cgc3RhY2sgY2FzZSwgd2hlcmUgaXQN
Cj4gPiArwqDCoMKgwqDCoMKgwqAgKiBuZWVkcyB0byBzZXQgX1BBR0VfQ09XLiBwdGVfbWtjb3co
KSB3aWxsIGRvIHRoaXMgaW4NCj4gPiArwqDCoMKgwqDCoMKgwqAgKiB0aGUgY2FzZSBvZiBzaGFk
b3cgc3RhY2suDQo+ID4gK8KgwqDCoMKgwqDCoMKgICovDQo+ID4gK8KgwqDCoMKgwqDCoMKgaWYg
KHB0ZV9kaXJ0eShwdGVfcmVzdWx0KSkNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcHRlX3Jlc3VsdCA9IHB0ZV9ta2NvdyhwdGVfcmVzdWx0KTsNCj4gDQo+IC4uLiBhbmQgaW4g
dGhhdCBjYXNlIHdlIG5lZWQgdG8gdHVybiBpdCBpbnRvIGEgX1BBR0VfQ09XIHNldHRpbmc/DQo+
IA0KVGhlIGNvbW1lbnQgaXMgcmVmZXJyaW5nIHRvIHRoZSBkaXJ0eSBiaXRzIHBvc3NpYmx5IGNv
bWluZyBmcm9tDQpuZXdwcm90LCBidXQgbG9va2luZyBhdCBpdCBub3cgSSB0aGluayB0aGUgY29k
ZSB3YXMgYnJva2VuIHRyeWluZyB0bw0KZml4IHRoZSByZWNlbnQgc29mdCBkaXJ0eSB0ZXN0IGJy
ZWFrYWdlLiBOb3cgaXQgbWlnaHQgbG9zZSBwcmUtZXhpc3RpbmcNCmRpcnR5IGJpdHMgaW4gdGhl
IHB0ZSB1bmVzc2FyaWx5Li4uIEkgdGhpbmsuIEknbSB0ZW1wb3JhcmlseSB3aXRob3V0DQphY2Nl
c3MgdG8gbXkgdGVzdCBlcXVpcG1lbnQgc28gd2lsbCBoYXZlIHRvIGdldCBiYWNrIHRvIHlvdSBv
biB0aGlzLg0KVGhhbmtzIGZvciBmbGFnZ2luZyB0aGF0IHNvbWV0aGluZyBsb29rcyBvZmYuDQoN
Cg==
