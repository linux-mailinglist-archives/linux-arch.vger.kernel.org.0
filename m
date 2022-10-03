Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8295F36D5
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 22:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJCUF0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 16:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiJCUFY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 16:05:24 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2931F9CF;
        Mon,  3 Oct 2022 13:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664827523; x=1696363523;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=05YmWF92ZqMrEEGK6fGk+NXC2iiCIzfIW55Efc1G2Qs=;
  b=Q4+gGAlJhGaIKMQlZPG/3l9BaqIj6nGozkFDmGHWsRzoIfxD9/ZBsKeD
   /qTutCtVOYZahRwqIBAKo7UFMMnFQ/Bpb6j/QxylXX/k88G7YIdEOkiS4
   DUwlZSGOaZXy/ktcpmjIbQGqXgLUuXDJxNZ2/RbsouLUbw6poRPuFMJLs
   NBVxCkJtLpeqoIltc5dgl7MJf6u9Um4Yf6Rmim+e3/aKBvpWj4A82YPyw
   ZeB8rlYtqtlt/208RWgBEwNXITDX+Av5qswJVqRU53MJg9GoY9dG/3uDt
   qyhASAtptSZ7/Hi5I/PBTI39wj05NzYvy8+ze7jfx8v2cofHrz5vleVs0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="366846048"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="366846048"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 13:05:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="625928964"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="625928964"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 03 Oct 2022 13:05:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 13:05:21 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 13:05:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 3 Oct 2022 13:05:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 3 Oct 2022 13:05:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lH2m2obznILXSL6dvgzVUqdRCGojPTXjVN2gX6Qfuy93xkHGUVlT9fF6aMkpyVJZhtxp2vCcTGMmHtdPg+WzPbknfFVbLircIO8yYP6ndg1oUPWx4VZRJR9HZtbs02R50UwIQDUTVIwcRE7lIicqXVlD5Vw8nVOEqmtmMhkF8v/CBdq7aoLYiu51jZzejFq32R2/tkBERvVbtiuQXQ9i8H8ov2yWAhnuYuPk5ycjHjM1SaUnmziE3AIfE5Gd5M9oMq4g5k5DyTGhKoXg8WDh/z7i4Nf6KEaJ1X9aquqpEiP99dhmLTiCAIj3gGQusypsVEJRhFS4NCpJnLAkObZ2sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05YmWF92ZqMrEEGK6fGk+NXC2iiCIzfIW55Efc1G2Qs=;
 b=KIeh7JT9CKOjbO/634KRleYCMmMIawrt/DssCJXEAUnoUDwqVOoJp2tbVLD7TaphklFDUtGkh2dAeQR+aBx2B+n62Yyd6WEAVNyFeRmAp24gFOMHC2bp3reT8lq/qzR3yc6X1H2xEKxgQhOK+NoClagGpo8bQDku4gO0LiBIwZf8GiApEJyqmgmBX5kzJgs+Y1Jeyo3VIAA0/Y1Z5opIjSCl+gtNEkbQoOng9z1uC5la6gW9e6rhGOlOlTOEJFzpwSaEtaqUgdTGoPDG8N5IyLrFqp81T4C9kZI0T9TSOQ8BlzQwSG0uagqPJyVJtKyIxV0cSmWgYT8M8vLbwx2fCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SJ0PR11MB5024.namprd11.prod.outlook.com (2603:10b6:a03:2dd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Mon, 3 Oct
 2022 20:05:13 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 20:05:13 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "keescook@chromium.org" <keescook@chromium.org>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
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
Subject: Re: [PATCH v2 06/39] x86/fpu: Add helper for modifying xstate
Thread-Topic: [PATCH v2 06/39] x86/fpu: Add helper for modifying xstate
Thread-Index: AQHY1FMJrtB3LEMfaUW58zSfmJBEFq38+AqAgAAmNIA=
Date:   Mon, 3 Oct 2022 20:05:13 +0000
Message-ID: <e0b3662ac478a7d2ae1991e8c674732592c2ea88.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-7-rick.p.edgecombe@intel.com>
         <202210031045.419F7DB396@keescook>
In-Reply-To: <202210031045.419F7DB396@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SJ0PR11MB5024:EE_
x-ms-office365-filtering-correlation-id: c88cc684-2310-45ab-3461-08daa57a9561
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I6G38Vu4FQLXFbGahaBuzQBL4P5GLeB0G/cbmwxUInIaJ9V/glS6BhLtuT/hdv5K5SNCbY83XOv64Rq76hamlJC9F3jkarvnvs0T1XZCHt1flu7kjcpbDzEL1DAJxeDEmmJjAe8wRE9oPGKF8O2rtnqBeYiI9vj6MO6Uwlr0XKpEfgOLE5/ebR6MMP++Z9Rdm0+mTkaE0xA4HoVFUXzamsc8Z2GZdNKsO4A+5sqZyCJ11FzMBazjDxJSZYz2qSbxDj6npH1hz8SoqeaXJGT+tmiY11VkKdfN7fKK9A2jbAyM6y2XNkUYmZft/t3jR/K74XzBfUoi0BRlaXrWnfr4lLa6Bu5QGt1k0l05tM80EYuCtR9r3qi8lerjnYlkFZzEp/kDvgPBxKm0JQ70Vc3dMYqKLCCQJ5b3F7cCFBpXOFNzc1bsaLSxEsSUhh7bJlZhc4CNcq0BRLhZpzzfJszDM+dc5MYQ/v5YpoD7RPEk1QJNvVfHRdSnB0FGL5HTwh+wXCZG88EmWoEzFKqKsU2VJlCySyIh/8g5lajgKXkQ8IHkT6DIKFqguGMMc7ZbBvDjmSXMi6O7RZeh3UxXFAWIJaInzKqJnCm2IsgS8Ee5YV15ZNdt4Gl7lZGWXE5pp6VdsOuZgb+pPxNA3mdZ4i/hKVBYL7ovi4GoMS+iCD1EWsAEdxLGfUUZBZGp7fLsHZcyyu7ih83r6k7tofPFceipCnl3vuHLTAh1NemLXDo3y51LBuBAD0940wij61N08uK71Q1PH7nckfceLbGa86jB5bxR74lJeL/bbpFBViOTJt0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199015)(7416002)(5660300002)(8936002)(2616005)(26005)(36756003)(41300700001)(6512007)(82960400001)(6486002)(66946007)(91956017)(64756008)(66446008)(66476007)(8676002)(66556008)(186003)(83380400001)(4326008)(2906002)(76116006)(122000001)(54906003)(7406005)(6506007)(6916009)(316002)(71200400001)(38100700002)(38070700005)(478600001)(86362001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDJZdzMveVdWSmxIREtmZVdKOGlUVE00MVczM0kyTUd0Vi9kTDArMEJpbFlX?=
 =?utf-8?B?a29PalI4VzhuQXA0eEtYaWdVYkROWlI4R1c3NE1iNmhGNlkxQmpIUVZ0allk?=
 =?utf-8?B?NkRVWDhuVWFkV3pwR29oV1U2dTMyeFU4bUV0WmczbkMybG9IV1NpVDdXRDlZ?=
 =?utf-8?B?dVkxU0NNT09hT25XMy92YndwWWpyMGoxNGU1d2JOaCtJemNwZDJCYVhsbGpJ?=
 =?utf-8?B?dmJMY2tIN3V4VGlnUWZZTStxNzJvbGhSbnNWYkQxR3ZveElzUnJPMDM1VC9h?=
 =?utf-8?B?eE1PcGhLdE9ZalcvTVdDYjN3dHgxZ2w0VWg3R3dQTmdiNHNlNDRoSTc5VDJD?=
 =?utf-8?B?KzdicGgzTWdQS055Q05KQ0hrSTRmei8rUVloeFcrSE0rb0xiMEcweUdHTGdU?=
 =?utf-8?B?RE5ZTXpGUk9HcDlwTmVaRXNYMU1WNXlOU2JUQW51M0d6ZzBoVDkzeHhpWkJV?=
 =?utf-8?B?REgyRlhWTjViQzFlV0V1TlpvQmRiYlVERStHNEQrU0M5a2NqWGNJa1dieGlX?=
 =?utf-8?B?eHhyWTJwT3RwM0o0OW5RVmpZUnNCWC9JYmtocWdqYmt2d0J3VmIyN0hQZ1hS?=
 =?utf-8?B?VEhuNDgvcHNuaVJ0ZmNEcGIweWZZRDRGd1p6R21yMzZ4bWtmdldDRVJvSlo3?=
 =?utf-8?B?b1NBYlF2eTIwR0JzZGk4RDVTVzRtRWxMc2ZPbTBrNlVveGtRcjQzNStnaS84?=
 =?utf-8?B?eElDQ1JGMEpXbWlkNGhVMWdYbFBmTERKcGkxZU9IVnVqNUJHUTdHYUxSU3dL?=
 =?utf-8?B?RkRSS0pkUVJITmFJN2MxSDNyMTVpRW9DVTlHazZhS1BuQ3Nudm9zV2EwWGpP?=
 =?utf-8?B?WE5Hdk9wbnNxOW9LaFk0b0x1WFgzQURrcmJJU2ViMWxtS01iL1NwbjM0U3B5?=
 =?utf-8?B?K2hWMW1tRHJyTDNpSWFORENaTS9sclU2MGhuKytRTEkyckVtM0czbTRtbjN2?=
 =?utf-8?B?TG5LdWdRTHVHWTJCa0tjSWJGSTZjVnFNcXRPVjczUlZvYnNGM0UxT3R1QnRx?=
 =?utf-8?B?RFEvSFIxeXg0NWcvQkVhNmdHM20ySnhMV2lUU1VZVVFHUEpVNzUvR1gzckNu?=
 =?utf-8?B?Y3J5TmdGYnJEbVdqTDk1OXpkM3BES2hteTIwVzd4RDNONm1RYnNYR2ppaVlY?=
 =?utf-8?B?OUZaVG14cmxGaW9lYkwwTDdMbjdNN0dQN003NGVld1o0K3VKVVJUMFFkTWcz?=
 =?utf-8?B?ZGdqTThPRGhrNjg4Q2dZSTdBTVNoMlNtNE5MbFFET3FIVjBvKzBKVmY5Mncz?=
 =?utf-8?B?NzNCdHZXYTdMQ2p1YkVvZGMvQ2pSVjNneXFQSUtaNUdrZ05SN29RUXNHNWJP?=
 =?utf-8?B?bE9ubGpzNnk0Zi9Bb24vYWd4OGhtTkZWeXVOWTlrUVZzS3MraUw0V1EwcURJ?=
 =?utf-8?B?SHNBbWlIbDZGampzdHVRSkkwTkdqS0RTcWZTOFpseVd2OUZtUWo3NVArMGFC?=
 =?utf-8?B?cy9OcnkvdXFya1VIbm9iVzZuVURqTnFuTEg0SlZpbkJPTnhqOXdHQWw5WnJB?=
 =?utf-8?B?S3JHWmU4VnllRi9LZ1NhNmtWMFdjTjZ4amRXeFRvK1NkZVNXUGt6VVZob2ZZ?=
 =?utf-8?B?WUhpODY3MEh6T0FxRksxS1pKT1kxYjJaY09KbUo4b3JnZncyRDZuRUZiZVBq?=
 =?utf-8?B?VE9vUHNGTmRVRkY0ZVZMcnR5eS9KTWpDREd0T2hXUlh4bmZsZWtGc3B5RGhl?=
 =?utf-8?B?VnVLbkdFUUtCcDJ4YVhONFBEQjZTSlE2SU94K0NOV3g5ZlNPMnl4RFVBMDZX?=
 =?utf-8?B?TVNOZmlKdmdlKytKUVFza1p0MURiR29PK0pnWVVQWVU5MXB5MkwrR0JuMXdl?=
 =?utf-8?B?bDYzczhYNDZuanFjTHppRnZlU040VjRkd1VxVWVDaE5sZk5ua2tzMzJjZlIz?=
 =?utf-8?B?bHk1YUZSOFZUZ0pJY3h5T1pSZ1BXQWRGQXR3a1dENTAvYUxkNWRZSzNLYmJx?=
 =?utf-8?B?aUNxeFF2dE14d2duTTE2Sm45cHZiaGVYemE1NUtraWJxUEYrZ21aMVQ0eWg1?=
 =?utf-8?B?T2JxQlNVYzkyNVhINUJ0Q2NTakNMOGh0NWh3QTdackhNM3NMR29XaWI0WUN0?=
 =?utf-8?B?NituM2J3QWs1bVdGRDk0UmQzMW5mK0xLWk1kZjUvTC93OVJSWXc3WlFodEZv?=
 =?utf-8?B?VGVXM0tmYW1ENHhjRVIzSVlDUkVINEM0allIczc5N2NHSmhkV0lSN3UzWXlS?=
 =?utf-8?Q?DbbV5Ee/wCGmDGUZDfeMEy0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2591A435FC6497488E12ACBFFC5AF1A5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c88cc684-2310-45ab-3461-08daa57a9561
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 20:05:13.6646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lxi2mtoDytZYAHs29p8wivnoEXpCBSApwP0qatodm65+H8aO+LnOcmRkloPwuQrF/0b4iTxJZOeMSooezgfSOIFz7vuXekJ160rH3fxEYGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5024
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTAzIGF0IDEwOjQ4IC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+ID4g
VGhlIGVhc2llc3Qgd2F5IHRvIG1vZGlmeSBzdXBlcnZpc29yIHhmZWF0dXJlIGRhdGEgaXMgdG8g
Zm9yY2UNCj4gPiByZXN0b3JlDQo+ID4gdGhlIHJlZ2lzdGVycyBhbmQgd3JpdGUgZGlyZWN0bHkg
dG8gdGhlIE1TUnMuIE9mdGVuIHRpbWVzIHRoaXMgaXMNCj4gPiBqdXN0IGZpbmUNCj4gPiBhbnl3
YXkgYXMgdGhlIHJlZ2lzdGVycyBuZWVkIHRvIGJlIHJlc3RvcmVkIGJlZm9yZSByZXR1cm5pbmcg
dG8NCj4gPiB1c2Vyc3BhY2UuDQo+ID4gRG8gdGhpcyBmb3Igbm93LCBsZWF2aW5nIGJ1ZmZlciB3
cml0aW5nIG9wdGltaXphdGlvbnMgZm9yIHRoZQ0KPiA+IGZ1dHVyZS4NCj4gDQo+IEp1c3QgZm9y
IG15IG93biBjbGFyaXR5LCBkb2VzIHRoaXMgbWVhbiBsb2NrL2xvYWQgX25lZWRzXyB0byBoYXBw
ZW4NCj4gYmVmb3JlIE1TUiBhY2Nlc3MsIG9yIGlzIGl0IGp1c3QgYSBjb252ZW5pZW50IHBsYWNl
IHRvIGRvIGl0PyBGcm9tDQo+IGxhdGVyDQo+IHBhdGNoZXMgaXQgc2VlbXMgaXQncyBhIHJlcXVp
cmVtZW50IGR1cmluZyBNU1IgYWNjZXNzLCB3aGljaCBtaWdodCBiZQ0KPiBhDQo+IGdvb2QgaWRl
YSB0byBkZXRhaWwgaGVyZS4gSXQgYW5zd2VycyB0aGUgcXVlc3Rpb24gIndoZW4gaXMgdGhpcw0K
PiBmdW5jdGlvbg0KPiBuZWVkZWQ/Ig0KDQpUaGUgQ0VUIHN0YXRlIGlzIHhzYXZlcyBtYW5hZ2Vk
LiBJdCBnZXRzIGxhemlseSByZXN0b3JlZCBiZWZvcmUNCnJldHVybmluZyB0byB1c2Vyc3BhY2Ug
d2l0aCB0aGUgcmVzdCBvZiB0aGUgZnB1IHN0dWZmLiBUaGlzIGZ1bmN0aW9uDQp3aWxsIGZvcmNl
IHJlc3RvcmUgYWxsIHRoZSBmcHUgc3RhdGUgdG8gdGhlIHJlZ2lzdGVycyBlYXJseSBhbmQgbG9j
aw0KdGhlbSBmcm9tIGJlaW5nIGF1dG9tYXRpY2FsbHkgc2F2ZWQvcmVzdG9yZWQuIFRoZW4gdGhl
IHRhc2tzIENFVCBzdGF0ZQ0KY2FuIGJlIG1vZGlmaWVkIGluIHRoZSBNU1JzLCBiZWZvcmUgdW5s
b2NraW5nIHRoZSBmcHJlZ3MuIExhc3QgdGltZSBJDQp0cmllZCB0byBtb2RpZnkgdGhlIHN0YXRl
IGRpcmVjdGx5IGluIHRoZSB4c2F2ZSBidWZmZXIgd2hlbiBpdCB3YXMNCmVmZmljaWVudCwgYnV0
IGl0IGhhZCBpc3N1ZXMgYW5kIFRob21hcyBzdWdnZXN0ZWQgdGhpcy4NCg0KPiANCj4gPiANCj4g
PiBBZGQgYSBuZXcgZnVuY3Rpb24gZnByZWdzX2xvY2tfYW5kX2xvYWQoKSB0aGF0IGNhbiBzaW11
bHRhbmVvdXNseQ0KPiA+IGNhbGwNCj4gPiBmcHJlZ3NfbG9jaygpIGFuZCBkbyB0aGlzIHJlc3Rv
cmUuIEFsc28gcGVyZm9ybSBzb21lIGV4dHJhIHNhbml0eQ0KPiA+IGNoZWNrcyBpbiB0aGlzIGZ1
bmN0aW9uIHNpbmNlIHRoaXMgd2lsbCBiZSB1c2VkIGluIG5vbi1mcHUgZm9jdXNlZA0KPiA+IGNv
ZGUuDQo+IA0KPiBOaXQ6IHRoaXMgaXMgY2FsbGVkICJmcHVfbG9ja19hbmRfbG9hZCIgaW4gdGhl
IHBhdGNoIGl0c2VsZi4NCg0KT29wcywgdGhhbmtzLg0K
