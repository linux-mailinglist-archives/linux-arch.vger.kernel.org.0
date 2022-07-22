Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B025C57E345
	for <lists+linux-arch@lfdr.de>; Fri, 22 Jul 2022 16:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbiGVOxM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Jul 2022 10:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiGVOxL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Jul 2022 10:53:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5499DEC5;
        Fri, 22 Jul 2022 07:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gHrljq7uAAkt6EA0Rax0KNr3SuXDdnvY9kKt6QjVG6M=; b=e84zQK+3cIn4BmPB50nGg55Bco
        nOQWDdETaYPfU8vVUfKowVB2vyzy3IjAsBABj5LFma5e5RlmTXnr8xTDEURTn9OUJMx4PvHLRG8fT
        xP6RwaJmr5vb774E5D5kiG8jHhx8OlABwMhDxwW48aGuz5OQFcq1gqUl0L+/oQgrAwUo7sZTfZJss
        zqMy8Oy1jAuoUo+4aKGbNm0y6tU/zDTXF0lW3LKmAA/qEGaHRHdM6PkoEbk44n3SxlCXbPi+RzTgm
        0ocyLT3zwJ9fxaBJcHuJKxaGULrtIfVJ8fhvNTCcUza97Q8f+nVe4RCOFJTb9yhCfANykx/CavLfz
        b+M9nWFg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEu1b-006nRT-16; Fri, 22 Jul 2022 14:53:07 +0000
Date:   Fri, 22 Jul 2022 07:53:06 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] asm-generic: remove a broken and needless ifdef
 conditional
Message-ID: <Ytq50u0nhkJ1UV0U@bombadil.infradead.org>
References: <20220722110711.16569-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722110711.16569-1-lukas.bulwahn@gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 22, 2022 at 01:07:11PM +0200, Lukas Bulwahn wrote:
> Commit 527701eda5f1 ("lib: Add a generic version of devmem_is_allowed()")
> introduces the config symbol GENERIC_LIB_DEVMEM_IS_ALLOWED, but then
> falsely refers to CONFIG_GENERIC_DEVMEM_IS_ALLOWED (note the missing LIB
> in the reference) in ./include/asm-generic/io.h.
> 
> Luckily, ./scripts/checkkconfigsymbols.py warns on non-existing configs:
> 
> GENERIC_DEVMEM_IS_ALLOWED
> Referencing files: include/asm-generic/io.h
> 
> The actual fix, though, is simply to not to make this function declaration
> dependent on any kernel config. For architectures that intend to use
> the generic version, the arch's 'select GENERIC_LIB_DEVMEM_IS_ALLOWED' will
> lead to picking the function definition, and for other architectures, this
> function is simply defined elsewhere.
> 
> The wrong '#ifndef' on a non-existing config symbol also always had the
> same effect (although more by mistake than by intent). So, there is no
> functional change.
> 
> Remove this broken and needless ifdef conditional.
> 
> Fixes: 527701eda5f1 ("lib: Add a generic version of devmem_is_allowed()")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---

There is only one architecture which defines this as a static inline.
Should that architecture include asm-generic/io.h, or if it already
does, it may end up with a compilation error.

So if arch/s390/include/asm/page.h can end up including asm-generic/io.h
or if any file including for s390 can include its arch page.h and
asm-generic/io.h then we'll still need the guard.

This may compile today for s390 because s390 may not use asm-generic/io.h.

So why not just keep the guard and correct this as intended?

  Luis

> v1: https://lore.kernel.org/all/20211006145859.9564-1-lukas.bulwahn@gmail.com/
> 
> Arnd, please pick this v2 for your asm-generic branch. 
> 
> 
>  include/asm-generic/io.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index ce4c90601300..a68f8fbf423b 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -1221,9 +1221,7 @@ static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
>  }
>  #endif
>  
> -#ifndef CONFIG_GENERIC_DEVMEM_IS_ALLOWED
>  extern int devmem_is_allowed(unsigned long pfn);
> -#endif
>  
>  #endif /* __KERNEL__ */
>  
> -- 
> 2.17.1
> 
