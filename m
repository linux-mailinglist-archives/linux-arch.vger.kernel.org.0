Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F7D3AF985
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jun 2021 01:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhFUXjJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Jun 2021 19:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbhFUXjH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jun 2021 19:39:07 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA60C061574
        for <linux-arch@vger.kernel.org>; Mon, 21 Jun 2021 16:36:51 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id m21so32896737lfg.13
        for <linux-arch@vger.kernel.org>; Mon, 21 Jun 2021 16:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fqBMFMkh+3vsj4PE2zy4sOG9Di6zkfuPgmZeKyRMggk=;
        b=FwTzGNcpDtlrI1kY0RIGO3zETGbXVETw5XVSJFPsLGj6Xz/SJV56ObDVCGf2pDuQ1Z
         igDUi27LyzA/lOjip7sVylirPYT+bZ/hF+sKh406iS7GyB+Vq1L8K8GDXIUSy1RHLXYZ
         859pKuXlceGLPjaK41xP26kUTIY685CWI4qnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fqBMFMkh+3vsj4PE2zy4sOG9Di6zkfuPgmZeKyRMggk=;
        b=fhyD12FRe7BBg5gLSio4GfHPc3Dc2bCW7fii4Fsu5dII4rShrP36ukKxau5cdYrVZA
         FSkCK9sbk48BA/hYp19b9umSfDkj/COreuk5cRw5ePPbLvQv9eyruDaf5mLPgDnBvFNR
         dMjUm5z4AFskBcgE7VaqJyGMJijku6SooG5AP3SR6Au6h5bxJyRODrr/fZbQdUDdS+5o
         rrZQSjSvU0glRc4m4oRRAA/ePoMkCNgh9wF/rowhqN7arwumyQ2Zfwlw4D4uy8S47uGb
         vAxXxZvUwwlHmpCb7hn6O7olohw1SsNSK1A6C5Yrd+pskLierfKw6IQompsfygZmPzU2
         ZrNA==
X-Gm-Message-State: AOAM532Kj/PJsqbvOFVEYdj20WbsYHvUadzDumDoEmco3I/pErE80t4V
        XH0KzjL4zbBdJU4gdAAK/YrWucsJEZOZ/6H9Z3E=
X-Google-Smtp-Source: ABdhPJzpA0qUOcxXjhplHjCUwQDB/9wS6kFzRSKQQ4Bvkx2SZHfDJ6LVGyEkgA/Uz+RGkWuE6qiYuQ==
X-Received: by 2002:a19:7506:: with SMTP id y6mr532163lfe.629.1624318610208;
        Mon, 21 Jun 2021 16:36:50 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id br5sm671398lfb.82.2021.06.21.16.36.49
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 16:36:49 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id s22so27548390ljg.5
        for <linux-arch@vger.kernel.org>; Mon, 21 Jun 2021 16:36:49 -0700 (PDT)
X-Received: by 2002:a2e:22c4:: with SMTP id i187mr544552lji.251.1624318609289;
 Mon, 21 Jun 2021 16:36:49 -0700 (PDT)
MIME-Version: 1.0
References: <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
 <87eed4v2dc.fsf@disp2133> <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
 <87fsxjorgs.fsf@disp2133> <CAHk-=wj5cJjpjAmDptmP9u4__6p3Y93SCQHG8Ef4+h=cnLiCsA@mail.gmail.com>
 <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk> <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
 <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
 <YNDsYk6kbisbNy3I@zeniv-ca.linux.org.uk> <CAHk-=wh82uJ5Poqby3brn-D7xWbCMnGv-JnwfO0tuRfCvsVgXA@mail.gmail.com>
 <YNEfXhi80e/VXgc9@zeniv-ca.linux.org.uk>
In-Reply-To: <YNEfXhi80e/VXgc9@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Jun 2021 16:36:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjtagi3g5thA-T8ooM8AXcy3brdHzugCPU0itdbpDYH_A@mail.gmail.com>
Message-ID: <CAHk-=wjtagi3g5thA-T8ooM8AXcy3brdHzugCPU0itdbpDYH_A@mail.gmail.com>
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 21, 2021 at 4:23 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         How would it help e.g. oopsen on the way out of timer interrupts?
> IMO we simply shouldn't allow ptrace access if the tracee is in that kind
> of state, on any architecture...

Yeah no, we can't do the "wait for ptrace" when the exit is due to an
oops. Although honestly, we have other cases like that where do_exit()
isn't 100% robust if you kill something in an interrupt. Like all the
locks it leaves locked etc.

So do_exit() from a timer interrupt is going to cause problems
regardless. I agree it's probably a good idea to try to avoid causing
even more with the odd ptrace thing, but I don't think ptrace_event is
some really "fundamental" problem at that point - it's just one detail
among many many.

So I was more thinking of the debug patch for m68k to catch all the
_regular_ cases, and all the other random cases of ptrace_event() or
ptrace_notify().

Although maybe we've really caught them all. The exit case was clearly
missing, and the thread fork case was scrogged. There are patches for
the known problems. The patches I really don't like are the
verification ones to find any unknown ones..

            Linus
