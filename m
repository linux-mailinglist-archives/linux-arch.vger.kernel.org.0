Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6015A72E85A
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 18:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242636AbjFMQUp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 12:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242535AbjFMQUj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 12:20:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9CFB5;
        Tue, 13 Jun 2023 09:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686673237; x=1718209237;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IHL29WgjJjl9nIkpIA8n91KTj3OfbTF9AN6+iWvgtK8=;
  b=mpyKqEiYB5Jm3MXnR0ehGcTzOJE/uxT+CwaBrsxXIkD9FNEU5Q3tXA0D
   peLU+bby6jKArWDVUji0vxL3b/iWDCZI5CqA508NsLI2zF+UqqUARocTb
   UhnTKWEbwkRv9wLJ5szeuut2953SYkng8HmEwMj6SWIfztSijyaI1qIQX
   4U/1EmSkFUd5wBYi8RHgm/1XxIQlj/Mq44mWoBHRNYxcM4/a2v7xTgxie
   GCsbA639oscEmY+e2IGK4t1/xAm6hEb4I96SN9f3CfKFCoLhSKn3qSoW/
   pxO04k0KRtLCG59ot7hlMeZkytXqwha5F8AzXat+zHA5uSUfLn96KL+M5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="338742005"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="338742005"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 09:20:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="705878370"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="705878370"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 13 Jun 2023 09:20:34 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 09:20:33 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 09:20:32 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 09:20:32 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 09:20:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ag52Z9dnftxGfXPkuoN8uv0GvsNP3UStZxsY15K5wqyyIyUc3wyyA94ZstvvMPaRdSZbCp+6M/dCDQFp2EvXzwYYybpjE8sffc/Kah5ZYsRBd4mIYaf6tDQjeEO/md8yX5CcFxKKem8gE/o+vhlHji3bou+WE/Q3tcGSBAp2sMK0dCjLIAC6HgaYpNHefhSL0byYhMXRYh7VUcIdOasvVxrS52gKhsmn0NWPokmrZEa2mS3m9W0Un57oxgkNBJ4q6UJqR5T9oTtRRgOZRKyRzTr7/LewtjZ6UP9THqYzFfpSlSWL72X9VXWFZAtXLAAK1+9NKnSol2cSOXl52k283A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHL29WgjJjl9nIkpIA8n91KTj3OfbTF9AN6+iWvgtK8=;
 b=KjkV42nuZto+YduJvmcsn49niOjjnFxmsno3NTNMHV2RFe2f7FZYOPOWQsROGqBR5Af3u1NKpijN2tK5siMJCUXD87JfXF7nouzG+kLQ6DoWBwlewjV7WWP55Gs5WrZ81vhqttnOOPTw1tAE5GPA4qaXbMYD2rfeklk8p7Oy0F36770Vm3OgV+HNJw96RI+l8rpMOyfyO9xKviogkDZNWlZqW1u3J9Uv+wjOgLlcpUD0Y9Kxt48zbXdl5D1eY2Zhl8bHF++vxyeSRLzAPCM8CJ2xYouX7Tutd/LjkW61c531GEqAc4H6FuQV8EmBFmimZHvCs6pd6lROaUPhIygUJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA1PR11MB7853.namprd11.prod.outlook.com (2603:10b6:208:3f7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Tue, 13 Jun
 2023 16:20:27 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 16:20:27 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "rppt@kernel.org" <rppt@kernel.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 03/42] mm: Make pte_mkwrite() take a VMA
Thread-Topic: [PATCH v9 03/42] mm: Make pte_mkwrite() take a VMA
Thread-Index: AQHZnYvLI3qZgQAfOkuOCJG2PT9bba+IWjGAgACQpIA=
Date:   Tue, 13 Jun 2023 16:20:27 +0000
Message-ID: <34c4f8dac1db9995ae566dc2898296267d49bf1a.camel@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
         <20230613001108.3040476-4-rick.p.edgecombe@intel.com>
         <20230613074245.GQ52412@kernel.org>
In-Reply-To: <20230613074245.GQ52412@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA1PR11MB7853:EE_
x-ms-office365-filtering-correlation-id: b5f408bf-f2b7-4275-08e4-08db6c2a19aa
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tz8/uAZ1nAXM2OINaPTUj+tF0k/MttoShgEhYsso5m2C/IJ5h7n/bGO2dG6RuiiiB46cIJ2FQVBaUufV/cTyTJtqw/k5nOk+afmrmPS7g3DyFYqXMAZSy4w3hGfkIbUkE80omIFBGb+Y38cr//9l/smqnLQqpokBivaZnj2lADg4zYmsOtKD3SNp+GafCkzk8dFjraJJQG8YkMuG0Vny5M+OcLKC7YzrymjebX1zF9q9fq0gIAKzBLceS3i1DJFuCTjuPeBa7iWYcgeGbXAgAlkX7ufH+F9sTTu47iNM2XEIuWhEzewr6hZqd1Uvm8ilZK8Tuv3k2XXxo/Sk+TFXBHefC5vlImxYOUiWh6pJ8u+6i5H6BhA3OMjnFR7CV6kw6JVHP4Kbk7l8OYiMdmTT6IkwroyroHREsb6z8nXiMUBKn3fwkl3G3F46K8BYrVskJMjweTs5dQoiRLGmIjaP44ATrWAIVzFsN2Nkel/v3gpw7gogWb1T2HCQDquFg0LVTfZegH3FeURCTepJIeH5ZHB8HMIpL6VkU5Sp5Oq1HwQXXwGae9B4fl7a6KzOogru80G2+Pl5lGwepYwGaRa6LoSZQVwbKgupL5QW+U7ZDPo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199021)(38070700005)(86362001)(36756003)(91956017)(66556008)(4326008)(54906003)(6916009)(478600001)(71200400001)(316002)(66946007)(66476007)(64756008)(66446008)(76116006)(6486002)(5660300002)(4744005)(2906002)(8936002)(7416002)(8676002)(7406005)(2616005)(82960400001)(41300700001)(122000001)(38100700002)(6512007)(6506007)(186003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFkzMWJ4bnpRelhjRmZCWVVLM1Q5ajNpS1JFYW5lS1JSV1VwQnZLUXcwQ3FV?=
 =?utf-8?B?L1MvRys0NU11dHJxUkJaVCtRa2Y5RDlMTCtQOU42T3pDSnI4UnYrUW15NUdu?=
 =?utf-8?B?c2lWTWVmQ3I5M2wySnRRZndiZTdsSnhIQVNqYnBjMkpDMUlYWlFUZ051cjJh?=
 =?utf-8?B?NFNBZ3B3U1FmNCtwY3ZTWFpsVXJCclozYlc5QlF2MGZlYnlHVlF0NXdtUUN1?=
 =?utf-8?B?UTJ4SFV3clRlVDlkTVhwQ3R1UHllaFhkMXcvNFFjVlNzSk9ZZ05IREt4YVdy?=
 =?utf-8?B?TUNkRXlETk93OG11NEN4bzZzd2M5VkN4UXNaR2V3QWh2T254UmlsQjYwajQx?=
 =?utf-8?B?VjFGcFFJM04vZmU0OW1nL0w3TEZQU2lmbzRFcjdkVmhiTmtqSDN4Z05BU3VF?=
 =?utf-8?B?RjR1dmkzcEZIbGlNU205SWhmbWVmWFcrMXpGaFFnTFZacCtsdmxKbkZMNVpl?=
 =?utf-8?B?QjBRSVlCUVhGNmRlaGpHN2xYNHVKQm9ocWp5KzZIVDFsYkFZSHBvcVVrT3J6?=
 =?utf-8?B?VEd2RWFXQms5NjZzZEhQcnNTcDNZSUNaR1Juck1hd1RBUmFnRkRKVWRaakVJ?=
 =?utf-8?B?Z0hDSmJLT2ZtaUxGL2pwak5PRHJNaUJTeGM0azlabDNnWjdkRFdtUGI5YnBN?=
 =?utf-8?B?ZmFCeld3ZWw0Y3FGc0p2M2JuaHZMSnVZM29mSkgxTHRBOU1nOHBKWVRGMEt0?=
 =?utf-8?B?MEQzUmltRTFsQkttdFFTVjJ3R1JrbytsVXBoYkhYVi81RmtLaXBBOXJpM3RK?=
 =?utf-8?B?TFlpY3RxSFpGYThwQXV1bjNOcWZ3RGdCN1lQVUNBd3VnekRNQzA2WWJpUCtG?=
 =?utf-8?B?dXR0ZytGVE5jYWJ2UzJrWXlTbjZ5YzhaY2x5bHhvcldSVTlHQ3kvYytqaE9X?=
 =?utf-8?B?dTd4azlvRE1EY0NZamJJSGxOTGFtcitQYVRmZDdPdFpzZFE5bHhTTEdKYXNq?=
 =?utf-8?B?MkI2VkpKbGJyZVZQRk5GTW8zUm51VDhqOVk3THowY3pHU2NuSk04NEc4anVv?=
 =?utf-8?B?SElYMERCZ1czdXJPcXEvYm45Tm94eUhzNDExQVV3TE1YYXc5MTRoUUhybFRT?=
 =?utf-8?B?SWxVbCtPOTRaZXN3aTgwRHpYSkhjR1F2OW5JRjYvak5Eb3VPaHdtb21GazFU?=
 =?utf-8?B?d2huS1FOeVZLdXJSd1hiU1hITTExdWtzWUFmclBOZjNQWTdVb2NENElGVG1U?=
 =?utf-8?B?cXJkNjlYbjZ6TCtSOEN1cnpGYzQ4NnpCRTljNlZSbTZKVVBlZ0lYVzQzU2tZ?=
 =?utf-8?B?SWZ6K2NUK2lDMTQzbWV1cUh6TTUxaTU4VExKTlRCVDNRYjQ0V3pOU1dPQnFp?=
 =?utf-8?B?QWxORk5lbHVUNWVrRVh2MkxKRTlVWGxJQ1ZXNEd2SG12Q091OUwyYjM1ZW8x?=
 =?utf-8?B?N1kvNzRlNDhpUkpQUlpyZllYT0JaRTJmYU8rMXgwQi93dmx1cVJUemNqN0hE?=
 =?utf-8?B?L05aZmpqTmZlTjJRS0JtOWIrUXdnUFYxY0tOTXh1b1piT0poYi9yallGMmV2?=
 =?utf-8?B?NDQ3U3ZvcDdzRWpVOENkbE1lc1o0VFRFNW5ScjJjelcyT3JTN1BzQTU4SHUy?=
 =?utf-8?B?U0V3eFRFZkxzR01lUE5JeFE2NStzelFEVEp4czgxSnh2K2dQMytEVDJyNnBk?=
 =?utf-8?B?QUN5d0Y0aUNCYUtEd0poMmpOeHdtRWZWZ0ZSNEdFam9xNGtlZlhLZ0RRd0hZ?=
 =?utf-8?B?UGJWdE9icGNybmpHOWlqVFM1ZkRJY0Mydk5QdDlpTStPM01WZlRUL0c2b3Bp?=
 =?utf-8?B?MzNyMGhQTnNsOW42QUIvVTdZNzdZbnBVL1dJYTRCc2RzQUhjOEpiamhCUXl6?=
 =?utf-8?B?cUZFMUExbTMyZjJQYjVZckQvV1NOZHBzUEZKdnhkUlJHY1N3WHBMNUZrRU1q?=
 =?utf-8?B?aWFwMVYyR1lXWnY0T1VOUEJzNGExQUh4dEQvakJSTlc5enFpbllmeDZMdHdW?=
 =?utf-8?B?dm9WSTg2QkpnSi9rak4rZWdkNGJYdGJ6d2ZVRlAvdGJYZlNveG5FV2h3ZE5D?=
 =?utf-8?B?UXd5VFBYZ3E2ckp3NEo0L3M3V1hvWE9EM0M5NEFxMzYzTHlpeTRpaXlxQ1Nj?=
 =?utf-8?B?N2VuSlFUMit0QmRBTmR6QmZWdkhLd3l2aTBaRU4rSWFvSUJ6Z3o4eFk5MkRT?=
 =?utf-8?B?dTVxMzM1cUJJSlVrREVHWjMxQjZQemVwMWQyZkxPUjN6VW80aDJQT0pyWVdn?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02E9A478A4FE564496AB45B8286BF7FF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f408bf-f2b7-4275-08e4-08db6c2a19aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 16:20:27.7719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DJKLbJgUt5iRn3hxnPwErWmLcWELwqcVBanciq42cJG9xPKZoz/Wo7Akr1DhZGiSdrsRfd6wdeF+nndy/ZPiq8Icw87xnCkZ8kCvbP/JM6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7853
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIzLTA2LTEzIGF0IDEwOjQyICswMzAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiA+IEluIGEgcHJldmlvdXMgcGF0Y2hlcywgcHRlX21rd3JpdGUoKSB3YXMgcmVuYW1lZA0KPiA+
IHB0ZV9ta3dyaXRlX25vdm1hKCkgYW5kDQo+ID4gY2FsbGVycyB0aGF0IGRvbid0IGhhdmUgYSBW
TUEgd2VyZSBjaGFuZ2VkIHRvIHVzZQ0KPiA+IHB0ZV9ta3dyaXRlX25vdm1hKCkuIFNvDQo+IA0K
PiBNYXliZQ0KPiBUaGlzIGlzIHRoZSB0aGlyZCBzdGVwIHNvIHB0ZV9ta3dyaXRlKCkgd2FzIHJl
bmFtZWQgdG8NCj4gcHRlX21rd3JpdGVfbm92bWEoKQ0KPiBhbmQgLi4uDQoNCkhtbSwgeWVhLg0K
DQo+IA0KPiA+IG5vdyBjaGFuZ2UgcHRlX21rd3JpdGUoKSB0byB0YWtlIGEgVk1BIGFuZCBjaGFu
Z2UgdGhlIHJlbWFpbmluZw0KPiA+IGNhbGxlcnMgdG8NCj4gPiBwYXNzIGEgVk1BLiBBcHBseSB0
aGUgc2FtZSBjaGFuZ2VzIGZvciBwbWRfbWt3cml0ZSgpLg0KPiA+IA0KPiA+IE5vIGZ1bmN0aW9u
YWwgY2hhbmdlLg0KPiA+IA0KPiA+IFN1Z2dlc3RlZC1ieTogRGF2aWQgSGlsZGVuYnJhbmQgPGRh
dmlkQHJlZGhhdC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmljayBFZGdlY29tYmUgPHJpY2su
cC5lZGdlY29tYmVAaW50ZWwuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IE1pa2UgUmFwb3BvcnQg
KElCTSkgPHJwcHRAa2VybmVsLm9yZz4NCg0KVGhhbmtzIQ0K
