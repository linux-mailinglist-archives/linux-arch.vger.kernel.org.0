Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079CE620283
	for <lists+linux-arch@lfdr.de>; Mon,  7 Nov 2022 23:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbiKGWrF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Nov 2022 17:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbiKGWrC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Nov 2022 17:47:02 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC412C65D;
        Mon,  7 Nov 2022 14:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667861221; x=1699397221;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=C529xIjeV1plZjzE/l03cW1TIQnLSJ80qElJ/R+JZoY=;
  b=QHp0HqvkEMZOQZsNECHuWV/PyILeJkZiYuasHAJO5QKy30KeAbHB9wi2
   FciTK1WcVmoAhOYPnsLYj10n/YD51UlqW4ee+o8HepolHZkjz9zo15bbk
   NY+RlnMEsE1jvIctADKyFtjiYYvBHVaw4VuWwteWUAzk2f1hm+2NaydcJ
   8c95rOomNKwP3JOTgE6B+roiDy1eZEtEmd758M9hNgBJEJ+5+hvkgnQab
   ixpEurizwUF5be1vO5OzwbDQbV5nkK28no3dJZxtQOHzxoamX/ppCK4DX
   b2mPD9g9TbKPb2MFuc5mCYpGukg4/hGagEauEo0tnNnxjoCjkJcCfFcPP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="298056801"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="298056801"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 14:47:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="614043678"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="614043678"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 07 Nov 2022 14:47:01 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 14:47:00 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 7 Nov 2022 14:47:00 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 7 Nov 2022 14:47:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Du0qF/AYJIaEtDDp7gDczfSMqM13qRm7og0w60JQBgZGPY2CensPZZ6Qkb7ELakhacQCCWYvw7OfhfcwrFmSh2GnqxIb6Wn3E/KtH0XvbSPkWJpIBS9yrs0EsurOM4SbiVjzjOqYfxlJZfdYS+QbEMD1PbEDIP8XgNnAqlplW0qJ+2Y2gOv77FerHLaB8ownNC9B6Mek4wyc7jFhTkXlnKi1l407sOV+53PnjvmYzK3AkK0ZweEQgKW74d2XvXrXv/7lo0V2RaLjhuId+pQcwZUAGmIUfRGVTvcFTiGCik5zS30PPoJQzgTTOA1RNOV4Lr/7uepXwlQoTwW4VPMduQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C529xIjeV1plZjzE/l03cW1TIQnLSJ80qElJ/R+JZoY=;
 b=guW+RoAiA69+GRUsh+UmmTyZhdAQ4Ut6m3MQSFDyX5q6FNQT99tPmUwv6olqZh5WYDPwJhyf0RRV7CsEdzks11+uBLYDiEW9bat2FGTnUApX3OiNv80HYapNq6GB2w6DfeNCsZW4+BIwOL5faQizAznoIWo11Pjf//2R6BRwaKRCWCsEXXhw9QU/+7j20d/i8LSsnP63SKm5E7g74Mzfhjk9f7dvN37yBi5G8BABGau744czWcQDXfqAtkXhoUxiGCKJCetYq339nvlhvz3P6VNTsvs2Ptg1iAXd/m9uEJlzkipY8Ulob84t0J2iQ6qz98xolw1DEQ/KBwTCRf25cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by IA1PR11MB7342.namprd11.prod.outlook.com (2603:10b6:208:425::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 22:46:54 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5791.027; Mon, 7 Nov 2022
 22:46:53 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "hjl.tools@gmail.com" <hjl.tools@gmail.com>
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
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [RFC 37/37] fs/binfmt_elf: Block old shstk elf bit
Thread-Topic: [RFC 37/37] fs/binfmt_elf: Block old shstk elf bit
Thread-Index: AQHY8J5g32apAoMYh0aArgmkU40OVa4vYA0AgAJEZxCAAgw+gIAAAcpVgAALa4CAABn9AIAAIbOAgAADEYCAAANrgIAAA+EAgAAQdwA=
Date:   Mon, 7 Nov 2022 22:46:52 +0000
Message-ID: <2f8fe2ede43909ea3c51ff05f7dae5f63d5ed8c8.camel@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
         <20221104223604.29615-38-rick.p.edgecombe@intel.com>
         <CAMe9rOpfSccXVWmgK6E0Y0DXC=VX3PpdxXookN1Ty8soeAxrKw@mail.gmail.com>
         <87iljs4ecp.fsf@oldenburg.str.redhat.com>
         <ca106fe1b5005f54525e7a644684108f6a823e14.camel@intel.com>
         <87h6zaiu05.fsf@oldenburg.str.redhat.com>
         <f60f1138813f850d52dd92bc6b3df067c021a197.camel@intel.com>
         <CAMe9rOpVUwCccRb5DAyraEKO48rix+Xfiamfp_Vc_aHhjp7=LQ@mail.gmail.com>
         <73b8f726c424db1af1c10a48e101bf74703a186a.camel@intel.com>
         <CAMe9rOo6+Di5-mdWa6rviZ7zdO3yMgFPeTw-CXxXZNSQc=-8Wg@mail.gmail.com>
         <31b5284ce7930835b055e4207059e4bea32367be.camel@intel.com>
         <CAMe9rOr1XpnisqWHh6C6Wi6tUAu5avhbKb_7E7ZpN_eMkktTww@mail.gmail.com>
In-Reply-To: <CAMe9rOr1XpnisqWHh6C6Wi6tUAu5avhbKb_7E7ZpN_eMkktTww@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|IA1PR11MB7342:EE_
x-ms-office365-filtering-correlation-id: c08708d0-60de-4ce1-6e50-08dac111f70e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OpRumthJf4j4V+6H3oQgrEHIxoCfA7KQuHU4ihXpvhYo75PpEdODdpSrh0i+ONloCQ/Jtsc25eBBezZT8vitaTQVn5xce/tmt7YTuKH5fU9uYoK2sRxf9YS27HL+QizoFXEIbLTZU4AmGyKA2IYIIhIR3agQs9QWMBVrlHofNWVSyiv6Rq2H7QWdY9sIYbu1DpV/23KBGXpC6yvjOeAf4yu0FSTWpXHwXywmI+hWfwJzjmUJdNr1593j/OBVMS5siFFD2lb/5zKoyD5aPhkYY9+e7ytme0rHykEqJpvCixfN1Fg7Gkt4wocCBkd60w4z0WoAk0uXtjZgNiwoUTXNFYgnt+aYN+oEfI+J/c/8SdDuh+TpYvXPta1rn4cI4rLInX7XhrLftHqzP/sdihDhEtiEXzhVXwLEiNmJWi9blzDWG5mkbYV/Oce0UhmCOP0Fp84g1Zx00GgzeLFYODffK1PLq7xIqvK5xGR7QU9L0JX4CGw6VJoRFwmT1Po41HZ6yKYKBPBIrbFmU68nB/E6WLjfJo1WolzWCBM9XkMdl7a5lskWlo+1EfKP/TfBWobkYiIy1WQxtZpwdEU4JGmuuiSEdjw1QhQbBU8bLbnlp62s3nZrtHc9BEX+cJuqojH1g1hH46dvfBjOVkczB1oejaaTyoHrbe+H4LjBaG8MunkSMiZyjLMwnNsswyMWKxaSyg0B+dJttRW/sH+72a4ij06NyUcqhCJm9AgN2PUi6Jz0gBq/JfNG0nlSUb/vj7xEGp/Ig527iTwoHZLor50t3rMd6Bt3vCUYsB+zZ23zHLs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199015)(186003)(38100700002)(82960400001)(122000001)(71200400001)(36756003)(478600001)(38070700005)(6486002)(86362001)(83380400001)(6506007)(6512007)(26005)(2616005)(53546011)(7416002)(7406005)(5660300002)(2906002)(8936002)(54906003)(316002)(6916009)(8676002)(66556008)(76116006)(66476007)(4326008)(66946007)(66446008)(64756008)(41300700001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVl0UElhRzg5bktFNENkb2xjOERNNVgwS0RtenViMGthVWNFQS90T2k5enMz?=
 =?utf-8?B?UTBRNkpMSU1ibHgzUEYvR0MwTXlwUnlBNWUvd2I3RDdVU2tGWFRTT2toajNv?=
 =?utf-8?B?c2RpRXByaUx4dDkwbm1lM3JXblVKZkluV3laTkpFOVpHR0w5V0pBZ05UNDUw?=
 =?utf-8?B?UVRpeFdzcEdpN1V4elFaTDZsRk1QbUtlUnEreVo0TnBIZ1lYZ1p3QzVMMUR0?=
 =?utf-8?B?Y3BoVnZEcFFmRDEzZzc2dnJySkF4OUdHMmdFVy83c3U2ZTVVOGMyNWE1YS9D?=
 =?utf-8?B?Y3htSEJwVXFiZVNkNWZub2xJSjJMa05aQkVVWDI4UWJuSTNMS29hRkxwaTlS?=
 =?utf-8?B?ZlE4ZWQ4Q3QzVmZ2Y254Q2JlQzVFWHJuNzZNYmxPd0p5aDlvMW1tbUhLNVB2?=
 =?utf-8?B?NngycWtRekQ1Wk9lRDIyRzlaVDg3NkREdWd2U0NCanZPNkZqd3JRMmRpZkJs?=
 =?utf-8?B?RzQ5ZzJ1aldSUzlKTE1yRTM5dlJwSGJseE4veXRRZmZWeXhyaXh4MGd4OFA4?=
 =?utf-8?B?ZU1tVHFQek9zQnMvL1AvYmJaUk9IRkpEV3JacGpvZXN3NFQ3SE0yVDBwS2dq?=
 =?utf-8?B?ZloydnUrdnZZQmtEKzhIZEVTK0s0NmZFU2Jra0ZmT0lOZFk1emFuVUY2M3Mx?=
 =?utf-8?B?cC9PdytRZFZNUC9iWjErNUhpV2VnTU40SmJ0KzFEOGplVmhBa1ovY0hsbkg3?=
 =?utf-8?B?eUFPOHpXY2REdlhValhoWTN5K3g5UGZmZkhFQWlNZ3MrY2N4a044L00zZUlP?=
 =?utf-8?B?YzlKMTlLN25acUZiMnRuV3NCSW5zalp3dnVkQnJWN0MvUVpxekU4bHgza1BH?=
 =?utf-8?B?cjRhVWRITTduVEZHU1lxZndPMWlmdVB1ZXh1NkFTa2E1S3VVdkw3OTMwRzVp?=
 =?utf-8?B?bEJJQzl4cTJmYnBKK2c5SWFPMkxOaHM2MGdneVFtUWRyYXh5SlJ0bVRlYS95?=
 =?utf-8?B?djVJRFNWYk0vQVVlVE14UDVYeDZyenhSN0VRWlRkQy9qbDJTWjB3Vkxuak8w?=
 =?utf-8?B?TzlMU0NtZTZGMmZ3OG9LN0gvTDVMRG9HWklUQm5keVMzNEZuWWxiU1F1YUhs?=
 =?utf-8?B?MTB2eHJ2Ui95TlI4QlVWNGdZdU9sZGhUMzFjTUVBVHdFUHpKZWNvWm1kOXk4?=
 =?utf-8?B?WEs1N0JjOHMyZ3E4UEdxcXJBdnJzalNPUzkyZ3dxcjVlN25BcXg5YkhqYm5N?=
 =?utf-8?B?clE2MVNqRXc1WXhlZ3N6N2xPQzJ2b1Ayd0xvN2I1OGE3eWljTjlHNkR6RmVU?=
 =?utf-8?B?eWRaR2hXZ3FtQitDY0NyMlNPWG1TK0tJVEFCdnVaUzdSSWNWNjRGM21PWTN3?=
 =?utf-8?B?RUFoYWRRSkhWdVZRamkzVVhhUkRsZVNwRGR2Qk5TU1haS0phTGJqdXVjdUUw?=
 =?utf-8?B?MDdGQ1BDV09Lb3R5OU8rcXNEK2gyM2cvYkJoTWFkSDArQi9iYUhOcDM5Q0hj?=
 =?utf-8?B?K0xhR3lBS3VKU1duMEZVejY0VDhIUUw0U2lLUzVMU3ZxWFYzaDh1YmFSU1B1?=
 =?utf-8?B?TSt1S2g4SXdIUExiZC9Iak55MHNmR3pSdG5wZmMrUXVhTDQwdi9Za2xnT1Qw?=
 =?utf-8?B?NHo4dTdRbUdTSFlxUHRqTmdLdCtmczM1cEV2Z2hDUnZKa2tqcjBERUpoWEZq?=
 =?utf-8?B?YWZDWDZ5QlNJM0hsWHBhbGp3RDBtcXM4UkpHQS9BMDhWM3Z1NEtaY0FxQlox?=
 =?utf-8?B?SUwyazh0b25LZyttN2JZaXpzeXFpdnlRVW9IanRnYWxsckg0SlVGWUVheEM2?=
 =?utf-8?B?VlFzMUpnVytqUVhQZDRJSnFJOS83aGh6T1B0ME1TLyt0dklMbFg3UEF5ZEdL?=
 =?utf-8?B?b0Z0UElEdXNEK0haTFdkQWRzb0RBQTVjaUIweEo4dHFIQldHZUx2WVBOZk0z?=
 =?utf-8?B?OW5rYlV2Qk1JZ00xbC83Zm5WYUlTaEQ0K0tRVkhqaGhZYTd6TUxUajdhNGxa?=
 =?utf-8?B?ZVBHWFBOMmxTaWYySVhQRWc4ZVB3c2d0TTRMbVd4ZVJ6aUYwbktLTmhTVitZ?=
 =?utf-8?B?ZEdGUkp6anMrb3o3dVhpZUYxeG5QKzUydVZZVmFqK0Y1a3lqL3FYSlRPVGY4?=
 =?utf-8?B?Rmc1TGhqZUxyOCtoYXhUZ2N2aWNrYkUzZUVUZGdNZXYvNHBVc0RGOXE2YktT?=
 =?utf-8?B?T0xmZlFMd1NQb2c3bVFJb0VMNzY5dHhnM0I1VjJ2Z3czaDYvUzlTZzJSbml1?=
 =?utf-8?Q?q10MFzZHmcAVwlgfsVl0/qA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FA1E6232E092944A8358762EC1E20B0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c08708d0-60de-4ce1-6e50-08dac111f70e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 22:46:52.9556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fMGjwrdJl2ZJwEHNOAz/ivvkYSb93UR4Tx32F7efyDO80r2P/tH8YYmrREz5hj2TCtOVDagPNToLg1TqOxBrtx10NoheB0/mnv683sZl/LY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7342
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

T24gTW9uLCAyMDIyLTExLTA3IGF0IDEzOjQ3IC0wODAwLCBILkouIEx1IHdyb3RlOg0KPiBPbiBN
b24sIE5vdiA3LCAyMDIyIGF0IDE6MzQgUE0gRWRnZWNvbWJlLCBSaWNrIFANCj4gPHJpY2sucC5l
ZGdlY29tYmVAaW50ZWwuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBNb24sIDIwMjItMTEtMDcg
YXQgMTM6MjEgLTA4MDAsIEguSi4gTHUgd3JvdGU6DQo+ID4gPiA+ID4gU29tZSBhcHBsaWNhdGlv
bnMgYW5kIGxpYnJhcmllcyBhcmUgY29tcGlsZWQgd2l0aCAtZmNmLQ0KPiA+ID4gPiA+IHByb3Rl
Y3Rpb24sDQo+ID4gPiA+ID4gYnV0DQo+ID4gPiA+ID4gdGhleSBtYW5pcHVsYXRlIHRoZSBzdGFj
ayBpbiBzdWNoIGEgd2F5IHRoYXQgdGhleSBhcmVuJ3QNCj4gPiA+ID4gPiBjb21wYXRpYmxlDQo+
ID4gPiA+ID4gd2l0aCB0aGUgc2hhZG93IHN0YWNrLiAgIEhvd2V2ZXIsIGlmIHRoZSBidWlsZC90
ZXN0IHNldHVwDQo+ID4gPiA+ID4gZG9lc24ndA0KPiA+ID4gPiA+IHN1cHBvcnQNCj4gPiA+ID4g
PiBzaGFkb3cgc3RhY2ssIGl0IGlzIGltcG9zc2libGUgdG8gdmFsaWRhdGUuDQo+ID4gPiA+ID4g
DQo+ID4gPiA+IA0KPiA+ID4gPiBXaGVuIHdlIGhhdmUgZXZlcnl0aGluZyBpbiBwbGFjZSwgdGhl
IHByb2JsZW1zIHdvdWxkIGJlIG11Y2gNCj4gPiA+ID4gbW9yZQ0KPiA+ID4gPiBvYnZpb3VzIHdo
ZW4gZGlzdHJvcyBzdGFydGVkIHR1cm5pbmcgaXQgb24uIEJ1dCB3ZSBjYW4ndCB0dXJuDQo+ID4g
PiA+IGl0IG9uDQo+ID4gPiA+IGFzDQo+ID4gPiANCj4gPiA+IE5vdCBuZWNlc3NhcmlseS4gIFRo
ZSBwcm9ibGVtIHdpbGwgc2hvdyB1cCBvbmx5IGluIGEgQ0VUIGVuYWJsZWQNCj4gPiA+IGVudmly
b25tZW50IHNpbmNlIGJ1aWxkL3Rlc3Qgc2V0dXAgbWF5IG5vdCBiZSBvbiBhIENFVCBjYXBhYmxl
DQo+ID4gPiBoYXJkd2FyZS4NCj4gPiANCj4gPiBXZWxsLCBJJ20gbm90IHN1cmUgb2YgdGhlIGRl
dGFpbHMgb2YgZGlzdHJvIHRlc3RpbmcsIGJ1dCB0aGVyZSBhcmUNCj4gPiBwbGVudHkgb2YgVEdM
IGFuZCBsYXRlciBzeXN0ZW1zIG91dCB0aGVyZSB0b2RheS4gV2l0aCBrZXJuZWwNCj4gPiBzdXBw
b3J0LA0KPiA+IEknbSB0aGlua2luZyB0aGVzZSB0eXBlcyBvZiBwcm9ibGVtcyBjb3VsZG4ndCBs
dXJrIGZvciB5ZWFycyBsaWtlDQo+ID4gdGhleQ0KPiA+IGhhdmUuDQo+IA0KPiBJZiB0aGlzIGlz
IHRoZSBjYXNlLCB3ZSB3b3VsZCBoYXZlIG5vdGhpbmcgdG8gd29ycnkgYWJvdXQgc2luY2UgdGhl
DQo+IENFVA0KPiBlbmFibGVkIGFwcGxpY2F0aW9ucyB3b24ndCBwYXNzIHZhbGlkYXRpb24gaWYg
dGhleSBhcmVuJ3QgQ0VUDQo+IGNvbXBhdGlibGUuDQoNCkhtbSwgSSB0aGluayB5b3UgY291bGRu
J3QgaGF2ZSBhbHJlYWR5IGZvcmdvdHRlbiB0aGUgcHJvYmxlbSBiaW5hcmllcw0KYXJlIGFscmVh
ZHkgc2hpcHBlZC4uLg0KDQo+IA0KPiA+ID4gDQo+ID4gPiA+IHBsYW5uZWQgd2l0aG91dCBicmVh
a2luZyB0aGluZ3MgZm9yIGV4aXN0aW5nIGJpbmFyaWVzLiBXZSBjYW4NCj4gPiA+ID4gaGF2ZQ0K
PiA+ID4gPiBib3RoDQo+ID4gPiA+IGJ5Og0KPiA+ID4gPiAxLiBDaG9vc2luZyBhIG5ldyBiaXQs
IGFkZGluZyBpdCB0byB0aGUgdG9vbHMsIGFuZCBuZXZlcg0KPiA+ID4gPiBzdXBwb3J0aW5nDQo+
ID4gPiA+IHRoZQ0KPiA+ID4gPiBvbGQgYml0IGluIGdsaWJjLg0KPiA+ID4gPiAyLiBQcm92aWRp
bmcgdGhlIG9wdGlvbiB0byBoYXZlIHRoZSBrZXJuZWwgYmxvY2sgdGhlIG9sZCBiaXQsDQo+ID4g
PiA+IHNvDQo+ID4gPiA+IHVwZ3JhZGVkIHVzZXJzIGNhbiBkZWNpZGUgd2hhdCBleHBlcmllbmNl
IHRoZXkgd291bGQgbGlrZS4gVGhlbg0KPiA+ID4gPiBkaXN0cm9zDQo+ID4gPiA+IGNhbiBmaW5k
IHRoZSBwcm9ibGVtcyBhbmQgYWRqdXN0IHRoZWlyIHBhY2thZ2VzLiBJJ20gc3RhcnRpbmcNCj4g
PiA+ID4gdG8NCj4gPiA+ID4gdGhpbmsNCj4gPiA+ID4gYSBkZWZhdWx0IG9mZiBzeXNjdGwgdG9n
Z2xlIG1pZ2h0IGJlIGJldHRlciB0aGFuIGEgS2NvbmZpZy4NCj4gPiA+ID4gMy4gQW55IG90aGVy
IGlkZWFzPw0KPiA+ID4gDQo+ID4gPiBEb24ndCBlbmFibGUgQ0VUIGluIGdsaWJjIHVudGlsIHdl
IGNhbiB2YWxpZGF0ZSBDRVQNCj4gPiA+IGZ1bmN0aW9uYWxpdHkuDQo+ID4gDQo+ID4gQ2FuIHlv
dSBlbGFib3JhdGUgb24gd2hhdCB5b3UgbWVhbiBieSB0aGlzPyBOb3QgdXBzdHJlYW0gZ2xpYmMg
Q0VUDQo+ID4gc3VwcG9ydD8gT3IgaGF2ZSB1c2VycyBub3QgZW5hYmxlIGl0PyBJZiB0aGUgbGF0
dGVyLCBob3cgd291bGQgdGhleQ0KPiA+IGtub3cgYWJvdXQgYWxsIHRoZXNlIHByb2JsZW1zLg0K
PiANCj4gVGhlIGN1cnJlbnQgZ2xpYmMgZG9lc24ndCBzdXBwb3J0IENFVC4gIFRvIGVuYWJsZSBD
RVQgaW4gYW4NCj4gYXBwbGljYXRpb24sDQo+IG9uZSBzaG91bGQgdmFsaWRhdGUgaXQgdG9nZXRo
ZXIgd2l0aCB0aGUgQ0VUIGVuYWJsZWQgZ2xpYmMgdW5kZXIgdGhlDQo+IENFVA0KPiBlbmFibGVk
IGtlcm5lbCBvbiBhIENFVCBjYXBhYmxlIG1hY2hpbmUuDQoNCkFncmVlZCB0aGF0IHRoaXMgaXMg
aG93IGl0IHNob3VsZCBoYXZlIGdvbmUuDQoNCj4gDQo+ID4gDQo+ID4gQW5kIHdoYXQgaXMgd3Jv
bmcgd2l0aCB0aGUgY2xlYW5lc3Qgb3B0aW9uLCBudW1iZXIgMT8gVGhlIEFCSQ0KPiA+IGRvY3Vt
ZW50DQo+ID4gY2FuIGJlIHVwZGF0ZWQuDQo+IA0KPiBJdCBkb2Vzbid0IGhlbHAgcmVzb2x2ZSBh
bnkgaXNzdWVzLg0KDQpQbGVhc2UgcmVhZCB0aGUgY292ZXJsZXR0ZXIgaWYgeW91IGFyZSB1bnN1
cmUgb2Ygd2hhdCBpc3N1ZXMgdGhpcyBpcw0KdHJ5aW5nIHRvIGFkZHJlc3MuIEkgc2hvdWxkIGhh
dmUgcHV0IG1vcmUgaW4gdGhlIGNvbW1pdCBsb2cuDQoNCg0KDQo=
