Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 315546D658
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2019 23:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfGRVVm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Jul 2019 17:21:42 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40780 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfGRVVm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jul 2019 17:21:42 -0400
Received: by mail-vs1-f68.google.com with SMTP id a186so18528333vsd.7
        for <linux-arch@vger.kernel.org>; Thu, 18 Jul 2019 14:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JLWgE4G1xumD+5ZusInPzcVsAid5/1NnJBPXIPh5kwU=;
        b=c/8BoGQt9/QOqtqbYVLLVLcLBKKCNOL7ZGgciVXxCS21F1WB5gBw1Lhtv1yMwGbQ/8
         FL7h6h0baE/EM6HpjnHtdgaCQxgO1LCBFh5EMOP8abh9QCVx9P0iVVBR1osJKkuIj37I
         7In1Y7cMeJe/ozyMDC/3pmdbyV+j2J3tmfucx9P0zn3zlgwZMEGPszlG/ypDkHx9w0ey
         VmnNdkY5C43kS4BMQYBEBtVWCnmD58X/+gFuHIi7F0VXGS7IeLhQ6lpyF6vygZUViVa0
         OEbs/lPqkuIOfBqlLezNboG1lpxEwSrVjAGOZTHk62zaj5AxQJAcmrSg06aF3ENi3eNO
         sM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JLWgE4G1xumD+5ZusInPzcVsAid5/1NnJBPXIPh5kwU=;
        b=Ju7rgvdFlDRI5MmKSavb0diyOdFCzdnPDMJraFnfHBdQW+vID+E+DtJkm5UQPk6gI6
         R1AuYj2Wr+dcZ8ySgusBCqmR+JJV4NcJyCOrl24oDY8AmzSddveN9wEJIGgz+fOOTObU
         kih0hxiw1HxlTqJyO0lw2VICvRl15MTd5tnulcvMlW8nvYuYLyFJydg8z9ditoDsTO3D
         dXgkydKENfIsjQXfEdhpGtGeCV224uHuNLcymqcFW3q/8Y8PytJFn11Ulr5huBxFhIbd
         chxnpNAw7F0k5D2Mi7hmwdbmLJxHNWOq2IhKJlIdMIS1K40jLTQPFrS2NA9qX5AFds+k
         6Udg==
X-Gm-Message-State: APjAAAUhR822IpUN+V+BXfJb/GHUQNUWOVxBDbY3qcmRpXPlxqAdvcIR
        o5nNTGUdU/cCsJq0g0foZ5yvmKwn5UStROTXvmfR
X-Google-Smtp-Source: APXvYqzw6e79MIrSSr/wveDt3o5nS/x3WVT9g6SIC9rmt/BfJdmhC96Gcdb7mp3vJdj09OD/y6QUPsswLWFlksDLylI=
X-Received: by 2002:a67:d39e:: with SMTP id b30mr30387881vsj.212.1563484900833;
 Thu, 18 Jul 2019 14:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <1562959401-19815-1-git-send-email-cai@lca.pw> <20190712.154606.493382088615011132.davem@davemloft.net>
 <EFD25845-097A-46B1-9C1A-02458883E4DA@lca.pw> <20190712.175038.755685144649934618.davem@davemloft.net>
 <D7E57421-A6F4-4453-878A-8F173A856296@lca.pw> <CAKwvOdkCfqfpJYYX+iu2nLCUUkeDorDdVP3e7koB9NYsRwgCNw@mail.gmail.com>
In-Reply-To: <CAKwvOdkCfqfpJYYX+iu2nLCUUkeDorDdVP3e7koB9NYsRwgCNw@mail.gmail.com>
From:   Bill Wendling <morbo@google.com>
Date:   Thu, 18 Jul 2019 14:21:29 -0700
Message-ID: <CAGG=3QUvdwJs1wW1w+5Mord-qFLa=_WkjTsiZuwGfcjkoEJGNQ@mail.gmail.com>
Subject: Re: [PATCH] be2net: fix adapter->big_page_size miscaculation
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Qian Cai <cai@lca.pw>, James Y Knight <jyknight@google.com>,
        David Miller <davem@davemloft.net>, sathya.perla@broadcom.com,
        ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
        somnath.kotur@broadcom.com, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, netdev@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

[My previous response was marked as spam...]

Top-of-tree clang says that it's const:

$ gcc a.c -O2 && ./a.out
a is a const.

$ clang a.c -O2 && ./a.out
a is a const.


On Thu, Jul 18, 2019 at 2:10 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Jul 18, 2019 at 2:01 PM Qian Cai <cai@lca.pw> wrote:
> >
> >
> >
> > > On Jul 12, 2019, at 8:50 PM, David Miller <davem@davemloft.net> wrote:
> > >
> > > From: Qian Cai <cai@lca.pw>
> > > Date: Fri, 12 Jul 2019 20:27:09 -0400
> > >
> > >> Actually, GCC would consider it a const with -O2 optimized level because it found that it was never modified and it does not understand it is a module parameter. Considering the following code.
> > >>
> > >> # cat const.c
> > >> #include <stdio.h>
> > >>
> > >> static int a = 1;
> > >>
> > >> int main(void)
> > >> {
> > >>      if (__builtin_constant_p(a))
> > >>              printf("a is a const.\n");
> > >>
> > >>      return 0;
> > >> }
> > >>
> > >> # gcc -O2 const.c -o const
> > >
> > > That's not a complete test case, and with a proper test case that
> > > shows the externalization of the address of &a done by the module
> > > parameter macros, gcc should not make this optimization or we should
> > > define the module parameter macros in a way that makes this properly
> > > clear to the compiler.
> > >
> > > It makes no sense to hack around this locally in drivers and other
> > > modules.
> >
> > If you see the warning in the original patch,
> >
> > https://lore.kernel.org/netdev/1562959401-19815-1-git-send-email-cai@lca.pw/
> >
> > GCC definitely optimize rx_frag_size  to be a constant while I just confirmed clang
> > -O2 does not. The problem is that I have no clue about how to let GCC not to
> > optimize a module parameter.
> >
> > Though, I have added a few people who might know more of compilers than myself.
>
> + Bill and James, who probably knows more than they'd like to about
> __builtin_constant_p and more than other LLVM folks at this point.
>
> --
> Thanks,
> ~Nick Desaulniers
