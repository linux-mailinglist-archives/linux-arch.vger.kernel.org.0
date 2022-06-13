Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D965549B24
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jun 2022 20:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244537AbiFMSKO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 13 Jun 2022 14:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243322AbiFMSJ6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jun 2022 14:09:58 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA2311A06;
        Mon, 13 Jun 2022 06:58:35 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1o0kaB-0000lz-EM; Mon, 13 Jun 2022 15:58:19 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     palmer@rivosinc.com, arnd@arndb.de, linux@roeck-us.net,
        palmer@dabbelt.com, guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] uapi: Fixup strace compile error
Date:   Mon, 13 Jun 2022 15:58:18 +0200
Message-ID: <5835624.lOV4Wx5bFT@diego>
In-Reply-To: <20220613013051.1741434-1-guoren@kernel.org>
References: <20220613013051.1741434-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Am Montag, 13. Juni 2022, 03:30:51 CEST schrieb guoren@kernel.org:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> There is no CONFIG_64BIT in userspace, we shouldn't limit it with
> __BITS_PER_LONG == 32 to break the compatibility. Just export F_*64
> definitions to userspace permanently.
> 
> gcc-11 -DHAVE_CONFIG_H   -I./linux/x86_64 -I../../../src/linux/x86_64
> -I./linux/generic -I../../../src/linux/generic -I. -I../../../src
> -DIN_STRACE=1      -isystem /opt/kernel/include -Wall -Wextra
> -Wno-missing-field-initializers -Wno-unused-parameter -Wdate-time
> -Wformat-security -Wimplicit-fallthrough=5 -Winit-self -Wlogical-op
> -Wmissing-prototypes -Wnested-externs -Wold-style-definition
> -Wtrampolines -Wundef -Wwrite-strings -Werror   -g -O2 -c -o
> libstrace_a-fetch_bpf_fprog.o `test -f 'fetch_bpf_fprog.c' || echo
> '../../../src/'`fetch_bpf_fprog.c
> In file included from ../../../src/defs.h:404,
>                  from ../../../src/fcntl.c:12:
> ../../../src/xlat/fcntlcmds.h:54:7: error: ‘F_GETLK64’ undeclared here
> (not in a function); did you mean ‘F_GETLK’?
>    54 |  XLAT(F_GETLK64),
>       |       ^~~~~~~~~
> ../../../src/xlat.h:64:54: note: in definition of macro ‘XLAT’
>    64 | # define XLAT(val)                      { (unsigned)(val), #val
>       }
>       |                                                      ^~~
> ../../../src/xlat/fcntlcmds.h:57:7: error: ‘F_SETLK64’ undeclared here
> (not in a function); did you mean ‘F_SETLK’?
>    57 |  XLAT(F_SETLK64),
>       |       ^~~~~~~~~
> ../../../src/xlat.h:64:54: note: in definition of macro ‘XLAT’
>    64 | # define XLAT(val)                      { (unsigned)(val), #val
>       }
>       |                                                      ^~~
> ../../../src/xlat/fcntlcmds.h:60:7: error: ‘F_SETLKW64’ undeclared here
> (not in a function); did you mean ‘F_SETLKW’?
>    60 |  XLAT(F_SETLKW64),
>       |       ^~~~~~~~~~
> ../../../src/xlat.h:64:54: note: in definition of macro ‘XLAT’
>    64 | # define XLAT(val)                      { (unsigned)(val), #val
>       }
>       |                                                      ^~~
> make[4]: *** [Makefile:5017: libstrace_a-fcntl.o] Error 1
> 
> comment by Eugene:
> Actually, it's quite the opposite: "ifndef" usage made it vailable at all
> times to the userspace, and this change has actually broken building strace
> with the latest kernel headers[1][2].  There could be some debate whether
> having these F_*64 definitions exposed to the user space 64-bit
> applications, but it seems that were no harm (as they were exposed already
> for quite some time), and they are useful at least for strace for compat
> application tracing purposes.
> 
> Fixes: 306f7cc1e9061 "uapi: always define F_GETLK64/F_SETLK64/F_SETLKW64 in fcntl.h"
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Reported-by: Eugene Syromiatnikov <esyr@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  include/uapi/asm-generic/fcntl.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
> index f13d37b60775..cd6bd65ec25d 100644
> --- a/include/uapi/asm-generic/fcntl.h
> +++ b/include/uapi/asm-generic/fcntl.h
> @@ -116,13 +116,11 @@
>  #define F_GETSIG	11	/* for sockets. */
>  #endif
>  
> -#if __BITS_PER_LONG == 32 || defined(__KERNEL__)
>  #ifndef F_GETLK64
>  #define F_GETLK64	12	/*  using 'struct flock64' */
>  #define F_SETLK64	13
>  #define F_SETLKW64	14
>  #endif
> -#endif /* __BITS_PER_LONG == 32 || defined(__KERNEL__) */

Looks like prviously there were a number of ways these constants
were ifdef'd - or not. A number of platforms already had no ifdef of
any sort around them before, so this looks like the sane way to do it.

Though in the original patch the special-mips-variant also gained the
	#if __BITS_PER_LONG == 32 ...
conditional in arch/mips/include/uapi/asm/fcntl.h .
So, is it also affected by this issue?


Heiko


