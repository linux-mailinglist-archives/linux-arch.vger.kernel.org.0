Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46D35FF1A6
	for <lists+linux-arch@lfdr.de>; Fri, 14 Oct 2022 17:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiJNPqH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Oct 2022 11:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiJNPqA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Oct 2022 11:46:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CF42B601;
        Fri, 14 Oct 2022 08:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665762355; x=1697298355;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ljiKUjm7Mhlz4qqUY+7TMgJJot2k5mG33mYURZx46eI=;
  b=YD7/g1F8cb01dwZBMimzqZlbWlGlIREvqAEOa6+vrbBpuCTf5Fgev143
   Fdl73WFfqh9AEfHzQqeyos4sw9v/A0rjTYc6/aYWGp9AlVq5WGIe+/pGr
   rk2TJoy5uFVMwFpXJTyeqXovSF4Mmi8NihVjo3gjjzwEk72LNl9kI/hNm
   pyxnR+hhgn+VUzIz3EwTkwHLGoemAU8QqWG7XpPIV0zKFOYC1cZm3cKjo
   RjdhtL24/WLzhxdHQKGtHZhIqYauJjkZ9BBnjxwuYF6j1Zrrj16tmpbX5
   33IQ3v9J5uhMFHRz4GyH0Rdf5nPQUneYuqyo9Ma7bo6Elo1qDNXazi3AA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="391709809"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="391709809"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 08:45:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="660768840"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="660768840"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 14 Oct 2022 08:45:47 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 08:45:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 14 Oct 2022 08:45:47 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 14 Oct 2022 08:45:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EANsSyN8OmUN6c5ej+YPvsRoCmWanDVSyCQqdlh6HrJdJhmMZxRiyu5hGFPpvalu/ZWVFrQpmDU5FbPrkYueVaKSSQq6ZBvidMk71DiA/U/GjX1E3cGbKTMiHFAWjVYqy4w0G7m2eICA0x0Hir2X8qQKuyjvCVZlag1fAmpIea//+WkiDq4M0H3+irZFTnRWbuKFzc2e/XIoXjO9T3seTuLr50C0BNyJ4WlotaH5GUUbXM+oESrf0rv8+wxac68EVe6aH9ekgf4ife36djOexRZhkIWyCx138KxHo2O4oa/shQl+n4fUhwoKChTHqdB/EABsLPiqke/V8TUsfy7x6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljiKUjm7Mhlz4qqUY+7TMgJJot2k5mG33mYURZx46eI=;
 b=QCqdM1Uw6i5OEC/Dv9TQWPh6WcrCcUnuMmpXMYWKrQC3LA71gGPP3mZeLqhRU4JK0T3HjN4idg5O4YIqSdwGgqcLgTSHFw3JX9T6/LFGisPIOp5p0GcAeqEQ/pu33qGwk/katsfo1PTaJ8bnN2UrZZ3zCWRTXhrCt50DIKPzzH+9SIlRNZkXhvdaNjQnY2X8cO9s9Wr0gnlgX8cC+9bmFwFyQzJ8Lw6Osx7JaBfC/USIN+gj5WA0+DHIt6tZt2kmW896ps+8HGhpQ+LJAOwMoox9njOhXrRsWjfHcw7TF+H0vtkJ1aO1ZlPIP83kwMw5k9wY751KsvTbRq0eORTwDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM4PR11MB7352.namprd11.prod.outlook.com (2603:10b6:8:103::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Fri, 14 Oct
 2022 15:45:44 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5723.030; Fri, 14 Oct 2022
 15:45:44 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
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
Subject: Re: [PATCH v2 16/39] x86/mm: Update maybe_mkwrite() for shadow stack
Thread-Topic: [PATCH v2 16/39] x86/mm: Update maybe_mkwrite() for shadow stack
Thread-Index: AQHY1FMaMzdwW7wSikebdXDsEB5a1K4OG7sAgAADp4A=
Date:   Fri, 14 Oct 2022 15:45:44 +0000
Message-ID: <b8796aea7c0396dab59cf539a7de3c5e8c8e2933.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-17-rick.p.edgecombe@intel.com>
         <Y0mBFjfOAA+hJcUn@hirez.programming.kicks-ass.net>
In-Reply-To: <Y0mBFjfOAA+hJcUn@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|DM4PR11MB7352:EE_
x-ms-office365-filtering-correlation-id: d6b3f4ca-1c78-4069-fa63-08daadfb27ea
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JSbbtZuFW0WSzWGo8bWAhCgCdd1fsws3TcvIWfK7TcCQYeSeIc4rRXE+vqWIzz7mEy6EkNzf1GK6x8g2pzAR6e4DDQpIwdga8YosNVWhwRR6RWLPkGQlqxWFL4mDK2L7jithTpYf/hd7y/E+F6kHrA1V2AEQA14ztMXpRT/fUDQt9ZRuTA9d2Q2TTa5w1SlruSi1NvjmcMA2HhF0AgBy4/lu3DuT1R90eBUarhrr3qTWM0r8qAlqXUQKFvW9ODjOZjXgFgMSTky/82ox4iZSErQi/oAqtzz8FGGnEFgJnmJ5GZ2EDwOwuWVLSYJ6q5mRI5PTXgQKzPwLJ07RpqsZhd/soIalXabSL0h8IKmlhLTnN13Ceq35PnQ0RJPodatzEhZerIf/vvp5FjKe60rCQGK6e0LnaQaWXzXmzukofAZJ+9xLh6V5QD2M2UYc67VIVQCDk50Q8QtHXgzB8f295IHeKat+tMTOjlzgzvMiKVxsXmnMDQoumwcHevjGLYt0zkI7l27aJfz3GpbzfeaQPwTtMiH6tJKmgGYVe1SrUVyc2KmcZ/sQnFKtmykyTUYrd8jPr1YssHMY8vq5eqRGEnV3GX5byiyfQfoeUxDiDW6xgpQKGSK6XwF+V521OEUqHZdiiOt3BuiNqrjlP2vthe6P/n/Es27fCJiXFROmskB4HtPPlLn02eiG23JSsCDKQzCsm+XmJ4AhJts4wErsqpw0mqoci4pI7//xt/8SHB2Wm7oD04yHpF8ZTSY6QwYVNkiNWM90WfqKBGUPwT0j7zkjlTujIkgqzt1oEgEqY5g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199015)(7416002)(38100700002)(54906003)(6506007)(82960400001)(5660300002)(66946007)(4001150100001)(2906002)(64756008)(91956017)(66446008)(66556008)(76116006)(316002)(66476007)(41300700001)(8676002)(186003)(7406005)(4326008)(38070700005)(122000001)(6916009)(8936002)(83380400001)(478600001)(6486002)(71200400001)(26005)(2616005)(6512007)(86362001)(36756003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnlMSWUwWFhpUTkrNGphWTVKNUtUZUZlZkwzUGFqejUwTEdsVVpsUkFLdXlP?=
 =?utf-8?B?ZVdXNHlCd1hqclBrUHB6RnBIZ3hWdnRCR0ZsS1JpTGNJWjR5WWpFMk41SCtz?=
 =?utf-8?B?Y2xSK1U1Q1pZbWlSZ1JobHdUdktldkNRU2JTUHVVSGNZejlwTm5RZjh3QmxM?=
 =?utf-8?B?MVZvdGQwMjFYM09vMDRVUUFRMWFwL0Q1aGpseHBPbEpEZkk3RWo1YTRQZ0lp?=
 =?utf-8?B?Umlvenk1cDFqM0piVS9LS0RPLzI3UW50QTlCcEUxcnVDYWh4WC9xV0hFcDZD?=
 =?utf-8?B?Yy9xakpiZWlMdTYxS3lMZHEwNUFsdXRMQlFDdzRFNUE0OFN0L3pSUlZoUm5Q?=
 =?utf-8?B?ekFGS0wraFVHdENCM1l1QkNndUJVc3ZLUHJiODJBdjY1dFp0WExWU2Y2TlZ0?=
 =?utf-8?B?blgrRWQydmJLL0VmTnhNZnV1K01LKzZYY0hpbk1WYUJueFBPUktIem5tbWY4?=
 =?utf-8?B?cHJxT3ZBNTVkMUx1NGFSb21KcGdRamlTdkIzU0tHdUlDNGtzc0taYzhxbnQ1?=
 =?utf-8?B?Z2VjUG9rSjdYajJ2VHBRMUZ3NG10aW5lRnBXWUFCWVNiWTFYYzRNTU1ZQTJE?=
 =?utf-8?B?SDdHamM0RWNMUEZZRjY0d1YrVUk0Vjdxa1BxRmZIeGhLcFhseWEwWit3eWMr?=
 =?utf-8?B?Y1dPQXNwaGxoVzVhaU52MHBrMVlLQTd2MkVNNVVuMTVaSlloek9CWFd6YTBG?=
 =?utf-8?B?Wmd6M3BXbDBGc1dqNzdQL2xmTlZxL0FKYTVrRFNLOTJkazJwSmUzMTVaWkFr?=
 =?utf-8?B?bVpvTmM5SGFGUmRhN3JrVDh2ajAyaTI5QjdnU1VoNWJtNlZhb3NFbTJ5Nmhx?=
 =?utf-8?B?a2RLakVuWFVSc0l5K3Q0RG5RZkx1bmczdFQ0aTkvTGEyVUVJb3pKZTJXUE5Z?=
 =?utf-8?B?UlQyMHpiTXNSZ205aWtSWFVMZUcxQm5EUXhETlNSQ3lXY1Z4N1R3VXZuS0dJ?=
 =?utf-8?B?VWZkd3ZGRlZHcFU5bGUwNG5NbVMwRXRpVjdkQkZWQ3VMWVBhRk1CNFc1ekNz?=
 =?utf-8?B?ZTExMTBoeGtCNlQzUzBtWWJ0L0EzMytCT3BzVEpKME1TeVlaVEpMREVESllF?=
 =?utf-8?B?QUhvUHczcnJhYml5bEtQVTJmMUJoSVUzVFpRZ0tKTTBYT2VlaEg4ZDF6K2Vj?=
 =?utf-8?B?WlZvL0dac0x4QWhveGRLWUc2cEtXODJQUmZaQzYwblZoeTloSDMxVmx4YWg5?=
 =?utf-8?B?ajR6NVkzTjBpQXl3MHJYMlJNTUpFRkhUd3ZaVjlhdk5oMGlILzR3Z0tyWnFF?=
 =?utf-8?B?MjVJc1EwRXhRbEEwRm8wUk9penlRa1QraHFWaXlTNTUxRHZTYUlpZGZHTHVl?=
 =?utf-8?B?K1drdUxGdklrbUdJWUIxVDA5MUpBSGJYekJJczhQNnJocGgvdVl3Uk5NZVZH?=
 =?utf-8?B?d3l0K0wwaVlNeXNuMW5YTFdDV2d1UnVKRWhqN3NKdnNGdUpyTVZOdTF1d3dT?=
 =?utf-8?B?dm9kRjZTbVl4T1FGWWdKS0h4RXFhdGwzUHpJYStCcGo4QnZNMTlnMXNnWTU4?=
 =?utf-8?B?TE1kbGNkSVhFYWptWGlsRThEeUJsN05YQ0FCc0JXcGxzT0xHdFZHZHlRcmFr?=
 =?utf-8?B?U2sxM2RvYWswdWJ3REJmWDBJN1c5ZUtyMVNXR0ZTdVpYM3M2MFQ0c3ZmUGw2?=
 =?utf-8?B?TW1qNGV1S1NNNDFhTUdpS3hFK2c4MkpKWkNFV240YldiSEEvVmxjUFk0THll?=
 =?utf-8?B?VW9wc3RjZWRKTWplUW5EaTlML01iM0RqTzg0Y2o4Nzk4bXZiNzJLMndvNm5Z?=
 =?utf-8?B?NHh6cjV5ZnZNdEo4aTBJb1lySnJGSEltOTJuN1NIYVRuT2Nid0N5ZHQxeTdi?=
 =?utf-8?B?ODNmQzdESmxQWmVTc3o1WG8zeWhROGttZitxZkdpRFJzRTN5aWtWT0oxOFRq?=
 =?utf-8?B?NzB1REFKaUc2WkR2TWJ5anYvby9mbmVkSlpPZUlSWmwrZDFrWTI0R1QrQ3pl?=
 =?utf-8?B?YUtTYVJWclZTTU9BcVE4NjFBV2dSZzVHNzZ1dEJ6aFZEdjBiejV6OFkrbFY1?=
 =?utf-8?B?QSthLzV3Um9ZSWRpSzVQTm9taDA4cHphbmE0anJLdENETEhHMFR5WWNkNVVS?=
 =?utf-8?B?djN0NkRnQWpSY1Zqbnp0WXliNTQ5U3pJcGlLSzV0N25ZWG9DVkQxUE9STXMz?=
 =?utf-8?B?TkRQMlI4QnNBRStsTTVMQ1k3eDJrdUg4end5RHI3clc0c3puZ1dETFVjUjJu?=
 =?utf-8?Q?APbJu/pFxFw/nrSoQ8Ymyl4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A21C0F544AB24B4B835D506BABC9ECB3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b3f4ca-1c78-4069-fa63-08daadfb27ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 15:45:44.4141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VQFyukXoYCYuRgiyzMta8q3lMdC3prdnjBa0El2Ru/Yu3CDwv0u6G7Qbr0ZD3SJpdlXC6BwCdqofcwEwSV1iUf3EmI8gD8Eo4saKLOmZu0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7352
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIyLTEwLTE0IGF0IDE3OjMyICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gVGh1LCBTZXAgMjksIDIwMjIgYXQgMDM6Mjk6MTNQTSAtMDcwMCwgUmljayBFZGdlY29t
YmUgd3JvdGU6DQo+IA0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21tLmggYi9pbmNs
dWRlL2xpbnV4L21tLmgNCj4gPiBpbmRleCA4Y2Q0MTNjNWEzMjkuLmZlZjE0YWIzYWJjYiAxMDA2
NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L21tLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4
L21tLmgNCj4gPiBAQCAtOTgxLDEzICs5ODEsMjUgQEAgdm9pZCBmcmVlX2NvbXBvdW5kX3BhZ2Uo
c3RydWN0IHBhZ2UgKnBhZ2UpOw0KPiA+ICAgICogc2VydmljaW5nIGZhdWx0cyBmb3Igd3JpdGUg
YWNjZXNzLiAgSW4gdGhlIG5vcm1hbCBjYXNlLCBkbw0KPiA+IGFsd2F5cyB3YW50DQo+ID4gICAg
KiBwdGVfbWt3cml0ZS4gIEJ1dCBnZXRfdXNlcl9wYWdlcyBjYW4gY2F1c2Ugd3JpdGUgZmF1bHRz
IGZvcg0KPiA+IG1hcHBpbmdzDQo+ID4gICAgKiB0aGF0IGRvIG5vdCBoYXZlIHdyaXRpbmcgZW5h
YmxlZCwgd2hlbiB1c2VkIGJ5DQo+ID4gYWNjZXNzX3Byb2Nlc3Nfdm0uDQo+ID4gKyAqDQo+ID4g
KyAqIElmIGEgdm1hIGlzIHNoYWRvdyBzdGFjayAoYSB0eXBlIG9mIHdyaXRhYmxlIG1lbW9yeSks
IG1hcmsgdGhlDQo+ID4gcHRlIHNoYWRvdw0KPiA+ICsgKiBzdGFjay4NCj4gPiAgICAqLw0KPiA+
ICsjaWZuZGVmIG1heWJlX21rd3JpdGUNCj4gPiAgIHN0YXRpYyBpbmxpbmUgcHRlX3QgbWF5YmVf
bWt3cml0ZShwdGVfdCBwdGUsIHN0cnVjdA0KPiA+IHZtX2FyZWFfc3RydWN0ICp2bWEpDQo+ID4g
ICB7DQo+ID4gLSAgICAgaWYgKGxpa2VseSh2bWEtPnZtX2ZsYWdzICYgVk1fV1JJVEUpKQ0KPiA+
ICsgICAgIGlmICghKHZtYS0+dm1fZmxhZ3MgJiBWTV9XUklURSkpDQo+ID4gKyAgICAgICAgICAg
ICBnb3RvIG91dDsNCj4gPiArDQo+ID4gKyAgICAgaWYgKHZtYS0+dm1fZmxhZ3MgJiBWTV9TSEFE
T1dfU1RBQ0spDQo+ID4gKyAgICAgICAgICAgICBwdGUgPSBwdGVfbWt3cml0ZV9zaHN0ayhwdGUp
Ow0KPiA+ICsgICAgIGVsc2UNCj4gPiAgICAgICAgICAgICAgICBwdGUgPSBwdGVfbWt3cml0ZShw
dGUpOw0KPiA+ICsNCj4gPiArb3V0Og0KPiA+ICAgICAgICByZXR1cm4gcHRlOw0KPiA+ICAgfQ0K
PiA+ICsjZW5kaWYNCj4gDQo+IFdoeSB0aGUgI2lmbmRlZiBndWFyZD8gVGhlcmUgaXMgbm8gb3Ro
ZXIgaW1wbGVtZW50YXRpb24sIG5vciBkb2VzDQo+IHRoaXMNCj4gcGF0Y2ggaW50cm9kdWNlIG9u
ZS4NCg0KT2ggeWVhLCB0aGlzIHNlcmllcyB1c2VkIHRvIGFkZCBhbm90aGVyIG9uZSwgYnV0IEkg
Zm9yZ290IHRvIHJlbW92ZSB0aGUNCmd1YXJkcy4gVGhhbmtzLg0KDQo+IA0KPiBBbHNvLCB3b3Vs
ZG4ndCBpdCBiZSBzaW1wbGVyIHRvIHdyaXRlIGl0IGxpa2U6DQo+IA0KPiBzdGF0aWMgaW5saW5l
IHB0ZV90IG1heWJlX21rd3JpdGUocHRlX3QgcHRlLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QNCj4g
KnZtYSkNCj4gew0KPiAgICAgICAgIGlmICghKHZtYS0+dm1fZmxhZ3MgJiBWTV9XUklURSkpDQo+
ICAgICAgICAgICAgICAgICByZXR1cm4gcHRlOw0KPiANCj4gICAgICAgICBpZiAodm1hLT52bV9m
bGFncyAmIFZNX1NIQURPV19TVEFDSykNCj4gICAgICAgICAgICAgICAgIHJldHVybiBwdGVfbWt3
cml0ZV9zaHN0ayhwdGUpOw0KPiANCj4gICAgICAgICByZXR1cm4gcHRlX21rd3JpdGUocHRlKTsN
Cj4gfQ0KDQpZZXAsIHRoYXQgbG9va3MgYmV0dGVyLiBUaGFua3MuDQo=
