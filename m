Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4943C8071
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jul 2021 10:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238562AbhGNIpf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jul 2021 04:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238432AbhGNIpe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jul 2021 04:45:34 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9698BC06175F;
        Wed, 14 Jul 2021 01:42:42 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id c17so2023450ejk.13;
        Wed, 14 Jul 2021 01:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eRRBdAbPowYjIItlTV4onJeeQmdz/xOO5no/2s3eeNI=;
        b=cjAe5XbV21hxDm7z6vT4uqRk64jPGU9pnBfGb6SGfZScVd6llV+IXiewGKjKbCdL/i
         i5N/HjA7wq8cF2efsYzY6Rtw8mU9g2sL9/lGWcMi84LMhrygiwIAa7stD+bOqR7s2Vk4
         eRCdd+VQAtyZ9jiOcRixTYJF/3wMhuf/r+CIQIhmr1JsPDGDPWtROtHZD0un34ZVZIzs
         SlsSBeIrxp0QuYMZnIwcbQnl1sD6XwBVm5X9avRIeF1e53VjmrjqjQhpVj0xMQ7imPUc
         LN3OnyniM3ziJhD1o5KbL+Lijmx2Pqxx0gu+faPX5VwTNg7s5CaF0+ISLalyHVabrqQR
         7kpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eRRBdAbPowYjIItlTV4onJeeQmdz/xOO5no/2s3eeNI=;
        b=m+vBjgvNrZjLb8Z5uZBoIBomJnE9Kd7uM6AxJDFqsva+dnvI3V0jWdUzCMaDadZiao
         rPH7k/JCxn7Qi0urQsE3ch7N+Owzu1I4jWg2KgcCJvYx2cUSxCq6+dzNXwgMFoFvawHT
         k/kgcxuBdkTHyuvUFvwsZgLk2Z8JCJToOVKJ+ccqtqA11by/lVUPM0GH00YjoMpKv2J4
         G+pOUoUjxIAFn/DmCM196GFvLiDJavAJxa3WyJYQ6/rVvdfU7QEHLM756d0Wyg5PrHBt
         z5CAlkNjtl0ATMn5jQMcKGrTPtnb9LrFLek6EQPS87y5C1YlsJS/c6eZA3e3av4ASUwg
         Ia9w==
X-Gm-Message-State: AOAM531AooSzDRwfwm5jtx0pIZCU78gm7SxpQpUeJdNAWH0c2KHex0zd
        Jgwjabnv4mOP1Oi38ZktKRodXNNnIw==
X-Google-Smtp-Source: ABdhPJwwewxjRSdYhSkYvwb0/gSuNFEgilIXpsTS6eyDg3qCncxhOVRBMDwfCLSfc0CaNKWCcnCVvw==
X-Received: by 2002:a17:907:a04e:: with SMTP id gz14mr11266940ejc.24.1626252150392;
        Wed, 14 Jul 2021 01:42:30 -0700 (PDT)
Received: from localhost.localdomain ([46.53.251.125])
        by smtp.gmail.com with ESMTPSA id g8sm628248edv.84.2021.07.14.01.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 01:42:29 -0700 (PDT)
Date:   Wed, 14 Jul 2021 11:42:28 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] Decouple build from userspace headers
Message-ID: <YO6jdIlu5xy35nix@localhost.localdomain>
References: <YO3txvw87MjKfdpq@localhost.localdomain>
 <CAK7LNATVysAEkcq86AD75njoXis67M4i+QVEfg5LawWzfC1h9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNATVysAEkcq86AD75njoXis67M4i+QVEfg5LawWzfC1h9g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 14, 2021 at 01:54:59PM +0900, Masahiro Yamada wrote:
> On Wed, Jul 14, 2021 at 4:47 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > In theory, userspace headers can be under incompatible license.
> >
> > Linux by virtue of being OS kernel is fully independent piece of code
> > and should not require anything from userspace.
> 
> As far as I know,
> <stdarg.h> was the only exception,
> which was borrowed from the compiler.
> 
> 
> I like this as long as:
>   - license is clear (please add SPDX tag to the new header)
>   - it works for both gcc and clang (I guess the answer is yes)

It should. clang version is essentially the same
(with less prehistoric macrology).

> I think removing <stdbool.h> and <stddef.h> are non-controversial.
> Mayby, you can split it into 1/2.
> 
> 
> 
> 
> >
> > For this:
> >
> > * ship minimal <stdarg.h>
> >         2 types, 4 macros
> >
> > * delete "-isystem"
> >         This is what enables leakage.
> >
> > * fixup compilation where necessary.
> >
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > ---
> >
> >  Makefile                                                               |    2 +-
> >  arch/um/include/shared/irq_user.h                                      |    1 -
> >  arch/um/os-Linux/signal.c                                              |    2 +-
> >  crypto/aegis128-neon-inner.c                                           |    2 --
> >  drivers/net/wwan/iosm/iosm_ipc_imem.h                                  |    1 -
> >  drivers/pinctrl/aspeed/pinmux-aspeed.h                                 |    1 -
> >  drivers/staging/media/atomisp/pci/hive_isp_css_common/host/isp_local.h |    2 --
> >  include/stdarg.h                                                       |    9 +++++++++
> >  sound/aoa/codecs/onyx.h                                                |    1 -
> >  sound/aoa/codecs/tas.c                                                 |    1 -
> >  10 files changed, 11 insertions(+), 11 deletions(-)
> >
> 
> > new file mode 100644
> > --- /dev/null
> > +++ b/include/stdarg.h
> > @@ -0,0 +1,9 @@
> 
> 
> This is a new file, so please add the SPDX tag.
> What project did you copy the code from?
> 
>   If gcc, is it GPL v3 (but not compatible for GPL v2) ?

It is GPL 2, brought to you by Debian! I'll add a link.

	http://archive.debian.org/debian/pool/main/g/gcc-4.2/

>   If clang, is it
>    SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
> 
> Or, can we license this small portion of code
> as GPL v2?
> 
> 
> 
> > +#ifndef _LINUX_STDARG_H
> > +#define _LINUX_STDARG_H
> > +typedef __builtin_va_list __gnuc_va_list;
> 
> Where is __gnuc_va_list needed?
> 
> BTW, once this is accepted, I'd like to
> change all <stdarg.h>  to <linux/stdarg.h>.

Yes. I've just realised <stdarg.h> is the wrong place:

  gcc -Wp,-MMD,scripts/selinux/genheaders/.genheaders.d -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -std=gnu89     -I/home/ad/linux/linux-1/include/uapi -I/home/ad/linux/linux-1/include -I/home/ad/linux/linux-1/security/selinux/include  -I ./scripts/selinux/genheaders   -o scripts/selinux/genheaders/genheaders /home/ad/linux/linux-1/scripts/selinux/genheaders/genheaders.c
In file included from /home/ad/linux/linux-1/scripts/selinux/genheaders/genheaders.c:6:
/usr/include/stdio.h:52:9: error: unknown type name ‘__gnuc_va_list’
   52 | typedef __gnuc_va_list va_list;

Or maybe <stdarg.h> is the right place by passing all those include
directories to userspace helpers is the wrong thing to do.
