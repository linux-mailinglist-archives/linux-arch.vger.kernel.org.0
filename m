Return-Path: <linux-arch+bounces-11031-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDA4A6C3F9
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 21:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 992357A633F
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 20:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04C11EEA3C;
	Fri, 21 Mar 2025 20:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nvSStd5E"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDD51E7C0B;
	Fri, 21 Mar 2025 20:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742587890; cv=none; b=ctNwEECC6f6ZkxPUvgBk+qwCEs06U6UCvpdPHGIl/Qkc0olXNQIyTqs5MsD8pqp7EUaOX1yQ5Bko6T6vJULWJvgAi4ykB1vpnzfdHEbUqwvulkwvJMe+EhFt3dl8mmjcTLklMGzim1E6lIFr/j1Dkp/QF2EGniXCW58SgoOc8pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742587890; c=relaxed/simple;
	bh=xsq4fMA9KErOYHpGLUUJOLylW+Xto3AugMKGT4drrrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hv1spOftKL4jFrnviB17lFMMxqKpD5utbYrs9bkfex/bMmKAiZrec0oS2fdJ8orAhST1/ahQF6+3rMwBFwSWqL9s8TtE1uiwTpLb025b7lK5E9HvFytk6YnYRLcr/QSVT0fBI8xaK6V6kiiC6G7VJyPMkSriMENBpVKZfsxtau4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nvSStd5E; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 353462025389;
	Fri, 21 Mar 2025 13:11:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 353462025389
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742587888;
	bh=ITpL14RmT7jWiNjR2GtSe0m1zpsnePBZKTOpKhGLiCU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nvSStd5EIPUCS1lGHYZ0GWov/8+OkkDrMUoX+9aDmf6yrWik1ywMI7mldvkqbHeqH
	 BD+PFvVYsttpY06YF2fI0tZLy2OPKopSoMrBwtFLAqFMr9glMVJxlbaaSnhB4EMn7B
	 Zxb+lEKFL/oz3QDhZbbZ02k7poz0h5+SF7i/ukzo=
Message-ID: <bae5bb62-d480-46fd-837c-9267c0a30fae@linux.microsoft.com>
Date: Fri, 21 Mar 2025 13:11:22 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] Drivers: hv: Use hv_hvcall_*() to set up hypercall
 arguments
To: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, bhelgaas@google.com, arnd@arndb.de
Cc: x86@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <20250313061911.2491-1-mhklinux@outlook.com>
 <20250313061911.2491-5-mhklinux@outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20250313061911.2491-5-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/2025 11:19 PM, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Update hypercall call sites to use the new hv_hvcall_*() functions
> to set up hypercall arguments. Since these functions zero the
> fixed portion of input memory, remove now redundant zero'ing of
> input fields.
> 
> hv_post_message() requires additional updates. The payload area is
> treated as an array to avoid wasting cycles on zero'ing it and
> then overwriting with memcpy(). To allow treatment as an array,
> the corresponding payload[] field is updated to have zero size.
> 
I'd prefer to leave the payload field as a fixed-sized array.
Changing it to a flexible array makes it look like that input is
for a variable-sized or rep hypercall, and it makes the surrounding
code in hv_post_message() more complex and inscrutable as a result.

I suggest leaving hv_post_message() alone, except for changing
hyperv_pcpu_input_arg -> hyperv_pcpu_arg, and perhaps a comment
explaining why hv_hvcall_input() isn't used there.

> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  drivers/hv/hv.c           | 9 ++++++---
>  drivers/hv/hv_balloon.c   | 4 ++--
>  drivers/hv/hv_common.c    | 2 +-
>  drivers/hv/hv_proc.c      | 8 ++++----
>  drivers/hv/hyperv_vmbus.h | 2 +-
>  5 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index a38f84548bc2..e2dcbc816fc5 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -66,7 +66,8 @@ int hv_post_message(union hv_connection_id connection_id,
>  	if (hv_isolation_type_tdx() && ms_hyperv.paravisor_present)
>  		aligned_msg = this_cpu_ptr(hv_context.cpu_context)->post_msg_page;
>  	else
> -		aligned_msg = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +		hv_hvcall_in_array(&aligned_msg, sizeof(*aligned_msg),
> +				   sizeof(aligned_msg->payload[0]));
>  
>  	aligned_msg->connectionid = connection_id;
>  	aligned_msg->reserved = 0;
> @@ -80,8 +81,10 @@ int hv_post_message(union hv_connection_id connection_id,
>  						  virt_to_phys(aligned_msg), 0);
>  		else if (hv_isolation_type_snp())
>  			status = hv_ghcb_hypercall(HVCALL_POST_MESSAGE,
> -						   aligned_msg, NULL,
> -						   sizeof(*aligned_msg));
> +						   aligned_msg,
> +						   NULL,
> +						   struct_size(aligned_msg, payload,
> +							       HV_MESSAGE_PAYLOAD_QWORD_COUNT));

See my comment above, I'd prefer to leave this function mostly
alone to maintain readability.

>  		else
>  			status = HV_STATUS_INVALID_PARAMETER;
>  	} else {
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index fec2f18679e3..2def8b8794ee 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -1582,14 +1582,14 @@ static int hv_free_page_report(struct page_reporting_dev_info *pr_dev_info,
>  	WARN_ON_ONCE(nents > HV_MEMORY_HINT_MAX_GPA_PAGE_RANGES);
>  	WARN_ON_ONCE(sgl->length < (HV_HYP_PAGE_SIZE << page_reporting_order));
>  	local_irq_save(flags);
> -	hint = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +
> +	hv_hvcall_in_array(&hint, sizeof(*hint), sizeof(hint->ranges[0]));

We should ensure the returned batch size is large enough for
"nents".

>  	if (!hint) {
>  		local_irq_restore(flags);
>  		return -ENOSPC;
>  	}
>  
>  	hint->heat_type = HV_EXTMEM_HEAT_HINT_COLD_DISCARD;
> -	hint->reserved = 0;
>  	for_each_sg(sgl, sg, nents, i) {
>  		union hv_gpa_page_range *range;
>  
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 9804adb4cc56..a6b1cdfbc8d4 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -293,7 +293,7 @@ void __init hv_get_partition_id(void)
>  	u64 status, pt_id;
>  
>  	local_irq_save(flags);
> -	output = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	hv_hvcall_inout(NULL, 0, &output, sizeof(*output));
>  	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, &output);
>  	pt_id = output->partition_id;
>  	local_irq_restore(flags);
> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index 2fae18e4f7d2..5c580ee1c23f 100644
> --- a/drivers/hv/hv_proc.c
> +++ b/drivers/hv/hv_proc.c
> @@ -73,7 +73,8 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>  
>  	local_irq_save(flags);
>  
> -	input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	hv_hvcall_in_array(&input_page, sizeof(*input_page),
> +			   sizeof(input_page->gpa_page_list[0]));

We should ensure the returned batch size is large enough.

>  
>  	input_page->partition_id = partition_id;
>  
> @@ -124,9 +125,8 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
>  	do {
>  		local_irq_save(flags);
>  
> -		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>  		/* We don't do anything with the output right now */
> -		output = *this_cpu_ptr(hyperv_pcpu_output_arg);
> +		hv_hvcall_inout(&input, sizeof(*input), &output, sizeof(*output));
>  
>  		input->lp_index = lp_index;
>  		input->apic_id = apic_id;
> @@ -167,7 +167,7 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
>  	do {
>  		local_irq_save(irq_flags);
>  
> -		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +		hv_hvcall_in(&input, sizeof(*input));
>  
>  		input->partition_id = partition_id;
>  		input->vp_index = vp_index;
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 29780f3a7478..44b5e8330d9d 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -101,7 +101,7 @@ struct hv_input_post_message {
>  	u32 reserved;
>  	u32 message_type;
>  	u32 payload_size;
> -	u64 payload[HV_MESSAGE_PAYLOAD_QWORD_COUNT];
> +	u64 payload[];

See my comment above, I'd prefer to keep this how it is.

>  };
>  
>  

Thanks
Nuno


