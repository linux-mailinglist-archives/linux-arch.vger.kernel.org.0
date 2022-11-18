Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DF662FB8B
	for <lists+linux-arch@lfdr.de>; Fri, 18 Nov 2022 18:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbiKRRZh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Nov 2022 12:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbiKRRZf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Nov 2022 12:25:35 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253819151C;
        Fri, 18 Nov 2022 09:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668792334; x=1700328334;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=gSTsco0nM8QJ1OzbLmdzWcUatyrz+kO0iSYOITknKlE=;
  b=NywwwLZhDvItcYEBmWQK+lHbslep8nqIgAlks72oZykFuC7t0eesWCuT
   iPB8pAfDHj7ZxMT8KLiXzo+SxGmF10jF+P6CT+t8RR+2ygMSv1I7aXXxS
   xd1qG59BdB7/NNv8XR2Hwl/3ScfAvImMAiVg3nkTGrc/1rgsWUPUCwL0N
   RXQ2THwSBdXAESNl7zF4jQySvtb/oUCMk7DeKlFeRwf56uqLQZdQU+vaX
   vfjgCp6iys9uwrJ0C8uUFyxx2dhw5IytQhGnfdXV9W3XC2nSzzQkc0uG1
   3NLlHccJ7zNUnsELW2q/LeZnvxuHOJBEph4d9K5DCqxujOjNmSdeikZ3W
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="296549812"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="296549812"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 09:25:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="746074376"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="746074376"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 18 Nov 2022 09:25:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 09:25:32 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 18 Nov 2022 09:25:32 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 18 Nov 2022 09:25:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlrqjcnCAuwlzaruu1oDGyZaVDUUI7jJ1HBRDWmMX9JwvjRXaqHZ/DRTZvQKzQ8qexY2+czBuLECAP9H0J/E7Z9QLDkgDvoyHyNoMqD4kTGoOS1yEdIRINOm+F3dLG/59jsAnuxpqoHuMsfpnWiRkxugl2vNt4C067zGServcoZm0gCLTuv7LKAoerbCtJM1imjjT98F6Z/EPUaBxkkA1kvtd0gr19S23Sq2tff+H5yFuT1+zSoa6Lf2r/KDcBw+tlkk+xuWQrXXL5AkLybZxBEEBG/G7/kHHLRbpQqTyO+UFXbbc5rvvTxPJBB1Ug9WqF0JRrsrCIMrXGvFqpV6/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPpMdEjr2m0ZArTwK9/f09JX5mg436WBKog3EnADrJg=;
 b=dIPm1rBRwB50FbSgEYUpA1vq6JF0na0IzbbxNuGZRZhGEsKU35lORZ2TelqQIqRFmXGV/p/AfN8vB89GlYXpuFlLM6PGWNLOptgWJd1topSfrcIGig52T0mL25Yv6XIEC801mVPdHZh/WxSm48BP1+jFlfTKmX0PHHGdHaYO1BSgER4tGjYQQ+ukZAPOyFWLF6ZFfCmjZ75ODvoDoNcoiKLByFM2INNisJL6czkBMsShdMkyFiCk+Ekao3vzQ8UbbkXB572vN5cijEAFt3dxQ/abn7OXiYuC4Q0vGh/9oadE6XptW2oL5ez3LZdfvGaluonxqBFpw+FPnq8J15ttVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY4PR11MB2005.namprd11.prod.outlook.com (2603:10b6:903:2e::18)
 by PH7PR11MB7478.namprd11.prod.outlook.com (2603:10b6:510:269::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Fri, 18 Nov
 2022 17:25:24 +0000
Received: from CY4PR11MB2005.namprd11.prod.outlook.com
 ([fe80::ad04:c349:b06a:c1b4]) by CY4PR11MB2005.namprd11.prod.outlook.com
 ([fe80::ad04:c349:b06a:c1b4%9]) with mapi id 15.20.5813.020; Fri, 18 Nov 2022
 17:25:24 +0000
From:   "Schimpe, Christina" <christina.schimpe@intel.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
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
Subject: RE: [PATCH v3 35/37] x86/cet: Add PTRACE interface for CET
Thread-Topic: [PATCH v3 35/37] x86/cet: Add PTRACE interface for CET
Thread-Index: AQHY8J5eaXgH6xugZk20MwPZdy8SOK5AIA2AgACAkACAAnwdkIAAH/sAgAHGHQCAAAClIA==
Date:   Fri, 18 Nov 2022 17:25:23 +0000
Message-ID: <CY4PR11MB2005DA1DF43749F2DAF562A5F9099@CY4PR11MB2005.namprd11.prod.outlook.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
         <20221104223604.29615-36-rick.p.edgecombe@intel.com>
         <Y3Olme4Nl+VOkjAH@hirez.programming.kicks-ass.net>
         <223bf306716f5eb68e4f9fd660414c84cddd9886.camel@intel.com>
         <CY4PR11MB2005AD47BA1D97BC1A96A769F9069@CY4PR11MB2005.namprd11.prod.outlook.com>
         <Y3ZB4iJew2Fkh4R3@hirez.programming.kicks-ass.net>
 <88f33231041de56c70a4c06c603962a2f8d7ca4e.camel@intel.com>
In-Reply-To: <88f33231041de56c70a4c06c603962a2f8d7ca4e.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR11MB2005:EE_|PH7PR11MB7478:EE_
x-ms-office365-filtering-correlation-id: 2b78ceb1-07fb-4c78-e958-08dac989e079
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: go637UMFf1Um3LquVUXuXiJdZGiMFOjIBp+6ND/jxdMuirhGsR5BiZhaeWfTZdWH6dfIJWbB+vDl0UTfGxczgwt+fQFXLZQW38YynxcT2rk0fWwCxPI5r/e84XvJG96sG+Fq/4BLGOr2zBCg46xhfGno/Ab3ZB/A+6ILJtuXXf9z0R84DsqJ3ctL4BwPiTXISWSgIs0ZL+rQV+FOeJNQq9aMuEsf4RBCFcnMklMC2ioPjeyxbpypNB8Beed5hd+aKWsLl/Kto3Mhai8mO8DDZyPa8exSFrM7vNCdeM2Y4X0B9Hzj5qOiCcvqBRDMCFKwZBV3RE7zQLux5eK+N4zQHYwD758j2HyrzjnEY+h6I6EwOT7eNLeO+4AMnD24yI2iiMy/w+34O3nRwL2zkDArqZr2fS4LmZYZZoHI7xe8IB0v/Mcuve9bZShHHKEROc8/ldXDXTL7Muc0tXqb2z/RK+MlFeNSfRmcUQTRf5fkLVhVcW3ACBpRLQMpgCNCMr3iVBi0kddBnDIM1mQXlZs6kkuGUPypOXkSgBFaGRf717354zmFdxAOgTmRAzgH25C4l7bCMKOZJDUq7O5rlG1smnSTRQk3UPTRBJ9atnQ9wVJNZNzr6kuxSq/oEpCb0AzAEsuG0131yx78nRL0+uRs8IOeTH/PaNH+HLA3pj6uetHTPORpgq3mBI4/kPC5HyUKpTa+uFXUY2AbdV52mtbIStid5RO/8HnlDZvmdEJc+Fg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB2005.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199015)(38100700002)(122000001)(55016003)(33656002)(38070700005)(82960400001)(86362001)(9686003)(66946007)(71200400001)(76116006)(26005)(110136005)(6506007)(7696005)(54906003)(316002)(478600001)(7406005)(7416002)(186003)(5660300002)(4744005)(2906002)(4001150100001)(83380400001)(966005)(66476007)(4326008)(41300700001)(66556008)(8676002)(66446008)(64756008)(52536014)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXVJYnlUa2hjWG5mTVhNOTRJODkwYmJIS1JTNUw3cGJjTXJacGVsT3dlNGE0?=
 =?utf-8?B?Y1JUUFhGdERuWlZPa0MzekhCNUtvd3ovQXRDcDR6ZGY3aFlEMUQySzRJeGt1?=
 =?utf-8?B?NFBmbkc0ZnJJelRTc3JOUnF1RGRJNFQzeWl6anY5NUM1Vi82TG1hRm1NaENr?=
 =?utf-8?B?cktHUEE1UTRKMGl2dzVYMlBzeFZ5dDdiTmp0bERQb0hILzIxbjZ3c0Z0TjVU?=
 =?utf-8?B?cW5lSVYxSHJseXRjKzZhb21uMUMxNFRERGxKYzRtTmpZMG1oMjN6WnZxd05k?=
 =?utf-8?B?bmdjbmN6bFgrZ09PZ0czdzZpaTBWVjVVWnoram40V1VGU2J3VjlQZGlQUnRi?=
 =?utf-8?B?SGZEQlV6dkpQUWtZOEdOam5MdDVYME5rYU1VOEFNdWxLTy9YRFlvbmQ1UDd1?=
 =?utf-8?B?dlkyMnZLOGsvaCtQZW1lMWkwaEVoV1M0WXlrcUNNZVMxZnF5azluZ2RrcWor?=
 =?utf-8?B?NlBHbEIrTloxNmkvRnVQSTFubEx6WG9CMEtuYzkrSjFjQjd0WE41TnYydWNY?=
 =?utf-8?B?SVduUVVVdEllZ0lBOHVjR29sd2lkalE2d2o1VTBQZ1F3cHlDREl4ZGx3YzlU?=
 =?utf-8?B?bWpsenF3Y2JvbWNLNTJ4NEsxN3ZSL2lUZEdKdTU0NDcvR3U5MTZybk01UmV6?=
 =?utf-8?B?ZkthWlE2UjcvVjZCYU9kaGNld20yMndXTTRsWjNaT04yLzhpQVVrK3VTQnBZ?=
 =?utf-8?B?RzlMU1lJQWcyeVN4TWtoQ1l4a0d3bldNbWxEUjhUNUE3MktveWEySDl0SkZs?=
 =?utf-8?B?dWkrMDFpTWl1V2U3UmNCWlVRK3ZBRmkwV3l1VFU0eFFEMUg1QmVmK0o1Tncy?=
 =?utf-8?B?NEFpejluRnhDM1BCYlBwdW5ZQVdZK1lYUGQzM0FoTko1RUwzcGx1Q21kamdX?=
 =?utf-8?B?Tjcza25vOE5EUzdvZGczTDlDRWRGYUplVWpBQzNBZ1FTR084WWxSM3dYOFdR?=
 =?utf-8?B?dStmV0lvNWlqUWtYMm1ObkRjNmE0OGdSaE9iQ0J3Vit0RGxWWEEvVHRVaW03?=
 =?utf-8?B?K2RxRWNpNGhUM21MZllmR2UvRlpsM2QxMGpiUXFraGpOaGQzOHhLbU04WXZl?=
 =?utf-8?B?QTQ3eXEyMFRoL3ZKaHQ5RVBkb3NVVWdKcy9IaGdSSG90L0RSY0ZxN0VoSjZ3?=
 =?utf-8?B?T0I1MlNibWQ0QXFOUHVrMFFzSHQ3ZGJURVoxVm1XUlZaUXd6dWtLUUFkY0hQ?=
 =?utf-8?B?MmFiYUhZd1JUYjZDa3JML2d4cXl5NDRaMGpUaWlkdVQ0R2phaEpvcFVHOUty?=
 =?utf-8?B?aHZ1Y1FIUUNjVnQ5NERXVjExeGRpS2lnK3E3M3YrV2JYSjZTM0dPa1lmVHZ1?=
 =?utf-8?B?bmxYMWoxNlA3dWhHd05QZnozSTllN3QvYTY5aGY5YkJ0M3NCN2dSWGdVUW5h?=
 =?utf-8?B?M2xoZkRVU3RkbC81b3Jud0s4YWcraURsUWxmNHRzejhmYnp0YklVMDZtZUxU?=
 =?utf-8?B?N1BNbmFhdXFVWjlDUk83bTdNazJXM3ArU1lUSzI3dlZPR3ZNVnJBSnBuYjNa?=
 =?utf-8?B?bW1uQStuSVVJOGEzRmNDT0c3TVc4NWpjMmQvY0ZuSThYbitnTVlzWVNpeVZP?=
 =?utf-8?B?T3VSNnYvakc4eVN0NWpKK2NMVGNCWmUwYlE2Sk1PNkEwSlV5SExGTzYzT2pI?=
 =?utf-8?B?V2tkV0RQcm5VdWEzYytCUTh0ZHlaOFAwbDZweVlXcGJKMUVwc3Nvb1hKbjgx?=
 =?utf-8?B?N1d2bnJXRG9Sc21FdmJPdXJYZlpzeE4wclRTRDRMSktrcHdlczZyVVJRWUQ4?=
 =?utf-8?B?Y0NHSG9Nd0JHRWI1WDEwNEYxRkl1Tk9rc0h2Nnloa2ROL0RVMUQycmNFUHhF?=
 =?utf-8?B?S1VGL1RyWVpTcDN6ZEZ3Tk9PWnc4WjdNemt0RHpIeVBRdngzVFZZTzJLakE1?=
 =?utf-8?B?L1M4N1NoL2tvakQzUEhrWnNwOUNRNXQzTHBxQTM5WTQ0UENsQUNXQWk2MzlR?=
 =?utf-8?B?UHc4MURnUzliVlptTjRFbVNvNzUyMjJuOHh0eVk0TXZFQnN1VEE3WHNjaTNw?=
 =?utf-8?B?UXNvTXhXeUNFb1dLV00ybDJ6OUt2clJ1U0JtZkY5WTNzN0ljZCszNVExaWpx?=
 =?utf-8?B?N0NhcFFqSmxFeUJBSDEyUXNiTVBGbjlzNE9zeTZPdld5S0tudDJ2MXAvekQr?=
 =?utf-8?B?Zm90ZHB3Y3BoWTd0WXJCY2lzcEFOVFByTzBGeTZEYnp4U040VS9MdVFiWFJv?=
 =?utf-8?B?MFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB2005.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b78ceb1-07fb-4c78-e958-08dac989e079
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 17:25:23.9510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SgYRrznGJvj0mi5ueOKoX7b9Lmsa47NhpYcTAFPyFyZ4EFoHJSWuGsOovkAlTj0iF6Z/sAuTncDlH9IMKgQqZIsmDbRWLrQb0f2m5ISDOu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7478
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PiBPbiBUaHUsIDIwMjItMTEtMTcgYXQgMTU6MTQgKzAxMDAsIFBldGVyIFppamxzdHJhIHdyb3Rl
Og0KPiA+IEFsc28sIHd0aCBpcyBhbiBpbmZlcmlvciBjYWxsPw0KPiANCj4gSSB0aGluayBpdCdz
IHRoZSBHREIgZnVuY3Rpb25hbGl0eSB0byBtYWtlIGEgY2FsbCBpbiB0aGUgcHJvY2VzcyBiZWlu
ZyBkZWJ1Z2dlZC4NCj4gU28gaWYgeW91IHdhbnQgdG8gY2FsbCBzb21ldGhpbmcgd2l0aG91dCBh
biBlbmRicmFuY2ggSSBndWVzcy4NCg0KRm9yIGluZmVyaW9yIGNhbGxzLCBHREIgYnVpbGRzIGEg
ZHVtbXktZnJhbWUgdG8gZXZhbHVhdGUgYW4gZXhwcmVzc2lvbjoNCmh0dHBzOi8vc291cmNld2Fy
ZS5vcmcvZ2RiL29ubGluZWRvY3MvZ2RiL0NhbGxpbmcuaHRtbA0KDQpCZXN0IFJlZ2FyZHMsDQpD
aHJpc3RpbmENCg0KSW50ZWwgRGV1dHNjaGxhbmQgR21iSApSZWdpc3RlcmVkIEFkZHJlc3M6IEFt
IENhbXBlb24gMTAsIDg1NTc5IE5ldWJpYmVyZywgR2VybWFueQpUZWw6ICs0OSA4OSA5OSA4ODUz
LTAsIHd3dy5pbnRlbC5kZSA8aHR0cDovL3d3dy5pbnRlbC5kZT4KTWFuYWdpbmcgRGlyZWN0b3Jz
OiBDaHJpc3RpbiBFaXNlbnNjaG1pZCwgU2hhcm9uIEhlY2ssIFRpZmZhbnkgRG9vbiBTaWx2YSAg
CkNoYWlycGVyc29uIG9mIHRoZSBTdXBlcnZpc29yeSBCb2FyZDogTmljb2xlIExhdQpSZWdpc3Rl
cmVkIE9mZmljZTogTXVuaWNoCkNvbW1lcmNpYWwgUmVnaXN0ZXI6IEFtdHNnZXJpY2h0IE11ZW5j
aGVuIEhSQiAxODY5MjgK

