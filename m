Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB252C6A8D
	for <lists+linux-arch@lfdr.de>; Fri, 27 Nov 2020 18:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgK0RYl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Nov 2020 12:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgK0RYk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Nov 2020 12:24:40 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C046C0613D2
        for <linux-arch@vger.kernel.org>; Fri, 27 Nov 2020 09:24:40 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id s8so6311840wrw.10
        for <linux-arch@vger.kernel.org>; Fri, 27 Nov 2020 09:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H3ObvY1r3renc4Ah+jFrI+KzRbAudlUpLmDRxAHSY+U=;
        b=JpTGq8V4a8zWrWeJu8cV5tUMjcltaSPvcianrIRAx9qZ4cvC0O0EIk7+bF+G7fSTew
         5wvrFBNXfK/2OLu8fZoCT3WB61t0O9idgrlnsSYy1eEfZiW7xVc6Jq8kudBzltjU/kBX
         cueZuJjBKFmZUUJXc3OxotPCY09s5krti+WNVhyyLrZp9Ur4FFq+YB/N+eC5OjR2AeGw
         0Q0mZna3hEeDRac8uUTgFX3U/3F10fzMFImMXJDjF+tvTt6jYKwviOGOxaJDwZKm6NxA
         0o3N224wVU4R6du7oe16Vvl7poVuZMBdQ3RBvl1WYbSL6UhAmVw4v1VmUwJ9sG8MMQh9
         EpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H3ObvY1r3renc4Ah+jFrI+KzRbAudlUpLmDRxAHSY+U=;
        b=WiDU5qxrdosE19XbDZcey9Ja1UAlpr/f6TMbdadUy39DWA86HdPaxzei2PJoGxVDyE
         vH5chD0JZqgRHeEXuiJkQZ33e6Z4k9WG5Ds16mUP7oTboKVW+6LaGNDYmJCa6l5yJ7Nn
         0zldhQGZV+dQVDYwz3wwCVZTM/3SIgV2SLvdLrXLkgpxLuSKZRhp6sL8o1H0x/rCxIcm
         NrHVo7DxDiGzSOoDXjpEK9GkJ+qSD/nay1b2D6Ff9ZGC+25nQLq2pj06Ri55oEJ6ah43
         NfClTT8Dq7T5WrXiPwKf9zKv/EjpO+Jq2fWtI97y05DuDpAtJhP8eEDYy83VWUMzmOtm
         IfrA==
X-Gm-Message-State: AOAM532Cy2FPLR97LC7HMBUuaaERwffcZ2XOu0rklq3P86jok0NJpw9m
        K65WLSTlG1B5quQEJvjqR0CsNg==
X-Google-Smtp-Source: ABdhPJyVAqeh2K+OEvlhMIhr9vl4ww1DzWUlFf3LhHqGTGOr7T6czgXu/T6DtHCqB5BZbuX7SVSW9w==
X-Received: by 2002:a5d:6744:: with SMTP id l4mr11924486wrw.378.1606497878757;
        Fri, 27 Nov 2020 09:24:38 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id w11sm14212259wmg.36.2020.11.27.09.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 09:24:38 -0800 (PST)
Date:   Fri, 27 Nov 2020 17:24:34 +0000
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v4 03/14] KVM: arm64: Kill 32-bit vCPUs on systems with
 mismatched EL0 support
Message-ID: <20201127172434.GA984327@google.com>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-4-will@kernel.org>
 <9bd06b193e7fb859a1207bb1302b7597@kernel.org>
 <20201127115304.GB20564@willie-the-truck>
 <583c4074bbd4cf8b8085037745a5d1c0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <583c4074bbd4cf8b8085037745a5d1c0@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Friday 27 Nov 2020 at 17:14:11 (+0000), Marc Zyngier wrote:
> On 2020-11-27 11:53, Will Deacon wrote:
> > On Fri, Nov 27, 2020 at 10:26:47AM +0000, Marc Zyngier wrote:
> > > On 2020-11-24 15:50, Will Deacon wrote:
> > > > If a vCPU is caught running 32-bit code on a system with mismatched
> > > > support at EL0, then we should kill it.
> > > >
> > > > Acked-by: Marc Zyngier <maz@kernel.org>
> > > > Signed-off-by: Will Deacon <will@kernel.org>
> > > > ---
> > > >  arch/arm64/kvm/arm.c | 11 ++++++++++-
> > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> > > > index 5750ec34960e..d322ac0f4a8e 100644
> > > > --- a/arch/arm64/kvm/arm.c
> > > > +++ b/arch/arm64/kvm/arm.c
> > > > @@ -633,6 +633,15 @@ static void check_vcpu_requests(struct kvm_vcpu
> > > > *vcpu)
> > > >  	}
> > > >  }
> > > >
> > > > +static bool vcpu_mode_is_bad_32bit(struct kvm_vcpu *vcpu)
> > > > +{
> > > > +	if (likely(!vcpu_mode_is_32bit(vcpu)))
> > > > +		return false;
> > > > +
> > > > +	return !system_supports_32bit_el0() ||
> > > > +		static_branch_unlikely(&arm64_mismatched_32bit_el0);
> > > > +}
> > > > +
> > > >  /**
> > > >   * kvm_arch_vcpu_ioctl_run - the main VCPU run function to execute
> > > > guest code
> > > >   * @vcpu:	The VCPU pointer
> > > > @@ -816,7 +825,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
> > > >  		 * with the asymmetric AArch32 case), return to userspace with
> > > >  		 * a fatal error.
> > > >  		 */
> > > > -		if (!system_supports_32bit_el0() && vcpu_mode_is_32bit(vcpu)) {
> > > > +		if (vcpu_mode_is_bad_32bit(vcpu)) {
> > > >  			/*
> > > >  			 * As we have caught the guest red-handed, decide that
> > > >  			 * it isn't fit for purpose anymore by making the vcpu
> > > 
> > > Given the new definition of system_supports_32bit_el0() in the
> > > previous
> > > patch,
> > > why do we need this patch at all?
> > 
> > I think the check is still needed, as this is an unusual case where we
> > want to reject the mismatched system. For example, imagine
> > 'arm64_mismatched_32bit_el0' is true and we're on a mismatched system:
> > in
> > this case system_supports_32bit_el0() will return 'true' because we
> > allow 32-bit applications to run, we support the 32-bit personality etc.
> > 
> > However, we still want to terminate 32-bit vCPUs if we spot them in this
> > situation, so we have to check for:
> > 
> > 	!system_supports_32bit_el0() ||
> > 	static_branch_unlikely(&arm64_mismatched_32bit_el0)
> > 
> > so that we only allow 32-bit vCPUs when all of the physical CPUs support
> > it at EL0.
> > 
> > I could make this clearer either by adding a comment, or avoiding
> > system_supports_32bit_el0() entirely here and just checking the
> > sanitised SYS_ID_AA64PFR0_EL1 register directly instead.
> > 
> > What do you prefer?
> 
> Yeah, the sanitized read feels better, if only because that is
> what we are going to read in all the valid cases, unfortunately.
> read_sanitised_ftr_reg() is sadly not designed to be called on
> a fast path, meaning that 32bit guests will do a bsearch() on
> the ID-regs every time they exit...
> 
> I guess we will have to evaluate how much we loose with this.

Could we use the trick we have for arm64_ftr_reg_ctrel0 to speed this
up?

Thanks,
Quentin
