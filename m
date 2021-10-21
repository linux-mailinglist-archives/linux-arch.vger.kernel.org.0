Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C301E436360
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 15:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhJUNwZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 09:52:25 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:45341 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhJUNwY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 09:52:24 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MK3mS-1mPkh72WvG-00LZhi; Thu, 21 Oct 2021 15:50:07 +0200
Received: by mail-wr1-f52.google.com with SMTP id r18so1226479wrg.6;
        Thu, 21 Oct 2021 06:50:07 -0700 (PDT)
X-Gm-Message-State: AOAM531XQ4qmZX/cdKyIo+x2yhiBXZAjDJHLwIev/Xn02DeZbZTtzNe1
        iTlTEmqZOpad7CoNYsJJEtyxInXHMyDYZUi3bco=
X-Google-Smtp-Source: ABdhPJzFgn79Ic6FqBqH1cvM4ZGB9Dra++hlNfhANl9ybgG+sQ8/6wYtZISF0tQPrg0FbbKYG8md6racZvoc4a5yYuU=
X-Received: by 2002:a05:6000:18c7:: with SMTP id w7mr7104304wrq.411.1634824207284;
 Thu, 21 Oct 2021 06:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <YXFli3mzMishRpEq@hirez.programming.kicks-ass.net>
In-Reply-To: <YXFli3mzMishRpEq@hirez.programming.kicks-ass.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Oct 2021 15:49:51 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2+=9jjyqN5dMOb4+bYJy=q5G3CxFaCW+=4xryz-S=zYA@mail.gmail.com>
Message-ID: <CAK8P3a2+=9jjyqN5dMOb4+bYJy=q5G3CxFaCW+=4xryz-S=zYA@mail.gmail.com>
Subject: Re: [PATCH] locking: Generic ticket lock
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christophm30@gmail.com>,
        Stafford Horne <shorne@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:oz2/dP5J5bv0MZ5b5PpkbfR/AHPVkMMXoayFbA+g+9/TZYgDQim
 599eBtzjZbI1PpL5vv/5JIMFEoDtxbIoRe5XU8Lt5U3hlp6hyeKhcLh86Ed07egMp66Gqs4
 2zaLVEF8lr2Gk3I/7Bh+JroOclDoMQ3V6do9+wmUf3SxvgMQXVAcosHoCCJOdD0yk8bmVgj
 +M0300hmfe6u0Qfq93NMA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8pKS50lWB3A=:AbKj+0rqm3eAX3LNHG38Hf
 PCiLyg8EA1uUI1n3wl5KfDu+b+ZdKxNM8v2ryQDCiitBWePuuG9ZOFIUrxC5CGn0PasAP+DGV
 mC0WkkBkMT4kC4XHlsBk/W1136WsQEnk6SMBtBQ2tNQG5oS2x3ymiEx6nhgZm7f3kpKz3v+gh
 uJXXou2bQzT3N0Kxr7uVcGktsw7k2IBB4HDltFLYG6pB8cQQZVO7YQxSR6PeBVF02chznZysj
 WheCPJbGX2pY+Rpp33iQJdQXwFadgvlObpC6054a9RltHw/t9Kl9HOILeZ9+dJCwbZ4xlWlAT
 LE+/D/5nKON5/qlUvtiGq/N3ZG7V9erIyuILvnNncoKvQ6tYSuJQSDJ8wFuw1sgOHMoNUf25H
 qIop0lKmZol1M6drDEsGzqhGDCYPMSAC29VyNf8yYf/2JVURNajOvIV1ukMC2A+9IEHli+2Ef
 /g2XE/XI4q7Ldo5M6FHkvNATxK7LrVMwNqCtC9eYulM7BLn+F3lXiBxUtJZ9FN/irVkHGosfD
 qvFfiD8uU0u3tXEJf6N8a2L3LjSloiBvTXGZ1QbIFupRHsNBVwZi4uy7jxxMCllwoi1FZ1U69
 7jWtgQQ2nKsL6udnAg0Di0jlLq3IlrGz3UGOkz9zUvPQnH9KucX/62nN5/sNZAQBToHYHgQa+
 +RGZak2WPRWmU/gXnXWgsj3rt6X8fAe/NjQK5XphEFxyaw7++bKsmT5JpUu2KPl44Yho=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 21, 2021 at 3:05 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Therefore provide ticket locks, which depend on a single atomic
> operation (fetch_add) while still providing fairness.

Nice!

Aside from the qspinlock vs ticket-lock question, can you describe the
tradeoffs between this generic ticket lock and a custom implementation
in architecture code? Should we convert most architectures over
to the generic code in the long run, or is there something they
can usually do better with an inline asm based ticket lock or
a trivial test-and-set?

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/asm-generic/qspinlock.h         |   30 +++++++++
>  include/asm-generic/ticket_lock_types.h |   11 +++
>  include/asm-generic/ticket_lock.h       |   97 ++++++++++++++++++++++++++++++++
>  3 files changed, 138 insertions(+)

If anyone wants to use this for their architecture, feel free to add

Acked-by: Arnd Bergmann <arnd@arndb.de>

to merge it through the respective architecture git tree. If there is more
than one architecture that wants it right now, I could also take them
all through
the asm-generic tree.

          Arnd
