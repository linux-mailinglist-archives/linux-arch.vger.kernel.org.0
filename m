Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265AA668848
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jan 2023 01:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240624AbjAMAQv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Jan 2023 19:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240369AbjAMAQV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Jan 2023 19:16:21 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174E1687B2
        for <linux-arch@vger.kernel.org>; Thu, 12 Jan 2023 16:13:35 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id j9so13861587qvt.0
        for <linux-arch@vger.kernel.org>; Thu, 12 Jan 2023 16:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kqiL43eyuEfUGs2vRxAEVvpUnI4QNGGWB1NDFJCBIyY=;
        b=hsvjOhr77zapXL9VgwDCu/nspZMcI9irVYw/aM6FdAC+cXzhnAPzK7LCAG7RqQZj81
         zwWabggWfjPPSAh7ggo71yG7mqp2NKWZTeCL23K4GtByEyl7iXJsuJpmSArE0X2iPJcK
         1ojWDX9lwlXQBp2dt7cKIVuYG0iNNtUcO91v0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kqiL43eyuEfUGs2vRxAEVvpUnI4QNGGWB1NDFJCBIyY=;
        b=qUFtznTRbb8tDtymDIXVi2EBOBU7Ywn8JI8x5ITDfxyE0Vn51ZR5LfjxYVci/0yyyu
         fF4olb5N99rJVnsIUmrRn9to2o6pfy+7PysHibhxML80MuFL6DK5R3PjKbYXYZtxiw1t
         zwvijvGxchwqbHl6uyXClANMPhsFMKVvlnDhFefQ6r/+Mn4O4B7ZtL0Pv9dPGxT+mQ/x
         BoYZgDvYxrA2G0Cv9qTFy0nJMGKFxtLGZ4jo2rKKJaz3nWg/EHr1T6RglbjVFad1iqrH
         16FvVR8qgbemlE+THsc/igDn87tlMGXPtAMEWRxZsg1ueExd4nTLs0STo/URcPjfuJ15
         PAvg==
X-Gm-Message-State: AFqh2kqFFfq4pRGU88oNKYVXn/2g1wk8KhXIIU9ybEQACXygdArGSq5g
        ceU/3kLEGPUMJRnCFC+Nr9qnO368XqyrwJL1lJw=
X-Google-Smtp-Source: AMrXdXvk5DqXxxSc52EQ+w9Y7qsLgJlCJ7V05cSjXVJQDa6a349SwejumEalOLfLAyZ95Rn5hibXkA==
X-Received: by 2002:a0c:fc43:0:b0:534:26eb:a25d with SMTP id w3-20020a0cfc43000000b0053426eba25dmr10008917qvp.40.1673568813867;
        Thu, 12 Jan 2023 16:13:33 -0800 (PST)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id t2-20020a37ea02000000b006fb9bbb071fsm11680170qkj.29.2023.01.12.16.13.32
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 16:13:33 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id k11so731825qth.3
        for <linux-arch@vger.kernel.org>; Thu, 12 Jan 2023 16:13:32 -0800 (PST)
X-Received: by 2002:a05:622a:250f:b0:3b2:d164:a89b with SMTP id
 cm15-20020a05622a250f00b003b2d164a89bmr19886qtb.452.1673568812575; Thu, 12
 Jan 2023 16:13:32 -0800 (PST)
MIME-Version: 1.0
References: <CAGudoHHx0Nqg6DE70zAVA75eV-HXfWyhVMWZ-aSeOofkA_=WdA@mail.gmail.com>
In-Reply-To: <CAGudoHHx0Nqg6DE70zAVA75eV-HXfWyhVMWZ-aSeOofkA_=WdA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Jan 2023 18:13:16 -0600
X-Gmail-Original-Message-ID: <CAHk-=wjthxgrLEvgZBUwd35e_mk=dCWKMUEURC6YsX5nWom8kQ@mail.gmail.com>
Message-ID: <CAHk-=wjthxgrLEvgZBUwd35e_mk=dCWKMUEURC6YsX5nWom8kQ@mail.gmail.com>
Subject: Re: lockref scalability on x86-64 vs cpu_relax
To:     Mateusz Guzik <mjguzik@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Jan Glauber <jan.glauber@gmail.com>, tony.luck@intel.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

[ Adding linux-arch, which is relevant but not very specific, and the
arm64 and powerpc maintainers that are the more specific cases for an
architecture where this might actually matter.

  See

        https://lore.kernel.org/all/CAGudoHHx0Nqg6DE70zAVA75eV-HXfWyhVMWZ-aSeOofkA_=WdA@mail.gmail.com/

  for original full email, but it might be sufficiently clear just
from this heavily cut-down context too ]

Side note on your access() changes - if it turns out that you can
remove all the cred games, we should possibly then revert my old
commit d7852fbd0f04 ("access: avoid the RCU grace period for the
temporary subjective credentials") which avoided the biggest issue
with the unnecessary cred switching.

I *think* access() is the only user of that special 'non_rcu' thing,
but it is possible that the whole 'non_rcu' thing ends up mattering
for cases where the cred actually does change because euid != uid (ie
suid programs), so this would need a bit more effort to do performance
testing on.

On Thu, Jan 12, 2023 at 5:36 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> To my understanding on said architecture failed cmpxchg still grants you
> exclusive access to the cacheline, making immediate retry preferable
> when trying to inc/dec unless a certain value is found.

I actually suspect that is _always_ the case - this is not like a
contended spinlock where we want to pause because we're waiting for
the value to change and become unlocked, this cmpxchg loop is likely
always better off just retrying with the new value.

That said, the "likely always better off" is purely about performance.

So I have this suspicion that the reason Tony added the cpu_relax()
was simply not about performance, but about other issues, like
fairness in SMT situations.

That said, evern from a fairness perspective the cpu_relax() sounds a
bit odd and unlikely - we're literally yielding when we lost a race,
so it hurts the _loser_, not the winner, and thus might make fairness
worse too.

I dunno.  Tony may have some memory of what the issue was.

> ... without numbers attached to it. Given the above linked thread it
> looks like the arch this was targeting was itanium, not x86-64, but
> the change landed for everyone.

Yeah, if it was ia64-only, it's a non-issue these days. It's dead and
in pure maintenance mode from a kernel perspective (if even that).

> Later it was further augmented with:
> commit 893a7d32e8e04ca4d6c882336b26ed660ca0a48d
> Author: Jan Glauber <jan.glauber@gmail.com>
> Date:   Wed Jun 5 15:48:49 2019 +0200
>
>     lockref: Limit number of cmpxchg loop retries
> [snip]
>     With the retry limit the performance of an open-close testcase
>     improved between 60-70% on ThunderX2.
>
> While the benchmark was specifically on ThunderX2, the change once more
> was made for all archs.

Actually, in that case I did ask for the test to be run on x86
hardware too, and exactly like you found:

> I should note in my tests the retry limit was never reached fwiw.

the max loop retry number just isn't an issue. It fundamentally only
affects extremely unfair platforms, so it's arguably always the right
thing to do.

So it may be "ThunderX2 specific" in that that is where it was
noticed, but I think we can safely just consider the max loop thing to
be a generic safety net that hopefully simply never triggers in
practice on any sane platform.

> All that said, I think the thing to do here is to replace cpu_relax
> with a dedicated arch-dependent macro, akin to the following:

I would actually prefer just removing it entirely and see if somebody
else hollers. You have the numbers to prove it hurts on real hardware,
and I don't think we have any numbers to the contrary.

So I think it's better to trust the numbers and remove it as a
failure, than say "let's just remove it on x86-64 and leave everybody
else with the potentially broken code"

Because I do think that a cmpxchg loop that updates the value it
compares and exchanges is fundamentally different from a "busy-loop,
trying to read while locked", and with your numbers as ammunition, I
think it's better to just remove that cpu_relax() entirely.

Then other architectures can try to run their numbers, and only *if*
it then turns out that they have a reason to do something else should
we make this conditional and different on different architectures.

Let's try to keep the code as common as possibly until we have hard
evidence for special cases, in other words.

                 Linus
