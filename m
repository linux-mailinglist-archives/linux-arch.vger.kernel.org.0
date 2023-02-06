Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A3568BCD2
	for <lists+linux-arch@lfdr.de>; Mon,  6 Feb 2023 13:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjBFMbt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Feb 2023 07:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjBFMbs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2023 07:31:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CEA12052;
        Mon,  6 Feb 2023 04:31:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B8EDB80FA3;
        Mon,  6 Feb 2023 12:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9D6C433EF;
        Mon,  6 Feb 2023 12:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675686703;
        bh=SSKnltqyFrUrRR/6DQuBz9zXXdOyQfpcUJPdcNtRCFU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g/GTgn5Zr2vIJt5DlEEdvQeuIMMj6GVrHVTg0gW7msGYEZ2ewNkdZaWKqZzbUfZmn
         qEpeyC+c7b4H3xQijFuKs2cuxOvAOUxg5ygp7Xrr5LmfFbQXfAWfjtg2yHUDFjTlcv
         QPGM84IoNDnhvhOaSBp2uSNhf5ICbdUzFsNx+kn7DISAaAp+hjPnB7narguJLOFKp3
         m7ZwGSK/moPApG+Yv66+cdu974/NI95+nMFCtUHDEIpvJhRW6JeYsFnmqtusPKhVsE
         B0kCmixpbYxqYmZn0ociftTSOT7vLDSNxMxceEQjR/2SKHUpKesLPIjOIbxOsL/cle
         fdk1VexLpof8w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1pP0er-00800O-6V;
        Mon, 06 Feb 2023 12:31:41 +0000
Date:   Mon, 06 Feb 2023 12:31:40 +0000
Message-ID: <86wn4vynyr.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     James Morse <james.morse@arm.com>, linux-pm@vger.kernel.org,
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
        Oliver Upton <oliver.upton@linux.dev>,
        Len Brown <lenb@kernel.org>,
        Rafael Wysocki <rafael@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [RFC PATCH 29/32] KVM: arm64: Pass hypercalls to userspace
In-Reply-To: <cffde8a1-74e4-9b61-1eea-544ba3405ed4@arm.com>
References: <20230203135043.409192-1-james.morse@arm.com>
        <20230203135043.409192-30-james.morse@arm.com>
        <865ycg1kv2.wl-maz@kernel.org>
        <cffde8a1-74e4-9b61-1eea-544ba3405ed4@arm.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/28.2
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: suzuki.poulose@arm.com, james.morse@arm.com, linux-pm@vger.kernel.org, loongarch@lists.linux.dev, kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, x86@kernel.org, tglx@linutronix.de, lpieralisi@kernel.org, mark.rutland@arm.com, sudeep.holla@arm.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, mingo@redhat.com, will@kernel.org, catalin.marinas@arm.com, chenhuacai@kernel.org, oliver.upton@linux.dev, lenb@kernel.org, rafael@kernel.org, kernel@xen0n.name, salil.mehta@huawei.com, linux@armlinux.org.uk, jean-philippe@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 06 Feb 2023 10:10:41 +0000,
Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> 
> Hi,
> 
> A few cents from the Realm support point of view.
> 
> On 05/02/2023 10:12, Marc Zyngier wrote:
> > On Fri, 03 Feb 2023 13:50:40 +0000,
> > James Morse <james.morse@arm.com> wrote:
> >> 
> >> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> >> 
> >> When capability KVM_CAP_ARM_HVC_TO_USER is available, userspace can
> >> request to handle all hypercalls that aren't handled by KVM. With the
> >> help of another capability, this will allow userspace to handle PSCI
> >> calls.
> >> 
> >> Suggested-by: James Morse <james.morse@arm.com>
> >> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> >> Signed-off-by: James Morse <james.morse@arm.com>
> >> 
> >> ---
> >> 
> > 
> > On top of Oliver's ask not to make this a blanket "steal everything",
> > but instead to have an actual request for ranges of forwarded
> > hypercalls:
> > 
> >> Notes on this implementation:
> >> 
> >> * A similar mechanism was proposed for SDEI some time ago [1]. This RFC
> >>    generalizes the idea to all hypercalls, since that was suggested on
> >>    the list [2, 3].
> >> 
> >> * We're reusing kvm_run.hypercall. I copied x0-x5 into
> >>    kvm_run.hypercall.args[] to help userspace but I'm tempted to remove
> >>    this, because:
> >>    - Most user handlers will need to write results back into the
> >>      registers (x0-x3 for SMCCC), so if we keep this shortcut we should
> >>      go all the way and read them back on return to kernel.
> >>    - QEMU doesn't care about this shortcut, it pulls all vcpu regs before
> >>      handling the call.
> 
> This may not be always possible, e.g., for Realms. GET_ONE_REG is
> not supported. So using an explicit passing down of the args is
> preferrable.

What is the blocker for CCA to use GET_ONE_REG? The value obviously
exists and is made available to the host. pKVM is perfectly able to
use GET_ONE_REG and gets a bunch of zeroes for things that the
hypervisor has decided to hide from the host.

Of course, it requires that the hypervisor (the RMM in your case)
knows about the semantics of the hypercall, but that's obviously
already a requirement (or you wouldn't be able to use PSCI at all).

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
