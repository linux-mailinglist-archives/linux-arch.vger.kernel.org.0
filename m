Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341AD79D70F
	for <lists+linux-arch@lfdr.de>; Tue, 12 Sep 2023 19:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjILRCV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Sep 2023 13:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236687AbjILRCN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Sep 2023 13:02:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7A031728;
        Tue, 12 Sep 2023 10:02:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B803CC15;
        Tue, 12 Sep 2023 10:02:45 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 431A73F738;
        Tue, 12 Sep 2023 10:02:03 -0700 (PDT)
Message-ID: <3ad03f27-1f2b-a79f-130d-afb9e713fa70@arm.com>
Date:   Tue, 12 Sep 2023 18:01:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 30/32] KVM: arm64: Pass PSCI calls to userspace
Content-Language: en-GB
To:     Salil Mehta <salil.mehta@huawei.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
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
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20230203135043.409192-1-james.morse@arm.com>
 <20230203135043.409192-31-james.morse@arm.com>
 <7e182886f20044d09d5b269cb6224af7@huawei.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <7e182886f20044d09d5b269cb6224af7@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Salil,

On 23/05/2023 10:32, Salil Mehta wrote:
>> From: James Morse <james.morse@arm.com>
>> Sent: Friday, February 3, 2023 1:51 PM
>> To: linux-pm@vger.kernel.org; loongarch@lists.linux.dev;
>> kvmarm@lists.linux.dev; kvm@vger.kernel.org; linux-acpi@vger.kernel.org;
>> linux-arch@vger.kernel.org; linux-ia64@vger.kernel.org; linux-
>> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>> x86@kernel.org
> 
> [...]
> 
> 
>>
>> When the KVM_CAP_ARM_PSCI_TO_USER capability is available, userspace can
>> request to handle PSCI calls.
>>
>> This is required for virtual CPU hotplug to allow the VMM to enforce the
>> online/offline policy it has advertised via ACPI. By managing PSCI in
>> user-space, the VMM is able to return PSCI_DENIED when the guest attempts
>> to bring a disabled vCPU online.
>> Without this, the VMM is only able to not-run the vCPU, the kernel will
>> have already returned PSCI_SUCCESS to the guest. This results in
>> timeouts during boot as the OS must wait for the secondary vCPU.
>>
>> SMCCC probe requires PSCI v1.x. If userspace only implements PSCI v0.2,
>> the guest won't query SMCCC support through PSCI and won't use the
>> spectre workarounds. We could hijack PSCI_VERSION and pretend to support
>> v1.0 if userspace does not, then handle all v1.0 calls ourselves
>> (including guessing the PSCI feature set implemented by the guest), but
>> that seems unnecessary. After all the API already allows userspace to
>> force a version lower than v1.0 using the firmware pseudo-registers.
>>
>> The KVM_REG_ARM_PSCI_VERSION pseudo-register currently resets to either
>> v0.1 if userspace doesn't set KVM_ARM_VCPU_PSCI_0_2, or
>> KVM_ARM_PSCI_LATEST (1.0).

> I just saw the latest PSCI standard issue (Mar 2023 E Non-Confidential
> PSCI 1.2 issue E) and it contains the DENIED return value for the CPU_ON. 
> 
> Should we *explicitly* check for PSCI 1.2 support before allowing vCPU
> Hot plug support? For this we would need KVM changes.

The VMM should certainly check which version of PSCI it supports, to make sure it doesn't
return an error code that the spec says that version of PSCI doesn't use.

Moving the PSCI support to the VMM is a pre-requisite for supporting this mechanism,
otherwise KVM will allow the CPUs to come online immediately.


Thanks,

James
