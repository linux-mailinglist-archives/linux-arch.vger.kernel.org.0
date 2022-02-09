Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDEB4AE6D5
	for <lists+linux-arch@lfdr.de>; Wed,  9 Feb 2022 03:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343859AbiBICk2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Feb 2022 21:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbiBICTS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Feb 2022 21:19:18 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E8BC06157B;
        Tue,  8 Feb 2022 18:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644373157; x=1675909157;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bW2sNCiorRSptroK3im4uwBBJZGbARD1xXgS08snxBU=;
  b=cxpJt6/OEL1uGh9Zj1lPMpcL6WR7Ns6K5z/MFfa7HeGy4X9QlpXJWnM9
   rOwfBOSY6AEYTwtDGXNpmgnng81eCjdc50MbdVeETCLxpRWzVvLgnNPo4
   Q+xDEJffLvg6wYM1mbf94Cyi8rKl8cbPKYLX/5+EFvYAP4dfvJepGBmYS
   CjjxbgBgPYXw25Xhnz4j6/2uOx4LwGz61KonLcZk1Y2UifxRxm6nmNrqD
   UzLRdJMQMyCRbq6+Xt60zV5rO9QZnkPZZ46wMlOtK676YG/LJR0uHtoKa
   6uyZI7CBFVOakCvNSzn8HD1LQpab41kVKuEf0LyYM/BHIojXsh/QxzRRY
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="248862763"
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="248862763"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 18:19:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="678314152"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2022 18:19:16 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 8 Feb 2022 18:19:15 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 8 Feb 2022 18:19:15 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 8 Feb 2022 18:19:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdTtDEeMkn+RxuSuRi7M/QdSKa9VLzBnpH4VjTYngU+jRdH1UxjEPeOGasbjme/5xHeBsEOlwGPat1zI9F+u+RuJgcT5XSAkV3f8dh5DWzemF6KAUDbyEdOhSovUgRMFZVuqC2bb8Fo+TIhXLmjBNe4BtqfJMQSeXNLCnjQ6/navbaHjFPUBDi918UiOjFArlezIQ9iDz+IRyrXaIc379B3pmBkD0SaJCTwCc7ceYnXV2S/N1dHcfqvdafqy0TDTaIrI112ihEhPz1jhg348kpeojHgCeJa0Gcu8WmNkY+GtFdUB7m3ckMmelPpgdihyKA9e7kgUE8k2hZofWnP9OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bW2sNCiorRSptroK3im4uwBBJZGbARD1xXgS08snxBU=;
 b=cfBSDbDHvONfYiH14yRVlDULc8DxwHMsqQA6PMK1AZUMUedkOQH6389C3rsQPOdRFpc+6yLsqBfF35Ef9QhCXeMxgF0um/XAgeD+ZVgYeBc3aVuhi1GYuF6Tuuw4cgH8xUAAyJcEI6EdxvN+Ub0KNjIce9u5w+zlrITQTwQBn4yHWGxLZbXvBQMvF286RnOPxY2yLZSJ48U5G3w0buxepHzgiWocKVRNUDPBNSD4LMyCddry+Fr9EJqT76e1pHyxmzZSbiR3e02pUKv0DUrPTP8PGjNKQHIlamD6TdrLXJk/LagKDruqH5l4JGqjjvzZmnHizdex71nAAbGQgbreOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MN2PR11MB4368.namprd11.prod.outlook.com (2603:10b6:208:17b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 02:18:42 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15%4]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 02:18:42 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Lutomirski, Andy" <luto@kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "adrian@lisas.de" <adrian@lisas.de>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "avagin@gmail.com" <avagin@gmail.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
Thread-Topic: [PATCH 00/35] Shadow stacks for userspace
Thread-Index: AQHYFh9orVaVUe6rNECZu4edjJzhZqyG5jiAgADTxwCAAJnkAIABGRSAgAADewCAAHMeAIAAC4MAgACbY4A=
Date:   Wed, 9 Feb 2022 02:18:42 +0000
Message-ID: <8e36f20723ca175db49ed3cc73e42e8aa28d2615.camel@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
         <YgAWVSGQg8FPCeba@kernel.org> <YgDIIpCm3UITk896@lisas.de>
         <8f96c2a6-9c03-f97a-df52-73ffc1d87957@intel.com>
         <YgI1A0CtfmT7GMIp@kernel.org> <YgI37n+3JfLSNQCQ@grain>
         <357664de-b089-4617-99d1-de5098953c80@www.fastmail.com>
         <YgKiKEcsNt7mpMHN@grain>
In-Reply-To: <YgKiKEcsNt7mpMHN@grain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5c15b84-1c9b-472b-5bc8-08d9eb727e45
x-ms-traffictypediagnostic: MN2PR11MB4368:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MN2PR11MB43683522B08BDC5814B2D2F2C92E9@MN2PR11MB4368.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 73WizJIoyZ4vzG4SS120yK+FvuO6ZYEZBgjUI18UfS42fAUyVWQCU750PGXnC2e60754k6tQDHLmrKkXD9IxwCTrpoRvrkqEM+uDZtgCUmrrKGz6UYMlKenp2/hmHWwkgGWgFuBwE/30e9jYl2b3sCnSWgAMK1ZLB0Hxqw3JzFA7URgJur+2U6DILUvpyJCOvYZyAI6Wm9tR5cO2Yi83Og2HQxKV0pJUbz2mVIIS67bLTHEUDcyzr0/pQ28kGBZSi4nEYr6JCP7ldSKub0jz7aPbUVh6hgKqxiSIAfS9rB6ypbg3ZZWQuTfKFax7bpDLcSt97k/x1ug2hTgUg6gshc6TpsDEtn47AA5vxpt0fWFyClxSfjTVwSYt/FTefvWmImHOVOpOaObrr5i13ZgNb+vV2qE3qj1jswUIVmpA7OW42zN5WH0lKaMoV+QjnlbpeL6azcKyiaipSvtT6dUrQMe6BqpFi31zDgjOk4H56dFcvjFN0NHtfApP0pu618j0eg96O6vyAezzWUh4rQKc3+jWaZcbRYHhcKZXvyOeier+UHCiQTDwt7DSQNnT9a3HgKJHE+6SaRyol1+SQfkDCw5eza3xUDwvs1pSkMp5W7+Tuo7Kqhi5uJx53OJdHS7QzuEprNDGr0Yql3x5GlrOATjzGqLT/YRrBSPAJD+Fij96dpSr/Kht7Nowtp+lG4HKDLyYqkjzMGF4nP1TSyApdhRyIX1i8JbdTbALnzpfdV0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(66446008)(8936002)(4326008)(8676002)(5660300002)(6486002)(66556008)(83380400001)(26005)(2616005)(38070700005)(66946007)(186003)(7416002)(6506007)(86362001)(7406005)(76116006)(64756008)(66476007)(71200400001)(38100700002)(316002)(54906003)(508600001)(110136005)(6512007)(36756003)(82960400001)(2906002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUMxOVlDYzNycHdESzVseXEyRGt3SmVwQ0NCSUUxd21TcURDbzNkMnNzc2pX?=
 =?utf-8?B?dGdrM3pmcjNRSWFza0FVaXZycUdjeUZJM0ZmTkJhMnlPQlF6VTR1aVVqdGZt?=
 =?utf-8?B?MzBsVUFTdFYwcW16V05YcjlrSitYVE51WnVBeFl2ckJSTTBQYXlxdG1OZlVk?=
 =?utf-8?B?UkNxWDhoL3hUWmVjbWxlRy90OENnRzNjMDhTL090S3EvVEFaRy9PMkZCVERh?=
 =?utf-8?B?b1REamZubldIQmszRm94V2NGNEJhMjRlTTRsM0I2NVNISGg2SGZXbkpkUHRK?=
 =?utf-8?B?emVzUWFNNlN5eG9NLzZyQ3dPQVBldGJzVk9UV3ZMbUpWczJrUVhUdVdQajRJ?=
 =?utf-8?B?QUY3czM4OVRPNnhDV0xCVitiWmVoTitVRkRvK0tVQ01KUkRydlZlbkZtYjNp?=
 =?utf-8?B?bWxKdjlPWjV6UmI4WW5qd213b3NNSnVjdXZUVkVFdUFvSUJaeExCVzdLdlVS?=
 =?utf-8?B?Y0pPdWxaWWNQUXYxdFdKU0VaTjVROVJoTld6OU5DMWI3cEpqUTQ2YVhnQlJX?=
 =?utf-8?B?cE1yNkw0eGFFQ0tnQVFzTEYvOWJ0Wmw3ek0vMDBzempHUXNrWTYxaEhST25v?=
 =?utf-8?B?YW04bG50VWR0VjdPa2hBNzA5djFyMkhaRGVsd2JjdExOUHBZa2ZrNDViRzVC?=
 =?utf-8?B?alM3QlY1V0hwV0xMTVJtR0M2WU05TGZhcjdZQStOME9qRElwUTk5Zzc1NTZE?=
 =?utf-8?B?MWxxZ1J2MW16NVYzclROeEtoNnZScmhwUnhoZ3ZKYVdqYzFsWUsxYllQbHdR?=
 =?utf-8?B?OGZKQnNGVTBRbHlTVTRLRklNSXZyaFViUDBjdG9ZcHkwdy9xMm43SW5kRHZL?=
 =?utf-8?B?ZEtweldLRXhGSDJvQndlVG9sZllYQkR1UkJyVVdaSko0NDczRlpvRTdEYllT?=
 =?utf-8?B?V1d4V0syMlc5UVpNbUgxVU1Zc0drL1p3WU95VmllL1k1ZitaTEdWb05kSSsv?=
 =?utf-8?B?VFVWWm9GQ3RPRmgwL1ppU2lYS2JOYmw1ZjlaUHAyU1JqV3RwYlRHemt0VVk1?=
 =?utf-8?B?aktoVXFINEpzSjN0bXpBQUpuNDRwd0hOTUZQV2NUYWxPR3dyWjIwUzUvK1ZO?=
 =?utf-8?B?TGVXenFNVlRlczhMMngrSW1qdDlmMkZyRURUaDlSWE1kZnZvaTVJSHpJbEx6?=
 =?utf-8?B?TTZHYTcxTzQyUGF6MlJlUVRXMDhTOFl6MzMxeHdBTVRvY2h2V3FPRFE3eWVZ?=
 =?utf-8?B?TWp4b2dUZmpvMWRqM21RaEljbFRGUGR3eHIrbFkxZWpBSGNqN1JWTWplTnMv?=
 =?utf-8?B?dE9ZdkVSbnJic2J3TnpYbEpIdUxUQk9Kd0FmQnpFUGJrTWRQMWVBWFJ3S0Uv?=
 =?utf-8?B?WkR3SHpRQ2oxRFNKeFVBdGNtV1AwYTlXWnJCYWZqZlNtUE96OGl0Sk5yNitn?=
 =?utf-8?B?VXgvZnZDanZUSWhKY28rOTJkby96dE1OZ3RPbFVyOTFuSkVudURaZFJWMm5W?=
 =?utf-8?B?VFl2Qzkydi9URUgwdktvWnpaeVFpakFwYUwrenpZL0ptVWJubEZpUURhRGlx?=
 =?utf-8?B?VmNSQTRSaTJRaFcwUEhvZml3M2RWWEFVY3ZQWEE4MjI2YU04TnY3M2lHUVNo?=
 =?utf-8?B?NmpPbXlRNnBzdjNVYUJFb2hUSE8xcmNyc09ZRzVEbFl0MVZjTDIzNnBKSndu?=
 =?utf-8?B?aHZrVUNrQTNTUUQzRU4vcGpzWlp3bUVFS1ZwYzl2UzFwS2RacWlMRklZbHdB?=
 =?utf-8?B?SHNhRHFSV3pMK2pYZjQ0VTJyb2ZCU2haQ3c0VEF5S3hNc1ZlQTBXNWx5MmdV?=
 =?utf-8?B?WndEaWpBQnV4VmhpRDY0dXltaG1Nc0ZyeXN6L2UzVWxWNFRBbUtENEdqeEE5?=
 =?utf-8?B?b2k1NEVZdWR1ZVV1VEN3TnBRejd5aDR5SFBQa2diTnRpaGc2M3hIbHVabVQy?=
 =?utf-8?B?WHlqZ29GSVdoZURpRE93My9laTdvVGJMTGFZTjdIUUNDMU0xY0VzbnB3Nndx?=
 =?utf-8?B?emlOanN6bk9RRVNRMmlYVTJ4UUgwRXdrM3RZMmdmVm9DTmdFTm8vSkgwQklH?=
 =?utf-8?B?T3BaZUZwOGM1d1NLMFBIbUJ3VFZDWEg1cnBjRWNCeWRUQzZUbjVvd25adk53?=
 =?utf-8?B?VHo5bllodGE2cnl5eUxWOHFETEhIRjhTR3QxRU5ndU0rNzJIelU4blJtRXZT?=
 =?utf-8?B?dllrbC9jWTNEUGV4cW1JNHJuQm9jalVqYVZIdHY0ZWtEU0RHUzd6VFQ1Z05U?=
 =?utf-8?B?U3pVQmNyTFludDM2OG5FaHlrYVErTDNKN0p6b1pwL21zcm8reFBpUWdFRkZE?=
 =?utf-8?Q?holN1dnovg2i7Kne7T8lzvNjX6HHzYA9hm2gSU4wVQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3A928D539DE6F49BD441E7DCF21C2C5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c15b84-1c9b-472b-5bc8-08d9eb727e45
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 02:18:42.4878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I6DohFmFMVoktbHCeAMtWX1ILkpnvhEOwn/Ql5VzMmyd9YAiquofUMkcrPJI497Tem1nXsluC3yqm7+j9XM/R1lBoHU/Ig6wy70URDAc98Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4368
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIyLTAyLTA4IGF0IDIwOjAyICswMzAwLCBDeXJpbGwgR29yY3Vub3Ygd3JvdGU6
DQo+IE9uIFR1ZSwgRmViIDA4LCAyMDIyIGF0IDA4OjIxOjIwQU0gLTA4MDAsIEFuZHkgTHV0b21p
cnNraSB3cm90ZToNCj4gPiA+ID4gQnV0IHN1Y2ggYSBrbm9iIHdpbGwgaW1tZWRpYXRlbHkgcmVk
dWNlIHRoZSBzZWN1cml0eSB2YWx1ZSBvZg0KPiA+ID4gPiB0aGUgZW50aXJlDQo+ID4gPiA+IHRo
aW5nLCBhbmQgSSBkb24ndCBoYXZlIGdvb2QgaWRlYXMgaG93IHRvIGRlYWwgd2l0aCBpdCA6KA0K
PiA+ID4gDQo+ID4gPiBQcm9iYWJseSBhIGtpbmQgb2YgbGF0Y2ggaW4gdGhlIHRhc2tfc3RydWN0
IHdoaWNoIHdvdWxkIHRyaWdnZXINCj4gPiA+IG9mZiBvbmNlDQo+ID4gPiByZXR1cnQgdG8gYSBk
aWZmZXJlbnQgYWRkcmVzcyBoYXBwZW5lZCwgdGh1cyB3ZSB3b3VsZCBiZSBhYmxlIHRvDQo+ID4g
PiBqdW1wIGluc2lkZQ0KPiA+ID4gcGFyYXRpdGUgY29kZS4gT2YgY291cnNlIHN1Y2ggdHJpZ2dl
ciBzaG91bGQgYmUgYXZhaWxhYmxlIHVuZGVyDQo+ID4gPiBwcm9wZXINCj4gPiA+IGNhcGFiaWxp
dHkgb25seS4NCj4gPiANCj4gPiBJJ20gbm90IGZ1bGx5IGluIHRvdWNoIHdpdGggaG93IHBhcmFz
aXRlLCBldGMgd29ya3MuICBBcmUgd2UNCj4gPiB0YWxraW5nIGFib3V0IHNhdmUgb3IgcmVzdG9y
ZT8NCj4gDQo+IFdlIHVzZSBwYXJhc2l0ZSBjb2RlIGluIHF1ZXN0aW9uIGR1cmluZyBjaGVja3Bv
aW50IHBoYXNlIGFzIGZhciBhcyBJDQo+IHJlbWVtYmVyLg0KPiBwdXNoIGFkZHIvbHJldCB0cmlj
ayBpcyB1c2VkIHRvIHJ1biAiaW5qZWN0ZWQiIGNvZGUgKGNvZGUgaW5qZWN0aW9uDQo+IGl0c2Vs
ZiBpcw0KPiBkb25lIHZpYSBwdHJhY2UpIGluIGNvbXBhdCBtb2RlIGF0IGxlYXN0LiBEaW1hLCBB
bmRyZWksIEkgZGlkbid0IGxvb2sNCj4gaW50byB0aGlzIGNvZGUNCj4gZm9yIHllYXJzIGFscmVh
ZHksIGRvIHdlIHN0aWxsIG5lZWQgdG8gc3VwcG9ydCBjb21wYXQgbW9kZSBhdCBhbGw/DQo+IA0K
PiA+IElmIGl0J3MgcmVzdG9yZSwgd2hhdCBleGFjdGx5IGRvZXMgQ1JJVSBuZWVkIHRvIGRvPyAg
SXMgaXQganVzdA0KPiA+IHRoYXQgQ1JJVSBuZWVkcyB0byByZXR1cm4NCj4gPiBvdXQgZnJvbSBp
dHMgcmVzdW1lIGNvZGUgaW50byB0aGUgdG8tYmUtcmVzdW1lZCBwcm9ncmFtIHdpdGhvdXQNCj4g
PiB0cmlwcGluZyBDRVQ/ICBXb3VsZCBpdA0KPiA+IGJlIGFjY2VwdGFibGUgZm9yIENSSVUgdG8g
cmVxdWlyZSB0aGF0IGF0IGxlYXN0IG9uZSBzaHN0ayBzbG90IGJlDQo+ID4gZnJlZSBhdCBzYXZl
IHRpbWU/DQo+ID4gT3IgZG8gd2UgbmVlZCBhIG1lY2hhbmlzbSB0byBhdG9taWNhbGx5IHN3aXRj
aCB0byBhIGNvbXBsZXRlbHkgZnVsbA0KPiA+IHNoYWRvdyBzdGFjayBhdCByZXN1bWU/DQo+ID4g
DQo+ID4gT2ZmIHRoZSB0b3Agb2YgbXkgaGVhZCwgYSBzaWdyZXR1cm4gKG9yIHNpZ3JldHVybi1s
aWtlIG1lY2hhbmlzbSkNCj4gPiB0aGF0IGlzIGludGVuZGVkIGZvcg0KPiA+IHVzZSBmb3IgYWx0
c2hhZG93c3RhY2sgY291bGQgc2FmZWx5IHZlcmlmeSBhIHRva2VuIG9uIHRoZQ0KPiA+IGFsdHNo
ZG93c3RhY2ssIHBvc3NpYmx5DQo+ID4gY29tcGFyZSB0byBzb21ldGhpbmcgaW4gdWNvbnRleHQg
KG9yIG5vdCAtLSB0aGlzIGlzbid0IGNsZWFybHkNCj4gPiBuZWNlc3NhcnkpIGFuZCBzd2l0Y2gN
Cj4gPiBiYWNrIHRvIHRoZSBwcmV2aW91cyBzdGFjay4gIENSSVUgY291bGQgdXNlIHRoYXQgdG9v
LiAgT2J2aW91c2x5DQo+ID4gQ1JJVSB3aWxsIG5lZWQgYSB3YXkNCj4gPiB0byBwb3B1bGF0ZSB0
aGUgcmVsZXZhbnQgc3RhY2tzLCBidXQgV1JVU1MgY2FuIGJlIHVzZWQgZm9yIHRoYXQsDQo+ID4g
YW5kIEkgdGhpbmsgdGhpcw0KPiA+IGlzIGEgZnVuZGFtZW50YWwgcmVxdWlyZW1lbnQgZm9yIENS
SVUgLS0gQ1JJVSByZXN0b3JlIGFic29sdXRlbHkNCj4gPiBuZWVkcyBhIHdheSB0byB3cml0ZQ0K
PiA+IHRoZSBzYXZlZCBzaGFkb3cgc3RhY2sgZGF0YSBpbnRvIHRoZSBzaGFkb3cgc3RhY2suDQoN
ClN0aWxsIHdyYXBwaW5nIG15IGhlYWQgYXJvdW5kIHRoZSBDUklVIHNhdmUgYW5kIHJlc3RvcmUg
c3RlcHMsIGJ1dA0KYW5vdGhlciBnZW5lcmFsIGFwcHJvYWNoIG1pZ2h0IGJlIHRvIGdpdmUgcHRy
YWNlIHRoZSBhYmlsaXR5IHRvDQp0ZW1wb3JhcmlseSBwYXVzZS9yZXN1bWUvc2V0IENFVCBlbmFi
bGVtZW50IGFuZCBTU1AgZm9yIGEgc3RvcHBlZA0KdGhyZWFkLiBUaGVuIGluamVjdGVkIGNvZGUg
ZG9lc24ndCBuZWVkIHRvIGp1bXAgdGhyb3VnaCBhbnkgaG9vcHMgb3INCnBvc3NpYmx5IHJ1biBp
bnRvIHJvYWQgYmxvY2tzLiBJJ20gbm90IHN1cmUgaG93IG11Y2ggdGhpcyBvcGVucyB0aGluZ3MN
CnVwIGlmIHRoZSB0aHJlYWQgaGFzIHRvIGJlIHN0b3BwZWQuLi4NCg0KQ3lyaWxsLCBjb3VsZCBp
dCBmaXQgaW50byB0aGUgQ1JJVSBwYXVzZSBhbmQgcmVzdW1lIGZsb3c/IFdoYXQgYWN0aW9uDQpj
YXVzZXMgdGhlIGZpbmFsIHJlc3VtaW5nIG9mIGV4ZWN1dGlvbiBvZiB0aGUgcmVzdG9yZWQgcHJv
Y2VzcyBmb3INCmNoZWNrcG9pbnRpbmcgYW5kIGZvciByZXN0b3JlPyBXb25kZXJpbmcgaWYgd2Ug
Y291bGQgc29tZWhvdyBtYWtlIENFVA0KcmUtZW5hYmxlIGV4YWN0bHkgdGhlbi4NCg0KQW5kIEkg
Z3Vlc3MgdGhpcyBhbHNvIG5lZWRzIGEgd2F5IHRvIGNyZWF0ZSBzaGFkb3cgc3RhY2sgYWxsb2Nh
dGlvbnMgYXQNCmEgc3BlY2lmaWMgYWRkcmVzcyB0byBtYXRjaCB3aGVyZSB0aGV5IHdlcmUgaW4g
dGhlIGR1bXBlZCBwcm9jZXNzLiBUaGF0DQppcyBtaXNzaW5nIGluIHRoaXMgc2VyaWVzLg0KDQoN
Cj4gPiANCj4gPiBTbyBJIHRoaW5rIHRoZSBvbmx5IHNwZWNpYWwgY2FwYWJpbGl0eSB0aGF0IENS
SVUgcmVhbGx5IG5lZWRzIGlzDQo+ID4gV1JVU1MsIGFuZA0KPiA+IHdlIG5lZWQgdG8gd2lyZSB0
aGF0IHVwIGFueXdheS4NCj4gDQo+IFRoYW5rcyBmb3IgdGhlc2Ugbm90ZXMsIEFuZHkhIEkgY2Fu
J3QgcHJvdmlkZSBhbnkgc2FuZSBhbnN3ZXIgaGVyZQ0KPiBzaW5jZSBkaWRuJ3QNCj4gcmVhZCB0
ZWNoIHNwZWMgZm9yIHRoaXMgZmVhdHVyZSB5ZXQgOi0pDQoNCg0KDQoNCg==
