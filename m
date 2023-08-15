Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6008D77CA0C
	for <lists+linux-arch@lfdr.de>; Tue, 15 Aug 2023 11:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbjHOJKv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Aug 2023 05:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbjHOJKO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Aug 2023 05:10:14 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0A1F1BDF;
        Tue, 15 Aug 2023 02:09:58 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qVq3p-0002fc-00; Tue, 15 Aug 2023 11:09:57 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id D27A5C0276; Tue, 15 Aug 2023 10:27:07 +0200 (CEST)
Date:   Tue, 15 Aug 2023 10:27:07 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 2/3] mips: replace #include <asm/export.h> with #include
 <linux/export.h>
Message-ID: <ZNs225J/yWq3wbmf@alpha.franken.de>
References: <20230807153243.996262-1-masahiroy@kernel.org>
 <20230807153243.996262-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807153243.996262-2-masahiroy@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 08, 2023 at 12:32:42AM +0900, Masahiro Yamada wrote:
> Commit ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost")
> deprecated <asm/export.h>, which is now a wrapper of <linux/export.h>.
> 
> Replace #include <asm/export.h> with #include <linux/export.h>.
> 
> After all the <asm/export.h> lines are converted, <asm/export.h> and
> <asm-generic/export.h> will be removed.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/mips/cavium-octeon/octeon-memcpy.S | 2 +-
>  arch/mips/kernel/mcount.S               | 2 +-
>  arch/mips/kernel/r2300_fpu.S            | 2 +-
>  arch/mips/kernel/r4k_fpu.S              | 2 +-
>  arch/mips/lib/csum_partial.S            | 2 +-
>  arch/mips/lib/memcpy.S                  | 2 +-
>  arch/mips/lib/memset.S                  | 2 +-
>  arch/mips/lib/strncpy_user.S            | 2 +-
>  arch/mips/lib/strnlen_user.S            | 2 +-
>  arch/mips/mm/page-funcs.S               | 2 +-
>  arch/mips/mm/tlb-funcs.S                | 2 +-
>  11 files changed, 11 insertions(+), 11 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
