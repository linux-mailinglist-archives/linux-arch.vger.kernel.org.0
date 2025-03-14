Return-Path: <linux-arch+bounces-10754-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1369A6076A
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 03:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 723BC19C2FB2
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 02:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0A832C85;
	Fri, 14 Mar 2025 02:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hKgiynss"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EED8837;
	Fri, 14 Mar 2025 02:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741918544; cv=none; b=KBFVquWGLkGuua3GTGghiOufg6CBqJuPw+g4S6JABiAh9mtzk8AJcvjGUFzK06v8oQ0BhuaZ1ur4IB+OdFxK/DYijf3KMTd9VmpEg/l92BHhUZ+a5jThvsI8xxOSCeMlEB8k1tgpg3p2V60fQz4dDoUyoxONziXXK6+vnmQxkB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741918544; c=relaxed/simple;
	bh=6FoLNt32SQsmFw2HDUU7bFTjObgHdMjANGDu8e27Ch0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ONVPN4jWed8hHuPhup2tvJv6JXO3NzcqboMxhprOxnFyThrQmUyJbIR+mMMUkk7bK/233IP7OY/m8UJ3UC42Gwz8Iwr+y7K+fIVlwy21L33/b8+05Nc/0SCQ2kDkk5jlrvqiNu501e/+4B0yzr3092A6mPKfbwPTZiyujRdQXTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hKgiynss; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.11.134] (76-14-231-56.or.wavecable.com [76.14.231.56])
	by linux.microsoft.com (Postfix) with ESMTPSA id 19D182033437;
	Thu, 13 Mar 2025 19:15:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 19D182033437
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741918541;
	bh=H7QiqwLD4prcSORdmDVIt3EMTb2eEPwqy7Jd/uto5q8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hKgiynssVngIM6CXmr7OSPnDt6X7FX+Av0WhPujd3l1AiaXkDcrsWlHN80E5Bddy+
	 rjLjxDMHv8HASjpX5HMHDkZWsbty2VevyBO+8bEbG3AthzAxqXG7KOEATpG5OL7lj8
	 ClMnBNw9VCuwcq71jaZWorwPgRJ+XhPtkG1g8V5g=
Message-ID: <adfdd111-f838-48a4-b77d-4207f3ab9976@linux.microsoft.com>
Date: Thu, 13 Mar 2025 19:15:39 -0700
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
 <SN6PR02MB4157C3F431CD26EDA05E4AD4D4D32@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157C3F431CD26EDA05E4AD4D4D32@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/2025 9:43 AM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, February 26, 2025 3:08 PM
>>
> 
> I've done a partial review of the code in this patch.  See comments inline
> as usual.
> 
> I'd like to still review most of the code in mshv_root_main.c, and maybe
> some of mshv_synic.c and include/uapi/linux/mshv.c. I'll send a separate
> email with those comments when I complete them. The patch is huge, so
> I'm breaking my review comments into two parts.
> 
> I've glanced through mshv_eventfd.c, mshv_eventfd.h, and mshv_irq.c,
> but I don't have enough knowledge/expertise in these areas to add any
> useful comments, so I'm not planning to review them further.
> 
Thanks for taking a look. Just so you know, I was getting ready to post v6 of
this patchset when I saw this email. So not all the comments will be addressed
in the next version, but I've noted them and I will keep an eye out for the
second part if you send it after v6 is posted.

<snip>
>> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst
>> b/Documentation/userspace-api/ioctl/ioctl-number.rst
>> index 6d1465315df3..66dcfaae698b 100644
>> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
>> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
>> @@ -370,6 +370,8 @@ Code  Seq#    Include File                                           Comments
>>  0xB7  all    uapi/linux/remoteproc_cdev.h                            <mailto:linux-
>> remoteproc@vger.kernel.org>
>>  0xB7  all    uapi/linux/nsfs.h                                       <mailto:Andrei Vagin
>> <avagin@openvz.org>>
>>  0xB8  01-02  uapi/misc/mrvl_cn10k_dpi.h                              Marvell CN10K DPI driver
>> +0xB8  all    uapi/linux/mshv.h                                       Microsoft Hyper-V /dev/mshv driver
> 
> Hmmm. Doesn't this mean that the mshv ioctls overlap with the Marvell
> CN10K DPI ioctls? Is that intentional? I thought the goal of the central
> registry in ioctl-number.rst is to avoid overlap.
> 
Yes, they overlap. In practice it really doesn't matter IMO - IOCTL numbers
are only interpreted by the driver of the device that the ioctl() syscall
is made on.

I believe the whole scheme to generate unique IOCTL numbers and try not to
overlap them was is some case I'm not familiar with - something like
multiple drivers handling IOCTLs on the same device FD? And maybe it's handy
in debugging if you see an IOCTL number in isolation and want to know where
it comes from?

On a practical note, we have been using this IOCTL range for some time
in other upstream code like our userspace rust library which interfaces with
this driver (https://github.com/rust-vmm/mshv). So it would also be nice to
keep that all working as much as possible with the kernel code that is on
this mailing list.

<snip>>> +#endif /* _MSHV_H */
>> diff --git a/drivers/hv/mshv_common.c b/drivers/hv/mshv_common.c
>> new file mode 100644
>> index 000000000000..d97631dcbee1
>> --- /dev/null
>> +++ b/drivers/hv/mshv_common.c
>> @@ -0,0 +1,161 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2024, Microsoft Corporation.
>> + *
>> + * This file contains functions that are called from one or more modules: ROOT,
>> + * DIAG, or VTL. If any of these modules are configured to build, this file is
> 
> What are the DIAG and VTL modules?  I see only a root module in the Makefile.
> 
Ah, yep, they are not in this patchset but will follow. I can remove thereferences to them here, and make this comment future tense: "functions that WILL
be called from one or more modules".

<snip>>> +
>> +struct mshv_vp {
>> +	u32 vp_index;
>> +	struct mshv_partition *vp_partition;
>> +	struct mutex vp_mutex;
>> +	struct hv_vp_register_page *vp_register_page;
>> +	struct hv_message *vp_intercept_msg_page;
>> +	void *vp_ghcb_page;
>> +	struct hv_stats_page *vp_stats_pages[2];
>> +	struct {
>> +		atomic64_t vp_signaled_count;
>> +		struct {
>> +			u64 intercept_suspend: 1;
>> +			u64 root_sched_blocked: 1; /* root scheduler only */
>> +			u64 root_sched_dispatched: 1; /* root scheduler only */
>> +			u64 reserved: 62;
> 
> Hmmm.  This looks like 65 bits allocated in a u64.
> 
Indeed it is, good catch

>> +
>> +	/*
>> +	 * Since MSHV does not support more than one async hypercall in flight
> 
> Wording is a bit messed up.  Drop the "Since"?
> 
Yep, thanks

>> +	 * for a single partition. Thus, it is okay to define per partition
>> +	 * async hypercall status.
>> +	 */
<snip>
>> +
>> +extern struct mshv_root mshv_root;
>> +extern enum hv_scheduler_type hv_scheduler_type;
>> +extern u8 __percpu **hv_synic_eventring_tail;
> 
> Per comments on an earlier patch, the __percpu is in the wrong place.
> 
Thanks, will fix here too.
<snip>>> +int hv_call_create_partition(u64 flags,
>> +			     struct hv_partition_creation_properties creation_properties,
>> +			     union hv_partition_isolation_properties isolation_properties,
>> +			     u64 *partition_id)
>> +{
>> +	struct hv_input_create_partition *input;
>> +	struct hv_output_create_partition *output;
>> +	u64 status;
>> +	int ret;
>> +	unsigned long irq_flags;
>> +
>> +	do {
>> +		local_irq_save(irq_flags);
>> +		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>> +		output = *this_cpu_ptr(hyperv_pcpu_output_arg);
>> +
>> +		memset(input, 0, sizeof(*input));
>> +		input->flags = flags;
>> +		input->compatibility_version = HV_COMPATIBILITY_21_H2;
>> +
>> +		memcpy(&input->partition_creation_properties, &creation_properties,
>> +		       sizeof(creation_properties));
> 
> This is an example of a generic question/concern that occurs in several places. By
> doing a memcpy into the hypercall input, the assumption is that the creation
> properties supplied by the caller have zeros in all the reserved or unused fields.
> Is that a valid assumption?
> 
When the entire struct is provided as a function parameter, I think it's a valid
assumption that that struct is initialized correctly by the caller.

The alternative (taking it to an extreme, in my opinion) is that we go through
each field in the parameters and assign them all individually, which could be quite
a lot of fields. E.g. going through all the bits in these structs with 60+ bitfields
and re-setting them here to be sure the reserved bits are 0.

>> +
>> +		memcpy(&input->isolation_properties, &isolation_properties,
>> +		       sizeof(isolation_properties));
>> +
>> +		status = hv_do_hypercall(HVCALL_CREATE_PARTITION,
>> +					 input, output);
<snip>>> +/* Ask the hypervisor to map guest ram pages or the guest mmio space */
>> +static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
>> +			       u32 flags, struct page **pages, u64 mmio_spa)
>> +{
>> +	struct hv_input_map_gpa_pages *input_page;
>> +	u64 status, *pfnlist;
>> +	unsigned long irq_flags, large_shift = 0;
>> +	int ret = 0, done = 0;
>> +	u64 page_count = page_struct_count;
>> +
>> +	if (page_count == 0 || (pages && mmio_spa))
>> +		return -EINVAL;
>> +
>> +	if (flags & HV_MAP_GPA_LARGE_PAGE) {
>> +		if (mmio_spa)
>> +			return -EINVAL;
>> +
>> +		if (!HV_PAGE_COUNT_2M_ALIGNED(page_count))
>> +			return -EINVAL;
>> +
>> +		large_shift = HV_HYP_LARGE_PAGE_SHIFT - HV_HYP_PAGE_SHIFT;
>> +		page_count >>= large_shift;
>> +	}
>> +
>> +	while (done < page_count) {
>> +		ulong i, completed, remain = page_count - done;
>> +		int rep_count = min(remain, HV_MAP_GPA_BATCH_SIZE);
>> +
>> +		local_irq_save(irq_flags);
>> +		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
>> +
>> +		input_page->target_partition_id = partition_id;
>> +		input_page->target_gpa_base = gfn + (done << large_shift);
>> +		input_page->map_flags = flags;
>> +		pfnlist = input_page->source_gpa_page_list;
>> +
>> +		for (i = 0; i < rep_count; i++)
>> +			if (flags & HV_MAP_GPA_NO_ACCESS) {
>> +				pfnlist[i] = 0;
>> +			} else if (pages) {
>> +				u64 index = (done + i) << large_shift;
>> +
>> +				if (index >= page_struct_count) {
> 
> Can this test ever be true?  It looks like the pages array must
> have space for each 4K page even if mapping in 2Meg granularity.> But only every 512th entry in the pages array is looked at
> (which seems a little weird). But based on how rep_count is set up,
> I don't see how the algorithm could go past the end of the pages
> array.
> 
I don't think the test can actually be true - IIRC I wrote it as a kind
of "is my math correct?" sanity check, and there was a pr_err() or a
WARN()here in a previous iteration of the code.

The large page list is a bit weird - When we allocate the large pages in
the kernel, we get all the (4K) page structs for that range back from the
kernel, and we hang onto them. When mapping the large pages into the
hypervisor we just have to map the PFN of the first page of each 2M page,
hence the skipping.

Now I'm thinking about it again, maybe we can discard most of the 4K page
structs the kernel gives back and keep it as a packed array of the "head"
pages which are all we really need (and then also simplify this mapping
code and save some memory).

The current code was just the simplest way to add the large page
functionality on top of what we already had, but looks like it could
probably be improved.

>> +					ret = -EINVAL;
>> +					break;
>> +				}
>> +				pfnlist[i] = page_to_pfn(pages[index]);
>> +			} else {
>> +				pfnlist[i] = mmio_spa + done + i;
>> +			}
>> +		if (ret)
>> +			break;
> 
> This test could also go away if the ret = -EINVAL error above can't
> happen.
> 
Ack
<snip>
>> +
>> +/* Ask the hypervisor to map guest mmio space */
>> +int hv_call_map_mmio_pages(u64 partition_id, u64 gfn, u64 mmio_spa, u64 numpgs)
>> +{
>> +	int i;
>> +	u32 flags = HV_MAP_GPA_READABLE | HV_MAP_GPA_WRITABLE |
>> +		    HV_MAP_GPA_NOT_CACHED;
>> +
>> +	for (i = 0; i < numpgs; i++)
>> +		if (page_is_ram(mmio_spa + i))
> 
> FWIW, doing this check one-page-at-a-time is somewhat expensive if numpgs
> is large.  The underlying data structures should support doing a single range
> check, but I haven't looked at whether functions exist to do such a range check.
> 
Indeed - I'll make a note to investigate, thanks.

>> +			return -EINVAL;
>> +
>> +	return hv_do_map_gpa_hcall(partition_id, gfn, numpgs, flags, NULL,
>> +				   mmio_spa);
>> +}
>> +
>> +int hv_call_unmap_gpa_pages(u64 partition_id, u64 gfn, u64 page_count_4k,
>> +			    u32 flags)
>> +{
>> +	struct hv_input_unmap_gpa_pages *input_page;
>> +	u64 status, page_count = page_count_4k;
>> +	unsigned long irq_flags, large_shift = 0;
>> +	int ret = 0, done = 0;
>> +
>> +	if (page_count == 0)
>> +		return -EINVAL;
>> +
>> +	if (flags & HV_UNMAP_GPA_LARGE_PAGE) {
>> +		if (!HV_PAGE_COUNT_2M_ALIGNED(page_count))
>> +			return -EINVAL;
>> +
>> +		large_shift = HV_HYP_LARGE_PAGE_SHIFT - HV_HYP_PAGE_SHIFT;
>> +		page_count >>= large_shift;
>> +	}
>> +
>> +	while (done < page_count) {
>> +		ulong completed, remain = page_count - done;
>> +		int rep_count = min(remain, HV_MAP_GPA_BATCH_SIZE);
> 
> Using HV_MAP_GPA_BATCH_SIZE seems a little weird here since there's
> no input array and hence no constraint based on keeping input args to
> just one page. Is it being used as an arbitrary limit so the rep_count
> passed to the hypercall isn't "too large" for some definition of "too large"?
> If that's the case, perhaps a separate #define and a comment would
> make sense. I kept trying to figure out how the batch size for unmap was
> related to the map hypercall, and I don't think there is any relationship.
> 
I think batching this was intentional so that we can be sure to re-enable
interrupts periodically when unmapping an entire VM's worth of memory. That
said, as you know the hypercall will return if it takes longer than a certain
amount of time so I guess that is "built-in" in some sense.

I think keeping the batching, but #defining a specific value for unmap as you
suggest is a good idea.

I'd be inclined to use a similar number (something like 512).

>> +
>> +		local_irq_save(irq_flags);
>> +		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
>> +
>> +		input_page->target_partition_id = partition_id;
>> +		input_page->target_gpa_base = gfn + (done << large_shift);
>> +		input_page->unmap_flags = flags;
>> +		status = hv_do_rep_hypercall(HVCALL_UNMAP_GPA_PAGES, rep_count,
>> +					     0, input_page, NULL);
>> +		local_irq_restore(irq_flags);
>> +
>> +		completed = hv_repcomp(status);
>> +		if (!hv_result_success(status)) {
>> +			ret = hv_result_to_errno(status);
>> +			break;
>> +		}
>> +
>> +		done += completed;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +int hv_call_get_gpa_access_states(u64 partition_id, u32 count, u64 gpa_base_pfn,
>> +				  union hv_gpa_page_access_state_flags state_flags,
>> +				  int *written_total,
>> +				  union hv_gpa_page_access_state *states)
>> +{
>> +	struct hv_input_get_gpa_pages_access_state *input_page;
>> +	union hv_gpa_page_access_state *output_page;
>> +	int completed = 0;
>> +	unsigned long remaining = count;
>> +	int rep_count, i;
>> +	u64 status;
>> +	unsigned long flags;
>> +
>> +	*written_total = 0;
>> +	while (remaining) {
>> +		local_irq_save(flags);
>> +		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
>> +		output_page = *this_cpu_ptr(hyperv_pcpu_output_arg);
>> +
>> +		input_page->partition_id = partition_id;
>> +		input_page->hv_gpa_page_number = gpa_base_pfn + *written_total;
>> +		input_page->flags = state_flags;
>> +		rep_count = min(remaining, HV_GET_GPA_ACCESS_STATES_BATCH_SIZE);
>> +
>> +		status = hv_do_rep_hypercall(HVCALL_GET_GPA_PAGES_ACCESS_STATES, rep_count,
>> +					     0, input_page, output_page);
>> +		if (!hv_result_success(status)) {
>> +			local_irq_restore(flags);
>> +			break;
>> +		}
>> +		completed = hv_repcomp(status);
>> +		for (i = 0; i < completed; ++i)
>> +			states[i].as_uint8 = output_page[i].as_uint8;
>> +
>> +		states += completed;
>> +		*written_total += completed;
>> +		remaining -= completed;
>> +		local_irq_restore(flags);
> 
> FWIW, this local_irq_restore() could move up three lines to before the progress
> accounting is done.
> 
Good point, thanks.
<snip>
>> +		memset(input, 0, sizeof(*input));
>> +		memset(output, 0, sizeof(*output));
> 
> Why is the output set to zero?  I would think Hyper-V is responsible for
> ensuring that the output is properly populated, with unused fields/areas
> set to zero.
> 
Overabundance of caution, I think! It doesn't need to be zeroed AFAIK.

I recently did a some cleanup (in our internal tree) to make sure we are
memset()ing the input and *not* memset()ing the output everywhere, but
it didn't make it into this series. There are a few more places like this.

<snip>
>> +
>> +int hv_call_set_vp_state(u32 vp_index, u64 partition_id,
>> +			 /* Choose between pages and bytes */
>> +			 struct hv_vp_state_data state_data, u64 page_count,
> 
> The size of "struct hv_vp_state_data" looks to be 24 bytes (3 64-bit words).
> Is there a reason to pass this by value instead of as a pointer? I guess it works
> like this, but it seems atypical.
> 
No particular reason. I'm guessing the compiler will pass this by copying it to this
function's stack frame - 24 bytes is still rather small so I don't think it's an issue.

I'm also under the impression the compiler may optimize this to a pointer since it is
not modified?

I usually only pass a pointer (for read-only values) when it's something really
large that I *definitely* don't want to be copied on the stack (like, 100 bytes?).
In that case I probably only have a pointer to vmalloc'd/kalloc()'d memory anyway.

<snip>
>> +	local_irq_save(flags);
>> +	status = hv_do_fast_hypercall8(HVCALL_CLEAR_VIRTUAL_INTERRUPT,
>> +				       partition_id) &
>> +			HV_HYPERCALL_RESULT_MASK;
> 
> This "anding" with HV_HYPERCALL_RESULT_MASK should be removed.
> 
Yep, thanks.

>> +	local_irq_restore(flags);
> 
> The irq save/restore isn't needed here since this is a fast hypercall and
> per-cpu arg memory is not used.
> 
Agreed, will remove these for the fast hypercall sites.

<snip>
>> +		input->proximity_domain_info = hv_numa_node_to_pxm_info(node);
>> +		status = hv_do_hypercall(HVCALL_CREATE_PORT, input, NULL) &
>> +			 HV_HYPERCALL_RESULT_MASK;
> 
> Use the hv_status checking macros instead of and'ing with
> HV_HYPERCALL_RESULT_MASK.
> 
Thanks, these need a bit of cleanup.

<snip>
>> +	status = hv_do_fast_hypercall16(HVCALL_DELETE_PORT,
>> +					input.as_uint64[0],
>> +					input.as_uint64[1]) &
>> +			HV_HYPERCALL_RESULT_MASK;
>> +	local_irq_restore(flags);
> 
> Same a previous comment about and'ing.  And irq save/restore
> isn't needed.
> 
ack

<snip>
>> +		status = hv_do_hypercall(HVCALL_CONNECT_PORT, input, NULL) &
>> +			 HV_HYPERCALL_RESULT_MASK;
> 
> Same here.  Use hv_* macros.
> 
ack

<snip>
>> +	status = hv_do_fast_hypercall16(HVCALL_DISCONNECT_PORT,
>> +					input.as_uint64[0],
>> +					input.as_uint64[1]) &
>> +			HV_HYPERCALL_RESULT_MASK;
>> +	local_irq_restore(flags);
> 
> Same as above.
> 
ack

<snip>
>> +	local_irq_save(flags);
>> +	input.sint_index = sint_index;
>> +	status = hv_do_fast_hypercall8(HVCALL_NOTIFY_PORT_RING_EMPTY,
>> +				       input.as_uint64) &
>> +		 HV_HYPERCALL_RESULT_MASK;
>> +	local_irq_restore(flags);
> 
> Same as above.
> 
ack, and I'll double check we don't have other fast hypercall sites doing this

<snip>>> +		/*
>> +		 * This is required to make sure that reserved field is set to
>> +		 * zero, because MSHV has a check to make sure reserved bits are
>> +		 * set to zero.
>> +		 */
> 
> Is this comment about checking reserved bits unique to this hypercall? If not, it
> seems a little odd to see this comment here, but not other places where the input
> is zero'ed.
> 
I agree the comment isn't necessary - memset()ing the input to zero should be the
default policy. I'll remove it.

>> +		memset(input_page, 0, sizeof(*input_page));
>> +		/* Only set the partition id if you are making the pages
>> +		 * exclusive
>> +		 */
>> +		if (flags & HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE)
>> +			input_page->partition_id = partition_id;
>> +		input_page->flags = flags;
>> +		input_page->host_access = host_access;
>> +
>> +		for (i = 0; i < rep_count; i++) {
>> +			u64 index = (done + i) << large_shift;
>> +
>> +			if (index >= page_struct_count)
>> +				return -EINVAL;
> 
> Can this test ever be true?
> 
See above in hv_do_map_gpa_hcall(), it's more of a sanity check or assert.

>> +
>> +			input_page->spa_page_list[i] =
>> +						page_to_pfn(pages[index]);
> 
> When large_shift is non-zero, it seems weird to be skipping over most
> of the entries in the "pages" array.  But maybe there's a reason for that.
> 
See above where we do the same thing in hv_do_map_gpa_hcall(). The hypervisor
only needs to see the "head" pages - the GPAs of the 2MB pages.

>> +		}
>> +
>> +		status = hv_do_rep_hypercall(code, rep_count, 0, input_page,
>> +					     NULL);
>> +		local_irq_restore(irq_flags);
>> +
>> +		completed = hv_repcomp(status);
>> +
>> +		if (!hv_result_success(status))
>> +			return hv_result_to_errno(status);
>> +
>> +		done += completed;
>> +	}
>> +
>> +	return 0;
>> +}
> 
> [snip the rest of the patch that I haven't reviewed yet]
> 
> Michael


