Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437093EF1C8
	for <lists+linux-arch@lfdr.de>; Tue, 17 Aug 2021 20:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhHQSZQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Aug 2021 14:25:16 -0400
Received: from mga12.intel.com ([192.55.52.136]:35943 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229850AbhHQSZQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Aug 2021 14:25:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="195745259"
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; 
   d="scan'208";a="195745259"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 11:24:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; 
   d="scan'208";a="462498504"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga007.jf.intel.com with ESMTP; 17 Aug 2021 11:24:41 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 17 Aug 2021 11:24:40 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 17 Aug 2021 11:24:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 17 Aug 2021 11:24:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 17 Aug 2021 11:24:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krdkEU1hDsJ5tbnE7jKeYp5RBBjLtZ3PqIQXL3+S+FcttIQahmd0bdAtTI9trelIlv3VpYOrrnmbiJKLQX7kfQdtw5QxNxN7EH8q/Acf3PfJ+R66hG1h+e200inG3Q1Trf6weUcXuH5+X9oKcoN6a2zkHLJwb7NnkQd2hurp9/+8tWK8iFhZuLZdEnWq5BGpC5iAax21UtjOhR0g9WPmsq6nk/gFSn65E+mNdV+AyaKLxY/wGODHCmgIB7+Vuza0jSeEMi8PGdhSClS/MVZlUhCPfkmREQN/LhA4dcmBoektNF/I0bRvcw7qmuoDZ2w0L4VMZkNb/Pu3s0oz4ezBPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SekS6hB0z4Jnzx4ZYwvc0HsUsEUGxk4+PcxFPZbZVCA=;
 b=n1NJk5Qjzi4i8f7r6AUJZqjDIKXJ7OgtxRAo3MOKy+gql8NiDaTaIpuqhZYl/cOHGbKaAO90D0gXTmNHISqzgweYZ2/txiAnu+u6XKULcjmDDSnQ8/zzMsQmpoMCZq4c9CobWm4jDm6lyI8fvMvZSk1wuCghg8XQYxamj1nUfndk8EYcPWbI/4XNjn8ptHWpHtMwHsXLX8qWaZaoif31oMpVEZ36EsZgUlqwWpRlQzt3hS7CMTHSZa8VuncgKYP8yWPIr6vM6+VdoSDr6SoL93U7UJAvw7q/B0sP7blJsYJYcbmpXtl1Xyky1c+OA9BsQcgOUDQoSh0rljbY+n4+Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SekS6hB0z4Jnzx4ZYwvc0HsUsEUGxk4+PcxFPZbZVCA=;
 b=C3hVUfzvn49iZ8Vh1tHF1gsk84o/vKRpm5ifBow+FnVkFGf8ldYmOIfObr3i4Kjc1yb/CXWSSyDFnIfVvLFJVTZq2IiUERh445O6inJH8GMvi/g9dYdRIOnQxDJQ0HwlAQIxFmHUPN+orR72YiWYus6DybVDbD5y4jOWw+CQ3DA=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5736.namprd11.prod.outlook.com (2603:10b6:8:11::11) by
 DM6PR11MB3068.namprd11.prod.outlook.com (2603:10b6:5:6b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.17; Tue, 17 Aug 2021 18:24:34 +0000
Received: from DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::2920:8181:ca3f:8666]) by DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::2920:8181:ca3f:8666%3]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 18:24:34 +0000
Subject: Re: [PATCH v28 09/32] x86/mm: Introduce _PAGE_COW
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
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20210722205219.7934-1-yu-cheng.yu@intel.com>
 <20210722205219.7934-10-yu-cheng.yu@intel.com> <YRpBVu7dCBjks71I@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <59b9b98b-28e7-fc13-f13b-0079e184826f@intel.com>
Date:   Tue, 17 Aug 2021 11:24:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
In-Reply-To: <YRpBVu7dCBjks71I@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0191.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::16) To DM8PR11MB5736.namprd11.prod.outlook.com
 (2603:10b6:8:11::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.18] (98.33.34.38) by SJ0PR03CA0191.namprd03.prod.outlook.com (2603:10b6:a03:2ef::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 17 Aug 2021 18:24:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad3b96c0-d87f-49ef-82ce-08d961ac4329
X-MS-TrafficTypeDiagnostic: DM6PR11MB3068:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB3068DB42AEBA0909137E77F1ABFE9@DM6PR11MB3068.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: arVcz43wtCuSHlnQ0Ox8zvWgkn3VXEFiqeeicErktOPtzDKL/AYB72aSlsNfqwhEmS/wak8ajf78SNrlpwgwlJh+mdnx3BlfF2a+SP4YXvSgdx4VwxpSn3rTyDGlP46N3C4/Ml6JuqGZsqlLIorQ2EPySzqc+zVE4AHybZ1BgCaqWxVZhwb7A3Va746EhWd+gxb2sxWrpKY+S4px9Yl1R6+6Cj4sSG5IG5u2jDe+rB3rIobLKhw9FtXF0imnEhnwzftLgWnW7uXKJuo+dLiz37WyVeYe+4cl9jHlZnVF8YR2k/71TRdZXl8WG6UMppPXAttzLFE+HWSXd0xzFefZZjLiQgel73jD5sOSTq5wIJnv22CJKs0vsPvqzFLdpGK+euc3Ga1LzZX7t28qOjZNW/V6IKPmhKmUuAZjSI9dMdq25ZA5373qyKHfN1RDlIF9N22AaMvqrQCwdtm/pJovlKHKcSh6stCvJ2ZKMgS+xE62CGQJLL8E9tgCn5eC2NG7k0WxmwpjuDIayxKGAc+AhiW/leEk9CayA9lxc0eBjxsVpcHUHW5lkvioxUCsVpVu0rkiQyafVViSGAKesKSgQN1bi/LhbYClvU0etIKOVh6TW98daghWcTM8rTEsyA5HpWgu971mECABTYKX/qZG6bpW2taskQxd7C5UAPgO4WlpKQX/6BeKHrwxosa5pte15kdYl5QpZfe/4MqDu72m82w4hUkukigExRSRLToJUX4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(6916009)(5660300002)(478600001)(4326008)(956004)(2616005)(186003)(66476007)(54906003)(16576012)(26005)(53546011)(66556008)(6486002)(31696002)(31686004)(36756003)(66946007)(316002)(7416002)(86362001)(2906002)(38100700002)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3VWelNlWUJibWMrQjJma3ZJSFMxbE9KNVZRRjNkbC95QXlIUXRocmRtYm9i?=
 =?utf-8?B?b0pDSTdSMHRyN250T1FFYWdLTGJqbHlaMWVmQkswQjBUQ1I3c2xoZnh4T1ho?=
 =?utf-8?B?bDIzbitUOE8wTU04eFZQYnpXVTU1RzFpTU9ZUERMcGhuaFBOY0xmUjNEUHRz?=
 =?utf-8?B?YURtSEIzeVczUkF1bHo4ajhndVozait0R2wwRWZzRjZmdWpScUtTMFMrSkl3?=
 =?utf-8?B?U2tCdEg1UW9Xa2hhWWZ6dEhJSjlYNE5GbzFIK29WdHB6ZXNyZXpQZGl6NTQ2?=
 =?utf-8?B?NjZtT012QTZEWE9jY3pOdDRRWWU1dGsxb21qWGtFQmVBWWJEY2E1WEpQbGUv?=
 =?utf-8?B?OVdVallyajFlOEIyd1BMbFV6U2cvVTdRMmhWNUpzUEZWQzNEWWNTRWYreXVJ?=
 =?utf-8?B?dkJuTUdNd0Q2SGNubm5TUy9UcHRYU25kUmF0VGdDTjZKUTl1OTg1TmtQeW1w?=
 =?utf-8?B?VnNnMDBjV0U4M2pla21RTGxOZkYvQ1VwM1dvRUtTL3RxdnYrM1k3UCtoc3Ey?=
 =?utf-8?B?cW9wRDMvbEZYWGhNTjA0SGpWZGNGbmVDQ0VDelpRUXQxNEhWVFk0amQ5TU9j?=
 =?utf-8?B?N3JiM3NJQVVLNU12b0d2WVM5RitlVmdOS29qRXhjTGRyVDV3c3ppTjFLaTJV?=
 =?utf-8?B?M2wwaStXUnU0S3gxMEowYTU1Q1pjam52ZE0wRmFFTjVpYnBtUTY3NnE2STlJ?=
 =?utf-8?B?c3VtQk5iNGpEWGQrR3hqbldMWGtwa0cyV2x4UVJaTnVlWVdvdUJjRzNuR2NV?=
 =?utf-8?B?SmlPM01lVXU3MXJDSE1XaGZyUVFLWi9QQjBsS2dKRFRLVmNQVDhabzVDSnR5?=
 =?utf-8?B?dklSR0VXR0tlMWdlL3lUZmVqVGErcFBPRnFST3hYYWh0UzBFNzhGVW5UYnUv?=
 =?utf-8?B?NTVTc2Nac0l1VFVyVG1MVnIydXZLWWN1ZE5NLzZUWlVPUDMxcjNtZW9MamZk?=
 =?utf-8?B?aVZRdkttS1RhWkk2VzAveWdwSEUxU2h4VURWK1VyNmRINjV4eFZKRTBHSWhM?=
 =?utf-8?B?NXlCMEZJTEJoUEJES2ltbWNNT1Fyb292WjVHZGRJTjRuWE9udlJiZldBbllk?=
 =?utf-8?B?Q3lkUWNEcklIa0hic1ZnSi9rdFpoVHhyRlhyZmxwSXBsVTBlMDd0WHZpWUZ2?=
 =?utf-8?B?WEtXTjVvMjlaYnN4b1k4aWtHUzFzWVlSMUM5bmJpajE3S09YU054T0owRFBy?=
 =?utf-8?B?c2wvaCtwbXUxV0gyeHFlN1ZnUmhvek53Yy9uWGVjbHh4S2NDam5nOE05SWEv?=
 =?utf-8?B?QVZGZU1zamU1UndhMXd2dzZBZGphVGw4YVlxK3owOWxhcnplUlRtT1hpY0hZ?=
 =?utf-8?B?YnpHb0pIYjQrdFp4SGZKUWRlb2ZWMXBiRFA4OFBUY0RaaEdSckJaZUx6d1pI?=
 =?utf-8?B?WG8vZ2w4YjBRT1publMzekt1WElSU3h2dXg3S0pSY0twOU8wMjh4UVNkRC9G?=
 =?utf-8?B?NEhvVHdXekJaWUVnM25UQTc0RUZzdjRiVmhmdHFsbTBPZW1oTmRkRUNpdm5r?=
 =?utf-8?B?NXQ5d0JUazlHZWRmWDdYTEpOWlkvOW9PdWxVbW9qOWFGY2NWbE00L0Q3TEo2?=
 =?utf-8?B?MWVRcm11NVhQMlA2U2l1NHhFMHhmTW84MzlQMzltMEY5TGI1SEk4d2tlMmRs?=
 =?utf-8?B?L0p6QkxubEF1cGVPV2dlV2tHVHlFNGoyYUUxeWRVcEdCTXRoZzNoVlU3Wno4?=
 =?utf-8?B?YXFKU0I5RmduSVYrVmZVSEc3MnJiZXdOU1NuZnhEbG9ISk5ZNWFiU3FWdUhq?=
 =?utf-8?Q?3vW/5hYvpN5OqTHwuvG2gvLkMomMU6Y9Nu2ZO8M?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3b96c0-d87f-49ef-82ce-08d961ac4329
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 18:24:34.0680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLIk9cIPCBvnZKi/f6GUVI9j8PocamTgXp470m408C0zgQRJpSRNrzdgYqvuCEIQcaEv84Efn0QBFuJbnkOxsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3068
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/16/2021 3:43 AM, Borislav Petkov wrote:
> On Thu, Jul 22, 2021 at 01:51:56PM -0700, Yu-cheng Yu wrote:
>> @@ -153,13 +178,23 @@ static inline int pud_young(pud_t pud)
>>   
>>   static inline int pte_write(pte_t pte)
>>   {
>> -	return pte_flags(pte) & _PAGE_RW;
>> +	/*
>> +	 * Shadow stack pages are always writable - but not by normal
>> +	 * instructions, and only by shadow stack operations.  Therefore,
>> +	 * the W=0,D=1 test with pte_shstk().
>> +	 */
>> +	return (pte_flags(pte) & _PAGE_RW) || pte_shstk(pte);
> 
> Well, this is weird: if some kernel code queries a shstk page and this
> here function says it is writable but then goes and tries to write into
> it and that write fails, then it'll confuse the user.
> 
> IOW, from where I'm standing, that should be:
> 
> 	return (pte_flags(pte) & _PAGE_RW) && !pte_shstk(pte);
> 
> as in, a writable page is one which has _PAGE_RW and it is *not* a
> shadow stack page because latter is special and not really writable.
> > Hmmm?
> 

Indeed, this can be looked at in a few ways.  We can visualize 
pte_write() as 'CPU can write to it with MOV' or 'CPU can write to it 
with any opcodes'.  Depending on whatever pte_write() is, copy-on-write 
code can be adjusted accordingly.

Yu-cheng
