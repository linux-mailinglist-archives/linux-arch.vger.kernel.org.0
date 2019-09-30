Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62397C294A
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2019 00:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfI3WIV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Sep 2019 18:08:21 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40345 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfI3WIV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Sep 2019 18:08:21 -0400
Received: by mail-lj1-f195.google.com with SMTP id 7so11138505ljw.7;
        Mon, 30 Sep 2019 15:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XVYFsDz4vREp8ZSRf0zTMs244xJkgJaF/u18hl6MGk4=;
        b=SosvQtC/R1g7Bd+ChiKpXUzohopP6VF9c+Sh39MAYTApzuZC8aEMcZ7JLDdGKJ64XO
         6w7vQncP03M6KqvYbtDbd/4EPgGzeaYZKCJ0uzyumQt4Kgl9Jrq6rwvNcQcfk3tswl9M
         00iKOPKUYhqPTEHBJySaUo6i7M+RI1b/alftpJi2EHCg7ojN0S4BMu2nw1a3BHkeb5AN
         8VA4Pfv9wXACOc7TCrCczTueAVXHfGO4P91mw4H/lEAeecd1E4w4/1kdvk4wWfqOO4YI
         GQKdg4gJaRSgXd4LAZ/Y6ytFH01TVfrK2iDqGjUYJEIcC3REbhbjPYk9EcsvjIq3Toq2
         CNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XVYFsDz4vREp8ZSRf0zTMs244xJkgJaF/u18hl6MGk4=;
        b=EbQ2XhQ5CLkf6wAl/7nPxgVjHstGSyNQpOaE2OlJsjfsp2EQWDIJV76A1399uvvaiZ
         LDYBzfuhWL3ONNU/+PjM+PI7emZ1LWj1Tmo9qLO/BmIbJR8b5MWGAAe/aI+TfUP6KBiQ
         3SAH1UB10AGSpunautwFOdF0M00W9YSHXqEa9jenQkSFpLvFZh03a4Ni6hX+27FD1hTj
         BzVeevkTw7T8ETp7v4/xodYcIuSK23O6nDRlpxBzkq/yb1/74OzLPFKnbHr9QHV9O/HI
         DckjwQtW6ynKIruZuNMnz1cj1UfKVdyXEJooUpfyqa/Us4jeBq36pStg8dnr6Y1HV1ES
         QX7A==
X-Gm-Message-State: APjAAAWh78WzKTnXzuXTmVbykP2VN49F5/RdN1lwcyFa/rwUsWb8bTqU
        ibVbJgg5BYDCOtzAuBFsBFuaYjB3yuv96qKn5PM=
X-Google-Smtp-Source: APXvYqz7W5tUMdwsZ9FmQJVTx8wbccrL8KkBbmimUt1T0WjY/lLpFV7aq24TBxMlU7NoBZxzqZpGj3wQXOL/O/hWcOc=
X-Received: by 2002:a2e:4704:: with SMTP id u4mr13379612lja.203.1569881298946;
 Mon, 30 Sep 2019 15:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190830034304.24259-1-yamada.masahiro@socionext.com>
 <f5c221f5749e5768c9f0d909175a14910d349456.camel@suse.de> <CAKwvOdk=tr5nqq1CdZnUvRskaVqsUCP0SEciSGonzY5ayXsMXw@mail.gmail.com>
 <CAHk-=wiTy7hrA=LkmApBE9PQtri8qYsSOrf2zbms_crfjgR=Hw@mail.gmail.com>
 <20190930112636.vx2qxo4hdysvxibl@willie-the-truck> <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck> <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
In-Reply-To: <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 1 Oct 2019 00:08:07 +0200
Message-ID: <CANiq72kbZVB4vdyQonMQzuRHdh=BnD6F=sv5NQsFey5_xAB-Zg@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
To:     Nick Desaulniers <ndesaulniers@google.com>
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

On Mon, Sep 30, 2019 at 11:50 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> So __attribute__((always_inline)) doesn't guarantee that code will be
> inlined.  [...] inline and __attribute__((always_inline))
> are a heuristic laden mess and should not be relied upon.

Small note: in GCC, __attribute__((always_inline)) is documented as
actually guaranteeing to either inline or error otherwise (although
see the remark for indirect calls):

    "Failure to inline such a function is diagnosed as an error. Note
that if such a function is called indirectly the compiler may or may
not inline it depending on optimization level and a failure to inline
an indirect call may or may not be diagnosed."

As for LLVM/Clang, no idea, since it does not say anything about it in
the docs -- but from what you say, it is a weaker guarantee.

Cheers,
Miguel
