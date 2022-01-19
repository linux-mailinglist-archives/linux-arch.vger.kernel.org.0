Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26BE14938F3
	for <lists+linux-arch@lfdr.de>; Wed, 19 Jan 2022 11:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344916AbiASKzd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Jan 2022 05:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344215AbiASKzd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Jan 2022 05:55:33 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD56EC06173E
        for <linux-arch@vger.kernel.org>; Wed, 19 Jan 2022 02:55:32 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id d3so7620286lfv.13
        for <linux-arch@vger.kernel.org>; Wed, 19 Jan 2022 02:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hv19+FUuJFtOAO6iaJuAnBrt1u4EzLcgQ5Z0F046cSc=;
        b=b10bWonVa7wm11a1lLLgw2lVosLMoECr73kDitwGxNeQIDjcIoxbhUE2y8Y1nCL0sZ
         3RizJd53LvzeMjHdK6ZD1P3jaTxeIJqI0H/980mbnQHQYQS2zvjVgpP2Q2TAisklLSwJ
         BbEUVv2Me5t7kP+rJ2faWuz3VRVVrG9IN4YJKCzAwUodDBdCQ3jh3BsQvm89I8VUR5rE
         4EAwom6ri3PPq5oB8tyrGwM1leXTpn+2unLTvOLkFffIlY4ICJh98eK/PRBmVUfRKkeL
         h8Oa+zVqhnPN3N3Lfphur1o4cz0ULaXNZQka62N51olyeC5EXkkLvHPEXsiQkxzr/CFz
         YKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hv19+FUuJFtOAO6iaJuAnBrt1u4EzLcgQ5Z0F046cSc=;
        b=Y+Vi/j69M18ExP+no+ubbZNn6tgtAub6g29Fna+rW/Y3oV6F2hxGYRTbVWAd/UM7Tu
         N1/hABTbI3LD2xW3cfhOrGuVZISx9gs07zXVQ0yMkRMPtMHsIICmDIFB+Yjg1MQYnx4C
         vfBnT9OHDVLtYy/wBPqTq9LyhRVD1NOiF/x6K1IYYwf0XyDiZSli2D4K5EhMiCUSDYFE
         yfbEn8Kpg4BMJfA3/UIgVQwrV2paeY8qINlVTJIA16vUyPUjE3sF+r4dh680Ru3/Rw34
         wOfWuSDuj9oeM89gpnysZh4Gh9xFDX3zoKHmUbbBcHhqmPMlJ8XkbbKcfZ4uK0YiQ+8K
         8cpg==
X-Gm-Message-State: AOAM533K1j6DmZivr/akJa+vE46fgQ+uT6HSZ4oJzfI9S1GYLc+M/LLT
        NIKD231qeH17oZQmrerJFuJea6dt/Jb23q7mEu6Qcg==
X-Google-Smtp-Source: ABdhPJy3QGVuAvoUQBcShKcLI+7zAxF67RgJ0fDrXQFaK/tU+aAU07QEp2wdslWpjbpv3BMHE84aXFNgkxel9dEdm8c=
X-Received: by 2002:a05:6512:1293:: with SMTP id u19mr24170479lfs.373.1642589731024;
 Wed, 19 Jan 2022 02:55:31 -0800 (PST)
MIME-Version: 1.0
References: <20220119085719.1357874-1-daniel.lezcano@linaro.org> <20220119085719.1357874-2-daniel.lezcano@linaro.org>
In-Reply-To: <20220119085719.1357874-2-daniel.lezcano@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 19 Jan 2022 11:54:54 +0100
Message-ID: <CAPDyKFp1s+Xvg5bE3J9GV6gkLB0vKDd1YdVdMPW-+vpAqiKcjA@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] powercap/drivers/dtpm: Convert the init table
 section to a simple array
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, robh@kernel.org, lukasz.luba@arm.com,
        heiko@sntech.de, arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 19 Jan 2022 at 09:57, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The init table section is freed after the system booted. However the
> next changes will make per module the DTPM description, so the table
> won't be accessible when the module is loaded.
>
> In order to fix that, we should move the table to the data section
> where there are very few entries and that makes strange to add it
> there.
>
> The main goal of the table was to keep self-encapsulated code and we
> can keep it almost as it by using an array instead.
>
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks for updating!

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/powercap/dtpm.c           |  2 ++
>  drivers/powercap/dtpm_cpu.c       |  5 ++++-
>  drivers/powercap/dtpm_subsys.h    | 18 ++++++++++++++++++
>  include/asm-generic/vmlinux.lds.h | 11 -----------
>  include/linux/dtpm.h              | 24 +++---------------------
>  5 files changed, 27 insertions(+), 33 deletions(-)
>  create mode 100644 drivers/powercap/dtpm_subsys.h
>
> diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
> index 8cb45f2d3d78..0e5c93443c70 100644
> --- a/drivers/powercap/dtpm.c
> +++ b/drivers/powercap/dtpm.c
> @@ -24,6 +24,8 @@
>  #include <linux/slab.h>
>  #include <linux/mutex.h>
>
> +#include "dtpm_subsys.h"
> +
>  #define DTPM_POWER_LIMIT_FLAG 0
>
>  static const char *constraint_name[] = {
> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> index b740866b228d..5763e0ce2af5 100644
> --- a/drivers/powercap/dtpm_cpu.c
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -269,4 +269,7 @@ static int __init dtpm_cpu_init(void)
>         return 0;
>  }
>
> -DTPM_DECLARE(dtpm_cpu, dtpm_cpu_init);
> +struct dtpm_subsys_ops dtpm_cpu_ops = {
> +       .name = KBUILD_MODNAME,
> +       .init = dtpm_cpu_init,
> +};
> diff --git a/drivers/powercap/dtpm_subsys.h b/drivers/powercap/dtpm_subsys.h
> new file mode 100644
> index 000000000000..2a3a2055f60e
> --- /dev/null
> +++ b/drivers/powercap/dtpm_subsys.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2022 Linaro Ltd
> + *
> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> + */
> +#ifndef ___DTPM_SUBSYS_H__
> +#define ___DTPM_SUBSYS_H__
> +
> +extern struct dtpm_subsys_ops dtpm_cpu_ops;
> +
> +struct dtpm_subsys_ops *dtpm_subsys[] = {
> +#ifdef CONFIG_DTPM_CPU
> +       &dtpm_cpu_ops,
> +#endif
> +};
> +
> +#endif
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 42f3866bca69..2a10db2f0bc5 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -321,16 +321,6 @@
>  #define THERMAL_TABLE(name)
>  #endif
>
> -#ifdef CONFIG_DTPM
> -#define DTPM_TABLE()                                                   \
> -       . = ALIGN(8);                                                   \
> -       __dtpm_table = .;                                               \
> -       KEEP(*(__dtpm_table))                                           \
> -       __dtpm_table_end = .;
> -#else
> -#define DTPM_TABLE()
> -#endif
> -
>  #define KERNEL_DTB()                                                   \
>         STRUCT_ALIGN();                                                 \
>         __dtb_start = .;                                                \
> @@ -723,7 +713,6 @@
>         ACPI_PROBE_TABLE(irqchip)                                       \
>         ACPI_PROBE_TABLE(timer)                                         \
>         THERMAL_TABLE(governor)                                         \
> -       DTPM_TABLE()                                                    \
>         EARLYCON_TABLE()                                                \
>         LSM_TABLE()                                                     \
>         EARLY_LSM_TABLE()                                               \
> diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
> index d37e5d06a357..506048158a50 100644
> --- a/include/linux/dtpm.h
> +++ b/include/linux/dtpm.h
> @@ -32,29 +32,11 @@ struct dtpm_ops {
>         void (*release)(struct dtpm *);
>  };
>
> -typedef int (*dtpm_init_t)(void);
> -
> -struct dtpm_descr {
> -       dtpm_init_t init;
> +struct dtpm_subsys_ops {
> +       const char *name;
> +       int (*init)(void);
>  };
>
> -/* Init section thermal table */
> -extern struct dtpm_descr __dtpm_table[];
> -extern struct dtpm_descr __dtpm_table_end[];
> -
> -#define DTPM_TABLE_ENTRY(name, __init)                         \
> -       static struct dtpm_descr __dtpm_table_entry_##name      \
> -       __used __section("__dtpm_table") = {                    \
> -               .init = __init,                                 \
> -       }
> -
> -#define DTPM_DECLARE(name, init)       DTPM_TABLE_ENTRY(name, init)
> -
> -#define for_each_dtpm_table(__dtpm)    \
> -       for (__dtpm = __dtpm_table;     \
> -            __dtpm < __dtpm_table_end; \
> -            __dtpm++)
> -
>  static inline struct dtpm *to_dtpm(struct powercap_zone *zone)
>  {
>         return container_of(zone, struct dtpm, zone);
> --
> 2.25.1
>
