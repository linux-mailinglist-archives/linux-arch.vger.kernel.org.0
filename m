Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C7842AB04
	for <lists+linux-arch@lfdr.de>; Tue, 12 Oct 2021 19:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbhJLRpH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Oct 2021 13:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbhJLRpG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Oct 2021 13:45:06 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCB7C061762
        for <linux-arch@vger.kernel.org>; Tue, 12 Oct 2021 10:43:04 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id r201so14546955pgr.4
        for <linux-arch@vger.kernel.org>; Tue, 12 Oct 2021 10:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c0eaXCym61eiyhGT8GrUnwQDVzwTszJGE9WWYZbnw/I=;
        b=WxPZdN095KQgIlI5yU5qv0kDDUbBxKJaeY7ZC60bwwjCmldsE5dJp8xBjUlh2H3f7u
         KDcadpUVFwub2imKyC31S7f+xXPYC3o0QZayMhGwBFND9QSSkipX+sNLN90JdelYcTQV
         icggDdPWpuMAw4t03MeCBYYi/bC9qevHqZZYs+zUb+0aiQ7EAIJHrMdiFnYoTYu422eg
         uJNegZaUShKK4Z3PYQkHuOa7SLoCwsbTusMRGb7Z+VqP1cY9TG6mW5XMlJLFBqIp0ND4
         Qohcz53rKRmxnjn2Kc0dL0iebauPHDeU9Xe9+UkQrP37q/4ILF/V1eyPuoG9gexwZ1Jh
         vFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c0eaXCym61eiyhGT8GrUnwQDVzwTszJGE9WWYZbnw/I=;
        b=BzeND6eNBllUO1HR942KLAX4u/jvhVUAoEntVaxmXQOIzMgnnx4oYIHQ2oV5ftDkPP
         F3Mpd8P3ypbI+T0VrB+B3ggUuS2lkFRf+BHdkcW8pX7mQcK2dVABHjSGI+tmvXH8C5cS
         qq9Cw4lNWlw84EQ9ZTlb5RElY7ExlgLSNeHVOYng6nVXh7u4BvYm6qZNRbRnhgyxouTF
         hrMb9ivGytjmvrvWJqzzEinjP/orHRqUJnjN/51BkSL4vekL5iQyrgvhZ2Aa+oC5G8id
         rupdHbQbumzENViHdXnf6bCuPl3bsOjahd8JedW9Xyd12z093k+Bq4rUkPPsylcjXzyK
         BxHQ==
X-Gm-Message-State: AOAM530sgkKQjhzLhSd/JRlEPHaiEJmSqMFuRjeggmMSNpBhNEPAmZJk
        BIJciweNRzeDHU4WhQK6RQUHcOyORb+BkWqCuvj6zQ==
X-Google-Smtp-Source: ABdhPJw1VjQ62MwbxnVetu2KFatM9kheWAJJfezTYytAXzbh88FOGY4hTcSMBpDz0J/dm4EaQSnWU4J67TnjFV+cb6o=
X-Received: by 2002:a62:1b92:0:b0:3eb:3f92:724 with SMTP id
 b140-20020a621b92000000b003eb3f920724mr33331175pfb.3.1634060583829; Tue, 12
 Oct 2021 10:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053103-mutt-send-email-mst@kernel.org> <CAPcyv4hDhjRXYCX_aiOboLF0eaTo6VySbZDa5NQu2ed9Ty2Ekw@mail.gmail.com>
 <0e6664ac-cbb2-96ff-0106-9301735c0836@linux.intel.com>
In-Reply-To: <0e6664ac-cbb2-96ff-0106-9301735c0836@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 12 Oct 2021 10:42:52 -0700
Message-ID: <CAPcyv4g0v0YHZ-okxf4wwVCYxHotxdKwsJpZGkoT+fhvvAJEFg@mail.gmail.com>
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

On Sun, Oct 10, 2021 at 3:11 PM Andi Kleen <ak@linux.intel.com> wrote:
>
>
> On 10/9/2021 1:39 PM, Dan Williams wrote:
> > On Sat, Oct 9, 2021 at 2:53 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >> On Fri, Oct 08, 2021 at 05:37:07PM -0700, Kuppuswamy Sathyanarayanan wrote:
> >>> From: Andi Kleen <ak@linux.intel.com>
> >>>
> >>> For Confidential VM guests like TDX, the host is untrusted and hence
> >>> the devices emulated by the host or any data coming from the host
> >>> cannot be trusted. So the drivers that interact with the outside world
> >>> have to be hardened by sharing memory with host on need basis
> >>> with proper hardening fixes.
> >>>
> >>> For the PCI driver case, to share the memory with the host add
> >>> pci_iomap_host_shared() and pci_iomap_host_shared_range() APIs.
> >>>
> >>> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> >>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >> So I proposed to make all pci mappings shared, eliminating the need
> >> to patch drivers.
> >>
> >> To which Andi replied
> >>          One problem with removing the ioremap opt-in is that
> >>          it's still possible for drivers to get at devices without going through probe.
> >>
> >> To which Greg replied:
> >> https://lore.kernel.org/all/YVXBNJ431YIWwZdQ@kroah.com/
> >>          If there are in-kernel PCI drivers that do not do this, they need to be
> >>          fixed today.
> >>
> >> Can you guys resolve the differences here?
> > I agree with you and Greg here. If a driver is accessing hardware
> > resources outside of the bind lifetime of one of the devices it
> > supports, and in a way that neither modrobe-policy nor
> > device-authorization -policy infrastructure can block, that sounds
> > like a bug report.
>
> The 5.15 tree has something like ~2.4k IO accesses (including MMIO and
> others) in init functions that also register drivers (thanks Elena for
> the number)
>
> Some are probably old drivers that could be fixed, but it's quite a few
> legitimate cases. For example for platform or ISA drivers that's the
> only way they can be implemented because they often have no other
> enumeration mechanism. For PCI drivers it's rarer, but also still can
> happen. One example that comes to mind here is the x86 Intel uncore
> drivers, which support a mix of MSR, ioremap and PCI config space
> accesses all from the same driver. This particular example can (and
> should be) fixed in other ways, but similar things also happen in other
> drivers, and they're not all broken. Even for the broken ones they're
> usually for some crufty old devices that has very few users, so it's
> likely untestable in practice.
>
> My point is just that the ecosystem of devices that Linux supports is
> messy enough that there are legitimate exceptions from the "First IO
> only in probe call only" rule.
>
> And we can't just fix them all. Even if we could it would be hard to
> maintain.
>
> Using a "firewall model" hooking into a few strategic points like we're
> proposing here is much saner for everyone.
>
> Now we can argue about the details. Right now what we're proposing has
> some redundancies: it has both a device model filter and low level
> filter for ioremap (this patch and some others). The low level filter is
> for catching issues that don't clearly fit into the
> "enumeration<->probe" model. You could call that redundant, but I would
> call it defense in depth or better safe than sorry. In theory it would
> be enough to have the low level opt-in only, but that would have the
> drawback that is something gets enumerated after all you would have all
> kind of weird device driver failures and in some cases even killed
> guests. So I think it makes sense to have

The "better safe-than-sorry" argument is hard to build consensus
around. The spectre mitigations ran into similar problems where the
community rightly wanted to see the details and instrument the
problematic paths rather than blanket sprinkle lfence "just to be
safe". In this case the rules about when a driver is suitably
"hardened" are vague and the overlapping policy engines are confusing.

I'd rather see more concerted efforts focused/limited core changes
rather than leaf driver changes until there is a clearer definition of
hardened. I.e. instead of jumping to the assertion that fixing up
these init-path vulnerabilities are too big to fix, dig to the next
level to provide more evidence that per-driver opt-in is the only
viable option.

For example, how many of these problematic paths are built-in to the
average kernel config? A strawman might be to add a sprinkling error
exits in the module_init() of the problematic drivers, and only fail
if the module is built-in, and let modprobe policy handle the rest.

>
>
> > Fix those drivers instead of sprinkling
> > ioremap_shared in select places and with unclear rules about when a
> > driver is allowed to do "shared" mappings.
>
> Only add it when the driver has been audited and hardened.
>
> But I agree we need on a documented process for this. I will work on
> some documentation for a proposal. But essentially I think it should be
> some variant of what Elena has outlined in her talk at Security Summit.
>
> https://static.sched.com/hosted_files/lssna2021/b6/LSS-HardeningLinuxGuestForCCC.pdf
>
> That is using extra auditing/scrutiny at review time, supported with
> some static code analysis that points to the interaction points, and
> code needs to be fuzzed explicitly.
>
> However short term it's only three virtio drivers, so this is not a
> urgent problem.
>
> > Let the new
> > device-authorization mechanism (with policy in userspace)
>
>
> Default policy in user space just seems to be a bad idea here. Who
> should know if a driver is hardened other than the kernel? Maintaining
> the list somewhere else just doesn't make sense to me.

I do not understand the maintenance burden correlation of where the
policy is driven vs where the list is maintained? Even if I agreed
with the contention that out-of-tree userspace would have a hard time
tracking the "hardened" driver list there is still an in-tree
userspace path to explore. E.g. perf maintains lists of things tightly
coupled to the kernel, this authorized device list seems to be in the
same category of data.

> Also there is the more practical problem that some devices are needed
> for booting. For example in TDX we can't print something to the console
> with this mechanism, so you would never get any output before the
> initrd. Just seems like a nightmare for debugging anything. There really
> needs to be an authorization mechanism that works reasonably early.
>
> I can see a point of having user space overrides though, but we need to
> have a sane kernel default that works early.

Right, as I suggested [1], just enough early authorization to
bootstrap/debug initramfs and then that can authorize the remainder.

[1]: https://lore.kernel.org/all/CAPcyv4im4Tsj1SnxSWe=cAHBP1mQ=zgO-D81n2BpD+_HkpitbQ@mail.gmail.com/
