Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEB99185ED2
	for <lists+linux-arch@lfdr.de>; Sun, 15 Mar 2020 19:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgCOSNF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 15 Mar 2020 14:13:05 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35553 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgCOSNF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 15 Mar 2020 14:13:05 -0400
Received: by mail-ot1-f68.google.com with SMTP id k26so15572772otr.2;
        Sun, 15 Mar 2020 11:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sUWxzwalztrbVHkKPVnLn6brXKU37JI+sM+O4Ra8rhs=;
        b=lq4yIQjEt2Hva+LcSSsImPTWVkqQaZfajPDIstvHN3u4DJApTyrnSyYM/mWt9r57IS
         7NCAZPtKcTXZDKZuGgA8uSvuBawx/VzEj21I7wvoOML/QaX7gnK4TcEJ8jiw4iSXKX2H
         NKgvZMsDKBeerFxLlMHeI4paXpjuhvscgBxKAveI5e3hh1yeHGJEIQ2kThld6jiU2xbH
         aCvvbdNgDngXTBS7GeVxsftzbF3/98o7ntEnNGIl2n/Z4Y3t7XjRn23a7DS67UKlIwFs
         HFpi+eUM0v8zHK+8PmHoYngJ/8V1G/bwoMFzyDy4mY2mMrsuD3TWG4XWpn/5bwA8GsPv
         ogkA==
X-Gm-Message-State: ANhLgQ3iicHLLXHqe368Gg5iGwFhjUYyZ8z/qcK0Vo+Hws3DYQJiTBjY
        8/ISs0c2pDqlsyksgXLYyNQbPvpCDWqbjGzGerA=
X-Google-Smtp-Source: ADFU+vuljzpiAOboo4aW31HwprwvTT5TAdtHnEFj+Bt3WiCyoSI14V4Qib0nSclh//AsNushyf+apHwC0RArd/Opt60=
X-Received: by 2002:a9d:6a47:: with SMTP id h7mr2572485otn.297.1584295982859;
 Sun, 15 Mar 2020 11:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200315175108.9694-1-romain.naour@gmail.com> <20200315175108.9694-2-romain.naour@gmail.com>
In-Reply-To: <20200315175108.9694-2-romain.naour@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 15 Mar 2020 19:12:51 +0100
Message-ID: <CAMuHMdV7N4cxCmyv-eXa1Cnx9pnQLr-cuwAbNwwG-4YyKodgeA@mail.gmail.com>
Subject: Re: [PATCH 2/2] include/asm-generic: vmlinux.lds.h
To:     Romain Naour <romain.naour@gmail.com>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>,
        Alan Modra <amodra@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

CC arnd, linux-arch

On Sun, Mar 15, 2020 at 6:51 PM Romain Naour <romain.naour@gmail.com> wrote:
> Since the patch [1], building the kernel using a toolchain built with
> Binutils 2.33.1 prevent booting a sh4 system under Qemu.
> Apply the patch provided by Alan Modra [2] that fix alignment of rodata.
>
> [1] https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;h=ebd2263ba9a9124d93bbc0ece63d7e0fae89b40e
> [2] https://www.sourceware.org/ml/binutils/2019-12/msg00112.html
>
> Signed-off-by: Romain Naour <romain.naour@gmail.com>
> Cc: Alan Modra <amodra@gmail.com>
> ---
>  include/asm-generic/vmlinux.lds.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index e00f41aa8ec4..d46d34b58c96 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -374,6 +374,7 @@
>   */
>  #ifndef RO_AFTER_INIT_DATA
>  #define RO_AFTER_INIT_DATA                                             \
> +       . = ALIGN(8);                                                   \
>         __start_ro_after_init = .;                                      \
>         *(.data..ro_after_init)                                         \
>         JUMP_TABLE_DATA                                                 \
> --
> 2.24.1
