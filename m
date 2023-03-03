Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E1A6A9DE7
	for <lists+linux-arch@lfdr.de>; Fri,  3 Mar 2023 18:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjCCRmA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Mar 2023 12:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjCCRl7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Mar 2023 12:41:59 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCE217CC0;
        Fri,  3 Mar 2023 09:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677865318; x=1709401318;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qQc9zd6N/QV5rER6yC9e005blfFYM0mugGNYKm2SBII=;
  b=MeRq49LTUXvj9oLKkbBj5+D4ciMVvTVc2yIgdKuTV+nMp/yh8tNs+gEz
   5aYyavBujpip7vjVr0GvuoBJDfwbVMc96RhJsRzXbWegXjLMbmSitxMTs
   in5k0WvLyfeR2Q2cVIuopwmWPOFQWeBcxkGEpjlQYSFeHTApsaPnVgOb1
   YrdZnIdsAfTtWB9BzwACaTuuk/iuSUaaNjjJWo0iUtHutTqmbkYpdE0+v
   93yTHO4DnRwo1YFSFZM7pQrhcEEZVnR4XvodFl7J3VyDax8WiRQ118ao/
   CtZ3jn/H7WtsjJSv7Fc5wUfcSfxF0NcBqu992DUUmgHi1K/TNSOsvuH+C
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="318929106"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="318929106"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 09:41:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="625430309"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="625430309"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 03 Mar 2023 09:41:53 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 3 Mar 2023 09:41:39 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 3 Mar 2023 09:41:39 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 3 Mar 2023 09:41:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kem+jnT2LLppiQC+lOqlKcHHpPO9EfU6Ehpl0hwMJMXP6ZJ4rRRc35cxFH5kkcCngkAw7lhwuL/rNdSSyOU7EiXMG0+dCABJQs13GKHdRWZFnG6WQQkjBx/gkPMHT0FrEfPLKTPVUaJsHtDEPiFznal94yLum7gLkrGlFZrw8YiWqoOsF13PgUDgYWytavkPMOeV1kV0vEKuQ2L2HCE67sE5rLbS3nqncrw2ZRdHvXufAivTt7bxeP6mO9qkR3kYFJoWv9LFVd+Y4gSBcLthec0v8QNvfFlj/PYeD8ZDiCVFn8DIROVPoJ5njcJgxRjN0U4nmjY56hrU6K9Z+ahOjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQc9zd6N/QV5rER6yC9e005blfFYM0mugGNYKm2SBII=;
 b=ZV3WigCHtN8DU49c7354VV9NKXJergXuBhXtO5F2w/RsSfTa++kgfS8xyGZogpKwZES6b0yEwIoI/l3iJIzN2cdlO6qCN0HghIlFxN9VIg7XZ4Fz/iDi7aQiaI78GPeIoiGeltvQC+O7Wp6iXGIrjhvHWOk/xrLZYFWhbVimFjOkCY7Xrd9sbjixV52Z08No4KFLs01lbsWuDwd4Z9Jo0tVAMu9hn2TrQu5n0bx49VZpNkiHFgV/aZgubeiXVyNaykvj0GHn/6tp4ZM9GO+V/AKK/kb2NkLhgh2A7RpdoRlZKkIRnVr4Q9izaTaoM2U8NCzJYN6jfzcfecDQWNvnkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CH0PR11MB5537.namprd11.prod.outlook.com (2603:10b6:610:d4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22; Fri, 3 Mar
 2023 17:41:35 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6156.022; Fri, 3 Mar 2023
 17:41:35 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>, "nd@arm.com" <nd@arm.com>
Subject: Re: [PATCH v7 01/41] Documentation/x86: Add CET shadow stack
 description
Thread-Topic: [PATCH v7 01/41] Documentation/x86: Add CET shadow stack
 description
Thread-Index: AQHZSvs0qmse+4pcp0Wr5jGCLtkFY67l/FKAgAA/GgCAAXK9AIAAVL+AgAFCGYCAABPTAA==
Date:   Fri, 3 Mar 2023 17:41:35 +0000
Message-ID: <8ce8464f9619a43e7505c815e1858c6df4f51759.camel@intel.com>
References: <Y/9fdYQ8Cd0GI+8C@arm.com>
         <636de4a28a42a082f182e940fbd8e63ea23895cc.camel@intel.com>
         <ZADLZJI1W1PCJf5t@arm.com>
         <8153f5d15ec6aa4a221fb945e16d315068bd06e4.camel@intel.com>
         <ZAIgrXQ4670gxlE4@arm.com>
In-Reply-To: <ZAIgrXQ4670gxlE4@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|CH0PR11MB5537:EE_
x-ms-office365-filtering-correlation-id: a88e93a5-39a0-4dc0-08bd-08db1c0e8900
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zCg6xRw5hMf0npUOMfrg8SaJ5H6SazRw5Gw4MDA6EI+IPjLdoz2559jqspmmZcv/LpzTTv5WKgGFR+25XKsa4R7x2TNZwouOvwlUSuw3NB59U7rqR5SKw1OL74q9zPFjEAOc9Ju16LmLJU1rbEYNnSr9VK23fGYvmIZgT2fE0yStz1IQIMeJXgrFfMAaT3xSd/17edYFCABaEdn0gKxjGD86qwA8YEmRihU0/tm6N9U7L1h44XGb2/9OWVchSPbossC3juov8dlV1chKQI+faHhL1tcox2nmXOEgLodDoUCR7P3prUHzjTW9+CBzRWHBbUAJogmrcnjSEGtVrJDAt6JRrC8M59EyaViWPhdi03eE3dHj7C0XBAtp3lWIiMRh6dwzO9Qgqtg9R8Mrd94dy0ciuTguGJvGchMH+yePIs9zK9PfpMYjjL+32XtnE8Oq8gVtynHXre3IIvYPKW58Zx4+EH4nkyJUkaUUywFlNgf1H/J5AMGjK77YjcJ0XuaTJ4PKHhxHsYfQovqFiYWgu6NsVtoFdedNjJqghS3bwxRFO61Q5mrup3wEFBmuK16+d5h6hWRbRKVNYGv21y/gyf/FwkOM4Qi6Udo16Zv59zlAv9MYSquarVrQhbXOUZPhvFgDwnDyOaPIF9wrzlsE+WPmrWuQ/2CwKyeLMeDLE7vU/zSNlXT/DN0VdHUfLlFcNOVw3GiIdiGCih73z71cK+9F97Xv3Wz+SY5pEBG9jr04jLg4FPP+dibWFTLgJCBa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199018)(36756003)(6512007)(6506007)(6486002)(2616005)(186003)(26005)(316002)(41300700001)(110136005)(54906003)(66946007)(76116006)(8676002)(4326008)(66476007)(66446008)(66556008)(64756008)(8936002)(478600001)(7406005)(7416002)(71200400001)(82960400001)(5660300002)(38100700002)(122000001)(38070700005)(91956017)(921005)(2906002)(86362001)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFhWZ3NkRGNNNEVqZURMRGxablQvUlV4Q1lZNVQ5NENieTFuNFJma05HOXV2?=
 =?utf-8?B?Q3JRWWVnT3lBcWdyb2M3RHhkNlk3WTNKMGdaUytrK3RvUzNPQ2d6S0VxTHRu?=
 =?utf-8?B?YndBK1I4UUc5OFYzU2pIUjdPZE8wNlk3akdnRk45ZE13b25mZjJ4NzR0OFJC?=
 =?utf-8?B?UUwyTlUvdFlDZUx2dUs1VVI2NVNKck9tNUxhNDBXbytsUnJEODdFRGdDRVMv?=
 =?utf-8?B?ZVN6bytEVHBtTGVXRGZGbzdNL2RCUElkM1NVQVpScHNoTlFQOUlXUlhBbHVR?=
 =?utf-8?B?azJJdC9NOTA3cGl1UGRSWktzYXBxZVFHMzlWYjk2aXliYXRFVkUxSmM2Rjkz?=
 =?utf-8?B?eXJLbEg2T3BYbVRQeTlFejVDSkxGMXM0ZkVmVEs4NUpJMGR2K2E5ZkVCVnl1?=
 =?utf-8?B?cEZpVy95YXZ2M1BiSWhicDQwbVVaYjVBOXlOVzRVclNPNkk3cnIyREpibDlP?=
 =?utf-8?B?N1NnVU9XYUJKbStYQ29NMk9QbmNPN0dEeHRCb0ZxMmxwREFocm1aWk1pbjc1?=
 =?utf-8?B?amF3R2d4WU9KL1FhZUtia1dHampwNHBYR1Y0ZWhxOEJmdEZoRkUwS1A0L3c0?=
 =?utf-8?B?TXgrYzNpN0djU1dsRTkrZU1OVnczZjNDaXlpTUF2K0sxVmdRVVZsOW4wUmRJ?=
 =?utf-8?B?bGNGSzROWkU4dGt5UXdmeXhVekFNVjBxUnVyL1pWYk1odjlrbzdEOVdhbTZB?=
 =?utf-8?B?UTJiWTJIZFI3Qys5WFIrdUR2T1phdWphMlh1eTR3VnU5aHBQdUJ6YktCQlNN?=
 =?utf-8?B?WU52VU8wbnBZTHNtZ08rMkkzdm5adU80aU1EUnZNc0ttVnFIYWZ1Uy9kMXNm?=
 =?utf-8?B?YUsvQUZVdXlvRjBSTWtWeTZDcDBUUUhaY0lwVFRvaWNiN1lEOFpQMm9zUE1I?=
 =?utf-8?B?NUNKRVhJMTlWUnplM3NnS0RKUGFzN0JZTzVpK0w4eTN0c0RabFJIclAvOXpC?=
 =?utf-8?B?TlZycTFOUzlLRGdlZVdDSUJwVCtia2t1TGtmZlJWMnJVOFJSUXBudW1lWWo1?=
 =?utf-8?B?UTdlKzhuallOcjh1eGgxSHNhVlV2QTBVVzNXZHBKWVA4T3FwRWljZE1ybVFO?=
 =?utf-8?B?T1UxaWNYZ0RNcGI5OFhwOWpva0lpZUhzMFVNN0QwajdKNWpuZTBkL3JlOWZx?=
 =?utf-8?B?K3NIOG1iOGRwblM1TWJHQWN5V0s3OEhhaDJPS0c2NFBMTGhYaWJzK3gya1Ez?=
 =?utf-8?B?WDBzOWhYZDhraTQ0YisvRGRPU0U0MVlUbVRzK05WUGFVWUM0OEI5b1RxOHhV?=
 =?utf-8?B?b0g4cHZPNi9JNThJTlRISTcvaExMRVYxdXU0ZU52b1JsRzNaTXZ5VFFWYWZw?=
 =?utf-8?B?K2J6SzZXUGhQUkhyaGgrMU1pU1J0Rmt6UDQwWTM5bTNNLzdtL3ZpR1I1MndF?=
 =?utf-8?B?dy9hSHVYQUFuallzNDVCRlB2VHN4SmxjdE1uWlMrckppcmU3TUhSQmtrcG1S?=
 =?utf-8?B?TmFORFFDU24xczZJMXJDWFEwWXVIV04zWVNrRkg1VlBIcVJvVHRJcEl4b3RH?=
 =?utf-8?B?YWpUZnpjOE5MaG9tZklOZVZlcDRFK1Q2WWtGQ0doZkxJdDZ4cjFaQzVkaW9q?=
 =?utf-8?B?K1RWYm9CcjNKSzRYbFhFYkxoektnT0hpaW01a1JKNFpnWUFacnI4S0tvM2N3?=
 =?utf-8?B?c3liRzZ3TEdYMFI2M0hBUkJXcDhQMlkyaUZ5SEpkbE5GUVJhYzAyYTlyQWJ4?=
 =?utf-8?B?ZUhOOUtNZC8vT1g4WHArbGZ0S1dpdkRMbFpJcmRVQ252YUFoa2dOeThMazV6?=
 =?utf-8?B?dEUzaTU4TWZDYmU2bktrK3NYNEtYWHl3MVhad0tUaGNrRXNoa3owdGFMT2xW?=
 =?utf-8?B?dlB1MzZtUnZGd3RQUG9QejZUOHpjMmxadHVrOWsxT1N6R0lFbmVNMmNLNXNC?=
 =?utf-8?B?QVlnRmlzaUFMZnU0V2dyRW9ldDVlcnpYM0dLNFJucUJWY25QMzNiWHg1aU9N?=
 =?utf-8?B?MW4vdktBYmVneWR4MmR5aHFTVHBZMXUzWEdOM204TVE1Ui9MTkVtRnhSQ0RG?=
 =?utf-8?B?dTNtUDkwUWZNNjNmS1NlOXpzc3hsaVRUOUF2c0txR01aampReDVMc3QrdlZo?=
 =?utf-8?B?RWxJejNJT0JnRWlhdXNhWUNXNXJsb1B6MXdibHZkdXl5aXRiT2R4bWJ4UnVm?=
 =?utf-8?B?TkhLK093NFMwZk9NZTRLM3YzQmVObjFEa1V2eUEzU2drOEpRaEp3Zm1UN2tO?=
 =?utf-8?Q?rCQCLtupPyWbvB5lrLc8A+o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <187AE3DD4C01F44F8DFAD7ADCF866AD6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a88e93a5-39a0-4dc0-08bd-08db1c0e8900
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 17:41:35.6501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QWOnxPgfNnJA8CijwxhsvZutqDQ9MEndhhvp0UrlLpOf30vebJDpEYDTSLV0p5mevMM+yBgaSlsF4+6J4US/+mYt1saDFl2fnRRqmmimuI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5537
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIzLTAzLTAzIGF0IDE2OjMwICswMDAwLCBzemFib2xjcy5uYWd5QGFybS5jb20g
d3JvdGU6DQo+IHRoZSBwb2ludHMgdGhhdCBpIHRoaW5rIGFyZSB3b3J0aCByYWlzaW5nOg0KPiAN
Cj4gLSBzaGFkb3cgc3RhY2sgc2l6ZSBsb2dpYyBtYXkgbmVlZCB0byBjaGFuZ2UgbGF0ZXIuDQo+
ICAgKGl0IGNhbiBiZSB0b28gYmlnLCBvciB0b28gc21hbGwgaW4gcHJhY3RpY2UuKQ0KDQpMb29r
aW5nIGF0IG1ha2luZyBpdCBtb3JlIGVmZmljaWVudCBpbiB0aGUgZnV0dXJlIHNlZW1zIGdyZWF0
LiBCdXQNCnNpbmNlIHdlIGFyZSBub3QgaW4gdGhlIHBvc2l0aW9uIG9mIGJlaW5nIGFibGUgdG8g
bWFrZSBzaGFkb3cgc3RhY2tzDQpjb21wbGV0ZWx5IHNlYW1sZXNzIChzZWUgYmVsb3cpDQoNCj4g
LSBzaGFkb3cgc3RhY2sgb3ZlcmZsb3cgaXMgbm90IHJlY292ZXJhYmxlIGFuZCB0aGUNCj4gICBw
b3NzaWJsZSBmaXggZm9yIHRoYXQgKHNpZ2FsdHNoc3RrKSBicmVha3MgbG9uZ2ptcA0KPiAgIG91
dCBvZiBzaWduYWwgaGFuZGxlcnMuDQo+IC0ganVtcCBiYWNrIGFmdGVyIFNTX0FVVE9ESVNBUk0g
c3dhcGNvbnRleHQgY2Fubm90IGJlDQo+ICAgcmVsaWFibGUgaWYgYWx0IHNpZ25hbCB1c2VzIHRo
cmVhZCBzaGFkb3cgc3RhY2suDQo+IC0gdGhlIGFib3ZlIHR3byBjb25jZXJucyBtYXkgYmUgbWl0
aWdhdGVkIGJ5IGRpZmZlcmVudA0KPiAgIHNpZ2FsdHN0YWNrIGJlaGF2aW91ciB3aGljaCBtYXkg
YmUgaGFyZCB0byBhZGQgbGF0ZXIuDQoNCkFyZSB5b3UgYXdhcmUgdGhhdCB5b3UgY2FuJ3Qgc2lt
cGx5IGVtaXQgYSByZXN0b3JlIHRva2VuIG9uIHg4NiB3aXRob3V0DQpmaXJzdCByZXN0b3Jpbmcg
dG8gYW5vdGhlciByZXN0b3JlIHRva2VuPyBUaGlzIGlzIHdoeSAoSSdtIGFzc3VtaW5nKQ0KZ2xp
YmMgdXNlcyBpbmNzc3AgdG8gaW1wbGVtZW50IGxvbmdqbXAgaW5zdGVhZCBvZiBqdXN0IGp1bXBp
bmcgYmFjayB0bw0KdGhlIHNldGptcCBwb2ludCB3aXRoIGEgc2hhZG93IHN0YWNrIHJlc3RvcmUu
IFNvIG9mIGNvdXJzZSB0aGVuIGxvbmdqbXANCmNhbid0IGp1bXAgYmV0d2VlbiBzaGFkb3cgc3Rh
Y2tzLiBTbyB0aGVyZSBhcmUgc29ydCBvZiB0d28gY2F0ZWdvcmllcw0Kb2YgcmVzdHJpY3Rpb25z
IG9uIGJpbmFyaWVzIHRoYXQgbWFyayB0aGUgU0hTVEsgZWxmIGJpdC4gVGhlIGZpcnN0DQpjYXRl
Z29yeSBpcyB0aGF0IHRoZXkgaGF2ZSB0byB0YWtlIHNwZWNpYWwgc3RlcHMgd2hlbiBzd2l0Y2hp
bmcgc3RhY2tzDQpvciBqdW1waW5nIGFyb3VuZCBvbiB0aGUgc3RhY2suIE9uY2UgdGhleSBoYW5k
bGUgdGhpcywgdGhleSBjYW4gd29yaw0Kd2l0aCBzaGFkb3cgc3RhY2suDQoNClRoZSBzZWNvbmQg
Y2F0ZWdvcnkgaXMgdGhhdCB0aGV5IGNhbid0IGRvIGNlcnRhaW4gcGF0dGVybnMgb2YganVtcGlu
Zw0KYXJvdW5kIG9uIHN0YWNrcywgcmVnYXJkbGVzcyBvZiB0aGUgc3RlcHMgdGhleSB0YWtlLiBT
byBjZXJ0YWluDQpwcmV2aW91c2x5IGFsbG93ZWQgc29mdHdhcmUgcGF0dGVybnMgYXJlIG5vdyBp
bXBvc3NpYmxlLCBpbmNsdWRpbmcgb25lcw0KaW1wbGVtZW50ZWQgaW4gZ2xpYmMuIChBbmQgdGhl
IGV4YWN0IHJlc3RyaWN0aW9ucyBvbiB0aGUgZ2xpYmMgQVBJcyBhcmUNCm5vdCBkb2N1bWVudGVk
IGFuZCB0aGlzIHNob3VsZCBiZSBmaXhlZCkuDQoNCklmIGFwcGxpY2F0aW9ucyB3aWxsIHZpb2xh
dGUgZWl0aGVyIHR5cGUgb2YgdGhlc2UgcmVzdHJpY3Rpb25zIHRoZXkNCnNob3VsZCBub3QgbWFy
ayB0aGUgU0hTVEsgZWxmIGJpdC4NCg0KTm93IHRoYXQgc2FpZCwgdGhlcmUgaXMgYW4gZXhjZXB0
aW9uIHRvIHRoZXNlIHJlc3RyaWN0aW9ucyBvbiB4ODYsDQp3aGljaCBpcyB0aGUgV1JTUyBpbnN0
cnVjdGlvbiwgd2hpY2ggY2FuIHdyaXRlIHRvIHRoZSBzaGFkb3cgc3RhY2suIFRoZQ0KYXJjaF9w
cmN0bCgpIGludGVyZmFjZSBhbGxvd3MgdGhpcyB0byBiZSBvcHRpb25hbGx5IGVuYWJsZWQgYW5k
IGxvY2tlZC4NClRoZSB2MiBzaWduYWwgYW5hbHlzaXMgSSBwb2ludGVkIGVhcmxpZXIsIG1lbnRp
b25zIGhvdyB0aGlzIG1pZ2h0IGJlDQp1c2VkIGJ5IGdsaWJjIHRvIHN1cHBvcnQgbW9yZSBvZiB0
aGUgY3VycmVudGx5IHJlc3RyaWN0ZWQgcGF0dGVybnMuDQpQbGVhc2UgdGFrZSBhIGxvb2sgaWYg
eW91IGhhdmVuJ3QgKHNlY3Rpb24gInNldGptcCgpL2xvbmdqbXAoKSIpLiBJdA0KYWxzbyBleHBs
YWlucyB3aHkgaW4gdGhlIG5vbi1XUlNTIHNjZW5hcmlvcyB0aGUga2VybmVsIGNhbid0IGVhc2ls
eQ0KaGVscCBpbXByb3ZlIHRoZSBzaXR1YXRpb24uDQoNCldSU1Mgb3BlbnMgdXAgd3JpdGluZyB0
byB0aGUgc2hhZG93IHN0YWNrLCBhbmQgc28gYSBnbGliYy1XUlNTIG1vZGUNCndvdWxkIGJlIG1h
a2luZyBhIHNlY3VyaXR5L2NvbXBhdGliaWxpdHkgdHJhZGVvZmYuIEkgdGhpbmsgc3RhcnRpbmcN
CndpdGggdGhlIG1vcmUgcmVzdHJpY3RlZCBtb2RlIHdhcyB1bHRpbWF0ZWx5IGdvb2QgaW4gY3Jl
YXRpbmcgYSBrZXJuZWwNCkFCSSB0aGF0IGNhbiBzdXBwb3J0IGJvdGguIElmIHVzZXJzcGFjZSBj
b3VsZCBwYXBlciBvdmVyIEFCSSBnYXBzIHdpdGgNCldSU1MsIHdlIG1pZ2h0IG5vdCBoYXZlIHJl
YWxpemVkIHRoZSBpc3N1ZXMgd2UgZGlkLg0KDQo+IC0gZW5kIHRva2VuIGZvciBiYWNrdHJhY2Ug
bWF5IGJlIHVzZWZ1bCwgaWYgYWRkZWQNCj4gICBsYXRlciBpdCBjYW4gYmUgaGFyZCB0byBjaGVj
ay4NCg0KWWVzIHRoaXMgc2VlbXMgbGlrZSBhIGdvb2QgaWRlYS4gVGhhbmtzIGZvciB0aGUgc3Vn
Z2VzdGlvbi4gSSdtIG5vdA0Kc3VyZSBpdCBjYW4ndCBiZSBhZGRlZCBsYXRlciB0aG91Z2guIEkn
bGwgUE9DIGl0IGFuZCBkbyBzb21lIG1vcmUNCnRoaW5raW5nLg0K
