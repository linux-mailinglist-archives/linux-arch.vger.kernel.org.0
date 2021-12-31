Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B5C482434
	for <lists+linux-arch@lfdr.de>; Fri, 31 Dec 2021 14:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhLaNeU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Dec 2021 08:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhLaNeU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Dec 2021 08:34:20 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9767FC061574
        for <linux-arch@vger.kernel.org>; Fri, 31 Dec 2021 05:34:19 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id j11so58553792lfg.3
        for <linux-arch@vger.kernel.org>; Fri, 31 Dec 2021 05:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wp/ltEVoPdzx2pRrEQ4BgyolvgNnR0QMjtwXZXnrtlw=;
        b=iJgVB5rwvhuY7YqV1NkNfAfGGzf3TsdX+4Yvwz+pt4/gquZhGZvP6eouNx6pVtQmQx
         Y4/cKGy4OMIlCsWlgJMlmX7nXH0J7tkezAKvB70haBI7YFAQXX1VWNAxVLB9GSt/x7zL
         oj70jZ5FUcOIw5KhZIBQrrZkC5kOT4qLtbmw0fXa6/7cSSmg+VFZjVCarnNUem/Vw/l6
         3/fMA3eyE/dgMBlhJqkwakQCLWnqmTIYsnzR/Q8w1tHguBwB+c9cPGWV/NXMt03vgf9h
         RGOemVhzhGdPcStcVEdgzYZGRdXmLMtuEygLD+Q3LljaF4c+tYjJ0OF5YEKAlHfplTMj
         VfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wp/ltEVoPdzx2pRrEQ4BgyolvgNnR0QMjtwXZXnrtlw=;
        b=Q8Oqae3CCeJfuTIKal3k5AIP48TIC/vnlLZKksih+Qir6jkkmtX7sWdRJuH7jT5O3L
         OPiTbEKsdZUXtss43Hm+M+WW37JfLU/PcTEzve3oMzzTLMaQ6pnQzAZXdQybm/jTzbpb
         g9+cflNqQ4xsi090oRzXB6Cbig4fZZJSzvdyu2YsGKfUq0cXLYfZIjxFEMokj+sFdrRj
         H0xGmYV1uDbxrP9kii40tjqMZ6uVGYwepU/oy05ZJShFmCAM6FiFAqJ/5bD4bPBISKbb
         fsizfjiRJlpxMbSqTNNKone4aQB11GljX3gsBQ8rhK2xxhBqhvHdu5dhfba2XxmrhjVb
         Uxig==
X-Gm-Message-State: AOAM530qp3J8QeTsVCpYGhQk15w7lDkZZdRvu6jJ39naeQTVLoiCZVbe
        brH3h9T2NR696LkleME7yi8VqxGbPmwVo+vzYtZLAmz8OKw7hA==
X-Google-Smtp-Source: ABdhPJyRGhHv/2JtqLwUHFfFhC+MlVhOY4g6rwByr1LJ1qx2O3WBLs8LcdIWIt/sNquPovNd06q+x9OHrETHj/cwPtw=
X-Received: by 2002:a05:6512:3d9e:: with SMTP id k30mr31899208lfv.184.1640957657751;
 Fri, 31 Dec 2021 05:34:17 -0800 (PST)
MIME-Version: 1.0
References: <20211218130014.4037640-1-daniel.lezcano@linaro.org> <20211218130014.4037640-2-daniel.lezcano@linaro.org>
In-Reply-To: <20211218130014.4037640-2-daniel.lezcano@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 31 Dec 2021 14:33:41 +0100
Message-ID: <CAPDyKFpY4i0Mtb==8zknsuG0HdhPW2fXFvEN+AJScVmT65A-ow@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] powercap/drivers/dtpm: Move dtpm table from init
 to data section
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, lukasz.luba@arm.com, robh@kernel.org,
        heiko@sntech.de, arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 18 Dec 2021 at 14:00, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The dtpm table is used to let the different dtpm backends to register
> their setup callbacks in a single place and preventing to export
> multiple functions all around the kernel. That allows the dtpm code to
> be self-encapsulated.

Well, that's not entirely true. The dtpm code and its backends (or
ops, whatever we call them) are already maintained from a single
place, the /drivers/powercap/* directory. I assume we intend to keep
it like this going forward too, right?

That is also what patch4 with the devfreq backend continues to conform to.

>
> The dtpm hierarchy will be passed as a parameter by a platform
> specific code and that will lead to the creation of the different dtpm
> nodes.
>
> The function creating the hierarchy could be called from a module at
> init time or when it is loaded. However, at this moment the table is
> already freed as it belongs to the init section and the creation will
> lead to a invalid memory access.
>
> Fix this by moving the table to the data section.

With the above said, I find it a bit odd to put a table in the data
section like this. Especially, since the only remaining argument for
why, is to avoid exporting functions, which isn't needed anyway.

I mean, it would be silly if we should continue to put subsystem
specific tables in here, to just let them contain a set of subsystem
specific callbacks.

>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Kind regards
Uffe

> ---
>  include/asm-generic/vmlinux.lds.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 42f3866bca69..50d494d94d6c 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -362,7 +362,8 @@
>         BRANCH_PROFILE()                                                \
>         TRACE_PRINTKS()                                                 \
>         BPF_RAW_TP()                                                    \
> -       TRACEPOINT_STR()
> +       TRACEPOINT_STR()                                                \
> +       DTPM_TABLE()
>
>  /*
>   * Data section helpers
> @@ -723,7 +724,6 @@
>         ACPI_PROBE_TABLE(irqchip)                                       \
>         ACPI_PROBE_TABLE(timer)                                         \
>         THERMAL_TABLE(governor)                                         \
> -       DTPM_TABLE()                                                    \
>         EARLYCON_TABLE()                                                \
>         LSM_TABLE()                                                     \
>         EARLY_LSM_TABLE()                                               \
> --
> 2.25.1
>
