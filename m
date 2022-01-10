Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72DA9489E4F
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jan 2022 18:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238203AbiAJR0B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jan 2022 12:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238230AbiAJR0A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jan 2022 12:26:00 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DE6C06173F
        for <linux-arch@vger.kernel.org>; Mon, 10 Jan 2022 09:25:59 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id s30so19073834lfo.7
        for <linux-arch@vger.kernel.org>; Mon, 10 Jan 2022 09:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/2g4WzhUycW/Ns97U5fXJOBAR0Fut5CITQBsuRcSJ3Q=;
        b=AiJmLJpdMyI2TF4+zo61R9W1PwwTq5FFExDcBX4ZFTOtBV6VzDymirf3f59Sbfdj0q
         Ryv0jG1DUNYlfnQ0Fkmm+uUs9fUsmOeOXPVg0H72WDCaNfgAgKxH8kZUrwQExTx2euCE
         3/eL28GDF9eWagtoCQY365cz5vbtP8iiLfH2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/2g4WzhUycW/Ns97U5fXJOBAR0Fut5CITQBsuRcSJ3Q=;
        b=scp12eJ7rt5PBIH+jqdZWgJzL2RJfJFDU622D/ga7S/u/+79JkNNaH1Fzx3ZsGawaJ
         g48nF8cTHbv/scOP2mqXmPrnKYN1ZDb5tHdQPufU3dGwQWuFrgrpEsFKPvR46EtPp0Ig
         S8JLPq90Loe3PGDxpLDbmrzaJU5qA2VcXjPJe41FBUCKyzMYD6fyLNjIALswHK1sVnFl
         HD8GHcB8PvwSrF74F4DPpuDsabChoB2fAaO1vSuP9Y4RwT+59b3v1jt/hQ9eVgLJcfNy
         im9g4J6VGxF3aaO+2fo/PdWbObEbmHXOGqH4W2lBHmAS5bspATe5+hjDmICtW41d5hiR
         zyQg==
X-Gm-Message-State: AOAM5303u8/RbhtKhLNsJt5dDaMi/lm1tbAlmpFNvZxv9pNhBs14qM32
        f51q3vneAnyVCc7VpDRN7Yg7/Wo+TQ8vcE7rd30=
X-Google-Smtp-Source: ABdhPJx+uL4hwlG2dBWSRtgMP1bueyoPXSmW8zERXbwECwQx8loYMZlmUAT/O8n2fmZZBIiEKgyrIg==
X-Received: by 2002:a05:651c:508:: with SMTP id o8mr322535ljp.99.1641835558011;
        Mon, 10 Jan 2022 09:25:58 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id j7sm1082098lfe.12.2022.01.10.09.25.57
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 09:25:57 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id m1so13679801lfq.4
        for <linux-arch@vger.kernel.org>; Mon, 10 Jan 2022 09:25:57 -0800 (PST)
X-Received: by 2002:a5d:6951:: with SMTP id r17mr507730wrw.274.1641835215696;
 Mon, 10 Jan 2022 09:20:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641659630.git.luto@kernel.org> <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
 <CAHk-=wj4LZaFB5HjZmzf7xLFSCcQri-WWqOEJHwQg0QmPRSdQA@mail.gmail.com>
 <3586aa63-2dd2-4569-b9b9-f51080962ff2@www.fastmail.com> <CAHk-=wi2MtYYTs08RKHtj9Vtm0dri-saWwYh0tj=QUUUDSJFRQ@mail.gmail.com>
 <430e3db1-693f-4d46-bebf-0a953fe6c2fc@www.fastmail.com> <CAHk-=wjkbFFvgnUqgO8omHgTJx0GDwhxP9Cw0g6E03zOVbC7HQ@mail.gmail.com>
 <484a7f37-ceed-44f6-8629-0e67a0860dc8@www.fastmail.com> <CAHk-=whJYoKgAAtb6pYQVSPnyLQsnS6+rU=0jBUqrZU76LyDqg@mail.gmail.com>
 <CAHk-=wgnTWk2zeOO1YQ_8S-xPf4Pr0vXBs7DnhOPdKQFHXOnxw@mail.gmail.com>
 <1641790309.2vqc26hwm3.astroid@bobo.none> <1641791321.kvkq0n8kbq.astroid@bobo.none>
In-Reply-To: <1641791321.kvkq0n8kbq.astroid@bobo.none>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Jan 2022 09:19:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=whX3cMJ30ZwX+BUJm8Eov3Ae3C76Ba51FAzX4nJz24Kmg@mail.gmail.com>
Message-ID: <CAHk-=whX3cMJ30ZwX+BUJm8Eov3Ae3C76Ba51FAzX4nJz24Kmg@mail.gmail.com>
Subject: Re: [PATCH 16/23] sched: Use lightweight hazard pointers to grab lazy mms
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jan 9, 2022 at 9:18 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> This is the patch that goes on top of the series I posted. It's not
> very clean at the moment it was just a proof of concept.

Yeah, this looks like what x86 basically already effectively does.

x86 obviously doesn't have that TLBIE option, and already has that
"exit lazy mode" logic (although it does so differently, using
switch_mm_irqs_off(), and guards it with the 'info->freed_tables'
check).

But there are so many different possible ways to flush TLB's (the
whole "paravirt vs native") that it would still require some
double-checking that there isn't some case that does it differently..

               Linus
