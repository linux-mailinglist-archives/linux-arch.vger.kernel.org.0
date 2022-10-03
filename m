Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3365F37F0
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 23:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJCViT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 17:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiJCViC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 17:38:02 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE52140E3;
        Mon,  3 Oct 2022 14:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664832996; x=1696368996;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lOgVoJnH+Q7I9AmdGcotGSHYV4BZE8/XjozrOeB/J1E=;
  b=O648cjutAXRYgJdY4f8YpBZWq62nNoJ9zB6Zum8wxbubTV4lCZbyDzMF
   Ig70FFk2aahwAhKml6g9d6QiXzDXMcvqNmN55I1oPpOBCvrCoDCm94fK6
   nG3urrbhbk+Gg7m/CepRaJn9i2BFpXoe357UEnu/Ng9KE/8UWcOduHf6G
   FUB5EcTSYyAfPMd0/PliZMlz12y682WZ/o5vyUHm8kzPnPqjQcIk0GISf
   y0Qo6m6GsZ7gGV8HvHQ/LjCFUdTkwDwNyP7c6pwWeSRy7GP5MVVB68tvp
   rdB3/3pbbuMb+fjSRGuBgviZttRP1njGtYvpaV1nsii6bgMaxCXrBmGCX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="366864265"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="366864265"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 14:36:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="601394594"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="601394594"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 03 Oct 2022 14:36:21 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 14:36:20 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 14:36:20 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 3 Oct 2022 14:36:20 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 3 Oct 2022 14:36:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnAhUXhD/u1VjcZ+Lspjo4G3Ibmb19qhgn1MlczpjgXqAdCgOorwJv293GduGHjsFvCn9McR+SaHazDueiWzQPmpcHos0NDo0mwzNmrkhSBgRTRfptF97IJx5oatWKVorfMfoYV+Zn12qHDaY8+YlpsSPdo3fBxxVvcoJv8+tOghHncs2UfOR7MR3zDV/O5rkXFrpe9O7OqeCV6oBnBmDBtNEwspKZPe01QRAOaBwhinEoOyYP02gnMQZk0b1NNGQzSLQHA4eZJ8v32F3p1XiZBRUg4mNIFhD4WeB+BJUnE/QK0zGIwi2OElUuTElA3r4+dyty2opuSh+L/3DNJBDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOgVoJnH+Q7I9AmdGcotGSHYV4BZE8/XjozrOeB/J1E=;
 b=N7HwFsiUIiaptBjFRq5z+VR8A7WKFvGinCFHI2AXXRAc8l6+pzGL6N+QOs0EU84fX5q/xtvGUy6Q1/VUhdhv4CVNQDeReXgee3Y2SBZ1D+7ZzMIDFR/+CfdgU0H19GtrOGie5ZM2HGp2SKxbtSoeIVBHvQ88WtiCxhJBWYflSnI467qxVPHo4XcRycT8aCbCJwB9UayCRznnCwI3r3tBLzUEJg8e0ZdEJsLQbhDfklEq475NFnNwCt7yHUVVBVUea+Eg1Ig7YG+yOJrlPlvE5oYk1hNZ/Sc1bXACYPNccHovhTOG1u5SPhHE+D4o5ywZ9QY9DXGuvB3g1W5Nmne+MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BL1PR11MB5255.namprd11.prod.outlook.com (2603:10b6:208:31a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Mon, 3 Oct
 2022 21:36:10 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 21:36:10 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
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
Subject: Re: [PATCH v2 10/39] x86/mm: Introduce _PAGE_COW
Thread-Topic: [PATCH v2 10/39] x86/mm: Introduce _PAGE_COW
Thread-Index: AQHY1FMOaUlv/a8lEUG05TjT32eaO6384Q6AgABWmIA=
Date:   Mon, 3 Oct 2022 21:36:10 +0000
Message-ID: <9e9f2ce8193ea2e86474ab999ad2a034c49d8b22.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-11-rick.p.edgecombe@intel.com>
         <20221003162613.2yvhvb6hmnae2awz@box.shutemov.name>
In-Reply-To: <20221003162613.2yvhvb6hmnae2awz@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|BL1PR11MB5255:EE_
x-ms-office365-filtering-correlation-id: 2ff87e53-b322-487e-1ea9-08daa58749d4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: imk3Fty4ocwF4k6eKhtUoVloGiC2Oq5BmKZFLWHJfSZHaGcPG9Z/RRq2t7wCuslyTX/BBUtuPAwtCjZdSmBMVY3HsoJ/+qcfut9gXKmLmmUCUwttFwPMs8okt7AdZ22pSxkwL3LDLMf/EPJ0LRb0sumNkVRGLrUoLIYkWFDdx7B01LeQ1SOEnb2UZNAD2VY/w0gLBgL5h0gqZo0iGvKowu/sAIkuPMZPA8JqVG+gIhomRRh/sxJOyszKYtnggDA7TaI2TlaXwe6PNTr2AZtfVrrGvoxz5/rzRG72rc/HCli5jYUSeByePygVG2AUq162iMjQR1b72mgc8dXNQc6/vgX9/hh/11EbknsbtFczZbIxnc4AXyA9CbbjkJLk6FaQb6CrqRkVy1I12LdS4+nlhmbHImicWdk9s3y+yioH1VMRfeRIAiO+n9dbgZtsItl6vQFq2tztgOb5P9Vg0FGI0aZbJyKTGWw2thPEkom38GT5w+d4O9vBSG9cU5qFXeqJyDG+EQ7owQEk0QFCEvGiXfN41uy782x6gTtiBp2bAX8QxFZoiYqGId4MSqbDmIHpWjVQs+ESlRwxBRHbyYMJuv1YfUT4g7LZ2Yl7GKcBDvvpd8wy90wGsVEsYVYjPWp1c3tXimXuxCuiS5I+O/BrOPXs/HzAzKPGlpVjNrq+om8rCsVz9ZIHw1AnpaPsQa/6KW5Oypf5PL3yTt+sR806QlWItyQJkgtdBnjoZ5JyOj0E6vo6EYDFnFpae0sDIkJVwfy6ITwMDwAtLaRdc8yn1boX68afDo9k+D7qSDjKXr8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199015)(316002)(6506007)(6512007)(26005)(38070700005)(110136005)(38100700002)(8676002)(122000001)(64756008)(66476007)(4326008)(66556008)(66446008)(76116006)(54906003)(66946007)(86362001)(2616005)(82960400001)(71200400001)(478600001)(36756003)(186003)(6486002)(6636002)(5660300002)(8936002)(2906002)(7406005)(41300700001)(7416002)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmhLMVJXZHc4YXFrOVh1dUhJdncxcXY1QUljalk5VWR3enlTQ1JLSS8yeHNq?=
 =?utf-8?B?N0FJcHBVd3A3RDhrak4reXRrMWk3ZGF4NkJ1Snd6bStFVUtWSDRPaElYM2hi?=
 =?utf-8?B?TFJiSlNiNGdkWnZIcGduaDRYYkQxWnRtaHNVRFdsVGdsQ0dzMzNGbm9DbjBI?=
 =?utf-8?B?TmZjendNc2Fha045MkhKc0k2c0QzT1JiY0pMZGE0VzZhUytncVFUdFBZaHRE?=
 =?utf-8?B?dkEvTnZ5VnFVeGRpZGdCYTB2WmVCU3RTczZtRWNKR0N6dkxpd2g0eTZOa2VR?=
 =?utf-8?B?dDBVaGFjSnVxVlFEZTVCMEYxdmtEM1lpa3dmS2E1YVJWd1dCL1RCUTl5YWpu?=
 =?utf-8?B?RjFFeFg3eUxoWFJ4bERkUjRzeUpjZ0xNWmNyNkE0Z0JUUVhNOExrUWVPbEhO?=
 =?utf-8?B?OGdHVjFoSnZOTm4xTnF1WURUb3k2R0NxNGE2WDhVOG5SNWxPVS95TVNVckR5?=
 =?utf-8?B?MGZKdU41WktES0hqZFliSDlGSEN5ZXR3eDJaOFBiUUV4VkFkRlhvbkUyYmI1?=
 =?utf-8?B?aC9kdmVOQlFoSEhIWHZDaXp2MXJoVUtJR3doOHdZOUE2T1FFZDRva1lJU3Jr?=
 =?utf-8?B?NmEvR2YyMjFCTXlVNDM4d1lLVExoa2QzaW1PRGN3dE5OY0RQRGNBN29SYmJC?=
 =?utf-8?B?cVBpSmJFd20zWUxSYXFBaHA0cEljb0ZVRnFyR3hNSDlYM2RVbVpqVGVtWU9r?=
 =?utf-8?B?MUh0eGMrZWRPN2NTNjRKYVZVSzdTMDdBQkJtVGgvM1RXZmYwbFBGeUxrN2to?=
 =?utf-8?B?MC9xSzBaWHNxZkdVZTBnU0QxWWt0NWxpRW1DWjd0UFlMQ1VqR3dxdVpXNGtr?=
 =?utf-8?B?YUtRWjVPNTk3SDVlQjlHK3d3T0JjLzAxM1M2eEdMd2tleHNoRzFPRXJzcUs0?=
 =?utf-8?B?dkhxK0VpT29hT3d1a3p3N2xOL2xQNDlpbHgyRERuaFkyUU4vcGllM2VTWlc0?=
 =?utf-8?B?NFlrTVlTSWFKSXFHbUNka0sxanlHZTgwbGFhTnZEMG5hdlZWelBJZTg0VWw3?=
 =?utf-8?B?ZXhpRm1jaVJueUFreHlrNmRJRnpzUTZsM20reXcwbWxIY2VzSjM5cDBZNlpH?=
 =?utf-8?B?Q1gyeldoWDUwY1BockZkdGxJUU8wVzFjK2pLNmc2Q3oxMEVFUSs5VjF0K2xB?=
 =?utf-8?B?UWhkNm5UN09YNGZMb2ovWWQzL25XRjROTjZYSkNPeVFDUjNEcFRBNzVLdUpw?=
 =?utf-8?B?bk44YnNWOXZLdlF5bWY0VGo4MWRQSFZNdndOdDd1M0gzRHk1M2U5a0RiNmxn?=
 =?utf-8?B?NjJ5UEd2NlFhcXQwZlZnSEpqZEErdi9aVVgvRTFkUnFjdFkweEJyTFVRbGFp?=
 =?utf-8?B?UkYwb1RXU1ZtVHl3djV3QVJjc2hJRk16NE01TlMwWWo3YW5sL2FwOWtvempB?=
 =?utf-8?B?V0dldTNXcTZRUFlRMjVkMThodkNoSWp4TFc2SWg5SjROSGFaSDVzL2tDdkNu?=
 =?utf-8?B?TjBLL3ZrQzNaLzQ5TVJDc0h4Q3pGYWE4QlNjb3BBTG55RFNSN1Z1Uldrajdx?=
 =?utf-8?B?RWZTUlplZmY1dnBqQXhtWnNIY2tqTkhzNUtORC81S1VqcmhMcGFrRGJWNzhT?=
 =?utf-8?B?OXBmc0QvbXF6UzNOOTN4cjdLQ0UwWmxiOEI5Umd3eVRxK2pCcUJKaFZha2VH?=
 =?utf-8?B?NExOSE5reTc4Zyt6RlhpdTJHSmdFcHFsNG1ycUt0Rk42dGh5YTBwVEllQXVu?=
 =?utf-8?B?VXNBUnBTWmMySzhpbUh4Vm5uYi9zdG0yTXUrMHlCRDRKRXd4M2R4V0I5OE9w?=
 =?utf-8?B?QnBVaWozN2d2NU9wOGNoWm10cGZ3a2dhSytJSDJKU2lKRmN4bGhvNXRPZHJU?=
 =?utf-8?B?Z2xjTklHSjdZM1VhWkZTQTd5MEY3WWMwekJDYXZreXp0c0poSTdBOGhIeWE4?=
 =?utf-8?B?VWd1R1MzZmVyZUdTclpGaDY2ME1HNlhpQmNOTUhqNEdQa25NeFZrKzNOemE1?=
 =?utf-8?B?UTBzZkxod1ZMSGkrc0RmUTI5bHNvbDFta1BVRUkrY01nWEtJTHFnQlBsUVkv?=
 =?utf-8?B?cTg2Y2JsZkYzYnpBcFRnL0h2cnZSdHJKTmhWRTVzV29lUFVJbzFPcThSNFJs?=
 =?utf-8?B?NWZrRHZVMmw4RDduRjJVZ3ZlR2lQU1BRV1NUVmF6c3FlK3JOVlhGV2FsakxD?=
 =?utf-8?B?U1pHSEt1VWVwSnhTK1N0V2tSaHgwUFFOMXBUaFlsSHZhd01Va2hYVjFUWVdw?=
 =?utf-8?Q?vxA+NqSl+QBDQUxK8gr6sd4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <06356F25474E1D44B5C13BEA4360B4E3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff87e53-b322-487e-1ea9-08daa58749d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 21:36:10.3527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: atZvAUq96Z5J6PTRqqJrsMNc8biMmJN6mtydln7HPirqRPSPRIh3ukF6tT47NAALbvarunedjIpJ9SmoFDi5Jke1qvr9pEKY8kYsn9UZaOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5255
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTAzIGF0IDE5OjI2ICswMzAwLCBLaXJpbGwgQSAuIFNodXRlbW92IHdy
b3RlOg0KPiBPbiBUaHUsIFNlcCAyOSwgMjAyMiBhdCAwMzoyOTowN1BNIC0wNzAwLCBSaWNrIEVk
Z2Vjb21iZSB3cm90ZToNCj4gPiArLyoNCj4gPiArICogTm9ybWFsbHkgdGhlIERpcnR5IGJpdCBp
cyB1c2VkIHRvIGRlbm90ZSBDT1cgbWVtb3J5IG9uIHg4Ni4gQnV0DQo+ID4gKyAqIGluIHRoZSBj
YXNlIG9mIFg4Nl9GRUFUVVJFX1NIU1RLLCB0aGUgc29mdHdhcmUgQ09XIGJpdCBpcyB1c2VkLA0K
PiA+ICsgKiBzaW5jZSB0aGUgRGlydHk9MSxXcml0ZT0wIHdpbGwgcmVzdWx0IGluIHRoZSBtZW1v
cnkgYmVpbmcNCj4gPiB0cmVhdGVkDQo+ID4gKyAqIGFzIHNoYW9kdyBzdGFjayBieSB0aGUgSFcu
IFNvIHdoZW4gY3JlYXRpbmcgQ09XIG1lbW9yeSwgYQ0KPiA+IHNvZnR3YXJlDQo+ID4gKyAqIGJp
dCBpcyB1c2VkIF9QQUdFX0JJVF9DT1cuIFRoZSBmb2xsb3dpbmcgZnVuY3Rpb25zIHB0ZV9ta2Nv
dygpDQo+ID4gYW5kDQo+ID4gKyAqIHB0ZV9jbGVhcl9jb3coKSB0YWtlIGEgUFRFIG1hcmtlZCBj
b252ZW50aWFsbHkgQ09XIChEaXJ0eT0xKQ0KPiA+IGFuZA0KPiA+ICsgKiB0cmFuc2l0aW9uIGl0
IHRvIHRoZSBzaGFkb3cgc3RhY2sgY29tcGF0aWJsZSB2ZXJzaW9uIG9mIENPVw0KPiA+IChDb3c9
MSkuDQo+ID4gKyAqLw0KPiA+ICsNCj4gPiArc3RhdGljIGlubGluZSBwdGVfdCBwdGVfbWtjb3co
cHRlX3QgcHRlKQ0KPiA+ICt7DQo+ID4gKyAgICAgaWYgKCFjcHVfZmVhdHVyZV9lbmFibGVkKFg4
Nl9GRUFUVVJFX1NIU1RLKSkNCj4gPiArICAgICAgICAgICAgIHJldHVybiBwdGU7DQo+ID4gKw0K
PiA+ICsgICAgIHB0ZSA9IHB0ZV9jbGVhcl9mbGFncyhwdGUsIF9QQUdFX0RJUlRZKTsNCj4gPiAr
ICAgICByZXR1cm4gcHRlX3NldF9mbGFncyhwdGUsIF9QQUdFX0NPVyk7DQo+ID4gK30NCj4gPiAr
DQo+ID4gK3N0YXRpYyBpbmxpbmUgcHRlX3QgcHRlX2NsZWFyX2NvdyhwdGVfdCBwdGUpDQo+ID4g
K3sNCj4gPiArICAgICAvKg0KPiA+ICsgICAgICAqIF9QQUdFX0NPVyBpcyB1bm5lY2Vzc2FyeSBv
biAhWDg2X0ZFQVRVUkVfU0hTVEsga2VybmVscy4NCj4gPiArICAgICAgKiBTZWUgdGhlIF9QQUdF
X0NPVyBkZWZpbml0aW9uIGZvciBtb3JlIGRldGFpbHMuDQo+ID4gKyAgICAgICovDQo+ID4gKyAg
ICAgaWYgKCFjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX1NIU1RLKSkNCj4gPiArICAg
ICAgICAgICAgIHJldHVybiBwdGU7DQo+ID4gKw0KPiA+ICsgICAgIC8qDQo+ID4gKyAgICAgICog
UFRFIGlzIGdldHRpbmcgY29waWVkLW9uLXdyaXRlLCBzbyBpdCB3aWxsIGJlIGRpcnRpZWQNCj4g
PiArICAgICAgKiBpZiB3cml0YWJsZSwgb3IgbWFkZSBzaGFkb3cgc3RhY2sgaWYgc2hhZG93IHN0
YWNrIGFuZA0KPiA+ICsgICAgICAqIGJlaW5nIGNvcGllZCBvbiBhY2Nlc3MuIFNldCB0aGV5IGRp
cnR5IGJpdCBmb3IgYm90aA0KPiA+ICsgICAgICAqIGNhc2VzLg0KPiA+ICsgICAgICAqLw0KPiA+
ICsgICAgIHB0ZSA9IHB0ZV9zZXRfZmxhZ3MocHRlLCBfUEFHRV9ESVJUWSk7DQo+ID4gKyAgICAg
cmV0dXJuIHB0ZV9jbGVhcl9mbGFncyhwdGUsIF9QQUdFX0NPVyk7DQo+ID4gK30NCj4gDQo+IFRo
ZXNlIFg4Nl9GRUFUVVJFX1NIU1RLIGNoZWNrcyBtYWtlIG1lIHVuZWFzeS4gTWF5YmUgdXNlIHRo
ZQ0KPiBfUEFHRV9DT1cNCj4gbG9naWMgZm9yIGFsbCBtYWNoaW5lcyB3aXRoIDY0LWJpdCBlbnRy
aWVzLiBJdCB3aWxsIGdldCB5b3UgbXVjaCBtb3JlDQo+IGNvdmVyYWdlIGFuZCBtb3JlIHVuaXZl
cnNhbCBydWxlcy4NCg0KWWVzLCBJIGRpZG4ndCBsaWtlIHRoZW0gZWl0aGVyIGF0IGZpcnN0LiBU
aGUgcmVhc29uaW5nIG9yaWdpbmFsbHkgd2FzDQp0aGF0IF9QQUdFX0NPVyBpcyBhIGJpdCBtb3Jl
IHdvcmsgYW5kIGl0IG1pZ2h0IHNob3cgdXAgZm9yIHNvbWUNCmJlbmNobWFyay4NCg0KTG9va2lu
ZyBhdCB0aGlzIGFnYWluIHRob3VnaCwgaXQgaXMganVzdCBhIGZldyBtb3JlIG9wZXJhdGlvbnMg
b24NCm1lbW9yeSB0aGF0IGlzIGFscmVhZHkgZ2V0dGluZyB0b3VjaGVkIGVpdGhlciB3YXkuIEl0
IG11c3QgYmUgYSB2ZXJ5DQp0aW55IGFtb3VudCBvZiBpbXBhY3QgaWYgYW55LiBJJ20gZmluZSBy
ZW1vdmluZyB0aGVtLiBIYXZpbmcganVzdCBvbmUNCnNldCBvZiBsb2dpYyBhcm91bmQgdGhpcyB3
b3VsZCBtYWtlIGl0IGVhc2llciB0byByZWFzb24gYWJvdXQuDQoNCkRhdmUsIGFueSB0aG91Z2h0
cyBvbiB0aGlzPw0K
