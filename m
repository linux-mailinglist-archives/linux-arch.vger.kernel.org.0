Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B8128CDD5
	for <lists+linux-arch@lfdr.de>; Tue, 13 Oct 2020 14:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgJMMJu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Oct 2020 08:09:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbgJMMJu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Oct 2020 08:09:50 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 465CF21D6C;
        Tue, 13 Oct 2020 12:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590989;
        bh=qo+QfLR4H3hgMllp7V0/DI24KeRu5ExwQonOtD6C/a4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dguFK4qOzyEMMsR8gxfqmRjfn56mgjJEWzopDxcSmjlmIVSApv21F9QwuRZ0KgEiH
         34wEYV8LZPGHglz6kHnFonKyNhplBNh8bvvb0wdnFSJFd8eL24T4jGGMl3iwySaH5+
         RfZc19Cb6K9E1jBJcz1CnjSBzG2QhrEoqmlQuB0Q=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kSJ7j-000p1i-4g; Tue, 13 Oct 2020 13:09:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 13 Oct 2020 13:09:47 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     James Morse <james.morse@arm.com>, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 1/3] arm64: kvm: Handle Asymmetric AArch32 systems
In-Reply-To: <20201013115953.gepxn5dbzrk6x6ec@e107158-lin>
References: <20201008181641.32767-1-qais.yousef@arm.com>
 <20201008181641.32767-2-qais.yousef@arm.com>
 <7c058d22dce84ec7636863c1486b11d1@kernel.org>
 <20201009095857.cq3bmmobxeq3tm5z@e107158-lin.cambridge.arm.com>
 <63e379d1399b5c898828f6802ce3dca5@kernel.org>
 <20201009124817.i7u53qrntvu7l5zq@e107158-lin.cambridge.arm.com>
 <54379ee1-97b1-699b-9500-655164f2e083@arm.com>
 <8cdbcf81bae94f4b030e2906191d80af@kernel.org>
 <13eb5d05-9eaf-7640-cd44-cfd7f8820257@arm.com>
 <20201013115953.gepxn5dbzrk6x6ec@e107158-lin>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <20fba6976710e00dc32164bf8af26164@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: qais.yousef@arm.com, james.morse@arm.com, linux-arch@vger.kernel.org, will@kernel.org, peterz@infradead.org, catalin.marinas@arm.com, gregkh@linuxfoundation.org, torvalds@linux-foundation.org, morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-10-13 12:59, Qais Yousef wrote:
> On 10/13/20 12:51, James Morse wrote:
>> Hi Marc,
>> 
>> On 13/10/2020 11:32, Marc Zyngier wrote:
>> > On 2020-10-12 16:32, James Morse wrote:
>> >> On 09/10/2020 13:48, Qais Yousef wrote:
>> >>> On 10/09/20 13:34, Marc Zyngier wrote:
>> >>>> You can try setting vcpu->arch.target to -1, which is already caught by
>> >>>> kvm_vcpu_initialized() right at the top of this function. This will
>> >>
>> >>>> prevent any reentry unless the VMM issues a KVM_ARM_VCPU_INIT ioctl.
>> >>
>> >> This doesn't reset SPSR, so this lets the VMM restart the guest with a
>> >> bad value.
>> >
>> > That's not my reading of the code. Without a valid target, you cannot enter
>> > the guest (kvm_vcpu_initialized() prevents you to do so). To set the target,
>> > you need to issue a KVM_ARM_VCPU_INIT ioctl, which eventually calls
>> 
>> > kvm_reset_vcpu(), which does set PSTATE to something legal.
>> 
>> aha! So it does, this is what I was missing.
>> 
>> 
>> > Or do you mean the guest's SPSR_EL1? Why would that matter?
>> >
>> >> I think we should make it impossible to return to aarch32 from EL2 on
>> >> these systems.
>> >
>> > And I'm saying that the above fulfills that requirement. Am I missing
>> > something obvious?
>> 
>> Nope, I was.
>> 
>> I agree the check on entry from user-space isn't needed.
> 
> Thanks both.
> 
> So using the vcpu->arch.target = -1 is the best way forward. In my 
> experiments
> when I did that I considered calling kvm_reset_vcpu() too, does it make 
> sense
> to force the reset here too? Or too heavy handed?

No, userspace should know about it and take action if it wants too.
Trying to fix it behind the scenes is setting expectations, which
I'd really like to avoid.

         M.
-- 
Jazz is not dead. It just smells funny...
