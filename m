Return-Path: <linux-arch+bounces-10968-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62647A6976E
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 19:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94CCD1721B0
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 18:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAFD206F11;
	Wed, 19 Mar 2025 18:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sfta73GW"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697B3202971;
	Wed, 19 Mar 2025 18:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742407472; cv=none; b=McrqjDaxdcSu7cbZWFaPKy6CaiUwOTMXIIRqLLg5v0xOD4vq6OwPlhk2MMgzjICBw7m8Q4ue68lx+TueyWTkhZGiWCAHW9RclJq2RYQqoJTmKKkCmMJ41nPIVNsK67DLtNHKjVQNp4qVLRPzMluFGwBayoI9SDwD3uIgMJJwd9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742407472; c=relaxed/simple;
	bh=9p2UBz/QA8scnm5HX/3m0Mc66hHZZvwC2vmYqUnyn8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=srkTJCk7qRCKnRfLSt7U1bsGNKCy8wPb/maSLo9xtQkwJdtXsGgAyZhUuClAnO0dkfHtenrewh2nG0/6GiLlwLNot2H7BO7U9mfFE3dbEGNEoPx6lBkNvhyq59cm+IE7WgGRDW7iBSdQ8iaS5CYDiiyEVBipPatu4J2oiTfwdyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sfta73GW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 723342116B2A;
	Wed, 19 Mar 2025 11:04:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 723342116B2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742407464;
	bh=gC8pXVAWUQ2vl5I11MAp+n/V7d6h6Fj9qgoDP/kFvoI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sfta73GWjKfXmrNlFXAyYk/kkVe/NRLYwA4dkqy9LAxtDrmWcsW5VmvpxSozHi8tT
	 RZt3eXI14NRkqr1tR3scUWpBXcwA1I+Tmj+PAuy1qJUN5BkrEFW4u0tvBkLyrsd5Uf
	 tyrYDDo+h8c56GoBVQ7JiSgzgYQ2WT9z8myq3e4c=
Message-ID: <9791bc6b-d8ad-47ee-8c54-7230d044f8d5@linux.microsoft.com>
Date: Wed, 19 Mar 2025 11:04:22 -0700
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
 <afd87eba-742f-4b67-9171-fd8486416b7b@linux.microsoft.com>
 <SN6PR02MB41574DE5535222985147134CD4D92@SN6PR02MB4157.namprd02.prod.outlook.com>
 <BN7PR02MB4148D51FFF965676AD155A3ED4D92@BN7PR02MB4148.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <BN7PR02MB4148D51FFF965676AD155A3ED4D92@BN7PR02MB4148.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/2025 8:26 AM, Michael Kelley wrote:
> From: Michael Kelley <mhklinux@outlook.com> Sent: Tuesday, March 18, 2025 7:10 PM
>>
>> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Tuesday, March
>> 18, 2025 5:34 PM
>>>
>>> On 3/17/2025 4:51 PM, Michael Kelley wrote:
>>>> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, February 26, 2025 3:08 PM
> 
> [snip]
> 
>>>>> +
>>>>> +	region = mshv_partition_region_by_gfn(partition, mem.guest_pfn);
>>>>> +	if (!region)
>>>>> +		return -EINVAL;
>>> <snip>
>>>> +	case MSHV_GPAP_ACCESS_TYPE_ACCESSED:
>>>>> +		hv_type_mask = 1;
>>>>> +		if (args.access_op == MSHV_GPAP_ACCESS_OP_CLEAR) {
>>>>> +			hv_flags.clear_accessed = 1;
>>>>> +			/* not accessed implies not dirty */
>>>>> +			hv_flags.clear_dirty = 1;
>>>>> +		} else { // MSHV_GPAP_ACCESS_OP_SET
>>>>
>>>> Avoid C++ style comments.
>>>>
>>> Ack
>>>
>>>>> +			hv_flags.set_accessed = 1;
>>>>> +		}
>>>>> +		break;
>>>>> +	case MSHV_GPAP_ACCESS_TYPE_DIRTY:
>>>>> +		hv_type_mask = 2;
>>>>> +		if (args.access_op == MSHV_GPAP_ACCESS_OP_CLEAR) {
>>>>> +			hv_flags.clear_dirty = 1;
>>>>> +		} else { // MSHV_GPAP_ACCESS_OP_SET
>>>>
>>>> Same here.
>>>>
>>> Ack
>>>
>>>>> +			hv_flags.set_dirty = 1;
>>>>> +			/* dirty implies accessed */
>>>>> +			hv_flags.set_accessed = 1;
>>>>> +		}
>>>>> +		break;
>>>>> +	}
>>>>> +
>>>>> +	states = vzalloc(states_buf_sz);
>>>>> +	if (!states)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	ret = hv_call_get_gpa_access_states(partition->pt_id, args.page_count,
>>>>> +					    args.gpap_base, hv_flags, &written,
>>>>> +					    states);
>>>>> +	if (ret)
>>>>> +		goto free_return;
>>>>> +
>>>>> +	/*
>>>>> +	 * Overwrite states buffer with bitmap - the bits in hv_type_mask
>>>>> +	 * correspond to bitfields in hv_gpa_page_access_state
>>>>> +	 */
>>>>> +	for (i = 0; i < written; ++i)
>>>>> +		assign_bit(i, (ulong *)states,
>>>>
>>>> Why the cast to ulong *?  I think this argument to assign_bit() is void *, in
>>>> which case the cast wouldn't be needed.
>>>>
>>> It looks like assign_bit() and friends resolve to a set of functions which do
>>> take an unsigned long pointer, e.g.:
>>>
>>> __set_bit() -> generic___set_bit(unsigned long nr, volatile unsigned long *addr)
>>> set_bit() -> arch_set_bit(unsigned int nr, volatile unsigned long *p)
>>> etc...
>>>
>>> So a cast is necessary.
>>
>> Indeed, you are right.  Seems like set_bit() and friends should take a void *.
>> But that's a different kettle of fish.
>>
>>>
>>>> Also, assign_bit() does atomic bit operations. Doing such in a loop like
>>>> here will really hammer the hardware memory bus with atomic
>>>> read-modify-write cycles. Use __assign_bit() instead, which does
>>>> non-atomic operations. You don't need atomic here as no other
>>>> threads are modifying the bit array.
>>>>
>>> I didn't realize it was atomic. I'll change it to __assign_bit().
>>>
>>>>> +			   states[i].as_uint8 & hv_type_mask);
>>>>
>>>> OK, so the starting contents of "states" is an array of bytes. The ending
>>>> contents is an array of bits. This works because every bit in the ending
>>>> bit array is set to either 0 or 1. Overlap occurs on the first iteration
>>>> where the code reads the 0th byte, and writes the 0th bit, which is part of
>>>> the 0th byte. The second iteration reads the 1st byte, and writes the 1st bit,
>>>> which doesn't overlap, and there's no overlap from then on.
>>>>
>>>> Suppose "written" is not a multiple of 8. The last byte of "states" as an
>>>> array of bits will have some bits that have not been set to either 0 or 1 and
>>>> might be leftover garbage from when "states" was an array of bytes. That
>>>> garbage will get copied to user space. Is that OK? Even if user space knows
>>>> enough to ignore those bits, it seems a little dubious to be copying even
>>>> a few bits of garbage to user space.
>>>>
>>>> Some comments might help here.
>>>>
>>> This is a good point. The expectation is indeed that userspace knows which
>>> bits are valid from the returned "written" value, but I agree it's a bit
>>> odd to have some garbage bits in the last byte. How does this look (to be
>>> inserted here directly after the loop):
>>>
>>> +       /* zero the unused bits in the last byte of the returned bitmap */
>>> +       if (written > 0) {
>>> +               u8 last_bits_mask;
>>> +               int last_byte_idx;
>>> +               int bits_rem = written % 8;
>>> +
>>> +               /* bits_rem == 0 when all bits in the last byte were assigned */
>>> +               if (bits_rem > 0) {
>>> +                       /* written > 0 ensures last_byte_idx >= 0 */
>>> +                       last_byte_idx = ((written + 7) / 8) - 1;
>>> +                       /* bits_rem > 0 ensures this masks 1 to 7 bits */
>>> +                       last_bits_mask = (1 << bits_rem) - 1;
>>> +                       states[last_byte_idx].as_uint8 &= last_bits_mask;
>>> +               }
>>> +       }
>>
>> A simpler approach is to "continue" the previous loop.  And if "written"
>> is zero, this additional loop won't do anything either:
>>
>> 	for (i = written; i < ALIGN(written, 8); ++i)
>> 		__clear_bit(i, (ulong *)states);
>>
> > One further thought here: Could "written" be less than
> args.page_count at this point? That would require
> hv_call_get_gpa_access_states() to not fail, but still return
> a value for written that is less than args.page_count. If that
> could happen, then the above loop should be:
> 
> 	for (i = written; i < bitmap_buf_sz * 8; ++i)
> 		__clear_bit(i, (ulong *)states);
> 
> so that all the uninitialized bits and bytes that will be written
> back to user space are cleared.
> Hmmm...now I'm not so sure where the need for "written" came from in
the first place - in practice "written" will always be equal to
args.page_count except on error, but in that case there's a goto
free_return anyway, so the number is never copied to userspace. And
I checked the userspace code - it doesn't expect a partial result
either.

So it seems to be redundant, but I don't really want to remove it just
now.

Your suggestion with bitmap_buf_sz * 8 should be fine, and will make it
straightforward to remove "written" in a future cleanup if that ends up
looking like a good idea.

>>>
>>> The remaining bytes could be memset() to zero but I think it's fine to leave
>>> them.
>>
>> I agree.  The remaining bytes aren't written back to user space anyway
>> since the copy_to_user() uses bitmap_buf_sz.
> 
> Maybe I misunderstood what you meant by "remaining bytes".  I think
> all bits and bytes that are written back to user space should have
> valid data or zeros so that no garbage is written back.
> 
Agreed.

Nuno

> Michael
> 
>>
>>>
>>>>> +
>>>>> +	args.page_count = written;
>>>>> +
>>>>> +	if (copy_to_user(user_args, &args, sizeof(args))) {
>>>>> +		ret = -EFAULT;
>>>>> +		goto free_return;
>>>>> +	}
>>>>> +	if (copy_to_user((void __user *)args.bitmap_ptr, states, bitmap_buf_sz))
>>>>> +		ret = -EFAULT;
>>>>> +
>>>>> +free_return:
>>>>> +	vfree(states);
>>>>> +	return ret;
>>>>> +}


