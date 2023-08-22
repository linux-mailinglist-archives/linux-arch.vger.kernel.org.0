Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFC0784B3F
	for <lists+linux-arch@lfdr.de>; Tue, 22 Aug 2023 22:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjHVUSq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Aug 2023 16:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjHVUSp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Aug 2023 16:18:45 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A54610B;
        Tue, 22 Aug 2023 13:18:43 -0700 (PDT)
Received: from [192.168.0.5] (71-212-112-68.tukw.qwest.net [71.212.112.68])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9692B2126CD4;
        Tue, 22 Aug 2023 13:18:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9692B2126CD4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692735523;
        bh=btU0rYW/bx7YGoKcH73ygw8rCrE2wH1cwH/SWBjhpw4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DFC55oaMZJjU5gyX4Fty/5hcpe8EZiLuuMET7BoKHLcBAxiEFJXna19hq74swcGlC
         HTBv8OZaA5fbgfgXzMlSIqmKIqtQxAIih87JuxnQWsZCkg4XQAwNVfozq/7qHFGGB8
         G7mAw8OA+d5/OAuXF2bxPILeSUJ7bneXfKAmIDb4=
Message-ID: <8978223c-c5e8-4235-a0ed-2031583c2751@linux.microsoft.com>
Date:   Tue, 22 Aug 2023 13:18:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Content-Language: en-US
To:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc:     "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "apais@linux.microsoft.com" <apais@linux.microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        MUKESH RATHOR <mukeshrathor@microsoft.com>,
        "stanislav.kinsburskiy@gmail.com" <stanislav.kinsburskiy@gmail.com>,
        "jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>
References: <1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1692309711-5573-16-git-send-email-nunodasneves@linux.microsoft.com>
 <PUZP153MB063545036E6B547C009F6AECBE1BA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <664aec4c-7ea9-447f-afab-9e31e9e106c1@linux.microsoft.com>
 <PUZP153MB0635A9EBE87C3589612B628CBE19A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <PUZP153MB0635A9EBE87C3589612B628CBE19A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/19/2023 10:19 PM, Saurabh Singh Sengar wrote:
> 
> 
>> -----Original Message-----
>> From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> Sent: Saturday, August 19, 2023 12:30 AM
>> To: Saurabh Singh Sengar <ssengar@microsoft.com>; linux-
>> hyperv@vger.kernel.org; linux-kernel@vger.kernel.org; x86@kernel.org; linux-
>> arm-kernel@lists.infradead.org; linux-arch@vger.kernel.org
>> Cc: patches@lists.linux.dev; Michael Kelley (LINUX)
>> <mikelley@microsoft.com>; KY Srinivasan <kys@microsoft.com>;
>> wei.liu@kernel.org; Haiyang Zhang <haiyangz@microsoft.com>; Dexuan Cui
>> <decui@microsoft.com>; apais@linux.microsoft.com; Tianyu Lan
>> <Tianyu.Lan@microsoft.com>; ssengar@linux.microsoft.com; MUKESH
>> RATHOR <mukeshrathor@microsoft.com>; stanislav.kinsburskiy@gmail.com;
>> jinankjain@linux.microsoft.com; vkuznets <vkuznets@redhat.com>;
>> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de;
>> dave.hansen@linux.intel.com; hpa@zytor.com; will@kernel.org;
>> catalin.marinas@arm.com
>> Subject: Re: [PATCH v2 15/15] Drivers: hv: Add modules to expose /dev/mshv
>> to VMMs running on Hyper-V
>>
>> On 8/18/2023 6:08 AM, Saurabh Singh Sengar wrote:
>>>> +
>>>> +config MSHV_VTL
>>>> +	tristate "Microsoft Hyper-V VTL driver"
>>>> +	depends on MSHV
>>>> +	select HYPERV_VTL_MODE
>>>> +	select TRANSPARENT_HUGEPAGE
>>>
>>> TRANSPARENT_HUGEPAGE can be avoided for now.
>>>
>>
>> I will remove it in the next version. Thanks.
>>>> +
>>>> +#define HV_GET_REGISTER_BATCH_SIZE	\
>>>> +	(HV_HYP_PAGE_SIZE / sizeof(union hv_register_value))
>>>> +#define HV_SET_REGISTER_BATCH_SIZE	\
>>>> +	((HV_HYP_PAGE_SIZE - sizeof(struct hv_input_set_vp_registers)) \
>>>> +		/ sizeof(struct hv_register_assoc))
>>>> +
>>>> +int hv_call_get_vp_registers(
>>>> +		u32 vp_index,
>>>> +		u64 partition_id,
>>>> +		u16 count,
>>>> +		union hv_input_vtl input_vtl,
>>>> +		struct hv_register_assoc *registers) {
>>>> +	struct hv_input_get_vp_registers *input_page;
>>>> +	union hv_register_value *output_page;
>>>> +	u16 completed = 0;
>>>> +	unsigned long remaining = count;
>>>> +	int rep_count, i;
>>>> +	u64 status;
>>>> +	unsigned long flags;
>>>> +
>>>> +	local_irq_save(flags);
>>>> +
>>>> +	input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
>>>> +	output_page = *this_cpu_ptr(hyperv_pcpu_output_arg);
>>>> +
>>>> +	input_page->partition_id = partition_id;
>>>> +	input_page->vp_index = vp_index;
>>>> +	input_page->input_vtl.as_uint8 = input_vtl.as_uint8;
>>>> +	input_page->rsvd_z8 = 0;
>>>> +	input_page->rsvd_z16 = 0;
>>>> +
>>>> +	while (remaining) {
>>>> +		rep_count = min(remaining, HV_GET_REGISTER_BATCH_SIZE);
>>>> +		for (i = 0; i < rep_count; ++i)
>>>> +			input_page->names[i] = registers[i].name;
>>>> +
>>>> +		status = hv_do_rep_hypercall(HVCALL_GET_VP_REGISTERS,
>>>> rep_count,
>>>> +					     0, input_page, output_page);
>>>
>>> Is there any possibility that count value is passed 0 by mistake ? In
>>> that case status will remain uninitialized.
>>>
>>
>> These lines ensure rep_count is never 0 here:
>>
>> 	while (remaining) {
>> 		rep_count = min(remaining, HV_GET_REGISTER_BATCH_SIZE);
>>
>> Remaining can't be 0 or the loop would exit, and
>> HV_GET_REGISTER_BATCH_SIZE is not 0, or we would never get any registers.
> 
> There is a parameter in this function "count". I was checking if there is any possibility
> that is passed as 0 by mistake ? this will lead to "remaining" value as 0 and loop will never
> execute. Which results using "status" uninitialized later in the function.
> 
> 

Ah ok, thanks! I will change it to return immediately in case count is 0.
>>>> diff --git a/drivers/hv/mshv.h b/drivers/hv/mshv.h
>>>> new file mode 100644
>>>> index 000000000000..166480a73f3f
>>>> --- /dev/null
>>>> +++ b/drivers/hv/mshv.h
>>>> @@ -0,0 +1,156 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>>> +/*
>>>> + * Copyright (c) 2023, Microsoft Corporation.
>>>> + */
>>>> +
>>>> +#ifndef _MSHV_H_
>>>> +#define _MSHV_H_
>>>> +
>>>> +#include <linux/spinlock.h>
>>>> +#include <linux/mutex.h>
>>>> +#include <linux/semaphore.h>
>>>> +#include <linux/sched.h>
>>>> +#include <linux/srcu.h>
>>>> +#include <linux/wait.h>
>>>> +#include <uapi/linux/mshv.h>
>>>> +
>>>> +/*
>>>> + * Hyper-V hypercalls
>>>> + */
>>>> +
>>>> +int hv_call_withdraw_memory(u64 count, int node, u64 partition_id);
>>>> +int hv_call_create_partition(
>>>> +		u64 flags,
>>>> +		struct hv_partition_creation_properties creation_properties,
>>>> +		union hv_partition_isolation_properties isolation_properties,
>>>> +		u64 *partition_id);
>>>> +int hv_call_initialize_partition(u64 partition_id);
>>>> +int hv_call_finalize_partition(u64 partition_id);
>>>> +int hv_call_delete_partition(u64 partition_id);
>>>> +int hv_call_map_gpa_pages(
>>>> +		u64 partition_id,
>>>> +		u64 gpa_target,
>>>> +		u64 page_count, u32 flags,
>>>> +		struct page **pages);
>>>> +int hv_call_unmap_gpa_pages(
>>>> +		u64 partition_id,
>>>> +		u64 gpa_target,
>>>> +		u64 page_count, u32 flags);
>>>> +int hv_call_get_vp_registers(
>>>> +		u32 vp_index,
>>>> +		u64 partition_id,
>>>> +		u16 count,
>>>> +		union hv_input_vtl input_vtl,
>>>> +		struct hv_register_assoc *registers);
>>>> +int hv_call_get_gpa_access_states(
>>>> +		u64 partition_id,
>>>> +		u32 count,
>>>> +		u64 gpa_base_pfn,
>>>> +		u64 state_flags,
>>>> +		int *written_total,
>>>> +		union hv_gpa_page_access_state *states);
>>>> +
>>>> +int hv_call_set_vp_registers(
>>>> +		u32 vp_index,
>>>> +		u64 partition_id,
>>>> +		u16 count,
>>>> +		union hv_input_vtl input_vtl,
>>>> +		struct hv_register_assoc *registers);
>>>
>>> Nit: Opportunity to fix many of the checkpatch.pl related to line break here
>>> and many other places.
>>>
>>
>> checkpatch.pl doesn't complain about anything in this file.
> 
> If we use --strict switch with checkpatch.pl we observe additional CHECK(s).
> I observe 159 CHECK(s) with this patch overall.
> (total: 1 errors, 7 warnings, 159 checks, 7460 lines checked)
> Few examples:
> 
> CHECK: Lines should not end with a '('
> #240: FILE: drivers/hv/hv_call.c:73:
> +int hv_call_set_vp_registers(
> 
> CHECK: Alignment should match open parenthesis
> #266: FILE: drivers/hv/hv_call.c:99:
> +               memcpy(input_page->elements, registers,
> +                       sizeof(struct hv_register_assoc) * rep_count);
> 
> 

I didn't try --strict before. Thanks, I'll fix up the formatting.

> I also see an error with flexible array, possibly we can fix that as well.
> 
> ERROR: Use C99 flexible arrays - see https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
> #7468: FILE: include/uapi/linux/mshv.h:134:
> +       struct mshv_msi_routing_entry entries[0];
> +};
> 

Indeed, I'll fix it too.


