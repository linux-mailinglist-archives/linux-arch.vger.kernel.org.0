Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702153AECBE
	for <lists+linux-arch@lfdr.de>; Mon, 21 Jun 2021 17:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhFUPso (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Jun 2021 11:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbhFUPso (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jun 2021 11:48:44 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A194CC061574
        for <linux-arch@vger.kernel.org>; Mon, 21 Jun 2021 08:46:28 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id u11so14938389ljh.2
        for <linux-arch@vger.kernel.org>; Mon, 21 Jun 2021 08:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R/gsr/Z80fSxEB0qmGqShvDUtlhm4ESakW3xcimnUEw=;
        b=a39nbPZCP+nWMeIZ/x5qt0slwYnbNb/TvhmNaAml5kNvhs0i32rgF44OFGvy4ACZ5M
         SfNAyRTK1aJ1m7aW6sC2No3kMhETcLZ7kUjianICGGeVyVPSyizOAaXDDMbjMew6KcRK
         SAT8eIJUsUOJFoDNwA7oyYdllQrDrIWi08wng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R/gsr/Z80fSxEB0qmGqShvDUtlhm4ESakW3xcimnUEw=;
        b=QonTiHiRzAXQUPszAS9SO+SmCe/WLj9UM1qoxpq1L3DVgL37NSmqcywYUVFv4H0xZr
         BT79cRBsTNrnqeEce174Op0bYAXA85prK6OCTpRv96yLiGBNaPUvvXLAKcvMKkrs9Yfs
         JPYmwsMc6KNp4RkDUgLRWr7FL5fzVYvNBvAx4Fw4yvsNZQAGTNINkpex5xUXFadEFpc4
         BFv7rXNFGOh4zntOUiutsinFi9g79DgRZgczXPStW83ZxcErboMoQOoOtULSilrswPVq
         0iiXdeY7os0NF+SduJhryuCTbiY/v+hOSHtf+czc+FkKur2NZ88rAEvX0KfJeMUosiEJ
         5eOA==
X-Gm-Message-State: AOAM532FlDgHfKlSTNoHK9xgk976u2D/CQiQCjTwnqNgty1XpjGV4vVh
        /+6+6nz0Sb2Jxc70GNeODnAAzxHdI0xbzJU8VKE=
X-Google-Smtp-Source: ABdhPJz8ltQZ/LYDjr5xShlh0Me2Gvbwpt+4u3IqqqoM40/I/bgS+bgEFrU2LyAw9ms17r3pg7mrYg==
X-Received: by 2002:a2e:2a43:: with SMTP id q64mr21968332ljq.375.1624290386741;
        Mon, 21 Jun 2021 08:46:26 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id h20sm617520lfu.212.2021.06.21.08.46.26
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 08:46:26 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id k8so25713147lja.4
        for <linux-arch@vger.kernel.org>; Mon, 21 Jun 2021 08:46:26 -0700 (PDT)
X-Received: by 2002:a2e:b618:: with SMTP id r24mr22042332ljn.48.1624289909978;
 Mon, 21 Jun 2021 08:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <87pmwsytb3.fsf@disp2133> <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
 <87sg1lwhvm.fsf@disp2133> <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
 <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com> <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
 <87eed4v2dc.fsf@disp2133> <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
 <87fsxjorgs.fsf@disp2133> <CAHk-=wj5cJjpjAmDptmP9u4__6p3Y93SCQHG8Ef4+h=cnLiCsA@mail.gmail.com>
 <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
In-Reply-To: <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Jun 2021 08:38:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjC_=iwj61vSZ0orPGjrxhDK3Ob2D4eaRpXXFdAbF6coQ@mail.gmail.com>
Message-ID: <CAHk-=wjC_=iwj61vSZ0orPGjrxhDK3Ob2D4eaRpXXFdAbF6coQ@mail.gmail.com>
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
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 21, 2021 at 6:55 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Jun 15, 2021 at 02:58:12PM -0700, Linus Torvalds wrote:
>
> > And I think our horrible "kernel threads return to user space when
> > done" is absolutely horrifically nasty. Maybe of the clever sort, but
> > mostly of the historical horror sort.
>
> How would you prefer to handle that, then?  Separate magical path from
> kernel_execve() to switch to userland?  We used to have something of
> that sort, and that had been a real horror...

Hmm. Maybe the alternatives would all be worse. The current thing is
clever, and shares the return path with the normal case. It's just
also a bit surprising, in that a kernel thread normally must not
return - with the magical exception of "if it had done a
kernel_execve() at some point, then returning is magically the way you
actually start user mode".

So it all feels very special, and there's not even a comment about it.

I think we only have two users of that thing (the very first 'init',
and user-mode-helpr), So I guess it doesn't really matter.

            Linus
