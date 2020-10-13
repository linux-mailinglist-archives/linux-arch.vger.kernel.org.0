Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1155128CCBE
	for <lists+linux-arch@lfdr.de>; Tue, 13 Oct 2020 13:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgJMLwY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Oct 2020 07:52:24 -0400
Received: from foss.arm.com ([217.140.110.172]:57922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727230AbgJMLwX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Oct 2020 07:52:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBD6D1FB;
        Tue, 13 Oct 2020 04:52:22 -0700 (PDT)
Received: from [172.16.1.113] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EA933F719;
        Tue, 13 Oct 2020 04:52:21 -0700 (PDT)
Subject: Re: [RFC PATCH 1/3] arm64: kvm: Handle Asymmetric AArch32 systems
To:     Marc Zyngier <maz@kernel.org>
Cc:     Qais Yousef <qais.yousef@arm.com>, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20201008181641.32767-1-qais.yousef@arm.com>
 <20201008181641.32767-2-qais.yousef@arm.com>
 <7c058d22dce84ec7636863c1486b11d1@kernel.org>
 <20201009095857.cq3bmmobxeq3tm5z@e107158-lin.cambridge.arm.com>
 <63e379d1399b5c898828f6802ce3dca5@kernel.org>
 <20201009124817.i7u53qrntvu7l5zq@e107158-lin.cambridge.arm.com>
 <54379ee1-97b1-699b-9500-655164f2e083@arm.com>
 <8cdbcf81bae94f4b030e2906191d80af@kernel.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <13eb5d05-9eaf-7640-cd44-cfd7f8820257@arm.com>
Date:   Tue, 13 Oct 2020 12:51:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <8cdbcf81bae94f4b030e2906191d80af@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Marc,

On 13/10/2020 11:32, Marc Zyngier wrote:
> On 2020-10-12 16:32, James Morse wrote:
>> On 09/10/2020 13:48, Qais Yousef wrote:
>>> On 10/09/20 13:34, Marc Zyngier wrote:
>>>> You can try setting vcpu->arch.target to -1, which is already caught by
>>>> kvm_vcpu_initialized() right at the top of this function. This will
>>
>>>> prevent any reentry unless the VMM issues a KVM_ARM_VCPU_INIT ioctl.
>>
>> This doesn't reset SPSR, so this lets the VMM restart the guest with a
>> bad value.
> 
> That's not my reading of the code. Without a valid target, you cannot enter
> the guest (kvm_vcpu_initialized() prevents you to do so). To set the target,
> you need to issue a KVM_ARM_VCPU_INIT ioctl, which eventually calls

> kvm_reset_vcpu(), which does set PSTATE to something legal.

aha! So it does, this is what I was missing.


> Or do you mean the guest's SPSR_EL1? Why would that matter?
> 
>> I think we should make it impossible to return to aarch32 from EL2 on
>> these systems.
> 
> And I'm saying that the above fulfills that requirement. Am I missing
> something obvious?

Nope, I was.

I agree the check on entry from user-space isn't needed.


Thanks,

James
