Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F018C3F77C6
	for <lists+linux-arch@lfdr.de>; Wed, 25 Aug 2021 16:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240493AbhHYOxX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Aug 2021 10:53:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240395AbhHYOxW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 25 Aug 2021 10:53:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36A4E610CD;
        Wed, 25 Aug 2021 14:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629903156;
        bh=JavDwpgii8kF2lXyvHOwR8IF/SUWfOr82rbSiTe1nco=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=etlal+X6PK/iyyE+nCKJqe8xvh6sOY35Jz8lqksr6gEQVCToh4OokpBhqzSLN+EQd
         CbpLIssWEQtnZPMe70kfBxZJeme2Vw5EfXhChn/2RVE74/XOQ0ogJdDJbJSxQ6B6tW
         NpWtwQV/bKLoQqX4+aw+rClsxeZQuTcMptgtwqLJE9cPhKmxBAMOvE9u1TAbpbyusm
         2r/bieajK+y11XHoHy7rRrWGS+kpuVvgAm5FMOgzMz/YOJ/ryEgttZaNO+A2gFqSgV
         gSDOXXqDHEGwZCzB6XgcGfNipfy8ECvl8ldyO/Fs4RX/PiHXnplmt9Ddb5SbfOzVkW
         H7gyI/GMyzCTg==
Date:   Wed, 25 Aug 2021 09:52:35 -0500
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
Message-ID: <20210825145235.GA3565590@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb8c6f96-2597-bb80-bd08-7958405e1bf5@linux.intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 24, 2021 at 01:50:00PM -0700, Andi Kleen wrote:
> 
> On 8/24/2021 1:31 PM, Bjorn Helgaas wrote:
> > On Tue, Aug 24, 2021 at 01:14:02PM -0700, Andi Kleen wrote:
> > > On 8/24/2021 11:55 AM, Bjorn Helgaas wrote:
> > > > [+cc Rajat; I still don't know what "shared memory with a hypervisor
> > > > in a confidential guest" means,
> > > A confidential guest is a guest which uses memory encryption to isolate
> > > itself from the host. It doesn't trust the host. But it still needs to
> > > communicate with the host for IO, so it has some special memory areas that
> > > are explicitly marked shared. These are used to do IO with the host. All
> > > their usage needs to be carefully hardened to avoid any security attacks on
> > > the guest, that's why we want to limit this interaction only to a small set
> > > of hardened drivers. For MMIO, the set is currently only virtio and MSI-X.
> > Good material for the commit log next time around.  Thanks!
> 
> This is all in the patch intro too, which should make it into the merge
> commits.

It's good if the cover letter makes into the merge commit log.

It's probably just because my git foo is lacking, but merge commit
logs don't seem as discoverable as the actual patch commit logs.  Five
years from now, if I want to learn about pci_iomap_shared() history, I
would "git log -p lib/pci_iomap.c" and search for it.  But I don't
think I would see the merge commit then.

Bjorn
