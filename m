Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B283EA369
	for <lists+linux-arch@lfdr.de>; Thu, 12 Aug 2021 13:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbhHLLXZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Aug 2021 07:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbhHLLXY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Aug 2021 07:23:24 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D1FC061765
        for <linux-arch@vger.kernel.org>; Thu, 12 Aug 2021 04:22:59 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id h18so6446749ilc.5
        for <linux-arch@vger.kernel.org>; Thu, 12 Aug 2021 04:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xJyTXUk7YQUSDA53BJfEIaZEJV/E+iMCVnAbPcOvA0Y=;
        b=oeJQVl2cAbLJG2Rhra2xnBYmexcl1totbZIl1Q+N1HmN+eBU3Uj7IHxbDIihQMTh4O
         duRrMrzhcoguiecooCJ8/yRNFdmEezKlUMtl5MyIAQO03XxbAPyv7Hgp0LMKe0rnYUMr
         PRI59ogzguHoge8YEG4fEkOG4/4r73092xDZ7VttQymXq00oPLMkro910cERbdkEVdAG
         8nNsVykARWCnhHN3//sOr9McpVevderyqO7SA1ERlJYYaYZDggiDbabL9zjLF5AIt8pY
         JtAsIO09ShCr0h226oTr1u8iGsj1BBpoFZQaUO+hQ07A6QZlcGNkKU5KnF3Ir2dA/YLl
         bk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xJyTXUk7YQUSDA53BJfEIaZEJV/E+iMCVnAbPcOvA0Y=;
        b=icyMYwf8RRQdtDiWXSUhrnB5ANYW6vGMn9lbrCcPdqlEDL/zsBArlzOm35+bTE8A1X
         zF+8Skk9oV2+Ysm25fFQVmh4Q9txdIKaSkC/of9d3lQXovnfvgid5cD+IlxqW2KfOqiI
         i17f5VK/tXLgWTxpHNtswQSg5y3BkYrKMJRt9Q7Nb9LmzYG/LrlyC/lUQK1ewv8sBlF6
         IrjIf+JcHtqD4LLLwNEYLK4DlRwe3nEPicZlsYReiKl/WW0HF73dhRwkN4lsrtdXRFGW
         +Jrn80CexedbdJF0/UvVmASqOD/d1UxQpZ0anzvo0TkMNbC2AKHKYFmf6BBk27+MoIp/
         zGMA==
X-Gm-Message-State: AOAM532x27DVj2bOMZYkh2MzF0RSxzyNqiJXxSHJfLE5r/EiHbaCov0k
        yudoySvabJsT0Ei3eiHdYtv4fjJBU//acrMESeo=
X-Google-Smtp-Source: ABdhPJxBZZrmacRomHUwvG3YLr8ZmCg1xQN9p7+EoImA8Z1eC9xR64dxV6LsTCCW8ipHbTFjAW0K8t1UkuSDt4AMyqk=
X-Received: by 2002:a92:da0d:: with SMTP id z13mr2346431ilm.95.1628767379270;
 Thu, 12 Aug 2021 04:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-14-chenhuacai@loongson.cn> <CAK8P3a2sCqqYC8pUPOyp-D48EOWbcryTO4pWFptftciWcWDk3Q@mail.gmail.com>
In-Reply-To: <CAK8P3a2sCqqYC8pUPOyp-D48EOWbcryTO4pWFptftciWcWDk3Q@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 12 Aug 2021 19:22:47 +0800
Message-ID: <CAAhV-H655+kc1QG9qnnqdEqkSfc4QUR0kVVm3C7r3_momW_b_Q@mail.gmail.com>
Subject: Re: [PATCH 13/19] LoongArch: Add some library functions
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Tue, Jul 6, 2021 at 6:17 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > +/*
> > + * long __strncpy_from_user(char *to, const char *from, long len)
> > + *
> > + * a0: to
> > + * a1: from
> > + * a2: len
> > + */
> > +SYM_FUNC_START(__strncpy_from_user)
> > +       move    a3, zero
> > +
>
> I doubt this is better than the C version in lib/strncpy_from_user.c
OK, they will be replaced with the C version.

Huacai
>
> > diff --git a/arch/loongarch/lib/strnlen_user.S b/arch/loongarch/lib/strnlen_user.S
> > new file mode 100644
> > index 000000000000..9288a5ad294e
> > --- /dev/null
> > +++ b/arch/loongarch/lib/strnlen_user.S
> > @@ -0,0 +1,47 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> > + */
>
> Same here.
>
> Have you done any measurement to show that the asm version actually helps
> here? If not, just use the generic version.
>
>
>        Arnd
