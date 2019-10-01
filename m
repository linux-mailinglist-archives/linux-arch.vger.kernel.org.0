Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8FEC420F
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2019 22:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfJAUx7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Oct 2019 16:53:59 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46989 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfJAUx7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Oct 2019 16:53:59 -0400
Received: by mail-qk1-f194.google.com with SMTP id 201so12679589qkd.13;
        Tue, 01 Oct 2019 13:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v7MUChZMPK1zb+gMXHU9XAGkO5pYjaFnqTcVSPFdTOk=;
        b=c7F0xiJipaPPKQhVLUiiwGsk7nbi53P01pVjsfR5Oh0x37OhzjUv3MVVQbleiEgRto
         MxT9q0mBQpA2HByGtCTZajKYhNG5fNHZIuam6bN4LDqDrBNshfnhlXLAWd6Wh6SaADYG
         W+2RkhYQ0Ngyn0vl2yGxCv3S5BTSvo4G/oYw07TttSWVY9BKRJ0ZflKLtPxzDmMoatF1
         NKN/TlXN+zo+cPckiQBng+jRTxMTZPqQwEcr522ZaCnPEnFMVzjYisflxf1xrBpJbE27
         fAdbWgpnuQ7xn0/dCuqvMR+MkDYoPRc59AlNoI62Pc+iZRqtlt3t2OrRxrpVeK0/SVwa
         9+4A==
X-Gm-Message-State: APjAAAV6L+b6yKh0IJIMmfsszF3NJJPoTdsemhW6DF6cOS0JIay/dZDY
        D+A+gESzpYBOGUapKnEqeD6EZPHE1WAb69FI8HA=
X-Google-Smtp-Source: APXvYqwAAPH4OmvY2XCe1/doK1g9oWOdcEyrG1wCz0XnGY6yC21KGfyPKMEejKGP/IUydW6XAfSyzIaF1jEoGuvJHxY=
X-Received: by 2002:a37:a858:: with SMTP id r85mr72574qke.394.1569963237942;
 Tue, 01 Oct 2019 13:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190930112636.vx2qxo4hdysvxibl@willie-the-truck>
 <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck> <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
 <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck> <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
 <20191001170142.x66orounxuln7zs3@willie-the-truck> <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
 <20191001175512.GK25745@shell.armlinux.org.uk> <CAKwvOdmw_xmTGZLeK8-+Q4nUpjs-UypJjHWks-3jHA670Dxa1A@mail.gmail.com>
 <20191001181438.GL25745@shell.armlinux.org.uk> <CAKwvOdmBnBVU7F-a6DqPU6QM-BRc8LNn6YRmhTsuGLauCWKUOg@mail.gmail.com>
In-Reply-To: <CAKwvOdmBnBVU7F-a6DqPU6QM-BRc8LNn6YRmhTsuGLauCWKUOg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 1 Oct 2019 22:53:41 +0200
Message-ID: <CAK8P3a0eKOyJRjp1P8HWfSLWO=d6Y3befy3kQBgTPVX+g_2q4A@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Kees Cook <keescook@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 1, 2019 at 10:21 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
> On Tue, Oct 1, 2019 at 11:14 AM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > On Tue, Oct 01, 2019 at 11:00:11AM -0700, Nick Desaulniers wrote:
> > > On Tue, Oct 1, 2019 at 10:55 AM Russell King - ARM Linux admin
> > > <linux@armlinux.org.uk> wrote:
> > In any case, I violently disagree with the idea that stuff we have
> > in header files should be permitted not to be inlined because we
> > have soo much that is marked inline.
>
> So there's a very important subtly here.  There's:
> 1. code that adds `inline` cause "oh maybe it would be nice to inline
> this, but if it isn't no big deal"
> 2. code that if not inlined is somehow not correct.
> 3. avoid ODR violations via `static inline`
>
> I'll posit that "we have soo much that is marked inline [is
> predominantly case 1 or 3, not case 2]."  Case 2 is a code smell, and
> requires extra scrutiny.

1. is clearly the most common case, but there is also

4. Some compiler version (possibly long gone, possibly still current)
makes bad inlining decisions that result in horrible but functionally
correct object code for a particular function, and forcing a function to
be inlined results in what we had expected the compiler to do already.

The problem with 2. is that they are largely not documented, and often
unintentional. This also affects functions that are simply 'static'
rather than 'static inline' but are broken when not being inlined.
E.g. we've had a number of kernel bugs with 'static __init' functions
that gcc always inlined into a non-__init caller, but that produced an
invalid call into a discarded function when clang decided to leave
them out of line.

      Arnd
