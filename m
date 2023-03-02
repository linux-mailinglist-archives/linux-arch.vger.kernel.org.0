Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4896A8B64
	for <lists+linux-arch@lfdr.de>; Thu,  2 Mar 2023 23:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCBWB4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Mar 2023 17:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCBWBx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2023 17:01:53 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9C25A6DD;
        Thu,  2 Mar 2023 14:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677794489; x=1709330489;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NLC14dQOC6LGKEwzg159yXmmJSbHjJ3LCxKnaKgBMMs=;
  b=IOBBvdyqFdqB4BX8IYND20SrsiKj+Y8mm0alYgjGrbp0bIz9T8GqyhaM
   KCPe2SJDoY9NglSs0RNPdvZmpjK/O/734Kp2F6mICpd3E84j9zlx165/z
   ioJS5O4Q9Nc5+xoA6zP/+BevlKF1cOMpTTxGEBv+8A5FC/roPdyGaDA1F
   xkh5oK590xo/C4XwyzfomynpC7xJIjjRKfbU8rqcuZS9f4nM19YW20Ysq
   JQnJdiBGBoSk/eXLPg2UBe1YYDGMN8cpOeofolt5z7wZwbhlI01JuJDXl
   cB7/xADhYJeZe8cidqrSQPX2dcVdAPPZHzGkAHClurz+WQtOgkFc8ymL+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="337177536"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="337177536"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 13:48:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="675117272"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="675117272"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 02 Mar 2023 13:48:36 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 13:48:36 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 13:48:36 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Mar 2023 13:48:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlexctPUlBYmtNezt8XGToNhJESgJmnlRH93xRG67Ir4niP3Bg2zh1IoiZNjYRJ+GZpn3K5fsa5CHOi/O8m159YBqwalwc/NSE9xnDNzm5T4la0wKr7UokvPVP6If+2iMy9epkxErTtr7UKtyQ/UQlCtgDC+8E9u9Vd2fvqdvtSc05XMHilfdebxHVoGr+FZtBi9pDyGasf4Di+AJ8XZn0NoDuZ/O59yWuPP44JYIm0jZMkT/FbubgnhaQf/KYu1l5m884I+ccqZrCa4aISB6x5pen5tT0zwGRz3K7HFPAp1Kd14AHX/DlQeiHVugylku4ZkAfUU5Tetuo/64+Xujw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLC14dQOC6LGKEwzg159yXmmJSbHjJ3LCxKnaKgBMMs=;
 b=lFn84w3nthv1YFajaLcgFTUf1hkPNTl1F6z1yIDyIz5d1Nwd9L3xH1AUhC2MFcJOF/9qXnmQTz/5me5EPwE+ehsQ7vvD+WCsmbiCavdEl/P733Cp4PpXuD+3p1YxvF4ueeBGGZJeb1TuqffEDBFW5bESJjo3oFfwLAjQtCrqVPCMvIHy3L+eHCdWyYzc8PjwWqmIUekR6cLji4aBMJNO6FB7M5gPwe7UYzREhImxiX7v9tjGV3VQ22GGVsVVWLCrkvARBfHZ45bI1hO8QQIhrE6S4yG6GWHOdF7/MHPtavq/iatJeZ41QEWdT2RDcP5qZMuGzWENat3y90tfun2mcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH7PR11MB7962.namprd11.prod.outlook.com (2603:10b6:510:245::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Thu, 2 Mar
 2023 21:48:33 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 21:48:32 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
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
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>, "nd@arm.com" <nd@arm.com>,
        "al.grant@arm.com" <al.grant@arm.com>
Subject: Re: [PATCH v7 30/41] x86/shstk: Handle thread shadow stack
Thread-Topic: [PATCH v7 30/41] x86/shstk: Handle thread shadow stack
Thread-Index: AQHZSvtG+2WnM2cLTkqogSV10ayPpq7nxJIAgABG7IA=
Date:   Thu, 2 Mar 2023 21:48:32 +0000
Message-ID: <7fbf0e04699eae5595108349c99bd270e5d9a0a0.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-31-rick.p.edgecombe@intel.com>
         <ZADeMDFETi7bfcz+@arm.com>
In-Reply-To: <ZADeMDFETi7bfcz+@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH7PR11MB7962:EE_
x-ms-office365-filtering-correlation-id: 7bc9c21a-ad49-4493-7b93-08db1b67de3b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6+y4if5re41C8r/bdNFjekyh5fiQ5L2lKjcrbehjbgPzh5ZjzHkNmzb+ECv7JeDC22yCyejPbMePWnCDvnkFRlG3aTTRhkjVTaCGWcw2qO/goYtWM0SkehnAeHI8CLwsd9czayQBfq91RNU7ZUJIRyWfgPVCZmD8hpwduC1Ew5AESJTzsl5752WMZzKzjANjVQ6zm0YzuBCFAenPt4GlZOAlmDai5qCHoFBFQ3AK9QVPdbREMeRfxmUqK9VzroBjF7dlIOq1o0nTWRrP1RU3cdLjqSC/+ekGV3XGKKnQXpkMzocaH8indxR4UC2bkWx7DkIZO9SGruJX3r6SlcRf85niCImgYMk9kim26lf9ov8/tXcJNZPSXCSWvZQCtGL6hiEt0ZlB3fTUIrbDxXZk2V20Je2GhgvDrDju/Ggx3uL6N4WmfBTsLBK1lo5yqxZmy7bfi2tMFnVU8zJWrF5VXULh2htRxVK8zyhLnqfsNaWl4jJXWwbVEXk0iv5YfXxdAs3ubYzSwC818GIkpVZbW3fk5VgxfPKzkHAN4U62HgfnBHl0vWpIhklw7FSiS3J8bqoxa8UWWtNVbhC0e+jRCNS4wdyd+MACxs0BIBel2sVFEUYuOndxtx5U8qjZqB/Z5xX4oUw2ZG89xCCKOC11JRd4/bVx+iKj7qSVl5GMV6YkTHNWebAf2VZJ9plf35PmPDzWWzWI6HVFauR+TTKJIRu4ImUhyjeIe7wrZkwoF1nlb5r8BNsuEnbXo7geLAvB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199018)(54906003)(4326008)(7406005)(36756003)(66946007)(86362001)(5660300002)(66556008)(8676002)(7416002)(41300700001)(64756008)(8936002)(66476007)(66446008)(2906002)(921005)(122000001)(82960400001)(38070700005)(38100700002)(6486002)(478600001)(91956017)(316002)(76116006)(71200400001)(83380400001)(110136005)(186003)(6506007)(26005)(2616005)(6512007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bklRdkhrYXZaRVF4b0oweDFES0M3ZFFBalgyWTdRM2xBQm5FTnZENXpSSi9o?=
 =?utf-8?B?NEJSK0w1Y2cyU01PalFqbm9pQ2NoODRSc2hHOXFoaDRTZk41OUVES3FhbU5i?=
 =?utf-8?B?am12STh5dGd3WkxPL0RtVjFHdk9qZWVuK2luQlR2UjVweExFQUkycVRoSVF3?=
 =?utf-8?B?RUZFMFpSMzJpQmt5M2hmam83d2xHRm40Y2NUQlZ4d2NSMFp4dFpoR1VhM3JE?=
 =?utf-8?B?TnhVS3cvSDR4Z0ZpblhyQWVOaStYM0VKMlBHUFlhcThmR2U3MGxIL1AxTzFB?=
 =?utf-8?B?Q2dNeWJjaTFTREJ5N0NHWlRyN05TWXpnTlBFM2ZoZittY2t0MUFHOENoVVd6?=
 =?utf-8?B?aFJMR0JZT1k1cnM4NGhnUHhNMkh1TzcwbUp1MUFqdlVYcHFkbmovZURhNy9D?=
 =?utf-8?B?WnB1aVBzSFF4eU9xcU0yL3JKMHJFVDlUZHh3ZjQyUVhtNGFrVWNteURlcHVX?=
 =?utf-8?B?SUJjUGI1bWhGK1drQmtPUVFGL0dVN0t3WmptSllkUjBFdjhWNUtncWRxbFpB?=
 =?utf-8?B?N0VSaVc2dVVHb0NnOWEveEN2MktXZWovbHNONlhweXo4akFweUllRmo0ZGds?=
 =?utf-8?B?Y2lVcmxHREVSTEMwOGpML09oK0ZLakpydndCTTcxK1VxWFFXS01rUzVKRWlG?=
 =?utf-8?B?bWUwbUM0dTJVdDdqMTBkdzdTbGs1eTROeFJpb096VkxTTmt0ZG5VWGV5WWo5?=
 =?utf-8?B?enkvQThMR1ZYZjF3WldXcWdhbmV4ancxdFVWKzQyaG9zRU1idDVKYU9PdFBz?=
 =?utf-8?B?dG9YYTZyZlIyNjlEc3R3MWM1OTJuQUhHNTg2VmRRL1F2NVBueG5lQXpUcW16?=
 =?utf-8?B?bkEvT2syYkQxUXJJb0pReFV3NGtaNWg0UCtnR3hJY1VyY1pwY0Jmb1dRUmw2?=
 =?utf-8?B?R2QrTlFyN3pWVUpVRFJWUytNZ0dRZ0tjclc3UE15WDNWN2dXdzlJKzNSUkR4?=
 =?utf-8?B?a1licW5kdUNUV0x1c0owOHU3Vm1JUjd2REE5R1hkckphSlNpeFd2MWptZFVW?=
 =?utf-8?B?MTh1M0lBQkFVMUN0OU0ydUx1bVVqeHBKRlh2WWpTbG9IQ2RoeHpUUjlTa2V2?=
 =?utf-8?B?ckVxdjNiSXd6YXpZUlIxVHNGOG5pTjh2cm9jWWtvVEljWThCNGM2T2dQS0dq?=
 =?utf-8?B?L2w2SEZGMU5kU0QyLzg4OGJUbFAxblNrVUxzY1J2SkZiTTNHdlVJTTgxL3dS?=
 =?utf-8?B?TU1CSU5YMnh2RHQ1KzVSWTNOdllYQjI5Nis0dWltQVV6NE80SFZZY29LbnZK?=
 =?utf-8?B?cHBIZUp6d3ZrNHJuVDV3azhkYzIydUFuTko5amVFTldKbHVmakJwOTVJRmcr?=
 =?utf-8?B?QlpjbkdPbDZieGhsdGhEaW1TSEs2VXFPUUhrQ1VMeDM5RENuYTBBZkpuYUJU?=
 =?utf-8?B?WGsrbWZMNEw0c0hqOFg1Y2d2UEpJZG44cVdkY2NhSUJUdS9DdE8veHV2VXhy?=
 =?utf-8?B?Q2lPSjM3UDNtT202SnpZTlRXN0RjdkFKMUFSTGxZeC9UcGpuOVdPbmUyRVBw?=
 =?utf-8?B?QlNMWHlxd0tpOGE0dHdQQkNTdFFpNEZIaUVTeUQ5ZitiRzNzM1o3dXhpK3kv?=
 =?utf-8?B?R2ZmeE9SQyswbml2K0lHY2EyWWtTaVM4bHVEUGEvL3NMUitQTFduRWxaQTJy?=
 =?utf-8?B?clgxdmVHeXFNdXp0bzB0VzJsU0Z2N2p6eXVaNEJJa3ZCWXpMRnduazc5cmV4?=
 =?utf-8?B?bGxBQXZnSzFZdWtEMjZQTFEyYjZtd1dNaGhMM0N6dDI4OXovNHRNcDc2aTdU?=
 =?utf-8?B?UUoxUFV2d2x5SlFKUkMydXkveWJtZi9iUkYzdmtTbUxXeU5EeW5NVmNNVTBG?=
 =?utf-8?B?VmVPWGhta3FhaEdwM3JXNjFCV05QVVBnWDlVWXRTcDBTb0JwSERkR1dPU0pE?=
 =?utf-8?B?Tk56aVRRV2o2eGw2d1ZXajNxL2ZIL0svaDJjaXB4c3FqTWZKZWxIR2lDd3p5?=
 =?utf-8?B?QVlRbnFIeHFaOEVmY01qME1KUStPZHBlMUduVzBkSWxtWmpUdzFxY08rNnE1?=
 =?utf-8?B?SDZOdzJ5RVFhdjg4Z0RNMTB2MUkrb0ZoMXBEdGEwdVptbjJ4c2JYQ01IQmRi?=
 =?utf-8?B?bkdySG1JYWpTbW92dlYzcjhTamc5bHMzREg4R3FxYUFlbzAxQnVqaXpGb1Rv?=
 =?utf-8?B?cXBlQmZmbHlCeWRWb0xLZWZqMkhyNFZTQmUreitNazVyQUY3UVQ3VXdacUZj?=
 =?utf-8?Q?ySJBJ832u6RXQ7wwxT1xYK8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D68B5FA5B949AE49B4865587AC471B3E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc9c21a-ad49-4493-7b93-08db1b67de3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 21:48:32.6922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /PtSkarg4o9w+QkVK9lUlzzJ5i1O2fF2WASuTaQyf1hIaKnqlQnNJhyBmZbkBfoUdAKJitx3Urc/NtrwAPmomSQ3+T5o1ijneGzfg7fG52Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7962
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIzLTAzLTAyIGF0IDE3OjM0ICswMDAwLCBTemFib2xjcyBOYWd5IHdyb3RlOg0K
PiBUaGUgMDIvMjcvMjAyMyAxNDoyOSwgUmljayBFZGdlY29tYmUgd3JvdGU6DQo+ID4gRm9yIHNo
YWRvdyBzdGFjayBlbmFibGVkIHZmb3JrKCksIHRoZSBwYXJlbnQgYW5kIGNoaWxkIGNhbiBzaGFy
ZQ0KPiA+IHRoZSBzYW1lDQo+ID4gc2hhZG93IHN0YWNrLCBsaWtlIHRoZXkgY2FuIHNoYXJlIGEg
bm9ybWFsIHN0YWNrLiBTaW5jZSB0aGUgcGFyZW50DQo+ID4gaXMNCj4gPiBzdXNwZW5kZWQgdW50
aWwgdGhlIGNoaWxkIHRlcm1pbmF0ZXMsIHRoZSBjaGlsZCB3aWxsIG5vdCBpbnRlcmZlcmUNCj4g
PiB3aXRoDQo+ID4gdGhlIHBhcmVudCB3aGlsZSBleGVjdXRpbmcgYXMgbG9uZyBhcyBpdCBkb2Vz
bid0IHJldHVybiBmcm9tIHRoZQ0KPiA+IHZmb3JrKCkNCj4gPiBhbmQgb3ZlcndyaXRlIHVwIHRo
ZSBzaGFkb3cgc3RhY2suIFRoZSBjaGlsZCBjYW4gc2FmZWx5IG92ZXJ3cml0ZQ0KPiA+IGRvd24N
Cj4gPiB0aGUgc2hhZG93IHN0YWNrLCBhcyB0aGUgcGFyZW50IGNhbiBqdXN0IG92ZXJ3cml0ZSB0
aGlzIGxhdGVyLiBTbw0KPiA+IENFVCBkb2VzDQo+ID4gbm90IGFkZCBhbnkgYWRkaXRpb25hbCBs
aW1pdGF0aW9ucyBmb3IgdmZvcmsoKS4NCj4gPiANCj4gPiBVc2Vyc3BhY2UgaW1wbGVtZW50aW5n
IHBvc2l4IHZmb3JrKCkgY2FuIGFjdHVhbGx5IHByZXZlbnQgdGhlIGNoaWxkDQo+ID4gZnJvbQ0K
PiA+IHJldHVybmluZyBmcm9tIHRoZSB2Zm9yaygpIGNhbGxpbmcgZnVuY3Rpb24sIHVzaW5nIENF
VC4gR2xpYmMgZG9lcw0KPiA+IHRoaXMNCj4gPiBieSBhZGp1c3RpbmcgdGhlIHNoYWRvdyBzdGFj
ayBwb2ludGVyIGluIHRoZSBjaGlsZCwgc28gdGhhdCB0aGUNCj4gPiBjaGlsZA0KPiA+IHJlY2Vp
dmVzIGEgI0NQIGlmIGl0IHRyaWVzIHRvIHJldHVybiBmcm9tIHZmb3JrKCkgY2FsbGluZyBmdW5j
dGlvbi4NCj4gDQo+IHRoaXMgY29tbWl0IG1lc3NhZ2UgaW1wbGllcyB0aGVyZSBpcyBwcm90ZWN0
aW9uIGFnYWluc3QNCj4gdGhlIHZmb3JrIGNoaWxkIGNsb2JiZXJpbmcgdGhlIHBhcmVudCdzIHNo
YWRvdyBzdGFjaywNCj4gYnV0IGFjdHVhbGx5IHRoZSBjaGlsZCBjYW4gSU5DU1NQIChvciBsb25n
am1wKSBhbmQgdGhlbg0KPiBjbG9iYmVyIGl0Lg0KDQpJdCdzIHRydWUgdGhlIHZmb3JrIGNoaWxk
IGNvdWxkIHVzZSBJTkNTU1AgYW5kIGNsb2JiZXIgdG8gY3JlYXRlDQpwcm9ibGVtcywgc28gaXQg
aXMgbm90IGEgc3Ryb25nIGd1YXJhbnRlZSBvZiBzaGFkb3cgc3RhY2sgaW50ZWdyaXR5Lg0KQnV0
IHRoYXQncyBub3QgY2xhaW1lZCBlaXRoZXIuIEl0IGRvZXMgInByZXZlbnQgdGhlIGNoaWxkIGZy
b20NCnJldHVybmluZyBmcm9tIHRoZSB2Zm9yaygpIGNhbGxpbmcgZnVuY3Rpb24iIGFzIG11Y2gg
YXMgc2hhZG93IHN0YWNrDQpwcm90ZWN0aW9ucyBhcHBseSwgd2hpY2ggSSB0aGluayB3b3VsZCBi
ZSByZWFzb25hYmx5IHVuZGVyc3Rvb2QuIFRoZQ0KdmZvcmsgY2hpbGQgY291bGQgYWxzbyB1c2Ug
d3JzcyB0byB3cml0ZSB0aGUgcmV0dXJuIGFkZHJlc3MgdG8gdGhlDQpzaGFkb3cgc3RhY2sgYW5k
IGFjdHVhbGx5IHJldHVybiwgb3IgZGlzYWJsZSBzaGFkb3cgc3RhY2sgYW5kIHJldHVybiwNCmFz
IG90aGVyIHdheXMgdG8gY3JlYXRlIHByb2JsZW1zLg0KDQo+IA0KPiBzbyB0aGUgZ2xpYmMgY29k
ZSBqdXN0IHRyaWVzIHRvIGNhdGNoIGJ1Z3MgYW5kIGFjY2lkZW50cw0KPiBub3QgYSBzdHJvbmcg
c2VjdXJpdHkgbWVjaGFuaXNtLiBpJ2Qgc2tpcCB0aGlzIHBhcmFncmFwaC4NCg0KWWVwLiBJIHRo
aW5rIGl0J3MgdmVyeSBtdWNoIGEgIm5pY2UgdG8gaGF2ZSIgdGhpbmcgYW5kIG5vdCBpbnRlbmRl
ZCBmb3INCnNlY3VyaXR5LiBUaGUgcGFyYWdyYXBoIGlzIGFuIGFzaWRlIGFueXdheSwgYmVjYXVz
ZSBpdCBpcyBzcGVjaWZpY3MNCmFib3V0IGFub3RoZXIgcHJvamVjdC4gSSBkb24ndCBoYXZlIGFu
eSBvYmplY3Rpb24gdG8gZHJvcHBpbmcgaXQgaWYgdGhlDQpvcHBvcnR1bml0eSBjb21lcyB1cC4g
SUlSQyBpdCB3YXMgYWRkZWQgYmVjYXVzZSBzb21lb25lIHRob3VnaHQgdmZvcmsNCmNvdWxkbid0
IHdvcmsgd2l0aCBzaGFkb3cgc3RhY2ssIHNvIHBlb3BsZSBtaWdodCBsaWtlIHRvIGhhdmUgdGhl
DQpkZXRhaWxzIG9mIGhvdyBjYW4gYmUgZG9uZS4NCg0KSSB3b3VsZG4ndCBldmVuIGJlIHRvbyBi
b3RoZXJlZCBpZiB0aGUgZGlzY3Vzc2VkIGdsaWJjIGJlaGF2aW9yIHdhcw0KZHJvcHBlZCBlaXRo
ZXIuIHZmb3JrKCkgY2FuIGdvIHdyb25nIG1hbnkgd2F5cyByZWdhcmRsZXNzIG9mIHNoYWRvdw0K
c3RhY2suIElzIGl0IHdvcnRoIHRoZSBleHRyYSBzcGVjaWFsIGJlaGF2aW9yPyBNYXliZSBqdXN0
IGJhcmVseS4uLg0K
