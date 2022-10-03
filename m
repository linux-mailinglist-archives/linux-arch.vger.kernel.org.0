Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03F95F35B0
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 20:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiJCSeS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 14:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJCSeR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 14:34:17 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABA641D2B;
        Mon,  3 Oct 2022 11:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664822056; x=1696358056;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=d0HSGbJhM+CqgxBaOLjcX0eJ2zNUAIWLwfiAnLFCvn4=;
  b=d2087sRSXe5DBBhKM6InYAJ/OuI0q+pBzBVrA8fW/Z9+pq5/IfMqLo3H
   YWsOjfReQirlrWz+scAr2awiKhPDvAbKC3vNeD3VhXbZ8ivUmN0DjOjXm
   rgMkiLPo0XtPVZuIX58Sf0Fcdy4VOAx8dijD2AxW0K7n65fE+zxbmDsbJ
   SXTXjlZ8LwPD7Ekz4m1k/q2zEYfGmiVpuXTGOG02s1xQ8iKGtJIPPdRl8
   gD7GlOz4yxjZIoKVWyed1ucZOdTW/kw5kioqYgH7zu42oIiW8rLPtzM9q
   m1oPS7SHKcOYJLVBiULmdSsxYR1LeICKan5GUFnuDBOq6AuCiA7AJ5pM3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="300329434"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="300329434"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 11:34:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="601341883"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="601341883"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 03 Oct 2022 11:34:15 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 11:34:14 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 11:34:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 3 Oct 2022 11:34:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 3 Oct 2022 11:34:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HV4wj0yQKS+B3RbqLtpAPNU+LkJF5lOuaFlvfCC+VrPTg2kDNzL/OI3BdZW7kQyG3gbxQCZUrVUKO2HV60C00N5WTAJdyRniDYDAT1k9pDpzgfkF4OG6SxDz9MosUWl77WoJnE8DujXmc4yD/fSgV3606xBEggV4gHFK1QaasA10SJ+8PWI/6KOpkP1+eGtaVC3NyG4XE/9nOb5xlkKUW9GSCoCOH6in9ZYYk0nEevMamOmNlOhp1hNrbR1U4AfPJuvgoEkxevktH0ibXrc06RUh8QseOmxhMHB2X4yoGaJ1TmdFYng9ufGkgV0Fyo+Y3DrUmKfxpodM6dkhXw+B3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0HSGbJhM+CqgxBaOLjcX0eJ2zNUAIWLwfiAnLFCvn4=;
 b=keLahUAAY5B8fTcMduQi7B+2qJN3Fw6KUA6uZ80nH4XHnNyi/th5mD0I9lbJwLrGNdb1a9gikBo6Bb+H4IVvl1p26QxAnBau5xg9q+qEWnzq9KqbsoUlie8+14HhtNmpwBcm40NdTOFY+LFHhkmNFibEn08sqU9t2kXByIC6v3AZg5bhl/koom5Cy27Gmi8MD83QFTQR2zRT0asglqpvuWRhn1G2MJmYLMOI3GlhFpwxxNVRCmBKVH+bi/aRJuqQb4fe42g0kZ82eOAK+ej+GPNXkdbM4+H7Zgo0XtxZ8NwO/Xf4265buQ+kkxreLZ+Ti9jabU9+kNNoCwH7IYjSAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DS0PR11MB6446.namprd11.prod.outlook.com (2603:10b6:8:c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 3 Oct
 2022 18:33:52 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 18:33:52 +0000
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
Subject: Re: [PATCH v2 00/39] Shadowstacks for userspace
Thread-Topic: [PATCH v2 00/39] Shadowstacks for userspace
Thread-Index: AQHY1FL+PZNXoimaQEWxF6O0RvydXK3868UAgAAY8oA=
Date:   Mon, 3 Oct 2022 18:33:52 +0000
Message-ID: <7c85acd79688c5ea41f760535612ef77093a41c7.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <202210030946.CB90B94C11@keescook>
In-Reply-To: <202210030946.CB90B94C11@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|DS0PR11MB6446:EE_
x-ms-office365-filtering-correlation-id: 691cd510-1e5a-49fc-a2e5-08daa56dd253
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NH7g1xZ9JxEbNFQifxKeBh2dbIT4CufjXBhINowv/VD2R8p7gZxoxmbmm0L25v12JoYiabp9txvhXNo1dHMODt15KneH4fR2AcvQI6sLvYK9gPEH3T6YY0DLzFfXLVbebguAk7wXEdtWZEPsfd7BLDQTa3771rXuu3KlDZ1JGIpsjQXPAc1Fn+6oUGB6NvN9aaJYZI0m3E8LasZWgjM6cIHspCWa+SGSabtq3+dyCtuthRqnHah+FSAx+U7+GlAK2OutJqWRHifUI7jxoCHIUGLU8R2W8K7O928kc140zFXnjUkwjUQpBzJ9/QAVqv8TnZRMH1XL1hLubnNPtKX09/lVPkZrRIxfUFwjQGzp5WbBR6TW3pqPLgbOOSkCSJBn0m7BGfwIvnG+pacawSSWaHsS91MUiMvfSrw7lbX70GmOZ30SVbqEVoof044uHfLx5BI8jFLXZz4n+j/f5+CegGmKvp8UbdP5/yqDlaq+foXt/NOKXnfnyYLGGwzVnU1WgnXEcva6pvfWlo+XcVBjhSp7MG8knYz6ZeVW4qf5dRO1MgReUzVFU8JwX16QwiYO32wpk01ZdS2CJVv+ppenVtBql1EqbayXdUQwG1YuIchASa5pW4Z6H1dKbKzgevDC2mzcFb/o4Vps4cRWCa1UZs2HipNOoD70QAT+CQM1PI+NQ2vQmQbUvrw/qZ6A+tA4uQM3e2LzJlO9twi+2HPSiZAhqMgXsXOWVzaW4fnoa9Au4uLHCPcRm2afi1jF73yrOKLNb8K2HDBdQPUofcoVsxsWBlTXNBKm9jD+zGybzvY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199015)(7406005)(5660300002)(7416002)(8936002)(2906002)(41300700001)(91956017)(71200400001)(36756003)(66946007)(478600001)(82960400001)(86362001)(38100700002)(6486002)(122000001)(76116006)(6506007)(6512007)(8676002)(66446008)(64756008)(26005)(54906003)(66556008)(66476007)(6916009)(4326008)(2616005)(316002)(186003)(38070700005)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzlyNzg2VUdKUldjYU50eVk3dWFERnJwdEVyYmcwY2MzU1pESGRCSHE1SWx5?=
 =?utf-8?B?NmFQcUhuVFNXZ28vWk9OaUxiYjBwN0tNN2ViVjZnUjBvdG85YTNJZlBRMDIz?=
 =?utf-8?B?MkowaEpoME90cWo0bVJtZG1nVDliZ2pMMHZkenRRS3F1VXRQaWFKRSt3eVlY?=
 =?utf-8?B?SFA5b0FvWmZ5Z0RZTEVQWDNFTTF1QWlWa0ZBd2tTSW44c09CL3d5eVR6UzBW?=
 =?utf-8?B?MTFDZms3VHFNTzFvVlB4ckR1RGNienZncXVwcm54SDc0TGZad01MeVUxc2k5?=
 =?utf-8?B?L1g5MzVUcWtzYVJjem02emlYdnVKaElvSi9EOWlRSDJSNkxiZExWd3FPdDlR?=
 =?utf-8?B?bFZDKzBnU1BQQlNqS1Nqb3liRVJ2WkNpM3hPT2FRQXFubTFxMEtRR2libjE3?=
 =?utf-8?B?cW4xK0ZvNlJkQVdmYkFCcXpFbHo1MjRnM0VHSHpEQVA3elJFVUhSTHVzVm93?=
 =?utf-8?B?eUFQYXloR09yL3ppQ2NiVHJxQWQwUWd0cXhCR2dYK053aWlsektxNGREMDlt?=
 =?utf-8?B?Yk4wMlFOblh4WWNVemtoVmJJVlZHS3Z1cTdQc0dPMXAzbVhCQnd6R29FT0Y3?=
 =?utf-8?B?UnVkTnBJRTlJNXg2TENoUTN3ckpHcnh1QlFUY0U5V0RLY0lHekN0R2w2RGd4?=
 =?utf-8?B?SG51SVpRNDQ0TDdmc2dmRFZSTjBTOGNRSjFicnJHeENqNjJIZ291MDBETkdh?=
 =?utf-8?B?R3lxUGJBNXYzWjlxS3BVZzZEREx3NDFLMU15OG1iTkhhdjZaVC9UY2tOb3VO?=
 =?utf-8?B?dHlHSU0yRy9jbFl1S2tYK0prMWkvMlhwS2dxVGk5QSsxY2tmaDRYdzRFOXgw?=
 =?utf-8?B?RGFONVdtaU5HeUQ0Q1hHVEcwSmtzRlIwV0NuTlJWQmtQQ0FvQ1pKOFQ4ODJD?=
 =?utf-8?B?UjhoMWpKc1NDaW5lN1AyTnpzOHIvZzFTdkY2WTlGOWJqWkVQYUgrNEdoNkhT?=
 =?utf-8?B?M3FjcVhTNVArblladFkrakpDeDhVUTYydUpmaGdSRVVKc1hTNXhpYmdzQnJR?=
 =?utf-8?B?b1NDcTl4Y1kwOUM0a2ovMkZPVEhKUitMMEFoWGc1and5dlBVN3ZrTGxjdG1T?=
 =?utf-8?B?bVhKcWNBeENiVlc1TWFkaEpHT3FncmRJZ21oM2NMa0k3SHZyYzlNbzVZTmhj?=
 =?utf-8?B?dkZrSk1laVR2L3FQMkx0QUNYTUpSQ2RDbjE3VitBUUtzMm9oTkFpcXRxMzlD?=
 =?utf-8?B?anpxU1hVTUx1RUtIbU05dEpZY1hScVRrVC9nSmZmb3BsZGF0V09jaHRDR1B3?=
 =?utf-8?B?NURVNFk3U3owYUg1aklqOGhzMDgzU01lQkxvSFF2bjI3aEhXaWx4cGNHck1p?=
 =?utf-8?B?N2ZZTkxCMFUyZDJwVXJiS3p6TnovNTZtc3dLV09SUEFOMHo1NlVZaVcrbG4y?=
 =?utf-8?B?Nnk0OFdocFdWUUhkRzVEcTZkdzhSUSs0VVRsVk5JOEZjbGl6aU1XdkEzSWtQ?=
 =?utf-8?B?Z1dYaU1Bbm9yNDhkdmR3ck8vaSs5MEtNWTNGclV4SWxmb2hXOEMwempFY2ND?=
 =?utf-8?B?QTRpemVQTitHYnBCZWx3RG5TNmN4a3dIMXlyRVFGWStEekl4empRd3RUakp1?=
 =?utf-8?B?VFlNQW1KbHQ3TGQzeEYzR20vTExBanlsZHdielc3MG5MZDZ4TmgzSHlKSGhK?=
 =?utf-8?B?TkpEMDJSK2xJZm50RDArL01DNUdaKy8xM3pWUlhhSVhpdFFjdHFiNEI3Tm4y?=
 =?utf-8?B?OGE5Y2QraUxkYmFVYkU2RURFNFpkWDY1RDRQZWJ0cFFBZE05OEZGNDU5VUdW?=
 =?utf-8?B?WWtaYmtvNWJhczIzYmxTZytPQUViS1hzeWN1KytCc2wxRUZpeUNYN25ONnVW?=
 =?utf-8?B?WXNQY0lmd3ljNXNrLzFEMzVQeTZ2Z3hIZnlwV3hlU1lMNnUwTkVzZmpDc1g0?=
 =?utf-8?B?OHpaL0VuK0RaYU4xUXBDRUQxRmhubDRzOVc5bTU1WE82dUdhZDVFclZqeWJI?=
 =?utf-8?B?Q2JCdTZCSWxBTTZaQndQS0RReklnNWQ0WTdGQnp3NWc5SWpqSEttM25qZ1U5?=
 =?utf-8?B?NklYT2VQMkwvZzg4Zy9sZjFoYVR4VkRJdlZRc3RtS29raUI2eE85VHV6RkRq?=
 =?utf-8?B?R1lSZVk3ajNjZHRYUlIrNlJ2bStqa1JiTkNJL29zRHB1eG4rb3hYZ0t1ZjFh?=
 =?utf-8?B?eWtPSmkzNHRKcTZFWkRrUGRsQzBVa2RvemViRkcyM0JpNUlIOEdkbHViejli?=
 =?utf-8?Q?InZksY96pWYb7XWFUhAwmTc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7477686F97EF994CA7947ED14FB4E847@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 691cd510-1e5a-49fc-a2e5-08daa56dd253
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 18:33:52.4436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wNYoPw1GNs0UgHwsUKXj6S8fhaqpUwCrEhvjg//7EUn9298masKtMKlyecm+LYEjBNOs6XeOp2ZCoDO1Ge8AIapDaTqTfa31hzej1HkiOEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6446
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTAzIGF0IDEwOjA0IC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+ID4g
U2hhZG93IHN0YWNrIHNpZ25hbCBmb3JtYXQNCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiA+IFNvIHRvIGhhbmRsZSBhbHQgc2hhZG93IHN0YWNrcyB3ZSBuZWVkIHRvIHB1c2ggc29t
ZSBkYXRhIG9udG8gYQ0KPiA+IHN0YWNrLiBUbyANCj4gPiBwcmV2ZW50IFNST1Agd2UgbmVlZCB0
byBwdXNoIHNvbWV0aGluZyB0byB0aGUgc2hhZG93IHN0YWNrIHRoYXQgdGhlDQo+ID4ga2VybmVs
IGNhbiANCj4gPiBbLi4uXQ0KPiA+IHNoYWRvdyBzdGFjayByZXR1cm4gYWRkcmVzcyBvciBhIHNo
YWRvdyBzdGFjayB0b2tlbnMuIFRvIG1ha2Ugc3VyZQ0KPiA+IGl0IGNhbuKAmXQgYmUgDQo+ID4g
dXNlZCwgZGF0YSBpcyBwdXNoZWQgd2l0aCB0aGUgaGlnaCBiaXQgKGJpdCA2Mykgc2V0LiBUaGlz
IGJpdCBpcyBhDQo+ID4gbGluZWFyIA0KPiA+IGFkZHJlc3MgYml0IGluIGJvdGggdGhlIHRva2Vu
IGZvcm1hdCBhbmQgYSBub3JtYWwgcmV0dXJuIGFkZHJlc3MsDQo+ID4gc28gaXQgc2hvdWxkIA0K
PiA+IG5vdCBjb25mbGljdCB3aXRoIGFueXRoaW5nLiBJdCBwdXRzIGFueSByZXR1cm4gYWRkcmVz
cyBpbiB0aGUNCj4gPiBrZXJuZWwgaGFsZiBvZiANCj4gPiB0aGUgYWRkcmVzcyBzcGFjZSwgc28g
d291bGQgbmV2ZXIgYmUgY3JlYXRlZCBuYXR1cmFsbHkgYnkgYQ0KPiA+IHVzZXJzcGFjZSBwcm9n
cmFtLiANCj4gPiBJdCB3aWxsIG5vdCBiZSBhIHZhbGlkIHJlc3RvcmUgdG9rZW4gZWl0aGVyLCBh
cyB0aGUga2VybmVsIGFkZHJlc3MNCj4gPiB3aWxsIG5ldmVyIA0KPiA+IGJlIHBvaW50aW5nIHRv
IHRoZSBwcmV2aW91cyBmcmFtZSBpbiB0aGUgc2hhZG93IHN0YWNrLg0KPiA+IA0KPiA+IFdoZW4g
YSBzaWduYWwgaGl0cywgdGhlIGZvcm1hdCBwdXNoZWQgdG8gdGhlIHN0YWNrIHRoYXQgaXMgaGFu
ZGxpbmcNCj4gPiB0aGUgc2lnbmFsIA0KPiA+IGlzIGZvdXIgOCBieXRlIHZhbHVlcyAoc2luY2Ug
d2UgYXJlIDY0IGJpdCBvbmx5KToNCj4gPiA+IDEuLi5vbGQgU1NQfDEuLi5hbHQgc3RhY2sgc2l6
ZXwxLi4uYWx0IHN0YWNrIGJhc2V8MHwNCj4gDQo+IERvIHRoZXNlIGVuZCB1cCBiZWluZyBub24t
Y2Fub25pY2FsIGFkZHJlc3Nlcz8gKFRvIGF2b2lkIGNvbmZ1c2lvbg0KPiB3aXRoDQo+ICJyZWFs
IiBrZXJuZWwgYWRkcmVzc2VzPykNCg0KVXN1YWxseSwgYnV0IG5vdCBuZWNlc3NhcmlseSB3aXRo
IExBTS4gTEFNIGNhbm5vdCBtYXNrIGJpdCA2MyB0aG91Z2guDQpTbyBoeXBvdGhldGljYWxseSB0
aGV5IGNvdWxkIGJlY29tZSAicmVhbCIga2VybmVsIGFkZHJlc3NlcyBzb21lIGRheS4NClRvIGtl
ZXAgdGhlbSBpbiB0aGUgdXNlciBoYWxmIGJ1dCBzdGlsbCBtYWtlIHN1cmUgdGhleSBhcmUgbm90
IHVzYWJsZSwNCnlvdSB3b3VsZCBlaXRoZXIgaGF2ZSB0byBlbmNvZGUgdGhlIGJpdHMgb3ZlciBh
IGxvdCBvZiBlbnRyaWVzIHdoaWNoDQp3b3VsZCB1c2UgZXh0cmEgc3BhY2UsIG9yIHNocmluayB0
aGUgYXZhaWxhYmxlIGFkZHJlc3Mgc3BhY2UsIHdoaWNoDQpjb3VsZCBjYXVzZSBjb21wYXRpYmls
aXR5IHByb2JsZW1zLg0KDQpEbyB5b3UgdGhpbmsgaXQncyBhbiBpc3N1ZT8NCg==
