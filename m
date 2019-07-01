Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9712E5BF73
	for <lists+linux-arch@lfdr.de>; Mon,  1 Jul 2019 17:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfGAPPK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Jul 2019 11:15:10 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32821 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbfGAPPI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Jul 2019 11:15:08 -0400
Received: by mail-qt1-f193.google.com with SMTP id h24so11993362qto.0;
        Mon, 01 Jul 2019 08:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SWzGaJ3K1m5MITaG47DyN8fuDrDuFeO4EBg8cfltv6A=;
        b=hQ5leNLM8zxOlu0xsEq+CpBBF+yONRHMazzmXgQLZJgzPUrIhv3SqKdZHn0TthjDRf
         2+EZ1PV5SayL37HNJkFiSF3YChEPRaieqPDrGtd2+1zr9pI4nnrE/MbO5pNjg3zWcvSH
         jS3d4lRakpMjcM0E3GH3ok6qBYtARCJ4NdSDzkZ5N9l+oPaSAr+1tlrg8YMKA95YGYPy
         zTyInKt2ata0phwGhrq4uNQUTSYImaZNouGYToCVA/YoDXppDdz7sz7zfnwODOUB7Wtq
         HgsJn4yXw8q+mLwRnI8umKsBZFBVhkdnuuTPIS0IMbHX/osrvVAKzbUq0y1cCew6Hq4I
         QkGA==
X-Gm-Message-State: APjAAAVUP0vb2G8h1jSw9Rk6s1rRnBeWm5ruBHyutSGuIWrx+Vcd8+YT
        KgPHFLDm+L09OMH/Wi6uiAL4hfiLaVLbA9igh02wV5bE
X-Google-Smtp-Source: APXvYqx2fcdlEPw8crNsDt0x8PrIMzIH0ySrWp/sigjo3EdA1jcH64351orRTGa3HS4+P7B9/E6V6IaUYuj0wxQf3YU=
X-Received: by 2002:aed:33a4:: with SMTP id v33mr20640020qtd.18.1561994107714;
 Mon, 01 Jul 2019 08:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190604160944.4058-1-christian@brauner.io> <20190604160944.4058-2-christian@brauner.io>
 <20190620184451.GA28543@roeck-us.net> <20190620221003.ciuov5fzqxrcaykp@brauner.io>
 <CAK8P3a2iV7=HkHBVL_puvCQN0DmdKEnVs2aG9MQV_8Q58JSfTA@mail.gmail.com>
 <20190621111839.v5yqlws6iw7mx4aa@brauner.io> <CAK8P3a0T1=eg5ONbMFhHi=vmk1K5uogZ+5=wpsXvjVDzn6vS=Q@mail.gmail.com>
 <20190621153012.fxwhx25mzmzueqh7@brauner.io>
In-Reply-To: <20190621153012.fxwhx25mzmzueqh7@brauner.io>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 1 Jul 2019 17:14:51 +0200
Message-ID: <CAK8P3a0f_=q88JB=t7fbmweAbZ2E2_uCMt+2JoBYx3od_M6fHQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arch: wire-up clone3() syscall
To:     Christian Brauner <christian@brauner.io>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Ley Foon Tan <lftan@altera.com>,
        "moderated list:NIOS2 ARCHITECTURE" 
        <nios2-dev@lists.rocketboards.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 21, 2019 at 5:30 PM Christian Brauner <christian@brauner.io> wrote:
> On Fri, Jun 21, 2019 at 04:20:15PM +0200, Arnd Bergmann wrote:
> > On Fri, Jun 21, 2019 at 1:18 PM Christian Brauner <christian@brauner.io> wrote:
> Hm, if you believe that this is fine and want to "vouch" for it by
> whipping up a patch that replaces the wiring up done in [1] I'm happy to
> take it. :) Otherwise I'd feel more comfortable not adding all arches at
> once.
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=clone

Sorry for my late reply. I had actually looked at the implementations
in a little
more detail and I think you are right that adding these are better
left to the arch
maintainers in case of clone3.

      Arnd
