Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED83C6A21AD
	for <lists+linux-arch@lfdr.de>; Fri, 24 Feb 2023 19:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBXSkR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Feb 2023 13:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBXSkQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Feb 2023 13:40:16 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344D46C8C6;
        Fri, 24 Feb 2023 10:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677264003; x=1708800003;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jYw2dz/5C0IiFAE7G4p090thQB6TgN8jMsnmhWwhxkM=;
  b=UCexXFisjrugQwlOYW/SSxmge1c0mdBQYaEn1lAkDaWKKfovu2BaraRI
   wk7Gy5C00Z7l82DU+J9F92YDViHWEjyQQk6ksrJLpbJTUvuXS8GtJzHuH
   OufTV8JtXwNpcHv8jDrDUQFfCf2cGqBhsbmnSSI4VCzISCBo0dM4PNJvF
   u3iZQ+MhiszFPXsCk2CF3MS4JytrCfx/AeEtXQ2c57Jz82FnzepLhgAZJ
   iUBJf7CzDeHHuiy39QgFwhsygh64QtrjGDmG6Y8FdeQN8b7f5abjqd3PO
   JDfDChQuYW/QltWMn2aaLWlf0bxp6S4vXvY0sfEsAHp/4TwK1Nh0nJsID
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="396060595"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="396060595"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 10:40:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="1001918721"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="1001918721"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 24 Feb 2023 10:40:01 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 24 Feb 2023 10:40:00 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 24 Feb 2023 10:40:00 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 24 Feb 2023 10:40:00 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 24 Feb 2023 10:40:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMJXzYS5Ytlpf54mSBH67zaoRiGRnpF924uHhZ6oxcUE6fUbcO6WzX2NN8Z7mUnE8gzIOVmPlmZtjOutL+/tZqV5wWvEkFV8SWIk8chFx5RIgx0a0JUcpx4IYmSGt3P4BnmU1qMkRd8hnj1yQah3Kgi8yN2AC65lOAa03fOi1nCwMMyhcHmAlri6lhLckOVtrimNvElKmV+6rb8jPTWPhNBA0SmqBfsBfWyaREPfdfMiBd3waT37wsdt3ga/2mVKWBY/qXqpSgY5lCviCeqCPgSMQMJ5HnzHCjD9T1leeBXtbgEWQOxWPGw/ofWux6mh2EwkXoDXQ5Y6/CLEtq7aXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYw2dz/5C0IiFAE7G4p090thQB6TgN8jMsnmhWwhxkM=;
 b=nAKsjCGEFwE7sN+j+eEU0RqL5JOk8uT2AMXEHTNVW6h8PphuT4D7Cp+RQp06x7PTYrmCyZChjoEWHw/59Ys39WrDW2qliaLeNWs7QEReEfky4S1hGAvYCPdggGtB59IkiYT4Dn+i4ueoLmQWir4vda1SPEEus58q3vlr8bYYxz9rF0BBfognnb88EzZty38Y+TGDwB3uXBD1AbJWDn5ZD+BTUCuZVHYOOt+69BnRBQ1TIwSz9VQPRA4nGg5OawcCm7//5CvsZW05lLdjTvcpv87Sbbw3NhgsTno4KtkK8IwHcO7wjXIjVW0zQOCTHlDSqMJWOj9FGeudD1UO2qGQrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH0PR11MB7562.namprd11.prod.outlook.com (2603:10b6:510:287::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 18:39:57 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6134.024; Fri, 24 Feb 2023
 18:39:57 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
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
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v6 37/41] selftests/x86: Add shadow stack test
Thread-Topic: [PATCH v6 37/41] selftests/x86: Add shadow stack test
Thread-Index: AQHZQ95ICJxsx2cypUapk1OQ308pxa7ckxuAgABFBgCAAStAgIAAc6oA
Date:   Fri, 24 Feb 2023 18:39:57 +0000
Message-ID: <683c1cfa0b094f938a96efa8caea4311a3b42f3e.camel@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
         <20230218211433.26859-38-rick.p.edgecombe@intel.com>
         <Y/duhySUieqUWoGX@zn.tnic>
         <5fe0874655a7190a6ea5a070584d2603522f4395.camel@intel.com>
         <Y/ijdXoTAATt0+Ct@zn.tnic>
In-Reply-To: <Y/ijdXoTAATt0+Ct@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH0PR11MB7562:EE_
x-ms-office365-filtering-correlation-id: 0947b5e7-9107-4281-ae49-08db1696874c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: giLVpGqVwhhVVStgbrw3oj0BbJM/CPJiSlT6xG2wf9EOJJu6s6roJ6PxKYZNdbGMDCnlf4PZpkAaUo8fOrRyT75QwAlY2e4nR6NYgMu8d8GuUsp2feIVVWviq+bkVU4jy/IuIBekd2esgrV94B6hL+9/AOCYnwZPsj4iX35HeWIXcIdEV+vY0+oMfrF3NxqI94fxcK8upwq1/BWyff2QvAhePUUV4Z6/R1Qyp9p+rojLLvkUM/UbNOew60c7QsXx88SIESH6KQdJEJm7svHa+PLyi9qfFaCGsN1+sSWkqInkkjOXqNcwcfOtqF9CRwC8I2Ds4pea4J0InbWBL3V/JmXoWNbBuPGxMlfuyBA4TtOnvCDidtocIbh1PV18lKanGe2zKEcdFd16l4ieaYEZx55RFIZ+ANjjRX5SFjn7yGaz0V2jGU77MmJkjqqBpaHiCyX8hjpVXPBw12EqV7ZbO481qvRXhyHRgV5bIAG7iaJU7OxDmE6TgCSFCs/RYxMuNIzzdbne5TYiYz403p5ooYsQUP8ERbDiD/GsmQ4DZesV+LEOLTu1Rq4x1bCQcjaTNH6VgvhYEyoerUiNg0OHumuVnFZyUEfwzi25qmPIcIazSGq17uWZpimV8kL6kmsMxOl3aPHRgAEj1E4vwSbwiKOjloukvVrB9GfcWFZb1rHbObhjgl95dJVL8jYXZVqJJ90ZgMKQrh888XBOmZ2L4eelKCYz2CxId1w2MFJibgs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199018)(8676002)(316002)(54906003)(91956017)(66946007)(66476007)(66556008)(76116006)(83380400001)(6916009)(66446008)(4326008)(64756008)(38070700005)(41300700001)(5660300002)(7416002)(8936002)(7406005)(6506007)(186003)(6512007)(26005)(2616005)(71200400001)(478600001)(6486002)(86362001)(122000001)(36756003)(2906002)(82960400001)(38100700002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjNCT2o0RU1xVmVkcnVGaWVQWDNWendia3ovNHdHV0RQOEhSZDJhZlptOXFR?=
 =?utf-8?B?YjN1UFMwN3l3MjJpSkpzNVFMamNBR1VBaUFWbm5TQ2hOS3dZbmhKZWFmM2tM?=
 =?utf-8?B?REFZbG1zOHI4bmhGL2VBdzZxYVFieFpQMjVndVNGenpJRzd4SW1mMFFjYkpz?=
 =?utf-8?B?YUpIc2ZlMmdUREhkaU9yU3pva3gvUHNjTWpBbnpSNGdjeWJuTWVFYUl5NUN5?=
 =?utf-8?B?b2ZIcUZFalo0TEcwaWNnY0FidnROd0F4d2hsaWk5a1FVZVBjRzc3UmVaUW5P?=
 =?utf-8?B?em1wUHVObzE0VmlZeWhrY002bnJWS3cxdUZIZGJOTytybGxDSXRlNDVhalFR?=
 =?utf-8?B?YTRnOUFMV09FdUx2VHIvdHVWT0hxdUZIeW5ueWtaRXQzQXBZdEZxZjhhWkx5?=
 =?utf-8?B?WXkzWndmMWFGRUtJU2lmVFhjSDNraHZVdXkzelRUM3NVbURWSTJOcHhxeFkw?=
 =?utf-8?B?YlFXM3BNaFh2VFlnMmdCQXcrMTM1K1poT1ZYUkczN0J4MVZueWNncDVmc1FT?=
 =?utf-8?B?ekxUOWxHVHZ3c21yWkpOWGxqbGFUTzQvZm1sV3ZZeHMvWUE0elBwc2c5L2RH?=
 =?utf-8?B?cWVWR0ZGS2lhbXBVUDJJNHBVSUdlUHpRbGorb1NwaGgvZkhtckd4UzFKWHdI?=
 =?utf-8?B?U2hYZnJoNmdpbFEydW5yRlFYeUxiYU1jdVdWbEpadVp3dVZVZGlRTHFFSWRK?=
 =?utf-8?B?WWV4Y1RFVEZBYkpJUzdweWhlVk9KSndtd0d6Yjl4d0hHWnIvMHBMTEdZaEpx?=
 =?utf-8?B?eTRXZmZ4Yy9MRHRJaUJhMjRsRkhhSHFrYmQ3K25BN09jWFFnNW5HODZqajR5?=
 =?utf-8?B?dTNWTGJaaDZpOVIxSUoxM2VkMVVIbzMra1pzNzAxVXE3NmQzR3NmcGJVMmh0?=
 =?utf-8?B?UXYwNURxVFY1SlNWcnl0M3F6VEg0MkhUUWJCemNScEJyZ250Qng4b2RJVThj?=
 =?utf-8?B?UTY3d2FHT1MreTNaSU1xN1JkNlBBckNTcFNJL0QrVWNKMmROMWloU2wyN2x3?=
 =?utf-8?B?dk5FY2lndVZyMG9aMWFHUlRiY0FLanJCT25vNmdNOWk5WHpxL2tpbkRHYUdM?=
 =?utf-8?B?eTZzNzVlWjNtZjNhQVY5cWpYczZHUWJMNCtZazJVZHNRVzZUc2pzUTZZRkxL?=
 =?utf-8?B?c0c1R2x4elZIMnMyYnk2d0YvYXR0cjJBUDMxV2kyeWIyNTE4QjFYL3M4MXFp?=
 =?utf-8?B?QjczTUo3R29helVDaDdhWFBueGxvcUtWcllTcmY2bHBxL2l2aG1BUGRleC85?=
 =?utf-8?B?eDlFRVVjUTBUTGZocGxROTE4V1haeDZhTi9hL2hISWdkTklNTWt1RWNRUkN4?=
 =?utf-8?B?VkFFMm9neTU2b1U1eTdLMVNiK0NTS1RpMGh1bTRmNmg2Rjd0NWpuTFpKSmZp?=
 =?utf-8?B?b0U1bm9ERUw5MUNZaUJ6Y1BJc2dsK0FJSDJSU25ZL1FWOGdyaTZjL2IrUkFp?=
 =?utf-8?B?M293aWQ3SFNUTE12cDE3LzE4REFHcitmczA4RTErOWpiYmpGNHV0VGZXcUFV?=
 =?utf-8?B?TG9pVXVpdE50aldtR3FlU05yQi9mSlhnVGloRzV0TWtIakhMTWZ2SmxuM04y?=
 =?utf-8?B?SEJIcXFqYlNta3BoUkpZYi9wajNpVjc2bjMyYm96eDRRMDYxTXdSNEVtckZx?=
 =?utf-8?B?Z21va0cwc3FnMlJwZFFmU1I5cC9YZEZHMEJnbEF0SDdiei84VjBockxMTXVE?=
 =?utf-8?B?M3RCbTlGaWw1dGdwV1I3aGdhSThKeXlMeXhmSU5wNWIyencrbkpFaDZ1VUlj?=
 =?utf-8?B?UHZOb1dGWkl4NVBiaHRzdDlWSEZubGFwQ2U4SktxeWhMWElSaUtlMlhBYi9o?=
 =?utf-8?B?Q1d0WEp1RTZtWDNGK3oxb2tYMUhjY1YxYUtBZVRiajZUNTdic1lIQ3RGOGVi?=
 =?utf-8?B?QkFXNFVqMG1FOWFleXo3eVZSd0hheHdZN05DYkpmUlVaVlVtRmxiTEZRUXVn?=
 =?utf-8?B?ZUs5SGU0SE01d3h4cmFQMU9PRGVLczNtK0RDR3BQc05zeGs1UFNubk1OTVgr?=
 =?utf-8?B?Y2ppTGJWZE0yR3lRNU1XeFBNbUZ2bWNDT0pUcnZ2UXBqc1ViRnkzRkcrUUg0?=
 =?utf-8?B?RzUvZCs4VTJpY3JPb0xNb00wQ0puQnVSSUlWS29LYituL1IzR0d4cU1vQktl?=
 =?utf-8?B?dEJnaHN1Tk9tVHBWQ0JYQk9Ld01CWlozYU43cTZ3MHhwOGErUFdyMVZZS3VL?=
 =?utf-8?Q?TOF+rI6lTMyhVf1JMAcv0yc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E57D266DE507744B3AA787E264F337D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0947b5e7-9107-4281-ae49-08db1696874c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 18:39:57.3443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aRfw8YEbAWod524MbXIG0hlD2lQSrDAlxzVE9fSgn2BYgpymxVA1sK3fc/VHhInE/vJriJykltALYFxItdqnSG+gyVLyCJXrLgp/d0OyDaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7562
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIzLTAyLTI0IGF0IDEyOjQ1ICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFRodSwgRmViIDIzLCAyMDIzIGF0IDA1OjU0OjU1UE0gKzAwMDAsIEVkZ2Vjb21iZSwg
UmljayBQIHdyb3RlOg0KPiA+IFRoZSBwcm9wb3NlZCBNYWtlZmlsZSBzb2x1dGlvbiBzZWVtcyBh
IGJpdCB1bnVzdWFsLiBXaGF0IGFib3V0IHRoaXMNCj4gPiBsZXNzIGNvbXBsaWNhdGVkIHNvbHV0
aW9uIHRvIGp1c3QgbWFrZSB0aGlzIGNhc2Ugd29yaz8NCj4gDQo+IEkgbGlrZSBzaW1wbGUuIDop
DQoNCkRvbmUhDQoNCj4gDQo+ID4gU28gYWx0ZXJuYXRpdmVseSwgd2h5IG5vdCBqdXN0IGFsd2F5
cyBlbmNvdXJhZ2UgYnVpbGRpbmcgdGhlDQo+ID4gaGVhZGVycw0KPiA+IGJlZm9yZSBydW5uaW5n
IHRoZSBzZWxmdGVzdHMgYnkgd2FybmluZyBpZg0KPiA+ICR7YWJzX3NyY3RyZWV9L3Vzci9pbmNs
dWRlL2xpbnV4IGlzIG5vdCBmb3VuZD8NCj4gDQo+IHMvZW5jb3VyYWdlL2F1dG9tYXRlLw0KPiAN
Cj4gSW1hZ2luZSB0aGlzIHNpdHVhdGlvbjogbWFpbnRhaW5lciBzYXlzOiAicGxlYXNlIHJ1biB0
aGUgc2VsZnRlc3RzIi4NCj4gVXNlciBzYXlzLCAidWggb2gsIGl0IGZhaWxzIGJ1aWxkaW5nLCBJ
IG5lZWQgdG8gZmlndXJlIHRoYXQgb3V0DQo+IGZpcnN0LiINCj4gDQo+IFNvIHdlIHNob3VsZCBu
b3QgaGF2ZSB1c2VycyBoYXZlIHRvIGZpZ3VyZSBvdXQgc3R1ZmYgaWYgd2UgY2FuIGNvZGUNCj4g
aXQNCj4gdG8gaGFwcGVuIGF1dG9tYXRpY2FsbHkgZm9yIHRoZSBkZWZhdWx0IGNhc2UuDQo+IA0K
PiBJZiB0aGV5IHdhbnQgc29tZXRoaW5nIHNwZWNpYWwsIHRoZW4gdGhleSBjYW4gZG8gYWxsIHRo
ZSBmaWd1cmluZyBvdXQNCj4gdGhleSB3YW50LiA6LSkNCg0KSSBndWVzcyB5b3UgYWxzbyBjb3Vs
ZCBydW4gaW50byB0aGUgcHJvYmxlbSBvZiB1c2luZyBvbGQgaGVhZGVycy4gTGlrZQ0Kc2F5IHlv
dSBjaGVja291dCBrZXJuZWwgQSwgYnVpbGQgaGVhZGVycywgdGhlbiBjaGVjayBvdXQga2VybmVs
IEIgYW5kDQpidWlsZCBzZWxmdGVzdHMuIFlvdSBnZXQgc3VycHJpc2VkIGJ5IHVzaW5nIHRoZSBv
bGQgaGVhZGVycyBmcm9tIEEuDQoNClRvZGF5IHRoZSBzZWxmdGVzdHMgZG9uJ3Qgc2VlbSB0byBk
ZXBlbmQgb24gaGF2aW5nIGEgLmNvbmZpZyBvcg0KYW55dGhpbmcuIEJ1dCBhdXRvYnVpbGRpbmcg
ZG9lcywgc28gaXRzIGtpbmQgb2YgY2hhbmdlIHRvIGhvdyB0aWVkIGluDQp0aGUgc2VsZnRlc3Rz
IGFyZS4gQnV0IG1heWJlIGl0J3MgaG93IGl0IHNob3VsZCBiZSBmb3IgYWxsIG9mIHRoZW0uDQpI
bW0uDQo=
