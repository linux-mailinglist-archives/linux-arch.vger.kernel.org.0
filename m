Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5FF53EB247
	for <lists+linux-arch@lfdr.de>; Fri, 13 Aug 2021 10:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239702AbhHMIIW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Aug 2021 04:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239501AbhHMIIV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Aug 2021 04:08:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325F6C061756;
        Fri, 13 Aug 2021 01:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9uWCFAcyzkVj8no+O0RsCmvXvpv4eWhAb7u9P+Jl+OQ=; b=skolZA0941a9vaUZQjHgRhvFcO
        noo8dvQYNH3YQWFixE/g/Oqa0E5fFrhuFY22BTP1ffQxL+CNHP3+pHRxDfAlVhQ1fjeZbFhxBcpFp
        wguhbgaYjMXpFIksAmp5LLR34Bfvu840nTRaHX7sAu689DUOBFyLy6SaM8o0/T+3+ZeRBghm9amva
        eMhPxO+xayDbhuWM0HqeF/rr4O+zadv8uSge/qRFcOrDWv941ztngfG+iSJ1dDMyEbANHNMVB4SLu
        b3YC3dA4pdD9r6/MVNO8rYpYYOTmD+3S1UWQ8hFCQ9g6dyDKijDHeZ0XZdzjIRPY8qpoGora5iFkn
        kATt0VhQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mES9E-00FTGj-HZ; Fri, 13 Aug 2021 08:02:49 +0000
Date:   Fri, 13 Aug 2021 09:02:36 +0100
From:   Christoph Hellwig <hch@infradead.org>
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
Subject: Re: [PATCH v4 11/15] pci: Add pci_iomap_shared{,_range}
Message-ID: <YRYnHNOSeS/kQW2H@infradead.org>
References: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210805005218.2912076-12-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805005218.2912076-12-sathyanarayanan.kuppuswamy@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 04, 2021 at 05:52:14PM -0700, Kuppuswamy Sathyanarayanan wrote:
> +extern void __iomem *pci_iomap_shared(struct pci_dev *dev, int bar,
> +				      unsigned long max);
> +extern void __iomem *pci_iomap_shared_range(struct pci_dev *dev, int bar,
> +					    unsigned long offset,
> +					    unsigned long maxlen);

No need for externs here.

> +/**
> + * pci_iomap_shared_range - create a virtual shared mapping cookie for a
> + *                          PCI BAR

This reads like completely garbage from a markow chain.
