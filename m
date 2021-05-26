Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79C1390FF5
	for <lists+linux-arch@lfdr.de>; Wed, 26 May 2021 07:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhEZFYo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 May 2021 01:24:44 -0400
Received: from verein.lst.de ([213.95.11.211]:33262 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229522AbhEZFYm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 May 2021 01:24:42 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 46E216736F; Wed, 26 May 2021 07:23:09 +0200 (CEST)
Date:   Wed, 26 May 2021 07:23:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guo Ren <guoren@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V3 2/2] riscv: Use use_asid_allocator flush TLB
Message-ID: <20210526052308.GA29213@lst.de>
References: <1621945447-38820-1-git-send-email-guoren@kernel.org> <1621945447-38820-3-git-send-email-guoren@kernel.org> <20210525123556.GB4842@lst.de> <CAJF2gTSa3LJKTRBv6NOvg0HtoKPL-5YyP6wY2=AJhQtAZwBBzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTSa3LJKTRBv6NOvg0HtoKPL-5YyP6wY2=AJhQtAZwBBzg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 26, 2021 at 11:12:40AM +0800, Guo Ren wrote:
> > static inline void local_flush_tlb_range_asid(unsigned long start,
> >                 unsigned long size, unsigned long asid)
> >
> > > +{
> > > +     unsigned long tmp = start & PAGE_MASK;
> > > +     unsigned long end = ALIGN(start + size, PAGE_SIZE);
> > > +
> > > +     if (size == -1) {
> > > +             __asm__ __volatile__ ("sfence.vma x0, %0" : : "r" (asid) : "memory");
> > > +             return;
> >
> > Please split the global (size == -1) case into separate helpers.
> Do you mean:

No.  Basically a

static inline void local_flush_tlb_ll_asid(unsigned long asid)
{
	__asm__ __volatile__ ("sfence.vma x0, %0"
				:
				: "r" (asid)
				: "memory");
}

and

static inline void local_flush_tlb_range_asid(unsigned long start,
		unsigned long size, unsigned long asid)

{
	unsigned long end = ALIGN(start + size, PAGE_SIZE), tmp;

	for (tmp = start & PAGE_MASK; tmp < end; tmp += PAGE_SIZE) {
		__asm__ __volatile__ ("sfence.vma %0, %1"
					:
					: "r" (tmp), "r" (asid)
					: "memory");
	}
}
