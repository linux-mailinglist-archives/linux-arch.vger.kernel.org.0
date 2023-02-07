Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C345168DF59
	for <lists+linux-arch@lfdr.de>; Tue,  7 Feb 2023 18:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjBGRv2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Feb 2023 12:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjBGRvX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Feb 2023 12:51:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B73533E0B6;
        Tue,  7 Feb 2023 09:51:12 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8343D1042;
        Tue,  7 Feb 2023 09:51:54 -0800 (PST)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4574E3F71E;
        Tue,  7 Feb 2023 09:51:08 -0800 (PST)
Message-ID: <0621bf8e-06f2-70f2-6d2b-f311c5a4ffce@arm.com>
Date:   Tue, 7 Feb 2023 17:50:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFC PATCH 29/32] KVM: arm64: Pass hypercalls to userspace
Content-Language: en-GB
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        kvmarm@lists.linux.dev, kvm@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Marc Zyngier <maz@kernel.org>,
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
        Len Brown <lenb@kernel.org>,
        Rafael Wysocki <rafael@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20230203135043.409192-1-james.morse@arm.com>
 <20230203135043.409192-30-james.morse@arm.com> <Y913sIqWxmf4O5oG@google.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <Y913sIqWxmf4O5oG@google.com>
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

Hi Oliver,

On 03/02/2023 21:08, Oliver Upton wrote:
> On Fri, Feb 03, 2023 at 01:50:40PM +0000, James Morse wrote:
>> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>
>> When capability KVM_CAP_ARM_HVC_TO_USER is available, userspace can
>> request to handle all hypercalls that aren't handled by KVM.

> I would very much prefer we not go down this route. This capability
> effectively constructs an ABI out of what KVM presently does not
> implement. What would happen if KVM decides to implement a new set
> of hypercalls later down the road that were previously forwarded to
> userspace?

The user-space support would never get called. If we have a wild-west allocation of IDs in
this area we have bigger problems. I'd hope in this example it would be a VMM or an
in-kernel implementation of the same feature.

When I floated something like this before for supporting SDEI in guests, Christoffer
didn't like tie-ing KVM to SMC-CC - hence the all or nothing.

Since then we've had things like Spectre, which I don't think the VMM should
ever be allowed to handle, which makes the whole thing much murkier.


> Instead of a catch-all I think we should take the approach of having
> userspace explicitly request which hypercalls should be forwarded to
> userspace. I proposed something similar [1], but never got around to
> respinning it (oops).

> Let me dust those patches off and align with Marc's suggestions.
> 
> [1]: https://lore.kernel.org/kvmarm/20221110015327.3389351-1-oliver.upton@linux.dev/

I've no problem with doing it like this. This approach was based on Christoffer's previous
feedback, but the world has changed since then.

Let me know if you want me to re-spin that series - I need to get this into some
shape next week for Salil to look at the Qemu changes, as I can't test the whole thing
until that is done.



Thanks,

James
