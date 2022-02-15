Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D429A4B5FF3
	for <lists+linux-arch@lfdr.de>; Tue, 15 Feb 2022 02:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiBOBW0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Feb 2022 20:22:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiBOBWY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 20:22:24 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D372BB57B;
        Mon, 14 Feb 2022 17:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644888135; x=1676424135;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lwOs+0Oe0K4gYQKcMHrsg11SyTFei8L5B5SwerBFd4o=;
  b=LeXF7y+yRna6mycWpxezzMCP7+HgsaFXUbAbdpKIX3fotLN1aE+v7k59
   4RTiSLQdhSC+UCn6d4p2WXK+h/pJlq0xXJPOYxRz5ZDMnSR3Z8EJzHTFY
   LXIRC3Di+d5A51UkvcnNG0EiGsGdsAe8Kbv7s3RlfiWJQy9uzcx5lZ30c
   madvDQbgBaK8V6o8TGaROxRiDV83Zr7xxBhbS+ISEXUTeuA0g+nsfS17l
   88TmSGPoE17EQTCuPD+jquq3WQ/sVWvSV9kg65gnS8IRRuiOhPoZscCDt
   ZSF64Jx4PnpCcesGDNnizcDprAVpLj6Q5LxE3cEUBgWlAQ/aTAQ7e9lA9
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="247817632"
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="247817632"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 17:22:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="680784398"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2022 17:22:14 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 14 Feb 2022 17:22:14 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 14 Feb 2022 17:22:13 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 14 Feb 2022 17:22:13 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 14 Feb 2022 17:22:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0J/80TCA3bKgKoTHRfuE/ML3E0x/RClCceoq36Meqt8w6eXph1gARMuAgnK2mHsEnsPqBz/t8y3OXoYh032/K/OE7UFpZHtpZWHt+oCWbecCdHjViVmXX904Cv1raCosZrCFFI8G4GEoEq6xg65ho97l6yqkfZa3h5ruZpei8LFIBL9uHUsfdsydVSWgCbgq59BbCAxz63+1XHBQTe3Rny/A9FXje10pkXoWj2eyS80hqyv+N5w0Ky4M7adOPGOAvSt5jpykra0aOD8HZE4EcqQ/l30z0bz2M8D+PGOwEE0dHHXLp3NVTWzw/rvEIMJtIRj5xHUEJKXpfaQtW/MYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwOs+0Oe0K4gYQKcMHrsg11SyTFei8L5B5SwerBFd4o=;
 b=XeF53T+YY8Alu3dUSaB7n0zODkFUbetTEzG/rrqzKUWacVmi4xG+MPPjdPVnQpXr93V3XbuR9flJZSt8yRHaMVKn75q34F3tXMqIvp/RTLoWEI/KVGTJFDFhZgqSXQbr4mF8hb46a4vL3Yo4OJ2fgQNhcVx/ydDWX8yofjxNxqh2ZTlWMt4GsGc1+ReBZyWQfghUgutVUMq4yTSaRqu1WDk62NKzKJpksyPcYrUWPUdT0bLj/hHlKYmSLW2IDiu4w7Nsnz3bqJYoXRaCNC67Jl5jGI8fsBcMcbF2ooeUzWZipoDd8RokT80ZKwTfrxO4Pw4AqhGRJaF/X5owtETAxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM6PR11MB2569.namprd11.prod.outlook.com (2603:10b6:5:c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 01:22:04 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 01:22:04 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "jannh@google.com" <jannh@google.com>
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
        "dave.martin@arm.com" <dave.martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH 26/35] x86/process: Change copy_thread() argument 'arg' to
 'stack_size'
Thread-Topic: [PATCH 26/35] x86/process: Change copy_thread() argument 'arg'
 to 'stack_size'
Thread-Index: AQHYFh91Rj66tgwW7EWlgeEMY1b8B6yTEgGAgADWngA=
Date:   Tue, 15 Feb 2022 01:22:04 +0000
Message-ID: <959707bff94b3a54f05cfcfc09fa809f08152807.camel@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
         <20220130211838.8382-27-rick.p.edgecombe@intel.com>
         <CAG48ez0_Ng8Fv4ytLK=Y5ANXiDfBPsFFwfxQTzgmDjU1RNFnDw@mail.gmail.com>
In-Reply-To: <CAG48ez0_Ng8Fv4ytLK=Y5ANXiDfBPsFFwfxQTzgmDjU1RNFnDw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc1ad9d2-31e5-4a24-20f3-08d9f0219327
x-ms-traffictypediagnostic: DM6PR11MB2569:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB2569C6BB1AACBFF3DB908406C9349@DM6PR11MB2569.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2X52Ai2vBUkVrq2Q3iRLVgW6mibd8GTH9FNCp1phYAxhRRmLme+hF2pBZs6Tl2AiPBYAFy2rXNT9xD5UR7dIOeCWHbRHJXKApexd1YGaV+ZFr3DJg0mEzafWDrKDHUBWtuY8IeRFZNvf8QgYKpBRZ/e4oTvzQkuPn4Z1yduYWj2TY1PJv9U4lHMWJH42IRROhH91268ofjVeuau2xMXM3aDsUfWQv3we6gWcaabU1KGaW9hiCx2FirJCk4s8lYOEDE27z0MtCwD5UU1A2lq0ldMuNDBFi59mmtMIudHWWPmkScVN7HhuLIHZTGj/qDHuJRRUCCyZ6nt3Ki68WP2fS/99H09bSiLLK0szK3PBdYUv9la3igiVfnc7xKPevmYVupK4/8YXag7fnfnGF752a3LQdG+lCwKePPtmUTuj6PZPC2JXTQ0DOKAZ6JzNiIyakAJ8eY8d7iMGy5znL2h+9w/L3X9RWOtkn/Ze2Q4ZYfMuvrX605KSn+EKvvPuaU0uadejHCzLNia3mNr7bvlx6DirK/KgZIaBPHvJtiI3qrRODfNFRcdSu3qah9Jfy4j057f4exhXwubhz8frFXd6h1xxqKL55hsHrWS/7PCau/aeUFaxtCuUAfb0Jcu180tKR9MqZBsJRPt7IdXnyV9GNi5I7KilpLxZEGae9ipLH5F+mnR9ahzJHJS4CJf9lINOWydpSJILR9AR8FUBTo42ITMA5pl1z/jKt2hqKusovLM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(6916009)(2906002)(316002)(54906003)(8676002)(4326008)(66476007)(66446008)(122000001)(64756008)(38100700002)(82960400001)(76116006)(66556008)(508600001)(71200400001)(38070700005)(8936002)(7406005)(7416002)(5660300002)(83380400001)(26005)(53546011)(6512007)(186003)(2616005)(86362001)(6486002)(6506007)(36756003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGIvaVZPcTZWd3krZWxONGdvVWxjQ2hPQXA2Yng2cmlMdGNRT2xZM2dTQmQ5?=
 =?utf-8?B?cUdFVDRQeEdkdUhIZmVGZzRvd2FrZmdMRElUcjJPUXYyd01YL2gyc0hQMmZT?=
 =?utf-8?B?UzFyS2p2ditpMzdhZHBsWkVKOXRwQWxKT0t2T1pVMkF3LzRvR3hXeFNjNDJo?=
 =?utf-8?B?Q2pXb1F4OHdmVkpwSWFrcnpWV1RQa2FuUnViZUZhQzhPcmdEUk5yVVBoenlJ?=
 =?utf-8?B?enA3REVOMVR5OEgrSGc2UFFzWHBYS1MycTM3a2lJRWdreTladlRubHRETGNI?=
 =?utf-8?B?bjF4WHllb1dwOGJBOWdSQ240Y3FtM3VkaGc0b3ZjNXpra0dXcFRGYW0vNDVF?=
 =?utf-8?B?MzlOMml6bndROU03emtRSlo5NDRHdDlTVjV4b0hhQklnOVlwQmdMRGcySys5?=
 =?utf-8?B?TG1FcEJDZkowakJBRUZzd203MXJCRUU0TU5CL1NEaU8yMXRZRXJDTElFNlNs?=
 =?utf-8?B?ZGpnaC9yemYxUEtEOUFZN3RLazBkdkRWNEFGRFdhajVQZ1BHaUk4czAyMFc2?=
 =?utf-8?B?aUh0QUFEalJDc29WaTB3R3ZjZE11WEhETEZPWmdKUXA3ZUFGS0ZCZEkycWoy?=
 =?utf-8?B?dTR3a0lXWkEzd0ZYa0Y1RURFbGNYbjFGdFh6Rjk3UE5KSGFDSmZ4RENMYklK?=
 =?utf-8?B?cWdzeGNtSHY2M2hpTllnbTVNYzd2bnpRTEZ0OEU5SG9DYVJPdlozalphQVEz?=
 =?utf-8?B?aG9zditjQWdHM2hhcTBwdHMvbEdReHlWU1p0blRkZ1RpNFYrTVU0blQvWU1B?=
 =?utf-8?B?Q1FYb0xPYXBVSkFxS3ZhWHBOdkx5YUtzWDhtM2g4RGZQekluV1A4MWJ0TlBv?=
 =?utf-8?B?NFdJUXF4cndWOWZTVWNYMSttKzRQYmV5L0hvMHlRTHFFaCtkQUdVSktUYkZW?=
 =?utf-8?B?TE9GTW1kU1RoNEhrMGhaZlFaMFFQTnpQZXBtdndzZU5lUk5nQ1FkK0x1bGxD?=
 =?utf-8?B?OTg2VWtNa1lBZGNXaTRRNkVzUVJZakdaQk1tVTNQdWJzUEFaWTFNTzdDUG5F?=
 =?utf-8?B?TXpZdE9JMXlWT0dvMnB3eWxVcWZXejQxKzRPSHpsQkp2N3hvckFxeGR2QzNR?=
 =?utf-8?B?K1lwaENjdWZWQ0x2d0tGam5rRVpyckF5YlJmbytFcGVlWVZIMUJpT3RjV2U5?=
 =?utf-8?B?SlRzcE5PRmtZUThBYXhIb1ZrcTZyUGQyeFJJcjFwNTQ3aWI4Szc0T3EzOG5P?=
 =?utf-8?B?N2VIV05tMmVMbGZOY3RLbVJvdllyM0hvSlRGZ0kzYTk2akdDNW9oYmtTZVZQ?=
 =?utf-8?B?MVJibkhQaGJPaXordXRSeFFIMEV0Q3lNVEJXa1hNVDh2U1NEd3VWWEdNcHpS?=
 =?utf-8?B?eFYzeUVySmpZenlqUjNxOFJseUNoa1A1dVNFM3VUYVA0MW9jMTdiR3BoYlRX?=
 =?utf-8?B?cnVhRVVSM0p6RWE0TGZNb1RKM0xmTVAwNjdVUm9XeUQ2MHZzNTVGaW9Bbnow?=
 =?utf-8?B?ekhOeFQ0ZkNsWGVRY3Z4OGtScERoSWVQTWFNTy96TUtSdC9zUzhDOXhySTAr?=
 =?utf-8?B?MW9kRFYzYm84WG1kYTc1UG9pdCtFMExOZlBGS2hydmxEQzlnMHUvc2UwTDZl?=
 =?utf-8?B?VU9NMkRNbGtTWERIYldxeTBJR21hQ0M4aml2NGsySjJnUXJ6L1BBbHNBakhL?=
 =?utf-8?B?cTlUb0FNV3Z1dXREak5IL1lpWnIrbHdFSlJtSEZDeENxaGpOS0RnN0RaSUp0?=
 =?utf-8?B?cTh6K29kWE5HRG4wS2o2a1RWa2tYS1MxOGJBRWVYOENkRHJXUzMvVlN3eHlo?=
 =?utf-8?B?d1owTEZyYkRFN1pQczM3b3lveEgrZXVBSERJbGtya0tRczJoQ1NpQy83SnBT?=
 =?utf-8?B?Z3hhSExKS0NrcWkrTWY5dHVab1JVMDBJVmNXYTRuWTFIN0tkanhnRC8zNEE3?=
 =?utf-8?B?OWo3STBYZVZOczFqVWE5OWVUdVM5elIyR29rUTBxdVFYZTRteHUvVVBKSEo3?=
 =?utf-8?B?cXM2ZXd2U1YxTFcycEYxNm9wa2Y1RUVNdzhWd3NUSDdqTjB5aGZHNnVCd0dT?=
 =?utf-8?B?ZEdBZkxXbDk5WlVEM2hscHNqMkZjQ2tkWm1sZm1scnF4WWlxd0d6OSs5S0Ny?=
 =?utf-8?B?VE44MEpva0FBRnpDaGdRTlhCaDVjaHltS0hPSEhRa3ZUU1hmd3loZVhvVnZn?=
 =?utf-8?B?eGp3azB6ajEvSkxtZWRVL0ttL1Myc0U1UU01SXJacnl5d0w1WlExQ0FrRnli?=
 =?utf-8?B?TlRIQ2pqRjh4YVJuR2NDZnNSZ1BDK1B0Um1VZzRaS2FZb3ZJemVaZkZMZVhF?=
 =?utf-8?Q?3mr07t++e8xwZanFaPRK+OiPjowIRqcsEW3VmoYd1c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA8525ABDA784B48BFE407111CE4F23A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1ad9d2-31e5-4a24-20f3-08d9f0219327
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 01:22:04.1475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YMhRxiH+Q1Y4k3brb67Up2eIeY4VbHfRHkl0OCHgNsOi0qCIQyjeQ4L6OYRj6NlCDKrpc8NmId7ud+nIk4TW+k/u8v9ztu2lCVEtdZlNHCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2569
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTAyLTE0IGF0IDEzOjMzICswMTAwLCBKYW5uIEhvcm4gd3JvdGU6DQo+IE9u
IFN1biwgSmFuIDMwLCAyMDIyIGF0IDEwOjIyIFBNIFJpY2sgRWRnZWNvbWJlDQo+IDxyaWNrLnAu
ZWRnZWNvbWJlQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gRnJvbTogWXUtY2hlbmcgWXUg
PHl1LWNoZW5nLnl1QGludGVsLmNvbT4NCj4gPiANCj4gPiBUaGUgc2luZ2xlIGNhbGwgc2l0ZSBv
ZiBjb3B5X3RocmVhZCgpIHBhc3NlcyBzdGFjayBzaXplIGluDQo+ID4gJ2FyZycuICBUbyBtYWtl
DQo+ID4gdGhpcyBjbGVhciBhbmQgaW4gcHJlcGFyYXRpb24gb2YgdXNpbmcgdGhpcyBhcmd1bWVu
dCBmb3Igc2hhZG93DQo+ID4gc3RhY2sNCj4gPiBhbGxvY2F0aW9uLCBjaGFuZ2UgJ2FyZycgdG8g
J3N0YWNrX3NpemUnLiAgTm8gZnVuY3Rpb25hbCBjaGFuZ2VzLg0KPiANCj4gQWN0dWFsbHkgdGhh
dCBuYW1lIGlzIG1pc2xlYWRpbmcgLSB0aGUgc2luZ2xlIGNhbGxlciBjb3B5X3Byb2Nlc3MoKQ0K
PiBpbmRlZWQgZG9lczoNCj4gDQo+IHJldHZhbCA9IGNvcHlfdGhyZWFkKGNsb25lX2ZsYWdzLCBh
cmdzLT5zdGFjaywgYXJncy0+c3RhY2tfc2l6ZSwgcCwNCj4gYXJncy0+dGxzKTsNCj4gDQo+IGJ1
dCB0aGUgbWVtYmVyICJzdGFja19zaXplIiBvZiAic3RydWN0IGtlcm5lbF9jbG9uZV9hcmdzIiBj
YW4NCj4gYWN0dWFsbHkNCj4gYWxzbyBiZSBhIHBvaW50ZXIgYXJndW1lbnQgZ2l2ZW4gdG8gYSBr
dGhyZWFkLCBzZWUgY3JlYXRlX2lvX3RocmVhZCgpDQo+IGFuZCBrZXJuZWxfdGhyZWFkKCk6DQo+
IA0KPiBwaWRfdCBrZXJuZWxfdGhyZWFkKGludCAoKmZuKSh2b2lkICopLCB2b2lkICphcmcsIHVu
c2lnbmVkIGxvbmcNCj4gZmxhZ3MpDQo+IHsNCj4gICBzdHJ1Y3Qga2VybmVsX2Nsb25lX2FyZ3Mg
YXJncyA9IHsNCj4gICAgIC5mbGFncyAgICA9ICgobG93ZXJfMzJfYml0cyhmbGFncykgfCBDTE9O
RV9WTSB8DQo+ICAgICAgICAgICAgIENMT05FX1VOVFJBQ0VEKSAmIH5DU0lHTkFMKSwNCj4gICAg
IC5leGl0X3NpZ25hbCAgPSAobG93ZXJfMzJfYml0cyhmbGFncykgJiBDU0lHTkFMKSwNCj4gICAg
IC5zdGFjayAgICA9ICh1bnNpZ25lZCBsb25nKWZuLA0KPiAgICAgLnN0YWNrX3NpemUgID0gKHVu
c2lnbmVkIGxvbmcpYXJnLA0KPiAgIH07DQo+IA0KPiAgIHJldHVybiBrZXJuZWxfY2xvbmUoJmFy
Z3MpOw0KPiB9DQo+IA0KPiBBbmQgdGhlbiBpbiBjb3B5X3RocmVhZCgpLCB3ZSBoYXZlOg0KPiAN
Cj4ga3RocmVhZF9mcmFtZV9pbml0KGZyYW1lLCBzcCwgYXJnKQ0KPiANCj4gDQo+IFNvIEknbSBu
b3Qgc3VyZSB3aGV0aGVyIHRoaXMgbmFtZSBjaGFuZ2UgcmVhbGx5IG1ha2VzIHNlbnNlLCBvcg0K
PiB3aGV0aGVyIGl0IGp1c3QgYWRkcyB0byB0aGUgY29uZnVzaW9uLg0KDQpUaGFua3MgSmFubi4g
WWVhIEkgZ3Vlc3MgdGhpcyBtYWtlcyBpdCB3b3JzZS4NCg0KUmVhZGluZyBhIGJpdCBvZiB0aGUg
aGlzdG9yeSwgaXQgc2VlbXMgdGhlcmUgdXNlZCB0byBiZSB1bndpZWxkeQ0KYXJndW1lbnQgbGlz
dHMgd2hpY2ggd2VyZSByZXBsYWNlZCBieSBhIGJpZyAic3RydWN0IGtlcm5lbF9jbG9uZV9hcmdz
Ig0KdG8gYmUgcGFzc2VkIGFyb3VuZC4gVGhlIHJlLXVzZSBvZiB0aGUgc3RhY2tfc2l6ZSBhcmd1
bWVudCBpcyBmcm9tDQpiZWZvcmUgdGhlcmUgd2FzIHRoZSBzdHJ1Y3QuIEFuZCB0aGVuIHRoZSBz
dHJ1Y3QganVzdCBpbmhlcml0ZWQgdGhlDQpjb25mdXNpb24gd2hlbiBpdCB3YXMgaW50cm9kdWNl
ZC4NCg0KU28gaWYgYSBzZXBhcmF0ZSAqZGF0YSBtZW1iZXIgd2FzIGFkZGVkIHRvIGtlcm5lbF9j
bG9uZV9hcmdzIGZvcg0Ka2VybmVsX3RocmVhZCgpIGFuZCBjcmVhdGVfaW9fdGhyZWFkKCkgdG8g
dXNlLCB0aGV5IHdvdWxkbid0IG5lZWQgdG8NCnJlLXVzZSBzdGFja19zaXplLiBBbmQgY29weV90
aHJlYWQoKSBjb3VsZCBqdXN0IHRha2UgYSBzdHJ1Y3QNCmtlcm5lbF9jbG9uZV9hcmdzIHBvaW50
ZXIuIEl0IG1pZ2h0IG1ha2UgaXQgbW9yZSBjbGVhci4NCg0KQnV0IGNvcHlfdGhyZWFkKCkgaGFz
IGEgdG9uIG9mIGFyY2ggc3BlY2lmaWMgaW1wbGVtZW50YXRpb25zLiBTbyB0aGV5DQp3b3VsZCBh
bGwgbmVlZCB0byBiZSB1cGRhdGVkIHRvIGRvIHRoaXMuDQoNCkp1c3QgcGxheWluZyBhcm91bmQg
d2l0aCBpdCwgSSBkaWQgdGhpcyB3aGljaCBvbmx5IG1ha2VzIHRoZSBjaGFuZ2Ugb24NCng4Ni4g
RHVwbGljYXRpbmcgaXQgZm9yIDIxIGNvcHlfdGhyZWFkKClzIHNlZW1zIHBlcmZlY3RseSBkb2Fi
bGUsIGJ1dA0KSSdtIG5vdCBzdXJlIGhvdyBtdWNoIHBlb3BsZSBjYXJlIHZzIHJlbmFtaW5nIGFy
ZyB0bw0Kc3RhY2tzaXplX29yX2RhdGEuLi4NCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5l
bC9wcm9jZXNzLmMgYi9hcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzcy5jDQppbmRleCAxMWJmMDliNjBm
OWQuLmNmYmJhNWIxNDYwOSAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2tlcm5lbC9wcm9jZXNzLmMN
CisrKyBiL2FyY2gveDg2L2tlcm5lbC9wcm9jZXNzLmMNCkBAIC0xMzIsOSArMTMyLDggQEAgc3Rh
dGljIGludCBzZXRfbmV3X3RscyhzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAsDQp1bnNpZ25lZCBsb25n
IHRscykNCiAgICAgICAgICAgICAgICByZXR1cm4gZG9fc2V0X3RocmVhZF9hcmVhXzY0KHAsIEFS
Q0hfU0VUX0ZTLCB0bHMpOw0KIH0NCiANCi1pbnQgY29weV90aHJlYWQodW5zaWduZWQgbG9uZyBj
bG9uZV9mbGFncywgdW5zaWduZWQgbG9uZyBzcCwNCi0gICAgICAgICAgICAgICB1bnNpZ25lZCBs
b25nIHN0YWNrX3NpemUsIHN0cnVjdCB0YXNrX3N0cnVjdCAqcCwNCi0gICAgICAgICAgICAgICB1
bnNpZ25lZCBsb25nIHRscykNCitpbnQgY29weV90aHJlYWQodW5zaWduZWQgbG9uZyBjbG9uZV9m
bGFncywgc3RydWN0IGtlcm5lbF9jbG9uZV9hcmdzDQoqYXJncywNCisgICAgICAgICAgICAgICBz
dHJ1Y3QgdGFza19zdHJ1Y3QgKnApDQogew0KICAgICAgICBzdHJ1Y3QgaW5hY3RpdmVfdGFza19m
cmFtZSAqZnJhbWU7DQogICAgICAgIHN0cnVjdCBmb3JrX2ZyYW1lICpmb3JrX2ZyYW1lOw0KQEAg
LTE3OCw3ICsxNzcsNyBAQCBpbnQgY29weV90aHJlYWQodW5zaWduZWQgbG9uZyBjbG9uZV9mbGFn
cywgdW5zaWduZWQNCmxvbmcgc3AsDQogICAgICAgIGlmICh1bmxpa2VseShwLT5mbGFncyAmIFBG
X0tUSFJFQUQpKSB7DQogICAgICAgICAgICAgICAgcC0+dGhyZWFkLnBrcnUgPSBwa3J1X2dldF9p
bml0X3ZhbHVlKCk7DQogICAgICAgICAgICAgICAgbWVtc2V0KGNoaWxkcmVncywgMCwgc2l6ZW9m
KHN0cnVjdCBwdF9yZWdzKSk7DQotICAgICAgICAgICAgICAga3RocmVhZF9mcmFtZV9pbml0KGZy
YW1lLCBzcCwgc3RhY2tfc2l6ZSk7DQorICAgICAgICAgICAgICAga3RocmVhZF9mcmFtZV9pbml0
KGZyYW1lLCBhcmdzLT5zdGFjaywgKHVuc2lnbmVkDQpsb25nKWFyZ3MtPmRhdGEpOw0KICAgICAg
ICAgICAgICAgIHJldHVybiAwOw0KICAgICAgICB9DQogDQpAQCAtMTkxLDggKzE5MCw4IEBAIGlu
dCBjb3B5X3RocmVhZCh1bnNpZ25lZCBsb25nIGNsb25lX2ZsYWdzLCB1bnNpZ25lZA0KbG9uZyBz
cCwNCiAgICAgICAgZnJhbWUtPmJ4ID0gMDsNCiAgICAgICAgKmNoaWxkcmVncyA9ICpjdXJyZW50
X3B0X3JlZ3MoKTsNCiAgICAgICAgY2hpbGRyZWdzLT5heCA9IDA7DQotICAgICAgIGlmIChzcCkN
Ci0gICAgICAgICAgICAgICBjaGlsZHJlZ3MtPnNwID0gc3A7DQorICAgICAgIGlmIChhcmdzLT5z
dGFjaykNCisgICAgICAgICAgICAgICBjaGlsZHJlZ3MtPnNwID0gYXJncy0+c3RhY2s7DQogDQog
I2lmZGVmIENPTkZJR19YODZfMzINCiAgICAgICAgdGFza191c2VyX2dzKHApID0gZ2V0X3VzZXJf
Z3MoY3VycmVudF9wdF9yZWdzKCkpOw0KQEAgLTIxMSwxNyArMjEwLDE3IEBAIGludCBjb3B5X3Ro
cmVhZCh1bnNpZ25lZCBsb25nIGNsb25lX2ZsYWdzLA0KdW5zaWduZWQgbG9uZyBzcCwNCiAgICAg
ICAgICAgICAgICAgKi8NCiAgICAgICAgICAgICAgICBjaGlsZHJlZ3MtPnNwID0gMDsNCiAgICAg
ICAgICAgICAgICBjaGlsZHJlZ3MtPmlwID0gMDsNCi0gICAgICAgICAgICAgICBrdGhyZWFkX2Zy
YW1lX2luaXQoZnJhbWUsIHNwLCBzdGFja19zaXplKTsNCisgICAgICAgICAgICAgICBrdGhyZWFk
X2ZyYW1lX2luaXQoZnJhbWUsIGFyZ3MtPnN0YWNrLCAodW5zaWduZWQNCmxvbmcpYXJncy0+ZGF0
YSk7DQogICAgICAgICAgICAgICAgcmV0dXJuIDA7DQogICAgICAgIH0NCiANCiAgICAgICAgLyog
U2V0IGEgbmV3IFRMUyBmb3IgdGhlIGNoaWxkIHRocmVhZD8gKi8NCiAgICAgICAgaWYgKGNsb25l
X2ZsYWdzICYgQ0xPTkVfU0VUVExTKQ0KLSAgICAgICAgICAgICAgIHJldCA9IHNldF9uZXdfdGxz
KHAsIHRscyk7DQorICAgICAgICAgICAgICAgcmV0ID0gc2V0X25ld190bHMocCwgYXJncy0+dGxz
KTsNCiANCiAgICAgICAgLyogQWxsb2NhdGUgYSBuZXcgc2hhZG93IHN0YWNrIGZvciBwdGhyZWFk
ICovDQogICAgICAgIGlmICghcmV0KQ0KLSAgICAgICAgICAgICAgIHJldCA9IHNoc3RrX2FsbG9j
X3RocmVhZF9zdGFjayhwLCBjbG9uZV9mbGFncywNCnN0YWNrX3NpemUpOw0KKyAgICAgICAgICAg
ICAgIHJldCA9IHNoc3RrX2FsbG9jX3RocmVhZF9zdGFjayhwLCBjbG9uZV9mbGFncywgYXJncy0N
Cj5zdGFja19zaXplKTsNCiANCiAgICAgICAgaWYgKCFyZXQgJiYgdW5saWtlbHkodGVzdF90c2tf
dGhyZWFkX2ZsYWcoY3VycmVudCwNClRJRl9JT19CSVRNQVApKSkNCiAgICAgICAgICAgICAgICBp
b19iaXRtYXBfc2hhcmUocCk7DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zY2hlZC90YXNr
LmggYi9pbmNsdWRlL2xpbnV4L3NjaGVkL3Rhc2suaA0KaW5kZXggYjkxOThhMWIzYTg0Li5mMTM4
YjIzYWVlNTAgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L3NjaGVkL3Rhc2suaA0KKysrIGIv
aW5jbHVkZS9saW51eC9zY2hlZC90YXNrLmgNCkBAIC0zNCw2ICszNCw3IEBAIHN0cnVjdCBrZXJu
ZWxfY2xvbmVfYXJncyB7DQogICAgICAgIGludCBpb190aHJlYWQ7DQogICAgICAgIHN0cnVjdCBj
Z3JvdXAgKmNncnA7DQogICAgICAgIHN0cnVjdCBjc3Nfc2V0ICpjc2V0Ow0KKyAgICAgICB2b2lk
ICpkYXRhOw0KIH07DQogDQogLyoNCkBAIC02Nyw4ICs2OCw4IEBAIGV4dGVybiB2b2lkIGZvcmtf
aW5pdCh2b2lkKTsNCiANCiBleHRlcm4gdm9pZCByZWxlYXNlX3Rhc2soc3RydWN0IHRhc2tfc3Ry
dWN0ICogcCk7DQogDQotZXh0ZXJuIGludCBjb3B5X3RocmVhZCh1bnNpZ25lZCBsb25nLCB1bnNp
Z25lZCBsb25nLCB1bnNpZ25lZCBsb25nLA0KLSAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qg
dGFza19zdHJ1Y3QgKiwgdW5zaWduZWQgbG9uZyk7DQorZXh0ZXJuIGludCBjb3B5X3RocmVhZCh1
bnNpZ25lZCBsb25nIGNsb25lX2ZsYWdzLCBzdHJ1Y3QNCmtlcm5lbF9jbG9uZV9hcmdzICphcmdz
LA0KKyAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnApOw0KIA0KIGV4
dGVybiB2b2lkIGZsdXNoX3RocmVhZCh2b2lkKTsNCiANCkBAIC04NSwxMCArODYsMTAgQEAgZXh0
ZXJuIHZvaWQgZXhpdF9maWxlcyhzdHJ1Y3QgdGFza19zdHJ1Y3QgKik7DQogZXh0ZXJuIHZvaWQg
ZXhpdF9pdGltZXJzKHN0cnVjdCBzaWduYWxfc3RydWN0ICopOw0KIA0KIGV4dGVybiBwaWRfdCBr
ZXJuZWxfY2xvbmUoc3RydWN0IGtlcm5lbF9jbG9uZV9hcmdzICprYXJncyk7DQotc3RydWN0IHRh
c2tfc3RydWN0ICpjcmVhdGVfaW9fdGhyZWFkKGludCAoKmZuKSh2b2lkICopLCB2b2lkICphcmcs
IGludA0Kbm9kZSk7DQorc3RydWN0IHRhc2tfc3RydWN0ICpjcmVhdGVfaW9fdGhyZWFkKGludCAo
KmZuKSh2b2lkICopLCB2b2lkICpkYXRhLA0KaW50IG5vZGUpOw0KIHN0cnVjdCB0YXNrX3N0cnVj
dCAqZm9ya19pZGxlKGludCk7DQogc3RydWN0IG1tX3N0cnVjdCAqY29weV9pbml0X21tKHZvaWQp
Ow0KLWV4dGVybiBwaWRfdCBrZXJuZWxfdGhyZWFkKGludCAoKmZuKSh2b2lkICopLCB2b2lkICph
cmcsIHVuc2lnbmVkIGxvbmcNCmZsYWdzKTsNCitleHRlcm4gcGlkX3Qga2VybmVsX3RocmVhZChp
bnQgKCpmbikodm9pZCAqKSwgdm9pZCAqZGF0YSwgdW5zaWduZWQNCmxvbmcgZmxhZ3MpOw0KIGV4
dGVybiBsb25nIGtlcm5lbF93YWl0NChwaWRfdCwgaW50IF9fdXNlciAqLCBpbnQsIHN0cnVjdCBy
dXNhZ2UgKik7DQogaW50IGtlcm5lbF93YWl0KHBpZF90IHBpZCwgaW50ICpzdGF0KTsNCiANCmRp
ZmYgLS1naXQgYS9rZXJuZWwvZm9yay5jIGIva2VybmVsL2ZvcmsuYw0KaW5kZXggZDc1YTUyOGY3
YjIxLi44YWYyMDJlNTY1MWUgMTAwNjQ0DQotLS0gYS9rZXJuZWwvZm9yay5jDQorKysgYi9rZXJu
ZWwvZm9yay5jDQpAQCAtMjE3MCw3ICsyMTcwLDcgQEAgc3RhdGljIF9fbGF0ZW50X2VudHJvcHkg
c3RydWN0IHRhc2tfc3RydWN0DQoqY29weV9wcm9jZXNzKA0KICAgICAgICByZXR2YWwgPSBjb3B5
X2lvKGNsb25lX2ZsYWdzLCBwKTsNCiAgICAgICAgaWYgKHJldHZhbCkNCiAgICAgICAgICAgICAg
ICBnb3RvIGJhZF9mb3JrX2NsZWFudXBfbmFtZXNwYWNlczsNCi0gICAgICAgcmV0dmFsID0gY29w
eV90aHJlYWQoY2xvbmVfZmxhZ3MsIGFyZ3MtPnN0YWNrLCBhcmdzLQ0KPnN0YWNrX3NpemUsIHAs
IGFyZ3MtPnRscyk7DQorICAgICAgIHJldHZhbCA9IGNvcHlfdGhyZWFkKGNsb25lX2ZsYWdzLCBh
cmdzLCBwKTsNCiAgICAgICAgaWYgKHJldHZhbCkNCiAgICAgICAgICAgICAgICBnb3RvIGJhZF9m
b3JrX2NsZWFudXBfaW87DQogDQpAQCAtMjQ4Nyw3ICsyNDg3LDcgQEAgc3RydWN0IG1tX3N0cnVj
dCAqY29weV9pbml0X21tKHZvaWQpDQogICogVGhlIHJldHVybmVkIHRhc2sgaXMgaW5hY3RpdmUs
IGFuZCB0aGUgY2FsbGVyIG11c3QgZmlyZSBpdCB1cA0KdGhyb3VnaA0KICAqIHdha2VfdXBfbmV3
X3Rhc2socCkuIEFsbCBzaWduYWxzIGFyZSBibG9ja2VkIGluIHRoZSBjcmVhdGVkIHRhc2suDQog
ICovDQotc3RydWN0IHRhc2tfc3RydWN0ICpjcmVhdGVfaW9fdGhyZWFkKGludCAoKmZuKSh2b2lk
ICopLCB2b2lkICphcmcsIGludA0Kbm9kZSkNCitzdHJ1Y3QgdGFza19zdHJ1Y3QgKmNyZWF0ZV9p
b190aHJlYWQoaW50ICgqZm4pKHZvaWQgKiksIHZvaWQgKmRhdGEsDQppbnQgbm9kZSkNCiB7DQog
ICAgICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3MgPQ0KQ0xPTkVfRlN8Q0xPTkVfRklMRVN8Q0xPTkVf
U0lHSEFORHxDTE9ORV9USFJFQUR8DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIENM
T05FX0lPOw0KQEAgLTI0OTYsNyArMjQ5Niw3IEBAIHN0cnVjdCB0YXNrX3N0cnVjdCAqY3JlYXRl
X2lvX3RocmVhZChpbnQNCigqZm4pKHZvaWQgKiksIHZvaWQgKmFyZywgaW50IG5vZGUpDQogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBDTE9ORV9VTlRSQUNFRCkgJiB+Q1NJR05B
TCksDQogICAgICAgICAgICAgICAgLmV4aXRfc2lnbmFsICAgID0gKGxvd2VyXzMyX2JpdHMoZmxh
Z3MpICYgQ1NJR05BTCksDQogICAgICAgICAgICAgICAgLnN0YWNrICAgICAgICAgID0gKHVuc2ln
bmVkIGxvbmcpZm4sDQotICAgICAgICAgICAgICAgLnN0YWNrX3NpemUgICAgID0gKHVuc2lnbmVk
IGxvbmcpYXJnLA0KKyAgICAgICAgICAgICAgIC5kYXRhICAgICAgICAgICA9IGRhdGEsDQogICAg
ICAgICAgICAgICAgLmlvX3RocmVhZCAgICAgID0gMSwNCiAgICAgICAgfTsNCiANCkBAIC0yNTk0
LDE0ICsyNTk0LDE0IEBAIHBpZF90IGtlcm5lbF9jbG9uZShzdHJ1Y3Qga2VybmVsX2Nsb25lX2Fy
Z3MNCiphcmdzKQ0KIC8qDQogICogQ3JlYXRlIGEga2VybmVsIHRocmVhZC4NCiAgKi8NCi1waWRf
dCBrZXJuZWxfdGhyZWFkKGludCAoKmZuKSh2b2lkICopLCB2b2lkICphcmcsIHVuc2lnbmVkIGxv
bmcgZmxhZ3MpDQorcGlkX3Qga2VybmVsX3RocmVhZChpbnQgKCpmbikodm9pZCAqKSwgdm9pZCAq
ZGF0YSwgdW5zaWduZWQgbG9uZw0KZmxhZ3MpDQogew0KICAgICAgICBzdHJ1Y3Qga2VybmVsX2Ns
b25lX2FyZ3MgYXJncyA9IHsNCiAgICAgICAgICAgICAgICAuZmxhZ3MgICAgICAgICAgPSAoKGxv
d2VyXzMyX2JpdHMoZmxhZ3MpIHwgQ0xPTkVfVk0gfA0KICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgQ0xPTkVfVU5UUkFDRUQpICYgfkNTSUdOQUwpLA0KICAgICAgICAgICAgICAg
IC5leGl0X3NpZ25hbCAgICA9IChsb3dlcl8zMl9iaXRzKGZsYWdzKSAmIENTSUdOQUwpLA0KICAg
ICAgICAgICAgICAgIC5zdGFjayAgICAgICAgICA9ICh1bnNpZ25lZCBsb25nKWZuLA0KLSAgICAg
ICAgICAgICAgIC5zdGFja19zaXplICAgICA9ICh1bnNpZ25lZCBsb25nKWFyZywNCisgICAgICAg
ICAgICAgICAuZGF0YSAgICAgICAgICAgPSBkYXRhLA0KICAgICAgICB9Ow0KIA0KICAgICAgICBy
ZXR1cm4ga2VybmVsX2Nsb25lKCZhcmdzKTsNCg0KDQo=
