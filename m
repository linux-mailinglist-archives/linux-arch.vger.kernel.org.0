Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA95B3F55B7
	for <lists+linux-arch@lfdr.de>; Tue, 24 Aug 2021 04:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbhHXCPF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Aug 2021 22:15:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:9375 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233145AbhHXCPE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 23 Aug 2021 22:15:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10085"; a="214093547"
X-IronPort-AV: E=Sophos;i="5.84,346,1620716400"; 
   d="scan'208";a="214093547"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 19:14:20 -0700
X-IronPort-AV: E=Sophos;i="5.84,346,1620716400"; 
   d="scan'208";a="425944647"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.255.228.210]) ([10.255.228.210])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 19:14:19 -0700
Subject: Re: [PATCH v4 11/15] pci: Add pci_iomap_shared{,_range}
To:     Dan Williams <dan.j.williams@intel.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
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
        virtualization@lists.linux-foundation.org
References: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210805005218.2912076-12-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210823195409-mutt-send-email-mst@kernel.org>
 <26a3cce5-ddf7-cbe6-a41e-58a2aea48f78@linux.intel.com>
 <CAPcyv4iJVQKJ3bVwZhD08c8GNEP0jW2gx=H504NXcYK5o2t01A@mail.gmail.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <d992b5af-8d57-6aa6-bd49-8e2b8d832b19@linux.intel.com>
Date:   Mon, 23 Aug 2021 19:14:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4iJVQKJ3bVwZhD08c8GNEP0jW2gx=H504NXcYK5o2t01A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 8/23/2021 6:04 PM, Dan Williams wrote:
> On Mon, Aug 23, 2021 at 5:31 PM Kuppuswamy, Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>
>>
>> On 8/23/21 4:56 PM, Michael S. Tsirkin wrote:
>>>> Add a new variant of pci_iomap for mapping all PCI resources
>>>> of a devices as shared memory with a hypervisor in a confidential
>>>> guest.
>>>>
>>>> Signed-off-by: Andi Kleen<ak@linux.intel.com>
>>>> Signed-off-by: Kuppuswamy Sathyanarayanan<sathyanarayanan.kuppuswamy@linux.intel.com>
>>> I'm a bit puzzled by this part. So why should the guest*not*  map
>>> pci memory as shared? And if the answer is never (as it seems to be)
>>> then why not just make regular pci_iomap DTRT?
>> It is in the context of confidential guest (where VMM is un-trusted). So
>> we don't want to make all PCI resource as shared. It should be allowed
>> only for hardened drivers/devices.
> That's confusing, isn't device authorization what keeps unaudited
> drivers from loading against untrusted devices? I'm feeling like
> Michael that this should be a detail that drivers need not care about
> explicitly, in which case it does not need to be exported because the
> detail can be buried in lower levels.

We originally made it default (similar to AMD), but it during code audit 
we found a lot of drivers who do ioremap early outside the probe 
function. Since it would be difficult to change them all we made it 
opt-in, which ensures that only drivers that have been enabled can talk 
with the host at all and can't be attacked. That made the problem of 
hardening all these drivers a lot more practical.

Currently we only really need virtio and MSI-X shared, so for changing 
two places in the tree you avoid a lot of headache elsewhere.

Note there is still a command line option to override if you want to 
allow and load other drivers.

-Andi

