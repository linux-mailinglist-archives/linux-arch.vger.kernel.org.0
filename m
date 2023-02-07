Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EBD68DF5E
	for <lists+linux-arch@lfdr.de>; Tue,  7 Feb 2023 18:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjBGRvn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Feb 2023 12:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjBGRvc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Feb 2023 12:51:32 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C18573EC48;
        Tue,  7 Feb 2023 09:51:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6F651762;
        Tue,  7 Feb 2023 09:51:58 -0800 (PST)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDD593FA32;
        Tue,  7 Feb 2023 09:51:11 -0800 (PST)
Message-ID: <7462738f-e837-cd99-f441-8e7c29d250cd@arm.com>
Date:   Tue, 7 Feb 2023 17:50:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFC PATCH 29/32] KVM: arm64: Pass hypercalls to userspace
Content-Language: en-GB
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        kvmarm@lists.linux.dev, kvm@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Len Brown <lenb@kernel.org>,
        Rafael Wysocki <rafael@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20230203135043.409192-1-james.morse@arm.com>
 <20230203135043.409192-30-james.morse@arm.com> <865ycg1kv2.wl-maz@kernel.org>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <865ycg1kv2.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Marc,

On 05/02/2023 10:12, Marc Zyngier wrote:
> On Fri, 03 Feb 2023 13:50:40 +0000,
> James Morse <james.morse@arm.com> wrote:
>>
>> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>
>> When capability KVM_CAP_ARM_HVC_TO_USER is available, userspace can
>> request to handle all hypercalls that aren't handled by KVM. With the
>> help of another capability, this will allow userspace to handle PSCI
>> calls.

> On top of Oliver's ask not to make this a blanket "steal everything",
> but instead to have an actual request for ranges of forwarded
> hypercalls:
> 
>> Notes on this implementation:
>>
>> * A similar mechanism was proposed for SDEI some time ago [1]. This RFC
>>   generalizes the idea to all hypercalls, since that was suggested on
>>   the list [2, 3].
>>
>> * We're reusing kvm_run.hypercall. I copied x0-x5 into
>>   kvm_run.hypercall.args[] to help userspace but I'm tempted to remove
>>   this, because:
>>   - Most user handlers will need to write results back into the
>>     registers (x0-x3 for SMCCC), so if we keep this shortcut we should
>>     go all the way and read them back on return to kernel.
>>   - QEMU doesn't care about this shortcut, it pulls all vcpu regs before
>>     handling the call.
>>   - SMCCC uses x0-x16 for parameters.
>>   x0 does contain the SMCCC function ID and may be useful for fast
>>   dispatch, we could keep that plus the immediate number.
>>
>> * Add a flag in the kvm_run.hypercall telling whether this is HVC or
>>   SMC?  Can be added later in those bottom longmode and pad fields.

> We definitely need this. A nested hypervisor can (and does) use SMCs
> as the conduit.

Christoffer's comments last time round on this was that EL2 guests get SMC with this,
and EL1 guests get HVC. The VMM could never get both...


> The question is whether they represent two distinct
> namespaces or not. I *think* we can unify them, but someone should
> check and maybe get clarification from the owners of the SMCCC spec.

i.e. the VMM requests 0xC400_0000:0xC400_001F regardless of SMC/HVC?

I don't yet see how a VMM could get HVC out of a virtual-EL2 guest....


>> * On top of this we could share with userspace which HVC ranges are
>>   available and which ones are handled by KVM. That can actually be added
>>   independently, through a vCPU/VM device attribute which doesn't consume
>>   a new ioctl:
>>   - userspace issues HAS_ATTR ioctl on the vcpu fd to query whether this
>>     feature is available.
>>   - userspace queries the number N of HVC ranges using one GET_ATTR.
>>   - userspace passes an array of N ranges using another GET_ATTR. The
>>     array is filled and returned by KVM.

> As mentioned above, I think this interface should go both ways.
> Userspace should request the forwarding of a certain range of
> hypercalls via a similar SET_ATTR interface.

Yup, I'll sync up with Oliver about that.


> Another question is how we migrate VMs that have these forwarding
> requirements. Do we expect the VMM to replay the forwarding as part of
> the setting up on the other side? Or do we save/restore this via a
> firmware pseudo-register?

Pfff. VMMs problem. Enabling these things means it has its own internal state to migrate.
(is this vCPU on or off?), I doubt it needs reminding that the state exists.

That said, Salil is looking at making this work with migration in Qemu.


Thanks,

James
