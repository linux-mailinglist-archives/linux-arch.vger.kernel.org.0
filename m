Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC615F39E6
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 01:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiJCXiw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 19:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJCXiu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 19:38:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD3D3D58A;
        Mon,  3 Oct 2022 16:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664840318; x=1696376318;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=krx9BILux0iVl562acCF4Uk0w8y8tsMCy7J9dq2LVVQ=;
  b=P9KoZbLkog8IV2qu9pGPUGMU0YBzSChrsGQIYpRwWXcgjC5nWfHuRocA
   ndXXXyoKDKaD9GCMbYjtnjwF2HK419FnLYA9/3+Mt1TSWfE6P+27+fsFi
   i5iVe1Qh7LviTYNFc4CoQ+UKTm+qU/Cgu4ktGdWGdHtYVFzo3ai6bm+iD
   tmcZM/spGbRPoc9Miij94OTlZZzRiy6tBd3vCmxnnouka38MKe+KK5AMC
   ynbeSvmnCUfY3U76Pfc0yGhaNbQ9fF6QvJp1qb/Mp09ncVF3qjWxsMp+z
   69xtdxlmifbH1gmAfCYrMR1/W0Nhj+WoudLCrGESgAZvxjpqNEoa8TWjz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="290006519"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="290006519"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 16:38:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="712817544"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="712817544"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Oct 2022 16:38:37 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 16:38:36 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 16:38:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 3 Oct 2022 16:38:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 3 Oct 2022 16:38:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/IZL14fQJgTXxs68WCZnMq6cPwRld43h00FuFGD2v3OeMj43T0/cCVtM8isx0MnrKvsyOxYALxidHK8o6NQl0X6nRkPSMadzW+8SdRTtclu2qSgh+DXNvU7c2mud/Q42q+3VdylranT0giVun20KXMsFMun6pJoRbvBAwL2T+ZNFljtQnMvfHrv7wkFZakK2sdpIV97OQmgXDCEL4eN81kWyFSEmm50NxcwWzwszhpbFhAXPGkvjqRpSqPYN41eVRoBhre/aqWaFTThQTtTEG2yu/SnqdPd4zny8cMSnYKcqhqtSDNJ9tgR8oH1Yh1txxyDH/mlTDhN/7h3DlAPow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krx9BILux0iVl562acCF4Uk0w8y8tsMCy7J9dq2LVVQ=;
 b=W/6D8MGFOPrQDbTXrCJ5FjqjvXiFOyhzoojCb1gHCPyq5kl6io0zRi+hzIQJej5gcT47uZkkWUBWhbPPer0eedX22Euz9DenQYM0g5umRUrorAYJruXLuyuCTL1IXi0XlNpSahMQHPcMmXFB7VXqbmuzgaK5++K+mxopR0EhmrsVa4zLSVjPR69GXOPjZxnVOrsHhwAfzNsZJacXdRlvd8tKBNbJn1YYtpGIPTs6JGMcEQ5pr4az/5sg1PK709ztfhqVVI1dzgQg3xQUWVduH1k4oLD71t9gnV6hzC22V4Vm9+WP6S5BUqJBaNeIu2fydCZaGM/Mk9YEsHcGgT5UOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by IA1PR11MB6444.namprd11.prod.outlook.com (2603:10b6:208:3a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 3 Oct
 2022 23:38:23 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 23:38:23 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "nadav.amit@gmail.com" <nadav.amit@gmail.com>
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
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
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
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 12/39] x86/mm: Update ptep_set_wrprotect() and
 pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
Thread-Topic: [PATCH v2 12/39] x86/mm: Update ptep_set_wrprotect() and
 pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
Thread-Index: AQHY1FMUATa463BSCk+10IV661tk3K38/nyAgABHr4CAAA3mgIAAANiAgAABR4CAAAObgA==
Date:   Mon, 3 Oct 2022 23:38:22 +0000
Message-ID: <547f2a8a87c255c58dbf2350013f72649dfcdc10.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-13-rick.p.edgecombe@intel.com>
         <E5D7151E-B5A6-4BEA-9642-ECCFC28F8C8E@gmail.com>
         <64313344833c3b1701002a347d539e69276b66fb.camel@intel.com>
         <35EEB9F0-D99A-4664-9628-27029B52CFD1@gmail.com>
         <65CF3B29-BF53-4BA3-89D9-5398CEB7F813@gmail.com>
         <FF5CBF3F-A66F-4923-BEAC-D1C95DAB740D@gmail.com>
In-Reply-To: <FF5CBF3F-A66F-4923-BEAC-D1C95DAB740D@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|IA1PR11MB6444:EE_
x-ms-office365-filtering-correlation-id: 8be2ba63-d014-4a15-9d01-08daa5985c47
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yD9t4N1LBEBFdCQhYDFkBG7Jp3ztwDvT1sX1SipJcOsuYTVj3RRw7XPnJnELQmy8//IauVn/dpSxeF25ilMuili3OhNOnEoSK0IiDygrPeak3AhWHpxKlxqJJ5jNDSBZ61L67gVh08tfOS6w1RqZheVOiPOB6k/WQ+POhYQ5h2QorlsqlJbU8DN5Gj5FqIY6+BAFmHC/hY0FoIKOrK5FazLmVzo0gpWlphDXBiIdsq3GsmpI7va+3kgpuBrYK3N7172yz68t6DdecVH/X3qIDD3H6rQ1tu5kAA0CFBbyTn7B8BRURTIpzl+IZI+eh/hiVtqx6XZ/VS7uJVgAJ8hwyn8kBykmHdCsalK18+hpWLjiuAAz3k8SE9IqlaDtr4qrvbXx0+7mzXNanlqRTdZ65HSsvlCn9R3tmdhsM+V/ZlNdI+WFVIsZkiZ61pab1nJe6U1+WHLUJrPWswKaBsOR9tQqZjlIrljusvR1+9jzcRbNs53AbvybmSRYDQ/JMlwgPjr3xF1WLRbbUIfnVr/wEz+7eLcqWsHrQsYNJbHJ70iOcrC65UDP6gNu5a82vqWmIx14haC5ySIPcpmdpcbCy75YfPBoRcUhwZe8TouyR0Bw2YcPYgjdaLJyAhnVdUcmv1XXPDmTGIzwElzkHgDIL9OfoKvhK1zDuFXd6djwbe43qcNNGRzaUPUn6O2mrNfIM8zSk47e3o6onhd7wNOvXWHipKyN/NnX+a5pANZ0UOp8LBKuFBfWArCWwooPKCFtxzhn0WHbGoyDzAKxMLCDhee347wh9LBad844gKFPqPwB753wLOUOJ0c4qa7FrmSE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199015)(54906003)(86362001)(478600001)(6916009)(83380400001)(71200400001)(7416002)(7406005)(5660300002)(41300700001)(8936002)(36756003)(91956017)(316002)(76116006)(4326008)(6486002)(64756008)(66946007)(66556008)(66476007)(66446008)(8676002)(122000001)(82960400001)(186003)(38100700002)(6512007)(2616005)(53546011)(6506007)(38070700005)(26005)(2906002)(99106002)(14143004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUh1bjVHRDdscGFJMDhJNjFUeXZUK1ZRV3h2RTdMK1FDZWVoUmJRelFXcno1?=
 =?utf-8?B?WjFoMjdEd3VFUXdTNHBqYmxCUENDMXJXelFzZGJSNTUyN0dNdjZ1VjJYd1di?=
 =?utf-8?B?THFzVVo2YlVwRUxVQUNLN09LWFl0a3p3L0VpTTllTndZSTZIRFJreWo2Rmdl?=
 =?utf-8?B?THFycCtEVXRIL1pQQTdMMU9NM3YvU0w0ZGN0UXBsM0FUejdzanNZRUwxWmJL?=
 =?utf-8?B?MURXZm5lWXpONEErNEhPZjI2TkordGE2UTAxOWNiLzl6S2ZWQXBOamh1RlUy?=
 =?utf-8?B?UlFnU1dUUXJSTm1IVmlNQlRYc0JveGlDZGlFbFQvczZ3RldmVzF6L1FuR1d5?=
 =?utf-8?B?UDFkOHpWRUV4MmIrOXBJdGp4WmJGQ0Q4alVXUHA5WmEzN3JMbXZpTmN3ZFZG?=
 =?utf-8?B?UDhiUXE3MS8xazNKQnJDWFBGNVZ2LzNWaUlvMTBtMEdKMVRPS0ZiN3hhUDVD?=
 =?utf-8?B?V2UzOHVKcDcwVllleHBKL3RmalNKSTVrR05nNjl2WFFvOFJEVXB1aUdZSkNT?=
 =?utf-8?B?RHlWYWZmZjRBbjQ0TlpXV1YwTjl3RzMyTHVuNnJYNXpIaTFsb0dwTkZRaHNs?=
 =?utf-8?B?MHk4eUJpcGVsLzd5OUwreVB4QmdlaTZtSkpPMlFFN3NvSEhPallUZWJKYU56?=
 =?utf-8?B?YXVmNGVhM0o1YTFiWngzTDVtM3o5SmtMR0FzSk9VNFdYZUhlNDc5UW1iN09h?=
 =?utf-8?B?cTRIQ2x2NEJYdnFkSllISWx5TGVxcy9ZNWNoSzdpK0Z5bzZtYlYvN25vV05o?=
 =?utf-8?B?TnBlNXdFWDFrNXExQk5DeHVQQ05Cd0VpL2FLK1AyMGphTFZhZm1uQURMbUtx?=
 =?utf-8?B?UnNqaHJiTTdTdFlYNndWLzRyUnhBTkx1ZlZtMnlySTA1YUVaeHBkYnVPSU5I?=
 =?utf-8?B?ZUpvamlaRDJrT0UwU2RGVGlKSWN3S3BxdUQvTGNOMGwxVVFCNHBpVldnVk1T?=
 =?utf-8?B?M0UyZXBla0VpQnBpeWVOcDRpRitheThkMWZSelY3NUk2RnJ0NHZqazBwSUVY?=
 =?utf-8?B?aWc4YmVQYmxFZXA1MlpwOURyakgwcUpSZG1aTUZXa1NTMzJmQmRyY2tOWEMv?=
 =?utf-8?B?QnMrdGZHVVl4R3VzcmQzcjBIM1NFRzk4NFJqRWhqMnVvMGNXenRnKytZL1hm?=
 =?utf-8?B?eWJpSEk2UUFaQ0E0YzlmekJndGI3ZHM5UEVhZWJDREsxOGxYVXpPeGFVdHB5?=
 =?utf-8?B?WDg1OUhjTlhJWmQ1OGdERzgxS1lsMHFPeHFsa2k1S3hSajVNaFBCQVFCL1NN?=
 =?utf-8?B?SGRQcWtZVDNSdTlSaGxRcFBVRVovWjQ4dXJPU1lDRTdhbFZTTjc5TWFxZk9E?=
 =?utf-8?B?elV6aDVOdC9mWXZqNGZUS21SbkZtQWx0a2U0S3RrK1dZcTdQZm5YT3Q4bkg1?=
 =?utf-8?B?ZHp6dmRadG1HalJsTHQveVNrK1Y0cHZjc1hqYnlQa0JEa0JmQ2JZeXJMYlM4?=
 =?utf-8?B?VjBhdEJKNGIxMTRNOVY3c0FrMi9jWWNpL21MbEdETS9lTkszRG90eGZ5Rjd4?=
 =?utf-8?B?VGY0RWpPMFk4dmtJbk44KzkxWkdmZHhPcS80QW1HSFZJSGtXenhtMjdtVHlC?=
 =?utf-8?B?cURCMlQ2WHRpVE9jQTBQU25ITEhHZkxmMC9vTzIxajYvbVBTcTNrTS9hbkVr?=
 =?utf-8?B?YnZRUFRKYzNIdDg3UkdtcFVZL0tWRGJ4cTA0VmsrVnJ6dEYvUmRLeXVUUzA3?=
 =?utf-8?B?SHhVVGtrMGR2SWpBTnJvSjgzQnZjcjZSa1NnQzJaR3ZrcHJsYmFVWWZwVHBo?=
 =?utf-8?B?dUdoc1R6d2Q0MXJjYkxYSDhlaDlGLy9CRFN6cWJJK2lWSHpBRGNkUDJDZFhQ?=
 =?utf-8?B?ZU80M1FyeDJ5Mlo3elNFZndpWkorQUpPMWlXczJzNmt0M05JMEEvT0VEc2wv?=
 =?utf-8?B?V1RBUlV2eWpzUVBmYUZSVjlZNjNOVG9VdFBNejV6ak1LazQ3YU01MFc3S2Va?=
 =?utf-8?B?RTk1Tk8zTWh1QnlaYzd3bmtWMndVWm8rcXQ4MmVoc2xpRkhLa3dmV2Npc0M5?=
 =?utf-8?B?NDlIQlVrdjkzd0VGSkZVeE02eEN3RUR1UHp5NGtsZ2tFdDNOSWs4aEViL3JU?=
 =?utf-8?B?c1c2Nm5NTlR1QXRidEZVeUZRanNSTXRwbDdmVVN5UmZLSmlrQTEwai8xek9w?=
 =?utf-8?B?S2hHOE5qWWNydk5iSGFQMnNQUXZjWE4zVUxoSlJ3YzFjK1dMdkNSV0IrQUVO?=
 =?utf-8?Q?VyglslA1bighMEI6/PStmh4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B52E1B4902942E47860D7AB42A3BAB37@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be2ba63-d014-4a15-9d01-08daa5985c47
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 23:38:22.7843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pRs2LfuelJ8WhiODmPtkAmIzJ0FNSM/yrT4TZbi0hWZ+KNIHWCjbo3p0sis+IYv3a8KpcvFNi0F82T4k7/HrdSPC+8qqcYPFeJh999n8O6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6444
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

T24gTW9uLCAyMDIyLTEwLTAzIGF0IDE2OjI1IC0wNzAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPiBP
biBPY3QgMywgMjAyMiwgYXQgNDoyMCBQTSwgTmFkYXYgQW1pdCA8bmFkYXYuYW1pdEBnbWFpbC5j
b20+IHdyb3RlOg0KPiANCj4gPiBPbiBPY3QgMywgMjAyMiwgYXQgNDoxNyBQTSwgTmFkYXYgQW1p
dCA8bmFkYXYuYW1pdEBnbWFpbC5jb20+DQo+ID4gd3JvdGU6DQo+ID4gDQo+ID4gPiBPbiBPY3Qg
MywgMjAyMiwgYXQgMzoyOCBQTSwgRWRnZWNvbWJlLCBSaWNrIFAgPA0KPiA+ID4gcmljay5wLmVk
Z2Vjb21iZUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiA+IE9uIE1vbiwgMjAyMi0x
MC0wMyBhdCAxMToxMSAtMDcwMCwgTmFkYXYgQW1pdCB3cm90ZToNCj4gPiA+ID4gPiBEaWQgeW91
IGhhdmUgYSBsb29rIGF0IHB0ZXBfc2V0X2FjY2Vzc19mbGFncygpIGFuZCBmcmllbmRzDQo+ID4g
PiA+ID4gYW5kDQo+ID4gPiA+ID4gY2hlY2tlZCB0aGV5DQo+ID4gPiA+ID4gZG8gbm90IG5lZWQg
dG8gYmUgY2hhbmdlZCB0b28/IA0KPiA+ID4gPiANCj4gPiA+ID4gcHRlcF9zZXRfYWNjZXNzX2Zs
YWdzKCkgZG9lc24ndCBhY3R1YWxseSBzZXQgYW55IGFkZGl0aW9uYWwNCj4gPiA+ID4gZGlydHkg
Yml0cw0KPiA+ID4gPiBvbiB4ODYsIHNvIEkgdGhpbmsgaXQncyBvay4NCj4gPiA+IA0KPiA+ID4g
QXJlIHlvdSBzdXJlIGFib3V0IHRoYXQ/IChsb3N0IG15IGNvbmZpZGVuY2UgdG9kYXkgc28gSSBh
bQ0KPiA+ID4gaGVzaXRhbnQpLg0KPiA+ID4gDQo+ID4gPiBMb29raW5nIG9uIGluc2VydF9wZm4o
KSwgSSBzZWU6DQo+ID4gPiANCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgZW50cnkgPSBt
YXliZV9ta3dyaXRlKHB0ZV9ta2RpcnR5KGVudHJ5KSwNCj4gPiA+IHZtYSk7DQo+ID4gPiAgICAg
ICAgICAgICAgICAgICAgICAgIGlmIChwdGVwX3NldF9hY2Nlc3NfZmxhZ3Modm1hLCBhZGRyLCBw
dGUsDQo+ID4gPiBlbnRyeSwgMSkpIC4uLg0KPiA+ID4gDQo+ID4gPiBUaGlzIGFwcGVhcnMgdG8g
c2V0IHRoZSBkaXJ0eSBiaXQgd2hpbGUgcG90ZW50aWFsbHkgbGVhdmluZyB0aGUNCj4gPiA+IHdy
aXRlLWJpdA0KPiA+ID4gY2xlYXIuIFRoaXMgaXMgdGhlIHNjZW5hcmlvIHlvdSB3YW50IHRvIGF2
b2lkLCBubz8NCj4gPiANCj4gPiBOby4gSSBhbSBub3QgcGF5aW5nIGF0dGVudGlvbi4gSWdub3Jl
Lg0KPiANCj4gU29ycnkgZm9yIHRoZSBzcGFtLiBKdXN0IHRoaXMg4oCcZGlydHnigJ0gYXJndW1l
bnQgaXMgY29uZnVzaW5nLiBUaGlzDQo+IGluZGVlZA0KPiBzZWVtcyBsaWtlIGEgZmxvdyB0aGF0
IGNhbiBzZXQgdGhlIGRpcnR5IGJpdC4gSSB0aGluay4NCg0KSSB0aGluayB0aGUgSFcgZGlydHkg
Yml0IHdpbGwgbm90IGJlIHNldCBoZXJlLiBIb3cgaXQgd29ya3MgaXMsDQpwdGVfbWtkaXJ0eSgp
IHdpbGwgbm90IGFjdHVhbGx5IHNldCB0aGUgSFcgZGlydHkgYml0LCBidXQgaW5zdGVhZCB0aGUN
CnNvZnR3YXJlIENPVyBiaXQuIEhlcmUgaXMgdGhlIHJlbGV2YW50IHNuaXBwZXQ6DQoNCnN0YXRp
YyBpbmxpbmUgcHRlX3QgcHRlX21rZGlydHkocHRlX3QgcHRlKQ0Kew0KCXB0ZXZhbF90IGRpcnR5
ID0gX1BBR0VfRElSVFk7DQoNCgkvKiBBdm9pZCBjcmVhdGluZyBEaXJ0eT0xLFdyaXRlPTAgUFRF
cyAqLw0KCWlmIChjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX1NIU1RLKSAmJiAhcHRl
X3dyaXRlKHB0ZSkpDQoJCWRpcnR5ID0gX1BBR0VfQ09XOw0KDQoJcmV0dXJuIHB0ZV9zZXRfZmxh
Z3MocHRlLCBkaXJ0eSB8IF9QQUdFX1NPRlRfRElSVFkpOw0KfQ0KDQpTbyBmb3IgYSAhVk1fV1JJ
VEUgdm1hLCB5b3UgZW5kIHVwIHdpdGggV3JpdGU9MCxDb3c9MSBQVEUgcGFzc2VkDQppbnRvIHB0
ZXBfc2V0X2FjY2Vzc19mbGFncygpLiBEb2VzIGl0IG1ha2Ugc2Vuc2U/DQo=
