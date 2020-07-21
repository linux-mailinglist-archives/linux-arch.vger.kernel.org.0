Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122C22277CD
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 06:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgGUE6j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 00:58:39 -0400
Received: from verein.lst.de ([213.95.11.211]:50449 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbgGUE6j (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Jul 2020 00:58:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E950E68AFE; Tue, 21 Jul 2020 06:58:34 +0200 (CEST)
Date:   Tue, 21 Jul 2020 06:58:34 +0200
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
Message-ID: <20200721045834.GA9613@lst.de>
References: <20200714105505.935079-1-hch@lst.de> <20200714105505.935079-2-hch@lst.de> <20200718013849.GA157764@roeck-us.net> <20200718094846.GA8593@lst.de> <20200720221046.GA86726@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720221046.GA86726@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 20, 2020 at 03:10:46PM -0700, Guenter Roeck wrote:
> I had another look into the code. Right after this patch, I see
> 
> #define uaccess_kernel() segment_eq(get_fs(), KERNEL_DS)
> 
> Yet, this patch is:
> 
> -       if (CHECK_DATA_CORRUPTION(!segment_eq(get_fs(), USER_DS),
> +       if (CHECK_DATA_CORRUPTION(uaccess_kernel(),
> 
> So there is a negation in the condition. Indeed, the following change
> on top of next-20200720 fixes the problem for mps2-an385.
> 
> -       if (CHECK_DATA_CORRUPTION(uaccess_kernel(),
> +       if (CHECK_DATA_CORRUPTION(!uaccess_kernel(),
> 
> How does this work anywhere ?

No, that is the wrong check - we want to make sure the address
space override doesn't leak to userspace.  The problem is that
armnommu (and m68knommu, but that doesn't call the offending
function) pretends to not have a kernel address space, which doesn't
really work.  Here is the fix I sent out yesterday, which I should
have Cc'ed you on, sorry:

---
From 2bb889b2d99a2d978e90640ade8fe02359287092 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 20 Jul 2020 17:46:50 +0200
Subject: arm: don't call addr_limit_user_check for nommu

On arm nommu kernel use the same constant for USER_DS and KERNEL_DS,
and seqment_eq always returns false.  With the current check in
addr_limit_user_check that works by accident, but when replacing
seqment_eq with uaccess_kerne it will fail.  Just remove the not
needed check entirely.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/arm/kernel/signal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index ab2568996ddb0c..c9dc912b83f012 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -713,7 +713,9 @@ struct page *get_signal_page(void)
 /* Defer to generic check */
 asmlinkage void addr_limit_check_failed(void)
 {
+#ifdef CONFIG_MMU
 	addr_limit_user_check();
+#endif
 }
 
 #ifdef CONFIG_DEBUG_RSEQ
-- 
2.27.0

