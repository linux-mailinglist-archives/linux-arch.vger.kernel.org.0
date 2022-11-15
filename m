Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AD662A324
	for <lists+linux-arch@lfdr.de>; Tue, 15 Nov 2022 21:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiKOUk1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Nov 2022 15:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKOUk0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Nov 2022 15:40:26 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C8613EBD;
        Tue, 15 Nov 2022 12:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668544825; x=1700080825;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=V++BCCHR+89BHvrfD15PWejHPFM5Y8PXkQZ5a8SIvT0=;
  b=GUj/+DW3hvpLNzv+vG7+/5cGGjyF186iAyJsmHiuhYgX4rQhPfMBVEuZ
   T2k/NjhJ0VOGEkHyKRwlycgtFOH7FRggNwYzIxEE86BkPXFYn/7ex5n7R
   MTllNf5+LBgx3mceXE+RAoJiMx4i65djFvg3WhmQe7jr1swfdgkfRZcjX
   iOcAYcE3LPDTBPU/RLRM39ey9glntRdqTOHJ187Y1eT1FOttFtc4yTfIQ
   19ZwZP701lHFqt5ydGykkrstRTz04E6RRzL2oEdSxXtA8XOc4jDUmdc1/
   LkhGiAtRGUdluUT6SsV/d5Ab8BtL5/uWdfFzZAidf7qe4MAPtAd3h/iKM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="339167825"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="339167825"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 12:40:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="813817263"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="813817263"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 15 Nov 2022 12:40:23 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 12:40:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 12:40:22 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 12:40:22 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 12:40:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lE9PaYxayNOP3ODsQbUHobyvrpnOlRncONulHGPryWkJj1XMTtjsjoGW0Wc8uipeviSaL7CQ6tjWn8QcUAxif0fT0wup8x8k7rY5SMZ1eIlkbAeJ5a+tgmoNxOy6sbL0gT2YACgKTF/ZC2EoPslPPp+LIoelqx7z857ro1sZZYGz1HrwV7ybioV8g8K8hKR+1weR5YZotHDq7tmwvjCkZNFa131v0b90ay5LiZdQooQyE4/X2PPXqggcqHmg5neNQ2WrkDuf/SK7W+kYuM6bWpjxKtc+olL8BGSelneJoino5UrfOsY2g/0v1Hi1wRzOYhX6SEfD3oTJZc2scjszSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V++BCCHR+89BHvrfD15PWejHPFM5Y8PXkQZ5a8SIvT0=;
 b=B1y3z9KTtQt3dGYcU/rDEOR1hetHQkFIWrISFn6Zm8NJ6zcU7OZpWFpLF7fDFG3uUHKbeB+6NPpiRVfWCP65DHgoqO11EsHpfgbKAQ8VUpLMRRzssw88EBYmoI7DekdpFXymXOsq7vt4/lkFDR1LzzNb9M1t8GT7pKmL8VbI/02+1H6NFfEmRDOKH/GO2pygVQC3SkX2gez0JHMAGMvDbZULbaowrQLkCDdkcGrm1ZyqrqmM0Q1Ai7ybKgQxFwX1S4BdF2WxLnwIVzghflWgZldou+nI8GIEijCDW2ha72+nG5WuWFksl42ObMVH+Lg5x5cyU3MAtSSseFOAAtbT/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH7PR11MB5958.namprd11.prod.outlook.com (2603:10b6:510:1e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 20:40:19 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3%5]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 20:40:19 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
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
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 18/37] mm: Add guard pages around a shadow stack.
Thread-Topic: [PATCH v3 18/37] mm: Add guard pages around a shadow stack.
Thread-Index: AQHY8J5Z/yyGN1DeJ0iivA3WbjZDhq4/84aAgACQLwA=
Date:   Tue, 15 Nov 2022 20:40:19 +0000
Message-ID: <6e402f94fe1e942116aca729f1d54fd1399cb98a.camel@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
         <20221104223604.29615-19-rick.p.edgecombe@intel.com>
         <Y3OAP3E3UQShJ22N@hirez.programming.kicks-ass.net>
In-Reply-To: <Y3OAP3E3UQShJ22N@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH7PR11MB5958:EE_
x-ms-office365-filtering-correlation-id: fb9f964f-a2cd-42db-0283-08dac7499c5e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2LsEzUGlI6ZnUNiihK0ZaIC73+ILpcx94FOK4PN3wc9rz6A1kqsLK2jvMS2VGSld7BJEJUyU/MRBzEnANh/azkr63GpqRnEOFsGLs/d2HUMekTWJ0jNQXmVrZ46t4hOlGyUfThv3W6w2Iy+bfMlbCI/pW7IQ21vQhSNg5H1hGhvRPoUB6SY0Fr6HWhRKWwt9mnJZEe9bJwnt8FY063Fl5t77/eOzAz7q7EpdtAD3uPLEeKHScE0dADiMjbjxftzf4+mQznAItxo/Gyw3R08dkQK6aZ2oRKCOCkjuUN4AA37mYkxkqW44h9hh/Vmicnyay/4B3SJSL0BpPiUijkYAWVn53xZhvqFPH2L813QEhBMQSmSU/+B3jK77duW5i7tUJoimt1cVbc/Kvp19g76RFBBoQca0/YOiCKTT1AcyD9NKtrv45ZCnn4zpjiru9t4d52j5j+vPP7lG1cI/fmbqTN0WSp3CFgVPaQx+YlCthO4WVWu47qCha80Q9QsQeKbPfHuOxc11VOICVvjxLLSdjOYe1QiU4cu2lxTmo/a0edAMH2ldHu+qvBT07ZQGVf9obwulYALiDtVdaXaHkvGtAgi7RqVnwJW2nr5csHj6hx6Ar95qAcawHkN6tPn8VYbxtwRW6rdfs+o6zmhrOyGE6v1AaUW/ley0o74+oUblqXEYJgjjN84yaeoy9vWpxBQLmZ7BVu8yyQwOfuHl8koP2o72BUkc/0qk9f/VSa7KOg5jfPi08JzNLYpHdOoCj5e9ACr0eA4VSFKFh4i+16BgeB+REkJJfmV+HgB46e7ZBwY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199015)(71200400001)(6486002)(478600001)(6916009)(38070700005)(54906003)(6506007)(64756008)(66476007)(316002)(6512007)(66446008)(66556008)(66946007)(26005)(76116006)(82960400001)(86362001)(91956017)(7406005)(4326008)(8676002)(186003)(38100700002)(8936002)(2616005)(5660300002)(36756003)(7416002)(122000001)(4001150100001)(41300700001)(2906002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?di9Dd1pmdzMxQnhmM042bHQxWEhTSExUZEp0WnZ4T2pybWdBajcvb2sxTGlM?=
 =?utf-8?B?TDR3VUpDWDlIZnVCZTlKcFhVUFR6bEYxRnhYWGZXZmVHZ3VDYjB1Wm5DL3Fk?=
 =?utf-8?B?YmswVmFocVN4WmxNWXowQjRUSks0aGpGdm1qdWxpNkVMM2pBZlM0TnFISVYw?=
 =?utf-8?B?QStydmJrS1V6c3VQSEEycUJubVdyRlArRXdqZVZwOGNTZlhnR3lBb0VpR2dn?=
 =?utf-8?B?VE4wbHdTMVlXVHR3dGxPcjYzNHNWNE45a0VqSXJMZlhyeERqakNwU2NRMXcv?=
 =?utf-8?B?dkZqbkd0TlEzSThzM25JRWx1MklkUUxWVno5Q1hZZWY2R2RLZmxUd0xtbWh1?=
 =?utf-8?B?MW45cklQb2YyTmMwdDc2dzJQL3o1ZUt6dWdKZFFpaWFBVFUrSjFPalBrc25J?=
 =?utf-8?B?d01XZ1owU2g2VFd3djI2NjBISVpHZG5WUEtIVHpwUGRKQTg4SlQ4RG9jZXY5?=
 =?utf-8?B?ZWQ3cEx0U0JTaXRzbGQzcWo3RUxWTElubDZtdHAwQVVrTk1RMmZId3BNZ3FC?=
 =?utf-8?B?RGRhYzRFdXhFZXlzNjAzVmllUHAyTnN3UDErbE9HOVc0aXBNaU5CUWcrdVBw?=
 =?utf-8?B?aEZ4cTd3UFVLSUp1SUhNVDJ0d1BVK1RrWTNKOGljRWZ4WURNMUlnc0RMMy9Q?=
 =?utf-8?B?MXFNMSt5dlpWUkgrUkxMYnNMVzFtVTZyT0c2b3Y3dGZQMnN5SFNmVjA3R29t?=
 =?utf-8?B?Mm5aODhqNnB1ZzV4aUNnayt6VjY5R2g2UVdIWnhZeFBvVmx0RGpxckhEejQx?=
 =?utf-8?B?RmdYNEJGa2cvazlyVHFRMnl5MUVzbndlYnhoa3cvNmtOS29BMUFESGJ6S3FD?=
 =?utf-8?B?NkErc3ZhOHNldXo5eENBdWdZTGk3YS9iZVZPVWlBWWx3SjgwdTlpcWFlUEFi?=
 =?utf-8?B?MSt3bFo1Q2xzblJ0aFRYSEE3L2FHWDZneFV6QjBUR29JZXRYazF6M2U0QnNv?=
 =?utf-8?B?ckYxRHNaQmcwUlFNVEo2aFp4YytUWGRGdVVTM1Bab1NtUURaNHhhTlhBTHNK?=
 =?utf-8?B?bUNHZVJHUFN1QkNXbzRZbVdtcG1aZFd1OVpWUTg0V0hhbTdHS05SeUtHSEFV?=
 =?utf-8?B?UkNxdEpLQTN2b1lxY2M2RjFjYlVQQjJkM21Sbk43Mm84eGhUQ1lUQ0VVK1p5?=
 =?utf-8?B?ZWc4RXM5NGx3OW9TNzJrTFlMVjE1MWZFaE55RTBnOWN6WkhJNWl0ZE01dlhO?=
 =?utf-8?B?bTh3TWxTeTZTTE1NSitzd0hrZi9DTlNLY1lYSVBaK2lDWEZ6Tyt4emUvNHJ4?=
 =?utf-8?B?T3ppcUdxVWs0aGtRaGIzRC91NVErdTcrMDIxY1FTd0ViL056WWR4ZXZ5OHMx?=
 =?utf-8?B?NVd5SUJNb3JwNTJUUE5jeHZMRlVEQWJGR05yeHNpcmVGTVl4NzVQcEtHYTFi?=
 =?utf-8?B?WlZVbW1UMXpLV3FNMHlQL09DbVlWYUtVUElsVkVPTHBmQi8rQU13RTRwcnFx?=
 =?utf-8?B?NDI4Nm04ajFvT0xSNjdxTE4zcDRRMHV3Y0JDeTBKS29EdXRhN3Q0ZDNMOHFV?=
 =?utf-8?B?WGZ1RmE4dGFJNjdFTWNManJKR1BCbWtQUStsdWNEaEhka3dJaEVFSXptSk5T?=
 =?utf-8?B?Qm9TTVFicFRwVTN2ZGpVL3JzQ2V5TFpuaFZORkhJVXpJcDBpM3lMckFWR0h0?=
 =?utf-8?B?NFNuakdWd2NqOHpxM0dlcHhpQ1M2UFZTVXZGWlZldEErQmRRODl3bkdLNkx5?=
 =?utf-8?B?ZisyZGZ3b2taL01hYnZIWXJPekREL2tjbnZINzd4a2kvTjhrcFk1NTVNUjUz?=
 =?utf-8?B?K1dxVUNhVjQ3dElIVmxoOGxpTkE3UmNtUkxFYWJCQ2VPWE15WHdLTTY4WDhS?=
 =?utf-8?B?Zmc5V0Y0SUFybWo2UlRYZTk3TmZmS0tzNTZMa3R3ZFppMVI3MDZNVEUxT1Nh?=
 =?utf-8?B?SGVSbzE3aW01dzcybEwvWWZQV0RGdENkWHhJc3lDekljOFl4dXZtRWNyMitX?=
 =?utf-8?B?NmFKTnhOTXBkS25DVDRDOWM3R3F6VXZYTUIvbFYyQTB4aDU2TEpzdG53TVpJ?=
 =?utf-8?B?SXFMN0JBRGd2cHdadlhlRytXVzM1Y0pHdkY3TC95OS9Sd3JpRFdmWEFOR1FN?=
 =?utf-8?B?VVJjdXpWdHMzbVF4S01lSlVIL2tzMHpLdGpZWnhWdXdEYW0vQnVDck40dWFO?=
 =?utf-8?B?MHd5N0tvWGdxbmtkZTlwcVFXZnFSRUh5RTdML3RZYWJjOXV2dXVTdDBnUitH?=
 =?utf-8?Q?Uux8B76wDS+NNdZ3dcSIiWo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F45A7F2C61B1D45953802B330870991@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9f964f-a2cd-42db-0283-08dac7499c5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 20:40:19.5980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UCqBaDoqVK9YLyZl3YWEzMtLPe0e3mnH25ENScvUhWakgX9WhalOFHNo+4Bfc0L+2yhpaFZYaykLYoSUFm259euBYHNNJ3ZR9WlxR0KbQJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5958
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTE1IGF0IDEzOjA0ICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gRnJpLCBOb3YgMDQsIDIwMjIgYXQgMDM6MzU6NDVQTSAtMDcwMCwgUmljayBFZGdlY29t
YmUgd3JvdGU6DQo+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9tbS9tbWFwLmMgYi9hcmNo
L3g4Ni9tbS9tbWFwLmMNCj4gPiBpbmRleCBjOTBjMjA5MDRhNjAuLjY2ZGExZjMyOThiMCAxMDA2
NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9tbS9tbWFwLmMNCj4gPiArKysgYi9hcmNoL3g4Ni9tbS9t
bWFwLmMNCj4gPiBAQCAtMjQ4LDMgKzI0OCwyNiBAQCBib29sIHBmbl9tb2RpZnlfYWxsb3dlZCh1
bnNpZ25lZCBsb25nIHBmbiwNCj4gPiBwZ3Byb3RfdCBwcm90KQ0KPiA+ICAgICAgICAgICAgICAg
IHJldHVybiBmYWxzZTsNCj4gPiAgICAgICAgcmV0dXJuIHRydWU7DQo+ID4gICB9DQo+ID4gKw0K
PiA+ICt1bnNpZ25lZCBsb25nIHN0YWNrX2d1YXJkX3N0YXJ0X2dhcChzdHJ1Y3Qgdm1fYXJlYV9z
dHJ1Y3QgKnZtYSkNCj4gPiArew0KPiA+ICsgICAgIGlmICh2bWEtPnZtX2ZsYWdzICYgVk1fR1JP
V1NET1dOKQ0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuIHN0YWNrX2d1YXJkX2dhcDsNCj4gPiAr
DQo+ID4gKyAgICAgLyoNCj4gPiArICAgICAgKiBTaGFkb3cgc3RhY2sgcG9pbnRlciBpcyBtb3Zl
ZCBieSBDQUxMLCBSRVQsIGFuZA0KPiA+IElOQ1NTUChRL0QpLg0KPiANCj4gQ2FuIHdlIHBlcmhh
cHMgd3JpdGUgdGhpcyBsaWtlOiBJTkNTUFBbUURdID8gVGhlICgpIG5vdGF0aW9uIG1ha2VzIGl0
DQo+IGxvb2sgbGlrZSBhIGZ1bmN0aW9uLg0KDQpTdXJlLg0KDQo+IA0KPiA+ICsgICAgICAqIElO
Q1NTUFEgbW92ZXMgc2hhZG93IHN0YWNrIHBvaW50ZXIgdXAgdG8gMjU1ICogOCA9IH4yIEtCDQo+
ID4gKyAgICAgICogKH4xS0IgZm9yIElOQ1NTUEQpIGFuZCB0b3VjaGVzIHRoZSBmaXJzdCBhbmQg
dGhlIGxhc3QNCj4gPiBlbGVtZW50DQo+ID4gKyAgICAgICogaW4gdGhlIHJhbmdlLCB3aGljaCB0
cmlnZ2VycyBhIHBhZ2UgZmF1bHQgaWYgdGhlIHJhbmdlIGlzDQo+ID4gbm90DQo+ID4gKyAgICAg
ICogaW4gYSBzaGFkb3cgc3RhY2suIEJlY2F1c2Ugb2YgdGhpcywgY3JlYXRpbmcgNC1LQiBndWFy
ZA0KPiA+IHBhZ2VzDQo+ID4gKyAgICAgICogYXJvdW5kIGEgc2hhZG93IHN0YWNrIHByZXZlbnRz
IHRoZXNlIGluc3RydWN0aW9ucyBmcm9tDQo+ID4gZ29pbmcNCj4gPiArICAgICAgKiBiZXlvbmQu
DQo+ID4gKyAgICAgICoNCj4gPiArICAgICAgKiBDcmVhdGlvbiBvZiBWTV9TSEFET1dfU1RBQ0sg
aXMgdGlnaHRseSBjb250cm9sbGVkLCBzbyBhDQo+ID4gdm1hDQo+ID4gKyAgICAgICogY2FuJ3Qg
YmUgYm90aCBWTV9HUk9XU0RPV04gYW5kIFZNX1NIQURPV19TVEFDSw0KPiA+ICsgICAgICAqLw0K
PiA+ICsgICAgIGlmICh2bWEtPnZtX2ZsYWdzICYgVk1fU0hBRE9XX1NUQUNLKQ0KPiA+ICsgICAg
ICAgICAgICAgcmV0dXJuIFBBR0VfU0laRTsNCj4gPiArDQo+ID4gKyAgICAgcmV0dXJuIDA7DQo+
ID4gK30NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tbS5oIGIvaW5jbHVkZS9saW51
eC9tbS5oDQo+ID4gaW5kZXggNWQ5NTM2ZmE4NjBhLi4wYTNmN2UyYjMyZGYgMTAwNjQ0DQo+ID4g
LS0tIGEvaW5jbHVkZS9saW51eC9tbS5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9tbS5oDQo+
ID4gQEAgLTI4MzIsMTUgKzI4MzIsMTYgQEAgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWFfbG9v
a3VwKHN0cnVjdA0KPiA+IG1tX3N0cnVjdCAqbW0sIHVuc2lnbmVkIGxvbmcgYWRkcikNCj4gPiAg
ICAgICAgcmV0dXJuIG10cmVlX2xvYWQoJm1tLT5tbV9tdCwgYWRkcik7DQo+ID4gICB9DQo+ID4g
ICANCj4gPiArdW5zaWduZWQgbG9uZyBzdGFja19ndWFyZF9zdGFydF9nYXAoc3RydWN0IHZtX2Fy
ZWFfc3RydWN0ICp2bWEpOw0KPiA+ICsNCj4gPiAgIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9u
ZyB2bV9zdGFydF9nYXAoc3RydWN0IHZtX2FyZWFfc3RydWN0DQo+ID4gKnZtYSkNCj4gPiAgIHsN
Cj4gPiArICAgICB1bnNpZ25lZCBsb25nIGdhcCA9IHN0YWNrX2d1YXJkX3N0YXJ0X2dhcCh2bWEp
Ow0KPiA+ICAgICAgICB1bnNpZ25lZCBsb25nIHZtX3N0YXJ0ID0gdm1hLT52bV9zdGFydDsNCj4g
PiAgIA0KPiA+IC0gICAgIGlmICh2bWEtPnZtX2ZsYWdzICYgVk1fR1JPV1NET1dOKSB7DQo+ID4g
LSAgICAgICAgICAgICB2bV9zdGFydCAtPSBzdGFja19ndWFyZF9nYXA7DQo+ID4gLSAgICAgICAg
ICAgICBpZiAodm1fc3RhcnQgPiB2bWEtPnZtX3N0YXJ0KQ0KPiA+IC0gICAgICAgICAgICAgICAg
ICAgICB2bV9zdGFydCA9IDA7DQo+ID4gLSAgICAgfQ0KPiA+ICsgICAgIHZtX3N0YXJ0IC09IGdh
cDsNCj4gPiArICAgICBpZiAodm1fc3RhcnQgPiB2bWEtPnZtX3N0YXJ0KQ0KPiA+ICsgICAgICAg
ICAgICAgdm1fc3RhcnQgPSAwOw0KPiA+ICAgICAgICByZXR1cm4gdm1fc3RhcnQ7DQo+ID4gICB9
DQo+ID4gICANCj4gPiBkaWZmIC0tZ2l0IGEvbW0vbW1hcC5jIGIvbW0vbW1hcC5jDQo+ID4gaW5k
ZXggMmRlZjU1NTU1ZTA1Li5mNjc2MDZmYmM0NjQgMTAwNjQ0DQo+ID4gLS0tIGEvbW0vbW1hcC5j
DQo+ID4gKysrIGIvbW0vbW1hcC5jDQo+ID4gQEAgLTI4MSw2ICsyODEsMTMgQEAgU1lTQ0FMTF9E
RUZJTkUxKGJyaywgdW5zaWduZWQgbG9uZywgYnJrKQ0KPiA+ICAgICAgICByZXR1cm4gb3JpZ2Jy
azsNCj4gPiAgIH0NCj4gPiAgIA0KPiA+ICt1bnNpZ25lZCBsb25nIF9fd2VhayBzdGFja19ndWFy
ZF9zdGFydF9nYXAoc3RydWN0IHZtX2FyZWFfc3RydWN0DQo+ID4gKnZtYSkNCj4gPiArew0KPiA+
ICsgICAgIGlmICh2bWEtPnZtX2ZsYWdzICYgVk1fR1JPV1NET1dOKQ0KPiA+ICsgICAgICAgICAg
ICAgcmV0dXJuIHN0YWNrX2d1YXJkX2dhcDsNCj4gPiArICAgICByZXR1cm4gMDsNCj4gPiArfQ0K
PiANCj4gSSdtIHRoaW5raW5nIHBlcmhhcHMgdGhpcyB3YW50cyB0byBiZSBhbiBpbmxpbmUgZnVu
Y3Rpb24/DQoNCkkgZG9uJ3QgdGhpbmsgaXQgY2FuIHdvcmsgd2l0aCB3ZWFrIHRoZW4uDQo=
