Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD4F287C04
	for <lists+linux-arch@lfdr.de>; Thu,  8 Oct 2020 21:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbgJHTDZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Oct 2020 15:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729316AbgJHTDZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Oct 2020 15:03:25 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AFEC061755
        for <linux-arch@vger.kernel.org>; Thu,  8 Oct 2020 12:03:24 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a4so6884363lji.12
        for <linux-arch@vger.kernel.org>; Thu, 08 Oct 2020 12:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2+ZHKNnic7Qk2kqMLwISmHHuDfZEQAZNd4c7bk1SkbU=;
        b=WGFHmaJJtUyHuGaccY2f+aEGOmKl7C1zchw4YdYU+KFRtD10H1AOq0+c410VZzVzc4
         6K2SwIqvE9bX/4T/JZRHOVNFjRZlHSeuaLUg8jDXQY1eBjMHIN3DJNloiQdmKgx77DtY
         YkDEsw/3kP3QxLFsULpkfZuAHmXWQJKTcvHM95neXkRxG9M1Onakk1J8GIsWazDFT8GA
         +yKQjaDzvZ0j1PJgCe1bEeIrVB1J0FJr+RpI96y4Ja9UYXrl3fUrGDos1Kpyup1200KK
         6gGkmALfOkRiHixC76o/Vh5Vt2aW7a7J6mStKpjdB2r3IgrrnB9o5hAnJFVMSLdwJqvI
         Tp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2+ZHKNnic7Qk2kqMLwISmHHuDfZEQAZNd4c7bk1SkbU=;
        b=rldyEA3Z9CkUJdUhV/1CelJmrLo8BgZInAxdagcOJVKmYXuNQIz4XwlJ7otHaMQ8bq
         VtV0L5Wr6qFAOtjNwZE8zE10seIE9XCT8J8mQrb9hmEqugn6EPkTN6oNHy0AdEWLllid
         SIQ/ywz5u9JTr8vE3GkSIgklaXRsMOP1kmNdUNghl+mpiARBjnmMamfaSCwgKaoBLXoI
         8E/aWmmH+ocCmUijSaXNxxo5CPME87o+QVqMUGgnwYyNkZIsDAtzzgP9MCnCzawYwDhf
         YwV7ynHwlc6KWpWFMMmfN4DRCMP4oycyx8Cw1JxKgYBtlOD/gYVd8mxl/8wJ0zejHIYk
         8S+Q==
X-Gm-Message-State: AOAM533hOrt2WHRyQI+bPVp8y4W9TMjKRj5ebHfg0LhaLw3dwg1fjw8f
        setSxg40qodhxeTidR8YdI3cVnjxTdCrlmpjR4Xwwl8/oH3AAQ==
X-Google-Smtp-Source: ABdhPJyRxcZ02okHIOSJxlopsG/hX5Jrp1nXMtvvhq7+5Sc1MKyfDnqacSbN7+jMyxq1YJrbuWhuUrI0I73BStrGMNw=
X-Received: by 2002:a2e:6816:: with SMTP id c22mr4139598lja.200.1602183802334;
 Thu, 08 Oct 2020 12:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601960644.git.thehajime@gmail.com> <03cee062a2841e3597ae181f1903d21394651f62.1601960644.git.thehajime@gmail.com>
 <8ff2e602fca71fb7244c178017959cc8d153fbfd.camel@sipsolutions.net>
In-Reply-To: <8ff2e602fca71fb7244c178017959cc8d153fbfd.camel@sipsolutions.net>
From:   Octavian Purdila <tavi.purdila@gmail.com>
Date:   Thu, 8 Oct 2020 22:03:11 +0300
Message-ID: <CAMoF9u0m+qQzNS5mG90MiOVqgOPmbDKTs-p03PLKL0vyT_16fw@mail.gmail.com>
Subject: Re: [RFC v7 12/21] um: nommu: system call interface and application API
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Hajime Tazaki <thehajime@gmail.com>,
        linux-um <linux-um@lists.infradead.org>, jdike@addtoit.com,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-kernel-library <linux-kernel-library@freelists.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Akira Moroo <retrage01@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 7, 2020 at 10:05 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:
> >
> > +++ b/arch/um/nommu/include/uapi/asm/syscalls.h
> > @@ -0,0 +1,287 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>
> That doesn't really make sense - if you use LKL you're linking Linux, so
> you can't use this "WITH Linux-syscall-note"?
>
> > +#ifndef __UM_NOMMU_UAPI_SYSCALLS_H
> > +#define __UM_NOMMU_UAPI_SYSCALLS_H
>
> [snip]
>
> This file really worries me, it includes half the world and (re)defines
> the other half ... How is this ever going to be maintained?
>

There are not that many definitions here, just the ones that were
never defined in uapi headers. And, AFAIK, new code that exposes
structures and data types should always go  into uapi headers and not
directly in glibc, etc. So once we fix the old stuff, it should be
fine?

> > index 000000000000..ec7356c0dee9
> > --- /dev/null
> > +++ b/arch/um/scripts/headers_install.py
> > @@ -0,0 +1,197 @@
> > +#!/usr/bin/env python
>
> might want to make that explicitly 'python3', some newer distros (e.g.
> ubuntu 20.04) are now shipping without a 'python' by default.
>

Good point, will fix it in the next patch series.

> > +def has_lkl_prefix(w):
> > +  return w.startswith("lkl") or w.startswith("_lkl") or w.startswith("__lkl") \
> > +         or w.startswith("LKL") or w.startswith("_LKL") or w.startswith("__LKL")
>
>
> > +        content = re.sub(re.compile("(\/\*(\*(?!\/)|[^*])*\*\/)", re.S|re.M), " ", open(h).read())
> >
> > +    dir = os.path.dirname(h)
> > +    out_dir = args.path + "/" + re.sub("(" + srctree + "/arch/um/nommu/include/uapi/|arch/um/nommu/include/generated/uapi/|include/generated/uapi/|include/generated|" + install_hdr_path + "/include/)(.*)", "lkl/\\2", dir)
>
>
> you have some very long lines in places, I'm sure you could fix that
> (e.g. the last one by doing something with '|'.join([...]))
>

Thanks for pointing it out, we will fix it :)
