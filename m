Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BD95F36BD
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 21:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJCTx7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 15:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJCTx5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 15:53:57 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81502F3B7;
        Mon,  3 Oct 2022 12:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664826833; x=1696362833;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=k29nyPakB3E4A5+MNnq/YwaLHVaLqvdT02fNlSf7jPs=;
  b=QxUYPVQICQE9pguRTiAzgjHgqPBvjnDJRl5t5Embvnh4NOpzkQgCZ3Q0
   SB1DDnJC9S0ySJhYizYZfCXRuG5FgaanL9OPOz3zsbBcb+sQ42juHp8ZQ
   lKaSOheL3l8MUFmvAyHo8ODGIpRQPUWYNt2wagcfkNEzw0LU2K1MW8G61
   W+Pg5pBn+XlG6D6Y4vJ/1aR8laQT0gMOlluR/605zl8luWC3z5C5J+OLw
   GPmqinsR8stAurK/PHmn75TaKI/P8TInRWJcVbVCT8EeIg+EIKUXueraL
   gR7ka+k8Rf7Y+VuubErcU1oXd7pdwOjL4FaonrP7uSKKILOHf9kQxgmDT
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="283111846"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="283111846"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 12:53:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="623675656"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="623675656"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 03 Oct 2022 12:53:52 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 12:53:51 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 3 Oct 2022 12:53:51 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 3 Oct 2022 12:53:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4TjXwYBMqB0hTCktKNgg6uNYERqa5MpYN2uGyqdSjKa3t3jFZCJFmDGplm+wa4eDmNizJB5GLVeu7qLsZ0+jSTxxqi/8kb96t2mJkUGTA6KlP+wEJCsZQdKRhBmIOFrfp7uv0ivb8JS6Pu//cpRYZysrHsxPMT7EIqXMEJHZ+xRML0iquWExCVDYhveRcEojMcndzYvGzJXplBhZmn0DeR4lOHaBZejfXwSu9VXFQelEGj/adIPO5a3Rs5vn+ZZ1I2pyjaPlKjZZZJQbFrmmonXgtMuCV72n/niQgUx+9CsQ6FrdP0BzlTr5b7+OJoyXR3F3OS+wqa+tiIoBc1Aqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k29nyPakB3E4A5+MNnq/YwaLHVaLqvdT02fNlSf7jPs=;
 b=cR3mDBTKgDfNxKBgJgwM8U8JqJBMxjktwuMfKxFFSHLn0MPZZIpB7/tGVkeBgJ/2W2jGq21oDCchLNBxzV/8MHeB5LkX6o70oyrFuD0xnEMYVOVtuCEwiQhGNXpLLDu7pahSouYmBSKtHJJSMcI1ISnl3LJOZXMtz41S0LvFFNMq6oE3/NhVYHonlYHyh32FdcV6s0kGLZemCeRaOCZ1A4gARFjfdivpP8VvXUvFhd4hF9s09VQmeL7kLnfRe8Ud8kdxNPZE2pruED/8JYJyLLL79NqKghCYowTCLgi7khvnGHPW9vAYjCPn5eNyicX7TG78a1FfYbbhaOVnnAqrNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CO1PR11MB5202.namprd11.prod.outlook.com (2603:10b6:303:97::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Mon, 3 Oct
 2022 19:53:44 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 19:53:44 +0000
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
Subject: Re: [PATCH v2 02/39] x86/cet/shstk: Add Kconfig option for Shadow
 Stack
Thread-Topic: [PATCH v2 02/39] x86/cet/shstk: Add Kconfig option for Shadow
 Stack
Thread-Index: AQHY1FMAO2++jn8eSkiiPpemqAqzVa38sqUAgABoY4A=
Date:   Mon, 3 Oct 2022 19:53:43 +0000
Message-ID: <f5ffce2fb60e5b06e0d6942d7058c1e14c12a9db.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-3-rick.p.edgecombe@intel.com>
         <20221003134006.yoye7dvywuec6bco@box.shutemov.name>
In-Reply-To: <20221003134006.yoye7dvywuec6bco@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|CO1PR11MB5202:EE_
x-ms-office365-filtering-correlation-id: c507653d-d795-45df-2cf7-08daa578fa3b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JzSXmVy5rbROsydSmAdij3hd/y29SiFkw+lVEAqEYUFeJRaFT1pk34oEhw5DVZWhbOgL5bQzCKGf8HSrpxeMv8rFv/+51yCaMNPz3kS5WtxlFVOK74F0VrfspHPQVdQW0R55itltBKZOlEvG151UzFrqEHw8XcrXZyF3PJm/lCe/nrrTTa3GacZNabZ2gP2uV/isscKpuMlS2c9mUjm4yoJn/4y3OAz02aeSKW20v00ALxoNeTmrVio86qRgnT0QEQC3brE6FphY7SCIRrW/cviyJ7CBvgwZ+8qtswYQEdJ1LF2PO01FXggBoMFa7/hj1DnDaesfcF2beJRok9+iXK2nzq7bZ0b9THoToapmLIzupEhgUaHH7HnoGeTdP3DaEywHcggABU0HmliRTZyN7H7R1r3/+kG+0kFi3lTd9jF0p3cvF3Li+Cn2EFZ/VFJgw6/bFys8GBifmpI/IEOvWSvplNsS2LKZDsi2TOdasbkhjCUU0uZ7UTdrbOyFcsg4syvbTnl+IUApb3gREm6QYXuEODVHfVckRyLg3D9qe0KLGVApqoBp8lKM4mH4R0NFx99V+yfXDXjgFkuPKQ1Hy/GIaVXQ0fZCJ3uOSuVNR0O7T3LFHATBFf07sEOpCpLMkU6a7jfU4070VKRzw/BCLHO/ix7oA86cJLdxLkzvPthSksj4FGm4WjdXp/W7ANb+zxC9ucxS815ZpNtP511aPuwhuDJOf6frupbjQaNoCXe5LSCjgn+/BKLSBI0AgK2/hGmFrrHOfFMpckEAd+HXGwfIedW7AZXABItGwqTrkw8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199015)(38070700005)(86362001)(36756003)(66446008)(66946007)(76116006)(4326008)(66476007)(64756008)(66556008)(8676002)(2906002)(91956017)(54906003)(6916009)(316002)(186003)(122000001)(38100700002)(82960400001)(478600001)(71200400001)(26005)(6486002)(6512007)(6506007)(5660300002)(7416002)(4744005)(7406005)(8936002)(41300700001)(2616005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alFEUzNLcEhhcWFHRzIxVW1EZDRMaUxhR1ZEbVgyMjRSVnJRc0QxQ0lGbEtt?=
 =?utf-8?B?YVRGQkZYUER6TWRMSXdsS082QWJlSlpYMnlIS1VGZkNaWmUwb0pNQ243MlVn?=
 =?utf-8?B?SStKbUJrSEZnRHM4Y095V1pxZmdsdWdzQTRRc2VpZm5iYVVxUTkyOG1iMkxp?=
 =?utf-8?B?Q2R1R3BOVzE1WnJtOW1Xbk14UzFabUtHbHB5b1E0RHFJVWtFSmxOamRQT3U0?=
 =?utf-8?B?ZmxUQkYybU03cWE0SVRMa2ZEcTZqNE51cmpSanhJTFcxZW84Y3FZOTFHZW5V?=
 =?utf-8?B?d2NKTUxDNGVLbUgyLzJTOHltSDN4cmR0VHBPdmppTVF4NXBQOVluTng3OUZF?=
 =?utf-8?B?WW02cGJOdTF4Myt4Sy9ndTRmaG1yMmV0dmtGL1hVNHoxUXJsYmJiTTEzS1lk?=
 =?utf-8?B?V1dYQXdzSEpGZk42U1p6OWs0TW9sN3FFSkt0dklvRU15OVArM1o3RU9iT20x?=
 =?utf-8?B?bCt4dmliOENlWW9XVlB6dDBvcE1rNGp4UHNjeEZsejNGV0k0NDRZQlBBQUMx?=
 =?utf-8?B?bi9NQmRGOU5hRjZPT01BbjJQRDByc3dzZkVhS2Z4clRsQ0JKNld0d0pTd3Jp?=
 =?utf-8?B?K0tybDlHOUtTSisxU2tPOUV2N1VPZjhVbDQ4TnVXQURNaVByUnJITm4ydnYv?=
 =?utf-8?B?NzlTTmdaWVg1Szg2cHByYzdWVldLS2tPWXUzK21LeWwrd1RUL2VQS0RvajRr?=
 =?utf-8?B?MXhCOHZBbHdGVTRrck1SWUNpL0g1ZUpPL09uUExXdkZJcUVQekZ0dVFvdGtv?=
 =?utf-8?B?bWJlSWpqRXd6eit2ckVGTHVnbnhxbnZYZTFtZ21oZllhcHNxMlFKams0U1lH?=
 =?utf-8?B?L05QeVVJWG43Q3dadFJ6NmlVTTlxWWdDNHBXNm1XbkRYWVhhRnJIS25iaXo1?=
 =?utf-8?B?ZkphdVNkRURQSGI1VjQ5ZFNJN1RQUEFJa0RpR0tqeEduM3hIdXNUZzFJN2d1?=
 =?utf-8?B?aSs0czJyZzFVSnhCTVpDU0FDQ0ZZRmdSSGhtdlRvM3ZnSDVpdWV0N0RBZGl4?=
 =?utf-8?B?ckZSNFkxdmN1eXE0VER0aG1FTlZpU3ZRcmxtOUNxS3huMG91VHJmMXRxbjhS?=
 =?utf-8?B?bWNJRlZhNXo1N2dDc3lGWUJrU3NiL0pYdEZsQ09GY0dlSnhuSjZRTTMwdEFw?=
 =?utf-8?B?MGZCRXdDOUI3cnZ0Sjc0a3RnYXlSWkRDcjA2L3EzY2VyaWsrbnRLektoOGRE?=
 =?utf-8?B?NVFyRytRdit3aXltcXJ5U3Q0TGlJdFVWUENiY1NCbUgrK2s0bW4ydVhNcmda?=
 =?utf-8?B?bjZXOW9vTGR4REZXcU0vQnliK3RtV2JPMTBVMUx5NEZxa2FuTDVobVhycXZE?=
 =?utf-8?B?cFFoc0ZvcEdkbHc1Sm9uYnhYYS9IOWtJbVluNmFTQ2dRVHJnb3JrQTVKaDkv?=
 =?utf-8?B?L1FJWEg2amxmQnNRb3ZJS0NmcGJ0dlhpMm9yNEZCZmpUYjhCMGVRdzBwdFM3?=
 =?utf-8?B?WWxVcUlxY2EvRU1YWkswZC9FOHU0TDAwTXVRSjIrNlJZYzdDOW9XOFFzVW5U?=
 =?utf-8?B?aEpVc0p0cndlN2pXTHVqUGxqLzViN1BLcVdabUxYN0k5QUk5WjlCa1ozMmVl?=
 =?utf-8?B?eU1jYm55T1BlWm1ObUNiL1REUDhkK0ZYbVQzYi85OG1xQytyTTUvaDdrNFd4?=
 =?utf-8?B?bFdBSXhPd0I4UkpKeitiSWs5OUw0cE5yZ3ZOTXlpVVV2K1ZPdmhzaVBkOXZG?=
 =?utf-8?B?YU9zUkx1ODhGRUtQUWVUd3EvY2l6cmN6STZ1dDJSZ2xVZThMblhLYmE1SzFZ?=
 =?utf-8?B?Zy9XWGNNdXdtQ3dOeXJ4V29ONlRHY0piT1cxMVU4S1F3YTY3eUo3ZmNKNjJ3?=
 =?utf-8?B?YjMxZ1IvZHcveDlyejZiaDB6bW1QRk9rN0hQcFUwOVc3L2F5clpxcVpCSWJV?=
 =?utf-8?B?cXdaV25FbXZaM3oxT2dJY0lhT3pQVG9RU3VzUTdLMUgxZzR4YzhkUGNEYWly?=
 =?utf-8?B?TEtYbUxJa1BNQzlFN1hISTZMUy9Wbzc4RGFrUitLWndkMGR3WGVSS0RBUHhV?=
 =?utf-8?B?NzZ0SmhZL0RBanhEZ0FJV0tFTitMYk41SzEzSHgycXltQnljVjNOUGM5MEF1?=
 =?utf-8?B?NDlvMVNZbHFqbGVMNkhDeVo3R3JEKy9IbjVVUTNGVzVVNDQyaWFuL0xidW1E?=
 =?utf-8?B?ejJOMWZqWEdRRG52aTZnZkZndGRkbFA4TFgxN216dVMwTkxwUUU4MGF3WWxk?=
 =?utf-8?Q?+YFf8i80ElfemiK3UhnAEic=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <54565ECAC90309499F4ECE8FE362E4A8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c507653d-d795-45df-2cf7-08daa578fa3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 19:53:43.9030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SQ6MkX9PHrXzWNo/hpGg1ejzAE/REYjV+wOcaeKX5tdmGI9CdYkI9gJe5EVbA8Cy18+R0lDsbBQGJORd/jBg/y7Fv84O0HNLKrXL5cp3Mi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5202
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTAzIGF0IDE2OjQwICswMzAwLCBLaXJpbGwgQSAuIFNodXRlbW92IHdy
b3RlOg0KPiBIbS4gU2hvdWxkbid0IEFSQ0hfSEFTX1NIQURPV19TVEFDSyBkZWZpbml0aW9uIGJl
IGluIGFyY2gvS2NvbmZpZywNCj4gbm90DQo+IHVuZGVyIGFyY2gveDg2Pw0KPiANCj4gQWxzbywg
SSB0aGluayAiZGVmX2Jvb2wgbiIgaGFzIHRoZSBzYW1lIG1lYW5pbmcgYXMganVzdCAiYm9vbCIs
IG5vPw0KPiANCj4gPiArDQo+ID4gK2NvbmZpZyBYODZfU0hBRE9XX1NUQUNLDQo+ID4gKyAgICAg
cHJvbXB0ICJYODYgU2hhZG93IFN0YWNrIg0KPiA+ICsgICAgIGRlZl9ib29sIG4NCj4gDQo+IE1h
eWJlIGp1c3QNCj4gDQo+ICAgICAgICAgYm9vbCAiWDg2IFNoYWRvdyBTdGFjayINCj4gDQo+ID8N
ClllcCwgd2lsbCBjaGFuZ2UgaXQuIFRoYW5rcy4NCg==
