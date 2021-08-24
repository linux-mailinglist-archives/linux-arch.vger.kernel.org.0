Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407253F6948
	for <lists+linux-arch@lfdr.de>; Tue, 24 Aug 2021 20:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbhHXS4a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Aug 2021 14:56:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230500AbhHXS41 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Aug 2021 14:56:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC45C61178;
        Tue, 24 Aug 2021 18:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629831343;
        bh=d/Fr0mBMXraTW+Ew01Yil+DCXSSjTvd5q9qem138RPE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=t5cnqJZj36He9/zjegb9+V9+U3YiQamVwwKvzU1WrQq1Qaa+otNQjIpOiBqlsMEdM
         /Hqh3iR5wCXL+mGe6LqhWoGFpktgZ9b12IewTtcxFDv1maXi/yfljyIhDOnl/z5XMt
         kqtFzOpSSbjXME95XQ70DtnBwGzFO7+zGwLjQy9HFrGMtxqHJNh2QDgWLglZ5C35GH
         hnCcNOL4lw0MsGxbMWF0J/SLHbKZSnrBA1q8ych11j+zeKHwRGuUnfE1N3/f5XMPXs
         oyQMr/mk68NjLI3llarex6W2QR/Y9G8ODdkhohBntXV7QiObuNljxc6qSrgPHYc8ep
         rrO89m1YOIQlQ==
Date:   Tue, 24 Aug 2021 13:55:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kuppuswamy, Sathyanarayanan" 
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
        Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4 11/15] pci: Add pci_iomap_shared{,_range}
Message-ID: <20210824185541.GA3485816@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d21a2a2d-4670-ba85-ce9a-fc8ea80ef1be@linux.intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

[+cc Rajat; I still don't know what "shared memory with a hypervisor
in a confidential guest" means, but now we're talking about hardened
drivers and allow lists, which Rajat is interested in]

On Tue, Aug 24, 2021 at 10:20:44AM -0700, Andi Kleen wrote:
> 
> > I see. Hmm. It's a bit of a random thing to do it at the map time
> > though. E.g. DMA is all handled transparently behind the DMA API.
> > Hardening is much more than just replacing map with map_shared
> > and I suspect what you will end up with is basically
> > vendors replacing map with map shared to make things work
> > for their users and washing their hands.
> 
> That concept exists too. There is a separate allow list for the drivers. So
> just adding shared to a driver is not enough, until it's also added to the
> allowlist
> 
> Users can of course chose to disable the allowlist, but they need to
> understand the security implications.
> 
> > I would say an explicit flag in the driver that says "hardened"
> > and refusing to init a non hardened one would be better.
> 
> We have that too (that's the device filtering)
> 
> But the problem is that device filtering just stops the probe functions, not
> the initcalls, and lot of legacy drivers do MMIO interactions before going
> into probe. In some cases it's unavoidable because of the device doesn't
> have a separate enumeration mechanism it needs some kind of probing to even
> check for its existence And since we don't want to change all of them it's
> far safer to make the ioremap opt-in.
> 
> 
> -Andi
> 
