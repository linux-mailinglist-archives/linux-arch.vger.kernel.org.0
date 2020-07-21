Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692C6227805
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 07:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgGUFU0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 01:20:26 -0400
Received: from verein.lst.de ([213.95.11.211]:50550 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgGUFU0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Jul 2020 01:20:26 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 849376736F; Tue, 21 Jul 2020 07:20:22 +0200 (CEST)
Date:   Tue, 21 Jul 2020 07:20:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] syscalls: use uaccess_kernel in
 addr_limit_user_check
Message-ID: <20200721052022.GA10011@lst.de>
References: <20200714105505.935079-1-hch@lst.de> <20200714105505.935079-2-hch@lst.de> <20200718013849.GA157764@roeck-us.net> <20200718094846.GA8593@lst.de> <20200720221046.GA86726@roeck-us.net> <20200721045834.GA9613@lst.de> <eb470677-b569-a6f0-e63b-60149b54863a@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb470677-b569-a6f0-e63b-60149b54863a@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 20, 2020 at 10:15:37PM -0700, Guenter Roeck wrote:
> >> -       if (CHECK_DATA_CORRUPTION(uaccess_kernel(),
> >> +       if (CHECK_DATA_CORRUPTION(!uaccess_kernel(),
> >>
> >> How does this work anywhere ?
> > 
> > No, that is the wrong check - we want to make sure the address
> > space override doesn't leak to userspace.  The problem is that
> > armnommu (and m68knommu, but that doesn't call the offending
> > function) pretends to not have a kernel address space, which doesn't
> > really work.  Here is the fix I sent out yesterday, which I should
> > have Cc'ed you on, sorry:
> > 
> 
> The patch below makes sense, and it does work, but I still suspect
> that something with your original patch is wrong, or at least suspicious.
> Reason: My change above (Adding the "!") works for _all_ of my arm boot
> tests. Or, in other words, it doesn't make a difference if true
> or false is passed as first parameter of CHECK_DATA_CORRUPTION(), except
> for nommu systems. Also, unless I am really missing something, your
> original patch _does_ reverse the logic.

Well.  segment_eq is in current mainline used in two places:

 1) to implement uaccess_kernel
 2) in addr_limit_user_check to implement uaccess_kernel-like
    semantics using a strange reverse notation

I think the explanation for your observation is how addr_limit_user_check
is called on arm.  The addr_limit_check_failed wrapper for it is called
from assembly code, but only after already checking the addr_limit,
basically duplicating the segment_eq check.  So for mmu builds it won't
get called unless we leak the kernel address space override, which
is a pretty fatal error and won't show up in your boot tests.  The
only good way to test it is by explicit injecting it using the
lkdtm module.
