Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B327BBFF0
	for <lists+linux-arch@lfdr.de>; Fri,  6 Oct 2023 22:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbjJFUBk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Oct 2023 16:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbjJFUBi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Oct 2023 16:01:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076C983;
        Fri,  6 Oct 2023 13:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696622497; x=1728158497;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=w18bicPFsa6muxGkgTV16Ht3yE15FqqvBTrUOmV0dfc=;
  b=HK0Ha5l/GV32WRbGxVR6NXQkG9DIr6Po7NvtSd1WsJvY+LxPc4I20bhT
   F6qbrIZ0gdUFi9HLAsuDpTBOFR7sn5FxnQCKzBAHjsE4uSp1HqPmnmaPB
   KEDxFTwha/Dm0wtHzjPjciLlb7uJor/3EYjmc3S3zHse6nUsZJ+i/LFWc
   PNk2KgoYpwd/wjEvmX4bmbdHiYObVDrt3oqJFnFP1zAaQ/d2TYe512kEx
   9cSv7QYnfpQr08zN+uBePE0gEJRM/icgUbTRG9mJj6NDu0pr9y+UrgAS8
   sM98+E7Eab6IwxwlwU+pz1xFYEk0HRtma8rAoOg1f5wAi3RSeR+xA3S6i
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="383710496"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="383710496"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 13:01:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="842947806"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="842947806"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Oct 2023 13:01:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 13:01:35 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 13:01:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 6 Oct 2023 13:01:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 6 Oct 2023 13:01:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDLREd1fmnJhWqMT+I3tNpL/XXE+IfEwf+CtlaNUhpAw5L/D8ZN4b6n32qSmyCR+Ktsbvr8Tz3kfW7pMYtWBQcEUtbIRc4/J0/CfT7NXmz7aPQA4/+hj6QEt7U1W+L4shGU6Uwt9KJXumLZfiykp1Lng1Ki0CY9qGbvMuZKnITSm0hNEInWajSPHklyou+/SMBM5ox3yu1f5K7khibVho2f5LVjbJQVaEZtH1cmGlIHxi38U80RCdjgBlkh/DrXs94moeit3SGtiBeLscK79N97x0x7AnGsVHjbDdYhAFVCaFUl4EGMhHL/3bjkc1iIsLv3BP4nbw/hSPZg/uccb3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w18bicPFsa6muxGkgTV16Ht3yE15FqqvBTrUOmV0dfc=;
 b=YABE15NdwbB79Pd1NDFGK14mnTv9LUhNb8X/bLBz8kyhF53eDohBLVibU0JusdTPCyhhWKXzLYkwM7tF5dWjwUJdpbL6aSO0Zqua7XD9XEmOJk+G5xm3knVT3F56q28+OsXcpqjjOKJ20M8UdIdwsFu/J+o86Mdp66Qwh2Q6VxeVh/QzVCPIBU69f/sdnUw9Rsj1Kbvd4F1m7ce2GXYT4j4xQAzVQ6CwESWMik7sQTLWfAGcei5YNeBcnsW7CswsF9uMeBOrgz8uo8KXgIfT5q/avdr3vphTGLK4bzY3kKvGCCNKL2fmG64WgK3yZRuVRj4G9zeURvf1SLICVEBtnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA3PR11MB7655.namprd11.prod.outlook.com (2603:10b6:806:307::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.24; Fri, 6 Oct
 2023 20:01:31 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::56f1:507b:133e:57cf]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::56f1:507b:133e:57cf%5]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 20:01:31 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Mehta, Sohil" <sohil.mehta@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
CC:     "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "deller@gmx.de" <deller@gmx.de>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
        "irogers@google.com" <irogers@google.com>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "chris@zankel.net" <chris@zankel.net>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "x86@kernel.org" <x86@kernel.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
        "ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>,
        "bp@alien8.de" <bp@alien8.de>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
        "will@kernel.org" <will@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "mattst88@gmail.com" <mattst88@gmail.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "slyich@gmail.com" <slyich@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "rmclure@linux.ibm.com" <rmclure@linux.ibm.com>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "svens@linux.ibm.com" <svens@linux.ibm.com>,
        "dalias@libc.org" <dalias@libc.org>,
        "schwab@linux-m68k.org" <schwab@linux-m68k.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v2] arch: Reserve map_shadow_stack() syscall number for
 all architectures
Thread-Topic: [PATCH v2] arch: Reserve map_shadow_stack() syscall number for
 all architectures
Thread-Index: AQHZ5z2WzPjTzalN7Ei06VoIKvvJZ7A4YMaAgAAFboCAAAaGAIAE5JYA
Date:   Fri, 6 Oct 2023 20:01:31 +0000
Message-ID: <3bd9a85c6f10279af6372cf17064978ad38c18b3.camel@intel.com>
References: <20230914185804.2000497-1-sohil.mehta@intel.com>
         <487836fc-7c9f-2662-66a4-fa5e3829cf6b@intel.com>
         <231994b0-ca11-4347-8d93-ce66fdbe3d25@app.fastmail.com>
         <622b95d8-f8ad-5bd4-0145-d6aed2e3c07d@intel.com>
In-Reply-To: <622b95d8-f8ad-5bd4-0145-d6aed2e3c07d@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA3PR11MB7655:EE_
x-ms-office365-filtering-correlation-id: b2d26037-faf1-48cc-8352-08dbc6a708bb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jaX1Pd6ew70OEJ8SnmQTMbzU9crA0n7TyQtG7/s7zq10nJhRlgLbrqT0kTBhRbQs0DeG5Q2OUSC1sf5Zc9kZagmBl3/eL0BiVJSjjeG85LNAZYY3wxlXvlRe0wRukh6SeX7+N3xukFsa03O/SM8F0Demp1Z6QT9JeVL5ENgdlRhKdenh3mewROtbcUsS/etkIpw74dcp7e+8xImLOqUgmUmTGSq5PKoA/qlKVqGIBfjn6w6bqIR61kxRga5h3hQhQDnTfaO4SINf4Qn7y+OyimJ9JsyICSus1F+IOQfSCiL0KMKRJrrTHs6KEN7uvKYMKZZSxrCF2fNilvF7IMm2A8usqSZ1Ace1XLwD3TribKZPdRqHO9H/rpK/mzApDcPgN1Ixl0s0T9MH5bWvQoYsft1wTHdBYCxJXNYGLg3w99Bck/0S5QMiQVAeEr2sBKe+RjVKL9rMyIb1DB1tVHUcTHDpIU7Bd+LczGtIBhByVdbxiojQ7my5E07ystRhjWZ6332/bFlwHpQNKHQq4qToCTOvvWwNmJ/b9nuCyxfZN4OP6dZGnd1KUh5iPwWqFCcV8lYaq5IhemEgiP/PwHsgIGOP5vMcy/AnKzrncxauXVNcFLWX0Fe4ReD7fOA2v1yD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(8936002)(2616005)(66946007)(54906003)(66446008)(66476007)(66556008)(64756008)(316002)(41300700001)(6506007)(86362001)(6512007)(26005)(36756003)(71200400001)(6486002)(38100700002)(82960400001)(122000001)(478600001)(76116006)(110136005)(91956017)(4744005)(7366002)(7416002)(7406005)(38070700005)(2906002)(4326008)(5660300002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDNCTDcvd3F5djFlaDY3QTQzVDU0Y2Z0VXZ2aGlpTFpla01XU2Q2YnA0MEhj?=
 =?utf-8?B?bi93bUtpZUlEVDVZR0ZGTmJ1bS9BNE8xcm9vbmtRQmtwb0taQmhQclFkbEV4?=
 =?utf-8?B?UUNtaURuUGFFZ2JjeFJJMyswc1VXckJiRlZ0WFVYTkd0c1hWZmZuVm1QdWNZ?=
 =?utf-8?B?NnhMYjlTZzRXcTN5VVg3RFNFWkd2ZkdJR2lya0lZMmMwbXJ5MXZkTnc1d2Y4?=
 =?utf-8?B?NjhvYmlVc0NxMlo4M2VFL010d1psdEVpclJNV0JUdXgvUVQ1bUZCbit5MkRx?=
 =?utf-8?B?UjE4alpMYU1xTlZsMjVOSFBOcWVWZE91TjVsRzZpTmlVV0JSK25MS3JXYzFs?=
 =?utf-8?B?TWRSUUpYM0p0ZklrNFJFNGhxRFR3a3ZnNnRxL0JFMjFad1J2bEY3VEduVnVo?=
 =?utf-8?B?YnlSQnYyaGxHanBnQlVZN1o0MlpuYlpGZExMNE5YM0lzQjlvNnI5VHIydldy?=
 =?utf-8?B?RGFhZ2pRUy92QTl4MnBtYXE2czFDcEZEeVd0dW1QNDJreUZ5TjB5cjRlZ2FV?=
 =?utf-8?B?NlRJMUpCb3NybFRZcjI4MFFhS0dXVmpBclFTeG1kdTVMQlpOTmNmZk9lYmRl?=
 =?utf-8?B?K3pPdkl0cmJCVHNWbGtBYm9TZ24vNFZRVVMwYmlmeWVaYmZsekN1ZDZIeENt?=
 =?utf-8?B?YWJEZkVPbm5rYVVFdTJBR05IenYvakVZdFArY1J1WWRJWW84d1lqS29QVkwr?=
 =?utf-8?B?RWMxa0MrTjZTMEpJVkw2cGFBRGVmWS9TTEhHaFp2TXMvRmZpekwvOUFoWGpM?=
 =?utf-8?B?OEFJMGFRWktodXlpdnRqNU8wOHI1YlRNRTA2RG1CYnBsQWpqSkhobk95Rkpi?=
 =?utf-8?B?eWg1U29vbWdvZXFCZjVDSzNKRmtBd3U5dXp1NDV6cE8zVTBocm82VitZSW5n?=
 =?utf-8?B?L01PZlM4RzVWWmkvUUFxZWoveGo0Uk10VnRlWmJiR1lGQ2FXbThIdHJIRUF1?=
 =?utf-8?B?M1FRWEV5UkE2cWRsQTZBSDRjR1g5M0lSWEJnTUxwd0NMM0ZGOVJ1bnBYaFNQ?=
 =?utf-8?B?SWNXNHplYjhFNnFESURKSlNvVGlVcW1BRmUwSzRJL1V1SCtuUDVtMlZ4bFBK?=
 =?utf-8?B?NWh3VG9PaWJybGUyd1NIelR2c3BHWXVwNGRPZFB4UzR5SllyK2dneW9mTlk5?=
 =?utf-8?B?QS9XbFNjQlUwMnJMMWFsckFvbFhoWURxN0ZBc1JFUHUvbWZUYmw5TXVyZFN6?=
 =?utf-8?B?b0V3OXNTdmkweEIvdWx2YTF4NHIyYVJYWDA4ZEwzdmJiNm5LK0xRSDJucEdF?=
 =?utf-8?B?RkpyU2lxdzhPc3krZTZhSkhzdVhJdkFQWHNGM1RFMVM0Y3BpSWQxTmpsQ21a?=
 =?utf-8?B?eTNieU90emk3L1FDdjgraUR1akNnWHorOHd4V25TRWFBRWY1WUc1Z3FndVNU?=
 =?utf-8?B?TEpPeDduYWM0c3FvTDQ3STYvdEd3dVd0WlRSVlI5UkpKUFhFY1RVWElIcXJH?=
 =?utf-8?B?eWRuOCtNSWJSSVRlU0NOSk1oUlRoaWpFRWgwVjYzNlAwWk0zSFlSdGxoMTFS?=
 =?utf-8?B?b0lVanpyUTV0L09POHJlRnREZlJmQ1hNeE94ekNvUC81Q1prYUZSMTlnZnpN?=
 =?utf-8?B?dVNzRUV5UnAxS0g3K0doaGJoMzNMTWVERlNLMlB6WXNjcDBvK3Zmc0w4eloy?=
 =?utf-8?B?SUsrYy91TVdzV2ZQN3gyK25DN3NkTUVBOW1SNVEwZHNJR0h6NFJLZVdhSFdE?=
 =?utf-8?B?Y05ZcEhWa3JNbGY2VThFTGV2V2JWRm8rakdFMUJqbEpGWXFjRWhuVXZiNzBN?=
 =?utf-8?B?b3ZhKzNrNHVwdDJHNS9UYkFLWTJhYjl3WjBSbng0UUdyUXRUSWp4VlllcFgy?=
 =?utf-8?B?Skl6SUQ5czhzQzZNclhKSXBCNDRkWGpmZFlCWm1uM2ozNnpQdmJSa0NSRXAw?=
 =?utf-8?B?bUVSOHRZS2Q0d2Fuai9mYjh1akljc3JlYjlLbUwyTnhMamJTcDNETU5wS0VQ?=
 =?utf-8?B?dEg1ZDNFZFV0T0RhOUpadmw4R2s2Q05URzVWdGpMb2RnbGRMakVjL0dhbmxM?=
 =?utf-8?B?RllsZEZjbnlLVGZZU3JNU0owbVJ2WTVpdFp6dE1HbGZxb3pqdmR6YkZ0UWow?=
 =?utf-8?B?ZllzckNyMEVMTXVnOUFnd1hEZnlGREg3VlgyZCt6ZlZmMVNBUzFqdWdFR0d6?=
 =?utf-8?B?QlBRemJHVnJibkZLZ0crVk9obmNvQ1ZDQ1NxUVFVMU1QNFV2SldkdG53bG1r?=
 =?utf-8?B?b3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C2B3A20E2357943B9266903966FAF59@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d26037-faf1-48cc-8352-08dbc6a708bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 20:01:31.1308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y+a1VFJnoIQj7e9E6vA7aNpD9bLEnNFQ9SCLb2RbHpQ+n+fwWkFOHk4aPyQw6o99d0pByBmjyl6/DnKmvIfacs1wG89qpEjTdZ0PYDilOxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7655
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIzLTEwLTAzIGF0IDEwOjE4IC0wNzAwLCBTb2hpbCBNZWh0YSB3cm90ZToNCj4g
PiBJZiB5b3UgbGlrZSwgSSBjYW4gcGljayB0aGlzIHVwIGZvciA2LjcgdGhyb3VnaCB0aGUgYXNt
LWdlbmVyaWMNCj4gPiB0cmVlLiBJZiB5b3UgdGhpbmsgdGhpcyBzaG91bGQgYmUgcGFydCBvZiA2
LjYsIEkgd291bGQgc3VnZ2VzdA0KPiA+IHRvIG1lcmdlIGl0IHRocm91Z2ggdGhlIHRyZWUgdGhh
dCBvcmlnaW5hbGx5IGNvbnRhaW5lZCB0aGUNCj4gPiBzeXNjYWxsIGNvZGUuDQo+ID4gDQo+IA0K
PiBEYXZlLCBJbmdvLCB3b3VsZCB5b3UgcHJlZmVyIHRvIHRha2UgdGhpcyBwYXRjaCB0aHJvdWdo
IDYuNiBvciBkZWZlcg0KPiBpdA0KPiB1bnRpbCA2Ljc/DQo+IA0KPiBJdCdzIG5vdCBuZWNlc3Nh
cmlseSBhIGZpeCBidXQgaXQgZG9lcyBoZWxwIGZpbmlzaCB1cCB0aGUgc2hzdGsNCj4gc3lzY2Fs
bA0KPiBhZGRlZCB3aXRoIDYuNi4gQWxzbywgaXQgbWlnaHQgaGVscCByZWR1Y2Ugc29tZSBtZXJn
ZSBjb25mbGljdHMgbGF0ZXINCj4gaWYNCj4gbmV3ZXIgc3lzY2FsbHMgYXJlIGJlaW5nIGFkZGVk
IGR1cmluZyB0aGUgNi43IHdpbmRvdy4NCg0KSGkgQXJuZCwNCg0KSXQgZG9lc24ndCBsb29rIGxp
a2UgYW55b25lIGlzIHBvdW5jaW5nIG9uIHRoZSBzeXNjYWxsIG51bWJlciBpbiBsaW51eC0NCm5l
eHQgY3VycmVudGx5LiBJdCBtaWdodCBiZSBuaWNlIHRvIGhhdmUgdGhpcyBwYXRjaCBnbyB0aHJv
dWdoIGxpbnV4LQ0KbmV4dCBzaW5jZSBpdCB0b3VjaGVzIHNvIG1hbnkgYXJjaGl0ZWN0dXJlcy4g
QW5kIGl0IHNvdW5kcyBsaWtlIHg4Ng0KZm9sayBhcmUgb2sgd2l0aCB0aGlzLCBzbyBpZiB5b3Ug
Y291bGQgcGljayBpdCB1cCBmb3IgNi43IHRoYXQgd291bGQgYmUNCmdyZWF0LiBUaGFua3MhDQo=
