Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136D86C28B2
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 04:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjCUDyt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 23:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCUDys (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 23:54:48 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D5D1FCF
        for <linux-arch@vger.kernel.org>; Mon, 20 Mar 2023 20:54:46 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso14634868pjb.3
        for <linux-arch@vger.kernel.org>; Mon, 20 Mar 2023 20:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679370886;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoABFC0Xy1EF5COqSJmS8vasqT4dLgmRzbs++Rzv7g8=;
        b=TmYhZNLluP9YJBu0GCH8ISUhXDlv7gr5BVpFGydQG0SbjYIa4Pe5xCrgs7NZ+dV/jx
         yw/i2n1cYrQWf6wKcdhfvFEcKP6OClbYe2TXvkVeGFYAuFPUhw/VHjYoqBoRHkku9Yyo
         YWWC3zkApLYJjIfkchNY0gSQ686GHeCh8LCT9SN4yJcp6kFJ7yk/++obcTGJ3T89oCYQ
         NUGzX2q87r3NVUfFZZVx/0cQMslHEuTRIDh3RqPyRRfEnZRpLDxVAQhSPAYgX7uX3RxX
         HmzZO0YicX5sEei74jmJ2OHFKaWouOtUX/Dp/VGusHFxDC3CxmnpbBoWnl6TCEib2N+C
         u+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679370886;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hoABFC0Xy1EF5COqSJmS8vasqT4dLgmRzbs++Rzv7g8=;
        b=D29oSLVxAI5lTcWdXDpBh7ScQ29AtgjzoSPC7XKj0gECSwdaYs/yByuNDuGDHTzAFT
         fpiizqkQPYJRT12fQk7rbrriWVhuFMWwJWasA3F5FVq7pMTvpn+pyORp1/hqcm1TOtLy
         cpmgswlj5IAWn4Wltd9lMN0La1v4yuKLVo2P/M0P/smwdVZDmXVd0HXFy2vqr569UH55
         K0LUGySxEt8uaZxFSYcpIiTIKFO1ijV3WmM+ID5t+9VjzoGQyHEyvhJqjkKBGq6BEuzN
         e7V5UYdyyQTvb311wYqzkA4ywEa9fH7s58vVsx27easr4ZQntxTTcsByMpo0rq6bw2tj
         mtmQ==
X-Gm-Message-State: AO0yUKVia9G1zfNVL1KUSofdpOVOdrHetQykCy2zaKMCBP9PYeW89UdH
        6H7RfO0dm+fw7SMQsZ8sB2Q=
X-Google-Smtp-Source: AK7set9bW6MOw9JnTLFSfH/FO7ROJZl4Ze+GGQm42g/O8jmbrO7D12Z+lVRicSWvohwxG9WJlWXqGg==
X-Received: by 2002:a17:90b:4f8a:b0:237:24eb:99d8 with SMTP id qe10-20020a17090b4f8a00b0023724eb99d8mr1184759pjb.19.1679370886224;
        Mon, 20 Mar 2023 20:54:46 -0700 (PDT)
Received: from localhost (121-44-69-75.tpgi.com.au. [121.44.69.75])
        by smtp.gmail.com with ESMTPSA id a3-20020a637f03000000b005034a46fbf7sm6872626pgd.28.2023.03.20.20.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 20:54:45 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 21 Mar 2023 13:54:38 +1000
Message-Id: <CRBRAIZP5QE1.ITEW097S1CJ6@bobo>
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Peter Zijlstra" <peterz@infradead.org>,
        "Andrew Morton" <akpm@linux-foundation.org>
Cc:     "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Nadav Amit" <nadav.amit@gmail.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, "Rik van Riel" <riel@redhat.com>,
        <linux-arch@vger.kernel.org>, <linux-mm@kvack.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        "Andy Lutomirski" <luto@amacapital.net>
Subject: Re: [PATCH v7 5/5] powerpc/64s: enable MMU_LAZY_TLB_SHOOTDOWN
X-Mailer: aerc 0.13.0
References: <20230203071837.1136453-1-npiggin@gmail.com>
 <20230203071837.1136453-6-npiggin@gmail.com>
 <20230226141238.6ec5fdf7d75dcf2cd4c58ba0@linux-foundation.org>
 <Y/yxEnCcPmUk89Jp@hirez.programming.kicks-ass.net>
In-Reply-To: <Y/yxEnCcPmUk89Jp@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon Feb 27, 2023 at 11:33 PM AEST, Peter Zijlstra wrote:
> On Sun, Feb 26, 2023 at 02:12:38PM -0800, Andrew Morton wrote:
> > On Fri,  3 Feb 2023 17:18:37 +1000 Nicholas Piggin <npiggin@gmail.com> =
wrote:
> >=20
> > > On a 16-socket 192-core POWER8 system, the context_switch1_threads
> > > benchmark from will-it-scale (see earlier changelog), upstream can
> > > achieve a rate of about 1 million context switches per second, due to
> > > contention on the mm refcount.
> > >=20
> > > 64s meets the prerequisites for CONFIG_MMU_LAZY_TLB_SHOOTDOWN, so ena=
ble
> > > the option. This increases the above benchmark to 118 million context
> > > switches per second.
> >=20
> > Is that the best you can do ;)
> >=20
> > > This generates 314 additional IPI interrupts on a 144 CPU system doin=
g
> > > a kernel compile, which is in the noise in terms of kernel cycles.
> > >=20
> > > ...
> > >
> > > --- a/arch/powerpc/Kconfig
> > > +++ b/arch/powerpc/Kconfig
> > > @@ -265,6 +265,7 @@ config PPC
> > >  	select MMU_GATHER_PAGE_SIZE
> > >  	select MMU_GATHER_RCU_TABLE_FREE
> > >  	select MMU_GATHER_MERGE_VMAS
> > > +	select MMU_LAZY_TLB_SHOOTDOWN		if PPC_BOOK3S_64
> > >  	select MODULES_USE_ELF_RELA
> > >  	select NEED_DMA_MAP_STATE		if PPC64 || NOT_COHERENT_CACHE
> > >  	select NEED_PER_CPU_EMBED_FIRST_CHUNK	if PPC64
> >=20
> > Can we please have a summary of which other architectures might benefit
> > from this, and what must they do?

Coming back to this... The recipes to enable are somewhat documented I
Kconfig. If those weren't clear I can improve or.. not sure where else
to add this stuff. It would be nice if all these options had more
explanation and requirements, I'm just not sure what's going to work
best (beyond what I did in Kconfig).

Not much noise from other archs so far, so I'll take a guess and say
archs that have large SMP systems might. x86 and s390 perhaps. Seems
to be some work still ongoing in the x86 branch, I didn't hear if you
found the docs inadequate or any suggestions to improve understanding?
Some were very confused by it, but I was never able to help them grasp
the concepts or get to the bottom of what the problem was, so that
was a dead end unfortunately.


> >=20
> > As this is powerpc-only, I expect it won't get a lot of testing in
> > mm.git or in linux-next.  The powerpc maintainers might choose to merge
> > in the mm-stable branch at
> > git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm if this is a
> > concern.
>
> I haven't really had time to page all of this back in, but x86 is very
> close to be able to use this, it mostly just needs cleaning up some
> accidental active_mm usage.
>
> I've got a branch here:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=
=3Dx86/lazy
>
> That's mostly Nick's patches with a bunch of Andy's old patches stuck on
> top. I also have a pile of notes, but alas, not finished in any way.

Great that a proof of concept shows it can work for x86, I guess
that's an ack for this series from x86? :)

x86 implementation presumably won't be merged until objectionable
active_mm and other code in core code that makes things difficult for
the arch is cleaned up so we don't get into the situation again where
crap keeps getting built on crap and everybody else's nice clean patches
gets nacked for years because one arch is festering. Will be great to
see those cleanups.

Thanks,
Nick

