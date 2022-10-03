Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4547B5F36B8
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 21:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiJCTxM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 15:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiJCTxL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 15:53:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19F82F3B7;
        Mon,  3 Oct 2022 12:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664826790; x=1696362790;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mSuvQ9D7eT/nZy/x0GR+OZ6QTnjLRBa9DtM7l0MH/MQ=;
  b=MmVGD62d1gKunD5bjUWk11RYTcw367avxJe+AcRVgrl8MqAxLPdM4KTM
   1onCMopdhOiEYp06oEFcK5fITT5MPLXXce7m1Yke1pq0SN0+cUK7Z23FZ
   BugnuxpFygUj+KJOxGX46GiyBo/3iSAI9XoYL5/FHH91DT64YyxyoFTKP
   AZRPh1vcCvf2myBZyoJrH7+ejXEF5hPIu4Yk/2rIfA5n+a63pdJzOu4Y8
   Pthvt4RjZFnv5lJwxIaQHWe4u0IpLHp84yuvi179OAUPQLby22nNC4dJI
   3TD40w0I/2qv4/5v6CTELpRn8Bk1V4JeL1SQNtQ/Me8RhRYYJdhmIVgZ3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="283111720"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="283111720"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 12:53:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="952505158"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="952505158"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 03 Oct 2022 12:53:04 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 12:53:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 12:53:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 3 Oct 2022 12:53:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 3 Oct 2022 12:53:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liweUs9+AmDvNJDIQZ4VrIAenaR5Peg0I+IkqC1FKOc5dY1yWHHSZ9k6VD+CbpE9KSWrjg7D+7k93jtTLYM9GZalbxaSH5gOek4U3VPLYf4Wzk4AYSVURxseK6T5hStXOByeuLQNTUVLgNyz7UGfeTs0Nlu7JoUfapTKq3pNKHNpP6g+Ym+ocWO8OlOkej35KYaqi+uH+61OMfmv+/a/B7w8dZUGRRXFV2OeiRyey8s7lkjmLnLoXtNegPdryXgJwDI5ZVMhMOjqJjEsa/dt2Z5og5LwU0VRV/S2nFk8ZqG/vzKDB6ygZG7fGlkmqetfF2UfNrIT6HM/k8olIP+evw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSuvQ9D7eT/nZy/x0GR+OZ6QTnjLRBa9DtM7l0MH/MQ=;
 b=HsqjMkGyN38XKf8fkx6U9gILGfmDipf2IaOnEPSSXyQaI2aAia96EDQocpaYJQd1MJsNE73z1yYwjuKsh6gBox3R5+cKNYOdtvz7DfSRXly9b78fp3EGvA4m9lZEKwAwbOk9CW1hw0rIRoyiQQH91geu2oTzAuAnpwen1fyrUA/8JLqMlXookpCvUcj+t4T7At/GTJEc10lHAReG4VXySbS3G/bm0z4arh2zpYel7CZfX6ZJ/gC5h1PMbwGr4jWexuKCqZ0zqv2p3IlGB7agCu6f+fK2zBttM2iAevCLK1njXhQH3NupqLFGHJ9P6JC4qcAlmQy7V+aL62y2UZpLMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SN7PR11MB6604.namprd11.prod.outlook.com (2603:10b6:806:270::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 3 Oct
 2022 19:52:54 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 19:52:54 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "keescook@chromium.org" <keescook@chromium.org>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
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
Subject: Re: [PATCH v2 02/39] x86/cet/shstk: Add Kconfig option for Shadow
 Stack
Thread-Topic: [PATCH v2 02/39] x86/cet/shstk: Add Kconfig option for Shadow
 Stack
Thread-Index: AQHY1FMAO2++jn8eSkiiPpemqAqzVa388ZwAgAApMIA=
Date:   Mon, 3 Oct 2022 19:52:54 +0000
Message-ID: <0ee0e91fef2b4cf86d8bd544aac80e84454a30f4.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-3-rick.p.edgecombe@intel.com>
         <202210031020.0E93C75F9@keescook>
In-Reply-To: <202210031020.0E93C75F9@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SN7PR11MB6604:EE_
x-ms-office365-filtering-correlation-id: 0056d60b-7092-487b-edba-08daa578dce7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yh5YSKBTH7NhQ5UDmT1HDCOTTHDA1yAUvclMPs39edsJxkh7zXvHNWOxRQzSFcvw2cstSglcH5QbvvEfOW7NSdyPTVGd3ySAHzYlOzUq0+Ndf+1DmC953/UadUqPqfi3iaaJRgc5Sx+deS4SIfAwlT5cZWQd5h/8mULndXhm1YwYeOMxW7lCpioM003ESwxzDimxqIFqvPCXEQ/I19JPM7RUFMpZQgXKmOr0blMiPakTuAyfeAFv+bXoz72H80vlwudATG0mkPIc1Ctyhe0aVDeV2zuA7e61lBmtEPXX7jSqfbBoxldQYjpGZrLAYpRTG2HMZg/AGxDoRrkuCIp25JBwE6KCO0AkV3Xgzj6JeyHkb9C98vr0Y3BArAjGZx1UZt5hTM4jn/2amjDsmuZO0lyAa2KgvU5+v6Cy0nAVooAid8v1k62V3orO3FjelfLnVYTB0YTJuYo8OtvqImHnSgJUTbXZovyH0ISenh8wdvadY/sFi6GUD77wetoQj9N1UDoq8ohe2artJ9RZH4b7ByKsbjDLru1YU0g2gJzYxvj+Q2fStEFug4maiJUt/W5cvAU0F85kibg8ndCwH3JPfTLKqY+SeCuWD+SLbz3Pa1utHdmbgxEFe+55PcQ6qdOTPtzKzR9jU1DTgSI4h19x3nukjKobQ5ojn6sNmbYib/8JHHtb8e0gqiIXlstSUoTbLzUdGwe+MnhkpvY1pNSjKGoG+8+nxon9vcV42kBdkT18riF2yUxMcbqA87DFQhtX+Q7CVUbNa6lp12leSDo0HzIHQPzIM7NvuJ7CJ7GEXno=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199015)(38100700002)(122000001)(82960400001)(6512007)(7416002)(5660300002)(7406005)(6506007)(2616005)(186003)(2906002)(8936002)(36756003)(4744005)(6916009)(54906003)(316002)(91956017)(71200400001)(41300700001)(6486002)(83380400001)(26005)(86362001)(478600001)(38070700005)(66446008)(76116006)(66476007)(4326008)(66946007)(8676002)(66556008)(64756008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3hiTnZTbWl0OXhzeUpaQmVCM25VMmJUdXhFcUxNQlNWVU16WmRkTlV4RUV3?=
 =?utf-8?B?UTFrNUFuVjVjZ1ovaTVObmJlT0xyYVIxb2NFeFRFNForSzNOaUEzbkJnOExX?=
 =?utf-8?B?TlZCVGpBY2xFc1JnK3NNakNxdWVtaUtYa2ZDRGNBeG1XdDJuZUtXWDZlb0dS?=
 =?utf-8?B?Q1FaVnoxcVFlUC9XMGRoWGxlenVCUGtSUzU5OWxPbFRGSEs1TUVFWWNzMnNu?=
 =?utf-8?B?a0FjUyszYXlxdlROMmd3anhCUUVpeFVTUzVsWG9uY1c1VGZTY1hjVzFHdjIy?=
 =?utf-8?B?T3h6NS83TmpSSXNCTXVRYk1uZXhQQmEwOTFwZEMvZm5UOHc0cVA1U29UZnBm?=
 =?utf-8?B?aXd0c21oTWJDd0FLQjZHU3ZEM1J1K0oxMHZMOGNGSDQzc3hidS9zVkFIK0o1?=
 =?utf-8?B?VU1NZ0tXZHRhQk9seDBTWU9PWXFzSzdTV1RzNm04UG1mUmxrVnRiOTM4bDBw?=
 =?utf-8?B?b3d6aTdTaWp1OElpblpOeUJaTy94VTdBR0Z3S0tPdGNxZUMrR1NEc1RXVUx2?=
 =?utf-8?B?Zzl3V0Vvd0IyczgyVHBNNkxHamVXTlo5VmhRR2N3dUg5ajliem1uWENaWlhV?=
 =?utf-8?B?aHkreVU4NjViL29mYXRRamVjRVNobTRUZm9WUURJekxjMTdoVnpLZHpYZEpj?=
 =?utf-8?B?Ymp6aGE1MllkTCtJT0kyRU9ndjJLQmltY3oyZDh3dGVacFAxNVQ0TlhURGI5?=
 =?utf-8?B?bVJsMjEzNm1kRm5qRzY4QUErSTV2bEhNSU9PbUgxaitVdGhiaWFoazBsenNY?=
 =?utf-8?B?RFBzaU1ETWNHdExLYmF0ajdveXlWWFh0bVVxUUV5RWRPb0ExK2hYc1RmbjNz?=
 =?utf-8?B?MmFWM09YUk02SU9ma2lPeDhBQjFSdUlOa2tJQ1BqTGR5eDExcUxOMzc4djV1?=
 =?utf-8?B?K0FHTFQxYTgxMk90U3VwbE1FZzVwNlQvZkE3KzRtY2R3eGZiKzVsRGpvOWpX?=
 =?utf-8?B?VXhocGNhbHJScUFqRStaSU9oUERteTNDekdDY2xYcTg0YVZrVFRUQmtTK3Zi?=
 =?utf-8?B?YTdjdUwzWmZvaU4wNXhLVlZDdUpmZGJweHF6dHFXUEp0TVZTNGdvOUZ0a2Vw?=
 =?utf-8?B?dzdaYXl5YzNpWFo5eEcyWDlwTWY1dDR6eTlaUmVoQlRwUHN6L2FUZDUzdVV1?=
 =?utf-8?B?U0ZBTzg5bGszYXlMam0yUmV3bWVQUXNOR0ovZEhvVXh6VnUwc3pJcVNQTUxu?=
 =?utf-8?B?OWI5WHcvSTU1QzdjbGtXR1gxRW50RDhvMVFFdmVLakpJWDlSdUN1dVJEUVNG?=
 =?utf-8?B?WGNxQzErUC8xc1F2Q1RjT1FwTVUzb2tJSVdjMmZZUmpXb2Zsa0hQYVZwSDVq?=
 =?utf-8?B?TW5vOXhpbjByNzBtL05RMThIemZSY0lSSy9LTjc1N3lleU1CSkdhUjJPOGZz?=
 =?utf-8?B?bDlKTE44MU10dEhydUlrclJxWURUU0hLajJXTUxjQjVYcnEzeHJmT0VvZVhP?=
 =?utf-8?B?cHVzT1VPZ3F5Y1BWTkhXZ3JtR0paeHpjR3J6aThTaTAyVHVNYjcycElvOTV3?=
 =?utf-8?B?ZjRZRGNvR2M3cjJSR2RNd09WMWVub2ZDTS9iWE9wY2NoL2x3OWtjd3hrTmxM?=
 =?utf-8?B?UGRWblpMaHJyaitjRCt2aTdJcEhSckVpWDFuREJLOGM4TUVZbXZka0xJZVRm?=
 =?utf-8?B?UjBJMFYrL05TcThXaVIxejkrYXB1T1hqelNoa05ESWtoUWdMVk55NlZNQ1U4?=
 =?utf-8?B?cXpKekZvUEhsMFQyVnF6R0NUdERIT09JNk9sbFdyRzFhRkVaRExJSExYNlpj?=
 =?utf-8?B?WHZ6UE0xWXNQMWE1UGZnR2hMbHdIVVMwNC9PWUowVC9MbE5FOFZkTGN0MElw?=
 =?utf-8?B?N3lLM0dFTGdGbDBSb29aMjJUcUsrYi9ob3NaeUFkelBHQ0RmcUdYTXIzUk8v?=
 =?utf-8?B?cGJUQjJxQ21PaER5WEUvZWJMZkFNUHdHM3RBcjIxM2ljUTdydFMwa0c2SXRm?=
 =?utf-8?B?VmRWNlZmdHp6RTN4YmlhZjlWaGNTVVZ6aXFWdjl6bmNDbUt5T0RYdzExT08r?=
 =?utf-8?B?UlAyU0d5RGdGM0wrOC9TalFTaW9zUUFOT1lqNkFSd0x0alk0bjBMb0paNzdH?=
 =?utf-8?B?N2NRU1pYQmJUeGZxbm9iR2pEYWdXUHNoRENEWEx4RHVhSUN1L3R2WUlGaEZH?=
 =?utf-8?B?TW4yRXlXTmJpaVFHN0JScFB2K3JWZ0lTZHYreDhQZXZTNFFvT1pwNVA3bXQ5?=
 =?utf-8?Q?jm7xi1tCgoWxDgrtRSJFngc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA925B175FDEF74291E1E2BAC39EEE9D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0056d60b-7092-487b-edba-08daa578dce7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 19:52:54.0942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xdPcDWcRWoRK8VjorP7BXkQqD/OqmYDRCVlsrDCtdPsCHX3qMtUcayw0mwNuMRZLoChbcVGq+a1Dv7+d7lW1bk+u+t7/s+jgC+bCookpz+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6604
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTAzIGF0IDEwOjI1IC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+ID4g
K2NvbmZpZyBYODZfU0hBRE9XX1NUQUNLDQo+ID4gKyAgICAgcHJvbXB0ICJYODYgU2hhZG93IFN0
YWNrIg0KPiA+ICsgICAgIGRlZl9ib29sIG4NCj4gDQo+IEkgaG9wZSB3ZSBjYW4gc3dpdGNoIHRo
aXMgdG8gImRlZmF1bHQgeSIgc29vbiwgZ2l2ZW4gaXQncyBhIGhhcmR3YXJlDQo+IGZlYXR1cmUg
dGhhdCBpcyBkaXNhYmxlZCBhdCBydW50aW1lIHdoZW4gbm90IGF2YWlsYWJsZS4NCg0KSG1tLCB5
ZXMuIE5vdCBzdXJlIG9uIHRoaXMuIEknbSBpbmNsaW5lZCB0byBsZWF2ZSBpdCBhcyBpcyBmb3Ig
bm93Lg0KDQo+IA0KPiA+ICsgICAgIGRlcGVuZHMgb24gQVJDSF9IQVNfU0hBRE9XX1NUQUNLDQo+
IA0KPiBEb2Vzbid0IHRoaXMgZGVwZW5kIG9uIEFTX1dSVVNTIHRvbz8NCg0KWWVzLCB0aGlzIGdv
dCBtZXNzZWQgdXAgd2hlbiB0aGlzIHBhdGNoIHdlbnQgdG8gYW5kIGZyb20gdGhlIENFVCBLVk0N
CnNlcmllcy4NCg0KVGhhbmtzIQ0K
