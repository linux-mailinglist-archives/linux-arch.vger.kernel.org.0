Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7674281A6
	for <lists+linux-arch@lfdr.de>; Sun, 10 Oct 2021 16:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbhJJOKC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 10 Oct 2021 10:10:02 -0400
Received: from albireo.enyo.de ([37.24.231.21]:55352 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232494AbhJJOKC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 10 Oct 2021 10:10:02 -0400
X-Greylist: delayed 332 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Oct 2021 10:10:01 EDT
Received: from [172.17.203.2] (port=53125 helo=deneb.enyo.de)
        by albireo.enyo.de ([172.17.140.2]) with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1mZZOs-0005i0-H2; Sun, 10 Oct 2021 14:02:02 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.94.2)
        (envelope-from <fw@deneb.enyo.de>)
        id 1mZZOs-0006bz-4t; Sun, 10 Oct 2021 16:02:02 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
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
Subject: Re: [RFC PATCH] LKMM: Add ctrl_dep() macro for control dependency
References: <20210928211507.20335-1-mathieu.desnoyers@efficios.com>
        <87lf3f7eh6.fsf@oldenburg.str.redhat.com>
        <20210929174146.GF22689@gate.crashing.org>
        <2088260319.47978.1633104808220.JavaMail.zimbra@efficios.com>
        <871r54ww2k.fsf@oldenburg.str.redhat.com>
        <CAHk-=wgexLqNnngLPts=wXrRcoP_XHO03iPJbsAg8HYuJbbAvw@mail.gmail.com>
Date:   Sun, 10 Oct 2021 16:02:02 +0200
In-Reply-To: <CAHk-=wgexLqNnngLPts=wXrRcoP_XHO03iPJbsAg8HYuJbbAvw@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 1 Oct 2021 09:35:47 -0700")
Message-ID: <87y271yo4l.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Linus Torvalds:

> On Fri, Oct 1, 2021 at 9:26 AM Florian Weimer <fweimer@redhat.com> wrote:
>>
>> Will any conditional branch do, or is it necessary that it depends in
>> some way on the data read?
>
> The condition needs to be dependent on the read.
>
> (Easy way to see it: if the read isn't related to the conditional or
> write data/address, the read could just be delayed to after the
> condition and the store had been done).

That entirely depends on how the hardware is specified to work.  And
the hardware could recognize certain patterns as always producing the
same condition codes, e.g., AND with zero.  Do such tests still count?
It depends on what the specification says.

What I really dislike about this: Operators like & and < now have side
effects, and is no longer possible to reason about arithmetic
expressions in isolation.
