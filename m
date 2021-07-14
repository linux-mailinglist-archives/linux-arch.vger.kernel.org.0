Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEFD3C7DD0
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jul 2021 07:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237800AbhGNFIy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jul 2021 01:08:54 -0400
Received: from condef-05.nifty.com ([202.248.20.70]:45427 "EHLO
        condef-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhGNFIy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jul 2021 01:08:54 -0400
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Jul 2021 01:08:54 EDT
Received: from conssluserg-04.nifty.com ([10.126.8.83])by condef-05.nifty.com with ESMTP id 16E4touN013513
        for <linux-arch@vger.kernel.org>; Wed, 14 Jul 2021 13:55:50 +0900
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 16E4tbgB022054;
        Wed, 14 Jul 2021 13:55:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 16E4tbgB022054
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1626238537;
        bh=RG3mFTWRkOy23j6Tuz6mqRZldb0E49OGrpWqNp//4bE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KX6SCE+7lLsGEKV6nc0a6h9WbdKLbXdWFed2jCZ6rqmV+AuQriC4/75EGoYhnZe8I
         /YdXmGZAbsqlicbMLwkghGvu6qdARGtVHnbHRJ1zjcs7G2a29Nw0IbGThKRub68m/6
         6AFtsCTapULyQ0fBsWEmP6T/EpkzgMiPAQUic1VKvkp7bdSXvjaXzHDzeFUkSCB5iq
         r4N/zzQF00k9BYIBJbgBXHOBDF8OeU7TuGDsvn3q6NZhiCCai4GwsFNjMEgzFkKcZh
         lUtZlihQEfbtqiyVcmuLFJUuXW5tC2QrpBWXDqM5npBqZrT278kO2pxkNlm6EXbnQd
         CJ/MhfDgk/+Dw==
X-Nifty-SrcIP: [209.85.214.169]
Received: by mail-pl1-f169.google.com with SMTP id j3so909759plx.7;
        Tue, 13 Jul 2021 21:55:37 -0700 (PDT)
X-Gm-Message-State: AOAM533Utrtcpho60d0T0aLq6HDchbyzzg4B4yx5onDOT65JIRF6J0YS
        y2Q2usTd36ftMMqdKrRD8OezmPW5xFSfh8Qky9o=
X-Google-Smtp-Source: ABdhPJwWrK3LMXMkxe0SnnVE3tQhZ3hhBYm79wwh+zAMvIZ4TB8bGaHZkHHEL78BVzJIJeAvMP8Ma0WRGCPjiDxoYes=
X-Received: by 2002:a17:902:8ec7:b029:11b:acb4:ac43 with SMTP id
 x7-20020a1709028ec7b029011bacb4ac43mr6217143plo.1.1626238536711; Tue, 13 Jul
 2021 21:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <YO3txvw87MjKfdpq@localhost.localdomain>
In-Reply-To: <YO3txvw87MjKfdpq@localhost.localdomain>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 14 Jul 2021 13:54:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNATVysAEkcq86AD75njoXis67M4i+QVEfg5LawWzfC1h9g@mail.gmail.com>
Message-ID: <CAK7LNATVysAEkcq86AD75njoXis67M4i+QVEfg5LawWzfC1h9g@mail.gmail.com>
Subject: Re: [PATCH] Decouple build from userspace headers
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 14, 2021 at 4:47 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> In theory, userspace headers can be under incompatible license.
>
> Linux by virtue of being OS kernel is fully independent piece of code
> and should not require anything from userspace.

As far as I know,
<stdarg.h> was the only exception,
which was borrowed from the compiler.


I like this as long as:
  - license is clear (please add SPDX tag to the new header)
  - it works for both gcc and clang (I guess the answer is yes)


I think removing <stdbool.h> and <stddef.h> are non-controversial.
Mayby, you can split it into 1/2.




>
> For this:
>
> * ship minimal <stdarg.h>
>         2 types, 4 macros
>
> * delete "-isystem"
>         This is what enables leakage.
>
> * fixup compilation where necessary.
>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
>
>  Makefile                                                               |    2 +-
>  arch/um/include/shared/irq_user.h                                      |    1 -
>  arch/um/os-Linux/signal.c                                              |    2 +-
>  crypto/aegis128-neon-inner.c                                           |    2 --
>  drivers/net/wwan/iosm/iosm_ipc_imem.h                                  |    1 -
>  drivers/pinctrl/aspeed/pinmux-aspeed.h                                 |    1 -
>  drivers/staging/media/atomisp/pci/hive_isp_css_common/host/isp_local.h |    2 --
>  include/stdarg.h                                                       |    9 +++++++++
>  sound/aoa/codecs/onyx.h                                                |    1 -
>  sound/aoa/codecs/tas.c                                                 |    1 -
>  10 files changed, 11 insertions(+), 11 deletions(-)
>

> new file mode 100644
> --- /dev/null
> +++ b/include/stdarg.h
> @@ -0,0 +1,9 @@


This is a new file, so please add the SPDX tag.
What project did you copy the code from?

  If gcc, is it GPL v3 (but not compatible for GPL v2) ?
  If clang, is it
   SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

Or, can we license this small portion of code
as GPL v2?



> +#ifndef _LINUX_STDARG_H
> +#define _LINUX_STDARG_H
> +typedef __builtin_va_list __gnuc_va_list;

Where is __gnuc_va_list needed?




BTW, once this is accepted, I'd like to
change all <stdarg.h>  to <linux/stdarg.h>.





-- 
Best Regards
Masahiro Yamada
