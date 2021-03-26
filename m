Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB7234A945
	for <lists+linux-arch@lfdr.de>; Fri, 26 Mar 2021 15:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhCZOJB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Mar 2021 10:09:01 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:36066 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhCZOIe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Mar 2021 10:08:34 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4F6P2d6PvWz1ryY1;
        Fri, 26 Mar 2021 15:08:25 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4F6P2d4qBqz1qqwS;
        Fri, 26 Mar 2021 15:08:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id onoyYkV_BZHU; Fri, 26 Mar 2021 15:08:24 +0100 (CET)
X-Auth-Info: OEvAU2bUcvvTBFMfvWGLhYIW4WQnHRDFk1cZLlSNZz300DmBDLQfVXreztynDrlR
Received: from igel.home (ppp-46-244-160-134.dynamic.mnet-online.de [46.244.160.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 26 Mar 2021 15:08:24 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 998042C35E3; Fri, 26 Mar 2021 15:08:22 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     will@kernel.org, danielwa@cisco.com, robh@kernel.org,
        daniel@gimpelevich.san-francisco.ca.us, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        microblaze <monstr@monstr.eu>, linux-mips@vger.kernel.org,
        nios2 <ley.foon.tan@intel.com>, openrisc@lists.librecores.org,
        linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, linux-xtensa@linux-xtensa.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 11/17] riscv: Convert to GENERIC_CMDLINE
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
        <46745e07b04139a22b5bd01dc37df97e6981e643.1616765870.git.christophe.leroy@csgroup.eu>
X-Yow:  I'd like some JUNK FOOD...  and then I want to be ALONE --
Date:   Fri, 26 Mar 2021 15:08:22 +0100
In-Reply-To: <46745e07b04139a22b5bd01dc37df97e6981e643.1616765870.git.christophe.leroy@csgroup.eu>
        (Christophe Leroy's message of "Fri, 26 Mar 2021 13:44:58 +0000
        (UTC)")
Message-ID: <87zgyqdn3d.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mär 26 2021, Christophe Leroy wrote:

> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index f8f15332caa2..e7c91ee478d1 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -20,6 +20,7 @@
>  #include <linux/swiotlb.h>
>  #include <linux/smp.h>
>  #include <linux/efi.h>
> +#include <linux/cmdline.h>
>  
>  #include <asm/cpu_ops.h>
>  #include <asm/early_ioremap.h>
> @@ -228,10 +229,8 @@ static void __init parse_dtb(void)
>  	}
>  
>  	pr_err("No DTB passed to the kernel\n");
> -#ifdef CONFIG_CMDLINE_FORCE
> -	strlcpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> +	cmdline_build(boot_command_line, NULL, COMMAND_LINE_SIZE);
>  	pr_info("Forcing kernel command line to: %s\n", boot_command_line);

Shouldn't that message become conditional in some way?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
