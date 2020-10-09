Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A312884F7
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 10:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732455AbgJIIMz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 04:12:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732337AbgJIIMy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Oct 2020 04:12:54 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 659EE2222C;
        Fri,  9 Oct 2020 08:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602231173;
        bh=OOZE/OubbAUXFk9LwOjk4/f69GK6LyH2hA25/MLV+rE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pEfiOlgHo15H2FnKlrJIfLDnErA/nRvfAcD2Ze789rgq7+jutJQwHwjZuTP6ysP/q
         pf0NSfGyl3NuEsq0efRZFr2R+j+z0Dr7hf4LaAT412Ds76gkVwsmHempD7eFEnMv8+
         yz171nv3slIsKkTyzwNzov9A9gBjU8cLxMmpK8UM=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kQnWF-000wZ0-Da; Fri, 09 Oct 2020 09:12:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 09 Oct 2020 09:12:51 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] arm64: kvm: Handle Asymmetric AArch32 systems
In-Reply-To: <20201008181641.32767-2-qais.yousef@arm.com>
References: <20201008181641.32767-1-qais.yousef@arm.com>
 <20201008181641.32767-2-qais.yousef@arm.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <7c058d22dce84ec7636863c1486b11d1@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: qais.yousef@arm.com, catalin.marinas@arm.com, will@kernel.org, peterz@infradead.org, morten.rasmussen@arm.com, gregkh@linuxfoundation.org, torvalds@linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-10-08 19:16, Qais Yousef wrote:
> On a system without uniform support for AArch32 at EL0, it is possible
> for the guest to force run AArch32 at EL0 and potentially cause an
> illegal exception if running on the wrong core.
> 
> Add an extra check to catch if the guest ever does that and prevent it
> from running again, treating it as ARM_EXCEPTION_IL.
> 
> We try to catch this misbehavior as early as possible and not rely on
> PSTATE.IL to occur.

nit: PSTATE.IL doesn't "occur". It is an "Illegal Exception Return" that
can happen.

> 
> Tested on Juno by instrumenting the host to:
> 
> 	* Fake asym aarch32.
> 	* Comment out hiding of ID registers from the guest.
> 
> Any attempt to run 32bit app in the guest will produce such error on
> qemu:
> 
> 	# ./test
> 	error: kvm run failed Invalid argument
> 	R00=ffff0fff R01=ffffffff R02=00000000 R03=00087968
> 	R04=000874b8 R05=ffd70b24 R06=ffd70b2c R07=00000055
> 	R08=00000000 R09=00000000 R10=00000000 R11=00000000
> 	R12=0000001c R13=ffd6f974 R14=0001ff64 R15=ffff0fe0
> 	PSR=a0000010 N-C- A usr32
> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> ---
>  arch/arm64/kvm/arm.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index b588c3b5c2f0..22ff3373d855 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -644,6 +644,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>  	struct kvm_run *run = vcpu->run;
>  	int ret;
> 
> +	if (!system_supports_32bit_el0() && vcpu_mode_is_32bit(vcpu)) {
> +		kvm_err("Illegal AArch32 mode at EL0, can't run.");

No, we don't scream on the console in an uncontrolled way based on
illegal user input (yes, the VM *is* userspace).

Furthermore, you seem to deal with the same problem *twice*. See below.

> +		return -ENOEXEC;
> +	}
> +
>  	if (unlikely(!kvm_vcpu_initialized(vcpu)))
>  		return -ENOEXEC;
> 
> @@ -804,6 +809,17 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
> 
>  		preempt_enable();
> 
> +		/*
> +		 * For asym aarch32 systems we present a 64bit only system to
> +		 * the guest. But in case it managed somehow to escape that and
> +		 * enter 32bit mode, catch that and prevent it from running
> +		 * again.

The guest didn't *escape* anything. It merely used the CPU as designed.
The fact that the hypervisor cannot prevent the guest from using AArch32
is an architectural defect.

> +		 */
> +		if (!system_supports_32bit_el0() && vcpu_mode_is_32bit(vcpu)) {
> +			kvm_err("Detected illegal AArch32 mode at EL0, exiting.");

Same remark as above. Userspace has access to PSTATE and can work out
the issue by itself.

> +			ret = ARM_EXCEPTION_IL;

This will cause the thread to return to userspace after having done a
vcpu_put(). So why don't you just mark the vcpu as uninitialized before
returning to userspace? It already is in an illegal state, and the only
reasonable thing userspace can do is to reset it.

This way, we keep the horror in a single place, and force userspace to
take action if it really wants to recover the guest.

         M.
-- 
Jazz is not dead. It just smells funny...
