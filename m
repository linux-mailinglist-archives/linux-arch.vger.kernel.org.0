Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04C65F4750
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 18:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiJDQQC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 12:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiJDQP6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 12:15:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C31A5FDC4;
        Tue,  4 Oct 2022 09:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664900155; x=1696436155;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xGQPUSWte+1Bn9Pv2tFkLmMGc4OFZApSZH1SbEU0BDE=;
  b=kpw1v9CiO/wgBVI/O5uKRAml2ml8yrFunl7Sw1B1I8FXgiEiYdOFA1nJ
   8GTkk7s/lE374ZesPQKV96P62a4W0eIFSGJfNfJwlfq39cFbu93QaJpa/
   VTdtYsEe0rmAjSFjHPhhq0EjDUQfwjZ1mm6Smymqs/odQtutMHPP4/Pbw
   iK3WpG8ZPTGoTt+mVEZj8hoj9yzpzg4XNewgIVgKJhsnDNJOWJfVfgfyk
   gcfgIojcU1Mq5n0ZEeQmvuXEgSCzQUGFwcLsRblL6X/7Knp3PIocYI5Ky
   OCORSG37QBYyv8A/3MNGnDbCgVUsnKlZTyLXqbzOhKtJae8Oxp30Ejd63
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="300553641"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="300553641"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 09:15:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="728277444"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="728277444"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 04 Oct 2022 09:15:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 4 Oct 2022 09:15:51 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 4 Oct 2022 09:15:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 4 Oct 2022 09:15:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 4 Oct 2022 09:15:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mww9Y0yGKwIiXtCxGMb9FInwPegqTT/A6q0wmM2zvZMBMCyz6EuaYiAmBLgBEEF39Lp6J6gyy4zorMAaJM8/DeTAX0mPB7tKftkYiCprAYfT9wileWxmmYwK+Z9AwvBmACsmMUxiIhppUKtUAybv3mbRZQ4SAjpX4CIFM8YbRQcSSDhYlVjsoLrDJTll9Q1Btg6AmGOGewHKiRoy9PbUOWP+kAHVo9jbimg7hIWdakDsgIuhw+/cMnfq7RiSMgownuodfVmWpB+GBvwH6YE9Q7kTUf9ig61gC7H1lqhtW5ymCSY+yA4FJWvTWRxtN9g597CxWZ0JcgMiNhVKwI829w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGQPUSWte+1Bn9Pv2tFkLmMGc4OFZApSZH1SbEU0BDE=;
 b=dB3C5zHiVxo6JpraOSiJc67l/pmt118yXgOXe25IleZd6r4DN/Z0pgx+qLsSfv+XVOLH/v52hE42NLsvyJawuSBh3wwIMPCgqgGhtOk841zYq0GWZ8ci8Vzs5cbCwZ5+3lfwFu7NyfJ+gpirtpntqPIcZkAaxjKAv5N10YVaXTrXKxxFc1B41cpsCbGghSUhcR8wlsDGG3/J3uGleKN8Ep705bWkPGX8hLCNz4Qfy0wjO0Gb8+o/ZYVcoJRGdQaHHsy8AuMcMmasfqP/lCZeBtb3wYD90sl0Havas8JNT5EVJXHMHCbglHYCx70Gurv221gSAarhf8Nsy4ngYMvuwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MW3PR11MB4585.namprd11.prod.outlook.com (2603:10b6:303:52::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 4 Oct
 2022 16:15:44 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.028; Tue, 4 Oct 2022
 16:15:44 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
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
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 17/39] mm: Fixup places that call pte_mkwrite()
 directly
Thread-Topic: [PATCH v2 17/39] mm: Fixup places that call pte_mkwrite()
 directly
Thread-Index: AQHY1FMa24Mj89j8rEOlmG8UPkMiXa39XtCAgAERpIA=
Date:   Tue, 4 Oct 2022 16:15:44 +0000
Message-ID: <2b024333bdb826aa8c968d6d1465e45deb935ae5.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-18-rick.p.edgecombe@intel.com>
         <20221003235619.qdoedbrcrplaa4tf@box.shutemov.name>
In-Reply-To: <20221003235619.qdoedbrcrplaa4tf@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MW3PR11MB4585:EE_
x-ms-office365-filtering-correlation-id: 37f182ca-5161-4d8b-50ca-08daa623b0cc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZqPXc8wEAjXj16mEbUjnf7/nLO/JvnxGTEZfxwfy2JE/ilrBt3yj9NqDS2tAr0hNZAPMMcG2HesebDOB1UA8yghyakkvRZ8ZKQ5Ls2tQRNn2CAx//DsSAzI4A0UbJZTDho3JWQWgRgQ0wQK5hdMfQFv5b9sAO9jA0W5adw0PKF0ApzX9mbbb1g69i9XXejAK2bTcpTxtOF6/3ZlBUsDF2gWsKecgturq1ob/NsTJlYnlYGetDud16xHXtOBBJeTCI739XKmDf67oq7KLY9KdjgR5ZCCtcrbmUalo7DaKMzahG1Ck3u50eTZmRyQMfAWXICUEssZbvWQcYsWevU44yTnN0yBJCeu2G4irxA8uBfi9JIND8BVTIgNOJLWchqCd9IAdYKHzNV0ZUeOUmRdtaGcx8WXaSXZJ2dJ+EAvu1D5WRN9inJ8D2d5OHqwxDu+bVeVvXyhL1qwxgg0+3eYIZXn/t80NzYjLSERrp99VjVVWmDTv1HElltj0IQp7hwwKgzKJotADlAeyIOj/J5Wek9kd0ZJvmpkkJG3tXGtrqO3Sb7AMyWiP7qRDRNHXFU6GzDjcYvoRhTuWLHk1iuOsyxDK4QhvleZtK18W6S0bYbrzRSdUGau035H1YdxGz65wUnc8fAKI64Dhv0UiKxcpj6C8cSEcWYisfx6/K9Z1xwur4oTOQzyEVHCoSZa69fBzBVSR7xYYn/+VfCERWUJQWEz2HndOe2Cairgwi5i7swhpZEobqruXPvxkvV+V/JOEax5ATb5kKJ9DZtWGmiWMpmFEN864nI2tvEfy0bo5qfo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199015)(122000001)(38100700002)(82960400001)(86362001)(38070700005)(36756003)(8936002)(6506007)(41300700001)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(7406005)(4326008)(7416002)(5660300002)(6512007)(26005)(478600001)(186003)(71200400001)(6486002)(54906003)(8676002)(91956017)(316002)(6916009)(2616005)(2906002)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVJPVDFFWDc2Rk5BeExwZjc3ZEppT2p0allZRTRvT2RkVkFXU3lNY1NsbGUw?=
 =?utf-8?B?MjF6bFRmV1JGMm9UWkp6VVVtMkhxR1kyeGE0Q0x6UmFIaEhxQXkwMlV4UG1D?=
 =?utf-8?B?eTVtd0JXTDNoZmZsLzVyRTA1VHVpaytEc3BHQTN0cGgxcTFOalVBSlpsRXF2?=
 =?utf-8?B?eUpzOEFVUEp5WGozNkVCKzQ4RFJ2KzdzcVdVZzR0SGEzc0JOZTFjYlBUMmdn?=
 =?utf-8?B?cVI2cmtPMk5kdFRHZGJvOXlJTllqQ1A4U1BpYmovdnA5d1ZxQmdIcHJvWVBj?=
 =?utf-8?B?dlZCQWNiNjFPS2tKanlSNTdTcWJRL0pSRFNMSEVhemlCcEU0ZERWbkxtbTVa?=
 =?utf-8?B?Y2V0YmxwUi9JRTRtaFBCMEdrV0s0cTlJZU1ZaVJQeVNBb1o5QzNnbmhLSEpE?=
 =?utf-8?B?VElCaWhaQUFYdFJwVVc5emIvenJMMVkvemlKTkpCRVhFY2hxUmNlRWh4Q1Rz?=
 =?utf-8?B?bytXb1E4NUJLL25GbVNicHV2TUVrT2phL0NiWEtud0NnY3JST3JDcVFRVFFw?=
 =?utf-8?B?V1lvK3F3UElSVDZzVnh2enRSVEdCYTB5aUNndGd4S29DcDM2bmpLR1ZiVG4w?=
 =?utf-8?B?Y2Zta1g4SWZSbVJjelhlRXNXMXFITUJqalV5OUpNa3lKc2wxMGdQVDY5dkJQ?=
 =?utf-8?B?dXFEN1Fka2FsTXpWYS9PeDFGR0xLeE1WTlFCTU9UVzRjTHhWWm54N3ZUcG5x?=
 =?utf-8?B?eXdUUytaUjFGNVNOT2xBamE4bkUrN2JXSW96blFacnIxSjE4TXZZT1V6aUJm?=
 =?utf-8?B?YjMvK1JJUHNCdnJTenl3Q2FKbEVYZkNuc1pjSEN4VG1KMkZmemxKRWI1ZlR3?=
 =?utf-8?B?VmcrSUM0MnpiTzFYL1RIcENWMkxWemdua3lGdkFQd0MzdDFiZm1VOWdvZWZC?=
 =?utf-8?B?cjZvRXBkb2t6aFZjT3NaRjR5alFVcmpEbzQxUGZ3bDI2KzNSeHRxNlVVUTh4?=
 =?utf-8?B?Wm1lcWRKZHV5dDBiSlY3d2ZUWmNRaUpSV0M4N3FSZTZqWExuZFRsVFZpMjN0?=
 =?utf-8?B?STh0d3BGaGZ4NHhGK3owcTUwUjZsc3hxQ3p1bVFjdzc1NUJsRjJ6SUViVVph?=
 =?utf-8?B?QW42YTIrVzJoT1ZGTExHZkwzOXF5aHBzbUJoYmE2d1J2bUxkQ2c5Yitncm1Y?=
 =?utf-8?B?dzNrTzVHS3hWbFBsemdwOW1jcjdOQWVrT2tQTE5kc0dYR0hqcXJMWlBtRE1G?=
 =?utf-8?B?Q21xNk1NaTA4Q1BMNC9YaE9rQWFQcEp5T1E4RjVuY2JGTUpHWkhiK1A2eWZQ?=
 =?utf-8?B?VFVCWWNURWxLMXJuK1FKQmVEeEUzem9vOGJGcTFwOFVRQ3BPVkg4UGM3cjJH?=
 =?utf-8?B?Y1VZL2JCVXZJMyttbXNBTkMwYU9QbThJZzZDaUF4SjN3eVpiOEVYWFhEbUIz?=
 =?utf-8?B?YUdHSzZ2UWRKR2V5amZlWnpaeXJ0NGo0cGVJRkxQMnFMcXJydWxzbFBrQ1RM?=
 =?utf-8?B?TEw4TENacDBsekI1Rzh6S1lQSnl1cEFGNUYwREJJOUdtYW4vcUJGNkVMcDhW?=
 =?utf-8?B?aHUydFpPQTZEOWhGRjBLWWZPb3BYVUhtYTBobnl5Wk1kMHdwY1FxMVNJMGlw?=
 =?utf-8?B?NEd3ZXdLSks0L2twdWt3QjhpMHpmQjZFSFl5RWlYc0xIaEczdU5iTVIwYlFG?=
 =?utf-8?B?VFNvRFpFcWxkZ0VRNEhJdDVyNW5HalZxZjVaZ2ErMUFnQnk0Q0NsZmowU09G?=
 =?utf-8?B?R09mYkJtVlhaa29ROFE5SlU0ZjR4UmNFcmhPOWlaOGdEa0I3akFNSllOR1Ey?=
 =?utf-8?B?VkRpSUtmZXB2Sy9zUEFqd0VNR0tuOXdBMDZTMWlKNUM3TjYvVjYvMzk0ZFcv?=
 =?utf-8?B?ZjBXRHpVMXRBMHBkOEFUT1llenBxTHd2UkpoWHcrWU8rdXB1TGo1TGI5QzU4?=
 =?utf-8?B?bXdGQkwySTlnNzB6OTJrZXo1L09wZ2hLTTFLN2hyYXJLQnZwSGhOcE9OUWlF?=
 =?utf-8?B?eTRnLzNoS1JLTFdBanVUcy81RGdiWmpVVXZvVjhtTThaQmZxN04xRklPT0FW?=
 =?utf-8?B?alorQm4zcGx0eW5IckxRMUNBUHZGTTdOZUZ3S25BUjV6VEJ3NmtrMlJjNWh6?=
 =?utf-8?B?TW82MDJYOXFvVzExS3N3Vk1MTVZHakl5bTZHbHloTm1VUGlpam9zZ2JqTE1z?=
 =?utf-8?B?UmpFdmRYMWFOVXFvcG9vSnhiNm1zZ1IwNmwwZnFMZVk2UXBLOThRZHhhM2FY?=
 =?utf-8?Q?Tg+bZm39QI1c4PeBlTwwi5k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E78CF92AE3145341834CB8DC2E22BFA5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f182ca-5161-4d8b-50ca-08daa623b0cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 16:15:44.5967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nEfzkxOTnWhzR/ndGlr+dR1qKH/9gKyScn/A47vHlC+6mHPWvlmJDuXxlR3bR7wpZBtFSghl+cWlIdv/pTUF35zYrPm85+l1d0J9Fd6A2s4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4585
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIyLTEwLTA0IGF0IDAyOjU2ICswMzAwLCBLaXJpbGwgQSAuIFNodXRlbW92IHdy
b3RlOg0KPiBPbiBUaHUsIFNlcCAyOSwgMjAyMiBhdCAwMzoyOToxNFBNIC0wNzAwLCBSaWNrIEVk
Z2Vjb21iZSB3cm90ZToNCj4gPiBGcm9tOiBZdS1jaGVuZyBZdSA8eXUtY2hlbmcueXVAaW50ZWwu
Y29tPg0KPiA+IA0KPiA+IFdpdGggdGhlIGludHJvZHVjdGlvbiBvZiBzaGFkb3cgc3RhY2sgbWVt
b3J5IHRoZXJlIGFyZSB0d28gd2F5cyBhDQo+ID4gcHRlIGNhbg0KPiA+IGJlIHdyaXRhYmxlOiBy
ZWd1bGFyIHdyaXRhYmxlIG1lbW9yeSBhbmQgc2hhZG93IHN0YWNrIG1lbW9yeS4NCj4gPiANCj4g
PiBJbiBwYXN0IHBhdGNoZXMsIG1heWJlX21rd3JpdGUoKSBoYXMgYmVlbiB1cGRhdGVkIHRvIGFw
cGx5DQo+ID4gcHRlX21rd3JpdGUoKQ0KPiA+IG9yIHB0ZV9ta3dyaXRlX3Noc3RrKCkgZGVwZW5k
aW5nIG9uIHRoZSBWTUEgZmxhZy4gVGhpcyBjb3ZlcnMgbW9zdA0KPiA+IGNhc2VzDQo+ID4gd2hl
cmUgYSBQVEUgaXMgbWFkZSB3cml0YWJsZS4gSG93ZXZlciwgdGhlcmUgYXJlIHBsYWNlcyB3aGVy
ZQ0KPiA+IHB0ZV9ta3dyaXRlKCkNCj4gPiBpcyBjYWxsZWQgZGlyZWN0bHkgYW5kIHRoZSBsb2dp
YyBzaG91bGQgbm93IGFsc28gY3JlYXRlIGEgc2hhZG93DQo+ID4gc3RhY2sgUFRFDQo+ID4gaW4g
dGhlIGNhc2Ugb2YgYSBzaGFkb3cgc3RhY2sgVk1BLg0KPiA+IA0KPiA+ICAgLSBkb19hbm9ueW1v
dXNfcGFnZSgpIGFuZCBtaWdyYXRlX3ZtYV9pbnNlcnRfcGFnZSgpIGNoZWNrDQo+ID4gVk1fV1JJ
VEUNCj4gPiAgICAgZGlyZWN0bHkgYW5kIGNhbGwgcHRlX21rd3JpdGUoKSwgd2hpY2ggaXMgdGhl
IHNhbWUgYXMNCj4gPiBtYXliZV9ta3dyaXRlKCkNCj4gPiAgICAgaW4gbG9naWMgYW5kIGludGVu
dGlvbi4gSnVzdCBjaGFuZ2UgdGhlbSB0byBtYXliZV9ta3dyaXRlKCkuDQo+IA0KPiBMb29rcyBs
aWtlIHlvdSBmb2xkZWQgY2hhbmdlIGZvciBkb19hbm9ueW1vdXNfcGFnZSgpIGludG8gdGhlIHdy
b25nDQo+IHBhdGNoLg0KPiBJIHNlZSB0aGUgcmVsZXZhbnQgY2hhbmdlIGluIHRoZSBwcmV2aW91
cyBwYXRjaC4NCg0KQXJnLCB5ZXAgdGhhbmtzLiBJdCBnb3QgbW92ZWQgYWNjaWRlbnRhbGx5Lg0K
