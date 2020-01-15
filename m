Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76B8713CD75
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jan 2020 20:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgAOTvi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jan 2020 14:51:38 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:44799 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729398AbgAOTvi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jan 2020 14:51:38 -0500
Received: by mail-oi1-f182.google.com with SMTP id d62so16578624oia.11
        for <linux-arch@vger.kernel.org>; Wed, 15 Jan 2020 11:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WrYAie2eRW6IOTWX2EXtM4jme3AXHDgWbVMHcdt6qOk=;
        b=QeMscKv82Bnz8PPS+/me8QibPYuHHbtAGQHXr1iESgQRS5z9UegSgqBc7oHWy/l5N8
         kScbRsGy4BFu6acDpF4e+5OqfHO0Yg+pLjevq5crkOWgeZuTFH+or+Q3q6LILoDWguFW
         SF7N0HHqaAByj5cyV6lvQfeiPmJMT01gDalkmMHeQroUmKtjmo5dq3dxFibsh/XEKpVO
         Cpfb5+m2w3y8eXA0XhmBM+The7CO09fmdOE7l15/M++VLmfveN0fRQX+yNNMwUmUehmp
         gP7PUCdjw5EB/qALIkf5Li0x+0aQbOOBmQST5RqHHEUv0NRU7Q4NOpWwuMKyaDqzOS1F
         iRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WrYAie2eRW6IOTWX2EXtM4jme3AXHDgWbVMHcdt6qOk=;
        b=Gd3Iqa7Z8h2fPtvTv+e5WBrTYqfe5tNzj7OmXQXdxmnMSbMM7G1dO0kZ4dL1bRgwC0
         mCqgemZHKZIkr40pjVNfKoO7JwjWIVxpLsnMJS7Y1m2O/FsiD1qfBBjj6DW21+DOLXxd
         lcPBxC+Y7LrvM6w1ad8ZTn+9Rk/v4xIv73pXXdKvMWfJAeZtUejHr4gGiBpq3IW1iV+j
         p83zT6cI/sDT39Q6zNeZz4iFXsMPVcP+HMq/E8Wjxjdb2aul8JrpTb4ukvZmKAH1k/P9
         scLd1NS9B6ZwkVvqBlILdORXAlY0zK6a+xamd1U4ENgqpjStnIpImjfzSkTk+Zn6OulA
         kvGA==
X-Gm-Message-State: APjAAAXxYSufBgSQT45tKqjt+jKzS639TJEF0NBsROWhH793j09xwBBB
        K8hSICHQPU5farr/ifUpoJVn3Lty0wSult+sg+nKFg==
X-Google-Smtp-Source: APXvYqznmXUDHrqkq6pOGZvvIxaj76OPkZQJUmHzZZ2yM6qp0VMnMMzFY7hgzrG9YmzcMX3Zmb9cUg2ozkWQegK2zxA=
X-Received: by 2002:aca:2112:: with SMTP id 18mr1133436oiz.155.1579117897045;
 Wed, 15 Jan 2020 11:51:37 -0800 (PST)
MIME-Version: 1.0
References: <20200115165749.145649-1-elver@google.com> <CAK8P3a3b=SviUkQw7ZXZF85gS1JO8kzh2HOns5zXoEJGz-+JiQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3b=SviUkQw7ZXZF85gS1JO8kzh2HOns5zXoEJGz-+JiQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 15 Jan 2020 20:51:26 +0100
Message-ID: <CANpmjNOpTYnF3ssqrE_s+=UA-2MpfzzdrXoyaifb3A55_mc0uA@mail.gmail.com>
Subject: Re: [PATCH -rcu] asm-generic, kcsan: Add KCSAN instrumentation for bitops
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        christophe leroy <christophe.leroy@c-s.fr>,
        Daniel Axtens <dja@axtens.net>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 15 Jan 2020 at 20:27, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Jan 15, 2020 at 5:58 PM Marco Elver <elver@google.com> wrote:
> >   * set_bit - Atomically set a bit in memory
> > @@ -26,6 +27,7 @@
> >  static inline void set_bit(long nr, volatile unsigned long *addr)
> >  {
> >         kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> > +       kcsan_check_atomic_write(addr + BIT_WORD(nr), sizeof(long));
> >         arch_set_bit(nr, addr);
> >  }
>
> It looks like you add a kcsan_check_atomic_write or kcsan_check_write directly
> next to almost any instance of kasan_check_write().
>
> Are there any cases where we actually just need one of the two but not the
> other? If not, maybe it's better to rename the macro and have it do both things
> as needed?

Do you mean adding an inline helper at the top of each bitops header
here, similar to what we did for atomic-instrumented?  Happy to do
that if it improves readability.

Thanks,
-- Marco
