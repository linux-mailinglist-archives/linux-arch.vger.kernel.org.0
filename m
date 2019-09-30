Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7FE1C29A5
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2019 00:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfI3Wey (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Sep 2019 18:34:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35183 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfI3Wey (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Sep 2019 18:34:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id 205so6429795pfw.2
        for <linux-arch@vger.kernel.org>; Mon, 30 Sep 2019 15:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7SR5SJpCZzCR2HUyKgols4Ma/MTXm0Tu30NRGBJBmLQ=;
        b=MOWTHPUwU1iS50Z3VFZA5DFevN71k70iB6IqofUavf/x1Nw+kv1n0f0Sq5oAZEzLvL
         xLQFdHuY2ewoREYA3vaIqrKdhMxDxcKTmjl9JS5mLDb//GKRO4pR9pr0tGSdFwURX/Hm
         q+rCUWqufGVzOq/ajZ4+ysaFaZF39LNfK6RxkybZ7Ld/DFxDtmSlJNzHEIv/BZhE+44m
         WV6trAVqy1zOmVuGaejXWaRtNbSI1LWY2Y1QUafxdmQifE14+Vo/0IWblPjFVpw8zYyZ
         UUfsJZRE54IiOF4YqjuO/qBjMN2RhDYUOixGN1CN8FS834d1pmqTq7UWdEHpavKTXIiq
         oSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7SR5SJpCZzCR2HUyKgols4Ma/MTXm0Tu30NRGBJBmLQ=;
        b=WZyAFxVPFRLmCe1e9g1xQ81ezblnlJT/RUMNkZfX3k3DS0q4tUpNa2KtGAPub7hmqZ
         OtB+UQdTFOIqX+LRcU7N4XUnUmg3WlX0lyp06Guj/wvKiE7D5VVyy/TTIU6wgjCfiqty
         ALBBDuBBuvWRhBW9Uc+IJHsgh3ihhllWecUUosZwIZgQh8FYmiYYC4iR57QNsqZKZXpZ
         JPtOwiPy28SmsQewNsD8TZQRB7CTeuQK2fhYouhTqfc+HD6XkvtExI/HIdKZ9KL85pmP
         vS+hCkSGRjOsivItwuRsiJwD6bBOFXil4mfVlg5ydH3rj89mxhgNu5TQA8E5oRn3ZspT
         BIWQ==
X-Gm-Message-State: APjAAAW+hNRdy0VrMypjuzP3q+OJVDhNNV25FtRV/Ejn3WlUhy+YYBqm
        R5FkFSYN55G9QAIHn71DAdVuq7k8a0avdbgnjd7Wvg==
X-Google-Smtp-Source: APXvYqyOU2bwSPdSL51Jh7RdzyoNXLxhELPpgkbg72EzzJZ/2dNcZv/B/p8mtSppYe8kSal5ZVqB7ESgT0GvDuiU08g=
X-Received: by 2002:a17:90a:178d:: with SMTP id q13mr1777052pja.134.1569882893154;
 Mon, 30 Sep 2019 15:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190830034304.24259-1-yamada.masahiro@socionext.com>
 <f5c221f5749e5768c9f0d909175a14910d349456.camel@suse.de> <CAKwvOdk=tr5nqq1CdZnUvRskaVqsUCP0SEciSGonzY5ayXsMXw@mail.gmail.com>
 <CAHk-=wiTy7hrA=LkmApBE9PQtri8qYsSOrf2zbms_crfjgR=Hw@mail.gmail.com>
 <20190930112636.vx2qxo4hdysvxibl@willie-the-truck> <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck> <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
 <CANiq72kbZVB4vdyQonMQzuRHdh=BnD6F=sv5NQsFey5_xAB-Zg@mail.gmail.com>
In-Reply-To: <CANiq72kbZVB4vdyQonMQzuRHdh=BnD6F=sv5NQsFey5_xAB-Zg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 30 Sep 2019 15:34:41 -0700
Message-ID: <CAKwvOdm_GoUeDjAYXTqCTuvdL+9vwvfeofhv06MLMYVA75CnEg@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Stefan Wahren <wahrenst@gmx.net>,
        Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 30, 2019 at 3:08 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Sep 30, 2019 at 11:50 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > So __attribute__((always_inline)) doesn't guarantee that code will be
> > inlined.  [...] inline and __attribute__((always_inline))
> > are a heuristic laden mess and should not be relied upon.
>
> Small note: in GCC, __attribute__((always_inline)) is documented as
> actually guaranteeing to either inline or error otherwise (although
> see the remark for indirect calls):
>
>     "Failure to inline such a function is diagnosed as an error. Note

Not an error, but a warning at least: https://godbolt.org/z/_V5im1.

That's interesting, so it has multiple semantics, because it's also
documented to inline even when no optimizations are specified.  So
when someone uses __attribute__((always_inline)) without a comment,
it's not clear whether they mean for there to be a warning when this
is not inlined, or for it to be inlined at -O0 (guess not for the
kernel), or both.  If the kernel wants to enforce the former, why not
set `-Werror=attributes`?  Maybe that warning is too broad?  Seems
like a recipe for subtly broken code found at runtime, when we'd
rather have stronger compile time guarantees.

> that if such a function is called indirectly the compiler may or may
> not inline it depending on optimization level and a failure to inline
> an indirect call may or may not be diagnosed."
>
> As for LLVM/Clang, no idea, since it does not say anything about it in
> the docs -- but from what you say, it is a weaker guarantee.

Filed https://bugs.llvm.org/show_bug.cgi?id=43517
-- 
Thanks,
~Nick Desaulniers
