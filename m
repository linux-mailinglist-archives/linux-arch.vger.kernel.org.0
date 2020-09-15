Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4065E26AAB5
	for <lists+linux-arch@lfdr.de>; Tue, 15 Sep 2020 19:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgIORbm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Sep 2020 13:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbgIORaK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Sep 2020 13:30:10 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2487DC06174A
        for <linux-arch@vger.kernel.org>; Tue, 15 Sep 2020 10:30:10 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id c2so3517483ljj.12
        for <linux-arch@vger.kernel.org>; Tue, 15 Sep 2020 10:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xSVHWYbzu3UQ8PBlLDNLl6dehpYO4ZB4CwIyD75ZWAE=;
        b=HrsWxAPBdchRgJHFmShgtgLo+DYOxZ4XfJAXkzfzzcfRKd+SalkgHXOKOAhxqlhHgQ
         V1SM0m5nq2pQBoktRVl1X3TADwVGw68gQTnxbkgl/4Ys1lUtjCYE6YOc6zJjNuYpT6Oi
         cumGXilNIqaAVXq/H8sUmOpuXNhTWtrjfr3qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xSVHWYbzu3UQ8PBlLDNLl6dehpYO4ZB4CwIyD75ZWAE=;
        b=SD8S/1VVSiggsitaYuO+Y/RlUkJdl0lFc4L8e6YP6xnbZFvS99bkZ+PFpWO2XSVxa8
         AIl/djNpYAfeZbYcL7U445Mgw0Ir04g3fhL93BACf4yW8ZaOqNQml6GWY0MB2uhcIQ4J
         IsOxSpewnL7uS7xOUOsdt21EEnT+gf9Jh7p1+X2XwcnCkfuIFsUllNLOHnaUBO/9t4GS
         zCbtLAi8xiTWAYlHJs3tjfOf2xGB7lwrd8l1xoF28wH9SjCrdXNK6cyXNTHsg9D3Spa8
         ZVojGNYbDATCSEQ1icXDVR7UXCB+oARv6wqWp5+Y7Ft3QSALs6JzPK/9relni1q8lXEP
         NtfQ==
X-Gm-Message-State: AOAM531iLRo8kCFZtzPVh97ZTkRsU7DrEMjT2wy8ZA4r2AK8lIbo+aHl
        7lTIeBSNq8goeay4cx8ozsftfszAGB13LQ==
X-Google-Smtp-Source: ABdhPJzgGHBtgzwEY+b8squFXamdKH2KJpVkmbhXiH3wJC4ur/rdk0wWF9OxtvCs2wVuEQvnnu1cVg==
X-Received: by 2002:a2e:3a09:: with SMTP id h9mr6857362lja.287.1600191008276;
        Tue, 15 Sep 2020 10:30:08 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id z7sm4424222lfc.59.2020.09.15.10.30.06
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 10:30:07 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id z17so3937378lfi.12
        for <linux-arch@vger.kernel.org>; Tue, 15 Sep 2020 10:30:06 -0700 (PDT)
X-Received: by 2002:a19:521a:: with SMTP id m26mr7168489lfb.133.1600191006488;
 Tue, 15 Sep 2020 10:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200914204209.256266093@linutronix.de> <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com>
 <871rj4owfn.fsf@nanos.tec.linutronix.de> <CAHk-=wj0eUuVQ=hRFZv_nY7g5ZLt7Fy3K7SMJL0ZCzniPtsbbg@mail.gmail.com>
 <CAHk-=wjOV6f_ddg+QVCF6RUe+pXPhSR2WevnNyOs9oT+q2ihEA@mail.gmail.com>
 <CAMj1kXHrDU50D08TwLfzz2hCK+8+C7KGPF99PphXtsOYZ-ff1g@mail.gmail.com>
 <20200915062253.GA26275@gondor.apana.org.au> <CAHk-=wir6LZ=4gHt8VDdASv=TmEMjEUONuzbt=s+DyXPCvxaBA@mail.gmail.com>
 <87een35woz.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87een35woz.fsf@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Sep 2020 10:29:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_koVS=8bYurGCZ8zs=zDH5cOKVzFdoj4AkUWEW9mKjA@mail.gmail.com>
Message-ID: <CAHk-=wg_koVS=8bYurGCZ8zs=zDH5cOKVzFdoj4AkUWEW9mKjA@mail.gmail.com>
Subject: Re: [patch 00/13] preempt: Make preempt count unconditional
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um <linux-um@lists.infradead.org>,
        Brian Cain <bcain@codeaurora.org>,
        linux-hexagon@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 15, 2020 at 12:24 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Alternatively we just make highmem a bit more expensive by making these
> maps preemptible. RT is doing this for a long time and it's not that
> horrible.

Ack.

In fact, I've wanted to start just removing kmap support entirely. At
some point it's not so much about "I have an old machine that wants
HIGHMEM" but about "I have an old CPU, and I'll just run an old
kernel".

It's not that 32-bit is irrelevant, it's that 32-bit with large
amounts of memory is irrelevant.

Last time this was discussed, iirc the main issue was some
questionable old ARM chips that were still very common in embedded
environments, even with large memory.

But we could definitely start de-emphasizing HIGHMEM.

                     Linus
