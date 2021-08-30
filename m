Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D833FB0B4
	for <lists+linux-arch@lfdr.de>; Mon, 30 Aug 2021 07:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhH3FMm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Aug 2021 01:12:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:7792 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230191AbhH3FMm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Aug 2021 01:12:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10091"; a="217926786"
X-IronPort-AV: E=Sophos;i="5.84,362,1620716400"; 
   d="scan'208";a="217926786"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2021 22:11:48 -0700
X-IronPort-AV: E=Sophos;i="5.84,362,1620716400"; 
   d="scan'208";a="497257549"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.238.58]) ([10.212.238.58])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2021 22:11:47 -0700
Subject: Re: [PATCH v4 11/15] pci: Add pci_iomap_shared{,_range}
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
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
        virtualization@lists.linux-foundation.org
References: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210805005218.2912076-12-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210823195409-mutt-send-email-mst@kernel.org>
 <26a3cce5-ddf7-cbe6-a41e-58a2aea48f78@linux.intel.com>
 <CAPcyv4iJVQKJ3bVwZhD08c8GNEP0jW2gx=H504NXcYK5o2t01A@mail.gmail.com>
 <d992b5af-8d57-6aa6-bd49-8e2b8d832b19@linux.intel.com>
 <20210824053830-mutt-send-email-mst@kernel.org>
 <d21a2a2d-4670-ba85-ce9a-fc8ea80ef1be@linux.intel.com>
 <20210829112105-mutt-send-email-mst@kernel.org>
 <09b340dd-c8a8-689c-4dad-4fe0e36d39ae@linux.intel.com>
 <20210829181635-mutt-send-email-mst@kernel.org>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <3a88a255-a528-b00a-912b-e71198d5f58f@linux.intel.com>
Date:   Sun, 29 Aug 2021 22:11:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210829181635-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 8/29/2021 3:26 PM, Michael S. Tsirkin wrote:
> On Sun, Aug 29, 2021 at 09:17:53AM -0700, Andi Kleen wrote:
>> Also I changing this single call really that bad? It's not that we changing
>> anything drastic here, just give the low level subsystem a better hint about
>> the intention. If you don't like the function name, could make it an
>> argument instead?
> My point however is that the API should say that the
> driver has been audited,

We have that status in the struct device. If you want to tie the ioremap 
to that we could define a ioremap_device() with a device argument and 
decide based on that.

Or we can add _audited to the name. ioremap_shared_audited?

> not that the mapping has been
> done in some special way. For example the mapping can be
> in some kind of wrapper, not directly in the driver.
> However you want the driver validated, not the wrapper.
>
> Here's an idea:


I don't think magic differences of API behavior based on some define are 
a good idea.  That's easy to miss.

That's a "COME FROM" in API design.

Also it wouldn't handle the case that a driver has both private and 
shared ioremaps, e.g. for BIOS structures.

And we've been avoiding that drivers can self declare auditing, we've 
been trying to have a separate centralized list so that it's easier to 
enforce and avoids any cut'n'paste mistakes.

-Andi

