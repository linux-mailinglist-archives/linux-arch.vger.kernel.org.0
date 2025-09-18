Return-Path: <linux-arch+bounces-13680-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B5456B862A6
	for <lists+linux-arch@lfdr.de>; Thu, 18 Sep 2025 19:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A85C94E2BBC
	for <lists+linux-arch@lfdr.de>; Thu, 18 Sep 2025 17:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775B631355D;
	Thu, 18 Sep 2025 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="L7LbEwHs"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE97426B74A;
	Thu, 18 Sep 2025 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215481; cv=none; b=MaL94wZ2v42eJ5oWCur3OcZycPW/7e1sNopiYaWOOK4hCdon9DeyYpbM3NbSFeweSkWN876fAnNyoo9bitDUDdzIo6OyvTUsWZg8XgJRlBEsFGYPsqLUWa6triIgwSlVCNOT3MWI/gsUojCeW2CGjriyn/7YsqtUaoNSRHz3vzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215481; c=relaxed/simple;
	bh=9xha+Sew8ao0lfqA0DrjVsj67/PQt/V8s6oL45X0vn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aK1srP5vU+d8pAv1KR77M6BwUX0gnkMU1fBPvehlufcqN/qfrvg/kDMS4HTzIwNrHRpj6K+wHDzjcHQO+ekLt8EeF9uw6SxrU+KBntFo/HhhuK/e70rKElavLs2wIFQpcw56bnwEdGkkec8nH4Qra26MHmdoL+PpnQFukoMz2oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=L7LbEwHs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-166.hsd1.wa.comcast.net [98.225.44.166])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4C5AE20143D0;
	Thu, 18 Sep 2025 10:11:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4C5AE20143D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758215474;
	bh=eb8uc79smY+eM6cnckViDbW2FWxjH04s95FBPUXLfD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L7LbEwHsgCC+O85actqse7LAmDE/wJLXCZpQmRJhvwmj9RvgabmSqfzRcIUq//mZ7
	 rFon4TQP59+5HFb7AZZ9Kz9DfVwZ1AZaYaBlW1dyNI7oB+Ld8DcEMhPhiHnhs6uwa3
	 U//30pzlFtcDUJJxiFdCAaIM3gkK+1/mfLBnVM/k=
Date: Thu, 18 Sep 2025 10:11:12 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Mukesh Rathor <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	arnd@arndb.de
Subject: Re: [PATCH v1 5/6] x86/hyperv: Implement hypervisor ram collection
 into vmcore
Message-ID: <aMw9MCq8788YauXs@skinsburskii.localdomain>
References: <20250910001009.2651481-1-mrathor@linux.microsoft.com>
 <20250910001009.2651481-6-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910001009.2651481-6-mrathor@linux.microsoft.com>

On Tue, Sep 09, 2025 at 05:10:08PM -0700, Mukesh Rathor wrote:

<snip>

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
> +		for (;;);			/* cause no vmexits */
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
> +	input->rip = trampoline_pa;	/* PA of hv_crash_asm32 */
> +	input->arg = devirt_cr3arg;	/* PA of trampoline page table L4 */
> +
> +	status = hv_do_hypercall(HVCALL_DISABLE_HYP_EX, input, NULL);
> +
> +	/* Devirt failed, just reboot as things are in very bad state now */
> +	native_wrmsrq(HV_X64_MSR_RESET, 1);    /* get hv to reboot */

AFAIU here ...

> +}
> +
> +/*
> + * Generic nmi callback handler: could be called without any crash also.
> + *   hv crash: hypervisor injects nmi's into all cpus
> + *   lx crash: panicing cpu sends nmi to all but self via crash_stop_other_cpus
> + */
> +static int hv_crash_nmi_local(unsigned int cmd, struct pt_regs *regs)
> +{
> +	int ccpu = smp_processor_id();
> +
> +	if (!hv_has_crashed && hv_cda && hv_cda->cda_valid)
> +		hv_has_crashed = 1;
> +
> +	if (!hv_has_crashed && !lx_has_crashed)
> +		return NMI_DONE;	/* ignore the nmi */
> +
> +	if (hv_has_crashed) {
> +		if (!kexec_crash_loaded() || !hv_crash_enabled) {
> +			if (ccpu == 0) {
> +				native_wrmsrq(HV_X64_MSR_RESET, 1); /* reboot */

and here the machine will be reset, which in both cases won't allow to
collect the VMRS file, thus not allowing to debug nested hypervisor
failures.

Perhaps it worth keeping the state for any case (not just nested), but
the nested state should be preserved.

Thanks,
Stanislav

> -- 
> 2.36.1.vfs.0.0
> 

