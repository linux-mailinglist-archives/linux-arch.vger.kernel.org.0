Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9739768B9E5
	for <lists+linux-arch@lfdr.de>; Mon,  6 Feb 2023 11:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjBFKV1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Feb 2023 05:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjBFKV0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2023 05:21:26 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 636032069F;
        Mon,  6 Feb 2023 02:20:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED41813D5;
        Mon,  6 Feb 2023 02:11:29 -0800 (PST)
Received: from [10.57.75.57] (unknown [10.57.75.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 584233F71E;
        Mon,  6 Feb 2023 02:10:43 -0800 (PST)
Message-ID: <cffde8a1-74e4-9b61-1eea-544ba3405ed4@arm.com>
Date:   Mon, 6 Feb 2023 10:10:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 29/32] KVM: arm64: Pass hypercalls to userspace
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>
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
        Oliver Upton <oliver.upton@linux.dev>,
        Len Brown <lenb@kernel.org>,
        Rafael Wysocki <rafael@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20230203135043.409192-1-james.morse@arm.com>
 <20230203135043.409192-30-james.morse@arm.com> <865ycg1kv2.wl-maz@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <865ycg1kv2.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

A few cents from the Realm support point of view.

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
>>
>> Suggested-by: James Morse <james.morse@arm.com>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Signed-off-by: James Morse <james.morse@arm.com>
>>
>> ---
>>
> 
> On top of Oliver's ask not to make this a blanket "steal everything",
> but instead to have an actual request for ranges of forwarded
> hypercalls:
> 
>> Notes on this implementation:
>>
>> * A similar mechanism was proposed for SDEI some time ago [1]. This RFC
>>    generalizes the idea to all hypercalls, since that was suggested on
>>    the list [2, 3].
>>
>> * We're reusing kvm_run.hypercall. I copied x0-x5 into
>>    kvm_run.hypercall.args[] to help userspace but I'm tempted to remove
>>    this, because:
>>    - Most user handlers will need to write results back into the
>>      registers (x0-x3 for SMCCC), so if we keep this shortcut we should
>>      go all the way and read them back on return to kernel.
>>    - QEMU doesn't care about this shortcut, it pulls all vcpu regs before
>>      handling the call.

This may not be always possible, e.g., for Realms. GET_ONE_REG is
not supported. So using an explicit passing down of the args is
preferrable.

Thanks
Suzuki
