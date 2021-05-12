Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F2937B718
	for <lists+linux-arch@lfdr.de>; Wed, 12 May 2021 09:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhELHvF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 May 2021 03:51:05 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:50065 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhELHvF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 May 2021 03:51:05 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MFKX3-1lihhK34Pp-00Fnda; Wed, 12 May 2021 09:49:55 +0200
Received: by mail-oi1-f178.google.com with SMTP id x15so7731063oic.13;
        Wed, 12 May 2021 00:49:55 -0700 (PDT)
X-Gm-Message-State: AOAM5332yO5fBiTf58nzSnzrGM13tnnVMVvXp+6Vm9GXPnge8Fqoosq0
        bwic36wCqdqkwYZXa/BM5jt9yIG2rb9ootp5+kU=
X-Google-Smtp-Source: ABdhPJxd0lpfpoLIqJOw+6SPCO8QED3/X3t9JAR8I4sQlku1WpueQz6KE4WIiLlRxouPNnwly1mFxvEEQ4Zrg7KWp+o=
X-Received: by 2002:aca:f587:: with SMTP id t129mr25234423oih.84.1620805794260;
 Wed, 12 May 2021 00:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210401003153.97325-1-yury.norov@gmail.com> <20210401003153.97325-12-yury.norov@gmail.com>
 <1ac7bbc2-45d9-26ed-0b33-bf382b8d858b@I-love.SAKURA.ne.jp>
 <CAHp75Vea0Y_LfWC7LNDoDZqO4t+SVHV5HZMzErfyMPoBAjjk1g@mail.gmail.com>
 <YJm5Dpo+RspbAtye@rikard> <YJoyMrqRtB3GSAny@smile.fi.intel.com>
 <YJpePAHS3EDw6PK1@rikard> <151de51e-9302-1f59-407a-e0d68bbaf11c@i-love.sakura.ne.jp>
 <YJrrJhvwq7RUvDXD@rikard>
In-Reply-To: <YJrrJhvwq7RUvDXD@rikard>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 12 May 2021 09:48:57 +0200
X-Gmail-Original-Message-ID: <CAK8P3a02qNHcksJ8DahHgLtbM9ZOydGjE3__3GoxgJFiWrAT0w@mail.gmail.com>
Message-ID: <CAK8P3a02qNHcksJ8DahHgLtbM9ZOydGjE3__3GoxgJFiWrAT0w@mail.gmail.com>
Subject: Re: [PATCH 11/12] tools: sync lib/find_bit implementation
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux-SH <linux-sh@vger.kernel.org>,
        Alexey Klimov <aklimov@redhat.com>,
        David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rich Felker <dalias@libc.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:fhzWoOc1Vad7Gk0f0i3YZQTK7+oA8uzLV3sSW2zE6I47Ody7IvG
 S0rZhdcOmArhLGlKkN1ijeiTQrZ8WMMZFefLsOAMnFJrJeQPFlDraXdgRyMU3S/pxOXZe0g
 BsfNnWJgJOSMWKh2ZovFD7lypwLsYydBp2uw2L+vSc66ZfZckw/BZ8xsWEtKjxfaPba8u3J
 l08CRvBFmJL2LQvms5Cwg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KK/dcYhHyco=:CAyYNaS8gDrjoZWnGW4SWq
 E8AaGhybFNBdvJxiR+GRumjv3VKz0jhJNfW4HndiWyssPH49ibo1CZcxYtq/anY0PEZeaO/Jp
 g9My9IpOds7tbz9kPb47eWFiXdgLHh89RUzMUECtIZXLiGNnsa52/LlKDnt3sOcjq9prq6KUL
 Iw2khn48hpKRmKf54LMEUa3+AQDBiF8L+nWjneAH3TM2CBFnQaJSDLIzmgYAHhanqpSdFXoa7
 IqhLX1qpkIScny65UVA05L3HmHmY3t3bxoFFCJWYCX4gOU+10pGWjU0wj5EkSLqd3oi3cpJPw
 JkR6bF2FPHWBMkjgU55RExNZHI8RvwW/1hjOMOtYUFjKqz5LkjxdCEnQZxXftg0aUUGdKascV
 sj/twLz9OZtizPljvAz0YiP6DqWDlqZWQGLC51/kFpE7dSYbyEpNXpVUt9jncgxvWURNFFYf9
 6ES0kgyxQtuon2CtZQKkA9demAPU7ac1cuCt51tw5JQEEvARHI8/k5F0UP3jcsqsH2HPJmYvk
 ke5jjaQ5xzWPNZqleeBgGM=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 11, 2021 at 10:39 PM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
> On Tue, May 11, 2021 at 08:53:53PM +0900, Tetsuo Handa wrote:

> > #define GENMASK_INPUT_CHECK(h, l) \
> >      (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> >           __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> >
> > __GENMASK() does not need "h" and "l" being a constant.
> >
> > Yes, small_const_nbits(size) in find_next_bit() can guarantee that "size" is a
> > constant and hence "h" argument in GENMASK_INPUT_CHECK() call is also a constant.
> > But nothing can guarantee that "offset" is a constant, and hence nothing can
> > guarantee that "l" argument in GENMASK_INPUT_CHECK() call is also a constant.
> >
> > Then, how can (l) > (h) in __builtin_constant_p((l) > (h)) be evaluated at build time
> > if either l or h (i.e. "offset" and "size - 1" in find_next_bit()) lacks a guarantee of
> > being a constant?
> >
>
> So the idea is that if (l > h) is constant, __builtin_constant_p should
> evaluate that, and if it is not it should use zero instead as input to
> __builtin_chose_expr(). This works with non-const inputs in many other
> places in the kernel, but apparently in this case with a certain
> compiler, it doesn't so I guess we need to work around it.

I have a vague memory that __builtin_constant_p() inside of
__builtin_choose_expr()
always evaluates to false because of the order in which the compiler processes
those: If constant-folding only happens after __builtin_choose_expr(), then
__builtin_constant_p() has to be false.

        Arnd
