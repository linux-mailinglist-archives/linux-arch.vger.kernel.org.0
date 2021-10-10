Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30CD42840C
	for <lists+linux-arch@lfdr.de>; Mon, 11 Oct 2021 00:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbhJJWYl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 10 Oct 2021 18:24:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:64334 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231136AbhJJWYk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 10 Oct 2021 18:24:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10133"; a="226725291"
X-IronPort-AV: E=Sophos;i="5.85,363,1624345200"; 
   d="scan'208";a="226725291"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2021 15:22:41 -0700
X-IronPort-AV: E=Sophos;i="5.85,363,1624345200"; 
   d="scan'208";a="459751289"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.83.75]) ([10.209.83.75])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2021 15:22:40 -0700
Message-ID: <cec62ebb-87d7-d725-1096-2c97c5eedbc3@linux.intel.com>
Date:   Sun, 10 Oct 2021 15:22:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053103-mutt-send-email-mst@kernel.org>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <20211009053103-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> To which Andi replied
> 	One problem with removing the ioremap opt-in is that
> 	it's still possible for drivers to get at devices without going through probe.
>
> To which Greg replied:
> https://lore.kernel.org/all/YVXBNJ431YIWwZdQ@kroah.com/
> 	If there are in-kernel PCI drivers that do not do this, they need to be
> 	fixed today.
>
> Can you guys resolve the differences here?


I addressed this in my other mail, but we may need more discussion.


>
> And once they are resolved, mention this in the commit log so
> I don't get to re-read the series just to find out nothing
> changed in this respect?
>
> I frankly do not believe we are anywhere near being able to harden
> an arbitrary kernel config against attack.

Why not? Device filter and the opt-ins together are a fairly strong 
mechanism.

And it's not that they're a lot of code or super complicated either.

You're essentially objecting to a single line change in your subsystem here.


> How about creating a defconfig that makes sense for TDX then?

TDX can be used in many different ways, I don't think a defconfig is 
practical.

In theory you could do some Kconfig dependency (at the pain point of 
having separate kernel binariees), but why not just do it at run time 
then if you maintain the list anyways. That's much easier and saner for 
everyone. In the past we usually always ended up with runtime mechanism 
for similar things anyways.

Also it turns out that the filter mechanisms are needed for some arch 
drivers which are not even configurable, so alone it's probably not enough,


> Anyone deviating from that better know what they are doing,
> this API tweaking is just putting policy into the kernel  ...

Hardening drivers is kernel policy. It cannot be done anywhere else.


-Andi
