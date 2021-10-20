Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FAB435130
	for <lists+linux-arch@lfdr.de>; Wed, 20 Oct 2021 19:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhJTR2r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Oct 2021 13:28:47 -0400
Received: from mga18.intel.com ([134.134.136.126]:27405 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230031AbhJTR2r (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Oct 2021 13:28:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="215763495"
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="215763495"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 10:26:32 -0700
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="720499302"
Received: from yakasaka-mobl1.gar.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.9.165])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 10:26:29 -0700
Subject: Re: [PATCH v5 06/16] x86/tdx: Make DMA pages shared
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
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
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-7-sathyanarayanan.kuppuswamy@linux.intel.com>
 <654455db-a605-5069-d652-fe822ae066b0@amd.com>
 <66acafb6-7659-7d76-0f52-d002cfae9cc8@linux.intel.com>
 <0b06e686-b0d8-9485-ae00-b23f805916d9@amd.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <930ec8e0-669d-8501-af66-38e4cab60a1f@linux.intel.com>
Date:   Wed, 20 Oct 2021 10:26:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <0b06e686-b0d8-9485-ae00-b23f805916d9@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 10/20/21 10:22 AM, Tom Lendacky wrote:
>>
>> For non TDX case, in CC_ATTR_HOST_MEM_ENCRYPT, we should still call
>> amd_force_dma_unencrypted() right?
> 
> What I'm saying is that you wouldn't have amd_force_dma_unencrypted(). I 
> think the whole force_dma_unencrypted() can exist as-is in a different 
> file, whether that's cc_platform.c or mem_encrypt_common.c.
> 
> It will return true for an SEV or TDX guest, true for an SME host based 
> on the DMA mask or else false. That should work just fine for TDX.

Got it. Thanks for clarifying it.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
