Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00343EF1F5
	for <lists+linux-arch@lfdr.de>; Tue, 17 Aug 2021 20:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbhHQShI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Aug 2021 14:37:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:41145 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232769AbhHQShH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Aug 2021 14:37:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="216166234"
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; 
   d="scan'208";a="216166234"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 11:36:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; 
   d="scan'208";a="424019233"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga003.jf.intel.com with ESMTP; 17 Aug 2021 11:36:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 17 Aug 2021 11:36:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 17 Aug 2021 11:36:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 17 Aug 2021 11:36:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPYiaq3s0pV/LJ7Yqeanv7Bvr7YgyO45UiISOkvCoW92W3g9v6DfeyHo0e6su3IZmRHQAOUlXYOhaW4gGIULW4sOi2sj4xvmtSIe5A/bs9DnGgAY9MvZVkdtNZTp++jkogx0yzAw3qdHOJMVHXBmktvzvIVROhcQaM3zWfp5MH34gn4Rl97koSXybesw3NH09/9c3SJ4vw8tufafVtTcm3fZYGhcsUKt/ZYLpQIabPETAzf0t01DckfTRR2pcflyPIvsdLSgJ+KAij7AgnuQYMgBRbjq31D3vB8dQyCp9a+ZaEfUGBobppeAAE3a65IqNzUcdnf3NyZ4LkDSV46ujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxHM1rMM0pXS/6ZcI7UK5+gOfX+7MSRAyODcBZYx3sc=;
 b=YaTHzC9CRRQWNFw0iuKtCuUUGbmh2uG+nq0dus7YHc8+FyOAm1T451awkr2Q8hIhzthKz4TntDxVmziUHRyZUonz930B2/dWUrSYIr3B+ILOalA3XZLeglybeXPb6lgm69VEKPgZEO//ZW4XvOu/4IOsUuOhqhMqyoawRYYa2X4aeLPbEj8QRucFomduvRNk/RqAADfTf0b+RjH1c6tWkeRJ+NkTDM17u9lx9jw1O/qvRM9H+lXydEw+u3s+4314lpNptrv3lOjQLCxmCIDjLNQWo3LQckQEXfn3htblYQOOUriIxeESuD7sjYj3eTHjolUfUqqE6aUg86lDvxay6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxHM1rMM0pXS/6ZcI7UK5+gOfX+7MSRAyODcBZYx3sc=;
 b=md4mcuIN7qx5UkUGDQ+savMoeVhl1lH5n9VB4vK2ZDrI0QMdD/70B9dHDl5VYwjh7aTu/Ar0a+6KEUegvEulJislRqs3YQp2Xhfw3vkB6CcU9Cu5M1tpE4ILmuNI+prg3Gm+aIewDUGy6rogt1oVweATNaYBW7A34r/k/iKJZBY=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5736.namprd11.prod.outlook.com (2603:10b6:8:11::11) by
 DM6PR11MB2603.namprd11.prod.outlook.com (2603:10b6:5:c6::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.18; Tue, 17 Aug 2021 18:36:27 +0000
Received: from DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::2920:8181:ca3f:8666]) by DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::2920:8181:ca3f:8666%3]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 18:36:27 +0000
Subject: Re: [PATCH v28 16/32] x86/mm: Update maybe_mkwrite() for shadow stack
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
 <20210722205219.7934-17-yu-cheng.yu@intel.com> <YRqaesuEy9ZGttZ6@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <87cbd676-5b60-da55-1f95-c5a6ae61e3fc@intel.com>
Date:   Tue, 17 Aug 2021 11:36:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
In-Reply-To: <YRqaesuEy9ZGttZ6@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0119.namprd03.prod.outlook.com
 (2603:10b6:303:b7::34) To DM8PR11MB5736.namprd11.prod.outlook.com
 (2603:10b6:8:11::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.18] (98.33.34.38) by MW4PR03CA0119.namprd03.prod.outlook.com (2603:10b6:303:b7::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Tue, 17 Aug 2021 18:36:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf159d98-1e4e-457a-e370-08d961adec12
X-MS-TrafficTypeDiagnostic: DM6PR11MB2603:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB2603FFA08D4AC1C95D901ECEABFE9@DM6PR11MB2603.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tY8TS+FsahifQtR6Q0ctIq1NaWsYdsDEP7LKtm7gV8QvnQC8buT7IUQsdmc8HiNjP7e17OO7fxBngH3I7cGsH6UW6/2odnNpQhx0V/rKWQpzFGxTNSrqmxtXByZLwrzlMvv7g52AmmYPmlCv6dU+XRmyMrr3YhLeLfXM9fSaRUVCcvl7UaQ39zgrdq9SBv4Q5DKYrsp6cHjhjyWqqgH5V6Y3YooqE6DzkPPxUkenz7BIJruJoY7LMkXw4wX7OexwAiPjbl1j0C+37lO36Z3pfnZ1/33BpeZPYlj6T5ezL2v4pWerUB6Cy0Aeyxdp05CA4+xIPz0Bzqqy4HMNztzvXj7LZ2VMpsal2ts2m4qTJVCcJ3uvlShx4fRq3TobJ3lPNoX1BIfWxL1gXlwhrWCKOl5xSM8v8WsD4K7esbVt7/LpRklLQVRuiNzbXUotM9RN2PQzP6BWBgODlSle8RedKyynPvWwfpCGJ5CvXAQdNsf6+Fd4HStIRQCfRb6AQzE5Z6n0ypuOG9ExXEzDe+6M6Qi0dJQNbBMZ9yHkNvGswNbYlunADTZ9z6fpbr2D0Zr6Vy2Q97cEGPEIuMRINlW/dSdWLO/ds9iQBcq97hjPeaEmh45C6u5vBSWEqcig9/bi/yjIaWuNbIqOvAfh77wzfeUt8QYK3ptijE8p2cnU+dCTN/aRCpHkMCpGDxheDtJUp0Jva2k9GCClFmexzhf3YdJP5WW25TkLO1aoFp1wTuI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(8936002)(2906002)(38100700002)(316002)(16576012)(5660300002)(7416002)(4326008)(36756003)(31686004)(86362001)(54906003)(6486002)(66556008)(6666004)(26005)(53546011)(31696002)(186003)(6916009)(956004)(4744005)(2616005)(8676002)(66476007)(478600001)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk1uNWY4NjlJeE04aTA3bWwyVFhLcFFiWThlZWY4ajk1dkRid1lzYVc4STBt?=
 =?utf-8?B?M0hFbDBtVG5SNHk1RjZjNjVMb2pqSElHSEpuTVV2WUlJQ2pWemdKM3Mzd1JV?=
 =?utf-8?B?cXUvSFBXR1RNL3B4dzZJZ0pLM29aOTZKT2ZoMTV3RFhJdXphMHVOTlZEcGdF?=
 =?utf-8?B?ZlRTcE43NUVGVnVsZHV6eVgwR1pvMnhQKzJhRnRqRzBnSWlHRXBuazZRRGRa?=
 =?utf-8?B?QmE5SjlpU2hsbnNMTG9tdDRFdjFmVVZNZGVYdEdQR1FzK0JVNlkvWFlqbld3?=
 =?utf-8?B?RElENUJpSGRFcXo4WmpKa1BOL0QwUzZJTmxWWDY1cnkzSnJ6amh5ZFMwY3pO?=
 =?utf-8?B?bTFpM05kZmJhNEszdFlTQkRvOEMrM0tmR1Q4YzdkNitvYXhQK29jQlVpR3ky?=
 =?utf-8?B?VkQ1MU5HRytWZ09heXhnWm4rSFhQeTcwOXJOb0ZZUVVQMlBWYzBxc0FnbVFP?=
 =?utf-8?B?Y2l5UlQ2Wi9IR24ycjhWalBqZDFBejhydEJtMVJsSGxnbWxjQ21BOUdiR1dQ?=
 =?utf-8?B?NjliOGlZQ3ZCM2VTekhOQjVWOSt5V041S1NTQnZ4enZYZEJ1aXZIOE1EZzFm?=
 =?utf-8?B?WWJwdkhTYTJiRzVWRTZJQ3RhNVRuOTBJQU9SeGdsZk9kcm42VktBdEhIWnZF?=
 =?utf-8?B?dmlFQ3B1cFM5QUtOVjZKL3VIcERDdmx3OGRrZFp2a3g2N3hmMjhlempvaHRS?=
 =?utf-8?B?QytIZ3RwWnJsMkJpeXhybTA4Qm5vd0VmazZuUDVCa1MzdjJxdXd0Y2JLV1VQ?=
 =?utf-8?B?cGpqdWIrd3NuUlA0Y2Jtb2JNQjJjTThVREY4ZnF0T3BsWk9LYmRlbTNKQUQv?=
 =?utf-8?B?Z3RtS2JBU2xmQm1CU1EzZDhEaW1iTGk2YzUvdDJCc2crTW1JZEVhL09NVzB1?=
 =?utf-8?B?b1hwNFVUNUdMVS9pWmxoczhDL1IzVFU2dFIzeW12YzRJRFZscjhXSGFUYWxl?=
 =?utf-8?B?UjZ5WTFKTTRzd1lLQ0RwOWRPYUY0ZmxpZE5YMDJmakdsWmtodzFyVUxJTlFO?=
 =?utf-8?B?cGwwT0kxRHlab0Qyc3B6cFA3SUVWY294REpsVmh5WGhUaUM5TkpyaTJmTkI3?=
 =?utf-8?B?dE1VYkFNMzZEYzAvN2ZKRE00M2tvOHJlR0cyZWxrM3lTQXBqalNtdWNRekx0?=
 =?utf-8?B?Rkl3QzhGSW4rNHZ3SHFjRW9MWmNFTHJNWCt2WFdhWW1wOVhGSkRMOFkvRDF2?=
 =?utf-8?B?a3Mrd3hFL1ZLS2hLK1QvY2dBTmticTUyV1h2bTh3ZlhyYlJjS2NYN2h5b0Jt?=
 =?utf-8?B?OE44Mmk5RkdidTUxSmNDWU5EN0tWZko0K0xNdTBQMm56Q0R2eWVKcGF2TlhV?=
 =?utf-8?B?aWFCdDQrU1diV0FzK3JvUVNBcFZaWWNWU01xYjdqbXhZTGJ6NGNBRVNLK01p?=
 =?utf-8?B?U0ZidlJGd0RtWHExZ3E5QUx3c2wzeXZndGxObk5ETjZ0Ry9tZkgrQ1RlTHlo?=
 =?utf-8?B?RERvdGpVRUFEZmVBdFhJRHh0dGxleDhESG9lVkhXREZ5M0RHOWxsNzhXbXRE?=
 =?utf-8?B?Y0hscjN4WFFDWktjbFV2RGVqTFlHeXp2d2E4TS9mL1VLSHUvU1kwVmRadlVY?=
 =?utf-8?B?Q1ZJOEp6OHhMZTJ2WE52cktaL1BZU3ZuMy96TnFWc1NacUJaeGx6alNHa3Bz?=
 =?utf-8?B?OHl6Szh5amtRK3loOGVkSS9teXFxNHVQNXBSMVk3S2IzbnJmazFxUGYrb2RR?=
 =?utf-8?B?c0MzU1dLT0lzZkFWQWRuRU5oQi9icWhSdnU2aEtad1F1Y3hkUngySFFPUkQ4?=
 =?utf-8?Q?bkssoWUUTXDVyhESaTO1xv6F9Ig9DlCpVpk2FcQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf159d98-1e4e-457a-e370-08d961adec12
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 18:36:26.9982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkBGc2AM/Mh53mBS73ar+DTjg1WilBpahQOSluJVBwaa+2PRsyU6hhfVUlv3nxfQ82TNch1x/Rv+PqnKt8z5Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2603
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/16/2021 10:03 AM, Borislav Petkov wrote:
> On Thu, Jul 22, 2021 at 01:52:03PM -0700, Yu-cheng Yu wrote:
>> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
>> index 3364fe62b903..ba449d12ec32 100644
>> --- a/arch/x86/mm/pgtable.c
>> +++ b/arch/x86/mm/pgtable.c
>> @@ -610,6 +610,26 @@ int pmdp_clear_flush_young(struct vm_area_struct *vma,
>>   }
>>   #endif
>>   
>> +pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
>> +{
>> +	if (likely(vma->vm_flags & VM_WRITE))
>> +		pte = pte_mkwrite(pte);
>> +	else if (likely(vma->vm_flags & VM_SHADOW_STACK))
>> +		pte = pte_mkwrite_shstk(pte);
>> +	return pte;
>> +}
>> +
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
>> +{
>> +	if (likely(vma->vm_flags & VM_WRITE))
>> +		pmd = pmd_mkwrite(pmd);
>> +	else if (likely(vma->vm_flags & VM_SHADOW_STACK))
>> +		pmd = pmd_mkwrite_shstk(pmd);
> 
> What are all those likely()ies here for?
> 

I will remove those.

Thanks,
Yu-cheng
