Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225BA430D2E
	for <lists+linux-arch@lfdr.de>; Mon, 18 Oct 2021 02:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344885AbhJRA5Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 17 Oct 2021 20:57:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34970 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344888AbhJRA5Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 17 Oct 2021 20:57:25 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634518512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=Gay8VmFyss97KfWC5visbOqdWAYqK9/j2DbvMiqFQuY=;
        b=XHU/uT6rxY83cF7h/S8R1Or7JEZysnYFiMTBcvx5KoySp5QBAdL72qHvO/eAZ44b/oq3vE
        btNorRbowan8FRVNNpXH6+aXAmG0xXy2yRXzb6ymU0722PLjY2grnFZ0xyYhFuMZt8oj34
        nVCwWohCP3WCdN+qHMYPSPAQitSOPg+8BNuqxg2PGTNKfNzy8XO1aG4MVazipjYuTM5Hfg
        rPKozNgBgpjTgQTFwURKcICK+nkcOLZyV12wAWjfISaiPSEk3dwNafUw/aNGmJrVIt60fW
        QrDeG4HB/o/g+NtgFglnBrD3XJ+VscmgTDiwoLvTPsn1H2T4v4+ErS5lir8cLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634518512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=Gay8VmFyss97KfWC5visbOqdWAYqK9/j2DbvMiqFQuY=;
        b=bkeSQfcwuKqiSyUYQR5UJ5dUTJnV3GfJ5hn2kv4dlsE7Q5KIsp4P7VACv6mECyInrd/hXO
        2M0zlxRqSRVXWIAA==
To:     Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
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
In-Reply-To: <0e6664ac-cbb2-96ff-0106-9301735c0836@linux.intel.com>
Date:   Mon, 18 Oct 2021 02:55:11 +0200
Message-ID: <875ytv2lu8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Andi,

On Sun, Oct 10 2021 at 15:11, Andi Kleen wrote:
> On 10/9/2021 1:39 PM, Dan Williams wrote:
>> I agree with you and Greg here. If a driver is accessing hardware
>> resources outside of the bind lifetime of one of the devices it
>> supports, and in a way that neither modrobe-policy nor
>> device-authorization -policy infrastructure can block, that sounds
>> like a bug report.
>
> The 5.15 tree has something like ~2.4k IO accesses (including MMIO and 
> others) in init functions that also register drivers (thanks Elena for 
> the number)

These numbers are completely useless simply because they are based on
nonsensical criteria. See:

  https://lore.kernel.org/r/87r1cj2uad.ffs@tglx

> My point is just that the ecosystem of devices that Linux supports is 
> messy enough that there are legitimate exceptions from the "First IO 
> only in probe call only" rule.

Your point is based on your outright refusal to actualy do a proper
analysis and your outright refusal to help fixing the real problems.

All you have provided so far is handwaving based on a completely useless
analysis.

Sure, your goal is to get this TDX problem solved, but it's not going to
be solved by:

  1) Providing a nonsensical analysis

  2) Using #1 as an argument to hack some half baken interfaces into the
     kernel which allow you to tick off your checkbox and then leave the
     resulting mess for others to clean up.
 
Try again when you have factual data to back up your claims and factual
arguments which prove that the problem can't be fixed otherwise.

I might be repeating myself, but kernel development works this way:

  1) Hack your private POC - Yay!

  2) Sit down and think hard about the problems you identified in step
     #1. Do a thorough analysis.
  
  3) Come up with a sensible integration plan.

  4) Do the necessary grump work of cleanups all over the place

  5) Add sensible infrastructure which is understandable for the bulk
     of kernel/driver developers

  6) Let your feature fall in place

and not in the way you are insisting on:

  1) Hack your private POC - Yay!

  2) Define that this is the only way to do it and try to shove it down
     the throat of everyone.

  3) Getting told that this is not the way it works

  4) Insist on it forever and blame the grumpy maintainers who are just
     not understanding the great value of your approach.

  5) Go back to #2

You should know that already, but I have no problem to give that lecture
to you over and over again. I probably should create a form letter.

And no, you can bitch about me as much as you want. These are not my
personal rules and personal pet pieves. These are rules Linus cares
about very much and aside of that they just reflect common sense.

  The kernel is a common good and not the dump ground for your personal
  brain waste.

  The kernel does not serve Intel. Quite the contrary Intel depends on
  the kernel to work nicely with it's hardware. Ergo, Intel should have
  a vested interest to serve the kernel and take responsibility for it
  as a whole. And so should you as an Intel employee.

Just dumping your next half baken workaround does not cut it especially
not when it is not backed up by sensible arguments.

Please try again, but not before you have something substantial to back
up your claims.

Thanks,

	Thomas
