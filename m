Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029C95FC9EA
	for <lists+linux-arch@lfdr.de>; Wed, 12 Oct 2022 19:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiJLRab (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Oct 2022 13:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJLRaa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Oct 2022 13:30:30 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BF443ADF;
        Wed, 12 Oct 2022 10:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665595828; x=1697131828;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jTE9lClbs7QXf3QcaRKj4YG9Bk8Ltie9WRmrbej6J8I=;
  b=DpBQQgD33jw94wZ9llj+W5Bix+yjTDIBLz5S8czyPvADLztpqqNwlVTY
   /tIiHKDqYfIUzdkSqiNds7hoZpmfP/ABia7uKIFDbWbeg8cIhVywwqUuo
   XJJA95bqGMmWuorRcPl4kz7Uq/bXLpwm9ln3ztUQcB+mlMZjT49JqEU1c
   qAbL71Cx/u+HlP6hzbq0rR13+1N+ECZ/FFvO4S5OaZk1K9ZS1+bELIyPi
   6uDT8aRfnrzPlFRmjsGVDlkO4VnjTmQbv+pTnDHW51nRP8rk0cBDWj4u9
   0DoH+k3/mlhkUBq+Hg/kSixHM3xwqi0IEHXUeYu9Go7sWj4YYHgW/OIJH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="391164161"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="391164161"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 10:30:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="626851495"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="626851495"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 12 Oct 2022 10:30:27 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 12 Oct 2022 10:30:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 12 Oct 2022 10:30:27 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 12 Oct 2022 10:30:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcN8nWp1RZkkovcRpZLvJAo1YE9I3F8MyPEH3PKtRtvFneqx+V7g7mggu5gmME+lfByvH9WWMOGzsjq1n26GmFkxE2n7/2mMbBodsS3XNKgdK/xYS7tczXc/qNAUvf0AizXnos1P32mBBRVwEUx+bNQBY4L/oMVMHcetw/x7Dgu6HnFoTqcUYVCj4LV3fjozjAJHbxyziR+M0Z2vBEgRSUjekVPI5nTeRI21/ywiUQ14zChwesWzVgeJo96X7gnNwktMP5sTkYuWfbhI49N7FCVN1rv1stP0xnwo+sRFXKmltjc+0XaIDNwKrIj4yrWiNhbtB+09D1aI4r+cSOde8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTE9lClbs7QXf3QcaRKj4YG9Bk8Ltie9WRmrbej6J8I=;
 b=H0hfwr/7BR0k2phSmiwEy1LOckSePloqynJGEVkb9BN+eM1JoS84gtnjq4qDZnD0cMPA0KVD4I4U96MH6UUlPbRvfDeLNU5d9mBETf22IyLmwbkbONKzWRfMrQqBzhr7MBUEDOmDRPzUJacgPUVTKU079mN3P/0FH2j04sJ7Su3rwFszXXwATua/t4JEzDiCx70xDUCIKnOmnVplk25fyoY0q/ivQ7lILIJqS1/NLn7m10FV7I8He4D7jUWpWVxDHW2tp5xmWD2XGdnuKsCcUI9pge+zakHNThwOUsdoH5aN79edNYT4zf4T5KQZU+qjCs2bFEakiAYBw5jJu/c8yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DS0PR11MB7358.namprd11.prod.outlook.com (2603:10b6:8:135::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Wed, 12 Oct
 2022 17:30:24 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 17:30:24 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "fweimer@redhat.com" <fweimer@redhat.com>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
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
        "Moreira, Joao" <joao.moreira@intel.com>,
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
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 23/39] x86: Introduce userspace API for CET enabling
Thread-Topic: [PATCH v2 23/39] x86: Introduce userspace API for CET enabling
Thread-Index: AQHY1FMhBBwtibGlfkiKNuNOGUg8sa4HhVsJgABcyICAAt7r8IAAVumA
Date:   Wed, 12 Oct 2022 17:30:24 +0000
Message-ID: <0ba8d8b5ccc39f169e8e056fb36451de720aa4eb.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-24-rick.p.edgecombe@intel.com>
         <87v8os0wx5.fsf@oldenburg.str.redhat.com>
         <8599719452d9615235f7fdd274a9b6ea04ab1f7c.camel@intel.com>
         <87zge1z13n.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87zge1z13n.fsf@oldenburg.str.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|DS0PR11MB7358:EE_
x-ms-office365-filtering-correlation-id: cec28189-0f77-49d6-3eab-08daac777224
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T9uUDZ2UoLFFUu9WNmtnY8/chy8PhF6lSkdiX+9dqzDIkNECwxFoMYso6zZ4Gs8MWmb+j5jjN07aayoUwMLsz4CVcNfozsCNuAS57WALOlApWg3OhGYvzocWvCtdeHvDLcscqnf8AGCX+xMcwPoICn5m1A7Fngaz6GFKzbaQc5z9cydYLh8xsokasg0CGUqwaU8yARPmq+7TVVGSsx10cWpNLytTA7V5VAgS9zPBwBNkDw9MpBz8tPXym5R/VRMKmPlToMOcNlt+Kx8AkpfZwy2Mo9ruR6X1XSNbLjuAh3OTKkBjG+GfrwoVB8NxKqerZECXLaH/EJfJTPLW2GS3tSYGmIgpml2rQv2sEGV/+Fs/FOI4lhs50WPKTERVSlb2/FLbL9/B0oEKzFRWyQaTpOGjF9N8r2woVUUZf4M4u60zWmp4YK+pK5zm4nnMkxULtK67N3H4D84or0kBNS+JKvJgJgHTDbYpIJQ9DcauoBlVZx2bdhN1jR9T2XJBq3W9wS2ZA6pAEOzxnBcNa1D8/1pZ3BZj35QrSdWxJycqVOuim9gND/on+Obzjivt9hJILkyEpw27u3NlE40MzC79P4Ib8hY92TVMRmuShkpWNakGPRer+B724MCfMG1IU94L2KAGhyStAbx0552t/UwZwef1lhjaNZOd3jzmpqX1PciWRBjDTDnZ1byGP4hq54Z+V9fdQIpIr7OcGkFvqDfTkTD5TgxTeFHnTTlXwJvKECtlFBlimkT4EbAubMzvX/ugXxD+1LR60eugNuho8qLVzeTTf5x9A9DN7v6okOw++rjcxDAa1AE9BlBrJFeua8z7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199015)(26005)(7416002)(41300700001)(2616005)(6506007)(8936002)(966005)(186003)(6512007)(6486002)(122000001)(36756003)(38100700002)(71200400001)(8676002)(76116006)(478600001)(316002)(6916009)(54906003)(82960400001)(5660300002)(66446008)(91956017)(4326008)(66946007)(66476007)(66556008)(64756008)(7406005)(2906002)(4001150100001)(86362001)(38070700005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3BKSWpYTTRWS1k3SVN5R0JYWmxLSFR0TEJQN1IzeEpjTG1VRmExc2VnbW03?=
 =?utf-8?B?SFdyL2w3WXRjNFdMeWRnM3g4U2Q2TWJqVFBxa2NpRGZ4NDB5QUk2RithMDNz?=
 =?utf-8?B?YVB4N0diTlRkNWl0aVozdzRlS1FGRUJSbFRFdTRTOXlRN3RidHZLS0c3RlJB?=
 =?utf-8?B?RjNkejJGNVRNZ1ZrTmRhRDlQNzAzeEZJYk9ybkxQTTRZZ05rUi9RTlI5ZXgy?=
 =?utf-8?B?QldGdFUyYTlqeFhjNkJCdWloOUhoSnJ1ZWNNWW5tdC9FV21sTUxBb1J1dVV4?=
 =?utf-8?B?ZUZ5czZoNi82RjlpVlJ1MDBEaXliRUk0UzQwZkxzSHRIREI2blgxNGk5eXda?=
 =?utf-8?B?Nk00Q0hRMlJYOC81c2cvL0ZmbmhkNVl3UHJyRXVmSmpEY3F6ZzZlRHdPMWRt?=
 =?utf-8?B?V0ZNVFg2R25SOVpJL3BvRmRQVkRFSGs1cU8wU3FldjAzWnVKWUg1VEdJL2Fr?=
 =?utf-8?B?KzFtdzNZYUNHYlFVRkROYW01SkQ0VVZjUjJLVkZkM0pTNUVuRXVDa1NBK3VC?=
 =?utf-8?B?MW9MTUJqTERNYVdlZXoyL1lXaWI2ajh6amxCZ3FBK1I1MWhSejVkbklmdVZU?=
 =?utf-8?B?V0xVaHhKTVkwQTJsQkcxeC81T29BaTljbUpBNWJ6YkV5cVZtSlpGOVpPUURV?=
 =?utf-8?B?SFBFR09HRG85NVdpS3ZEYjFyM3hkVXJGaDlnU1hJMUJjU1VCUGQzM1RjbFNF?=
 =?utf-8?B?TXkxZVA4VFNJK1RVazVJMVFmKzdYdElkZzNnSjcyREtta2hWWTBJamRQTStI?=
 =?utf-8?B?MUw2SDJ3QlE4a3AzclFpY2llYkgvNDFwREJrNytWZ2xNVE85RHcrSlg2cFoz?=
 =?utf-8?B?L2NNMW96ZDh0SzZaSjJBTWVNS3Bnb29iN2dFTXlzajhlb3drQTRmYVV5MEdO?=
 =?utf-8?B?Z3VOL1dISEFYaHNUSFRXVWtDNFRQNGtlQjFVOTU3Tk8xY3huaEowRUwyQTky?=
 =?utf-8?B?Q1I1c1U2bDZ2Q2FsdzZQUnBsRWc5NkYvcjk3V25uK043UE51a0VQaE5yUGFH?=
 =?utf-8?B?TDZHa3NVNGRkM01aeGo1SGswZXA1NVB0MmZMSEQ3RmJQdVM0cDlpRlpaanlk?=
 =?utf-8?B?M3J4NHpVSjFXYmdnVERDcCtOQmJvNDNvS3VEY2tlejRzL1RQN3dybWh6dFl6?=
 =?utf-8?B?U2Fnc2Z2eFd3aFRaTTcvc2tRWTNZK1oxVzhBeFhOZW1hRGlobm80TlBpUnN0?=
 =?utf-8?B?MU1wRmx2dENBVWwzazY5T2RHUGUrdXZrOENibTdUalVUQ2JRZ1JUQ1o3Umxw?=
 =?utf-8?B?b0hrWlU0K2crUUtGYXRXendsQTZjVDVmRlgrWUVqdXVUMHNEcVl1Qyt5U2NK?=
 =?utf-8?B?ckp5Q2g5Z0IwVG9QWndVMEtxakx3bWxmQy94TjVjWTdWSDFzYWcvOEovMW44?=
 =?utf-8?B?ekNkNVMySEgyM2FIU2xZcG5hdmZncmRHNFI1eXkwRmZseUJiQ0xnQktOdGNM?=
 =?utf-8?B?MFNpc25wcXlHWnpxaUlXUVRxOU1jOUVJUVovWW45bCtMdTAwWmhkeTNXY3pX?=
 =?utf-8?B?aFJxQkpLZytHQ3FZdkVYV2owQUV1bmpOUjhsV1h5U2FLTU14d29JUHpJdk9s?=
 =?utf-8?B?Q3N2cytaZWg0bGp3TzZaVzAxdUs3M0xISDVlQjFSTE5IQUxDcE9maWhVK2Ev?=
 =?utf-8?B?enVOWnlFVUR5emhZc2hiekY1TFZEOVBmVWl4TjI2NE1qRWEycy9SVEk5dmxm?=
 =?utf-8?B?enRYVWFHRVhRcmhSb3pxSFpydjRtR2FpT0l4TzFZMXIrak5lQXpuRFhLKzha?=
 =?utf-8?B?NzJUS2tkb1NUYnlDNFM2YXVIV1dDVThVcG5vc2pKWmZCVGF4ZnRocWEvYnRH?=
 =?utf-8?B?T2c1UUtJcVFISEJnd0orSVRWdk1XU1Z6WTVwQTFzZ0g2WFlJWlhIeXlDUWd3?=
 =?utf-8?B?bzJjemJrMzRTeVZrL1BWMzBtd3NLZEgxV1VrYjJzVE9Vb21MKzJSNGF5a1k3?=
 =?utf-8?B?djdQZ3RnbHI4ZHE0aktBVWlDVVdrdkhiV2ZZbXNVdlo3aDlaZTFCUUpFL0tP?=
 =?utf-8?B?T1d3Y2ZtbkpwN0s1TzNzVmJtS1FXeUw1ajBqY0cwakcrUmd4WitPUnBYTEpZ?=
 =?utf-8?B?a2NVYnl6bmxnT1hDYzVaNXIyb2YyQkt1aVRUdzIydE1HUU5rY1h0eDVRbnd0?=
 =?utf-8?B?RVMzOVhBSGFXb0NQL2kyem5NWVJPaEwwUGZZYmdBb2FSZGZDTVk2aWc1V3ov?=
 =?utf-8?Q?to+R5F1ix18c9uB3/IFq7a4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <517C6C4AE85BE64684FB836FB563C450@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cec28189-0f77-49d6-3eab-08daac777224
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 17:30:24.1785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TUxNMr9n4AvDByg52mOGqB4r0Ewj5MhBd0A4wY/uxVWIiRMm0pS91RUN97bMq2qJ9YkLWVrVFH53kayRgrt5uUaVaz54VUFNZ7VpvYIT09U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7358
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gV2VkLCAyMDIyLTEwLTEyIGF0IDE0OjE4ICswMjAwLCBGbG9yaWFuIFdlaW1lciB3cm90ZToN
Cj4gKiBSaWNrIFAuIEVkZ2Vjb21iZToNCj4gDQo+ID4gT24gTW9uLCAyMDIyLTEwLTEwIGF0IDEy
OjU2ICswMjAwLCBGbG9yaWFuIFdlaW1lciB3cm90ZToNCj4gPiA+ID4gKyAgICAgLyogT25seSBz
dXBwb3J0IGVuYWJsaW5nL2Rpc2FibGluZyBvbmUgZmVhdHVyZSBhdCBhIHRpbWUuDQo+ID4gPiA+
ICovDQo+ID4gPiA+ICsgICAgIGlmIChod2VpZ2h0X2xvbmcoZmVhdHVyZXMpID4gMSkNCj4gPiA+
ID4gKyAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiA+IA0KPiA+ID4gVGhpcyBtZWFu
cyB3ZSdsbCBzb29uIG5lZWQgdGhyZWUgZXh0cmEgc3lzdGVtIGNhbGxzIGZvciB4ODYtNjQNCj4g
PiA+IHByb2Nlc3MNCj4gPiA+IHN0YXJ0OiBTSFNUSywgSUJULCBhbmQgc3dpdGNoaW5nIG9mZiB2
c3lzY2FsbCBlbXVsYXRpb24uICAoVGhlDQo+ID4gPiBsYXR0ZXINCj4gPiA+IGRvZXMgbm90IG5l
ZWQgYW55IHNwZWNpYWwgQ1BVIHN1cHBvcnQuKQ0KPiA+ID4gDQo+ID4gPiBNYXliZSB3ZSBjYW4g
ZG8gc29tZXRoaW5nIGVsc2UgaW5zdGVhZCB0byBtYWtlIHRoZSBzdHJhY2Ugb3V0cHV0DQo+ID4g
PiBhDQo+ID4gPiBsaXR0bGUgYml0IGNsZWFuZXI/DQo+ID4gDQo+ID4gSW4gcHJldmlvdXMgdmVy
c2lvbnMgaXQgc3VwcG9ydGVkIGVuYWJsaW5nIG11bHRpcGxlIGZlYXR1cmVzIGluIGENCj4gPiBz
aW5nbGUgc3lzY2FsbC4gVGhvbWFzIEdsZWl4bmVyIHBvaW50ZWQgb3V0IHRoYXQgKHRoaXMgd2Fz
IG9uIHRoZQ0KPiA+IExBTQ0KPiA+IHBhdGNoc2V0IHRoYXQgc2hhcmVkIHRoZSBpbnRlcmZhY2Ug
YXQgdGhlIHRpbWUpIGl0IG1ha2VzIHRoZQ0KPiA+IGJlaGF2aW9yDQo+ID4gb2Ygd2hhdCB0byBk
byB3aGVuIG9uZSBmZWF0dXJlIGZhaWxzIHRvIGVuYWJsZSBjb21wbGljYXRlZDoNCj4gPiANCj4g
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzg3emdqanFpY28uZmZzQHRnbHgvDQo+IA0K
PiBDYW4gd2UgcmV0dXJuIHRoZSBiaXRzIGZvciB0aGUgZmVhdHVyZXMgdGhhdCB3ZXJlIGFjdHVh
bGx5IGVuYWJsZWQ/DQoNCkFjdHVhbGx5IHRoYXQgc3BlY2lmaWMgb3B0aW9uIGlzIGNvdmVyZWQg
aW4gdGhhdCB0aHJlYWQgYXMgd2VsbC4gSSB3YXMNCnRoaW5raW5nIHdlIHdvdWxkIG5lZWQgdG8g
cGFzcyBhIHN0cnVjdCBpbiBhbiBvdXQgdG8gZG8gYSBiYXRjaA0Kb3BlcmF0aW9uLiBUaG9tYXMg
c3VnZ2VzdGVkIGl0IGNvdWxkIGJlIGFkZGVkIGxhdGVyIGFuZCB0byBzdGFydCB3aXRoIGENCnNp
bXBsZXIgb3B0aW9uLiBJcyBhbiBleHRyYSBzeXNjYWxsIG9yIHR3byBhdCBzdGFydHVwIHJlYWxs
eSBhIGJpZw0KcHJvYmxlbT8NCg0KPiBUaG9zZSB0aHJlZSBkb24ndCBoYXZlIGNyb3NzLWRlcGVu
ZGVuY2llcyBpbiB0aGUgc2Vuc2UgdGhhdCB5b3Ugd291bGQNCj4gb25seSB1c2UgWCAmIFkgdG9n
ZXRoZXIsIGJ1dCBub3QgWCBvciBZIGFsb25lLg0KDQpJIGRvbid0IGZ1bGx5IGZvbGxvdyB0aGlz
LCBidXQgV1JTUyBkb2VzIGFjdHVhbGx5IGRlcGVuZCBvbiBTSFNUSy4NCg==
