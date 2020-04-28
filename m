Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD211BB37B
	for <lists+linux-arch@lfdr.de>; Tue, 28 Apr 2020 03:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgD1Bg6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Apr 2020 21:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726251AbgD1Bg5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Apr 2020 21:36:57 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFD5C03C1A8
        for <linux-arch@vger.kernel.org>; Mon, 27 Apr 2020 18:36:57 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u15so19724048ljd.3
        for <linux-arch@vger.kernel.org>; Mon, 27 Apr 2020 18:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6dLKuml1l37VsUNUL7W3+8Plw3oZZU13zk85vygbzVU=;
        b=Bd+HoaOQxYuuh8Zf1OdODQuVSh84RUl4JQmlzGerUyQmf8yQo21wChRkbSt91VRbi7
         rW7nVLys2SsQX2Zyf0eFgqihojc0YmFDp8m/iu9CZyEhvrn1ELZTebPjm+Ei/dLS9xRA
         fQg/tEt3Rd0+Q259PEVjDGKRpewOS/+lcY8FU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6dLKuml1l37VsUNUL7W3+8Plw3oZZU13zk85vygbzVU=;
        b=QTpdMOR54JnRDCQ4WSYokBgV050MCZnXvZMQ15mAnqqUJ7UCp2NHlLKg5svHExAzYV
         k3s35robXcKkTqqT66j1CNSFqcnyekAoMnKmKUGtBJh1Z82B57r6rxm4qIz/qzbvZTLe
         8f1dgAECcd+86si+ZLUCAFkodqbC5zLees419IW+fdNrUS5pVPTtTOyAejbON1T7np+/
         Rru7aJkBgGUkma4aQzw/tTMVt0rQXm5JdBTq2Gs/uXalcupO+BK9JRBwf7GoEKt8a0dq
         Kx43Y0r3frot76XIxPPOFFSJmv3zu/x5yM+RroZfM0zqCn1yRVK4NEsnEm6ZqEwd1kFv
         k+ug==
X-Gm-Message-State: AGi0PuYiJ0i075HuP6krplOlS9AGIDaWBdY+XGHFzJqffcF5ro514nfB
        ESLRuEohHmgBvQfUHmJPMwcXA3qEiI4=
X-Google-Smtp-Source: APiQypIwNNMI6hps8qcyO4faIp46H3ztwc2LkJSyexdhGBgG5n88JLqtOTgRHHKkf4YWi5uau3wubA==
X-Received: by 2002:a2e:b162:: with SMTP id a2mr15880126ljm.25.1588037815168;
        Mon, 27 Apr 2020 18:36:55 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id l2sm11307361ljg.89.2020.04.27.18.36.52
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 18:36:54 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id u15so19723954ljd.3
        for <linux-arch@vger.kernel.org>; Mon, 27 Apr 2020 18:36:52 -0700 (PDT)
X-Received: by 2002:a05:6512:14a:: with SMTP id m10mr17156490lfo.152.1588037812064;
 Mon, 27 Apr 2020 18:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200426130100.306246-1-hagen@jauu.net> <20200426163430.22743-1-hagen@jauu.net>
 <20200427170826.mdklazcrn4xaeafm@wittgenstein> <CAG48ez0hskhN7OkxwHX-Bo5HGboJaVEk8udFukkTgiC=43ixcw@mail.gmail.com>
 <87zhawdc6w.fsf@x220.int.ebiederm.org> <20200427185929.GA1768@laniakea>
 <CAK8P3a2Ux1pDZEBjgRSPMJXvwUAvbPastX2ynVVC2iPTTDK_ow@mail.gmail.com>
 <20200427201303.tbiipopeapxofn6h@wittgenstein> <20200428004546.mlpwixgms2ekpfdm@yavin.dot.cyphar.com>
In-Reply-To: <20200428004546.mlpwixgms2ekpfdm@yavin.dot.cyphar.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Apr 2020 18:36:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wga3O=BoKZXR27-CDnAFareWcMxXhpWerwtCffdaH6_ow@mail.gmail.com>
Message-ID: <CAHk-=wga3O=BoKZXR27-CDnAFareWcMxXhpWerwtCffdaH6_ow@mail.gmail.com>
Subject: Re: [RFC v2] ptrace, pidfd: add pidfd_ptrace syscall
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 27, 2020 at 5:46 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> I agree. It would be a shame to add a new ptrace syscall and not take
> the opportunity to fix the multitude of problems with the existing API.
> But that's a Pandora's box which we shouldn't open unless we want to
> wait a long time to get an API everyone is okay with -- a pretty high
> price to just get pidfds support in ptrace.

We should really be very very careful with some "smarter ptrace".
We've had _so_ many security issues with ptrace that it's not even
funny.

And that's ignoring all the practical issues we've had.

I would definitely not want to have anything that looks like ptrace AT
ALL using pidfd. If we have a file descriptor to specify the target
process, then we should probably take advantage of that file
descriptor to actually make it more of a asynchronous interface that
doesn't cause the kinds of deadlocks that we've had with ptrace.

The synchronous nature of ptrace() means that not only do we have
those nasty deadlocks, it's also very very expensive to use. It also
has some other fundamental problems, like the whole "take over parent"
and the SIGCHLD behavior.

It also is hard to ptrace a ptracer. Which is annoying when you're
debugging gdb or strace or whatever.

So I think the thing to do is ask the gdb (and strace) people if they
have any _very_ particular painpoints that we could perhaps help with.

And then very carefully think things through and not repeat all the
mistakes ptrace did.

I'm not very optimistic.

              Linus
