Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5723D2AD28C
	for <lists+linux-arch@lfdr.de>; Tue, 10 Nov 2020 10:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbgKJJd2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Nov 2020 04:33:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:51742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729902AbgKJJd2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Nov 2020 04:33:28 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2762C20780;
        Tue, 10 Nov 2020 09:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605000807;
        bh=uEKTfHixYeT5Tb8Ezc5HUHIdMDI5g+hUoBiizVerKYI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=16Q3RE3v0hUqz5GUBORBmyBzTvExolpPPZ71vWgfjUxvo9a01hpTi0ftSpcwvJ93f
         1wbzK113f1ZKz22A90Fj3XA3w3Kg86/T+j3aqrbq3VP3QLzw80vothuBr+qf25wi3q
         cZj2i7dTyowQW955IgqTmg7soHhoYOtOKAFs0pmY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kcQ1l-009Oxm-5T; Tue, 10 Nov 2020 09:33:25 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Nov 2020 09:33:25 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, kernel-team@android.com
Subject: Re: [PATCH v2 3/6] KVM: arm64: Kill 32-bit vCPUs on systems with
 mismatched EL0 support
In-Reply-To: <20201109213023.15092-4-will@kernel.org>
References: <20201109213023.15092-1-will@kernel.org>
 <20201109213023.15092-4-will@kernel.org>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <1df601250710b1fdef1e9089c33c5850@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, catalin.marinas@arm.com, gregkh@linuxfoundation.org, peterz@infradead.org, morten.rasmussen@arm.com, qais.yousef@arm.com, surenb@google.com, qperret@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-11-09 21:30, Will Deacon wrote:
> If a vCPU tries to run 32-bit code on a system with mismatched support

nit: s/tries to run/is caught running/

> at EL0, then we should kill it.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/kvm/arm.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 5750ec34960e..d322ac0f4a8e 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -633,6 +633,15 @@ static void check_vcpu_requests(struct kvm_vcpu 
> *vcpu)
>  	}
>  }
> 
> +static bool vcpu_mode_is_bad_32bit(struct kvm_vcpu *vcpu)
> +{
> +	if (likely(!vcpu_mode_is_32bit(vcpu)))
> +		return false;
> +
> +	return !system_supports_32bit_el0() ||
> +		static_branch_unlikely(&arm64_mismatched_32bit_el0);
> +}
> +
>  /**
>   * kvm_arch_vcpu_ioctl_run - the main VCPU run function to execute 
> guest code
>   * @vcpu:	The VCPU pointer
> @@ -816,7 +825,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>  		 * with the asymmetric AArch32 case), return to userspace with
>  		 * a fatal error.
>  		 */
> -		if (!system_supports_32bit_el0() && vcpu_mode_is_32bit(vcpu)) {
> +		if (vcpu_mode_is_bad_32bit(vcpu)) {
>  			/*
>  			 * As we have caught the guest red-handed, decide that
>  			 * it isn't fit for purpose anymore by making the vcpu

Acked-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...
