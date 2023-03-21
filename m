Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6186C3DD0
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 23:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCUWld (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Mar 2023 18:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjCUWlc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 18:41:32 -0400
X-Greylist: delayed 891 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Mar 2023 15:41:31 PDT
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B39058C02
        for <linux-arch@vger.kernel.org>; Tue, 21 Mar 2023 15:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=mIwynQgjzMEjx1NFjlz0a05nnkbCrn+qgmoGl+S5aZE=; b=TlnQnwPD0bY4H/Ev84SzuT+cQs
        kH/adSoMXHBN3TbSyBaJpmaGqEfGeMUpHm2/E1f3fmTfwUSDrx9UKMsHARF7GooQSiSQnH0qpN0Sa
        SgcwBO8BwqxybVTCU+lkQZDI7BegMamueI6mdy7fKvNfeBh2EYkfXACpWBXi8qfWFR2sgceV+yo6h
        TMRLHnpi9NUMhxJu7Au9B5yNbBZycP8nLfmcTdSN5IxPFF46dHfv+mOP/y4Kbx4EyGBMI2gKXqqod
        cLXbMyJjtqdrRfjQ1733EBV6B91k4RlL0bhoPRIifcKtouzv6Cs2MJwVv3Boe8BLfwFHnr/TTSjlP
        LcKD2Cdw==;
Received: from aurel32 by hall.aurel32.net with local (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1pekQs-001zcp-Oi; Tue, 21 Mar 2023 23:26:18 +0100
Date:   Tue, 21 Mar 2023 23:26:18 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: remove special treatment for the link order of
 head.o
Message-ID: <ZBovCrMXJk7NPISp@aurel32.net>
Mail-Followup-To: Masahiro Yamada <masahiroy@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, linux-kernel@vger.kernel.org
References: <20221012233500.156764-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012233500.156764-1-masahiroy@kernel.org>
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 2022-10-13 08:35, Masahiro Yamada wrote:
> In the previous discussion (see the Link tag), Ard pointed out that
> arm/arm64/kernel/head.o does not need any special treatment - the only
> piece that must appear right at the start of the binary image is the
> image header which is emitted into .head.text.
> 
> The linker script does the right thing to do. The build system does
> not need to manipulate the link order of head.o.
> 
> Link: https://lore.kernel.org/lkml/CAMj1kXH77Ja8bSsq2Qj8Ck9iSZKw=1F8Uy-uAWGVDm4-CG=EuA@mail.gmail.com/
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/head-object-list.txt | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/scripts/head-object-list.txt b/scripts/head-object-list.txt
> index b16326a92c45..f226e45e3b7b 100644
> --- a/scripts/head-object-list.txt
> +++ b/scripts/head-object-list.txt
> @@ -15,7 +15,6 @@ arch/alpha/kernel/head.o
>  arch/arc/kernel/head.o
>  arch/arm/kernel/head-nommu.o
>  arch/arm/kernel/head.o
> -arch/arm64/kernel/head.o
>  arch/csky/kernel/head.o
>  arch/hexagon/kernel/head.o
>  arch/ia64/kernel/head.o

This patch causes a significant increase of the arch/arm64/boot/Image
size. For instance the generic arm64 Debian kernel went from 31 to 39 MB
after this patch has been applied to the 6.1 stable tree.

In turn this causes issues with some bootloaders, for instance U-Boot on
a Raspberry Pi limits the kernel size to 36 MB.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
