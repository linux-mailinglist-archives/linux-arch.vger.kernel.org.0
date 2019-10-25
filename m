Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82851E5535
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2019 22:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfJYUdc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Oct 2019 16:33:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728514AbfJYUdc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 25 Oct 2019 16:33:32 -0400
Received: from rapoport-lnx (unknown [87.70.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F0C9205F4;
        Fri, 25 Oct 2019 20:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572035611;
        bh=+V3MYXgziPOZllvPaeN2wWalwWrmuc8yiZofvYCWoNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1ISSeESRZG09GzO0p+0h+u/Da++xXbkOcsQ5mlswN8E+JmDJy8i2vG7sk1XtBAlth
         O+JkATp4aZZ6UwRybaJhjTl0dq8o88pCslQd7+isc/kOjQ3j0a42WMTbSUrvr9icVT
         /jJxJNBEQReX2euA+K+z//obJVLa7yxkT+K4iwqU=
Date:   Fri, 25 Oct 2019 23:33:19 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Michal Simek <monstr@monstr.eu>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jeff Dike <jdike@addtoit.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Sam Creasey <sammy@sammy.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-parisc@vger.kernel.org, linux-um@lists.infradead.org,
        sparclinux@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 06/12] microblaze: use pgtable-nopmd instead of
 4level-fixup
Message-ID: <20191025203318.GA8413@rapoport-lnx>
References: <1571822941-29776-1-git-send-email-rppt@kernel.org>
 <1571822941-29776-7-git-send-email-rppt@kernel.org>
 <aa7df5a1-5022-bc82-8816-74c956e2fd90@monstr.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa7df5a1-5022-bc82-8816-74c956e2fd90@monstr.eu>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 25, 2019 at 10:24:30AM +0200, Michal Simek wrote:
> Hi Mike,
> 
> On 23. 10. 19 11:28, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > microblaze has only two-level page tables and can use pgtable-nopmd and
> > folding of the upper layers.
> > 
> > Replace usage of include/asm-generic/4level-fixup.h and explicit definition
> > of __PAGETABLE_PMD_FOLDED in microblaze with
> > include/asm-generic/pgtable-nopmd.h and adjust page table manipulation
> > macros and functions accordingly.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  arch/microblaze/include/asm/page.h    |  3 ---
> >  arch/microblaze/include/asm/pgalloc.h | 16 ----------------
> >  arch/microblaze/include/asm/pgtable.h | 32 ++------------------------------
> >  arch/microblaze/kernel/signal.c       | 10 +++++++---
> >  arch/microblaze/mm/init.c             |  7 +++++--
> >  arch/microblaze/mm/pgtable.c          | 13 +++++++++++--
> >  6 files changed, 25 insertions(+), 56 deletions(-)
> 
> I have take a look at this and when this is applied on the top of
> 5.4-rc2 there is not a problem.
> But as was reported by 0-day there is compilation issue on the top of
> mmotm/master tree and I am able to replicate it.
> It means there are other changes in Andrew's tree which are causing it.

0day is still using an old tree for mmotm:

> url:    https://github.com/0day-ci/linux/commits/Mike-Rapoport/mm-remove-__ARCH_HAS_4LEVEL_HACK/20191025-063009
> base:   git://git.cmpxchg.org/linux-mmotm.git master
> config: microblaze-mmu_defconfig (attached as .config)

A while ago Johannes moved the mmotm to github and the last commit in
git.cmpxchg.org/linux-mmotm.git was in the end of August.

[1] https://lore.kernel.org/linux-mm/20190916134327.GC29985@cmpxchg.org
 
> Thanks,
> Michal
> 
> -- 
> Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
> w: www.monstr.eu p: +42-0-721842854
> Maintainer of Linux kernel - Xilinx Microblaze
> Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
> U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
> 

-- 
Sincerely yours,
Mike.
