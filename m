Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C88D3EAD2A
	for <lists+linux-arch@lfdr.de>; Fri, 13 Aug 2021 00:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236910AbhHLWaM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Aug 2021 18:30:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:42422 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231392AbhHLWaM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Aug 2021 18:30:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="215191292"
X-IronPort-AV: E=Sophos;i="5.84,317,1620716400"; 
   d="scan'208";a="215191292"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 15:29:46 -0700
X-IronPort-AV: E=Sophos;i="5.84,317,1620716400"; 
   d="scan'208";a="517642404"
Received: from smachee-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.213.169.15])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 15:29:45 -0700
Subject: Re: [PATCH v4 09/15] pci: Consolidate pci_iomap* and pci_iomap*wc
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        James E J Bottomley <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20210812194330.GA2500473@bjorn-Precision-5520>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <fbce6e80-07e3-8b95-dff6-1ade6be58b29@linux.intel.com>
Date:   Thu, 12 Aug 2021 15:29:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210812194330.GA2500473@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 8/12/21 12:43 PM, Bjorn Helgaas wrote:
> Is there a branch with all of this applied?  I was going to apply this

Its is maintained in following tree.

https://github.com/intel/tdx/commit/93fd5b655172ba9e3350487995102a8b2c41de27

> to help take a look at it, but it doesn't apply to v5.14-rc1.  I know

This patch can be applied independently. I have just applied it on top
of v5.14-rc5, and it seems to apply clean. Can you try -rc5?

> you listed some prereqs in the cover letter, but it's a fair amount of
> work to sort all that out.
> 
> On Wed, Aug 04, 2021 at 05:52:12PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> From: Andi Kleen <ak@linux.intel.com>
> 
> If I were applying these, I would silently update the subject lines to
> match previous commits.  Since these will probably be merged via a
> different tree, you can update if there's a v5:
> 
>    PCI: Consolidate pci_iomap_range(), pci_iomap_wc_range()

Yes. I will fix this in next version.

> 
> Also applies to 11/15 and 12/15.

Will do the same.

> 
>> pci_iomap* and pci_iomap*wc are currently duplicated code, except
>> that the _wc variant does not support IO ports. Replace them
>> with a common helper and a callback for the mapping. I used
>> wrappers for the maps because some architectures implement ioremap
>> and friends with macros.
> 
> Maybe spell some of this out:
> 
>    pci_iomap_range() and pci_iomap_wc_range() are currently duplicated
>    code, ...  Implement them using a common helper,
>    pci_iomap_range_map(), ...
> 
> Using "pci_iomap*" obscures the name and doesn't save any space.
> 
> Why is it safe to make pci_iomap_wc_range() support IO ports when it
> didn't before?  That might be desirable, but I think it *is* a
> functional change here.

Agree. Commit log had to be updated. I will include these details
in next submission.

> 
> IIUC, pci_iomap_wc_range() on an IO port range previously returned
> NULL, and after this patch it will work the same as pci_iomap_range(),
> i.e., it will return the result of __pci_ioport_map().
> 
>> This will allow to add more variants without excessive code
>> duplications. This patch should have no behavior change.
>>
>> Signed-off-by: Andi Kleen <ak@linux.intel.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>   lib/pci_iomap.c | 81 +++++++++++++++++++++++++++----------------------
>>   1 file changed, 44 insertions(+), 37 deletions(-)
>>


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
