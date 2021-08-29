Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2803FAD35
	for <lists+linux-arch@lfdr.de>; Sun, 29 Aug 2021 18:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhH2QoK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 29 Aug 2021 12:44:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:32683 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229687AbhH2QoJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 29 Aug 2021 12:44:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10091"; a="218207569"
X-IronPort-AV: E=Sophos;i="5.84,361,1620716400"; 
   d="scan'208";a="218207569"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2021 09:43:16 -0700
X-IronPort-AV: E=Sophos;i="5.84,361,1620716400"; 
   d="scan'208";a="509322544"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.238.58]) ([10.212.238.58])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2021 09:43:15 -0700
Subject: Re: [PATCH v4 11/15] pci: Add pci_iomap_shared{,_range}
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
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
References: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210805005218.2912076-12-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210823195409-mutt-send-email-mst@kernel.org>
 <26a3cce5-ddf7-cbe6-a41e-58a2aea48f78@linux.intel.com>
 <YSSay4zGjLaNMOh1@infradead.org>
 <2747d96f-5063-7c63-5a47-16ea299fa195@linux.intel.com>
 <20210829113023-mutt-send-email-mst@kernel.org>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <82e133af-6ad4-6910-8b1a-3f9e1a42a0fa@linux.intel.com>
Date:   Sun, 29 Aug 2021 09:43:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210829113023-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> All this makes sense but ioremap is such a random place to declare
> driver has been audited, and it's baked into the binary with no way for
> userspace to set policy.
>
> Again all we will end up with is gradual replacement of all ioremap
> calls with ioremap_shared as people discover a given driver does not
> work in a VM.

No the device filter will prevent that. They would need to submit 
patches to the central list.

Or they can override it at the command line, but there is already an 
option to force all ioremaps to be shared. So if you just want some 
driver to run without caring about security you can already do that 
without modifying it.

Besides the shared concept only makes sense for virtual devices, so if 
you don't have a device model for a device this will never happen either.

So I don't think your scenario of all ioremaps becoming shared will ever 
happen.


> How are you going to know driver has actually been
> audited? what the quality of the audit was? did the people doing the
> auditing understand what they are auditing for?  No way, right?

First the primary purpose of the ioremap policy is to avoid messing with 
all the legacy drivers (which is 99+% of the code base)

How to handle someone maliciously submitting a driver to the kernel is a 
completely different problem. To some degree there is trust of course. 
If someone says they audited and a maintainer trusts them with their 
statement, but they actually didn't there is a problem, but it's larger 
than just TDX. But in such a case the community code audit will also 
focus on such areas, and people interested in confidential computing 
security will also start taking a look.

And we're also working on fuzzing, so these drivers will be fuzzed at 
some point, so mistakes will be eventually found.

But in any case the ioremap policy is mainly to prevent having to handle 
this for all legacy drivers.

I would rather change the few drivers that are actually needed, than all 
the other drivers.

That's really the fundamental problem this is addressing: how to get 
reasonable security with all the legacy drivers out of the box without 
touching them.


-Andi


