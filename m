Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B9236871D
	for <lists+linux-arch@lfdr.de>; Thu, 22 Apr 2021 21:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238702AbhDVTXU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Apr 2021 15:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236668AbhDVTXU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Apr 2021 15:23:20 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05C2C061756
        for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2021 12:22:44 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so43218038otn.1
        for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2021 12:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=66cEbil9eINHpcRrkzmgQxcSDhUEl5mJfXPxp3tOEXI=;
        b=IuMg6mQeBwJh4wTwLnveFoFpVCocNbp/3EC4dwCMijoPhLgQM2OBh4NUIZQwRzsLzW
         yYUK/yBVD+pjy3xQqUyrjYIWcB65J/+htg7XP2EYaEZ6LluevaV3OfGb5DqbxPWkexz9
         e9Hr4nzsad9879fuUtXEkkmYIvolaJX/qO07bJ9/pH2oCxyYlNvUU180O1hr+XS7qAcP
         HOJ0PnJLi5S79sK+mXpRHBp5AzAf3NweX5pKLSbi3BCQUEnEGKeNSulp4rqrWsDneIsn
         DjK05zqJ25SPj0NRq+FOEEn5/fGxMyOzXla900ECNgIHH6ZPofKnTKl0LWDF6GSoFUf9
         WWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=66cEbil9eINHpcRrkzmgQxcSDhUEl5mJfXPxp3tOEXI=;
        b=A5fL442j4/V2NbyPg3po4Nu+GL3+F7gYhnJulmR+SZORh3+DeAntb/DETPhN67tUyk
         Qy70eAnhQpPmTXAYnmb8WX3K6tJl7hVcltxFUWFY1O7ugAVfmpXSwcDc60dGYfB43L0f
         SF0+P/8ogGCefpyKB7DMo2ZHLxix7b+Q4Qu90evGcWOZouSXzwcNdJe+SGAAKZHbh43X
         kcbA0sKYs4oQEMnsO3qpbwBzMweRWmeuQ9BK+OrORhl6fxF/EdxiPOQQfAYnVvTFWNHD
         PzRY8tQkLraDQUF4cvpbQdnj4ZM99ecYVyympdvEk47zKjM/6sycubKL6kLgVR5x1Dbg
         cA3w==
X-Gm-Message-State: AOAM533/M4hS9BtcL630fw/hhjnL+u/37HhIu+nND5oTYQCs6l1s/cTY
        RN+UUjKwvenaK2+adQ7IbzYMkyXkXcHOoHn7GjfEiQ==
X-Google-Smtp-Source: ABdhPJwx2fYflGjsAzNwa66QYD0lhZUtecFrQpiV3owpBNe0jgxddvCCKETq2D5XKlLBMFEXtVDQDJOt9zvi59YXxn4=
X-Received: by 2002:a9d:1ea9:: with SMTP id n38mr83098otn.233.1619119364007;
 Thu, 22 Apr 2021 12:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210422064437.3577327-1-elver@google.com> <d480a4f56d544fb98eb1cdd62f44ae91@AcuMS.aculab.com>
 <CANpmjNNjkQdziFZDkPy5EnwCF+VyBWKXEwCDgNpxHGZd+BLQag@mail.gmail.com>
In-Reply-To: <CANpmjNNjkQdziFZDkPy5EnwCF+VyBWKXEwCDgNpxHGZd+BLQag@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 22 Apr 2021 21:22:31 +0200
Message-ID: <CANpmjNNHRmaxawVKNe8Oe=pnEgoJG6iqevHNJRa4EoeFtS5fYQ@mail.gmail.com>
Subject: Re: [PATCH tip 1/2] signal, perf: Fix siginfo_t by avoiding u64 on
 32-bit architectures
To:     David Laight <David.Laight@aculab.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "glider@google.com" <glider@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "christian@brauner.io" <christian@brauner.io>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "pcc@google.com" <pcc@google.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 22 Apr 2021 at 12:17, Marco Elver <elver@google.com> wrote:
> On Thu, 22 Apr 2021 at 11:48, David Laight <David.Laight@aculab.com> wrote:
> >
> > From: Marco Elver
> > > Sent: 22 April 2021 07:45
> > >
> > > On some architectures, like Arm, the alignment of a structure is that of
> > > its largest member.
> >
> > That is true everywhere.
> > (Apart from obscure ABI where structure have at least 4 byte alignment!)
>
> For instance, x86 didn't complain, nor did m68k. Both of them have
> compile-time checks for the layout (I'm adding those for Arm
> elsewhere).
[...]
> > Much as I hate __packed, you could add __packed to the
> > definition of the structure member _perf.
> > The compiler will remove the padding before it and will
> > assume it has the alignment of the previous item.
> >
> > So it will never use byte accesses.
>
> Sure __packed works for Arm. But I think there's no precedent using
> this on siginfo_t, possibly for good reasons? I simply can't find
> evidence that this is portable on *all* architectures and for *all*
> possible definitions of siginfo_t, including those that live in things
> like glibc.
>
> Can we confirm that __packed is fine to add to siginfo_t on *all*
> architectures for *all* possible definitions of siginfo_t? I currently
> can't. And given it's outside the scope of the C standard (as of C11
> we got _Alignas, but that doesn't help I think), I'd vote to not
> venture too far for code that should be portable especially things as
> important as siginfo_t, and has definitions *outside* the kernel (I
> know we do lots of non-standard things, but others might not).

After thinking about this all afternoon, you convinced me that the
commit message wasn't great, and this should be in the commit message,
too: https://lkml.kernel.org/r/20210422191823.79012-1-elver@google.com

Thanks,
-- Marco
