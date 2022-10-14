Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F8D5FF41D
	for <lists+linux-arch@lfdr.de>; Fri, 14 Oct 2022 21:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiJNTfy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Oct 2022 15:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJNTfx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Oct 2022 15:35:53 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC7F127433;
        Fri, 14 Oct 2022 12:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665776152; x=1697312152;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XbI4yLHuucgYL5kZRlQJM5mGGR/uWfZ+rX3xWouyIaE=;
  b=Rr93Bfe+E1WGkRsV8ClAIKQoMzfcJ58cIO9wo2k9ATRWX5w0faUQPTCX
   c/ewByvbI5c2dnQrW7zvFruJuAG5apDO7JCyK2rKJztYgJRU5aNtD+QFP
   w6SCOIJwN5CdZEeTdKcMPm3v0Qc3zf2+aaHi5fja4zl4j5cj2XzjsoNcP
   LO7xsFoaGMfim10CIcve0X2dPq2YPKS1XibnrAKTGUk58SORP1V6nUxJ1
   FliwMKpUENoe8I1nwUuCxb4YI9MVOBnrcZa1dQnh6JIrNCyWh0uGv5dUP
   v5gOgQablKklg+/5CBqUyATltj/QtB4/c/nPIsf8jJCuJkgp+rHeA1Kil
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="369653159"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="369653159"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 12:35:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="690664362"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="690664362"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 14 Oct 2022 12:35:49 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 12:35:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 14 Oct 2022 12:35:49 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 14 Oct 2022 12:35:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2cXY4tnNdSPGR+2JaRLqBcniS0a7j247gmRX1xDITv+efSwFfujscSoIVbXA1pXDg1GcOvta+A/lA/kE6lXjwXtj01pJWI9tWEg0280WW3K9w+AowRIGFdcN/rVMnNQkRiVEItNmDmWtf3daKGN7h+89Jb732hZWbj2q/gKmRhCPZdmAMFITZfqjCFat7xpcw/oV/xEVmHn00aWyckwnCBFjWciQPAxDZsY/EXhaqTyogfU5x6qY7+uVrIbiQn8/JqBY3k6DapiRmR1TbYhXaSV7wcRlt0kZG78k16b4x6+nQMyanyYMY1UgiexsRKhk6c6fEX8sq7ngshTs/WoyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbI4yLHuucgYL5kZRlQJM5mGGR/uWfZ+rX3xWouyIaE=;
 b=bL61lnR3M+ynQjpM1LtcLfjTk3mOwYXLNKXatGea0f9PBreDt4e/Ua//UwA8hxA10/RuFR8Hc02pTHkDGVR9ocA9qPD+h3r6F+V/XlAbYGr/QZG6t8b1h2nrjeXpVAUjWK/j1OpiSwGBJYUSHYOUyeegRmn6N0+TUjPVCAdJlnRYbRfNwIZST8ZRFfHBEQbJ1WoJpcCB6dYJAKKK018FoFmqons/F5ky861MkFCj6AbPvH04I8oskzTeLYflYpEClFs/Wzi+qH1JBXKxVsblFgSWBxqr3OEBX4ix2y9ypss5aI+xaPRJj5w46LztEKUMSa/tZOdaT4InIFRjdrdnJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH7PR11MB6500.namprd11.prod.outlook.com (2603:10b6:510:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 19:35:42 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5723.030; Fri, 14 Oct 2022
 19:35:41 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
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
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 03/39] x86/cpufeatures: Add CPU feature flags for
 shadow stacks
Thread-Topic: [PATCH v2 03/39] x86/cpufeatures: Add CPU feature flags for
 shadow stacks
Thread-Index: AQHY1FMDSx+9BFjxpk+rUsHcCuNHaK4OKSQAgAA2fgA=
Date:   Fri, 14 Oct 2022 19:35:41 +0000
Message-ID: <6ff03d0ea266b99aafda06a72bf511cd5cc5f47a.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-4-rick.p.edgecombe@intel.com>
         <Y0mMVjzEox6Ck6iZ@zn.tnic>
In-Reply-To: <Y0mMVjzEox6Ck6iZ@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH7PR11MB6500:EE_
x-ms-office365-filtering-correlation-id: 0c8c7eaf-eb68-41c3-a87e-08daae1b47a0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x1kk8UugsHn0OdF6b3yYZZiAw11++0+xu5IdSrIftmAAZhfwaNpCa1kff9wUEb2N24P/Eysr9ACdcdI5t3siMkejETFOF4pnMAgDVZEFFkGsTdlYy1VDInsOkk9AyJjX6EndhQjLSL2MlkO1iBPqbImGKuHrpunIxjKWNVmBL8vqo+f/qnhzUqKEDIMjorcFFfERqZE8j5Htm6/UgGJphUF9U3ZZKjDbZ2fMSr5zXLnXpX05ApELYB2QJMbb7R/dmJf86I2RfJCSXbSxqRyWTgnXY+31xDBSYIoMrHKnNST+jUND9r/Me02Wpybj19cucQkb87itSzsRmSbaSFqIh76YrYZbMjqx4RVH7Dtrg1hJM94+3fAk4WExPk684Tw98G8mKOGwnEqdC6nG4s9oBk3osfDTr/SkSSNP3uNRcue22s3QeVASrwqmAvdQRzrTo2wo3WwlFEc4EIyeQma7J1A7eCx7rq+eY4+liXgjko4JKcdJqlGck6stsgA8F1K29hW6n9KzXsnkDDGXKB30hEWRSIRtyjq3uqNdRdDjnZFRxZGpFmOM/vcTavblzN9g7YFf3Vy4izM490FIzmD5cPlOD7egZxoM+PHCrYSIu2+eql1EXrWk+mfBzV/HB1BM4/sP5T8HhHU7oBcNwJOxTdlNrwo2oKuINfZ5mgEFHy6k3UOBnIdwahn+2obdDBdzbmLyFwz74F4ayY/TYTClJ1R3y92CNU9rJ73dDhNSYvu24XpQbC0ExEm+Y0MltDsAYPKUlrWJaJZ8jwnYX+ZBBkDVgEsGaBmX8wPQC6ltDbU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199015)(316002)(4744005)(83380400001)(71200400001)(66556008)(66446008)(66476007)(64756008)(4326008)(76116006)(8676002)(66946007)(91956017)(186003)(38100700002)(8936002)(54906003)(5660300002)(7416002)(7406005)(6916009)(82960400001)(36756003)(478600001)(2906002)(26005)(38070700005)(6512007)(4001150100001)(41300700001)(6506007)(2616005)(6486002)(86362001)(122000001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHp6c2tnYTFLNW9NbmY3RmkvaHk3b2I3MGVwT0FqQVN4Ulk3WHB2eVQ3OFVm?=
 =?utf-8?B?ZDcxNHV2aVg3R2IzNXdhemRYTjRuMnRleG44MEI2ZEVWeW5DajhPbTM0ZitY?=
 =?utf-8?B?S0dmMjFSUzNNRFhtWWdHWFZiT05Pb0l3cXljOHNNRGFjV3g2Um8xQzMrOGdy?=
 =?utf-8?B?YS9NR21pVXN6SlhsbzlYTXhVYUJpL0dlMUpRU0hCTDFOWVA0VDJaWnN4aTV6?=
 =?utf-8?B?bm8ya0swUEZja1gxRmZ3VEh5QjJVcXhIbUw4TG56eFN1WmUwNFhnYnVXVlls?=
 =?utf-8?B?TmViMUVLVU00ZnJZTUtQYnoramNFNkFReXA1eXNXc3RScXZ1eXF1czI0VW51?=
 =?utf-8?B?Y1RBSmJCZE94RVFuaGRvV24xaEMycVo2QmowMUU0WWFyVHZsL2oxSmpRcHBK?=
 =?utf-8?B?L2wwQWJQUS9FQ2pwNnkyakVyejgwdTZHS05BRkZaaytJMEo5WURROVFqOTBK?=
 =?utf-8?B?NVhLaWtzWE5nWmMzN2d1Q0hhWkk2U2JEdGU0YlBkT0FQa2pkblc1WDZXZno0?=
 =?utf-8?B?anFpMFlheTdyczdkRDhqSDNGOXFzSGtWc1p3bGhKMUxoUVNRcDFSbFhHQ0FZ?=
 =?utf-8?B?dnBzVC9CV1NLbmZkdnFLckdWUVB5b3VxSGVHc3RzOU5Fa0J6WHppYUg0NWVV?=
 =?utf-8?B?SVdqN3Z4NVBnSzV6aC9HcGNNL0MzSnlrQkdUVXFwRnBvSC9qRG9RVzZkRGhX?=
 =?utf-8?B?UjE3VFZuQWhSaXAyMERCWlNTNEtacGhmNTEzQkVZNGZMK1VOdStpTUROaURJ?=
 =?utf-8?B?T0hGT2tOdzFSZWUxc3I3bVppaGptTUtoSmUwUmV5TU5OZUVpZWc1dlBlQlN3?=
 =?utf-8?B?R08xTEd5Vkoyc2NQSjExVXF6ZUU2S0Fpb3k2aVVaSWxzNS9VVWE3QkdXM0tK?=
 =?utf-8?B?Qks4KzlOZlBCblFIUm1YVmFKR1grUjgyVG5kUE9rV2FiSWZiY0JSdXlwWjF4?=
 =?utf-8?B?eDBIRm1wTmYvbDZHOWh6eTVKQ1VuNlBJcnVRQmVlTWQxS2t3dXczLzdzcDEz?=
 =?utf-8?B?SThVTEhyekpsdGFHT00yNzNkSkZ1dC9zOHIxdXdra09OVGFpUTNMZFJIUGp2?=
 =?utf-8?B?c2h2WHd5TVF6MWFucS9pb3YrTmJIL1o0OFhtc2YyUGhzaWJEZzNDZVJYMHc0?=
 =?utf-8?B?b3hKR0RMam55amp1WWtGUmhMVjVWeDdvUEZVQk8yNmsrejVNcWlZSW1NZ0pF?=
 =?utf-8?B?aU5ZZFdVN3ZCVlZaQVllN0Y1YTZIb2ZNU0x6NnFoc2xnY01VeXAzWk1xcmd6?=
 =?utf-8?B?QUFMQ0sxdlNqdmphOWwvUXlVWUIvZnJ3UVVoeEFpOVV0SUpQOVREUTB3NUJD?=
 =?utf-8?B?V1dUdlhmdmNrUWNmYy9oL1RVUlh2ZzVVUFl2TEphRVhHdzRkRWJjTGI1WUV0?=
 =?utf-8?B?OWE0QWR6L0UrZ0ttQWJWcndkTG5SSzhpRVlKZDJ0QWpvUEhhM3ZRd0hwcks4?=
 =?utf-8?B?U3Z2cTJRTmx6WE9TTis3dGpySWZXV0ZkTGViTEkvbHg0eloxTkhxRUc3Y0xV?=
 =?utf-8?B?cGFmb05jVllVdjg0ZWlFb2JMR0R4djRQWDVTU2doSDhIRkovTUlLQ3hDOHFY?=
 =?utf-8?B?VFpEMlFheEhVdWZaclhGWnY0N21UbUh1WFRVbkNhTXVzZ0YxbHBacStqZzFp?=
 =?utf-8?B?ekhrdk5ieW1ERG9kN2M5cWc2ZCtGVTBaWG1GYmdBdWRZZllZMjZEZlExL0Rm?=
 =?utf-8?B?ME90MDV2cm5tOTMycGIrNzFSUnphYWt5S2VlY25rRHB1dDc0N3YzWGs1YTYz?=
 =?utf-8?B?d1IxQUVnSVFsOGhmc1Y1NnBHNHUwR2FnMElsZkhrVXVaRktvbFJLaUYyMldI?=
 =?utf-8?B?SklHZEJYb0xneWJ5ODhrRzNTZ0o1WnRQNU9QYVh2K2s4bVNaTnVMOG1wU1RF?=
 =?utf-8?B?UFhqcUhWWTBBbnpycXpMbnlESElueU85Y04rQ3o1T3NrQ2pMMFJwK2RZZVkr?=
 =?utf-8?B?MWs2MExLLzBoMUQ3MVdpNDdOM2s2Z0JNcjJXQ0w0c2FsR3RCek9vZVNWL3p2?=
 =?utf-8?B?VkQ3eGFDbXEwZ2RWR1U3Rmg5RFBkak12VkpwUDRyYVFLajFCZXlLM2NJdDhN?=
 =?utf-8?B?VW9TaGg5eXozdkdOVnB2YnJ4N0ExWEtTZVpHeVVESk8rTTFDYlJjRWx5NHZK?=
 =?utf-8?B?bTNoNVlyZEFNR0NnOGdxV0hrQzQ3TGZMVVZsL29GYTN6NFlybDlJVFNtVlZX?=
 =?utf-8?Q?oWRAMSPgH58sb3GIe1DNBvs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AEC1792C0785CA4D8F11295DA13F4297@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8c7eaf-eb68-41c3-a87e-08daae1b47a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 19:35:41.5251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xd7x9JB9Y2bnHDInfVp/FWp0yXhTTMhcb40tNE8VShJj8dOFc++wmv813iPeX/0iSPbCtriKHeQGK7gB03n5DVIJRAcAJQ4iUlUcpCtSZZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6500
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIyLTEwLTE0IGF0IDE4OjIwICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFRodSwgU2VwIDI5LCAyMDIyIGF0IDAzOjI5OjAwUE0gLTA3MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+IEZyb206IFl1LWNoZW5nIFl1IDx5dS1jaGVuZy55dUBpbnRlbC5jb20+
DQo+ID4gDQo+ID4gVGhlIENvbnRyb2wtRmxvdyBFbmZvcmNlbWVudCBUZWNobm9sb2d5IGNvbnRh
aW5zIHR3byByZWxhdGVkDQo+ID4gZmVhdHVyZXMsDQo+ID4gb25lIG9mIHdoaWNoIGlzIFNoYWRv
dyBTdGFja3MuIEZ1dHVyZSBwYXRjaGVzIHdpbGwgdXRpbGl6ZSB0aGlzDQo+ID4gZmVhdHVyZQ0K
PiA+IGZvciBzaGFkb3cgc3RhY2sgc3VwcG9ydCBpbiBLVk0sIHNvIGFkZCBhIENQVSBmZWF0dXJl
IGZsYWdzIGZvcg0KPiA+IFNoYWRvdw0KPiA+IFN0YWNrcyAoQ1BVSUQuKEVBWD03LEVDWD0wKTpF
Q1hbYml0IDddKS4NCj4gPiANCj4gPiBUbyBwcm90ZWN0IHNoYWRvdyBzdGFjayBzdGF0ZSBmcm9t
IG1hbGljaW91cyBtb2RpZmljYXRpb24sIHRoZQ0KPiA+IHJlZ2lzdGVycw0KPiA+IGFyZSBvbmx5
IGFjY2Vzc2libGUgaW4gc3VwZXJ2aXNvciBtb2RlLiBUaGlzIGltcGxlbWVudGF0aW9uDQo+ID4g
Y29udGV4dC1zd2l0Y2hlcyB0aGUgcmVnaXN0ZXJzIHdpdGggWFNBVkVTLiBNYWtlIFg4Nl9GRUFU
VVJFX1NIU1RLDQo+ID4gZGVwZW5kDQo+ID4gb24gWFNBVkVTLg0KPiA+IA0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFl1LWNoZW5nIFl1IDx5dS1jaGVuZy55dUBpbnRlbC5jb20+DQo+ID4gQ28tZGV2ZWxv
cGVkLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQo+ID4g
U2lnbmVkLW9mZi1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29t
Pg0KPiA+IENjOiBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9taXVtLm9yZz4NCj4gDQo+IFJldmll
d2VkLWJ5OiBCb3Jpc2xhdiBQZXRrb3YgPGJwQHN1c2UuZGU+DQoNClRoYW5rcyENCg==
