Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4468B62A47F
	for <lists+linux-arch@lfdr.de>; Tue, 15 Nov 2022 22:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiKOVuD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Nov 2022 16:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiKOVuC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Nov 2022 16:50:02 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3360CF05;
        Tue, 15 Nov 2022 13:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668549001; x=1700085001;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+NYo6aZi7o7ZK0zIubUk50ZwJnXxFpeWtPwH879HNUU=;
  b=kkVU7cVyyKjRQXZnnbpIq7He1DYIR33kKtOAcBWe3/uHufSlV6BbVRSa
   +ThsW4N5cFaFFs7QzOSSGXD0ScaLOV9JJdJbUcyBFQdQBdcDIm2l1SoLW
   g7o2FAybIe68g4zUbXIwGTe6FuCOI4u7lleSjA7eh3HXi1RVSSaOf6yjj
   69/v3mP9GykoJlZW8OczBdpuT8Tzxe/wGZsa7djh2QszHxAOGfLl9kaa/
   HCFj7Z1bDLRMcuFPh+0zSax/nWqdcZPWR4+dU6VYr13RRqfieqOus65HI
   453J+ycdYdXz+SNkCWDQYrzzQcay2ai+fNtyCbNSfIvdSYv9i9UC7H3+W
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="295741909"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="295741909"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 13:50:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="728113998"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="728113998"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Nov 2022 13:50:00 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 13:50:00 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 13:49:59 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 13:49:59 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 13:49:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQoA5aOXqJ11v1/f7Qi5gVsqyV9WSY7kqJ3vxAoP82kqNtT0phQ0ztumjmMc8CRSA/QZEsVUPNj/maQ6hMSgf7z/izlmUUXYxeq6WAOTlznoV6PoHDc7ax0yuKOLx7mQIn4LyTHoOoMz60vehCRMLT9IbBPr3QMQTbUsBikNVwfWhem0SJuslION1e3tjtXnVoItaW0XoeTsDuwYfu9Na1aZgVvxM+wX+teeWfA6NGqlDj1sFt7lRhgQRL5pAGJDiyelJIue+cdZH1hAeDgWK3cqXU9cWehRVARf/k1hYPB53ttvksVIQA/QdgKIdZQ3r4TSpmjv5Z/b4DR6cTyryQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NYo6aZi7o7ZK0zIubUk50ZwJnXxFpeWtPwH879HNUU=;
 b=aRz0e8fVNqMIj0aInwXChr2ex6BIFjirh+szL3nBVkRdzqj2L3kWVoEHJzqRjlO7lB7FsV0Xwp6Ui2ltTnOVxRGvS+85KcLr6HEdqvl4XM6Mq+xMXA1WQCokuGCmJJatXxDo6ao1qxLqEMQQj+qeYObGrFqx2rA0B0VlSwmXZ1KuoP36e/24oeX3MZ1gFxWdPKqRqk9og339l7BYgjXPuWCHnIbjiQt3IeyQvkrwB7XGjKWpmuwX+tVRwVIzVPSB3oCNbpk9utuwTDztt97ShdIdsutFAj3XfgmvM/7x4jMAjZshQn90dqwkrXrR204ih9lPWZW1bgVAja21XZ1T+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CH0PR11MB5298.namprd11.prod.outlook.com (2603:10b6:610:bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 21:49:50 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3%5]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 21:49:50 +0000
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
Subject: Re: [PATCH v3 18/37] mm: Add guard pages around a shadow stack.
Thread-Topic: [PATCH v3 18/37] mm: Add guard pages around a shadow stack.
Thread-Index: AQHY8J5Z/yyGN1DeJ0iivA3WbjZDhq4/84aAgACQLwCAAASYgIAADtSA
Date:   Tue, 15 Nov 2022 21:49:50 +0000
Message-ID: <fed5a4d4249d2387cc02a169f89c65753a6303ff.camel@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
         <20221104223604.29615-19-rick.p.edgecombe@intel.com>
         <Y3OAP3E3UQShJ22N@hirez.programming.kicks-ass.net>
         <6e402f94fe1e942116aca729f1d54fd1399cb98a.camel@intel.com>
         <Y3P9De8QyGDYfzAz@hirez.programming.kicks-ass.net>
In-Reply-To: <Y3P9De8QyGDYfzAz@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|CH0PR11MB5298:EE_
x-ms-office365-filtering-correlation-id: fe432ddb-35d9-4b1d-9756-08dac753522e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e9lm6CjInEJV0zZFPSa6E8sbTTDo41ywnxwYDXHMzh0EfWVqQVG8t8yymUFw8/mQagsVkWnd+vtF6TI9vQvIkUR1Um1t9Zxg4doW86uLuoYhZhZAJLy3+rl0vTeqipNCB4xlgqKguatCVysT0Q9cUqp85qTgN8c1K6PYIiOPigbwK56/SQc0bu6Wzo2heTIQ4zbF16kkKAT0fsxL2LMNVaKsfMzDIWD1jFm/reIiR8IaXxJIIB896bj4lbjVNN55Qlb22Ab9EsZLelKkHWnbcES7m6OIDgMNGKChSNUcrvP2mSLbadHjih6ExZ/eNQx+bvyU1rUiv38Fz2xjnqqT0QZcQL3GvF5ybYvGjP9DhX6fX+pYQpsM1bMwx3ruMAjrvtqAmDsqR6DRl6+5UHSrGD36ovilJ3ClZu4cZ0RSbtoBF1ikOxND0uhAKol6350/qyRCOFfCVq4sWcrNSkhjEbUP8QTCAiTA3iBZQ9RJuJAh4P0s/AgXLqfrsnUDJPL2mUKhyKhByaaf2/qLD4qC0fcm7IgrDFPGcMAY7pcMYNQpwNax7sl0nmJG1N6LM5PtNgKTdFUY496ye3V8MpRd11v+kpG4N4ckbAQ6RXNc7xLDuEFQKTWN7hvPpz7RSk86x92mPp75cbNVFNnYP9k2df8/32FJc4h16cRdR7E1FM8AFGoPG2cZIwgA3fiYemkMRmTepOHqk6JbO1BuubhFfizICrwpDDMqwiLEYGBGkLDbZ8EjGpRwp1DUf0Oou6XrDHGsaH+vEn0B2h4rzg/1UZXn1vN0tGYBaB5GRrwT/Q7ieH+GTvVjzCQPukxYzWlKrq456HDEAltNtGgpyMN0Ag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(39860400002)(366004)(346002)(396003)(451199015)(71200400001)(478600001)(54906003)(6486002)(6916009)(966005)(186003)(2616005)(7406005)(7416002)(4744005)(8936002)(6506007)(41300700001)(36756003)(64756008)(2906002)(91956017)(4001150100001)(5660300002)(26005)(316002)(76116006)(66556008)(66476007)(66446008)(8676002)(66946007)(4326008)(6512007)(86362001)(82960400001)(38100700002)(122000001)(38070700005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUJYRE1qYkNLWlBpVG42M2YvS2V0QXM1Zi9hdjdLQVduc3dwTUVvYUdLQUdr?=
 =?utf-8?B?TkY3djM3VU9sMlZsd1o2aFBScWFUSEdOcVFMbGczSzBqRjlKeGdSUWFSVGE0?=
 =?utf-8?B?Zk8yTVVQM1d6dG9CdmtHdFdTUURyNjRtenljcGV0c05BRkhUYUJITVVvOU9T?=
 =?utf-8?B?b2hUVnRGSTRGY29OekZsWHc0WXYzUG14c2czSG05MThiR0tRSm8wZVJ0OGFT?=
 =?utf-8?B?N29kd2J1RHpaVm85Z09SWVNuRmI4YVBjNm5tcmM0ZmFHTlBRZTZsbzZRa01W?=
 =?utf-8?B?V08wM2xCbFEvSGVIWFdWb01McVpHVzlZVFB4Ujk0Tmlhb01TQ1NOYXVpQzZl?=
 =?utf-8?B?NXA1ZlhnYlVDSFNTZVUya3pPSVZ2S1lYdWJSaEV6blgyZUpqTkF6SXUvOHBh?=
 =?utf-8?B?bzVZZzEveDY4NlJyMitqdGNFcFkyR0Fsc2k5OG5meTBDdVFpbHhvWEdHMjY2?=
 =?utf-8?B?cGV0cVRoSWtwU1dKMTVaY2JLNlNlbzkyK2FLWjRqc2JDT1J3VGlsT3hqNWJp?=
 =?utf-8?B?am1PK0hhdWprVGZQZzRRS1lrbkE0Sy9TN1dsTUZ1SVhLV3dhbFo2VnZiT3JC?=
 =?utf-8?B?aCtGMjBoWXZMcEp3a09rRFovNDNXdy9PRDVoMTRHR1pJQnBaNEZMSy90UTJS?=
 =?utf-8?B?SXNMN1NTbDRQSGg1bzhiQzk3WUxhWDR3bEdDZDh0Z3FjWTNiNXZ2TjF5dVBT?=
 =?utf-8?B?Z1BZSStHZGxxMXdJZnhsVCs1WlJlc09FL2NKenEycFdUTnhhVnQ1aENMRDVF?=
 =?utf-8?B?VlpWdTBEOTZpbWkrZVFnZG9CK3FxRkxzc1ZzSUhVWDJCWS9pQWVYZTFWV2lw?=
 =?utf-8?B?bTB3OWNrQktDdGRTRkYrSkNobkNYODU2RXZ2ZXNrcHJaWHZuMHg5c0RLcXVS?=
 =?utf-8?B?VXRXQ0wrSHNmNlZoMnZuT0VvNHBBYko4eXRTUVBjNGVvS0tIVmV6ZlJVRENO?=
 =?utf-8?B?bTZEYVozUzEzamsrVTRiYUN0Qk43dzMvZUp0dGxITDczWmd2cXdlWlNOeTVk?=
 =?utf-8?B?QUozRnJJOUErNjc1bGV3bkZZS3EwTmh3YW5wSGphVHBrWUJNWnlHdE1vQVJq?=
 =?utf-8?B?aUhNRkJqZHQ1bUpYbHpxTVFBcUpWSWQrQS9MempMM0hvWndBVmVyNmo0SkJm?=
 =?utf-8?B?VWFsdzU0bUU3Y004OTBCWmp0dCtscGJCZkNiYWJlU21xSSthZGkvaUJZamJ2?=
 =?utf-8?B?MjVSRDh0TUZJWmVXQyt2OHVTb0xrVlY5WWVMSWFWTFBienZUc3pyazFRVitM?=
 =?utf-8?B?YnVBSXBILzFVcFdYNUpQZTlTdjQ5OGoza3ppdENtZ2pBN3ZRS0xBdmV5UnVo?=
 =?utf-8?B?NE90WEltbmlab1hZa0JrVWI4ektlWEpyVXJzRVgyNmQ4ZmN0LzFnc0VKbnRS?=
 =?utf-8?B?a1BuWUhsUDNUOG9CdlpoMCtabmdlRHE1Sit3WjZZNGRIaGNKT3BEUDJuWHFy?=
 =?utf-8?B?L29BdlRvOGQ3SHFaTDBzRWVaUkRiY1ZmV0V6SGhGTjJlRkc5TG9BR2xnUE5R?=
 =?utf-8?B?TTFlMWVxWTJoNWlMYVJhYVhsS2RoTkQzRURJU1ZrbVNud2xneEUyT3dhTkNj?=
 =?utf-8?B?NnE1RytqcUZScEJwQ3pxS2VZVzFaWDFiN3JueFlRUDYzajNiUFB5OU94alQ3?=
 =?utf-8?B?V0xCM1gzcFNqMm9iUlNtaTlYNCtObTdBVjBzVDdIMmYweFM5dDdLZ2ZiL0Rn?=
 =?utf-8?B?NWZPN25RMG9KOGtMT3VZeGM3T1JWWUY2S1V4aFVERi9zQ1UwVDRlY2xGeGFI?=
 =?utf-8?B?ZWxicEtvekJJMlV6Z24rV2FPQ2ZUejJPeVdTUUpyd0lURHpuenVreU80MXEr?=
 =?utf-8?B?NVhNTCtjSHdqQjdCbU9JVUNmblZTL3FpLzFqRWtOV203UHdOVmcvY0JqQWR0?=
 =?utf-8?B?NjdBNVRHbGVhYk9HY2RqQ2FUeDE3TlNQOWt0dEpYcExCdlh2TVFEVlFkeEpp?=
 =?utf-8?B?UFRCcDV1bGprYTNqT3BSYmJjMlFQSHVIUzd3S01yUHFpbVhmaFFkOXdNcGw2?=
 =?utf-8?B?bWVpaWhUN2pqTjRHNnNQTXMzcVlrZSt0WmJIVk1uWHVvVnNveDRqNUozSldB?=
 =?utf-8?B?d0xPclZ1bm5Ia2RjeHpUQlBkb1RVZnJjUU9aS05mV2Vsc2lsVmptTEVzVVc5?=
 =?utf-8?B?UDRQcXZSNXhuc21PT2pFREpQRGJCcGZSeExyWXZrMlRKSjhTV1QyUm5pM25G?=
 =?utf-8?Q?4RozNwqUnUnEBktdiEU/HZw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EEF00377046AD4BBEB564297DFE21F4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe432ddb-35d9-4b1d-9756-08dac753522e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 21:49:50.1188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: diKh1UwIHGpJhTwkqQtIKpYpcG1FRD78FFoNCuy7qWi3Fr4Oqmh4I8fHPnq5B4p9VnSS0E0XHO+fnSeaPZVt5QJt9Th2x7vWfQ+5Ixwc3zo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5298
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTE1IGF0IDIxOjU2ICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gVHVlLCBOb3YgMTUsIDIwMjIgYXQgMDg6NDA6MTlQTSArMDAwMCwgRWRnZWNvbWJlLCBS
aWNrIFAgd3JvdGU6DQo+ID4gPiA+ICt1bnNpZ25lZCBsb25nIF9fd2VhayBzdGFja19ndWFyZF9z
dGFydF9nYXAoc3RydWN0DQo+ID4gPiA+IHZtX2FyZWFfc3RydWN0DQo+ID4gPiA+ICp2bWEpDQo+
ID4gPiA+ICt7DQo+ID4gPiA+ICsgICAgIGlmICh2bWEtPnZtX2ZsYWdzICYgVk1fR1JPV1NET1dO
KQ0KPiA+ID4gPiArICAgICAgICAgICAgIHJldHVybiBzdGFja19ndWFyZF9nYXA7DQo+ID4gPiA+
ICsgICAgIHJldHVybiAwOw0KPiA+ID4gPiArfQ0KPiA+ID4gDQo+ID4gPiBJJ20gdGhpbmtpbmcg
cGVyaGFwcyB0aGlzIHdhbnRzIHRvIGJlIGFuIGlubGluZSBmdW5jdGlvbj8NCj4gPiANCj4gPiBJ
IGRvbid0IHRoaW5rIGl0IGNhbiB3b3JrIHdpdGggd2VhayB0aGVuLg0KPiANCj4gVGhhdCB3YXMg
a2luZGEgdGhlIHBvaW50LCBfX3dlYWsgc3Vja3MgYW5kIHRoaXMgaXMgdmVyeSBzbWFsbCBpbiBh
bnkNCj4gY2FzZS4NCg0KX193ZWFrIHdhcyBzdWdnZXN0ZWQgaGVyZToNCg0KaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGttbC9mOTJjNTExMC03ZDk3LWI2OGQtZDM4Ny03ZTZhMTZhMjllNDlAaW50
ZWwuY29tLw0KDQpMZXQgbWUgdHJ5IHRvIHB1dCBpbiBjcm9zcyBhcmNoIGNvZGUgYWdhaW4gbGlr
ZSB0aGUgb3RoZXIgc3VnZ2VzdGlvbg0Kd2FzLiBJIGNhbid0IHJlbWVtYmVyIHRoZSByZWFzb24g
d2h5IEkgZGlkbid0IGRvIGl0Lg0K
