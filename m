Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22648692C94
	for <lists+linux-arch@lfdr.de>; Sat, 11 Feb 2023 02:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjBKBpO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Feb 2023 20:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjBKBpL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Feb 2023 20:45:11 -0500
Received: from out-35.mta1.migadu.com (out-35.mta1.migadu.com [IPv6:2001:41d0:203:375::23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F40B366B0
        for <linux-arch@vger.kernel.org>; Fri, 10 Feb 2023 17:45:09 -0800 (PST)
Date:   Sat, 11 Feb 2023 01:44:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676079907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ATfIOa15+8O6yLufISvtN1TVTqsxnTy8db9Z05Rn/lM=;
        b=Rg/5vaCGC6R2WY/BoSaEk9npLFDaCrjyEy+ovYHEvHIAzOzHgOFlFOzgzfnyZulHtcsJgj
        4WDRxAWfHwLR2m/YnH2XZS6PY5IsxqbrkAZ+M3IlX0OOHFQKnM/tp8Ty0j+fLhx3NZV/3T
        zsjh9O5QqBvEOJfneV8w5MqEtU/4W8A=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     James Morse <james.morse@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, linux-pm@vger.kernel.org,
        loongarch@lists.linux.dev, kvmarm@lists.linux.dev,
        kvm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
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
Subject: Re: [RFC PATCH 29/32] KVM: arm64: Pass hypercalls to userspace
Message-ID: <Y+bzG6JH5gY9afNW@linux.dev>
References: <20230203135043.409192-1-james.morse@arm.com>
 <20230203135043.409192-30-james.morse@arm.com>
 <865ycg1kv2.wl-maz@kernel.org>
 <7462738f-e837-cd99-f441-8e7c29d250cd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7462738f-e837-cd99-f441-8e7c29d250cd@arm.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hey James,

On Tue, Feb 07, 2023 at 05:50:58PM +0000, James Morse wrote:

[...]

> > As mentioned above, I think this interface should go both ways.
> > Userspace should request the forwarding of a certain range of
> > hypercalls via a similar SET_ATTR interface.
> 
> Yup, I'll sync up with Oliver about that.

Sorry, I was tied up with some unrelated stuff at work this week. I
polished up what I had and sent out an RFC v2 for SMCCC filtering [1].
Mentioning it here because my email service gives up if I Cc too many
recipients so I didn't include everyone on this series.

[1]: https://lore.kernel.org/linux-arm-kernel/20230211013759.3556016-1-oliver.upton@linux.dev/

-- 
Thanks,
Oliver
