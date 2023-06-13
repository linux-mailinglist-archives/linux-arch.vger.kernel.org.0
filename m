Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B82072E824
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 18:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241553AbjFMQPx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 12:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241540AbjFMQPw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 12:15:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423EB92;
        Tue, 13 Jun 2023 09:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686672950; x=1718208950;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1YSguj2NdFKopLjLCmcdLEOf3/miHcdDvhhxqpdJRT8=;
  b=mw6gZDxYN0Dtrhb2S3gN211giSZWE0N376FmCCId0VjdcZY/nlKHuwV0
   fzIqmUvmV+aL28rR3SACIBktJvkco1y7g/WjtaF750N9raLnQqCnuuNkC
   jhuIskfjQPer0APTLof9zOdCHets7k8yjj6/qpStIqUDY7TaDiWLsYf0r
   cAF090LvfVdCrxPCwP9CvRf1u4kI1lTcbeN+8MAzhoc+/IHbVCAj4ECVk
   kuWmbOFFqXuLLOaL/RHMLL8ZYPYHSYrKpHj9AOJ44dvUpYizZLDHAsXMk
   EyOToski8sRP8j2Kjs5CxeVFXbtGdhRKcFlqtcyG/89MksgHqY2bMCRgv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="360864427"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="360864427"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 09:14:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711714696"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="711714696"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 13 Jun 2023 09:14:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 09:14:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 09:14:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 09:14:38 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 09:14:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0k/6F7gPxogx+ZdDzC04x7ONxKJctyq7M91RtcI/MInhjGI15qZNmDXQhCgIf6oKcbg9rmEjvAI8JtkWIQsiFAuj5/NYLvsj+/QFLJyU4+NtNAqxzz9uwuLDY4xGq6AlVB5CJausgqHEwjhhoj/TCm64/g2V5sQVnxSfXEDRjgVflN+jdxlkd6M7xqqr5aPBQLBNyrqVhd9v0jI9GsKd+zas2OcABJsKK6KwI98zjGjMyc4KMtvCzIhgakfoMhdbRIzGHtanAfPaGP9i9KOwtk3zHMHsxvSBtaViRncFs6+9IDmqTny53Nc4HT+nhwPG/FCXtw/2JN5+XXH+5g6tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YSguj2NdFKopLjLCmcdLEOf3/miHcdDvhhxqpdJRT8=;
 b=HSmGMdrW/RVo2LReKraQFNIFSL2NhTFmhZqtyaLu/NX6Z7mNBpjm5EEZQ1cF5mVEbZ29TJruKNK4+4wS2VDiKJQ2XtoMNxep75H7PG59y4aZvEoiAmlCjfn+vdJwj5dQHjJu1ryFAX/4bFDjk/XoHEUbnnc4emadAYjhtW5l8vHbc37OzxGA9l+7OGYHD2LovsvY+W0/t8Q5ucCsV1F2z/B+bAmIuVtIE+UcSE26QBnKBQaTO4HCT4UyrNXkW3LJ6cad+9ixBf7Z7F/jAdEcdZTTgKCEcjBIjH487CGCWPLtDp9WOqPs84CLSBbDjxU7JkVSXq96PsVcwo+X0/zrIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CH0PR11MB5314.namprd11.prod.outlook.com (2603:10b6:610:bd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 16:14:29 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 16:14:29 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "rppt@kernel.org" <rppt@kernel.org>
CC:     "Schimpe, Christina" <christina.schimpe@intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "david@redhat.com" <david@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "torvalds@linuxfoundation.org" <torvalds@linuxfoundation.org>,
        "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v9 01/42] mm: Rename arch pte_mkwrite()'s to
 pte_mkwrite_novma()
Thread-Topic: [PATCH v9 01/42] mm: Rename arch pte_mkwrite()'s to
 pte_mkwrite_novma()
Thread-Index: AQHZnYu46x2k3QQH7UG560N9dHwyWK+IWnuAgACOrYA=
Date:   Tue, 13 Jun 2023 16:14:29 +0000
Message-ID: <5669622238aa3092218b82ced6221a244a25dcc3.camel@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
         <20230613001108.3040476-2-rick.p.edgecombe@intel.com>
         <20230613074347.GR52412@kernel.org>
In-Reply-To: <20230613074347.GR52412@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CH0PR11MB5314:EE_
x-ms-office365-filtering-correlation-id: f7d6ee06-80b8-4ef0-9173-08db6c294451
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JWprDw9R91T6P7sdlq7mHurm8vtSSWDW6tZUV2LH6k4+F+0jmuq1mnataaDRCiyaQxKj9/aysCdqL52j2JMoArubrKQ0JxckZj245CU5W+VUh3hdSHDf1kOq3szzlxuIYBbFlJReMnsF+Na5MiZrHW2Rja5rIVIHicMmdzMolK9L98NDoivdZUHIf2QYDuI0Sx0Syct1qyiLq+i/DA6An9IfQnjRbwLodVgcCXPxpW47iKdzbfWbzOssZMY9FW2SLt/JSBsmeB4MOmaptO9Is2DGrlFDXF8KZBFeV593wXBE0jrjlDwaF5+r+HFpPv0bYTMXZSt8FPBg3sS7Acb5dzFiXdUIJ+koBCtFHAfVzw5gW3GUQmb6fUWViabgeLxmmsRuBJ6BeB7GVx7bCpeZcBZH1Xhn/5ZtjG7FgSUUuMuOhb0g4O0O9IUTxERNUzvD75sto/MxylTFrDM9cLO5lunua92WNUMJw8Vete0UUdLd3H8L8SylE0ufk0r2cKuw4+BfW3WEAcT2rqUsCcYhwm+uRFxj6LPvctbTBxdsPOpcT6hoCtdlJfuuaxCIHkOkBS3pKh8C3TfGgmW+U5cUs3/O0mBBtwex8kClE5zCGMk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(396003)(346002)(366004)(451199021)(2616005)(5660300002)(6486002)(54906003)(122000001)(82960400001)(71200400001)(6916009)(41300700001)(8676002)(8936002)(66476007)(64756008)(316002)(66556008)(66946007)(478600001)(4326008)(91956017)(66446008)(76116006)(38100700002)(966005)(186003)(83380400001)(26005)(6512007)(6506007)(86362001)(7366002)(7416002)(38070700005)(2906002)(7406005)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1hkaUsySkZPVFVjZGNJT1hrV3FsNU5UTG0zalB4b3Yrd3I2eWZYQ1FUS0Nw?=
 =?utf-8?B?UGlTQUhocTJMOHd2Y0c2TzhoTXdsb3RRcDZEUXpGcEVUd1FTTytGVVFuTjBQ?=
 =?utf-8?B?TkVvVG1yZ3VDYjYxdnhaL0ZDWGxDNjc3bFV6Qk1tWUVrd3Ezc2VBOGc0SCtM?=
 =?utf-8?B?RVRKNGQyZG5ibkJHSFF2SE1OQ1NRdGVQOUlLWUFtKzM2WHk5aDhHbHFOMndk?=
 =?utf-8?B?QUZ4VUt0d3VySm5valpoSnNtTFRGcWN5K2IrTk5pRUJsYVg0SFZ5UzJZUjJi?=
 =?utf-8?B?MFRkSW5HOTFwMkV4K291blVndHNxUE1xWFBYTVYvNlFVNjQyeWtLN1hSUXRV?=
 =?utf-8?B?SkFKbS9FY2MySTAwYTh1ZFcxaHU4WjFQRlFVaDlUeE9pOU1Pc3lpUktsRnhp?=
 =?utf-8?B?WFRqNGFpZThOQkRLdmMwN0ozaTRJd1Y4Nm1WcE1EQ1k1a0p1RXlBVVJ1ZW44?=
 =?utf-8?B?L3ZDOFMwdTVjRU5CV3lQMnJRQkNJaFdlUnA1WnpkTkIyQUxpRmdoQTUzZkxQ?=
 =?utf-8?B?K2FDUHkraDlyQy8rYitXa3czRk1rQ1FLcHU2VnlBakVNd0ttOTN6V1RtcmVs?=
 =?utf-8?B?aUV4bVJjazFvcEh1dlVGck5MYnp2aTViNVdRMVV0WUF4d0M0anJhM083MUI0?=
 =?utf-8?B?VzE4c0o3MDhMVkg0SzNWTjdXeDRCVlFsaVI5MkczSEtiVmk5Z0xEamhlMlpr?=
 =?utf-8?B?dCtvQ3JOMzVCVG9PdUlrN0k0VDZJN0JrTmI3WmxSU0xLbW0ya3VScy8yZStW?=
 =?utf-8?B?MXBYd3grdjBXem9KYi81YTFzcXQ5a0pWUjRINWsxWjNZMlNIZnJCbjN5U2Vh?=
 =?utf-8?B?SWpXUnQwL3ZQMHlzc2dzL0p3MjdUek8zeXdsQ0VwVWRIaDZHZXp4b25XdFFO?=
 =?utf-8?B?Q1NPVitQeW5KR2NTN1JQd25STTN3L1FJREl2MjJ5V2VRbzFPMFJ2TnVHUFBi?=
 =?utf-8?B?N09XbTE3NHJ6aXJWenNOTkZsVlFHemt4UnQ5VXdJRXVQT25CWFlUdlZFUFlx?=
 =?utf-8?B?VW5iYVZFN0ZDckhCcXRJdHZNRTZIV2RUcmdCdFhmUTF5bFIySGpsTGtBdkxx?=
 =?utf-8?B?WXQyM2o4MngvVjAvZFJ1UGQxaTJvSnA4TVdTN0IzR1JBNHRVL3FnV09VeW51?=
 =?utf-8?B?NXFJQjdqMk5LMnM4Nk1DUS96ejdyKzVtT0pmVW9ta2R4MjBubkNBRG8vbFF1?=
 =?utf-8?B?L2QraVIrem9oa3l0NG5lLzVTVjJzYm41VWxMNVdmVWoxRFZGL2ZSQUFxNmNN?=
 =?utf-8?B?VVl1azJNaElxZnJMbHlEaVdVcys2VWJzWVVIb2x2YlFwV202UlJUUUlNSzBQ?=
 =?utf-8?B?UmZYWXZLaXEwbVVWN09qK0NEM1JveFdUVHNTVHNaMnR4aXZuSTJpcTE2S2hn?=
 =?utf-8?B?UVNjWUFKRGYxQXlSOUJ2UmFSUFF6ZzRKdHhGREdlUkVValV5ZlhaVnNUOGc1?=
 =?utf-8?B?NkUyN2l0NlUycElzeEdodGtIUndmR2dGdFo1c1lObVgrOUE0ZGR2SFBnUlVt?=
 =?utf-8?B?WFpyejl0MjlJN25TT21zbWtMS2JUZXpCdlB4WlVQWHUySEpRMXJrN3l5MVFw?=
 =?utf-8?B?Mm1oNkRTckNwK29zMXA4Ujk3K0pNZXkzbDNUYm0wOW5tcXV6Tm10TEZCb3FT?=
 =?utf-8?B?QmNFSTlFdXZ0MFY3T3ZyYTlsbHdLSnBvVlZLOHRMLzBRTW0wU3Bod2FvVFNU?=
 =?utf-8?B?MHJFcTMxUTVTbVJMWlhvQXVxY0VHMEhlMkhjSHk1SEw1SW1JTUt6R0ZIVGh5?=
 =?utf-8?B?MDd1RDRadUtPV1hhRTAyRFV3NHdVQTFxQ2JUenpldTk5b2dVRkc0L1oveGRD?=
 =?utf-8?B?MHNPTG5uNnhRS0wzd2N6OXNyRDkrWk5vbFdSODE4WnVRbU9YMXl6Skp1NDlS?=
 =?utf-8?B?UWQ1Q1FkMitZNUpVVGkvd1FGQlA0aEpDV2FDa1VOSUN2UWlzUnV6V1N0SmRj?=
 =?utf-8?B?WFFLbE1Ib3FFWEQ3TFhLMVZYWHN3dTZvUjk5Q2x4a21IdXNoczhNWlROZFUv?=
 =?utf-8?B?ck53eGNDTGZ0YUNRVDFVZCt1UzJhOW4vVnZwTTJudzlMUGI3clEvUVZwYXEz?=
 =?utf-8?B?YllacUZGWGZFMTU1MWg5bml2bjF2YkZaL3RFNDdMdW04UVlzaVRYMWM5WFVY?=
 =?utf-8?B?VlNoRWpxclZLcmpBM3pJZVhqVC9ub2c1TVpaYUJpQXowY21ZNm9neVVDa2RJ?=
 =?utf-8?B?Smc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AA4083E4B64FB458A77F8FAA81792E3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d6ee06-80b8-4ef0-9173-08db6c294451
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 16:14:29.8596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X1SEBhgkCDj3W1VugL+rsL+qnW6dLBlMJaQgqH0TuTjRBohGpVUjSkPOYrsJ/6VAwZt/tS/UM9uucb6Vih/ZKqb3mIABHHqi1zUY7WFDNsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5314
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIzLTA2LTEzIGF0IDEwOjQzICswMzAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBPbiBNb24sIEp1biAxMiwgMjAyMyBhdCAwNToxMDoyN1BNIC0wNzAwLCBSaWNrIEVkZ2Vjb21i
ZSB3cm90ZToNCj4gPiBUaGUgeDg2IFNoYWRvdyBzdGFjayBmZWF0dXJlIGluY2x1ZGVzIGEgbmV3
IHR5cGUgb2YgbWVtb3J5IGNhbGxlZA0KPiA+IHNoYWRvdw0KPiA+IHN0YWNrLiBUaGlzIHNoYWRv
dyBzdGFjayBtZW1vcnkgaGFzIHNvbWUgdW51c3VhbCBwcm9wZXJ0aWVzLCB3aGljaA0KPiA+IHJl
cXVpcmVzDQo+ID4gc29tZSBjb3JlIG1tIGNoYW5nZXMgdG8gZnVuY3Rpb24gcHJvcGVybHkuDQo+
ID4gDQo+ID4gT25lIG9mIHRoZXNlIHVudXN1YWwgcHJvcGVydGllcyBpcyB0aGF0IHNoYWRvdyBz
dGFjayBtZW1vcnkgaXMNCj4gPiB3cml0YWJsZSwNCj4gPiBidXQgb25seSBpbiBsaW1pdGVkIHdh
eXMuIFRoZXNlIGxpbWl0cyBhcmUgYXBwbGllZCB2aWEgYSBzcGVjaWZpYw0KPiA+IFBURQ0KPiA+
IGJpdCBjb21iaW5hdGlvbi4gTmV2ZXJ0aGVsZXNzLCB0aGUgbWVtb3J5IGlzIHdyaXRhYmxlLCBh
bmQgY29yZSBtbQ0KPiA+IGNvZGUNCj4gPiB3aWxsIG5lZWQgdG8gYXBwbHkgdGhlIHdyaXRhYmxl
IHBlcm1pc3Npb25zIGluIHRoZSB0eXBpY2FsIHBhdGhzDQo+ID4gdGhhdA0KPiA+IGNhbGwgcHRl
X21rd3JpdGUoKS4gRnV0dXJlIHBhdGNoZXMgd2lsbCBtYWtlIHB0ZV9ta3dyaXRlKCkgdGFrZSBh
DQo+ID4gVk1BLCBzbw0KPiA+IHRoYXQgdGhlIHg4NiBpbXBsZW1lbnRhdGlvbiBvZiBpdCBjYW4g
a25vdyB3aGV0aGVyIHRvIGNyZWF0ZQ0KPiA+IHJlZ3VsYXINCj4gPiB3cml0YWJsZSBtZW1vcnkg
b3Igc2hhZG93IHN0YWNrIG1lbW9yeS4NCj4gDQo+IE5pdDrCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXiBtYXBwaW5nPw0KDQpIbW0sIHN1cmUu
DQoNCj4gDQo+ID4gQnV0IHRoZXJlIGFyZSBhIGNvdXBsZSBvZiBjaGFsbGVuZ2VzIHRvIHRoaXMu
IE1vZGlmeWluZyB0aGUNCj4gPiBzaWduYXR1cmVzIG9mDQo+ID4gZWFjaCBhcmNoIHB0ZV9ta3dy
aXRlKCkgaW1wbGVtZW50YXRpb24gd291bGQgYmUgZXJyb3IgcHJvbmUgYmVjYXVzZQ0KPiA+IHNv
bWUNCj4gPiBhcmUgZ2VuZXJhdGVkIHdpdGggbWFjcm9zIGFuZCB3b3VsZCBuZWVkIHRvIGJlIHJl
LWltcGxlbWVudGVkLg0KPiA+IEFsc28sIHNvbWUNCj4gPiBwdGVfbWt3cml0ZSgpIGNhbGxlcnMg
b3BlcmF0ZSBvbiBrZXJuZWwgbWVtb3J5IHdpdGhvdXQgYSBWTUEuDQo+ID4gDQo+ID4gU28gdGhp
cyBjYW4gYmUgZG9uZSBpbiBhIHRocmVlIHN0ZXAgcHJvY2Vzcy4gRmlyc3QgcHRlX21rd3JpdGUo
KQ0KPiA+IGNhbiBiZQ0KPiA+IHJlbmFtZWQgdG8gcHRlX21rd3JpdGVfbm92bWEoKSBpbiBlYWNo
IGFyY2gsIHdpdGggYSBnZW5lcmljDQo+ID4gcHRlX21rd3JpdGUoKQ0KPiA+IGFkZGVkIHRoYXQg
anVzdCBjYWxscyBwdGVfbWt3cml0ZV9ub3ZtYSgpLiBOZXh0IGNhbGxlcnMgd2l0aG91dCBhDQo+
ID4gVk1BIGNhbg0KPiA+IGJlIG1vdmVkIHRvIHB0ZV9ta3dyaXRlX25vdm1hKCkuIEFuZCBsYXN0
bHksIHB0ZV9ta3dyaXRlKCkgYW5kIGFsbA0KPiA+IGNhbGxlcnMNCj4gPiBjYW4gYmUgY2hhbmdl
ZCB0byB0YWtlL3Bhc3MgYSBWTUEuDQo+ID4gDQo+ID4gU3RhcnQgdGhlIHByb2Nlc3MgYnkgcmVu
YW1pbmcgcHRlX21rd3JpdGUoKSB0byBwdGVfbWt3cml0ZV9ub3ZtYSgpDQo+ID4gYW5kDQo+ID4g
YWRkaW5nIHRoZSBwdGVfbWt3cml0ZSgpIHdyYXBwZXIgaW4gbGludXgvcGd0YWJsZS5oLiBBcHBs
eSB0aGUgc2FtZQ0KPiA+IHBhdHRlcm4gZm9yIHBtZF9ta3dyaXRlKCkuIFNpbmNlIG5vdCBhbGwg
YXJjaHMgaGF2ZSBhDQo+ID4gcG1kX21rd3JpdGVfbm92bWEoKSwNCj4gPiBjcmVhdGUgYSBuZXcg
YXJjaCBjb25maWcgSEFTX0hVR0VfUEFHRSB0aGF0IGNhbiBiZSB1c2VkIHRvIHRlbGwgaWYNCj4g
PiBwbWRfbWt3cml0ZSgpIHNob3VsZCBiZSBkZWZpbmVkLiBPdGhlcndpc2UgaW4gdGhlICFIQVNf
SFVHRV9QQUdFDQo+ID4gY2FzZXMgdGhlDQo+ID4gY29tcGlsZXIgd291bGQgbm90IGJlIGFibGUg
dG8gZmluZCBwbWRfbWt3cml0ZV9ub3ZtYSgpLg0KPiA+IA0KPiA+IE5vIGZ1bmN0aW9uYWwgY2hh
bmdlLg0KPiA+IA0KPiA+IENjOiBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnDQo+ID4gQ2M6IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBDYzogbGludXgtYWxwaGFAdmdlci5rZXJu
ZWwub3JnDQo+ID4gQ2M6IGxpbnV4LXNucHMtYXJjQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gPiBD
YzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+ID4gQ2M6IGxpbnV4LWNz
a3lAdmdlci5rZXJuZWwub3JnDQo+ID4gQ2M6IGxpbnV4LWhleGFnb25Admdlci5rZXJuZWwub3Jn
DQo+ID4gQ2M6IGxpbnV4LWlhNjRAdmdlci5rZXJuZWwub3JnDQo+ID4gQ2M6IGxvb25nYXJjaEBs
aXN0cy5saW51eC5kZXYNCj4gPiBDYzogbGludXgtbTY4a0BsaXN0cy5saW51eC1tNjhrLm9yZw0K
PiA+IENjOiBNaWNoYWwgU2ltZWsgPG1vbnN0ckBtb25zdHIuZXU+DQo+ID4gQ2M6IERpbmggTmd1
eWVuIDxkaW5ndXllbkBrZXJuZWwub3JnPg0KPiA+IENjOiBsaW51eC1taXBzQHZnZXIua2VybmVs
Lm9yZw0KPiA+IENjOiBvcGVucmlzY0BsaXN0cy5saWJyZWNvcmVzLm9yZw0KPiA+IENjOiBsaW51
eC1wYXJpc2NAdmdlci5rZXJuZWwub3JnDQo+ID4gQ2M6IGxpbnV4cHBjLWRldkBsaXN0cy5vemxh
YnMub3JnDQo+ID4gQ2M6IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gPiBDYzog
bGludXgtczM5MEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBDYzogbGludXgtc2hAdmdlci5rZXJuZWwu
b3JnDQo+ID4gQ2M6IHNwYXJjbGludXhAdmdlci5rZXJuZWwub3JnDQo+ID4gQ2M6IGxpbnV4LXVt
QGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gPiBDYzogbGludXgtYXJjaEB2Z2VyLmtlcm5lbC5vcmcN
Cj4gPiBDYzogbGludXgtbW1Aa3ZhY2sub3JnDQo+ID4gU3VnZ2VzdGVkLWJ5OiBMaW51cyBUb3J2
YWxkcyA8dG9ydmFsZHNAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBS
aWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQo+ID4gTGluazoNCj4g
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL0NBSGstPXdpWmpTdTdjOXNGWVpiM3EwNDEw
OHN0Z0hmZjJ3ZmJva0dDQ2dXN3Jpeis4UUBtYWlsLmdtYWlsLmNvbS8NCj4gDQo+IFJldmlld2Vk
LWJ5OiBNaWtlIFJhcG9wb3J0IChJQk0pIDxycHB0QGtlcm5lbC5vcmc+DQoNClRoYW5rcyENCg==
