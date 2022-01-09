Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEE5488C29
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jan 2022 21:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbiAIUAy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Jan 2022 15:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiAIUAx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jan 2022 15:00:53 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5C4C06173F
        for <linux-arch@vger.kernel.org>; Sun,  9 Jan 2022 12:00:52 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z22so284641edd.12
        for <linux-arch@vger.kernel.org>; Sun, 09 Jan 2022 12:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LvH/2se3xGwfYyEVjqEGAd4Kiiwrhocy6Easjpl6vwM=;
        b=IcrK3Xa/N2KJ9hAMhoP55dkMvsyWl6DTRNGw3xGSJzWS4+hN3DQoHjdAJ0NdcSHyUS
         28+P6gtfn7Z/CsggBRBoZ0glN3QIUffoG5sHD4YitC3BwVMYbULQP9QktsMH27VV064n
         JSH+yB0E3+bAqMO6rgATjvA9zHEkRuGQGJWHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LvH/2se3xGwfYyEVjqEGAd4Kiiwrhocy6Easjpl6vwM=;
        b=kfvhaqBOGhQ0nEJHTGE7Dfw6a64qD4hxdCGLkihliQ+u/IyHhvuJFWpGegxOH96OAx
         WI3dO7lSe2LjHIsnHr9yTBjC6p9NsxNeSn2JMIiO/ajZa//M/ydk1RNi1clyAARg8YkB
         EQLdyhbJD4zFjNDFvzmU4GeZygliRBv/syJYncdk4rmhIJepPXXtDt8HFFgSYPNO8cqV
         2Wye+J5DwomEL9sqEZ2Pm0Yr3r22cCJuLKg6IGPAhR8kMSWuwneaujV4zQDh4dNDV7it
         L7RuZy65eGsDaknpCRKB+so/oi0ZsOYNuZHZXvzQIXa9biviot6yZqcI4opaTjfLguSS
         iIJw==
X-Gm-Message-State: AOAM532JLQkQwTrkIFjdQ+WgbFoUaL9qS4kOG1LSXxqtdEDOAjMeCsSm
        8o7R/MYcHpSuvSkCiRUMVOZBfvs263GIyu11OuA=
X-Google-Smtp-Source: ABdhPJyY9OjPd1ZBraRAyd3oM/LwpuE9jHUZCLO9EXywTQ1iuylJFg2pBLsU2ub3eGVDg3QcOsNOuw==
X-Received: by 2002:a17:906:2b01:: with SMTP id a1mr10968002ejg.709.1641758451125;
        Sun, 09 Jan 2022 12:00:51 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id 18sm1664353ejo.8.2022.01.09.12.00.48
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jan 2022 12:00:49 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id q8so22817220wra.12
        for <linux-arch@vger.kernel.org>; Sun, 09 Jan 2022 12:00:48 -0800 (PST)
X-Received: by 2002:adf:eeca:: with SMTP id a10mr17443019wrp.274.1641758448174;
 Sun, 09 Jan 2022 12:00:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641659630.git.luto@kernel.org> <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
 <739A3109-04DD-4BA5-A02B-52EE30E820AE@gmail.com> <CAHk-=wiEZO-uyFELSZgYmxF7eOLHrvh-kMWY5qTKjckOdNQxpA@mail.gmail.com>
 <B728EEE2-1EB9-4ACD-9F4E-423276380C0C@gmail.com> <CAHk-=wgtS7aNL=bxuwVFKiUzijc1EFiFXWTNLH-CHEgxciUVdg@mail.gmail.com>
 <355c148c-06a8-4e15-a77b-0ea2e22bf708@www.fastmail.com>
In-Reply-To: <355c148c-06a8-4e15-a77b-0ea2e22bf708@www.fastmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 9 Jan 2022 12:00:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiNTupLcOL7z=FNq2YoD=H=urRHFZQNqHAvJ+8R=ZyOVw@mail.gmail.com>
Message-ID: <CAHk-=wiNTupLcOL7z=FNq2YoD=H=urRHFZQNqHAvJ+8R=ZyOVw@mail.gmail.com>
Subject: Re: [PATCH 16/23] sched: Use lightweight hazard pointers to grab lazy mms
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jan 9, 2022 at 11:53 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> My original PCID series actually did remove lazy TLB on x86. I don't
> remember why, but people objected. The issue isn't the limited PCID
> space -- IIRC it's just that MOV CR3 is slooooow. If we get rid of
> lazy TLB on x86, then we are writing CR3 twice on even a very short
> idle. That adds maybe 1k cycles, which isn't great.

Yeah, my gut feel is that lazy-TLB almost certainly makes sense on x86.

And the grab/mmput overhead and associated cacheline ping-pong is (I
think) something we could just get rid of on x86 due to the IPI model.
There are probably other costs to lazy TLB, and I can imagine that
there are other maintenance costs, but yes, cr3 moves have always been
expensive on x86 even aside from the actual TLB switch.

But I could easily imagine the situation being different on arm64, for example.

But numbers beat "gut feel" and "easily imagine" every time. So it
would be kind of nice to have that ...

          Linus
