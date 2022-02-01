Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9314A5493
	for <lists+linux-arch@lfdr.de>; Tue,  1 Feb 2022 02:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbiBABQn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jan 2022 20:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiBABQm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jan 2022 20:16:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25EBC061714;
        Mon, 31 Jan 2022 17:16:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80F91B821E6;
        Tue,  1 Feb 2022 01:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8CAC340E8;
        Tue,  1 Feb 2022 01:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643678199;
        bh=SiaprZtsbmIByPda5if7yP4S3qTQaX2CMcJuefUGDKk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qOlocfnYjy/jF9UZ67g/M/ExV0XvO67aaNYB+FZkbtlYDi48cmlBRlZhEXWbP8Ae7
         eYkCoe1RJh1MjU4osvh8utpTaRc9nCpeKkZdG1qjdGqJfNsWUKBqKVvbP9W+O+O21F
         ZBFX7gvLtbSal2OiR51Xu9x253nAAItkmYviVcjMIRynvmAx6L+9rfjRcLXv0hVnxF
         5jx9yrr54hADg4g+hSvIyemHzmXfDP8050L1Wmrxv8JBxKGV2mq2lpeROyz/SZ3eTF
         tNhoSwW2uqSYY4qJU3PE+P4p6KX/64r4Mb7CXTkHwbapVu1p7HnWxCzTVy1UbBT8tR
         46QACMtSzx2xA==
Received: by mail-ua1-f47.google.com with SMTP id e17so12905635uad.9;
        Mon, 31 Jan 2022 17:16:39 -0800 (PST)
X-Gm-Message-State: AOAM5319gogn16G7lXK5t1TuAZX6N8RHLDbHT5zvo7PeBH+3B8eqSMQa
        hxbrcTPt3PkMi1/nES1EHMqzYX0swHV/ObU/Js8=
X-Google-Smtp-Source: ABdhPJxWLBDyOJOGeSWO+apAtkye8u+6OgeQZNAJBFBTM1KwFxdAT0Qwyi0qpOrXa/BhnrxjpnZuE4ZnTHXGEOOwSZ8=
X-Received: by 2002:ab0:2092:: with SMTP id r18mr8891303uak.66.1643678198369;
 Mon, 31 Jan 2022 17:16:38 -0800 (PST)
MIME-Version: 1.0
References: <20220131064933.3780271-1-hch@lst.de> <20220131064933.3780271-2-hch@lst.de>
In-Reply-To: <20220131064933.3780271-2-hch@lst.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 1 Feb 2022 09:16:27 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTjj8DXByP44DsC47xB2W_88j5Qp7TyEnRQCfUvHQUixA@mail.gmail.com>
Message-ID: <CAJF2gTTjj8DXByP44DsC47xB2W_88j5Qp7TyEnRQCfUvHQUixA@mail.gmail.com>
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

This patch should be:

diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index ecd0f5bdfc1d..220ae6d32e7b 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -193,32 +193,28 @@ struct f_owner_ex {
 #define F_LINUX_SPECIFIC_BASE  1024

 #ifndef HAVE_ARCH_STRUCT_FLOCK
-#ifndef __ARCH_FLOCK_PAD
-#define __ARCH_FLOCK_PAD
-#endif
-
 struct flock {
        short   l_type;
        short   l_whence;
        __kernel_off_t  l_start;
        __kernel_off_t  l_len;
        __kernel_pid_t  l_pid;
+#ifdef __ARCH_FLOCK_PAD
        __ARCH_FLOCK_PAD
-};
 #endif
-
-#ifndef HAVE_ARCH_STRUCT_FLOCK64
-#ifndef __ARCH_FLOCK64_PAD
-#define __ARCH_FLOCK64_PAD
+}
 #endif

+#ifndef HAVE_ARCH_STRUCT_FLOCK64
 struct flock64 {
        short  l_type;
        short  l_whence;
        __kernel_loff_t l_start;
        __kernel_loff_t l_len;
        __kernel_pid_t  l_pid;
+#ifdef __ARCH_FLOCK64_PAD
        __ARCH_FLOCK64_PAD
+#endif
 };

Right?

Seems you've based on an old tree, right?

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
