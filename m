Return-Path: <linux-arch+bounces-13888-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CB7BB5817
	for <lists+linux-arch@lfdr.de>; Thu, 02 Oct 2025 23:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EEA43A5254
	for <lists+linux-arch@lfdr.de>; Thu,  2 Oct 2025 21:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD313265CC5;
	Thu,  2 Oct 2025 21:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+K2wg+s"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31A07081C;
	Thu,  2 Oct 2025 21:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759441358; cv=none; b=JDTNZbcUFXuSY6WPlJPT32ZYKKfHdF4tUmjHsI0/4iHz5q90XR9TNKiYom/7dWVqpOcYa+Hh719gUc26qtNYw1o2B70O84k/gXj69NQLE+isnFt05klMNzenVGedF3GBqjcv2EfhRvfwISU65J2Tc4MBI8V1Jsa806u5/e8tJYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759441358; c=relaxed/simple;
	bh=R+U+5Uoh8xpG2po4iT5CxOmrkdsIQY39xuIay2qKYH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQSgg6j+l+CWnZ5ACtWNZggAqmBRP+RPHqsVZVSEvCTHcg0E8XsXASDaUZFKdAbcLQkwCeJ8O47ISCk/ocmw3vBixVU772zI1o4HSHI8jyJnJ4GYzjsCYTj/gjvhR0GvZ6WUx3mIzjRrwwDDw1ugoShBNx6/yV4/3PnI1jHsit0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+K2wg+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB198C4CEF4;
	Thu,  2 Oct 2025 21:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759441358;
	bh=R+U+5Uoh8xpG2po4iT5CxOmrkdsIQY39xuIay2qKYH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z+K2wg+s6ye8wg87MpZi4h3uVemy3ZH129Ew4Kn+NR01NV+mS+84oIRhVjtDVIK3U
	 t0Tcni0VZy6GPtDppQfSe7ewKPWUYQJ2e3RMVI2+/eCUi1KFmNJZ4yqR1Adq0oC8c9
	 VriiRho+tt0/765a+a+A/be8EeV0dLDh5O9whp9vshJNQfRCj6994UQqXOF+/WZnKF
	 phJShQ04sA+UQIzDJ+44DMGLSZdIMRgTbS67VFd0DfOq/CP5UtlIYS5yL/EMsvcwGh
	 wWILiw4VsKMgwilcGDKh7Tj2ES1kgsu2/VWP0NctHF9h8d3fUBvZ8i42dklE57sB7y
	 T7nI3kyHfBD4Q==
Date: Thu, 2 Oct 2025 21:42:36 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Mukesh Rathor <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	arnd@arndb.de
Subject: Re: [PATCH v2 5/6] x86/hyperv: Implement hypervisor RAM collection
 into vmcore
Message-ID: <20251002214236.GC925245@liuwe-devbox-debian-v2.local>
References: <20250923214609.4101554-1-mrathor@linux.microsoft.com>
 <20250923214609.4101554-6-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923214609.4101554-6-mrathor@linux.microsoft.com>

On Tue, Sep 23, 2025 at 02:46:08PM -0700, Mukesh Rathor wrote:
[...]
> +
> +/*
> + * This is the C entry point from the asm glue code after the devirt hypercall.

devirt -> devirtualization

> + * We enter here in IA32-e long mode, ie, full 64bit mode running on kernel
> + * page tables with our below 4G page identity mapped, but using a temporary
> + * GDT. ds/fs/gs/es are null. ss is not usable. bp is null. stack is not
> + * available. We restore kernel GDT, and rest of the context, and continue
> + * to kexec.
> + */
[...]
> +
> +static noinline __noclone void crash_nmi_callback(struct pt_regs *regs)
> +{
> +	struct hv_input_disable_hyp_ex *input;
> +	u64 status;
> +	int msecs = 1000, ccpu = smp_processor_id();
> +
> +	if (ccpu == 0) {
> +		/* crash_save_cpu() will be done in the kexec path */
> +		cpu_emergency_stop_pt();	/* disable performance trace */
> +		atomic_inc(&crash_cpus_wait);
> +	} else {
> +		crash_save_cpu(regs, ccpu);
> +		cpu_emergency_stop_pt();	/* disable performance trace */
> +		atomic_inc(&crash_cpus_wait);
> +		for (;;)
> +			cpu_relax();
> +	}
> +
> +	while (atomic_read(&crash_cpus_wait) < num_online_cpus() && msecs--)
> +		mdelay(1);
> +
> +	stop_nmi();
> +	if (!hv_has_crashed)
> +		hv_notify_prepare_hyp();
> +
> +	if (crashing_cpu == -1)
> +		crashing_cpu = ccpu;		/* crash cmd uses this */
> +
> +	hv_hvcrash_ctxt_save();
> +	hv_mark_tss_not_busy();
> +	hv_crash_fixup_kernpt();
> +
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->rip = trampoline_pa;
> +	input->arg = devirt_arg;
> +
> +	status = hv_do_hypercall(HVCALL_DISABLE_HYP_EX, input, NULL);
> +

If I understand this correctly, after this call, upon return from the
hypervisor, Linux will start executing the trampoline code.

> +	hv_panic_timeout_reboot();

Why is this needed? Is it to catch the case when the hypercall fails?


[...]
> +static void __noclone hv_crash_stop_other_cpus(void)
> +{
> +	static bool crash_stop_done;
> +	struct pt_regs lregs;
> +	int ccpu = smp_processor_id();
> +
> +	if (hv_has_crashed)
> +		return;		/* all cpus already in NMI handler path */
> +
> +	if (!kexec_crash_loaded()) {
> +		hv_notify_prepare_hyp();
> +		hv_panic_timeout_reboot();	/* no return */
> +	}
> +
> +	/* If hyp crashes also, we could come here again before cpus_stopped is

hypervisor or hv (given the same term is used in the function)

> +	 * set in crash_smp_send_stop(). So use our own check.
> +	 */
> +	if (crash_stop_done)
> +		return;
> +	crash_stop_done = true;
> +
> +	/* Linux has crashed: hv is healthy, we can ipi safely */

IPI.

> +
> +err_out:
> +	unregister_nmi_handler(NMI_LOCAL, "hv_crash_nmi");
> +	pr_err("Hyper-V: only linux (but not hyp) kdump support enabled\n");

hypervisor not hyp. This is a message for the user so we should be as
clear as possible.

Wei

> +}
> -- 
> 2.36.1.vfs.0.0
> 

