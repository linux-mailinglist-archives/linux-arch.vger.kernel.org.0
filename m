Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB9F42E444
	for <lists+linux-arch@lfdr.de>; Fri, 15 Oct 2021 00:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhJNWi6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Oct 2021 18:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhJNWi5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Oct 2021 18:38:57 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22593C061570
        for <linux-arch@vger.kernel.org>; Thu, 14 Oct 2021 15:36:52 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id n8so33132622lfk.6
        for <linux-arch@vger.kernel.org>; Thu, 14 Oct 2021 15:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oPuxOfPoEn2w+Vy6YtWqvZyYsB0r4ReZCNxVMrkb8QI=;
        b=TU2N5ITK3xVvoWLOxg0QxSdXuTND/1UVb8D9kq7fbac/6VC+lbImYzJlzwGBaDf5Pi
         1jEErQguvYRKtAArQG03jv4A/g1xPWpJLfs42JrKGBOTus1dB6eJozNJOOcZh974rGLb
         bnRyUJRcXby9bIILD4PGb6QWwfZdO2Q7jF3rY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oPuxOfPoEn2w+Vy6YtWqvZyYsB0r4ReZCNxVMrkb8QI=;
        b=QzF2YayXBNJSPLjbA4NgilKwpSwvpTdjaLKaxFEL6a0VCbNK4GUtSKF+IaamydvPw9
         0WxCLmsQbOmgHY/WxaGYXgoHLfwHqPUkWFhFqmqOxReW0si3687jIOlk7OTFQgsdtr+J
         prinqCJDPyKace3RVE2NM0P5dcQphSJy8VAF3kK+VBbZrx7okW4egKA6ydOluuwT3TtP
         7U1ID5zSqneyu+uK5vPwsDySNjvijSra8Q3naJC3GiuHkGxq3onxZGg7XdbPjTdizQZR
         FUBhRHlejUfYp9WptixddZ7xNTLMuFr1mUDzWAiIBOWZE1yjIEIm2VCypgwI34N6CKFJ
         KkOA==
X-Gm-Message-State: AOAM533XE4BoIeAceBc/x46yl0wQE/jwiMbv33Gi+ZrcRpS63474Ny2P
        nPHK5GTlxvSpFm3I2NgLdsEIcxg0v+gCUgOL
X-Google-Smtp-Source: ABdhPJycyxcG/FpWVBE+B73L/Ex4NFWsXS1BXpgkWd84rpZm0yzqhEg7Af4mz+PZuSDhq4zeMt1nTg==
X-Received: by 2002:a2e:b0c6:: with SMTP id g6mr8926159ljl.496.1634251010183;
        Thu, 14 Oct 2021 15:36:50 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id p6sm335738lfs.109.2021.10.14.15.36.45
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 15:36:49 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id r19so32228560lfe.10
        for <linux-arch@vger.kernel.org>; Thu, 14 Oct 2021 15:36:45 -0700 (PDT)
X-Received: by 2002:a05:6512:398a:: with SMTP id j10mr7595767lfu.402.1634251004791;
 Thu, 14 Oct 2021 15:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <87lf3f7eh6.fsf@oldenburg.str.redhat.com> <20210929174146.GF22689@gate.crashing.org>
 <2088260319.47978.1633104808220.JavaMail.zimbra@efficios.com>
 <871r54ww2k.fsf@oldenburg.str.redhat.com> <CAHk-=wgexLqNnngLPts=wXrRcoP_XHO03iPJbsAg8HYuJbbAvw@mail.gmail.com>
 <87y271yo4l.fsf@mid.deneb.enyo.de> <20211014000104.GX880162@paulmck-ThinkPad-P17-Gen-1>
 <87lf2v61k7.fsf@mid.deneb.enyo.de> <20211014162311.GD880162@paulmck-ThinkPad-P17-Gen-1>
 <87o87r4gfp.fsf@mid.deneb.enyo.de> <20211014210959.GJ880162@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20211014210959.GJ880162@paulmck-ThinkPad-P17-Gen-1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 Oct 2021 18:36:28 -0400
X-Gmail-Original-Message-ID: <CAHk-=whrmpKUbJp1gmY3tyNCw6YebEZO1Cd8GzsL_4WFf-obDQ@mail.gmail.com>
Message-ID: <CAHk-=whrmpKUbJp1gmY3tyNCw6YebEZO1Cd8GzsL_4WFf-obDQ@mail.gmail.com>
Subject: Re: [RFC PATCH] LKMM: Add ctrl_dep() macro for control dependency
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Florian Weimer <fw@deneb.enyo.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        j alglave <j.alglave@ucl.ac.uk>,
        luc maranget <luc.maranget@inria.fr>,
        akiyks <akiyks@gmail.com>,
        linux-toolchains <linux-toolchains@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 14, 2021 at 5:10 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> In all the weakly ordered architectures I am aware of, spilling to
> the stack and reloading preserves the ordering.  The ordering from
> the initial load to the spill is an assembly-language data dependency,
> the ordering from the spill to the reload is single-variable SC, and
> the ordering beyond that is the original control dependency.

I think the thing about a control dependency is that any way to
optimize it differently only strengthens it.

That was very different from the problems we had with describing the
RCU dependencies - they were data dependencies, and if they could ever
be turned into control dependencies, they would have been weakened.

But the only way to really weaken a control dependency and the write
behind it is to get rid of it entirely.

So turning it into a data dependency (by turning the conditional into
a 'select' instruction, for example) only makes it stronger. And no
amount of register spilling or data movement any other way makes any
difference.

That's why all the examples of what could go wrong were about same
code on both sides of the conditional, which allowed removing the
conditional entirely (or at least moving parts of the "protected" code
to before it.

(The other way to remove the conditional is to just optimize away the
conditional itself, but that's defeated by "READ_ONCE()" being part of
the source of the conditional, and any data or control dependency from
that fundamental "the compiler cannot remove this logic" is always
sufficient).

So I really don't think this is even about "any weakly ordered
architecture". I think this is fundamentally about causality. You
simply cannot make a conditional write visible before the condition
has been resolved, and resolving the condition requires the read to
have happened.

This is not open to "speculation". Not by hardware, not by compilers.

There are only two ways you can break this fundamental construct:

 - outright bugs

 - a perfect oracle

And honestly, if you have a perfect oracle, you're better off making
money playing the lotto than you would ever be doing hardware or
software development, so that second option isn't really even
interesting.

                 Linus
