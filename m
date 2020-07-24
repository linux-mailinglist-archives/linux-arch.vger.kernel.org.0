Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE23722BE26
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 08:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgGXGlU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jul 2020 02:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgGXGlU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2020 02:41:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BC6C0619D3;
        Thu, 23 Jul 2020 23:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9Azj/mUx6+f5fk9NY2T38Tsh0GsS8yhWgaldDHz0tL8=; b=FNuNTItzxYtnjPlhenZldsMDjP
        UJEtFzx9eiLn0Tbo78Z+kWRU+Hwkch6CqZFZInK657N6vhC2wQoww6clvA3lkv1jAUmPRCQgGyvPq
        YKZ9vBWDPPkDM3plh+tQgac3iS+o5mT9S7WZ2isdHergByE1OO5wHxG/GdQIABZDMUHvzgl7tRMeK
        hX27fyZY0JGzFau0RCtQ7NEBlbTJnfnKL3coyrtbYsc4bLv6Ah/SmEQ7mPcgHnzHp90KgGLUpQzlH
        kzxNDVVe2h+SbL9rNVoylyyR2Q7M+R6NRLHjGhxCDikA8K+ZEVbRTDpHKowBCKdUF7w6kf1qyuTgv
        6HCNTkSA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyrOP-0002uR-Ew; Fri, 24 Jul 2020 06:41:17 +0000
Date:   Fri, 24 Jul 2020 07:41:17 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 04/20] unify generic instances of
 csum_partial_copy_nocheck()
Message-ID: <20200724064117.GA10522@infradead.org>
References: <20200724012512.GK2786714@ZenIV.linux.org.uk>
 <20200724012546.302155-1-viro@ZenIV.linux.org.uk>
 <20200724012546.302155-4-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724012546.302155-4-viro@ZenIV.linux.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 24, 2020 at 02:25:30AM +0100, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> quite a few architectures have the same csum_partial_copy_nocheck() -
> simply memcpy() the data and then return the csum of the copy.
> 
> hexagon, parisc, ia64, s390, um: explicitly spelled out that way.
> 
> arc, arm64, csky, h8300, m68k/nommu, microblaze, mips/GENERIC_CSUM, nds32,
> nios2, openrisc, riscv, unicore32: end up picking the same thing spelled
> out in lib/checksum.h (with varying amounts of perversions along the way).
> 
> everybody else (alpha, arm, c6x, m68k/mmu, mips/!GENERIC_CSUM, powerpc,
> sh, sparc, x86, xtensa) have non-generic variants.  For all except c6x
> the declaration is in their asm/checksum.h.  c6x uses the wrapper
> from asm-generic/checksum.h that would normally lead to the lib/checksum.h
> instance, but in case of c6x we end up using an asm function from arch/c6x
> instead.
> 
> Screw that mess - have architectures with private instances define
> _HAVE_ARCH_CSUM_AND_COPY in their asm/checksum.h and have the default
> one right in net/checksum.h conditional on _HAVE_ARCH_CSUM_AND_COPY
> *not* defined.

net-next has a patch from me killing off csum_and_copy_from_user
already:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=f1bfd71c8662f20d53e71ef4e18bfb0e5677c27f
