Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF874AE405
	for <lists+linux-arch@lfdr.de>; Tue,  8 Feb 2022 23:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387572AbiBHWZS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Feb 2022 17:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386968AbiBHVhB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Feb 2022 16:37:01 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C2FC0612B8;
        Tue,  8 Feb 2022 13:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644356219; x=1675892219;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=T/IAoQLvB0Lg8HIzGgwZ9F7g8CFabStavZcxRogEKkA=;
  b=l0pynamc8nQthvisVThU8tp4wimqvsoDHbriKgLUScMFqNKF/5DzJ5Dz
   N3o/UgsWCStSG/Ej127rn9yTSsk3qUFLR5r6QvRt9qx+UdJrPUHMhd412
   cv5lnoacH1AxjMYrULkPeYMh14vepJyIAp6GzaYpl8cDy4GqDEhq380Hc
   5UZpptKDXdQl+5df49T27PiNZug91pV2SZANTj34m2H5q3zfRFNxXKhyx
   Qy4q5gYxQIrXqN9CEqXomlJakWzMPluR32ogq08kBBXWfjyBJ7lu5WA65
   UsJKzjMM02FYYgrgGcw5ajmFV4F26byeuLSEttQtqFcEmXEDuciOBAAlI
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="229029813"
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="229029813"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 13:36:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="484965434"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga006.jf.intel.com with ESMTP; 08 Feb 2022 13:36:58 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 8 Feb 2022 13:36:58 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 8 Feb 2022 13:36:57 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 8 Feb 2022 13:36:57 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 8 Feb 2022 13:36:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRfkikjgZnJiw+mpEs9T1Bk4PPMVni16etsmxzxnt4kEeq0UCQeFR8WVeRs1jWR561mF+Br/jeKOHhb6TENBuhh2/b3k3vxUwdBxzSpPWbY+pcv2PlhiuPR6lOd8MWnPDQjARfZTohi0VhcmuvlDoabFl/y2oYCYnWPwL3E23vPc4hwiQ70IKXJjqi4DNv+lhwswaglbvF/hKT0lJBtSo2QW0ZLDFa/DiqhGq1YLK+d4KvyQz9EwAh4G3wfsjO2+3E2JIV5/6NPJwqtfPTvDCLFHs6naX+Tx+2ZMLmxw3ovQr/6Yf4CQgQOhkk8g0obOq7WybsmRsMCgjEFMgWz3rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/IAoQLvB0Lg8HIzGgwZ9F7g8CFabStavZcxRogEKkA=;
 b=NZCwEh0QfOEyUC/vTkTw1bxIZO1oxyuIwNrvU7EvALPvzCja/20srImqZr+n562dcIy1w4EEEKqbp0wjoMVXrHmWyq7or1Ufxy0zcEUz77aG++/SU8P/JdMldt/SkE76vuIKvKx43geDGBRpjB0nlTcijg+WDckt9HQDFDcvsAG36ATiNkUw/rMRkkN7oC0OgFZwN++X5TVVC92cS8EXkFXD33b79gCRjBzZawd+MjrFgj0FHs8BTWUW8j1/YSoEeAfQQRnH8In7ruhQO7CSLJSpu2Ua/ZzWblJZD5Oil4Alze2GJfnpOZg61m7LKJUsrR+VaVQnnO9xJOTy0B92ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CH0PR11MB5708.namprd11.prod.outlook.com (2603:10b6:610:111::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Tue, 8 Feb
 2022 21:36:54 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 21:36:54 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
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
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: Re: [PATCH 05/35] x86/fpu/xstate: Introduce CET MSR and XSAVES
 supervisor states
Thread-Topic: [PATCH 05/35] x86/fpu/xstate: Introduce CET MSR and XSAVES
 supervisor states
Thread-Index: AQHYFh9wEHwD2PSKkU6YFZngZmqSvayIyIiAgAFzMoA=
Date:   Tue, 8 Feb 2022 21:36:54 +0000
Message-ID: <7f4d29e0700b310a964d6db5451e6facfb555841.camel@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
         <20220130211838.8382-6-rick.p.edgecombe@intel.com>
         <9ad0f7f7-e034-eb6d-eee4-1e977123efe7@intel.com>
In-Reply-To: <9ad0f7f7-e034-eb6d-eee4-1e977123efe7@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72b19882-b130-4231-0047-08d9eb4b201c
x-ms-traffictypediagnostic: CH0PR11MB5708:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CH0PR11MB570847426069316D088C0FD6C92D9@CH0PR11MB5708.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hg5Q4kohwstMU8UlL8La2D62AUC+0k8W+wjdoY1MKEc+srXE1pOb5lzhFrd9x1gkqbFgZue0YRF/gsFa5WB+GGPqB2Ctjg/oRsDFy1dNfyhat3+i36zzpTnyWveB0jT3Y1RXPujDckXX40742wj+2CgbkabBn5OGk8y259hIqx2Kh1WfKS6lIqaqt9blQkZ0VgJtH7d2XSMF2Cjr5Rzx4+bkVgk4O4bPZ1Ap9F0gyDFtCJ9DhaFDpy3or3g4xeAPqUll/ZKSYUstngSTJbqKh7G/jN7oZqNplaVt8K0/Q2dbPvrqBfqJa0bxvcwO4KcT+rUEkYzSomksmUQcAiZzbmItgPkFTqQuA4Kp9o6bMViJCKGrqYQ/zO/6heZ+nKXfibNwwBNsUBatntDknrnJ1cDjPcQP8+C1PyjGDKt70jpfB1kMIexkE1r4pPpYvxdla0CaAt50HYwbhH6S48sdD9AhwB8tm4IHzY8nKd9tP0DaV5uo3CU14N2XiDtc27ri856c922TSbRfCpD3QCp4zyn2XRf0a3jX9DzOV9XBYO52al5xOuPM5HEx8t+KOgat1FD8xWsA593DSzSjLW6lgjMZg5FjKDEK6SMex48CRNRiH+BUYmFlWiUGuRtkezhoVdgOa7M5VdvD3q2mg1PJn2xp5E2ccoccsYA4OQkpzVbVkjsOYKJ/94tTWy2nEEquKURA0Yy7nMLAxD5hvqoV0wBmgMZ0ztgIQ+qp556NopAvl/ELW5ssH+oTFNvqdBtf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(71200400001)(5660300002)(7406005)(7416002)(2616005)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(8936002)(6506007)(66946007)(6512007)(2906002)(53546011)(38070700005)(76116006)(26005)(83380400001)(110136005)(86362001)(36756003)(508600001)(122000001)(38100700002)(82960400001)(921005)(6486002)(316002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGFQa1I3M256V1VGN1RIc1FWSjFXZm9UV0E5RXFUL0ZqK2NBTThPaVdDY3Rh?=
 =?utf-8?B?bHoyb0ZIdCtiTnRDd3JmYWlaMXJ5VDE1ZmthS1g5VWhTdmp5R09XdzNtanAx?=
 =?utf-8?B?NExFa3hQMmpOYU5sdzZ5QUlmaTlnK2wxanB2dEZGOXY3SjVVdnMyNVFnK1pz?=
 =?utf-8?B?bHE0b1RESThtOVdBaFUrZFcvUkoxNzNvUlVIWWhMQkdwU3IwNC9kb0JTaHAx?=
 =?utf-8?B?VStLdllhTUpOdkNzOER2R24wQkh0QXV6MWZlVWhwaG5vWTdlZTlmR3dDUGMz?=
 =?utf-8?B?Z2hKb2N1Wkk1VVJKMnFMQUJ5VEQrZy9jd3UybkdQSGpyWjVlWFJidlFWWTJF?=
 =?utf-8?B?OUNucHFLVWNzS25KNjFKc25PWm5FeFdBcG51MlNpRGJZVEYxRS9FZmQ5MlNN?=
 =?utf-8?B?cGE1WkxtOFltQitHdzNBNVBhRUdLZ1pDakdxTXZud3FvZ240MW9WUDBFRTFq?=
 =?utf-8?B?c1BPV0V4cjhaTUlVUTZxS2g4QnFXUmFCdFBmOXBNMzNWOUdManVMdEZvckZV?=
 =?utf-8?B?T0JkN0srSTRMR2ZERGRnN3prTENXVHRySGhBRTA5em9ReSs1TVJxSjJlbWRF?=
 =?utf-8?B?ZVdZUEN0Q2hlVWxHRDMybmc2RUJCa1pyT0tkTHM4VVgzVThpUHEzTUFlUU5S?=
 =?utf-8?B?SVpkSmlvcmp0cThvYUtoR3RYK1FwUVh2WHV4T0dXNmovN3ZzVGJPUzFaeVRC?=
 =?utf-8?B?Z0x4cnhhNDlpbzRyaHl1NEppT3FBbEs0Z3htOGVmU3ZORUlIdG9YbTBzZWgv?=
 =?utf-8?B?T0haZ1ExL1lpUU1nMU1uazZPdEhMdURqTDJPOFNRaU9mZEwxMlZPbXM3ZSt1?=
 =?utf-8?B?S01CM0xXcVA3VDhnWEN0QWpMbzgxNnRsb3dEM0hiQ3pyWGdaZWlmdFNEUUE1?=
 =?utf-8?B?VFU3KytSNmlyMnV2YWlaUE5vTmRZQlk4UHp0dU5OaUxMS3dURENldnQrTGxm?=
 =?utf-8?B?dE4wNzVsQUMwQ3ZiMkJUWG1uekxIVDlkNHdQanZmV25kL09Kb01ManJRb29p?=
 =?utf-8?B?cnN2Z1J0cXBueER1U2lBMVFLU2ovbnF0aXM0YzB0bm9QS2FmbldMWTdLUHlF?=
 =?utf-8?B?YVJzclhma1JGd1VHWGVFclVmN0NhUk1RQ01Dd1VGZEc4T0pZZ1JxM1VEaVZ3?=
 =?utf-8?B?eWpudU5kZlhWbHZsS3ljSmlUc1FMUUwvYzFzMkh1bGNXYkh0dFExMlJyVnpo?=
 =?utf-8?B?aVBIazRsN2Z6c3EySUwrYWpiZ25HTFErc2IyYVZNU04weWJMaEQrL3VCem5s?=
 =?utf-8?B?ZVVEeXNNbUtlVFRqU3p3YlVHQ3VxNmJCYmpzTUlndTg0Q0JPbG1HSUJic08z?=
 =?utf-8?B?akxkQmhxdVpmYk5HUDBNSXl5ajdrMVY0QWlHVlY3RE1PK1JBc2JHQkM0LzZ0?=
 =?utf-8?B?MHk5QnZNQndneU91MVRWMldaNk9zdjdnai9CeGlHUlVuSUQ1cFRzMHRZQ1p3?=
 =?utf-8?B?ZVdsaUFnZkpGRFZTVFJRbGw1RG9UaXhqQXVody9ZUTJzekR1Z2Y0UWVqcFdv?=
 =?utf-8?B?SDFoVGxTejBkcmNnQWYzL1ZkTlhXY0V4bTdGVkV0WjA2MWVVTXJCSjhLRHJs?=
 =?utf-8?B?VUtqTi9ZcFIvTnh5S3cvQnZqK3l4Ky85M1NxclBTSmZoZFczS0dNNjJnSXJ5?=
 =?utf-8?B?UVROTi90Ky9iRTBKNi9hM1pYNyszRjhaaDUzZkQ5R3pqUlpRTXIrdEpsS2Jr?=
 =?utf-8?B?Y1J5RVpoYnA1WnF1NktrYnRpREtuQ3pxVTQyWE5sS2taUWY2MGl6dVU4eVkr?=
 =?utf-8?B?cklITEJPdTVoMGJtakJHL3hWa0J2aVB1dFJzQUZEUlgyQXQyc2ttbmQ5Z1RQ?=
 =?utf-8?B?TTRLVnBLYTVVNGpuTC9yNVo3Zm0vWE5QK3VPUkF2SnNFZ2NwVmloRHBRMnFJ?=
 =?utf-8?B?d3dSb3R4WEQ0aXVYZEZJTTl2TnUwNVRLQ0J6aXF2V1VUNlZ4dTlWWjRPUjBw?=
 =?utf-8?B?c2IrTkw5a0NBRlkzSHZsYjhRTUkxRFRpdXVrWmRvYmdwZHJPMUlnUmUvNUdx?=
 =?utf-8?B?T1VtWENZcmQwOFVaOFM4SVhYVTk4cit3RFRnb1RGKzZ3RE5odXVweU5oejNx?=
 =?utf-8?B?N3dJWVorMkpEQ1FxUkJBM2tYYXFsMjA1cTdXeHZRWVAyWXlKMmNjMnl3OFln?=
 =?utf-8?B?TGdiMjhhdndiRFQvaWJ2cTRtaHR1cEk4MVVpb1hXWnRKQUZjd1NpSklMdUh0?=
 =?utf-8?B?SGdwNW5oVnJPSHUvd1RXY21BWi96TXpZNnBUU1BkdU9wYitqQmhTdnMxb3JV?=
 =?utf-8?Q?nvuZwX/OaYlznbIhTvG+oYsMlXDGYn/eqwokWyPmAw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <069179B460A0A84B972C4C4A26C0CC82@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b19882-b130-4231-0047-08d9eb4b201c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 21:36:54.1228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RHD4KSruXeGv/tamHpi6bwqzgKab1489uIFCEpor8N3OQIDt+6ql1hgszepAPPOJMCm/feWt1NWg6fn9lDq0XIxPQaELIgGGGgesTi6bLBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5708
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTAyLTA3IGF0IDE1OjI4IC0wODAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gMS8zMC8yMiAxMzoxOCwgUmljayBFZGdlY29tYmUgd3JvdGU6DQo+ID4gRnJvbTogWXUtY2hl
bmcgWXUgPHl1LWNoZW5nLnl1QGludGVsLmNvbT4NCj4gPiANCj4gPiBDb250cm9sLWZsb3cgRW5m
b3JjZW1lbnQgVGVjaG5vbG9neSAoQ0VUKSBpbnRyb2R1Y2VzIHRoZXNlIE1TUnM6DQo+ID4gDQo+
ID4gICAgIE1TUl9JQTMyX1VfQ0VUICh1c2VyLW1vZGUgQ0VUIHNldHRpbmdzKSwNCj4gPiAgICAg
TVNSX0lBMzJfUEwzX1NTUCAodXNlci1tb2RlIHNoYWRvdyBzdGFjayBwb2ludGVyKSwNCj4gPiAN
Cj4gPiAgICAgTVNSX0lBMzJfUEwwX1NTUCAoa2VybmVsLW1vZGUgc2hhZG93IHN0YWNrIHBvaW50
ZXIpLA0KPiA+ICAgICBNU1JfSUEzMl9QTDFfU1NQIChQcml2aWxlZ2UgTGV2ZWwgMSBzaGFkb3cg
c3RhY2sgcG9pbnRlciksDQo+ID4gICAgIE1TUl9JQTMyX1BMMl9TU1AgKFByaXZpbGVnZSBMZXZl
bCAyIHNoYWRvdyBzdGFjayBwb2ludGVyKSwNCj4gPiAgICAgTVNSX0lBMzJfU19DRVQgKGtlcm5l
bC1tb2RlIENFVCBzZXR0aW5ncyksDQo+ID4gICAgIE1TUl9JQTMyX0lOVF9TU1BfVEFCIChleGNl
cHRpb24gc2hhZG93IHN0YWNrIHRhYmxlKS4NCj4gDQo+IFRvIGJlIGhvbmVzdCwgSSdtIG5vdCBz
dXJlIHRoaXMgaXMgdmVyeSB2YWx1YWJsZS4gIEl0J3MgKlZFUlkqIGNsb3NlDQo+IHRvDQo+IHRo
ZSBleGFjdCBpbmZvcm1hdGlvbiBpbiB0aGUgc3RydWN0dXJlIGRlZmluaXRpb25zLiAgSXQncyBh
bHNvIG5vdA0KPiBvYnZpb3VzbHkgcmVsYXRlZCB0byBYU0FWRS4gIEl0J3MgbW9yZSBvZiB0aGUg
IndoYXQiIHRoaXMgcGF0Y2ggZG9lcw0KPiB0aGFuIHRoZSAid2h5Ii4gIEdvb2QgY2hhbmdlbG9n
cyB0YWxrIGFib3V0ICJ3aHkiLg0KDQpPayBJJ2xsIGxvb2sgYXQgcmUtd29yZGluZyB0aGlzLg0K
DQo+IA0KPiA+IFRoZSB0d28gdXNlci1tb2RlIE1TUnMgYmVsb25nIHRvIFhGRUFUVVJFX0NFVF9V
U0VSLiAgVGhlIGZpcnN0DQo+ID4gdGhyZWUgb2YNCj4gPiBrZXJuZWwtbW9kZSBNU1JzIGJlbG9u
ZyB0byBYRkVBVFVSRV9DRVRfS0VSTkVMLiAgQm90aCBYU0FWRVMgc3RhdGVzDQo+ID4gYXJlDQo+
ID4gc3VwZXJ2aXNvciBzdGF0ZXMuICBUaGlzIG1lYW5zIHRoYXQgdGhlcmUgaXMgbm8gZGlyZWN0
LA0KPiA+IHVucHJpdmlsZWdlZCBhY2Nlc3MNCj4gPiB0byB0aGVzZSBzdGF0ZXMsIG1ha2luZyBp
dCBoYXJkZXIgZm9yIGFuIGF0dGFja2VyIHRvIHN1YnZlcnQgQ0VULg0KDQpPaCwgd2VsbCBJIGd1
ZXNzIHRoaXMgKmlzKiBtZW50aW9uZWQgZWxzZXdoZXJlLCB0aGFuIGluIHBhdGNoIDMuDQoNCj4g
DQo+IEZvcmdpdmUgbWUgd2hpbGUgSSBnbyBpbnRvIGNoYW5nZWxvZyBsZWN0dXJlIG1vZGUgZm9y
IGEgbW9tZW50Lg0KPiANCj4gSSB3YXMgY29uc3RhbnRseSBsb29raW5nIHVwIGF0IHRoZSBsaXN0
IG9mIE1TUnMgYW5kIHRyeWluZyB0bw0KPiByZWNvbmNpbGUNCj4gdGhlbSB3aXRoIHRoaXMgcGFy
YWdyYXBoLiAgSW1hZ2luZSBpZiB5b3UgaGFkIHN0YXJ0ZWQgb3V0IHRoaXMNCj4gY2hhbmdlbG9n
DQo+IGJ5IHNheWluZzoNCj4gDQo+IAlTaGFkb3cgc3RhY2sgcmVnaXN0ZXIgc3RhdGUgY2FuIGJl
IG1hbmFnZWQgd2l0aCBYU0FWRS4gIFRoZQ0KPiAJcmVnaXN0ZXJzIGNhbiBsb2dpY2FsbHkgYmUg
c2VwYXJhdGVkIGludG8gdHdvIGdyb3VwczoNCj4gDQo+IAkJKiBSZWdpc3RlcnMgY29udHJvbGxp
bmcgdXNlci1tb2RlIG9wZXJhdGlvbg0KPiAJCSogUmVnaXN0ZXJzIGNvbnRyb2xsaW5nIGtlcm5l
bC1tb2RlIG9wZXJhdGlvbg0KPiANCj4gCVRoZSBhcmNoaXRlY3R1cmUgaGFzIHR3byBuZXcgWFNB
VkUgc3RhdGUgY29tcG9uZW50czogb25lIGZvcg0KPiAJZWFjaCBncm91cCBvZiByZWdpc3RlcnMu
ICBUaGlzIF9sZXRzXyBhbiBPUyBtYW5hZ2UgdGhlbQ0KPiAJc2VwYXJhdGVseSBpZiBpdCBjaG9v
c2VzLiAgTGludXggY2hvb3NlcyB0byAuLi4gPGV4cGxhaW4gdGhlDQo+IAlkZXNpZ24gY2hvaWNl
IGhlcmUsIG9yIHdoeSB3ZSBkb24ndCBjYXJlIHlldD4uDQo+IA0KPiAJQm90aCBYU0FWRSBzdGF0
ZSBjb21wb25lbnRzIGFyZSBzdXBlcnZpc29yIHN0YXRlcywgZXZlbiB0aGUNCj4gCXN0YXRlIGNv
bnRyb2xsaW5nIHVzZXItbW9kZSBvcGVyYXRpb24uICBUaGlzIGlzIGEgZGVwYXJ0dXJlDQo+IGZy
b20NCj4gCWVhcmxpZXIgZmVhdHVyZXMgbGlrZSBwcm90ZWN0aW9uIGtleXMgd2hlcmUgdGhlIFBL
UlUgc3RhdGUgaXMNCj4gCWEgbm9ybWFsIHVzZXIgKG5vbi1zdXBlcnZpc29yKSBzdGF0ZS4gIEhh
dmluZyB0aGUgdXNlciBzdGF0ZSBiZQ0KPiAJDQo+IAlzdXBlcnZpc29yLW1hbmFnZWQgZW5zdXJl
cyB0aGVyZSBpcyBubyBkaXJlY3QsIHVucHJpdmlsZWdlZA0KPiAJYWNjZXNzIHRvIGl0LCBtYWtp
bmcgaXQgaGFyZGVyIGZvciBhbiBhdHRhY2tlciB0byBzdWJ2ZXJ0IENFVC4NCj4gDQo+IEFsc28s
IElCVCBndW5rIGlzIGluIGhlcmUgdG9vLCByaWdodD8gIExldCdzIGF0IGxlYXN0ICptZW50aW9u
KiB0aGF0DQo+IGluDQo+IHRoZSBjaGFuZ2Vsb2cuDQoNCldlIGNhbiByZW1vdmUgdGhlIElCVCBz
dHVmZiBpZiBpdHMgYmV0dGVyLiBJIGFsd2F5cyBhcHByZWNpYXRlIGZpbmRpbmcNCnRoZSB1bnVz
ZWQgZmVhdHVyZXMgaW4gaGVhZGVycyB3aGVuIGhhY2tpbmcgYXJvdW5kLiBCdXQgaXQgYWxsIGFk
ZHMgdG8NCmJ1aWxkIHRpbWUgc2xpZ2h0bHkgSSBndWVzcy4NCg0KPiANCj4gLi4uDQo+ID4gIC8q
IEFsbCBzdXBlcnZpc29yIHN0YXRlcyBpbmNsdWRpbmcgc3VwcG9ydGVkIGFuZCB1bnN1cHBvcnRl
ZA0KPiA+IHN0YXRlcy4gKi8NCj4gPiAgI2RlZmluZSBYRkVBVFVSRV9NQVNLX1NVUEVSVklTT1Jf
QUxMDQo+ID4gKFhGRUFUVVJFX01BU0tfU1VQRVJWSVNPUl9TVVBQT1JURUQgfCBcDQo+ID4gZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL21zci1pbmRleC5oDQo+ID4gYi9hcmNoL3g4
Ni9pbmNsdWRlL2FzbS9tc3ItaW5kZXguaA0KPiA+IGluZGV4IDNmYWYwZjk3ZWRiMS4uMGVlNzdj
ZTRjNzUzIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL21zci1pbmRleC5o
DQo+ID4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vbXNyLWluZGV4LmgNCj4gPiBAQCAtMzYy
LDYgKzM2MiwyNiBAQA0KPiA+ICANCj4gPiAgDQo+ID4gICNkZWZpbmUgTVNSX0NPUkVfUEVSRl9M
SU1JVF9SRUFTT05TCTB4MDAwMDA2OTANCj4gPiArDQo+ID4gKy8qIENvbnRyb2wtZmxvdyBFbmZv
cmNlbWVudCBUZWNobm9sb2d5IE1TUnMgKi8NCj4gPiArI2RlZmluZSBNU1JfSUEzMl9VX0NFVAkJ
CTB4MDAwMDA2YTAgLyogdXNlciBtb2RlDQo+ID4gY2V0IHNldHRpbmcgKi8NCj4gPiArI2RlZmlu
ZSBNU1JfSUEzMl9TX0NFVAkJCTB4MDAwMDA2YTIgLyoga2VybmVsDQo+ID4gbW9kZSBjZXQgc2V0
dGluZyAqLw0KPiA+ICsjZGVmaW5lIENFVF9TSFNUS19FTgkJCUJJVF9VTEwoMCkNCj4gPiArI2Rl
ZmluZSBDRVRfV1JTU19FTgkJCUJJVF9VTEwoMSkNCj4gPiArI2RlZmluZSBDRVRfRU5EQlJfRU4J
CQlCSVRfVUxMKDIpDQo+ID4gKyNkZWZpbmUgQ0VUX0xFR19JV19FTgkJCUJJVF9VTEwoMykNCj4g
PiArI2RlZmluZSBDRVRfTk9fVFJBQ0tfRU4JCQlCSVRfVUxMKDQpDQo+ID4gKyNkZWZpbmUgQ0VU
X1NVUFBSRVNTX0RJU0FCTEUJCUJJVF9VTEwoNSkNCj4gPiArI2RlZmluZSBDRVRfUkVTRVJWRUQJ
CQkoQklUX1VMTCg2KSB8DQo+ID4gQklUX1VMTCg3KSB8IEJJVF9VTEwoOCkgfCBCSVRfVUxMKDkp
KQ0KPiANCj4gV291bGQgR0VOTUFTS19VTEwoKSBsb29rIGFueSBuaWNlciBoZXJlPyAgSSBndWVz
cyBpdCdzIHByZXR0eSBjbGVhcg0KPiBhcy1pcyB0aGF0IGJpdHMgNi0+OSBhcmUgcmVzZXJ2ZWQu
DQoNCkhtbSwgdmlzdWFsbHkgSSB0aGluayBpdCBtaWdodCBiZSBlYXNpZXIgdG8gY2F0Y2ggdGhh
dCB5b3UgbmVlZCB0bw0KcmVtb3ZlIGEgcmVzZXJ2ZWQgYml0IGlmIGl0IGlzIGJlaW5nIGFkZGVk
IGFmdGVyIGJlY29taW5nIHVucmVzZXJ2ZWQNCnNvbWUgZGF5Lg0KDQo+IA0KPiA+ICsjZGVmaW5l
IENFVF9TVVBQUkVTUwkJCUJJVF9VTEwoMTApDQo+ID4gKyNkZWZpbmUgQ0VUX1dBSVRfRU5EQlIJ
CQlCSVRfVUxMKDExKQ0KPiANCj4gQXJlIHRob3NlIGJpdCBmaWVsZHMgY29tbW9uIGZvciBib3Ro
IHJlZ2lzdGVycz8gIEl0IG1pZ2h0IGJlIHdvcnRoIGENCj4gY29tbWVudCB0byBtZW50aW9uIHRo
YXQuDQoNClllcywgSSdsbCBtZW50aW9uIHRoYXQuDQoNCj4gDQo+ID4gKyNkZWZpbmUgTVNSX0lB
MzJfUEwwX1NTUAkJMHgwMDAwMDZhNCAvKiBrZXJuZWwgc2hhZG93DQo+ID4gc3RhY2sgcG9pbnRl
ciAqLw0KPiA+ICsjZGVmaW5lIE1TUl9JQTMyX1BMMV9TU1AJCTB4MDAwMDA2YTUgLyogcmluZy0x
IHNoYWRvdw0KPiA+IHN0YWNrIHBvaW50ZXIgKi8NCj4gPiArI2RlZmluZSBNU1JfSUEzMl9QTDJf
U1NQCQkweDAwMDAwNmE2IC8qIHJpbmctMiBzaGFkb3cNCj4gPiBzdGFjayBwb2ludGVyICovDQo+
IA0KPiBBcmUgUEwxLzIgZXZlciB1c2VkIGluIHRoaXMgaW1wbGVtZW50YXRpb24/ICBJZiBub3Qs
IGxldCdzIGF4ZSB0aGVzZQ0KPiBkZWZpbml0aW9ucy4NCg0KVGhleSBhcmUgbm90IHVzZWQuIE9r
Lg0KDQo+IA0KPiA+ICsjZGVmaW5lIE1TUl9JQTMyX1BMM19TU1AJCTB4MDAwMDA2YTcgLyogdXNl
ciBzaGFkb3cgc3RhY2sNCj4gPiBwb2ludGVyICovDQo+ID4gKyNkZWZpbmUgTVNSX0lBMzJfSU5U
X1NTUF9UQUIJCTB4MDAwMDA2YTggLyogZXhjZXB0aW9uDQo+ID4gc2hhZG93IHN0YWNrIHRhYmxl
ICovDQo+ID4gKw0KPiA+ICAjZGVmaW5lIE1TUl9HRlhfUEVSRl9MSU1JVF9SRUFTT05TCTB4MDAw
MDA2QjANCj4gPiAgI2RlZmluZSBNU1JfUklOR19QRVJGX0xJTUlUX1JFQVNPTlMJMHgwMDAwMDZC
MQ0KPiA+ICANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2ZwdS94c3RhdGUuYw0K
PiA+IGIvYXJjaC94ODYva2VybmVsL2ZwdS94c3RhdGUuYw0KPiA+IGluZGV4IDAyYjNkZGFmNGY3
NS4uNDQzOTcyMDI3NjJiIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9mcHUveHN0
YXRlLmMNCj4gPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvZnB1L3hzdGF0ZS5jDQo+ID4gQEAgLTUw
LDYgKzUwLDggQEAgc3RhdGljIGNvbnN0IGNoYXIgKnhmZWF0dXJlX25hbWVzW10gPQ0KPiA+ICAJ
IlByb2Nlc3NvciBUcmFjZSAodW51c2VkKSIJLA0KPiA+ICAJIlByb3RlY3Rpb24gS2V5cyBVc2Vy
IHJlZ2lzdGVycyIsDQo+ID4gIAkiUEFTSUQgc3RhdGUiLA0KPiA+ICsJIkNvbnRyb2wtZmxvdyBV
c2VyIHJlZ2lzdGVycyIJLA0KPiA+ICsJIkNvbnRyb2wtZmxvdyBLZXJuZWwgcmVnaXN0ZXJzIgks
DQo+ID4gIAkidW5rbm93biB4c3RhdGUgZmVhdHVyZSIJLA0KPiA+ICAJInVua25vd24geHN0YXRl
IGZlYXR1cmUiCSwNCj4gPiAgCSJ1bmtub3duIHhzdGF0ZSBmZWF0dXJlIgksDQo+ID4gQEAgLTcz
LDYgKzc1LDggQEAgc3RhdGljIHVuc2lnbmVkIHNob3J0IHhzYXZlX2NwdWlkX2ZlYXR1cmVzW10N
Cj4gPiBfX2luaXRkYXRhID0gew0KPiA+ICAJW1hGRUFUVVJFX1BUX1VOSU1QTEVNRU5URURfU09f
RkFSXQk9IFg4Nl9GRUFUVVJFX0lOVEVMX1BULA0KPiA+ICAJW1hGRUFUVVJFX1BLUlVdCQkJCT0g
WDg2X0ZFQVRVUkVfUEtVLA0KPiA+ICAJW1hGRUFUVVJFX1BBU0lEXQkJCT0gWDg2X0ZFQVRVUkVf
RU5RQ01ELA0KPiA+ICsJW1hGRUFUVVJFX0NFVF9VU0VSXQkJCT0gWDg2X0ZFQVRVUkVfU0hTVEss
DQo+ID4gKwlbWEZFQVRVUkVfQ0VUX0tFUk5FTF0JCQk9DQo+ID4gWDg2X0ZFQVRVUkVfU0hTVEss
DQo+ID4gIAlbWEZFQVRVUkVfWFRJTEVfQ0ZHXQkJCT0NCj4gPiBYODZfRkVBVFVSRV9BTVhfVElM
RSwNCj4gPiAgCVtYRkVBVFVSRV9YVElMRV9EQVRBXQkJCT0NCj4gPiBYODZfRkVBVFVSRV9BTVhf
VElMRSwNCj4gPiAgfTsNCj4gPiBAQCAtMjUwLDYgKzI1NCw4IEBAIHN0YXRpYyB2b2lkIF9faW5p
dCBwcmludF94c3RhdGVfZmVhdHVyZXModm9pZCkNCj4gPiAgCXByaW50X3hzdGF0ZV9mZWF0dXJl
KFhGRUFUVVJFX01BU0tfSGkxNl9aTU0pOw0KPiA+ICAJcHJpbnRfeHN0YXRlX2ZlYXR1cmUoWEZF
QVRVUkVfTUFTS19QS1JVKTsNCj4gPiAgCXByaW50X3hzdGF0ZV9mZWF0dXJlKFhGRUFUVVJFX01B
U0tfUEFTSUQpOw0KPiA+ICsJcHJpbnRfeHN0YXRlX2ZlYXR1cmUoWEZFQVRVUkVfTUFTS19DRVRf
VVNFUik7DQo+ID4gKwlwcmludF94c3RhdGVfZmVhdHVyZShYRkVBVFVSRV9NQVNLX0NFVF9LRVJO
RUwpOw0KPiA+ICAJcHJpbnRfeHN0YXRlX2ZlYXR1cmUoWEZFQVRVUkVfTUFTS19YVElMRV9DRkcp
Ow0KPiA+ICAJcHJpbnRfeHN0YXRlX2ZlYXR1cmUoWEZFQVRVUkVfTUFTS19YVElMRV9EQVRBKTsN
Cj4gPiAgfQ0KPiA+IEBAIC00MDUsNiArNDExLDcgQEAgc3RhdGljIF9faW5pdCB2b2lkIG9zX3hy
c3Rvcl9ib290aW5nKHN0cnVjdA0KPiA+IHhyZWdzX3N0YXRlICp4c3RhdGUpDQo+ID4gIAkgWEZF
QVRVUkVfTUFTS19CTkRSRUdTIHwJCVwNCj4gPiAgCSBYRkVBVFVSRV9NQVNLX0JORENTUiB8CQkJ
XA0KPiA+ICAJIFhGRUFUVVJFX01BU0tfUEFTSUQgfAkJCVwNCj4gPiArCSBYRkVBVFVSRV9NQVNL
X0NFVF9VU0VSIHwJCVwNCj4gPiAgCSBYRkVBVFVSRV9NQVNLX1hUSUxFKQ0KPiA+ICANCj4gPiAg
LyoNCj4gPiBAQCAtNjIxLDYgKzYyOCw4IEBAIHN0YXRpYyBib29sIF9faW5pdA0KPiA+IGNoZWNr
X3hzdGF0ZV9hZ2FpbnN0X3N0cnVjdChpbnQgbnIpDQo+ID4gIAlYQ0hFQ0tfU1ooc3osIG5yLCBY
RkVBVFVSRV9QS1JVLCAgICAgIHN0cnVjdCBwa3J1X3N0YXRlKTsNCj4gPiAgCVhDSEVDS19TWihz
eiwgbnIsIFhGRUFUVVJFX1BBU0lELCAgICAgc3RydWN0IGlhMzJfcGFzaWRfc3RhdGUpOw0KPiA+
ICAJWENIRUNLX1NaKHN6LCBuciwgWEZFQVRVUkVfWFRJTEVfQ0ZHLCBzdHJ1Y3QgeHRpbGVfY2Zn
KTsNCj4gPiArCVhDSEVDS19TWihzeiwgbnIsIFhGRUFUVVJFX0NFVF9VU0VSLCAgIHN0cnVjdCBj
ZXRfdXNlcl9zdGF0ZSk7DQo+ID4gKwlYQ0hFQ0tfU1ooc3osIG5yLCBYRkVBVFVSRV9DRVRfS0VS
TkVMLCBzdHJ1Y3QNCj4gPiBjZXRfa2VybmVsX3N0YXRlKTsNCj4gPiAgDQo+ID4gIAkvKiBUaGUg
dGlsZSBkYXRhIHNpemUgdmFyaWVzIGJldHdlZW4gaW1wbGVtZW50YXRpb25zLiAqLw0KPiA+ICAJ
aWYgKG5yID09IFhGRUFUVVJFX1hUSUxFX0RBVEEpDQo+ID4gQEAgLTYzNCw3ICs2NDMsOSBAQCBz
dGF0aWMgYm9vbCBfX2luaXQNCj4gPiBjaGVja194c3RhdGVfYWdhaW5zdF9zdHJ1Y3QoaW50IG5y
KQ0KPiA+ICAJaWYgKChuciA8IFhGRUFUVVJFX1lNTSkgfHwNCj4gPiAgCSAgICAobnIgPj0gWEZF
QVRVUkVfTUFYKSB8fA0KPiA+ICAJICAgIChuciA9PSBYRkVBVFVSRV9QVF9VTklNUExFTUVOVEVE
X1NPX0ZBUikgfHwNCj4gPiAtCSAgICAoKG5yID49IFhGRUFUVVJFX1JTUlZEX0NPTVBfMTEpICYm
IChuciA8PQ0KPiA+IFhGRUFUVVJFX1JTUlZEX0NPTVBfMTYpKSkgew0KPiA+ICsJICAgIChuciA9
PSBYRkVBVFVSRV9SU1JWRF9DT01QXzEzKSB8fA0KPiA+ICsJICAgIChuciA9PSBYRkVBVFVSRV9S
U1JWRF9DT01QXzE0KSB8fA0KPiA+ICsJICAgIChuciA9PSBYRkVBVFVSRV9SU1JWRF9DT01QXzE2
KSkgew0KPiA+ICAJCVdBUk5fT05DRSgxLCAibm8gc3RydWN0dXJlIGZvciB4c3RhdGU6ICVkXG4i
LCBucik7DQo+ID4gIAkJWFNUQVRFX1dBUk5fT04oMSk7DQo+ID4gIAkJcmV0dXJuIGZhbHNlOw0K
PiANCj4gVGhhdCBpZigpIGlzIGdldHRpbmcgdW53ZWlsZHkuICBXaGlsZSBJIGdlbmVyYWxseSBk
ZXNwaXNlIG1hY3Jvcw0KPiBpbXBsaWNpdGx5IG1vZGlmeWluZyB2YXJpYWJsZXMsIHRoaXMgbWln
aHQgYmUgd29ydGggaXQuICBXZSBjb3VsZA0KPiBoYXZlIGENCj4gbG9jYWwgZnVuY3Rpb24gdmFy
aWFibGU6DQo+IA0KPiAJYm9vbCBmZWF0dXJlX2NoZWNrZWQgPSBmYWxzZTsNCj4gDQo+IGFuZCB0
aGVuIG11Y2sgd2l0aCBpdCBpbiB0aGUgbWFjcm86DQo+IA0KPiAjZGVmaW5lIFhDSEVDS19TWihz
eiwgbnIsIG5yX21hY3JvLCBfX3N0cnVjdCkgZG8gew0KPiAJaWYgKG5yID09IG5yX21hY3JvKSkg
ew0KPiAJCWZlYXR1cmVfY2hlY2tlZCA9IHRydWU7DQo+IAkJaWYgKFdBUk5fT05DRShzeiAhPSBz
aXplb2YoX19zdHJ1Y3QpLCAuLi4gKSB7DQo+IAkJCV9feHN0YXRlX2R1bXBfbGVhdmVzKCk7DQo+
IAkJfQ0KPiAgICAgICAgIH0NCj4gfSB3aGlsZSAoMCkNCj4gDQo+IFRoZW4gdGhlIGlmKCkganVz
dCBtYWtlcyBzdXJlIHRoZSBmZWF0dXJlIHdhcyBjaGVja2VkIGluc3RlYWQgb2YNCj4gY2hlY2tp
bmcgZm9yIHJlc2VydmVkIGZlYXR1cmVzIGV4cGxpY2l0bHkuICBXZSBjb3VsZCBhbHNvIGRvOg0K
PiANCj4gCWJvb2wgYyA9IGZhbHNlOw0KPiANCj4gCS4uLg0KPiANCj4gICAgICAgICBjIHw9IFhD
SEVDS19TWihzeiwgbnIsIFhGRUFUVVJFX1lNTSwgICAgICAgc3RydWN0DQo+IHltbWhfc3RydWN0
KTsNCj4gICAgICAgICBjIHw9IFhDSEVDS19TWihzeiwgbnIsIFhGRUFUVVJFX0JORFJFR1MsICAg
c3RydWN0IC4uLg0KPiAgICAgICAgIGMgfD0gWENIRUNLX1NaKHN6LCBuciwgWEZFQVRVUkVfQk5E
Q1NSLCAgICBzdHJ1Y3QgLi4uDQo+IAkuLi4NCj4gDQo+IGJ1dCB0aGF0IHN0YXJ0cyB0byBydW4g
aW50byA4MCBjb2x1bW5zLiAgVGhvc2UgYXJlIGJvdGggbmljZSBiZWNhdXNlDQo+IHRoZXkgbWVh
biB5b3UgZG9uJ3QgaGF2ZSB0byBtYWludGFpbiBhIGxpc3Qgb2YgcmVzZXJ2ZWQgZmVhdHVyZXMg
aW4NCj4gdGhlDQo+IGNvZGUuICBBbm90aGVyIG9wdGlvbiB3b3VsZCBiZSB0byBkZWZpbmUgYToN
Cj4gDQo+IGJvb2wgeGZlYXR1cmVfaXNfcmVzZXJ2ZWQoaW50IG5yKQ0KPiB7DQo+IAlzd2l0Y2gg
KG5yKSB7DQo+IAkJY2FzZSBYRkVBVFVSRV9SU1JWRF9DT01QXzEzOg0KPiAJCS4uLg0KPiANCj4g
c28gdGhlIGlmKCkgbG9va3MgbmljZXIgYW5kIHdvbid0IGdyb3c7IHRoZSBmdW5jdGlvbiB3aWxs
IGdyb3cNCj4gaW5zdGVhZC4NCj4gDQo+IEVpdGhlciB3YXksIEkgdGhpbmsgdGhpcyBuZWVkcyBz
b21lIHJlZmFjdG9yaW5nLg0KDQpZZXMsIHRoaXMgbWFrZXMgc2Vuc2UuIEknbGwgcGxheSBhcm91
bmQgd2l0aCBpdC4NCg==
