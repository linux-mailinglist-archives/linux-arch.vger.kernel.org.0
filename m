Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E903F0945
	for <lists+linux-arch@lfdr.de>; Wed, 18 Aug 2021 18:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhHRQj0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Aug 2021 12:39:26 -0400
Received: from mga11.intel.com ([192.55.52.93]:17041 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhHRQjZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 18 Aug 2021 12:39:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="213246754"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="213246754"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 09:38:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="678640678"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga006.fm.intel.com with ESMTP; 18 Aug 2021 09:38:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 18 Aug 2021 09:38:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 18 Aug 2021 09:38:41 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 18 Aug 2021 09:38:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hP9llbRHla1xF2+uRYMuxNGKco1tvb6gsH7dGp6nT+RW+m1TiuEXkVxBNEe1KmctE8WINXPHTV4kQBz6LkCJN7sYlfW07E1JoUssGthP52FJ2hFMRvJupIQs/Mao4mVbuSepRIDI5GOp5YasAXjko8kV8es5B9sUfPvBySAeyfugYsruUEVfw+kcCY+xJXTbUKusclWr/163Cu3ojTpOJUN0wvHz7sWIjgL9NbDlRTQCy2Uv46XjxL1irEu5pk2BagQflcDMyn3Cn7lGxgKMBd+Q4j++4w5pf4w2byNZ4mbGUsH3H+pRG9Kypl1/+kDmeafvXKP6Jdk+3JeUfHfXxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMgquCDRz8PiUsncptVOB5Q5Z8D18z3Hl4lXJRl0pM8=;
 b=k6n1yUaw18E86Ken0IN5ojss0Jv4VDPk7xgDwSVjURSpJzpjuzpA5GX+zjR+MJP4ZBJXPGSgshCnhfKU1wIZHq+yU87GiG7FSZSqTwIcjHmm17nSMcHn3T1nRC9LshOC48xElrtjP7Cmc/vOZnj2RKhqpeoFvNTBxqFfUnFJF+/BCamjZ6mnkluLJ1xITbhcsGzUNohCaV8j1s9O17PtiAcMOh+La5n9O0I4DeWV3e2pw5k43aiaJ85PvCo5SLI56qKz3hlssXVK4Q9MvLU/A5VTjuTbaQ9MXq7esNI9KePU7bxtVu4hgVLQCnx4mNtYIm5n0Zafqib1epEokiaXlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMgquCDRz8PiUsncptVOB5Q5Z8D18z3Hl4lXJRl0pM8=;
 b=KkMTEw9Uq8WM86W19DDKUr4ACR7TRb3mxcOP3t0xdPo9KBOPhXMP5U4ReAtPWNGzjfbSIzjMH1nn557YE8gewevYrVUpPAeTYfNryPRIkTrsHV1eGDsr8SMqlo5Um97Ymbi3YMxSBNSXMQB6tdSEsrd0IcWjGErbLPFUArBaWzM=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5736.namprd11.prod.outlook.com (2603:10b6:8:11::11) by
 DM6PR11MB3996.namprd11.prod.outlook.com (2603:10b6:5:196::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.17; Wed, 18 Aug 2021 16:38:36 +0000
Received: from DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::2920:8181:ca3f:8666]) by DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::2920:8181:ca3f:8666%4]) with mapi id 15.20.4436.019; Wed, 18 Aug 2021
 16:38:36 +0000
Subject: Re: [PATCH v28 09/32] x86/mm: Introduce _PAGE_COW
To:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>
CC:     "luto@amacapital.net" <luto@amacapital.net>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, "Jann Horn" <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Dave Martin" <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <YRwT7XX36fQ2GWXn@zn.tnic>
 <1A27F5DF-477B-45B7-AD33-CC68D9B7CB89@amacapital.net>
 <YRwbD1hCYFXlYysI@zn.tnic>
 <490345b6-3e3d-4692-8162-85dcb71434c9@www.fastmail.com>
 <YRwjnmT9O8jYmL/9@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <9a2b91ea-6a07-b7c8-24ac-3a15f62fbb7c@intel.com>
Date:   Wed, 18 Aug 2021 09:38:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <YRwjnmT9O8jYmL/9@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::18) To DM8PR11MB5736.namprd11.prod.outlook.com
 (2603:10b6:8:11::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.18] (98.33.34.38) by SJ0PR03CA0013.namprd03.prod.outlook.com (2603:10b6:a03:33a::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Wed, 18 Aug 2021 16:38:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88cf635c-6da8-4309-58c8-08d96266a006
X-MS-TrafficTypeDiagnostic: DM6PR11MB3996:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB3996E250868A19B653116029ABFF9@DM6PR11MB3996.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nmML+ao1mKjTqCXPHsur8UTXhYO5Xb0QIJf7E9L5SiSstnW9nrDeApiPwD9LEcNEO/EDg9Sbl+lXc9CdPsydpjTC/2IIt2ZCYpx3wU7Dd2K9YffAr+4YQxGW/3RAiaSYfgm8KBpS4N8SxIUzsmgGJQpEMMLn2oY0//C6KQM7YQAVtQQkstqHujch8SSmqC+6EaZqaZBsr7F7VBQkM/cQQQE3r1YKPq/l6TdxkFhpZoSUs7dXV8M04qDahTcIW8MJBVhtzUVMh1JJgeKZYmFgcfErVulf7YH07DvxbxHS0cV7nU9X+ITlkQe0/RJpBCJCDHklUD8XJSId7jhw6KdMTdhpjCb3f5DjU11/Tj5SlZYp36ESRdYzXGv5AcQ1fSvYFLa7yO/xvRF6XrubfSYzjukI80hwCj3PfxWCqUcV07SUnDEJvtrf1AvHD28Vx9UoyKuuaUBLTLczZ0tgmOAP7ugpsRDsm0Jl/qwWheEAREbQEiA12dknf0SRd1bBOvaZTMFqkltdlO6WeUaQHICTwXD/99MvNV9akwn16y5AKIrwyHO6jI+f8+eEZHAItTPyOMPgPvFjWBoeabMnHXofi4toOmpbuMu9CHeEVWFc9ScxMH3/8TEpMs1rpFGdnVMWvW1qGGpX1l0oMX4/4b7eolbjVKKFuDPmnOB9xYy8MCdZ8PH7HwvsV/nXCDhBo4XF9LD2OVMv40pDl8uP2JtZdA/Ncq1qx7x4nbnQ1qm51ro=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(4326008)(478600001)(7406005)(5660300002)(53546011)(38100700002)(186003)(6486002)(31686004)(16576012)(36756003)(316002)(26005)(110136005)(8936002)(54906003)(2616005)(956004)(66476007)(66556008)(86362001)(31696002)(7416002)(8676002)(66946007)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czlrbEg1ejZKMVFCS3MxMVgvNVhONlZ1UThUTCtvZThwNkkzNTIyN2kwK1NI?=
 =?utf-8?B?WGhRU09KQmt4eGhBQlhjc1J4S2JXbU5pQTcyeWRzaU55OEFKK0tCclM3YmY3?=
 =?utf-8?B?VU1Iak51MHdxU1IwSXdNRDBTdE95OGVpSUFOVm1XMFV5L0VYU3N6L3I2N0Fv?=
 =?utf-8?B?TFIvdnRvYk1WTGpwU1B2LzdIZlMrWmIvUy9ucFBKaE1xOElQUVMyVC9DVldZ?=
 =?utf-8?B?VWt4WFJJRC9YQVBVNGkyT1h5Z2oyQkx4TmZYN2c0aTVuelJqc01YWGZRV1Ew?=
 =?utf-8?B?c1lLbjlQVXhEdzZzZ05NQ3d1Rk1PZkVxYjAwNFhGZG90NmE5V0EyVWpWRnVr?=
 =?utf-8?B?b3VkT29lUEZFOUtLaTVDQmZrcVNrUFFYSkllUHFHNi9zMGpONkNnYkpDeSt3?=
 =?utf-8?B?TEQ1KzNEaWlkTnhzMEEzZTZaV0x5NkJHZSswbk1XbVphOVU3TE1aYmhhVUdG?=
 =?utf-8?B?d01sckE2dWRsbWR1VDR4TDNUZUR0dTZ1WHMrQjNjQ3hJU2w5RjNpUkRJSVJ3?=
 =?utf-8?B?VmdNa2U0MlN4OEIrUkRkd0RKTUt3UXpHMU4rWWg1dUNpMGlkRkpaR2IrTkdF?=
 =?utf-8?B?NVRTcDBoNlNIN2NvRlJiOE5iVFk3cDhHcnRtdFNma3B4ZmF2MXhzbUJ3NjZ5?=
 =?utf-8?B?VWk1QklJMWhDb0o5Y0ZVVnM4NkowZmNOcTVvYTZ0dnBaejVNNU82Zk02Vy9X?=
 =?utf-8?B?N0tvd0tuSVdZcUtLcGpoSkRzb2duMmJZMFJyNk5BcjRQamFZSGVSQ3VFVEFY?=
 =?utf-8?B?cFVmWWgweVJJb1E0VjdEZm9oVW80T1k2VUpiSHZxZnZXWWgxM2JsWHlkWFRM?=
 =?utf-8?B?ei9KeGlEckluWHhJNlY3VW1DSmFVSTVBbi8rM0ZjKzFRZiszTjR1N3IwbUF5?=
 =?utf-8?B?SHRPVGk0dk9pRkgxZURudWpWWGpTQWcxaXVpVzllMEJIM1hXeGFHc09WMVhZ?=
 =?utf-8?B?QmthMlFwaE9sanpmaVQzbVdEc0U3WFVzcHFtUzJlNmZnWDNVY2twT01WS0ho?=
 =?utf-8?B?MFBtQllhWjRCU2c5bjVINVdaTEdRaUpSeGlJUzQyZHRoWFlpa2lqR2cvRjEv?=
 =?utf-8?B?L0FiTHVGaXVSV1E3bTU1eFVYY1pCUTRJeklmcFVoSWxNOE1KN0E0bGppTXlE?=
 =?utf-8?B?N3R2NUF5WHluMlpvMm9yVmt3SDFNTnV1T3dpbkVmaVJwM08yK1MrQjRpcW12?=
 =?utf-8?B?amgxbUV6TUJkU3hDZ2pFM3JSek9hQmdFQVhoNUdMNnc3Q1VBUEZDa3FtUGdN?=
 =?utf-8?B?YTExLzMzaml1TjJEYjFIUDN6UnhTWWFwWlBuWEJUazJjZjNsNnhhOHQvVmFr?=
 =?utf-8?B?aDh3N1Z1RGM2K3A4VmxkRWFkbHFYNWRSeWRtY0FZMmJLVGs3Zm4vUytmSXlv?=
 =?utf-8?B?OGh1OHB3Uzg3YzNaR29Ud1FML2pWUUY3SG9hUGMza0dkT0d4QWgzbVpFdFpI?=
 =?utf-8?B?ejVSY2FoSTlQcG9DdytNNDFWNlhPOWR5UmtPZUFyc2x3ZkhSZEVmcjg3T2NC?=
 =?utf-8?B?SlNHeXZGQ2xRZVVUUkczVTk4WHlIM3FvekZWaU9NNEJnUlFTMThubzVmUnk1?=
 =?utf-8?B?ZWc4MXFLeWNNM3owampzT20raHNObWREaGRRZ0JJWGdFdC83VFFSN0kzc0F2?=
 =?utf-8?B?bjhiUTVIa0V6TFQrVERFdjMxdklEUjM0eDVSTnd0OHcvOVZ6aHZLNm9sUjFi?=
 =?utf-8?B?bm14OVdOSEFEWFZRWHdKYWgxOUw2azFKL0pHckZXOEpOcWdQRFppL1RIRUYv?=
 =?utf-8?Q?wVmEmG0QRmadggY0KKVPFR8Yb3rsXXzJG+1EnVJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88cf635c-6da8-4309-58c8-08d96266a006
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 16:38:36.2563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xn6BDMPTwoJQQI4tnGPaOSB4Ag34Ej6qV+AWA8NVH7FBOULR0Bi+s9sV6VIi7LB7gckzElDAyaCbiPuCg+fc6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3996
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/17/2021 2:01 PM, Borislav Petkov wrote:
> On Tue, Aug 17, 2021 at 01:51:52PM -0700, Andy Lutomirski wrote:
>> WRSS can be used from user mode depending on the configuration.
> 
> My point being, if you're going to do shadow stack management
> operations, you should check whether the target you're writing to is a
> shadow stack page. Clearly userspace can't do that but userspace will
> get notified of that pretty timely.
> 
>> Double-you shmouble-you. You can't write it with MOV, but you can
>> write it from user code and from kernel code. As far as the mm is
>> concerned, I think it should be considered writable.
> 
> Because?
> 
>> Although... anyone who tries to copy_to_user() it is going to be a bit
>> surprised. Hmm.
> 
> Ok, so you see the confusion.
> 

copy_to_user() can run into normal read-only areas too.  The caller can 
handle that just fine.

> In any case, I don't think you can simply look at a shadow stack page as
> simple writable page. There are cases where it is going to be fun.
> 
> So why are we even saying that a shadow stack page is writable? Why
> can't we simply say that a shadow stack page is, well, something
> special?
> 

We can visualize the type of a mm area by looking at vma->vm_flags, e.g. 
maybe_mkwrite(), and PTE macros as lower-level operatives.  These two 
have some relations but not one-to-one.  Note that a PTE in a writable 
area is not always pte_write().

I have considered and implemented a shadow stack PTE either pte_write() 
or not.  Making shadow stack as pte_write() results in less arch_* 
macros and less confusion in copy-on-write code.  That is one more thing 
to consider.

Thanks,
Yu-cheng
