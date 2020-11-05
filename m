Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216982A896F
	for <lists+linux-arch@lfdr.de>; Thu,  5 Nov 2020 23:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732713AbgKEWAq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Nov 2020 17:00:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:58398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732619AbgKEWAY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 5 Nov 2020 17:00:24 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 071B522227;
        Thu,  5 Nov 2020 22:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604613622;
        bh=Ng62cOiykOA1O87FhmHYbHcgoeckhlkjpnfL1YKeKrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=thJGSwKULHSwtcrvSFZSm9IHGjC3eUfefwaylhlBSYAo/z2xmgpIk2dXk/yuybHUB
         yW9P+rKPi2T9qikPGhMP8nwRNInsZllySLf5VwaQVFW/SQy9tBNLxa5HLUZqZOejQM
         fMaFiyO7ByfPzUAqKqHa4MFsr8fCgQDoWlk9L02I=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 5/8] tools/memory-model: Add a glossary of LKMM terms
Date:   Thu,  5 Nov 2020 14:00:14 -0800
Message-Id: <20201105220017.15410-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105215953.GA15309@paulmck-ThinkPad-P72>
References: <20201105215953.GA15309@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/glossary.txt | 155 ++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)
 create mode 100644 tools/memory-model/Documentation/glossary.txt

diff --git a/tools/memory-model/Documentation/glossary.txt b/tools/memory-model/Documentation/glossary.txt
new file mode 100644
index 0000000..036fa28
--- /dev/null
+++ b/tools/memory-model/Documentation/glossary.txt
@@ -0,0 +1,155 @@
+This document contains brief definitions of LKMM-related terms.  Like most
+glossaries, it is not intended to be read front to back (except perhaps
+as a way of confirming a diagnosis of OCD), but rather to be searched
+for specific terms.
+
+
+Address Dependency:  When the address of a later memory access is computed
+	based on the value returned by an earlier load, an "address
+	dependency" extends from that load extending to the later access.
+	Address dependencies are quite common in RCU read-side critical
+	sections:
+
+	 1 rcu_read_lock();
+	 2 p = rcu_dereference(gp);
+	 3 do_something(p->a);
+	 4 rcu_read_unlock();
+
+	 In this case, because the address of "p->a" on line 3 is computed
+	 from the value returned by the rcu_dereference() on line 2, the
+	 address dependency extends from that rcu_dereference() to that
+	 "p->a".  In rare cases, optimizing compilers can destroy address
+	 dependencies.	Please see Documentation/RCU/rcu_dereference.txt
+	 for more information.
+
+	 See also "Control Dependency".
+
+Acquire:  With respect to a lock, acquiring that lock, for example,
+	using spin_lock().  With respect to a non-lock shared variable,
+	a special operation that includes a load and which orders that
+	load before later memory references running on that same CPU.
+	An example special acquire operation is smp_load_acquire(),
+	but atomic_read_acquire() and atomic_xchg_acquire() also include
+	acquire loads.
+
+	When an acquire load returns the value stored by a release store
+	to that same variable, then all operations preceding that store
+	happen before any operations following that load acquire.
+
+	See also "Relaxed" and "Release".
+
+Coherence (co):  When one CPU's store to a given variable overwrites
+	either the value from another CPU's store or some later value,
+	there is said to be a coherence link from the second CPU to
+	the first.
+
+	It is also possible to have a coherence link within a CPU, which
+	is a "coherence internal" (coi) link.  The term "coherence
+	external" (coe) link is used when it is necessary to exclude
+	the coi case.
+
+	See also "From-reads" and "Reads-from".
+
+Control Dependency:  When a later store's execution depends on a test
+	of a value computed from a value returned by an earlier load,
+	a "control dependency" extends from that load to that store.
+	For example:
+
+	 1 if (READ_ONCE(x))
+	 2   WRITE_ONCE(y, 1);
+
+	 Here, the control dependency extends from the READ_ONCE() on
+	 line 1 to the WRITE_ONCE() on line 2.	Control dependencies are
+	 fragile, and can be easily destroyed by optimizing compilers.
+	 Please see control-dependencies.txt for more information.
+
+	 See also "Address Dependency".
+
+Cycle:	Memory-barrier pairing is restricted to a pair of CPUs, as the
+	name suggests.	And in a great many cases, a pair of CPUs is all
+	that is required.  In other cases, the notion of pairing must be
+	extended to additional CPUs, and the result is called a "cycle".
+	In a cycle, each CPU's ordering interacts with that of the next:
+
+	CPU 0                CPU 1                CPU 2                      
+	WRITE_ONCE(x, 1);    WRITE_ONCE(y, 1);    WRITE_ONCE(z, 1);
+	smp_mb();            smp_mb();            smp_mb();
+	r0 = READ_ONCE(y);   r1 = READ_ONCE(z);   r2 = READ_ONCE(x);
+
+	CPU 0's smp_mb() interacts with that of CPU 1, which interacts
+	with that of CPU 2, which in turn interacts with that of CPU 0
+	to complete the cycle.	Because of the smp_mb() calls between
+	each pair of memory accesses, the outcome where r0, r1, and r2
+	are all equal to zero is forbidden by LKMM.
+
+	See also "Pairing".
+
+From-Reads (fr):  When one CPU's store to a given variable happened
+	too late to affect the value returned by another CPU's
+	load from that same variable, there is said to be a from-reads
+	link from the load to the store.
+
+	It is also possible to have a from-reads link within a CPU, which
+	is a "from-reads internal" (fri) link.  The term "from-reads
+	external" (fre) link is used when it is necessary to exclude
+	the fri case.
+
+	See also "Coherence" and "Reads-from".
+
+Fully Ordered:  An operation such as smp_mb() that orders all of
+	its CPU's prior accesses with all of that CPU's subsequent
+	accesses, or a marked access such as atomic_add_return()
+	that orders all of its CPU's prior accesses, itself, and
+	all of its CPU's subsequent accesses.
+
+Marked Access:  An access to a variable that uses an special function or
+	macro such as "r1 = READ_ONCE()" or "smp_store_release(&a, 1)".
+
+	See also "Unmarked Access".
+
+Pairing: "Memory-barrier pairing" reflects the fact that synchronizing
+	data between two CPUs requires that both CPUs their accesses.
+	Memory barriers thus tend to come in pairs, one executed by
+	one of the CPUs and the other by the other CPU.  Of course,
+	pairing also occurs with other types of operations, so that a
+	smp_store_release() pairs with an smp_load_acquire() that reads
+	the value stored.
+
+	See also "Cycle".
+
+Reads-From (rf):  When one CPU's load returns the value stored by some other
+	CPU, there is said to be a reads-from link from the second
+	CPU's store to the first CPU's load.  Reads-from links have the
+	nice property that time must advance from the store to the load,
+	which means that algorithms using reads-from links can use lighter
+	weight ordering and synchronization compared to algorithms using
+	coherence and from-reads links.
+
+	It is also possible to have a reads-from link within a CPU, which
+	is a "reads-from internal" (rfi) link.	The term "reads-from
+	external" (rfe) link is used when it is necessary to exclude
+	the rfi case.
+
+	See also Coherence" and "From-reads".
+
+Relaxed:  A marked access that does not imply ordering, for example, a
+	READ_ONCE(), WRITE_ONCE(), a non-value-returning read-modify-write
+	operation, or a value-returning read-modify-write operation whose
+	name ends in "_relaxed".
+
+	See also "Acquire" and "Release".
+
+Release:  With respect to a lock, releasing that lock, for example,
+	using spin_unlock().  With respect to a non-lock shared variable,
+	a special operation that includes a store and which orders that
+	store after earlier memory references that ran on that same CPU.
+	An example special release store is smp_store_release(), but
+	atomic_set_release() and atomic_cmpxchg_release() also include
+	release stores.
+
+	See also "Acquire" and "Relaxed".
+
+Unmarked Access:  An access to a variable that uses normal C-language
+	syntax, for example, "a = b[2]";
+
+	See also "Marked Access".
-- 
2.9.5

