Return-Path: <linux-arch+bounces-13456-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 646CEB5047A
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 19:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2532D5E4565
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 17:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0CA352FF5;
	Tue,  9 Sep 2025 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ulduel1y"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC8635691F;
	Tue,  9 Sep 2025 17:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757438979; cv=none; b=G/VjIAIha08DWsvmetAL8rZf9rMkBZe7ykjeM39ImkOgtDACz7kF3135RFReRHsSZmgWwJ7Y2hSDJX0TXX3uY4EU9K0CgF59UvcIcLIa72CTFe2QF1u/uR2Y+J6j5VDrs7e3jsJhP6wd8VFTFxI5CduKwMtJ38mq8jRgxlkIIVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757438979; c=relaxed/simple;
	bh=X6h+qkwqhh7NJsAq+bWdQ5P4ns7PaP8xLURDSvlJljo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWRswM9Kr0230UDbXbQ3MVo02iQ5Z0tUGv0567RJcDoal/lzLC2bevJgArNzzUxWwCxzAmwKGgq+fa8aPAQslLmpD/L4D/o27BKKkDfoQY+IAEwIJivGVO4R/+RfTkB4GCnudtA6zFlaFFiVNI4Csn+43sowQKZf5xaiROMOgFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ulduel1y; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2BDBB211AA25;
	Tue,  9 Sep 2025 10:29:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2BDBB211AA25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757438977;
	bh=gp/ZTt/4C0fll+DipX39N43BG3drsSk0xDimngnq7gU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ulduel1y8gp1lzs6p/K1YSYfATdGgzT7tOnqx2z00wQ2Mcm+5kFiSrjKbHNL1dKR7
	 SsXcdo8CG0GKrchvp1b7FEAxTpHkJdO1P5JZrZcO5x2CuPHdQuHNI6cdSgJkYdVbQw
	 3BNKjTk6P6FOjY5afJlDJwQxuUJAts3JmGECMPE4=
Date: Tue, 9 Sep 2025 10:29:35 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	arnd@arndb.de
Subject: Re: [PATCH v0 5/6] x86/hyperv: Implement hypervisor ram collection
 into vmcore
Message-ID: <aMBj_2ad2vGEIy9J@skinsburskii.localdomain>
References: <20250904021017.1628993-1-mrathor@linux.microsoft.com>
 <20250904021017.1628993-6-mrathor@linux.microsoft.com>
 <aLoUsvfcAqGdV9Qr@skinsburskii.localdomain>
 <69639330-7fa0-0dce-2504-8c5e3c6e9a64@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69639330-7fa0-0dce-2504-8c5e3c6e9a64@linux.microsoft.com>

On Thu, Sep 04, 2025 at 07:38:53PM -0700, Mukesh R wrote:
> On 9/4/25 15:37, Stanislav Kinsburskii wrote:
> > On Wed, Sep 03, 2025 at 07:10:16PM -0700, Mukesh Rathor wrote:
> >> +
> >> +/*
> >> + * Common function for all cpus before devirtualization.
> >> + *
> >> + * Hypervisor crash: all cpus get here in nmi context.
> >> + * Linux crash: the panicing cpu gets here at base level, all others in nmi
> >> + *		context. Note, panicing cpu may not be the bsp.
> >> + *
> >> + * The function is not inlined so it will show on the stack. It is named so
> >> + * because the crash cmd looks for certain well known function names on the
> >> + * stack before looking into the cpu saved note in the elf section, and
> >> + * that work is currently incomplete.
> >> + *
> >> + * Notes:
> >> + *  Hypervisor crash:
> >> + *    - the hypervisor is in a very restrictive mode at this point and any
> >> + *	vmexit it cannot handle would result in reboot. For example, console
> >> + *	output from here would result in synic ipi hcall, which would result
> >> + *	in reboot. So, no mumbo jumbo, just get to kexec as quickly as possible.
> >> + *
> >> + *  Devirtualization is supported from the bsp only.
> >> + */
> >> +static noinline __noclone void crash_nmi_callback(struct pt_regs *regs)
> >> +{
> >> +	struct hv_input_disable_hyp_ex *input;
> >> +	u64 status;
> >> +	int msecs = 1000, ccpu = smp_processor_id();
> >> +
> >> +	if (ccpu == 0) {
> >> +		/* crash_save_cpu() will be done in the kexec path */
> >> +		cpu_emergency_stop_pt();	/* disable performance trace */
> >> +		atomic_inc(&crash_cpus_wait);
> >> +	} else {
> >> +		crash_save_cpu(regs, ccpu);
> >> +		cpu_emergency_stop_pt();	/* disable performance trace */
> >> +		atomic_inc(&crash_cpus_wait);
> >> +		for (;;);			/* cause no vmexits */
> >> +	}
> >> +
> >> +	while (atomic_read(&crash_cpus_wait) < num_online_cpus() && msecs--)
> >> +		mdelay(1);
> >> +
> >> +	stop_nmi();
> >> +	if (!hv_has_crashed)
> >> +		hv_notify_prepare_hyp();
> >> +
> >> +	if (crashing_cpu == -1)
> >> +		crashing_cpu = ccpu;		/* crash cmd uses this */
> >> +
> >> +	hv_hvcrash_ctxt_save();
> >> +	hv_mark_tss_not_busy();
> >> +	hv_crash_fixup_kernpt();
> >> +
> >> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> >> +	memset(input, 0, sizeof(*input));
> >> +	input->rip = trampoline_pa;	/* PA of hv_crash_asm32 */
> >> +	input->arg = devirt_cr3arg;	/* PA of trampoline page table L4 */
> >> +
> >> +	status = hv_do_hypercall(HVCALL_DISABLE_HYP_EX, input, NULL);
> >> +	if (!hv_result_success(status)) {
> >> +		pr_emerg("%s: %s\n", __func__, hv_result_to_string(status));
> >> +		pr_emerg("Hyper-V: disable hyp failed. kexec not possible\n");
> > 
> > These prints won't ever be printed to any console as prints in NMI
> > handler are deffered.
> 
> It's mostly for debug. There are different config options allowing one
> to build kernel easily dumping to either uart, led, speaker etc... There
> are no easy ways to debug. kernel debuggers could trap EMERGENCY printks 
> also...  
> 
> Are you 100% sure printk is async even if KERN_EMERG? If yes, I'd like to 
> propose someday to make it bypass all that for pr_emerg.
> 

Yes, I'm quite sure. Right now this looks like is dead code.

> 
> > Also, how are they aligned with the notice in the comment on top of
> > the function stating that console output would lead to synic ipi call?
> 
> Comment says "Hypervisor Crash". Please reread the whole block.
> 

The comment states that in case of hypervisor crash "console
output from here would result in synic ipi hcall, which would result in
reboot".
So, why printing anything if it will simply lead to reboot?

> > 
> > Resetting the machine from an NMI handler is sloppy.
> > There could be another NMI, which triggers the panic, leading to this handler.
> > NMI handlers servicing is batched meanining that not only this handler
> > won't output anything, but also any other prints from any other handlers
> > executed before the same lock won't be written out to consoles.
> > 
> > This introduces silent machine resets for the root partition. Can the
> > intrusive logic me moved to a tasklet?
> 
> I really don't think you understand what is going on here. I've tried
> telling you at least once in the past year, there is no return from the nmi 
> handler in case of hyp crash, and that this is panic mode, something 
> really bad has happened! It could be memory corruption, it could be 
> hw failure...  The hyp goes in emergency mode that just mostly loops, 
> handling tiny number of hypercalls and msrs for support of dom0/root 
> like windows that implements custom core collection in raw mode.
> 

I wasn't clear.
I wasn't talking about a hypervisor crash. If it is so intrusive, that an
attempt to print things to console may lead to reboot, then there should
be no prints for this case.

But this same logic is also used for Linux crashes, when prints can and
should be printed to console.
Moreover, whe same logic is used for a case when there is no crash
kernel loaded, which as I said already leads to silent reboot if panic
has happened in NMI handler.

I believe this needs to be fixed.

Stas


