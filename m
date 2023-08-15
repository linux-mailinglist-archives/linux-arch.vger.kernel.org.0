Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C426477CA0A
	for <lists+linux-arch@lfdr.de>; Tue, 15 Aug 2023 11:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjHOJKu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Aug 2023 05:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbjHOJKO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Aug 2023 05:10:14 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B085D1BDD;
        Tue, 15 Aug 2023 02:09:58 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qVq3o-0002fY-00; Tue, 15 Aug 2023 11:09:56 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 9D620C030D; Tue, 15 Aug 2023 10:27:20 +0200 (CEST)
Date:   Tue, 15 Aug 2023 10:27:20 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/3] mips: remove <asm/export.h>
Message-ID: <ZNs26FyjZhzP+Cs5@alpha.franken.de>
References: <20230807153243.996262-1-masahiroy@kernel.org>
 <20230807153243.996262-3-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807153243.996262-3-masahiroy@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 08, 2023 at 12:32:43AM +0900, Masahiro Yamada wrote:
> All *.S files under arch/mips/ have been converted to include
> <linux/export.h> instead of <asm/export.h>.
> 
> Remove <asm/export.h>.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/mips/include/asm/Kbuild | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
> index dee172716581..7ba67a0d6c97 100644
> --- a/arch/mips/include/asm/Kbuild
> +++ b/arch/mips/include/asm/Kbuild
> @@ -7,7 +7,6 @@ generated-y += unistd_nr_n32.h
>  generated-y += unistd_nr_n64.h
>  generated-y += unistd_nr_o32.h
>  
> -generic-y += export.h
>  generic-y += kvm_para.h
>  generic-y += mcs_spinlock.h
>  generic-y += parport.h
> -- 
> 2.39.2
> 

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
