Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EE469D66B
	for <lists+linux-arch@lfdr.de>; Mon, 20 Feb 2023 23:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjBTWoV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Feb 2023 17:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBTWoT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Feb 2023 17:44:19 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B181EBE9;
        Mon, 20 Feb 2023 14:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676933058; x=1708469058;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EDd1lwnjawDBRp4I1oRC/+P72uhIWnEAuYcKswvOVSY=;
  b=D0uPCxi95CLgSC+YRxKHo2ifdGw/lFuWaFgpvDKi/eu/XzhCUYiFyWKF
   te2BGcdTnNC6TNOCHNdIOwDHcEAdtvZ9kkH22Uj3vqU7g8ezXyethBOJM
   6A8nVkJcVPGmvLs99a4+bXQNjxBzfgDTGrkhv8xbKKgvT6T4IQOt0vVrS
   8q9gZP1Z+hhwgOgH5yRcDLN97hLFUjQGyn7irk4F7JjTw27te9AVjVVl2
   rTinNOsDbOWbIAFyLa+K0q+QuJRSOWHdaPr0gtJGfj2djlMBTOhkMyP1+
   ltmn3kl/Hq0P/zu1yitlo4jiCD1YYY288PlFa7J9taChY/rd0utisKp5/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="331166561"
X-IronPort-AV: E=Sophos;i="5.97,313,1669104000"; 
   d="scan'208";a="331166561"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 14:44:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="701794192"
X-IronPort-AV: E=Sophos;i="5.97,313,1669104000"; 
   d="scan'208";a="701794192"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 20 Feb 2023 14:44:16 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 20 Feb 2023 14:44:16 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 20 Feb 2023 14:44:16 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 20 Feb 2023 14:44:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMWZk4f9HpED2YYE5IgyRgkCZ8Kx5ip4ZBzCLnzYzU7OjTUDnzYrVoi9HjqPEu8MGqL7UBkq148tB9YBAde+WtlKEneKX0OPXOEElHJIJJYK8aIRmHeghVPsXvLRmTiq90EEC/rHE+C6MC1DUHkSTQUc710GFa1Mtei5P9Y5Y880KPP8MoOHQH+nR3ANDtLlOZJddz9Vw9xeXSY2bTNo4m6vXEik85xDeMGmzUdZcm/Bla3buAJznEbWVqmQgXC+hWLKeROlqGoIGziKI6igQOuSHDbgU/q0vBlUangFdAyK8t6TtHLFRLpD5f57eTYeVqgnHJHCs4FVYo/0G4q+8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDd1lwnjawDBRp4I1oRC/+P72uhIWnEAuYcKswvOVSY=;
 b=CY1MWIu1pfkUR9dZICUg/xBxthJDoJ8FYG6CWXuL5Jsv44vyCSeBaxSvH496kajbB9uZXs+egIz6wKqBK07HwVlrNVDZgz5VaUYNATwxEBS/3WJx8gYqKXvSALRD7yNKlUeKXr6m8OSAkmioNj40YcNSXjKkjjKKX3KazmbyigcDlOzNVIPjLJ1DP//JT13uG5Eto8Ph4GQl/EdJRw+0LMt9zdsreImznxlQ0sD+PKmZ1Fx3bNRVBRYaYMgGz+6EpvFp3TZLEKUDkF6oCsKe4wD0i6FfRY6xo97KvTPlEleuDS7jSQ4ea/CHEAJd2KELm/AgF6JHYY2G9+xImBYS1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM8PR11MB5701.namprd11.prod.outlook.com (2603:10b6:8:20::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 22:44:13 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6111.019; Mon, 20 Feb 2023
 22:44:13 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "david@redhat.com" <david@redhat.com>,
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
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v6 22/41] mm/mmap: Add shadow stack pages to memory
 accounting
Thread-Topic: [PATCH v6 22/41] mm/mmap: Add shadow stack pages to memory
 accounting
Thread-Index: AQHZQ95AuCiA6kLAS0S/RX8WTDnCKq7XzlwAgACjmwA=
Date:   Mon, 20 Feb 2023 22:44:13 +0000
Message-ID: <8bd58778e062bb9526c905c5573a2ee20cb41eef.camel@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
         <20230218211433.26859-23-rick.p.edgecombe@intel.com>
         <6ccc8d30-336a-12af-1179-5dc4eca3048d@redhat.com>
In-Reply-To: <6ccc8d30-336a-12af-1179-5dc4eca3048d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|DM8PR11MB5701:EE_
x-ms-office365-filtering-correlation-id: 09f87c7c-457d-4fa6-80cd-08db1393fd1b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nlLKf3n8LmxyEI1msrL6W7MPUr58f8JCCsIM2nl8ewkiQ+lNDT2O20hJ0Kb6GPnOLz6W81clNU98eozTsgq7cQm/9a8IlSYDG3uBNoNbVijvPVMuxohO6c2GOCUpo0r3LrRgbEb54OxdtdseMKjnmZ5YfZwB6vIgItSG0SwAPn29sW3yD1tkxPx6YDIEJTnuv+7nU2N1kktXGX+UP9Wg31Z6iOVGKet2s2qsx/zn/r40sdJhNX8i7ihWt4QtqwgAkwhL9GTofleMHOjg+t/33AHBch4aEEQDuAk8+fjg28RnYahh0/fdaJjItv2X0cEKDcfT+Kmg71df9pbufFMC15lf8WjffmyyzAjmcHa6Rtu3DjzytVGllQ9RWjMmfBTLmxo1RMdRw/lORue+y7EewvQFzQ4a+HwTpZ+laXgC1JDFQnbFvpfuH2a/JJ2K9x7tIcJlDfDAAX3C1q/nljGedZYLxNfdhmmS42P8So1WiferbLBocUQgfUzjjBx4BRCjRJgkpPHyMdy1up9cVvbyjoVvSv23lIhjI6SibRIvs2te7xEUTpdci6XENPc5C90lgVdCok2b3VT8P1loaIESM5Nz64SoUKDb4doEmn7jav7AXdPakjfWQJtfrWm49PGRk6kKy5RxHWidxOUVwDYw42EdRWfj06KidzKWVv+7JjGaGiF96ywDCt9xi40EIaf9Y4z+ZoOVJ8ip8dYTRcuxe6qHQzSY+GV+uYKOBuaN7kU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199018)(122000001)(2906002)(82960400001)(86362001)(15650500001)(38100700002)(6486002)(71200400001)(966005)(26005)(53546011)(478600001)(186003)(36756003)(6512007)(6506007)(921005)(38070700005)(8676002)(64756008)(66476007)(66556008)(76116006)(8936002)(83380400001)(316002)(66446008)(110136005)(2616005)(41300700001)(66946007)(4326008)(7406005)(5660300002)(7416002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGRobnVGSWFoVnlzR2R6ODRVQW16cG1FTDBzKzBsd0ttSEF2Q0o0QnJVZi9G?=
 =?utf-8?B?RnExSGU1L0tNRHZ4RGtjQnk2ejdHakZvYVpKZTVNbm1iM2k1ek5sWmlOZ0Ra?=
 =?utf-8?B?cDZFZ0RkeWU5WmptZjdkT29DcEJORUhzS05FNkc2YmlMUlRYTDY3VllrMUZV?=
 =?utf-8?B?YU13QWpqejVndnNicERqOHZZYThrTmxEbmRJL0IzY2JKSjNLOGlqRGhRaExT?=
 =?utf-8?B?S08zeHJGZi9haUJLaVVxTFRtY09jYVJzWXk5c1preENvOWFZc21Ea1NMMkJs?=
 =?utf-8?B?UisrQnIrSjBReitaeXc3cFRKUyt5WVZNQmU3VmRoZE85TGRVVVI1NGVBK1Qw?=
 =?utf-8?B?cVZjcmxjZmN1K2x1WE1ZWGtmRDJMZFYzSk1SV0JIVG9rTmJjU0p6ZFZEWXJY?=
 =?utf-8?B?MzJkMzR2TXExUHd1MEpLMTVZalpEb2R2M01KVXhCQVpwdHVIN3lhWk83RWRo?=
 =?utf-8?B?eHQzNG9HMUpCelltcFZtbXBrKzAvSGZDeVFLTGV2RU1QV2ZDOTZraXNnVU5B?=
 =?utf-8?B?N0NTNGc3TkJuZzdNa3NHcUlHRGk1TnZmNHk2OVNJNzBjczBLSmw0ZWRMNUVB?=
 =?utf-8?B?MlpiZ21CZ0wzNVlhdEVoaDdCWnJPNWhDWGxrMWlEd1RieEl1dHo1WWZEU1Bx?=
 =?utf-8?B?bU5JL05nM0JvZDBsZ3hjYWRDeWdHKzc1SDRIU012UmpoTzJiUXQ0SzMyNWNm?=
 =?utf-8?B?SFhQSE41UW55eFQ2eU5PWGZRbDFadTBtRnY0bmU5ZE5SSzVveml4Tytac1cx?=
 =?utf-8?B?dkRrY2pndW51aUczRDJQWEFrN1ZFMXk2QTE4VzBub3BqZlFjTHdsNHdkTnRh?=
 =?utf-8?B?OVJRRStEQUViU3V4YSsxNTZkZ2FtMTB1Vnc3OUFJMDhDQm1HWWIwblpqY3pm?=
 =?utf-8?B?N1VFN2d5L2Q4YXJpdjJoWUJWeWsya2t0akwwbzhtREZ5MGR1ZkRPSFBMUVFV?=
 =?utf-8?B?aXJMVTlwZ3dLK0d2NS9LMjBIWmtSTzlMOVdWRnpMUlVNQ3BhamVMK0kxaWNl?=
 =?utf-8?B?NTE0MGxOVkE3d3hNQUx5R0p4N2JLYXFZdjBLRisrSitkRnRiVG5pRFlQbGRr?=
 =?utf-8?B?U3lmVVd0M2tONmEwcGw0R3Y5dUsvSE1helJtS20zM2NVODVrWWp3LzdzbWhS?=
 =?utf-8?B?VForOWlzWUM0dzFBakxoYkMwamtwWnBaenhrY2hFcGRVRm9BKzB3a3VFTE4x?=
 =?utf-8?B?VUl3UWZESitMVWxxbzVlNGhEVk4wTmxHUGRUQVBIeElYQThrK1EvV201NEhs?=
 =?utf-8?B?ZFRyYmh6WGJ0S2JncEw2b3pSOUNEdFVsdnI3SHRYVVJmMUVPaHROelRNSGc4?=
 =?utf-8?B?QmpPOGRzejllYVJ6ak42ZDJlY1FObEl1bXhubXB2UXplL285MnRWNS9sbndt?=
 =?utf-8?B?WjlMMGJnNVRyZUswOW9YaVNIcUNhUnlWRzJBbXY0WVptVGZGdjQ1eFVxTWk4?=
 =?utf-8?B?bmJuVXRkY3NzQnZKVmw1N0swWDJSdXRpOUhUc0laeUN0Q2J2eWpRSEpLOGU4?=
 =?utf-8?B?V0FXRlEvSWQ1S2ZYM1F0VEFsT2tsUW1Ja2hmelZ3WmRwUEtqdTEzMCt1UFpF?=
 =?utf-8?B?SXY2WFk2QzQ3RDV6aXk4bDZ2WUJDQTFON2R6ZWlzK2pXck93ZDVKYU9WOFNQ?=
 =?utf-8?B?bEhsRjRkRXQ3b2FrREk1TlRDS3FSQTE4TU1rUnhzamhvc0lYRHU0dnlncnRF?=
 =?utf-8?B?QUUvczIxSkYyUERnUEFGZ2lHZ000VkFlVUhEZzNCdE9SQTNORjc3dTVoT2s3?=
 =?utf-8?B?ZnV0M0J5M2UrcGZUQkhFYS9DdVBDeHVuTkVIY0phMFB1VnFzRlNOSXQ3OE0y?=
 =?utf-8?B?L1ZLTXB6VXFHN1ZlS0ZLZ2NvZ2tXM2Vrajcxb1ZUOGoweGtTSi9VRTFFa0Yz?=
 =?utf-8?B?ajRrem1qdDc2bmM2NGtoakk5ek5YOUViUG9UNXh3NE85b1h4azMrcjR2SWdK?=
 =?utf-8?B?TE9YZXFBQk0wMjNOeHpRWjZxeUxOUWQzdlZXNnRTTDZlTjBCdVVObUw2OXl3?=
 =?utf-8?B?Vys5L0ZPVXNEbUV5RWQyTjFTaFBPZVM0dkFTYmlPbkcyRTNVbVdRMnFuWHh0?=
 =?utf-8?B?c1Y1UzlIVU5ZVVl4VWRFMXJFVjlObkZQU2xmVE8wejltNEhlSGtrcnNDcHMr?=
 =?utf-8?B?YlBiZ3dvczN1bzJJOXQrNFZLRUdUYUtsM2N0T0FJNUZJeU9PZFJ1NDVnLzZn?=
 =?utf-8?Q?btXP8zKr7jbTYfxhcImsUps=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD7A1A6D32A0924CA5802C2B98600AC0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f87c7c-457d-4fa6-80cd-08db1393fd1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 22:44:13.0459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 83A+HM3p2lbMlQ8u7mtxA44dBGhffMu/uB5yeEeB5VM7Mj0nmcdco4VxR8Q6Rq6kBPAvts5+g+FMpnR0SueHu4otZHXT+ygEQ4TyDGdYue0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5701
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIzLTAyLTIwIGF0IDEzOjU4ICswMTAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gT24gMTguMDIuMjMgMjI6MTQsIFJpY2sgRWRnZWNvbWJlIHdyb3RlOg0KPiA+IEZyb206
IFl1LWNoZW5nIFl1IDx5dS1jaGVuZy55dUBpbnRlbC5jb20+DQo+ID4gDQo+ID4gVGhlIHg4NiBD
b250cm9sLWZsb3cgRW5mb3JjZW1lbnQgVGVjaG5vbG9neSAoQ0VUKSBmZWF0dXJlIGluY2x1ZGVz
DQo+ID4gYSBuZXcNCj4gPiB0eXBlIG9mIG1lbW9yeSBjYWxsZWQgc2hhZG93IHN0YWNrLiBUaGlz
IHNoYWRvdyBzdGFjayBtZW1vcnkgaGFzDQo+ID4gc29tZQ0KPiA+IHVudXN1YWwgcHJvcGVydGll
cywgd2hpY2ggcmVxdWlyZXMgc29tZSBjb3JlIG1tIGNoYW5nZXMgdG8gZnVuY3Rpb24NCj4gPiBw
cm9wZXJseS4NCj4gPiANCj4gPiBBY2NvdW50IHNoYWRvdyBzdGFjayBwYWdlcyB0byBzdGFjayBt
ZW1vcnkuDQo+ID4gDQo+ID4gUmV2aWV3ZWQtYnk6IEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21p
dW0ub3JnPg0KPiA+IFRlc3RlZC1ieTogUGVuZ2ZlaSBYdSA8cGVuZ2ZlaS54dUBpbnRlbC5jb20+
DQo+ID4gVGVzdGVkLWJ5OiBKb2huIEFsbGVuIDxqb2huLmFsbGVuQGFtZC5jb20+DQo+ID4gU2ln
bmVkLW9mZi1ieTogWXUtY2hlbmcgWXUgPHl1LWNoZW5nLnl1QGludGVsLmNvbT4NCj4gPiBDby1k
ZXZlbG9wZWQtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRl
bC5jb20+DQo+ID4gQ2M6IEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPg0KPiA+IA0K
PiA+IC0tLQ0KPiA+IHYzOg0KPiA+ICAgIC0gUmVtb3ZlIHVubmVlZGVkIFZNX1NIQURPV19TVEFD
SyBjaGVjayBpbiBhY2NvdW50YWJsZV9tYXBwaW5nKCkNCj4gPiAgICAgIChLaXJpbGwpDQo+ID4g
DQo+ID4gdjI6DQo+ID4gICAgLSBSZW1vdmUgaXNfc2hhZG93X3N0YWNrX21hcHBpbmcoKSBhbmQg
anVzdCBjaGFuZ2UgaXQgdG8NCj4gPiBkaXJlY3RseSBiaXR3aXNlDQo+ID4gICAgICBhbmQgVk1f
U0hBRE9XX1NUQUNLLg0KPiA+IA0KPiA+IFl1LWNoZW5nIHYyNjoNCj4gPiAgICAtIFJlbW92ZSBy
ZWR1bmRhbnQgI2lmZGVmIENPTkZJR19NTVUuDQo+ID4gDQo+ID4gWXUtY2hlbmcgdjI1Og0KPiA+
ICAgIC0gUmVtb3ZlICNpZmRlZiBDT05GSUdfQVJDSF9IQVNfU0hBRE9XX1NUQUNLIGZvcg0KPiA+
IGlzX3NoYWRvd19zdGFja19tYXBwaW5nKCkuDQo+ID4gLS0tDQo+ID4gICAgbW0vbW1hcC5jIHwg
MiArKw0KPiA+ICAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBk
aWZmIC0tZ2l0IGEvbW0vbW1hcC5jIGIvbW0vbW1hcC5jDQo+ID4gaW5kZXggNDI1YTkzNDllNjEw
Li45Zjg1NTk2Y2NlMzEgMTAwNjQ0DQo+ID4gLS0tIGEvbW0vbW1hcC5jDQo+ID4gKysrIGIvbW0v
bW1hcC5jDQo+ID4gQEAgLTMyOTAsNiArMzI5MCw4IEBAIHZvaWQgdm1fc3RhdF9hY2NvdW50KHN0
cnVjdCBtbV9zdHJ1Y3QgKm1tLA0KPiA+IHZtX2ZsYWdzX3QgZmxhZ3MsIGxvbmcgbnBhZ2VzKQ0K
PiA+ICAgICAgICAgICAgICAgIG1tLT5leGVjX3ZtICs9IG5wYWdlczsNCj4gPiAgICAgICAgZWxz
ZSBpZiAoaXNfc3RhY2tfbWFwcGluZyhmbGFncykpDQo+ID4gICAgICAgICAgICAgICAgbW0tPnN0
YWNrX3ZtICs9IG5wYWdlczsNCj4gPiArICAgICBlbHNlIGlmIChmbGFncyAmIFZNX1NIQURPV19T
VEFDSykNCj4gPiArICAgICAgICAgICAgIG1tLT5zdGFja192bSArPSBucGFnZXM7DQo+IA0KPiBX
aHkgbm90IG1vZGlmeSBpc19zdGFja19tYXBwaW5nKCkgPw0KDQpJdCBraW5kIG9mIHN0aWNrcyBv
dXQgYSBsaXR0bGUgaW4gdGhpcyBjb25kaXRpb25hbCwgYnV0DQppc19zdGFja19tYXBwaW5nKCkg
aGFzIHRoaXMgY29tbWVudDoNCi8qDQogKiBTdGFjayBhcmVhIC0gYXV0b21hdGljYWxseSBncm93
cyBpbiBvbmUgZGlyZWN0aW9uDQogKg0KICogVk1fR1JPV1NVUCAvIFZNX0dST1dTRE9XTiBWTUFz
IGFyZSBhbHdheXMgcHJpdmF0ZSBhbm9ueW1vdXM6DQogKiBkb19tbWFwKCkgZm9yYmlkcyBhbGwg
b3RoZXIgY29tYmluYXRpb25zLg0KICovDQoNClNoYWRvdyBzdGFjayBkb24ndCBncm93LCBzbyBp
dCBkb2Vzbid0IHF1aXRlIGZpdC4gVGhlcmUgdXNlZCB0byBiZSBhbg0KaXNfc2hhZG93X3N0YWNr
X21hcHBpbmcoKSwgYnV0IGl0IHdhcyByZW1vdmVkIGJlY2F1c2UgYWxsIHRoYXQgd2FzDQpuZWVk
ZWQgKGZvciB0aGUgdGltZSBiZWluZykgd2FzIHRoZSBzaW1wbGUgYml0d2lzZSBBTkQ6DQoNCmh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvODA0YWRiYWMtNjFlNi0wZmQyLWY3MjYtNTczNWZi
MjkwMTk5QGludGVsLmNvbS8NCg==
