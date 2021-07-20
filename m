Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984203D0000
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jul 2021 19:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhGTQfd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jul 2021 12:35:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:20594 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229779AbhGTQfb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Jul 2021 12:35:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="272398710"
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="scan'208";a="272398710"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 10:13:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="scan'208";a="500833768"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jul 2021 10:13:58 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 20 Jul 2021 10:13:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 20 Jul 2021 10:13:58 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 20 Jul 2021 10:13:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wd7nfJiN/efwlagqwpy/ULSRbEL0Nw+IOuCW+iQjFocu9aHvPg4PENIUoPWzOGD6tPREZItFL1OuvjS4XaSMqXoRGBe7pk3hLy4g/FG0XjQ+1VdIoth4L2yh20ZmZd1bkBXA4AMeH+mGaGSH2uya2JTE3FsR4lWyGt4XdaNBTLtcwi9K2EsvGXLbbm6zP8cEo21p3iOGDBszDVkZiYICfoGioPxm/Qv8pzf7jHpY36gbVXXW8ybev53jg/YDViX2PGCNXtBCN4PWgDuq7bNBmnbXot/0/AUvWKk4/9u1L2HhADXgeKAdB0ru8q16VCa3Z4iDrofmFxx9/gJ0zV8Hbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1B1nHfnBy8kt9fksJFNGGqd0I9Jf5DlYWLV7KNWob8=;
 b=ZOLuKpmbO6PgHJyuLkQZaWdrkmvLymFBFovIt7z63Ne0XH0kQmDdvSHJmNdleHRrGmyIa9VMUi/W4iUPOuDArnb9OM8CjArV64b15OpRvEcSf6Y+cHTVFjgvCCqJyv/gTNMqfLIebzqP8KS8r1y/uQbp3TuUIvp7wUtK3i9T3A+2QUSmAjbzw7YLKz67GEQ7/rSvsrZVoY1ADmrBoil2O9XUjHvCqxQtBqWBactUkhFZTjiKGZEX8fIbOTz0hWslHzq+Sa7d884drTIoTIPIILamaigUBIh9OOeXRL/ZWiNXjvenB4jN+Tou5tuUvdHNIbibCMffEK3iQK2LvucwJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1B1nHfnBy8kt9fksJFNGGqd0I9Jf5DlYWLV7KNWob8=;
 b=m4Kl34ICihNz9++O7dTMW04H3/1C0432AH527yiH+MzP4DyUI0bGCJnG+OeYOub2YElTQuRIVX5dfYXyiTA7X1hnwKju8Yc+ID7cOk1KyC3jLF43sIaw5kV/F/mbMGIYXvngrxU34ta69JL/r9QXQ9LcXCdC/w27+o29YwdC6eM=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5736.namprd11.prod.outlook.com (2603:10b6:8:11::11) by
 DM6PR11MB2713.namprd11.prod.outlook.com (2603:10b6:5:c4::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.31; Tue, 20 Jul 2021 17:13:51 +0000
Received: from DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::b5d2:99f4:cd51:f197]) by DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::b5d2:99f4:cd51:f197%4]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 17:13:51 +0000
Subject: Re: [PATCH v27 23/31] x86/cet/shstk: Add user-mode shadow stack
 support
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        "vedvyas.shanbhogue@intel.com" <vedvyas.shanbhogue@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "esyr@redhat.com" <esyr@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20210521221211.29077-1-yu-cheng.yu@intel.com>
 <20210521221211.29077-24-yu-cheng.yu@intel.com>
 <798a369d3e7339a42f390321b56423cafd4e477f.camel@intel.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <44269526-6b77-f300-90cf-5501feac426c@intel.com>
Date:   Tue, 20 Jul 2021 10:13:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
In-Reply-To: <798a369d3e7339a42f390321b56423cafd4e477f.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0354.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::29) To DM8PR11MB5736.namprd11.prod.outlook.com
 (2603:10b6:8:11::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.18] (98.33.34.38) by SJ0PR03CA0354.namprd03.prod.outlook.com (2603:10b6:a03:39c::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 17:13:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8271ee5-b309-4e43-24e9-08d94ba1bef2
X-MS-TrafficTypeDiagnostic: DM6PR11MB2713:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB2713C42D29BBAE2A34320A4BABE29@DM6PR11MB2713.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dY4WbcQl00Sdyvt/7H4LJAnyx7SXWHkGEINoZQFF+vGEtK7AWuMJituTfB/QAFFbOIjHrrLaMgALtRi8TKIkpX9UTndmND6N9U6ad4+WWlxfmiKNXjvre1EoqctDsmN576sllRb/34+BMuxuWUWzjTgupIA1CI9LFFkGv9rL9OVL/3bkp3csexPgDZUT3cABwKfYf2cTdvC/VsMoDvii7k8q0Tiei4+8N9Sdo2OdhrI3mO/Q2oUEpOtrnHYxOrsIcU2oNrCfMRRkuKBQmdgTnFGM1b+WPMYqhjvE4sPmrVq9JlhLJb+b/RwR0gg/1hGw5cxZ+bC90NkGOhXzDeXD4eZlIiy7hJaWDgpx+iCcLrfyWLaTKfWMzlOQ2+lB3kcqyKvaXHmCMb9Kq3KdXkBu60ltcKMbAH63GPsUZgazwIZeaKl156KYwlFqoa+KuisD55jvvDpl5WWoCbx/pL0UNJWvqPeOH2CaYDwmlsWcVLxZf9mGcvO6lBJ/Bjr6D9IV16Zd7QRCrFTENnk76F4rEe0A9ijOcoRHnK3V26U3VFEouw7I1G5cTfr7yRC5sejY0nbpCLwnOAAz2t/dFzL9GBlsqkt8Q3x1EFh0SqiDuBBmhljUCg9W4z33IH12h4dppfZ0iNiaGWUBCxyN3Y6DXJuL4H54/jUc4A+utSpg1LjIuDdDC6JWw9sasVGcXrauyr6pTwiIVs8goYyAGNM5/TdFoRYPCrl+rHxLN6EMhSCWIF31ICenAfZHqvpzGEtI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(53546011)(36756003)(66476007)(26005)(956004)(38100700002)(83380400001)(921005)(478600001)(2616005)(6486002)(186003)(86362001)(8936002)(110136005)(316002)(31696002)(16576012)(2906002)(31686004)(6666004)(7416002)(8676002)(66946007)(5660300002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rzl3d2lpMWs1YUlMejRXOWcxaHdjSFFvTUFER09JMlhwU1VpZ2NkTjBSRS9B?=
 =?utf-8?B?SWFYb0RRbnlyVHRJdEhHbHZ0QjdGUDUwdzBuam1iUXdQam1NM082ZlR0REYr?=
 =?utf-8?B?a3BRdHZrbWU1aW03N2FVZFlVeVFYdHlneWxSdXpSUWVOanovSkNmVkRUM2U1?=
 =?utf-8?B?RWljYVIxY0dORU8rQ0grbGd6YTdzNlYxV2tOYWwzWVM2R1Myc3ZBZHNhOVEx?=
 =?utf-8?B?b3ZsdHFoM3V4andsZGNaOFdmUHdYR0FZZDVSaVVTSFFKcit2dkEwa0JnWUFy?=
 =?utf-8?B?dGg0RnpZQk53YjF5bXZMRTlSQmZHa3dzSDVpM0ljSjVhU0JnUWhsd3ZSeS9U?=
 =?utf-8?B?a1AyQjJVZjZaVXFucy83ZDBGNitrdWF2M2YyOUQrYnVhTCtRWDZFaHFVWjRz?=
 =?utf-8?B?Q2dYYjZsb3g4UDdxZDhOc2VFNTg4SDZpK3duSjB3Um10S25vSW0wR0NYOU5I?=
 =?utf-8?B?WmJ1b3Byc3pkZWZSR3RPdk1CMEVTc0VycGxYSzNycSs4WU56WmhmRkxFMFhn?=
 =?utf-8?B?bHB5akh5azF5Y2lsQld2eXJEcldsQmpnRFpoQ1I0Z1N2dnZlbEpSRTRtRFFi?=
 =?utf-8?B?TXJibTlqVis4ck9paVlEd1lsaXkzQ3l5M3NWbjc3dS94N3BVVUlHOU9qd3c4?=
 =?utf-8?B?SDM0NzZHY2ZBQnVhREtqdnNabStsd3BoSmV0cEQyam94RnhyZzJvSkExcjR1?=
 =?utf-8?B?ZDVTMEgrYWlnZGFBQ3Y2aGl4T1N3U0tybjJYYWRuaC8zNXNrVnZYakI2eWZn?=
 =?utf-8?B?Vld5WURwaWUwSkVXZng4T2hMMnUyODlSM0RNOTVzTUU3dTNlUUtoNVhkVk44?=
 =?utf-8?B?T3o0M29jM2hFWWJSaE5HelcxUXJSZkdSVHpqMnVkeGhmaFg0SmQ3bmpEM1lt?=
 =?utf-8?B?NFYzZFJVVWh6OUJ4bTJyS2Yrb2pqbTVrRnE5L0JSK3ZpZzZRbFRjMDBrU0dl?=
 =?utf-8?B?T1RQRHhuaEYwNndEaWlQVkhWNjJGMEg0VlhVZHBYVjJrVHRzVjI1aVVhUk4v?=
 =?utf-8?B?NWlzREpXdU5sWTkvNTBSYUQxekp0UkJJc2VQUkdZb2VJc1pvR0dzZkpIc3Bm?=
 =?utf-8?B?RDRWajF5OHJ6MU9BRUMybVQ3M3dHUG9hYkgwb0I5TnJrbitRREdMSlVIUitT?=
 =?utf-8?B?TzBEY3hYd2lsZVBxZ2lBVjVYT0NsOEE5TFkwLzJKVVV2QkJqSGpYZnVSY1V5?=
 =?utf-8?B?YnN4YUtYWjV1VWhtV1YvRHZhSjQ1a29FNFo0TjZJRzFsS0dwd09GeE9DU0xQ?=
 =?utf-8?B?KzR6U08wYkg1aUdNYWVQNnAzbVpHcDVZQ2JUM0dYMFlnaDJrN3RoL3pNUHdK?=
 =?utf-8?B?ckJiY2JzQWIwVlNWTWFLZUNPWkRGbmIySjhCbTE2YTk3eEsveXQraDRsSEFr?=
 =?utf-8?B?N3FBM2FkODJCRURYMUtFTTlVUVBOcmk3cEFVL0E1eWRoSGpzaXNmcFJUREcz?=
 =?utf-8?B?WHFuSjZvQXNELzBFaDBiblQ0R1JzRUIxNXV3MGJWZHV0aUJYc3k5ZDQ4Qkdi?=
 =?utf-8?B?dHpmY1J5d2pFQk9aZFJ0T2hOSmtZYjJzZnI2RE9jb256QlB5eGxwNW5xaUNh?=
 =?utf-8?B?dFl3NHlLaE5DbXJXWEdLcXhpVVpKSWNlUzhEUmRFbDBYT0dCQWlKRVhWV3pm?=
 =?utf-8?B?OUoyL0xmSWVmMXdvZHhpenNmV0RpRXJPYnJ6VXA5bm1CblVDOTh2eWVwczB5?=
 =?utf-8?B?WnVEdTFRV1ZQZy93T1lVd2dwNXdHcDNWa25wbktSbjZtVGYzK1dMNDkzV1Jp?=
 =?utf-8?Q?z0n/5nFw9VXIGrffZpfUAWqK3cj+pL6o6jfARP6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8271ee5-b309-4e43-24e9-08d94ba1bef2
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 17:13:51.6706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qMk0GR2PrvzPTg2ebBlQXHkEwObe2Lsg0OilTL9FNAqBJn750YgLrED4xluUtnLwV1hh9J1qsbOPwpbwXwyb4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2713
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/19/2021 11:23 AM, Edgecombe, Rick P wrote:
> On Fri, 2021-05-21 at 15:12 -0700, Yu-cheng Yu wrote:
>> Introduce basic shadow stack enabling/disabling/allocation routines.
>> A task's shadow stack is allocated from memory with VM_SHADOW_STACK
>> flag
>> and has a fixed size of min(RLIMIT_STACK, 4GB).
>>
>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>> Cc: Kees Cook <keescook@chromium.org>

[...]

>> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
>> new file mode 100644
>> index 000000000000..5ea2b494e9f9
>> --- /dev/null
>> +++ b/arch/x86/kernel/shstk.c

[...]

>> +int shstk_setup(void)
>> +{
>> +       struct thread_shstk *shstk = &current->thread.shstk;
>> +       unsigned long addr, size;
>> +
>> +       if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
>> +               return -EOPNOTSUPP;
> The only caller of this will skip it if
> !cpu_feature_enabled(X86_FEATURE_SHSTK), so this is dead logic. Same
> pattern in the IBT patch.
> 

Indeed that is the case.  We can simply remove the test of 
X86_FEATURE_SHSTK.

Thanks,
Yu-cheng
