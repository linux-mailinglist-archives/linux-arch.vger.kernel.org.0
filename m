Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACFAEF4025
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2019 06:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfKHFw4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Nov 2019 00:52:56 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:26065 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfKHFw4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 00:52:56 -0500
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id xA85qa6Z026064;
        Fri, 8 Nov 2019 14:52:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com xA85qa6Z026064
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1573192357;
        bh=oze4vkDR6a97yj7MfBeCKtMK2B4lV6gmZ1gcgZSyTSQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S1QR/3aAJ/147DnqJVz4pn/qF0A8gdY8U6dCnOx5MVH4uDJ+02rlXmz71/XdokwOg
         7Yvh1mNya368a2qaDkeYgMUD7uI147rX49wprZSH0Hlh1oPMfQfHxzUZJnPSaka9hl
         22VCgMnM17vGtPVHte8ZSG1yPhc/v9Tv9j4HvyVw2pfs0P9N2lsJB2wc8gy2frHBVz
         GnNRFfZDZrHVGuIk23QszDp6kVgnwENrOc5ZLrOq1uJ/xaqavVOfMYMLUHXHthMvLO
         0K6fgy5dz34MQSaXneEL1ldUw3hviuVF2P7wo2YqHbz9NCM3gC1gduWSeH6cSEbayn
         P2nW4BVxE2OFg==
X-Nifty-SrcIP: [209.85.221.179]
Received: by mail-vk1-f179.google.com with SMTP id k19so1198579vke.10;
        Thu, 07 Nov 2019 21:52:37 -0800 (PST)
X-Gm-Message-State: APjAAAV9IwORv9fCBopfT7N/pqgkZeWzCZxOZBK3fJaL4600tmG4YZz/
        vNwdrC4KK3TXRz5soib71J6I35jMIfCopERgdrk=
X-Google-Smtp-Source: APXvYqwf6UskW8myjS2ENLGPYKbSWm2w0jIBBGQF/LzsPjrT0NYXExunWV9HevU28FxQXvEH/5oIohboL5JXuewrYFE=
X-Received: by 2002:a1f:18ca:: with SMTP id 193mr6058533vky.66.1573192355612;
 Thu, 07 Nov 2019 21:52:35 -0800 (PST)
MIME-Version: 1.0
References: <20191030063855.9989-1-yamada.masahiro@socionext.com> <20191030063855.9989-3-yamada.masahiro@socionext.com>
In-Reply-To: <20191030063855.9989-3-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 8 Nov 2019 14:51:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR3Runh-eLQ7_wLodvo3_+d13UctAzEzbJgWoYnf998jw@mail.gmail.com>
Message-ID: <CAK7LNAR3Runh-eLQ7_wLodvo3_+d13UctAzEzbJgWoYnf998jw@mail.gmail.com>
Subject: Re: [PATCH 3/3] arch: sembuf.h: make uapi asm/sembuf.h self-contained
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-s390 <linux-s390@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Andrew,

I think you modified the commit log before applying this patch.
I just noticed a typo.


commit 411865d8dd2c31f56eefc54bc16fabb47e1bfb73
Author: Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed Nov 6 16:07:08 2019 +1100

    arch: sembuf.h: make uapi asm/sembuf.h self-contained

    Uuserspace cannot compile <asm/sembuf.h> due to some missing type
    definitions.  For example, building it for x86 fails as follows:



If possible, could you fix up  s/Uuserspace/Userspace/  ?


Thanks.
Masahiro Yamada





On Wed, Oct 30, 2019 at 3:40 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> The user-space cannot compile <asm/sembuf.h> due to some missing type
> definitions. For example, building it for x86 fails as follows:
>
>   CC      usr/include/asm/sembuf.h.s
> In file included from <command-line>:32:0:
> ./usr/include/asm/sembuf.h:17:20: error: field =E2=80=98sem_perm=E2=80=99=
 has incomplete type
>   struct ipc64_perm sem_perm; /* permissions .. see ipc.h */
>                     ^~~~~~~~
> ./usr/include/asm/sembuf.h:24:2: error: unknown type name =E2=80=98__kern=
el_time_t=E2=80=99
>   __kernel_time_t sem_otime; /* last semop time */
>   ^~~~~~~~~~~~~~~
> ./usr/include/asm/sembuf.h:25:2: error: unknown type name =E2=80=98__kern=
el_ulong_t=E2=80=99
>   __kernel_ulong_t __unused1;
>   ^~~~~~~~~~~~~~~~
> ./usr/include/asm/sembuf.h:26:2: error: unknown type name =E2=80=98__kern=
el_time_t=E2=80=99
>   __kernel_time_t sem_ctime; /* last change time */
>   ^~~~~~~~~~~~~~~
> ./usr/include/asm/sembuf.h:27:2: error: unknown type name =E2=80=98__kern=
el_ulong_t=E2=80=99
>   __kernel_ulong_t __unused2;
>   ^~~~~~~~~~~~~~~~
> ./usr/include/asm/sembuf.h:29:2: error: unknown type name =E2=80=98__kern=
el_ulong_t=E2=80=99
>   __kernel_ulong_t sem_nsems; /* no. of semaphores in array */
>   ^~~~~~~~~~~~~~~~
> ./usr/include/asm/sembuf.h:30:2: error: unknown type name =E2=80=98__kern=
el_ulong_t=E2=80=99
>   __kernel_ulong_t __unused3;
>   ^~~~~~~~~~~~~~~~
> ./usr/include/asm/sembuf.h:31:2: error: unknown type name =E2=80=98__kern=
el_ulong_t=E2=80=99
>   __kernel_ulong_t __unused4;
>   ^~~~~~~~~~~~~~~~
>
> It is just a matter of missing include directive.
>
> Include <asm/ipcbuf.h> to make it self-contained, and add it to
> the compile-test coverage.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/mips/include/uapi/asm/sembuf.h    | 2 ++
>  arch/parisc/include/uapi/asm/sembuf.h  | 1 +
>  arch/powerpc/include/uapi/asm/sembuf.h | 2 ++
>  arch/sparc/include/uapi/asm/sembuf.h   | 2 ++
>  arch/x86/include/uapi/asm/sembuf.h     | 2 ++
>  arch/xtensa/include/uapi/asm/sembuf.h  | 1 +
>  include/uapi/asm-generic/sembuf.h      | 1 +
>  usr/include/Makefile                   | 1 -
>  8 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/include/uapi/asm/sembuf.h b/arch/mips/include/uapi=
/asm/sembuf.h
> index 60c89e6cb25b..7d135b93bebd 100644
> --- a/arch/mips/include/uapi/asm/sembuf.h
> +++ b/arch/mips/include/uapi/asm/sembuf.h
> @@ -2,6 +2,8 @@
>  #ifndef _ASM_SEMBUF_H
>  #define _ASM_SEMBUF_H
>
> +#include <asm/ipcbuf.h>
> +
>  /*
>   * The semid64_ds structure for the MIPS architecture.
>   * Note extra padding because this structure is passed back and forth
> diff --git a/arch/parisc/include/uapi/asm/sembuf.h b/arch/parisc/include/=
uapi/asm/sembuf.h
> index 3c31163b1241..b17a2460b184 100644
> --- a/arch/parisc/include/uapi/asm/sembuf.h
> +++ b/arch/parisc/include/uapi/asm/sembuf.h
> @@ -3,6 +3,7 @@
>  #define _PARISC_SEMBUF_H
>
>  #include <asm/bitsperlong.h>
> +#include <asm/ipcbuf.h>
>
>  /*
>   * The semid64_ds structure for parisc architecture.
> diff --git a/arch/powerpc/include/uapi/asm/sembuf.h b/arch/powerpc/includ=
e/uapi/asm/sembuf.h
> index 3f60946f77e3..f42c9c3502c7 100644
> --- a/arch/powerpc/include/uapi/asm/sembuf.h
> +++ b/arch/powerpc/include/uapi/asm/sembuf.h
> @@ -2,6 +2,8 @@
>  #ifndef _ASM_POWERPC_SEMBUF_H
>  #define _ASM_POWERPC_SEMBUF_H
>
> +#include <asm/ipcbuf.h>
> +
>  /*
>   * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public License
> diff --git a/arch/sparc/include/uapi/asm/sembuf.h b/arch/sparc/include/ua=
pi/asm/sembuf.h
> index f3d309c2e1cd..5d7764cdf80f 100644
> --- a/arch/sparc/include/uapi/asm/sembuf.h
> +++ b/arch/sparc/include/uapi/asm/sembuf.h
> @@ -2,6 +2,8 @@
>  #ifndef _SPARC_SEMBUF_H
>  #define _SPARC_SEMBUF_H
>
> +#include <asm/ipcbuf.h>
> +
>  /*
>   * The semid64_ds structure for sparc architecture.
>   * Note extra padding because this structure is passed back and forth
> diff --git a/arch/x86/include/uapi/asm/sembuf.h b/arch/x86/include/uapi/a=
sm/sembuf.h
> index 89de6cd9f0a7..da0464af7aa6 100644
> --- a/arch/x86/include/uapi/asm/sembuf.h
> +++ b/arch/x86/include/uapi/asm/sembuf.h
> @@ -2,6 +2,8 @@
>  #ifndef _ASM_X86_SEMBUF_H
>  #define _ASM_X86_SEMBUF_H
>
> +#include <asm/ipcbuf.h>
> +
>  /*
>   * The semid64_ds structure for x86 architecture.
>   * Note extra padding because this structure is passed back and forth
> diff --git a/arch/xtensa/include/uapi/asm/sembuf.h b/arch/xtensa/include/=
uapi/asm/sembuf.h
> index 09f348d643f1..3b9cdd406dfe 100644
> --- a/arch/xtensa/include/uapi/asm/sembuf.h
> +++ b/arch/xtensa/include/uapi/asm/sembuf.h
> @@ -22,6 +22,7 @@
>  #define _XTENSA_SEMBUF_H
>
>  #include <asm/byteorder.h>
> +#include <asm/ipcbuf.h>
>
>  struct semid64_ds {
>         struct ipc64_perm sem_perm;             /* permissions .. see ipc=
.h */
> diff --git a/include/uapi/asm-generic/sembuf.h b/include/uapi/asm-generic=
/sembuf.h
> index 0bae010f1b64..5807fcd643ba 100644
> --- a/include/uapi/asm-generic/sembuf.h
> +++ b/include/uapi/asm-generic/sembuf.h
> @@ -3,6 +3,7 @@
>  #define __ASM_GENERIC_SEMBUF_H
>
>  #include <asm/bitsperlong.h>
> +#include <asm/ipcbuf.h>
>
>  /*
>   * The semid64_ds structure for x86 architecture.
> diff --git a/usr/include/Makefile b/usr/include/Makefile
> index 099d7401aa23..107d04bd5ee3 100644
> --- a/usr/include/Makefile
> +++ b/usr/include/Makefile
> @@ -16,7 +16,6 @@ override c_flags =3D $(UAPI_CFLAGS) -Wp,-MD,$(depfile) =
-I$(objtree)/usr/include
>  # Please consider to fix the header first.
>  #
>  # Sorted alphabetically.
> -header-test- +=3D asm/sembuf.h
>  header-test- +=3D asm/shmbuf.h
>  header-test- +=3D asm/signal.h
>  header-test- +=3D asm/ucontext.h
> --
> 2.17.1
>


--=20
Best Regards
Masahiro Yamada
