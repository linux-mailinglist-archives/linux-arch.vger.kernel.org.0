Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E1A427D65
	for <lists+linux-arch@lfdr.de>; Sat,  9 Oct 2021 22:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhJIUmH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 9 Oct 2021 16:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhJIUmG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 9 Oct 2021 16:42:06 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C720C061762
        for <linux-arch@vger.kernel.org>; Sat,  9 Oct 2021 13:40:09 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id on6so10126845pjb.5
        for <linux-arch@vger.kernel.org>; Sat, 09 Oct 2021 13:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PNkbI6CC4MPwch06xoRoPuOpZuZRykTcMawJcvuLIGc=;
        b=Muu3r0eHUqB/dNHg2SbcMZBR59fyebiqEBsvk6PezrQlxQGwEI1ZicQJ1XHU8yb+jR
         kHSIW8u2KEJn+hh/8bqD+oSUoLGTMzHi2MKjMWxijaluyFQ9X/HFL9QP8jG3kJvP1+yC
         MFrvKW7dOAqDY1UzAuwqQRxVpGtbg2xoYhxoIQminXJgv3DKYb4mwO0GqHZDYiNWBRPr
         zX9FmLpjC1P17blRe4cxwK4BawnSAcTVigJTMtvWGUVR4Krw0LhW/yHMyjDs7LwJths0
         zTeiN6ZgCa7R3RDBLb9WPt7ZUqU0TGXpSpq1OOroQI9pRt1DcheHTMwoozKzKGHc51Jc
         ai5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PNkbI6CC4MPwch06xoRoPuOpZuZRykTcMawJcvuLIGc=;
        b=GBpEVgQFmvvWBs+cfN9zLfYfQZDVDQ5S1fumSXCfbiLmAvFys236YK9kwTDK0rTiZ/
         y/iUOpVt9SHoifIpQ4dYHSSWtMWfLMoDzjlXsagtUCs1Mlt7zARRutiQRlpNaBwE1j/D
         fZ7rrOAgGslBgQZ6oXaND4BL7LKZga+i0KoVCSN4cP8BCVRjAnSEU4oBw2xUbyxKXp0K
         T6YS6US+ED3LpRu+ml76zm5IRTzZklhd8Q+vTuOvTi/AEVO64I0gsumWf6GS+2+NrBaR
         O1FyXZsH14ytgaMAG4Xe/mEnwcbNcsdtLI6GtPR9S8hbbz985SRQDH2O6VAmd9GXJCkS
         pJSw==
X-Gm-Message-State: AOAM5315lI0hiFOLrh2fmKlAsJtVO1ziKrXY7aDG/2xEB0HzIB00jT4o
        1TIVp12pqVeex1IRBf0IfZ91oIePqD7gjM7L1eymKw==
X-Google-Smtp-Source: ABdhPJySd5zqNERLKr8S37E5WA9IMnevPxuJEZ9BVS6uY8X2FGjPzRDwsaOEKoQH/I5/2YcevgWJ2BJGpdsvJiUJb30=
X-Received: by 2002:a17:90a:d686:: with SMTP id x6mr20678375pju.8.1633812008773;
 Sat, 09 Oct 2021 13:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com> <20211009053103-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211009053103-mutt-send-email-mst@kernel.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 9 Oct 2021 13:39:57 -0700
Message-ID: <CAPcyv4hDhjRXYCX_aiOboLF0eaTo6VySbZDa5NQu2ed9Ty2Ekw@mail.gmail.com>
Subject: Re: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(), pci_iomap_host_shared_range()
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Kuppuswamy Sathyanarayanan 
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
        Andi Kleen <ak@linux.intel.com>,
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
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Oct 9, 2021 at 2:53 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Oct 08, 2021 at 05:37:07PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > From: Andi Kleen <ak@linux.intel.com>
> >
> > For Confidential VM guests like TDX, the host is untrusted and hence
> > the devices emulated by the host or any data coming from the host
> > cannot be trusted. So the drivers that interact with the outside world
> > have to be hardened by sharing memory with host on need basis
> > with proper hardening fixes.
> >
> > For the PCI driver case, to share the memory with the host add
> > pci_iomap_host_shared() and pci_iomap_host_shared_range() APIs.
> >
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> So I proposed to make all pci mappings shared, eliminating the need
> to patch drivers.
>
> To which Andi replied
>         One problem with removing the ioremap opt-in is that
>         it's still possible for drivers to get at devices without going through probe.
>
> To which Greg replied:
> https://lore.kernel.org/all/YVXBNJ431YIWwZdQ@kroah.com/
>         If there are in-kernel PCI drivers that do not do this, they need to be
>         fixed today.
>
> Can you guys resolve the differences here?

I agree with you and Greg here. If a driver is accessing hardware
resources outside of the bind lifetime of one of the devices it
supports, and in a way that neither modrobe-policy nor
device-authorization -policy infrastructure can block, that sounds
like a bug report. Fix those drivers instead of sprinkling
ioremap_shared in select places and with unclear rules about when a
driver is allowed to do "shared" mappings. Let the new
device-authorization mechanism (with policy in userspace) be the
central place where all of these driver "trust" issues are managed.

> And once they are resolved, mention this in the commit log so
> I don't get to re-read the series just to find out nothing
> changed in this respect?
>
> I frankly do not believe we are anywhere near being able to harden
> an arbitrary kernel config against attack.
> How about creating a defconfig that makes sense for TDX then?
> Anyone deviating from that better know what they are doing,
> this API tweaking is just putting policy into the kernel  ...

Right, userspace authorization policy and select driver fixups seems
to be the answer to the raised concerns.
