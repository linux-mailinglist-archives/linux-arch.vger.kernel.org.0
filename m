Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15BC42AC20
	for <lists+linux-arch@lfdr.de>; Tue, 12 Oct 2021 20:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbhJLSj6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Oct 2021 14:39:58 -0400
Received: from mga03.intel.com ([134.134.136.65]:46818 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234577AbhJLSj6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 Oct 2021 14:39:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="227195754"
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; 
   d="scan'208";a="227195754"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 11:37:24 -0700
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; 
   d="scan'208";a="562780711"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.115.208]) ([10.209.115.208])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 11:37:20 -0700
Message-ID: <2c9e9cdc-041c-1310-8063-115b678974d3@linux.intel.com>
Date:   Tue, 12 Oct 2021 11:37:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
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
 <YWPunfa+WK86Cgnv@infradead.org>
 <a070274e-6a3a-fb0a-68ff-d320d0729377@linux.intel.com>
 <20211011142956-mutt-send-email-mst@kernel.org>
 <YWUdpik4SP/7QlbN@infradead.org>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <YWUdpik4SP/7QlbN@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 10/11/2021 10:31 PM, Christoph Hellwig wrote:
> On Mon, Oct 11, 2021 at 03:09:09PM -0400, Michael S. Tsirkin wrote:
>> The reason we have trouble is that it's not clear what does the API mean
>> outside the realm of TDX.
>> If we really, truly want an API that says "ioremap and it's a hardened
>> driver" then I guess ioremap_hardened_driver is what you want.
> Yes.  And why would be we ioremap the BIOS anyway?  It is not I/O memory
> in any of the senses we generally use ioremap for.

I/O memory is anything outside the kernel memory map.

-Andi


