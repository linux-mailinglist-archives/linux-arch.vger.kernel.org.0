Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0830F1766BD
	for <lists+linux-arch@lfdr.de>; Mon,  2 Mar 2020 23:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgCBWUK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Mar 2020 17:20:10 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:33037 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgCBWUK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2020 17:20:10 -0500
Received: by mail-pj1-f68.google.com with SMTP id m7so361611pjs.0
        for <linux-arch@vger.kernel.org>; Mon, 02 Mar 2020 14:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eiRXpYLqa4ejnGphOY97gu7ECpDZYBemFYjwQAOSIN8=;
        b=aaGbZGjtJ97tAFGUqz1YUpCvWUuKvLCOUoq7GqERz+rB0v9aKkWW1Vu0eodTPN9RqX
         872hdjf3v+n810DIGbWsb1YA3ylC25C8v7EbWQNdSnyn6CmqUl7EYIv2FFTiNddxIOh7
         lGAwzdPNbyd6Btislx/JrjefO+I8oHSBuVzcuGPCQJBgfUM96yWecj+MmA8ndhCrt1qV
         wsqBoVrTHQprLkdeFc8bBH4cBTEiANYeLNTg2xN2rJdvvRvKUTfzQ4otrxw9aIwvUrKk
         aglUxIPKqfFRNTr5MBy60063UjLYzQNw6+c5p0GejmWLVief8dOlfKcEFSvRknw4chxX
         3HJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eiRXpYLqa4ejnGphOY97gu7ECpDZYBemFYjwQAOSIN8=;
        b=poz8BZs3zdW7DVrabON5WQkhMF4Pp/p4Gt3zLE8lA4leZqv2wI3LsggMrJrzgY+llk
         7eUxXkNifxPQU0MkXnYl6G9z3md7V/qlfWhQqWbBwFCzXkrcnNCcxcIvM9HvKzHS6PGM
         2H49LM4W4yASL5JMv8ESUILuXLjIhrjh2JE1vPizG6qkn/lQd809STf8QjNxgKkDnoPH
         PXpH2k8roFLB9bq8gT78mSI2rbNi/ja4EvTY0tkRKFsR7/qaHB2Z9jzOitxDiEHPt5z/
         JiDLbMudJ4PHbuDZKT8lmGvnae9vcjbGLyq3VCpwGXgtzbw9ZBuxcxLP+e9tL33EkiCC
         tILw==
X-Gm-Message-State: ANhLgQ3Gq7cx7rrdeDcJweZJNhP8fYr7RhmyfaLexN+XpKvDlSFf4pFU
        xfU8GT4ppRwqJ5KjM45ddGCnOird5A4HBfwZFxME2w==
X-Google-Smtp-Source: ADFU+vuOaeld9UBVLAooUJ2zjVQ14iAl+j/4kAj7yT6yN5YktIvgDo9o5Nd/iazOvMtSLESD5sgw76KV2VeNpaXLVLU=
X-Received: by 2002:a17:90a:3a90:: with SMTP id b16mr120232pjc.29.1583187608902;
 Mon, 02 Mar 2020 14:20:08 -0800 (PST)
MIME-Version: 1.0
References: <20200228012036.15682-1-brendanhiggins@google.com>
 <20200302200337.GH11244@42.do-not-panic.com> <20200302211640.GA8364@roeck-us.net>
In-Reply-To: <20200302211640.GA8364@roeck-us.net>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 2 Mar 2020 14:19:57 -0800
Message-ID: <CAFd5g452oaKojBZfvTYw-L14wTFqsjDeX4mtYDM=kv6xhcTnig@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] kunit: create a centralized executor to dispatch
 all KUnit tests
To:     Guenter Roeck <linux@roeck-us.net>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Iurii Zaikin <yzaikin@google.com>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com,
        Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 2, 2020 at 1:16 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Mon, Mar 02, 2020 at 08:03:37PM +0000, Luis Chamberlain wrote:
> > Guenter,
> >
> > are you still running your cross-architecture tests? If so any chance
>
> Yes
>
> > you can try this for your build tests?
> >
>
> I didn't have KUNIT_TEST enabled to start with. I did that now, and
> started a test run on mainline a minute ago. We'll see how that goes.

FYI, kbuild already found some architectures for which this change doesn't work.

So far, I need to fix:
- arm64 (32 bit seems to work fine)
- i386 in some cases.

> Afterwards, sure, I can run the series in a test branch. It would be great
> if I can pick it up from a repository somewhere.

Cool, I will post my next revision to a branch somewhere.

Thanks!
