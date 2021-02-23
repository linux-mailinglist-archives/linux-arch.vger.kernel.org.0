Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CA0322994
	for <lists+linux-arch@lfdr.de>; Tue, 23 Feb 2021 12:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhBWLh3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Feb 2021 06:37:29 -0500
Received: from mail-40134.protonmail.ch ([185.70.40.134]:10920 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbhBWLh1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Feb 2021 06:37:27 -0500
Date:   Tue, 23 Feb 2021 11:36:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1614080204; bh=jv9tL4u29gVpzSBS59HCvCUVd6Rj3pWoR+fnneLx15A=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=VKk652/EGtE5Cpi6lODpKNnBP2HuuuCiPYsjeJ5xh0JzwmeD5ccfJpzDuhf2chAev
         JVduJgzSNQUq/s3Hi5JFCse15vul4QCHvaVIwNqsNzose3rfHCewveJTeFPZCUjWxR
         kDWs5ScAJyi2hc6KrmQhB7hRx+4lhRpRcK3aZ3vfz2SuKYdYBWdfqXvopmi6/fzv7x
         8NK8o6FJZG5MDjk5IWi+vy5/fxH0is4DbRGn+qnG98buqg3fPg2C8Q2d4fOrCq76nu
         4A7iEX+qXYxgAx/pzW96JfahVJoThqVzo4eIyhRexANzcSZ5TPT8vvxeH+mYjIFhwX
         b4J7SK3WHFMsA==
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Pei Huang <huangpei@loongson.cn>,
        Kees Cook <keescook@chromium.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Fangrui Song <maskray@google.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Corey Minyard <cminyard@mvista.com>,
        kernel test robot <lkp@intel.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: Re: [PATCH mips-fixes] vmlinux.lds.h: catch even more instrumentation symbols into .data
Message-ID: <20210223113600.7009-2-alobakin@pm.me>
In-Reply-To: <20210223113600.7009-1-alobakin@pm.me>
References: <20210223113600.7009-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> LKP caught another bunch of orphaned instrumentation symbols [0]:
>
> mipsel-linux-ld: warning: orphan section `.data.$LPBX1' from
> `init/main.o' being placed in section `.data.$LPBX1'
> mipsel-linux-ld: warning: orphan section `.data.$LPBX0' from
> `init/main.o' being placed in section `.data.$LPBX0'
> mipsel-linux-ld: warning: orphan section `.data.$LPBX1' from
> `init/do_mounts.o' being placed in section `.data.$LPBX1'
> mipsel-linux-ld: warning: orphan section `.data.$LPBX0' from
> `init/do_mounts.o' being placed in section `.data.$LPBX0'
> mipsel-linux-ld: warning: orphan section `.data.$LPBX1' from
> `init/do_mounts_initrd.o' being placed in section `.data.$LPBX1'
> mipsel-linux-ld: warning: orphan section `.data.$LPBX0' from
> `init/do_mounts_initrd.o' being placed in section `.data.$LPBX0'
> mipsel-linux-ld: warning: orphan section `.data.$LPBX1' from
> `init/initramfs.o' being placed in section `.data.$LPBX1'
> mipsel-linux-ld: warning: orphan section `.data.$LPBX0' from
> `init/initramfs.o' being placed in section `.data.$LPBX0'
> mipsel-linux-ld: warning: orphan section `.data.$LPBX1' from
> `init/calibrate.o' being placed in section `.data.$LPBX1'
> mipsel-linux-ld: warning: orphan section `.data.$LPBX0' from
> `init/calibrate.o' being placed in section `.data.$LPBX0'
>
> [...]
>
> Soften the wildcard to .data.$L* to grab these ones into .data too.
>
> [0] https://lore.kernel.org/lkml/202102231519.lWPLPveV-lkp@intel.com
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> ---
>  include/asm-generic/vmlinux.lds.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi Thomas,

This applies on top of mips-next or Linus' tree, so you may need to
rebase mips-fixes before taking it.
It's not for mips-next as it should go into this cycle as a [hot]fix.
I haven't added any "Fixes:" tag since these warnings is a result
of merging several sets and of certain build configurations that
almost couldn't be tested separately.

> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmli=
nux.lds.h
> index 01a3fd6a64d2..c887ac36c1b4 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -95,7 +95,7 @@
>   */
>  #ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
>  #define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
> -#define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..L* .data..compoundlit=
eral* .data.$__unnamed_* .data.$Lubsan_*
> +#define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..L* .data..compoundlit=
eral* .data.$__unnamed_* .data.$L*
>  #define SDATA_MAIN .sdata .sdata.[0-9a-zA-Z_]*
>  #define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]* .rodata..L*
>  #define BSS_MAIN .bss .bss.[0-9a-zA-Z_]* .bss..compoundliteral*
> --
> 2.30.1

Thanks,
Al

