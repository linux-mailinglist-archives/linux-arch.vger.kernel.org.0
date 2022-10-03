Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1025F33F7
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 18:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiJCQ5l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 12:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiJCQ5h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 12:57:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E85F31375;
        Mon,  3 Oct 2022 09:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664816256; x=1696352256;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DoNIIgYRP9ty3KB6hVirLqtAVQ4OmCfBzmddc1rYv7A=;
  b=ccmqNhzy1yaM7F8OXTG2QZqgku/I/xZWW5ktxKcdu7ozisgv2u450b1m
   0ziPDNt6mzvGIjyyUnWTBmISbSUqSP/8OWLcp4CzAA4kN7PMZs280G5jQ
   y1H9cYaNJ5BA9Nxg4yMo5vBJYifC/Rt37NQ8DNk38AZlNvNuZYbTAQER1
   7pMKuTV93sSACIPukmja6SzfByaC+xwK84itLHRVPA6M2D3g8qnC2zZnB
   6jfJbyMkwyFt8FOZhjKoVQA01YMkqGW1qGqBmoC0jBb++Z6NAni7o3Sz2
   t7uXe8tnM0EZI33mR8Jvi2Wi/hrZa2++GTddQr8RW8VcJjtGgeJXPncvo
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="366757608"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="366757608"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 09:57:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="601294789"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="601294789"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 03 Oct 2022 09:57:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 09:57:34 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 09:57:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 3 Oct 2022 09:57:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 3 Oct 2022 09:57:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYfXVif13+k7RO+7OmgXIFO6GzmgePc0th0ynvLX7L5xFionjGR5+DEWvMjHoxuS0mNnnPDaBooIRJNhvGzlRcTHvn1WlmZ7uyTbu/xR45dd3PbRf0EwpMHRXdy2dGLllN+H1tlROjrHb9CoPmvFbKPmw4Aec6t7RLB6r6yyE/VuqkKUbUf/8GiWHPlqAcYGTmNxFteBuRuI02fMk8zOBu6Ti8+g/YY20iQqsRmxCaO1wBSg8iqofdOUpwOLKycXCMES5P1nu3CQQsErG7qAJ3ljs75G+kgWHsthW3O/DNmx2KwkXAwfQPO8h4k3jkkGZ9kNYWlDVtRdOPSG+Fd48g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoNIIgYRP9ty3KB6hVirLqtAVQ4OmCfBzmddc1rYv7A=;
 b=CaIGEpW2M5oCpqtm36ZJIPBwvg/jI34cw8aQGQ4IpEz0rsvm9OatIoh2ZIk2jrKsqhdnx/9x08mBaFqnwRkXMhassLkXP1juMsYtqN/YO6ioBZSwqdnUVsszBecu/S43HXw7gaR3idaHhstXkO5ui6QxLnINwOvnE9Ski+YKkmuRM/IxXadnmMWPOT6c0+m71hUzvJT6RESQD5BQmnLdqGkblWzPLoAb3g1W7j/Ge6nVCAffPf8PBxybCfro5vofSlEOaB1uyod4Fm2famuSnnXnR0H6/0NGkCoWaxVJqy5jYwNAoIX8Yqbk96YUbkXya8xizTo6zEdIIdYzJtH9BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH8PR11MB6706.namprd11.prod.outlook.com (2603:10b6:510:1c5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Mon, 3 Oct
 2022 16:57:32 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 16:57:32 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "rppt@kernel.org" <rppt@kernel.org>
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
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
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
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 25/39] x86/cet/shstk: Handle thread shadow stack
Thread-Topic: [PATCH v2 25/39] x86/cet/shstk: Handle thread shadow stack
Thread-Index: AQHY1FMioR2zkUKPr0OYxM5M3mC81a38f3UAgABqWIA=
Date:   Mon, 3 Oct 2022 16:57:31 +0000
Message-ID: <cc95438c680ee4c109ed3be5760d85a5e1ba0af3.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-26-rick.p.edgecombe@intel.com>
         <Yzq7RjsnM8ix+enT@kernel.org>
In-Reply-To: <Yzq7RjsnM8ix+enT@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH8PR11MB6706:EE_
x-ms-office365-filtering-correlation-id: b2c58fc5-5242-408e-b624-08daa5605cd1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s1L8CthJ/DM69QUCMA095shKws0cEBcYagVDRiHhkN43Yj6CR6visy/J9GxdBfVJHeZ+SUnZT3uVmgE9SNn3LyCHfj8/c+2p0XgaaMt2ABvJyQw6LE24XF66+jOXJ2FTTtDXAPItGsH7gEl8DoOgC3zywbaur3ugf1oB5CKZcGITyLgFFqLzrcj+wsU+ldEAsy1jkUAociIuXj6aIPor+P0KlXm18iJqZv5LN1Q5T52bc0a3/NFvZ4P3A/XF/VOXUV7C+Te+6HYE22ARzV+hdnniIwpzQl9+ePB1XBdbEMyZXFGyO09fjYOtavDsRO5ATHo/NcMTAdRdve2DaMmTEH+CjFIvxAE54LHn72qV6vhIidOs26HGwg0bQb0q5QjsVc4tUIMQpSOpSobbtVGjElzkTf1q9behXGPed4BJgkMiEr0WIkcCwzikZDW9n6Z6Pj+9qMUp1HdTq3oSfqWEVjzQKM/6bg4dJGSxxRA0dHbkmfiDLzIkW/EfEWsUWTeq3IxBjbeFSce2gQh5yWFjIIiilAEaH5XwpONtaWmZwWuNT/7C/lUYveh53oggjtWC9m5Abbl6RWPei0a6um+ZWqKENTFjPlPFokPU2eAM+5wSHJYJwfW8LkVIW3RmoP73rQzK45lAEHM8hnSoGNyCRMgVK5lkgHyJDUmMvYQtzUph8Rk0bMdpBbpE72MwNL1nJm/kua4LmhyXHZqt1YnYWvMGU/Jy60J+V78vH8UhmKuA3wJehlgT5MxTkLbys+zFd4F3pfZAfaaqxgTpfKPXLY0OcbQ7LG5rtj6YyG348P0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199015)(26005)(6512007)(6506007)(122000001)(478600001)(38100700002)(2616005)(186003)(2906002)(5660300002)(7406005)(86362001)(558084003)(7416002)(8936002)(6486002)(316002)(54906003)(4326008)(6916009)(76116006)(41300700001)(38070700005)(71200400001)(36756003)(8676002)(64756008)(66946007)(66446008)(66476007)(66556008)(82960400001)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3VQYnpJaGM1SmxXMGhaSkhKajFETXpucm9WeXIrT0NjTjdVZ09WUWQzK1Ny?=
 =?utf-8?B?ZkxOeG9CYUs2eDZQaFk0WTNLamtNYTdiQmYranZ5d1ArNXBhOWhvRXljcUJD?=
 =?utf-8?B?UUMwbXZLVGk0bXcrWE5PVHBDTEd4WFFwa3BLYXVzOHZ4dG00c3ZTRUJTRXYr?=
 =?utf-8?B?c2JGM1ZnMHc0bHdBckxaVXJrdkxTUm54L1FiMVl4NnQ2cVNmMUNBSHZudkUw?=
 =?utf-8?B?WTRqSms2SUxiZ2tBQjExeWRTblNDREoxMS9DNElNUGdzbU1HVHNzb2dzejNR?=
 =?utf-8?B?OWhid3g2M2hVdUdiYmIzNnZFbWozYStHTGFRYlVQQ2NqSFlmVDdta21qN0FN?=
 =?utf-8?B?clg1WmI0R3pRa0VSYURRV2NUSXlZUUZzZnYveXJzUGVMVFUxYVdFcXlpdWUz?=
 =?utf-8?B?VzJHYkRRL1pUekkzc0VqK0JHemV2UXQ4cHA1N1VQeDJSditlM29OTmVoZkFl?=
 =?utf-8?B?a2VKZ3FLOW9vK2lDM3R3T3BYckVVaHhhSURSbkRjamFpdWtXbE1VMFJOVDF0?=
 =?utf-8?B?T2pRSHZBMFd0N0hKUldpZk9PTG96ako3NnRjbDZtcFR4SjdETE95NTUxcE10?=
 =?utf-8?B?ZWR0VytZeXRXSU5vYVQ0T1lXWVhMOTVEYmFhK1ZwZDJKZDB6clBGT25YV0Z1?=
 =?utf-8?B?cFRDWXREOWNjNk45aEk0dm56a1hlcG9yNGI3WE4reFFzei9iY1p0QXNqUDc0?=
 =?utf-8?B?c2NsMUY2MHQ4Qm5JNlQzY2ZWT2p6V0hpRTZPczV6ZDZIeVJsSkQrdGZ1ajM0?=
 =?utf-8?B?OTZiVDJzOGpZZ0Z0ZXF2ZGdNMUVUKzdjMHdIazBpa3pzNjlhODA0NHVZc1lR?=
 =?utf-8?B?WC83RDFYcXpwNi9Oekh1UmZQbDlPRkdpbmJZRWNmbnA2KytEYnYzQlRsY2xM?=
 =?utf-8?B?RkUzNFovbC9EMjVhNk11cGY5aFZlYUdFQ1B4K1VtRW9peEZRN3dsem9HeGpj?=
 =?utf-8?B?VGdyU3FSQUxBc3VHV3AvNFN2anlmcHFNclZ4WGZYUXJLNlpXSjlJQ3N6RTNt?=
 =?utf-8?B?Q1R3YmhmNVJyYmxRaitPaXhRMkZJVGRhR0FFT2NKMGxKNXZmUjFjYlh5Si9L?=
 =?utf-8?B?SXFCaVU3bTdNemJKTzM0bkk0U0xIMjkxWGgyR01EbGxIMjVLRTA3NHpLNEtw?=
 =?utf-8?B?UEVrSU5rMENLejM5ZXg4UUh1Ynk2Q1UxQW9ib0pTUUxmd2ZwR2t1YStTOFVQ?=
 =?utf-8?B?NmRxandseVNLc0Y1bitlTUxqenczcEpVb0NpMTNaeDRiZXI5NXE4NWpMeDB2?=
 =?utf-8?B?WFFtQjNobmIxaVlTNE9UbDR2eWpUejBpdmRZaXRncmNhaU5wVUNxM1BLclVG?=
 =?utf-8?B?U1FiNzArWjVlWVZ0cUExK1FhbnJvdTRkTVhVZUdLU2Uvbmx1R2dYWEYzL1VM?=
 =?utf-8?B?SG95dHVTRmpEYmkvMVgrd2VsSVo4S091c3BMYVl4Ly82VUlSN3ZHdFk0NWJL?=
 =?utf-8?B?Wm5ZZTc3REVzamFGSmhLV0FRcXVoVlNCbEtOTEZ3UXo0bHZIM2NCMHkyRVNO?=
 =?utf-8?B?emR6bzVKZFkzV1lxb3pHdHIzaGhTOVBKUjMyaW13RFRHWGJ3V2lrdjhCRXZk?=
 =?utf-8?B?T0p0dWt3MWFhSkZ1NkREakkvTmNzeER1c2R5TStiV05NZ1d2R2RQUS8rYS8x?=
 =?utf-8?B?ZGlGU0lnK2EvNXRjdlljVHNnQkhwbVhhazFoQXYyaXJmNmZFQVB3VVJwRzJv?=
 =?utf-8?B?aHNSU3l0a1hrQlVyMEcyNlBvUElRSkdCTmVQSG8rdU1TSUl2cEkrMnY4SDlO?=
 =?utf-8?B?eDFDSFVrNktFS2ZBK1IxZlRGMlBtcjlXRkM0U2Z6Sm9TSG1uTUoyaFUvaUpG?=
 =?utf-8?B?a0xzV3FqT1BiL3F5b1JKOXNpWlBBR3M5UWgwSlllaDFkQWZPUnlJNHRKNVgy?=
 =?utf-8?B?NmIzRGprT1hia1JiS2VHa2k2cGUyWGU4SkpwNjVqVzJUMEJ2eHBTWWFNMjFr?=
 =?utf-8?B?eTVvN3ROQ2tNUlBsZTZCTTJOQ2pDVWZTMlc4YjRxeHRkUlB5K2lNb3FrcTdj?=
 =?utf-8?B?bjQvU0gzY2VOTFV3dXg4ZkFKRkhlenZLT3E1NFF0aXdVKzNJUkl2VHd1M0FW?=
 =?utf-8?B?dlBLdlhCdEg2VllMZlI0UXkyY3NiRjRXYVN0QlBFSlZrTmJIWGQxVTlLbE1y?=
 =?utf-8?B?ZjRObFp1SGVtMHQ4TkM5eUI1QVRlYmxZQWtIbkZGSmVOK2hocjRYcTkvc1RE?=
 =?utf-8?Q?hZcDsrwmlVihPXO5prDiYpU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <452CB878844C4048A766E8BACD4199C4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c58fc5-5242-408e-b624-08daa5605cd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 16:57:31.8568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c+fYJix4DHU/g0Xedo3my45vQwyAY3T1Gv/cF0Vool8WQ3q/xoJiojDn8P1mufmr7DgrFMWUnOEtq2ClJZTxFvrKqlTDvXju7RfJ4vHwDp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6706
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTAzIGF0IDEzOjM2ICswMzAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiA+ICtzdGF0aWMgaW50IHVwZGF0ZV9mcHVfc2hzdGsoc3RydWN0IHRhc2tfc3RydWN0ICpkc3Qs
IHVuc2lnbmVkIGxvbmcNCj4gPiBzaHN0a19hZGRyKQ0KPiA+ICt7DQo+IA0KPiByZXR1cm4gMDsg
Pw0KPiANCj4gPiArfQ0KPiA+ICsjZW5kaWYNCj4gPiArDQoNCk9vcHMuIEl0IHdhcyBhIGxhc3Qg
bWludXRlIGNoYW5nZSB0byBoYXZlIHVwZGF0ZV9mcHVfc2hzdGsoKSByZXR1cm4NCmludC4gVGhh
bmtzLg0K
