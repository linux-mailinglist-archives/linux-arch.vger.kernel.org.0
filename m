Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC18D20BB5F
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jun 2020 23:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbgFZVXO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Jun 2020 17:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgFZVXN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Jun 2020 17:23:13 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8948FC03E97B
        for <linux-arch@vger.kernel.org>; Fri, 26 Jun 2020 14:23:12 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x8so3817970plm.10
        for <linux-arch@vger.kernel.org>; Fri, 26 Jun 2020 14:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CvJoXjPb3PppSXrTvZvJe33y7yc/YsOEYDjM/f5h460=;
        b=V4+waQO8b0iUP2RZw/9wwuSg1yJTxiHT0OF4g7SF9fKIzoFlXU6ot0auFw3DJDBR0p
         MbiGN8aOp87G0zacaSAFT7QrcUII1OlL5ZJdBCNbrfDgLWo8Xo07JOjx5OykYTd3bbuF
         qDCxZQPmgDAryI5UWavy9oWaqjeoKgoMhzprLtGpkwY4B7WeL/Z145HYp+Rdd1SoD8c6
         3BJH7MM784WaQY5yKAj70FP0deHmf6UKu+Ay4aV4LdsxdfEIupTDZoN+0XY1PELwlMmu
         hhn1UVkn6JRYANDcsLxYRtknIt/x4emnPr4cN4nzAKmjLtv5/apaBUms8FL3Yc4BwsJs
         H47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CvJoXjPb3PppSXrTvZvJe33y7yc/YsOEYDjM/f5h460=;
        b=CPep8ui41aD6SXtDEFMHuxT59PE3JmJMHW7nY4n4083LFTe3Wt4AJGr2D0BEHGQaSP
         0B2FkF/V0dG+XGnp9s0DQFxOBA/IX1TkcTHvukooLI5jh1NqnwdxqvqFWcfjs2tsQQA+
         /wXrNnlsSXkwSMFo4hPLWuKv8DsbCVlYdcX7sUOLFRVy+8P1dC/8IGKHWXNGYWGwEFFE
         3wtNGjOOuyHrPJzBTAEqEDHPbE9rNWCIW7nzamh6VQs8b4krLtiHcJHUn9orqSD0vN1L
         +CgnedRMMNYCoQLZvLSs4MhqVmU8gFqbVD59H0TI6cJW/cjCjul4+T1bt7yw8f1rCSLJ
         rqAA==
X-Gm-Message-State: AOAM53285N5H6PWd4Cf2IWy0n7NcoQ/fu2ff3oN/5vUfsMLflDhr+SZt
        /XKeQofOxLtwp+57dkQ5IsxyOJHS8HHKT8uanmKkfw==
X-Google-Smtp-Source: ABdhPJwAirQYhcHGLt1+JjXg5NVX+m/8Nr12fmbDVwUgoHtdJsK/GnGlRIvrgvOirMw8ViXfV6UFbIIy77mdcmwl2RU=
X-Received: by 2002:a17:90a:6ac8:: with SMTP id b8mr5607777pjm.217.1593206591785;
 Fri, 26 Jun 2020 14:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200626210917.358969-1-brendanhiggins@google.com>
 <20200626210917.358969-3-brendanhiggins@google.com> <202006261420.02E8E62@keescook>
In-Reply-To: <202006261420.02E8E62@keescook>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 26 Jun 2020 14:23:00 -0700
Message-ID: <CAFd5g47ZKJHzseyZT73uYB+EpAkyfN+gBj5X8ufZVnD6eG19eQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/12] arch: arm64: add linker section for KUnit test suites
To:     Kees Cook <keescook@chromium.org>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Iurii Zaikin <yzaikin@google.com>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com,
        Frank Rowand <frowand.list@gmail.com>, catalin.marinas@arm.com,
        will@kernel.org, monstr@monstr.eu,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        paulus@samba.org, chris@zankel.net, jcmvbkbc@gmail.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 26, 2020 at 2:20 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Jun 26, 2020 at 02:09:07PM -0700, Brendan Higgins wrote:
> > Add a linker section to arm64 where KUnit can put references to its test
> > suites. This patch is an early step in transitioning to dispatching all
> > KUnit tests from a centralized executor rather than having each as its
> > own separate late_initcall.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >  arch/arm64/kernel/vmlinux.lds.S | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> > index 6827da7f3aa54..a1cae9cc655d7 100644
> > --- a/arch/arm64/kernel/vmlinux.lds.S
> > +++ b/arch/arm64/kernel/vmlinux.lds.S
> > @@ -181,6 +181,9 @@ SECTIONS
> >               INIT_RAM_FS
> >               *(.init.rodata.* .init.bss)     /* from the EFI stub */
> >       }
> > +     .kunit_test_suites : {
> > +             KUNIT_TEST_SUITES
> > +     }
>
> See my reply to 01/12. Then this patch can be dropped. :)

Sweet, presumably this one and others.

> >       .exit.data : {
> >               EXIT_DATA
> >       }
> > --
> > 2.27.0.212.ge8ba1cc988-goog
> >
>
> --
> Kees Cook
