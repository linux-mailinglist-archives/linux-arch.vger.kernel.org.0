Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F231458AEEB
	for <lists+linux-arch@lfdr.de>; Fri,  5 Aug 2022 19:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbiHERaT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Aug 2022 13:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241168AbiHERaO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Aug 2022 13:30:14 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEEF3A2
        for <linux-arch@vger.kernel.org>; Fri,  5 Aug 2022 10:30:12 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b96so4311103edf.0
        for <linux-arch@vger.kernel.org>; Fri, 05 Aug 2022 10:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ONebu+4QLRptJ6A+Ou0an3ofnAwu546ZMSAcmQOzkVY=;
        b=IWmWAJxYsy3IA4Cg/AofIaZIQu5z2QPcTD8IKLllL/eWUVmIqjemQRBI8751Gav7zj
         eEKQzkAkZK6Gehr3Ikl7Y7fdWkSSAgArdgJVV3ae7bL7M5nvXGvUQ5GYGjlAI7xgGz/s
         kI4jX93SFRIST1Y8CKlfAGLpScBIaYeX43zm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ONebu+4QLRptJ6A+Ou0an3ofnAwu546ZMSAcmQOzkVY=;
        b=tvFFfAmy/oKmscNOjr+48iuiLDMpkcqwC9qbeyUxlUdXSPhcSTqmQYO5iqKeNhoZBu
         ke/Tidv3rICmIaPyPzRv9MV21aq8XhltUIPdi0o9RgJpLT3BAvK0yiQZpUEdzh//6gya
         cfuyHXqYuft2f7mW9KCdr4A68guHJB/R5AOfQlJwEynmW1lxgocLkcCNmUCYcg14VixE
         N6ftaQWmALGDuBJdDfR11t+5P9CsZeASY6UkKaCxbNP8o1vOVZAgTyUPqy9RFb9WpHMQ
         Osg1qgN1FXQqf+Twvxyri2G+8fD85bJtgt9VN5j14sf3o48Ca1Il9m7nWqjZzyVhZM3J
         XqDg==
X-Gm-Message-State: ACgBeo1IFE/e6XDT8k/lN0KjikJa54L/cjj/k4yxq0cGfFgQ2pKAmHJ4
        7kCSeFJwRg8tH0X+5mGZmm/9zhhaWPS3EVho
X-Google-Smtp-Source: AA6agR4npC5rgKI8Iv+qHOJ3daB7tK5IeRZWF/NG1BNWJdA/7MCSsQT2g84wbNObDhklQp30PDKAKg==
X-Received: by 2002:a05:6402:1389:b0:43a:ceea:93fd with SMTP id b9-20020a056402138900b0043aceea93fdmr7524223edv.64.1659720610685;
        Fri, 05 Aug 2022 10:30:10 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id h14-20020a50ed8e000000b0043a2b8ab377sm177245edr.88.2022.08.05.10.30.09
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 10:30:10 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id z12so3948280wrs.9
        for <linux-arch@vger.kernel.org>; Fri, 05 Aug 2022 10:30:09 -0700 (PDT)
X-Received: by 2002:a5d:64c1:0:b0:220:8590:3809 with SMTP id
 f1-20020a5d64c1000000b0022085903809mr5008022wri.97.1659720609554; Fri, 05 Aug
 2022 10:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2jgQcLaDXX6eOTNrU0RJ2O625e75LBMy6v2ABP0cdoww@mail.gmail.com>
In-Reply-To: <CAK8P3a2jgQcLaDXX6eOTNrU0RJ2O625e75LBMy6v2ABP0cdoww@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 Aug 2022 10:29:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZSD3W2y6yczad2Am=EfHYyiPzTn3CfXxrriJf9i5W5w@mail.gmail.com>
Message-ID: <CAHk-=wgZSD3W2y6yczad2Am=EfHYyiPzTn3CfXxrriJf9i5W5w@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic: updates for 6.0
To:     Arnd Bergmann <arnd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 5, 2022 at 3:25 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
>  - A patch from Sebastian Siewior to rework the handling of
>    IRQ stacks in softirqs across architectures, which is
>    needed for enabling PREEMPT_RT.

I am quite fed up with the chaos and garbage that PREEMPT_RT has
caused this release.

Once again, this pull request contains senseless code because of a
PREEMPT_RT patch that was merged based on some bogus "the RT code
needs this".

First off, the RT code isn't currently enabled in upstream kernels, so
none of this merits any kind of big hurry and mindless "need to apply
because it's a bug".

Secondly, that patch is HORRENDOUSLY UGLY.

I hereby ask every single maintainer to immediately stop taking these
bogus patches that contain variations on random

  #ifdef CONFIG_PREEMPT_RT

because they are clearly left-over turds from the RT tree that were
unbelievably ugly hacks, and should never have been merged upstream.

Why am I so upset?

WE ALREADY HAVE A DIFFERENT CONFIG VARIABLE EXPLICITLY FOR THIS!

In fact, you can *see* that config variable in the patch.

There's a very specific HAVE_SOFTIRQ_ON_OWN_STACK variable that has
the following help message (even if that help will never be shown
because it's not an actual question, it's a helper config variable
that gets selected):

   config HAVE_SOFTIRQ_ON_OWN_STACK
        bool
        help
          Architecture provides a function to run __do_softirq() on a
          separate stack.

and that config variable ALREADY PROTECTS the do_softirq_own_stack()
declaration in asm-generic. The very one you just added the
CONFIG_PREEMPT_RT thing around.

In other words, the RT patch is just mindless and ugly, and the right
thing to do would have been

 (a) make HAVE_SOFTIRQ_ON_OWN_STACK have a

        depends on !PREEMPT_RT

 (b) as PREEMPT_RT is enabled one architecture at a time, you can make
the architecture header files also use that HAVE_SOFTIRQ_ON_OWN_STACK
thing, which makes a whole lot more sense than sprinkling random
CONFIG_REEMPT_RT things around.

I have pulled this, but I'm really *really* fed up with these
PREEMPT_RT patches that add code that MAKES NO SENSE.

In just this merge window:

 We had it in the dentry tree.

 Then we had it in the printk tree to the point where I refused to even pull it.

 And now we have it in the asm-generic tree too.

The rule about RT patches has *always* been that we merge them as they
become clean enough to make sense. That rule seems to have entirely
flown out the window here, and suddenly it has become a sport to add
random senseless #ifdef CONFIG_PREEMPT_RT lines to code.

At least the dentry case had a nice big comment (which really was
required exactly because the code made no sense on its own). This
patch had nothing of the sort.

PREEMPT_RT is special enough that it really needs to spend a _lot_
more time making the code sensible, rather than add random hacks like
this. And when we have a config parameter that is *explicitly* about
this very issue, we should use that one, not some PREEMPT_RT hack.

And the RT tree has had literally decades where people tried very hard
to do exactly that - make proper abstractions, and make sure that
merging the RT patches made sense even outside the context of the RT
code.

Now suddenly all that "this code has to make sense" seems to be history.

And it really shouldn't be.

              Linus
