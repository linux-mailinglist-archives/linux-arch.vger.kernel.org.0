Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8C82CE785
	for <lists+linux-arch@lfdr.de>; Fri,  4 Dec 2020 06:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbgLDF1D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Dec 2020 00:27:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:48512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgLDF1D (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Dec 2020 00:27:03 -0500
From:   Andy Lutomirski <luto@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        X86 ML <x86@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
Subject: [RFC v2 0/2] lazy mm refcounting
Date:   Thu,  3 Dec 2020 21:26:15 -0800
Message-Id: <cover.1607059162.git.luto@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is part of a larger series here, but the beginning bit is irrelevant
to the current discussion:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/mm&id=203d39d11562575fd8bd6a094d97a3a332d8b265

This is IMO a lot better than v1.  It's now almost entirely in generic
code.  (It looks like it's 100% generic, but that's a lie -- the
generic code currently that all possible lazy mm refs are in
mm_cpumask(), and that's not true on all arches.  So, if we take my
approach, we'll need to have a little arch hook to control this.)

Here's how I think it fits with various arches:

x86: On bare metal (i.e. paravirt flush unavailable), the loop won't do
much.  The existing TLB shootdown when user tables are freed will
empty mm_cpumask of everything but the calling CPU.  So x86 ends up
pretty close to as good as we can get short of reworking mm_cpumask() itself.

arm64: It needs the fixup above for correctness, but I think performance
should be pretty good.  Compared to current kernels, we lose an mmgrab()
and mmdrop() on each lazy transition, and we add a reasonably fast loop
over all cpus on process exit.  Someone (probably me) needs to make
sure we don't need some extra barriers.

power: Similar to x86.

s390x: Should be essentially the same as arm64.

Other arches: I don't know.  Further research is required.

What do you all think?

Andy Lutomirski (2):
  [NEEDS HELP] x86/mm: Handle unlazying membarrier core sync in the arch
    code
  [MOCKUP] sched/mm: Lightweight lazy mm refcounting

 arch/x86/mm/tlb.c    |  17 +++++-
 kernel/fork.c        |   4 ++
 kernel/sched/core.c  | 134 +++++++++++++++++++++++++++++++++++++------
 kernel/sched/sched.h |  11 +++-
 4 files changed, 145 insertions(+), 21 deletions(-)

-- 
2.28.0

