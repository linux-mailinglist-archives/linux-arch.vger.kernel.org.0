Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CC8431893
	for <lists+linux-arch@lfdr.de>; Mon, 18 Oct 2021 14:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhJRMPq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Oct 2021 08:15:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231310AbhJRMPp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 Oct 2021 08:15:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F24B60FC3;
        Mon, 18 Oct 2021 12:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634559214;
        bh=JZE/18szAvUy5mVaCGRgXJrrABVRJ4b0rsi8noFT/gc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IkZ3b0MSfLm82OzxCOU7adYJFi02YagmoJazhg7LEntEzfOQdqHwsXijFZPe4QPtw
         xwtKn2ZJjvqdKSJbh+62rRNRcDQXH+5QrQDVWusQU+/IlmLPXzykFgeISq0R7Wk3Gh
         hblMyMVpPBCIxh/4VYKjOCHOCmFjBQ3qVCvJK2UA=
Date:   Mon, 18 Oct 2021 14:13:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
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
Subject: Re: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
Message-ID: <YW1k69vzJr5kbViv@kroah.com>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053103-mutt-send-email-mst@kernel.org>
 <CAPcyv4hDhjRXYCX_aiOboLF0eaTo6VySbZDa5NQu2ed9Ty2Ekw@mail.gmail.com>
 <0e6664ac-cbb2-96ff-0106-9301735c0836@linux.intel.com>
 <CAPcyv4g0v0YHZ-okxf4wwVCYxHotxdKwsJpZGkoT+fhvvAJEFg@mail.gmail.com>
 <9302f1c2-b3f8-2c9e-52c5-d5a4a2987409@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9302f1c2-b3f8-2c9e-52c5-d5a4a2987409@linux.intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 12, 2021 at 11:35:04AM -0700, Andi Kleen wrote:
> > I'd rather see more concerted efforts focused/limited core changes
> > rather than leaf driver changes until there is a clearer definition of
> > hardened.
> 
> A hardened driver is a driver that

Ah, you do define this, thank you!

> - Had similar security (not API) oriented review of its IO operations
> (mainly MMIO access, but also PCI config space) as a non privileged user
> interface (like a ioctl). That review should be focused on memory safety.

Where is this review done?  Where is is documented?  Who is responsible
for keeping it up to date with every code change to the driver, and to
the code that the driver calls and the code that calls the driver?

> - Had some fuzzing on these IO interfaces using to be released tools.

"some"?  What tools?  What is the input, and where is that defined?  How
much fuzzing do you claim is "good enough"?

> Right now it's only three virtio drivers (console, net, block)

Where was this work done and published?  And why only 3?

> Really it's no different than what we do for every new unprivileged user
> interface.

Really?  I have seen loads of new drivers from Intel submitted in the
past months that would fail any of the above things just based on
obvious code reviews that I end up having to do...

If you want to start a "hardened driver" effort, there's a lot of real
work that needs to be done here and documented, and explained why it can
not just be done for the whole kernel...

greg k-h
