Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AEA6ACCC8
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 19:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCFSg2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 13:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjCFSg1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 13:36:27 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BCE65045;
        Mon,  6 Mar 2023 10:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678127754; x=1709663754;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/Zh7eBp9zj6h5v8Sq6u9iBobJVo2hLD8OZh36ntXQLk=;
  b=WzrwWuGNmeGgxgf4LxIhO/W8bKQ+dph1byfyYuX5QGZhUMNLyuCnhJsZ
   94lZeG4PmBQVLVKuDd02WitYefg9u7zIGnQZNO44zgcGc5lK+1nRkhEYI
   p3dq8ak0jpeYAFGX0R5n6fIK7phR32nnLD1LyVezrBKQzrnBGixtDPWdB
   c1f8/eLQaZx8Mh5tnWz6o5e/iuLZUbro90jagv5nYn5fpQ5Sz0B7doUtt
   5lb39jLGP03bTPFsHr7Zvv1+nTZKiH3C92s1put3PfFSkVWubW3f6RgUi
   BcRXotQkAHNH8QgbOXSvbF+O2p8aM9rF8loV2rOWx9FwRp0h2XOCxlNUj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="316037339"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="316037339"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:33:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="922041332"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="922041332"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 06 Mar 2023 10:33:39 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 10:33:38 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 6 Mar 2023 10:33:38 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 6 Mar 2023 10:33:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLJa8ZhDP8JLIGzLxfKN5g0jYhVCzfeicB/j5co4ESmVnP5ma0LPvQN2jF6Fg64ukuwKYiU6qzZW5pQNy8jQZC0f7OubZMUELBnA5ckSu7EU74E+MQm/i2t4dc5NkRe9mDRiHfuqCTS+RYgfVSUCmLzAethd3GRRTuCQd2Tuhz5duYhhGWZM6/KWGZkNtFP4/fzQS6747TMwgAHJdNxJ1Wz9lJxRilibd5bEDB4pQRxCPry0mAqjY6etHE558QhnZ+Q2WR0AMzqBln8lDntpBOBrV4WvV7F9iN5G4QSsWsjJ36Dx4HJ0AdOoRR0w3p4vXEv6pNBFpuEvIBqfU7IuXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Zh7eBp9zj6h5v8Sq6u9iBobJVo2hLD8OZh36ntXQLk=;
 b=Ikx/1u+3+T4RJRBabeQ7kJWggT0xAZuk7JUY/uujUbF5Y/irADT7VwwMqX1kehIQuia190yORYFMEm5vNLq2dybR4XPV++1U1MPZDgmCyifu7JFOOqwerDGn5jwjBWkZ8QZPBwZktQBX9Xcos6hfqn51rYJyzjqOFoeDLgh01u7L1zDOaYjuCWLFaCMv57QdpG/PEYPCtiOkL5kakDg8hQZ3ZwvDi2e9CYFWMsCERxMSuRMTG+ZYVmQgncqSaj7RBmci2CgWH7u/xNL+77gBnZp9pQ+47w01lPIKUI6faMh+WEHdBxuiz/XblbIlbBR8KKN9BK59sRKpAer4E306/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by IA1PR11MB7388.namprd11.prod.outlook.com (2603:10b6:208:420::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22; Mon, 6 Mar
 2023 18:33:35 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 18:33:35 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Lutomirski, Andy" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>
CC:     "david@redhat.com" <david@redhat.com>,
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
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v7 24/41] mm: Don't allow write GUPs to shadow stack
 memory
Thread-Topic: [PATCH v7 24/41] mm: Don't allow write GUPs to shadow stack
 memory
Thread-Index: AQHZSvtA9HShWDZSHU6zwVvYYuImzq7txAeAgABVMoCAAAUggA==
Date:   Mon, 6 Mar 2023 18:33:34 +0000
Message-ID: <c3e21d54fdc025c8e09f90b57dd3de0751cefbfd.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-25-rick.p.edgecombe@intel.com>
         <ZAXmOZYcoR3hq/CH@zn.tnic>
         <CALCETrViDpTbuBk+9wQa-PNzKZerwk=4MmKMXw2v3Ysxuv2k3A@mail.gmail.com>
In-Reply-To: <CALCETrViDpTbuBk+9wQa-PNzKZerwk=4MmKMXw2v3Ysxuv2k3A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|IA1PR11MB7388:EE_
x-ms-office365-filtering-correlation-id: beed3382-74ce-4d28-9eb5-08db1e714b66
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uNhWpWf4X49jGeA3lS4PmJHckfhnopq6pKm1aDtaPwhP450jOHK08f8x+4cwJBwvXIjaktJPgd5Jhze37sDDbuOEbLcHUL6NeOWuM6ozwLUzonwmDfRCripwQpvLS8bs1+f9pEY4y7ETDde2Qdr52HDpPy3L9mtCPk9Jdmc6OiD02QRSCI1XKUYMLXbGa+REKRrvnD6OvsTf5OK0ZpxDUH9uyFQtDjP8oUjaDLD+ze+8tgE9ctj6SE1Q2R6TCvWFQmQcuV+8gY0PBRHDHcr8k0N5sVOUMMWmsj2t6T4DBWTAnhvYoC4ZQHW0D3dAl9KEPg7vj5lkCO45sgjf+Xwtqo7MI1rsX7bOzV82HxK3+yNOiWTMWvU5cgpCBBVxuDrOyM4egmct3x9blNKk+MClbfiDykedNCbGr0OEOQuanscAJ8n+2wlo7zHzQy9L7kVG5WIGun41qNIv9n1hG3V8gQc4nLdEyS3AiVYc+SN9DomEREC/KND1zzM6qKyn2kzGKuDgB9OAxLq8Zw5TrBrWXS8woaHmfTtPfQWARgo/8ad1o2UFeiQCVjYJsVinlP37AHAxXN6dvJ9kPL4weqI4SSl3czH1jTZKnzSkK2gvREYuTtBj49ZaFCZmusv/LF2pqbJWfrt0OX+E13kwP9DqCa9bucsWVib1BOy33JlkFxeQN+tCXCPD017IQcqp258Fkw7oFEfhLDNpypcDxOyUeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199018)(8936002)(7416002)(5660300002)(4326008)(91956017)(66556008)(66476007)(8676002)(66446008)(64756008)(86362001)(66946007)(36756003)(83380400001)(54906003)(110136005)(76116006)(478600001)(71200400001)(316002)(41300700001)(7406005)(6486002)(966005)(26005)(186003)(2906002)(82960400001)(38100700002)(122000001)(6506007)(53546011)(6512007)(38070700005)(2616005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWY0SGxmQ3h4MUdacmdqcHMrS1dPaUtsSm11L3U4OUhYeXhSUVAyYzdnTXA1?=
 =?utf-8?B?Vmhnd3dlSmFOTklQVmN2VFZkNEhmaDFtbVdVcDVwOERxdGZiMFdLa0tvTTUz?=
 =?utf-8?B?ckF3Vm5sVmpLZzhyZXM3VUdCei9KNlRjYnVwMnhPN1JwTTVuVXlZb3pOaUNt?=
 =?utf-8?B?VlNaclJBd1A1cjRiUy91YWF4R3lhL2ZoNTdCUEkvdU9FV25KNHd3bGpFbUJl?=
 =?utf-8?B?K0ozajZDMVZtUWNERlkxNk5YVDVVZkR0dFBrMDgwMHNJNkExN2RIUjh5R3dD?=
 =?utf-8?B?eXdPVEcvbFhSY09EV3pHazlXRnhjM1p3V1pOWjl2SU0yREpUK29LRWc4a2RS?=
 =?utf-8?B?dmtDTWpzVkJPQTY0UzV6Qjg4MUV3NWZaMm53dDF6Z2QzemVWQTBHWkQ4ZEF0?=
 =?utf-8?B?L005YXVjRUVEeGJSV0pOQVNCamRCVnFxT3gzbmF4aHA2UVRRblAyQnZBQjJC?=
 =?utf-8?B?YlJUWWRQWTJyM2VZcE4yOURRTjhpUXg2Mmsvbko0M05Gdy9PWVdiZkQyOVp3?=
 =?utf-8?B?NWF0VE5EdVB5TGJoTHdEaTVoVis4OHpuRzIrYldpMXFFT2RyUXBNT3pwS3kx?=
 =?utf-8?B?MWRhbnYxb0lTbEw0dFFMRElSWWRGemZxaGpmeEdoTXI0S2NRdTlZRy9IbFM4?=
 =?utf-8?B?T090alFSTThyWkRNaHQ0Q3h1K1hyL3VNdndPMjFFc1dQZHp6K3o1Unh5RGNR?=
 =?utf-8?B?Ujg2WWtoWDdHYzBBRTluanV2dUZIczc0Z29tUFZDTXUyc1MvbDFXd21Yb0Fi?=
 =?utf-8?B?UnkrR3h1UXFWTWhDMHAxTmFBOHVFUk9CMVVGckVwSWx5ZTM4M3pOWFJBdUhm?=
 =?utf-8?B?YWsvNkhaZEdKSllERUhaNFA1SkxZeWNDL2p1ZURYVXRFLzhTWFVOYXd2K09J?=
 =?utf-8?B?Qjh6eGQ4MTF5L2FGYnAvT0R3Wmp5c2p3c05wWUp2WXVxR0FLSndTS3kyclA4?=
 =?utf-8?B?TGJqNjZqRG9WWU5QVDk4RzVJc2dHaEU5VDcweFV6SW0vVVBzOFJwVzR3LzM4?=
 =?utf-8?B?bTlNMTZJK3VpY2hOREpjdzBPWGN5YmlMM2FVUFZiV3hTMmpVbmhsb3h6R2Ni?=
 =?utf-8?B?U1FMekxsVng0UGhLNDh2eURGVWQrUVRwNENGeWRLM3kxT2dwMEJhbXNYU2Y0?=
 =?utf-8?B?djBTWHNoNWpnS1NGVTIzbGNnWVBkYldwb3hOb1o5eEdyN0FHU2tYWG5YWDYw?=
 =?utf-8?B?OVpzVXdMYXZQek82TlhzLzF3Ymdya1hPbGRtMy9rQm0vYVRBbHIwdFQ4NG1l?=
 =?utf-8?B?MGJvR3NtOVd4bGJkdmNKamNRZlpUNDFsOEVnRkZoQ0xPcWpKalgzLytIWDBu?=
 =?utf-8?B?V2NWS25vaW9DOEF1bGhTemlMV01RTTBLR1RmKzF3dXB6VVJ1enZ4NkRhekp4?=
 =?utf-8?B?cXkvT2o3TU5lTWQ4M2hBRndiTFo0NXBCdEpkUmVVZXBZbVl4VUtjVjdrQW5M?=
 =?utf-8?B?STh6aVdPWUlzT2lsWEpaZVJmQ1E0aC9NS1RjMG43Y2JvVzY1Z3lYVjBRc2lh?=
 =?utf-8?B?MGFzeWFnS2J4dDBCOEhuc0VienZiV1I5TW5ycDJrdjdFMkdoZFFld1FyallO?=
 =?utf-8?B?OGp4UkpnNlBZaXZYenBYUHVGR3E3OW0zRlp6akxYeU1tNlpvRG9haGVuZG1E?=
 =?utf-8?B?Vy9IaWpHOUpkdGVvdzkxS0lMUEFHWHB0d2lOMnUyZnREejExNFJ1ek9LNDkv?=
 =?utf-8?B?bG1IVTJwWHYxOUc3cEwrTTN0KytVYnh6N2U4MnNNbC9YWFR1dmp5cS91WHZU?=
 =?utf-8?B?TnBTNi9CMDR3dXp1STNyOHliRU5TY0JOMWFNZFJzRnVONTBQSVRRaG41YnVT?=
 =?utf-8?B?QjlKbXJPbDl2M0dqUHM1dEpySWJFWjNXV2VHODE3Qjd6RURHV253bFV5TmNM?=
 =?utf-8?B?akdqTXpxSEd0enBFN1RldGtEcFJhQUtaQVFPTFo3aktrd0RTUVc5ZjI0d0Z1?=
 =?utf-8?B?K1V6UmlYOUN6Q0g3eVdRSVlLZkR1b3VVWERNR1FHd0Q5NnhRRld4dUtKNGoz?=
 =?utf-8?B?a0tUeGFBTndDbU4raDNBS2F1MVpYOXllNkVUUFlUeEg5bWZwaGozSXkrcEVS?=
 =?utf-8?B?cjVFdHpmN2F2TW83ZkpjR3oxZVZ6b1JxTEZkSHh4OXpCdEJwb2NwQzJkdUZK?=
 =?utf-8?B?U2JQcGVjV0RLMWkydElsZXl0T2NFejEzcFlzZGcrRzJCcW1ZSExveW5vZllv?=
 =?utf-8?Q?lK0OveeTgY5VVClW5fxjixQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C089ADAD194BD488B07B1A9F3E8A6F6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beed3382-74ce-4d28-9eb5-08db1e714b66
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 18:33:34.7742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7NbHSHpnoseJLeeFLassJnHdbUumIW6j0kLXBwQIe/Xu1oUFlbe6mdkaZ0IjbSZekxqDBpgIVGYgrRMGv1Kg17RiusFWxJxv0Zjk+tenCiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7388
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIzLTAzLTA2IGF0IDEwOjE1IC0wODAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6
DQo+IE9uIE1vbiwgTWFyIDYsIDIwMjMgYXQgNToxMOKAr0FNIEJvcmlzbGF2IFBldGtvdiA8YnBA
YWxpZW44LmRlPiB3cm90ZToNCj4gPiANCj4gPiBPbiBNb24sIEZlYiAyNywgMjAyMyBhdCAwMjoy
OTo0MFBNIC0wODAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToNCj4gPiA+IFRoZSB4ODYgQ29udHJv
bC1mbG93IEVuZm9yY2VtZW50IFRlY2hub2xvZ3kgKENFVCkgZmVhdHVyZQ0KPiA+ID4gaW5jbHVk
ZXMgYSBuZXcNCj4gPiA+IHR5cGUgb2YgbWVtb3J5IGNhbGxlZCBzaGFkb3cgc3RhY2suIFRoaXMg
c2hhZG93IHN0YWNrIG1lbW9yeSBoYXMNCj4gPiA+IHNvbWUNCj4gPiA+IHVudXN1YWwgcHJvcGVy
dGllcywgd2hpY2ggcmVxdWlyZXMgc29tZSBjb3JlIG1tIGNoYW5nZXMgdG8NCj4gPiA+IGZ1bmN0
aW9uDQo+ID4gPiBwcm9wZXJseS4NCj4gPiA+IA0KPiA+ID4gU2hhZG93IHN0YWNrIG1lbW9yeSBp
cyB3cml0YWJsZSBvbmx5IGluIHZlcnkgc3BlY2lmaWMsIGNvbnRyb2xsZWQNCj4gPiA+IHdheXMu
DQo+ID4gPiBIb3dldmVyLCBzaW5jZSBpdCBpcyB3cml0YWJsZSwgdGhlIGtlcm5lbCB0cmVhdHMg
aXQgYXMgc3VjaC4gQXMgYQ0KPiA+ID4gcmVzdWx0DQo+ID4gDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KPiA+
ICAgICAgICAgXg0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICANCj4gPiAgICAgICAgICwNCj4gPiANCj4gPiA+IHRo
ZXJlIHJlbWFpbiBtYW55IHdheXMgZm9yIHVzZXJzcGFjZSB0byB0cmlnZ2VyIHRoZSBrZXJuZWwg
dG8NCj4gPiA+IHdyaXRlIHRvDQo+ID4gPiBzaGFkb3cgc3RhY2sncyB2aWEgZ2V0X3VzZXJfcGFn
ZXMoLCBGT0xMX1dSSVRFKSBvcGVyYXRpb25zLiBUbw0KPiA+ID4gbWFrZSB0aGlzIGENCj4gDQo+
IElzIHRoZXJlIGFuIGFsdGVybmF0ZSBtZWNoYW5pc20sIG9yIGRvIHdlIHN0aWxsIHdhbnQgdG8g
YWxsb3cNCj4gRk9MTF9GT1JDRSBzbyB0aGF0IGRlYnVnZ2VycyBjYW4gd3JpdGUgaXQ/DQoNClll
cywgR0RCIHNoYWRvdyBzdGFjayBzdXBwb3J0IHVzZXMgaXQgdmlhIGJvdGggcHRyYWNlIHBva2Ug
YW5kDQovcHJvYy9waWQvbWVtIGFwcGFyZW50bHkuIFNvIHNvbWUgYWJpbGl0eSB0byB3cml0ZSB0
aHJvdWdoIGlzIG5lZWRlZA0KZm9yIGRlYnVnZ2Vycy4gQnV0IG5vdCBDUklVIGFjdHVhbGx5LiBJ
dCB1c2VzIFdSU1MuDQoNClRoZXJlIHdhcyBhbHNvIHNvbWUgZGlzY3Vzc2lvblswXSBwcmV2aW91
c2x5IGFib3V0IGhvdyBhcHBzIG1pZ2h0DQpwcmVmZXIgdG8gYmxvY2sgL3Byb2Mvc2VsZi9tZW0g
Zm9yIGdlbmVyYWwgc2VjdXJpdHkgcmVhc29ucy4gQmxvY2tpbmcNCnNoYWRvdyBzdGFjayB3cml0
ZXMgd2hpbGUgeW91IGFsbG93IHRleHQgd3JpdGVzIGlzIHByb2JhYmx5IG5vdCB0aGF0DQppbXBh
Y3RmdWwgc2VjdXJpdHktd2lzZS4gU28gSSB0aG91Z2h0IGl0IHdvdWxkIGJlIGJldHRlciB0byBs
ZWF2ZSB0aGUNCmxvZ2ljIHNpbXBsZXIuIFRoZW4gd2hlbiAvcHJvYy9zZWxmL21lbSBjb3VsZCBi
ZSBsb2NrZWQgZG93biBwZXIgdGhlDQpkaXNjdXNzaW9uLCBzaGFkb3cgc3RhY2sgY2FuIGJlIGxv
Y2tlZCBkb3duIHRoZSBzYW1lIHdheS4NCg0KWzBdIA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGttbC9FODU3Q0Y5OC1FRUIyLTRGODMtODMwNS0wQTUyQjQ2M0E2NjFAa2VybmVsLm9yZy8NCg==
