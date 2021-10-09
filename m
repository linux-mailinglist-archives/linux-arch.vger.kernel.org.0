Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D19E427574
	for <lists+linux-arch@lfdr.de>; Sat,  9 Oct 2021 03:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244041AbhJIBra (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Oct 2021 21:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbhJIBra (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Oct 2021 21:47:30 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A1BC061570;
        Fri,  8 Oct 2021 18:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=8Yhlfpn88xGUZ0D2UsU9ZR1KIwe5CGURq7DLgR1hrBY=; b=1Z6zSdy4U1cnEgkDHFifc+XY8Y
        GlewY7KjyFBbKH64naXeI41ZeCK2wzbxmLYn8tQReOLUCKAfWokngJdgXzG2kZqfZuukHe0LzGSem
        /fWn4TtGInc4xujKU9lhTWQmbcOyZPdRobBXzgyYqQiz2V+LCqXMtthT6T+ZQAyQo3oPf9aPdoOkJ
        XKCfcDJy3GwQcs5wemBALdUGapmhhOQ0Ws+MHquNKSKXMDSnM/RxQhR8WlIXhEXmTBWm/wLd+hHF0
        AGJlpBT1b3CurBjVkXBwVF3uizzCjn8R7aZLHlbBj649FMdFXEGzDXcQrpB78Kj/tCgGw8zSXNsVA
        Vnnceg4Q==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mZ1QW-004Rhr-Nh; Sat, 09 Oct 2021 01:45:28 +0000
Subject: Re: [PATCH v5 16/16] x86/tdx: Add cmdline option to force use of
 ioremap_host_shared
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
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
 <20211009003711.1390019-17-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7b4c3e3e-09e4-3bf8-6e23-77892fb6df02@infradead.org>
Date:   Fri, 8 Oct 2021 18:45:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211009003711.1390019-17-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/8/21 5:37 PM, Kuppuswamy Sathyanarayanan wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 91ba391f9b32..0af19cb1a28c 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2076,6 +2076,18 @@
>   			1 - Bypass the IOMMU for DMA.
>   			unset - Use value of CONFIG_IOMMU_DEFAULT_PASSTHROUGH.
>   
> +	ioremap_force_shared= [X86_64, CCG]
> +			Force the kernel to use shared memory mappings which do
> +			not use ioremap_host_shared/pcimap_host_shared to opt-in
> +			to shared mappings with the host. This feature is mainly
> +			used by a confidential guest when enabling new drivers
> +			without proper shared memory related changes. Please note
> +			that this option might also allow other non explicitly
> +			enabled drivers to interact with the host in confidential
> +			guest, which could cause other security risks. This option
> +			will also cause BIOS data structures to be shared with the
> +			host, which might open security holes.

Hi,
This cmdline option text should have a little bit more info. Just as an
example/template:

	acpi_apic_instance=	[ACPI, IOAPIC]
			Format: <int>
			2: use 2nd APIC table, if available
			1,0: use 1st APIC table
			default: 0

So what is expected after the "=" sign?...

thanks.
-- 
~Randy
