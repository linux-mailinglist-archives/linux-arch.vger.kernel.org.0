Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA7029A6CD
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 09:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443726AbgJ0IoX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Oct 2020 04:44:23 -0400
Received: from casper.infradead.org ([90.155.50.34]:34702 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443713AbgJ0IoX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Oct 2020 04:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jmNJLBRCFdFXQCPDsbgJxCeg7OTT63Ved9ZS239LUkg=; b=uwVkm9dZG6qemWi1SUFtrghO8y
        U61seC3CjXBZ7FVApPCnMiEXJCSFrO9lQKMTHYIfUr9Y15LQGLCcbwOtZCWWC+SkmG8RD3nregZlH
        kiitudLOmiKoSMDkcfFvPQb6jgNt7RT75k+oQZNyu0kdR4f2Y5/Vde5PI0ld2a3pmmW/WyqruPh2z
        T8hXR7Pv6ajnvlYC45xSGFziuYv/skTWwThqP5D7d4RiekvuZst5EbXOyMB9/C6jF5mLzW6eym5ay
        +pvcFFcjgZ3QmJBlfJk+JydPksRC3QWLCdZGY6t3YUAhA1biP76jRuDxsqf5e10JjDNtZKhKTEWJw
        sXCX+sHg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXKaD-0002zC-6S; Tue, 27 Oct 2020 08:43:57 +0000
Date:   Tue, 27 Oct 2020 08:43:57 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, kvm@vger.kernel.org,
        Radim Kr??m???? <rkrcmar@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Rik van Riel <riel@redhat.com>,
        Larry Woodman <lwoodman@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Toshimitsu Kani <toshi.kani@hpe.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: AMD SME encrpytion and PCI BAR pages to user space
Message-ID: <20201027084357.GA10053@infradead.org>
References: <20201019152556.GA560082@nvidia.com>
 <4b9f13bf-3f82-1aed-c7be-0eaecebc5d82@amd.com>
 <20201021115933.GS6219@nvidia.com>
 <f9c50e3a-c5de-8c85-4d6c-0e8a90729420@amd.com>
 <20201021160322.GT6219@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021160322.GT6219@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 21, 2020 at 01:03:22PM -0300, Jason Gunthorpe wrote:
> Oh, interesting.. Yes the issue is no userspace DMA stuff uses the DMA
> API correctly (because it is in userspace)
> 
> So SWIOTLB tricks don't work, I wish the dma_map could fail for these
> situations

Userspace DMA by definition also does not use dma_map..
