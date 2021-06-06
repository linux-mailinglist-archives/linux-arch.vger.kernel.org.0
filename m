Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B99639D086
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 20:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhFFSvy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 14:51:54 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:45770 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhFFSvw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Jun 2021 14:51:52 -0400
Received: by mail-lf1-f51.google.com with SMTP id a1so12640328lfr.12
        for <linux-arch@vger.kernel.org>; Sun, 06 Jun 2021 11:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RJCua1TpemFOI3glAj3fgLbjj5CxdDpoZVGdK1bpooE=;
        b=eQFMVtzND83RNvBKe4gAJD9EpVFbNqfEo6XBgSpWhwW0OiuPD/lGFputn9h6YanwSf
         ohx5NvMs8hu1wCWtc40QJv5O8HrmCChBxr1RnmVvLasDZe1r9HwPa/xSxXQQPQwSwk+2
         CLsnEdpEEjSfN0HlTs+pdvfGZCV/grDccJwew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RJCua1TpemFOI3glAj3fgLbjj5CxdDpoZVGdK1bpooE=;
        b=mbdcyDZot67PEPFaQGJLUPz9f6nxepNGgNtUG0Uw8182PCkVKK67mkdANYiFFg7loN
         9d2vyXLetvqUltis+b6mFo2eWuhQorOAEJvPnEiC5posOhvnZDArkiq11t0zs6ksubh8
         aPmpFfU2ZHdSoeBwPXT8QV9qIRbP+AYjyN4EEvJcWtj3BTuRYhQaadf5AWIQPR0bOj17
         8DxjaANe1EMQ1GB8z/lP5WadpUcJ/qW9ZluNzuKd2axI6+CSBe84ECbnnGhoSGra1VEW
         nsfcm4spSnCgi+ST+Ob7lvAQV5Vh+QG0UkD8PkQm2DMw/dhA/3sEdsMSJvX1jdW2b69p
         heNQ==
X-Gm-Message-State: AOAM530fFtjgtvkt/xxG7k0qhYfu2N1T5fNPPpPMDctTWZYA2tXbi70H
        0njRSJEf7YQPEOSMDQlvzpG3A6LM5KMi6h5ohWI=
X-Google-Smtp-Source: ABdhPJwtiqS17zliUjX8wqEJa0k0jhF2KgNijyDxwEnY/vmqjMCrimjlvutPywDCngXF72w/xI3IyA==
X-Received: by 2002:ac2:5551:: with SMTP id l17mr9724675lfk.534.1623005330654;
        Sun, 06 Jun 2021 11:48:50 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id a14sm1223813lfs.108.2021.06.06.11.48.48
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 11:48:49 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id v22so20991026lfa.3
        for <linux-arch@vger.kernel.org>; Sun, 06 Jun 2021 11:48:48 -0700 (PDT)
X-Received: by 2002:ac2:43b9:: with SMTP id t25mr9503593lfl.253.1623005328455;
 Sun, 06 Jun 2021 11:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com>
 <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
 <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com>
 <20210605145739.GB1712909@rowland.harvard.edu> <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu> <20210606115336.GS18427@gate.crashing.org>
 <CAHk-=wjgzAn9DfR9DpU-yKdg74v=fvyzTJMD8jNjzoX4kaUBHQ@mail.gmail.com> <20210606184021.GY18427@gate.crashing.org>
In-Reply-To: <20210606184021.GY18427@gate.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Jun 2021 11:48:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjEHbGifWgA+04Y4_m43s-o+3bXpL5qPQL3ECg+86XuLg@mail.gmail.com>
Message-ID: <CAHk-=wjEHbGifWgA+04Y4_m43s-o+3bXpL5qPQL3ECg+86XuLg@mail.gmail.com>
Subject: Re: [RFC] LKMM: Add volatile_if()
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 6, 2021 at 11:43 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> You truly should have written a branch in tthe asm if you truly wanted
> a branch instruction.

That's exactly what I don't want to do, and what the original patch by
PeterZ did.

Why?

Because then we need to write that stupid pointless branch for every
single architecture.

And to work well, it needs "asm goto", which is so recent that a lot
of compilers don't support it (thank God for clang dragging gcc
kicking and screaming to implement it at all - I'd asked for it over a
decade ago).

So you get bad code generation in a lot of cases, which entirely
obviates the _point_ of this all - which is that we can avoid an
expensive operation (a memory barrier) by just doing clever code
generation.

So if we can't get the clever code generation, it's all pretty much
moot, imnsho.

A working barrier "just fixes it".

I suspect the best we can do is to just work around the gcc badness
with that __COUNTER__ trick of mine. The lack of a reliable comment
character is the biggest issue with that trick.

                 Linus
