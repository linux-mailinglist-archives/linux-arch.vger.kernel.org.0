Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50A079F49C
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 00:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjIMWFl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Sep 2023 18:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjIMWFk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Sep 2023 18:05:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C2A173A;
        Wed, 13 Sep 2023 15:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694642736; x=1726178736;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=s+6sAo4gG60eAhwsX/qXmJFoWFy3s62o4HqZz41EHO0=;
  b=dYfRK4mJ2axIUOznf11JTco0i0H6pwyr+FnbiFWYzTIlOxTanme/k13w
   vn2czRcsJ7XvJqjCEL5bYulH5OLB4spynlDa/WzBG5UgXp1qxZmniRCZo
   bmn/6Cec4Va6NSMPlGnKbS9li9uda4/vo+Mjt0+oXNv58drYsB8Hvof/K
   gmb5+Xx2H7K+BAD5UnuWZ1nwjwGf5z8tKXBYvNvdJtXRsrAHizi8LK//7
   PankX5AW8CllnKQLdQGZ3kpxLKu43tbjE4kNXOGawtjOrUiHkbl/pwEV9
   +LJaQtkwjl/LGbuQwJAU1UY7ykjbkTf8/YyiRuguLbzTe9JwhMqLipCm7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="442821575"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="442821575"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 15:05:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="991131860"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="991131860"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2023 15:05:31 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 15:05:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 15:05:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 15:05:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aejsEha6w2mWr3h7um3cj1+fu9rNF18pxhcmONOKOVDHLuKenr4zkbv6IOtnvGBp1coseDU6/DQ4k+8O6OUSjEkxRf9h5gORjJgOWNdhzI8kbaNMsOl+XSs3MVcnFuVIVfsImXmVaqDePOOrQK/H+pmJNuN1tq1YlHO7hDfJFMAPWhxIN8rUPSqVJ+vzM6llM9SI3zF8yct7vzLm8/NzZvbGIinWWdzm9F65pegKKlcOkjrjhrBpRaV4lDHEHpcWRTurd35TMBK5Kb4DSuUgt+344zjEDVA2u2xFpq2gYnkhKrpi1ToxECwqNQgJpTBSjVHjBEkInFXKOpvvHZKUww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+6sAo4gG60eAhwsX/qXmJFoWFy3s62o4HqZz41EHO0=;
 b=IABAcaDura1ZQb+K+GncbxKiJihOL7VshkIfamunMM+SY2EbyHMIzqRbKcRnOPXvdKsUwPNM8buBDt7d4EhW0m1TIri3AV91e2yL3zh+aU/+CHawSzmi8rYAsevhSkP77Tyk+HFTDzkp9E2N/s/UupiTISeGNfRPP5r5nJqvD7RDW7bWWpxAoDq+LrsLgyMiaFoFsUys0XSSV0FUlg1jscKYquuvxddFbD7A24I+5FKDDoq2Q541nXAdw4Y8Etuurc9I87vUJWwHKuIzJQsJ0DsqYHn00C4AeD689l1pTpFo+/kDrTvzgcHFN9mwYe+oAd3ockBxjCm+Uwwl71WGQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH0PR11MB5579.namprd11.prod.outlook.com (2603:10b6:510:e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Wed, 13 Sep
 2023 22:05:27 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::56f1:507b:133e:57cf]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::56f1:507b:133e:57cf%4]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 22:05:27 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Mehta, Sohil" <sohil.mehta@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
        "dalias@libc.org" <dalias@libc.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
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
        "broonie@kernel.org" <broonie@kernel.org>,
        "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
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
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "mattst88@gmail.com" <mattst88@gmail.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
        "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
        "irogers@google.com" <irogers@google.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH 2/2] arch: Reserve map_shadow_stack() syscall number for
 all architectures
Thread-Topic: [PATCH 2/2] arch: Reserve map_shadow_stack() syscall number for
 all architectures
Thread-Index: AQHZ5NpRkTepLBjCJE2MYA1Hq+GzELAWHwiAgAMFaQCAAC6mAA==
Date:   Wed, 13 Sep 2023 22:05:27 +0000
Message-ID: <a7238521c6f2caee4d76b58fafa60f133cf08041.camel@intel.com>
References: <20230911180210.1060504-1-sohil.mehta@intel.com>
         <20230911180210.1060504-3-sohil.mehta@intel.com>
         <8b7106881fa227a64b4e951c6b9240a7126ac4a2.camel@intel.com>
         <29da2af0-5c88-f937-a9b6-db2d5f481321@intel.com>
In-Reply-To: <29da2af0-5c88-f937-a9b6-db2d5f481321@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH0PR11MB5579:EE_
x-ms-office365-filtering-correlation-id: 4cd6c7a7-0085-4832-da09-08dbb4a5898b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S3SRYtpibv/fctCvyQ63lkU0gsMez7XDhMXJwTjFN0ie671pDeWdIoeYprlKQJUwGc7FdpHWYMtt2ZMecXp9PPGRGHLEQLBV0pOWpuck9cDMP9oxHZFJ+sldrnJPVSDXydEJHP2Uv1BpCIenFBHogWSJR+XsWSSZ9bW/0NLfS2zGy+4Yz8GVvAFVzINGh9koAIunvvILOYSNa6EwgHq2FbgI2vZEILIx2yZzFpS7S1nC+hdTc/uXJFXn3MRsdsYCgO2mbxjLQt0Bri9XckJDZzvhplwFxQpbHZ6DgJA+/KCPE4cnXtmRgTmGU4hvkGO9KW3ZWHtIfC1X4VROS1TkRsp+5FeR1slUV2+QLUOa8Pzn+XrY4N5IDZS4sXSfMhPXiIw9u6B/IsR8Ch9PRDCpJuw0mrAeXErOsUTn0/ch7Rlp1+flinamJpQO3htvXw5K8f2jDID2hnQLu7M1bLKghlhx1iqwBOm4FNa0YfT0V/Kwr1A0WWrpUJvC3biLL0W+hd87+zb31kQWM7ZifVuskmGXLocUWH32VMgtEisTA816aDxVsfNr7GfsO3zV52DUEdZbh4y6RY8pkuHw/fUXQr/CnxLrBRWZIAimo1yoKfhazdG9ukKvduzhUreNmhoN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(346002)(136003)(1800799009)(451199024)(186009)(8936002)(4326008)(5660300002)(2616005)(8676002)(6512007)(6486002)(53546011)(71200400001)(6506007)(26005)(83380400001)(82960400001)(478600001)(122000001)(76116006)(316002)(66446008)(91956017)(41300700001)(66476007)(64756008)(54906003)(66556008)(110136005)(66946007)(86362001)(36756003)(2906002)(38070700005)(38100700002)(7416002)(7366002)(7406005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajh4L2Ezb0w2VnpUWUVUcUFwakFoLzhBZDBvMjhnL3RSTnJoWmllQ1ZGcHo4?=
 =?utf-8?B?QW5jMkN4Uy94UWhvSkovVm9KMVoyaGwyRXRlQS81Q2RETWs0WTBENEFrQ21P?=
 =?utf-8?B?UDc5c2lWZjRSdzE3TU80N1lsaVhNbkxlS1BJcVJmbkNjN0FwNk9leE5MU29I?=
 =?utf-8?B?TnkwRUZmTkhpME1udFJxQTV4MkYvRFdwdHZFN3lrWG5TM3Y1dkZZMUJQQ2xW?=
 =?utf-8?B?M1M5SzFOekFWN0c1elIvSUlYQ0VZdC92TithV2lFbmt4M3RFT0NsUGZCNUVz?=
 =?utf-8?B?Q3dod1dWNTgraG5iWWVlaDhpSmlCMDVDcURwd3Z3UkRxVUJwOFptbVlNZDI3?=
 =?utf-8?B?c3ZNRkxSYjMrdFN0ck9iaGR0RDZtZk9lUXVvczJZR3dVRno0QVgxRmhuaXlh?=
 =?utf-8?B?b2pRLzBjeUViNXVWV2kvdmdDajZCSm9KTkN0ZWcxNTdzT3VObEhTSTZIR1V3?=
 =?utf-8?B?Qjd1cVQ5Z01VNHhyUzVZT0FkU3c3WUlNUTIrZTNEZ1RCZitvRzJFaGhoWWxo?=
 =?utf-8?B?OGZmaVlDdmtXbVhoN2VvWkpJNnhWRnFJSlR4M2p1WWlFenB2N1UyZGF6ZkJ2?=
 =?utf-8?B?cVkvZS9PcW85RzBiallZOWx0ZGhRN0ZkY1lPa0RVaGU2eHIvRnVXdmsxVVRH?=
 =?utf-8?B?ejVLTys2Y2R2UXY4Z3Z3SW4vNVp5bVltYjhiZXF6TFo2TjRzVmRpb3Vpd2Rx?=
 =?utf-8?B?U0xzbnB4THBuL2RXMzJ0a2dGZzBoNlJleXo3RGJVcnJydXNTRmVtd3FxVERQ?=
 =?utf-8?B?T2hHQm5KY0l2Y0JZMkY5QVFQWENLTENFalZZTmJhZ2NoYnlUNUNQMXRIc2tZ?=
 =?utf-8?B?bnUyMWdnK2lJc2gwdVN3c2o0S2NkUVkxdVlyd0ZsV1hHTnQ1cG43WnRpblpw?=
 =?utf-8?B?bUF0NlVhTVBDdS9raTc1ekFnZTJUMTZlazFmWTFlT0tGbHp0SytKYTl3TDFS?=
 =?utf-8?B?WlZublF2QXJjRGYrZ2F2U2MyWVdvdUxTL3E2VXAwN0dyM0wzc2g0T1dsdkdH?=
 =?utf-8?B?TWR0aC83TzJwczBhS0RtZ0tyWXd3V3lueUc5elZZUlBmYUVWZUw3L2ZHc2U0?=
 =?utf-8?B?dUpyZGFOeEJvQjMvdFlnTDdYUlIrTUF2eC9hbE85MUM2eTFiNlBXS0xrWFpt?=
 =?utf-8?B?Qm03SDRXZVU1ZElxejczaXRpU29RSTR0NzhTZ2IycVJvR3VYOU13cGd3TzJV?=
 =?utf-8?B?LzR6SUtwY242UXlNQ25wRldRRjBHMlhlZDY2U1phL2g0a3k2SU5xRUhWUGV4?=
 =?utf-8?B?U0JEQTZUVWVlelgyaS9oRlVVc1ZqV0RUL1hwM2FIOU5uek5EMWZCUzdNaExi?=
 =?utf-8?B?S1I5eGFyQUFVb2pFN1NUU3VrSkVyR3UyOWJ2Vy9FVzIxTWcyQ3JBWldsTFRJ?=
 =?utf-8?B?ZVlTcEF2Z0NBV2NINXM1UW9HVFhOaWdBVWNSLzNlQUFhanRoUXc3ZDcreWxF?=
 =?utf-8?B?VzBUQm44dCtDNmZJeG9NSDhIR05wR2RiYmZzT2FyeFNlQ3ZQMTdieFZxeVVl?=
 =?utf-8?B?ejAxRHBydFZ6SGlMRlZZSEJNd1Jad05NcFFQUjB0RFpXVER5S0UvMzZxQzBO?=
 =?utf-8?B?TUxBNXhmeno5N2tUbjYxU3dTZHE0Umd4SnQ3dlRmUGFZK1A2d1YzZDJubnJK?=
 =?utf-8?B?cjA3cVMrd0g0N0k2UUllODJQeGdkN2dKWSs4VysxS1c5OUovcUZ4Z3FCa1d2?=
 =?utf-8?B?aEs3V0hkUXRZa2ZPdjhNN2t5cmswbWhPR0hJZzdNMmpWamdrK2M2cUhQRVRG?=
 =?utf-8?B?NjFYd3R6Kzg3dUs0QU5RWWpVUW5mUjV0K3RSSnQ2NlZmR0NFQ2VrZkc1TVQw?=
 =?utf-8?B?Z05lY1ptZVBNOGxiQkdSY0xpYlptRWJGT09LVzhzUHlhbEZ6bGF4cUVCL2dD?=
 =?utf-8?B?R08zcSt4YzVHeGRVcmYySEd4YlBNNDhISGJWbG9IOHhaak5NakxuZzExMFFF?=
 =?utf-8?B?M3M3L0tmenVHRjI2VUhRa0kvazJEWmdpbWpDV2ZSY3hwUnVZOHVKUnV3YjBP?=
 =?utf-8?B?WFlFS1V3S0podm1ZN3VSNTMrYjdoeW1NdEZwdHVSNFljNGFUc3ptWmZ2cEtY?=
 =?utf-8?B?bHFnREZLUUFPV1Z4NDcxNXJEV2p3YzB5T3QxR0F6UXlSTXlBU04wYWdvL3lP?=
 =?utf-8?B?eWFTUlc4MTZCeEhIY1VCVzFqSzl4YzRVS2VRRnZpeHkyMmdFalJqTElCVW9Z?=
 =?utf-8?B?bXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C23AF5E60AE52E4F89DAA82F6EB21D96@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd6c7a7-0085-4832-da09-08dbb4a5898b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 22:05:27.2795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gn+F0CzvcoQ9RGr3016OdDHLdT1h1YcxaEcNvphlun9XTlq9W+PcXRmMjT2tIc42sxpcn4kn4wwKPzV2qhsT5EbF4p5FSGKOzuPUXND3NXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5579
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gV2VkLCAyMDIzLTA5LTEzIGF0IDEyOjE4IC0wNzAwLCBTb2hpbCBNZWh0YSB3cm90ZToNCj4g
T24gOS8xMS8yMDIzIDI6MTAgUE0sIEVkZ2Vjb21iZSwgUmljayBQIHdyb3RlOg0KPiA+IE9uIE1v
biwgMjAyMy0wOS0xMSBhdCAxODowMiArMDAwMCwgU29oaWwgTWVodGEgd3JvdGU6DQo+ID4gPiBk
aWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL2tlcm5lbC9zeXNjYWxscy9zeXNjYWxsLnRibA0KPiA+
ID4gYi9hcmNoL3Bvd2VycGMva2VybmVsL3N5c2NhbGxzL3N5c2NhbGwudGJsDQo+ID4gPiBpbmRl
eCAyMGU1MDU4NmU4YTIuLjI3NjdiOGE0MjYzNiAxMDA2NDQNCj4gPiA+IC0tLSBhL2FyY2gvcG93
ZXJwYy9rZXJuZWwvc3lzY2FsbHMvc3lzY2FsbC50YmwNCj4gPiA+ICsrKyBiL2FyY2gvcG93ZXJw
Yy9rZXJuZWwvc3lzY2FsbHMvc3lzY2FsbC50YmwNCj4gPiA+IEBAIC01MzksMyArNTM5LDQgQEAN
Cj4gPiA+IMKgNDUwwqDCoMKgwqBub3NwdcKgwqDCoHNldF9tZW1wb2xpY3lfaG9tZV9ub2RlwqDC
oMKgwqDCoMKgwqDCoMKgc3lzX3NldF9tZW1wb2xpY3kNCj4gPiA+IF9ob20NCj4gPiA+IGVfbm9k
ZQ0KPiA+ID4gwqA0NTHCoMKgwqDCoGNvbW1vbsKgwqBjYWNoZXN0YXTCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3lzX2NhY2hlc3RhdA0KPiA+ID4gwqA0NTLC
oMKgwqDCoGNvbW1vbsKgwqBmY2htb2RhdDLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgc3lzX2ZjaG1vZGF0Mg0KPiA+ID4gKzQ1M8KgwqDCoMKgY29tbW9uwqDC
oG1hcF9zaGFkb3dfc3RhY2vCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN5c19tYXBf
c2hhZG93X3N0DQo+ID4gPiBhY2sNCj4gPiANCj4gPiBJIG5vdGljZWQgaW4gcG93ZXJwYywgdGhl
IG5vdCBpbXBsZW1lbnRlZCBzeXNjYWxscyBhcmUgbWFudWFsbHkNCj4gPiBtYXBwZWQNCj4gPiB0
byBzeXNfbmlfc3lzY2FsbC4gSXQgYWxzbyBoYXMgc29tZSBzcGVjaWFsIGV4dHJhIHN5c19uaV9z
eXNjYWxsKCkNCj4gPiBpbXBsZW1lbnRhdGlvbiBiaXRzIHRvIGhhbmRsZSBib3RoIEFSQ0hfSEFT
X1NZU0NBTExfV1JBUFBFUiBhbmQNCj4gPiAhQVJDSF9IQVNfU1lTQ0FMTF9XUkFQUEVSLiBTbyB3
b25kZXJpbmcgaWYgaXQgbWlnaHQgbmVlZCBzcGVjaWFsDQo+ID4gdHJlYXRtZW50LiBEaWQgeW91
IHNlZSB0aG9zZSBwYXJ0cz8NCj4gPiANCj4gDQo+IFRoYW5rcyBmb3IgcG9pbnRpbmcgdGhpcyBv
dXQuIFBvd2VycGMgc2VlbXMgdG8gYmUgdW5pcXVlIGluIHRoZWlyDQo+IGhhbmRsaW5nIG9mIG5v
dCBpbXBsZW1lbnRlZCBzeXNjYWxscy4gTWF5YmUgaXQncyBiZWNhdXNlIG9mIHRoZWlyDQo+IHNw
ZWNpYWwgY2FzaW5nIG9mIHRoZSBBUkNIX0hBU19TWVNDQUxMX1dSQVBQRVIuDQo+IA0KPiBUaGUg
Y29kZSBiZWxvdyBpbiBhcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vc3lzY2FsbHMuaCBzdWdnZXN0
cyB0byBtZQ0KPiB0aGF0IGl0IHNob3VsZCBiZSBzYWZlIHRvIG1hcCBtYXBfc2hhZG93X3N0YWNr
KCkgdG8gc3lzX25pX3N5c2NhbGwoKQ0KPiBhbmQNCj4gdGhlIHNwZWNpYWwgaGFuZGxpbmcgd2ls
bCBiZSB0YWtlbiBjYXJlIG9mLg0KPiANCj4gI2lmbmRlZiBDT05GSUdfQVJDSF9IQVNfU1lTQ0FM
TF9XUkFQUEVSDQo+IGxvbmcgc3lzX25pX3N5c2NhbGwodm9pZCk7DQo+ICNlbHNlDQo+IGxvbmcg
c3lzX25pX3N5c2NhbGwoY29uc3Qgc3RydWN0IHB0X3JlZ3MgKnJlZ3MpOw0KPiAjZW5kaWYNCj4g
DQo+IEkgZG9uJ3QgcXVpdGUgdW5kZXJzdGFuZCB0aGUgdW5kZXJseWluZyByZWFzb25pbmcgZm9y
IGl0IHRob3VnaC4gRG8NCj4geW91DQo+IGhhdmUgYW55IGFkZGl0aW9uYWwgaW5zaWdodCBpbnRv
IGhvdyB3ZSBzaG91bGQgaGFuZGxlIHRoaXM/DQo+IA0KPiBJIGFtIHRoaW5raW5nIG9mIGRvaW5n
IHRoZSBmb2xsb3dpbmcgaW4gdGhlIG5leHQgaXRlcmF0aW9uIHVubGVzcw0KPiBzb21lb25lIGNo
aW1lcyBpbiBhbmQgc2F5cyBvdGhlcndpc2UuDQo+IA0KPiAtLS0gYS9hcmNoL3Bvd2VycGMva2Vy
bmVsL3N5c2NhbGxzL3N5c2NhbGwudGJsDQo+ICsrKyBiL2FyY2gvcG93ZXJwYy9rZXJuZWwvc3lz
Y2FsbHMvc3lzY2FsbC50YmwNCj4gQEAgLTUzOSw0ICs1MzksNCBAQA0KPiDCoDQ1MMKgwqDCoCBu
b3NwdcKgwqAgc2V0X21lbXBvbGljeV9ob21lX25vZGXCoMKgwqDCoMKgwqDCoMKgDQo+IHN5c19z
ZXRfbWVtcG9saWN5X2hvbWVfbm9kZQ0KPiDCoDQ1McKgwqDCoCBjb21tb27CoCBjYWNoZXN0YXTC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzeXNfY2FjaGVzdGF0
DQo+IMKgNDUywqDCoMKgIGNvbW1vbsKgIGZjaG1vZGF0MsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN5c19mY2htb2RhdDINCj4gLTQ1M8KgwqDCoCBjb21tb27C
oCBtYXBfc2hhZG93X3N0YWNrwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN5c19tYXBf
c2hhZG93X3N0YWNrDQo+ICs0NTPCoMKgwqAgY29tbW9uwqAgbWFwX3NoYWRvd19zdGFja8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzeXNfbmlfc3lzY2FsbA0KDQpJdCBtaWdodCBoYXZl
IHNvbWV0aGluZyB0byBkbyB3aXRoIHRoYXQgcG93ZXJwYydzIENPTkRfU1lTQ0FMTCgpDQppbXBs
ZW1lbnRhdGlvbiBvbmx5IGRlZmluZXMgdGhlIHN0cnVjdCBwdF9yZWdzIHZhcmlldHksIGJ1dCBU
QkggSSBnZXQgYQ0KYml0IGxvc3Qgd2hlbiBJIGdldCB0byB0aGUgaW5saW5lIGFzc2VtYmx5IHN5
bWJvbCBkZWZpbml0aW9ucyBwYXJ0cyBhbmQNCmhvdyBpdCBhbGwgdGllcyB0b2dldGhlci4NCg0K
RG9pbmcgcG93ZXJwYydzIHZlcnNpb24gYXMgc3lzX25pX3N5c2NhbGwgc2VlbXMgdG8gYmUgY29u
c2lzdGVudCBhdA0KbGVhc3QsIGFuZCBtYWtlcyBzZW5zZSB3aXRoIHJlc3BlY3QgdG8gdGhlIGNv
ZGUgeW91IHF1b3RlZC4NCg==
