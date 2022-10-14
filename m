Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C305FF1FB
	for <lists+linux-arch@lfdr.de>; Fri, 14 Oct 2022 18:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJNQDg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Oct 2022 12:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiJNQDg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Oct 2022 12:03:36 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406D7176504;
        Fri, 14 Oct 2022 09:03:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 924ABCE25C4;
        Fri, 14 Oct 2022 16:03:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF473C43470;
        Fri, 14 Oct 2022 16:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665763412;
        bh=M+V3mFqdz/kN2qQoBVf9O0cU5rIZOBRgjv6UT7ny7Os=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kqRH0TDHeQVWqsAcSkvowNocjUu7QK0vXJw7o2v4HG4Y270cXiHHSaQK2RDUn0cAz
         YS/wYCaQu9kA+RFU5HqxUZ8Wb4ghugFgNGK6KdnVQPblbOWbVCzujqfLiYqnAecdoQ
         CpQgBBj436cqwGPCE8tt7EiGViMdmMr0MYiYXqhj9ysTAsT1Ds9Ub8zFUkxk9FCf+z
         4A81Ns4TD3v/Tch0wn7FWoqlYB7cWQZ4moCnzdfkzSpGyhjULHjZ+Zcxr4Fo5sPLob
         WcRFoyrU1WOji4pa0Hgn5pRjoeXaA5Kuu2TOmyb/ch0LP4f/Ta07WkTlJ+VSqUUw08
         LwrJKfDoUXpNA==
Date:   Fri, 14 Oct 2022 09:03:29 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Subject: Re: [PATCH v3 1/2] kbuild: move -Werror from KBUILD_CFLAGS to
 KBUILD_CPPFLAGS
Message-ID: <Y0mIUW7Ozx9tseeG@dev-arch.thelio-3990X>
References: <20221012180118.331005-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012180118.331005-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 13, 2022 at 03:01:17AM +0900, Masahiro Yamada wrote:
> CONFIG_WERROR turns warnings into errors, which  happens only for *.c
> files because -Werror is added to KBUILD_CFLAGS.
> 
> Adding it to KBUILD_CPPFLAGS makes more sense because preprocessors
> understand the -Werror option.
> 
> For example, you can put a #warning directive in any preprocessed code.
> 
>     warning: #warning "this is a warning message" [-Wcpp]
> 
> If -Werror is added, it is promoted to an error.
> 
>     error: #warning "this is a warning message" [-Werror=cpp]
> 
> This commit moves -Werror to KBUILD_CPPFLAGS so it works in the same way
> for *.c, *.S, *.lds.S or whatever needs preprocessing.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> 
> (no changes since v1)
> 
>  Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 85a63a1d29b3..790760d26ea0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -859,7 +859,8 @@ stackp-flags-$(CONFIG_STACKPROTECTOR_STRONG)      := -fstack-protector-strong
>  
>  KBUILD_CFLAGS += $(stackp-flags-y)
>  
> -KBUILD_CFLAGS-$(CONFIG_WERROR) += -Werror
> +KBUILD_CPPFLAGS-$(CONFIG_WERROR) += -Werror
> +KBUILD_CPPFLAGS += $(KBUILD_CPPFLAGS-y)
>  KBUILD_CFLAGS-$(CONFIG_CC_NO_ARRAY_BOUNDS) += -Wno-array-bounds
>  
>  KBUILD_RUSTFLAGS-$(CONFIG_WERROR) += -Dwarnings
> -- 
> 2.34.1
> 
> 

For what it's worth, this is going to break 32-bit ARM builds with clang
plus the integrated assembler due to
https://github.com/ClangBuiltLinux/linux/issues/1315:

clang-16: error: argument unused during compilation: '-march=armv7-a' [-Werror,-Wunused-command-line-argument]

Ultimately, I want -Wunused-command-line-argument to be an error anyways
(https://github.com/ClangBuiltLinux/linux/issues/1587) but it would be
nice to get these cleaned up before this goes in.

Cheers,
Nathan
