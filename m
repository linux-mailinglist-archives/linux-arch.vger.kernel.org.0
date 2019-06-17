Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD7F48AD9
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2019 19:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfFQR4g (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Jun 2019 13:56:36 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36417 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFQR4g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Jun 2019 13:56:36 -0400
Received: by mail-lf1-f68.google.com with SMTP id q26so7208325lfc.3
        for <linux-arch@vger.kernel.org>; Mon, 17 Jun 2019 10:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mTIMaymR2g7ReedoWbXicVhALRP9n80T++Kcv0+9jtg=;
        b=e0tz/APC5r77SqUGRyfs/Mwa7FuxmPdocJvVwqMgopem89HfOL1bhcEpLKWmjogU8K
         7tnCaXIJLhABAdqAJmR5Xrk33u93+x+oVv8LofRf9OgNyy1lfVfpWErV7PeDRcYYQW6c
         63h5TyhdbeMvuJ21173JUk65/NyRsTxCQcS+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mTIMaymR2g7ReedoWbXicVhALRP9n80T++Kcv0+9jtg=;
        b=N578+2dvBhYW3QK4Te/NZ643nOX/N6xNNkSCmkN0qF3LBwzcuStbrIZP9Wje14W3n0
         IipiGJPR+1qPxM5z/IdgpZHwntOkGPsEH8Urid9E7ugOi+WyqCS/w6xeAEu0jfeiiid2
         vTUSyG8+WkhKmTKQYBG9snTv+RNVVRM67+CrkWnSlHaeaARrnFAPeFO/AJXWBCmJAOmi
         /BkpdAHLerLLMM1kkCNqza+sjBD9EJ+2r6ZBrJTvP9Bu61hOCs6ERWnUYA6aVMji1kgl
         WeZGue3rMTNh2fc+fnfR/rJVDQ7vIRWsCF4tpiRj07AN9ERxNZmkFl7sm+vGmbCXMuB7
         Wq9g==
X-Gm-Message-State: APjAAAUd7m3HOQLa7D6zp0TTycqZGM4i7OaQKpGLjs7HPaIZY33pjXzr
        m51T9yMiuFXWWSAEqyy/YhXiRUhdioI=
X-Google-Smtp-Source: APXvYqzRaQ+78nG0QnjfEntH4xOk5HJYa6OguN1zmLPx3QGGKN1OebTllupqbBm4bbDHOajEaby6Ng==
X-Received: by 2002:ac2:5205:: with SMTP id a5mr1696611lfl.143.1560794194026;
        Mon, 17 Jun 2019 10:56:34 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id w28sm2198607ljd.12.2019.06.17.10.56.33
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 10:56:33 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id x25so603866ljh.2
        for <linux-arch@vger.kernel.org>; Mon, 17 Jun 2019 10:56:33 -0700 (PDT)
X-Received: by 2002:a2e:9bc6:: with SMTP id w6mr17389201ljj.156.1560793800661;
 Mon, 17 Jun 2019 10:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190319165123.3967889-1-arnd@arndb.de> <alpine.DEB.2.21.1905072249570.19308@digraph.polyomino.org.uk>
 <87tvd2j9ye.fsf@oldenburg2.str.redhat.com> <CAHk-=wio1e4=WUUwmo-Ph55BEgH_X3oXzBpvPyLQg2TxzfGYuw@mail.gmail.com>
 <871s05fd8o.fsf@oldenburg2.str.redhat.com> <CAHk-=wg4ijSoPq-w7ct_VuZvgHx+tUv_QX-We-62dEwK+AOf2w@mail.gmail.com>
 <87sgs8igfj.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <87sgs8igfj.fsf@oldenburg2.str.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Jun 2019 10:49:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjCwnk0nfgCcMYqqX6o9bBrutDtut_fzZ-2VwiZR1y4kw@mail.gmail.com>
Message-ID: <CAHk-=wjCwnk0nfgCcMYqqX6o9bBrutDtut_fzZ-2VwiZR1y4kw@mail.gmail.com>
Subject: Re: [PATCH] uapi: avoid namespace conflict in linux/posix_types.h
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Joseph Myers <joseph@codesourcery.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Paul Burton <pburton@wavecomp.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 17, 2019 at 4:45 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> I wanted to introduce a new header, <asm/kernel_long_t.h>, and include
> it where the definition of __kernel_long_t is needed, something like
> this (incomplete, untested):

So this doesn't look interesting to me: __kernel_long_t is neither
interesting as a type anyway (it's just a way for user space to
override "long"), nor is it a namespace violation.

So honestly, user space could do whatever it wants for __kernel_long_t anyway.

The thing that I think we should try to fix is just the "val[]" thing, ie

> A different approach would rename <asm/posix_types.h> to something more
> basic, exclude the two structs, and move all internal #includes which do
> need the structs to the new header.

In fact, I wouldn't even rename <posix_types.h> at all, I'd just make
sure it's namespace-clean.

I _think_ the only thing causing problems is  '__kernel_fsid_t' due to
that "val[]" thing, so just remove ity entirely, and add it to
<statfs.h> instead.

And yeah, then we'd need to maybe make sure that the (couple) of
__kernel_fsid_t users properly include that statfs.h file.

Hmm?

               Linus
