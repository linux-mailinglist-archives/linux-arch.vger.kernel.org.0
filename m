Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F16A62AE3A
	for <lists+linux-arch@lfdr.de>; Tue, 15 Nov 2022 23:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiKOWYd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Nov 2022 17:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbiKOWYc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Nov 2022 17:24:32 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5311431C;
        Tue, 15 Nov 2022 14:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668551071; x=1700087071;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ioYse4mj8s6ql91TK5HvgW9IVOaDW+UiLOF39SY++Cs=;
  b=LY5ayog8ZnVXlzEugZsHNL3N4SPjSybjdrpR4zog6oYmG7LRZoSWacRm
   oULDFcu0hho1E5cK5sxDTHVUdsixppGpdnuxUCyOp0dkK7UHFU0xKxgSP
   qt8vjwj/r7gu7pTFHLHbmWMXVJLxyAyKOiZ/LSMZbGp/GaFgx6Cvj/4CD
   ujlVC909tEJbG/6aECwCBdVY32uPhppdtkkpt/NyTwTCQCZE67urA+w+X
   OAfpRKv6cto0h8pNAawocQE0yfYoVa3RdQatZjQnzM6EmfNyl72/w49CP
   WZ4q9UfR52N+xVXJa22gautRr8rFUqKd1KjInS4D41xVn9lds3i6MzVPW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="292092323"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="292092323"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 14:24:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="764082978"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="764082978"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 15 Nov 2022 14:24:29 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 14:24:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 14:24:28 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 14:24:28 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 14:24:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TanwpsY/5vBHxvGvLeugxbJ+LUa44z/pHS7LBuy0jmkgsBFMyczGaSiRsRnPCYOz/0WtOrE5ryMQTUIadA00RyKulrYkapdEu0RjrXhZ+jRsl9NNHT0X6MpkFvxgOfIgK0bXQTXnYp8nIheSTVGSpgPeSrzYnPfr0J1QRN7snkrMuMno8solDWBLpZixME4IAV2PzoQF04Y9Nm0ukt/zEhiK+fhmo2FYJLB/wksNYmIKyTy7m6nLnSjfCBkqeT27Ap5bCaRaW0NR0/bsJnQFYQo+M18F7RhVv0y2MADCf4PTgcZnghbYoM2bhB7JrFku86su20OMYcrJ7SuUfSX2gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioYse4mj8s6ql91TK5HvgW9IVOaDW+UiLOF39SY++Cs=;
 b=PLPgLa4BKyg2HXZ2D8AOvyVK3nk6BgHG5tqnVmg73k2gbAz8Mr5WSwKJOeptWlceEFfJKtsGqMMONK0JYDb2ZAWWM7ncQNT4Lh1Aau9dCGK4/DQBkzZd5GnZseItPQyccbCFrjCmAddotD0TrRghAEcCbe4Fmo56iRuDMA8qjHnKpr8Qvsv7sAjK9J2CxKmXEcTKmTpyQu4EZMTBc5fIK/5UpfGYgoFIcJAKTFPPI40Trj4ezPkFtVWQQVCepnD+NCE+4h2gkZs5jHzTBGRD5RDgIW9pFcGQIIhefvSUuosyJH9Wnxfm03cV/j3q+UqySP3bSc86p4ZH2imgAaiyQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BL1PR11MB5509.namprd11.prod.outlook.com (2603:10b6:208:31f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 22:23:47 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3%5]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 22:23:47 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>,
        "Schimpe, Christina" <christina.schimpe@intel.com>
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
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
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
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 35/37] x86/cet: Add PTRACE interface for CET
Thread-Topic: [PATCH v3 35/37] x86/cet: Add PTRACE interface for CET
Thread-Index: AQHY8J5eaXgH6xugZk20MwPZdy8SOK5AIA2AgACAkAA=
Date:   Tue, 15 Nov 2022 22:23:47 +0000
Message-ID: <223bf306716f5eb68e4f9fd660414c84cddd9886.camel@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
         <20221104223604.29615-36-rick.p.edgecombe@intel.com>
         <Y3Olme4Nl+VOkjAH@hirez.programming.kicks-ass.net>
In-Reply-To: <Y3Olme4Nl+VOkjAH@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|BL1PR11MB5509:EE_
x-ms-office365-filtering-correlation-id: 001f3729-9d39-4b5f-a7c6-08dac75810aa
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: waIiemWBgBObRbNrChWwbHLblsw5FXab1zMAST/6NNNEWbUTi3bqLi7jGrYtXilo28COE2Ww9pBGojYwraqkqb/G7okGZc8GJxIQcj/Wsf3CTJO7ZD55Xpdyzmy+asTxT8KZxBKxqAg7Qwija0eOI70dGbnBZ1AZstVGZBL7OQwAAma+i3vv6nCUJADfPDim36VKmLR9cBQLzZMXHzE95INkZjGqyAWD3686/9gXhh5jakMMPKUzIK5fvrpNv5t05hxF7+mMQbtI2Tz06C0NV+6WebhqiatW8xJOfYNbIvV0SAUpEEpeM1KvDDhPI41eN2LRTsncCl/QoQ/CUEBSuqZ+PpPe9hkSa5WRq1gu2HoqtoGQvkc4FW2NRIkD5RGDqkDeZVpz6DmUgq4OPkvluDAGeZ+BUNOIDtz58XpcWW6k68yPJ/yx5qxJxHPIHzcpLPTp1kjdzXq2NTE7z9Sr3o3NuwGtSh099N9vlm4p/NWc5rWvOAIzNgthLgYm8mRw9EkbjAfVhKtSV5lDBKnh817xnjOJhGqAc1rvb0dQS0Op+k80kr9rTxS58Y1KkFvddbN9akFSdpVI8mHMJYcwX0ohWamT506TcUfPVG/Vms802gRbVeGEIAfN1NG1/g45BG4oOSxNaEGsle/qzwJMOIXDh0VPrYd+xKMANMZhM78C9FF87192Dn04IIdt8GLzfVjC9ovQCqT04HEX5iFCvi7aWn0YJf3iBmYq5eH3jcTZ+cZYNZh233HnijwjYnUdv1c4Az/+sH0WoiC6SN5gBEOlY7sCvpW38F9wYaADZW8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199015)(5660300002)(7406005)(7416002)(71200400001)(41300700001)(4001150100001)(2906002)(6636002)(110136005)(8676002)(66446008)(64756008)(66476007)(66556008)(91956017)(76116006)(66946007)(316002)(6486002)(54906003)(4326008)(86362001)(6506007)(83380400001)(186003)(2616005)(478600001)(26005)(6512007)(8936002)(122000001)(82960400001)(38070700005)(36756003)(38100700002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHJuOWNiM3ZjOXczQmZnWGJxREloMUdhUUtCSUIzc2ZLSEJlNlJXcFU1ckE0?=
 =?utf-8?B?bnlHRkoyWXRiSFgzbDJBRS9TYldXZkJhQnkvaUFidDIwTFBieTRobWNPVGpy?=
 =?utf-8?B?TkNXRW9UK3FUZzNSNlVYM2dQai9qTXQyb1pMWVNneGVYaWgxZHFPeTYreTNj?=
 =?utf-8?B?OXhpQUVVYzZkeDV3SkFjbTBHTnc4R2tQTW9TZlFjNUM2WW1mcE1ZcjNySE1T?=
 =?utf-8?B?aFVER0NFY2JRbnNrM2hFbVY5a2tnMTNKQnNYSFdadGY2aERhR0lmWlVsY2JE?=
 =?utf-8?B?amRhNUVRUGZ6WFJiaUY2a3JFbmhWanFqOFltVlJCdTJQYS9ZREFYM04rVDVY?=
 =?utf-8?B?emsxWnJLRkhqZVAvdlFZd21iSTVxR1lwL2REVXcrTXAvZDNRckhOSnNlcTJx?=
 =?utf-8?B?RTkzSHZ5ZUlGaUJZbFV6MmpockRDbFJlS1VybUUwMEJpSWlYSjBZb25BMW5J?=
 =?utf-8?B?bm5MMEZrVDE3MWVpNEdCU0xsbWVYMENWbHZ0ZDZ4cXBGZGx4a0lMdGlJM3Nq?=
 =?utf-8?B?VlFMK0Yyek1GOWJGVTRuUW5qSjlYMWRBSzZwYnE5cDRmVFVsbXhhMEpiS0Nm?=
 =?utf-8?B?QURSL0ZSMUgvVnVCZjZVTXZRMHZnSi80YWJyYk02clZGSTgxamZpWmw2TXlH?=
 =?utf-8?B?YlVOT1MyQlFFMGlUUi81bmdVOWhvV1Y2MTk0ODg2Z2hWZ2pkcEw3bVdPaUdG?=
 =?utf-8?B?MHZneEx0L2FweEt2ckIwWDYzSGkxTlg0SnRranlTUE5PZFZHVDZPRGFOQzlO?=
 =?utf-8?B?VlJJMGVPOXRrbUExMjltRi9EKzUybHllTkUzblVLa0IyYUovaHI0a0NmTlhT?=
 =?utf-8?B?WTVHVVpMczlhTUUvNnhIbHZuZTNZQkNsTnlRRlRxaUJpZ05xbkFOZXA5b1Bj?=
 =?utf-8?B?Z3kwZkpvaVB3Y1QrVmZ2ZCttekpmNjF1TWZMcXdMR2VtaWpRNEpsRjRxZndU?=
 =?utf-8?B?WmUrM3Z4c0FSWFNsL3lUZXJWOFRqQjE2c1AwaEVoTW9MdnJoUGc5OHRpb2RB?=
 =?utf-8?B?eGNNbjQ2RS9CaUFHSmZFM3ZtSkFWTzE3bWl4SVo3Yld6ZzVTZTlLb09pem1F?=
 =?utf-8?B?d25BUWNBeWJUUk9yUHY0ZUJVS0IyeklWQVFzelowYSt4V3E3bTB3SWtxa2R5?=
 =?utf-8?B?YnZOMXJoOC91SmIvWTVnd2F4SVVWc0N0K0pFc1hsSlF5TWFvRjdQb3lxdG1F?=
 =?utf-8?B?dSs0UkRwMlc5VE9YUUUzcUt1TlYwejVqeWtmVHFkaGRBeE8yZDh2Zy8vK3Nm?=
 =?utf-8?B?UzlqWXdsclA0T3FUMUJmVjViMTV4aVFNV3R2dTdFN3k3WmJuM2tyRUp6V0RZ?=
 =?utf-8?B?VFFINktjM1NTWlgrOE8rVUFZMzlnbTc1VXJERFRYVEtQb0R5TXJ5YWduSWR3?=
 =?utf-8?B?TUdua3pGT1R5Tk0vRzJhdGhING9iOW12UFF3NVVySGltdXpWRXU2cVRoVVFC?=
 =?utf-8?B?eWY1VDJOelhHT2FaQjZtSTlRQmZQNXNvSVNqaWNHdXlidTc1Qlk4L1V0Nkha?=
 =?utf-8?B?WHZKWlZ1NFVJc1JoTXZSUEczaVRBOFkyeGdSN1ZOQlVYZHZUK0gwT2lmOUtQ?=
 =?utf-8?B?Q0ltTkpHMklDS1N3bXFZdmRZSlZYeHl2K2psZmFFRk53MnVlNmlxU3MvNGNl?=
 =?utf-8?B?b3dNc3Rab3NlREhWNHdsWWF0M0swY2dtTXdJeFJ1UGJqeFBqZ0tMMTZOSTZk?=
 =?utf-8?B?RnBiZ0JFYURTRGhXc055OVgwV2xLMm5CMVRoTU5QTC9wamplWjFSelhkdk40?=
 =?utf-8?B?MS8wSm5rTktzbWxpd0JtU1VkbExwSU5yL20xZkhHSS9walFUZjRKeUVuMWRM?=
 =?utf-8?B?NTIvYmpFR1pNRFhOOTV0ZHExeVdYTlNOZ0JKTFpwcE9uNk9JdG9NMmttTHVK?=
 =?utf-8?B?VUdoNm9HalYrYUdSWWZSZXVGek9iSXN1RGhtYzdmdDNReXNGbGNzK1pIbWlQ?=
 =?utf-8?B?YXBsNHB2dzJ4V2FVVU43eWttak5Gb3lCdWdsYjR6OFoyUnJBbWlZODkxNFhs?=
 =?utf-8?B?Zm5VNUM4MUJwa2Y3bG82ZW1sYlJxdGFWVFZPZFF6by9RbStWcXpCUFpQU3dk?=
 =?utf-8?B?NkVXUHlRb0VtanErendrSjIxK3l0S2U5cm8zcUNLR1ltK1JmQjRXK2pVVzVP?=
 =?utf-8?B?R09UcHV5RTdzaXlYRWpJM25hUWJ5bzFZaVJ0cHJqNGJUUncxdEZ4UHNITkN5?=
 =?utf-8?Q?k92IJdxfqlZGWlwdFV9x4CY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6316DAAA0206C4AA040A8F2BB2C0579@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 001f3729-9d39-4b5f-a7c6-08dac75810aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 22:23:47.6390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D7DNuxezfQpM7xEutN0bb5eIZluEvKCatAVLCcR/BDyjhUKEGq556NLJfsP6Rc1gbmg08eoT1wKKIWQLM2dN1YNAnMMtvfkjI0ef7/vaHxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5509
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

KyBDaHJpc3RpbmENCg0KT24gVHVlLCAyMDIyLTExLTE1IGF0IDE1OjQzICswMTAwLCBQZXRlciBa
aWpsc3RyYSB3cm90ZToNCj4gT24gRnJpLCBOb3YgMDQsIDIwMjIgYXQgMDM6MzY6MDJQTSAtMDcw
MCwgUmljayBFZGdlY29tYmUgd3JvdGU6DQo+ID4gRnJvbTogWXUtY2hlbmcgWXUgPHl1LWNoZW5n
Lnl1QGludGVsLmNvbT4NCj4gPiANCj4gPiBTb21lIGFwcGxpY2F0aW9ucyAobGlrZSBHREIgYW5k
IENSSVUpIHdvdWxkIGxpa2UgdG8gdHdlYWsgQ0VUIHN0YXRlDQo+ID4gdmlhDQo+ID4gcHRyYWNl
LiBUaGlzIGFsbG93cyBmb3IgZXhpc3RpbmcgZnVuY3Rpb25hbGl0eSB0byBjb250aW51ZSB0byB3
b3JrDQo+ID4gZm9yDQo+ID4gc2VpemVkIENFVCBhcHBsaWNhdGlvbnMuIFByb3ZpZGUgYW4gaW50
ZXJmYWNlIGJhc2VkIG9uIHRoZSB4c2F2ZQ0KPiA+IGJ1ZmZlcg0KPiA+IGZvcm1hdCBvZiBDRVQs
IGJ1dCBmaWx0ZXIgdW5uZWVkZWQgc3RhdGVzIHRvIG1ha2UgdGhlIGtlcm5lbOKAmXMgam9iDQo+
ID4gZWFzaWVyLg0KPiA+IA0KPiA+IFRoZXJlIGlzIGFscmVhZHkgcHRyYWNlIGZ1bmN0aW9uYWxp
dHkgZm9yIGFjY2Vzc2luZyB4c3RhdGUsIGJ1dA0KPiA+IHRoaXMNCj4gPiBkb2VzIG5vdCBpbmNs
dWRlIHN1cGVydmlzb3IgeGZlYXR1cmVzLiBTbyB0aGVyZSBpcyBub3QgYSBjb21wbGV0ZWx5DQo+
ID4gY2xlYXIgcGxhY2UgZm9yIHdoZXJlIHRvIHB1dCB0aGUgQ0VUIHN0YXRlLiBBZGRpbmcgaXQg
dG8gdGhlIHVzZXINCj4gPiB4ZmVhdHVyZXMgcmVnc2V0IHdvdWxkIGNvbXBsaWNhdGUgdGhhdCBj
b2RlLCBhcyBpdCBjdXJyZW50bHkgc2hhcmVzDQo+ID4gbG9naWMgd2l0aCBzaWduYWxzIHdoaWNo
IHNob3VsZCBub3QgaGF2ZSBzdXBlcnZpc29yIGZlYXR1cmVzLg0KPiA+IA0KPiA+IERvbuKAmXQg
YWRkIGEgZ2VuZXJhbCBzdXBlcnZpc29yIHhmZWF0dXJlIHJlZ3NldCBsaWtlIHRoZSB1c2VyIG9u
ZSwNCj4gPiBiZWNhdXNlIGl0IGlzIGJldHRlciB0byBtYWludGFpbiBmbGV4aWJpbGl0eSBmb3Ig
b3RoZXIgc3VwZXJ2aXNvcg0KPiA+IHhmZWF0dXJlcyB0byBkZWZpbmUgdGhlaXIgb3duIGludGVy
ZmFjZS4gRm9yIGV4YW1wbGUsIGFuIHhmZWF0dXJlDQo+ID4gbWF5DQo+ID4gZGVjaWRlIG5vdCB0
byBleHBvc2UgYWxsIG9mIGl04oCZcyBzdGF0ZSB0byB1c2Vyc3BhY2UuIEEgbG90IG9mIGVudW0N
Cj4gPiB2YWx1ZXMgcmVtYWluIHRvIGJlIHVzZWQsIHNvIGp1c3QgcHV0IGl0IGluIGRlZGljYXRl
ZCBDRVQgcmVnc2V0Lg0KPiA+IA0KPiA+IFRoZSBvbmx5IGRvd25zaWRlIHRvIG5vdCBoYXZpbmcg
YSBnZW5lcmljIHN1cGVydmlzb3IgeGZlYXR1cmUNCj4gPiByZWdzZXQsDQo+ID4gaXMgdGhhdCBh
cHBzIG5lZWQgdG8gYmUgZW5saWdodGVuZWQgb2YgYW55IG5ldyBzdXBlcnZpc29yIHhmZWF0dXJl
DQo+ID4gZXhwb3NlZCB0aGlzIHdheSAoaS5lLiB0aGV5IGNhbuKAmXQgdHJ5IHRvIGhhdmUgZ2Vu
ZXJpYyBzYXZlL3Jlc3RvcmUNCj4gPiBsb2dpYykuIEJ1dCBtYXliZSB0aGF0IGlzIGEgZ29vZCB0
aGluZywgYmVjYXVzZSB0aGV5IGhhdmUgdG8gdGhpbmsNCj4gPiB0aHJvdWdoIGVhY2ggbmV3IHhm
ZWF0dXJlIGluc3RlYWQgb2YgZW5jb3VudGVyaW5nIGlzc3VlcyB3aGVuIG5ldyBhDQo+ID4gbmV3
DQo+ID4gc3VwZXJ2aXNvciB4ZmVhdHVyZSB3YXMgYWRkZWQuDQo+IA0KPiBQZXIgdGhpcyBhcmd1
bWVudCB0aGlzIHNob3VsZCBub3QgdXNlIHRoZSBDRVQgWFNBVkUgZm9ybWF0IGFuZCBDRVQNCj4g
bmFtZQ0KPiBhdCBhbGwsIGJlY2F1c2UgdGhhdCBjb25mbGF0ZXMgdGhlIHNpdHVhdGlvbiB2cyBJ
QlQuIEVuYWJsaW5nIHRoYXQNCj4gbWlnaHQNCj4gbm90IHdhbnQgdG8gZm9sbG93IHRoaXMgcHJl
Y2VkZW50Lg0KDQpIbW0sIHdlIGRlZmluaXRlbHkgbmVlZCB0byBiZSBhYmxlIHRvIHNldCB0aGUg
U1NQLiBDaHJpc3RpbmEsIGRvZXMgR0RCDQpuZWVkIGFueXRoaW5nIGVsc2U/IEkgdGhvdWdodCBt
YXliZSB0b2dnbGluZyBTSFNUS19FTj8NCg0KU28gaXQgbWlnaHQgZW5kIHVwIGxvb2tpbmcgcHJl
dHR5IG11Y2ggdGhlIHNhbWUsIGFuZCBpdCB3b3VsZCBqdXN0IGJlDQpyZW5hbWVkIGFuZCBzZXBh
cmF0ZWQgaW4gY29uY2VwdC4NCg0KPiANCj4gPiBCeSBhZGRpbmcgYSBDRVQgcmVnc2V0LCBpdCBh
bHNvIGhhcyB0aGUgZWZmZWN0IG9mIGluY2x1ZGluZyB0aGUgQ0VUDQo+ID4gc3RhdGUNCj4gPiBp
biBhIGNvcmUgZHVtcCwgd2hpY2ggY291bGQgYmUgdXNlZnVsIGZvciBkZWJ1Z2dpbmcuDQo+ID4g
DQo+ID4gSW5zaWRlIHRoZSBzZXR0ZXIgQ0VUIHJlZ3NldCwgZmlsdGVyIG91dCBpbnZhbGlkIHN0
YXRlLiBUb2RheSB0aGlzDQo+ID4gaW5jbHVkZXMgc3RhdGVzIGRpc2FsbG93ZWQgYnkgdGhlIEhX
IGFuZCBzdGF0ZXMgaW52b2x2aW5nIEluZGlyZWN0DQo+ID4gQnJhbmNoDQo+ID4gVHJhY2tpbmcg
d2hpY2ggdGhlIGtlcm5lbCBkb2VzIG5vdCBjdXJyZW50bHkgc3VwcG9ydCBmb3IgdXNlcnNhcGNl
Lg0KPiA+IA0KPiA+IFNvIHRoaXMgbGVhdmVzIHRocmVlIHBpZWNlcyBvZiBkYXRhIHRoYXQgY2Fu
IGJlIHNldCwgc2hhZG93IHN0YWNrDQo+ID4gZW5hYmxlbWVudCwgV1JTUyBlbmFibGVtZW50IGFu
ZCB0aGUgc2hhZG93IHN0YWNrIHBvaW50ZXIuIEl0IGlzDQo+ID4gd29ydGgNCj4gPiBub3Rpbmcg
dGhhdCB0aGlzIGlzIHNlcGFyYXRlIHRoYW4gZW5hYmxpbmcgc2hhZG93IHN0YWNrIHZpYSB0aGUN
Cj4gPiBhcmNoX3ByY3RsKClzLg0KPiANCj4gRG9lcyB0aGlzIHZhbGlkYXRlIHRoZSBTU1AsIHdo
ZW4gc2V0LCBwb2ludHMgdG8gYW4gYWN0dWFsIHZhbGlkIFNTDQo+IHBhZ2U/DQoNCk5vLCBidXQg
dGhhdCBzaXR1YXRpb24gaXMgYWxyZWFkeSBwb3NzaWJsZSBhbmQgaGFzIHRvIGJlIGhhbmRsZWQN
CmFueXdheS4gSnVzdCB1bm1hcCB5b3VyIHNoYWRvdyBzdGFjaywgYW5kIG1hcCB3aGF0ZXZlciBv
dGhlciB0eXBlIG9mDQptZW1vcnkgYXQgdGhlIHNhbWUgYWRkcmVzcyB3aXRob3V0IGRvaW5nIGEg
Y2FsbCBvciByZXQuIFRoZW4geW91IHdpbGwNCnNlZ2ZhdWx0IGF0IHRoZSBmaXJzdCBjYWxsIG9y
IHJldC4NCg==
