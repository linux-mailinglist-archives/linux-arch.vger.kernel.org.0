Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE32641FA5
	for <lists+linux-arch@lfdr.de>; Sun,  4 Dec 2022 21:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiLDUvc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 4 Dec 2022 15:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiLDUvb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 4 Dec 2022 15:51:31 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8BD1260A;
        Sun,  4 Dec 2022 12:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670187090; x=1701723090;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IEQZzO5+SJIhY2K9i354gr2aAGwuAbJXmy2N7DAZXKk=;
  b=UiTB+59MHHGcYMq9hCVC/M5p2emQkKFadwlwu9qOJWXDivC1kDnPPFpF
   p6aWLEHs4RPLrR7VasPOk4x2o73H85O+rc4+B6fPDXy/ilVBCQpehOvHk
   YSrc8QbyvILlSL5hzFydzmOSdscrQwYNy48wQDhRviUrBbHgalvxigb7e
   3JdUPOaNrcOzXFw9e5ik2PFB57VbEwWkRc2IFcaqmYnxE3RWeeeY9Ifvo
   LO7+iBkj4QMtzrpbdXokBI3sWwIGc0C0t6/TG/RcPKgfkH0M9B7xjp2Mr
   e3QOKdrGUeikNBcdk+PNsXMj2XN58kfYS1mh/EK1jM6fBWW1xrLodTxHR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="303838786"
X-IronPort-AV: E=Sophos;i="5.96,217,1665471600"; 
   d="scan'208";a="303838786"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2022 12:51:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="645594522"
X-IronPort-AV: E=Sophos;i="5.96,217,1665471600"; 
   d="scan'208";a="645594522"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 04 Dec 2022 12:51:28 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 4 Dec 2022 12:51:28 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 4 Dec 2022 12:51:27 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 4 Dec 2022 12:51:27 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 4 Dec 2022 12:51:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVH/j7Dvch3/TPRPU/2SmWzxBg8RD4PSOnY5eXsAeyXPbM8k02p9JMjdNGn5nrZKDVHEMLoL7l9RG4xg+XZyw0JY8z0CJNeBZ/751DggbQHtrTr1gRdMj0xVxN3ma9+ctSgcBdSe3t07A6CJpyoAZNcGOEnyO+gTs+SU+IwFy6ku7rL2205b/rnOt+IMDVdmKMuIk2KwQrWDqETBHmP2aFat+lEZNP96b+mErtSTDoQ+0rkf98aNKNFm5UQ1WUNwJnHpwxkhzJQEZ4GUJIdxP0rcsum3wK12wDzQAQhAPynkv13uVByjmWe1zbY27wBhWa4TsHK3h0QIvql+qVC9qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEQZzO5+SJIhY2K9i354gr2aAGwuAbJXmy2N7DAZXKk=;
 b=ZlG9T6G/K7qEoB4Df/osx/KLoPIABtvG4ZJnY4K1bFJvgqvo5gppV3jyfSIf26z8qxm4XqItnQEw8IggR4YTl47H0KkAQqQIU91JEO8iwOXUhc5ayxdQyT5KguZSP1C0WWDECsSaW0FnQIRcTzxPI4aJThB67lkue3MEqzDGB3uoRnEzSY4oQV7il6+NDdUaHDiJlQMvbhCUfuCROiDVba1xolHpSPyCqmrZpKU0zHVZX5hs9KyPChn/l+UfIa4ByfYx7zz1dvZ3bTRYDnW5+w/gJ4uNklF5i5TbQsHbeBWFbRVFauoRe5Y+RoZO2bPPOSdwRTV54bIE7KOR4YVhNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH7PR11MB6607.namprd11.prod.outlook.com (2603:10b6:510:1b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Sun, 4 Dec
 2022 20:51:24 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff%5]) with mapi id 15.20.5880.013; Sun, 4 Dec 2022
 20:51:23 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Lutomirski, Andy" <luto@kernel.org>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 33/39] x86: Prevent 32 bit operations for 64 bit shstk
 tasks
Thread-Topic: [PATCH v4 33/39] x86: Prevent 32 bit operations for 64 bit shstk
 tasks
Thread-Index: AQHZBq94wdsyJh8FaUWxWY22Hx/U6K5cxacAgAFxTYA=
Date:   Sun, 4 Dec 2022 20:51:22 +0000
Message-ID: <20af3021fa4e9f1d9a322678b7ce1737d1931fee.camel@intel.com>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
         <20221203003606.6838-34-rick.p.edgecombe@intel.com>
         <CALCETrVMY4UadSrn3fTim5iCzPVf+XXnkyq57wjvnhVUNV1V5w@mail.gmail.com>
In-Reply-To: <CALCETrVMY4UadSrn3fTim5iCzPVf+XXnkyq57wjvnhVUNV1V5w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH7PR11MB6607:EE_
x-ms-office365-filtering-correlation-id: d0f4095c-155f-4556-7d38-08dad6394d9d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IuibLG9gbeazRf2IsIYtela2sMvqyd7BY6vCdZ3yHbCgAXebNDWN1CZ9V8A2ZrYPZMm8BnQ8kou/XlAqOrs751mOReV8LhObeQCZeWSK2EOIbRHhCUQObUjkzvUaibZoLq1L/8mtY/x7/Gg3MmsbOVuiG8WHTD6CsyAChQ+U0gK/cGeXLKbZH8ECc9pshJkxGyx+CU9NeWDGD7i6WWZSC9nZ7Crhv1INVzS097IvXnx1aIyjQI0fQriy53C6Bav0TW+WyW9zEueqDYMC7lhPygvsN2PrZlQHZyEEgFjK7Ov7kFVlej6tUrWya+0WHbl1l3dr0CA33eU9NH+2/GE0FhWVkSaAY0w0wUT96reKrcpfBP+tc/iy4x0BVPc05kzNYc0ffwembNeZ7paCaZQwKF8bNRtIiOZQj1zg56wB73HSWSd6bjf/JOcxIVkm4Sh8P3wbssESy/SoTN6PfsH+A8QTz2nHlrPcQqachYFczZaXz8qxcAnwnMVpHxOlGuK4PS5YUhLSEvwWlAsHvPBPdJeCLTIQv44siDHV2jo9UrDAR1+1pyddTtDogAzwES/Vtpbgr7FGnNL/V49J90SZcJ8yfmbX4rsssongvFLwfgYxDHptBdJgWLCvkllx1MJms4gHU8zJv21pPFYlL4Vay2pSC+2eTl1RLgn72nzF5hjDqmqJwarweFIlCvP9z+iTI+RxA1Nb6l2mP/NxnsoRKajHXd9NzWwVLae1t3OKWgA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199015)(82960400001)(38070700005)(122000001)(38100700002)(86362001)(71200400001)(8936002)(7416002)(7406005)(4744005)(2906002)(4326008)(41300700001)(5660300002)(8676002)(64756008)(53546011)(6512007)(26005)(6506007)(2616005)(186003)(54906003)(6916009)(316002)(76116006)(66946007)(66556008)(66476007)(66446008)(91956017)(6486002)(478600001)(36756003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXhySUluL2hTRGxUTVdLQ2d4TUxwRGc0Y3I2R0F5OHlkbXVGaWJGN0FMSUE1?=
 =?utf-8?B?UUUxSUpJaGxlS1NhdnRkckFPcWcxcXdCV0lEVTY1TUphRGR2TmhJc1NxK0tr?=
 =?utf-8?B?MDFndEw3TzBnNDU2alFXQ3dxWjMrTnZzUmV6QnVFZHdxaUczQ2V2MUxWOFdu?=
 =?utf-8?B?c0JvN3oxeDhzbko1aWxZUGwxZG93Z3lmajVSbU8yNU1Gd2d1ZXBXNVg3WDRj?=
 =?utf-8?B?bWhGbmxqaFlieWtpSVdnQTE3MkhVaEhpOUlCSXVUWmlFVnlibXJ0OGl1OGpq?=
 =?utf-8?B?NSszRExUa0ZROFdnNERlRk56bGZSZGRhaHF3S3NRSEN1K3p5c1FuRUt6VUd3?=
 =?utf-8?B?aDgxRTgvMDJIUnBvYXlKb29ObWJFQ0FuMDhDWUJpY0owYUhWYmoxcEhNY2hi?=
 =?utf-8?B?S1NOWjJPR2VrQ0lQWVRUajdBYm1POU1EWDFEZ0huYVF1dkpQK0hjcXRQOWNo?=
 =?utf-8?B?aXFGa0YxOFdFUitQMzhFT2d3WHNTakExVXA1RkVwRG9xeHRQbElOdXdGMFQy?=
 =?utf-8?B?SnpiZUR3TGR2T2RsamFNOGN3bGJoUlBxZ0JOdDh6ejJwcDdLY2dTU0tBMXVT?=
 =?utf-8?B?Z3hnRFUvYkFpTFhaUE5XOFJFV20xdHlXMU5Od3hMbGNPelFRcUEyQVppM2Jh?=
 =?utf-8?B?eTlxR3hRNkVOQWxZNG56NDVrYnRObFA0aWZJZXhmSnUxQ05xMmJGU2Q4TDRJ?=
 =?utf-8?B?TlA5dkRETENLUWJySlIxeEk2eWg1empZNFFrTkZRYjhUUFIrWkttaUdGS04v?=
 =?utf-8?B?dllLcmowa21oMHV0cWMyQnVGK1A5VGVJVlZBN3FmSk1ESXpBcHhzT25NNmps?=
 =?utf-8?B?NEpmZFBTTTJYSFNKOHhGcGo5Tm1rUHAxUWFzOS8zVFdPaU1DMU1BOFVMQkcy?=
 =?utf-8?B?OFFDU3hTcDlhMkQwSTVMT2o1Yy9aU0JEZVVIS2I1MzE2UVpFZnlYOTZVazBR?=
 =?utf-8?B?M1o1RkZPN09qdDJZS250UzdyT2I3b0tEaVVjRGJoM0NIVmJsaHpQNkptdjhU?=
 =?utf-8?B?dldRb0srcG1zMGQyS1dxYStuSkVNMHRIa2pWaUhYN01sa1hGOXRwL0xDOEVn?=
 =?utf-8?B?cnVwdEhwZ1NjOTdLK2tjUGVOSWVWZEFGZmJwZXlqeFh6OFlLK1BONzdOdUw5?=
 =?utf-8?B?dW5GQk9TU2VMNzN1ZlZKY056c1cxYzQ1UWlWZlpqWWZlbGlZQzd3dkFra2NB?=
 =?utf-8?B?V3pzNit4YXI0aWVxNno3WTk0VUFVanJ3RVM5ZlFoYXpCalRvdXU3MzczNXFp?=
 =?utf-8?B?SjlBQzRlVUlGWXp0Tkd0TjlwU3Z1aUV2QmhBdzlodnFBYkNGd2IxdkNqU1Bl?=
 =?utf-8?B?NGJXWUlPWHl0ZkNuMVFsOW1ZK1JSVGFNeXRkVVB4T2wrNEh6WkZsTzlpYWVq?=
 =?utf-8?B?RkFESjM3UUlPQ1dmVXl2MFlmeFZ3N1dRRlhKOFh5TjVRa3BrM09KMTBmVkVj?=
 =?utf-8?B?Wm9MZkZWZEZKTzE4L2w3cGZ2WGhqd3AzeHowcVg5SnRHWDhGNll5aWVRWFhv?=
 =?utf-8?B?bDhGd1paZWM5K01IRHdNY01LTW9SSDJPNmhpdXp0c1FkWEtSYnVuSEhDZ01v?=
 =?utf-8?B?eXlUUU82NWVpbHVCbjZHdXVJZm9qVG40bG5nVmRZMDBseWlVU08vcFhRdlJm?=
 =?utf-8?B?SnM1NXNDQ1h4NFdGdU84aXN0VnBRVlc5WHZ4VGtQZDNVcGY0S0JLbXdFT1JH?=
 =?utf-8?B?dmtDY0hBM0pxVHovR0xKdlhWc0FhZ0R3WTVvWjZvS084MmNadDhJdXdVNkpk?=
 =?utf-8?B?SEIxREI4ZFNNMnJCU0IraXRlNldTa21vb0FKWUFRL01wcEV0ZHE0M0Jpcm9z?=
 =?utf-8?B?dWM4c0lSZDVEeTVwSVRzNlMwTEsrTkxBN1JReVpPelVSVFlWQlowbHR5eksy?=
 =?utf-8?B?NERXemxjTi9JTXl3b3cwajRsT3kvQkMvSldzbW04NEhsS0cwVTM1bmYxVzdJ?=
 =?utf-8?B?QlQvMGE0QTdzNTdCV3ljQ1Z3YldCMjhPcEU3R1NoQVpMQ2c3NGRjV0xLcWY3?=
 =?utf-8?B?QmpEZUFVWk1NRlgxNTFNcnJ4RC9KUm9kNzRPRE9DVGl2SXN2WlBSMi9DUXRv?=
 =?utf-8?B?NVFFSURUbGxnR0wwTEVZNWRpMDBiY2ZncUNHWGhQUlFScVAwaGZZQ1JzMXBx?=
 =?utf-8?B?bWIvZXp6UGI2TjJraWgrL28vZnBtdWZHSmF4VUxnQ09zVytsUFA3RnZhOThY?=
 =?utf-8?Q?U2E5YYolCbNc1q23eFgRng4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4570289A4D19F6418EA5DB050143CF01@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f4095c-155f-4556-7d38-08dad6394d9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2022 20:51:22.9524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: saBjELTDqKqlCjVac/r2n8PRR611UrifY1Jgu11EU77QuxVLSQINAzbOyU+IfZn4LfjuPwkicEy/aG1LBhWuG6gIrE2RyYYtrvFlFaTL2QY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6607
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

T24gU2F0LCAyMDIyLTEyLTAzIGF0IDE0OjQ5IC0wODAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6
DQo+IE9uIEZyaSwgRGVjIDIsIDIwMjIgYXQgNDo0NCBQTSBSaWNrIEVkZ2Vjb21iZQ0KPiA8cmlj
ay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IFNvIHNpbmNlIDMyIGJp
dCBpcyBub3QgZWFzeSB0byBzdXBwb3J0LCBhbmQgdGhlcmUgYXJlIGxpa2VseSBub3QNCj4gPiBt
YW55DQo+ID4gdXNlcnMuIE1vcmUgY2xlYW5seSBkb24ndCBzdXBwb3J0IDMyIGJpdCBzaWduYWxz
IGluIGEgNjQgYml0DQo+ID4gYWRkcmVzcw0KPiA+IHNwYWNlIGJ5IG5vdCBhbGxvd2luZyAzMiBi
aXQgQUJJIHNpZ25hbCBoYW5kbGVycyB3aGVuIHNoYWRvdyBzdGFjaw0KPiA+IGlzDQo+ID4gZW5h
YmxlZC4gRG8gdGhpcyBieSBjbGVhcmluZyBhbnkgMzIgYml0IEFCSSBzaWduYWwgaGFuZGxlcnMg
d2hlbg0KPiA+IHNoYWRvdw0KPiA+IHN0YWNrIGlzIGVuYWJsZWQsIGFuZCBkaXNhbGxvdyBhbnkg
ZnVydGhlciAzMiBiaXQgQUJJIHNpZ25hbA0KPiA+IGhhbmRsZXJzLg0KPiA+IEFsc28sIHJldHVy
biBhbiBlcnJvciBjb2RlIGZvciB0aGUgY2xvbmUgb3BlcmF0aW9ucyB3aGVuIGluIGEgMzINCj4g
PiBiaXQNCj4gPiBzeXNjYWxsLg0KPiA+IA0KPiANCj4gVGhpcyBzZWVtcyB1bmZvcnR1bmF0ZS4g
IFRoZSByZXN1bHQgd2lsbCBiZSBhIGhpZ2hseSBpbmNvbXByZWhlbnNpYmxlDQo+IGNyYXNoLiAg
TWF5YmUgaW5zdGVhZCBkZW55IGVuYWJsaW5nIHNoYWRvdyBzdGFjayBpbiB0aGUgZmlyc3QgcGxh
Y2U/DQo+IE9yIGF0IGxlYXN0IHByX3dhcm5fb25jZSBpZiBhbnl0aGluZyBnZXRzIGZsdXNoZWQu
DQoNClRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24hIERlbnlpbmcgc2VlbXMgbXVjaCBiZXR0ZXIs
IEknbGwgY2hhbmdlIGl0Lg0K
