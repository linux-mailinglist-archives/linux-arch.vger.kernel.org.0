Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FC962E586
	for <lists+linux-arch@lfdr.de>; Thu, 17 Nov 2022 20:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbiKQT6J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Nov 2022 14:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240485AbiKQT6H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Nov 2022 14:58:07 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1B91836A;
        Thu, 17 Nov 2022 11:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668715085; x=1700251085;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cgtu0Xuc5eIsNJUHDvu9cUCLc4XhBtezN6QBQFs+Mgg=;
  b=cpZPjgL/aqcK87M5QAdY6s2CcG9j7jK3ll4TyDD4wKEXobcE3tmRV+Gk
   QVTfQBTfCTjlOJiKaTWV6/ndI0tLS+O0Ddph1N2T6pcabInQPBzEp0ide
   HQOnvkOBjHMhonp5NfwXESajmvF7AhAC/yMdByytwp+oicieZDrf7sqV9
   KMrVH9Ut7gZnt8ErqxEvZnqmwZNFbB3ZZM4JTEIaZFYBdjF2viTzffFES
   NPBlDbEZQcv/IqMW60vsVF5JyFk3GpV1vwZgAsMil2ZacCzDyY0DblVEp
   Yzxlvm+hsrO3HL/W/ui3fv3JuswzhSKS+zeGc8Fl8i+vpKu5T57TEgn+w
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="293353478"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="293353478"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 11:58:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="708762588"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="708762588"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 17 Nov 2022 11:58:05 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 11:58:04 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 17 Nov 2022 11:58:04 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 17 Nov 2022 11:58:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nN2iVUbHAofNOJu5pGCWLkwqMwlLaYTWXeL6mEzAbQyF600aKhnk9GT3r7qDiYtaG60lZLIAL/PqYVXudSSQVuUJm4oUqPpXIBuBX9oKSkbecN0Cay1wofU8tMwew2YeTpjDn/fSyAjJV7q47OBqpuEC8shdOcxsA7Gn7+sHpRwxhqy9LyuOVNhF/d6IGD25VKXBIPfo1gr+vFuVNq/RPj4dhJ8IyBX3McPFENHnqYRgNpov0JfpC71S6TGXjZxS/EyxxbKqiEjdm+PUFcOzLWcSXm02/6im87Q4zvIuAkrHKjO/nZK9viPeH8Tr7SleoMwkSBs/vqbpcqEGx2fhow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgtu0Xuc5eIsNJUHDvu9cUCLc4XhBtezN6QBQFs+Mgg=;
 b=e8vCLso179OGW7MS1dmaIoYItqujWV5KV6W6sizVvYhUDjyUA0jT/C/CeqyaCf/Ap8utbKkTAPoD24k98r+NXPAA3cQ/SlgJ/ge6BZTU8VdE6neFdnwAw3KRSI6xNsrq8igSMHHFuzF0P+QqzS6iJOL/WbF8tuY2xo6JogzBGOwCaSg31ddNyVuMXjOH8OrrMkNgOB4F60Bp8fzSZWmozWWu4aCmahcGannZ+3V1/9hbFfjNpWQN2pgWpsKAv9C1Pe3DGNefXgIyzzc8N8r9GBpJc96X6ZFtgqmEm723HjQoyShIhkvXZAoLhq/nu5bIbuA6lIoZwOFO+yCThIa8uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM4PR11MB6168.namprd11.prod.outlook.com (2603:10b6:8:ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 19:58:00 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3%5]) with mapi id 15.20.5813.020; Thu, 17 Nov 2022
 19:57:59 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Schimpe, Christina" <christina.schimpe@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
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
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 35/37] x86/cet: Add PTRACE interface for CET
Thread-Topic: [PATCH v3 35/37] x86/cet: Add PTRACE interface for CET
Thread-Index: AQHY8J5eaXgH6xugZk20MwPZdy8SOK5AIA2AgACAkACAAnwdkIAAf9AA
Date:   Thu, 17 Nov 2022 19:57:59 +0000
Message-ID: <a2c2552fcdba1a0fce0d02aeb519d33cac83bfd2.camel@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
         <20221104223604.29615-36-rick.p.edgecombe@intel.com>
         <Y3Olme4Nl+VOkjAH@hirez.programming.kicks-ass.net>
         <223bf306716f5eb68e4f9fd660414c84cddd9886.camel@intel.com>
         <CY4PR11MB2005AD47BA1D97BC1A96A769F9069@CY4PR11MB2005.namprd11.prod.outlook.com>
In-Reply-To: <CY4PR11MB2005AD47BA1D97BC1A96A769F9069@CY4PR11MB2005.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|DM4PR11MB6168:EE_
x-ms-office365-filtering-correlation-id: 2fa3873f-e85a-4e95-7431-08dac8d6070d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SHeQhtG6DUqNen2KbSvUWgljM/TSUwwIDMDdfa7G6J3VBDno1wLgEP73QHYRMFZRsFiRxRTkPyOuGjtoZtHDEeKI++dIFvN7lf7gLdeR4qyufuX1toFV7s3ddhglW/UZq+nxt44ix5MBpC/oxPp3fzlpm8awUIls7y0E2d80AYQd3f5QyT7pz0Xxy6VlOn6RvEMEVKO0J/6epBGWdLS/5R0Dr1WJEFROW7eI+ZxcbckYwzbKEC03FkDvgJOKgh4Mo6GSdNbIFyM0lgIw0qh8kLS02TaLFD2Ii3B9zLX8lju+0NgaOMk/RwQbovFXtOTo8NTGhM7zvbQ32TF1GoyGaUohq6UbO//9YPPsv2A96Wz3NaW+0Vt04VdAVdB09/cCwsoro2GCH3T3z3/FfC50/6FT+CU0XhxcFg3Gj/vDhbLmcb7UJn0A+bRyD2FRRCCgk6wcg33+5xPpzWvPAAvAtvVmLkpPlUZwBC+FU1QOkIFIS+/U483kMyuNvmsILFWTad7U2mhse2OJGZPI5e6FcPLQ3FiACzyZz7mNKptRkbgjiUIqJN18B8Uh+T+W0T0U/NAf1jr6lWZw6IMETL1wesLStVCfzUuWmn7VNj+u5hkb/HvOKYYVKKioM9Uf31jCNGfIr9t2d4mxiJiMcJAq8oGTEsDRgFOBynI1Zi6aAq2mnDSzgTs3w3FEbbyKLJwglEBa8Daq6Qhr8ghDvZO4qZMqSOEqJlLpUs935WJ0bgw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(136003)(396003)(366004)(346002)(451199015)(36756003)(86362001)(122000001)(38070700005)(26005)(38100700002)(82960400001)(2906002)(4001150100001)(186003)(6512007)(2616005)(7406005)(5660300002)(7416002)(6486002)(478600001)(110136005)(6506007)(76116006)(41300700001)(71200400001)(54906003)(8936002)(66446008)(66556008)(8676002)(64756008)(66476007)(91956017)(66946007)(4326008)(316002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1UrRTd6dzErQXNiVUdxc2M5SDFlZUJhZEt2NkdYUUQ4OGtsdmIza1BhZEdW?=
 =?utf-8?B?UmlDVE5tNGFtbnY3WklJR085NVVRdXN3Qmxabm5vTFRIcm1iZndIdmZEN3dn?=
 =?utf-8?B?OFdja1BkN3B1N0IwL2xkazZjbFFpZjg1Vmt3bGFYcW5ZRXduWkhJbXJldmov?=
 =?utf-8?B?MGVQa05YaVBhRThmWThRSFc5MVdYdkxwaHhySUFLY3pMenIrdk96SzduR25L?=
 =?utf-8?B?aG9Sek1YUnRxZ3R1NTkzSGsvTCsrYUJTUDMzdG9nQ2Y0b1JIZFRieEpzNjNk?=
 =?utf-8?B?czhpZFlFUmVEaWttMk5oMWM3ZnNRdW5QTUM1eEtGSm9wREM0OTlMeDFCWHpM?=
 =?utf-8?B?OUdUZWM1WUxNajhRVXpLVTVkcEJvZHg3QzFYdjc0K0IwOUsxUWFSQWVHSEF1?=
 =?utf-8?B?SVB2bFZOcEpwY1dYY3R2UzM2dUljckQzRldBTFhmMHBGaHZpR2hoNXZneFpS?=
 =?utf-8?B?a054YVNVVnBZSFluRWs4ZllaRW5qRW5tMWM2Qkg4b2JnT0lnWW5hL1JQSWkr?=
 =?utf-8?B?dy9MQ1QrZWtwY0RVVG1LeUpkVGpXYTB3YzBQTDRjV29rNFk3ZldTbXJQdC9W?=
 =?utf-8?B?cFFXVmhFb1U2MWlqUStmanVuSkVYcGpoMWs0ZUpMeGl0c3QzcjRzSVZyMWJK?=
 =?utf-8?B?WlJmNTNNbUIwWDVGbklvMFRlNXNialYxWDNONlR4TFpOd240bmhIV1lEZUdX?=
 =?utf-8?B?NWlvSUFQamozVEdRSE96aW5GV3VqdngzWElxb2FidU1TcTJGWllqQzg3cWY1?=
 =?utf-8?B?VW12MUllT1RpRmptN2l6V2wyMFMrVDhTN1ZlRzA3ZjhYUlFZR1V5alN0ZG9B?=
 =?utf-8?B?ME5vUTV6UUNwQWh2MnVEcHZDaVl0SHI4VzNHNmJnVmFBM1l4OGxheU5DcWNz?=
 =?utf-8?B?eE1hU0VWVzJ4ZldEWUR5R3VWTkhIUFB4bXpJREZBc0VEdnhyQ1V0RFdsNmxB?=
 =?utf-8?B?WW03ZnBOZ0t5YThtVEt0MVlQbzZNbS9hVXRpUjMxTy8xblV1V1RWMWdaZVFW?=
 =?utf-8?B?Z2pKcit2bnFUOTNMbXZha0JrQWtLUjRWTm5MTjZpeWRBbDZGYitHcE1SUGtU?=
 =?utf-8?B?YVpUWHFNcDhLdEplM1BwSkhMNjd5bG5sZExjTHhnOTNBNDBTcmtDelAzakMx?=
 =?utf-8?B?UUNQdkwwMW1rUW9KNmEvQWVkWDUvVXRISStEN1lZc3NhVzhmd0lMdzRNOCts?=
 =?utf-8?B?WWJEV0FQZlF5SkxYODc4bTE4SkZRYzhGQzBvdVplQThnaGhqczVUMyswUUhi?=
 =?utf-8?B?T1lvbWJzZ2RpSjU1V2lqcU1jQnFXRlZSbFlRVXd5N2ZMd0IvTjZieFV0ejZM?=
 =?utf-8?B?QmtOMFN3UjB6a3Y3R2p4bi9DOGhMY1NBaTl5WjRGZlZXRkdlVTd5Y2w0ZENB?=
 =?utf-8?B?emd4cm1nUFpudkY1Mk4yZXJyZHRTdDFMVW1ZTjRYWEJLQTI2TkNPU1dqMHVs?=
 =?utf-8?B?ZjFldUZSazdqaUNXYUd4WE5kTUdmMXFDa3ZJZENuYnJiTGFvaUhmVDg5QVIz?=
 =?utf-8?B?UWJlbGpjaldkT3ZTOGp5WEp2YU1iRk1GY3JDbjB1dm9oOUJOZUtEUkJFVlp0?=
 =?utf-8?B?Z3VPTDNjOEFpOE1pWmJiRVQweVVHMTFUUisrREJaNTRmcytzbUxmREVTOWNO?=
 =?utf-8?B?blY4K2FEbXo3OWk4LzZhdEkxNEdCdUF6Z1JTK3hzaXY5bHNlRmpaMytUcGxG?=
 =?utf-8?B?NHJlU3JmR0J4SEloQ2tSV3NIbGpHaFQvWWl0SzRHelRMZTJ0c3h1QWRwcTdq?=
 =?utf-8?B?VmJvNkM5RkNJZWZKUHpQcWZJUWJjUmpteGxiY0RZQVJhVFI3KzliR1M0RjJQ?=
 =?utf-8?B?U29mQkcxVTMyUmZJS0NJa1pwMkxYcXdNMEcyMnp4TjE4akhuNmY3cVZPV1dD?=
 =?utf-8?B?aWRJV1BCbFFZYkMrNW1maW5HYk4rdXluZzZibSt3NUFtN3hGM3FkVlJXbXE0?=
 =?utf-8?B?TWFjb3MxTklreVhlMk1YQ1EwdGhaYlhpSUJEVEorWmVOalFXUmE2QU00aFhJ?=
 =?utf-8?B?eU5wZ29ZaFJqM09nS1NvbWVRUHZ5MVJGQXc3YjZuNUQreUJNa1RaMlZhZnRH?=
 =?utf-8?B?YUVQMmtsYnZkeHBCU3FQazRTQ0lNUHZYTGgzSEJvWHpzMnJsbnJ4cHBHeU1I?=
 =?utf-8?B?SzQ4YWErelN6Zzc3cnd3S0hJam5LSXBXNlpaUVB3ZU5KZUdUQXFCc0duOXZJ?=
 =?utf-8?Q?KRiPdQck2pBm4q02b3JJ6L8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA82A64786F2574CB43E9A6AAC01E701@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa3873f-e85a-4e95-7431-08dac8d6070d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 19:57:59.3069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: neRdQUIExekFb7Wfk9TLRWTsojAUtbC/T2UY54BXz94d7wtXNZFbu8r+Gku2Bt1bABb9ALZUOkZJbS5nrBEZp6TrGOipKwl4fe+zBGDOxdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6168
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIyLTExLTE3IGF0IDEyOjI1ICswMDAwLCBTY2hpbXBlLCBDaHJpc3RpbmEgd3Jv
dGU6DQo+ID4gSG1tLCB3ZSBkZWZpbml0ZWx5IG5lZWQgdG8gYmUgYWJsZSB0byBzZXQgdGhlIFNT
UC4gQ2hyaXN0aW5hLCBkb2VzDQo+ID4gR0RCIG5lZWQNCj4gPiBhbnl0aGluZyBlbHNlPyBJIHRo
b3VnaHQgbWF5YmUgdG9nZ2xpbmcgU0hTVEtfRU4/DQo+IA0KPiBJbiBhZGRpdGlvbiB0byB0aGUg
U1NQLCB3ZSB3YW50IHRvIHdyaXRlIHRoZSBDRVQgc3RhdGUuIEZvciBpbnN0YW5jZQ0KPiBmb3Ig
aW5mZXJpb3IgY2FsbHMsDQo+IHdlIHdhbnQgdG8gcmVzZXQgdGhlIElCVCBiaXRzLg0KPiBIb3dl
dmVyLCB3ZSB3b24ndCB3cml0ZSBzdGF0ZXMgdGhhdCBhcmUgZGlzYWxsb3dlZCBieSBIVy4NCg0K
U29ycnksIEkgc2hvdWxkIGhhdmUgZ2l2ZW4gbW9yZSBiYWNrZ3JvdW5kLiBQZXRlciBpcyBzYXlp
bmcgd2Ugc2hvdWxkDQpzcGxpdCB0aGUgcHRyYWNlIGludGVyZmFjZSBzbyB0aGF0IHNoYWRvdyBz
dGFjayBhbmQgSUJUIGFyZSBzZXBhcmF0ZS4gDQpUaGV5IHdvdWxkIGFsc28gbm8gbG9uZ2VyIG5l
Y2Vzc2FyaWx5IG1pcnJvciB0aGUgQ0VUX1UgTVNSIGZvcm1hdC4NCkluc3RlYWQgdGhlIGtlcm5l
bCB3b3VsZCBleHBvc2UgYSBrZXJuZWwgc3BlY2lmaWMgZm9ybWF0IHRoYXQgaGFzIHRoZQ0KbmVl
ZGVkIGJpdHMgb2Ygc2hhZG93IHN0YWNrIHN1cHBvcnQuIEFuZCBhIHNlcGFyYXRlIG9uZSBsYXRl
ciBmb3IgSUJULg0KDQpTbyB0aGUgcXVlc3Rpb24gaXMgd2hhdCBkb2VzIHNoYWRvdyBzdGFjayBu
ZWVkIHRvIHN1cHBvcnQgZm9yIHB0cmFjZQ0KYmVzaWRlcyBTU1A/IElzIGl0IG9ubHkgU1NQPyBU
aGUgb3RoZXIgZmVhdHVyZXMgYXJlIFNIU1RLX0VOIGFuZA0KV1JTU19FTi4gSXQgbWlnaHQgYWN0
dWFsbHkgYmUgbmljZSB0byBrZWVwIGhvdyB0aGVzZSBiaXRzIGdldCBmbGlwcGVkDQptb3JlIGNv
bnRyb2xsZWQgKHJlbW92ZSB0aGVtIGZyb20gcHRyYWNlKS4gSXQgbG9va3MgbGlrZSBDUklVIGRp
ZG4ndA0KbmVlZCB0aGVtLg0KDQoNCg==
