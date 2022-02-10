Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7190D4B19A9
	for <lists+linux-arch@lfdr.de>; Fri, 11 Feb 2022 00:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345608AbiBJXkV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Feb 2022 18:40:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345717AbiBJXkU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Feb 2022 18:40:20 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A955F6E;
        Thu, 10 Feb 2022 15:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644536420; x=1676072420;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oL8twP3wIiFkDuXzn2YeSTjt/3hA1W+ZIgsXDEtT8DU=;
  b=dSpwNjjBTtVZKQKteQvcpNJhe+ReV4L3UN2iVUUTKI7nd0/6Cvq3Ti9c
   qf+60pt6umH3eRUY3V2eguIls9AY3CAa69qCK+roO6KBLX4V9aS4wv1DT
   xEwA1slgkYsCxMjjxXUJYM+smdI5ng+wQPnec38+KTE85kRQIB8ljaFT6
   /ync0cxZt6MABGWhhl8t/dpXFRJzHwTRvbwwNlTclJIFK58/zs61FXVzH
   yAVaVwRd6I7KpbXwWMHmzupCsNmNvFZ+Md6/T5phA5QbiFpi7dTNJy9Nn
   nnUEjVJMhXYC13TFa2ayfISOjyi7U9iKi1JkjXCc1A92ws31U+wWmAe46
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="312902716"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="312902716"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 15:40:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="701890158"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 10 Feb 2022 15:40:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 10 Feb 2022 15:40:19 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 10 Feb 2022 15:40:18 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 10 Feb 2022 15:40:18 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 10 Feb 2022 15:40:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7TeGq4mJU+NfdCWbsDrhgvJZ4tXGL0kjcFAyM/CwcjpC5KTHxljt0HQnaPmjW4Jcmnm4JpQtVL48qrl2fmYwSUSQI9eF5G4k9bt1F/XPJklok1yx0xqQjMjMdjMl/MHHwX/cVS9RU95HiqQBt/zCHB4Q4f23qm3bAcVeJrB7op406/m0vXLy8ctzs83w8XGCXk2e05zK0q/yqh3CMFOSOnQ9w7MiT3i+XhpupDtI+G+GAqq+GBMCQ96HMSiLvTbisVMafRNyUxl7WPmEd1DIISKkqO/pw3jityvCegxGQcaT7AT6NBGcY7g70t1kbCcnb/kWgnfLXoSa5H8eF+C8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oL8twP3wIiFkDuXzn2YeSTjt/3hA1W+ZIgsXDEtT8DU=;
 b=XzKbnyOkPoi1KpaydDtx2MaIQ1ybrTKJDTU6JKTiUaORLby6QC3C1rdQwxkHUwQh4y9BUmvkPOgBoiQ1NZXxBEMNwV8LuqPsAVHK6qL451YU39Bd5c2IWYNtAnVCRONznCF/C/qc8nAcLQN1/CcOgV45QskYR4+f1PqFZmLNaKeVJ7nqIGDXgkOYZ0teUkevMgzkx3ZwDY4hjc3+48hMAwKHtLtEz+Ogg2qsN4vvhEVmYjP7urnS1X5dsiswN/3jQr7r7ioM1y0CTzbVcGTwFcKqX3WMUJoDtv+BcFP4ZTDubydJOgDD3pEhWW/oO6vcXgoBHzBZIN9PUy5A2cAwcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CY4PR1101MB2358.namprd11.prod.outlook.com (2603:10b6:903:ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 23:40:16 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15%4]) with mapi id 15.20.4951.021; Thu, 10 Feb 2022
 23:40:16 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Lutomirski, Andy" <luto@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
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
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.martin@arm.com" <dave.martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH 18/35] mm: Add guard pages around a shadow stack.
Thread-Topic: [PATCH 18/35] mm: Add guard pages around a shadow stack.
Thread-Index: AQHYFh91Wc0p4+RWw0irm7tPRuygp6yNcwuAgAAGkYCAAAlAgA==
Date:   Thu, 10 Feb 2022 23:40:16 +0000
Message-ID: <e16fcf166d8304b0b9358e8413ec4a7ffc1de147.camel@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
         <20220130211838.8382-19-rick.p.edgecombe@intel.com>
         <4c216532-2b68-dd95-93f1-542df4786d7a@intel.com>
         <CALCETrWmiNi2+sPKWDUjGtGWtP9XNryfFe-dG4fTQkXyqGqpzQ@mail.gmail.com>
In-Reply-To: <CALCETrWmiNi2+sPKWDUjGtGWtP9XNryfFe-dG4fTQkXyqGqpzQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af31c853-f076-4510-6640-08d9eceeb103
x-ms-traffictypediagnostic: CY4PR1101MB2358:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CY4PR1101MB2358E080E6205DED40CAD998C92F9@CY4PR1101MB2358.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gL5ZiW3BvcR+tVwgCcEdLeJIHNhi1v39GbpsVS9u+TDp0xpNycAdelKAjubO4Kwt43dQ55jNp3Hvhkb/BqD0scaShrYM+wgivVMq856VqYRDQMzziYgFEXhavcHHVSUUavmwvcL2Rljp4G4a9gM+IsQ8J7rcdgwDQOslRCUaDHpDqbREpPGZrChrERHUF/cz/J9hZNx8ax5MO05IAaKZOkrjrvZLf0r4XMtWSfkc/Z0QfHXFMlgDn9e+F8RbnN+Erp0SpG42Kcy5zQYI9BA0TuY7wQ2O08edMeUArTkAT5OePfRItXMxx6xiLXxse76TnxDuL4YWn4nnRqYdslhk2UVGk8eFyzjz9J9hcO3gOCsLi/dMI+OBEL+xCbUx4Qyqh9maUt5T98YKNPvX8TkbaUdbte44xVFoyFn3oeaUzemUtaUUdf0DuzIcuUpL5SFmQq4Oxk5t7UEN2Xn2EFY5TGAJ/bJtRH7VNM/PWTyK5Jtuwm3b/IoPqX4WMsxkMTcv4pbRJmSnmsSXAywLLJwrtdUeBEJmy1BMGU0Td59I53r9seBQxtQlFOSwVvVu0TeoJAKL3wHcUdqyEPaW8m5o1X/tHdoqbLF94ewvzeg7UWjoto9ADyCU/pgzPOMBbE871Wblz9u77LK8yV05f++QvZlOkTySEtnqGqpqQNbmwLCIXTBYg7CYADueC7mTgdtphtVMFDOY8wmhVD5R+7+Oz6B3MClz3NWDx71ZZQoEKzA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(6486002)(36756003)(38070700005)(110136005)(316002)(6636002)(2906002)(86362001)(6512007)(508600001)(54906003)(6506007)(7416002)(7406005)(82960400001)(66446008)(26005)(186003)(2616005)(83380400001)(66946007)(38100700002)(5660300002)(66556008)(64756008)(66476007)(8936002)(8676002)(122000001)(76116006)(4326008)(71200400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnAwK3dKTjNJTWVXbDR5UkRHSGxNK0lUbmEzaGQ3ZFIrbkxjRzZkMjU1QkVV?=
 =?utf-8?B?MUNIOXBLME8yZFlIVHlVdGNkcHJtd0c0S3ZqNjgvNkRUaXBoVWxVT0crSnpY?=
 =?utf-8?B?aHpjd3BqWkQzdGRKQnNFV0tySnJZcGJIamVDemZKTWFoRXJqYVEwS0Z0RHBX?=
 =?utf-8?B?eFRHbEdyWkNpSjIzbE5kVkd2T1BNZ1lpUTNYajFZSUV0aUgzSlY1T241aGh2?=
 =?utf-8?B?TlFhRnMrYUFCNjdsWDJlaW5DMENmeEVNc1hkMENHN3VkTkd5RGNzV0RWbSs2?=
 =?utf-8?B?NUFITmp0dHdERWlUL0FLOWxhUnZnUEYwUk1qWHVtNmlaaDRWKzh0M1lLYW4y?=
 =?utf-8?B?Tk5LVVl6TE1uU09OeW12aVRuY00wcjFZK2dzM1hSZm9iOU9nZDhOTXNtMC9h?=
 =?utf-8?B?MXJHVkhlRDNCZDdMS3k2OTBCMHprVmxlNlZ5UHljTEFxeHBvT28vQ3RqcUZP?=
 =?utf-8?B?NTN3dCt4R0VpaFFkZ2ZUMjMrb3ZseWpJenBaNENtUmUydG1TamJFZUdCWXMv?=
 =?utf-8?B?RFFJMHFPbWdtbnB6NHF5dk9kZzNWUXJ5M2F6YWdOVFJBdXQyK1E3NDdPbGZH?=
 =?utf-8?B?aW1tTGJSNjl4NmlSNDRvSVFNbmtjbVlwR2Q3WUxML1Z3alZ2TGNubGJvMVp1?=
 =?utf-8?B?eVRIMzAyQnQyVUE0Sk5BNTRrejNZQ2VBMXRkdXQxTDhHQjVtUEVBK1ZzWmJr?=
 =?utf-8?B?T1QvMjBMcitmWlZLMnJ6Q0MremtYMHUrVGJVdStHRTRBa2R0Vm4xRXZkWkJK?=
 =?utf-8?B?Y2hvWnVwaDZVSkVYbFlCU1BJY2dyckFVeUlxZ29qQklLdkpWbUlPTnZlMnhX?=
 =?utf-8?B?YThwcG51MitlOUJlQy95ZFRLLzhxY3FBeWVOVk5OTkRCRWpaRU9JSkxSclM1?=
 =?utf-8?B?ZW41OHRTTkdmaWFiWVRJR0NTRVQzV1paTWJ3YzZ0cGo5YVVIVXJYR3ZIWlc5?=
 =?utf-8?B?Y2JYQVJEM1NiRW80ZzR6VDN0SzROUjExSWJ1QVJiVEJDbVhNeEZWRFVRLzBC?=
 =?utf-8?B?bFhRUHZXaENveHJQd2VuSVorbHdIZ21OWVU4WFU4UkRFc1pQRENpRktPSDJH?=
 =?utf-8?B?VW1aWTcyOGJ6UDFuaXpBN0dPSVhFRGcyVi9mYWVVblplc0RzcHVyYTY2RThL?=
 =?utf-8?B?aUc2VnA4T2NWQmk0OUJFVFJ1dDd4eDFpMmhmOHcvOVprVGd0cm01UkZoekgr?=
 =?utf-8?B?Q3NWdmNwWGtQQXZyWHpLckNSKzdyWVBZUGN3S1hiclZpYVZPa1QrZzF3RzZy?=
 =?utf-8?B?WmVuNDRhT2Z1OGlKd05EY2ovS2VqV2NQSG9OQ3RnL0VyOE96SUZHa2tjcmR3?=
 =?utf-8?B?a2IvUnJRWW5MbzZJNHQ2WEl0cWY1a0YvSWtqazA3Rk92SG51eFlRUGZhZmcz?=
 =?utf-8?B?N2xWM3kzQ1hscFp5dDVONGdLWnpES2RzbGNPdXJhbWYrZVhtamRkWnh1MDFi?=
 =?utf-8?B?bjlrRE9ycnVJcWxpdlRtTHZNaXZXVWg0aDVwTDkxQ1BvQmZFQ2Z3TVdTQTd5?=
 =?utf-8?B?NzR3b3BDUU8zZkh4WnBpaHB6c2ErUy81Q3pRUTF3YXd4TGdkMXdqckRlQmFw?=
 =?utf-8?B?RDRSek5JWDdod1ZhcDZ1OWlBTThUMFpxVzMyOTdMcjBxOUV0K0dTZHZ5ZDln?=
 =?utf-8?B?TlRsNEJ3eWZwcEVaeno4VVhSZTZDM0Jad1dRMERpNWRyUDlmUWtqT2ltOXVw?=
 =?utf-8?B?UXBqM25vWmx1WEo1NkpTYmhGNkh0Ti8rZW9ZY0tlK0tJNytkM2RHaWlEQ3Az?=
 =?utf-8?B?REVDQUJVNjEzY0FuTW1scG5oOTE2QVhCeW4wTkZQV3M5QTVYd0kwdi9vTk1n?=
 =?utf-8?B?b2U3N29QdHkrbkI1TlpBSURGSmtBQ013TUgybjRQdzdKQ0ZaQnJwSGxGbStV?=
 =?utf-8?B?SlcwanRZMHZOT3NFbkNkaDdRMitpL1phZmZYMk5URzZZb2g1ZGVDMU9sei9s?=
 =?utf-8?B?M0UzeUpTNDBwOHVyU29ZU3R0WXQrVzhZYkRqZWhuSlRiZzl5eU9sMzB6Wk1s?=
 =?utf-8?B?OGVVT0MxOU1JRzc5R3RYR3NIdm9YcGRpck1zQkd4L0JNU0NTTjJseFNheDFZ?=
 =?utf-8?B?UHFwd204VDJHU2pkRGhQUml1clpmTEhSNFpDajN0M3hXay9INmZod0dZVjIv?=
 =?utf-8?B?b3E3M2JoMG1LenFJRmRnOFFROElKaDhGYUhRSUVBeXRnSzF2TmltVFdnU0t2?=
 =?utf-8?B?K2ttM0JmOVVabFNFUzRVaUZtbEdMTHIyOHBIcXJHUDdpbmV1MFBKODVvcHVu?=
 =?utf-8?Q?ukfnHVz3V1e88M3vxg7iMGDC9If1ggRwzA4lbb5ekA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71412308ED0A5B4AA1CA9770557A3101@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af31c853-f076-4510-6640-08d9eceeb103
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 23:40:16.4703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NLHmdPQzAPLth4nQjAcEvotZnH33C9GRzcaaveyau9ffwn4IiR0mk+ThSBeNxhmFNQY4VJPdS4QG596crv66IQCKwbEiLYp0nHYaJ5qY8Rk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2358
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIyLTAyLTEwIGF0IDE1OjA3IC0wODAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6
DQo+IE9uIFRodSwgRmViIDEwLCAyMDIyIGF0IDI6NDQgUE0gRGF2ZSBIYW5zZW4gPGRhdmUuaGFu
c2VuQGludGVsLmNvbT4NCj4gd3JvdGU6DQo+ID4gDQo+ID4gT24gMS8zMC8yMiAxMzoxOCwgUmlj
ayBFZGdlY29tYmUgd3JvdGU6DQo+ID4gPiBJTkNTU1AoUS9EKSBpbmNyZW1lbnRzIHNoYWRvdyBz
dGFjayBwb2ludGVyIGFuZCAncG9wcyBhbmQNCj4gPiA+IGRpc2NhcmRzJyB0aGUNCj4gPiA+IGZp
cnN0IGFuZCB0aGUgbGFzdCBlbGVtZW50cyBpbiB0aGUgcmFuZ2UsIGVmZmVjdGl2ZWx5IHRvdWNo
ZXMNCj4gPiA+IHRob3NlIG1lbW9yeQ0KPiA+ID4gYXJlYXMuDQo+ID4gPiANCj4gPiA+IFRoZSBt
YXhpbXVtIG1vdmluZyBkaXN0YW5jZSBieSBJTkNTU1BRIGlzIDI1NSAqIDggPSAyMDQwIGJ5dGVz
DQo+ID4gPiBhbmQNCj4gPiA+IDI1NSAqIDQgPSAxMDIwIGJ5dGVzIGJ5IElOQ1NTUEQuICBCb3Ro
IHJhbmdlcyBhcmUgZmFyIGZyb20NCj4gPiA+IFBBR0VfU0laRS4NCj4gPiA+IFRodXMsIHB1dHRp
bmcgYSBnYXAgcGFnZSBvbiBib3RoIGVuZHMgb2YgYSBzaGFkb3cgc3RhY2sgcHJldmVudHMNCj4g
PiA+IElOQ1NTUCwNCj4gPiA+IENBTEwsIGFuZCBSRVQgZnJvbSBnb2luZyBiZXlvbmQuDQo+ID4g
DQo+ID4gV2hhdCBpcyB0aGUgZG93bnNpZGUgb2Ygbm90IGFwcGx5aW5nIHRoaXMgcGF0Y2g/ICBU
aGUgc2hhZG93IHN0YWNrDQo+ID4gZ2FwDQo+ID4gaXMgMU1CIGluc3RlYWQgb2YgNGs/DQo+ID4g
DQo+ID4gVGhhdCwgZnJhbmtseSwgZG9lc24ndCBzZWVtIHRvbyBiYWQuICBIb3cgYmFkbHkgZG8g
d2UgKm5lZWQqIHRoaXMNCj4gPiBwYXRjaD8NCg0KTGlrZSBqdXN0IHVzaW5nIFZNX1NIQURPV19T
VEFDSyB8IFZNX0dST1dTRE9XTiB0byBnZXQgYSByZWd1bGFyIHN0YWNrDQpzaXplZCBnYXA/IEkg
dGhpbmsgaXQgY291bGQgd29yay4gSXQgYWxzbyBzaW1wbGlmaWVzIHRoZSBtbS0+c3RhY2tfdm0N
CmFjY291bnRpbmcuDQoNCkl0IHdvdWxkIG5vIGxvbmdlciBnZXQgYSBnYXAgYXQgdGhlIGVuZCB0
aG91Z2guIEkgZG9uJ3QgdGhpbmsgaXQncw0KbmVlZGVkLg0KDQo+IA0KPiAxTUIgb2Ygb2VyLXRo
cmVhZCBndWFyZCBhZGRyZXNzIHNwYWNlIGluIGEgMzItYml0IHByb2dyYW0gbWF5IGJlIGENCj4g
c2hvdyBzdG9wcGVyLiAgRG8gd2UgaW50ZW5kIHRvIHN1cHBvcnQgYW55IG9mIHRoaXMgZm9yIDMy
LWJpdD8NCg0KSXQgaXMgc3VwcG9ydGVkIGluIHRoZSAzMiBiaXQgY29tcGF0aWJpbGl0eSBtb2Rl
LCBhbHRob3VnaCBJQlQgaGFkDQpkcm9wcGVkIGl0LiBJIGd1ZXNzIHRoaXMgd2FzIHByb2JhYmx5
IHRoZSByZWFzb24uDQo=
