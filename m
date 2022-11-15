Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BCF62AF41
	for <lists+linux-arch@lfdr.de>; Wed, 16 Nov 2022 00:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiKOXOW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Nov 2022 18:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237902AbiKOXN6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Nov 2022 18:13:58 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FBC183A3;
        Tue, 15 Nov 2022 15:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668554020; x=1700090020;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5BVbZ2O2ILUajGmze4q+7KroLq5uNPHvl89SLW6qdJg=;
  b=CQY/FfC5tj+Ojtm8/qXCS8dOjJ8vEXTq5Mwi+8bD7CABOgO2qZX/Jla0
   fwjAOBsPy3bjHNdMiwFBzP2eAAEQ+A/DUXvQ+NzCpVCKXzL6sKfwJTuiS
   WBO7Vc4u92SCtOfJjyT3emCVGbqh+mMzbBVNtTN+UqEdRBo8+LV+l3BEI
   Bb1fVFpFOCxjh2oU+6lcmI0LRAamrzp2ctQheK2ydqef/c8xHPiwmo5Pj
   Jbcqutn05QuNPNEnIHkI6NVrLwx26N6p60KPKjARx64erLV2KKh+xd9ho
   tsxR1N/dsGHe+BUsjaztg/Aj0P4ZB+efzVq3FXGfzIMSzOzMKLFOk6Iee
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="292783725"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="292783725"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 15:13:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="744793527"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="744793527"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 15 Nov 2022 15:13:39 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 15:13:39 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 15:13:39 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 15:13:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3TU17h+k+lPXN7NvwZb2zfeeab3lpW5pckO3Jgme1ONrUva1mD0wPYsDIMXfJSi6MzVE/SX+jzsRbqeHJYytYv28aH5NKVZmjr7Zv/KQEj2DY6gXGE0hICN1s+AN1PuVyPlB4r7M2zhwXY/uGuoKxxR6teQNBQf9jN57MoO7gkOe1taUFgaK5fJooexYu3goHhJQa1yvzzMzm+Kd8FkJAc6j0ZgHFkjfCIh/QGcfBO1tkrRLsnrVyxX5FnMTcyf2rNkjLYRPIAI20alC+KCP0WreQp/hebYavf5biIejjwemrUrlIhF3WJZPdWzhBz/+HMKlvhIliomQX7aTn2cnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BVbZ2O2ILUajGmze4q+7KroLq5uNPHvl89SLW6qdJg=;
 b=KoqvclCF1Ht0Lbyn9s3LKTD70BO5G4v4FHS6PBSlRnSph7aK31asGnOa1wixv7lCdB3PVh9gCXLF4g1JYMO3kQmC2eqlH2fhj9K6x5dQHMLeGH3IpqVGDP6jblE8zFCeLpE0ZpAao1UeEiJRt0wpflTHIdcRoRR5M2M3WV+f5b34yhaT6vgW1sBpZq1GnnNgfGNi7+JxRAhouUL27PBW6a55J0Vj9z6CZYiy6KAQhFSS8vgwGbcTTTOwndZ/rZYMtClERvgnfKSR9kceHVn5/WysBdUI1OJK1QzcGluJ2UB+z6zHMtdsNLI3R04G6Uvm4ZeEhCd7ren4uKu2C9erng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH0PR11MB5159.namprd11.prod.outlook.com (2603:10b6:510:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 23:13:34 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3%5]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 23:13:34 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
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
Subject: Re: [PATCH v3 15/37] x86/mm: Check Shadow Stack page fault errors
Thread-Topic: [PATCH v3 15/37] x86/mm: Check Shadow Stack page fault errors
Thread-Index: AQHY8J5a/ZcFBTphoU2iG+E5IUjl1q4/7s4AgACKgYCAABIcAIAAIxuA
Date:   Tue, 15 Nov 2022 23:13:34 +0000
Message-ID: <2766aedef0780f03b81ea7dfea42dffb328e21f1.camel@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
         <20221104223604.29615-16-rick.p.edgecombe@intel.com>
         <Y3N8Sn65TzyD6jwL@hirez.programming.kicks-ass.net>
         <b89565c96a0330c27ae179d96be05d2fc006121c.camel@intel.com>
         <Y3P/qltUOcCYsXoD@hirez.programming.kicks-ass.net>
In-Reply-To: <Y3P/qltUOcCYsXoD@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH0PR11MB5159:EE_
x-ms-office365-filtering-correlation-id: 915002d3-f957-4c6c-9bfd-08dac75f04e8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0KrqZLHCQliyPachuc+GfhFLxCvjpoQHV86B6xs9lr9Xued2pPI3OLtszr3yHLZp2Zgw7aPi1mJ9BdfY6iDfMgqeC/5BND8R/sDjc80wqNRBvagQeMjGTkJF0RdBWbHWsGcxeCmcwiSGB0KcRVY3rZo06+0wxsiGAdOBjIesVycjLYq604aJQle2fvE0RzE17l4iCKH5AMAEgh1OKyJkkjxFgl4IZHNk4+fHitiVwmbrsfcjrPyzGwB3UcRPq/ZBGyMoVa0YZqXL+UPcoBRvBekPLIcinIUvAFXD8zsAZTUdsmSDKmYN7O7OqAChPN3aea+ibYHl0tvwPxLc+LpyIxpdjASDeJdP2iH78ZAg8LFU4wZK+qpQFOtFEUADByPcNI3rrvdA2Xp0bbT8qzRoYx9Bg6i7mjzzWGXs3pRPWig0xBIozva0sI+eZ7bbQZohiqWUYWV9zWCXQ6v8TsM5q6FU0TBMPMU2RrrUDoxf2mOmI7BjGOJ57AWETB5SacR787sPbYoH1laVQ083sBLdI6GRS7RL0zWBqxcbGD1CfhIB78ti6BjZZYDYB3zd8tjWHlhdgkxKmBsuaAcrdFGiG43w0+zrOzyc/hU3JfxYpqZUh5quYSnlAb0YF4esxv+YaUfMUf+vfvrRmSM8e971e/b6BV4Kuqd0YAaOu15/is/YDb77RmFschXNQvrbb3CA5AMxAnOO9UBwIoIoNUovQrJfyF5BNHB4cpwP0puLmwr3GGXbK/TBzbxharPb77ZSdbyhl2I+A4Qzwg9VkBJqXByd7BOOoih4TgJWn0uP154=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199015)(2616005)(186003)(6506007)(6512007)(122000001)(26005)(54906003)(82960400001)(38100700002)(83380400001)(5660300002)(7416002)(7406005)(4001150100001)(2906002)(66556008)(6916009)(66476007)(71200400001)(6486002)(478600001)(41300700001)(4326008)(8936002)(64756008)(316002)(8676002)(91956017)(76116006)(66446008)(66946007)(38070700005)(86362001)(36756003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVZvb2lkRGdiTXgvcVl1bFFUSVpvekVzaThZN21pbVBiSHRrbWd4c3hybFZW?=
 =?utf-8?B?dzRlanV0U09zUEhKY3VhaVRacVFVU2YwVWxxOUpxM2lwK21iZk1OZU9BTDdC?=
 =?utf-8?B?MEdxK2hKYjU0SGxVSmhvWVQwdkdSVTFOVXZPaGtsaEdnMTcyczdBcndNd0tM?=
 =?utf-8?B?Zzd6cmc5REE1aXVKc05lMW85U1ViRm94Qjh3enEvMjZkdzE3RHVHQ044L2FB?=
 =?utf-8?B?K1dUakpGcUF1U0l6bVJKZkhvWFV0VnIvR0hTSnRuOE9WMVlrVW50L24wenBZ?=
 =?utf-8?B?cUZlSHNuSkdRVDJFb29QWjdCOCtEeFQwMVBSZTQ2NldIVTNXY1NieTVqanFK?=
 =?utf-8?B?eTlIODZUNlhMVldPTjZuTU4xQ3R6N3dweERvVG5rdnNYUHhlUEtyOEVlTkpu?=
 =?utf-8?B?djI3cy9OcWNvZHViVGxOZUJEUVllRHI5d01OYzJQc3AvSGh3WjR0WU51a21P?=
 =?utf-8?B?bWxKS2xKTmUrTk5JNHRNMk1vNFY0S2M3eHBJVnFJNDNKUjdqY3JzNlFuRW4v?=
 =?utf-8?B?OUM5U1B2SG94OFdMc0RMZ3VzT0VJRHVmS2xPR0d3SzcvN0JoVkMwTEk5S05l?=
 =?utf-8?B?RlBDNTI5VFhEcDJRTTIvQUNmdm0rOE1mZExCYUc4RHI4NktIN1RkalNoY3M2?=
 =?utf-8?B?MmVtUXlOU3l2MWVIOUVOcUp2dGdGZ3lJWXdCT05SZTczcEhjNHpPVWh4Sy9G?=
 =?utf-8?B?NHpmazVSa0lEMllSREQ0R3hMVWI3Q1ArNFQrbGN2cmJzQ0NYcGpYY2pxYzB1?=
 =?utf-8?B?OVhUSFAzSjY4UmloMlJkOTRQUGRCeWVmYXlMcU5GZ3luSjFXSUIyRlVpYVZh?=
 =?utf-8?B?YTMzUDIvSFdCTCtXekdlandkMCtIZVlxQU5zbTJxNWlVeHl6K29hbGVoUHpu?=
 =?utf-8?B?VFBBRGJRdkFwaUt4WDN1ajVYMXJiRzZiUnd2ajh0U3ErZWhBbXMyZDFITkdO?=
 =?utf-8?B?SnNvY1pxK21ndHRkY3ozbm1OOWR3Smk3RkJNOWo4em16cmdzSVRUc3MzMEFm?=
 =?utf-8?B?OFd3UFFmOWVMR3ovMGxycktDdGJVRkxRRE9nVS9yMXkxdjJhVWdPNkpYTDA1?=
 =?utf-8?B?UzBqbDVINW5nR21YamlWUk80cXhoL0JIMURpWjh1M2k4dkZWV0JLeFJEZm5V?=
 =?utf-8?B?dHorT0xNTVFRdnFQM2F3VXZRMk9TZTRqYnJnL3l5T1lDa2VsYWxRZ05oQko2?=
 =?utf-8?B?TUN1NEl5Q1NPVHhVL0hpTmZ0TTNMT29qenA3S25TdDdZUEY3NDBkdzMvdm5U?=
 =?utf-8?B?ZVlNWHNva3A2dHVyUlpkS0VwNm9jZjZadmEzcEhOVXdNWC96RlpZRDNqbmFi?=
 =?utf-8?B?VE05blhLMHRQUGtFU2kvajlFMi9XZnJwQ0F1cGxVT3Z2UHNMSTRWZU5tbmor?=
 =?utf-8?B?NUhVN0UzaG1BbEdtMDdXN25JQkdTcUg1c0VjK2VCT0VrVWpZcmpndmJvODNx?=
 =?utf-8?B?QTlCY1V0MnZ5YmphNmlndXhJMGk2a2kwdlJqMU9kemt6OFRtZW95dFVObUFn?=
 =?utf-8?B?THBPS0UvOUZsdGRxV2tWaWpuSXBYQU9FME54VHFkK1UzUXNHazFjdWVqeDcw?=
 =?utf-8?B?RDJEM2M0ekFOVGgvWCtPRW9VclRtOFhGR29qbnlIWmxaUk1xUWhOUWMrVzFW?=
 =?utf-8?B?ZUFCVlBOUWE3L2lza2ZaeDVmRHRrLzBhcTNRSDZkUjltcjI0dFZxMFNWSWNJ?=
 =?utf-8?B?cEgrWVh0dThuUzh0L3ZGYjZYQ2lKMmlUTEdCRFFlT1BCMDZRbndmb20ydG9P?=
 =?utf-8?B?ZWxjZnBBbWd1ZnIrcnBSWFF1elJldWVJNTJ5VXE4OHZuU1MxV2FUdVBwVnlG?=
 =?utf-8?B?TXJLSVZnVTZOeXJJSlU3MmJsc3BWUjh6Q0puSmg2M1lXbHhpRnVMaTlTZUhV?=
 =?utf-8?B?VUlyYVNPRmZST1JwQytETlRBSTBQWXFGS0haeGRrZWY1ZVd2QmdJd1JHTnhh?=
 =?utf-8?B?eHFxSmYwb00zczhkZWF3ZDlrclZBS1FsQTI2NWxiMXh5d0FjWnhnazRHdXAw?=
 =?utf-8?B?QUlrelduZ01rSkdSdGt5VXd6S01jeHR2U0FaOTNxOWY3N2pOK3U1MWhqZk5h?=
 =?utf-8?B?YmUvQjBPTFdZUFhxTzh1cUUzdXMyVjFCVGdTMWg3OFdTaUNNY2k1NXJNc3dU?=
 =?utf-8?B?VmZvcDVpRmhLL0FsWGxPelJHNEp1cGVEMWoyc0hXOC9wdi9tYjc5RnhUK0JJ?=
 =?utf-8?Q?QMIwBUvzZ0aXq2yv8VaG3f8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31098549C6C1C44487674B0433D165A8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 915002d3-f957-4c6c-9bfd-08dac75f04e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 23:13:34.4207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aL4RIExoh+PMik2YgHHqSbDbxXnAj3AMjBtMeXIG3gcjQ0bQih1skszx20Lh9oV6Vq2cRhbk3AxldjYT0+SlPqPQzgts5wkRaq7xBaSOva8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5159
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTE1IGF0IDIyOjA3ICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gVHVlLCBOb3YgMTUsIDIwMjIgYXQgMDg6MDM6MDZQTSArMDAwMCwgRWRnZWNvbWJlLCBS
aWNrIFAgd3JvdGU6DQo+IA0KPiA+IFRoYXQncyByaWdodC4gSSB0aGluayB0aGUgYXNzdW1wdGlv
biB0aGF0IG5lZWRzIHRvIGJlIGJyb2tlbiBpbiB0aGUNCj4gPiByZWFkZXJzIGhlYWQgaXMgdGhh
dCB5b3UgY2FuIHNhdGlzZnkgYSByZWFkIGZhdWx0IHdpdGggcmVhZC1vbmx5DQo+ID4gUFRFLg0K
PiA+IFRoaXMgaXMga2luZCBvZiBiYWtlZCBpbiBhbGwgb3ZlciB0aGUgcGxhY2Ugd2l0aCB0aGUg
emVyby1wZm4sIENPVywNCj4gPiBldGMuIE1heWJlIEkgc2hvdWxkIHRyeSB0byBzdGFydCB3aXRo
IHRoYXQuDQo+IA0KPiBNYXliZSBzb21ldGhpbmcgbGlrZToNCj4gDQo+IENvVyAtLSBwdGVfd3Jw
cm90ZWN0KCkgLS0gY2hhbmdlcyBhIFNTIHBhZ2UgJ1dyaXRlPTAsRGlydHk9MScgdG8NCj4gJ1dy
aXRlPTAsRGlydHk9MCxDb1c9MScgd2hpY2ggaXMgYSAncmVndWxhcicgUk8gcGFnZS4gQSBTUyBy
ZWFkIGZyb20NCj4gUkVUDQo+IHdpbGwgI1BGIGJlY2F1c2UgaXQgZXhwZWN0cyBhIFNTIHBhZ2Uu
IE1ha2Ugc3VyZSB0byBicmVhayB0aGUgQ29XIHNvDQo+IGl0DQo+IGNhbiBiZSByZXN0b3JlZCB0
byBhbiBTUyBwYWdlLCBhcyBzdWNoIGZvcmNlIHRoZSB3cml0ZSBwYXRoIGFuZA0KPiB0aWNrbGUN
Cj4gcHRlX21rd3JpdGUoKS4NCg0KSG1tLCBUQkggSSdtIG5vdCBzdXJlIGl0J3MgbW9yZSBjbGVh
ci4gSSB0cmllZCB0byB0YWtlIHRoaXMgYW5kIGZpbGwgaXQNCm91dCBtb3JlLiBEb2VzIGl0IHNv
dW5kIGJldHRlcj8NCg0KDQpXaGVuIGEgcGFnZSBiZWNvbWVzIENPVyBpdCBjaGFuZ2VzIGZyb20g
YSBzaGFkb3cgc3RhY2sgcGVybWlzc2lvbmVkDQpwYWdlIChXcml0ZT0wLERpcnR5PTEpIHRvIChX
cml0ZT0wLERpcnR5PTAsQ29XPTEpLCB3aGljaCBpcyBzaW1wbHkNCnJlYWQtb25seSB0byB0aGUg
Q1BVLiBXaGVuIHNoYWRvdyBzdGFjayBpcyBlbmFibGVkLCBhIFJFVCB3b3VsZA0Kbm9ybWFsbHkg
cG9wIHRoZSBzaGFkb3cgc3RhY2sgYnkgcmVhZGluZyBpdCB3aXRoIGEgInNoYWRvdyBzdGFjayBy
ZWFkIg0KYWNjZXNzLiBIb3dldmVyLCBpbiB0aGUgQ09XIGNhc2UgdGhlIHNoYWRvdyBzdGFjayBt
ZW1vcnkgZG9lcyBub3QgaGF2ZQ0Kc2hhZG93IHN0YWNrIHBlcm1pc3Npb25zLCBpdCBpcyByZWFk
LW9ubHkuIFNvIGl0IHdpbGwgZ2VuZXJhdGUgYSBmYXVsdC4NCg0KRm9yIGNvbnZlbnRpb25hbGx5
IHdyaXRhYmxlIHBhZ2VzLCBhIHJlYWQgY2FuIGJlIHNlcnZpY2VkIHdpdGggYSByZWFkDQpvbmx5
IFBURSwgYW5kIENPVyB3b3VsZCBub3QgaGF2ZSB0byBoYXBwZW4uIEJ1dCBmb3Igc2hhZG93IHN0
YWNrLCB0aGVyZQ0KaXNuJ3QgdGhlIGNvbmNlcHQgb2YgcmVhZC1vbmx5IHNoYWRvdyBzdGFjayBt
ZW1vcnkuIElmIGl0IGlzIHNoYWRvdw0Kc3RhY2sgcGVybWlzc2lvbmVkLCBpdCBjYW4gYmUgbW9k
aWZpZWQgdmlhIENBTEwgYW5kIFJFVCBpbnN0cnVjdGlvbnMuDQpTbyBDT1cgbmVlZHMgdG8gaGFw
cGVuIGJlZm9yZSBhbnkgbWVtb3J5IGNhbiBiZSBtYXBwZWQgd2l0aCBzaGFkb3cNCnN0YWNrIHBl
cm1pc3Npb25zLg0KDQpTaGFkb3cgc3RhY2sgYWNjZXNzZXMgKHJlYWQgb3Igd3JpdGUpIG5lZWQg
dG8gYmUgc2VydmljZWQgd2l0aCBzaGFkb3cNCnN0YWNrIHBlcm1pc3Npb25lZCBtZW1vcnksIHNv
IGluIHRoZSBjYXNlIG9mIGEgc2hhZG93IHN0YWNrIHJlYWQNCmFjY2VzcywgdHJlYXQgaXQgYXMg
YSBXUklURSBmYXVsdCBzbyBib3RoIENPVyB3aWxsIGhhcHBlbiBhbmQgdGhlIHdyaXRlDQpmYXVs
dCBwYXRoIHdpbGwgdGlja2xlIG1heWJlX21rd3JpdGUoKSBhbmQgbWFwIHRoZSBtZW1vcnkgc2hh
ZG93IHN0YWNrLg0K
