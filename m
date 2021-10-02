Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FD341FC86
	for <lists+linux-arch@lfdr.de>; Sat,  2 Oct 2021 16:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbhJBObV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 2 Oct 2021 10:31:21 -0400
Received: from netrider.rowland.org ([192.131.102.5]:59175 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S233372AbhJBObV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Oct 2021 10:31:21 -0400
Received: (qmail 533212 invoked by uid 1000); 2 Oct 2021 10:29:33 -0400
Date:   Sat, 2 Oct 2021 10:29:33 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        will@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        parri.andrea@gmail.com, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, linux-toolchains@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH] LKMM: Add ctrl_dep() macro for control dependency
Message-ID: <20211002142933.GA532982@rowland.harvard.edu>
References: <20210928211507.20335-1-mathieu.desnoyers@efficios.com>
 <20210929214703.GG22689@gate.crashing.org>
 <20210929235700.GF880162@paulmck-ThinkPad-P17-Gen-1>
 <20211001191008.GA16711@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001191008.GA16711@gate.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 01, 2021 at 02:10:08PM -0500, Segher Boessenkool wrote:
> Compilers understand you want exactly what you wrote.  If you write
> something other than what you want, you only will get what you want by
> pure luck.

The problem is that at times you _can't_ write what you want because the
language offers no way to express it.

Alan
