Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9032941BAC2
	for <lists+linux-arch@lfdr.de>; Wed, 29 Sep 2021 01:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243177AbhI1XK2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Sep 2021 19:10:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:26036 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243131AbhI1XK1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Sep 2021 19:10:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="222931040"
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="222931040"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 16:08:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="437410791"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 28 Sep 2021 16:08:46 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 16:08:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 28 Sep 2021 16:08:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 28 Sep 2021 16:08:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoCAqiPrVXMdzbFEkc9qDxwsf1D1Ha+X9WLTNLiSAgMd1vpv33YoMICTOkCj7P/VvdRQ7B8EGAVJZ/4rKrPsOrdX3DwLeUuxgwS6rQgBOLVEWn9uFaH8ARSUlNnCzLMkUoQeX2xaJDeJCcqG5p+gZ7Oan/gmyFpls5tnsAi8B/l/btNNA8TJhNYoJfGanpaLd7Yow0ccFNlxwMVA6lj+XBU2KYnARCm5i2akvlterwFv6mwNwsfS/nlPWkf9MPqIoaoaWMhVdawXruXzHmQZ6WmK42hzj8SzdDqxczqfwRy4QB515y8Jepz4f8AA8450hlOlFBeU+u6iT7CSR9RbBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=CPY036rvGiwiwNa0CzqQ4e/28g+pDaqImEVQBlz9pi0=;
 b=oNJVEi+Aa4IDIvWOq63wWhKghDUV3rtk0gXf92Yod5MDjdCLdskcjLoGcY1kdB9ETPBsEQ4gYlCdxFznnmWxNzBxPTabyjKAFZFhl6T1g8ujc1b8KGDmEfDYQbaH9vY1jtqgf0UFtcDiK/mDd4MiCaUzCwoEj56F40MrsTw1oKGOY/0l6+ZbU4HytTlVSRPyFrulG3Lc/OUrFHSMPCWrCJsoeERfW0wZAk03EHY/umIbzTeXbEocb6xW3hklPSVpRAKiz0s0QdFSFQHI1F5q216ExTy7LvqUBBNPWmKsjTJYKVlWtyKgslgzKt0aog9j2rszFl4OcdzcV+MStj4gbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPY036rvGiwiwNa0CzqQ4e/28g+pDaqImEVQBlz9pi0=;
 b=rorwXRQ6LQhWFgHotDrpJrULUZefhnjOmXWfUgDO0cbWfbqKKMjxCCDQHvbaeC111Z1wKSGHZQpdSXvU5j1dtF6CzikPvBrzaUOoSs4F5t8X/IbDUCnlDFMhqBclpbU7R65ryR6yVTlf7frlpd6586R9Go2EhrFyUqe8d7zQDWI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BYAPR11MB3494.namprd11.prod.outlook.com (2603:10b6:a03:86::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.20; Tue, 28 Sep
 2021 23:08:43 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff%3]) with mapi id 15.20.4544.021; Tue, 28 Sep 2021
 23:08:43 +0000
Subject: Re: [RFC PATCH 11/13] x86/uintr: Introduce uintr_wait() syscall
To:     Thomas Gleixner <tglx@linutronix.de>, <x86@kernel.org>
CC:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Gayatri Kammela" <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        <linux-api@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-12-sohil.mehta@intel.com> <87r1dedykm.ffs@tglx>
From:   Sohil Mehta <sohil.mehta@intel.com>
Message-ID: <2d404db6-828a-98de-f409-94ddf2c2af67@intel.com>
Date:   Tue, 28 Sep 2021 16:08:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <87r1dedykm.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BYAPR01CA0042.prod.exchangelabs.com (2603:10b6:a03:94::19)
 To BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
MIME-Version: 1.0
Received: from [192.168.86.37] (73.222.31.188) by BYAPR01CA0042.prod.exchangelabs.com (2603:10b6:a03:94::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 23:08:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86027aaf-90fd-46eb-e855-08d982d4eaa9
X-MS-TrafficTypeDiagnostic: BYAPR11MB3494:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR11MB34941D82E693C33F0230E71AE5A89@BYAPR11MB3494.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J7y57UaVG3xXxG+AnLn1d5LYofPqqJIQTZxtXWSQzzu2c6eRZwLWKDRBy+e1kR0elb5vx+wP52lXDEA2YOdN2iTlosKCweyvfY35/S9A77zqGQOFTAOTaLc9f+3GJHlH1kEqWzz2WraCXULoUnXSfEsYsswnSXPvJ6plRV89IqljxZEDYP0rmExYQ9jCk+qRelHCLjlsmOCIUBT1lsshNwFEQBSh4VdWeWXUmJcF3qKbLCgbLKxlvbPPRINRo25vK6ppY05RW7eV/B3RYdhiYkNyurHxyIDBOyVknaruXaE5R0xb7sRMFwVtsUKVqyOW9dkHm6lXB8StaqPyNEMpXFdYNmgQ/iCX+WCVqd5oJXGxDn0bc+6Hq97CMSg6hLILHUz1IueaVPQsh5hYCPlk0xbCOZlw6f7KuzutzY7O86gaVxtIYU2bwNxj6WVc+qYgtqwiRpfj8KWp+KmXq0W2aF4mF1JazjD+SWJsXljqLLxKJRbAsch/3rdMDk5virX/cHmuV8o2OD54I4Vdbb1n0CgQJc7yF3pDJNRsSRoL2O7oFECKzuCFYvOoqhe7KraMgMlOI9iDdzSgFzjmh676R+zwCpFnUcwyhQ3/tbdgEloN9BZhMLOt9/QWVEisnMUb/hPHtNiGLfkRP5RBjXdMQNAERzdgBLDUk4YmnTxGRnZTGkAPsf/ZKjlzyVOswlp9LXkI0qhL3UkcwuhshfZZsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(8936002)(66476007)(66556008)(26005)(186003)(8676002)(86362001)(7416002)(5660300002)(44832011)(31696002)(83380400001)(38100700002)(53546011)(6486002)(16576012)(956004)(316002)(4326008)(2906002)(36756003)(2616005)(31686004)(508600001)(54906003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGJQTVR5UUJicHFPdFA5TG12ZWVNT2NJd0d0bXZQWjhrZ3VoSTF0QnlWOS85?=
 =?utf-8?B?OVBYRzZLbDgrSXllNVpiVlFaZ2FHV2JBa29WYUtQL002TmQ2NmJRZkxHTG4x?=
 =?utf-8?B?bFBaUHBpTEZCeUVGVlZzeWNkNVU4LzNPR1c0aHJ1WHV1UVdsOEFPeEFKNTUy?=
 =?utf-8?B?a2dZa3pKUDJuK0tVendLbjk2K0lwM3oySU5KZU9rU3BUaVRHcHRnYU9lTFMr?=
 =?utf-8?B?Z1ZmL0RqOFVXM3E2MlRlbkMzOE4zeFVRY2Q1eG9pVTVqRjNRWHpTMDBHRVBl?=
 =?utf-8?B?MFFNTTlZYS9GU29ueWlMSGhFOGNMcnRvTzAwZzZUSkFEWEpDZ1pMWkx3dEFO?=
 =?utf-8?B?NS9EQTlzNSsvaGdaeVByOVd2VCtCKzZmOG1aODhSWnlOamdrSmkwZHMzcDVH?=
 =?utf-8?B?S3lKMzJObVA1OG9vdXMvcVpCWmluS1VhZlNqb245Snl5eUJpdU5VcDFSdzNP?=
 =?utf-8?B?cHlHV3o1RVpjYmxPbVI1U01mNnNhRDZ6Yk1XcmttK3owRzY5WUgyaHZ1NGth?=
 =?utf-8?B?aDkxM0J1L3JJUWJrQnlXaDBmOWxEeFNCSzRKODhPUUdNN0VCM1lHUXVEdjVr?=
 =?utf-8?B?TnZUakJCQjhoVDhoUzdrbVZ5d0IxY3d6MTQreUZINzlGM0ZNVDFpRUUxeHcx?=
 =?utf-8?B?R2toTGpxWW9zcU1FdGIvbENrWmI2aHRkbjJjYU5uWlU5anovbThzbDhTUkhz?=
 =?utf-8?B?amJPVWVxdmU2WU94K2VucHBIM2ZLamcxVWtwbVNUZG5FdnRSQ2xEa29KbnQr?=
 =?utf-8?B?WGs5ZkxwZG5pTGc0TXhjQXJ2WmcwekJ2SlNNc0ZGaGNCd09YczlmMEwveW9z?=
 =?utf-8?B?aDNMbnYxMSt4bFZpWGV6dDVGVFNvc3FoNTV0dW5WSXI2RDFpR3hYbFczQ2U3?=
 =?utf-8?B?RXhSRllYZ1hDZ0FYemI2bk1RUmJZSmVYdk1MaTM1cHpUM3hjT05jSXlvdDJQ?=
 =?utf-8?B?YjZzY0RVSjhBcVZFclJaMkRWM1h6S2hrVnIxK1o5eDhEUnNYVUVVcjgvL1F3?=
 =?utf-8?B?U0x2bXQyVlZTZ0diMjB0L3M3dFllUm9MeEsyRXA2aWNiY2lvU01VU1p2VmhS?=
 =?utf-8?B?UnNhSStyZUROeXRtRmFQK2wzYzBaekVIRVJjdFlSaXUwMFFuZ1JHQ0xDKzRF?=
 =?utf-8?B?bDFzUi8vN1R5Q2NleDhCZDBsYnhxbFZ0b3NnNFJFTlQ1QitqMDhNZTRjQUs5?=
 =?utf-8?B?dnpkWnF3R1VYZlJSclJjaGZEelF0L094MWhzTURqOWxuWGpKSUk4NEczSnpx?=
 =?utf-8?B?Zzhqa2diMEsrcmdhSmphZ2ZmWUwxQWluaGYwdWp0Y1FqYllMc09JQWxOSG9w?=
 =?utf-8?B?cUlIejdsOEZMdmtWdWRGMHJJU2w1eEN2ZW9MSHdHdHdEMFFERXYzdlZXZEVC?=
 =?utf-8?B?OHQ5T3V4R01UYUc3VVF1WHVRcElmd2JjTlplTjh2aGJTdmF3eUZlUHhXb2Vt?=
 =?utf-8?B?Ky9pa0pvU1VCYzN1b2RKS1NuRXQ2NFlHTUJTYXNESEFaVGIyS1BDdUJxeUFi?=
 =?utf-8?B?TmszT3kwSDk3amltRjdwcTN2WVlGUStCaVVLU08veUZ5OXdSWEt4bE9xQWM3?=
 =?utf-8?B?K1lxVERTRFZNdVpoWlQ2Sm9HZHVsT1Q5TWhrdXR3clZJSFVMV1ptVitjRm5r?=
 =?utf-8?B?K1VZUGNha3BZUnhXdEU2L3ZsbWowOUFaNXZ3TmhTNFFDWmR6R3g2SWttN0Rm?=
 =?utf-8?B?NWFhWG5KcitMQ2NjWDJBSFc5dENwUzVwSlpWSFlwSTdVUFZLdlArOWIyak92?=
 =?utf-8?Q?gOQrh3V8C2eCPnzVrxaPZRQzoHW+nwlqFGmqdR7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 86027aaf-90fd-46eb-e855-08d982d4eaa9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 23:08:43.3735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pptubdzV+TZY2zQcRYmUXui66yapp2u/Cjw1eEn7YQyc4UxGxxhvdsx/zu18iH5aBN8PY7lN/c6Q2Z99h2fzWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3494
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/24/2021 4:04 AM, Thomas Gleixner wrote:
> On Mon, Sep 13 2021 at 13:01, Sohil Mehta wrote:
>> Currently, the task wait list is global one. To make the implementation
>> scalable there is a need to move to a distributed per-cpu wait list.
> How are per cpu wait lists going to solve the problem?


Currently, the global wait list can be concurrently accessed by multiple 
cpus. If we have per-cpu wait lists then the UPID scanning only needs to 
happen on the local cpu's wait list.

After an application calls uintr_wait(), the notification interrupt will 
be delivered only to the cpu where the task blocked. In this case, we 
can reduce the UPID search list and probably get rid of the global 
spinlock as well.

Though, I am not sure how much impact this would have vs. the problem of 
scanning the entire wait list.

>> +
>> +/*
>> + * Handler for UINTR_KERNEL_VECTOR.
>> + */
>> +DEFINE_IDTENTRY_SYSVEC(sysvec_uintr_kernel_notification)
>> +{
>> +	/* TODO: Add entry-exit tracepoints */
>> +	ack_APIC_irq();
>> +	inc_irq_stat(uintr_kernel_notifications);
>> +
>> +	uintr_wake_up_process();
> So this interrupt happens for any of those notifications. How are they
> differentiated?


Unfortunately, there is no help from the hardware here to identify the 
intended target.

When a task blocks we:
* switch the UINV to a kernel NV.
* leave SN as 0
* leave UPID.NDST to the current cpu
* add the task to a wait list

When the notification interrupt arrives:
* Scan the entire wait list to check if the ON bit is set for any UPID 
(very inefficient)
* Set SN to 1 for that task.
* Change the UINV to user NV.
* Remove the task from the list and make it runnable.

We could end up detecting multiple tasks that have the ON bit set. The 
notification interrupt for any task that has ON set is expected to 
arrive soon anyway. So no harm done here.

The main issue here is we would end up scanning the entire list for 
every interrupt. Not sure if there any way we could optimize this?


> Again. We have proper wait primitives.

I'll use proper wait primitives next time.
>> +	return -EINTR;
>> +}
>> +
>> +/*
>> + * Runs in interrupt context.
>> + * Scan through all UPIDs to check if any interrupt is on going.
>> + */
>> +void uintr_wake_up_process(void)
>> +{
>> +	struct uintr_upid_ctx *upid_ctx, *tmp;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&uintr_wait_lock, flags);
>> +	list_for_each_entry_safe(upid_ctx, tmp, &uintr_wait_list, node) {
>> +		if (test_bit(UPID_ON, (unsigned long*)&upid_ctx->upid->nc.status)) {
>> +			set_bit(UPID_SN, (unsigned long *)&upid_ctx->upid->nc.status);
>> +			upid_ctx->upid->nc.nv = UINTR_NOTIFICATION_VECTOR;
>> +			upid_ctx->waiting = false;
>> +			wake_up_process(upid_ctx->task);
>> +			list_del(&upid_ctx->node);
> So any of these notification interrupts does a global mass wake up? How
> does that make sense?


The wake up happens only for the tasks that have a pending interrupt. 
They are going to be woken up soon anyways.

>> +/* Called when task is unregistering/exiting */
>> +static void uintr_remove_task_wait(struct task_struct *task)
>> +{
>> +	struct uintr_upid_ctx *upid_ctx, *tmp;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&uintr_wait_lock, flags);
>> +	list_for_each_entry_safe(upid_ctx, tmp, &uintr_wait_list, node) {
>> +		if (upid_ctx->task == task) {
>> +			pr_debug("wait: Removing task %d from wait\n",
>> +				 upid_ctx->task->pid);
>> +			upid_ctx->upid->nc.nv = UINTR_NOTIFICATION_VECTOR;
>> +			upid_ctx->waiting = false;
>> +			list_del(&upid_ctx->node);
>> +		}
> What? You have to do a global list walk to find the entry which you
> added yourself?

Duh! I could have gotten the upid_ctx from the task_struct itself. Will 
fix this.

Thanks,

Sohil


