Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4700F4C5F85
	for <lists+linux-arch@lfdr.de>; Sun, 27 Feb 2022 23:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiB0Wn7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 27 Feb 2022 17:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiB0Wn6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 27 Feb 2022 17:43:58 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A9A3EB9F;
        Sun, 27 Feb 2022 14:43:21 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id q4so8758400ilt.0;
        Sun, 27 Feb 2022 14:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z4bnNwe7U2Vh4XIKAHcu6wdoajMLlbGI9CQD4DbPubI=;
        b=JIN504u2qQKThwiQ0dRzJl4Q1JGJc/rswp3AoRX7y2BC/ZNBM+/cn7UAXV99gtQ16s
         bBgiUUvet/5oYcL8u0Hi8FS7T8KhouECYUL2WVPC82JuOoW76dUOKv8DpZGCwarRcdAs
         YBoA0VY19lGkuUfWuBYiYK05rtybnWFusXwQO7BYx8juikiLo0cQZJqWugmOW9uEBZX8
         OmtnKMihq4nmXhNnUt0dY147hFrkej9Ajnb7LSa126wnESmFZJmsoT+JikLlewrLrhoB
         UIoRV/+8eGUCWoNst8NVdZ62gnltE4xDzI1dLXochfsNXL8g+ondEc5FoBV4alw6CBf1
         3iJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z4bnNwe7U2Vh4XIKAHcu6wdoajMLlbGI9CQD4DbPubI=;
        b=6W1DmWmGvK27dlobVD8EK4kyxAkjhKz9rcllK0AKPFybHPE4uGfj/B0sYHWsforCaZ
         KqQM8sVGV6+IeirjaMelSN4vmQewEZ6T3fT9DS4LatUkd8aWA+s7oMXS0vUQRMBeLtwg
         Eo1Ds0GvnDrUIfOI+EWI9VKJ3y6As/uBlFlweMQoepE5XdpNTP+SDcQnSLdbcLbC5Fbj
         VmDsb2nJxWX5KLiJTzPmVYW2tzt3pphN6wdAj1JYIfDhWa2rf8GVeedD/YxQU4O0ZmTB
         yP76f9MEQdVIKT0IuDzfxLZrhJ4J0ODrcualT7b5kp5gzNyntDOhZK2jCCDCLTopwDzt
         HppA==
X-Gm-Message-State: AOAM533yuxNGDtKWAYJYuxlY4+l3nyJZgjwkw4RTCs7DVHSVtqErcFeD
        FsgAoGJbsDpjE+sH/hVx6gI4vGAv9lca6CejHOE=
X-Google-Smtp-Source: ABdhPJx+SeevTo5vtSZhGvvpVA1ddy2bLL8U09bLcO/C5jYWsYcKNU24IfCWMR7ECyUwpgphUUaEuawHmtZKNIZFiMg=
X-Received: by 2002:a05:6e02:b24:b0:2be:88f8:c4ed with SMTP id
 e4-20020a056e020b2400b002be88f8c4edmr16277966ilu.72.1646001800972; Sun, 27
 Feb 2022 14:43:20 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com>
 <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com> <CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com>
 <CAHk-=wgLe-OSLTEHm=V7eRG6Fcr0dpAM1ZRV1a=R_g6pBOr8Bg@mail.gmail.com>
 <20220226124249.GU614@gate.crashing.org> <CAK8P3a2Dd+ZMzn=gDnTzOW=S3RHQVmm1j3Gy=aKmFEbyD-q=rQ@mail.gmail.com>
 <20220227010956.GW614@gate.crashing.org> <7abf3406919b4f0c828dacea6ce97ce8@AcuMS.aculab.com>
 <20220227113245.GY614@gate.crashing.org> <CANiq72m28WrjVHkcg5Y0LDa51Ur4OCpFbGdcq+v4gqiC0Wi6zg@mail.gmail.com>
 <20220227201724.GZ614@gate.crashing.org>
In-Reply-To: <20220227201724.GZ614@gate.crashing.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 27 Feb 2022 23:43:09 +0100
Message-ID: <CANiq72nbLHvHX4Nk3oGutL=y3MghrFHs6HsmqN8HA8XwSv-4Ow@mail.gmail.com>
Subject: Re: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jakob <jakobkoschel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Feb 27, 2022 at 9:19 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> Requiring to annotate every place that has UB (or *can* have UB!) by the
> user is even less friendly than having so much UB is already :-(

Sure, but I did not suggest to annotate every place -- at least not in C.

What I said is that in cases like your division by zero example, there
is no one-fits-all solution. For instance, for integer arithmetic,
leaving the choice (e.g. wrapping, saturating, unchecked...) to the
user is a better approach.

> You need a VM like Java's to get even *close* to that.  This is not the
> C target: it is slower than wanted/expected, it is hosted instead of
> embedded, and it comes with a whole host of issues of its own.  One of
> the strengths of C is its tiny runtime, a few kB is a lot already!
>
> I completely agree that if you design a new "systems" language, you want
> to have much less undefined behaviour than C has.  But it is self-
> delusion to think you can eradicate all (or even most).

Nobody is suggesting to remove "all UB" in that sense or to use
VM-supported languages.

However, you can """eradicate all UB""" in a sense: you can offer to
write most code in a subset that does not allow any potential-UB
operations. This can even be "all" code, depending on how you count
(e.g. all application code).

Obviously, you still need the unchecked operations to implement the
safe APIs. This is why I mentioned them.

> And there are much bigger problems in any case!  If you think that if
> programmers could no longer write programs that invoke undefined
> behaviour they will write much better programs, programs with fewer
> serious functionality or security problems, even just a factor of two
> better, well...

Actually, according to several reports from Google, Microsoft, etc.,
it _is_ the biggest problem (~70%) when talking about security bugs.

So it is a good bet that it will translate into "better" programs, at
least on that axis, unless it is showed that removing UB somehow
increases the rate of other errors.

As for functionality problems, there are several ways to improve upon
C too, though it is harder to show data on that.

Cheers,
Miguel
