Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EF462FB74
	for <lists+linux-arch@lfdr.de>; Fri, 18 Nov 2022 18:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242496AbiKRRSM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Nov 2022 12:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242123AbiKRRSK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Nov 2022 12:18:10 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC1F8EB51;
        Fri, 18 Nov 2022 09:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668791889; x=1700327889;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=P6eaDjxr9vtxdiSCjHr5hIrERCnNdENz8unXAuGTlsQ=;
  b=QRasI9RsBOImMqPQHb19V9HA23C9Rp2cv2fNcdv8in9Qw7itGIIB2Bdu
   etM/ZGVKESC+owsRj2BBW0byF+sj5FBjaHBaLIujD6b0ygn4YkoFqZWZL
   jOzLpWoQP+PS4/9n2qR1JT5NtntJa66BO4c2LbKSi0+TKox09RJVSiAK0
   cCyildcuUfnJ5MRJoZBnSk8HGLjdLU20JK5Tbo1nnVvV9sj09W+bJ5e0N
   Z03JsGpu000oeVu3I5gF3PWhvHeyuW25BVVOh7iGgPlic5g3Qt5RdKX2N
   Dv31aeT1zhndNO/nvIU1stU2upKKykIGNnTLlPR+UOBu0qkoNpsrvYiu3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="314336883"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="314336883"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 09:18:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="671383100"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="671383100"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 18 Nov 2022 09:18:08 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 09:18:08 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 09:18:07 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 18 Nov 2022 09:18:07 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 18 Nov 2022 09:18:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGuUYYdIj7PeS1oCWAk8mkU2woOXpHmTVZA5VcvrHCtFx6kqKi/mLuvZXAYES/iuEzfzfdx08V9RLXlgb4ULZSvRPbRf9Vu/SokhGVOeAkTP4E5M7hHJj3BkIxgpMg13J03cW8HIYqvyzwndl8nkNlCUmWavXnjNO8AlhjYzYS1AaLTDuB56+iEp0x88Whj1NTaTUc2Ojykq7ncdfTgzx3CeDJwbiH8ISdwRNid8viW/G1EC4kW0grCYmw6K5TgKvNnCiCFpV3SMo0PC1zPcw90RrkKpeR2xocO134QHD6xehVWM19wXtA9LiKZcZjeSypmgtUmlw0cw4F0jdgTBDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6eaDjxr9vtxdiSCjHr5hIrERCnNdENz8unXAuGTlsQ=;
 b=MFVhAiYQgaBOboqjBLdv0sKuztQ7F+OD0I/4wD17YhE3UFzmIqQsNb96mU7AcRq+bhCyRnaxQpLBmapz2kWYxuJKE71c1uM3ZoqkJIAXBkeRV0d4W1X8TDgsjDEsAF0CxFXXt+xsHl3uVkEzVaoe57dRMXowdT9e3BwvPZ3dqAon0cbqSmuOhdNxZUPglkCaISnAyNltt8dV41xuQW4+qKw+VDj3j6vY0imt0Z5QwXr8IynF+1ucg54LHJ/vNYiIJbX6J7K1Fl42Dq6u1MvU+7hV/kq7FrPkANjTGUuCsC2RSGa7XLJYezQVPHP+wSXcSXkJrTGP9yA2X9gkjOmR9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MW4PR11MB7054.namprd11.prod.outlook.com (2603:10b6:303:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Fri, 18 Nov
 2022 17:18:04 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3%5]) with mapi id 15.20.5813.020; Fri, 18 Nov 2022
 17:18:04 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Schimpe, Christina" <christina.schimpe@intel.com>,
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
Subject: Re: [PATCH v3 35/37] x86/cet: Add PTRACE interface for CET
Thread-Topic: [PATCH v3 35/37] x86/cet: Add PTRACE interface for CET
Thread-Index: AQHY8J5eaXgH6xugZk20MwPZdy8SOK5AIA2AgACAkACAAnwdkIAAf9AAgAFU61CAABC8gA==
Date:   Fri, 18 Nov 2022 17:18:04 +0000
Message-ID: <1efbdf4c9cc624c863f27afdb980bd3a3ea75ae7.camel@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
         <20221104223604.29615-36-rick.p.edgecombe@intel.com>
         <Y3Olme4Nl+VOkjAH@hirez.programming.kicks-ass.net>
         <223bf306716f5eb68e4f9fd660414c84cddd9886.camel@intel.com>
         <CY4PR11MB2005AD47BA1D97BC1A96A769F9069@CY4PR11MB2005.namprd11.prod.outlook.com>
         <a2c2552fcdba1a0fce0d02aeb519d33cac83bfd2.camel@intel.com>
         <CY4PR11MB20055995B323E98C10BA159AF9099@CY4PR11MB2005.namprd11.prod.outlook.com>
In-Reply-To: <CY4PR11MB20055995B323E98C10BA159AF9099@CY4PR11MB2005.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MW4PR11MB7054:EE_
x-ms-office365-filtering-correlation-id: 3ab37d5b-6fa5-446d-edd0-08dac988da7d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a00SXtb79HeIOqB4vesxl9GjeUclBypDQUQ0Ykrt+7GAhPMQC61z9vIlAO3p3z8DaySgehvrChWkmPMINTOKt+WGkv04t++ZfkVvfsdv9pE7An1E/rPWpoDQ3as+a3uWTWOvRPZJ3VJ5MABVHdcGsiEwzQEoY7EuVE52nSzqSvfj8adxUClMaO2Upxc960j2KxlOf32swGobF7t95am6BQYO75PJtHOdMRDsDh1jkturkN4VrmPWjIhVgcg39girvgU50OXieWDFVR9ovytBA+BBhHwlEyBbIxGqvbsMW7oJ9efKRf7Bqr8/WsvkDY0Z/qpGW4YuA9v3DW8V9+bP6TlD5g2in/aiPn04WkEBCPGFjHAKameyYa/U76XKrJU8hpJv10jpW0gxYHb32PuGcIOl7p1oUJY0zeWN06kxqugZRVaKITXGDKpVQGVWHuJEMJgR9nUilFwNc5Ky5ZjtOD+LaLZfUFQhXYADRHubgTdTevPF1HkYUYsAKiDl7RwK+aofJs6HeLpCvxz5Vv3GC+r6/3cCrJYqkpZfek+HlErjQB2lwo/5AksRAE9tW2NXoPYUsCgaX9R5VhaYO+81JfOwxJZBjw34jF1YdxC6nJ9pt4wNCM3THwji/tfkiQPode//LdS6m+EwbhfgmYjfPEICXQBGFo5P2gSP3XOLx6ZxVmm7wYVcNZt05mQW/A2JKCfLI/1amnmwalFfG04gKK0FTb0qa8szYlAeAFF1Rlc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(38100700002)(38070700005)(82960400001)(122000001)(478600001)(6486002)(71200400001)(41300700001)(86362001)(110136005)(6506007)(54906003)(316002)(6512007)(66556008)(76116006)(91956017)(4001150100001)(8676002)(64756008)(26005)(4326008)(36756003)(66476007)(66946007)(2906002)(66446008)(2616005)(8936002)(7406005)(186003)(5660300002)(7416002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3lBbW1rRFRXN3hqK3VDNWdZSlNZWjlsMFZvdWN4Y2NpbnZZQWJiT3htRnRO?=
 =?utf-8?B?Sndia3oxU2FMNFMwZ0l6anlaUFNjb3BSbWR2UnVwTFVRcmgrRWN1MC9aOUZI?=
 =?utf-8?B?eEJjZnIxWDZ2RHNnQ1BUaW1vTjdsQWhpODUyQVQ4bWszSGp5aEhHcFNqQlJO?=
 =?utf-8?B?akQ2cVNsZU5KMGl4ZFMvWGQzanNNTEpPVS8yZmN4U2FaZjRiRWY4UzNUWVZW?=
 =?utf-8?B?Y1F4YmR4UVNseWFHOHRuMHhXanhGREdjbGh3d3RyTFY1dC9WVlJCN1dDTFI2?=
 =?utf-8?B?Vlg1NEM1SjhYSXBiVGNJTVBlNEJSak45aHlkVU81Q2tNYnZLZGJGek9tVmlT?=
 =?utf-8?B?c3RhQlBsNS9pUWpBOWF0QWdwUUErK0dhdE8raWhGWkRNNThTMWxzckI3SmN0?=
 =?utf-8?B?Vnd1SVJnWjE3NTNaUmNXVU9WRXpNUHdZelpXUlE1WlYzcGNtZ0llY1B3alpp?=
 =?utf-8?B?ZkNmbEFKZUtBTE1jZ1RGRG9XMWhRYXlnTkNzVkFQbXNTTnB4RTU4bnNwbVg0?=
 =?utf-8?B?eTl4eW1EajdEL3lnakJ1VnlnaTIxQVZYMzF4OVRlakFhSVkwUlY3Ly9aVHk3?=
 =?utf-8?B?dGRwU2ZYVStqTmRDbnVzQTlrZ1NJbEFZTHBZUk56K0xXQkM1czBsdGFKNFpv?=
 =?utf-8?B?TmJWNWczSkQxUzFhdGo0aGlsOVZPRS94T21YRkFyNEN4QW9YRm1rcFU5L1RQ?=
 =?utf-8?B?L0JBTEI2cVUrQXgrVC9neDlQYmEyV2E1NjFHVnJQVG5ldGRJdGsxSzVYWU5V?=
 =?utf-8?B?LzNhTjYxOEtlNTJyT2h5Y3RJcVlMaS9uL1dNdFlvUkhGYVN4T0NFT3dpTmRP?=
 =?utf-8?B?VzhPTmdzS3NlUURlci9aak5Vb2RaYmdhQkFWS01mMWlEMmVuNjhJNW9lUFc4?=
 =?utf-8?B?SmZ0WWxxVXJ0UUtTU2xBR0JyZDQ3QWdRZnBxSmdOa3Npand1c3RaNWYzbkhF?=
 =?utf-8?B?MFpBdTU5bjZjSm4zbm5TeDBLTVgvZFZsdUJvcVI1azRGUmg3REl3TWlrYVI3?=
 =?utf-8?B?Nkc2U3VZdTVoZzI4SVJXWGdvU0hjaTdEZzI2NVlEaTFyUmZhdTMwaDNOOERP?=
 =?utf-8?B?QTBSb2kvbTFHcXp2TUZJQzZ6MlBhNG1FNDVFVEQzdWV0NDJTcnpKcjhRZFp3?=
 =?utf-8?B?ekdkTjFFTmt2SU9BcElwT1NoNTZ5eVRTZ1MwczBGYVZ5VXlrbXFWall5ekxF?=
 =?utf-8?B?dHFMWEtaQ25UM2ltT3BBZnNjUXU1dXZCaDVYM1lTUkZvSzlQZ0YrTHRlNm5v?=
 =?utf-8?B?UGpWeHBRRFQ3YW9IK2l5YVVNYlBpb3FXUjNPd05RbWJCQ1R4bGthaC96Sm1X?=
 =?utf-8?B?azRvWk9wME9Ub2JzODBMbEpyQTh0OVgvNlBFa2ZVbExWQ2dySEZ4aFNLY2JN?=
 =?utf-8?B?RThqMlhyMnl6a3ppb3J5ZmdKSnBjWDh0dGdHVjhpTHZBdVkrUkczc0wyZzR4?=
 =?utf-8?B?QzN3M2Q3eUpIeEprQm5tSDB5WEN2ZzlhL0o0VHBJSDJTaGlIMGI3dFIrRGJ0?=
 =?utf-8?B?cEl5WEZhZXh6bkRaWW1teTBXWXlHNkhKYmF3Vi9sdTJlakNuN29mM3FVUGZ1?=
 =?utf-8?B?UUFxQXRhTnRIaXJKTUJhWlBGc0FOckEra3FYd0ZZZ25HZUl1ZG5iNjArc1lQ?=
 =?utf-8?B?cmpsUjJjak5NSGhlaXI2NlpvUUFTU0ZlUEpDWnNjdDVRdFQwbFFiSUNpaDJI?=
 =?utf-8?B?YTc2ZkpsWndxTFZhZ3JCMDJPTlAvSzJ0SUtEUUtnWVgzS2pNcWJvT2ZWNUs1?=
 =?utf-8?B?dDd2UlJEYm5YWlNYc2wyb2E3N01icGowQ21lK2t5a3pHeExTckhTbmdRTzlS?=
 =?utf-8?B?eGQrbDAxSTUxMFNyMTcveDVzMUVtUlVaTHhJNUJlRGJoNmxXNmhGVUhFVzRz?=
 =?utf-8?B?N0ErWE0xNlVCcXdOVi9NWTJFejI5dzFDT3dTTFpMVHVPQVJBZVQvTnNZbVdG?=
 =?utf-8?B?dVBtRGZsYkZhOG5XNGs5Q2E2c3RPYlRIZVlzSVNjb2FhQXJ6WEZCVXFCUS9a?=
 =?utf-8?B?NlFMNHl5ZDdhdU1GWkt0bHRYUU9ycVVMYWVXWmFONW94TlJUdG0zajEwMElH?=
 =?utf-8?B?QW12WEF3dW10dkV3K2ttNGhUcGFQL0dNcERqRWtvRVY5a0FmTGw0QVpoWFMz?=
 =?utf-8?B?Tm13MHBYdHZRc3dzazdNWGdQcEFSdHp0cVduSmlJTkNQWFZ2YTVOWXBBSkRX?=
 =?utf-8?Q?l1ExMeLAEMKWu62wXxo6BXs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2861EB4FF4EB434095AB2059F1D7F5E8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab37d5b-6fa5-446d-edd0-08dac988da7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 17:18:04.4611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MB9xLAroqcj6heXSBHNxLR5BkFvWJK2Tz2VYMReWQo7RBOB5jTP9pVH2VmVpdFrN5y91Y2iAcMK41U9Tb5J2C7DyCPBWTkG+oUFbZEnsgXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7054
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIyLTExLTE4IGF0IDE2OjIxICswMDAwLCBTY2hpbXBlLCBDaHJpc3RpbmEgd3Jv
dGU6DQo+ID4gT24gVGh1LCAyMDIyLTExLTE3IGF0IDEyOjI1ICswMDAwLCBTY2hpbXBlLCBDaHJp
c3RpbmEgd3JvdGU6DQo+ID4gPiA+IEhtbSwgd2UgZGVmaW5pdGVseSBuZWVkIHRvIGJlIGFibGUg
dG8gc2V0IHRoZSBTU1AuIENocmlzdGluYSwNCj4gPiA+ID4gZG9lcw0KPiA+ID4gPiBHREIgbmVl
ZCBhbnl0aGluZyBlbHNlPyBJIHRob3VnaHQgbWF5YmUgdG9nZ2xpbmcgU0hTVEtfRU4/DQo+ID4g
PiANCj4gPiA+IEluIGFkZGl0aW9uIHRvIHRoZSBTU1AsIHdlIHdhbnQgdG8gd3JpdGUgdGhlIENF
VCBzdGF0ZS4gRm9yDQo+ID4gPiBpbnN0YW5jZQ0KPiA+ID4gZm9yIGluZmVyaW9yIGNhbGxzLCB3
ZSB3YW50IHRvIHJlc2V0IHRoZSBJQlQgYml0cy4NCj4gPiA+IEhvd2V2ZXIsIHdlIHdvbid0IHdy
aXRlIHN0YXRlcyB0aGF0IGFyZSBkaXNhbGxvd2VkIGJ5IEhXLg0KPiA+IA0KPiA+IFNvcnJ5LCBJ
IHNob3VsZCBoYXZlIGdpdmVuIG1vcmUgYmFja2dyb3VuZC4gUGV0ZXIgaXMgc2F5aW5nIHdlDQo+
ID4gc2hvdWxkIHNwbGl0DQo+ID4gdGhlIHB0cmFjZSBpbnRlcmZhY2Ugc28gdGhhdCBzaGFkb3cg
c3RhY2sgYW5kIElCVCBhcmUgc2VwYXJhdGUuDQo+ID4gVGhleSB3b3VsZCBhbHNvIG5vIGxvbmdl
ciBuZWNlc3NhcmlseSBtaXJyb3IgdGhlIENFVF9VIE1TUiBmb3JtYXQuDQo+ID4gSW5zdGVhZCB0
aGUga2VybmVsIHdvdWxkIGV4cG9zZSBhIGtlcm5lbCBzcGVjaWZpYyBmb3JtYXQgdGhhdCBoYXMN
Cj4gPiB0aGUNCj4gPiBuZWVkZWQgYml0cyBvZiBzaGFkb3cgc3RhY2sgc3VwcG9ydC4gQW5kIGEg
c2VwYXJhdGUgb25lIGxhdGVyIGZvcg0KPiA+IElCVC4NCj4gPiANCj4gPiBTbyB0aGUgcXVlc3Rp
b24gaXMgd2hhdCBkb2VzIHNoYWRvdyBzdGFjayBuZWVkIHRvIHN1cHBvcnQgZm9yDQo+ID4gcHRy
YWNlDQo+ID4gYmVzaWRlcyBTU1A/IElzIGl0IG9ubHkgU1NQPyBUaGUgb3RoZXIgZmVhdHVyZXMg
YXJlIFNIU1RLX0VOIGFuZA0KPiA+IFdSU1NfRU4uDQo+ID4gSXQgbWlnaHQgYWN0dWFsbHkgYmUg
bmljZSB0byBrZWVwIGhvdyB0aGVzZSBiaXRzIGdldCBmbGlwcGVkIG1vcmUNCj4gPiBjb250cm9s
bGVkDQo+ID4gKHJlbW92ZSB0aGVtIGZyb20gcHRyYWNlKS4gSXQgbG9va3MgbGlrZSBDUklVIGRp
ZG4ndCBuZWVkIHRoZW0uDQo+ID4gDQo+IA0KPiBHREIgY3VycmVudGx5IHJlYWRzIHRoZSBDRVRf
VSBhbmQgU1NQIHJlZ2lzdGVyLiBIb3dldmVyLCB3ZSBkb27igJl0DQo+IG5lY2Vzc2FyaWx5IGhh
dmUgdG8gcmVhZCBFQl9MRUdfQklUTUFQX0JBU0UuDQo+IEluIGFkZGl0aW9uIHRvIFNTUCwgd2Ug
d2FudCB0byB3cml0ZSB0aGUgYml0cyBmb3IgdGhlIElCVCBzdGF0ZQ0KPiBtYWNoaW5lIChUUkFD
S0VSIGFuZCBTVVBQUkVTUykuDQo+IEhvd2V2ZXIsIGJlc2lkZXMgdGhhdCBHREIgZG9lcyBub3Qg
aGF2ZSB0byB3cml0ZSBhbnl0aGluZyBlbHNlLg0KDQpBZ2FpbiwgdGhpcyBpcyBqdXN0IGFib3V0
IHNoYWRvdyBzdGFjay4gSUJUIHdpbGwgaGF2ZSBhIHNlcGFyYXRlDQppbnRlcmZhY2UuIFNvIGJh
c2VkIG9uIHRoZXNlIGNvbW1lbnRzLCBJJ2xsIGNoYW5nZSB0aGUgaW50ZXJmYWNlIGluDQp0aGlz
IHBhdGNoIHRvIG9uZSBmb3Igc2ltcGx5IHJlYWRpbmcvd3JpdGluZyBTU1AuDQoNCg0K
