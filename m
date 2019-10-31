Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E066EA8D5
	for <lists+linux-arch@lfdr.de>; Thu, 31 Oct 2019 02:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfJaBeB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Oct 2019 21:34:01 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:22349 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfJaBeB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Oct 2019 21:34:01 -0400
X-Greylist: delayed 68041 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Oct 2019 21:33:59 EDT
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x9V1XblS010344;
        Thu, 31 Oct 2019 10:33:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x9V1XblS010344
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1572485618;
        bh=bp/M0yoU6XWG5FGhAIb3TMzMqQxSrCJgCA1yn97kfsQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bepu0HQtj2km9tsJjGfmcHRWgvBCy9PQixDLI2BqNjDpxR1mZXkyqL2hzJ+k+tDCK
         OgNeX5mD3j73WVVzLx33CKIPSSPcNvmqYoc5BnwPjqqn2Fb0wI7MxYeYoi6BdOcBKc
         hVqxXg3g8jPHBjwbaUiId4bJbTBUFIFQl8mvVKQiY2khMN4dhhi2D9wG196759fMoJ
         VKllNk/zKoN0r+hcC6mXXFB6v6gt8X3YByaYkb5a6vB8gfJUCIS7z/66QfvqTkUIE3
         dePXmDHyI001G8xbn4j+CFAv3XZQ9m6TiqnWmaKeqBl74g60NsDAJNyDK3kFizXYLS
         iNVrUZ44E/TTg==
X-Nifty-SrcIP: [209.85.222.49]
Received: by mail-ua1-f49.google.com with SMTP id o3so1312267ual.12;
        Wed, 30 Oct 2019 18:33:37 -0700 (PDT)
X-Gm-Message-State: APjAAAWVOpzo+cxHCxeS/Hz+4GztL/TICf7At2CdMFfmd3sV+ezuSv3I
        KR60v3lJ6LSADqAdR3ZIf1OkR619QXHMQISPvRU=
X-Google-Smtp-Source: APXvYqxc81LFapL9jQbAl/Jp9jDTGPd6bpNwimzNFfq1NBu7iKu4HEBediwWwcQA2Kk4XZiEWac1rp11E96eb0HJ1Sw=
X-Received: by 2002:ab0:710a:: with SMTP id x10mr1550343uan.25.1572485616550;
 Wed, 30 Oct 2019 18:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20191030063855.9989-1-yamada.masahiro@socionext.com>
In-Reply-To: <20191030063855.9989-1-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 31 Oct 2019 10:33:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNASrZpJ0J7N_YvSza2QQ_cQQ+Z04Cf5-Or4ivKMb9UVuMQ@mail.gmail.com>
Message-ID: <CAK7LNASrZpJ0J7N_YvSza2QQ_cQQ+Z04Cf5-Or4ivKMb9UVuMQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] arch: ipcbuf.h: make uapi asm/ipcbuf.h self-contained
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>
Cc:     linux-s390 <linux-s390@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Andrew,

I think this patch has already been picked up to your tree,
but I noticed a typo in the commit message just now.
Please see below.

On Wed, Oct 30, 2019 at 3:40 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> The user-space cannot compile <asm/ipcbuf.h> due to some missing type
> definitions. For example, building it for x86 fails as follows:
>
>   CC      usr/include/asm/ipcbuf.h.s
> In file included from ./usr/include/asm/ipcbuf.h:1:0,
>                  from <command-line>:32:
> ./usr/include/asm-generic/ipcbuf.h:21:2: error: unknown type name =E2=80=
=98__kernel_key_t=E2=80=99
>   __kernel_key_t  key;
>   ^~~~~~~~~~~~~~
> ./usr/include/asm-generic/ipcbuf.h:22:2: error: unknown type name =E2=80=
=98__kernel_uid32_t=E2=80=99
>   __kernel_uid32_t uid;
>   ^~~~~~~~~~~~~~~~
> ./usr/include/asm-generic/ipcbuf.h:23:2: error: unknown type name =E2=80=
=98__kernel_gid32_t=E2=80=99
>   __kernel_gid32_t gid;
>   ^~~~~~~~~~~~~~~~
> ./usr/include/asm-generic/ipcbuf.h:24:2: error: unknown type name =E2=80=
=98__kernel_uid32_t=E2=80=99
>   __kernel_uid32_t cuid;
>   ^~~~~~~~~~~~~~~~
> ./usr/include/asm-generic/ipcbuf.h:25:2: error: unknown type name =E2=80=
=98__kernel_gid32_t=E2=80=99
>   __kernel_gid32_t cgid;
>   ^~~~~~~~~~~~~~~~
> ./usr/include/asm-generic/ipcbuf.h:26:2: error: unknown type name =E2=80=
=98__kernel_mode_t=E2=80=99
>   __kernel_mode_t  mode;
>   ^~~~~~~~~~~~~~~
> ./usr/include/asm-generic/ipcbuf.h:28:35: error: =E2=80=98__kernel_mode_t=
=E2=80=99 undeclared here (not in a function)
>   unsigned char  __pad1[4 - sizeof(__kernel_mode_t)];
>                                    ^~~~~~~~~~~~~~~
> ./usr/include/asm-generic/ipcbuf.h:31:2: error: unknown type name =E2=80=
=98__kernel_ulong_t=E2=80=99
>   __kernel_ulong_t __unused1;
>   ^~~~~~~~~~~~~~~~
> ./usr/include/asm-generic/ipcbuf.h:32:2: error: unknown type name =E2=80=
=98__kernel_ulong_t=E2=80=99
>   __kernel_ulong_t __unused2;
>   ^~~~~~~~~~~~~~~~
>
> It is just a matter of missing include directive.
>
> Include <asm/posix_types.h> to make it self-contained, and add it to

Include <linux/posix_type.h> to make ...

Could you please fix it up locally?


Thank you.
Masahiro Yamada



> the compile-test coverage.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/s390/include/uapi/asm/ipcbuf.h   | 2 ++
>  arch/sparc/include/uapi/asm/ipcbuf.h  | 2 ++
>  arch/xtensa/include/uapi/asm/ipcbuf.h | 2 ++
>  include/uapi/asm-generic/ipcbuf.h     | 2 ++
>  usr/include/Makefile                  | 1 -
>  5 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/s390/include/uapi/asm/ipcbuf.h b/arch/s390/include/uapi=
/asm/ipcbuf.h
> index 5b1c4f47c656..1030cd186899 100644
> --- a/arch/s390/include/uapi/asm/ipcbuf.h
> +++ b/arch/s390/include/uapi/asm/ipcbuf.h
> @@ -2,6 +2,8 @@
>  #ifndef __S390_IPCBUF_H__
>  #define __S390_IPCBUF_H__
>
> +#include <linux/posix_types.h>
> +
>  /*
>   * The user_ipc_perm structure for S/390 architecture.
>   * Note extra padding because this structure is passed back and forth
> diff --git a/arch/sparc/include/uapi/asm/ipcbuf.h b/arch/sparc/include/ua=
pi/asm/ipcbuf.h
> index 9d0d125500e2..5b933a598a33 100644
> --- a/arch/sparc/include/uapi/asm/ipcbuf.h
> +++ b/arch/sparc/include/uapi/asm/ipcbuf.h
> @@ -2,6 +2,8 @@
>  #ifndef __SPARC_IPCBUF_H
>  #define __SPARC_IPCBUF_H
>
> +#include <linux/posix_types.h>
> +
>  /*
>   * The ipc64_perm structure for sparc/sparc64 architecture.
>   * Note extra padding because this structure is passed back and forth
> diff --git a/arch/xtensa/include/uapi/asm/ipcbuf.h b/arch/xtensa/include/=
uapi/asm/ipcbuf.h
> index a57afa0b606f..3bd0642f6660 100644
> --- a/arch/xtensa/include/uapi/asm/ipcbuf.h
> +++ b/arch/xtensa/include/uapi/asm/ipcbuf.h
> @@ -12,6 +12,8 @@
>  #ifndef _XTENSA_IPCBUF_H
>  #define _XTENSA_IPCBUF_H
>
> +#include <linux/posix_types.h>
> +
>  /*
>   * Pad space is left for:
>   * - 32-bit mode_t and seq
> diff --git a/include/uapi/asm-generic/ipcbuf.h b/include/uapi/asm-generic=
/ipcbuf.h
> index 7d80dbd336fb..41a01b494fc7 100644
> --- a/include/uapi/asm-generic/ipcbuf.h
> +++ b/include/uapi/asm-generic/ipcbuf.h
> @@ -2,6 +2,8 @@
>  #ifndef __ASM_GENERIC_IPCBUF_H
>  #define __ASM_GENERIC_IPCBUF_H
>
> +#include <linux/posix_types.h>
> +
>  /*
>   * The generic ipc64_perm structure:
>   * Note extra padding because this structure is passed back and forth
> diff --git a/usr/include/Makefile b/usr/include/Makefile
> index 57b20f7b6729..70f8fe256aed 100644
> --- a/usr/include/Makefile
> +++ b/usr/include/Makefile
> @@ -16,7 +16,6 @@ override c_flags =3D $(UAPI_CFLAGS) -Wp,-MD,$(depfile) =
-I$(objtree)/usr/include
>  # Please consider to fix the header first.
>  #
>  # Sorted alphabetically.
> -header-test- +=3D asm/ipcbuf.h
>  header-test- +=3D asm/msgbuf.h
>  header-test- +=3D asm/sembuf.h
>  header-test- +=3D asm/shmbuf.h
> --
> 2.17.1
>


--=20
Best Regards
Masahiro Yamada
