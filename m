Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8574AFDC9
	for <lists+linux-arch@lfdr.de>; Wed,  9 Feb 2022 20:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiBITzg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 14:55:36 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiBITzS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 14:55:18 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB57E0407B2;
        Wed,  9 Feb 2022 11:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644436516; x=1675972516;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=IIMObCwH80+to0quTj7KBPE+//HBUDJYiF3TkjK0VkA=;
  b=JAzhE9dRacaejyfyFciRj2BYAiMiHmqt7+WWgetFJT1Escm85/oRSKfM
   1E2CNRtEqh7/V83ULA9P4A0aCQkV+YieQL77gcIaUpRNLxUmAYlUga3V5
   Jb/PHKF+zB0LxDg7eAdRr7US1N6hPrBT/DNEXW7zu0C8GkRgaknNpddAD
   O6e+kQLUXmtHcDozVygwZzZ8yXCzzGVE/+5Stzzs7EezfSRZGPxlNzy0s
   FAQ6QjRNJW6GhvfKdJJsgiwQqjsZTd9pAUI17RyggMKZXZOGaGCJt2XVH
   vEC/H6tSyk8jS0FPAVdAr+QQxw+zWckrNi3G35N7FPgv27uH3ePrng+I3
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="335730139"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="335730139"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 11:55:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="541269494"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga008.jf.intel.com with ESMTP; 09 Feb 2022 11:55:15 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 9 Feb 2022 11:55:14 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 9 Feb 2022 11:55:14 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 9 Feb 2022 11:55:14 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 9 Feb 2022 11:55:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xad2b4q2aMV9AS36qF00nMBe188mQGzPdnk6I/p1jsq2SCzwR8nBBeNQxK/AOO2x3IYkfdQgtYlxLT9Oa2do7m5fFKH7h5PSeKz445N2TuCzpwpll6ueYvNkU8w+9EIUDV0J9kxfxqVgX/NbmUJK/lxNVfCGi+41uYEkBwcgeALJ+iHztyG8mIGJ6QTsNK12Mz9/CPW9pZWRK3POmExlPgvY89+WH6SeL78G2IHp2jmyOfg2ijuVRvgrRh/+Lpq+hrx/NNUUgdjMsdfdOW7fVy49HSFsePFQhM1m9x62vP7rVWq/ErtpFmEhauh8U1RzrbT+twoaZIBS26tnaruWjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIMObCwH80+to0quTj7KBPE+//HBUDJYiF3TkjK0VkA=;
 b=V9GO6KPhlGGIPWEKuyKN3L9OzdSILQIL/R+/8esqqJQ8Sic8MBletwKEOo9GuKdSko5uBCRJV1LzUAnATEkHBAwLBK6Hh7UAmYFa9/bjdbSeqE/1WHHCWtFwe99cXF58YztrNSrzXO+zKXq0AEAEgkSbOoBKILSzDxfW+OmSmCtYEgBDWwXfoOZ42dvc1yq1ZGcdBuE3exFSH/xNk9/Y94KIsCYFs0oE/doOKWEPJRAcWe7BWkQ3VxZmahOE1wbnqvfBuL8xLE3/0Z77h8YO2cvpaicTBNWlRpaSBBlllxBg0DgcfkGrjvhYQa2tFGf2AdMgj1R71LXCbjQ8odODmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BL0PR11MB2932.namprd11.prod.outlook.com (2603:10b6:208:78::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 19:55:10 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15%4]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 19:55:10 +0000
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
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH 23/35] x86/fpu: Add helpers for modifying supervisor
 xstate
Thread-Topic: [PATCH 23/35] x86/fpu: Add helpers for modifying supervisor
 xstate
Thread-Index: AQHYFh92EZjQ/VnlK0C25cYFiAsOpayJZfoAgAJLqYA=
Date:   Wed, 9 Feb 2022 19:55:10 +0000
Message-ID: <448d5985ea411a5bc9a3acbed45bb3b4e4b92faf.camel@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
         <20220130211838.8382-24-rick.p.edgecombe@intel.com> <87pmnxvizd.ffs@tglx>
In-Reply-To: <87pmnxvizd.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 926bb783-6583-492a-f66a-08d9ec06143b
x-ms-traffictypediagnostic: BL0PR11MB2932:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BL0PR11MB2932CF4F50D80EEB9204C563C92E9@BL0PR11MB2932.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y/EDkGc909Iqud1NX/HXZatEyYsYL+duj7jqGRa+z3eHnLR386/7tqR0S4x5a1RPaCHoq0y63hsOw5i8Caw+Ac/3F9raMD/Xmy1Zq5iVkxcqA4O5KqsriyUAE2DRL4q02aRNN/17Qy+cT9fqGtZt1lR801qSKpehKVP8tCpouvICDPwC9xFt9ZkdM6Pwa/TL2Pvbryzdd0E3pH4fL3nrozqLlgdr99OUH3pik+vjZQyqyA+zt5XLAqzNjQjNxA5nRdCDfexkVYAw3+mUv4xG2qSlQ6dwIqAS7nKl/gSdgkYRMu3GduvCdW/UKpas22TwkhRecXrnHX4v6DEQvMcH6hJNlKXpBL4mnTfTpTgrRw3Ybgf1+HIIVHx98X/ayP/IMLq4Zc587iuvKIwS8CBpKWP7+gQ64EraKXAJ/VB/VmzvG/U3k3oiBzk8QEbmwj6pPU+wYAUFE1xtbMsBQ+1YShlummCQ5H9k6Y8HTFZ0umJXd14952OxPEMH4gCbVDDhvfmW1UhjLfMVUEWeg4+ni/6obnBJAyuOWyEYM0z4rDntx53hCPWtmAKKhdBOBfxfQzKr6VOx3MnvHlh6Whroib0vsuMd5VGF5MVro/gFSX6uoIblwh/SuSW5kBBqENbYawgOPPbv1xcq+Thma/kfyh7t6j4Ls1/kdgv6cxH1BophDOHX8oM1IedPXdUaorjqvit/EE7yyuqPZo2GaYOS2FmLdM8qfXG1/Dwe45OyTTvFMHR2b5w5TftMM+d0NVDc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(508600001)(7416002)(8936002)(36756003)(5660300002)(2906002)(7406005)(71200400001)(64756008)(66946007)(8676002)(66446008)(316002)(76116006)(86362001)(110136005)(83380400001)(82960400001)(921005)(38100700002)(122000001)(2616005)(6512007)(26005)(38070700005)(66476007)(66556008)(186003)(6506007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ME9ySmsxVURpWDdvNlRRTm5oSUkyV0pFU0dRTWZYcDkya2todUtWUUtPWjBz?=
 =?utf-8?B?MThqVWh5bm1BNDFMZjBqcHpqTzV1cFcxUk81ci9RTVBQVWwvcWpJT1cvcGh3?=
 =?utf-8?B?K0VSbjRoZ1UyejdxYndoL0Fob013M1BRS2xad0xjOGFyWHNYT2hpL1ozYVZP?=
 =?utf-8?B?SEtHWGd2SGlWSlR3VUtEQnVDbDI3dXFCb05UWnpDMEpVMERoUlFRaGRjeHlX?=
 =?utf-8?B?OFJ2ZHN4Mk8yaVZlMmhpL2Z5UXJHNkh5VnVZQ21HcUJiZ1doWFRGbkdFbkFP?=
 =?utf-8?B?YVVIdUxXMDVSSmEyVHRBNXpOYi9rNUhoN3UxemRXQy9XTzQ0Qmx3NERpOFU4?=
 =?utf-8?B?Ri95d1BJNUFzNFpHTnNibmdYR2hYak55a2ZGQlNMOXR6Q0RzenNHKy8ra3hK?=
 =?utf-8?B?R1hOMGpUeHZVZWVXTVFVbUVmcGk5ZmlNRFh5Uk4yNWkxd05ZZDZiVmZxdkg1?=
 =?utf-8?B?ZmlKVW5RRUtqTzE1b0dHOWFFNUcvRVF2eFRqaEE1YXhZSndEdFJqampPak9W?=
 =?utf-8?B?c0wvOGJWRlc5TEUwa1Z1WGFrdXh6aHpkWlJhb1R1czRick9WZVlpM05Dclcz?=
 =?utf-8?B?ZWJtNUszY0NGWjJiaXA3bVFidVhieVM1ZW5jWDdwRGNFWEdtbm9VVWNUdk5s?=
 =?utf-8?B?R2RaNFQyQVZwZ2x4RDRsemNkOXBISVd0a2ZKTk9pQ2F0TnlxeDA2c0N2NUZP?=
 =?utf-8?B?VEpiVHZMaFZEVGRyV0pJUHJ5R21yRzB2WnhlcWtjSWlYdUtuaDV1ZEpBY0Rk?=
 =?utf-8?B?L09WWUJBbzRlMHRwalQ1dEtmRGJpT1MxNHYvM2J5NmhSLzhVSit4dmIxZmpN?=
 =?utf-8?B?d3JjblpaQ3JMWUtxYXBIMXFVS0FjY0djWUlWWmh5ZFRSSS9zNTc1L1pkQ2xR?=
 =?utf-8?B?ODNFVFFJSkQ2dy9pTm10MTBMeTdBLzVURktuMjF1QWV3S2c1eTJJVHd4cU9P?=
 =?utf-8?B?bzM2N245bjhJUzE3cG4zNmMxd0ZSRVNGWUR3TFpXTE44QU5uTW9qYzNtemw4?=
 =?utf-8?B?VitBVzIyeEFieXYrTHVPK2dLUVNsbEo4TmYrTG5DRmljaEdhWG5CdWdoRWpQ?=
 =?utf-8?B?TmFRdTdkRXhsdUIrZEVCSms1N01uSiswL1UxRXJRZUwyZ1FmUlROZW56NHdY?=
 =?utf-8?B?MHZPM1pid2tMNmIzYUMvMkxDbFgyRm42Q1ZtOGVneWdEMXVQSFBKbitodENx?=
 =?utf-8?B?SUcwanpzbnlNU3pVcElnUUMraHprUTdyWEcxNUxqdkhZOUYxbU0rSkxscGpL?=
 =?utf-8?B?dG1FNnl4TzZmSVhEM0l4dmRsTzRVbGp1U1I2ajJucVZHS0hHMi9PNFU1SE00?=
 =?utf-8?B?WmJiSlhkc0FTMk14MFBwbUQ4YWxjdjIxVXhJM2EycjNKQUlRUzM3N2JVZ2Q0?=
 =?utf-8?B?S1l2dnJQR2FQUmc0elIzL0NwYnZ2VSsvNkNHNnVOZ1FNUDBjSTdxVkpuTTRx?=
 =?utf-8?B?YXRFYWhwL3N6UDlrUnl3VG9YT3VXUktmQm8zb0FoaWxZZmN1bXpacnBvSnlx?=
 =?utf-8?B?MDZXK1BVTjd6b1VxOUZlYlFjRHFBeHJybVduRDZNbDhYK1N2bmtXK1JSVERW?=
 =?utf-8?B?V1VDY2FyckJGMmF3RGZXZnJGZ2Nybkd2dDVCZDdrcC9KaldaclJtL216VnUv?=
 =?utf-8?B?Z1RLdWFNN251dXZlR1N0dlZjTzZhY3dvWjhjUkIydERlV1FvVXJtcCtSd1hQ?=
 =?utf-8?B?UHBhZGtINlNEOGxRQTE4UWZsZDdaS01aSUdZRTI3TlJKU01uWFZIWWdNVy9X?=
 =?utf-8?B?SHNHNWovaUpPWnRPZmkxMW1KaTVYYnlCZW1lRXdTLytQQmFDakV4eVhxUDdV?=
 =?utf-8?B?eVczbnNrUUxOV0ttTWo5Vi85UEFZLzZRTEhKbi9vVEhTdk9lOWt2aGJOcmVN?=
 =?utf-8?B?U3Vpdi9UWXFVRUlTZk1OT082N3Vhc0x5L2NUZm9rNktkbm5WWjFWaVJ5b2pI?=
 =?utf-8?B?b0lLbkppTXlpNmVYQkswRUdkYzFmcERDVmpBb09TTytmZzg0N0RYTWlBOXVM?=
 =?utf-8?B?MFRoS2hWaGlOWXJsaFg3andsTExidTh4RjNzR2hkazMvTDhxZTdSWXl4eS8w?=
 =?utf-8?B?akVqaklsUEd3Q3JLTk5LZVhXaG1pV3pFTU9aM1FXdk13a3liN0FhSm9oZ1Ex?=
 =?utf-8?B?dllUa1I0T2Z3L01IT2lJYzUyVk1kTlFPU2o3VjhHRmpxdjk0SHBmOGNOUGNI?=
 =?utf-8?B?OU1zcUJRU0I0by9Ga05VaUZVdy93Q2M3QzhHTDRKcS9uVy9LeDZlQzI1Y2lN?=
 =?utf-8?Q?KUyNjB+4xU7RrD2tq3J60kIAw32qsztZ+eVyIVb2KA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB8C4C5BC050474A8D41BA6EC8459182@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 926bb783-6583-492a-f66a-08d9ec06143b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 19:55:10.1975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bC8vyAMpwVkLvPd3Ade1tDi/jBkk7MUR8auXYFQz5rhT5j789t1+zEYMqZTMgU4X/d//WAf+wMWwo8z2PdfwC2K9a7jTbCByp6ZzUXNMNsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB2932
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

T24gVHVlLCAyMDIyLTAyLTA4IGF0IDA5OjUxICswMTAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IEkgbGlrZSB0aGUgYXBwcm9hY2ggaW4gcHJpbmNpcGxlLCBidXQgeW91IHN0aWxsIGV4cG9z
ZSB0aGUgeHN0YXRlDQo+IGludGVybmFscyB2aWEgdGhlIHZvaWQgcG9pbnRlci4gSXQncyBqdXN0
IGEgcXVlc3Rpb24gb2YgdGltZSB0aGF0DQo+IHRoaXMNCj4gaXMgdHlwZSBjYXN0ZWQgYW5kIGFi
dXNlZCBpbiBpbnRlcmVzdGluZyB3YXlzLg0KDQpUaGFua3MgZm9yIHRha2luZyBhIGxvb2suIEkg
aGF2ZSB0byBzYXkgdGhvdWdoLCB0aGVzZSBjaGFuZ2VzIGFyZQ0KbWFraW5nIG1lIHNjcmF0Y2gg
bXkgaGVhZCBhIGJpdC4gU2hvdWxkIHdlIHJlYWxseSBkZXNpZ24gYXJvdW5kIGNhbGxlcnMNCmRp
Z2dpbmcgaW50byBteXN0ZXJpb3VzIHBvaW50ZXJzIHdpdGggbWFnaWMgb2Zmc2V0cyBpbnN0ZWFk
IG9mIHVzaW5nDQplYXN5IGhlbHBlcnMgZnVsbCBvZiB3YXJuaW5ncyBhYm91dCBwaXRmYWxscz8g
SXQgc2hvdWxkIGxvb2sgb2RkIGluIGENCmNvZGUgcmV2aWV3IHRvbyBJIHdvdWxkIHRoaW5rLg0K
DQo+IA0KPiBTb21ldGhpbmcgbGlrZSB0aGUgYmVsb3cgdW50ZXN0ZWQgKG9uIHRvcCBvZiB0aGUg
d2hvbGUgc2VyaWVzKQ0KPiBwcmVzZXJ2ZXMNCj4gdGhlIGVuY2Fwc3VsYXRpb24gYW5kIHJlZHVj
ZXMgdGhlIGNvZGUgYXQgdGhlIGNhbGwgc2l0ZXMuDQo+IA0KPiANCkl0IGxvc2VzIHRoZSBhYmls
aXR5IHRvIGtub3cgd2hpY2ggTVNSIHdyaXRlIGFjdHVhbGx5IGZhaWxlZC4gSXQgYWxzbw0KbG9z
ZXMgdGhlIGFiaWxpdHkgdG8gcGVyZm9ybSByZWFkL3dyaXRlIGxvZ2ljIHVuZGVyIGEgc2luZ2xl
DQp0cmFuc2FjdGlvbi4gVGhlIGxhdHRlciBpcyBub3QgbmVlZGVkIGZvciB0aGlzIHNlcmllcywg
YnV0IHRoaXMgc25pcHBldA0KZnJvbSB0aGUgSUJUIHNlcmllcyBkb2VzIGl0Og0KDQppbnQgaWJ0
X2dldF9jbGVhcl93YWl0X2VuZGJyKHZvaWQpDQp7DQoJdm9pZCAqeHN0YXRlOw0KCXU2NCBtc3Jf
dmFsID0gMDsNCg0KCWlmICghY3VycmVudC0+dGhyZWFkLnNoc3RrLmlidCkNCgkJcmV0dXJuIDA7
DQoNCgl4c3RhdGUgPSBzdGFydF91cGRhdGVfeHNhdmVfbXNycyhYRkVBVFVSRV9DRVRfVVNFUik7
DQoJaWYgKCF4c2F2ZV9yZG1zcmwoeHN0YXRlLCBNU1JfSUEzMl9VX0NFVCwgJm1zcl92YWwpKQ0K
CQl4c2F2ZV93cm1zcmwoeHN0YXRlLCBNU1JfSUEzMl9VX0NFVCwgbXNyX3ZhbCAmDQp+Q0VUX1dB
SVRfRU5EQlIpOw0KCWVuZF91cGRhdGVfeHNhdmVfbXNycygpOw0KDQoJcmV0dXJuIG1zcl92YWwg
JiBDRVRfV0FJVF9FTkRCUjsNCn0NCg0KSSBzdXBwb3NlIHdlIGNvdWxkIGp1c3QgYWRkIGEgbmV3
IGZ1bmN0aW9uIHRvIGRvIHRoYXQgbG9naWMgaW4gYSBzaW5nbGUNCnRyYW5zYWN0aW9uIHdoZW4g
dGhlIHRpbWUgY29tZXMuIEJ1dCBpbnZlbnRpbmcgZGF0YSBzdHJ1Y3R1cmVzIHRvDQpkZXNjcmli
ZSB3b3JrIHRvIGJlIHBhc3NlZCBvZmYgdG8gc29tZSBleGVjdXRvciBhbHdheXMgc2VlbXMgdG8g
YnJlYWsNCmF0IHRoZSBmaXJzdCBuZXcgcmVxdWlyZW1lbnQuIFdoYXQgSSB1c3VhbGx5IHdhbnRl
ZCB3YXMgYSBwcm9ncmFtbWluZw0KbGFuZ3VhZ2UsIGFuZCBJIGFscmVhZHkgaGFkIGl0Lg0KDQpO
b3QgdG8gYmlrZXNoZWQgdGhvdWdoLCBpdCB3aWxsIHN0aWxsIGdldCB0aGUgam9iIGRvbmUuDQo=
