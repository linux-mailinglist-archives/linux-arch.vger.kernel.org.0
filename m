Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946E42CA57B
	for <lists+linux-arch@lfdr.de>; Tue,  1 Dec 2020 15:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbgLAOWn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Dec 2020 09:22:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:50912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbgLAOWm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Dec 2020 09:22:42 -0500
Received: from gaia (unknown [95.146.230.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D1062076C;
        Tue,  1 Dec 2020 14:21:59 +0000 (UTC)
Date:   Tue, 1 Dec 2020 14:21:56 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v8 05/12] mm: HUGE_VMAP arch support cleanup
Message-ID: <20201201142156.GD31404@gaia>
References: <20201128152559.999540-1-npiggin@gmail.com>
 <20201128152559.999540-6-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201128152559.999540-6-npiggin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Nov 29, 2020 at 01:25:52AM +1000, Nicholas Piggin wrote:
> This changes the awkward approach where architectures provide init
> functions to determine which levels they can provide large mappings for,
> to one where the arch is queried for each call.
> 
> This removes code and indirection, and allows constant-folding of dead
> code for unsupported levels.
> 
> This also adds a prot argument to the arch query. This is unused
> currently but could help with some architectures (e.g., some powerpc
> processors can't map uncacheable memory with large pages).
> 
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/arm64/include/asm/vmalloc.h         |  8 +++
>  arch/arm64/mm/mmu.c                      | 10 +--

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
