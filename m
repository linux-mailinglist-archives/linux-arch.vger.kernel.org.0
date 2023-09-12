Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1DB79D704
	for <lists+linux-arch@lfdr.de>; Tue, 12 Sep 2023 19:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbjILRBx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Sep 2023 13:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbjILRBu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Sep 2023 13:01:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A4FA1724;
        Tue, 12 Sep 2023 10:01:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FF04C15;
        Tue, 12 Sep 2023 10:02:22 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A3F43F738;
        Tue, 12 Sep 2023 10:01:38 -0700 (PDT)
Message-ID: <1ca1fb8f-1dec-74a3-ee44-94609f6aba2c@arm.com>
Date:   Tue, 12 Sep 2023 18:01:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 00/32] ACPI/arm64: add support for virtual cpuhotplug
Content-Language: en-GB
To:     Gavin Shan <gshan@redhat.com>, linux-pm@vger.kernel.org,
        loongarch@lists.linux.dev, kvmarm@lists.linux.dev,
        kvm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org
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
        Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20230203135043.409192-1-james.morse@arm.com>
 <41dd71ab-a6a7-fd93-73ec-64a6b0ca468e@redhat.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <41dd71ab-a6a7-fd93-73ec-64a6b0ca468e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Gavin,

On 29/03/2023 03:35, Gavin Shan wrote:
> On 2/3/23 9:50 PM, James Morse wrote:

>> If folk want to play along at home, you'll need a copy of Qemu that supports this.
>> https://github.com/salil-mehta/qemu.git
>> salil/virt-cpuhp-armv8/rfc-v1-port29092022.psci.present
>>
>> You'll need to fix the numbers of KVM_CAP_ARM_HVC_TO_USER and KVM_CAP_ARM_PSCI_TO_USER
>> to match your host kernel. Replace your '-smp' argument with something like:
>> | -smp cpus=1,maxcpus=3,cores=3,threads=1,sockets=1
>>
>> then feed the following to the Qemu montior;
>> | (qemu) device_add driver=host-arm-cpu,core-id=1,id=cpu1
>> | (qemu) device_del cpu1
>>
>>
>> This series is based on v6.2-rc3, and can be retrieved from:
>> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/ virtual_cpu_hotplug/rfc/v1

> I give it a try, but the hot-added CPU needs to be put into online
> state manually. I'm not sure if it's expected or not.

This is expected. If you want the CPUs to be brought online automatically, you can add
udev rules to do that.


Thanks,

James
