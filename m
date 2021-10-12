Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F3842AC34
	for <lists+linux-arch@lfdr.de>; Tue, 12 Oct 2021 20:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbhJLSlN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Oct 2021 14:41:13 -0400
Received: from mga07.intel.com ([134.134.136.100]:3810 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234738AbhJLSlN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 Oct 2021 14:41:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="290731356"
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; 
   d="scan'208";a="290731356"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 11:38:55 -0700
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; 
   d="scan'208";a="562781011"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.115.208]) ([10.209.115.208])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 11:38:53 -0700
Message-ID: <f850d2d6-d427-8aeb-bd38-f9b5eb088191@linux.intel.com>
Date:   Tue, 12 Oct 2021 11:38:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
Content-Language: en-US
To:     "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
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
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053103-mutt-send-email-mst@kernel.org>
 <CAPcyv4hDhjRXYCX_aiOboLF0eaTo6VySbZDa5NQu2ed9Ty2Ekw@mail.gmail.com>
 <0e6664ac-cbb2-96ff-0106-9301735c0836@linux.intel.com>
 <DM8PR11MB57501C8F8F5C8B315726882EE7B69@DM8PR11MB5750.namprd11.prod.outlook.com>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <DM8PR11MB57501C8F8F5C8B315726882EE7B69@DM8PR11MB5750.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 10/12/2021 11:36 AM, Reshetova, Elena wrote:
>> The 5.15 tree has something like ~2.4k IO accesses (including MMIO and
>> others) in init functions that also register drivers (thanks Elena for
>> the number)
> To provide more numbers on this. What I can see so far from a smatch-based
> analysis, we have 409 __init style functions (.probe & builtin/module_
> _platform_driver_probe excluded) for 5.15 with allyesconfig. The number of
> distinct individual IO reads (MSRs included) is much higher than 2.4k and on the
> range of 30k because quite often there are more than a single IO read in the
> same source function. The full list of accesses and the possible call paths is huge
> for manually looking at, but here is the list of the 409 functions if anyone wants
> to take a look:


Thanks Elena.


I suspect the true number is even higher because that doesn't include IO 
inside calls to other modules and indirect pointers, correct?


-Andi

