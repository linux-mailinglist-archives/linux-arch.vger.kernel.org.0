Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DA57A1087
	for <lists+linux-arch@lfdr.de>; Fri, 15 Sep 2023 00:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjINWIR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 18:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjINWIQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 18:08:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441B52120;
        Thu, 14 Sep 2023 15:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694729292; x=1726265292;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4MQ0NFjV9NYa1jFLDiTaIVGNVtK641lyfxxe9rvVVls=;
  b=XhgjqOOMWmlr+1JzeFtfdphdQgp+1ueEOwZrzwLihctEV3cuMiT2p/S/
   kZrGK0GXq+MPsVbR21NAizIqVca18cjSNYt7TL7gFLEmj/HUfiMxBqHGs
   MeMt4RwAJd+jR+LdoNp2JOfVaSOd5wE6QDhEjm13v9IM/TAXiqFXExJnv
   tnfKWtsfVGduUqtitutolBKCksubMLoz/C8R0SViwhYbslZFDK8l8R11V
   ZJZJPjnK4NmVORl6TBDQ1DCHouso9/aeQEJ9BZkfsi2LNy73G4xaXi8IG
   QCOMTQc5SzeAVc9Ylj3jvhjlmJkM/UMvnWps6hh543LKnEZLgcBKFAXLl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="378000830"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="378000830"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 15:08:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="774047856"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="774047856"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 15:08:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 15:08:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 15:08:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 15:08:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPffQUMSRU4er3jn0fHk+DVH2aGGqc0E5ajzOOuqBxnD9TzDEqU8GjLRjNxQONQpAxhU1LGMC9rrrkrmhQo/YZBk03f1fZhhr89vit0G98ZbtT8P7T1TGc6NS5V78ni1NOr7RS8HFqEmH6VUvzRL1oTeP6rHTKVUSJGmYAYwj5Rj8z4IevCEaVtx3CAKJneaCaI2CceSs1gHmA078E9xz3jB6WdjsCvcCzFeXFGc0PyuiMJYe6uC8ysbpPwErESQJdDjaFcNBmuXRnQ/YdTWjDjSHzvWkMgMkxRQoz7i4+V5WhrvtZB5DOVpEKEKEftfLXnoyx9HxJmBP2p0r58bnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MQ0NFjV9NYa1jFLDiTaIVGNVtK641lyfxxe9rvVVls=;
 b=MfMPbIsNvPgLCEzxpNNSjJqpn0CEQE0Pse9s2vN+ftHwdpl8o6x20E8P2rjRBGt+t66J5htz2KC0kOwv0mQQjnLng3QJb6SVSbacTi2VNVHYpxTGJ8QaZEIE6inHjyOcXp29113uaKjZAFRGPnCn5ukWUOS4/ObR3cPxrz3WHEgLpjdI0OHz0QKa4eXnCjUX+pCP3OuTRCCMO6FzeBC4KJnH3EXH1seBRwhpbxD8IxuWOyznkgF0U2B7e446Hnsc2Tv4XeMvFshajSjx8R3czCa7ywN/sO080ILAN5Vf1J9GrYmJ2wCna9Emf5i0gqXFjSRKBmviwlMrSVX2gDF6Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA1PR11MB6147.namprd11.prod.outlook.com (2603:10b6:208:3ed::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Thu, 14 Sep
 2023 22:08:05 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::56f1:507b:133e:57cf]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::56f1:507b:133e:57cf%4]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 22:08:05 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Mehta, Sohil" <sohil.mehta@intel.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
CC:     "svens@linux.ibm.com" <svens@linux.ibm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "schwab@linux-m68k.org" <schwab@linux-m68k.org>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "dalias@libc.org" <dalias@libc.org>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>,
        "deller@gmx.de" <deller@gmx.de>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "rmclure@linux.ibm.com" <rmclure@linux.ibm.com>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
        "slyich@gmail.com" <slyich@gmail.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "chris@zankel.net" <chris@zankel.net>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "mattst88@gmail.com" <mattst88@gmail.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
        "irogers@google.com" <irogers@google.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH v2] arch: Reserve map_shadow_stack() syscall number for
 all architectures
Thread-Topic: [PATCH v2] arch: Reserve map_shadow_stack() syscall number for
 all architectures
Thread-Index: AQHZ5z2WzPjTzalN7Ei06VoIKvvJZ7Aa4WIA
Date:   Thu, 14 Sep 2023 22:08:05 +0000
Message-ID: <731438883ae3bcffa05ff014dda773a6c1e3c899.camel@intel.com>
References: <20230914185804.2000497-1-sohil.mehta@intel.com>
In-Reply-To: <20230914185804.2000497-1-sohil.mehta@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA1PR11MB6147:EE_
x-ms-office365-filtering-correlation-id: 3d3691fd-5bf0-4ad2-64a5-08dbb56f1230
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DwNkwK6D9+kE+r8pWdCcl2okA3AsmvVX68OpGeJE2yv+elLjK5y7fY7j/+KF4OmykYflSU/bAvgYk894XarnoqT9DFugGBPMEDlDSsJdQ4sAjJBicqvTWXWNY2i9l1etqrIGZC1hSZF8cyGuqOWq8VryzRDA8m7L6rtNpNCBDxGWxoT8melVbFgtkfNJyJ/KY6qZeo3+t9w9Ua1YgQeNUN1tCWUJDT28mE77IWAg7utDzDZjdLTavTrHe3H4bQMD77BHQSg4S1dW99Vu1ChbJmkTTJGdZpX9DzrW+/DBm1xf69/QFalNWzsFir7+/AbeTQKnXMcAgtiYtx4a5EQlLGh/QZfR+cU1Fzahw7/OSHLsT5AJn96lvSpqC+0MuRQJRVc+HPcsVm/qubPsKydU+i9Smwy5b+G6i+GxU288LTKvslg0Pc5bKtLIgUuu7oawHke3UNnjzY/Ru2mQzSE6zGR8jEDUi35bUts1fYYVGS80d6PfgcX+KMVNPAFhOBFcPgHzG9aegfTCDAub4Ru45CCY/2y7KDIwaWyT7SSESPnoUu/pKFN/hxtbTC447P/SydxhFnkeKeP/PToPQOhE/OH6FSDDrLdbcPMxz5WkUrTi2APFk2YeBkQK1Qt2CqrP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39860400002)(346002)(366004)(186009)(1800799009)(451199024)(66556008)(7416002)(41300700001)(71200400001)(316002)(2906002)(54906003)(6506007)(76116006)(110136005)(478600001)(6486002)(64756008)(26005)(6512007)(2616005)(66946007)(66476007)(66446008)(91956017)(7406005)(7366002)(38100700002)(36756003)(4326008)(8676002)(86362001)(8936002)(38070700005)(122000001)(83380400001)(5660300002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b05wbFpmL3JuVFJWWjRBbjg2bmVzbXVSQUJKdCtsSUFRY2xwa0JDZk4rYTJk?=
 =?utf-8?B?eW9mUzV5TE40QWovZVNGN1Fsd3FUVUhSSWRLQ1M5SWgzajRjcDVYZjdNNERo?=
 =?utf-8?B?NlQ0WTd6RENaSEZ6eTk2WDU0bjFVWlhYSEhzV0NCVG91bmVCLzNqb0IvNlVu?=
 =?utf-8?B?L2ErMGNNak5qN3RPZ1I5WEN2ZmxPSHNtYzQ0QU5DckdpVWkwSjBrc0NxNEkv?=
 =?utf-8?B?aG5SZGttOXUra09BWGZTRzRvR3ZnSWJ1SkQzK0t2NHlMZUZJQTJlS0tDUXB2?=
 =?utf-8?B?T1hVZ2ptemFHbVVnS0RSYnBUbzN4NjR1M3dYbTRrUzBybFNRVmFpek90M0wz?=
 =?utf-8?B?YTdWVXg5YTBXZ25ITkxqSTdBTjlYaVBPcGdnYW94eXcrL3VOb2RYTkhOcTdv?=
 =?utf-8?B?SlI2Um1zZS9kQ01za3NONlBEOFNmbXBUNlVGSjZXNUFzeUk1M3NpWEpYNTlV?=
 =?utf-8?B?MlJCRzl2Tytkem1lNXdITmFMcDR1eEhvQlNiMzhmTnNJclc3c2x3KzcybHRo?=
 =?utf-8?B?KzBSODhHNUYxTlJOZDZWS0RzaVJYL2taSUp6cnhJRVk5OGdHRWVpY241Tyt6?=
 =?utf-8?B?b3NJazdYOVp0TEJFQ0crdm9HWU82eHdkUmZxK2c4ZGtjejRyKzJZWU5LUXRY?=
 =?utf-8?B?RVh4eTB5OEVoaklsRkI0aTFSckE3SVMrV2h0MElJUis0YXVmWkRvcFp5TnlH?=
 =?utf-8?B?dXJpeHN1ZmkxZ2ExdGc1dU9NOEhXWmJTSFRZem8xd1pCS0FhdlNyTFJqbjQz?=
 =?utf-8?B?cTJESTNWZitaTUZROGtDK2VyeEg5by9YNmRGYWt5c3ZBNWEreWppUTBnUUw4?=
 =?utf-8?B?c1ZnVVZqSmpWN3k4SkkzaHB5cHliaVhpci9ESzhPVXZmZEVrOHN6Vy85VUNn?=
 =?utf-8?B?S3duNXV0UjFjOHEyazRXQnRRTy9PRkRiWEdhTWVhaWpWV1NMV3FXRlBobUYw?=
 =?utf-8?B?ZHJaTCt5emRCWjRLVDVqdDFJZ3N1VVZ0SkJFbGxsNUxKZFFFTXk1TkJhZnU0?=
 =?utf-8?B?ZXI3QXdtZzViMHRYN2tLYStCSnd3R21mciswa1Fra0d0WFZKelR1Q2grVkNi?=
 =?utf-8?B?SEVIbm9jb0xHV3A3ZXNVMWR1QWVHdEZhMis5d2hqVS8wS1RiWnNWNzltUm52?=
 =?utf-8?B?aFFWOHB0SEVON1hjdXFlcm8yVmJ2MDJxcHYrQURvTjdEMEhCblpZeG9TNUZK?=
 =?utf-8?B?ZUJUNS9BRzQ1TElidzZNOXVCazJRbEl5ckwzWWJPRnNBNERwVU1qN2VDMno2?=
 =?utf-8?B?ZDVEUHA2WU1Ma2YrcjNPRTVoUXhXTG9CZzBHY0g3REVtTTl2bWFpMWxjTE5B?=
 =?utf-8?B?OXhVbVo1UEhFVUxwenRUSERZN0QzUXlWS0pFblFtcml5MGp5K2NId00xdU8w?=
 =?utf-8?B?TWNtN0dCemNOUmdlMi9TdFdlRTRjc1FqN3Mzb0MrT0ZHaXRuTEhZalhSS3lP?=
 =?utf-8?B?OWZINkY5UUs2d3Q3Ui9PUlJhdFdmbzluZlYxNG1qbUZ0eExUQzduS1FlZExG?=
 =?utf-8?B?MGkxc1h0anZPQ3FHMUhLb0JHeTRjbzdEMmYxbkd2ZnA1ZTFLUzRsN3ZIR2J0?=
 =?utf-8?B?U21vWjlNL3oweUpJSHRCdkVIWWY2aUtEVmdhaVh2Q3N2L2pzeVprVXdheExu?=
 =?utf-8?B?NmVFRjNLMEwrbmdRR1RtVkhwU3JGMS85Y3BTV3RxdU5iajZ1dHpyZUZpS2Vj?=
 =?utf-8?B?Y0o2dTgrcFZCU29IUjBTRWlGRThYRmR0ZGtFUU1WODlPWW5MSzRqK1BCVzFB?=
 =?utf-8?B?a0NsemRGc25HTDVMQlREcnlMU01xSXVYdCsyWjI4RWtsSE5Pd01lelZoZUI4?=
 =?utf-8?B?STNtNk94T1pNSWxGZ0RRM285VUt1ajFqNGdocW11aUJ1QnRVRHV0RTNoZU14?=
 =?utf-8?B?RWZkdXhjQUh0YjRhd0I3YjRWd2FCNE54ekFwYnBTN0xUOEhFbWRja1RDT2tQ?=
 =?utf-8?B?NzZtRXE2OFY4N096UlF2MkxvQUI3am5IaUxGZkt2NElsTmZCY0Z5NitSVVh2?=
 =?utf-8?B?aXVmbXZKeUFJRDgrWEg5WnhOQ1lVSXViMUZ2U25uVis1VUFJdWYvN3J1azNP?=
 =?utf-8?B?YzFPTjM0Y1N3RHpVUXhpWnFGNkl6S3QyQTVPeDJiUU90UnNGcWJOS2gwSmhF?=
 =?utf-8?B?d21Mdld4MlF1UUZqN0h0N0Z3Q21IdVJtcnBKaU5sbElvZmxzM1pZL0NOLy9n?=
 =?utf-8?B?Tmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7633A60F63F7EA45A97D863E0C94E7B5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3691fd-5bf0-4ad2-64a5-08dbb56f1230
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 22:08:05.3603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5JfB67oO5FoQ7xXDp1alzV7KWsaUJxtt1RGpyjxYq6TGBdE2YWtdMzXSWzJD/QpPzWUEmVkFoPr4lkES4c/9/vAX6xSfrdeHkBJ663t+X4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6147
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIzLTA5LTE0IGF0IDE4OjU4ICswMDAwLCBTb2hpbCBNZWh0YSB3cm90ZToNCj4g
Y29tbWl0IGMzNTU1OWY5NGViYyAoIng4Ni9zaHN0azogSW50cm9kdWNlIG1hcF9zaGFkb3dfc3Rh
Y2sgc3lzY2FsbCIpDQo+IHJlY2VudGx5IGFkZGVkIHN1cHBvcnQgZm9yIG1hcF9zaGFkb3dfc3Rh
Y2soKSBidXQgaXQgaXMgbGltaXRlZCB0bw0KPiB4ODYNCj4gb25seSBmb3Igbm93LiBUaGVyZSBp
cyBhIHBvc3NpYmlsaXR5IHRoYXQgb3RoZXIgYXJjaGl0ZWN0dXJlcw0KPiAobmFtZWx5LA0KPiBh
cm02NCBhbmQgUklTQy1WKSwgdGhhdCBhcmUgaW1wbGVtZW50aW5nIGVxdWl2YWxlbnQgc3VwcG9y
dCBmb3INCj4gc2hhZG93DQo+IHN0YWNrcywgbWlnaHQgbmVlZCB0byBhZGQgc3VwcG9ydCBmb3Ig
aXQuDQo+IA0KPiBJbmRlcGVuZGVudCBvZiB0aGF0LCByZXNlcnZpbmcgYXJjaC1zcGVjaWZpYyBz
eXNjYWxsIG51bWJlcnMgaW4gdGhlDQo+IHN5c2NhbGwgdGFibGVzIG9mIGFsbCBhcmNoaXRlY3R1
cmVzIGlzIGdvb2QgcHJhY3RpY2UgYW5kIHdvdWxkIGhlbHANCj4gYXZvaWQgZnV0dXJlIGNvbmZs
aWN0cy4gbWFwX3NoYWRvd19zdGFjaygpIGlzIG1hcmtlZCBhcyBhIGNvbmRpdGlvbmFsDQo+IHN5
c2NhbGwgaW4gc3lzX25pLmMuIEFkZGluZyBpdCB0byB0aGUgc3lzY2FsbCB0YWJsZXMgb2Ygb3Ro
ZXINCj4gYXJjaGl0ZWN0dXJlcyBpcyBoYXJtbGVzcyBhbmQgd291bGQgcmV0dXJuIEVOT1NZUyB3
aGVuIGV4ZXJjaXNlZC4NCj4gDQo+IE5vdGUsIG1hcF9zaGFkb3dfc3RhY2soKSB3YXMgYXNzaWdu
ZWQgIzQ1MyBkdXJpbmcgdGhlIG1lcmdlIHByb2Nlc3MNCj4gc2luY2UgIzQ1MiB3YXMgdGFrZW4g
YnkgZmNobW9kYXQyKCkuDQo+IA0KPiBGb3IgUG93ZXJwYywgbWFwIGl0IHRvIHN5c19uaV9zeXNj
YWxsKCkgYXMgaXMgdGhlIG5vcm0gZm9yIFBvd2VycGMNCj4gc3lzY2FsbCB0YWJsZXMuDQo+IA0K
PiBGb3IgQWxwaGEsIG1hcF9zaGFkb3dfc3RhY2soKSB0YWtlcyB1cCAjNTYzIGFzIEFscGhhIHN0
aWxsIGRpdmVyZ2VzDQo+IGZyb20NCj4gdGhlIGNvbW1vbiBzeXNjYWxsIG51bWJlcmluZyBzeXN0
ZW0gaW4gdGhlIG90aGVyIGFyY2hpdGVjdHVyZXMuDQoNClJldmlld2VkLWJ5OiBSaWNrIEVkZ2Vj
b21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQo=
