Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EF35895DA
	for <lists+linux-arch@lfdr.de>; Thu,  4 Aug 2022 04:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237422AbiHDCKi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Aug 2022 22:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238910AbiHDCK2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Aug 2022 22:10:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A0FFE1;
        Wed,  3 Aug 2022 19:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDB55B82445;
        Thu,  4 Aug 2022 02:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11C0C433D7;
        Thu,  4 Aug 2022 02:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659579019;
        bh=aos4nr+dtzFt6+Lm052jknDjKBTWPYtcY7YwyUOYPj0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WZl6UN78qvLHW8FE+EnMxhqVI81/Fxs4sy8zr87dCCkh1Lj61LWcrhH6HaNjhC0uQ
         B8oAT8tXiyyMBeEGORbRhTM0oAPifzGPGJ0NfhJwGlwt1XA8J7FTent/K+JTQKnaS8
         Fq5YM4LZ40eLfcPm1h7VuhCx8Uvdyu7H76KYPKMSqJdfnuzBNMX5XuH37wrPHFrmsg
         j0jQXnW88MOAh3Fjqki4ELOG5Q0Llk2zly7c3PusvyLtd6AmHvNDsbjpKCU+oPNsDx
         FAmUawwOTLHxv+pPgJTueC0jlbfM6juSiGbI5cl0PyVkj0AyjJ15ILeDjE+uRzGavK
         cCLmviopwGuwg==
Received: by mail-oi1-f180.google.com with SMTP id h125so21794725oif.8;
        Wed, 03 Aug 2022 19:10:19 -0700 (PDT)
X-Gm-Message-State: ACgBeo17zpu8XEU67VbS9hYqVYFyhxiv/9WNEtBBIcDqEADXd3GuQqpj
        n6wtv9HNvm5T80KWXXwxx6mYGsyZ7aFue7tFMLw=
X-Google-Smtp-Source: AA6agR4tKOhfTMa8wkamlaYfmSOJJCRR2txdEupJqG9wDd7SQnyP89ZdfWXvXC5gce9oxdYNtydIOFtaS9M5oRVJC1o=
X-Received: by 2002:a05:6808:a10:b0:33a:d654:bf98 with SMTP id
 n16-20020a0568080a1000b0033ad654bf98mr2905634oij.112.1659579018934; Wed, 03
 Aug 2022 19:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220613013051.1741434-1-guoren@kernel.org> <5835624.lOV4Wx5bFT@diego>
In-Reply-To: <5835624.lOV4Wx5bFT@diego>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 4 Aug 2022 10:10:06 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSotQqmwCMq8Yvg11sZLhfBYONZviJqGBf0eJ9PXKEssg@mail.gmail.com>
Message-ID: <CAJF2gTSotQqmwCMq8Yvg11sZLhfBYONZviJqGBf0eJ9PXKEssg@mail.gmail.com>
Subject: Re: [PATCH] uapi: Fixup strace compile error
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 13, 2022 at 9:58 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Montag, 13. Juni 2022, 03:30:51 CEST schrieb guoren@kernel.org:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > There is no CONFIG_64BIT in userspace, we shouldn't limit it with
> > __BITS_PER_LONG =3D=3D 32 to break the compatibility. Just export F_*64
> > definitions to userspace permanently.
> >
> > gcc-11 -DHAVE_CONFIG_H   -I./linux/x86_64 -I../../../src/linux/x86_64
> > -I./linux/generic -I../../../src/linux/generic -I. -I../../../src
> > -DIN_STRACE=3D1      -isystem /opt/kernel/include -Wall -Wextra
> > -Wno-missing-field-initializers -Wno-unused-parameter -Wdate-time
> > -Wformat-security -Wimplicit-fallthrough=3D5 -Winit-self -Wlogical-op
> > -Wmissing-prototypes -Wnested-externs -Wold-style-definition
> > -Wtrampolines -Wundef -Wwrite-strings -Werror   -g -O2 -c -o
> > libstrace_a-fetch_bpf_fprog.o `test -f 'fetch_bpf_fprog.c' || echo
> > '../../../src/'`fetch_bpf_fprog.c
> > In file included from ../../../src/defs.h:404,
> >                  from ../../../src/fcntl.c:12:
> > ../../../src/xlat/fcntlcmds.h:54:7: error: =E2=80=98F_GETLK64=E2=80=99 =
undeclared here
> > (not in a function); did you mean =E2=80=98F_GETLK=E2=80=99?
> >    54 |  XLAT(F_GETLK64),
> >       |       ^~~~~~~~~
> > ../../../src/xlat.h:64:54: note: in definition of macro =E2=80=98XLAT=
=E2=80=99
> >    64 | # define XLAT(val)                      { (unsigned)(val), #val
> >       }
> >       |                                                      ^~~
> > ../../../src/xlat/fcntlcmds.h:57:7: error: =E2=80=98F_SETLK64=E2=80=99 =
undeclared here
> > (not in a function); did you mean =E2=80=98F_SETLK=E2=80=99?
> >    57 |  XLAT(F_SETLK64),
> >       |       ^~~~~~~~~
> > ../../../src/xlat.h:64:54: note: in definition of macro =E2=80=98XLAT=
=E2=80=99
> >    64 | # define XLAT(val)                      { (unsigned)(val), #val
> >       }
> >       |                                                      ^~~
> > ../../../src/xlat/fcntlcmds.h:60:7: error: =E2=80=98F_SETLKW64=E2=80=99=
 undeclared here
> > (not in a function); did you mean =E2=80=98F_SETLKW=E2=80=99?
> >    60 |  XLAT(F_SETLKW64),
> >       |       ^~~~~~~~~~
> > ../../../src/xlat.h:64:54: note: in definition of macro =E2=80=98XLAT=
=E2=80=99
> >    64 | # define XLAT(val)                      { (unsigned)(val), #val
> >       }
> >       |                                                      ^~~
> > make[4]: *** [Makefile:5017: libstrace_a-fcntl.o] Error 1
> >
> > comment by Eugene:
> > Actually, it's quite the opposite: "ifndef" usage made it vailable at a=
ll
> > times to the userspace, and this change has actually broken building st=
race
> > with the latest kernel headers[1][2].  There could be some debate wheth=
er
> > having these F_*64 definitions exposed to the user space 64-bit
> > applications, but it seems that were no harm (as they were exposed alre=
ady
> > for quite some time), and they are useful at least for strace for compa=
t
> > application tracing purposes.
> >
> > Fixes: 306f7cc1e9061 "uapi: always define F_GETLK64/F_SETLK64/F_SETLKW6=
4 in fcntl.h"
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Reported-by: Eugene Syromiatnikov <esyr@redhat.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: Palmer Dabbelt <palmer@rivosinc.com>
> > ---
> >  include/uapi/asm-generic/fcntl.h | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generi=
c/fcntl.h
> > index f13d37b60775..cd6bd65ec25d 100644
> > --- a/include/uapi/asm-generic/fcntl.h
> > +++ b/include/uapi/asm-generic/fcntl.h
> > @@ -116,13 +116,11 @@
> >  #define F_GETSIG     11      /* for sockets. */
> >  #endif
> >
> > -#if __BITS_PER_LONG =3D=3D 32 || defined(__KERNEL__)
> >  #ifndef F_GETLK64
> >  #define F_GETLK64    12      /*  using 'struct flock64' */
> >  #define F_SETLK64    13
> >  #define F_SETLKW64   14
> >  #endif
> > -#endif /* __BITS_PER_LONG =3D=3D 32 || defined(__KERNEL__) */
>
> Looks like prviously there were a number of ways these constants
> were ifdef'd - or not. A number of platforms already had no ifdef of
> any sort around them before, so this looks like the sane way to do it.
>
> Though in the original patch the special-mips-variant also gained the
>         #if __BITS_PER_LONG =3D=3D 32 ...
> conditional in arch/mips/include/uapi/asm/fcntl.h .
> So, is it also affected by this issue?
Not sure about mips.

>
>
> Heiko
>
>


--=20
Best Regards
 Guo Ren
