Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F188B3F6A6C
	for <lists+linux-arch@lfdr.de>; Tue, 24 Aug 2021 22:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbhHXUcB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Aug 2021 16:32:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234675AbhHXUcB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Aug 2021 16:32:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3738C610F7;
        Tue, 24 Aug 2021 20:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629837076;
        bh=u89RhbA1T4/YcegxqumOKFDZveULzg7IH3BXxWstXGA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=E7gmG9cu+2X8EpSv9jHNw194dQ/bFH+W8S5CviPC+WEzgK9x1GqwxeKDnQA93Ubc6
         pIROpW9mCbmFawlLNt183dkzLJG92jUie48vdct5nMY9KMIpav4jCN5vVtcBqt99IN
         LlMRmUTD9hQbKroaOXlhVlrUixEOK798eHEQ6pmGyuqfJJo5J4wfidKynCvdtb3s37
         PjcEO5DOcIPu3SLREF0Tt+IUZRL6NjCeGqQy3Vt+WmnxMDtnryxVfbjA5YVJAeYKm9
         BpOJvSuNngQVXkAMINkK0ZwKmdIz+EDYyzVhKaDWPyJSTPhZYBRtaAf1VAW/wDK4NO
         xT3mGvV5LJ4bA==
Date:   Tue, 24 Aug 2021 15:31:15 -0500
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
Message-ID: <20210824203115.GA3492097@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a80fc61a-bc55-b82c-354b-b57863ab03db@linux.intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 24, 2021 at 01:14:02PM -0700, Andi Kleen wrote:
> 
> On 8/24/2021 11:55 AM, Bjorn Helgaas wrote:
> > [+cc Rajat; I still don't know what "shared memory with a hypervisor
> > in a confidential guest" means,
> 
> A confidential guest is a guest which uses memory encryption to isolate
> itself from the host. It doesn't trust the host. But it still needs to
> communicate with the host for IO, so it has some special memory areas that
> are explicitly marked shared. These are used to do IO with the host. All
> their usage needs to be carefully hardened to avoid any security attacks on
> the guest, that's why we want to limit this interaction only to a small set
> of hardened drivers. For MMIO, the set is currently only virtio and MSI-X.

Good material for the commit log next time around.  Thanks!

Bjorn
