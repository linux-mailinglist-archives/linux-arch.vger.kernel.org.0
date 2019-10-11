Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA0CD3A43
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 09:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfJKHtY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Oct 2019 03:49:24 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37328 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfJKHtY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Oct 2019 03:49:24 -0400
Received: by mail-ot1-f68.google.com with SMTP id k32so7200763otc.4;
        Fri, 11 Oct 2019 00:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cXN+zRgmCQohqXmd61dtsclsBrxaUdjkWuLDpZ7x1eg=;
        b=COmSH8lMqsRhwcQgjIf7DYyIQ79i5Yi+/aTG24ZMJbHeKBXN+3XJwwxEMVaXlb4xca
         TkUjssp5ibE/4JMUg+zuGFj3fTAY6qCwFaiYRJfCuwX5lYXmFDu0BmKA5fMxGyYcPQww
         1nuiRubEW9rZP/SPdhLZLH9CmK1ZSEwZBVrfr9YIZOUGvJiLgZwVxHvV8F3pqoA72klJ
         45vLOKvfoIXCe6mGJ6FegixxHXmdvuz8lPQjq3voEpIlZqZA9IuMVp7ApTuYPaTtYiz1
         3Q0sWEZKjPXralVQDmAtHTSbDTbEv6M5Ct1p+7pHG43P2Bw7PTJ/5dpZsmMdtbEwTf9Q
         o6Hw==
X-Gm-Message-State: APjAAAVEc/ykruojrpubaWu+vVplF2xXo2Kgt9pcoDFti2kTkhTrTWz4
        X+Mpdipjy4awokU4qAn4qMeomw1qs9JERiF2XhY=
X-Google-Smtp-Source: APXvYqwqVxfC2cNUYKhwcqXPFeJg2d1bFBSsmVLGAXW7oEd6d1E5TBDxF8h/vtJ2zwm35tbMgZpLEGXynIDHXf1hv80=
X-Received: by 2002:a05:6830:1544:: with SMTP id l4mr3638195otp.297.1570780163122;
 Fri, 11 Oct 2019 00:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20191011000609.29728-1-keescook@chromium.org> <20191011000609.29728-14-keescook@chromium.org>
In-Reply-To: <20191011000609.29728-14-keescook@chromium.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 11 Oct 2019 09:49:12 +0200
Message-ID: <CAMuHMdXiSboG2xum0ZgjpwBxEaP-owywvPpmUubr1nuqzDPJ4Q@mail.gmail.com>
Subject: Re: [PATCH v2 13/29] vmlinux.lds.h: Replace RW_DATA_SECTION with RW_DATA
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

On Fri, Oct 11, 2019 at 2:07 AM Kees Cook <keescook@chromium.org> wrote:
> Rename RW_DATA_SECTION to RW_DATA. (Calling this a "section" is a lie,
> since it's multiple sections and section flags cannot be applied to
> the macro.)
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

>  arch/m68k/kernel/vmlinux-nommu.lds   | 2 +-
>  arch/m68k/kernel/vmlinux-std.lds     | 2 +-
>  arch/m68k/kernel/vmlinux-sun3.lds    | 2 +-

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
