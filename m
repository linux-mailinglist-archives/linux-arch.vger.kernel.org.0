Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60FD2272BF2
	for <lists+linux-arch@lfdr.de>; Mon, 21 Sep 2020 18:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgIUQZT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Sep 2020 12:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbgIUQZK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Sep 2020 12:25:10 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E09AC0613CF
        for <linux-arch@vger.kernel.org>; Mon, 21 Sep 2020 09:25:10 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w3so11623204ljo.5
        for <linux-arch@vger.kernel.org>; Mon, 21 Sep 2020 09:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LbpMl5lO0+qWgp9uAKdYj5ux1bx38Si35gqGXl7ChFs=;
        b=a2Cw4ka1cjcNejUhLUZAAjSLNoYelCoyZSpmQCatftbiLw5qTc+pZIam7CQ+bzySoC
         gGOBNlZFILF1rbb13VR5vHbBB6o7IPhfhEtjuIQ55GiefDbPErJYqMNF7ag3KHBM9T1M
         Z1SXFFsw84dXXtq0Bg7SO0KF3jcdxFjvGihOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LbpMl5lO0+qWgp9uAKdYj5ux1bx38Si35gqGXl7ChFs=;
        b=BtH/3+2ZpkQeLW2Owj4NmkYg+oUj55+1EERtX0hkchV+jkwK4nGpQ1Ck0lDLQh8dqC
         rHdjdzaaalmTVSbvNbbcfIclMAbWN4kcbfcCd0Vdpt1gxp1dg9jRAXHacAk48kqR01DM
         oK1cObwwFkwRIiYo3gxc7VHUbG939JKFFuaqAxhpQChhS3uZmToojn6o5S13I62WV2gm
         dOV3iE99mi5HdPsW+OW4Tc+IAhoGVT6HLgkpaW2KG9WLsLO9kSIAIjYkTFEFjRhmpNcr
         1YKPDuGLrRnT+SxLUjooVkyzvbhn3ty3IohXGZnptgpuX4dd0q/bfPBo6QZJWmSC7gRo
         y6Zg==
X-Gm-Message-State: AOAM5327TiaAaRXDpMYZCgCKFGPETEi9FDOcpsGLHzVZ0Ernoj0cJ41G
        3jP6o7rwDuyMt31v0ty9CHtt4ZH+f54BtA==
X-Google-Smtp-Source: ABdhPJxvRU6kxg+SwKIXeJJOaju2lgebPzaRjUkC9X5kgWu+eZIppkSbDxNbU0elqP8gZYucBCf1AQ==
X-Received: by 2002:a2e:8011:: with SMTP id j17mr170397ljg.444.1600705508558;
        Mon, 21 Sep 2020 09:25:08 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id u17sm2696097lfi.2.2020.09.21.09.25.02
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 09:25:02 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id k25so11646470ljk.0
        for <linux-arch@vger.kernel.org>; Mon, 21 Sep 2020 09:25:02 -0700 (PDT)
X-Received: by 2002:a2e:994a:: with SMTP id r10mr154392ljj.102.1600705501870;
 Mon, 21 Sep 2020 09:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200919091751.011116649@linutronix.de> <CAHk-=wiYGyrFRbA1cc71D2-nc5U9LM9jUJesXGqpPnB7E4X1YQ@mail.gmail.com>
 <87mu1lc5mp.fsf@nanos.tec.linutronix.de> <87k0wode9a.fsf@nanos.tec.linutronix.de>
 <CAHk-=wgbmwsTOKs23Z=71EBTrULoeaH2U3TNqT2atHEWvkBKdw@mail.gmail.com>
 <87eemwcpnq.fsf@nanos.tec.linutronix.de> <CAHk-=wgF-upZVpqJWK=TK7MS9H-Rp1ZxGfOG+dDW=JThtxAzVQ@mail.gmail.com>
 <87a6xjd1dw.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87a6xjd1dw.fsf@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Sep 2020 09:24:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhxzx3KHHOMvdDj3Aw-_Mk5eRiNTUBB=tFf=vTkw1FeA@mail.gmail.com>
Message-ID: <CAHk-=wjhxzx3KHHOMvdDj3Aw-_Mk5eRiNTUBB=tFf=vTkw1FeA@mail.gmail.com>
Subject: Re: [patch RFC 00/15] mm/highmem: Provide a preemptible variant of
 kmap_atomic & friends
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
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
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Vineet Gupta <vgupta@synopsys.com>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-sparc <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 21, 2020 at 12:39 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> If a task is migrated to a different CPU then the mapping address will
> change which will explode in colourful ways.

Heh.

Right you are.

Maybe we really *could* call this new kmap functionality something
like "kmap_percpu()" (or maybe "local" is good enough), and make it
act like your RT code does for spinlocks - not disable preemption, but
only disabling CPU migration.

That would probably be good enough for a lot of users that don't want
to expose excessive latencies, but where it's really not a huge deal
to say "stick to this CPU for a short while".

The crypto code certainly sounds like one such case.

             Linus
