Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABE2144020
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2020 16:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgAUPFh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jan 2020 10:05:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:42696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbgAUPFh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Jan 2020 10:05:37 -0500
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72C6D21569;
        Tue, 21 Jan 2020 15:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579619136;
        bh=ZipuNGCTBSu38FXFqjUfvBa1esJyOnZj1CxEHVnqEwU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PtbYcQvcLfgPPJFqYK8wAxFKdnWOOzRqJKEbKKqhM8cGSImD5VvPzxDYnkgnuC0HL
         mYa6R7sxRYhBP6xpnxsF+qRUQ2QgomqN/xBrsH7ElxiWHyBkSeMuez/Yy+xCUKnMga
         zuFu/5jXVv4TCA7ry6rgFjUNEYkj66bk55hfbrlI=
Received: by mail-lj1-f175.google.com with SMTP id w1so3144510ljh.5;
        Tue, 21 Jan 2020 07:05:36 -0800 (PST)
X-Gm-Message-State: APjAAAUZI/RLKaRhDy1sJ9LidtcD3G4jNi8OtoV9EO79TdC+saQEXD57
        bj5NLUPJhMCiEHRuYYBHvl+P63bnWFDuGoL2Ev8=
X-Google-Smtp-Source: APXvYqyyP7mlbRDitUaS+MHQ51rqYNoNjvIigwyRLg/5leOsqJaMz5djTTK8rZOatcjbiHNge19/xgqyQu+FoQYoosY=
X-Received: by 2002:a2e:89d0:: with SMTP id c16mr16637414ljk.228.1579619134609;
 Tue, 21 Jan 2020 07:05:34 -0800 (PST)
MIME-Version: 1.0
References: <1579603800-25146-1-git-send-email-majun258@linux.alibaba.com>
In-Reply-To: <1579603800-25146-1-git-send-email-majun258@linux.alibaba.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 21 Jan 2020 23:05:23 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRp-9ivwnjQ5Xcni6z4h7j3VRJ3LmbVzLysF-osehoAJQ@mail.gmail.com>
Message-ID: <CAJF2gTRp-9ivwnjQ5Xcni6z4h7j3VRJ3LmbVzLysF-osehoAJQ@mail.gmail.com>
Subject: Re: [PATCH] csky: Fix the compile error when enable ck860
To:     MaJun <majun258@linux.alibaba.com>
Cc:     mj145409@alibaba-inc.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi MaJun,

On Tue, Jan 21, 2020 at 8:25 PM MaJun <majun258@linux.alibaba.com> wrote:
>
> There is a compile error when ck860 processor is choosed.
> To fix this compile error, the FPU config should be disabled.
>
> Signed-off-by: MaJun <majun258@linux.alibaba.com>
> ---
>  arch/csky/Kconfig           | 2 +-
>  arch/csky/configs/defconfig | 7 -------
Kconfig and defconfig should be separate patches.

>  2 files changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index 3973847..f6ad4c6 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -154,7 +154,7 @@ config CPU_CK860
>         select CPU_HAS_TLBI
>         select CPU_HAS_CACHEV2
>         select CPU_HAS_LDSTEX
> -       select CPU_HAS_FPUV2
> +       select CPU_HAS_FPUV2 if CPU_HAS_FPU
Not right.

config CPU_HAS_FPUV2
         depends on CPU_HAS_FPU
         bool
How ?

>  endchoice
>
>  choice
> diff --git a/arch/csky/configs/defconfig b/arch/csky/configs/defconfig
> index 7ef4289..ad9591c 100644
> --- a/arch/csky/configs/defconfig
> +++ b/arch/csky/configs/defconfig
> @@ -10,9 +10,6 @@ CONFIG_BSD_PROCESS_ACCT=y
>  CONFIG_BSD_PROCESS_ACCT_V3=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
> -CONFIG_DEFAULT_DEADLINE=y
> -CONFIG_CPU_CK807=y
> -CONFIG_CPU_HAS_FPU=y
>  CONFIG_NET=y
>  CONFIG_PACKET=y
>  CONFIG_UNIX=y
> @@ -27,10 +24,7 @@ CONFIG_SERIAL_NONSTANDARD=y
>  CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
>  CONFIG_SERIAL_OF_PLATFORM=y
> -CONFIG_TTY_PRINTK=y
>  # CONFIG_VGA_CONSOLE is not set
> -CONFIG_CSKY_MPTIMER=y
> -CONFIG_GX6605S_TIMER=y
>  CONFIG_PM_DEVFREQ=y
>  CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
>  CONFIG_DEVFREQ_GOV_PERFORMANCE=y
> @@ -56,6 +50,5 @@ CONFIG_CRAMFS=y
>  CONFIG_ROMFS_FS=y
>  CONFIG_NFS_FS=y
>  CONFIG_PRINTK_TIME=y
> -CONFIG_DEBUG_INFO=y
>  CONFIG_DEBUG_FS=y
>  CONFIG_MAGIC_SYSRQ=y
> --
> 1.8.3.1
>
Agree about defconfig

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
