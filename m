Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40043E7C85
	for <lists+linux-arch@lfdr.de>; Tue, 10 Aug 2021 17:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243523AbhHJPkZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Aug 2021 11:40:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:53942 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243549AbhHJPjs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Aug 2021 11:39:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="213074200"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="213074200"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 08:39:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="445193987"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 10 Aug 2021 08:39:13 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 10 Aug 2021 08:39:12 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 10 Aug 2021 08:39:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 10 Aug 2021 08:39:11 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 10 Aug 2021 08:39:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExuTyYYXXuSR5E1P2/vaEl1+zzIgiW9ozCfrnDCJbimVvp28AMD74jOL1K7FVoPKEdvu7Skv7K4VowudN2s2X4m2qSA6MZtVIPzjxW85DtSIcuDHnLMJqL3oGN+cgDpxlNVSxpHKDXcuirHSTubnrdqDFSXXmVBYge7lj4RNq8gIYl0/ZcIfYiLSMicUmR4UdGvJToCck+PAem9jmwclMa0VI/n0/saa1dnIxVt1t3t0xE8WneQaQ3SMfzjgYWGJXIad2JFchKISB6dLVF6Y8FNejZU0kOdj+p/57OrEC3XR5yG0GvQAOAjj5NwoFfVuxmpxdy99sGd3Ds2Q4axalQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NeBy5DLs/x/Fdwpbu1QNUPYhaP+BIkANSY6TeoIME0Q=;
 b=btjRMXI10ktxjYrQSzdvWaPnaLN4M3006Rw1aUmq+8VoGO/7BqjzpPe6Js9vPFH3W9ujMXBZK0fMMs9mX9TRnaT9TyY+C2H8CI88Mlz1zT/Xtlxa3hsIqw5HBNvdwmTf5hOYFup1awvkf6X1OLoXh1Vnf6WXzR5bUZ8UmTg44WHyBmJHoG9eKdQNm/ZGwBraEWoQtcfkCiLQZka2iJv+CQqkpNx7z/YCW+ydOGwLseXVE4ajMmyzgjawIIckNz6/dNt4G+ImKfKOqLkfmVo7aUBt+vQp0GeRsyKmIQKK24VLx5S4HrNgeNz2VCcapNFdQPmJ89iTKoCRNL+3/gZ8fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NeBy5DLs/x/Fdwpbu1QNUPYhaP+BIkANSY6TeoIME0Q=;
 b=axtznPXlRZ7hJJTZznG+rn8+x2AinfFUA5S9JidbXvIR2MAOoOvE8MlaSvejRKAbul7B6a2oj6v1L+JiBoAAnPeqt/XRktRTFSHE9hsk1A0YiyL+7GBYZXuW5zEXGM761iUSCnrb2zfkSn92u0AX599QwCmzmIwzegurEJYpgxE=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5736.namprd11.prod.outlook.com (2603:10b6:8:11::11) by
 DM4PR11MB5296.namprd11.prod.outlook.com (2603:10b6:5:393::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.17; Tue, 10 Aug 2021 15:39:07 +0000
Received: from DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::2920:8181:ca3f:8666]) by DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::2920:8181:ca3f:8666%3]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 15:39:07 +0000
Subject: Re: [PATCH v28 04/32] x86/cpufeatures: Introduce CPU setup and option
 parsing for CET
To:     Borislav Petkov <bp@alien8.de>
CC:     <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-arch@vger.kernel.org>, <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Eugene Syromiatnikov" <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>
References: <20210722205219.7934-1-yu-cheng.yu@intel.com>
 <20210722205219.7934-5-yu-cheng.yu@intel.com> <YRFSg45dDMfeiGbt@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <c7867ec7-f03e-8928-3cce-88eaafd1efa1@intel.com>
Date:   Tue, 10 Aug 2021 08:39:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
In-Reply-To: <YRFSg45dDMfeiGbt@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR1601CA0016.namprd16.prod.outlook.com
 (2603:10b6:300:da::26) To DM8PR11MB5736.namprd11.prod.outlook.com
 (2603:10b6:8:11::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.18] (98.33.34.38) by MWHPR1601CA0016.namprd16.prod.outlook.com (2603:10b6:300:da::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend Transport; Tue, 10 Aug 2021 15:39:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95dcfa56-61a9-49a9-c0df-08d95c14fd8e
X-MS-TrafficTypeDiagnostic: DM4PR11MB5296:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR11MB5296C59D869269B8D921BEF7ABF79@DM4PR11MB5296.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sGTpjYa5Cfqdj07G/J9ZGdYQOsM3Q70CmkblpimpKmysV9QH7ZOBiY9eskX8oP04pEIszX8aYw8KBDPbwBeNwe3e990P+yVileTkNrfMmTCOxSjEGYyXGze5/KXf/8fL0AUB2Fdkmdj9pnxND3pKMGqZG2Hu2+gIu9VTngjGouVYwTR0WqBs4Lh7+fBadiJn3o14XJQ+wkdBsz6QxKHG7cEvvCYmRUlIVH8X9LOaibRnExggob3bKNaHw4hCVrJkiLwy8cls2ZqEFoMsLyEhFD8Kpzfg8QB76fu8SaE0cqbgwE1YSL4rwyRodm814kPD9WWFi3sC8kx/BtZNZY5LGFJ0A8OxKBJMnBtqPLJo3VFFguiFdgA4h+++extpjeywehBfmeZ0UThe/EAB0ypE4qSjA0X0VaIjpOxeg5vQ9Ti9N0h+ASVPtC6sut32l2DBQD1sHJ8RXhj/6qytB4AsBS0h6smXlVWsFDGq51eitRedgd+7pm/f0pj+WVzIiPjAdW45B3PSC6ngV+OhkZSOtnIX/VSWSFOulheQuEIhg39KqyhxQDDp3JW8DZO0OEyVb9tLJcKoXgWOS+Q9MkF/WL39b4SZEsgJ4l0OsQwJC19Jt85tLQ27o9aisr36WYQH0jqz9+9cv7BqjV5sqIygmK18BuDt3VbPUXqi16Oo98gj9VcWuXZRWqkSzE69GG1fEMb+q0NF+EyBMusJtUzJ9jCN+Ijf3NFNaGolqerDE+4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(186003)(2906002)(66476007)(53546011)(4326008)(478600001)(38100700002)(26005)(66556008)(66946007)(4744005)(54906003)(5660300002)(16576012)(6666004)(316002)(31686004)(8936002)(36756003)(956004)(8676002)(86362001)(7416002)(31696002)(6916009)(6486002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXpBMjdaZ2VSSTZaakhtMllTZWcwRk1hdGdnOWhlTW83b0NwbFFxM2R4cjFi?=
 =?utf-8?B?U0VBRDBQVXBNWkVUdnQwVG5RRVNORkNWRkROOFdZcHVQOUNjV0VXZmsyWFd6?=
 =?utf-8?B?NGVzWlNHWmdtSzNwbjBkUzVWUkpsN1FRd3lwT0JvTDhCQThYNndsWHg4NzNC?=
 =?utf-8?B?aUxIckJGNy95RE10N21KbHRQcWZHOWRlbVArSEwxc3lrZ1dvUWN3eFRHK1ZK?=
 =?utf-8?B?YkUySW1wVXRyYlNlZ0dTWlFwcE9Xa1QvQlhheGoxNTBhN0JwbUlrSmorK1Ew?=
 =?utf-8?B?TXYxeERVQjBSMVIzdUtNRFl2L0ltdFBlZ0x0VGpYSWY0dENqZjJPNHhmRW5x?=
 =?utf-8?B?U1ZVVHFUWm1OUURxajl6VzRMZENqWlR6anV1MXJ2R3A0WUVDQ2xGWDVDOTRx?=
 =?utf-8?B?NVh3UGZ3dDk5azNiSE1qOXdsdS9jbTBqTHRJQmdMcnRVbHQ3SmJ1ZElRWVVZ?=
 =?utf-8?B?MWxaWG5ycHp2b2Z5YVVTRVRpYjhydHRtQzVUVFVtbC90dDhNM2FGeFJ2WmJE?=
 =?utf-8?B?MlJZWWRVMXAwdnZCSWE2VzlpOEJmbzZHcGpkVDhvVGVPK1dKTFM2R2x4R283?=
 =?utf-8?B?eGV2UzdSancrVmlYOVhhb2pWK2xqWTg0K1J6ZGxMVHdSQmpFM3NkeTRncHhY?=
 =?utf-8?B?amZhVFVYOE0xLzBOV01uSmE0RHFUSWFiUjFma3B3REkrbFAwR2YzcG1ycGxP?=
 =?utf-8?B?dG5GVy8wOXdiS281cVlzRkNXamJqaE1pRUx3dHEyNFNMell5VTgvbmdGQUpZ?=
 =?utf-8?B?T3hEYUFJV1VSaTZscy8yVksrTTczeDA4NXJXS0xUY2ZzWjN6WU5WRDJEMmJr?=
 =?utf-8?B?aTc1aC9oMUFoTy9ZdURwejB0QWNVaCtJeE1MQ2lPUDU2RmhUSEpNWDErMzBL?=
 =?utf-8?B?blhxS1VnbkhQUXY0eWc5MkdtMlU1ODFuZWhJS1BlVndXSnFpelFlek1KWUc2?=
 =?utf-8?B?c2x0Um5HSjNpa0NhUno5cVJYMCtnMGNQQlJRb2t1S2VJc2NjQldjVlVMR1Yz?=
 =?utf-8?B?TUZlSk9qOXpRc0p1bmRtSEllN0c1VDN5WC9IbWY4a1lGSW5vNEZmazN0VnZt?=
 =?utf-8?B?M1NsSzVPNFkyVHJJVEV6azF1YVNCQklYSnU5UUVIdFZ0bkRNVEVYMUJtOE5F?=
 =?utf-8?B?VmgrelAxY3UwbWxGT2dxNHlqWEFxUkd5Qm0zdjRyTDRNNHJRWnZQQzM1VDBa?=
 =?utf-8?B?NzlOTWxaQk50SDQ5U1o0SmxpVVJHbEU0TmdzemtRbnNKRGZ5UkFMY3RUbk1M?=
 =?utf-8?B?cUpHTDhWdnJUVDRyeHNzcFJEc3Z1MExUaWI2WTRpSWdjV2szY1R0NWhBMllO?=
 =?utf-8?B?eXE5dWJFNG9HZGdRRkFxa2lEczc2V0J6Q3JFYldCdytBdVowb1pobUN5dHZU?=
 =?utf-8?B?YTc5UnBjbTM3VEdSR1FYZjBNS05PQkJrZEp0WEFYMlg1anhsWitEeTVSRnJo?=
 =?utf-8?B?ekt4UEVCSXVtaVBjWG4rMkNTOGwybkRMSUdvVnZ2WFY2S0srSzdxQnB3UjZQ?=
 =?utf-8?B?VHFOWXJKTzgzalB6dHZOQUJqU2NCRTFaUjVRVnNlUXVpRnVvY2tVZ25uL1lZ?=
 =?utf-8?B?NkNHTmd1ZWR6Mk94Vy9vMS9oczFPR3BBMVJiRytsR2Q2dHZqQ3FSMkc1RTJm?=
 =?utf-8?B?OXdERkFxa0l2aW5XenR6blBFNm51bmQzUnRybnlMaDF3WitZYU1OWjBNQ3kw?=
 =?utf-8?B?ZWxsTmdqOUZ6Ukp6N2taOXlnWWlGdnFEU1JuaHo2TDBuZHljZnpIUkVkQVhE?=
 =?utf-8?Q?07iYJYnhQQG/X2VKMg0tpTuKonKtTIgeDP/Uw13?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95dcfa56-61a9-49a9-c0df-08d95c14fd8e
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 15:39:07.4769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JMR7nEHGjLlrFQo2s+J3LrlzDjAfijVUfdsuC+JrPbeMnK22JpcSbfiFzgLKmHWF/tAa3coaYQ7VnU3eBFRzJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5296
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/9/2021 9:06 AM, Borislav Petkov wrote:
> On Thu, Jul 22, 2021 at 01:51:51PM -0700, Yu-cheng Yu wrote:
>>   /*
>>    * Some CPU features depend on higher CPUID levels, which may not always
>>    * be available due to CPUID level capping or broken virtualization
>> @@ -1249,6 +1257,11 @@ static void __init cpu_parse_early_param(void)
>>   	if (cmdline_find_option_bool(boot_command_line, "noxsaves"))
>>   		setup_clear_cpu_cap(X86_FEATURE_XSAVES);
>>   
>> +	if (cmdline_find_option_bool(boot_command_line, "no_user_shstk"))
>> +		setup_clear_cpu_cap(X86_FEATURE_SHSTK);
>> +	if (cmdline_find_option_bool(boot_command_line, "no_user_ibt"))
>> +		setup_clear_cpu_cap(X86_FEATURE_IBT);
> 
> Patch 1 says:
> 
> "Disabling shadow stack also disables IBT."
> 
> I don't see that here.
> 

We have X86_FEATURE_IBT dependent on X86_FEATURE_SHSTK (patch #3).
