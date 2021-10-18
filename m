Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03324318B3
	for <lists+linux-arch@lfdr.de>; Mon, 18 Oct 2021 14:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhJRMSB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Oct 2021 08:18:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229569AbhJRMSA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 Oct 2021 08:18:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2718B60FC3;
        Mon, 18 Oct 2021 12:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634559349;
        bh=utOH7FzBux08wNzkB3/bvFS2wN2XWHumibuU5/SmXqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RLIsz1J2utLAUX4a2GrToXiY0xBfCjZ73PD3hx1N9Ok6rP0P/uoORdGSKblUyCaKv
         YrTHN7wL8jRgbxJbVKnN0c0X1obFShrmbiad64H8b83XIybuE3HlqY0K45X4p4qAaS
         dCSKbXRf3JcZ3d/IAO/04HW8b+ibphQ9xnPd5sVo=
Date:   Mon, 18 Oct 2021 14:15:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
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
Message-ID: <YW1lc5Y2P1zRc2kp@kroah.com>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053103-mutt-send-email-mst@kernel.org>
 <cec62ebb-87d7-d725-1096-2c97c5eedbc3@linux.intel.com>
 <20211011073614-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011073614-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 11, 2021 at 07:59:17AM -0400, Michael S. Tsirkin wrote:
> On Sun, Oct 10, 2021 at 03:22:39PM -0700, Andi Kleen wrote:
> > 
> > > To which Andi replied
> > > 	One problem with removing the ioremap opt-in is that
> > > 	it's still possible for drivers to get at devices without going through probe.
> > > 
> > > To which Greg replied:
> > > https://lore.kernel.org/all/YVXBNJ431YIWwZdQ@kroah.com/
> > > 	If there are in-kernel PCI drivers that do not do this, they need to be
> > > 	fixed today.
> > > 
> > > Can you guys resolve the differences here?
> > 
> > 
> > I addressed this in my other mail, but we may need more discussion.
> 
> Hopefully Greg will reply to that one.

Note, when wanting Greg to reply, someone should at the very least cc:
him.

{sigh}

greg k-h
