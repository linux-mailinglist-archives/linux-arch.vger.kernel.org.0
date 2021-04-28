Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED1F36D8B4
	for <lists+linux-arch@lfdr.de>; Wed, 28 Apr 2021 15:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhD1Ntx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Apr 2021 09:49:53 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:39201 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238444AbhD1Ntu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Apr 2021 09:49:50 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mdv2u-1l4KgT2ejG-00b09Q; Wed, 28 Apr 2021 15:49:03 +0200
Received: by mail-wr1-f48.google.com with SMTP id a4so63164915wrr.2;
        Wed, 28 Apr 2021 06:49:03 -0700 (PDT)
X-Gm-Message-State: AOAM530uAp/LCL/eqZMGrVBLi8LTegYVODwwEwoa6iJVbQO3GrjCLJ3U
        ooV4APg0MWOToXzK6fWpE5/BmHut9FOp5z0X80E=
X-Google-Smtp-Source: ABdhPJwxcFqHTvpriPDLFCBYjaUmlSzPFxMp17E2xhbGh58TPZnVNGXTVvvgibdshFYXRzCXxxY7DwY8rHJcUQaWLB8=
X-Received: by 2002:a5d:6dc4:: with SMTP id d4mr37595126wrz.105.1619617743312;
 Wed, 28 Apr 2021 06:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <1618995255-91499-1-git-send-email-guoren@kernel.org>
 <20210428031807.GA27619@roeck-us.net> <CAJF2gTTSMC947zisNs+j_2rMoBqoOy-j1jvVBk2DNrf0Xt6sWA@mail.gmail.com>
 <CAK8P3a1DvsXSEDoovLk11hzNHyJi7vqNoToU+n5aFi2viZO_Uw@mail.gmail.com> <20210428124946.GA1976154@infradead.org>
In-Reply-To: <20210428124946.GA1976154@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 28 Apr 2021 15:48:29 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0zHhEjfEjHYx7UJuxnG1BfMgOhBi2sWrQxV0WwwAvBWQ@mail.gmail.com>
Message-ID: <CAK8P3a0zHhEjfEjHYx7UJuxnG1BfMgOhBi2sWrQxV0WwwAvBWQ@mail.gmail.com>
Subject: Re: [PATCH] csky: uaccess.h: Coding convention with asm generic
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Guo Ren <guoren@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:dTNYuGf/bvjL1/vBcUqA84N+2PSTHBRjrnCFO1sEjBfhjLfRrFM
 ik29EUnDS/2CDpEpQBS1zSiZrJ8DgxjPeOVoKtgSYm9pK6f+MAhpB8VmIbJhWljcx6BkLzC
 RrcTa6U0hgzk9rIZxIQBGU46fn2K3tOVq2bydtMjrRvpC4C4c0PRTpFEioicHaot/fm4UsL
 rI9u88RJn9RLb+N5b1Rkg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6NC2b99wojw=:Mt30fKiy7lF31UI1DLD+c8
 xzmGRzOZYmpfwdhoJsRp9VtJhM3qAumf8nDTp9i/6zJQJPmrwHSZftVp1z+5iHVNBqJ6chKod
 ifN3nyuJPxj1AXzrNUqRtZmRziVMrJbbGRaYX6hI2BQhyDenvL7q56YXlxBgawlBZzyz2DnwG
 mB95YO5+oBCgMwzxlYbr6JJ/YoHrTlB8psdvKTh4MzcXazGeRgdP9WQGVMBoqDqUjdCMo3oFJ
 sF+Rw/HC5VZ+Gqr0nUNDp/U441JJV37oXVdwdopXAzdtvj5FlO8Hne3hW3nFgnSvUZnFa+zEK
 7jzqw6NtN7p69av0/h7vY40E0fHIA/UbUPKc9DPommxigKCpQ/bfblH5dpu2IzBcVqA9wbGVF
 TxuQA2D+slSwAD78Om6Kf+QDcD7CTbQiPszjcWjRWFk0XVdP8RRfF3li7OQu2Sg+zaY4TEvkj
 UUK8mPivoPPxlOIx5CdW5mkDylG9+mRzDvyUquYkC4CV8gZkDAwfvxs5YwWggccKZ/DMHuSv+
 nBwjdgZyruLaivqkZr4DZI=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 28, 2021 at 2:49 PM Christoph Hellwig <hch@infradead.org> wrote:
> On Wed, Apr 28, 2021 at 11:25:29AM +0200, Arnd Bergmann wrote:
> > We might want to come up with a new version of asm-generic/uaccess.h
> > that actually makes it easier to have a sane per-architecture
> > implementation of the low-level accessors without set_fs().
> >
> > I've added Christoph to Cc here, he probably has some ideas
> > on where we should be heading.
>
> I think asm-generic/uaccess.h pretty much only makes sense for
> nommu.  For that case we can just kill the __{get,put}_user_fn
> indirection.  I actually have work for that in an old branch.
>
> Trying to use any of asm-generic/uaccess.h for MMU based kernel is
> just asking for trouble.

The one thing I'd like to see is a generic implementation of the outer
bit that implements handling the variable-length arguments, there are
so many ways that people have gotten that wrong in the past, and
it would be nice if architectures only had to implement a set of fixed-size
accessors that contain the architecture specific inline asm.

There is now a new version for x86 that based on asm-goto with
output, which should in theory provide a better implementation
for any architecture when using gcc-11/clang-11 or higher.

> > One noteworthy aspect is that almost nothing users the low-level
> > __get_user()/__put_user() helpers any more outside of architecture
> > specific code, so we may not need to have separate versions
> > for much longer.
>
> Al has been trying to kill them off entirely for a while, and I hope
> he'll eventually succeed.  That being said the difference should be
> that the __ versions just skip the access_ok, so having both is
> fairly trivial to implement.

That is the difference in the interface, but in some of architectures
there is another difference in that the __ version is completely
inlined while the normal version calls an external function.
I could never quite figure out the reason for this difference.

      Arnd
