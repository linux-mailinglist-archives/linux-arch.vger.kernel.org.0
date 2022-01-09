Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441B4488721
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jan 2022 01:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbiAIA71 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 19:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbiAIA70 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 19:59:26 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB23C06173F
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 16:59:26 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id b7so8922190edj.9
        for <linux-arch@vger.kernel.org>; Sat, 08 Jan 2022 16:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7zvEReNqkRUab5oYVSCs8wCUfMO8Yz5KCIMf8aOgdYE=;
        b=Rg+rcaglrF5BH+4vIFj86wzuPDqhPlDaexMTbCHoG8FJxYBbN+tipmYPYem0Tt6TNx
         /Dc6Y+yqZeqYco4OeqBvGl5nn3ivrV6mJhm/JLRlbOCuviFQuyc4rbKMTxTfP86nO2sS
         I5Pj+MPFjhGNYYQHir2wSYb9FgoaqQxZKVsO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7zvEReNqkRUab5oYVSCs8wCUfMO8Yz5KCIMf8aOgdYE=;
        b=oIX9OoU+vD1afhJiEqOVmSEDfULRSLuWmjdOxIC2L8TLiPsMlTsCuR0MjbpPrrMerh
         aqj8PjlL9ipWkOT56xvH9Gx6qf/NpgeH1FRnqE7f5WBFI7ThWRytpymN+T7xxWbASabZ
         CWjObt10O+q8H142gWYB/iMaGN3gT3jdJw82y3xdVK34MzmdIICPoFW/lwCMcPSac3Ou
         YhIfrPq6T9YPok7fuOHaD0VLKwiOMDczx9z7LXPKp7DK7E7KGtfcMQ3fTNgfdKj1ZIEm
         7jUwPAZWwh6WxqrZ5RnwCXJKQOKz+b7MilNvSvyOZ5zKfBbzNJDPPYCMAoGgUXs/PuA1
         yGIQ==
X-Gm-Message-State: AOAM532OTgyp3utNz8tfmddptwj6/vrIkKxR7Lmes2MDIbpgI3uGfr73
        ID0T8V5XJbX2vf2hXT1+pB6CbqgfoQga8fEPha4=
X-Google-Smtp-Source: ABdhPJy8lxpQA1stvkjNs/DkCLq1VJT82K0zKsCR+2I7zhcJVkLr2XDMJf5W9VThv8uRh1o/RbVXXA==
X-Received: by 2002:a17:907:c17:: with SMTP id ga23mr50328171ejc.127.1641689964522;
        Sat, 08 Jan 2022 16:59:24 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id s7sm1385432edx.56.2022.01.08.16.59.24
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jan 2022 16:59:24 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id c71so26489614edf.6
        for <linux-arch@vger.kernel.org>; Sat, 08 Jan 2022 16:59:24 -0800 (PST)
X-Received: by 2002:adf:c74e:: with SMTP id b14mr26112698wrh.97.1641689653198;
 Sat, 08 Jan 2022 16:54:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641659630.git.luto@kernel.org> <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
 <CAHk-=wj4LZaFB5HjZmzf7xLFSCcQri-WWqOEJHwQg0QmPRSdQA@mail.gmail.com> <3586aa63-2dd2-4569-b9b9-f51080962ff2@www.fastmail.com>
In-Reply-To: <3586aa63-2dd2-4569-b9b9-f51080962ff2@www.fastmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 Jan 2022 16:53:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi2MtYYTs08RKHtj9Vtm0dri-saWwYh0tj=QUUUDSJFRQ@mail.gmail.com>
Message-ID: <CAHk-=wi2MtYYTs08RKHtj9Vtm0dri-saWwYh0tj=QUUUDSJFRQ@mail.gmail.com>
Subject: Re: [PATCH 16/23] sched: Use lightweight hazard pointers to grab lazy mms
To:     Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

[ Let's try this again, without the html crud this time. Apologies to
the people who see this reply twice ]

On Sat, Jan 8, 2022 at 2:04 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> So this requires that all architectures actually walk all relevant
> CPUs to see if an IPI is needed and send that IPI. On architectures
> that actually need an IPI anyway (x86 bare metal, powerpc (I think)
> and others, fine. But on architectures with a broadcast-to-all-CPUs
> flush (ARM64 IIUC), then the extra IPI will be much much slower than a
> simple load-acquire in a loop.

... hmm. How about a hybrid scheme?

 (a) architectures that already require that IPI anyway for TLB
invalidation (ie x86, but others too), just make the rule be that the
TLB flush by exit_mmap() get rid of any lazy TLB mm references. Which
they already do.

 (b) architectures like arm64 that do hw-assisted TLB shootdown will
have an ASID allocator model, and what you do is to use that to either
    (b') increment/decrement the mm_count at mm ASID allocation/freeing time
    (b'') use the existing ASID tracking data to find the CPU's that
have that ASID

 (c) can you really imagine hardware TLB shootdown without ASID
allocation? That doesn't seem to make sense. But if it exists, maybe
that kind of crazy case would do the percpu array walking.

(Honesty in advertising: I don't know the arm64 ASID code - I used to
know the old alpha version I wrote in a previous lifetime - but afaik
any ASID allocator has to be able to track CPU's that have a
particular ASID in use and be able to invalidate it).

Hmm. The x86 maintainers are on this thread, but they aren't even the
problem. Adding Catalin and Will to this, I think they should know
if/how this would fit with the arm64 ASID allocator.

Will/Catalin, background here:

   https://lore.kernel.org/all/CAHk-=wj4LZaFB5HjZmzf7xLFSCcQri-WWqOEJHwQg0QmPRSdQA@mail.gmail.com/

for my objection to that special "keep non-refcounted magic per-cpu
pointer to lazy tlb mm".

           Linus
