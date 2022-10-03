Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9626F5F369E
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 21:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiJCTqe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 15:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJCTqc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 15:46:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D0518355;
        Mon,  3 Oct 2022 12:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664826391; x=1696362391;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=z9Cy+6mmlRlJ4jZN6RWgGxWTk5LNnt7eegKfvm57UeQ=;
  b=Y5aExS41GDdTS6rEHVntO/ey+1JKRLQYB2MSlt2ACej+GL1LQJkKAScY
   otSkN6gaeVxdfVyvZX/9hSN/LUB0hEOzjctivgnlYUYOfFqB6DF9T4VhS
   Jh8OecI745Hp5ufMC9Xz5c1xLRi9kfctb0dSrcrM7WsuvUyuvTH8uhw6E
   wyYjPUOCGxUH4rh0df0V1WKSZW2w7Zs40zTP0gBb/Y3FGb+Z581egXKlU
   I1XB0lhv00IHC/K1oQTAeJZtZznuJefjJbBL4WUTZhw2siJF4NNnI1ErE
   ttlRrP1CjcrdCnZhJkkqcUublHnsxD4R1JoirdhdO8hkvB4/gSv/qKfUh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="302722940"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="302722940"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 12:46:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="712752792"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="712752792"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Oct 2022 12:46:22 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 12:46:22 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 12:46:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 3 Oct 2022 12:46:21 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 3 Oct 2022 12:46:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrQnKqQsEYX5x14JWvlmaRVB8lfpaXNNBZj3EZZKGlqq9SNSbl6ZEJb3TrznWq2ochwZKZaBfjIIRIaoCO3Yg6Un22ZQ0vyCyPn6R5Y+Eobq38c2e4/av83wiYpn7bQ8jXAMG4odNkB2lzTOeg4Vwb1zN4PGCARQaDsfH+qHo0gTyptsb4lGYTYsMU6mZnl0tkukzfAu/mRMHCcechPPwUKDDuZVO2Uj8ZAq8wT330evei/mroX9NNPIMK3lZwV8l7E47aLJ2d7yKjqvGaWfaKG2gfp6dWPQnsWd1sqHxLDm8fs2ZvyzDiLApfr6sR99EZmk3oKptTa1fi2QtzXomw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9Cy+6mmlRlJ4jZN6RWgGxWTk5LNnt7eegKfvm57UeQ=;
 b=etgyuC1GydBdI+hHDzy1TW8gKmH+OqIyyv/ggxIHfe1dFr/gG46mLpDggInDqWeGofdJ73q9aX/7LRmVdroS9EuabVD4r7LOSQCODTxDA+bnJtD/B6VRTqujqA1qwCSQfXfQgdL0wmLaaQ8bcKSpgjXCCRgm6xLI8QmFGspOo/d5+GWXPI3XSRYq4BLXj8jzFnIXafaZJyhSo6ygsnkneJyxJ9yaQlsuBNtds8Exyzjn20dxR2R96GLUCnqwqfcJKIbBnVBtI95xhV3iX1vszJoG9JonC1Qtgrv4J2iwWXhVK5ctocNAHKKAl8+swCVQVLC7csyHItD6lWIhe9FDIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CO1PR11MB4915.namprd11.prod.outlook.com (2603:10b6:303:93::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Mon, 3 Oct
 2022 19:46:13 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 19:46:13 +0000
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
Subject: Re: [PATCH v2 01/39] Documentation/x86: Add CET description
Thread-Topic: [PATCH v2 01/39] Documentation/x86: Add CET description
Thread-Index: AQHY1FL/9ZOrfh44YkS3ARV6MT/4g63875GAgAApX4A=
Date:   Mon, 3 Oct 2022 19:46:13 +0000
Message-ID: <cff1fe97abc10fa19078ed3b9a1e3e2c5f133df7.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-2-rick.p.edgecombe@intel.com>
         <202210031006.02C79ED58@keescook>
In-Reply-To: <202210031006.02C79ED58@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|CO1PR11MB4915:EE_
x-ms-office365-filtering-correlation-id: dcfdf939-8292-4b19-ec7a-08daa577ede3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TVAjHUshglQ4kXy9FLo87RxKXTWk4hTfM0WMxH1KdKE8b4ktcNZLU+r02/Er6/EY4n390uVoXNsNZAxq7+gh1Uqquze7R/gB/lx6Y9wgqUTDPxf5+ilQw1xbQ8UK0x7ec/3JgxibgcZI6Lo9uKIA3ETNtcLtP99vVz83kwD4NVFjjA9aZw4nbXTtHvCj8KDlH8mlGqr+LbkvPqsijAPXuovKkqYwe/0vrxvykoArldP9ut/9F9ij89ZZfkF3RE6mP7P0DHF4wlio3z9Sam6iY3Hhec2x7/QUnObpM+A+KYSf0i2GXf0/5ULCc97FNmTexis3IRKENAi4r0akyxdWgW8jFj5PhGxkfxmewsMKTuUp1pOcreI2UX0uUUdisuYulnBucZNiacUFtXLROjbEB9H4/oMxTuB03q7TtVYrn9t9/MPkuk1m6+048oUZSODN0BuTI+rK1DOE1kI9YsMWhhPjA3atKgmvz8bFSPNRhz2o/aSH2piG1LCsDnTRGHn8gnFg9MMhQDD2HiIEG6KA0hddxITr3i/dmwIhvzEBAi9tV43Ugb8h2pXlWi5pY2Hlwu+GHugv8i4fsqwaOhQR1uA6dH1D7BZWsQXHwQLoUaZE4/xJW/cpGbsgwjeYmoiDyvyLAKa6jgirWMVVYj9l//wqAfHytgh88I+rzEu+fTXV49/bGyj5VBKG4BKmnpOhlaExFwwxikrPanwHJyaCsPXA8IZuKJ94za9wR1FX+0lgLXIvpG0rlIxI9UHaMvoJoGF0YWu8ypvw+HyrNufykI7j97PDnMshMavCnYSbSl8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(76116006)(6916009)(54906003)(26005)(6506007)(91956017)(2616005)(186003)(36756003)(6512007)(316002)(122000001)(38070700005)(2906002)(5660300002)(8936002)(82960400001)(7406005)(7416002)(38100700002)(41300700001)(86362001)(83380400001)(6486002)(71200400001)(478600001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGRsVmpSaGhzTTAwYm5zQWpaNEEyQkpKTm82ZXNCYk0zOEVrVDlhbmNOT2t6?=
 =?utf-8?B?eUxUUGZINktad3ltSThQNnRnYWowU2V5SW9tLzFjeFc5VDl2NlZwbytxa3Y2?=
 =?utf-8?B?SThCQ1VKR2JraDcrd2llWlpCTjEvakhMWkt1T2tpbDBXQy9OL2pNcnNmek9B?=
 =?utf-8?B?aFhmcnZMSm0xRGwvNDRFYmVBTXZDdUp3T3hneForS3ZtTE1reUVMOFg0RHll?=
 =?utf-8?B?d3lVdHM5TUJkcW11RUdRN0R4cnhDeGV4TVJvOGdacnVpZ2x4SjJNZjV6WWlZ?=
 =?utf-8?B?WHQwZVpVdWJXb05QU2w0Uk10SFZCN3gyRnlJM3hIS3U0cGFON3lESHRMWGtZ?=
 =?utf-8?B?WlJLdXM2UFhnTExYbmdvS1FlM1JsdnFJNU4xWjFwc2E0MXJhK2ZWS3VwYmp5?=
 =?utf-8?B?bmwrTDcxeFBOK3VkaGtqUy9nY0l4MFlYVXNyc0tYeUxqUWRHNXZvb1ViRWlu?=
 =?utf-8?B?TDloc2lZUDRvZGlxbDlpcHJFNUxpQ1NJcGhRK1dMN1ZYN3hnYU5nN0E0KytH?=
 =?utf-8?B?VVRvVkxFUmZjUzJ2THZTV3JoQStHdG4wUE1sSGhoM0ZwVGtQclZvUzlCWTBx?=
 =?utf-8?B?NGdXejN4SncwMExoRW9IYmc3LzBPS0tLMGRLM1hhUnZvYXVtQ1l4V3RPNjg4?=
 =?utf-8?B?RXNIUVllMUJiVGpMVWpjQWk1TUU2eENTSjJOVDZ1OEFsZFRKOFRjaW5rSmJI?=
 =?utf-8?B?ZVdpWU5kZEIwWlpLWklnbVVFWkZCSGVpSFlMZ2ZpTFd5QkVDeS8zMGZBMUxn?=
 =?utf-8?B?QzRjWjE3SU1lTWhZcjEzeWdwMVJ2cWFBeWFEbS9aU0Z4TXhWSzNaOWIzN0di?=
 =?utf-8?B?MEVaK081VHdxcGZ2R1dKQ3hFa3VOWDg3MVc5VXpmcElEcEJWeGFzVWdqbDZu?=
 =?utf-8?B?cXlvbjJSM2EzQ1RFQmxDemE0eDVyUDFuWVUwai9VMkNIY2YzMzZKUW11UDN3?=
 =?utf-8?B?cjlBZnpCNVBxcjc0MnQ2VS9BRlQxVlUydHloZFJlNjROTVh6YVc3VEJwdzdy?=
 =?utf-8?B?UFk0SjQ5NTZGWFJrcUJIaVFuQ1gxYStOdGEvMFBUcndZRi9ISzMvNnNseVBO?=
 =?utf-8?B?RDhXTmNkQ2JMNGVjOGVKWGdjUS9lZ3VqZXBhMnZKbCt3aEpnZ3JaOTV1Wjhx?=
 =?utf-8?B?QlVHR0dCd2ZHbEpnUDE2RFptWEQ4cDd2dU9UOVdGTEVKS1hubmk1eU9XZ0pN?=
 =?utf-8?B?eGgrRkgrMVJRWmpPM1dvWW5xWWdBOHBMWmYxY25jK2F4ckF5YnU5MmRLUk5j?=
 =?utf-8?B?WTMxN1ZUVXQvVXJzMFN3TmFuOG9mRHRDMzJNeWJDZVJYWmUrdUZwZmxjc3Za?=
 =?utf-8?B?UWNseWsxOHFybFdOQVBDZVh2QnhHZWRuTFc1TnBYdW43cU9oN1p2TTQ4M0Na?=
 =?utf-8?B?M3lyWmMvM2lwS3pZNHRIWTRhb3dwZk91K2c5ZFlkNVg0MWlObkwzeDBkK0pp?=
 =?utf-8?B?bTNWVnplcDQ4dUsvMGFrVWpkSGVoMERrUjRQaWNnQVJTMjdoT1M4cUpVWjQ0?=
 =?utf-8?B?RnQxcEtQY203U0FJOElUMytHOEVOZ3E2UzFzMWR3YTlnUnNPNFlDcEFjYmps?=
 =?utf-8?B?Zk9QMDNHWmYvRm53N1gyMjhnYVZUQTZOOHJtU25uZ3JkRVF4RlU1WWt0Mks2?=
 =?utf-8?B?TmU0eFlmTG5DRWhvS1ZmUXVuMU5OVkhOREp5ME53WWpNeWhnQ05mY2ljMnFr?=
 =?utf-8?B?K040MVEvUHI4NWtTcytlWmVGekJmVWNrdXpwa2owWnFMUDNUL1RoU1cwWGhh?=
 =?utf-8?B?bDNIU0hPUzZTTFB3bmFUcnNEaVA3Z3FHWkNLbDZEVCtxeExYTE5yMklDSW1h?=
 =?utf-8?B?L2tyREw0ZDhZT0hkeHFiSldNZzZIMXdqQ2U0K0l3RGxJOHFRcEVteXFQZDZl?=
 =?utf-8?B?Q2Vjb1pWL0dLekcyWC9zZVVYdllxYWZUaUllcW8vNzh1N0hvUHIwak55YkRx?=
 =?utf-8?B?Y0VoRVNJczMvSEN6dGRQSEs0Wk12cFFGSTI5bmpFMC9iWVNwK0xpWDJkVzdH?=
 =?utf-8?B?L1BYdzRSNFFVcWQzRDlKRTR2TFBCMGRHd2tabldpakd2RkVUZTd3NzlwUFhl?=
 =?utf-8?B?RnRibkFIWEZ5cEE0YzhVa0R3MXZVSk5MU28vTHFpSmRMUGhOK0Q0V1VOejlH?=
 =?utf-8?B?MW1JWEdtZ2NhUXlBb0p2bkRoZ2xLcDQveUNJZG45MTRrcTFTQ1VIaWQyNUxP?=
 =?utf-8?Q?tf3WPiNAxtfTC0NNTGKeD6g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6AF1E582341854FBFC681114EA45E33@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcfdf939-8292-4b19-ec7a-08daa577ede3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 19:46:13.7018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r4/JqJigB08R4UjCnbhCcpdY5ZKiwqbmrE8S9hnWr2TdXCDYEvGujHyaJ3felQm7/niyVDwTSAAOWwGR4qBHpVIw4v77PFu66C51iY+hVSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4915
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTAzIGF0IDEwOjE4IC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IE9u
IFRodSwgU2VwIDI5LCAyMDIyIGF0IDAzOjI4OjU4UE0gLTA3MDAsIFJpY2sgRWRnZWNvbWJlIHdy
b3RlOg0KPiA+IFsuLi5dDQo+ID4gK092ZXJ2aWV3DQo+ID4gKz09PT09PT09DQo+ID4gKw0KPiA+
ICtDb250cm9sLWZsb3cgRW5mb3JjZW1lbnQgVGVjaG5vbG9neSAoQ0VUKSBpcyB0ZXJtIHJlZmVy
cmluZyB0bw0KPiA+IHNldmVyYWwNCj4gPiArcmVsYXRlZCB4ODYgcHJvY2Vzc29yIGZlYXR1cmVz
IHRoYXQgcHJvdmlkZXMgcHJvdGVjdGlvbiBhZ2FpbnN0DQo+ID4gY29udHJvbA0KPiA+ICtmbG93
IGhpamFja2luZyBhdHRhY2tzLiBUaGUgSFcgZmVhdHVyZSBpdHNlbGYgY2FuIGJlIHNldCB1cCB0
bw0KPiA+IHByb3RlY3QNCj4gPiArYm90aCBhcHBsaWNhdGlvbnMgYW5kIHRoZSBrZXJuZWwuIE9u
bHkgdXNlci1tb2RlIHByb3RlY3Rpb24gaXMNCj4gPiBpbXBsZW1lbnRlZA0KPiA+ICtpbiB0aGUg
NjQtYml0IGtlcm5lbC4NCj4gDQo+IFRoaXMgbGlrZWx5IG5lZWRzIHJld29yZGluZywgc2luY2Ug
aXQncyBub3Qgc3RyaWN0bHkgdHJ1ZSBhbnkgbW9yZToNCj4gSUJUIGlzIHN1cHBvcnRlZCBpbiBr
ZXJuZWwtbW9kZSBub3cgKENPTkZJR19YODZfSUJUKS4NCg0KWWVwLCB0aGFua3MuDQoNCj4gDQo+
ID4gK0NFVCBpbnRyb2R1Y2VzIFNoYWRvdyBTdGFjayBhbmQgSW5kaXJlY3QgQnJhbmNoIFRyYWNr
aW5nLiBTaGFkb3cNCj4gPiBzdGFjayBpcw0KPiA+ICthIHNlY29uZGFyeSBzdGFjayBhbGxvY2F0
ZWQgZnJvbSBtZW1vcnkgYW5kIGNhbm5vdCBiZSBkaXJlY3RseQ0KPiA+IG1vZGlmaWVkIGJ5DQo+
ID4gK2FwcGxpY2F0aW9ucy4gV2hlbiBleGVjdXRpbmcgYSBDQUxMIGluc3RydWN0aW9uLCB0aGUg
cHJvY2Vzc29yDQo+ID4gcHVzaGVzIHRoZQ0KPiA+ICtyZXR1cm4gYWRkcmVzcyB0byBib3RoIHRo
ZSBub3JtYWwgc3RhY2sgYW5kIHRoZSBzaGFkb3cgc3RhY2suIFVwb24NCj4gPiArZnVuY3Rpb24g
cmV0dXJuLCB0aGUgcHJvY2Vzc29yIHBvcHMgdGhlIHNoYWRvdyBzdGFjayBjb3B5IGFuZA0KPiA+
IGNvbXBhcmVzIGl0DQo+ID4gK3RvIHRoZSBub3JtYWwgc3RhY2sgY29weS4gSWYgdGhlIHR3byBk
aWZmZXIsIHRoZSBwcm9jZXNzb3IgcmFpc2VzDQo+ID4gYQ0KPiA+ICtjb250cm9sLXByb3RlY3Rp
b24gZmF1bHQuIEluZGlyZWN0IGJyYW5jaCB0cmFja2luZyB2ZXJpZmllcw0KPiA+IGluZGlyZWN0
DQo+ID4gK0NBTEwvSk1QIHRhcmdldHMgYXJlIGludGVuZGVkIGFzIG1hcmtlZCBieSB0aGUgY29t
cGlsZXIgd2l0aA0KPiA+ICdFTkRCUicNCj4gPiArb3Bjb2Rlcy4gTm90IGFsbCBDUFUncyBoYXZl
IGJvdGggU2hhZG93IFN0YWNrIGFuZCBJbmRpcmVjdCBCcmFuY2gNCj4gPiBUcmFja2luZw0KPiA+
ICthbmQgb25seSBTaGFkb3cgU3RhY2sgaXMgY3VycmVudGx5IHN1cHBvcnRlZCBpbiB0aGUga2Vy
bmVsLg0KPiA+ICsNCj4gPiArVGhlIEtjb25maWcgb3B0aW9ucyBpcyBYODZfU0hBRE9XX1NUQUNL
LCBhbmQgaXQgY2FuIGJlIGRpc2FibGVkDQo+ID4gd2l0aA0KPiA+ICt0aGUga2VybmVsIHBhcmFt
ZXRlciBjbGVhcmNwdWlkLCBsaWtlIHRoaXM6ICJjbGVhcmNwdWlkPXNoc3RrIi4NCj4gPiArDQo+
ID4gK1RvIGJ1aWxkIGEgQ0VULWVuYWJsZWQga2VybmVsLCBCaW51dGlscyB2Mi4zMSBhbmQgR0ND
IHY4LjEgb3IgTExWTQ0KPiA+IHYxMC4wLjENCj4gPiArb3IgbGF0ZXIgYXJlIHJlcXVpcmVkLiBU
byBidWlsZCBhIENFVC1lbmFibGVkIGFwcGxpY2F0aW9uLCBHTElCQw0KPiA+IHYyLjI4IG9yDQo+
ID4gK2xhdGVyIGlzIGFsc28gcmVxdWlyZWQuDQo+ID4gKw0KPiA+ICtBdCBydW4gdGltZSwgL3By
b2MvY3B1aW5mbyBzaG93cyBDRVQgZmVhdHVyZXMgaWYgdGhlIHByb2Nlc3Nvcg0KPiA+IHN1cHBv
cnRzDQo+ID4gK0NFVC4NCj4gDQo+IE1heWJlIGNhbGwgdGhlbSBvdXQgYnkgbmFtZTogc2hzdGsg
aWJ0DQoNCk9rLg0KDQo+IA0KPiA+ICtDRVQgYXJjaF9wcmN0bCgpJ3MNCj4gPiArPT09PT09PT09
PT09PT09PT09DQo+ID4gKw0KPiA+ICtFbGYgZmVhdHVyZXMgc2hvdWxkIGJlIGVuYWJsZWQgYnkg
dGhlIGxvYWRlciB1c2luZyB0aGUgYmVsb3cNCj4gPiBhcmNoX3ByY3RsJ3MuDQo+ID4gKw0KPiA+
ICthcmNoX3ByY3RsKEFSQ0hfQ0VUX0VOQUJMRSwgdW5zaWduZWQgaW50IGZlYXR1cmUpDQo+ID4g
KyAgICBFbmFibGUgYSBzaW5nbGUgZmVhdHVyZSBzcGVjaWZpZWQgaW4gJ2ZlYXR1cmUnLiBDYW4g
b25seQ0KPiA+IG9wZXJhdGUgb24NCj4gPiArICAgIG9uZSBmZWF0dXJlIGF0IGEgdGltZS4NCj4g
DQo+IERvZXMgdGhpcyBtZWFuIG9ubHkgMSBiaXQgb3V0IG9mIHRoZSAzMiBtYXkgYmUgc3BlY2lm
aWVkPw0KDQpZZXMsIGV4YWN0bHkuDQoNCj4gDQo+ID4gKw0KPiA+ICthcmNoX3ByY3RsKEFSQ0hf
Q0VUX0RJU0FCTEUsIHVuc2lnbmVkIGludCBmZWF0dXJlKQ0KPiA+ICsgICAgRGlzYWJsZSBmZWF0
dXJlcyBzcGVjaWZpZWQgaW4gJ2ZlYXR1cmUnLiBDYW4gb25seSBvcGVyYXRlIG9uDQo+ID4gKyAg
ICBvbmUgZmVhdHVyZSBhdCBhIHRpbWUuDQo+ID4gKw0KPiA+ICthcmNoX3ByY3RsKEFSQ0hfQ0VU
X0xPQ0ssIHVuc2lnbmVkIGludCBmZWF0dXJlcykNCj4gPiArICAgIExvY2sgaW4gZmVhdHVyZXMg
YXQgdGhlaXIgY3VycmVudCBlbmFibGVkIG9yIGRpc2FibGVkIHN0YXR1cy4NCj4gDQo+IEhvdyBp
cyB0aGUgImZlYXR1cmVzIiBhcmd1bWVudCBwcm9jZXNzZWQgaGVyZT8NCg0KWWVzLCB0aGlzIHNo
b3VsZCBoYXZlIG1vcmUgaW5mby4gVGhlIGtlcm5lbCBrZWVwcyBhIG1hc2sgb2YgZmVhdHVyZXMN
CnRoYXQgYXJlICJsb2NrZWQiLiBUaGUgbWFzayBpcyBPUmVkIHdpdGggdGhlIGV4aXN0aW5nIHZh
bHVlLiBTbyBhbnkNCmJpdHMgc2V0IGhlcmUgY2Fubm90IGJlIGVuYWJsZWQgb3IgZGlzYWJsZWQg
YWZ0ZXJ3YXJkcy4gQml0J3MgdW5zZXQgaW4NCnRoZSBtYXNrIHBhc3NlZCBhcmUgaWdub3JlZC4N
Cg0KPiANCj4gPiBbLi4uXQ0KPiA+ICtQcm9jIHN0YXR1cw0KPiA+ICs9PT09PT09PT09PQ0KPiA+
ICtUbyBjaGVjayBpZiBhbiBhcHBsaWNhdGlvbiBpcyBhY3R1YWxseSBydW5uaW5nIHdpdGggc2hh
ZG93IHN0YWNrLA0KPiA+IHRoZQ0KPiA+ICt1c2VyIGNhbiByZWFkIHRoZSAvcHJvYy8kUElEL2Fy
Y2hfc3RhdHVzLiBJdCB3aWxsIHJlcG9ydCAid3JzcyIgb3INCj4gPiArInNoc3RrIiBkZXBlbmRp
bmcgb24gd2hhdCBpcyBlbmFibGVkLg0KPiANCj4gVElMIGFib3V0ICJhcmNoX3N0YXR1cyIuIDop
IFdoeSBpcyB0aGlzIGEgc2VwYXJhdGUgZmlsZT8gInN0YXR1cyIgaXMNCj4gYWxyZWFkeSBoYXMg
dW5pcXVlIGZpZWxkIG5hbWVzLg0KDQpJdCBsb29rcyBsaWtlICJzdGF0dXMiIG9ubHkgaGFzIGFy
Y2gtYWdub3N0aWMgZmVhdHVyZSBzdGF0dXMgdG9kYXkuDQpNYXliZSB0aGF0J3MgdGhlIHJlYXNv
bj8gQ0VUIHNlZW1zIHRvIGZpdCB0aGVyZSB0aG91Z2guDQoNCj4gDQo+ID4gK0ZvcmsNCj4gPiAr
LS0tLQ0KPiA+ICsNCj4gPiArVGhlIHNoYWRvdyBzdGFjaydzIHZtYSBoYXMgVk1fU0hBRE9XX1NU
QUNLIGZsYWcgc2V0OyBpdHMgUFRFcyBhcmUNCj4gPiByZXF1aXJlZA0KPiA+ICt0byBiZSByZWFk
LW9ubHkgYW5kIGRpcnR5LiBXaGVuIGEgc2hhZG93IHN0YWNrIFBURSBpcyBub3QgUk8gYW5kDQo+
ID4gZGlydHksIGENCj4gPiArc2hhZG93IGFjY2VzcyB0cmlnZ2VycyBhIHBhZ2UgZmF1bHQgd2l0
aCB0aGUgc2hhZG93IHN0YWNrIGFjY2Vzcw0KPiA+IGJpdCBzZXQNCj4gPiAraW4gdGhlIHBhZ2Ug
ZmF1bHQgZXJyb3IgY29kZS4NCj4gPiArDQo+ID4gK1doZW4gYSB0YXNrIGZvcmtzIGEgY2hpbGQs
IGl0cyBzaGFkb3cgc3RhY2sgUFRFcyBhcmUgY29waWVkIGFuZA0KPiA+IGJvdGggdGhlDQo+ID4g
K3BhcmVudCdzIGFuZCB0aGUgY2hpbGQncyBzaGFkb3cgc3RhY2sgUFRFcyBhcmUgY2xlYXJlZCBv
ZiB0aGUNCj4gPiBkaXJ0eSBiaXQuDQo+ID4gK1Vwb24gdGhlIG5leHQgc2hhZG93IHN0YWNrIGFj
Y2VzcywgdGhlIHJlc3VsdGluZyBzaGFkb3cgc3RhY2sgcGFnZQ0KPiA+IGZhdWx0DQo+ID4gK2lz
IGhhbmRsZWQgYnkgcGFnZSBjb3B5L3JlLXVzZS4NCj4gPiArDQo+ID4gK1doZW4gYSBwdGhyZWFk
IGNoaWxkIGlzIGNyZWF0ZWQsIHRoZSBrZXJuZWwgYWxsb2NhdGVzIGEgbmV3IHNoYWRvdw0KPiA+
IHN0YWNrDQo+ID4gK2ZvciB0aGUgbmV3IHRocmVhZC4NCj4gDQo+IFBlcmhhcHMgc3BlYWsgdG8g
dGhlIEFTTFIgY2hhcmFjdGVyaXN0aWNzIG9mIHRoZSBzaHN0ayBoZXJlPw0KDQpJdCBiZWhhdmVz
IGp1c3QgbGlrZSBtbWFwKCkuIEkgY2FuIGFkZCBzb21lIGluZm8uDQoNCj4gDQo+IEFsc28sIGl0
IHNlZW1zIGlmIHRoZXJlIGlzIGEgIkZvcmsiIHNlY3Rpb24sIHRoZXJlIHNob3VsZCBiZSBhbg0K
PiAiRXhlYyINCj4gc2VjdGlvbj8gSSBzdXNwZWN0IGl0IHdvdWxkIGJlIHNob3J0OiBzaHN0ayBp
cyBkaXNhYmxlZCB3aGVuIGV4ZWN2ZSgpDQo+IGlzDQo+IGNhbGxlZCBhbmQgbXVzdCBiZSByZS1l
bmFibGVkIGZyb20gdXNlcnNwYWNlLCB5ZXM/DQoNClN1cmUsIEkgY2FuIGFkZCBzb21lIGluZm8u
DQo=
