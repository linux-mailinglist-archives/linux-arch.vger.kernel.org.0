Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D2A38FDF6
	for <lists+linux-arch@lfdr.de>; Tue, 25 May 2021 11:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhEYJhF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 May 2021 05:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhEYJhF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 May 2021 05:37:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E9AC061574;
        Tue, 25 May 2021 02:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=77alA0oNaOdxO9Nn5XAmzEZ6uOPGgpzTh0etFfYrlAM=; b=CJtzWCtnRisoGTNMJQCQYaQgVp
        ZVGRtAAqogEkkwH9F9sBAGoaUIJqf8hyB4tWDL7yuZj/sqQh0U+BWtvZWmQGjuMN34YGl+CVRhKqY
        SpUjecHol9ErWniyWlQeiZ55SyQ6f5qUrCbAB5OfKHdCF0QtETh17x5xH9Cm8rZZgktR5YKtOhTaY
        BAo+VxbRlblic7Pi6monzUyPO9BA4KI29sePHIRFeDpFieohokdd8OHlD/lC11YmnpM9AjF2UhJvK
        mi4DXoLwyN6+LX4/ewdxrfmy4NRfdBhlIaoT1r8+VKmnGA1IUj76nNdLFH4YSTQJZb4oPpyYKmINK
        b2mPNq0A==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1llTSP-003LFb-Qx; Tue, 25 May 2021 09:34:52 +0000
Date:   Tue, 25 May 2021 10:34:37 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH 2/3] riscv: Fixup PAGE_UP in asm/page.h
Message-ID: <YKzErU3lpFO58hkY@infradead.org>
References: <1621839068-31738-1-git-send-email-guoren@kernel.org>
 <1621839068-31738-2-git-send-email-guoren@kernel.org>
 <YKyae+8O25A8vxMS@infradead.org>
 <CAJF2gTRA=tUid7akgVXfk6MHOd0KmJpDQEZ2m9wRfhigBDzQTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTRA=tUid7akgVXfk6MHOd0KmJpDQEZ2m9wRfhigBDzQTw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 25, 2021 at 05:28:21PM +0800, Guo Ren wrote:
> On Tue, May 25, 2021 at 2:34 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Mon, May 24, 2021 at 06:51:07AM +0000, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > Current PAGE_UP implementation is wrong. PAGE_UP(0) should be
> > > 0x1000, but current implementation will give out 0.
> > >
> > > Although the current PAGE_UP isn't used, it will soon be used in
> > > tlb_flush optimization.
> >
> > Nak.  Please just remove the PAGE_UP/PAGE_DOWN macros just like they
> > have been removed from other architectures long ago and use the
> > generic DIV_ROUND_UP macro for your new code like everyone else.
> 
> This patch has been dropped because it's wrong, ref Anup's reply.
> 
> Remove PAGE_UP/DOWN is okay for me. How about:
>  static inline void local_flush_tlb_range_asid(unsigned long start,
> unsigned long size,
>                                               unsigned long asid)
>  {
> -       unsigned long page_add = PAGE_DOWN(start);
> -       unsigned long page_end = PAGE_UP(start + size);
> +       unsigned long page_add = _ALIGN_DOWN(start, PAGE_SIZE);
> +       unsigned long page_end = _ALIGN_UP(start + size, PAGE_SIZE);
> 
> _ALIGN_XXX are also defined in arch/riscv/include/asm/page.h.

And these also are leftovers from days gone by and should be removed.

I think this should simply be:

	
	unsigned long page_add = start & PAGE_MASK;
	unsigned long page_end = PAGE_ALIGN(start + size);

(and page_add is a pretty horrible name as well..)
