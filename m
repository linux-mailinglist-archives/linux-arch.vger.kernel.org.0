Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F9D381AF7
	for <lists+linux-arch@lfdr.de>; Sat, 15 May 2021 22:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhEOUSy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 15 May 2021 16:18:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234840AbhEOUSv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 15 May 2021 16:18:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E63696121E;
        Sat, 15 May 2021 20:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621109857;
        bh=Z9NQzsSFCaSLn3jMjEHhBdcoFhlXWyGQ4ZxdOXx3NYA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=traaZJipL6kqLOa/FfhL7XkYEVzXJ6VK11z51O0PmjgxeOXOHzJig1nqPACsvqn73
         /Prt6FS/O4Vf4P/igam5GkrfH1hWpG4bOJPXcf7O0vB7zKbcx4YxuecdlNGJOLFZar
         JBVC7ml8MRpHpL5e0rWB5Ek2FvUlqXujauJAM0uGpYPVu0R/dz/aFLBC2qUvjMKO1U
         veZKr21xLUb95Q3LTpDa4IeGaEjsb2HteTWWnrn58wPw59An/b2OL+zFiOs0vQnybx
         B5OcYcjaAgKEANlvlbfTYNmlvnx9CK3G4RbmmAZWGE0X5f0iCg/DpomxBmfdgZEz4G
         oMg4r1ctGWdUA==
Received: by mail-wr1-f43.google.com with SMTP id z17so2415856wrq.7;
        Sat, 15 May 2021 13:17:37 -0700 (PDT)
X-Gm-Message-State: AOAM533ZpMGkRxZ0leBOl9xWfEIlJUtLpfPkffT9+RMzGxC/YLp+fYKR
        2bFHeB7ZCmyqc9Og4jPwxQKLgPvP5BlKt5iNpfU=
X-Google-Smtp-Source: ABdhPJxm+4q3De3RBJDfQGvWSlPiUE6c2DBBt55wdtCluO9aXAU9V+hkjWv4pM6qjaKQ5DGkyvnlFE5bXR41SbZuXEc=
X-Received: by 2002:a5d:5404:: with SMTP id g4mr1680204wrv.286.1621109856628;
 Sat, 15 May 2021 13:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210514100106.3404011-1-arnd@kernel.org> <20210514100106.3404011-13-arnd@kernel.org>
 <9f763da3-25c6-24e7-91e9-f3016a85f9f7@infradead.org>
In-Reply-To: <9f763da3-25c6-24e7-91e9-f3016a85f9f7@infradead.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 15 May 2021 22:16:32 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0Sp9JV-1pgqH0uf7tXxpL2O-VB+Unse8VaenO5drR15Q@mail.gmail.com>
Message-ID: <CAK8P3a0Sp9JV-1pgqH0uf7tXxpL2O-VB+Unse8VaenO5drR15Q@mail.gmail.com>
Subject: Re: [PATCH v2 12/13] asm-generic: uaccess: 1-byte access is always aligned
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 15, 2021 at 8:41 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 5/14/21 3:01 AM, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
> > index 4973328f3c6e..7e903e450659 100644
> > --- a/include/asm-generic/uaccess.h
> > +++ b/include/asm-generic/uaccess.h
> > @@ -19,7 +19,7 @@ __get_user_fn(size_t size, const void __user *from, void *to)
> >
> >       switch (size) {
> >       case 1:
> > -             *(u8 *)to = get_unaligned((u8 __force *)from);
> > +             *(u8 *)to = *((u8 __force *)from);
> >               return 0;
> >       case 2:
> >               *(u16 *)to = get_unaligned((u16 __force *)from);
> > @@ -45,7 +45,7 @@ __put_user_fn(size_t size, void __user *to, void *from)
> >
> >       switch (size) {
> >       case 1:
> > -             put_unaligned(*(u8 *)from, (u8 __force *)to);
> > +             *(*(u8 *)from, (u8 __force *)to);
>
> Should that be           from =
> ?

Thanks a lot for catching the typo!

Changed now to

        *(u8 __force *)to = *(u8 *)from;

For some reason neither my own build testing nor the kernel
build bot caught it so far.

        Arnd
