Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D678F428403
	for <lists+linux-arch@lfdr.de>; Mon, 11 Oct 2021 00:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbhJJWNY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 10 Oct 2021 18:13:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:49214 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231343AbhJJWNY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 10 Oct 2021 18:13:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10133"; a="224178252"
X-IronPort-AV: E=Sophos;i="5.85,363,1624345200"; 
   d="scan'208";a="224178252"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2021 15:11:25 -0700
X-IronPort-AV: E=Sophos;i="5.85,363,1624345200"; 
   d="scan'208";a="459743239"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.83.75]) ([10.209.83.75])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2021 15:11:24 -0700
Message-ID: <0e6664ac-cbb2-96ff-0106-9301735c0836@linux.intel.com>
Date:   Sun, 10 Oct 2021 15:11:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
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
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053103-mutt-send-email-mst@kernel.org>
 <CAPcyv4hDhjRXYCX_aiOboLF0eaTo6VySbZDa5NQu2ed9Ty2Ekw@mail.gmail.com>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <CAPcyv4hDhjRXYCX_aiOboLF0eaTo6VySbZDa5NQu2ed9Ty2Ekw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 10/9/2021 1:39 PM, Dan Williams wrote:
> On Sat, Oct 9, 2021 at 2:53 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>> On Fri, Oct 08, 2021 at 05:37:07PM -0700, Kuppuswamy Sathyanarayanan wrote:
>>> From: Andi Kleen <ak@linux.intel.com>
>>>
>>> For Confidential VM guests like TDX, the host is untrusted and hence
>>> the devices emulated by the host or any data coming from the host
>>> cannot be trusted. So the drivers that interact with the outside world
>>> have to be hardened by sharing memory with host on need basis
>>> with proper hardening fixes.
>>>
>>> For the PCI driver case, to share the memory with the host add
>>> pci_iomap_host_shared() and pci_iomap_host_shared_range() APIs.
>>>
>>> Signed-off-by: Andi Kleen <ak@linux.intel.com>
>>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> So I proposed to make all pci mappings shared, eliminating the need
>> to patch drivers.
>>
>> To which Andi replied
>>          One problem with removing the ioremap opt-in is that
>>          it's still possible for drivers to get at devices without going through probe.
>>
>> To which Greg replied:
>> https://lore.kernel.org/all/YVXBNJ431YIWwZdQ@kroah.com/
>>          If there are in-kernel PCI drivers that do not do this, they need to be
>>          fixed today.
>>
>> Can you guys resolve the differences here?
> I agree with you and Greg here. If a driver is accessing hardware
> resources outside of the bind lifetime of one of the devices it
> supports, and in a way that neither modrobe-policy nor
> device-authorization -policy infrastructure can block, that sounds
> like a bug report.

The 5.15 tree has something like ~2.4k IO accesses (including MMIO and 
others) in init functions that also register drivers (thanks Elena for 
the number)

Some are probably old drivers that could be fixed, but it's quite a few 
legitimate cases. For example for platform or ISA drivers that's the 
only way they can be implemented because they often have no other 
enumeration mechanism. For PCI drivers it's rarer, but also still can 
happen. One example that comes to mind here is the x86 Intel uncore 
drivers, which support a mix of MSR, ioremap and PCI config space 
accesses all from the same driver. This particular example can (and 
should be) fixed in other ways, but similar things also happen in other 
drivers, and they're not all broken. Even for the broken ones they're 
usually for some crufty old devices that has very few users, so it's 
likely untestable in practice.

My point is just that the ecosystem of devices that Linux supports is 
messy enough that there are legitimate exceptions from the "First IO 
only in probe call only" rule.

And we can't just fix them all. Even if we could it would be hard to 
maintain.

Using a "firewall model" hooking into a few strategic points like we're 
proposing here is much saner for everyone.

Now we can argue about the details. Right now what we're proposing has 
some redundancies: it has both a device model filter and low level 
filter for ioremap (this patch and some others). The low level filter is 
for catching issues that don't clearly fit into the 
"enumeration<->probe" model. You could call that redundant, but I would 
call it defense in depth or better safe than sorry. In theory it would 
be enough to have the low level opt-in only, but that would have the 
drawback that is something gets enumerated after all you would have all 
kind of weird device driver failures and in some cases even killed 
guests. So I think it makes sense to have


> Fix those drivers instead of sprinkling
> ioremap_shared in select places and with unclear rules about when a
> driver is allowed to do "shared" mappings.

Only add it when the driver has been audited and hardened.

But I agree we need on a documented process for this. I will work on 
some documentation for a proposal. But essentially I think it should be 
some variant of what Elena has outlined in her talk at Security Summit.

https://static.sched.com/hosted_files/lssna2021/b6/LSS-HardeningLinuxGuestForCCC.pdf

That is using extra auditing/scrutiny at review time, supported with 
some static code analysis that points to the interaction points, and 
code needs to be fuzzed explicitly.

However short term it's only three virtio drivers, so this is not a 
urgent problem.

> Let the new
> device-authorization mechanism (with policy in userspace)


Default policy in user space just seems to be a bad idea here. Who 
should know if a driver is hardened other than the kernel? Maintaining 
the list somewhere else just doesn't make sense to me.

Also there is the more practical problem that some devices are needed 
for booting. For example in TDX we can't print something to the console 
with this mechanism, so you would never get any output before the 
initrd. Just seems like a nightmare for debugging anything. There really 
needs to be an authorization mechanism that works reasonably early.

I can see a point of having user space overrides though, but we need to 
have a sane kernel default that works early.

-Andi
