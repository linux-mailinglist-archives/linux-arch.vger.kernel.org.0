Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F86968C4B2
	for <lists+linux-arch@lfdr.de>; Mon,  6 Feb 2023 18:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjBFR2Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Feb 2023 12:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjBFR2K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2023 12:28:10 -0500
X-Greylist: delayed 477 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Feb 2023 09:27:39 PST
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE352CFD1
        for <linux-arch@vger.kernel.org>; Mon,  6 Feb 2023 09:27:39 -0800 (PST)
Date:   Mon, 6 Feb 2023 17:19:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675703978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HQYDCy4xAq7++DqBp2PrFrzWfoeLMTv7/t3BwVc+5/M=;
        b=J9ErNIUpPqZIZXdMg30fbXll1h9T0Tvc0m6YwSEjZKdUoEOooQgqWauEEwTKgz5T3W0FTk
        rki4AZWQsgRfhqb68OZxWvRzYjB94NkQRpb2vk7/ewhW1i4abF/GN+8YazanH4qC5F0Wee
        Dwv1drNtXNr6gUzp6+ranIztAkcY0no=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Marc Zyngier <maz@kernel.org>
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
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Len Brown <lenb@kernel.org>,
        Rafael Wysocki <rafael@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [RFC PATCH 29/32] KVM: arm64: Pass hypercalls to userspace
Message-ID: <Y+E2nVnadj1emNs5@google.com>
References: <20230203135043.409192-1-james.morse@arm.com>
 <20230203135043.409192-30-james.morse@arm.com>
 <865ycg1kv2.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <865ycg1kv2.wl-maz@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Feb 05, 2023 at 10:12:49AM +0000, Marc Zyngier wrote:
> On Fri, 03 Feb 2023 13:50:40 +0000,
> James Morse <james.morse@arm.com> wrote:
> > 
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > When capability KVM_CAP_ARM_HVC_TO_USER is available, userspace can
> > request to handle all hypercalls that aren't handled by KVM. With the
> > help of another capability, this will allow userspace to handle PSCI
> > calls.
> > 
> > Suggested-by: James Morse <james.morse@arm.com>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: James Morse <james.morse@arm.com>
> > 
> > ---
> > 
> 
> On top of Oliver's ask not to make this a blanket "steal everything",
> but instead to have an actual request for ranges of forwarded
> hypercalls:
> 
> > Notes on this implementation:
> > 
> > * A similar mechanism was proposed for SDEI some time ago [1]. This RFC
> >   generalizes the idea to all hypercalls, since that was suggested on
> >   the list [2, 3].
> > 
> > * We're reusing kvm_run.hypercall. I copied x0-x5 into
> >   kvm_run.hypercall.args[] to help userspace but I'm tempted to remove
> >   this, because:
> >   - Most user handlers will need to write results back into the
> >     registers (x0-x3 for SMCCC), so if we keep this shortcut we should
> >     go all the way and read them back on return to kernel.
> >   - QEMU doesn't care about this shortcut, it pulls all vcpu regs before
> >     handling the call.
> >   - SMCCC uses x0-x16 for parameters.
> >   x0 does contain the SMCCC function ID and may be useful for fast
> >   dispatch, we could keep that plus the immediate number.
> > 
> > * Add a flag in the kvm_run.hypercall telling whether this is HVC or
> >   SMC?  Can be added later in those bottom longmode and pad fields.
> 
> We definitely need this. A nested hypervisor can (and does) use SMCs
> as the conduit. The question is whether they represent two distinct
> namespaces or not. I *think* we can unify them, but someone should
> check and maybe get clarification from the owners of the SMCCC spec.
> 
> >
> > * On top of this we could share with userspace which HVC ranges are
> >   available and which ones are handled by KVM. That can actually be added
> >   independently, through a vCPU/VM device attribute which doesn't consume
> >   a new ioctl:
> >   - userspace issues HAS_ATTR ioctl on the vcpu fd to query whether this
> >     feature is available.
> >   - userspace queries the number N of HVC ranges using one GET_ATTR.
> >   - userspace passes an array of N ranges using another GET_ATTR. The
> >     array is filled and returned by KVM.
> 
> As mentioned above, I think this interface should go both ways.
> Userspace should request the forwarding of a certain range of
> hypercalls via a similar SET_ATTR interface.
> 
> Another question is how we migrate VMs that have these forwarding
> requirements. Do we expect the VMM to replay the forwarding as part of
> the setting up on the other side? Or do we save/restore this via a
> firmware pseudo-register?

Personally I'd prefer we left that job to userspace.

We could also implement GET_ATTR, in case userspace has forgotten what
it wrote to the hypercall filter. The firmware pseudo-registers are
handy for moving KVM state back and forth 'for free', but I don't think
we need to bend over backwards to migrate state userspace is directly
responsible for.

-- 
Thanks,
Oliver
