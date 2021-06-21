Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C973AF605
	for <lists+linux-arch@lfdr.de>; Mon, 21 Jun 2021 21:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhFUTYm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Jun 2021 15:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbhFUTYk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jun 2021 15:24:40 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1AAC061574
        for <linux-arch@vger.kernel.org>; Mon, 21 Jun 2021 12:22:24 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id h15so13428256lfv.12
        for <linux-arch@vger.kernel.org>; Mon, 21 Jun 2021 12:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UWwkKMPjf9VHxhA/g9kybS/n5fjzQ1lCr96tYKbsWb4=;
        b=OWY9B/m6/Mxc4KE4rlqUmS8up4KOodyzZabkrCDG8PZQO7BOG22XJGJUOTvpEvWYz8
         5PgA6ftqBTHNUdu8z3XpFvF/2p6ZVtR21Nv8hDF/pcwb1wKzuer3Yr3ZrfLh8V5mdy+M
         eKJPw1pfo8vN7QoUHB7TWIVl4z9STd1R+XvlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UWwkKMPjf9VHxhA/g9kybS/n5fjzQ1lCr96tYKbsWb4=;
        b=YXJ0RCh6tkPOqKMQHUaIeWNGRxc+mS1F9JAz09AwicNpcM0AcLw9xGukjV2AyW1azV
         HQiAvp34uuoPqO5AfXI9js6F+hbEfTD1tBOJLDIj3EoJ9uapG50Xu3Zr2StEa3IrwOqr
         eW+brwm6Z/62IOaIeYpB+7DCwk5jIPtGEH29MA6T7vMPck5aSb+egrdgXtQpQA5Hoaue
         0mUy7gHOMi+rRNWO0MYynblwAdOgSEUDZASPKiVfobihC59ZbLEVxdjI5mfP0eJnuZZf
         ejvrL1wFt2rv2iW0VzFJPXqoN/T8Ijt9QvjRgliZZIBKRinstarl2YhbkVhOGjWOdvGU
         8S9A==
X-Gm-Message-State: AOAM530NZ2LIgirbaNusMzDi4/wKsC9p/+ykfqV9JnvU6iJFFoLS4IZl
        9h7gOaGVPVwSrD4GpUCCBbISl9OHoZrJqTQFQZ4=
X-Google-Smtp-Source: ABdhPJy6HdHbvDNpumOVmxl9Dz4eIvlecxImenpHqTQzsobObxTJvRpYHxZbYd5qAJjhGmCwr6iykA==
X-Received: by 2002:a05:6512:15a1:: with SMTP id bp33mr15196684lfb.623.1624303342777;
        Mon, 21 Jun 2021 12:22:22 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id h20sm1518277lfv.77.2021.06.21.12.22.22
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 12:22:22 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id a16so5264555ljq.3
        for <linux-arch@vger.kernel.org>; Mon, 21 Jun 2021 12:22:22 -0700 (PDT)
X-Received: by 2002:a2e:9644:: with SMTP id z4mr23025776ljh.507.1624303342282;
 Mon, 21 Jun 2021 12:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
 <87sg1lwhvm.fsf@disp2133> <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
 <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com> <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
 <87eed4v2dc.fsf@disp2133> <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
 <87fsxjorgs.fsf@disp2133> <CAHk-=wj5cJjpjAmDptmP9u4__6p3Y93SCQHG8Ef4+h=cnLiCsA@mail.gmail.com>
 <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk> <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
In-Reply-To: <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Jun 2021 12:22:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
Message-ID: <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
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

On Mon, Jun 21, 2021 at 11:59 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         There's a large mess around do_exit() - we have a bunch of
> callers all over arch/*; if nothing else, I very much doubt that really
> want to let tracer play with a thread in the middle of die_if_kernel()
> or similar.

Right you are.

I'm really beginning to hate ptrace_{event,notify}() and those
PTRACE_EVENT_xyz things.

I don't even know what uses them, honestly. How very annoying.

I guess it's easy enough (famous last words) to move the
ptrace_event() call out of do_exit() and into the actual
exit/exit_group system calls, and the signal handling path. The paths
that actually have proper pt_regs.

Looks like sys_exit() and do_group_exit() would be the two places to
do it (do_group_exit() would handle the signal case and
sys_group_exit()).

               Linus
