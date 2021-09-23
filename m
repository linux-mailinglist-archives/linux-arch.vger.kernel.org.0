Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17C1416882
	for <lists+linux-arch@lfdr.de>; Fri, 24 Sep 2021 01:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240717AbhIWXe0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Sep 2021 19:34:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:61328 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235628AbhIWXeZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Sep 2021 19:34:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="246426688"
X-IronPort-AV: E=Sophos;i="5.85,318,1624345200"; 
   d="scan'208";a="246426688"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 16:32:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,318,1624345200"; 
   d="scan'208";a="653833615"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga005.jf.intel.com with ESMTP; 23 Sep 2021 16:32:53 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 23 Sep 2021 16:32:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 23 Sep 2021 16:32:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 23 Sep 2021 16:32:52 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 23 Sep 2021 16:32:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbsYBH2Eq4PHVZHSxyJxMJwqj68GGv4FmsQpYJy8fcBOlOlhmPoLV+v42m5+mQKlouUvz/Xfvaf0Vmn9e9W8b76Its59lgN4EaOC8g/i5zXTHqitLOZWA2sJyxJ5INTvNMup9WDqqMU1TBrio3mjLXRW5kVMl4U5QsKolD0HUdLuCj3RskKK9OUtdJiVf0IvDn2BWM8UauYVUuVc/nOsbN+KoVZCUF+0hadGpljkZSeDm3XTpUfYLZM4Iu2OMrjwUq2pBhwqTqwKdaw6CnSUcxNmtnt2jMbg5ZJqxYWNd2zH+4bRiDMHv4tRLTLpXmoA0876JMRNlxivjfB0yXWPNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=6bVXQFzJ8vBokei2Bc67fUh/RRbqnOMoRlLmtZx7UZw=;
 b=PD+lZfrMs7DJJELfjT1WYkYYV7DRU3XcRCzi/wuDc0FvHvXKq57YobBaA+l60EK5V5r6OP9vup6mPEGuB/Kc7aJSV7hvS0FFmVYUD4uSglbycQPswrD4azO95w4WRPhUTj6CidkCw+Vn5WWEuGoJeqmY/+9RIfFP1SxylgO1t5O3pzqDz9+Vf309OM3ahQCsjEKSSxzF0LXHeA8J8zrQi+5g3nKPXsMSPobrcpJ9hFdoORrkkcsaz5lyOVL0Ru7gGicXseEiuD/z5yBISxU+G4sRDV2hS86f7Rm47osG/oBHPlmgqW82hJmnG1MEHwWfGG7U4BQ5X3cYDcZ79hk0Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bVXQFzJ8vBokei2Bc67fUh/RRbqnOMoRlLmtZx7UZw=;
 b=k2nB/qFPVZTNyRD75foZnZWFDd8cMkoqd2txEgTIv9C5LadvtLESorNqh5GlR62T6dsCOX2fMgw/WzJGvBCMNF/dilecme3nlZIrIJooUHI1RfS++Yx4IcHW8XZZ22T+3dWe/iGv8FlpDyBnxSGLkbwVvxaizRLjxG/xCM1YNmc=
Received: from SN6PR11MB3184.namprd11.prod.outlook.com (2603:10b6:805:bd::17)
 by SA2PR11MB5003.namprd11.prod.outlook.com (2603:10b6:806:11e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Thu, 23 Sep
 2021 23:32:47 +0000
Received: from SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::892e:cae1:bef0:935e]) by SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::892e:cae1:bef0:935e%6]) with mapi id 15.20.4523.022; Thu, 23 Sep 2021
 23:32:47 +0000
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
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "tarasmadan@google.com" <tarasmadan@google.com>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "vedvyas.shanbhogue@intel.com" <vedvyas.shanbhogue@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [NEEDS-REVIEW] Re: [PATCH v11 25/25] x86/cet/shstk: Add
 arch_prctl functions for shadow stack
Thread-Topic: [NEEDS-REVIEW] Re: [PATCH v11 25/25] x86/cet/shstk: Add
 arch_prctl functions for shadow stack
Thread-Index: AQHXpBafkXiywIsFO0GpZ4F+zmmfpKleug+AgAMcTACABC5WgIAAPYaAgjyGhQCACm2tAIAFKAoA
Date:   Thu, 23 Sep 2021 23:32:47 +0000
Message-ID: <1305ca8a74580a87d6c9aaa1c8d7f97422863ce0.camel@intel.com>
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
         <45c62101c065ed7e728fadac7207866bf8c36ec4.camel@intel.com>
         <b5b5787b-17ce-4e66-8bc6-ab42ae3e398d@www.fastmail.com>
In-Reply-To: <b5b5787b-17ce-4e66-8bc6-ab42ae3e398d@www.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ecdbf25-3e7a-491e-4528-08d97eea7392
x-ms-traffictypediagnostic: SA2PR11MB5003:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB50038CE820E394F8060901ADC9A39@SA2PR11MB5003.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k2opfqWHdsUY5cqJwE6Y78bzSwcAIx6thdoKHNYlzmh5DKcGsk6yp7j2LlMvBkJ8IznHXEIWjK0ttPIvYpo36kvVmyzjxrLSkC8e+Xt/PZo6Xa4obZChEQnKZXtL2dXs07/fJZchw8mLKF0zO2vE2MI1Qh23QPjjqHEtD+6jT38T1Bs2AZSph1DquKmvs9vF+xUB9niPoHSfjqvMZiGq5+MpCIWn8XmbDOF7Q8ng5g0Wew4wLL6Ffjtdlx5Q3LKcX/0iVhjypTiWmzaQ0Qx/Dh5fe49B31A3tZkXFUU45U+IgRVNUaoN9VNp8tiMxM68JrGZ3VRUcvnhZHoXAfkDCeDu80Ko44HRt3DquXwECujCUrfG8bLM2UdCvnWR9ss414FCKhCv69IqIwDcGENdXGhAj67sBAcGiWV6YrRYzcF5zqQY79G5Dn00gdYVcsHrpcxRda09D5KdloPakn3CzV3rqQh+j8tdirgfnrvRMntludfqvVFkuLtjQ6FVk348cV0ucTD0KU5OHKlsbWVPiV+ah1c0pNEcp4BGW0tkLrkFKFgK+P92/4rqxPR8Wv7sELIj1dM/pyVBCDoodR/iCl7ETZAgomAlWH+3/kzXAXkzZNJIyQTZD9JdNZTDwxC1QQiargagO6Xi86ymafQNak1k2YQfzKFDqixRVQobT1IV6Wmnz8PgxOeHC98noxwEZoJ2wWXH6ZdKq2MC3eCs8QlpuBovCESKeX+YjjKvlCA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3184.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(2906002)(38070700005)(8676002)(6512007)(91956017)(83380400001)(66946007)(76116006)(64756008)(186003)(86362001)(508600001)(5660300002)(38100700002)(66556008)(36756003)(4326008)(2616005)(66446008)(122000001)(6636002)(26005)(8936002)(316002)(6486002)(7416002)(66476007)(6506007)(110136005)(7406005)(54906003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3RGKy9uUHhWNEZKMmc0dWh2NG9hUVJLYVY3aFpWZjZMQU9CdjFWeWdvNVgw?=
 =?utf-8?B?NjZBZ0lISElQbi94M2pJNlJhWndnZ3A2YmRxLzlhU1BKV0VhcFptenhKTzBM?=
 =?utf-8?B?SW90T25ISzBIOHMvL3QrV2haWkJhUzQwaThHeTBBVWdZUDUyMkhsYlZIVW5D?=
 =?utf-8?B?dWE2K1Jqb2RiV0dPdjRpMVBxRDM1RjJtWkk5bUV0WlRXTzZaK1JMMFBWVmNT?=
 =?utf-8?B?bWZudGJYNWRzU2FSQUZpYzIydnBnbldTK2xJckQ4M3FmT3ZJb2RiY2taZzlo?=
 =?utf-8?B?cWgwSmVPSnNmOXFYemZuMmFCL0k3Qm1IYUIxczRQamgvY0NLQkFOVGVieTRa?=
 =?utf-8?B?am5tekw3M2YweUJQRTZSaVhlVGNqU0pEdXRETGVUOXd4d1o1QWF2Z1FEWUhj?=
 =?utf-8?B?Tk82WmxiTUhBUUExbGdTVUxWbmVTb2JDNU5XY2YvZ2puUUdtNkhMdjdtVWdI?=
 =?utf-8?B?L3J5VmM4UGtuSTMvTXFvV0FTQjJaMlNwYXJnZElDdVU3c09ZY3JaOFpaN01V?=
 =?utf-8?B?dERudzRMeWNMYkRnNVE1a1ExZ1JwOEFQRW1NMWdQd3grM051RDhYbTU5TFZr?=
 =?utf-8?B?ZUcyRGpLNFM1YUFNSkZGdmI3eVJVeTFFRzBDR0N1b0c2WE5HdHV6a2RNeFBm?=
 =?utf-8?B?am0rTi84cndjbmNzaXNpcno5SkphQlFnV2c1WGVxbmFjckYrZCtLNGY3UTJz?=
 =?utf-8?B?aC9zNkFwZ0VjRFZCYVhIMkFsTkhLWWRLb2ZMMXlWOUlXQVFqcFgvNGpTWWkv?=
 =?utf-8?B?Zy9oMHVDMDluMGZPRzI3ekVHNTg3YU1aSnNpNUxIQmUwM2JWYktaTE5BUHJG?=
 =?utf-8?B?K3JzQ24rRzFGOGJrODVjV1VqYzBCSVdpaTFWR3N3ZlNsdmZUY0xLNW4yL2pp?=
 =?utf-8?B?N0puZG9TSjBrTDdlbVhHYjMzdUl0d2FEYkRmTEdMNlh5MXRzVFYwZGVadUdh?=
 =?utf-8?B?cm15d2xmdU9vS3hTYTZFNDRyeHRYUk1XK0dZK2pPQ1M4ekYwNGFST1pOZmdY?=
 =?utf-8?B?SWFRbTBDbmZSVk85UmpCMDJRaDlTcjhDR3ZmV1dGSHRwSkFqRXlWUDQxSlJx?=
 =?utf-8?B?RzQvVnNBTW04Wmw4SXo3RDViNFJJY0hPcVBuSXRrTGRhdkZsOUZ3K1UwaGd4?=
 =?utf-8?B?c1FtVVp3NjBJYkhDSUlsWDdoUHJFT1VzUUoxMG1zVEsvMnVueHBSOXN6Mmor?=
 =?utf-8?B?R0t6cHBBdHREWEl1SjB6RmRQVFlNWDg4RThxcVVaZGdqS0hycWpVWTZaazM5?=
 =?utf-8?B?TGh5Uk5GUmJNYTI2WTkzUzVJT1c2RThlMklPRnV6Wm5YNGxvZmc5aE1VWkpL?=
 =?utf-8?B?YkVKVXJGZGtFa3gxaCtoeE1uNzdLQzJhQzVVSXFRV3J1eDNaM3pLN09TeHFJ?=
 =?utf-8?B?RTdldjAxdnE4VTNQbUJWdnZtN3lQSkIzbVFtV1dwR1pTcjhwL2tPUXNzNTFy?=
 =?utf-8?B?VVdyRFhHODIzamVUeUFqUW1zNGhEU2RtR2JaM2NPMnRxeWJXR25FYjBBbEY3?=
 =?utf-8?B?M0dBTkxlZnovd1VFUTNvamI3b0k1empCMWxKazc4YU1UMzlmTG4xOEQxU0Jx?=
 =?utf-8?B?d2FGTjEzTXIwOVlud0swMmp0ZVdOTUNJdkxMd3k3TWQ2eGxYUVExbVlOYStG?=
 =?utf-8?B?aEVUMWJ2TTlwUWpxNllYZFJkTDl6dW5mVnRwWXR3UU1uelYwWDRGZU9weUd4?=
 =?utf-8?B?dGs2aUZWMFZadCtjN0R4OWJmQWpZTDJSWE1BWmg0K2svM0FiVkxMWlhNaFdC?=
 =?utf-8?B?bldteTd3WkkvZVJlMi95ZnNkTFZCcmNTcTd2KzJzTG9ra3NMU3NGeXhhTlhy?=
 =?utf-8?B?eHB3MjRNM2pSS0o1dHM2dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5EFED9CB67E1F48B0E7B3B67BAD8295@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3184.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ecdbf25-3e7a-491e-4528-08d97eea7392
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 23:32:47.5209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JQQDFZdOZs0GDjZ0rk04Fdm49IATZyDueciDu6QMcYaQYZUtHNyiuVRG8VE162gBX41jj4qH4l0LlqQJiuCkT7XdISTnuzGYnvSZHn4vNi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5003
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIxLTA5LTIwIGF0IDA5OjQ4IC0wNzAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6
DQo+IE15IGdlbmVyYWwgb3BpbmlvbiBoZXJlICh0YWtlIHRoaXMgd2l0aCBhIGdyYWluIG9mIHNh
bHQgLS0gSSBoYXZlbid0DQo+IHBhZ2VkIGJhY2sgaW4gZXZlcnkgc2luZ2xlIGRldGFpbCkgaXMg
dGhhdCB0aGUga2VybmVsIHNob3VsZCBtYWtlIGl0DQo+IHN0cmFpZ2h0Zm9yd2FyZCBmb3IgYSBs
aWJjIHRvIGRvIHRoZSByaWdodCB0aGluZyB3aXRob3V0IG5hc3R5IHJhY2VzLA0KPiBjcm9zcy10
aHJlYWQgY29vcmRpbmF0aW9uLCBvciB1bm5lY2Vzc2FyeSBwZXJtaXNzaW9uIHRvIHdyaXRlIHRv
IHRoZQ0KPiBzdGFjay4gIEkgKmFsc28qIHRoaW5rIHRoYXQgaXQgc2hvdWxkIGJlIHBvc3NpYmxl
IGZvciB1c2Vyc3BhY2UgdG8NCj4gbWFuYWdlIGl0cyBvd24gc2hhZG93IHN0YWNrIGFsbG9jYXRp
b24gaWYgaXQgd2FudHMgdG8sIHNpbmNlIEknbSBzdXJlDQo+IHRoZXJlIHdpbGwgYmUgSklUIG9y
IGdyZWVuIHRocmVhZCBvciBvdGhlciB1c2UgY2FzZXMgdGhhdCB3YW50IHRvIGRvDQo+IGNyYXp5
IHRoaW5ncyB0aGF0IHdlIGZhaWwgdG8gYW50aWNpcGF0ZSB3aXRoIGluLWtlcm5lbCBtYWdpYy4N
Cj4gDQo+IFNvIHBlcmhhcHMgd2Ugc2hvdWxkIGtlZXAgdGhlIGV4cGxpY2l0IGFsbG9jYXRpb24g
YW5kIGZyZWUNCj4gb3BlcmF0aW9ucywgaGF2ZSBhIHdheSB0byBvcHQtaW4gdG8gV1JTUyBiZWlu
ZyBmbGlwcGVkIG9uLCBidXQgYWxzbw0KPiBkbyBvdXIgYmVzdCB0byBoYXZlIEFQSSB0aGF0IGhh
bmRsZSB0aGUga25vd24gY2FzZXMgd2VsbC4NCj4gDQo+IERvZXMgdGhhdCBtYWtlIHNlbnNlPyAg
Q2FuIHdlIGhhdmUgYm90aCBhcHByb2FjaGVzIHdvcmsgaW4gdGhlIHNhbWUNCj4ga2VybmVsPw0K
DQpJIHRoaW5rIHNvLiBJJ2xsIHRha2UgYSBsb29rIGF0IGFkZGluZyBhIHByY3RsIHRvIGVuYWJs
ZSBXUlNTLiBTaW5jZQ0KdGhlcmUgYWxyZWFkeSBpcyBBUkNIX1g4Nl9DRVRfRElTQUJMRSB0byBk
aXNhYmxlIENFVCwgaXQgZG9lc24ndCBzZWVtDQpsaWtlIGl0IHNob3VsZCBlc2NhbGF0ZSBhbnl0
aGluZy4gQW5kIEFSQ0hfWDg2X0NFVF9MT0NLIGNhbiBwcmV2ZW50DQp0dXJuaW5nIGl0IG9uIGlm
IGRlc2lyZWQuDQoNClRoYW5rcywNCg0KUmljaw0K
