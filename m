Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC247259EF3
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 21:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgIATIr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 15:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgIATIq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 15:08:46 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D89BC061244;
        Tue,  1 Sep 2020 12:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lAEF16Y7hbBT4eu86EXXZSLR75YbGx6Vr2GM79NERmk=; b=1uphIErQeCBiKEiiWPf6ob4E/d
        Dkcaf4xig5oOYejDV/HrxTzmcbXWYhfeNn/8XEaYrotA1HZpoP2PxDNdG9YZZ4uq4juK8D3z1cKir
        CFtfSvv75IWC6t69whf1ByKmJSXxFGW6oVo9eHr2FOk9xp8RYOoMpnZdC223ztaxp9fyylSznpdt4
        kukumAHay0Q1R6Aa5T7jVnvP7E2/N/X4EPx/XA/kYFFnyyvGwshOy65B1BuSv7PsLyvLRhHnWIEs+
        7mU/cT5hhzpgYHJQw7SBlS7AVn4VDgNLP9wotofmNFANSbc1yPs8Npll3RYhT9Bzyh8A5xRcrZj+o
        VOeDRRkw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDBdb-0000oV-Jo; Tue, 01 Sep 2020 19:08:11 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5DFC998046E; Tue,  1 Sep 2020 21:08:08 +0200 (CEST)
Date:   Tue, 1 Sep 2020 21:08:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, rostedt@goodmis.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, cameron@moodycamel.com,
        oleg@redhat.com, will@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH v5 00/21] kprobes: Unify kretprobe trampoline handlers
 and make kretprobe lockless
Message-ID: <20200901190808.GK29142@worktop.programming.kicks-ass.net>
References: <159870598914.1229682.15230803449082078353.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159870598914.1229682.15230803449082078353.stgit@devnote2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Aug 29, 2020 at 09:59:49PM +0900, Masami Hiramatsu wrote:
> Masami Hiramatsu (16):
>       kprobes: Add generic kretprobe trampoline handler
>       x86/kprobes: Use generic kretprobe trampoline handler
>       arm: kprobes: Use generic kretprobe trampoline handler
>       arm64: kprobes: Use generic kretprobe trampoline handler
>       arc: kprobes: Use generic kretprobe trampoline handler
>       csky: kprobes: Use generic kretprobe trampoline handler
>       ia64: kprobes: Use generic kretprobe trampoline handler
>       mips: kprobes: Use generic kretprobe trampoline handler
>       parisc: kprobes: Use generic kretprobe trampoline handler
>       powerpc: kprobes: Use generic kretprobe trampoline handler
>       s390: kprobes: Use generic kretprobe trampoline handler
>       sh: kprobes: Use generic kretprobe trampoline handler
>       sparc: kprobes: Use generic kretprobe trampoline handler
>       kprobes: Remove NMI context check
>       kprobes: Free kretprobe_instance with rcu callback
>       kprobes: Make local used functions static
> 
> Peter Zijlstra (5):
>       llist: Add nonatomic __llist_add() and __llist_dell_all()
>       kprobes: Remove kretprobe hash
>       asm-generic/atomic: Add try_cmpxchg() fallbacks
>       freelist: Lock less freelist
>       kprobes: Replace rp->free_instance with freelist

This looks good to me, do you want me to merge them through -tip? If so,
do we want to try and get them in this release still?

Ingo, opinions? This basically fixes a regression cauesd by

  0d00449c7a28 ("x86: Replace ist_enter() with nmi_enter()")

