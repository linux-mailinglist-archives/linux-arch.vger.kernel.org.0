Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60FF6352C72
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 18:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbhDBPgS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Apr 2021 11:36:18 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:19745 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhDBPgR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 2 Apr 2021 11:36:17 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FBkfh6syMz9v2m9;
        Fri,  2 Apr 2021 17:36:12 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id SsC2ob6kJi6G; Fri,  2 Apr 2021 17:36:12 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FBkfh5PDlz9v2m8;
        Fri,  2 Apr 2021 17:36:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A97528BB77;
        Fri,  2 Apr 2021 17:36:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id dzRgT34PMsr4; Fri,  2 Apr 2021 17:36:14 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BA9038BB6F;
        Fri,  2 Apr 2021 17:36:13 +0200 (CEST)
Subject: Re: [PATCH v3 12/17] sh: Convert to GENERIC_CMDLINE
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     will@kernel.org, danielwa@cisco.com, robh@kernel.org,
        daniel@gimpelevich.san-francisco.ca.us
Cc:     linux-arch@vger.kernel.org, devicetree@vger.kernel.org,
        microblaze <monstr@monstr.eu>, linux-xtensa@linux-xtensa.org,
        linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        nios2 <ley.foon.tan@intel.com>, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
 <6b76649009943f2893fdfded22becd41db2fe1f7.1616765870.git.christophe.leroy@csgroup.eu>
Message-ID: <d672dec1-6fcb-d5dc-a551-2a99e6dd6976@csgroup.eu>
Date:   Fri, 2 Apr 2021 17:36:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <6b76649009943f2893fdfded22becd41db2fe1f7.1616765870.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 26/03/2021 à 14:44, Christophe Leroy a écrit :
> This converts the architecture to GENERIC_CMDLINE.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---

> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index e798e55915c2..fab84f62448c 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -16,6 +16,7 @@ config SUPERH
>   	select CPU_NO_EFFICIENT_FFS
>   	select DMA_DECLARE_COHERENT
>   	select GENERIC_ATOMIC64
> +	select GENERIC_CMDLINE
>   	select GENERIC_CMOS_UPDATE if SH_SH03 || SH_DREAMCAST
>   	select GENERIC_IDLE_POLL_SETUP
>   	select GENERIC_IRQ_SHOW
> @@ -742,35 +743,6 @@ config ROMIMAGE_MMCIF
>   	  first part of the romImage which in turn loads the rest the kernel
>   	  image to RAM using the MMCIF hardware block.
>   
> -choice
> -	prompt "Kernel command line"
> -	optional
> -	default CMDLINE_OVERWRITE
> -	help
> -	  Setting this option allows the kernel command line arguments
> -	  to be set.
> -
> -config CMDLINE_OVERWRITE
> -	bool "Overwrite bootloader kernel arguments"
> -	help
> -	  Given string will overwrite any arguments passed in by
> -	  a bootloader.
> -
> -config CMDLINE_EXTEND
> -	bool "Extend bootloader kernel arguments"
> -	help
> -	  Given string will be concatenated with arguments passed in
> -	  by a bootloader.
> -
> -endchoice
> -
> -config CMDLINE
> -	string "Kernel command line arguments string"
> -	depends on CMDLINE_OVERWRITE || CMDLINE_EXTEND
> -	default "console=ttySC1,115200"
> -
> -endmenu
> -

That "endmenu" shall not be removed.

Fixed in v4,

Thanks to Rob L. for the report.
Christophe

>   menu "Bus options"
>   
>   config SUPERHYWAY
