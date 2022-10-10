Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190FD5FA21A
	for <lists+linux-arch@lfdr.de>; Mon, 10 Oct 2022 18:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiJJQom (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Oct 2022 12:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJJQol (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Oct 2022 12:44:41 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0C9E06;
        Mon, 10 Oct 2022 09:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665420278; x=1696956278;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=o2x6Nw3oslPmQR+ecaBCeJt5Lht4AqRv97HeaUUan7c=;
  b=b64GyVKbSwb9PdNzSCqFlt2Lx+lQUUjUPtUCj0ci/Qv4y/qh9o7lUJ09
   43XgqtcNNgg4jvtaFoDg3/JleheWvKotRSnwTqlQJLelZcLYnRkrloQIO
   ujEo5uqIkj1MN1x9gOFKFHrkccaVD0DBZ0/d0DrEj84AQoLPi1BiNOtX/
   ULvEP1fUBumVId2+DxV5o5fZffhznR1M7btm92Ror1SFk3hz6/BbhaNxp
   Btd4QN1vjpbleGdDHySFFR1gDaE3dvLyHSca9NbRcPk5wj66GIr1FK5e9
   q4W3mnYWaHCMnCz7G0KjrEqTGEnEltI6hDyU8d7pyNbC+fIJrUcb1M8/R
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="366243710"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="366243710"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 09:44:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="751414223"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="751414223"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 10 Oct 2022 09:44:37 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 09:44:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 10 Oct 2022 09:44:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 10 Oct 2022 09:44:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUCHY/quZYqofOz19kvVIOrJLfdoNH1CmCL12YjwzX+lIyodbN8h8ETabRGHAgQNVqReahOLQfkCZt1DAfh+Mp806Ku6voCJA4rUZ5jcWcuLISfFJqEyEeVWpx/Bk3OulLJDk//l7v8lYCsbkGU6gqYUQULjxDckkOerdGx0GAQXDQF/0Xan5SEbp8gdSsnVaqOXe97cfld9SgjkuuSRzI8ot/uOn1rpbPZfzrd49CSsPuVuDd7sRD8TYPPyl7UqOFZypbXvkoCJJ77K0vTCg6lTKXLc6Y9me7fOGDzIbThGtcNswbuaHtEuDvZes1zLQLP15lsgm0Tjnl9cTybcIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2x6Nw3oslPmQR+ecaBCeJt5Lht4AqRv97HeaUUan7c=;
 b=O0a4IHakz1wI4P6AWyqVz6bIPiZeQYLBiyIthbDh35MiuddBrQc1GksmDMRTS8Wypz5M8Bo8FkQcgkwkyVu2qQd3YZu1bRQGjUzhS2RNFcP+rSo4TTe1mmLJvMhZM2+XUF7/MV1ueggptE2dClkcUo/BT3YVf1n2GuKufqqc2A/FNqwq1pJiVpvQ7gopMa1C4EU3nH/QzOtQc34lMXFDa+w2cafQTv7yQQltBNhdPWlVTUnm1KgG8h9fKMwPYu9JmrcMseArQZDjSVHmOFco/7/rhDWezT85hb2xugxnavleOjrcZ8g8n5ubE9/rSekeA+TBmnf7gOk02hoAZl5SDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SA2PR11MB5129.namprd11.prod.outlook.com (2603:10b6:806:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 16:44:34 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.040; Mon, 10 Oct 2022
 16:44:34 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "fweimer@redhat.com" <fweimer@redhat.com>
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
Subject: Re: [PATCH v2 01/39] Documentation/x86: Add CET description
Thread-Topic: [PATCH v2 01/39] Documentation/x86: Add CET description
Thread-Index: AQHY1FL/9ZOrfh44YkS3ARV6MT/4g64HnGzRgABKE4A=
Date:   Mon, 10 Oct 2022 16:44:33 +0000
Message-ID: <62481017bc02b35587dd520ed446a011641aa390.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-2-rick.p.edgecombe@intel.com>
         <87ilkr27nv.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87ilkr27nv.fsf@oldenburg.str.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SA2PR11MB5129:EE_
x-ms-office365-filtering-correlation-id: 9c9be750-da87-4bc1-ff7f-08daaadeb608
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: StXXfR0/70ydfGfRKf1YFEi3GaO0hG7dJnHkkaHhmJfANDgROXaVeRjIps2HPXvFkKJlrg/GNREQh/CZlX3CaS2hB0mSTjEWzHJMvkCzVNS8G9z4vFENIkTw6a4WYP7rikbgz6IpIr61k7XrcGDppTbBecrsZ2s+qvdQcdZtAg2jjmm0nNBQOiwfCDr9xV+q5kuqfYDT9frMmCS0bsIlldJdYPO/zjfq1M1E2o/3dCqurQrX92YyMt79g8flmZtb45nWnsrKnAiazJHSY3JHU0prLKqtcZql9tn96FLk7EGdBFkgHHNOJ5JmHJoCgTsO9o3pMA2AlpuqMdUEISSposyulUQYfN7p0PcC5MOw1b/v2tTYyiE+B096YTFBdfox3j66lTdPDGm8MB/zkcE+v4doo3q2TE2iOFO182a+HV9FVDZikIiXZpkXHWOVadE3Ld6+xBmHkN5J9foyF80CLymMq+c/cFpuE6K6PMVkW9M7HOv6IeAyFXzbv3zT5yRBcA7KnRk/t62/kp2WF50rTM0aI1fUv1ru1YPodYhGLdthSXVO8nU1ZVFOWVuZJPFdZS7sLPzEHnWGJux30NpxQ7/nbpRi+Sy/tM3Jyg/QL3BGRFhiV/caZ1XTgnEx6cb/bT2YGi95jkupSvwWZ/uy8YnFrfnzXFHt43sER2PQOZf97PcAv1kWve5jvXGfr93NfhP8GCofwX6P69bue7yyMOzI/tVJg3XJ0he306M21ysNyTRsNXOxVkJ4tfF2mJP8RvZNl/U2NAikOzWpDELwz60lpAGZmsurDtNFI/cXbPI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199015)(6506007)(2616005)(6512007)(26005)(71200400001)(6486002)(186003)(82960400001)(38100700002)(86362001)(478600001)(38070700005)(36756003)(64756008)(66446008)(4326008)(66476007)(8676002)(122000001)(6916009)(66556008)(54906003)(4001150100001)(41300700001)(316002)(5660300002)(7416002)(8936002)(7406005)(2906002)(76116006)(66946007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDRQY1ovaUQwZTduSFV3cm9seXRXOXF0TCtOR3JNZWVXQUl0cVg3MjRzVTBG?=
 =?utf-8?B?ZE5TMkxGdVlZODl3ZncxbVRwNUhDdEpKc3Zhc0lvNjJiL1ZIcTNJQjZKNEll?=
 =?utf-8?B?Qk1uLzgyY3ZuQWM2U3o1alRYNmtVOFcraVNCT0lVYkFaamZYaVRqSmRFcWFF?=
 =?utf-8?B?VDEwWVNGR05OQWpWbEpNKzdTYnVKTlNwK3RFbE5PalkzZGthRHh0OUR0aFdQ?=
 =?utf-8?B?Rm83WE5oMmZpV2JHcXJnZlJVSU1oTStlSGxLS1RrK0h4aTB5WXdOZWpPeURy?=
 =?utf-8?B?OWx4eHA0NVd6Vlg5RkxjaUYvM3hRRmE1czVJQUtkOXdzQkFTRURvUjNGMTRG?=
 =?utf-8?B?RW1JL09LeEZaZzRIQXdhL0psRVVYOVJNWjcwK2FITjh6WGFVWkJDL3RxdFg3?=
 =?utf-8?B?aHNIYVNUNXBqS0RYK1Vsc1plV3RuZ3dheTlsYUt5K1A2VWpqQTA0ZmlEaG1C?=
 =?utf-8?B?MDBYdlVldFEzSTg1K3hmNk90MlhBaGh2bklRZld2VHdvVEZweFkrNXdGaXN1?=
 =?utf-8?B?bHk0NjZ6N2VidEpPZ1RCb3RyQjVUaGtHT2JNS1dQdUpJR3VadUtWd1lOK2Yw?=
 =?utf-8?B?enlnSzVlQis1dDZuTldYSmtnblBvTXdlOFpoWmVIWnMvUUV5VlNPb1h1eU9n?=
 =?utf-8?B?SmFMN2ZORTNTUXhreGxPb2lqbTRobWdTT1NrZUxzM3N0cjU5djlCTFoya2Iy?=
 =?utf-8?B?SlpOTFFJc1RmQ2pnZEZ6TitLSDZ6N2RjWDg1UVlGK1ZQNmFJN1ViRTQ2U3hk?=
 =?utf-8?B?N3ptMVFGQTgvWjV2UDdrbTJIKy9ESGZqcnk2S0NCWlNYZklyc052dVhPcWtY?=
 =?utf-8?B?NFNodFdqemdFOVhNODU0K1hsSWtvRFkvVnRsR2tld2FZTzRmWkVNUDVObGdI?=
 =?utf-8?B?bGNqT21JYmFoZzh1bTE2bFJEWGVhM3ltN1BHN0xQOVA2Tjlycm5MT0hKTFZ5?=
 =?utf-8?B?QkNpeThobHNBTmhjcXg5MFJVQ2h6UGsvbWNESVZWdGc3bVdoSnpXSEZ0L1dL?=
 =?utf-8?B?VUxiKy9hVlJHRHZzZHM5ZktscE5wVE5BOUlTajRYMUNjTFJFR0dKTkQxSHU3?=
 =?utf-8?B?UURlb29sMU53VHhhSHNlVk8wN25Iblp5T0F3QnFiVUgydE1FMU9uV211NmNw?=
 =?utf-8?B?d0ZuSUJMTU9GbHZUMEdHdDBiZlcwU2lVZzZPNXRWalBwNGhhM01WN1ZNOFFF?=
 =?utf-8?B?MmhlNFVrZC9oaGpVcTAyVGhIYldWQ1F3RzNXODdNRDl0TWcrSmo2cGJodXBN?=
 =?utf-8?B?L2VmWkNqdE52QUh6V1NueXREbzFsZEcxNW4wVWU2aFZReGpmTXg2Q2FQME95?=
 =?utf-8?B?UFN6TlBPakxCRGVOblh6ZmdpeVFpSWxkZGg1TFVaUzlaRjRGN2o1L0wxNHNq?=
 =?utf-8?B?czNBOHAxb2xqTWppRkRMY0p3SGR2dGJvUElsWm0wRWY0WVFRcDcxMDdST2xh?=
 =?utf-8?B?aTBZZDlKZ2JXc0VZeHV6MWFRRXNjWEptS0grUHpPMEp3aENPemZpMWt6Y1JT?=
 =?utf-8?B?Y3AvRFF0RDNMa0dRenRzZlU3Y1VEamJrNS9OdVpiakZCVWNvWGxPVE84djdC?=
 =?utf-8?B?bWxPOUJIbGl6SXFjbHJRTEdHbjhmZUFON2lYcHFWTzBUMVV5Y1gwdVRIRThV?=
 =?utf-8?B?aGQwc3JOUWkrTzMxWW5wcFJVRFFQejNNUGFyaVNWang2S0cyeU9MV1pEc2ZT?=
 =?utf-8?B?S1FBM2ViUmpySm8xYnJkSzdtNmdZS3RrQnpGS2R5SWpXdGVldWIzdHZOSGVq?=
 =?utf-8?B?dURuSDlXVXBtKzBVeFpXbDUvSWVtRnk0KzlnbFJKOXhVLzZxWnkzQlEvWkZt?=
 =?utf-8?B?a0I0NndsaFlQT1VQY3VyMTFwenlyVFhOSnBRYnJ5QVVnM2FZWnRDQ24ySFdn?=
 =?utf-8?B?OS9maFI3NHkwVUVIbWRrdmQrN2MvVGxMMU83clFFcGVKeGQ5NENNUXhkRTdk?=
 =?utf-8?B?TU02Q0twN2xjaFQzVG9KOVlkZm9xb1ZVdHhQYkFNcnpPMGg0OThRaXJLRVp0?=
 =?utf-8?B?QU5nV0ZvMFdpUTdSU2F1NCtaT3ZRYi92OVZRZ3VxNDJpZVIrM045RnhrZ2NQ?=
 =?utf-8?B?NDBpY2x3L3BnSEY2OVllbnczb0ZjU2psME9MS3cwT2FGSnpQNmVvOC9DT255?=
 =?utf-8?B?QmFKRnhkN0J0bW9pOWhhTjVqMjQ1ai9UcnZzd2F2OFdvU2V1N01JenBxc3lh?=
 =?utf-8?Q?wy8G66ZyR76JkFUgoAISe1M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2291D59113132D44A8872EE1116C5CAA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9be750-da87-4bc1-ff7f-08daaadeb608
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2022 16:44:33.9382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yl0thdMRSiWbi451ZC6uO6LEzASsQ8iPYkwZk77oSdqVkYJmdCUb7ERVllH1enIqrPx2VwHbmL0ZtJjPApkedw/J9cAKQMWOuuIKhu9MROU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5129
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTEwIGF0IDE0OjE5ICswMjAwLCBGbG9yaWFuIFdlaW1lciB3cm90ZToN
Cj4gVWhtLCBJIHRoaW5rIHdlIGFyZSB1c2luZyBiaW51dGlscyAyLjMwIHdpdGggZXh0cmEgZml4
ZXMuICBJIGhvcGUNCj4gdGhhdA0KPiB0aGVzZSBiaW5hcmllcyBhcmUgc3RpbGwgdmFsaWQuDQoN
ClllYSwgeW91J3JlIHJpZ2h0LiBBbmRyZXcgQ29vcGVyIHBvaW50ZWQgb3V0IGl0IGhhcyBiZWVu
IHN1cHBvcnRlZA0Kc2luY2UgMi4yOSwgc28gMi4zMCBzaG91bGQgYmUgZmluZS4NCg0KPiANCj4g
TW9yZSBpbXBvcnRhbnRseSwgZ2xpYmMgbmVlZHMgdG8gYmUgY29uZmlndXJlZCB3aXRoIC0tZW5h
YmxlLWNldA0KPiBleHBsaWNpdGx5ICh1bmxlc3MgdGhlIGNvbXBpbGVyIGRlZmF1bHRzIHRvIENF
VCkuICBUaGUgZGVmYXVsdCBnbGliYw0KPiBidWlsZCB3aXRoIGEgZGVmYXVsdCBHQ0Mgd2lsbCBw
cm9kdWNlIGR5bmFtaWNhbGx5LWxpbmtlZCBleGVjdXRhYmxlcw0KPiB0aGF0IGRpc2FibGUgQ0VU
ICh3aGVuIHJ1bm5pbmcgb24gbGF0ZXIvZGlmZmVyZW50bHkgY29uZmlndXJlZCBnbGliYw0KPiBi
dWlsZHMpLiAgVGhlIHN0YXRpY2FsbHkgbGlua2VkIG9iamVjdCBmaWxlcyBhcmUgbm90IG1hcmtl
ZCB1cCBmb3INCj4gQ0VUDQo+IGluIHRoYXQgY2FzZS4NCg0KVGhhbmtzLCB0aGF0J3MgYSBnb29k
IHBvaW50LiBJJ2xsIGFkZCBhIGJsdXJiIGFib3V0IGdsaWJjIG5lZWRzIHRvIGJlDQpjb21waWxl
ZCB3aXRoIENFVCBzdXBwb3J0Lg0KDQo+IA0KPiBJIHRoaW5rIHRoZSBnb2FsIGlzIHRvIHN1cHBv
cnQgdGhlIG5ldyBrZXJuZWwgaW50ZXJmYWNlIGZvciBhY3R1YWxseQ0KPiBzd2l0Y2hpbmcgb24g
U0hTVEsgaW4gZ2xpYmMgMi4zNy4gIEJ1dCBhdCB0aGF0IHBvaW50LCBob3BlZnVsbHkgYWxsDQo+
IHRob3NlIGV4aXN0aW5nIGJpbmFyaWVzIGNhbiBzdGFydCBlbmpveWluZyB0aGUgU1RTVEsgYmVu
ZWZpdHMuDQoNCkNhbiB5b3Ugc2hhcmUgbW9yZSBhYm91dCB0aGlzIHBsYW4/IEhKIHdhcyBwcmV2
aW91c2x5IHBsYW5uaW5nIHRvIHdhaXQNCnVudGlsIHRoZSBrZXJuZWwgc3VwcG9ydCB3YXMgdXBz
dHJlYW0gYmVmb3JlIG1ha2luZyBhbnkgbW9yZSBnbGliYw0KY2hhbmdlcy4gSG9wZWZ1bGx5IHRo
aXMgd2lsbCBiZSBpbiB0aW1lIGZvciB0aGF0LCBidXQgSSdkIHJlYWxseSByYXRoZXINCm5vdCBy
ZXBlYXQgd2hhdCBoYXBwZW5lZCBsYXN0IHRpbWUgd2hlcmUgd2UgaGFkIHRvIGRlc2lnbiB0aGUg
a2VybmVsDQppbnRlcmZhY2UgYXJvdW5kIG5vdCBicmVha2luZyBvbGQgZ2xpYmMncyB3aXRoIG1p
c21hdGNoZWQgQ0VUDQplbmFibGVtZW50Lg0KDQpXaGF0IGRpZCB5b3UgdGhpbmsgb2YgdGhlIHBy
b3Bvc2FsIHRvIGRpc2FibGUgZXhpc3RpbmcgYmluYXJpZXMgYW5kDQpzdGFydCBmcm9tIHNjcmF0
Y2g/IEVsYWJvcmF0ZWQgaW4gdGhlIGNvdmVybGV0dGVyIGluIHRoZSBzZWN0aW9uDQoiQ29tcGF0
aWJpbGl0eSBvZiBFeGlzdGluZyBCaW5hcmllcy9FbmFibGluZyBJbnRlcmZhY2UiLg0K
