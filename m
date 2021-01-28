Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4930D30713E
	for <lists+linux-arch@lfdr.de>; Thu, 28 Jan 2021 09:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbhA1ISP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 Jan 2021 03:18:15 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:44346 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbhA1ISB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Jan 2021 03:18:01 -0500
Received: by mail-oi1-f181.google.com with SMTP id n7so5156687oic.11;
        Thu, 28 Jan 2021 00:17:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TL3tp80ch5Ojmt15uhmuDBGqfvQ8YwjAwOvbZ3H5gho=;
        b=tY3YuKIqmRaJkzI6nyvtPbLy7yOjbbcQeeta0rppuamco2UVGIKwuoYnzU/mS2cuCa
         Ibamgeb2O5+vQdjjnN696vcSzs8mC7ZXmKlofm53bFYUcaL1+aOq7YvQO+PguzMUch8W
         yvlkCIm8ATu4GO/qmCHI7dAF1AENN008sW7eJNY1mjmigcole/y8mHbOzYE8wWoLWFDg
         coeLdrhY2B7iJaFDSxQPGjmmaRf1xGOsuRO+JkmqZG1/0V0Ee0d8bqapmcXHL6awaUYO
         eicZlAtaA/2pKlzF/fwB6oAt1G507kOpCrW0M1r6L3raHHiTTwFHDTKGo/Z7CYJouJXo
         PkCQ==
X-Gm-Message-State: AOAM530ZiPFrc2eXuKfnEVWqVmWGMlkhvzMgONMyEbJTJpybRxE6DULP
        qnDHyS/Yd+Cepqo4PYhqh8wV12Oi65jHiCdObok=
X-Google-Smtp-Source: ABdhPJyaplo6/NZAAIS02LBbY6W1dLxYDZ/X0XB3GuIXLfaRgiB9Cco71R6713OCRdUcK2cT17+0m9PEdnGKkCz70nI=
X-Received: by 2002:aca:1219:: with SMTP id 25mr5943005ois.54.1611821840178;
 Thu, 28 Jan 2021 00:17:20 -0800 (PST)
MIME-Version: 1.0
References: <20210128005110.2613902-1-masahiroy@kernel.org> <20210128005110.2613902-13-masahiroy@kernel.org>
In-Reply-To: <20210128005110.2613902-13-masahiroy@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Jan 2021 09:17:09 +0100
Message-ID: <CAMuHMdV_AHcnGoVToHLXa95JEd4wcL3eTqYfk6=7Ou0W8VJR5w@mail.gmail.com>
Subject: Re: [PATCH 12/27] m68k: syscalls: switch to generic syscalltbl.sh
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        alpha <linux-alpha@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Yamada-san,

On Thu, Jan 28, 2021 at 1:54 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> As of v5.11-rc1, 12 architectures duplicate similar shell scripts in
> order to generate syscall table headers. My goal is to unify them into
> the single scripts/syscalltbl.sh.
>
> This commit converts m68k to use scripts/syscalltbl.sh.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks a lot!

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
