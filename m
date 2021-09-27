Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A224194F2
	for <lists+linux-arch@lfdr.de>; Mon, 27 Sep 2021 15:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbhI0NUb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Sep 2021 09:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbhI0NU2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Sep 2021 09:20:28 -0400
X-Greylist: delayed 403 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Sep 2021 06:18:50 PDT
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48038C061575;
        Mon, 27 Sep 2021 06:18:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HJ3286WM8z4xZJ;
        Mon, 27 Sep 2021 23:12:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1632748321;
        bh=/6NGyTxf3yZzS/6VpTsWCSMws0EAQCWdVr1eBk3RItQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bCCOJ57PVuxKBr/+8rzursr0M58poo2U8UYU8FmOa4Ve+xeh2oVXaK/weC5cayqC8
         0wfzCG3XkzUK6Cq3uln4S1u7XiI8Y5zls2oXnDdU8s8sTYlXG0ip+mYiZXMrDsr0Ms
         rgvGcz2IfqStO+q38lKNaAq/EqUyLMic0uWxcIB0J9CzMKYaZF+8ecEHf3d0bQmkvS
         aHG/dFXj/TlPCuEGMseSTg3CjjKQ3HmJ7K6YllqzxrwuI16j2tZXrTHkJAF1Jps4OY
         umzjNyJWrNKJ+gqjI+Y3AiPuqS0/WkO+2lgBODADFgP+K/n+6PQi6QF0+aN0U1U7KW
         vJ+X8XhJSUtPA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Morton <akpm@linux-foundation.org>, arnd@arndb.de
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [PATCH 1/3] mm: Make generic arch_is_kernel_initmem_freed() do
 what it says
In-Reply-To: <0b55650058a5bf64f7d74781871a1ada2298c8b4.1632491308.git.christophe.leroy@csgroup.eu>
References: <0b55650058a5bf64f7d74781871a1ada2298c8b4.1632491308.git.christophe.leroy@csgroup.eu>
Date:   Mon, 27 Sep 2021 23:11:56 +1000
Message-ID: <87h7e6kvs3.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Commit 7a5da02de8d6 ("locking/lockdep: check for freed initmem in
> static_obj()") added arch_is_kernel_initmem_freed() which is supposed
> to report whether an object is part of already freed init memory.
>
> For the time being, the generic version of arch_is_kernel_initmem_freed()
> always reports 'false', allthough free_initmem() is generically called
> on all architectures.
>
> Therefore, change the generic version of arch_is_kernel_initmem_freed()
> to check whether free_initmem() has been called. If so, then check
> if a given address falls into init memory.
>
> In order to use function init_section_contains(), the fonction is
> moved at the end of asm-generic/section.h
>
> Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  include/asm-generic/sections.h | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
> index d16302d3eb59..d1e5bb2c6b72 100644
> --- a/include/asm-generic/sections.h
> +++ b/include/asm-generic/sections.h
> @@ -172,4 +158,21 @@ static inline bool is_kernel_rodata(unsigned long addr)
>  	       addr < (unsigned long)__end_rodata;
>  }
>  
> +/*
> + * Check if an address is part of freed initmem. This is needed on architectures
> + * with virt == phys kernel mapping, for code that wants to check if an address
> + * is part of a static object within [_stext, _end]. After initmem is freed,
> + * memory can be allocated from it, and such allocations would then have
> + * addresses within the range [_stext, _end].
> + */
> +#ifndef arch_is_kernel_initmem_freed
> +static inline int arch_is_kernel_initmem_freed(unsigned long addr)
> +{
> +	if (system_state < SYSTEM_RUNNING)
> +		return 0;
> +
> +	return init_section_contains((void *)addr, 1);
> +}
> +#endif

This will return an incorrect result for a short period during boot
won't it?

See init/main.c:

static int __ref kernel_init(void *unused)
{
	...
	free_initmem();			<- memory is freed here
	mark_readonly();

	/*
	 * Kernel mappings are now finalized - update the userspace page-table
	 * to finalize PTI.
	 */
	pti_finalize();

	system_state = SYSTEM_RUNNING;


After free_initmem() we have address ranges that are now freed initmem,
but arch_is_kernel_initmem_freed() continues to return 0 (false) for all
addresses, until we update system_state.

Possibly that doesn't matter for any of the current callers, but it
seems pretty dicey to me.

cheers
