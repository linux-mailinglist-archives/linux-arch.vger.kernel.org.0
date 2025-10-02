Return-Path: <linux-arch+bounces-13889-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13896BB586A
	for <lists+linux-arch@lfdr.de>; Fri, 03 Oct 2025 00:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906021AE128E
	for <lists+linux-arch@lfdr.de>; Thu,  2 Oct 2025 22:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF10280A56;
	Thu,  2 Oct 2025 22:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AqOHoEGj"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4001026FA67;
	Thu,  2 Oct 2025 22:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759442857; cv=none; b=KUu3DolVt49+U57rrDX6gBzz6Kue6IqxkM5AOF+bvlRZBJC3X/UVWtA5T/XKagZKGziFB214WUFZohU2/uhVPUBgoxmR5quXFiQcVPv7l1chAAJcgbU5t5ceA13PG7OkaL59k9BcUWvUB7kxvMnJ1bR4oZotQl0p+7U9wSYFuAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759442857; c=relaxed/simple;
	bh=l9PRSkbOjbx0wvtEpYGBAC3hbhyKfaeWce4pvuSbQx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f/ieUXT5szYhpfcTTCQusQsU1NvZEAUzN9W8oIHBmAcNerCN0GcY0gdwNqrwbLRaahQlFQGlEyda7LVR8EPt541K1XBc0mvCAXNSIlRPjaVfue8fVZOq0T7/7dxMrVuP9z3ZSoHIBKb//jshy2FgCU2kvSj67SqGyjGSekoFkEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AqOHoEGj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 57DAA211B7CF;
	Thu,  2 Oct 2025 15:07:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 57DAA211B7CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759442849;
	bh=xao0TbEt05A1Jnsh0i7O5sFYiMY/ojUq1im/BfgOwWs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AqOHoEGjS9LxyxRg0pHXUeETMaK7Ee5xZr/jWadxdFPSF+OK1t9+2iowHEHKP5Ovh
	 2d1opguXm/jHio3AKfpruIlXIlE+dAFxXS4vin7q/s6EE6Jc6qC00BDDElsHVc/BEc
	 HIF3Q0s/+53BSY/1vgf+IKi+rSht/duDqRWsrMd4=
Message-ID: <f6835c8e-70de-7bd0-f116-0a4eae0ef29c@linux.microsoft.com>
Date: Thu, 2 Oct 2025 15:07:28 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 5/6] x86/hyperv: Implement hypervisor RAM collection
 into vmcore
Content-Language: en-US
To: Wei Liu <wei.liu@kernel.org>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de
References: <20250923214609.4101554-1-mrathor@linux.microsoft.com>
 <20250923214609.4101554-6-mrathor@linux.microsoft.com>
 <20251002214236.GC925245@liuwe-devbox-debian-v2.local>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <20251002214236.GC925245@liuwe-devbox-debian-v2.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/25 14:42, Wei Liu wrote:
> On Tue, Sep 23, 2025 at 02:46:08PM -0700, Mukesh Rathor wrote:
> [...]
>> +
>> +/*
>> + * This is the C entry point from the asm glue code after the devirt hypercall.
> 
> devirt -> devirtualization
> 
>> + * We enter here in IA32-e long mode, ie, full 64bit mode running on kernel
>> + * page tables with our below 4G page identity mapped, but using a temporary
>> + * GDT. ds/fs/gs/es are null. ss is not usable. bp is null. stack is not
>> + * available. We restore kernel GDT, and rest of the context, and continue
>> + * to kexec.
>> + */
> [...]
>> +
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
>> +		for (;;)
>> +			cpu_relax();
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
>> +	input->rip = trampoline_pa;
>> +	input->arg = devirt_arg;
>> +
>> +	status = hv_do_hypercall(HVCALL_DISABLE_HYP_EX, input, NULL);
>> +
> 
> If I understand this correctly, after this call, upon return from the
> hypervisor, Linux will start executing the trampoline code.

correct.


>> +	hv_panic_timeout_reboot();
> 
> Why is this needed? Is it to catch the case when the hypercall fails?
  
correct.
 

> [...]
>> +static void __noclone hv_crash_stop_other_cpus(void)
>> +{
>> +	static bool crash_stop_done;
>> +	struct pt_regs lregs;
>> +	int ccpu = smp_processor_id();
>> +
>> +	if (hv_has_crashed)
>> +		return;		/* all cpus already in NMI handler path */
>> +
>> +	if (!kexec_crash_loaded()) {
>> +		hv_notify_prepare_hyp();
>> +		hv_panic_timeout_reboot();	/* no return */
>> +	}
>> +
>> +	/* If hyp crashes also, we could come here again before cpus_stopped is
> 
> hypervisor or hv (given the same term is used in the function)
> 
>> +	 * set in crash_smp_send_stop(). So use our own check.
>> +	 */
>> +	if (crash_stop_done)
>> +		return;
>> +	crash_stop_done = true;
>> +
>> +	/* Linux has crashed: hv is healthy, we can ipi safely */
> 
> IPI.
> 
>> +
>> +err_out:
>> +	unregister_nmi_handler(NMI_LOCAL, "hv_crash_nmi");
>> +	pr_err("Hyper-V: only linux (but not hyp) kdump support enabled\n");
> 
> hypervisor not hyp. This is a message for the user so we should be as
> clear as possible.

> Wei
> 
>> +}
>> -- 
>> 2.36.1.vfs.0.0
>>


