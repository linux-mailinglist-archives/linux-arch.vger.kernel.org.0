Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A834139A35
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jan 2020 20:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgAMTcR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jan 2020 14:32:17 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46041 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgAMTcQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jan 2020 14:32:16 -0500
Received: by mail-lf1-f66.google.com with SMTP id 203so7762523lfa.12
        for <linux-arch@vger.kernel.org>; Mon, 13 Jan 2020 11:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ae/+DIZn8QK4Eu0S9kiQGO5TqvMJzTIQ/bcHyd6r6aQ=;
        b=dsTuRrPnmRxjK6yre9iMf8gYcDE0hjJkuaJ2eT9ghACf2vMogI+i+ZMgu9tiR3PjxB
         uzQhEdyjiSlebYb6SLrus5AR2u6J5fDcOnswpR5Vfnatgy1xjOGHGAsOhngu0riP6Xcw
         2ZfyA9EtBicLF7bVKr8HK+hd9gJ6oiCIwVO50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ae/+DIZn8QK4Eu0S9kiQGO5TqvMJzTIQ/bcHyd6r6aQ=;
        b=Q2Wp2usR2euL+PeC8Eevgs4IAx+fYPsiQFBFOUmfoEjVvWT80VSdKGNQGA3W80UYDl
         MjnoNckosOJWlyAuRVEKW8p39EytPgBydXcTJnRjwdDr1enXyvjmY9pJ3nnSIUMsjbKz
         wJ2hqVsvMWosaoP8jV3HF7bkPFj1B83TsydVnjkkBolfqkdxn/yH+dKfKagmgvNcqyLX
         46lHFiDmWEs7NJaE0fBnSf0KcPXp2U5ymK6Fz0josyXg9Skc/c8bLsgD3GbydqzGFnoK
         yBBYk1hVm0mAraIgCBot+VW9yLy295sqd2WQpQrBDE/kTGkJcwiRc3orr0lv79APexwD
         TzNg==
X-Gm-Message-State: APjAAAXNe4Y2AWKHc2DyB2x0gnY+BRXypAnae5I2QV63ddi43E69+Ibu
        eOrn/8mifPNdeKT2DwXSJTeyGsh+KK4=
X-Google-Smtp-Source: APXvYqw9UNn9C06THH8ZdG7BNBS3aOZ39wkxBIKVMqhF7DDQpuV8f4vkpzOyXDTfZmrVFp54yjfeQg==
X-Received: by 2002:ac2:5444:: with SMTP id d4mr10726670lfn.49.1578943934351;
        Mon, 13 Jan 2020 11:32:14 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id s3sm6175896lfo.77.2020.01.13.11.32.13
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 11:32:13 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id o13so11450314ljg.4
        for <linux-arch@vger.kernel.org>; Mon, 13 Jan 2020 11:32:13 -0800 (PST)
X-Received: by 2002:a05:651c:282:: with SMTP id b2mr12034973ljo.41.1578943932792;
 Mon, 13 Jan 2020 11:32:12 -0800 (PST)
MIME-Version: 1.0
References: <20200110165636.28035-1-will@kernel.org> <20200110165636.28035-7-will@kernel.org>
 <CAHk-=wia5ppBsfHLMx648utCjO01JAZiME0K0eSHmhWuRyL+6w@mail.gmail.com> <20200113145954.GB4458@willie-the-truck>
In-Reply-To: <20200113145954.GB4458@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Jan 2020 11:31:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wirAWFOrfD4us1FepP0vWkZMpnqXusJyKHCqwBVsR43CA@mail.gmail.com>
Message-ID: <CAHk-=wirAWFOrfD4us1FepP0vWkZMpnqXusJyKHCqwBVsR43CA@mail.gmail.com>
Subject: Re: [RFC PATCH 6/8] READ_ONCE: Drop pointer qualifiers when reading
 from scalar types
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 13, 2020 at 7:00 AM Will Deacon <will@kernel.org> wrote:
>
> I can't disagree with that, but the only option we've come up with so far
> that solves this in the READ_ONCE() macro itself is the thing from PeterZ:
>
> // Insert big fat comment here
> #define unqual_typeof(x)    typeof(({_Atomic typeof(x) ___x __maybe_unused; ___x; }))

I'm with Luc on this - that not only looks gcc-specific, it looks
fragile too, in that it's not obvious that "_Atomic typeof(x)" really
is guaranteed to do what we want.

> So I suppose my question is: how ill does this code really make you feel?

I wish the code was more obvious.

One way to do that might be to do your approach, but just write it as
a series of macros that makes it a bit more understandable what it
does.

Maybe it's just because of a "pee in the snow" effect, but I think
this is easier to explain:

  #define __pick_scalar_type(x,type,otherwise)          \
        __builtin_choose_expr(__same_type(x,type), (type)0, otherwise)

  #define __pick_integer_type(x, type, otherwise)       \
        __pick_scalar_type(x, unsigned type,            \
          __pick_scalar_type(x, signed type, otherwise))

  #define __unqual_scalar_typeof(x) typeof(             \
        __pick_integer_type(x, char,                    \
          __pick_integer_type(x, short,                 \
            __pick_integer_type(x, int,                 \
              __pick_integer_type(x, long,              \
                __pick_integer_type(x, long long, x))))))

just because you there's less repeated noise, and the repetition there
is is simpler.

So still "Eww", but maybe not quite _as_ "Eww".

             Linus
