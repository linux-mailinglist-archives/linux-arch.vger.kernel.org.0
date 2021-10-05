Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC94F422AEA
	for <lists+linux-arch@lfdr.de>; Tue,  5 Oct 2021 16:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbhJEOWr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Oct 2021 10:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235294AbhJEOWp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Oct 2021 10:22:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33077C061749;
        Tue,  5 Oct 2021 07:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9cd4fflbhPi+WS75BLlYH8Lxr29xEplX+5DiCepdM6M=; b=OnNnDZAKK+pQ6EIA+ZWx48Di7m
        tMp2OUnjS87vId8Dy0d5hZTjGs7cBq59swnhV9JCKGUAzFnr4WwA+9tlVSLgeXL/JLufkRzubC33Q
        2l6MC4iBv8AJKNMMFJIyUSiJGVQMVoVnkPXvew12mA05UqHbUmiSw5/xcYTn8smG0rJ7m4vpEQQri
        uJzZ1wwm3TM8a92IqmGWFaJB9LOc9VPHqCAvbTIjN2+tUGfSHPwL5UelwKcDGytuynF2iS4WBAAmX
        cYg84BxxaLFmdMUPQ4PYoo8sij9dMymbE4t8KP5tgclSAt9k3YtZPnwReEUI5PfzlKFGo4C/q161H
        qyQQ4eEw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXlJ8-0083tX-1Y; Tue, 05 Oct 2021 14:20:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 28D5230003C;
        Tue,  5 Oct 2021 16:20:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 100B321339B6B; Tue,  5 Oct 2021 16:20:37 +0200 (CEST)
Date:   Tue, 5 Oct 2021 16:20:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH -rcu/kcsan 04/23] kcsan: Add core support for a subset of
 weak memory modeling
Message-ID: <YVxfNbTgT7GN21I1@hirez.programming.kicks-ass.net>
References: <20211005105905.1994700-1-elver@google.com>
 <20211005105905.1994700-5-elver@google.com>
 <YVxKplLAMJJUlg/w@hirez.programming.kicks-ass.net>
 <CANpmjNMk0ubjYEVjdx=gg-S=zy7h=PSjZDXZRVfj_BsNzd6zkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMk0ubjYEVjdx=gg-S=zy7h=PSjZDXZRVfj_BsNzd6zkg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 05, 2021 at 03:13:25PM +0200, Marco Elver wrote:
> On Tue, 5 Oct 2021 at 14:53, Peter Zijlstra <peterz@infradead.org> wrote:

> > And since you want to mark these functions as uaccess_safe, there must
> > not be any tracing on, hence notrace.
> 
> In the Makefile we've relied on:
> 
>   CFLAGS_REMOVE_core.o = $(CC_FLAGS_FTRACE)
> 
> just to disable it for all code here. That should be enough, right?

I find these implicit notrace thingies terribly confusing :/ I've
reported fail to rostedt a number of times only to be (re)told about
these Makefile level thingies.

Ideally we'd script notrace on every implicit symbol or something.
