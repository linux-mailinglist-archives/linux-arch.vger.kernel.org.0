Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70B64FEA7C
	for <lists+linux-arch@lfdr.de>; Wed, 13 Apr 2022 01:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiDLX0w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Apr 2022 19:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiDLX00 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Apr 2022 19:26:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99322D111B;
        Tue, 12 Apr 2022 15:12:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8334D61C33;
        Tue, 12 Apr 2022 21:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FC0C385A5;
        Tue, 12 Apr 2022 21:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649800120;
        bh=e0KhySr/UtVkziqmjJzUDp0PRfv9k6FipuSZSV+okHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ibyqs9v6j63iFgpc/JkvmS94m1mI+LGZvtxl9CNeQUfnJZ9YtGZVZv2bC9LEhmhJS
         3mipIKZoiUbkwS+aI4+zyyGzRsPH6D3XIGs/UYbrmGYqW4dDuqYUPz7uA7/1q11p3m
         oPq3dqCzmFQAQGOIwbYBBDMp+x+B1y87gDEw8Vlnj0WB1uKoESmySEXNPHya1yDMXF
         rugicO7BoTsdP2yGShAJuUqfsOJjsdjzReXIWd4i+/SgOnXBg4M6ouptd8lzk7aqj1
         kqMpPlqJ+cyNgh1caK3O7i7F11r46F3Jv529Y4m0a9lwFS0cMLxAs40qgg/ClrCq9W
         umDphqHnoOjLA==
Date:   Tue, 12 Apr 2022 14:48:38 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] init/Kconfig: Remove USELIB syscall by default
Message-ID: <YlXztpgTxmn29KF3@dev-arch.thelio-3990X>
References: <20220412212519.4113845-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412212519.4113845-1-keescook@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 12, 2022 at 02:25:20PM -0700, Kees Cook wrote:
> The uselib syscall has been long deprecated. There's no need to keep
> this enabled by default under X86_32.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

The 'bool "" + def_bool' was weird and I had to look up what libc5 even
was :)

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  init/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index ddcbefe535e9..5cddb9ba0eef 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -435,8 +435,8 @@ config CROSS_MEMORY_ATTACH
>  	  See the man page for more details.
>  
>  config USELIB
> -	bool "uselib syscall"
> -	def_bool ALPHA || M68K || SPARC || X86_32 || IA32_EMULATION
> +	bool "uselib syscall (for libc5 and earlier)"
> +	default ALPHA || M68K || SPARC
>  	help
>  	  This option enables the uselib syscall, a system call used in the
>  	  dynamic linker from libc5 and earlier.  glibc does not use this
> -- 
> 2.32.0
> 
