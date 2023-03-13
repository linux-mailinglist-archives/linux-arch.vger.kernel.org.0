Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A285F6B6DC4
	for <lists+linux-arch@lfdr.de>; Mon, 13 Mar 2023 04:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjCMDEj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Mar 2023 23:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjCMDEg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Mar 2023 23:04:36 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517611555A;
        Sun, 12 Mar 2023 20:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678676675; x=1710212675;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ms/DidVg4v6SkRPPUGT/Fl1lRxwgabB1/+4q6r28f/4=;
  b=fd9fNQtRPR3YtbeZZd9fgQDheh301f71ayneAr3Zb8g5Arj3fm5uq4Z9
   lOkal9XxQc0ca9iIBYXZeKbf+Jjl13Hblt4aE2QSowNOHRKzQiJy6+gDR
   uQRoYxms2GlRklMKnStJYk0vgfb8xNHXu7TdRQuMMUWekNxhX8j5ddJq1
   CuWF/pijVtjVbRaZzgIF7/2HRfcfnED+ZMSO5cqGu70Ij60ZJAnz8Z2Y8
   jRZZVQGxjOeN3ffNZ91u7v05g+SJzsoQJtyABIygYxe2FH4NB5vhYX1m4
   KcOi0sRrjktuECuWC+0kc/NhcbcRaULBjQt9qVxOeLTb3mmuCPkuQWYaO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="399646210"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="399646210"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 20:04:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="821785289"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="821785289"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 12 Mar 2023 20:04:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 12 Mar 2023 20:04:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 12 Mar 2023 20:04:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sun, 12 Mar 2023 20:04:14 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sun, 12 Mar 2023 20:04:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHhEuGxpiitXNvC1v6GU5igg3dIS1F/KsUnEDJZu07saDXvCrfoj/dgdRYchRvT7bxnHoLPgCkM4ClvVdYmoW/er7XHiwPPapZMzz6u2Cv4hV29/2YTaBUr9JO55aF1c8UoxEBnGjfbvX9x6qn53hGmBqqf0bd7k8bsBr7cc/Fmz+OXmWcVXdkLbgDkPGq8IYgQyF3t6onCMKDu1Fl3R/YyVwq+lzQiotX42zp+nqvOOLHY6JlZw5oF0s3Djj2KjPBNzMzwu9flfTuKWbDT8KHUt5onKbyml6LCB/4RIklwhCBJsP7KiHkDOFaIgalEV/wIFFeP1cYQUw/SSCinV2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ms/DidVg4v6SkRPPUGT/Fl1lRxwgabB1/+4q6r28f/4=;
 b=kyt6VipQVkMUg6b7j0PEnTwb8FekEC/z9uqnznvf0dGvkiMqJos9AxFrw2Ur78QUz1MraaTMz11F09DTc7kQvVp9prXwJTiXBP11481raEKcjmPppbPs2Yr01pxQsjjvP00Rb3lX/lzcahVXek+bpYgbWaoFHRSymg2maEyLZOSFVti7zygrtIdzjv8akWlT+q4/VTk3Dgag/PHAo0klmXpxGPFT4YdGG1fysTivCRZfbeJJSiTyAkcsXdCV6hgWCk5t3n3t8DU+YEykMIqNkmFo3IxcSAdoGhJUBoQcGov/ytVyj2RNB9rh6/gg3S6Lsz34ZlVOIDD5mu7Imkww+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CY8PR11MB7363.namprd11.prod.outlook.com (2603:10b6:930:86::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.22; Mon, 13 Mar
 2023 03:04:11 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 03:04:11 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "david@redhat.com" <david@redhat.com>,
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
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
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
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v7 40/41] x86/shstk: Add ARCH_SHSTK_UNLOCK
Thread-Topic: [PATCH v7 40/41] x86/shstk: Add ARCH_SHSTK_UNLOCK
Thread-Index: AQHZSvtJxFZ9DBZbF0G2QII1pVHTDa71wYsAgAJZdIA=
Date:   Mon, 13 Mar 2023 03:04:10 +0000
Message-ID: <2c67ed3b9dd93e215e5e7489ad56373da789a84d.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-41-rick.p.edgecombe@intel.com>
         <ZAyaIJFhSh0QyVq0@zn.tnic>
In-Reply-To: <ZAyaIJFhSh0QyVq0@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|CY8PR11MB7363:EE_
x-ms-office365-filtering-correlation-id: aa2e0311-20ae-44c3-df24-08db236f9e66
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ya1bK4WnviJwUq1Gj8bECC7HTXRZn4uoidlmdKuWH/SsB6P8/bO9tSAK2c7+NGObay2fksY4qWmBEhBOiKE55LlLSI05K+Sc7jJtFxlReDSaRamsgr5iM+mNRmH0PVNX13aAesG6tybms817lR2D1KMHBIsfR0BcrHL4qC7RpcJzqgIq8BeSXG/h1WJ6G9qnG8WXmn07kbOZjqDKmRCV912r/wxxp0dlXp6DxT7r2YwiWXeFe33beGqhYFcK484oGLFflXqII+Na0B09MYqo7qWib4GfiqGs5jDteyHl3tIK2lrxx7Szd5PTZ2A5VcOBH6owcTwSYbDQVW0Rm+aw7RRw5dv4QqfrxYcZBwTRqyATNFr4rXNgIxWVOUpTvSE4QJRiXXXsFp7289OuID/QQ8yAFD2m7zefHDfrIXRHEGVEScHv2NdEy3f1h4lwCI2h5MANVvEVBaxQwepbkU0nlvHUdpbOzaOS4gdQgI4NDOU0tzKWHKopfwwXmFZTU+tedXB/YXrTE9L+oUah5G5A7y0FLWwOyccM79lhZueCdXnCLMJeR4hOd1gStRI+jbYPuIsJOA51JV8PGhwVk2kgvflLpA6Tw5yYm7Loc2hWthLhJTUg+qS5iNwAFc9o19GQ8F4LelwKwU+UzL2oqxLN0ilCgdT+Dt0cNWvTKGSnN9fZK6MdniVwOBgIgq/FUL9o8WUbOWJAlTUbju4kUvlhvCPhdCA+ZyzvAND/V8hyvDg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199018)(8936002)(7406005)(41300700001)(7416002)(5660300002)(2906002)(82960400001)(86362001)(38070700005)(36756003)(122000001)(38100700002)(478600001)(91956017)(6916009)(66446008)(8676002)(66946007)(64756008)(6486002)(4326008)(66556008)(66476007)(71200400001)(2616005)(54906003)(316002)(6512007)(186003)(6506007)(26005)(83380400001)(76116006)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkhKQXpHU0FCNHF2bi9ZdWtTaXpUbmNScVBNRGlkZkFtN1hUOGJXaEFCZTFD?=
 =?utf-8?B?djZCVFlFdVBoeUtPcUtVRWkwK3VnSUo1NTBxMzkrdm1nSlNXNytUdjl4TVBH?=
 =?utf-8?B?WTFnZEdvZXZpM1dQSHlEbXhUdFZOS0NYVGY2ZmJvT214djRNY2wrNlU1cytW?=
 =?utf-8?B?Q09tNkpOL0Zzd0paaVROU3FXRElWbW9ack1hTzhFV3dPcWJRQWQ3SVBRM2o5?=
 =?utf-8?B?Tk1RQ0ltNXlHSkxBem5HK2hpcThUa3ZEUkdqamwydUUrQ0J1M3h2bWh3UGxW?=
 =?utf-8?B?aUMwbWIyQzV3VUw1MmhOaHpVWjd3eFBVUjhXYkcyQmhhS1ZkWVFKd011a2k4?=
 =?utf-8?B?eUdNMzBBemY0NmtUaHZwSFV1TDZjeFUrK0RVWHpPM3A2UXlQWmF6R0RQRUwx?=
 =?utf-8?B?bU9nR2pOa29nVnRoV1doQmVVNXBMenQwMkova0pxd3Z1cXhMVTlXWjg4b2dq?=
 =?utf-8?B?OFlZd2QxV1craTdMY2lSbmV5SFZoMmptWnJTN1ppU1hGZEgvSzJVTjc3VDlC?=
 =?utf-8?B?K2dtc3FqY2JVVTN5ODgzUWtjYjlZMG5YR0hWWlFSZXdqVGp0VjA0RkVFT0VO?=
 =?utf-8?B?UjdaUEc1UFludFk2V3Jac1orbytoVnlYcVovUEZ6MlFrb1ArV3hEZHY2SVll?=
 =?utf-8?B?TjhnVFA3SEVWZyswTG82L25lUlVBSjVUb29sdGlNWGxWSWFnVW5wTE9GTHhu?=
 =?utf-8?B?RHJoRFpnNjJiU2hYQzJTMThldTBGNG41a0lscUcvUTJDNUJsSTd1K0RaY2Qz?=
 =?utf-8?B?L0FFRlIxR1RlcjNFdjNCOGpnMmpZaDR4TlBoblN2N0Q0aVhUUG0yLzhuTlhq?=
 =?utf-8?B?ZTU5MkczcjFoeTZYVkppQXpzZTBnZ0lEREljb1lyRHMxMXZqZDRwU09jVFVI?=
 =?utf-8?B?ejliSWxhUWhseTcraUE4N2JTNTNybkhuMVQ5aWdEOTVMWFlWanQ5L2p2ZXRU?=
 =?utf-8?B?TTdVTHowMDJpYThVdFFlTHJPbmMxZmkvWU5xN0ZSWldFM1FvbjEyZ1h0L0Mw?=
 =?utf-8?B?Undocy9ra0VhVCtQWGlTK2V3VzVtK2I0WFJLbHE0UjVzd0hVYWlVRWgwOWF5?=
 =?utf-8?B?S2Y2TWJDQ2EvTXZFOEF0TVYrUWYvSU1odnJBVXdKWDFzSGhFOEhTa2pHL3dN?=
 =?utf-8?B?NDZ0OE10NE82akdicHRtRTBIbWs0ZE02ZG9NbE5lUXhjZzlzYzFiVzJUV2dH?=
 =?utf-8?B?dTJxckh1eU1HbUhMVnFrdjFjUFpaRU1mbFNabnp1WWljS0Y2eHFNNThNbjJR?=
 =?utf-8?B?eXF4aG9aR0srR0I0dHFXRUk0NXVrU2M4MDVMMnhNRkF2aHBBMklqTDRhamJy?=
 =?utf-8?B?dXQvZjNWUXFDd0NYdUZFNUVsQmhRMTltZ01Ec0FMeS9ZOStSdmJpRk5Xei9K?=
 =?utf-8?B?QUt5Q3p6eGpRK09iWTBYSVZEa3RDSnJwRTloWHFqYlBuRVFiWVJvSFhlVTk3?=
 =?utf-8?B?MDFpcnRudjA2dkUyMzVhenNlckJkQU1VR2o0VzgxMU9BaXdTYmNERENwTjdW?=
 =?utf-8?B?RmpPdU5hak90aUhmVnFFMGE4NGFWTmhMaXBHOHhad3FZR3QrZkpyd0x5SUxN?=
 =?utf-8?B?N2pFck1UNEREc3VESHZETStMT1lrVktYdjNSRDBpN0VIYXZNYzNwZTROV0ho?=
 =?utf-8?B?cUg4ZmpoMFB1UjdqT081Ti92TlpROC9FOThSaTFJMk5QSzRaN0ZGKzFEbEt3?=
 =?utf-8?B?aU1xUEZEVDN4MUNNRUg4b2tXSkVhRHorcXFWQUMzaHhIQVNxZFpPenpSekpz?=
 =?utf-8?B?bTBkaFhwcW5tNVNBb1hIeE9pOEZueDhXK2hXNjFGZ0YrWFNYRytXenBKbVpT?=
 =?utf-8?B?MGpLdkd5ZlJoV2o4aFdXT01YcGlteTY2azA3enN3MUZXNjB6UTBmaks2MFI2?=
 =?utf-8?B?clh4WEhKRS9zNUhKS1F1TUpWREhmbDZLUTE5bUIrdEhvY1ZTVTBwR3EzV1Za?=
 =?utf-8?B?aGFUTVZsMFBNTXhGMllhY1k2MDk0RzR2MWlyOW5PUjhLN2lFVU55RnYzYnF1?=
 =?utf-8?B?Vy8wNzloL1JzRThUaXBVUnVBR21ud1dqalR1U2NycVEyY1p2Mkdmbzl5U1RM?=
 =?utf-8?B?ajlGWFY4Qm5qK3BweEJuS3d6Zi9tMzJJbHVxMVdVa1pGUlpCTW44VG5DVUJi?=
 =?utf-8?B?Q0syQjBoWmw2a3NwVTZJV2JQWE5abzdvMnVwNDgvTndGTllmb3BqMkd0cFcy?=
 =?utf-8?Q?s3/qKuAamhZ9MPrOvmkvnyE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCDAB4A2F8BC464B89314BE36DFE6AF7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2e0311-20ae-44c3-df24-08db236f9e66
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 03:04:10.8628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I4NJRFEfsWa+VCLj52G8mgJh83yodyuO9g1g3+RiJfVjB9AjK/vYpdPyNunOwcXmueU/PW5tqe8AsQbbADHsu7dhimOYwUSpuokuFc+Ke9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7363
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gU2F0LCAyMDIzLTAzLTExIGF0IDE2OjExICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIE1vbiwgRmViIDI3LCAyMDIzIGF0IDAyOjI5OjU2UE0gLTA4MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+IEZyb206IE1pa2UgUmFwb3BvcnQgPHJwcHRAbGludXguaWJtLmNvbT4N
Cj4gPiANCj4gPiBVc2Vyc3BhY2UgbG9hZGVycyBtYXkgbG9jayBmZWF0dXJlcyBiZWZvcmUgYSBD
UklVIHJlc3RvcmUgb3BlcmF0aW9uDQo+ID4gaGFzDQo+ID4gdGhlIGNoYW5jZSB0byBzZXQgdGhl
bSB0byB3aGF0ZXZlciBzdGF0ZSBpcyByZXF1aXJlZCBieSB0aGUgcHJvY2Vzcw0KPiA+IGJlaW5n
IHJlc3RvcmVkLiBBbGxvdyBhIHdheSBmb3IgQ1JJVSB0byB1bmxvY2sgZmVhdHVyZXMuIEFkZCBp
dCBhcw0KPiA+IGFuDQo+ID4gYXJjaF9wcmN0bCgpIGxpa2UgdGhlIG90aGVyIHNoYWRvdyBzdGFj
ayBvcGVyYXRpb25zLCBidXQgcmVzdHJpY3QNCj4gPiBpdCBiZWluZw0KPiA+IGNhbGxlZCBieSB0
aGUgcHRyYWNlIGFyY2hfcGN0bCgpIGludGVyZmFjZS4NCj4gPiANCj4gPiBUZXN0ZWQtYnk6IFBl
bmdmZWkgWHUgPHBlbmdmZWkueHVAaW50ZWwuY29tPg0KPiA+IFRlc3RlZC1ieTogSm9obiBBbGxl
biA8am9obi5hbGxlbkBhbWQuY29tPg0KPiA+IFRlc3RlZC1ieTogS2VlcyBDb29rIDxrZWVzY29v
a0BjaHJvbWl1bS5vcmc+DQo+ID4gQWNrZWQtYnk6IE1pa2UgUmFwb3BvcnQgKElCTSkgPHJwcHRA
a2VybmVsLm9yZz4NCj4gDQo+IFRoYXQgdGFnIGlzIGtpbmRhIGltcGxpY2l0IGhlcmUuIFVubGVz
cyBoZSBkb2Vzbid0IEFDSyBoaXMgb3duIHBhdGNoLg0KPiA6LVANCg0KVWhoLCByaWdodC4gVGhp
cyB3YXMgbWUgbWluZGxlc3NseSBhZGRpbmcgaGlzIGFjayB0byBhbGwgdGhlIHBhdGNoZXMgaW4N
CnRoZSBzZXJpZXMuDQoNCj4gDQo+ID4gUmV2aWV3ZWQtYnk6IEtlZXMgQ29vayA8a2Vlc2Nvb2tA
Y2hyb21pdW0ub3JnPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1pa2UgUmFwb3BvcnQgPHJwcHRAbGlu
dXguaWJtLmNvbT4NCj4gPiBbTWVyZ2VkIGludG8gcmVjZW50IEFQSSBjaGFuZ2VzLCBhZGRlZCBj
b21taXQgbG9nIGFuZCBkb2NzXQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2sgRWRnZWNvbWJlIDxy
aWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCj4gDQo+IC4uLg0KPiANCj4gPiBkaWZmIC0tZ2l0
IGEvYXJjaC94ODYva2VybmVsL3Noc3RrLmMgYi9hcmNoL3g4Ni9rZXJuZWwvc2hzdGsuYw0KPiA+
IGluZGV4IDJmYWY5YjQ1YWM3Mi4uMzE5N2ZmODI0ODA5IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gv
eDg2L2tlcm5lbC9zaHN0ay5jDQo+ID4gKysrIGIvYXJjaC94ODYva2VybmVsL3Noc3RrLmMNCj4g
PiBAQCAtNDUxLDkgKzQ1MSwxNCBAQCBsb25nIHNoc3RrX3ByY3RsKHN0cnVjdCB0YXNrX3N0cnVj
dCAqdGFzaywgaW50DQo+ID4gb3B0aW9uLCB1bnNpZ25lZCBsb25nIGZlYXR1cmVzKQ0KPiA+ICAg
ICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+ICAgICAgICB9DQo+ID4gICANCj4gPiAtICAgICAv
KiBEb24ndCBhbGxvdyB2aWEgcHRyYWNlICovDQo+ID4gLSAgICAgaWYgKHRhc2sgIT0gY3VycmVu
dCkNCj4gPiArICAgICAvKiBPbmx5IGFsbG93IHZpYSBwdHJhY2UgKi8NCj4gPiArICAgICBpZiAo
dGFzayAhPSBjdXJyZW50KSB7DQo+IA0KPiBJcyB0aGF0IHRoZSBvbmx5IGNhc2U/IHRhc2sgIT0g
Y3VycmVudCBtZWFucyBwdHJhY2UgYW5kIHRoZXJlJ3Mgbm8NCj4gb3RoZXINCj4gd2F5IHRvIGRv
IHRoaXMgZnJvbSB1c2Vyc3BhY2U/DQoNCk5vdCB0aGF0IEkgY291bGQgc2VlLi4uDQoNCj4gDQo+
IElzbid0IHRoZXJlIHNvbWUgZmxhZyB3aGljaCBzYXlzIHRoYXQgdGFzayBpcyBwdHJhY2VkPyBJ
IHRoaW5rIHdlDQo+IHNob3VsZA0KPiBjaGVjayB0aGF0IG9uZSB0b28uLi4NCg0KVGhpcyBpcyBo
b3cgdGhlIG90aGVyIGFyY2hfcHJjdGwoKXMgaGFuZGxlIGl0IChpZiB0aGV5IGRvIGhhbmRsZSBp
dCwNCnNvbWUgZG9uJ3QpLiBTbyBJIHdvdWxkIHRoaW5rIGl0IHdvdWxkIGJlIG5pY2UgdG8ga2Vl
cCBhbGwgdGhlIGxvZ2ljDQp0aGUgc2FtZS4NCg0KSSBndWVzcyB0aGUgZmxhZyBtaWdodCB3b3Jr
IGJhc2VkIG9uIHRoZSBhc3N1bXB0aW9uIHRoYXQgaWYgdGhlIHRhc2sgaXMNCmJlaW5nIHB0cmFj
ZWQsIHRoZSBhcmNoX3ByY3RsKCkgY291bGRuJ3QgYmUgY29taW5nIGZyb20gYW55d2hlcmUgZWxz
ZS4NCk1heWJlIGl0IHNob3VsZCBnZXQgYSBuaWNlbHkgbmFtZWQgaGVscGVyIHRoYXQgdGhleSBj
b3VsZCBhbGwgdXNlIGFuZA0Kd2hhdGV2ZXIgYmVzdCBsb2dpYyBjb3VsZCBiZSBjb21tZW50ZWQu
DQoNCldvdWxkIHRoaXMgbWF5YmUgYmUgYmV0dGVyIGFzIGEgZnV0dXJlIGNsZWFudXAgdGhhdCBk
aWQgdGhlIGNoYW5nZSBmb3INCnRoZW0gYWxsPyANCg==
