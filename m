Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100F34296C6
	for <lists+linux-arch@lfdr.de>; Mon, 11 Oct 2021 20:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbhJKSYq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Oct 2021 14:24:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29076 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234399AbhJKSYo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 11 Oct 2021 14:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633976563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dMNh2Z50mjXzYsw8NI8wyY+ikUuFKE6oW0fJI23ISWw=;
        b=fISYrrSJNh9ZzUprXO1YpfKegc7B9Qj+81C1tBjNjqnDq7uIFV0QC5vTNWL6fmuDzC/oUL
        GzepTAj17G/Br0CpfRQzdBSPZ+jrgivJkXcBIQAEvHM3hWf0UlcWAdN4JeJFv0fPeVhfDz
        apBKm7KWzqve5OWKqVG8qMp5lseaa/o=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-wvvTBE0pO9GG0FbFkmFaKA-1; Mon, 11 Oct 2021 14:22:42 -0400
X-MC-Unique: wvvTBE0pO9GG0FbFkmFaKA-1
Received: by mail-ed1-f70.google.com with SMTP id c8-20020a50d648000000b003daa53c7518so16571172edj.21
        for <linux-arch@vger.kernel.org>; Mon, 11 Oct 2021 11:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dMNh2Z50mjXzYsw8NI8wyY+ikUuFKE6oW0fJI23ISWw=;
        b=nR0r7matC8sFXzX5JautRccZ9SatZ5o8W9+K8bBgIjpy2iZlJz8c3s59y7bADlwGje
         CXLgQ2LfmSo0a1yUmGvG0qUheNFAa/tmFFloR5Na8qnru5XfC6E2LexXD98pEDiISfTB
         b6eXAVgvNp5YR9t+gcNgn46RdRBNiGtmpNSNLP8evxEmKUSvzOrT5nvMfkJH4qlmFvwG
         AdqUVyq3JpITEc7fZ+rGUbyPMRX/wyUZXY82/IZOMPg4Q/VBgdYFS49xuKOdKTR45riE
         9amzOlR4js/NdpZQv2Fa1dtcM3tOs2hy4i95gaeIT9lTBA11vtLMPAw+J8x4OBrPouIh
         zaUw==
X-Gm-Message-State: AOAM5301DkDHSsEpYI+3G8ACMzoNM+CJ0LGSJasBRtfuPHkmU2zeDzeu
        y0Vzd+2bL49ENiS0UH7hOevlMCQMjxS3WZ/ho1KCS7eUMskv43ZJBbb0itUi32r0D1trmOjoxd8
        7eU0q3oqeS4uj2k+zxE5cgg==
X-Received: by 2002:aa7:c941:: with SMTP id h1mr44235666edt.128.1633976560834;
        Mon, 11 Oct 2021 11:22:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyN/U+BRUzodKL6gvFVqtuU/Q67n/I/WAJHIiErFZ+rnv84Ucv2oE2o+msvXuPI2MK8YmvNow==
X-Received: by 2002:aa7:c941:: with SMTP id h1mr44235616edt.128.1633976560614;
        Mon, 11 Oct 2021 11:22:40 -0700 (PDT)
Received: from redhat.com ([2.55.159.57])
        by smtp.gmail.com with ESMTPSA id u2sm4623544eda.32.2021.10.11.11.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 11:22:39 -0700 (PDT)
Date:   Mon, 11 Oct 2021 14:22:33 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
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
        Dan Williams <dan.j.williams@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
Message-ID: <20211011141248-mutt-send-email-mst@kernel.org>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053103-mutt-send-email-mst@kernel.org>
 <cec62ebb-87d7-d725-1096-2c97c5eedbc3@linux.intel.com>
 <20211011073614-mutt-send-email-mst@kernel.org>
 <78766e28-8353-acc8-19e2-033d4bbf3472@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78766e28-8353-acc8-19e2-033d4bbf3472@linux.intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 11, 2021 at 10:32:23AM -0700, Andi Kleen wrote:
> 
> > Because it does not end with I/O operations, that's a trivial example.
> > module unloading is famous for being racy: I just re-read that part of
> > virtio drivers and sure enough we have bugs there, this is after
> > they have presumably been audited, so a TDX guest is better off
> > just disabling hot-unplug completely, and hotplug isn't far behind.
> 
> These all shouldn't matter for a confidential guest. The only way it can be
> attacked is through IO, everything else is protected by hardware.
> 
> 
> Also it would all require doing something at the guest level, which we
> assume is not malicious.
> 
> 
> > Malicious filesystems can exploit many linux systems unless
> > you take pains to limit what is mounted and how.
> 
> That's expected to be handled by authenticated dmcrypt and similar.
> Hardening at this level has been done for many years.

It's possible to do it like this, sure. But that's not the
only configuration, userspace needs to be smart about setting things up.
Which is my point really.

> 
> > Networking devices tend to get into the default namespaces and can
> > do more or less whatever CAP_NET_ADMIN can.
> > Etc.
> 
> 
> Networking should be already hardened, otherwise you would have much worse
> problems today.

Same thing. NFS is pretty common, you are saying don't do it then. Fair
enough but again, arbitrary configs just aren't going to be secure.

> 
> 
> > hange in your subsystem here.
> > Well I commented on the API patch, not the virtio patch.
> > If it's a way for a driver to say "I am hardened
> > and audited" then I guess it should at least say so.
> 
> 
> This is handled by the central allow list. We intentionally didn't want each
> driver to declare itself, but have a central list where changes will get
> more scrutiny than random driver code.

Makes sense. Additionally, distros can tweak that to their heart's
content, selecting the functionality/security balance that makes sense
for them.

> But then there are the additional opt-ins for the low level firewall. These
> are in the API. I don't see how it could be done at the driver level, unless
> you want to pass in a struct device everywhere?

I am just saying don't do it then. Don't build drivers that distro does
not want to support into kernel. And don't load them when they are
modules.

> > > > How about creating a defconfig that makes sense for TDX then?
> > > TDX can be used in many different ways, I don't think a defconfig is
> > > practical.
> > > 
> > > In theory you could do some Kconfig dependency (at the pain point of having
> > > separate kernel binariees), but why not just do it at run time then if you
> > > maintain the list anyways. That's much easier and saner for everyone. In the
> > > past we usually always ended up with runtime mechanism for similar things
> > > anyways.
> > > 
> > > Also it turns out that the filter mechanisms are needed for some arch
> > > drivers which are not even configurable, so alone it's probably not enough,
> > 
> > I guess they aren't really needed though right, or you won't try to
> > filter them?
> 
> We're addressing most of them with the device filter for platform drivers.
> But since we cannot stop them doing ioremap IO in their init code they also
> need the low level firewall.
> 
> Some others that cannot be addressed have explicit disables.
> 
> 
> > So make them configurable?
> 
> Why not just fix the runtime? It's much saner for everyone. Proposing to do
> things at build time sounds like we're in Linux 0.99 days.
> 
> -Andi

Um. Tweaking driver code is not just build time, it's development time.
At least with kconfig you don't need to patch your kernel.

-- 
MST

