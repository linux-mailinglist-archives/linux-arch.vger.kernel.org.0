Return-Path: <linux-arch+bounces-13402-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 901BBB4951C
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 18:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4E13A538A
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 16:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBBB310764;
	Mon,  8 Sep 2025 16:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PwXasI5W"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEA8310655;
	Mon,  8 Sep 2025 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348494; cv=none; b=m2ApNbeuDvPMV3DiTDkVt5qgrj18vl96vhiTX3oKl+WGQ9IGTEjlqAmxTqO40TZbdYe2d/N9xEehxnJbd69wzW45ynTnUEUjgOAL14kTxFsL/L3QBHJCJztQrZGxyTNFCC+1xpJNRN/O4TRHqAzwev81Rdez1p8sRXs31Pku4FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348494; c=relaxed/simple;
	bh=34GpOzLXR0bFyAQy1FTwKhInP6+RG92gscjcwlECu4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqMp4rr4m7k8On2mqtCBpn2NqgmZapUafBLJdMmsyIPA1FSCE69EEknJ2CXd2t3/Lzzp47llIP2gBr2u8HS1CMCa1aQvxvUAdHxCy7Kpc7lxic0hw9q/NGVTFmL/quipxrjq47XDjQeFCK6IXdYeTFVfFsCWJbcbw24nZXEYIoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PwXasI5W; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id 84E312114259;
	Mon,  8 Sep 2025 09:21:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 84E312114259
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757348482;
	bh=RwbrwhKhFyk94/grv3i9OeNqfC4w6utxpOAblVOvnD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PwXasI5WFEeFUwo4+f9MgPn/P/sHAEf7MMusi9Y/95/ZdSJi8ojLuSnRfjBC0TST1
	 Beezep5afWxBt5tMHKmvMBSogI7og7/kaDO72C65seuugaTJVVNEFeAJiltTwys13H
	 gVWr0qXEt5PdbO3Tb8OElnPqgPXEuO+i1+eoU92I=
Date: Mon, 8 Sep 2025 09:21:18 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Mukesh Rathor <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	arnd@arndb.de
Subject: Re: [PATCH v0 5/6] x86/hyperv: Implement hypervisor ram collection
 into vmcore
Message-ID: <aL8Cfsl3Vaeuw-QI@skinsburskii.localdomain>
References: <20250904021017.1628993-1-mrathor@linux.microsoft.com>
 <20250904021017.1628993-6-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904021017.1628993-6-mrathor@linux.microsoft.com>

On Wed, Sep 03, 2025 at 07:10:16PM -0700, Mukesh Rathor wrote:
> This commit introduces a new file to enable collection of hypervisor ram
> into the vmcore collected by linux. By default, the hypervisor ram is locked,
> ie, protected via hw page table. Hyper-V implements a disable hypercall which
> essentially devirtualizes the system on the fly. This mechanism makes the
> hypervisor ram accessible to linux without any extra work because it is
> already mapped into linux address space. Details of the implementation
> are available in the file prologue.
> 
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_crash.c | 618 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 618 insertions(+)
>  create mode 100644 arch/x86/hyperv/hv_crash.c
> 
> diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
> new file mode 100644
> index 000000000000..50c54d39f0e2
> --- /dev/null
> +++ b/arch/x86/hyperv/hv_crash.c
> +

<snip>

> +/*
> + * generic nmi callback handler: could be called without any crash also.
> + *  hv crash: hypervisor injects nmi's into all cpus
> + *  lx crash: panicing cpu sends nmi to all but self via crash_stop_other_cpus
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
> +	if (hv_has_crashed && !hv_crash_enabled) {
> +		if (ccpu == 0) {
> +			pr_emerg("Hyper-V: core collect not setup. Reboot\n");
> +			native_wrmsrq(HV_X64_MSR_RESET, 1);	/* reboot */
> +		} else
> +			for (;;)
> +				cpu_relax();
> +	}
> +
> +	crash_nmi_callback(regs);
> +	return NMI_DONE;
> +}

One more thing.
It looks like the function above goes through the new logic even when
hypervisor is intact and there is no crash kernel loaded.
This is redundant and it should rather return back to the existent
generic kernel panic logic.

Stanislav


