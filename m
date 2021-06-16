Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADF73A9430
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jun 2021 09:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhFPHkk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Jun 2021 03:40:40 -0400
Received: from mail-vk1-f172.google.com ([209.85.221.172]:40567 "EHLO
        mail-vk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbhFPHkj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jun 2021 03:40:39 -0400
Received: by mail-vk1-f172.google.com with SMTP id i17so407993vkd.7;
        Wed, 16 Jun 2021 00:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oYkI/zG40URv+m/LERapdYdXE8mdGOgDXjJQ7nWdKJQ=;
        b=hSydv50Be21Z9io2d5aYTlJC0pqLDajaC4OV/GbBaoVCS69QWl7tBtBg6133ta3HB2
         GxMBGue8XramZqlfoFghbKwrW/8RCaqJdOYlz7aVhFEapHoygUkjYHcv5kMGmymiWNCe
         nMbauQ8ePyF3j7M2nQKgYM0zShlaD0H4XB+yVsZkBUe4kG4EhhgqMECb+X7cPiISqdCm
         7tmQkr36MS5Sf73LReF9GJrRprICg0iN9i8nC1oN0ef4buBZBwrvAxS03hHCxM8494RM
         WzJO8WR2apjyFa7EWztmOmyHGRE8VFrQEHJ7luZYYge1to8dMX+yrWRNjO4REBwqyCOl
         DGXA==
X-Gm-Message-State: AOAM531x5+nuni9NlNByuwomCGd09EM5Ru0B8OttCdFd3nmHKtNJKn6P
        +ki5u50Dkz2TmT+/SdNA2wJ/PRAcSSTlVrj1m5c=
X-Google-Smtp-Source: ABdhPJzufbJykYOmxZN0p1SAxGmJWo5X7VotLxBsWJYFnoUcAIbLyiwJ2blqdHa1Jr10POv3l3B1Oi8N3GGoHXROasQ=
X-Received: by 2002:a1f:9505:: with SMTP id x5mr8101727vkd.6.1623829113459;
 Wed, 16 Jun 2021 00:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <87sg1p30a1.fsf@disp2133> <CAHk-=wjiBXCZBxLiCG5hxpd0vMkMjiocenponWygG5SCG6DXNw@mail.gmail.com>
 <87pmwsytb3.fsf@disp2133> <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
 <87sg1lwhvm.fsf@disp2133> <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
 <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com> <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
 <87eed4v2dc.fsf@disp2133> <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com> <87fsxjorgs.fsf@disp2133>
In-Reply-To: <87fsxjorgs.fsf@disp2133>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Jun 2021 09:38:22 +0200
Message-ID: <CAMuHMdUkhbq+tOyrpyd5hKGGcpYduBnbnXKFBwEfCGjw5XGYVA@mail.gmail.com>
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Eric,

On Tue, Jun 15, 2021 at 9:32 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> Do you happen to know if there is userspace that will run
> in qemu-system-m68k that can be used for testing?

There's a link to an image in Laurent's patch series "[PATCH 0/2]
m68k: Add Virtual M68k Machine"
https://lore.kernel.org/linux-m68k/20210323221430.3735147-1-laurent@vivier.eu/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
