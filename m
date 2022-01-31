Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCC34A4681
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jan 2022 13:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbiAaMDj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jan 2022 07:03:39 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58876 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351754AbiAaMDS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jan 2022 07:03:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECED060EDB;
        Mon, 31 Jan 2022 12:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5670EC340E8;
        Mon, 31 Jan 2022 12:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643630596;
        bh=Tnl+b+xRnsReNq4KI429Am7kpgJQ0umrjTVla4lsCuM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fNYKVUnPHi4fB2RDVXN/XPov3Pzxn5A1kXwyz+7LOx0xtVsOdQVaSlptA3l6sPO0f
         drJ5QpM53lfVQOzGgCce6B3pLahQ7QGSlaLrpdhyAkJ8SULgXKHPGWHnYSLBvsBQ/t
         fs/0QUMACIndc/Oow7jaQyp72tjLmz/jpvKWB2XfcgrdeWAoLhIVtNkmROpwMglSMu
         MW+xwZqT00PRi0JLtYRicH1AppTKRmYG0WNykLZJqhzgiPwG33xGGGt1Ay/gpwP/2v
         R401bXofdi6TFPmB02Zav6cD1va7JnpIDrlctwFhFD/4xkKrfZp28yMy+9f7Qys9S9
         Esu0cmt5m7xVQ==
Received: by mail-vk1-f172.google.com with SMTP id u25so4747487vkk.3;
        Mon, 31 Jan 2022 04:03:16 -0800 (PST)
X-Gm-Message-State: AOAM5324krgYKGNBX9IlVyffx+2TS5qnkW9VzucVmgUDNubn/Os1xvZf
        idD+tV8jjy0IR/oldNfUFdAXJ+FFkQWxiRoYJ5E=
X-Google-Smtp-Source: ABdhPJzu/ltAZiRAPd2aiKC5Md3QokBpxOCcs120Jm2RVZ0hBQuqkRXhXkFbZurLz6s8XNLjpnUnIx3259o3xCGjxlQ=
X-Received: by 2002:a1f:640e:: with SMTP id y14mr8092831vkb.2.1643630595330;
 Mon, 31 Jan 2022 04:03:15 -0800 (PST)
MIME-Version: 1.0
References: <20220131064933.3780271-1-hch@lst.de> <20220131064933.3780271-2-hch@lst.de>
In-Reply-To: <20220131064933.3780271-2-hch@lst.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 31 Jan 2022 20:03:04 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRH0H-7XzH2-_4UK17CZXrVBf8Hfr59RuJPLgezZ1trdg@mail.gmail.com>
Message-ID: <CAJF2gTRH0H-7XzH2-_4UK17CZXrVBf8Hfr59RuJPLgezZ1trdg@mail.gmail.com>
Subject: Re: [PATCH 1/5] uapi: remove the unused HAVE_ARCH_STRUCT_FLOCK64 define
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Mon, Jan 31, 2022 at 2:49 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/uapi/asm-generic/fcntl.h       | 2 --
>  tools/include/uapi/asm-generic/fcntl.h | 2 --
>  2 files changed, 4 deletions(-)
>
> diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
> index ecd0f5bdfc1d6..caa482e3b01af 100644
> --- a/include/uapi/asm-generic/fcntl.h
> +++ b/include/uapi/asm-generic/fcntl.h
> @@ -207,7 +207,6 @@ struct flock {
>  };
>  #endif
>
> -#ifndef HAVE_ARCH_STRUCT_FLOCK64
>  #ifndef __ARCH_FLOCK64_PAD
>  #define __ARCH_FLOCK64_PAD
>  #endif
> @@ -220,6 +219,5 @@ struct flock64 {
>         __kernel_pid_t  l_pid;
>         __ARCH_FLOCK64_PAD
>  };
> -#endif
>
>  #endif /* _ASM_GENERIC_FCNTL_H */
> diff --git a/tools/include/uapi/asm-generic/fcntl.h b/tools/include/uapi/asm-generic/fcntl.h
> index ac190958c9814..4a49d33ca4d55 100644
> --- a/tools/include/uapi/asm-generic/fcntl.h
> +++ b/tools/include/uapi/asm-generic/fcntl.h
> @@ -202,7 +202,6 @@ struct flock {
>  };
>  #endif
>
> -#ifndef HAVE_ARCH_STRUCT_FLOCK64
>  #ifndef __ARCH_FLOCK64_PAD
>  #define __ARCH_FLOCK64_PAD
>  #endif
> @@ -215,6 +214,5 @@ struct flock64 {
>         __kernel_pid_t  l_pid;
>         __ARCH_FLOCK64_PAD
>  };
> -#endif
>
>  #endif /* _ASM_GENERIC_FCNTL_H */
> --
> 2.30.2
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
