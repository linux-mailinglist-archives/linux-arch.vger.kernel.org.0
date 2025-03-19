Return-Path: <linux-arch+bounces-10949-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C308DA68199
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 01:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8952E1747A2
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 00:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9454D29D0D;
	Wed, 19 Mar 2025 00:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MPEdx/fo"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D06618E25;
	Wed, 19 Mar 2025 00:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742344461; cv=none; b=T4qrdCVxskMZvlj9iyta8zArhv2t/G0NUfHqHnaI9KxgRCiKTZLIjulkZ6ORnvnrcwMznhFo4YyF8Wxa5551U3AK0zHhpfzFUn2cio3P9RA3CUIVDJuVQSfyO3AsqdhwVMOfqi0/aWqO/EOhAS4BjoJHtMMTpkxvZsRnTrI2+88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742344461; c=relaxed/simple;
	bh=7D4DVfjqUYrO15WIBGJuOnJEGskb57zhFCeN9JF9IN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fpnpier9ER6+Mbg7SNEqBOtjhX13Eghq80gdJGxfa51k8gVQpPKSVayxhBAcyRQS2hAlblTYzLYiJiTWyA4lNzPvFVTXooS5EyFVSHXTqm89Iu/twmWNfMbYegdFueCKfCGrplH09Cuvi58WK2GwlN08b+L0VKBpUF+z+7uMDPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MPEdx/fo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 11715202536C;
	Tue, 18 Mar 2025 17:34:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 11715202536C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742344457;
	bh=yzi5nB05C6YBwDVvPu1RQxP/gtmAUPKmVsdN1uMj47w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MPEdx/foH0ClIVHe99HYrM8kNT/GY9l6DlQLdC3XIxvKTglfj28cahW0GrOeiQTDq
	 vmtNywGzZYdUctz6ZXCJJB62hFZgu8znbPPHu/nXLNYmziUih8dEr431cCSq9wQbSi
	 Gv+oSB2KEOYANNgOtTG3sq8t3RFHiQ6IMoMrGcPY=
Message-ID: <afd87eba-742f-4b67-9171-fd8486416b7b@linux.microsoft.com>
Date: Tue, 18 Mar 2025 17:34:16 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/10] Drivers: hv: Introduce mshv_root module to
 expose /dev/mshv to VMMs
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "arnd@arndb.de"
 <arnd@arndb.de>,
 "jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
 "muminulrussell@gmail.com" <muminulrussell@gmail.com>,
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
 "mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
 "apais@linux.microsoft.com" <apais@linux.microsoft.com>,
 "Tianyu.Lan@microsoft.com" <Tianyu.Lan@microsoft.com>,
 "stanislav.kinsburskiy@gmail.com" <stanislav.kinsburskiy@gmail.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>,
 "prapal@linux.microsoft.com" <prapal@linux.microsoft.com>,
 "muislam@microsoft.com" <muislam@microsoft.com>,
 "anrayabh@linux.microsoft.com" <anrayabh@linux.microsoft.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
 <lenb@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-11-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157BE8AF5A1CDD39CF31124D4DF2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157BE8AF5A1CDD39CF31124D4DF2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/2025 4:51 PM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, February 26, 2025 3:08 PM
<snip>
>> +
>> +/* TODO move this to another file when debugfs code is added */
>> +enum hv_stats_vp_counters {			/* HV_THREAD_COUNTER */
>> +#if defined(CONFIG_X86)
>> +	VpRootDispatchThreadBlocked			= 201,
>> +#elif defined(CONFIG_ARM64)
>> +	VpRootDispatchThreadBlocked			= 94,
>> +#endif
>> +	VpStatsMaxCounter
>> +};
> 
> Where do these "magic" numbers come from?  Are they matching something
> in the Hyper-V host?
> 
They are part of the hypervisor ABI and really belong in hvhdk.h. These enums
have many members which we use in another part of the code but which are omitted
here.

For this patchset I put them here to avoid putting PascalCase definitions in the
global namespace. I was undecided if we want to keep them like this (maybe keeping
them out of hvhdk.h), or change them to linux style in a followup.

>> +
>> +struct hv_stats_page {
>> +	union {
>> +		u64 vp_cntrs[VpStatsMaxCounter];		/* VP counters */
>> +		u8 data[HV_HYP_PAGE_SIZE];
>> +	};
>> +} __packed;
>> +
>> +struct mshv_root mshv_root = {};
> 
> Initializer is unnecessary for global variables. They are already set to zero.
> 
Yep, I'll remove it.

>> +
>> +enum hv_scheduler_type hv_scheduler_type;
>> +
>> +/* Once we implement the fast extended hypercall ABI they can go away. */
>> +static void __percpu **root_scheduler_input;
>> +static void __percpu **root_scheduler_output;
> 
> The __percpu is probably in the wrong place like mentioned in earlier
> patches in this series.
> 
Ack, will fix.

<snip>
>> +
>> +static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
>> +				      bool partition_locked,
>> +				      void __user *user_args)
>> +{
>> +	u64 status;
>> +	int ret, i;
> 
> 'ret' should be initialized to 0. There's a path through this function that
> never sets 'ret' and the return value would be stack garbage.
> 
Thanks, will fix.

<snip>
>> +
>> +/*
>> + * Explicit guest vCPU suspend is asynchronous by nature (as it is requested by
>> + * dom0 vCPU for guest vCPU) and thus it can race with "intercept" suspend,
>> + * done by the hypervisor.
>> + * "Intercept" suspend leads to asynchronous message delivery to dom0 which
>> + * should be awaited to keep the VP loop consistent (i.e. no message pending
>> + * upon VP resume).
>> + * VP intercept suspend can't be done when the VP is explicitly suspended
>> + * already, and thus can be only two possible race scenarios:
>> + *   1. implicit suspend bit set -> explicit suspend bit set -> message sent
>> + *   2. implicit suspend bit set -> message sent -> explicit suspend bit set
>> + * Checking for implicit suspend bit set after explicit suspend request has
>> + * succeeded in either case allows us to reliably identify, if there is a
>> + * message to receive and deliver to VMM.
>> + */
>> +static long
> 
> For this function, why is the return type "long" instead of "int"?  Same
> question for several other functions below.  "long" works, but it's another
> case of being gratuitously atypical -- unless there's a reason.
> 
No good reason. It should just be an int.

<snip>
>> +
>> +	switch (args.type) {
>> +	case MSHV_VP_STATE_LAPIC:
>> +		state_data.type = HV_GET_SET_VP_STATE_LAPIC_STATE;
>> +		data_sz = HV_HYP_PAGE_SIZE;
>> +		break;
>> +	case MSHV_VP_STATE_XSAVE:
> 
> Just FYI, you can put a semicolon after the colon on the above line, which
> adds a null statement, and then the C compiler will accept the definition
> of local variable data_sz_64 without needing the odd-looking braces. 
> 
> See https://stackoverflow.com/questions/92396/why-cant-variables-be-declared-in-a-switch-statement/19830820
> 
> I learn something new every day! :-)
> 
I didn't know that! But actually I prefer the braces because they clearly
denote a new block scope for that case.

>> +	{
>> +		u64 data_sz_64;
>> +
>> +		ret = hv_call_get_partition_property(vp->vp_partition->pt_id,
>> +						     HV_PARTITION_PROPERTY_XSAVE_STATES,
>> +						     &state_data.xsave.states.as_uint64);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret = hv_call_get_partition_property(vp->vp_partition->pt_id,
>> +						     HV_PARTITION_PROPERTY_MAX_XSAVE_DATA_SIZE,
>> +						     &data_sz_64);
>> +		if (ret)
>> +			return ret;
>> +
>> +		data_sz = (u32)data_sz_64;
>> +		state_data.xsave.flags = 0;
>> +		/* Always request legacy states */
>> +		state_data.xsave.states.legacy_x87 = 1;
>> +		state_data.xsave.states.legacy_sse = 1;
>> +		state_data.type = HV_GET_SET_VP_STATE_XSAVE;
>> +		break;
>> +	}
>> +	case MSHV_VP_STATE_SIMP:
>> +		state_data.type = HV_GET_SET_VP_STATE_SIM_PAGE;
>> +		data_sz = HV_HYP_PAGE_SIZE;
>> +		break;
>> +	case MSHV_VP_STATE_SIEFP:
>> +		state_data.type = HV_GET_SET_VP_STATE_SIEF_PAGE;
>> +		data_sz = HV_HYP_PAGE_SIZE;
>> +		break;
>> +	case MSHV_VP_STATE_SYNTHETIC_TIMERS:
>> +		state_data.type = HV_GET_SET_VP_STATE_SYNTHETIC_TIMERS;
>> +		data_sz = sizeof(vp_state.synthetic_timers_state);
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (copy_to_user(&user_args->buf_sz, &data_sz, sizeof(user_args->buf_sz)))
>> +		return -EFAULT;
>> +
>> +	if (data_sz > args.buf_sz)
>> +		return -EINVAL;
>> +
>> +	/* If the data is transmitted via pfns, delegate to helper */
>> +	if (state_data.type & HV_GET_SET_VP_STATE_TYPE_PFN) {
>> +		unsigned long user_pfn = PFN_DOWN(args.buf_ptr);
>> +		size_t page_count = PFN_DOWN(args.buf_sz);
>> +
>> +		return mshv_vp_ioctl_get_set_state_pfn(vp, state_data, user_pfn,
>> +						       page_count, is_set);
>> +	}
>> +
>> +	/* Paranoia check - this shouldn't happen! */
>> +	if (data_sz > sizeof(vp_state)) {
>> +		vp_err(vp, "Invalid vp state data size!\n");
>> +		return -EINVAL;
>> +	}
> 
> I don't understand the above check.  sizeof(vp_state) is relatively small since
> it is effectively sizeof(hv_synthetic_timers_state), which is 200 bytes if I've
> done the arithmetic correctly. But data_sz could be a full page (4096 bytes)
> for the LAPIC, SIMP, and SIEFP cases, and the check would cause an error to
> be returned.
> 
data_sz > sizeof(vp_state) is true if and only if the HV_GET_SET_VP_STATE_TYPE_PFN
bit is set in state_data.type. This check ensures that invariant holds.

See just above where we delegate to mshv_vp_ioctl_get_set_state_pfn() in that case.

>> +
>> +	if (is_set) {
>> +		if (copy_from_user(&vp_state, (__user void *)args.buf_ptr, data_sz))
>> +			return -EFAULT;
>> +
>> +		return hv_call_set_vp_state(vp->vp_index,
>> +					    vp->vp_partition->pt_id,
>> +					    state_data, 0, NULL,
>> +					    sizeof(vp_state), (u8 *)&vp_state);
> 
> This is one of the cases where data from user space gets passed directly to
> the hypercall. So user space is responsible for ensuring that reserved fields
> are zero'ed and for otherwise ensuring a proper hypercall input. I just
> wonder if user space really does this correctly.
> 
The interfaces that are 'passthrough' like this remove quite a bit of
complexity from the kernel code and delegates it to userspace and the hypervisor.

It is on userspace to ensure the parameters are valid, and it's on the
hypervisor to check the fields and error if they are used improperly.

Note the hypervisor still needs to check everything regardless of if it comes
from the kernel or directly from userspace.

>> +
>> +static vm_fault_t mshv_vp_fault(struct vm_fault *vmf)
>> +{
>> +	struct mshv_vp *vp = vmf->vma->vm_file->private_data;
>> +
>> +	switch (vmf->vma->vm_pgoff) {
>> +	case MSHV_VP_MMAP_OFFSET_REGISTERS:
>> +		vmf->page = virt_to_page(vp->vp_register_page);
>> +		break;
>> +	case MSHV_VP_MMAP_OFFSET_INTERCEPT_MESSAGE:
>> +		vmf->page = virt_to_page(vp->vp_intercept_msg_page);
>> +		break;
>> +	case MSHV_VP_MMAP_OFFSET_GHCB:
>> +		if (is_ghcb_mapping_available())
>> +			vmf->page = virt_to_page(vp->vp_ghcb_page);
>> +		break;
> 
> If there's no GHCB mapping available, execution just continues with
> vmf->page not set. Won't the later get_page() call fail? Perhaps this
> should fail if there's no GHCB mapping available. Or maybe there's
> more about how this works that I'm ignorant of. :-)
> 
Hmm, maybe this check should just be removed. If we got here it means
the vmf->vma->vm_pgoff was already set in mmap(), so the page should be
valid in that case.

>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	get_page(vmf->page);
>> +
>> +	return 0;
>> +}
>> +
>> +static int mshv_vp_mmap(struct file *file, struct vm_area_struct *vma)
>> +{
>> +	struct mshv_vp *vp = file->private_data;
>> +
>> +	switch (vma->vm_pgoff) {
>> +	case MSHV_VP_MMAP_OFFSET_REGISTERS:
>> +		if (!vp->vp_register_page)
>> +			return -ENODEV;
>> +		break;
>> +	case MSHV_VP_MMAP_OFFSET_INTERCEPT_MESSAGE:
>> +		if (!vp->vp_intercept_msg_page)
>> +			return -ENODEV;
>> +		break;
>> +	case MSHV_VP_MMAP_OFFSET_GHCB:
>> +		if (is_ghcb_mapping_available() && !vp->vp_ghcb_page)
>> +			return -ENODEV;
>> +		break;
> 
> Again, if no GHCB mapping is available, should this return success?
> 
I think this should just check the vp->vp_ghcb_page is not NULL, like
the other cases. is_ghcb_mapping_available() is already checked to
decide whether to map the page in the first place. I'll change it.

>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	vma->vm_ops = &mshv_vp_vm_ops;
>> +	return 0;
>> +}
<snip>
>> +
>> +	input_vtl.as_uint8 = 0;
> 
> I see eight occurrences in this source code file where the above statement
> occurs and there is no further modification. Perhaps declare a static
> variable that is initialized properly, and use it as the input parameter to the
> various functions.  A second static variable could have the use_target_vtl = 1
> setting that is needed in three places.
> 
I was a bit doubtful, but I tried this and it removes quite a few lines without
much tradeoff in readability. Thanks!

>> +	ret = hv_call_map_vp_state_page(partition->pt_id, args.vp_index,
>> +					HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
>> +					input_vtl,
>> +					&intercept_message_page);
<snip>>> +static int mshv_init_async_handler(struct mshv_partition *partition)
>> +{
>> +	if (completion_done(&partition->async_hypercall)) {
>> +		pt_err(partition,
>> +		       "Cannot issue another async hypercall, while another one in progress!\n");
> 
> Two uses of word "another" in the error message is redundant.  Perhaps
> 
> 	"Cannot issue async hypercall while another one is in progress!"
> 
Thanks, I'll change it.

<snip>>> +
>> +	/* Reject overlapping regions */
>> +	if (mshv_partition_region_by_gfn(partition, mem->guest_pfn) ||
>> +	    mshv_partition_region_by_gfn(partition, mem->guest_pfn + nr_pages - 1) ||
>> +	    mshv_partition_region_by_uaddr(partition, mem->userspace_addr) ||
>> +	    mshv_partition_region_by_uaddr(partition, mem->userspace_addr + mem->size - 1))
>> +		return -EEXIST;
> 
> Having to fully walk the partition region list four times for the above checks
> isn't the most efficient approach, but I'm guessing that creating a region isn't
> really a hot path so it doesn't matter. And I don't know how long the region list
> typically is.
> 
Indeed, it seems wasteful at first but the list is usually only a few entries long,
and regions are rarely added or removed (usually just at boot).

<snip>>> +/* Called for unmapping both the guest ram and the mmio space */
>> +static long
>> +mshv_unmap_user_memory(struct mshv_partition *partition,
>> +		       struct mshv_user_mem_region mem)
>> +{
>> +	struct mshv_mem_region *region;
>> +	u32 unmap_flags = 0;
>> +
>> +	if (!(mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP)))
>> +		return -EINVAL;
>> +
>> +	if (hlist_empty(&partition->pt_mem_regions))
>> +		return -EINVAL;
> 
> Isn't the above check redundant, given the lookup by gfn that is
> done immediately below?
> 
Yes, I'll remove it.

>> +
>> +	region = mshv_partition_region_by_gfn(partition, mem.guest_pfn);
>> +	if (!region)
>> +		return -EINVAL;
<snip>>> +	case MSHV_GPAP_ACCESS_TYPE_ACCESSED:
>> +		hv_type_mask = 1;
>> +		if (args.access_op == MSHV_GPAP_ACCESS_OP_CLEAR) {
>> +			hv_flags.clear_accessed = 1;
>> +			/* not accessed implies not dirty */
>> +			hv_flags.clear_dirty = 1;
>> +		} else { // MSHV_GPAP_ACCESS_OP_SET
> 
> Avoid C++ style comments.
> 
Ack

>> +			hv_flags.set_accessed = 1;
>> +		}
>> +		break;
>> +	case MSHV_GPAP_ACCESS_TYPE_DIRTY:
>> +		hv_type_mask = 2;
>> +		if (args.access_op == MSHV_GPAP_ACCESS_OP_CLEAR) {
>> +			hv_flags.clear_dirty = 1;
>> +		} else { // MSHV_GPAP_ACCESS_OP_SET
> 
> Same here.
> 
Ack

>> +			hv_flags.set_dirty = 1;
>> +			/* dirty implies accessed */
>> +			hv_flags.set_accessed = 1;
>> +		}
>> +		break;
>> +	}
>> +
>> +	states = vzalloc(states_buf_sz);
>> +	if (!states)
>> +		return -ENOMEM;
>> +
>> +	ret = hv_call_get_gpa_access_states(partition->pt_id, args.page_count,
>> +					    args.gpap_base, hv_flags, &written,
>> +					    states);
>> +	if (ret)
>> +		goto free_return;
>> +
>> +	/*
>> +	 * Overwrite states buffer with bitmap - the bits in hv_type_mask
>> +	 * correspond to bitfields in hv_gpa_page_access_state
>> +	 */
>> +	for (i = 0; i < written; ++i)
>> +		assign_bit(i, (ulong *)states,
> 
> Why the cast to ulong *?  I think this argument to assign_bit() is void *, in
> which case the cast wouldn't be needed.
> 
It looks like assign_bit() and friends resolve to a set of functions which do
take an unsigned long pointer, e.g.:

__set_bit() -> generic___set_bit(unsigned long nr, volatile unsigned long *addr)
set_bit() -> arch_set_bit(unsigned int nr, volatile unsigned long *p)
etc...

So a cast is necessary.

> Also, assign_bit() does atomic bit operations. Doing such in a loop like
> here will really hammer the hardware memory bus with atomic 
> read-modify-write cycles. Use __assign_bit() instead, which does
> non-atomic operations. You don't need atomic here as no other
> threads are modifying the bit array.
> 
I didn't realize it was atomic. I'll change it to __assign_bit().

>> +			   states[i].as_uint8 & hv_type_mask);
> 
> OK, so the starting contents of "states" is an array of bytes. The ending
> contents is an array of bits. This works because every bit in the ending
> bit array is set to either 0 or 1. Overlap occurs on the first iteration
> where the code reads the 0th byte, and writes the 0th bit, which is part of
> the 0th byte. The second iteration reads the 1st byte, and writes the 1st bit,
> which doesn't overlap, and there's no overlap from then on.
> 
> Suppose "written" is not a multiple of 8. The last byte of "states" as an
> array of bits will have some bits that have not been set to either 0 or 1 and
> might be leftover garbage from when "states" was an array of bytes. That
> garbage will get copied to user space. Is that OK? Even if user space knows
> enough to ignore those bits, it seems a little dubious to be copying even
> a few bits of garbage to user space.
> 
> Some comments might help here.
> 
This is a good point. The expectation is indeed that userspace knows which
bits are valid from the returned "written" value, but I agree it's a bit
odd to have some garbage bits in the last byte. How does this look (to be
inserted here directly after the loop):

+       /* zero the unused bits in the last byte of the returned bitmap */
+       if (written > 0) {
+               u8 last_bits_mask;
+               int last_byte_idx;
+               int bits_rem = written % 8;
+
+               /* bits_rem == 0 when all bits in the last byte were assigned */
+               if (bits_rem > 0) {
+                       /* written > 0 ensures last_byte_idx >= 0 */
+                       last_byte_idx = ((written + 7) / 8) - 1;
+                       /* bits_rem > 0 ensures this masks 1 to 7 bits */
+                       last_bits_mask = (1 << bits_rem) - 1;
+                       states[last_byte_idx].as_uint8 &= last_bits_mask;
+               }
+       }

The remaining bytes could be memset() to zero but I think it's fine to leave
them.

>> +
>> +	args.page_count = written;
>> +
>> +	if (copy_to_user(user_args, &args, sizeof(args))) {
>> +		ret = -EFAULT;
>> +		goto free_return;
>> +	}
>> +	if (copy_to_user((void __user *)args.bitmap_ptr, states, bitmap_buf_sz))
>> +		ret = -EFAULT;
>> +
>> +free_return:
>> +	vfree(states);
>> +	return ret;
>> +}
<snip>
>> +static void
>> +handle_bitset_message(const struct hv_vp_signal_bitset_scheduler_message *msg)
>> +{
>> +	int bank_idx, vps_signaled = 0, bank_mask_size;
>> +	struct mshv_partition *partition;
>> +	const struct hv_vpset *vpset;
>> +	const u64 *bank_contents;
>> +	u64 partition_id = msg->partition_id;
>> +
>> +	if (msg->vp_bitset.bitset.format != HV_GENERIC_SET_SPARSE_4K) {
>> +		pr_debug("scheduler message format is not HV_GENERIC_SET_SPARSE_4K");
>> +		return;
>> +	}
>> +
>> +	if (msg->vp_count == 0) {
>> +		pr_debug("scheduler message with no VP specified");
>> +		return;
>> +	}
>> +
>> +	rcu_read_lock();
>> +
>> +	partition = mshv_partition_find(partition_id);
>> +	if (unlikely(!partition)) {
>> +		pr_debug("failed to find partition %llu\n", partition_id);
>> +		goto unlock_out;
>> +	}
>> +
>> +	vpset = &msg->vp_bitset.bitset;
>> +
>> +	bank_idx = -1;
>> +	bank_contents = vpset->bank_contents;
>> +	bank_mask_size = sizeof(vpset->valid_bank_mask) * BITS_PER_BYTE;
>> +
>> +	while (true) {
>> +		int vp_bank_idx = -1;
>> +		int vp_bank_size = sizeof(*bank_contents) * BITS_PER_BYTE;
>> +		int vp_index;
>> +
>> +		bank_idx = find_next_bit((unsigned long *)&vpset->valid_bank_mask,
>> +					 bank_mask_size, bank_idx + 1);
>> +		if (bank_idx == bank_mask_size)
>> +			break;
>> +
>> +		while (true) {
>> +			struct mshv_vp *vp;
>> +
>> +			vp_bank_idx = find_next_bit((unsigned long *)bank_contents,
>> +						    vp_bank_size, vp_bank_idx + 1);
>> +			if (vp_bank_idx == vp_bank_size)
>> +				break;
>> +
>> +			vp_index = (bank_idx << HV_GENERIC_SET_SHIFT) + vp_bank_idx;
> 
> This would be clearer if just multiplied by bank_mask_size instead of shifting.
> Since the compiler knows the constant value of bank_mask_size, it should generate
> the same code as the shift.
> 
I agree, but it should be multiplied by vp_bank_size as that's the size of a bank
in bits, as opposed bank_mask_size which is the size of the valid banks mask in bits.

(They're both the same value though, 64).

<snip>>> +
>> +enum {
>> +	MSHV_GPAP_ACCESS_TYPE_ACCESSED = 0,
>> +	MSHV_GPAP_ACCESS_TYPE_DIRTY,
>> +	MSHV_GPAP_ACCESS_TYPE_COUNT		/* Count of enum members */
>> +};
>> +
>> +enum {
>> +	MSHV_GPAP_ACCESS_OP_NOOP = 0,
>> +	MSHV_GPAP_ACCESS_OP_CLEAR,
>> +	MSHV_GPAP_ACCESS_OP_SET,
>> +	MSHV_GPAP_ACCESS_OP_COUNT		/* Count of enum members */
>> +};
> 
> Any reason these two enums explicitly set the first value to 0, while
> earlier enums do not?  This is another case of there being a difference,
> and me wondering if it's just gratuitous or if there's a specific reason.
> Consistency is a good thing!
> 
No reason, I'll remove these assignments.

<snip>>> +/* Partition fds created with MSHV_CREATE_PARTITION */
>> +#define MSHV_INITIALIZE_PARTITION	_IO(MSHV_IOCTL, 0x00)
>> +#define MSHV_CREATE_VP			_IOW(MSHV_IOCTL, 0x01, struct mshv_create_vp)
>> +#define MSHV_SET_GUEST_MEMORY		_IOW(MSHV_IOCTL, 0x02, struct mshv_user_mem_region)
>> +#define MSHV_IRQFD			_IOW(MSHV_IOCTL, 0x03, struct mshv_user_irqfd)
>> +#define MSHV_IOEVENTFD			_IOW(MSHV_IOCTL, 0x04, struct mshv_user_ioeventfd)
>> +#define MSHV_SET_MSI_ROUTING		_IOW(MSHV_IOCTL, 0x05, struct mshv_user_irq_table)
>> +#define MSHV_GET_GPAP_ACCESS_BITMAP	_IOWR(MSHV_IOCTL, 0x06, struct mshv_gpap_access_bitmap)
>> +/* Generic hypercall */
>> +#define MSHV_ROOT_HVCALL		_IOWR(MSHV_IOCTL, 0x07, struct mshv_root_hvcall)
> 
> I really don't like having the ioctl numbers here overlap with the /dev/mshv ioctls.
> There's just no need to overlap. But I realize changing it now is a big hassle.
> 
Fair enough, there isn't a real need for overlap between the different device IOCTLs.
But, yes, I am going to leave them alone unless there's a really good reason.

>> +
>> +/*
>> + ********************************
>> + * VP APIs for child partitions *
>> + ********************************
>> + */
>> +
>> +#define MSHV_RUN_VP_BUF_SZ 256
>> +
>> +/*
>> + * Map various VP state pages to userspace.
>> + * Multiply the offset by PAGE_SIZE before being passed as the 'offset'
>> + * argument to mmap().
>> + * e.g.
>> + * void *reg_page = mmap(NULL, PAGE_SIZE, PROT_READ|PROT_WRITE,
>> + *                       MAP_SHARED, vp_fd,
>> + *                       MSHV_VP_MMAP_OFFSET_REGISTERS * PAGE_SIZE);
>> + */
> 
> This is interesting.  I would not have thought PAGE_SIZE is available
> in the UAPI.  You must use something like the getpagesize() call. I know
> the root partition can only run with a 4K page size, but the symbol
> "PAGE_SIZE" is probably kernel code only.
> 
PAGE_SIZE here is meant to imply using whatever the system page size is,
but I think it's probably better to be explicit in the example. I will
change it to sysconf(_SC_PAGE_SIZE) as that seems to be the recommended way.

While at it I realized there were some more references to PAGE_SIZE and
HV_HYP_PAGE_SIZE in this file, but neither are defined in uapi.
I'm going to add a new #define MSHV_HV_PAGE_SIZE which matches the
hypervisor native page size of 0x1000 for these cases.

This mmap() call is the only time where the system page size is needed
instead of the Hyper-V page size.

>> +enum {
>> +	MSHV_VP_MMAP_OFFSET_REGISTERS,
>> +	MSHV_VP_MMAP_OFFSET_INTERCEPT_MESSAGE,
>> +	MSHV_VP_MMAP_OFFSET_GHCB,
>> +	MSHV_VP_MMAP_OFFSET_COUNT
>> +};
>> +
>> +/**
>> + * struct mshv_run_vp - argument for MSHV_RUN_VP
>> + * @msg_buf: On success, the intercept message is copied here. It can be
>> + *           interpreted using the relevant hypervisor definitions.
>> + */
>> +struct mshv_run_vp {
>> +	__u8 msg_buf[MSHV_RUN_VP_BUF_SZ];
>> +};
>> +
>> +enum {
>> +	MSHV_VP_STATE_LAPIC,		/* Local interrupt controller state (either arch) */
>> +	MSHV_VP_STATE_XSAVE,		/* XSAVE data in compacted form (x86_64) */
>> +	MSHV_VP_STATE_SIMP,
>> +	MSHV_VP_STATE_SIEFP,
>> +	MSHV_VP_STATE_SYNTHETIC_TIMERS,
>> +	MSHV_VP_STATE_COUNT,
>> +};
>> +
>> +/**
>> + * struct mshv_get_set_vp_hvcall - arguments for MSHV_[GET,SET]_VP_STATE
> 
> s/hvcall/state/
> 
Ack

<snip>
Thanks for the comments
Nuno

