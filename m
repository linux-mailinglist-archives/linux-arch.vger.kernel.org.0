Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AED43F6A40
	for <lists+linux-arch@lfdr.de>; Tue, 24 Aug 2021 22:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbhHXUOw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Aug 2021 16:14:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:27696 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232099AbhHXUOv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Aug 2021 16:14:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="217426630"
X-IronPort-AV: E=Sophos;i="5.84,348,1620716400"; 
   d="scan'208";a="217426630"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 13:14:05 -0700
X-IronPort-AV: E=Sophos;i="5.84,348,1620716400"; 
   d="scan'208";a="526813111"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.119.65]) ([10.209.119.65])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 13:14:03 -0700
Subject: Re: [PATCH v4 11/15] pci: Add pci_iomap_shared{,_range}
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
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
        virtualization@lists.linux-foundation.org,
        Rajat Jain <rajatja@google.com>
References: <20210824185541.GA3485816@bjorn-Precision-5520>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <a80fc61a-bc55-b82c-354b-b57863ab03db@linux.intel.com>
Date:   Tue, 24 Aug 2021 13:14:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210824185541.GA3485816@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 8/24/2021 11:55 AM, Bjorn Helgaas wrote:
> [+cc Rajat; I still don't know what "shared memory with a hypervisor
> in a confidential guest" means,

A confidential guest is a guest which uses memory encryption to isolate 
itself from the host. It doesn't trust the host. But it still needs to 
communicate with the host for IO, so it has some special memory areas 
that are explicitly marked shared. These are used to do IO with the 
host. All their usage needs to be carefully hardened to avoid any 
security attacks on the guest, that's why we want to limit this 
interaction only to a small set of hardened drivers. For MMIO, the set 
is currently only virtio and MSI-X.

-Andi


