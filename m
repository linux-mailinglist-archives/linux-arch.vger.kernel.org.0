Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D24A79F1DC
	for <lists+linux-arch@lfdr.de>; Wed, 13 Sep 2023 21:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjIMTTB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Sep 2023 15:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjIMTS6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Sep 2023 15:18:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BC0170F;
        Wed, 13 Sep 2023 12:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694632734; x=1726168734;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=63yUsneY/RmYlInZ/dnG/mTcTTecI9ZNgQJsTP1BacY=;
  b=h1Qd5h2ywPytRUhEW8I/ObMK80Xp4MarbG23fv5ZhXKsc8S1tlfSo8TL
   pKnZxv5fl0KVSLxN+X5UXgncLzr7qNbnay1dMj1ALIUFX8ucmyPOX3DBv
   NX7IS+ggvNFdbGG41Vf3tczC5EBETdZeCM8VpBVhSWAhsU5r24Z7or71z
   yu5UEhtm9MRHaUHzxQIecz00H7H0j7GzEKEfguUKtaDr+lDYxJ/fLM3QN
   F5Extjfl+f5rc2U7mm4HWTxJO/S+odD4w8IqGkllk6F0U2ih1C16UJRqK
   1As8urcubXQ/VCO1m0kkLNWtQNRXghV5CBJhjxG78ATT3m2siHl3psbse
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="381444959"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="381444959"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 12:18:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="1075062938"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="1075062938"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2023 12:18:44 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 12:18:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 12:18:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 12:18:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 12:18:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxgO8PmRj9AQDHr8aI67BCqKMySwwUc6SPzmc/8b4rQUAmeGDcCHJ/6jeNU8Og7ktMaEyM6tVpV1z/r+buV7MQDUGrHrygtAbKFQA8HNe6wc0Tr+41WBUUedkKwYjc9tERfgpI1UPQT+iHZwURiTrULp+yC1UHpFSefRtxkqPEO0ibBJMBMOFQSKmG9I7MuUShHR8I4j2DU03DVicCd5o+tzWPd8LSI7NB8lSh9K9YMlzQu/qRmiJ6vWCerOmHV9wC1xC0jv8y4fDEtvCBJHKo0/JFqCL08fPwmHC6xaAbknNNYzXBH8Vn+6Yn5nGHkVy4mmz1QffOXWfw4sTYEd3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4ojUKiq9OLFzo+o6q0g7FIc/PbSPJP4bCw0/REjVEs=;
 b=EpjlAqqXUWp5iU+F6G65g6hX0SJsYULhO/t/3BpwUTF5bxyrlYmtos/tXtQ+D6AymUNMpvwUUwvslohRnhha90sqwXPGPJ9WojsNQi9HzPFOor0g9sx5ZIyfiRZEJB6PSBfzXJFCadEy4zeH66RnIbvgk4N/bd1dKZ1vZ7nCs3NQCAi4cJA0KbWcSjsQAJi9y4C/5PNZ+CH3jFKPpttnRaIc5y85V62Ln7dWJ5v8EyCuEQII0Zk1DDjWKL6/bz5z9rCgpgZ1Evacchd8RoNN+MACc0hXQ0g+QMyUNoG97JOQqkWw39oKBQQocUvkVZnIlaf+8JgmNu5fECsQkZobcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by MW3PR11MB4635.namprd11.prod.outlook.com (2603:10b6:303:2c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 19:18:39 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::5e34:ee45:c5e8:59d0]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::5e34:ee45:c5e8:59d0%7]) with mapi id 15.20.6768.036; Wed, 13 Sep 2023
 19:18:39 +0000
Message-ID: <29da2af0-5c88-f937-a9b6-db2d5f481321@intel.com>
Date:   Wed, 13 Sep 2023 12:18:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] arch: Reserve map_shadow_stack() syscall number for
 all architectures
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
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
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
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
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
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
References: <20230911180210.1060504-1-sohil.mehta@intel.com>
 <20230911180210.1060504-3-sohil.mehta@intel.com>
 <8b7106881fa227a64b4e951c6b9240a7126ac4a2.camel@intel.com>
Content-Language: en-US
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <8b7106881fa227a64b4e951c6b9240a7126ac4a2.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0156.namprd05.prod.outlook.com
 (2603:10b6:a03:339::11) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|MW3PR11MB4635:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c37b63a-ed84-4964-0c54-08dbb48e3c4b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AhjLuF15f7DLSNwnZBfOHgCoKryBO2fDW40CYNJRHEArnIvA4XI+dpKWIF/LEY67LEEipN3A0NRj0zKYa4DoPj3UY1MzhvyANq7r5V3Jbg4DLYyoq7SUz405pT2x+S/IX7Y8XwmkZtNpsRZyP4x6VlZIfCcOpDAfFnie9VgiMJcbl70Mrrpwa7IhQ8NKCU5H5o+juIPvxGMGzsAIsYjETQa6lnwH5mJCmPMBzIt8pkv3y8xbDfJL6aloBVC5oEz4Metu5240dGZPp4timMeH0k1nwwA3dRNLBcylA3kGGP7w7bQP02pGAb5nz0BD0U/iaWba0U3CBQ/YS1DwFqQ3bkxKNCSp8VJZvka3JNj0QuIS3IwUN4weGKFuiz1SqGUmugedIoDoAORIaPYLlkJObQ6YaZ5cFQntQXJZbIShsyz8DoZdOjHTJYvcMtc2YxFVRN0yfYjHZZ3oEK3+2qC9En4vE0eFmW33LC2Xy0MubONXSrHJHZszf/eAov+HN+1T8X9jPkTIjwN9bOtj+MttOkylBXPfyQ8aCrHMSXC+Z2xoaDgFVPDblOc82XWVk4C0GGgHpeOSJQ2Z/P6CKAptFaGWhq1ye7nbsh7+tTv17bZk9yGR3iEzABzJA4NdhtyJHHWXAfhvfRvud7JzBWd3vQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199024)(1800799009)(186009)(31696002)(8676002)(86362001)(8936002)(4326008)(7366002)(7416002)(7406005)(5660300002)(44832011)(2906002)(36756003)(6666004)(38100700002)(83380400001)(82960400001)(53546011)(6506007)(6512007)(6486002)(26005)(478600001)(2616005)(66946007)(110136005)(66556008)(66476007)(54906003)(316002)(31686004)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmxlSG9QWFlvRUlhamI0WTZxQ29LMGZpVnpaMFRXRG1wWElYL3o1ZXQrNE0v?=
 =?utf-8?B?cW10S1lEZm9VTFU4SzJldnJNYmJJdnRNZ1UyOFR4MlF1MFUwZWgxbi9GaThX?=
 =?utf-8?B?eFJoV3EzclNDdEVnZjlwYnRQOEtTUkZqenBtbXE0WUNURktnczM2RzJueVlB?=
 =?utf-8?B?S2I3QzN0T1I0bnJvWkFoeTVpeXFTbHF0b2JQR1QyOXRhd1pybXp0M0FDd3Ey?=
 =?utf-8?B?WUx3TTdzMTYyK05HSzY0MTBBNlBkYVJRMnQ4YmN5WmFadW9tM0VCYkpwQnVC?=
 =?utf-8?B?SmpXN0VPbWJ6TTI5Ujh5QjVheGhEWVdmdld1SHl2MVNlUld4blk5UGh5SnRj?=
 =?utf-8?B?MExibFZSb3BmK0RTdmhYVWwwb3VPTFNHUDkxWnliblZyYjVFaktCQjJ4UUNr?=
 =?utf-8?B?SVcyMFNSQjVHRFNxcnIzQ0x4RzdMYVFYbjJwaWE0WTRiSDZ1bUV3VzVpckRW?=
 =?utf-8?B?ZG1seTlRb0pOQmd0NjVJYStQbzNPRWgwcm5Mb0RLUDlzWlZ1MkpMYk82NXFa?=
 =?utf-8?B?alZ4aHFCQzVZZDJlVEpaQUN1cTR0dFYyOUlEMjV1dFRVelhjZWFmdDZyeFMw?=
 =?utf-8?B?WjlGRU04RmdkS21nNmkwcWN3TTN2VFU5YjdEMzhRT0ZlYm9qWU1aVVRRaTlw?=
 =?utf-8?B?MXlyUUFlaWZ1Y20wK2RhV0tUTjRFdVBvZWliQ3cwUUs3TXJZS200eHF3ZVhF?=
 =?utf-8?B?NUdlMzlTM0FuRm13elVqeWtNOWhScDl4enQxK3VmTFNuTXU5SjVPbkVXdXo2?=
 =?utf-8?B?V1pscGFhcFA2OU5EWTNNSlgwOTlvb2VJM2R2WnFKVmpwVzhhMGhyRit5citT?=
 =?utf-8?B?VWlvZEFnQVRpc0JZekNXNzFScE1aMHpsMHdBa2sxcStNQWszdzJCbEFCNjM5?=
 =?utf-8?B?MEk5cTUrYUhVQ1d3M2R0ZTVaV3RXYnZuV3ZaTm5KclRQODdCREp5bGY5THVY?=
 =?utf-8?B?eVJFMU9ud21zbDFONWxJSUt5WVpBNVFuemxEbjNxcmI4SmJQTzVGRzZhNHI4?=
 =?utf-8?B?V1dOQ2kvU0F2SkdEaisrVnJnT0hqUnRlL3hveVptbHVSQ2hHTTRlOGFHY0Z0?=
 =?utf-8?B?VVhxWjRqMmN3S0swNzdaYjZJQnFuRlFlV093cFB2QW40T2dka3B2Uk1UcDNy?=
 =?utf-8?B?cFBua0pmVEZwNmhrMm9yWlcweExiVGk2TzhGNGJVRWxiWjJOanJIWXJncWg1?=
 =?utf-8?B?YzF5SnpFSEkrS1p4TFFwWVB1MVdjQyt4WFdOd0xZOUkzbGJiTUFpcGptZEtS?=
 =?utf-8?B?ZFZnanBBRGx1RG1xREtNcldJNGVUdU1MZDg5TW1tZHJVSnFuSkNJdWVSVUxo?=
 =?utf-8?B?NE5tbTV6ZjU5T0lla1d3QkkzZzN0WEhRbmtHWlNGVmNlQ2wrZVByWVdBaWgr?=
 =?utf-8?B?Q1J1b2dKMmVSWXZGV1IrSitEN2Q2L0M3Rm0vYk9CNHRXbDR0TExKWVdjLzdZ?=
 =?utf-8?B?WUQ0MkIxMG8rcVltdldiV3hPUUplTGxLcGwwY1hxT253M2JoYWhpMHZxdjNm?=
 =?utf-8?B?SGIwT0dEblpabjZwNE56T0xoYTJ0ZFZsZEVsR281NjNZYUtvR1NveS9GWTgw?=
 =?utf-8?B?QUs0OXFWbi9EVnBDbUNXcy9GNVZENGFWSmE4cVd5OWhycnVYRTVET0NKSytN?=
 =?utf-8?B?SHllT0FmQk5zaWxPcC9mS29PL1dVbktsejdJRU9ERVA3b0VHelA5eFU3amZ2?=
 =?utf-8?B?TDlrckhnUlM0cG1FdDdpcU42MW5zSkR5djlzVTZMWE01bW9iZEp1ZnJ1azlH?=
 =?utf-8?B?ekxIbnZPd3c4SXJtWjFQTkNFSm5CbHZlNXRRV21uaFRndnBZTnd5dUFMRWlv?=
 =?utf-8?B?V0xOa0ljWGtWT0liNVRtSTdEc0JPNnNNdC9BQXJIZXI4QnNNYzk4TktVWlo5?=
 =?utf-8?B?c0xEajlpU1ZmaHE4N2k5ZkZhZitjempYUzJDZ1hoYUZaaVVzSS9VcEVKQVdv?=
 =?utf-8?B?Sk9Gcmp6VjFKTThpN3VLVTR5d2FXdkt6enpOTVNQVDhOayt2eXV2eFJ5Mnlk?=
 =?utf-8?B?Vzh3YjJ5SWcrZzNydXZ1VElWVFdoYi9CbFgwVytwYlZHSWxoSENBZzRwZUtz?=
 =?utf-8?B?andaT1FGUHpFMUFjRy9LbEcreC9Ec3RhQUlBYXlZWUJabVNLUlhONnYzT0Zp?=
 =?utf-8?Q?vemlFFh/fWEgCepxVOg5aWysK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c37b63a-ed84-4964-0c54-08dbb48e3c4b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 19:18:39.4465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vm5GlSfx1z6OXYbq9cNmOOQrRB03AerxJhXyvc8PAV8yN8s+Z+DE/xotsDKUmZHZjVD3tG0aOOmqjvQgveCz9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4635
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/11/2023 2:10 PM, Edgecombe, Rick P wrote:
> On Mon, 2023-09-11 at 18:02 +0000, Sohil Mehta wrote:
>> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl
>> b/arch/powerpc/kernel/syscalls/syscall.tbl
>> index 20e50586e8a2..2767b8a42636 100644
>> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
>> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
>> @@ -539,3 +539,4 @@
>>  450    nospu   set_mempolicy_home_node         sys_set_mempolicy_hom
>> e_node
>>  451    common  cachestat                       sys_cachestat
>>  452    common  fchmodat2                       sys_fchmodat2
>> +453    common  map_shadow_stack                sys_map_shadow_stack
> 
> I noticed in powerpc, the not implemented syscalls are manually mapped
> to sys_ni_syscall. It also has some special extra sys_ni_syscall()
> implementation bits to handle both ARCH_HAS_SYSCALL_WRAPPER and
> !ARCH_HAS_SYSCALL_WRAPPER. So wondering if it might need special
> treatment. Did you see those parts?
> 

Thanks for pointing this out. Powerpc seems to be unique in their
handling of not implemented syscalls. Maybe it's because of their
special casing of the ARCH_HAS_SYSCALL_WRAPPER.

The code below in arch/powerpc/include/asm/syscalls.h suggests to me
that it should be safe to map map_shadow_stack() to sys_ni_syscall() and
the special handling will be taken care of.

#ifndef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
long sys_ni_syscall(void);
#else
long sys_ni_syscall(const struct pt_regs *regs);
#endif

I don't quite understand the underlying reasoning for it though. Do you
have any additional insight into how we should handle this?

I am thinking of doing the following in the next iteration unless
someone chimes in and says otherwise.

--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -539,4 +539,4 @@
 450    nospu   set_mempolicy_home_node         sys_set_mempolicy_home_node
 451    common  cachestat                       sys_cachestat
 452    common  fchmodat2                       sys_fchmodat2
-453    common  map_shadow_stack                sys_map_shadow_stack
+453    common  map_shadow_stack                sys_ni_syscall

