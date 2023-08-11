Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563A5779187
	for <lists+linux-arch@lfdr.de>; Fri, 11 Aug 2023 16:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbjHKOOZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 10:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHKOOY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 10:14:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E34DFA;
        Fri, 11 Aug 2023 07:14:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F126E6736C;
        Fri, 11 Aug 2023 14:14:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C6FC433C7;
        Fri, 11 Aug 2023 14:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691763263;
        bh=p9mfiPE1MWLML2xizj1bvPrS1LoPmZNcr5/G3sHxzOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K5VOham3DO0lmMHLxpqGsaiWoUC/6TazUEr3RAbZbqIoqmJjCfGCSuY0tqxsNr2NT
         dZmzDyJCUCJIKLfzBKFLFNxbSrVQDA401VfZqrqF/fCmet93lZ1EEjzYYnE9o43+jW
         m2FZoJqK7a1mXGzNZEg7RKQzvaSDH0tNrzBQ12dy5lxi9ENeGff5nCaE36LELeiYvo
         MPug8w/GStM7z5T5MoAAdzT1aTtI12xRqAc2cqFIf0uNBMs59oVecTA25c++2EX/2b
         febtvM7RcqpuadLkxiJlanu0VCMPjHx8tZBT+McEOUhlw2p/9MckLQwfARw6lp+EKn
         rXF7xVM4tJnwQ==
Date:   Fri, 11 Aug 2023 07:14:21 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/9] Kbuild: only pass -fno-inline-functions-called-once
 for gcc
Message-ID: <20230811141421.GA3948268@dev-arch.thelio-3990X>
References: <20230811140327.3754597-1-arnd@kernel.org>
 <20230811140327.3754597-2-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811140327.3754597-2-arnd@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 11, 2023 at 04:03:19PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang ignores the -fno-inline-functions-called-once option, but warns
> when building with -Wignored-optimization-argument enabled:
> 
> clang: error: optimization flag '-fno-inline-functions-called-once' is not supported [-Werror,-Wignored-optimization-argument]
> 
> Move it back to using cc-option for this one.
> 
> Fixes: 7d73c3e9c514 ("Makefile: remove stale cc-option checks")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

How can this even be hit with clang, as CONFIG_DEBUG_SECTION_MISMATCH
was changed to depend on GCC in the same commit?

> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index bf5a6100cf66e..991c02f8e9ac0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -967,7 +967,7 @@ endif
>  
>  # We trigger additional mismatches with less inlining
>  ifdef CONFIG_DEBUG_SECTION_MISMATCH
> -KBUILD_CFLAGS += -fno-inline-functions-called-once
> +KBUILD_CFLAGS += $(call cc-option,-fno-inline-functions-called-once)
>  endif
>  
>  # `rustc`'s `-Zfunction-sections` applies to data too (as of 1.59.0).
> -- 
> 2.39.2
> 
