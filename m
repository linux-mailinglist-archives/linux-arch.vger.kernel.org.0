Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F39D488592
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 20:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiAHTXI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 14:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiAHTXI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 14:23:08 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFEEC06173F
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 11:23:07 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z9so35946572edm.10
        for <linux-arch@vger.kernel.org>; Sat, 08 Jan 2022 11:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HAp9U7GC794so0DPwUoyAc6XCFDGP/6ZZKph1pyeqFk=;
        b=NRMT/9P1QQzMSkdfnte3DU53C3Y1PSFTN+V+KqzGbKXoKK2OAv2RLtbwuzMrPxLoBG
         tlvVMUV9Qa8v4n8Tv8abXCecPdYAwmxJiiGHGnEhAEDmj8AzzeB5VIU5Z+E4ACqTBBe4
         JooZU0paUl/jNDEl0WaRTfAUMwgcf1UIoxgl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HAp9U7GC794so0DPwUoyAc6XCFDGP/6ZZKph1pyeqFk=;
        b=BM6UGKgGLgLQw8QwIicu1/6X0la6Hxjl2G482AAq/x0Vrm5vNQWcuntIY7nl0HYhrF
         jJmatVFz0lqntNbefNYQw+iFJkfJs8WpG4yWA6VU2HqAjQMHsbOspCwqUCHqaV0OmfNY
         PLDZwfyPCqzGIxkHJ/gvS7k6E/WdwnoOu15YCJwQ7HRd38WVCs/JRqhkjNH6Zukz3T3Y
         9IIFlMMny6xPFQv0/DfwCh17FOtYFDpyzDCFVLaDN7T7eA0/ESOJZ73s4Owj3AyDT8Ga
         nQV9UxFetHxTqjN8/NQ4QJzuyMdR7u/g1rhI7F4HGDxGxW2xETBZxWdc5py11KlV4Ejt
         yaLg==
X-Gm-Message-State: AOAM530ghJlJ6kRrT7aD/AXxOthlyyCAokhGfU5J38Frk+3BJ3w+TyXE
        FNyzxfH1NL2+bv/WF0cVJhVzbX+eXK7fXWk8
X-Google-Smtp-Source: ABdhPJwM9oNWAAFdNt6j3Mt+QuFuZu4r/5WRWyAvbiTW71LOc2CUuhoo5hRw1Fg9ytrSAWnfqXG8rw==
X-Received: by 2002:aa7:cb08:: with SMTP id s8mr27697850edt.57.1641669785270;
        Sat, 08 Jan 2022 11:23:05 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id d1sm742289ejo.176.2022.01.08.11.23.04
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jan 2022 11:23:04 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id o7-20020a05600c510700b00347e10f66d1so570466wms.0
        for <linux-arch@vger.kernel.org>; Sat, 08 Jan 2022 11:23:04 -0800 (PST)
X-Received: by 2002:a1c:19c6:: with SMTP id 189mr12513195wmz.155.1641669784282;
 Sat, 08 Jan 2022 11:23:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641659630.git.luto@kernel.org> <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
In-Reply-To: <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 Jan 2022 11:22:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj4LZaFB5HjZmzf7xLFSCcQri-WWqOEJHwQg0QmPRSdQA@mail.gmail.com>
Message-ID: <CAHk-=wj4LZaFB5HjZmzf7xLFSCcQri-WWqOEJHwQg0QmPRSdQA@mail.gmail.com>
Subject: Re: [PATCH 16/23] sched: Use lightweight hazard pointers to grab lazy mms
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 8, 2022 at 8:44 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> To improve scalability, this patch adds a percpu hazard pointer scheme to
> keep lazily-used mms alive.  Each CPU has a single pointer to an mm that
> must not be freed, and __mmput() checks the pointers belonging to all CPUs
> that might be lazily using the mm in question.

Ugh. This feels horribly fragile to me, and also looks like it makes
some common cases potentially quite expensive for machines with large
CPU counts if they don't do that mm_cpumask optimization - which in
turn feels quite fragile as well.

IOW, this just feels *complicated*.

And I think it's overly so. I get the strong feeling that we could
make the rules much simpler and more straightforward.

For example, how about we make the rules be

 - a lazy TLB mm reference requires that there's an actual active user
of that mm (ie "mm_users > 0")

 - the last mm_users decrement (ie __mmput) forces a TLB flush, and
that TLB flush must make sure that no lazy users exist (which I think
it does already anyway).

Doesn't that seem like a really simple set of rules?

And the nice thing about it is that we *already* do that required TLB
flush in all normal circumstances. __mmput() already calls
exit_mmap(), and exit_mm() already forces that TLB flush in every
normal situation.

So we might have to make sure that every architecture really does that
"drop lazy mms on TLB flush", and maybe add a flag to the existing
'struct mmu_gather tlb' to make sure that flush actually always
happens (even if the process somehow managed to unmap all vma's even
before exiting).

Is there something silly I'm missing? Somebody pat me on the head, and
say "There, there, Linus, don't try to get involved with things you
don't understand.." and explain to me in small words.

                  Linus
