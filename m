Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96BBD42AE8C
	for <lists+linux-arch@lfdr.de>; Tue, 12 Oct 2021 23:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbhJLVQ7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Oct 2021 17:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbhJLVQ6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Oct 2021 17:16:58 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06634C061749
        for <linux-arch@vger.kernel.org>; Tue, 12 Oct 2021 14:14:56 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id om14so580750pjb.5
        for <linux-arch@vger.kernel.org>; Tue, 12 Oct 2021 14:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BvJKY1rKY/9760Gl0LeNDnuiT6sXKAWtw9tI5dawnj8=;
        b=o/GLSCG6RnyZhSaxYArhdjDI+GZqq0Tuo0BHCi9OQXV0eO0sxdtvf5e9ph018gRDa6
         WJ99ynXkrqPdl7uWFgm585DMEglXtlaisSsg/qyShYDhpZIu1BvMNlFI6crNzwZb3kVM
         D3Nt1dq7SpMnmm5+jl5p2FM1bFc6n4drqjIT0i4Fl9t9fDJ6UGChKOyaRtuZgyFcoJia
         eMdADZLXI2+b0qbYF+jnjboenngTrHPevUOH10+K98UqYyLojIdvIWQWl6PIPtNp4mXn
         ohpD2sOBLXyWV5UH2WaEiVPcRxts93LbhGN71NGL15k92yGs1DLkNua+zz0+5eS3od4g
         tZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BvJKY1rKY/9760Gl0LeNDnuiT6sXKAWtw9tI5dawnj8=;
        b=qbnDd/RhnXcoAUyQ8UhUt6SKQhBfHrQ9mHN/+FFU5C5d0Y9zTO+1+TJVUr19zWUGDm
         vEDcx5Hk+Df4evvUvooonLhDltNl3bqkOnvvHfvSdhNLvr1xKS01goF7lt2WtbjcZp9q
         ihEjklY7870Mqdw/4Tsdngmc4q3qVbQtVjOdzzsTs4U3Pwo+Ut5iaRiPZLW857rmrZ4+
         xjfb9xqVKEYZ63vX3KQBkd099CTMjoHRMhJ/yozI6qVoOdzyNwLy9A/Ex1dxEFZ/gWQX
         BNAtG1XZ9CM+nyczyX7Im1HhL2KCb4iMZoMKlUKnnl8LOIWzwHbRAKuXHTxjet+EkeLg
         OF/Q==
X-Gm-Message-State: AOAM533XOi8+K/GFleww6l8jtgwJTK9CldbHi/DyJ5S7kBMolu+8dh6t
        bqmwV5ZxEX89PeayzjYz7yKFBxRaXVv0T/pKjW6NRA==
X-Google-Smtp-Source: ABdhPJxlgENg9aVPk1SZ9ZEg6wuYtjv4aFSKCDl25/S1StL4dP/rCMPRYztdsJE333jGYnVsE21IQwgFHVQV3g7Wdr8=
X-Received: by 2002:a17:90b:350f:: with SMTP id ls15mr8831441pjb.220.1634073295349;
 Tue, 12 Oct 2021 14:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053103-mutt-send-email-mst@kernel.org> <CAPcyv4hDhjRXYCX_aiOboLF0eaTo6VySbZDa5NQu2ed9Ty2Ekw@mail.gmail.com>
 <0e6664ac-cbb2-96ff-0106-9301735c0836@linux.intel.com> <CAPcyv4g0v0YHZ-okxf4wwVCYxHotxdKwsJpZGkoT+fhvvAJEFg@mail.gmail.com>
 <9302f1c2-b3f8-2c9e-52c5-d5a4a2987409@linux.intel.com>
In-Reply-To: <9302f1c2-b3f8-2c9e-52c5-d5a4a2987409@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 12 Oct 2021 14:14:44 -0700
Message-ID: <CAPcyv4hG0HcbUO8Mb=ccDp5Bz3RJNkAJwKwNzRkQ1gCMpp_OMQ@mail.gmail.com>
Subject: Re: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(), pci_iomap_host_shared_range()
To:     Andi Kleen <ak@linux.intel.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        James E J Bottomley <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        "Reshetova, Elena" <elena.reshetova@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 12, 2021 at 11:35 AM Andi Kleen <ak@linux.intel.com> wrote:
>
>
> > The "better safe-than-sorry" argument is hard to build consensus
> > around. The spectre mitigations ran into similar problems where the
> > community rightly wanted to see the details and instrument the
> > problematic paths rather than blanket sprinkle lfence "just to be
> > safe".
>
> But that was due to performance problems in hot paths. Nothing of this
> applies here.

It applies because a new API that individual driver authors is being
proposed and that's an ongoing maintenance burden that might be
mitigated by hiding that implementation detail from leaf drivers.

>
> > In this case the rules about when a driver is suitably
> > "hardened" are vague and the overlapping policy engines are confusing.
>
> What is confusing exactly?

Multiple places to go to enable functionality. The device-filter
firewall policy can collide with the ioremap access control policy.

> For me it both seems very straight forward and simple (but then I'm biased)

You seem to be having a difficult time iterating this proposal toward
consensus. I don't think the base principles are being contested as
much as the semantics, scope, and need for the proposed API that is in
the purview of all leaf driver developers.

> The policy is:
>
> - Have an allow list at driver registration.
>
> - Have an additional opt-in for MMIO mappings (and potentially config
> space, but that's not currently there) to cover init calls completely.

The proliferation of policy engines and driver special casing is the
issue. Especially in this case where the virtio use case being
opted-in is *already* in a path that has been authorized by the
device-filter policy engine. I.e. why special case the ioremap() in
virtio to be additionally authorized when the device has already been
authorized to probe? Put another way, the easiest driver API change to
merge would be no additional changes in leaf drivers.

>
> >
> > I'd rather see more concerted efforts focused/limited core changes
> > rather than leaf driver changes until there is a clearer definition of
> > hardened.
>
> A hardened driver is a driver that
>
> - Had similar security (not API) oriented review of its IO operations
> (mainly MMIO access, but also PCI config space) as a non privileged user
> interface (like a ioctl). That review should be focused on memory safety.
>
> - Had some fuzzing on these IO interfaces using to be released tools.

What is the intersection of ioremap() users that are outside of the
proposed probe authorization regime AND want confidential computing
support?

> Right now it's only three virtio drivers (console, net, block)
>
> Really it's no different than what we do for every new unprivileged user
> interface.
>
>
> > I.e. instead of jumping to the assertion that fixing up
> > these init-path vulnerabilities are too big to fix, dig to the next
> > level to provide more evidence that per-driver opt-in is the only
> > viable option.
> >
> > For example, how many of these problematic paths are built-in to the
> > average kernel config?
>
> I don't think arguments from "the average kernel config" (if such a
> thing even exists) are useful. That's would be just hand waving.

I'm trying to bridge to your contention that this enabling can not
rely on custom kernel configs and must offer protection on the same
kernel image that might ship in the host, but lets set this aside and
focus on when and where leaf drivers need to adopt a new API.

> > A strawman might be to add a sprinkling error
> > exits in the module_init() of the problematic drivers, and only fail
> > if the module is built-in, and let modprobe policy handle the rest.
>
>
> That would be already hundreds of changes. I have no idea how such a
> thing could be maintained or sustained either.
>
> Really I don't even see how these alternatives can be considered. Tree
> sweeps should always be last resort. They're a pain for everyone. But
> here they're casually thrown around as alternatives to straight forward
> one or two line changes.

If it looked straightforward I'm not sure we would be having this
discussion, I think it's reasonable to ask if this is a per-driver
opt-in responsibility that must be added in addition to probe
authorization.

> >> Default policy in user space just seems to be a bad idea here. Who
> >> should know if a driver is hardened other than the kernel? Maintaining
> >> the list somewhere else just doesn't make sense to me.
> > I do not understand the maintenance burden correlation of where the
> > policy is driven vs where the list is maintained?
>
> All the hardening and auditing happens in the kernel tree. So it seems
> the natural place to store the result is in the kernel tree.
>
> But there's no single package for initrd, so you would need custom
> configurations for all the supported distros.
>
> Also we're really arguing about a list that currently has three entries.
>
>
> >   Even if I agreed
> > with the contention that out-of-tree userspace would have a hard time
> > tracking the "hardened" driver list there is still an in-tree
> > userspace path to explore. E.g. perf maintains lists of things tightly
> > coupled to the kernel, this authorized device list seems to be in the
> > same category of data.
>
> You mean the event list? perf is in the kernel tree, so it's maintained
> together with the kernel.
>
> But we don't have a kernel initrd.

I'm proposing that this list is either tiny and slow moving enough for
initrd builders to track manually, or it's a data file that ships in
distro kernel packages that initrd builders can pull in.

> >> Also there is the more practical problem that some devices are needed
> >> for booting. For example in TDX we can't print something to the console
> >> with this mechanism, so you would never get any output before the
> >> initrd. Just seems like a nightmare for debugging anything. There really
> >> needs to be an authorization mechanism that works reasonably early.
> >>
> >> I can see a point of having user space overrides though, but we need to
> >> have a sane kernel default that works early.
> > Right, as I suggested [1], just enough early authorization to
> > bootstrap/debug initramfs and then that can authorize the remainder.
>
> But how do you debug the kernel then? Making early undebuggable seems
> just bad policy to me.

I am not proposing making the early undebuggable.

>
> And if you fix if for the console why not add the two more entries for
> virtio net and block too?

Again because there seems to be struggling consensus around what
criteria constitutes being added to this list. In order to move this
series forward I'm trying to find common ground.
