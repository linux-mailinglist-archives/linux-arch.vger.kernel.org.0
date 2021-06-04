Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E74D39BC4F
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 17:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhFDP4c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 11:56:32 -0400
Received: from gate.crashing.org ([63.228.1.57]:35782 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229809AbhFDP4b (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 11:56:31 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 154FoTb5021396;
        Fri, 4 Jun 2021 10:50:29 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 154FoSDI021394;
        Fri, 4 Jun 2021 10:50:28 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 4 Jun 2021 10:50:28 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        paulmck@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, linux-kernel@vger.kernel.org,
        linux-toolchains@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <20210604155028.GF18427@gate.crashing.org>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net> <20210604104359.GE2318@willie-the-truck> <YLoPJDzlTsvpjFWt@hirez.programming.kicks-ass.net> <20210604134422.GA2793@willie-the-truck> <YLoxAOua/qsZXNmY@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLoxAOua/qsZXNmY@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 03:56:16PM +0200, Peter Zijlstra wrote:
> Urgh, I see. Compiler can't really help in that case either I'm afraid.
> They'll never want to modify loads that originate in an asm().

We never *can* change an asm template.  That is part of the fundamental
properties of inline asm.  We cannot even parse it!


Segher
