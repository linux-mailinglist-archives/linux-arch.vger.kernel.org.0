Return-Path: <linux-arch+bounces-13151-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8F7B23D49
	for <lists+linux-arch@lfdr.de>; Wed, 13 Aug 2025 02:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA633AAAB0
	for <lists+linux-arch@lfdr.de>; Wed, 13 Aug 2025 00:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FF49475;
	Wed, 13 Aug 2025 00:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJ2ozjWN"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334494685;
	Wed, 13 Aug 2025 00:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755045682; cv=none; b=lvRL13G2xSmx8G/BLpak14c9ailqxJi/gmCj0faPZuaAM//ZdMJ6vodPCx7KwuQmW235I66zgBeNdVQJlaiXVTD97amWfGUtRkm27Vnzkdti5U/s/WkCYXZPzg178AbQTqs7fyAH+djlD9k/8oHFrLk7uD7WKfCfROy1aJf3jdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755045682; c=relaxed/simple;
	bh=Asl961UA0vCD59+9K43qgi5UO6CxgMvHPUzfukUNK24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Om9OxuIk++tU38ug3SFRPGCnn2FeNoIjGcTu7UhNY+s9mlpF3mgbcerr0DkGDF4YMjckXaMATmf0ufZxKadsjSpG5oksgXD6FJpNYq3NFGskVVQUPDAl57VlhSwChLzbBTKBszRSZ6F9+IBaM8Sed3qzmDuG2zrhKrqzoaQ+sEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJ2ozjWN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6494EC4CEF0;
	Wed, 13 Aug 2025 00:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755045681;
	bh=Asl961UA0vCD59+9K43qgi5UO6CxgMvHPUzfukUNK24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vJ2ozjWNphL/gaj64VX0kduHHYvtCg2wG0Qn1q3Eo0znTTQEWAb7/AOGep3z0Afpo
	 2Ay2/hE0Eat3ioXCuCl6mg+l4mPD5Cdm0nZWz3GD/hCRYkKNDZ3rljqXggql5iwbZf
	 1hVf5D8ri+rTQP5fZazAfYv5ekrFw2AU7VisIoC6uXj9LfRbm97O2FG/TVyUsrrHr7
	 JWeqWldHB6kDW/RJtaDuAj31lbtkfzSWJNwsnsiXTgEnUDo+ByfLSY8/uvfv7rq9R4
	 aopPNxNNxDvb0DHs9jVxWOn/+cn01wb99WAyxwjslCZNBsa7DAx1/mdum2jyEiUTvE
	 4dlMG1OOwjRSw==
Date: Wed, 13 Aug 2025 00:41:20 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, lpieralisi@kernel.org, kw@linux.com, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, arnd@arndb.de, x86@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v4 2/7] x86/hyperv: Use hv_setup_*() to set up hypercall
 arguments -- part 1
Message-ID: <aJvfMN5BhyO5Ap5m@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250718045545.517620-1-mhklinux@outlook.com>
 <20250718045545.517620-3-mhklinux@outlook.com>
 <252e58be-4377-49b7-a572-0d40f54993d1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <252e58be-4377-49b7-a572-0d40f54993d1@linux.microsoft.com>

On Tue, Aug 12, 2025 at 05:22:29PM -0700, Nuno Das Neves wrote:
> On 7/17/2025 11:55 PM, mhkelley58@gmail.com wrote:
> > From: Michael Kelley <mhklinux@outlook.com>
> > 
> > Update hypercall call sites to use the new hv_setup_*() functions
> > to set up hypercall arguments. Since these functions zero the
> > fixed portion of input memory, remove now redundant calls to memset()
> > and explicit zero'ing of input fields.
> > 
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> > ---
> > 
> > Notes:
> >     Changes in v4:
> >     * Rename hv_hvcall_*() functions to hv_setup_*() [Easwar Hariharan]
> >     * Rename hv_hvcall_in_batch_size() to hv_get_input_batch_size()
> >       [Easwar Hariharan]
> >     
> >     Changes in v2:
> >     * Fixed get_vtl() and hv_vtl_apicid_to_vp_id() to properly treat the input
> >       and output arguments as arrays [Nuno Das Neves]
> >     * Enhanced __send_ipi_mask_ex() and hv_map_interrupt() to check the number
> >       of computed banks in the hv_vpset against the batch_size. Since an
> >       hv_vpset currently represents a maximum of 4096 CPUs, the hv_vpset size
> >       does not exceed 512 bytes and there should always be sufficent space. But
> >       do the check just in case something changes. [Nuno Das Neves]
> > 
> 
> <snip>
> 
> > diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
> > index 090f5ac9f492..87ebe43f58cf 100644
> > --- a/arch/x86/hyperv/irqdomain.c
> > +++ b/arch/x86/hyperv/irqdomain.c
> > @@ -21,15 +21,15 @@ static int hv_map_interrupt(union hv_device_id device_id, bool level,
> >  	struct hv_device_interrupt_descriptor *intr_desc;
> >  	unsigned long flags;
> >  	u64 status;
> > -	int nr_bank, var_size;
> > +	int batch_size, nr_bank, var_size;
> >  
> >  	local_irq_save(flags);
> >  
> > -	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > -	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
> > +	batch_size = hv_setup_inout_array(&input, sizeof(*input),
> > +			sizeof(input->interrupt_descriptor.target.vp_set.bank_contents[0]),
> > +			&output, sizeof(*output), 0);
> >  
> 
> Hi Michael, I finally managed to test this series on (nested) root
> partition and encountered an issue when I applied this patch.
> 
> With the above change, I saw HV_STATUS_INVALID_ALIGNMENT from this
> hypercall. I printed out the addresses and sizes and everything looked
> correct. The output seemed to be correctly placed at the end of the
> percpu page. E.g. if input was allocated at an address ending in 0x3000,
> output would be at 0x3ff0, because hv_output_map_device_interrupt is
> 0x10 bytes in size.
> 
> But it turns out, the definition for hv_output_map_device_interrupt
> is out of date (or was never correct)! It should be:
> 
> struct hv_output_map_device_interrupt {
> 	struct hv_interrupt_entry interrupt_entry;
> 	u64 extended_status_deprecated[5];
> } __packed;
> 
> (The "extended_status_deprecated" field is missing in the current code.)
> 
> Due to this, when the hypervisor validates the hypercall input/output,
> it sees that output is going across a page boundary, because it knows
> sizeof(hv_output_map_device_interrupt) is actually 0x58.
> 
> I confirmed that adding the "extended_status_deprecated" field fixes the
> issue. That should be fixed either as part of this patch or an additional
> one.

Thanks for testing this, Nuno. In that case, can you please submit a
patch for hv_output_map_device_interrupt? That can go in via the fixes
tree.

Thanks,
Wei

> 
> Nuno
> 
> PS. I have yet to test the mshv driver changes in patch 6, I'll try to
> do so this week.
> 
> >  	intr_desc = &input->interrupt_descriptor;
> > -	memset(input, 0, sizeof(*input));
> >  	input->partition_id = hv_current_partition_id;
> >  	input->device_id = device_id.as_uint64;
> >  	intr_desc->interrupt_type = HV_X64_INTERRUPT_TYPE_FIXED;
> > @@ -41,7 +41,6 @@ static int hv_map_interrupt(union hv_device_id device_id, bool level,
> >  	else
> >  		intr_desc->trigger_mode = HV_INTERRUPT_TRIGGER_MODE_EDGE;
> >  
> > -	intr_desc->target.vp_set.valid_bank_mask = 0;
> >  	intr_desc->target.vp_set.format = HV_GENERIC_SET_SPARSE_4K;
> >  	nr_bank = cpumask_to_vpset(&(intr_desc->target.vp_set), cpumask_of(cpu));
> >  	if (nr_bank < 0) {
> > @@ -49,6 +48,11 @@ static int hv_map_interrupt(union hv_device_id device_id, bool level,
> >  		pr_err("%s: unable to generate VP set\n", __func__);
> >  		return -EINVAL;
> >  	}
> > +	if (nr_bank > batch_size) {
> > +		local_irq_restore(flags);
> > +		pr_err("%s: nr_bank too large\n", __func__);
> > +		return -EINVAL;
> > +	}
> >  	intr_desc->target.flags = HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET;
> >  
> >  	/*
> > @@ -78,9 +82,8 @@ static int hv_unmap_interrupt(u64 id, struct hv_interrupt_entry *old_entry)
> >  	u64 status;
> >  
> >  	local_irq_save(flags);
> > -	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> >  
> > -	memset(input, 0, sizeof(*input));
> > +	hv_setup_in(&input, sizeof(*input));
> >  	intr_entry = &input->interrupt_entry;
> >  	input->partition_id = hv_current_partition_id;
> >  	input->device_id = id;
> 
> 

