Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FFB4295AE
	for <lists+linux-arch@lfdr.de>; Mon, 11 Oct 2021 19:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhJKRe0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Oct 2021 13:34:26 -0400
Received: from mga09.intel.com ([134.134.136.24]:18841 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229816AbhJKReZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 11 Oct 2021 13:34:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10134"; a="226828714"
X-IronPort-AV: E=Sophos;i="5.85,365,1624345200"; 
   d="scan'208";a="226828714"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 10:32:24 -0700
X-IronPort-AV: E=Sophos;i="5.85,365,1624345200"; 
   d="scan'208";a="440884638"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.255.229.69]) ([10.255.229.69])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 10:32:23 -0700
Message-ID: <78766e28-8353-acc8-19e2-033d4bbf3472@linux.intel.com>
Date:   Mon, 11 Oct 2021 10:32:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
Content-Language: en-US
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
 <cec62ebb-87d7-d725-1096-2c97c5eedbc3@linux.intel.com>
 <20211011073614-mutt-send-email-mst@kernel.org>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <20211011073614-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> Because it does not end with I/O operations, that's a trivial example.
> module unloading is famous for being racy: I just re-read that part of
> virtio drivers and sure enough we have bugs there, this is after
> they have presumably been audited, so a TDX guest is better off
> just disabling hot-unplug completely, and hotplug isn't far behind.

These all shouldn't matter for a confidential guest. The only way it can 
be attacked is through IO, everything else is protected by hardware.


Also it would all require doing something at the guest level, which we 
assume is not malicious.


> Malicious filesystems can exploit many linux systems unless
> you take pains to limit what is mounted and how.

That's expected to be handled by authenticated dmcrypt and similar. 
Hardening at this level has been done for many years.


> Networking devices tend to get into the default namespaces and can
> do more or less whatever CAP_NET_ADMIN can.
> Etc.


Networking should be already hardened, otherwise you would have much 
worse problems today.



> hange in your subsystem here.
> Well I commented on the API patch, not the virtio patch.
> If it's a way for a driver to say "I am hardened
> and audited" then I guess it should at least say so.


This is handled by the central allow list. We intentionally didn't want 
each driver to declare itself, but have a central list where changes 
will get more scrutiny than random driver code.

But then there are the additional opt-ins for the low level firewall. 
These are in the API. I don't see how it could be done at the driver 
level, unless you want to pass in a struct device everywhere?

>>> How about creating a defconfig that makes sense for TDX then?
>> TDX can be used in many different ways, I don't think a defconfig is
>> practical.
>>
>> In theory you could do some Kconfig dependency (at the pain point of having
>> separate kernel binariees), but why not just do it at run time then if you
>> maintain the list anyways. That's much easier and saner for everyone. In the
>> past we usually always ended up with runtime mechanism for similar things
>> anyways.
>>
>> Also it turns out that the filter mechanisms are needed for some arch
>> drivers which are not even configurable, so alone it's probably not enough,
>
> I guess they aren't really needed though right, or you won't try to
> filter them?

We're addressing most of them with the device filter for platform 
drivers. But since we cannot stop them doing ioremap IO in their init 
code they also need the low level firewall.

Some others that cannot be addressed have explicit disables.


> So make them configurable?

Why not just fix the runtime? It's much saner for everyone. Proposing to 
do things at build time sounds like we're in Linux 0.99 days.

-Andi

