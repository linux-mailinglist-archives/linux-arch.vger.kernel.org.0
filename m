Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE00CB3BE3
	for <lists+linux-arch@lfdr.de>; Mon, 16 Sep 2019 15:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbfIPNzu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Sep 2019 09:55:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbfIPNzt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Sep 2019 09:55:49 -0400
Received: from rapoport-lnx (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5F82214AF;
        Mon, 16 Sep 2019 13:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568642149;
        bh=Qw6DlJe9h17KJF1+v+dT72oQWDOddUyjHUhlMCEhp8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XPTufvuH1UTy/pOvMGZQdOF7SQV3VB01raZ4EKG+o4EXiEY3D2hLRYUlRw3OYTudk
         7ifs3vTA3J/UlC1HeoIc5365txH9KKqQGWl5ssh7Ckkc1fx6SAp9yZrtpcJUD2NkJz
         eu1aaMNnpR6YsHUTCAo2eol6j0CPHLbbhM6NdbPg=
Date:   Mon, 16 Sep 2019 16:55:43 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Laura Abbott <labbott@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mike Rapoport <rppt@linux.ibm.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH] arm64: use generic free_initrd_mem()
Message-ID: <20190916135542.GC5196@rapoport-lnx>
References: <1568618488-19055-1-git-send-email-rppt@kernel.org>
 <0ba20aa4-d2dd-2263-6b5f-16a5c8a39f67@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ba20aa4-d2dd-2263-6b5f-16a5c8a39f67@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

(added linux-arch)

On Mon, Sep 16, 2019 at 08:23:29AM -0400, Laura Abbott wrote:
> On 9/16/19 8:21 AM, Mike Rapoport wrote:
> >From: Mike Rapoport <rppt@linux.ibm.com>
> >
> >arm64 calls memblock_free() for the initrd area in its implementation of
> >free_initrd_mem(), but this call has no actual effect that late in the boot
> >process. By the time initrd is freed, all the reserved memory is managed by
> >the page allocator and the memblock.reserved is unused, so there is no
> >point to update it.
> >
> 
> People like to use memblock for keeping track of memory even if it has no
> actual effect. We made this change explicitly (see 05c58752f9dc ("arm64: To remove
> initrd reserved area entry from memblock") That said, moving to the generic
> APIs would be nice. Maybe we can find another place to update the accounting?

Any other place in arch/arm64 would make it messy because it would have to
duplicate keepinitrd logic.

We could put the memblock_free() in the generic free_initrd_mem() with
something like:

diff --git a/init/initramfs.c b/init/initramfs.c
index c47dad0..403c6a0 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -531,6 +531,10 @@ void __weak free_initrd_mem(unsigned long start,
unsigned long end)
 {
        free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM,
                        "initrd");
+
+#ifdef CONFIG_ARCH_KEEP_MEMBLOCK
+       memblock_free(__virt_to_phys(start), end - start);
+#endif
 }
 
 #ifdef CONFIG_KEXEC_CORE


Then powerpc and s390 folks will also be able to track the initrd memory :)

> >Without the memblock_free() call the only difference between arm64 and the
> >generic versions of free_initrd_mem() is the memory poisoning. Switching
> >arm64 to the generic version will enable the poisoning.
> >
> >Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> >---
> >
> >I've boot tested it on qemu and I've checked that kexec works.
> >
> >  arch/arm64/mm/init.c | 8 --------
> >  1 file changed, 8 deletions(-)
> >
> >diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> >index f3c7952..8ad2934 100644
> >--- a/arch/arm64/mm/init.c
> >+++ b/arch/arm64/mm/init.c
> >@@ -567,14 +567,6 @@ void free_initmem(void)
> >  	unmap_kernel_range((u64)__init_begin, (u64)(__init_end - __init_begin));
> >  }
> >-#ifdef CONFIG_BLK_DEV_INITRD
> >-void __init free_initrd_mem(unsigned long start, unsigned long end)
> >-{
> >-	free_reserved_area((void *)start, (void *)end, 0, "initrd");
> >-	memblock_free(__virt_to_phys(start), end - start);
> >-}
> >-#endif
> >-
> >  /*
> >   * Dump out memory limit information on panic.
> >   */
> >
> 

-- 
Sincerely yours,
Mike.
