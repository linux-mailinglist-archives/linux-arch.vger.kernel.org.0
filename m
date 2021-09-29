Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C0341CB37
	for <lists+linux-arch@lfdr.de>; Wed, 29 Sep 2021 19:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245180AbhI2RtX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Sep 2021 13:49:23 -0400
Received: from gate.crashing.org ([63.228.1.57]:47517 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245131AbhI2RtX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Sep 2021 13:49:23 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 18THfmdA001474;
        Wed, 29 Sep 2021 12:41:48 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 18THfk9G001468;
        Wed, 29 Sep 2021 12:41:46 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 29 Sep 2021 12:41:46 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        will@kernel.org, paulmck@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stern@rowland.harvard.edu, parri.andrea@gmail.com,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        linux-toolchains@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH] LKMM: Add ctrl_dep() macro for control dependency
Message-ID: <20210929174146.GF22689@gate.crashing.org>
References: <20210928211507.20335-1-mathieu.desnoyers@efficios.com> <87lf3f7eh6.fsf@oldenburg.str.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lf3f7eh6.fsf@oldenburg.str.redhat.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi!

On Wed, Sep 29, 2021 at 02:28:37PM +0200, Florian Weimer wrote:
> If you need a specific instruction emitted, you need a compiler
> intrinsic or inline assembly.

Not an intrinsic.  Builtins (like almost all other code) do not say
"generate this particular machine code", they say "generate code that
does <this>".  That is one reason why builtins are more powerful than
inline assembler (another related reason is that they tell the compiler
exactly what behaviour is expected).

> I don't think it's possible to piggy-back this on something else.

Unless we get a description of what this does in term of language
semantics (instead of generated machine code), there is no hope, even.


Segher
