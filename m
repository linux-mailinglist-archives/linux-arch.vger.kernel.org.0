Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2055876F4C0
	for <lists+linux-arch@lfdr.de>; Thu,  3 Aug 2023 23:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjHCVpj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Aug 2023 17:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjHCVph (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Aug 2023 17:45:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA5F35B5;
        Thu,  3 Aug 2023 14:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691099135; x=1722635135;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uL9O1FlrKasecN28UXFt0/H/JGqCfORMXhJ6xFBglwY=;
  b=CEgJ+dYaKbjNn/u8ksBgJtPYKmibBUbIMhRy0ZULURz1svW8W7WnagP2
   xWQWvNJGT5McvFEdcDiIV1nElICHs2w3SyTkoIbfPWzVpTX/9brpt3q5S
   5XoEIUzJtmc3hfZ25MZgoonRus3Dx3YrVRPnCI1t/I1rHx6pzoGgHmI8s
   cpY0GEKdoGEyfBck108aALBMpNOw5YDgusUMHPf/TKmkqrznULpbuIt4P
   nIYu64VMDlp9cpE8kASWPzD1+HUDc4LTnfKJT8IIWhYmvBLb7fmvqN1Mt
   MUBIjyHMYFoQnpbQGHf/tBOrvIHyO1wnwjA//lqoOrTupNdgxD6PSvaYu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="367468406"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="367468406"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 14:45:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="976281407"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="976281407"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 03 Aug 2023 14:45:20 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 14:45:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 14:45:19 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 14:45:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCMzXuyPRfaW4diUmCpWkNzBy7dQTyPpyNsIexxWiE2WOlGldEc1dM5DM82gejsTv8AwmAw7+JCpTESD8hADL314maiJlnmb4amcGaGPHypuYCPSrB1A004qhOTP66HVuFRWyWemn63Ut26GUPeeTZ0ag0ZN8yhNY0G/ARqqukMFO7dE1YkmGkE5n1S1Fndgm3iLcNuP69Pn8P296KbiFVtDFTPmQKWsDHATxJW9sVJSbUkS55peCiEKnpJ5QhR3Xfv+50+4LMdkQDku2yYCblNBTg7NNT6aY/sZJdE2hx93+axQCE19PrxzHBDrCzpaOD35SOTQvQkfxF2xhasbIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWD0cSyZdRPmwAIcwUOG5k4OwVJKZRBv7kuC3Pttilw=;
 b=BOAEpEjIVqmesiCiEeaYs0SWDhqRxvbYNGPjb34kAzAZ6diNvM4hvvmIE+Zvf3aH0V6+bwNiyBz50XAlr39VIIhnU3ymNLE38G3mqJUE3x8oagJISObUhjvP/44+aiAwA6/XTFZ4+UvIolCJk8SplePKINNeYWqVbqubxcjzMkASSbYi46rmncthlK+EA0KS5WLQB9r0tLZz5rAOhC8GA0QUAdzzFgyT/8BAW7orGn2EAkHPu/G2IgxXT38cNrAtxMYa4bIihnaOgGdmsR8O02Gmb12IxCTTDiZ28++BW+BZxIxSB6p0cjel0PIJqtqfJEhh+PD0dPUg8JtHqgPo+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SA0PR11MB4525.namprd11.prod.outlook.com (2603:10b6:806:9d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 21:45:12 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e96e:8ce2:abd9:c61c]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e96e:8ce2:abd9:c61c%4]) with mapi id 15.20.6652.019; Thu, 3 Aug 2023
 21:45:12 +0000
Message-ID: <5748f659-4063-0e18-c5d4-941a863d0d93@intel.com>
Date:   Thu, 3 Aug 2023 14:44:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] syscalls: Cleanup references to sys_lookup_dcookie()
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, <linux-api@vger.kernel.org>,
        <linux-arch@vger.kernel.org>
CC:     Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Michal Simek" <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Helge Deller" <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        "Max Filippov" <jcmvbkbc@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Sergei Trofimovich <slyich@gmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Rohan McLure <rmclure@linux.ibm.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Brian Gerst <brgerst@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-alpha@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-ia64@vger.kernel.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-mips@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
        <linux-sh@vger.kernel.org>, <sparclinux@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>
References: <20230628230935.1196180-1-sohil.mehta@intel.com>
 <20230710185124.3848462-1-sohil.mehta@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20230710185124.3848462-1-sohil.mehta@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0184.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::27) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SA0PR11MB4525:EE_
X-MS-Office365-Filtering-Correlation-Id: c7efc474-48d5-4247-6087-08db946aea3d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UVrTGacRs8YyvKou6lD2dmAhHLyZG41onkNpnNR6QqQTyHvOIGhlWSNTx34maOEc+v6dysJFYDqin8Wtmr7YUYWIk3CqQMpfa68snFQbRPR8hv4MV3HGLNFJ2Hj+OzQqElT/ADxLmZCzs+0eRVuWLlMKL2kODPI2mrYVpqF92/eBf/etz+ijgh7TAFOJBdOXPvSS7f31S+9H9Xs7FouCcgmvT6t+PxPO1MznmX/f1RcHHrVItnJuOJKqy0LWJ74Nr/1XygLg8t3n30hNhT/TeV9wBX9pjRfJaBUvcBSOOHfOz4huGaFH0fy9CZFSt9s2RDhRLCDBKr9wuJD5LMbcfjsNRou78UOAWbIgf2CjHJazFu3aXgc9LdGxdWVFGkenCoBuTigcGRDzhAv2SLSDMdEBYu4mKITZI+fRawhkDeJCpYou1Ahm1GY3JogkQMP3Kgasq9573yeDPfgDgtoxdaWrqOTG4kSrouWVZzp7EvV371YBYFsJ4Q4SqYcbTOZDV7qpJ9RfjY9t6ytLP7zKSzTNOlhYsylJdU3sPcZ7xkg0JUcEm0AvarS3gLHdPgeEcUx0UuHZAg6gbzBwrQ+gGa/k+2hrqqXXXuZkWj53zL6Yf+tC9tflTyTzn6wEdukrkqUfKpriovnj6wp72JKYsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199021)(186006)(41300700001)(6486002)(82960400001)(6666004)(478600001)(38100700002)(2616005)(26005)(83380400001)(53546011)(6512007)(6506007)(4744005)(316002)(2906002)(54906003)(86362001)(31696002)(36756003)(66476007)(66556008)(4326008)(66946007)(31686004)(8676002)(8936002)(5660300002)(44832011)(7406005)(7366002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmRKRXBJb2Q3d3NjcUt2TDZNN3R0c25rQzVya2VOZjFBYnRKYTFKNXRISG5s?=
 =?utf-8?B?SW5lQjZsMlR0d0N2elIxM0VXY0VxMjd2clRtZlI0aFRieVhJNEt3bXlTd3p3?=
 =?utf-8?B?Zy9SVXozM21URUsvNmVXaXdPYlFmbE9jcUdXS3VHTjBiTkp4YzlUU3BuNHFs?=
 =?utf-8?B?dzlFVkoxbmRkaUs0d0E4MVZMREcrMDdFWjM5RWlFSXlNTWMvNUQ0dXNCS3hl?=
 =?utf-8?B?dmo4WDlCOU1FZERCeEhqVllTYnMza3N2YXZRc0VSRjdjQXNtZ1pLa01zdFU3?=
 =?utf-8?B?bDhmeitsbDMxNUQ0MU40VjYxUEh6dVJ4ZENPRStTaGgreGtmMEpFUkxLclRM?=
 =?utf-8?B?YjlyWmNxMXl0SitYTGdpdkViNDhQQ3Urb1FTby9wVTI3QStUNllDaHhWTUl6?=
 =?utf-8?B?cEhya24zbWM1M0tlRUR0cDI2NkNjeFd4WE00dWNWdWJnYWRDOXBWOFdGcUFo?=
 =?utf-8?B?RVhjRVlBWk5JOGpuWEx5NzI5eDlJb3Bra3ZBM1JxcjNDbVVXc0l0VEVadmQ5?=
 =?utf-8?B?dnRhWDM4b3dXUFFkcjd2aHpZMTNhNVVLY3J0NXBPNmFyeXRDSC96clY4RXRz?=
 =?utf-8?B?WDd6dEF4ZU15NFQ5Ym53RzNUMkphUWhQdHBMaElCVXhUR05GN1lmRWg5aGth?=
 =?utf-8?B?anhkVThNQmxPQzg0U1pucTVaWk9GVEtoa1oweXRYYVEyY1N6MFJ3aFhFRXor?=
 =?utf-8?B?VDdCeGdRUXZTTGs3TmJxN0pZQ2dNOFpaNCtGUHFlVjhoTyt3YTYyLzNOeUFl?=
 =?utf-8?B?cHBDYmxCMjdDYnVmbGJkbG82SzJHWEEzQUZCUWUwMDVvYlZBbVpDVDBmRTZM?=
 =?utf-8?B?Z0MxOFdZZlBYOTZLQ3ZjcXorQ3FxYXVKN2xoUURONGpIRlZpK2gyMmJSd2xm?=
 =?utf-8?B?dHc2T1lvWW5FMlZ3dFdSRVRBN3h2bVVGSkkyTDBUdGVZRVBwY1AxcU54c3kz?=
 =?utf-8?B?cFhJTTJWRDlHZFBBN0tvcUxPeFhDdVlFK2ZwZmdvRlJzU2FpNXIzSmlpcGVP?=
 =?utf-8?B?MDArL0Z1SGhmSHBEaDNyM25KeEswWjM3Wkx5K0xSM3U1RUswbWY5citDRm0v?=
 =?utf-8?B?YW5ZQ0ZqY2VtV0RyS3dxbXVkTDYzY0xza2dENkw0cDhFNldNMmFEaE8rQTZS?=
 =?utf-8?B?SncwYlhxZmJ1Zk9Ocng4UDJJMTJxQU5FbGhlT3VOYjNaQ3dNdlNsS0wzYmtL?=
 =?utf-8?B?OVdXRE5TalEzZktSMGZmdVpWV0hKb0pXWXQ0Z3Y4RzI3bkZqN0tRcTc0c0xz?=
 =?utf-8?B?SDhDWmNUMXlTaTBmTnVMYlBSck0yQzNaYk5LSE5jdmdCdnl1WWlGNFpVRVEv?=
 =?utf-8?B?QU1UVU0rSXVMYUpnb1FNMjgwY21WYXg2dG5KWWlCNkxIM0hiVWNYaW9UUFRH?=
 =?utf-8?B?Sk44ejJNSzNtVGpnTkRYcDY1cVJCMXFiOU9UNmswUXhpODFKME96YUloNXJu?=
 =?utf-8?B?ODh2R3lueTdqZzRnYkhzNmR5akNjSzA3Y3JWS21jTTFIN3V3QlA0VnV0Z1Fu?=
 =?utf-8?B?V0xNdWs4MmRTV2R3NHhSSWxvQUE0RXZIR3hNS2c1OWtzOXdkeGpoa2lmcUg0?=
 =?utf-8?B?WGZBaTJySEgxajBDQTNFRllJV3VxcjlsYzZEaXNrUE1CY2sxQ29sYXFnd0FT?=
 =?utf-8?B?eHd6dWxXVmNkU2l6cWlISzJSbld4bTlMeWNVQXBMaVpZYzdhZmxuMVNOMU02?=
 =?utf-8?B?UHlrNEg0TkFtaURCeDE3ZWtEYk8yeDMwWHBpNTFJMkpnbGtZY0tmSzFHVzNu?=
 =?utf-8?B?dy9tK1krYlJ0TnM4N3R1Wk9iRGpMWHc4YTB6ZmNoVzIzWHhGYXFUcFgvcy9z?=
 =?utf-8?B?ZStmR0w0OU16R3B5c1Btc3drc1JYYzlnMXQyZFJ1QVh3cTRCRkVqZEFLWEZL?=
 =?utf-8?B?ZlNTeUk5bnhWR1I4SWcrOVovb3NRRGF3aE9USTArck9jeTN4b1RaellnV1dw?=
 =?utf-8?B?eFZyNkpZQlNsWkNFZUhrbVZYU0xaRjdFMmNOWjN2L1B2SjZRdHhtZ0NvS2Fq?=
 =?utf-8?B?ZFh5U2hCc0FCcHRwelhkRjJzU1BLSXZPcXY1azUzZW45MERkUzJobTRHcFJu?=
 =?utf-8?B?K0NLOGRVTUxGS3FmS2EzTHllRVE1WTNyVFliS0cySnFieTk3N2VEL3p6L05I?=
 =?utf-8?Q?TTk9ZlLYMBL+dE5LRZvdmLAqV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7efc474-48d5-4247-6087-08db946aea3d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 21:45:12.2569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8U377FaK/XnfXT9SSRaRvSyUZK3wdDiJCJW5sIIW8EG87Pp94noQYk9j6gTJZ/EtVddH0iPsAs44hofO5lD0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4525
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

On 7/10/2023 11:51 AM, Sohil Mehta wrote:
> commit 'be65de6b03aa ("fs: Remove dcookies support")' removed the
> syscall definition for lookup_dcookie.  However, syscall tables still
> point to the old sys_lookup_dcookie() definition. Update syscall tables
> of all architectures to directly point to sys_ni_syscall() instead.
> 
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Namhyung Kim <namhyung@kernel.org> # for perf

The patch has received a couple of additional Acks.

Does this seem like a valuable cleanup? If so, should it go through the
asm-generic tree?

Sohil
