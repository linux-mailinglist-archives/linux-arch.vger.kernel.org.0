Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D2842E109
	for <lists+linux-arch@lfdr.de>; Thu, 14 Oct 2021 20:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbhJNSWR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Oct 2021 14:22:17 -0400
Received: from albireo.enyo.de ([37.24.231.21]:44202 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231777AbhJNSWQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 Oct 2021 14:22:16 -0400
Received: from [172.17.203.2] (port=43549 helo=deneb.enyo.de)
        by albireo.enyo.de ([172.17.140.2]) with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1mb5Kd-00012e-4b; Thu, 14 Oct 2021 18:19:55 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.94.2)
        (envelope-from <fw@deneb.enyo.de>)
        id 1mb5Kc-000oEC-R6; Thu, 14 Oct 2021 20:19:54 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Subject: Re: [RFC PATCH] LKMM: Add ctrl_dep() macro for control dependency
References: <20210928211507.20335-1-mathieu.desnoyers@efficios.com>
        <87lf3f7eh6.fsf@oldenburg.str.redhat.com>
        <20210929174146.GF22689@gate.crashing.org>
        <2088260319.47978.1633104808220.JavaMail.zimbra@efficios.com>
        <871r54ww2k.fsf@oldenburg.str.redhat.com>
        <CAHk-=wgexLqNnngLPts=wXrRcoP_XHO03iPJbsAg8HYuJbbAvw@mail.gmail.com>
        <87y271yo4l.fsf@mid.deneb.enyo.de>
        <20211014000104.GX880162@paulmck-ThinkPad-P17-Gen-1>
        <87lf2v61k7.fsf@mid.deneb.enyo.de>
        <20211014162311.GD880162@paulmck-ThinkPad-P17-Gen-1>
Date:   Thu, 14 Oct 2021 20:19:54 +0200
In-Reply-To: <20211014162311.GD880162@paulmck-ThinkPad-P17-Gen-1> (Paul
        E. McKenney's message of "Thu, 14 Oct 2021 09:23:11 -0700")
Message-ID: <87o87r4gfp.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Paul E. McKenney:

>> > Yes, I know, we for sure have conflicting constraints on "reasonable"
>> > on copy on this email.  What else is new?  ;-)
>> >
>> > I could imagine a tag of some sort on the load and store, linking the
>> > operations that needed to be ordered.  You would also want that same
>> > tag on any conditional operators along the way?  Or would the presence
>> > of the tags on the load and store suffice?
>> 
>> If the load is assigned to a local variable whose address is not taken
>> and which is only assigned this once, it could be used to label the
>> store.  Then the compiler checks if all paths from the load to the
>> store feature a condition that depends on the local variable (where
>> qualifying conditions probably depend on the architecture).  If it
>> can't prove that is the case, it emits a fake no-op condition that
>> triggers the hardware barrier.  This formulation has the advantage
>> that it does not add side effects to operators like <.  It even
>> generalizes to different barrier-implying instructions besides
>> conditional branches.
>
> So something like this?
>
> 	tagvar = READ_ONCE(a);
> 	if (tagvar)
> 		WRITE_ONCE_COND(b, 1, tagvar);

Yes, something like that.  The syntax only makes sense if tagvar is
assigned only once (statically).

> (This seems to me to be an eminently reasonable syntax.)
>
> Or did I miss a turn in there somewhere?

The important bit is that the compiler emits the extra condition when
necessary, and the information in the snippet above seems to provide
enough information to optimize it away in principle, when it's safe.
This assumes that we can actually come up with a concrete model what
triggers the hardware barrier, of course.  For example, if tagvar is
spilled to the stack, is it still possible to apply an effective
condition to it after it is loaded from the stack?  If not, then the
compiler would have to put in a barrier before spilling tagvar if it
is used in any WRITE_ONCE_COND statement.
