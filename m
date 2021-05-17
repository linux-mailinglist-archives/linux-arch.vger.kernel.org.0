Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8898C3825D3
	for <lists+linux-arch@lfdr.de>; Mon, 17 May 2021 09:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbhEQHvP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 May 2021 03:51:15 -0400
Received: from mail-ua1-f41.google.com ([209.85.222.41]:35487 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbhEQHvO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 May 2021 03:51:14 -0400
Received: by mail-ua1-f41.google.com with SMTP id n61so1816797uan.2;
        Mon, 17 May 2021 00:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wm1leRczzFOwOFaSNT2IC1vyfbeH7BGd9FvIHYCsh/w=;
        b=CpX4nJZ0xQ+qCL0hsY5+pyieu90VHU3tQCSnspR6kXgmozyl4YvwqZSKFy2F4YjWN7
         zX1PYHEqH3z75ysGzaRh3NTZSafJyHfBa7oXLJ44yl7oXUOVdkLincPPA8R3uNPiGKi/
         +ZdAPUOmRjQICeVQn0Xvym5P5TvBeYSHY6LYaEucWCagAhQGOiY77PGG+ceJjjzJvJvU
         gIMdGawghORqiqs3Z1jEg2wbY24Mdi3gACew6JtM+at5GYb83Hy6HQN96rprf1yvCy8n
         euQxbf/IAJ/20fp1aBtfr+bWirPU39M/R5vAarQ7VlhX/qZFXrplSkq3mnxRZeTMp8mu
         DzHA==
X-Gm-Message-State: AOAM5338yq5Dt/vDQJk2W8g7VoK+Y1DA7sZr+l/Bf5qfdgylr97uOqPC
        c/Mm7qK6q8HzMX2wKTxg/I216oSCPhkRLTSXxVw=
X-Google-Smtp-Source: ABdhPJxMkbz10U6Jg7YSgioxoN/77aKbpd9YpL153uII/i6U1HGzQThHJEqUHqKW1WMKKAc41kkz+IhZpWsMRXHngY4=
X-Received: by 2002:ab0:f5:: with SMTP id 108mr16323124uaj.106.1621237797742;
 Mon, 17 May 2021 00:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210514220942.879805-1-arnd@kernel.org> <20210514220942.879805-5-arnd@kernel.org>
In-Reply-To: <20210514220942.879805-5-arnd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 May 2021 09:49:45 +0200
Message-ID: <CAMuHMdXPWdNqeeyCuKheOyTT-DSqrhKQyotmY5YBhdbz-VgfwA@mail.gmail.com>
Subject: Re: [PATCH 4/5] asm-generic: uaccess: remove inline strncpy_from_user/strnlen_user
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Brian Cain <bcain@codeaurora.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Sid Manning <sidneym@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-um <linux-um@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 15, 2021 at 12:11 AM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Consolidate the asm-generic implementation with the library version
> that is used everywhere else.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

>  arch/m68k/Kconfig             |  4 +--

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
