Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91A81F7947
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2019 17:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfKKQ6S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Nov 2019 11:58:18 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38250 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfKKQ6S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Nov 2019 11:58:18 -0500
Received: by mail-oi1-f196.google.com with SMTP id a14so12092567oid.5;
        Mon, 11 Nov 2019 08:58:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N5Vcj3yE2rkXP4doP0O2V7gRihUnv+nSjX4pf/13Rw8=;
        b=CBQ8W26nBhfvyynYKCEr3k8TGOtrtm34pDWrxm8OKM7Um9zQELtwz7Umd1M/a6q8Mi
         Onlte7cJBZM/IajBJgyVCrO1wacbaIh/ws+ue+BsmgLhbtThvvFKBs602VdJbQkt/CXu
         CmWa51IaSDH4hnQUuJpCm2FcvVpAXPYVqoDA8mWAFIRfCnxU9gKgBFR2QJ1aZfoWWhiz
         WoIdYP+9++Y2feuBw5/gKL2Ke8sd2f6XlgPYionZf2kwaaityTsdGBnoMNtP12Y2XWFF
         RLAkdyR+pOj1alVTcfuWhByYoYDkHMH1MgKwbB9k63qBkauP4Yor8yI9HM/Yr8ZLo6MR
         bs0w==
X-Gm-Message-State: APjAAAUHXO2fEm89dRaWb3V9JHhwcK3sJ+QcJL7RokoyXfyCOgZip+hS
        JiDyK5/jBvsdjxM3r2XN9eFHc5BwGqc8LxHCzOw=
X-Google-Smtp-Source: APXvYqy/vMjYcYeqIvTqdLd5GGnLez7ZmWGDKl5AqUc+6PF8GisVTiuTjJisyx2dw7CZpTj+GRrxuJBIdtOSyrbYjfw=
X-Received: by 2002:aca:fc92:: with SMTP id a140mr23499698oii.153.1573491497306;
 Mon, 11 Nov 2019 08:58:17 -0800 (PST)
MIME-Version: 1.0
References: <20191011000609.29728-1-keescook@chromium.org> <20191011000609.29728-12-keescook@chromium.org>
In-Reply-To: <20191011000609.29728-12-keescook@chromium.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Nov 2019 17:58:06 +0100
Message-ID: <CAMuHMdXfPyti1wFBb0hhf3CeDSQ=zVv7cV-taeYCmDswMQkXPQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/29] vmlinux.lds.h: Replace RODATA with RO_DATA
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Will Deacon <will@kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        alpha <linux-alpha@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Kees,

On Fri, Oct 11, 2019 at 2:07 AM Kees Cook <keescook@chromium.org> wrote:
> There's no reason to keep the RODATA macro: replace the callers with
> the expected RO_DATA macro.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/alpha/kernel/vmlinux.lds.S      | 2 +-
>  arch/ia64/kernel/vmlinux.lds.S       | 2 +-
>  arch/microblaze/kernel/vmlinux.lds.S | 2 +-
>  arch/mips/kernel/vmlinux.lds.S       | 2 +-
>  arch/um/include/asm/common.lds.S     | 2 +-
>  arch/xtensa/kernel/vmlinux.lds.S     | 2 +-
>  include/asm-generic/vmlinux.lds.h    | 4 +---
>  7 files changed, 7 insertions(+), 9 deletions(-)

Somehow you missed:

    arch/m68k/kernel/vmlinux-std.lds:  RODATA
    arch/m68k/kernel/vmlinux-sun3.lds:      RODATA

Leading to build failures in next-20191111:

    /opt/cross/kisskb/gcc-4.6.3-nolibc/m68k-linux/bin/m68k-linux-ld:./arch/m68k/kernel/vmlinux.lds:29:
syntax error
    make[1]: *** [/kisskb/src/Makefile:1075: vmlinux] Error 1

Reported-by: noreply@ellerman.id.au
http://kisskb.ellerman.id.au/kisskb/buildresult/14022846/

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
