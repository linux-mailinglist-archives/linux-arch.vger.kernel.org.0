Return-Path: <linux-arch+bounces-13389-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44026B44BAA
	for <lists+linux-arch@lfdr.de>; Fri,  5 Sep 2025 04:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E121B24408
	for <lists+linux-arch@lfdr.de>; Fri,  5 Sep 2025 02:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5366E207A3A;
	Fri,  5 Sep 2025 02:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VnwYnD3l"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893A83BB44;
	Fri,  5 Sep 2025 02:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757039943; cv=none; b=KT6xRmeIR8KwC9vXLiOUtMYlpSVjIE5PrvnbGoHDAKXHOPeqQBkzUTQcnLGGffF6KaQiCrbb6V+ZMV91Ir18e0qauUQ978Ma5gJ6M8FunDhwxIhhNT64W5uGXzKE5Ih37yjcTMkCYITvvT6sKpWJXbiX0XOJ7Q7gWouRJihvsso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757039943; c=relaxed/simple;
	bh=uQqoBfYMX69NyUQtyME2YZR7qU58/nGSW3VPx7GPavk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qhTKMTnoXxh3QEDlraCX4oQK9u/NTCRouu9m/o8G7SIVYkmxjOxGFXB8s6ZNFnKUcSnpm0biL8ZOo6z30Xjv8WMbAywKgBEYlW+OXZUcYJtgIF5qldeHeB6C3d9kxOYnJNv6ARk454E0n7fvffmlRHTUeGIBUrDtSiT4sYuXU10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VnwYnD3l; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id E8F1520171A2;
	Thu,  4 Sep 2025 19:38:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E8F1520171A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757039934;
	bh=F1zc6ijrbobXlcolUQdMDXicytniKJ23aitTlQlBf/w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VnwYnD3lS0QetFODdjRSz2zmKUI3t+JXWrKBROIkFeRdjJIZLukEO/1+r7TsdVMXE
	 DF09Ka6/s5mgsTwN0pgeJrgwncM4tUHrdeL0nQbAPDA2NN9SZ4n01gnqcbV3+NQgJ7
	 cbLh0ajz1wTho3IJlyNdelKs297OC5ci8dFImB1M=
Message-ID: <69639330-7fa0-0dce-2504-8c5e3c6e9a64@linux.microsoft.com>
Date: Thu, 4 Sep 2025 19:38:53 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v0 5/6] x86/hyperv: Implement hypervisor ram collection
 into vmcore
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, arnd@arndb.de
References: <20250904021017.1628993-1-mrathor@linux.microsoft.com>
 <20250904021017.1628993-6-mrathor@linux.microsoft.com>
 <aLoUsvfcAqGdV9Qr@skinsburskii.localdomain>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <aLoUsvfcAqGdV9Qr@skinsburskii.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/25 15:37, Stanislav Kinsburskii wrote:
> On Wed, Sep 03, 2025 at 07:10:16PM -0700, Mukesh Rathor wrote:
>> This commit introduces a new file to enable collection of hypervisor ram
>> into the vmcore collected by linux. By default, the hypervisor ram is locked,
>> ie, protected via hw page table. Hyper-V implements a disable hypercall which
>> essentially devirtualizes the system on the fly. This mechanism makes the
>> hypervisor ram accessible to linux without any extra work because it is
>> already mapped into linux address space. Details of the implementation
>> are available in the file prologue.
>>
>> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
>> ---
>>  arch/x86/hyperv/hv_crash.c | 618 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 618 insertions(+)
>>  create mode 100644 arch/x86/hyperv/hv_crash.c
>>
> 
> <snip>
> 
>> +
>> +/*
>> + * Common function for all cpus before devirtualization.
>> + *
>> + * Hypervisor crash: all cpus get here in nmi context.
>> + * Linux crash: the panicing cpu gets here at base level, all others in nmi
>> + *		context. Note, panicing cpu may not be the bsp.
>> + *
>> + * The function is not inlined so it will show on the stack. It is named so
>> + * because the crash cmd looks for certain well known function names on the
>> + * stack before looking into the cpu saved note in the elf section, and
>> + * that work is currently incomplete.
>> + *
>> + * Notes:
>> + *  Hypervisor crash:
>> + *    - the hypervisor is in a very restrictive mode at this point and any
>> + *	vmexit it cannot handle would result in reboot. For example, console
>> + *	output from here would result in synic ipi hcall, which would result
>> + *	in reboot. So, no mumbo jumbo, just get to kexec as quickly as possible.
>> + *
>> + *  Devirtualization is supported from the bsp only.
>> + */
>> +static noinline __noclone void crash_nmi_callback(struct pt_regs *regs)
>> +{
>> +	struct hv_input_disable_hyp_ex *input;
>> +	u64 status;
>> +	int msecs = 1000, ccpu = smp_processor_id();
>> +
>> +	if (ccpu == 0) {
>> +		/* crash_save_cpu() will be done in the kexec path */
>> +		cpu_emergency_stop_pt();	/* disable performance trace */
>> +		atomic_inc(&crash_cpus_wait);
>> +	} else {
>> +		crash_save_cpu(regs, ccpu);
>> +		cpu_emergency_stop_pt();	/* disable performance trace */
>> +		atomic_inc(&crash_cpus_wait);
>> +		for (;;);			/* cause no vmexits */
>> +	}
>> +
>> +	while (atomic_read(&crash_cpus_wait) < num_online_cpus() && msecs--)
>> +		mdelay(1);
>> +
>> +	stop_nmi();
>> +	if (!hv_has_crashed)
>> +		hv_notify_prepare_hyp();
>> +
>> +	if (crashing_cpu == -1)
>> +		crashing_cpu = ccpu;		/* crash cmd uses this */
>> +
>> +	hv_hvcrash_ctxt_save();
>> +	hv_mark_tss_not_busy();
>> +	hv_crash_fixup_kernpt();
>> +
>> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>> +	memset(input, 0, sizeof(*input));
>> +	input->rip = trampoline_pa;	/* PA of hv_crash_asm32 */
>> +	input->arg = devirt_cr3arg;	/* PA of trampoline page table L4 */
>> +
>> +	status = hv_do_hypercall(HVCALL_DISABLE_HYP_EX, input, NULL);
>> +	if (!hv_result_success(status)) {
>> +		pr_emerg("%s: %s\n", __func__, hv_result_to_string(status));
>> +		pr_emerg("Hyper-V: disable hyp failed. kexec not possible\n");
> 
> These prints won't ever be printed to any console as prints in NMI
> handler are deffered.

It's mostly for debug. There are different config options allowing one
to build kernel easily dumping to either uart, led, speaker etc... There
are no easy ways to debug. kernel debuggers could trap EMERGENCY printks 
also...  

Are you 100% sure printk is async even if KERN_EMERG? If yes, I'd like to 
propose someday to make it bypass all that for pr_emerg.


> Also, how are they aligned with the notice in the comment on top of
> the function stating that console output would lead to synic ipi call?

Comment says "Hypervisor Crash". Please reread the whole block.


>> +	}
>> +
>> +	native_wrmsrq(HV_X64_MSR_RESET, 1);    /* get hv to reboot */
> 
> Resetting the machine from an NMI handler is sloppy.
> There could be another NMI, which triggers the panic, leading to this handler.
> NMI handlers servicing is batched meanining that not only this handler
> won't output anything, but also any other prints from any other handlers
> executed before the same lock won't be written out to consoles.
> 
> This introduces silent machine resets for the root partition. Can the
> intrusive logic me moved to a tasklet?

I really don't think you understand what is going on here. I've tried
telling you at least once in the past year, there is no return from the nmi 
handler in case of hyp crash, and that this is panic mode, something 
really bad has happened! It could be memory corruption, it could be 
hw failure...  The hyp goes in emergency mode that just mostly loops, 
handling tiny number of hypercalls and msrs for support of dom0/root 
like windows that implements custom core collection in raw mode.

Lastly, if disable hyp fails, things are in dire straits and we do last 
ditch effort to print in case there is special debug printk or kernel 
debugger over serial attached intercepting pr_emerg, or print to LED 
for EMERGENCY etc ...  before rebooting without hanging.


>> +}
>> +
>> +/*
>> + * generic nmi callback handler: could be called without any crash also.
>> + *  hv crash: hypervisor injects nmi's into all cpus
>> + *  lx crash: panicing cpu sends nmi to all but self via crash_stop_other_cpus
>> + */
>> +static int hv_crash_nmi_local(unsigned int cmd, struct pt_regs *regs)
>> +{
>> +	int ccpu = smp_processor_id();
>> +
>> +	if (!hv_has_crashed && hv_cda && hv_cda->cda_valid)
>> +		hv_has_crashed = 1;
>> +
>> +	if (!hv_has_crashed && !lx_has_crashed)
>> +		return NMI_DONE;	/* ignore the nmi */
>> +
>> +	if (hv_has_crashed && !hv_crash_enabled) {
>> +		if (ccpu == 0) {
>> +			pr_emerg("Hyper-V: core collect not setup. Reboot\n");
> 
> Same here: this print won't reach console.
> 
>> +			native_wrmsrq(HV_X64_MSR_RESET, 1);	/* reboot */
>> +		} else
>> +			for (;;)
>> +				cpu_relax();
>> +	}
>> +
>> +	crash_nmi_callback(regs);
>> +	return NMI_DONE;
>> +}
>> +
> 
> <snip>
> 
>> +/* Setup for kdump kexec to collect hypervisor ram when running as mshv root */
>> +void hv_root_crash_init(void)
>> +{
>> +	int rc;
>> +	struct hv_input_get_system_property *input;
>> +	struct hv_output_get_system_property *output;
>> +	unsigned long flags;
>> +	u64 status;
>> +	union hv_pfn_range cda_info;
>> +
>> +	if (pgtable_l5_enabled()) {
>> +		pr_err("Hyper-V: crash dump not yet supported on 5level PTs\n");
>> +		goto err_out;
>> +	}
>> +
>> +	local_irq_save(flags);
>> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>> +	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
>> +
>> +	memset(input, 0, sizeof(*input));
>> +	memset(output, 0, sizeof(*output));
>> +	input->property_id = HV_SYSTEM_PROPERTY_CRASHDUMPAREA;
>> +
>> +	status = hv_do_hypercall(HVCALL_GET_SYSTEM_PROPERTY, input, output);
>> +	local_irq_restore(flags);
>> +	if (!hv_result_success(status))
>> +		goto prop_err_out;
>> +
>> +	cda_info.as_uint64 = output->hv_cda_info.as_uint64;
>> +
>> +	if (cda_info.base_pfn == 0) {
>> +		pr_err("Hyper-V: hypervisor crash dump area pfn is 0\n");
>> +		goto err_out;
>> +	}
>> +
>> +	hv_cda = phys_to_virt(cda_info.base_pfn << PAGE_SHIFT);
>> +
>> +	rc = hv_crash_trampoline_setup();
>> +	if (rc)
>> +		goto err_out;
>> +
>> +	register_nmi_handler(NMI_LOCAL, hv_crash_nmi_local, NMI_FLAG_FIRST,
>> +			     "hv_crash_nmi");
>> +
> 
> Rgistering NMI handler can fail and this should be handled.

Not sure if it "should be". There are other instances where this is 
not done because the call is guaranteed to be not recursive. 


> Stas
> 
>> +	smp_ops.crash_stop_other_cpus = hv_crash_stop_other_cpus;
>> +
>> +	crash_kexec_post_notifiers = true;
>> +	hv_crash_enabled = 1;
>> +	pr_info("Hyper-V: linux and hv kdump support enabled\n");
>> +
>> +	return;
>> +
>> +prop_err_out:
>> +	pr_err("Hyper-V: %s: property:%d %s\n", __func__, input->property_id,
>> +	       hv_result_to_string(status));
>> +err_out:
>> +	pr_err("Hyper-V: only linux (but not hv) kdump support enabled\n");
>> +}
>> +
>> -- 
>> 2.36.1.vfs.0.0
>>


