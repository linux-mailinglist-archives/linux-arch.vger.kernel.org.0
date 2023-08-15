Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8539A77CA0D
	for <lists+linux-arch@lfdr.de>; Tue, 15 Aug 2023 11:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbjHOJKv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Aug 2023 05:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbjHOJKP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Aug 2023 05:10:15 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFEC110C;
        Tue, 15 Aug 2023 02:09:58 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qVq3o-0002fa-00; Tue, 15 Aug 2023 11:09:56 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 1E949C01A8; Tue, 15 Aug 2023 10:26:48 +0200 (CEST)
Date:   Tue, 15 Aug 2023 10:26:48 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/3] mips: remove unneeded #include <asm/export.h>
Message-ID: <ZNs2yBOYr57Rjq9t@alpha.franken.de>
References: <20230807153243.996262-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807153243.996262-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 08, 2023 at 12:32:41AM +0900, Masahiro Yamada wrote:
> There is no EXPORT_SYMBOL line there, hence #include <asm/export.h>
> is unneeded.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/mips/kernel/octeon_switch.S | 1 -
>  arch/mips/kernel/r2300_switch.S  | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/arch/mips/kernel/octeon_switch.S b/arch/mips/kernel/octeon_switch.S
> index 9b7c8ab6f08c..447a3ea14aa1 100644
> --- a/arch/mips/kernel/octeon_switch.S
> +++ b/arch/mips/kernel/octeon_switch.S
> @@ -11,7 +11,6 @@
>   *    written by Carsten Langgaard, carstenl@mips.com
>   */
>  #include <asm/asm.h>
> -#include <asm/export.h>
>  #include <asm/asm-offsets.h>
>  #include <asm/mipsregs.h>
>  #include <asm/regdef.h>
> diff --git a/arch/mips/kernel/r2300_switch.S b/arch/mips/kernel/r2300_switch.S
> index 71b1aafae1bb..48e63943e6f7 100644
> --- a/arch/mips/kernel/r2300_switch.S
> +++ b/arch/mips/kernel/r2300_switch.S
> @@ -13,7 +13,6 @@
>   */
>  #include <asm/asm.h>
>  #include <asm/cachectl.h>
> -#include <asm/export.h>
>  #include <asm/fpregdef.h>
>  #include <asm/mipsregs.h>
>  #include <asm/asm-offsets.h>
> -- 
> 2.39.2

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
