Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9276040A28B
	for <lists+linux-arch@lfdr.de>; Tue, 14 Sep 2021 03:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhINBe1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Sep 2021 21:34:27 -0400
Received: from mga17.intel.com ([192.55.52.151]:32986 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhINBe1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Sep 2021 21:34:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="202015493"
X-IronPort-AV: E=Sophos;i="5.85,291,1624345200"; 
   d="scan'208";a="202015493"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 18:33:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,291,1624345200"; 
   d="scan'208";a="697128798"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga006.fm.intel.com with ESMTP; 13 Sep 2021 18:33:09 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 13 Sep 2021 18:33:08 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 13 Sep 2021 18:33:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Mon, 13 Sep 2021 18:33:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Mon, 13 Sep 2021 18:33:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbLI1Xylv+GB0UDqf+pw58NHbp9hOI7iJ6VcSRTCg+GUXACyXhjWuMplEHjxL6Rhc7ErOvjw9wUwqorssPZ4NIzaWeHDNXe/CA7eSyZfzXC6xFXdMyb1n/mpBrPu5BwtToBUf8UeDFj8Gcl/scL8Jj2two7R8RL7OI3HSMzAiuB/fNE2xc8p6J4Wl4BddM9FGSm77lwIuBLKgdehQWVy4ho61yd3BH4LCcbRvksZ9eWbM2+7DMh248PmfHbwq0tADT/Z4TQGbPR4vVza9ygSmyQnrMPWEIM0lcsYBM87qlRDj0ecrb+YT0mSViYD4Tpff0h+CquUXuhmkkAspUqxEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ocZn3K0nETdISEUm2lwo5bwPFJxG7qr5X/4n+XhSPRU=;
 b=lxQko/QIZg09jKKPN9i/v56rTbNNd4/M70yq7VMx+SGWIEwSaeRsrCxFLI93JAgfSWqOmnNuS9xMYxkEsdUqqGeL8+4CoCyNB9lRgUD+6Ktln7MlKV29atSblXH79bcJz0Tx2px4VIH+T0rU4u99L5lIU4WU0D49eikWKm2O8hPkU4h5rCpDjMoj2fqsFZADz3Jo41KxmoRlqlSlhtOBcRgG2uqT+HnfmRxJ2g5C4t+Q1+vIpmnbaDKQGWQXnqMb8aIbm5MdPjnIukjn3cn4YKiq7uqsgcFYGdb9MLsdOSBQZxi6MHnFEYxACaq5QPjP91vaMPNE5fHPadAUasyBOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocZn3K0nETdISEUm2lwo5bwPFJxG7qr5X/4n+XhSPRU=;
 b=FckZeEw7ZI0w/rJ36U92k3De85DoZjpiHmekOFCeoVUAqe/SUVVTPYmVp51nxVFrTaLtjtUzrahpu+gMAwrhZIl1V6QpZRSuaCHm/fZDvjvSsVN7MS6jGoL/V8MY8mNaJj7UqxvSPD8udquTw1ygHdUstrIZ6k9bzTv/jSnE/sI=
Received: from SN6PR11MB3184.namprd11.prod.outlook.com (2603:10b6:805:bd::17)
 by SN6PR11MB2669.namprd11.prod.outlook.com (2603:10b6:805:56::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Tue, 14 Sep
 2021 01:33:03 +0000
Received: from SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::892e:cae1:bef0:935e]) by SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::892e:cae1:bef0:935e%6]) with mapi id 15.20.4500.017; Tue, 14 Sep 2021
 01:33:03 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Lutomirski, Andy" <luto@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "esyr@redhat.com" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "tarasmadan@google.com" <tarasmadan@google.com>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "vedvyas.shanbhogue@intel.com" <vedvyas.shanbhogue@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [NEEDS-REVIEW] Re: [PATCH v11 25/25] x86/cet/shstk: Add
 arch_prctl functions for shadow stack
Thread-Topic: [NEEDS-REVIEW] Re: [PATCH v11 25/25] x86/cet/shstk: Add
 arch_prctl functions for shadow stack
Thread-Index: AQHXpBafkXiywIsFO0GpZ4F+zmmfpKleug+AgAMcTACABC5WgIAAPYaAgjyGhQA=
Date:   Tue, 14 Sep 2021 01:33:02 +0000
Message-ID: <45c62101c065ed7e728fadac7207866bf8c36ec4.camel@intel.com>
References: <086c73d8-9b06-f074-e315-9964eb666db9@intel.com>
         <CALCETrVeNA0Kt2rW0CRCVo1JE0CKaBxu9KrJiyqUA8LPraY=7g@mail.gmail.com>
         <0e9996bc-4c1b-cc99-9616-c721b546f857@intel.com>
         <4f2dfefc-b55e-bf73-f254-7d95f9c67e5c@intel.com>
         <CAMe9rOqt9kbqERC8U1+K-LiDyNYuuuz3TX++DChrRJwr5ajt6Q@mail.gmail.com>
         <20200901102758.GY6642@arm.com>
         <c91bbad8-9e45-724b-4526-fe3674310c57@intel.com>
         <CALCETrWJQgtO_tP1pEaDYYsFgkZ=fOxhyTRE50THcxYoHyTTwg@mail.gmail.com>
         <32005d57-e51a-7c7f-4e86-612c2ff067f3@intel.com>
         <46dffdfd-92f8-0f05-6164-945f217b0958@intel.com>
         <ed929729-4677-3d3b-6bfd-b379af9272b8@intel.com>
         <6e1e22a5-1b7f-2783-351e-c8ed2d4893b8@intel.com>
         <5979c58d-a6e3-d14d-df92-72cdeb97298d@intel.com>
         <ab1a3344-60f4-9b9d-81d4-e6538fdcafcf@intel.com>
         <08c91835-8486-9da5-a7d1-75e716fc5d36@intel.com>
         <a881837d-c844-30e8-a614-8b92be814ef6@intel.com>
         <cbec8861-8722-ec31-2c02-1cfed20255eb@intel.com>
         <b3379d26-d8a7-deb7-59f1-c994bb297dcb@intel.com>
         <a1efc4330a3beff10671949eddbba96f8cde96da.camel@intel.com>
         <41aa5e8f-ad88-2934-6d10-6a78fcbe019b@intel.com>
         <CALCETrX5qJAZBe9sHL6+HFvre-bbo+us1==q9KHNCyRrzaUsjw@mail.gmail.com>
In-Reply-To: <CALCETrX5qJAZBe9sHL6+HFvre-bbo+us1==q9KHNCyRrzaUsjw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5301671-c2ce-4fd9-96a9-08d9771f9844
x-ms-traffictypediagnostic: SN6PR11MB2669:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB26697842D4EAACEFBFBB5380C9DA9@SN6PR11MB2669.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bBY33GNoDPdFvVCSQCQXs7I86H4eEFsn7E63txatDOoeQYIAgxCUoI+LveSlHeNFAuBs0wB8dSbDuAYvpUe0ZDs5WlsMsJHAKI7gkIusmBlXMfm4saDzCcUrTVemt0bL4++Nelyt+7IfMWYpd+0OoC/CYCYxuwjg3SLY55k3s7Z3TkgTGufXW/Kg25xLuk7gHlOA8a0sY7OmZQ7ym5gfCOKBHnsWEf7fZ1rYS3xHxpRCLMfy5w0JjH4xRWv8goLmvJ82azclXZrhkipBBk3TygYsEFWo1BfCeNbY1w4/2XIQ1aAHurAslncnx9sCFODmoDpnwuAw9UXaQqaIY8jCk3Co7fK5FutWsukhdsnIUCBV4HxUTWL5P1FT1F12gH8KucmHLBUC8ZWg4s4vLOzHL4uXZ3QYFfKAbyiH7O9aMFD6pCWP97krZX/2PKW0svifWjDDDPn0igC0hyybBYkUk9RYsgqpu1KF+YOQJ9+gkGCZLyfrp+5rEMvCvkIfn7RRbRB2BtNF25RsE9zjgbcfZBU3eTlRxbnk6uKSeg+nnNOk88dZx5SHZtGl2P74k2EZk/jKWbLTgyPJCKTOcD+wyMqp2hKh4S2V4BMLeW1IDES6OHZcN0pJCqjm3k1NDuAURQ9LVLBDaM0UvD1aKIJNZL6N27r5t/9TGtcmbqr3RoNv+RbXySKebq1rqq5zA3/vTKWuQdl8YVYksvhcuJw9KNCznuKsR5LUxt38Q4o1gTej2X/U/PFIcSK2+38ba/C/ZDDO4BTT3YMvxtb566rRCM8gkrtuLLgcLNOLnEmUtyxK1Pj9ULpmsJVeX3M/IN+c
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3184.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(66446008)(2906002)(6506007)(53546011)(64756008)(4326008)(38100700002)(66946007)(110136005)(6636002)(54906003)(66556008)(66476007)(71200400001)(36756003)(2616005)(76116006)(8936002)(83380400001)(7406005)(8676002)(186003)(91956017)(7416002)(6486002)(6512007)(478600001)(5660300002)(86362001)(38070700005)(122000001)(26005)(966005)(316002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnVCZVZKc3JmRXltYWF1NVJnWWJVZDN2UkhLQmNWUHNsNk9Ha0VUZXNhL3pS?=
 =?utf-8?B?QjJicng5MFRXcHhLb0VGYlN3MUc5Y0VTdFdHK0MzNVFiaW5JWFZBUVNucDc2?=
 =?utf-8?B?U2F2L3M1cWhNSXZwUlBndFJwL2hncU82NlBvdkh2QlF1ckFUTVJEbTJxTlZU?=
 =?utf-8?B?UnNScWl4K3VFNjUwb0Fzck02MDYvTldSTWRVNGFXN21MNGZEU3pXK2RZQTFa?=
 =?utf-8?B?dDFCenMyYUFJSWVNOXFIZERoZTdPT09HRGJQa2Z2bjB3Qm83V1RnM09oV2ZS?=
 =?utf-8?B?TThrd2JtTGtoSmN3MVZsT0pqRGRGRWQ2ZU9YcnJVWExiNE0wL1J4V2tCUTFB?=
 =?utf-8?B?ZHBoWW9wckZFNzc5Nk1oc0JRVTJ2SmN3UGVNd2R5Zm1KblRaNm9xWFh5K2pX?=
 =?utf-8?B?TmxkSWgwMVBSdERTNEEvSHQ0UlVWb2VhNXBCMXNybVNpVlM5em1wRDQzUFp2?=
 =?utf-8?B?bUdKajU1SDVHc0ZsV2JZN0VyenovMGh2SVd1bjViaTJLVmZ4eDRZNDdnNG0r?=
 =?utf-8?B?VGVKdXBaUTZKT2RnZ0xTRVFIcSt4ZjhsU240UXhjSDVDNm1zeVVKSXZ4VU1y?=
 =?utf-8?B?aFFwYkpLQVVwR3BtWHY1MzJCWC8zeXFWbDVVWFdxTlpBbW1XU01HSkgzN3JD?=
 =?utf-8?B?Y2RrTTlyZTEwSkZJbjVIODIzRmZMdGRrY0lkaXIrR2NoVXdXUVAxcGFhcTh0?=
 =?utf-8?B?eXFpcUw0UWt4dktVck5LYXNDMmZ2bXYwSWtlYisxM3RGeFpjVVd4aG1lVGJ3?=
 =?utf-8?B?SWZ1bnd5SEdleUlaR2FQaVEyQnZJbUtpZmZJNHF1QTBmNkhYbnJZdmpQcGIw?=
 =?utf-8?B?VVlJbHYwZXV6M3pJR1dqRWg1NkE2WmhCL3V5M1FyME9OVGtkcGJHaGNPaUli?=
 =?utf-8?B?L3JRUXFTWkJObE9GTGRERVhBOTdGN3ludmNaSzZuTGhTU3E2Y2xWbVc4cmQ1?=
 =?utf-8?B?RHNLWmpjUWtlSUI1L2dVZVFmNFM1SWFYaVVpOHVRQXBmTzNoZlNVcVF2TmRw?=
 =?utf-8?B?amlvYVlUMWJVYi83bGFxZ1UwUGZJeEl6b2txbkhBVGRWTE45alJGWGhVbkpC?=
 =?utf-8?B?QXRpdTdMNTBkN2EzUlhRKzBXSXdjNlRmcThXWkI2Z1F4eFJIYXZsNWx4emdX?=
 =?utf-8?B?c3c2dUdFZ05pTWNya2htd0E3c0FQN25LNkZxRWZDKytTK1B2WFNZN1hNc25l?=
 =?utf-8?B?cGRKcmpFckMvQmNUOVh5ak5qdnJiZE5TL2VKam1IaSs4VHFNbVJFKzdVV1Nl?=
 =?utf-8?B?NU8vekFrdnZWWUNZUThXMVBVU3FUb0RabFJNRXF1eE5UdzFiWDBiMmgyNFpk?=
 =?utf-8?B?YUw5NDFORzU4YlBVUjhPM3FjdWhqbWZ5R3A0cGorM0o1d0QzOHI3ZmZja0JW?=
 =?utf-8?B?eVgxOVZWTjNCb0h4MVVhVzZsM1FFMWx5S2FPaHorTnpZYUN3bmdqV21HZVZ1?=
 =?utf-8?B?bkE0SE9ZVFRYa1FycWlDNWcxcVowMkpYZnJnbFRxcmp4UEt2eWFZTlExK2xa?=
 =?utf-8?B?Z2RmWGJneklEWlFUOXk3anhvdk55NEo2NlV2bHJ6elF4YWYrcU5MUUNjN3RV?=
 =?utf-8?B?TG5CWi9uT3JNQ0NVeHBybTkxZnJVV1RKS1NXL3hub3R1dUsreStUeXdVT09I?=
 =?utf-8?B?UVZqTEFwVTAzMXk1U2x0L04yMUlOZFFFSHV3MS9FWDVFMmxYZVI2bitNK3Q3?=
 =?utf-8?B?Vy9hUndwZm9lV2x0bzNyTU9BN1RsU2dCdmVRUHNuMU5PZ1ZFdFNWOG01dXNB?=
 =?utf-8?B?OEMxMlFseFF3N3M3WHBwK0krSkRMckpyWVZIRnNUUlUxVEZtb3gwYzkreVdC?=
 =?utf-8?B?Qy9IdmRCc0lPU1R5WnJidz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D1899B8D60503408BA099A0254789F5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3184.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5301671-c2ce-4fd9-96a9-08d9771f9844
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2021 01:33:02.9830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: siPqtOOtPPV1DKqE8xrYImooV9eJBII6+1ZYVJM2qqxk+wik6IQlgXI/FvfIG5nPQwsJF9DACZh5pFgY2jLgmsz77ITxuNDjNJJ1gFoi9vM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2669
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIwLTA5LTE0IGF0IDExOjMxIC0wNzAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6
DQo+ID4gT24gU2VwIDE0LCAyMDIwLCBhdCA3OjUwIEFNLCBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5z
ZW5AaW50ZWwuY29tPg0KPiA+IHdyb3RlOg0KPiA+IA0KPiA+IO+7v09uIDkvMTEvMjAgMzo1OSBQ
TSwgWXUtY2hlbmcgWXUgd3JvdGU6DQo+ID4gLi4uDQo+ID4gPiBIZXJlIGFyZSB0aGUgY2hhbmdl
cyBpZiB3ZSB0YWtlIHRoZSBtcHJvdGVjdChQUk9UX1NIU1RLKQ0KPiA+ID4gYXBwcm9hY2guDQo+
ID4gPiBBbnkgY29tbWVudHMvc3VnZ2VzdGlvbnM/DQo+ID4gDQo+ID4gSSBzdGlsbCBkb24ndCBs
aWtlIGl0LiA6KQ0KPiA+IA0KPiA+IEknbGwgYWxzbyBiZSBtdWNoIGhhcHBpZXIgd2hlbiB0aGVy
ZSdzIGEgcHJvcGVyIGNoYW5nZWxvZyB0bw0KPiA+IGFjY29tcGFueQ0KPiA+IHRoaXMgd2hpY2gg
YWxzbyBzcGVsbHMgb3V0IHRoZSBhbHRlcm5hdGl2ZXMgYW55IHdoeSB0aGV5IHN1Y2sgc28NCj4g
PiBtdWNoLg0KPiA+IA0KPiANCj4gTGV04oCZcyB0YWtlIGEgc3RlcCBiYWNrIGhlcmUuIElnbm9y
aW5nIHRoZSBwcmVjaXNlIEFQSSwgd2hhdCBleGFjdGx5DQo+IGlzDQo+IGEgc2hhZG93IHN0YWNr
IGZyb20gdGhlIHBlcnNwZWN0aXZlIG9mIGEgTGludXggdXNlciBwcm9ncmFtPw0KPiANCj4gVGhl
IHNpbXBsZXN0IGFuc3dlciBpcyB0aGF0IGl04oCZcyBqdXN0IG1lbW9yeSB0aGF0IGhhcHBlbnMg
dG8gaGF2ZQ0KPiBjZXJ0YWluIHByb3RlY3Rpb25zLiAgVGhpcyBlbmFibGVzIGFsbCBraW5kcyBv
ZiBzaGVuYW5pZ2Fucy4gIEENCj4gcHJvZ3JhbSBjb3VsZCBtYXAgYSBtZW1mZCB0d2ljZSwgb25j
ZSBhcyBzaGFkb3cgc3RhY2sgYW5kIG9uY2UgYXMNCj4gbm9uLXNoYWRvdy1zdGFjaywgYW5kIGNo
YW5nZSBpdHMgY29udHJvbCBmbG93LiAgU2ltaWxhcmx5LCBhIHByb2dyYW0NCj4gY291bGQgbXBy
b3RlY3QgaXRzIHNoYWRvdyBzdGFjaywgbW9kaWZ5IGl0LCBhbmQgbXByb3RlY3QgaXQgYmFjay4g
IEluDQo+IHNvbWUgdGhyZWF0IG1vZGVscywgdGhvdWdoIGNvdWxkIGJlIHNlZW4gYXMgYSBXUlNT
IGJ5cGFzcy4gIChBbHRob3VnaA0KPiBpZiBhbiBhdHRhY2tlciBjYW4gY29lcmNlIGEgcHJvY2Vz
cyB0byBjYWxsIG1wcm90ZWN0KCksIHRoZSBnYW1lIGlzDQo+IGxpa2VseSBtb3N0bHkgb3ZlciBh
bnl3YXkuKQ0KPiANCj4gQnV0IHdlIGNvdWxkIGJlIG1vcmUgcmVzdHJpY3RpdmUsIG9yIHBlcmhh
cHMgd2UgY291bGQgYWxsb3cgdXNlciBjb2RlDQo+IHRvIG9wdCBpbnRvIG1vcmUgcmVzdHJpY3Rp
b25zLiAgRm9yIGV4YW1wbGUsIHdlIGNvdWxkIGhhdmUgc2hhZG93DQo+IHN0YWNrcyBiZSBzcGVj
aWFsIG1lbW9yeSB0aGF0IGNhbm5vdCBiZSB3cml0dGVuIGZyb20gdXNlcm1vZGUgYnkgYW55DQo+
IG1lYW5zIG90aGVyIHRoYW4gcHRyYWNlKCkgYW5kIGZyaWVuZHMsIFdSU1MsIGFuZCBhY3R1YWwg
c2hhZG93IHN0YWNrDQo+IHVzYWdlLg0KPiANCj4gV2hhdCBpcyB0aGUgZ29hbD8NCj4gDQo+IE5v
IG1hdHRlciB3aGF0IHdlIGRvLCB0aGUgZWZmZWN0cyBvZiBjYWxsaW5nIHZmb3JrKCkgYXJlIGdv
aW5nIHRvIGJlDQo+IGENCj4gYml0IG9kZCB3aXRoIFNIU1RLIGVuYWJsZWQuICBJIHN1cHBvc2Ug
d2UgY291bGQgZGlzYWxsb3cgdGhpcywgYnV0DQo+IHRoYXQgc2VlbXMgbGlrZWx5IHRvIGNhdXNl
IGl0cyBvd24gaXNzdWVzLg0KDQpIaSwNCg0KUmVzdXJyZWN0aW5nIHRoaXMgb2xkIHRocmVhZCB0
byBoaWdobGlnaHQgYSBjb25zZXF1ZW5jZSBvZiB0aGUgZGVzaWduDQpjaGFuZ2UgdGhhdCBjYW1l
IG91dCBvZiBpdC4gSSBhbSBnb2luZyB0byBiZSB0YWtpbmcgb3ZlciB0aGlzIHNlcmllcw0KZnJv
bSBZdS1jaGVuZywgYW5kIHdhbnRlZCB0byBjaGVjayBpZiBwZW9wbGUgd291bGQgYmUgaW50ZXJl
c3RlZCBpbiByZS0NCnZpc2l0aW5nIHRoaXMgaW50ZXJmYWNlLg0KDQpUaGUgY29uc2VxdWVuY2Ug
SSB3YW50ZWQgdG8gaGlnaGxpZ2h0LCBpcyB0aGF0IG1ha2luZyB1c2Vyc3BhY2UgYmUNCnJlc3Bv
bnNpYmxlIGZvciBtYXBwaW5nIG1lbW9yeSBhcyBzaGFkb3cgc3RhY2ssIGFsc28gcmVxdWlyZXMg
bW92aW5nDQp0aGUgd3JpdGluZyBvZiB0aGUgcmVzdG9yZSB0b2tlbiB0byB1c2Vyc3BhY2UgZm9y
IGdsaWJjIHVjb250ZXh0DQpvcGVyYXRpb25zLiBTaW5jZSB0aGVzZSBvcGVyYXRpb25zIGludm9s
dmUgY3JlYXRpbmcvcGl2b3RpbmcgdG8gbmV3DQpzdGFja3MgaW4gdXNlcnNwYWNlLCB1Y29udGV4
dCBjZXQgc3VwcG9ydCBpbnZvbHZlcyBhbHNvIGNyZWF0aW5nIGEgbmV3DQpzaGFkb3cgc3RhY2su
IEZvciBub3JtYWwgdGhyZWFkIHN0YWNrcywgdGhlIGtlcm5lbCBoYXMgYWx3YXlzIGRvbmUgdGhl
DQpzaGFkb3cgc3RhY2sgYWxsb2NhdGlvbiBhbmQgc28gaXQgaXMgbmV2ZXIgd3JpdGFibGUgKGlu
IHRoZSBub3JtYWwNCnNlbnNlKSBmcm9tIHVzZXJzcGFjZS4gQnV0IGFmdGVyIHRoaXMgY2hhbmdl
IG1ha2Vjb250ZXh0KCkgbm93IGZpcnN0DQpoYXMgdG8gbW1hcCgpIHdyaXRhYmxlIG1lbW9yeSwg
dGhlbiB3cml0ZSB0aGUgcmVzdG9yZSB0b2tlbiwgdGhlbg0KbXByb3RlY3QoKSBpdCBhcyBzaGFk
b3cgc3RhY2suIFNlZSB0aGUgZ2xpYmMgY2hhbmdlcyB0byBzdXBwb3J0DQpQUk9UX1NIQURPV19T
VEFDSyBoZXJlWzBdLg0KDQpUaGUgd3JpdGFibGUgd2luZG93IGxlYXZlcyBhbiBvcGVuaW5nIGZv
ciBhbiBhdHRhY2tlciB0byBjcmVhdGUgYW4NCmFyYml0cmFyeSBzaGFkb3cgc3RhY2sgdGhhdCBj
b3VsZCBiZSBwaXZvdGVkIHRvIGxhdGVyIGJ5IHR3ZWFraW5nIHRoZQ0KdWNvbnRleHRfdCBzdHJ1
Y3R1cmUuIFRvIHRyeSB0byBzZWUgaG93IG11Y2ggdGhpcyBtYXR0ZXJzLCB3ZSBoYXZlIGRvbmUN
CmEgc21hbGwgdGVzdCB0aGF0IHVzZXMgdGhpcyB3aW5kb3cgdG8gUk9QIGZyb20gd3JpdGVzIGlu
IGFub3RoZXINCnRocmVhZCBkdXJpbmcgdGhlIG1ha2Vjb250ZXh0KCkvc2V0Y29udGV4dCgpIHdp
bmRvdy4gKG9mZmVuc2l2ZSB3b3JrDQpjcmVkaXQgdG8gSm9hbyBvbiBDQykuIFRoaXMgd291bGQg
cmVxdWlyZSBhIHJlYWwgYXBwIHRvIGFscmVhZHkgdG8gYmUNCnVzaW5nIHVjb250ZXh0IGluIHRo
ZSBjb3Vyc2Ugb2Ygbm9ybWFsIHJ1bnRpbWUuDQoNClRoZSBvcmlnaW5hbCBwcmN0bCBzb2x1dGlv
biBwcmV2ZW50cyB0aGlzIGNhc2Ugc2luY2UgdGhlIGtlcm5lbCBkaWQgdGhlDQphbGxvY2F0aW9u
IGFuZCByZXN0b3JlIHRva2VuIHNldHVwLCBidXQgb2YgY291cnNlIGl0IGhhZCBvdGhlciBpc3N1
ZXMuDQpUaGUgb3RoZXIgaWRlYXMgZGlzY3Vzc2VkIHByZXZpb3VzbHkgd2VyZSBhIG5ldyBzeXNj
YWxsLCBvciBzb21lIHNvcnQNCm9mIG5ldyBtYWR2aXNlKCkgb3BlcmF0aW9uIHRoYXQgY291bGQg
YmUgaW52b2x2ZWQgaW4gc2V0dGluZyB1cCBzaGFkb3cNCnN0YWNrLCBzdWNoIHRoYXQgaXQgaXMg
bmV2ZXIgd3JpdGFibGUgaW4gdXNlcnNwYWNlLiBPciwgc2ltcGxlciBidXQNCnVnbGllciwgdHdl
YWtpbmcgdGhlIGV4aXN0aW5nIFBST1RfU0hBRE9XX1NUQUNLIGJhc2VkIHNvbHV0aW9uIGJ5DQpt
YWtpbmcgY29yZSBtbWFwIGNvZGUgd3JpdGUgYSByZXN0b3JlIHRva2VuLg0KDQpUaG9zZSBhcmUg
c3RpbGwgcHJvYmFibHkgbm90IGVub3VnaCB0byBzdG9wIGFsbCBST1AgZ2l2ZW4gZXh0cmVtZQ0K
dGhyZWF0IG1vZGVscywgYXMgQW5keSBhbGx1ZGVkLiBCdXQgdG8gbWUsIHRoaXMgb25lIHNlZW1l
ZCBtYXliZSB3b3J0aA0KdHJ5aW5nIHRvIGltcHJvdmUuIEVzcGVjaWFsbHkgdGhpbmtpbmcgdG8g
YXZvaWQgZnV0dXJlIEFCSSBjaGFuZ2VzIGlmDQppdCBiZWNvbWVzIGEgcHJvYmxlbS4gV291bGQg
YW55b25lIGxpa2UgdG8gc2VlIGF0dGVtcHRzIHRvIHRpZ2h0ZW4gdGhpcw0KdXAgYnkgcmV2aXNp
dGluZyB0aGlzIHNoYWRvdyBzdGFjayBhbGxvY2F0aW9uIGludGVyZmFjZT8NCg0KVGhhbmtzLA0K
DQpSaWNrDQoNClswXSANCmh0dHBzOi8vZ2l0bGFiLmNvbS94ODYtZ2xpYmMvZ2xpYmMvLS9jb21t
aXQvOThlYmEwYjgyOWExODg0YzdkN2JmNzZiMGIzOTcyNTkxOWE5YjZhZiM5MmM4Njc2M2RmNjg0
NWM1YjI5NjY0YWMyZmY0MDI3NzY3OGZkMmM1XzBfMQ0K
