Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7601427893
	for <lists+linux-arch@lfdr.de>; Sat,  9 Oct 2021 11:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhJIJzk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 9 Oct 2021 05:55:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20749 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232146AbhJIJzk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 9 Oct 2021 05:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633773222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TC+ficJjTyhwmBtLURsKztDpUSSEvDlSazI7HDdGRfI=;
        b=cjSZUc86dmHceTLNpmvWsXr7bi1yVx+B2v6mVpNBZBSOp8aZtcH0vKkm+QKsqTqgoLtVVF
        XE5mynOhK2BzgvVtUXVkCWnt2MS6Ma/0AqIkeEZiyMIGHjDe93IRujeBW7TiGQY4RET7+D
        VzorxDcDG5x1F5jGkUXz/uWp3dT4ktI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-bz9TjC7FOmq-Np8RzQyEqA-1; Sat, 09 Oct 2021 05:53:42 -0400
X-MC-Unique: bz9TjC7FOmq-Np8RzQyEqA-1
Received: by mail-ed1-f69.google.com with SMTP id i7-20020a50d747000000b003db0225d219so11479542edj.0
        for <linux-arch@vger.kernel.org>; Sat, 09 Oct 2021 02:53:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TC+ficJjTyhwmBtLURsKztDpUSSEvDlSazI7HDdGRfI=;
        b=VMqQRgem5UMLb0fR2pAYizCIHNZwGpAb5XAqbRZDVO9EYrxWCN7ElvWetm3SDSRXKY
         yldnPF2OiXZFGdlFb0FlV1V9EDhW2IwsuegvSrk+X3GJ8RD9JQHFYlNtEI8UmEUJHrY5
         Ex/tZlYtvNseV1+B56TQQELoV+T3Ukr1P/M/fWQvGeVbZqat2QGrV2jwcW9MMD6VpUIU
         hvTa7zN9T/JscBDULgbKsbFoqptJGgVNr8dgEdTpGS2fQeUL/lwpzft6k08I2102vsQe
         bcWmvdbzNAKu3AMjr1/Bof/k/uWTv8QU7O5ak5qRDKsnq76rgQCAq3uJuuU7dG/PqPht
         GKrw==
X-Gm-Message-State: AOAM530w7bybpvv8U9gaukv/glAoOmgmMhM2xIbuGJya9tCD28svAaL0
        f9BuQHBL6cUz+u14Px4OOPaMytcjGv++X/lfZejVV3OAoXb9I0xlAXoPQL9RDbKLZUSDsjZMfro
        CYG5Ud2ZFOCc7ltcl12wwPA==
X-Received: by 2002:a17:906:2bc7:: with SMTP id n7mr10404160ejg.238.1633773220396;
        Sat, 09 Oct 2021 02:53:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxePZTE9MitFRdc70X+sthkRGYJjDyzEeDJjYhWOTmTvwwLiK4AL4UvsV8FtvbX7jf0fHnSpA==
X-Received: by 2002:a17:906:2bc7:: with SMTP id n7mr10404118ejg.238.1633773220163;
        Sat, 09 Oct 2021 02:53:40 -0700 (PDT)
Received: from redhat.com ([2.55.132.170])
        by smtp.gmail.com with ESMTPSA id rv25sm776493ejb.21.2021.10.09.02.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 02:53:39 -0700 (PDT)
Date:   Sat, 9 Oct 2021 05:53:32 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
Subject: Re: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
Message-ID: <20211009053103-mutt-send-email-mst@kernel.org>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 08, 2021 at 05:37:07PM -0700, Kuppuswamy Sathyanarayanan wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> For Confidential VM guests like TDX, the host is untrusted and hence
> the devices emulated by the host or any data coming from the host
> cannot be trusted. So the drivers that interact with the outside world
> have to be hardened by sharing memory with host on need basis
> with proper hardening fixes.
> 
> For the PCI driver case, to share the memory with the host add
> pci_iomap_host_shared() and pci_iomap_host_shared_range() APIs.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

So I proposed to make all pci mappings shared, eliminating the need
to patch drivers.

To which Andi replied
	One problem with removing the ioremap opt-in is that
	it's still possible for drivers to get at devices without going through probe.

To which Greg replied:
https://lore.kernel.org/all/YVXBNJ431YIWwZdQ@kroah.com/
	If there are in-kernel PCI drivers that do not do this, they need to be
	fixed today.

Can you guys resolve the differences here?

And once they are resolved, mention this in the commit log so
I don't get to re-read the series just to find out nothing
changed in this respect?

I frankly do not believe we are anywhere near being able to harden
an arbitrary kernel config against attack.
How about creating a defconfig that makes sense for TDX then?
Anyone deviating from that better know what they are doing,
this API tweaking is just putting policy into the kernel  ...

> ---
>  Changes since v4:
>  * Replaced "_shared" with "_host_shared" in pci_iomap* APIs
>  * Fixed commit log as per review comments.
> 
>  include/asm-generic/pci_iomap.h |  6 +++++
>  lib/pci_iomap.c                 | 47 +++++++++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/include/asm-generic/pci_iomap.h b/include/asm-generic/pci_iomap.h
> index df636c6d8e6c..a4a83c8ab3cf 100644
> --- a/include/asm-generic/pci_iomap.h
> +++ b/include/asm-generic/pci_iomap.h
> @@ -18,6 +18,12 @@ extern void __iomem *pci_iomap_range(struct pci_dev *dev, int bar,
>  extern void __iomem *pci_iomap_wc_range(struct pci_dev *dev, int bar,
>  					unsigned long offset,
>  					unsigned long maxlen);
> +extern void __iomem *pci_iomap_host_shared(struct pci_dev *dev, int bar,
> +					   unsigned long max);
> +extern void __iomem *pci_iomap_host_shared_range(struct pci_dev *dev, int bar,
> +						 unsigned long offset,
> +						 unsigned long maxlen);
> +
>  /* Create a virtual mapping cookie for a port on a given PCI device.
>   * Do not call this directly, it exists to make it easier for architectures
>   * to override */
> diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
> index 57bd92f599ee..2816dc8715da 100644
> --- a/lib/pci_iomap.c
> +++ b/lib/pci_iomap.c
> @@ -25,6 +25,11 @@ static void __iomem *map_ioremap_wc(phys_addr_t addr, size_t size)
>  	return ioremap_wc(addr, size);
>  }
>  
> +static void __iomem *map_ioremap_host_shared(phys_addr_t addr, size_t size)
> +{
> +	return ioremap_host_shared(addr, size);
> +}
> +
>  static void __iomem *pci_iomap_range_map(struct pci_dev *dev,
>  					 int bar,
>  					 unsigned long offset,
> @@ -106,6 +111,48 @@ void __iomem *pci_iomap_wc_range(struct pci_dev *dev,
>  }
>  EXPORT_SYMBOL_GPL(pci_iomap_wc_range);
>  
> +/**
> + * pci_iomap_host_shared_range - create a virtual shared mapping cookie
> + *				 for a PCI BAR
> + * @dev: PCI device that owns the BAR
> + * @bar: BAR number
> + * @offset: map memory at the given offset in BAR
> + * @maxlen: max length of the memory to map
> + *
> + * Remap a pci device's resources shared in a confidential guest.
> + * For more details see pci_iomap_range's documentation.

So how does a driver author know when to use this function, and when to
use the regular pci_iomap_range?  Drivers have no idea whether they are
used in a confidential guest, and which ranges are shared, it's a TDX
thing ...

This documentation should really address it.

> + *
> + * @maxlen specifies the maximum length to map. To get access to
> + * the complete BAR from offset to the end, pass %0 here.
> + */
> +void __iomem *pci_iomap_host_shared_range(struct pci_dev *dev, int bar,
> +					  unsigned long offset,
> +					  unsigned long maxlen)
> +{
> +	return pci_iomap_range_map(dev, bar, offset, maxlen,
> +				   map_ioremap_host_shared, true);
> +}
> +EXPORT_SYMBOL_GPL(pci_iomap_host_shared_range);
> +
> +/**
> + * pci_iomap_host_shared - create a virtual shared mapping cookie for a PCI BAR
> + * @dev: PCI device that owns the BAR
> + * @bar: BAR number
> + * @maxlen: length of the memory to map
> + *
> + * See pci_iomap for details. This function creates a shared mapping
> + * with the host for confidential hosts.
> + *
> + * @maxlen specifies the maximum length to map. To get access to the
> + * complete BAR without checking for its length first, pass %0 here.
> + */
> +void __iomem *pci_iomap_host_shared(struct pci_dev *dev, int bar,
> +			       unsigned long maxlen)
> +{
> +	return pci_iomap_host_shared_range(dev, bar, 0, maxlen);
> +}
> +EXPORT_SYMBOL_GPL(pci_iomap_host_shared);
> +
>  /**
>   * pci_iomap - create a virtual mapping cookie for a PCI BAR
>   * @dev: PCI device that owns the BAR
> -- 
> 2.25.1

