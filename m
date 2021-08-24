Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626043F6524
	for <lists+linux-arch@lfdr.de>; Tue, 24 Aug 2021 19:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238781AbhHXRKb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Aug 2021 13:10:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:34909 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238870AbhHXRIw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Aug 2021 13:08:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="196931983"
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="196931983"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 10:04:29 -0700
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="526698792"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.119.65]) ([10.209.119.65])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 10:04:27 -0700
Subject: Re: [PATCH v4 11/15] pci: Add pci_iomap_shared{,_range}
To:     Christoph Hellwig <hch@infradead.org>,
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
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <2747d96f-5063-7c63-5a47-16ea299fa195@linux.intel.com>
Date:   Tue, 24 Aug 2021 10:04:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YSSay4zGjLaNMOh1@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 8/24/2021 12:07 AM, Christoph Hellwig wrote:
> On Mon, Aug 23, 2021 at 05:30:54PM -0700, Kuppuswamy, Sathyanarayanan wrote:
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
> Well, assuming the host can do any damage when mapped shared that also
> means not mapping it shared will completely break the drivers.

There are several cases:

- We have driver filtering active to protect you against attacks from 
the host against unhardened drivers.

In this case the drivers not working is the intended behavior.

- There is an command allow list override for some new driver, but the 
driver is hardened and shared

The other drivers will still not work, but that's also the intended behavior

- Driver filtering is disabled or the allow list override is used to 
enable some non hardened/enabled driver

There is a command line option to override the ioremap sharing default, 
it will allow all drivers to do ioremap. We would really prefer to make 
it more finegrained, but it's not possible in this case. Other drivers 
are likely attackable.

- Driver filtering is disabled (allowing attacks on the drivers) and the 
command line option for forced sharing is set.

All drivers initialize and can talk to the host through MMIO. Lots of 
unhardened drivers are likely attackable.

-Andi

