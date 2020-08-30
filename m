Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC51B256D51
	for <lists+linux-arch@lfdr.de>; Sun, 30 Aug 2020 12:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgH3KSo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Aug 2020 06:18:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgH3KSo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 30 Aug 2020 06:18:44 -0400
Received: from kernel.org (unknown [87.70.91.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F69220738;
        Sun, 30 Aug 2020 10:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598782722;
        bh=sRD04fQkd7ArwvwEzVrpFGIAtRfVKXTA5eBOjfae0nY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cgWN+UpBHbinEyxZtXkegtbYJGDbuJ+YNBBJFlAwGNoxYapiivYV4080E3L2xMoYl
         HNyQpk5USDSZCxFaOw3sL8yI/hcE7dKTtGb+yjZBkhhsbvDLN9m4OSHe67qgIR7FsB
         6c0gsA8gwj5ojXAxmeVg0/R5kHFC2Iu1CHDAqwDo=
Date:   Sun, 30 Aug 2020 13:18:37 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 00/23] Use asm-generic for mmu_context no-op functions
Message-ID: <20200830101837.GB423750@kernel.org>
References: <20200826145249.745432-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826145249.745432-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 27, 2020 at 12:52:26AM +1000, Nicholas Piggin wrote:
> It would be nice to be able to modify mmu_context functions or add a
> hook without updating all architectures, many of which will be no-ops.
> 
> The motivation for this series is a change to lazy mmu handling, but
> this series stands on its own as a good cleanup whether or not we end
> up making that change.

I really like this series, I just have some small comments in reply to
patch 1, otherwise feel free to add

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> Arnd, is this something you could take through your asm-generic tree?
> (assuming arch maintainers are okay with it)
> 
> Thanks,
> Nick
> 
> Since v1:
> - Added acks and feedback from various people.
> - Fixed a nommu build error caught by ktp.
> - Dropped unicore32.
> 
> Nicholas Piggin (23):
>   asm-generic: add generic MMU versions of mmu context functions
>   alpha: use asm-generic/mmu_context.h for no-op implementations
>   arc: use asm-generic/mmu_context.h for no-op implementations
>   arm: use asm-generic/mmu_context.h for no-op implementations
>   arm64: use asm-generic/mmu_context.h for no-op implementations
>   csky: use asm-generic/mmu_context.h for no-op implementations
>   hexagon: use asm-generic/mmu_context.h for no-op implementations
>   ia64: use asm-generic/mmu_context.h for no-op implementations
>   m68k: use asm-generic/mmu_context.h for no-op implementations
>   microblaze: use asm-generic/mmu_context.h for no-op implementations
>   mips: use asm-generic/mmu_context.h for no-op implementations
>   nds32: use asm-generic/mmu_context.h for no-op implementations
>   nios2: use asm-generic/mmu_context.h for no-op implementations
>   openrisc: use asm-generic/mmu_context.h for no-op implementations
>   parisc: use asm-generic/mmu_context.h for no-op implementations
>   powerpc: use asm-generic/mmu_context.h for no-op implementations
>   riscv: use asm-generic/mmu_context.h for no-op implementations
>   s390: use asm-generic/mmu_context.h for no-op implementations
>   sh: use asm-generic/mmu_context.h for no-op implementations
>   sparc: use asm-generic/mmu_context.h for no-op implementations
>   um: use asm-generic/mmu_context.h for no-op implementations
>   x86: use asm-generic/mmu_context.h for no-op implementations
>   xtensa: use asm-generic/mmu_context.h for no-op implementations
> 
>  arch/alpha/include/asm/mmu_context.h         | 12 ++---
>  arch/arc/include/asm/mmu_context.h           | 17 +++---
>  arch/arm/include/asm/mmu_context.h           | 26 ++-------
>  arch/arm64/include/asm/mmu_context.h         |  9 ++--
>  arch/csky/include/asm/mmu_context.h          |  8 ++-
>  arch/hexagon/include/asm/mmu_context.h       | 33 ++----------
>  arch/ia64/include/asm/mmu_context.h          | 17 ++----
>  arch/m68k/include/asm/mmu_context.h          | 47 +++-------------
>  arch/microblaze/include/asm/mmu_context.h    |  2 +-
>  arch/microblaze/include/asm/mmu_context_mm.h |  8 +--
>  arch/microblaze/include/asm/processor.h      |  3 --
>  arch/mips/include/asm/mmu_context.h          | 11 ++--
>  arch/nds32/include/asm/mmu_context.h         | 10 +---
>  arch/nios2/include/asm/mmu_context.h         | 21 ++------
>  arch/openrisc/include/asm/mmu_context.h      |  8 ++-
>  arch/parisc/include/asm/mmu_context.h        | 12 ++---
>  arch/powerpc/include/asm/mmu_context.h       | 22 +++-----
>  arch/riscv/include/asm/mmu_context.h         | 22 +-------
>  arch/s390/include/asm/mmu_context.h          |  9 ++--
>  arch/sh/include/asm/mmu_context.h            |  7 ++-
>  arch/sh/include/asm/mmu_context_32.h         |  9 ----
>  arch/sparc/include/asm/mmu_context_32.h      | 10 ++--
>  arch/sparc/include/asm/mmu_context_64.h      | 10 ++--
>  arch/um/include/asm/mmu_context.h            | 12 ++---
>  arch/x86/include/asm/mmu_context.h           |  6 +++
>  arch/xtensa/include/asm/mmu_context.h        | 11 ++--
>  arch/xtensa/include/asm/nommu_context.h      | 26 +--------
>  include/asm-generic/mmu_context.h            | 57 +++++++++++++++-----
>  include/asm-generic/nommu_context.h          | 19 +++++++
>  29 files changed, 166 insertions(+), 298 deletions(-)
>  create mode 100644 include/asm-generic/nommu_context.h
> 
> -- 
> 2.23.0
> 
> 

-- 
Sincerely yours,
Mike.
