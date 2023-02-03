Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2DB68A6B7
	for <lists+linux-arch@lfdr.de>; Sat,  4 Feb 2023 00:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjBCXBx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 18:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbjBCXBu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 18:01:50 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7464B87591;
        Fri,  3 Feb 2023 15:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675465309; x=1707001309;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eMGnZkv9vX+xyDiV2wSKDrxf+0p1axGZsSCNNfjEnCs=;
  b=KFXJNm1sQTraP26tDkpp+SlzlqYVqtNYZycIgDclEmbOLHpZpW+elfdd
   e9vsVjEBY69TWkulXbyHe+wWPmn6une0bznuerySy3f/5FN+sAjooMZGc
   vYMtXqH71+mNxJnPNSmz4Va6MTy7kXvtrCnyHETzybLZxkakUrrrQ61W+
   JH46rTJYBk1WvkTAq8TziVHtOXz/HCrWBdgQ/ZKOZnJdN8PjgDSFLhDyS
   iCrSWwikpVD91I5zQESiupQShyHO3pjWS89YZniwUdeYqpRIjfGkstywp
   EWa9CsqiwKIHqlodq2rbxZk1Mdog1NA2/lcVobS54dq5odxFm50rskzQl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="356222933"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="356222933"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 15:01:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="754629104"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="754629104"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Feb 2023 15:01:47 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 15:01:46 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 15:01:46 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 3 Feb 2023 15:01:46 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 3 Feb 2023 15:01:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erS0XfkZZC+8ESXRHf7T+NX/Bp3v3lrykfeFHbQc+xNVB+Z1yuPLyQEdAEe4qCeq4ICi2bWgt9WE3PBRJqi/WfPK8B4jdjDKFxh5bn7kd3eWVbCr4ndSA+FOP5elWdQhuX984E6s5Bj5x//3uW3e1iPuNkx9b5jR7o8kGt4cLsdT98lQ/3dJgGYVcPz7+BTNPqDyb4ciiG1w1H6KyjPN7SmeKkyahxKSJPlw4AVFe8r5HDup+XhXlJQ+MlvvQNeN1frn7H++eII+cAnkhJqCfniusrp0D3UKehT9LXeZIieAFMC5krRmIACBhGW4xc4Vtv38NianyvjKOyVpky5ZIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMGnZkv9vX+xyDiV2wSKDrxf+0p1axGZsSCNNfjEnCs=;
 b=Lrz9pFxjdCTjpIzFmrVHhYOg1H12wkXe0CcStnlZGvBluNbglnIAMFT/dW3wQPkcvlG+ec1WWH+3EnvKSYyoEFd1dtnEmL999Qd4Ud0oYijqwmEiGIdv8lIZVcViCEkmlvGdg6A7ExRkInO3Xl/kWUdlW66hVbQ0Pg8qOdXT6V4ZhHBF57ZJ0+VeHgm9E6no+piuj84AYXuMrg0dcATM9HcCvZcqAgbqmYZvv+TGS53G1290uot2FQ5ZRkijUHma2VMfYb3Df/+QmuoEi6FXt+cB0Pfv5C7ptTycSdLw8s9NAjJPyClEagMIdo+hHFMIQTN6KBnp7/a/Bh2hLL4A0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH7PR11MB7002.namprd11.prod.outlook.com (2603:10b6:510:209::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 23:01:43 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6064.031; Fri, 3 Feb 2023
 23:01:42 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
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
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v5 07/39] x86: Add user control-protection fault handler
Thread-Topic: [PATCH v5 07/39] x86: Add user control-protection fault handler
Thread-Index: AQHZLExQ4M56KjXsiEavS5cSBSCSk669rWqAgAAEKICAAAWmAIAANyOA
Date:   Fri, 3 Feb 2023 23:01:42 +0000
Message-ID: <828f1b3154227c06ac1787961016464a4c116cc2.camel@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
         <20230119212317.8324-8-rick.p.edgecombe@intel.com>
         <Y91b2x8pSFtmB+w6@zn.tnic>
         <393a03d063dee5831af93ca67636df75a76481c3.camel@intel.com>
         <Y91kFGVFe6QlHKmi@zn.tnic>
In-Reply-To: <Y91kFGVFe6QlHKmi@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH7PR11MB7002:EE_
x-ms-office365-filtering-correlation-id: 9b62c7e0-61ba-42c5-08a2-08db063a9db4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NgYh15MPwzFmykBIDnbUW5ymcabfTMMXI3VTeYqm+VXjllpHLYCIgK0klxf4oIoVQtruequ4b7q/q8IhxQj6PHHlmryFElzgGnXcLBD2VmQVfzDoqRui+/k33KcjuhlkStLsUA9OVq/aeR/CU/AP0ejkuS6UkyWZPBN1YL0l6cNbc34I/Tco8DBuJS2zwiCdOroAjPZN/NfcZvFqhgeB5MdsjqNKdI9JHOeO259MUX5lzMEDN/HU0kAX5J9wSGDyfw/qfUHgXh4ESRCci4s7K3II6RL1wrkY2X/8T7YiH36gu/dP1sSmBjjWgm5B0WL7WDUffM/8IJeCg34+I9APW9p22uycb0yJUVhFtnfYbTYnuXwCBWIeq7xw5GLa5bHBOSWqRp59ZzDSZ6ye9ezBqSGk1WeTviOB3JFxJKF+nE06/hmo2zXYmoEuCJB2VTEXd28ORSeLxUjY1bdJ+xQu2NPXK3Py8mvvHF3YMbS9zyBYtu0TffQhSgj2fjcK4Z0PnLFxcm1wVkh/vqZ36nvNwhpbc2jcPu6O9R7zLzAcv7gWKbga6XaPB07JmVlMPe1tLzysnwPkYEgCLMafL8FPPa8lnif+c6TCcVaKr/xy7WIeT+lGiHceDtVqC9jOB+WkuDcXQQSKpgYHdzbSgml9qzf2yfnleTdyx80M4hNFqJzhsoI1lhx6+HFigYukAboTxygNaDYyXRP3ZMLdlWuO7tqQm7fh0gN7gvxyYiML6L0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(346002)(136003)(376002)(396003)(451199018)(2906002)(76116006)(36756003)(66556008)(6486002)(66446008)(7416002)(7406005)(6512007)(186003)(5660300002)(71200400001)(478600001)(26005)(2616005)(38070700005)(8936002)(82960400001)(86362001)(66476007)(41300700001)(66946007)(64756008)(6916009)(83380400001)(8676002)(91956017)(4326008)(54906003)(38100700002)(6506007)(316002)(122000001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0V2K2RBY2RPNXVUL3JBdHBheWJVSnc2K1M3bkNNbFlicWdnODE1cUR3WDNQ?=
 =?utf-8?B?YVhySTlYQm5KNDVBTzY0cFJQeSsvM0hDQUpHKzVJbWxtcndkTEZIUGx3a1ZB?=
 =?utf-8?B?L2owSXRKQnQrSDJ1OFplQXFsajYwNlRTalV2bm9yVWpNdmhwTGE1VWNRdzJO?=
 =?utf-8?B?bm5oRjk0WlRRTVJmQUJzQ1lYbTM3aytnRlNTQUNlTzJOSkR5blo3M2VGdDhO?=
 =?utf-8?B?M2k5akRCM0hNSGJMR3ZzWTErU0NZdkczbUhWbTg4a1NLRzgrOU11ZndtanRI?=
 =?utf-8?B?QXFtWXc0MXRHZTNDaHVPTDQvNlJHdDNwbTNtZTd4eWFCTXdxUUpWcndrOU1q?=
 =?utf-8?B?MWtnNDJ4d2E3czNkdnkxTTkvbkUrT2JWdGw1a2lSeEF3Y1hjMk92MVRUbVIw?=
 =?utf-8?B?YjJ3andIZy92SEhiWXR5SFIrS2E2aGcxbytrS0swcXdiZmoycWY2c211YkVt?=
 =?utf-8?B?Sk44ZW5CTjdQbUVmdThBV0k3amNNbmsrbXo1UkcwbWF1Q3haeU1ucFRmSVFy?=
 =?utf-8?B?TDBUNU8rdlcySDc1SlJKODhTeDBWNThYazNIVnhIMWUxNS9DVkZPc1NWVS8v?=
 =?utf-8?B?dEpPNy9KNmRRcHF3d2o2eTNDUVBCSVd1ZCswY0JHVHNsUWFwaEI0MkZlU0pm?=
 =?utf-8?B?TytCa3B1c1FIMGxCaW9vUHB2NnJzdjNSemtPUXlyOW1WS20zdTJaaWZvL3Z2?=
 =?utf-8?B?bTc2cFF4ZmNrV2VqME1JalZEWVhzbUpmaHNITjhyaVRDT2o5dmxRWmFycHh2?=
 =?utf-8?B?eVNTWmJQR2tqbXc1Q2VNMDBBZjRJZWJCZjl4dU9uYUxMU3N2WUVkaGp4ZXdo?=
 =?utf-8?B?QkJVaEE1UEFyc0JSTXcxUHBWQ1l6OVNoNy9tbVVOQjNKcU5pQ3Z1dENYMmVK?=
 =?utf-8?B?OUxOKzBpTVhQa0M1T3YrRXNKcUZPQmxtSkZVRkFTd05iUk0xSDR5bVFGazJM?=
 =?utf-8?B?Qk9JMGNxdXZtcTN1a1VkcjA0V0RxZS9pejVVNlVuN21RaW92ZzVnKzRxSWVI?=
 =?utf-8?B?TGh6dmxVTGdYMy94YnN6M1F0cFpJTnpNQWo0Mk90OWdNQkVWcnJwenRYa1hW?=
 =?utf-8?B?YTF4TTZVdE0wQ1hSbGJxWVUxemRJQXc3QXFmRWpwSVZCbDAxU1JGdWhXS1Zt?=
 =?utf-8?B?R0xuYzFDQ3pwaXdVQWwyNVJyWVhWbmpTbXZmenE2SnlBK2M2ZlJ4dkFDMjhh?=
 =?utf-8?B?UEczb1JxQThHNzU5MlBCWTZ5a1FzZkYycHl1Zmdhb3FnN1pKNSt3RkM2ZWUv?=
 =?utf-8?B?bExBNkdGRzVadWo1QWJCN0lZUW5mMW03MEVrcGtKVWR3T3cxMnhYeUpNaUZz?=
 =?utf-8?B?RVhKS3NGaFJvUU80ZmJDMDB1L2lCOHFNQ2FuUnhhdnF6NDIyaUREcEl2Rkph?=
 =?utf-8?B?WWxqbTRBSmpoSzdlMnFLWXk3VzZrdmNka2M3VUVkakFqZ1d3cFVTVCtUUmZY?=
 =?utf-8?B?cG5WYmFXSjFNUXpMbVVWZHBoQ3RFeG1HaEk2TWxwanJSV0k0aDB4ZjJuejRL?=
 =?utf-8?B?d2dVMWF4L09zbmJ0ZnFTd0RpV1R5eTFUL09FeWw3ekxHK1hoOW42K2IvMk1O?=
 =?utf-8?B?R2FHRktzemo2RzFScitUTjN1cnRPTnZmbFVzUExRK3BINmlWaEJYY3BsU1BN?=
 =?utf-8?B?bWtlMmtmbFg2NkRBWjV3WERnME9DUFZidVNwTWZvUlBmY1NXSnR3dURoelN5?=
 =?utf-8?B?S25PTFdxZitGTmxTMW8yNUNrbklRQzJSclFHRjBZVmdnU3kxdHJvUi9yRmdQ?=
 =?utf-8?B?b1FMd3BIZFN2VFZwWitId1lGTzdJRlVyT2t5THhMK1l1Qlc4dEtZdk5xenU4?=
 =?utf-8?B?UGhXa1U4N0pWNFZJMDR5VHpRZVQxdTM0RzlWaXhXcDRCT0NhVSs5bjVTVEdI?=
 =?utf-8?B?SFA5bmlaK08wRWdLbnBlVTh5cTR1WUl6VCtpWmJnV01pOHplcFdhSDJYOFZa?=
 =?utf-8?B?L0U0U1RIRW8xZ1Q0bUVkeXlrZHAycExLYXdoOERSejRKVkhlOXRxb2lZK2Mr?=
 =?utf-8?B?QTlkUndGMWUwTDl5WVhoTCtJbHlhV2I4VlRVL2sra0NDL3hLdmFrZklHSVVm?=
 =?utf-8?B?UFQ0SDhiNjQ2aHN0bXh0MHVxVGlsTTRUQngzck95RmY3d1J1Q2F4VzBJUVls?=
 =?utf-8?B?MXdFSVNqTjNWWnVhYWl4LytteEZwQXhQSGNHa0czY3BxSHFKTmdOeVpCVXdL?=
 =?utf-8?Q?uVGnUpDXAvg2UTLMtdfchgg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED34236A88452244B578E3DFCECC2349@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b62c7e0-61ba-42c5-08a2-08db063a9db4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 23:01:42.6592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dktWuXXrpSwfmORA9Beej+HeCGJ5RKyOrO1GDA7WXmh4k+dicEaRGBEACQtTkR218DFgsEUr7Z0DHCfxeHGFjijqmO70gmf/vcNlylt3cfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7002
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

T24gRnJpLCAyMDIzLTAyLTAzIGF0IDIwOjQ0ICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+ID4gSSB0aGluayB3ZSBoYXZlIHRvIHJlYWQgaXQgYmVmb3JlIHdlIGVuYWJsZSBpbnRlcnJ1
cHRzIG9yIHVzZQ0KPiA+IGZwcmVnc19sb2NrKCkuIFNvIHJlYWRpbmcgaXQgYmVmb3JlIHNhdmVz
IGRpc2FibGluZyBwcmVlbXB0aW9uDQo+ID4gbGF0ZXIuDQo+IA0KPiBTbyBJJ20gYSBiaXQgY29u
ZnVzZWQgLSB0aGVyZSdzIHRoYXQgY29uZF9sb2NhbF9pcnFfZW5hYmxlKCkgd2hpY2gNCj4gd2ls
bA0KPiBlbmFibGUgaW50ZXJydXB0cyBpZiB0aGV5IHdlcmUgZW5hYmxlZCBiZWZvcmUuDQo+IA0K
PiBTbyBpZiB0aGV5IHdlcmUgZW5hYmxlZCBiZWZvcmUgYW5kIHlvdSByZWVuYWJsZSB0aGVtIGhl
cmUsIHRoZW4gdGhhdA0KPiBjdXJyZW50IGNvdWxkIGJlIHRoZSB3cm9uZyBvbmUgaWYgd2Ugc2No
ZWR1bGUgaW4gYmV0d2VlbiwgcmlnaHQ/DQo+IA0KPiBJT1csIHNob3VsZG4ndCB0aG9zZSB0d28g
bGluZXMgYmUgc3dhcHBlZCBzbyB0aGF0IGl0IHNheXM6DQo+IA0KPiAgICAgICAgIHRzayA9IGN1
cnJlbnQ7DQo+IA0KPiAgICAgICAgIGNvbmRfbG9jYWxfaXJxX2VuYWJsZShyZWdzKTsNCj4gDQo+
IGFuZCB5b3UgY2FuIGJlIHN1cmUgdGhhdCB0c2sgaXMgYWx3YXlzIHRoZSByaWdodCBjdXJyZW50
IHdoaWNoIGNhdXNlZA0KPiB0aGUgI0NQPyBPciBhbSBJIHdheSBvZmYgYWdhaW4/DQoNClNpbmNl
IHRoaXMgcGF0aCBpcyBvbmx5IGZvciBleGNlcHRpb25zIGNvbWluZyBmcm9tIHVzZXJzcGFjZSwg
SSB0aGluaw0KaXQgc2hvdWxkIGJlIHZhbGlkIGVpdGhlciB3YXkuIEl0IGNhbid0IGJlIGR1cmlu
ZyBhIHRhc2sgc3dpdGNoLg0KSSBjYW4gc3dhcCB0aGUgbGluZXMgaWYgaXQgbG9va3Mgb2RkLCBi
dXQgdW5sZXNzIEknbSB3cm9uZyBhYm91dCB0aGUNCidjdXJyZW50JyB2YWxpZGl0eSBJIHRoaW5r
IGl0J3MgbmVnbGlnaWJseSBiZXR0ZXIgYXMgaXMgYmVjYXVzZSBpdCBpcw0KcHJlZW1wdGlibGUg
Zm9yIGFzIGxvbmcgYXMgcG9zc2libGUuDQo=
