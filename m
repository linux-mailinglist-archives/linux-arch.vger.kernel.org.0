Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29934D7442
	for <lists+linux-arch@lfdr.de>; Sun, 13 Mar 2022 11:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbiCMKjB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 13 Mar 2022 06:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbiCMKjA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 13 Mar 2022 06:39:00 -0400
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D333F117E;
        Sun, 13 Mar 2022 03:37:49 -0700 (PDT)
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id BAEDC72C90A;
        Sun, 13 Mar 2022 13:29:07 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id B01877CE0CA; Sun, 13 Mar 2022 13:29:07 +0300 (MSK)
Date:   Sun, 13 Mar 2022 13:29:07 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] shmbuf.h: add asm/shmbuf.h to UAPI compile-test
 coverage
Message-ID: <20220313102907.GC28782@altlinux.org>
References: <20220210021129.3386083-1-masahiroy@kernel.org>
 <20220210021129.3386083-3-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220210021129.3386083-3-masahiroy@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 10, 2022 at 11:11:25AM +0900, Masahiro Yamada wrote:
> asm/shmbuf.h is currently excluded from the UAPI compile-test because of
> the errors like follows:
> 
>     HDRTEST usr/include/asm/shmbuf.h
>   In file included from ./usr/include/asm/shmbuf.h:6,
>                    from <command-line>:
>   ./usr/include/asm-generic/shmbuf.h:26:33: error: field ‘shm_perm’ has incomplete type
>      26 |         struct ipc64_perm       shm_perm;       /* operation perms */
>         |                                 ^~~~~~~~
>   ./usr/include/asm-generic/shmbuf.h:27:9: error: unknown type name ‘size_t’
>      27 |         size_t                  shm_segsz;      /* size of segment (bytes) */
>         |         ^~~~~~
>   ./usr/include/asm-generic/shmbuf.h:40:9: error: unknown type name ‘__kernel_pid_t’
>      40 |         __kernel_pid_t          shm_cpid;       /* pid of creator */
>         |         ^~~~~~~~~~~~~~
>   ./usr/include/asm-generic/shmbuf.h:41:9: error: unknown type name ‘__kernel_pid_t’
>      41 |         __kernel_pid_t          shm_lpid;       /* pid of last operator */
>         |         ^~~~~~~~~~~~~~
> 
> The errors can be fixed by replacing size_t with __kernel_size_t and by
> including proper headers.
> 
> Then, remove the no-header-test entry from user/include/Makefile.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

This is essentially the same patch as
https://lore.kernel.org/lkml/20211227105303.GA25101@altlinux.org/

Apparently, some people are more lucky in getting their patches reviewed.

[...]
> diff --git a/arch/mips/include/uapi/asm/shmbuf.h b/arch/mips/include/uapi/asm/shmbuf.h
> index 680bb95b2240..eb74d304b779 100644
> --- a/arch/mips/include/uapi/asm/shmbuf.h
> +++ b/arch/mips/include/uapi/asm/shmbuf.h
> @@ -2,6 +2,9 @@
>  #ifndef _ASM_SHMBUF_H
>  #define _ASM_SHMBUF_H
>  
> +#include <asm/ipcbuf.h>
> +#include <asm/posix_types.h>

There is no need to include <asm/posix_types.h> since <asm/ipcbuf.h>
already includes it, but there is no harm either.

[...]
> diff --git a/arch/parisc/include/uapi/asm/shmbuf.h b/arch/parisc/include/uapi/asm/shmbuf.h
> index 5da3089be65e..532da742fb56 100644
> --- a/arch/parisc/include/uapi/asm/shmbuf.h
> +++ b/arch/parisc/include/uapi/asm/shmbuf.h
> @@ -3,6 +3,8 @@
>  #define _PARISC_SHMBUF_H
>  
>  #include <asm/bitsperlong.h>
> +#include <asm/ipcbuf.h>
> +#include <asm/posix_types.h>

Likewise.

[...]
> diff --git a/arch/powerpc/include/uapi/asm/shmbuf.h b/arch/powerpc/include/uapi/asm/shmbuf.h
> index 00422b2f3c63..439a3a02ba64 100644
> --- a/arch/powerpc/include/uapi/asm/shmbuf.h
> +++ b/arch/powerpc/include/uapi/asm/shmbuf.h
> @@ -2,6 +2,9 @@
>  #ifndef _ASM_POWERPC_SHMBUF_H
>  #define _ASM_POWERPC_SHMBUF_H
>  
> +#include <asm/ipcbuf.h>
> +#include <asm/posix_types.h>

Likewise.

[...]
> diff --git a/arch/sparc/include/uapi/asm/shmbuf.h b/arch/sparc/include/uapi/asm/shmbuf.h
> index a5d7d8d681c4..ed4f061c7a15 100644
> --- a/arch/sparc/include/uapi/asm/shmbuf.h
> +++ b/arch/sparc/include/uapi/asm/shmbuf.h
> @@ -2,6 +2,9 @@
>  #ifndef _SPARC_SHMBUF_H
>  #define _SPARC_SHMBUF_H
>  
> +#include <asm/ipcbuf.h>
> +#include <asm/posix_types.h>

Likewise.

[...]
> diff --git a/arch/x86/include/uapi/asm/shmbuf.h b/arch/x86/include/uapi/asm/shmbuf.h
> index fce18eaa070c..13775bfdfee2 100644
> --- a/arch/x86/include/uapi/asm/shmbuf.h
> +++ b/arch/x86/include/uapi/asm/shmbuf.h
> @@ -5,6 +5,10 @@
>  #if !defined(__x86_64__) || !defined(__ILP32__)
>  #include <asm-generic/shmbuf.h>
>  #else
> +
> +#include <asm/ipcbuf.h>
> +#include <asm/posix_types.h>

Likewise.

[...]
> diff --git a/arch/xtensa/include/uapi/asm/shmbuf.h b/arch/xtensa/include/uapi/asm/shmbuf.h
> index 554a57a6a90f..bb8bdddae9b5 100644
> --- a/arch/xtensa/include/uapi/asm/shmbuf.h
> +++ b/arch/xtensa/include/uapi/asm/shmbuf.h
> @@ -20,9 +20,12 @@
>  #ifndef _XTENSA_SHMBUF_H
>  #define _XTENSA_SHMBUF_H
>  
> +#include <asm/ipcbuf.h>
> +#include <asm/posix_types.h>

Likewise.

[...]
> diff --git a/include/uapi/asm-generic/shmbuf.h b/include/uapi/asm-generic/shmbuf.h
> index 2bab955e0fed..2979b6dd2c56 100644
> --- a/include/uapi/asm-generic/shmbuf.h
> +++ b/include/uapi/asm-generic/shmbuf.h
> @@ -3,6 +3,8 @@
>  #define __ASM_GENERIC_SHMBUF_H
>  
>  #include <asm/bitsperlong.h>
> +#include <asm/ipcbuf.h>
> +#include <asm/posix_types.h>

Likewise.


-- 
ldv
