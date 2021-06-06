Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59B339D088
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 20:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhFFS5M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 14:57:12 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:33472 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhFFS5L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Jun 2021 14:57:11 -0400
Received: by mail-lf1-f48.google.com with SMTP id t7so15222062lff.0
        for <linux-arch@vger.kernel.org>; Sun, 06 Jun 2021 11:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w5VchHZ9HNMBKb35UdCCE6Gr/vCI3h3rPMpf00kyqNs=;
        b=R2WObvngmVBGf8fkmSu/raDi70MtimjnPeoLsRpzIZ/QqlhRT9W729qtXgs0y+YRgE
         RccuCLSCbjRdauVYzc5HtTIUl0hU4XX6sAN+eohhsDMHfJe3SgfHLry/97Z55h4vRb9s
         IIm7AvmNxOb4EStL6EMtVKwNqWcgL8ls8QUQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w5VchHZ9HNMBKb35UdCCE6Gr/vCI3h3rPMpf00kyqNs=;
        b=JCFeq/mwx7SZBCTVmTIxZtmclcaYIc4fW1UtCbSy6+O7vbFo+93S26Lmit2iPbxVev
         zwjsoGXiFzQcpPYf14sjkVlcQDGUGqw0v9zoVagPV/LqujMLiP7rt+/wX6O6K98qdRQA
         1r3+Aw/ZgKseXeZKzT0JxAOGSlfrXVlLjTgKWD1Ty7UI3qwrVpGLwwtJ8h43nclRiR2Y
         +TkUe0aovRR7MwpPOS3nkf6uUgTDwy60EEEWTIzGhNyE48KYd2XG+YkGW5B/8iqzGBuJ
         FPzj8yUdkW2G5RRmABlFRCl0yGyzTr3BGF8vidoTD8P4MdDHr3l7OLdb8gfrZgsEsXg6
         0e4Q==
X-Gm-Message-State: AOAM5307GiAnUMPodFeFkp0+rkEM6/lEcaNZvywsjQ6uAsVhePuzjWxB
        DfGqa6jF5xh0j2+Eo5libl4L2ciNZvlnkbufW4E=
X-Google-Smtp-Source: ABdhPJy2TR9mSdjvhYIbmt0QyOEWw/AifTenh3QoCoKtcR1f5KqlOjv+rmGRkQYn4f9/W46fvTv8EQ==
X-Received: by 2002:a19:7d04:: with SMTP id y4mr9168230lfc.201.1623005648502;
        Sun, 06 Jun 2021 11:54:08 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id j17sm1115970ljc.100.2021.06.06.11.54.07
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 11:54:07 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id m3so18891129lji.12
        for <linux-arch@vger.kernel.org>; Sun, 06 Jun 2021 11:54:07 -0700 (PDT)
X-Received: by 2002:a05:651c:333:: with SMTP id b19mr11965516ljp.61.1623005647379;
 Sun, 06 Jun 2021 11:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com>
 <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
 <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com>
 <20210605145739.GB1712909@rowland.harvard.edu> <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu> <20210606115336.GS18427@gate.crashing.org>
 <CAHk-=wjgzAn9DfR9DpU-yKdg74v=fvyzTJMD8jNjzoX4kaUBHQ@mail.gmail.com>
 <20210606184021.GY18427@gate.crashing.org> <CAHk-=wjEHbGifWgA+04Y4_m43s-o+3bXpL5qPQL3ECg+86XuLg@mail.gmail.com>
In-Reply-To: <CAHk-=wjEHbGifWgA+04Y4_m43s-o+3bXpL5qPQL3ECg+86XuLg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Jun 2021 11:53:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiE14nATA-ejyeV0FmN9x1F+AiJvv88TZaj=DuxDP7sag@mail.gmail.com>
Message-ID: <CAHk-=wiE14nATA-ejyeV0FmN9x1F+AiJvv88TZaj=DuxDP7sag@mail.gmail.com>
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

On Sun, Jun 6, 2021 at 11:48 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> And to work well, it needs "asm goto", which is so recent that a lot
> of compilers don't support it (thank God for clang dragging gcc
> kicking and screaming to implement it at all - I'd asked for it over a
> decade ago).

Oh, actually, I'm wrong on this.

We don't need an output from the asm (the output ends up being in the
targets), so we can use the old-style asm goto that we've been relying
on for a long time.

So the main code generation problem is just (a) all the architectures
and (b) we'd have to use a fixed conditional against zero.

                Linus
