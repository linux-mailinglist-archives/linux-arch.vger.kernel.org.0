Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3230690EE3
	for <lists+linux-arch@lfdr.de>; Thu,  9 Feb 2023 18:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjBIRJd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Feb 2023 12:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjBIRJ3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Feb 2023 12:09:29 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D625FB60;
        Thu,  9 Feb 2023 09:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675962564; x=1707498564;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Skz9cH4xM+VGe0DSlzT0QriOPtzZROt3GsF9SCDG2Gw=;
  b=UrMNkY6Ufej3GMGOu5IdTxXAfR5kMPcJ5/brbwcxSxFGvjnLgPhwZXb7
   k6KJsAfFz5XNZBPGbU0adWtSujNfhZNr5e4gzujp1RqwWAjPdFt3SK5ks
   jO+dBE4ZvUBtzDglRLlqRgCvJ12PE+wZc1ygSvxo0U1BZm7MjPDudH7xL
   ZTU3lW7uuaL+DgSUyIfvsSizglTgjFb9Rkj90EegWkS2KHvU66SJSCtmc
   Snd2liynwsWsYamODhkwsUSN6L+D7xSqr0Hc1oPdzjKwsAeWWzfNY/qk/
   lam3T0Pzd89HrAAhgKHlw7DZiDLmZIndLrfnq+isb+ntQbzdJMJSp9iao
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="309815715"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="309815715"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 09:09:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="698100415"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="698100415"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 09 Feb 2023 09:09:22 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 09:09:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 09:09:21 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 09:09:21 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 9 Feb 2023 09:09:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGDiQQv9nUMLd2RBcNLnfemjewV61cpsYDu+HE2pmNLlDbdFFmNEl0IIHgc5eFV+I8b926p8yH2733xzuC0cUyg4GPp5zMyeAXQ8jNn5OdMCPBczm37ER1mWr9R2NjcFBn3AiaheMT6yH8x95NzHm1Ka2fVKbh7xQa14rgDcyRtMbNidbcDslFPb9O4wDNarl69FFIhLBUrY0H912u4HdLbYVNXI3s75KdgU0/GjhMtOE+BuDktc0JNBTaPWkxRLFyNhFFucGWQnY0l+5TGFTLndOK6F6MSd2S+hcp9p3c2WfaBS3tAT1In7W46oPanUYf3Z/ZbHEVuFFSbS527JFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Skz9cH4xM+VGe0DSlzT0QriOPtzZROt3GsF9SCDG2Gw=;
 b=RUUHdOFGZbIAdjFmTBN83fGjeizynhWQILI6OpdA68L009uGeDTxst7O1UqYoeaZAqIq7RapJm9Vq1ADKrtzre0Sj4Yavz6BJgiI/rHfH75h30I4s97Lo+YOTOK0yRQZGdFiBu9iOXWtLHVuucuAOx0FZQ0P774qO+5bN7IFfZFM9wgPzeeMf9YiwPm5dxyGuRD5ikPOHEZB4G48ZMqptHvDNKCtIZN6GB9U1L8B7KAsfHR6THmZEUVA2iCKQoPA/fUB3lFHMDFVDvfoI8hvJGABHWAQxvjzIo1tyRPd6/aogsHZsWnnK4hE8cHVDuA9wJ5FZbtgyB0nIrWG7VYe9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DS0PR11MB7927.namprd11.prod.outlook.com (2603:10b6:8:fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 17:09:16 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6086.019; Thu, 9 Feb 2023
 17:09:16 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
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
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v5 11/39] x86/mm: Update pte_modify for _PAGE_COW
Thread-Topic: [PATCH v5 11/39] x86/mm: Update pte_modify for _PAGE_COW
Thread-Index: AQHZLExwXsVvVi7azU26l2oZqLTgOK7Gx2uAgAAydAA=
Date:   Thu, 9 Feb 2023 17:09:15 +0000
Message-ID: <49d20fcd197e85e8475f5170db78780f06396cc0.camel@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
         <20230119212317.8324-12-rick.p.edgecombe@intel.com>
         <Y+T+ZxydCZS1Yjmz@zn.tnic>
In-Reply-To: <Y+T+ZxydCZS1Yjmz@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|DS0PR11MB7927:EE_
x-ms-office365-filtering-correlation-id: 08257d2a-d3a2-4408-f02e-08db0ac05f69
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RSqVBMwZxXOhMH+f4IRen8/H/1NTf+lhtJFOZpNz3jlSCZpmQBaO1hlwRf2+iQFbiEDGTx8mL/JKXgL23qA82XayufluEXkBAnHr6o6P2y8vGqCqtqT4Gl60TLqsg4FrxkOa9g3ewz8wB5kYXUjDxFnbBceqfDUv4JUgBr65UriWJN4CpxfZqj5ZCCgMQbYTBsKpiRd7J+8od7hbIYfQaaLuwc8kMOE68yrvLc4OuzecrU4tCcc+19RKb7+wrtbFLa6p+alEZ/K1OEqxCg4P0NTHCh9+HTVZRBP9C9kgswiVhlsaKglX+ygc3C+ZHfYlhbJTD9G3dDRpLozi6+AZi8iz2iElZ2NKSwO8qKhMav+8yExdcIU6WWT1K5x8xRY7784V6EC3s/qyJTiQOmznlWDEghaPCTlk6jYbUK3kj652kPkrZWNhXVjeoqf4HcmZtx5ZVnp71LC+BukS1YF8as0+5FdHYFNesCuy/5E/awAZvVGS9/nAYlBY5puUdK7pDBqNO4j85LI6HeWsy8RyxhGiHN0d2h8GhHuWcdQIjenRj5uefMrIHI25SsGYuGmjYBQAa7nTHmSKFCOB6Q1ucpTuoKRrY8GqNkOjVg0tm+CsnzV5yPbD2J1k+m0jRHLmtTnLGhJjvUpWjmJW4vF17QoG3/H+QR66VnbA8l2kI5gtT1JBVW9UhSGuBiGVphM/09byzheRxT+JFVpleDKZTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199018)(6512007)(316002)(54906003)(41300700001)(38100700002)(122000001)(8936002)(82960400001)(36756003)(15650500001)(2906002)(7416002)(7406005)(5660300002)(83380400001)(91956017)(66946007)(66556008)(76116006)(8676002)(4326008)(6916009)(66476007)(64756008)(66446008)(6506007)(478600001)(71200400001)(2616005)(6486002)(186003)(86362001)(26005)(38070700005)(66899018)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THRvQkhtUVhCOVo0U25IaTIzaTQ2UTU4SmhaZkUwNmZTandXc2cwRWs4dHR1?=
 =?utf-8?B?RmhwaWdGNmdrQThoNE5IeHVIOTU5UWxLaW5pWGlqNzJFSW1TOVN5YXV3WVJ1?=
 =?utf-8?B?b0h2YVplcmtTeTB3SzJPeTJsZzBYSUVNVTg3NElvRXl3aXduZVVCb1JXejNX?=
 =?utf-8?B?RUptUE50NXhnT2N5U2JBV0FFZmZQZTVkdE9qWGMxeGpQWUQ1dW9hbVZ3WWti?=
 =?utf-8?B?aWsvUHljR284S01MUExaZ2dpclJia1g0L25vSE9LQkdzVlZsQVMvQm92Mzkr?=
 =?utf-8?B?TXp5Rm9lVnplMkNlTDIzcXdLM2NXa2M1cjVvQlRKZEs2UGNHRVoyZjVWSlJS?=
 =?utf-8?B?WjcyV2ZuYjBpOTVOSVZIbGE1ZXpUTnNCS25SMVFmbktLR052UVhqTVNOYnhN?=
 =?utf-8?B?b2NoL1FFU1pNa1BidndIczZNRnltWEJnOC9URW1tWmZzMlRCbThwQTJTTDEw?=
 =?utf-8?B?ZW1NejJXejdVQThMQlVhcTVDMTY0djlLN3c0NkkyREFTSmxSYVFFMUF5aE9x?=
 =?utf-8?B?SjZKQ2FGaHQ3SFd0Q3h1VkNBUGZZcFdneGRhZ0pTeUw3TTRvQUJsb21RMHZ5?=
 =?utf-8?B?cVl5ZzcwYldmVzhqOHYxMXVheVFCdkExYkZkZHhRZnN5NEEvL0VFNHFkcUxO?=
 =?utf-8?B?ZVlDMkhlTGZoQXdnelVzakowMkJPeWUxNzB6aGVPMzBQTWMyd1ZYNCs1M3pE?=
 =?utf-8?B?alBSYXgzblpLL01vRGxVTFpNamFvdm0zSElCSXBXbTdMMlNDblNHQVRHZ2lx?=
 =?utf-8?B?em1CYStyWlFCdEM3eHk3NzFycUlsT2xneVVZS3BwUWRNc2s3TTc0NGUxWGR3?=
 =?utf-8?B?bXF6bXZlY2lLdmxoam5iYW10N0Q2SnRmSU5MUllvejM5L09qdGtNQWxwVEJN?=
 =?utf-8?B?RlF4NzVpTmVTdnVnVlNqcmVnTHBNaXVERUtzZkJBaTRDM2tKeVRGT1ZxUFBR?=
 =?utf-8?B?NUdkdWw2Qit5NndsSlBUb0h4MjBlODJNbk1GeVI5Skh3eGRtYzFTV0JkVE14?=
 =?utf-8?B?QkdKZVRocG9mWElNTjdzajJZVXAyazVGSjZpK21BeEcySkdzbVoyOG04aDZQ?=
 =?utf-8?B?VEphVDZTR3VNNnFtdW9hSnJaTHFVN1ZwZUl2VmVHSFNIeWY5SFhJTDVLZ3pn?=
 =?utf-8?B?MHJGUHdvbENLYXROVER1dlhKUUUzVDlPRWdmYzFFQVlQQUg2dEVOTW5vQWRy?=
 =?utf-8?B?cVI1YUJGU0ludS91WjkrTUFFQkkxeGl4VXRqWUZZV3FPNVlsVTBGY2VxeW82?=
 =?utf-8?B?d0VCcG1vTU1SOFQrbGtUTExFLytnSUFWei9PUmdzMU01T2JtcUtYZUxsWG9Z?=
 =?utf-8?B?K0lWMHpkLzJIR2pYK0ZCRkpTTWY3cCtBQTNqejMrYk9XQUh2dE5iV1NOR09n?=
 =?utf-8?B?cE5ranp0V0RiUDRrSGgxbGkyZnJMTENEUmp0Z2JpK00xYkRTWC8vUEpNYkpI?=
 =?utf-8?B?bDczOFNwWUduQVNwbXpyMFBvSnE5UUMvcFA4RjhBbHZUVVNEQXpJcHQxZS9y?=
 =?utf-8?B?NGU2ZmNCL1RjQTRSWkNLanU3cXJQTU0zNWdQR3hFVTB6SkRDeVlpWkNWUzdy?=
 =?utf-8?B?ZXF5djdXTXhPZmVkTmRESHR3Ump3c0h3TTVSRVlmVjJiSGJVS0ZWU1lVd0dL?=
 =?utf-8?B?U2pvdEdDS3FMWFgvbVZCSXJWTUJYa1hOTC9YSXZoNDZ6NHUzQ3NoeGNUcy9R?=
 =?utf-8?B?ckNwU09lSWtkNlZyOXFWdWRFVFNwYmw2N2pGMnZPU3NyOS9Xci8rdjlmdG1s?=
 =?utf-8?B?VUlpNldCVTRhK2ZtVnR1VWZ3UmMrZkUwV2srVjl5T3J2ZjU2SnhLQjhhdHh0?=
 =?utf-8?B?Q1BOVGJRblNNeUlBc01jMHNSRlJoR1BsSG1iZGZNMGx3YitXUThJOHUveUpP?=
 =?utf-8?B?S1NrN3BEZWw2MWpDNEJsalUvTGtUNkQ3dkljVVZPYmk2blRjM3dYWm5leFlP?=
 =?utf-8?B?OGVISG0yVS8xcHY5dEQyUkh2Y1NpUEpsQ2dQNFphZmowb0hZVjNhd29DeTEz?=
 =?utf-8?B?WlZYS3diaGptaUd5UXlDTDlreVNQZ1E4MTV1UzFBY2YxVXFESm82cDEyRzBK?=
 =?utf-8?B?M1RHUHRWdVgyVG82OTA1dGJGdlY0RG9Cd2JValJLVGsrMjJvVWEyUHUyVXlH?=
 =?utf-8?B?MkpCR0srb2p2NXBnZWUrKzA3UUVYTWdrN3VJbnYwdzNKamEraE9PQjJrM010?=
 =?utf-8?Q?FjZvD3tlB2878fYfPP3heLQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E4D3ADB58520B41897AD9C3F9109871@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08257d2a-d3a2-4408-f02e-08db0ac05f69
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 17:09:15.3365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jG6yrOjmOGhrkqztGzlSZta0FTYJnXbk9jGGQ8o+NLfOSgXjSSAMjA+WN7+6ahoooV94wEqpNjvyAgMwPLreS3Ie3dpXr63XrTJ7+VgYSOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7927
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIzLTAyLTA5IGF0IDE1OjA4ICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFRodSwgSmFuIDE5LCAyMDIzIGF0IDAxOjIyOjQ5UE0gLTA4MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+IEZyb206IFl1LWNoZW5nIFl1IDx5dS1jaGVuZy55dUBpbnRlbC5jb20+
DQo+ID4gDQo+ID4gVGhlIFdyaXRlPTAsRGlydHk9MSBQVEUgaGFzIGJlZW4gdXNlZCB0byBpbmRp
Y2F0ZSBjb3B5LW9uLXdyaXRlDQo+ID4gcGFnZXMuDQo+ID4gSG93ZXZlciwgbmV3ZXIgeDg2IHBy
b2Nlc3NvcnMgYWxzbyByZWdhcmQgYSBXcml0ZT0wLERpcnR5PTEgUFRFIGFzDQo+ID4gYQ0KPiA+
IHNoYWRvdyBzdGFjayBwYWdlLiBJbiBvcmRlciB0byBzZXBhcmF0ZSB0aGUgdHdvLCB0aGUgc29m
dHdhcmUtDQo+ID4gZGVmaW5lZA0KPiA+IF9QQUdFX0RJUlRZIGlzIGNoYW5nZWQgdG8gX1BBR0Vf
Q09XIGZvciB0aGUgY29weS1vbi13cml0ZSBjYXNlLCBhbmQNCj4gPiBwdGVfKigpIGFyZSB1cGRh
dGVkIHRvIGRvIHRoaXMuDQo+IA0KPiAiSW4gb3JkZXIgdG8gc2VwYXJhdGUgdGhlIHR3bywgY2hh
bmdlIHRoZSBzb2Z0d2FyZS1kZWZpbmVkIC4uLiINCj4gDQo+IEZyb20gc2VjdGlvbiAiMikgRGVz
Y3JpYmUgeW91ciBjaGFuZ2VzIiBpbg0KPiBEb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3VibWl0dGlu
Zy1wYXRjaGVzLnJzdDoNCj4gDQo+ICJEZXNjcmliZSB5b3VyIGNoYW5nZXMgaW4gaW1wZXJhdGl2
ZSBtb29kLCBlLmcuICJtYWtlIHh5enp5IGRvIGZyb3R6Ig0KPiBpbnN0ZWFkIG9mICJbVGhpcyBw
YXRjaF0gbWFrZXMgeHl6enkgZG8gZnJvdHoiIG9yICJbSV0gY2hhbmdlZCB4eXp6eQ0KPiB0byBk
byBmcm90eiIsIGFzIGlmIHlvdSBhcmUgZ2l2aW5nIG9yZGVycyB0byB0aGUgY29kZWJhc2UgdG8g
Y2hhbmdlDQo+IGl0cyBiZWhhdmlvdXIuIg0KDQpZZWEsIHRoaXMgaXMgYW1iaWd1b3VzLiBJdCdz
IGFjdHVhbGx5IHRyeWluZyB0byBzYXkgdGhhdCAidGhlIHNvZnR3YXJlLQ0KZGVmaW5lZC4uLiIg
KndlcmUqIGNoYW5nZWQgaW4gcHJldmlvdXMgcGF0Y2hlcy4gSSdsbCBjaGFuZ2UgaXQgdG8gbWFr
ZQ0KdGhhdCBjbGVhci4NCg0KPiANCj4gPiArc3RhdGljIGlubGluZSBwdGVfdCBfX3B0ZV9ta2Rp
cnR5KHB0ZV90IHB0ZSwgYm9vbCBzb2Z0KQ0KPiA+ICt7DQo+ID4gKyAgICAgcHRldmFsX3QgZGly
dHkgPSBfUEFHRV9ESVJUWTsNCj4gPiArDQo+ID4gKyAgICAgaWYgKHNvZnQpDQo+ID4gKyAgICAg
ICAgICAgICBkaXJ0eSB8PSBfUEFHRV9TT0ZUX0RJUlRZOw0KPiA+ICsNCj4gPiArICAgICByZXR1
cm4gcHRlX3NldF9mbGFncyhwdGUsIGRpcnR5KTsNCj4gPiArfQ0KPiANCj4gRHVubm8sIGRvIHlv
dSBldmVuIG5lZWQgdGhhdCBfX3B0ZV9ta2RpcnR5KCkgaGVscGVyPw0KPiANCj4gQUZBSVUsIHB0
ZV9ta2RpcnR5KCkgd2lsbCBhbHdheXMgc2V0IF9QQUdFX1NPRlRfRElSVFkgdG9vIHNvIHdoYXRl
dmVyDQo+IHRoZSBfX3B0ZV9ta2RpcnR5KCkgdGhpbmcgbmVlZHMgdG8gZG8sIHlvdSBjYW4gc2lt
cGx5IGRvIGl0IGJ5IGZvb3QNCj4gaW4NCj4gdGhlIHR3byBjYWxsc2l0ZXMuDQo+IA0KPiBBbmQg
dGhpcyB3YXkgeW91IHdvbid0IGhhdmUgdGhlIGNvbmZ1c2lvbjogc2hvdWxkIEkgdXNlIHB0ZV9t
a2RpcnR5KCkNCj4gb3INCj4gX19wdGVfbWtkaXJ0eSgpPw0KPiANCj4gRGl0dG8gZm9yIHRoZSBw
bWQgdmFyaWFudHMuDQo+IA0KPiBPdGhlcndpc2UsIHRoaXMgaXMgc3RhcnRpbmcgdG8gbWFrZSBt
b3JlIHNlbnNlIG5vdy4NCg0KVGhlIHRoaW5nIGlzIGl0IHdvdWxkIG5lZWQgdG8gZHVwbGljYXRl
IHRoZSBwdGVfd3JpdGUoKSBhbmQgc2hhZG93DQpzdGFjayBlbmFibGVtZW50IGNoZWNrIGFuZCBr
bm93IHdoZW4gdG8gc2V0IHRoZSBDb3coc29vbiB0byBiZQ0KU2F2ZWREaXJ0eSkgYml0Lg0KDQpJ
IHNlZSB0aGF0IGhhdmluZyBhIHNpbWlsYXIgaGVscGVyIGlzIG5vdCBpZGVhbCwgYnV0IGlzbid0
IGl0IG5pY2UgdGhhdA0KdGhpcyBzcGVjaWFsIGNyaXRpY2FsIGxvZ2ljIGZvciBzZXR0aW5nIHRo
ZSBDb3cgYml0IGlzIGFsbCBpbiBvbmUNCnBsYWNlPyBJIGFjdHVhbGx5IHRyaWVkIGl0IHRoZSBv
dGhlciB3YXksIGJ1dCB0aG91Z2h0IHRoYXQgaXQgd2FzIG5pY2VyDQp0byBoYXZlIGEgaGVscGVy
IHRoYXQgbWlnaHQgZHJpdmUgZnV0dXJlIHBlb3BsZSB0byBub3QgbWlzcyB0aGUgQ293IGJpdA0K
cGFydC4NCg0KV2hhdCBkbyB5b3UgdGhpbmssIGNhbiB3ZSBsZWF2ZSBpdCBvciBnaXZlIGl0IGEg
bmV3IG5hbWU/IE1heWJlDQpwdGVfc2V0X2RpcnR5KCkgdG8gYmUgbW9yZSBsaWtlIHRoZSB4ODYt
b25seSBwdGVfc2V0X2ZsYWdzKCkgZmFtaWx5IG9mDQpmdW5jdGlvbnM/IFRoZW4gd2UgaGF2ZToN
CnN0YXRpYyBpbmxpbmUgcHRlX3QgcHRlX21rZGlydHkocHRlX3QgcHRlKQ0Kew0KCXB0ZSA9IHB0
ZV9zZXRfZmxhZ3MocHRlLCBfUEFHRV9TT0ZUX0RJUlRZKTsNCg0KCXJldHVybiBwdGVfc2V0X2Rp
cnR5KHB0ZSk7DQp9DQoNCkFuZC4uLg0Kc3RhdGljIGlubGluZSBwdGVfdCBwdGVfbW9kaWZ5KHB0
ZV90IHB0ZSwgcGdwcm90X3QgbmV3cHJvdCkNCi4uLg0KCS8qDQoJICogRGlydHkgYml0IGlzIG5v
dCBwcmVzZXJ2ZWQgYWJvdmUgc28gaXQgY2FuIGJlIGRvbmUNCgkgKiBpbiBhIHNwZWNpYWwgd2F5
IGZvciB0aGUgc2hhZG93IHN0YWNrIGNhc2UsIHdoZXJlIGl0DQoJICogbWF5IG5lZWQgdG8gc2V0
IF9QQUdFX1NBVkVEX0RJUlRZLiBfX3B0ZV9ta2RpcnR5KCkgd2lsbCBkbw0KCSAqIHRoaXMgaW4g
dGhlIGNhc2Ugb2Ygc2hhZG93IHN0YWNrLg0KCSAqLw0KCWlmIChvbGR2YWwgJiBfUEFHRV9ESVJU
WSkNCgkJcHRlX3Jlc3VsdCA9IHB0ZV9zZXRfZGlydHkocHRlX3Jlc3VsdCk7DQoNCglyZXR1cm4g
cHRlX3Jlc3VsdDsNCn0NCg==
