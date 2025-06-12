Return-Path: <linux-arch+bounces-12329-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B36AAD7540
	for <lists+linux-arch@lfdr.de>; Thu, 12 Jun 2025 17:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854883B832E
	for <lists+linux-arch@lfdr.de>; Thu, 12 Jun 2025 15:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1019C24A07A;
	Thu, 12 Jun 2025 15:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-bs.de header.i=@tu-bs.de header.b="tyyE0jJs"
X-Original-To: linux-arch@vger.kernel.org
Received: from pmxout2.rz.tu-bs.de (pmxout2.rz.tu-bs.de [134.169.4.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AA726E717;
	Thu, 12 Jun 2025 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.169.4.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749740672; cv=none; b=MoAvK02sbobyISrcHbk/pvzVUPVxRpaj8Amo8U1i97yRs1xg9SSVQrCj7WMymh2Vy5XSudFMkETysFUAlkAHZWZssaU8PQ/uwwN81nHx9bkY9fHaRaytde+cy34phFAywTXsfPFaG6jGsLJHytCvxwG5mfn8la0YZimNgKSW/ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749740672; c=relaxed/simple;
	bh=M7psreqtd7qDN8w7ZaJtjjjh4GKXKbz1dQhsMZmx/og=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=QcuiCwBRWTkrrEZUD1F1eTNRWE0ZxpnOwSgnUdK1sBAtbPkKNOIojO1QFz9nV0u3UVcXoUBqb/VkdJ4MtYbpxta9aU6zfwt4mlhm3mkQZTMGmy2yU/NOSm9Tf/d1gzhCz0KeeD9bbc7D/X0pok8br9FiRWkv1Tv0FLlaPPBsH0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-bs.de; spf=pass smtp.mailfrom=tu-braunschweig.de; dkim=pass (2048-bit key) header.d=tu-bs.de header.i=@tu-bs.de header.b=tyyE0jJs; arc=none smtp.client-ip=134.169.4.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-bs.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-braunschweig.de
Received: from Hermes02.ad.tu-bs.de (hermes02.rz.tu-bs.de [134.169.4.130])
	by pmxout2.rz.tu-bs.de (Postfix) with ESMTPS id F34534E05E6;
	Thu, 12 Jun 2025 16:55:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-bs.de;
	s=exchange_neu; t=1749740130;
	bh=M7psreqtd7qDN8w7ZaJtjjjh4GKXKbz1dQhsMZmx/og=;
	h=Date:To:CC:From:Subject:From;
	b=tyyE0jJs1A8u58jMiVSNqeCpSVDjFl8CRZag/xvAwHfg+CJuZ/WwaJdz6YiZqCFZk
	 F//1n1T0H5JrpbUwn4L1rwVDO6GH9MwG0YyBwFyROHL4QdximACap6HYWbIWTD9i9q
	 KEwkiU92QtLs8dIuMojO+IPmRWANncU2YUkI3n2whuy7YAn6doQ13v3JPo3Iumpl8c
	 m20Q5xjjUiQZtA//C8yF3H+6P2NvtNcyn2yXn+GQAshDfxLz7wPbDJDFfAd4OkKJ91
	 27iO3VxYd+LnDO7m3d8uCU70kRXuOe6+9bpvz9loJU6WKqBYCzhQcL9sUYmnvmQ5mQ
	 xdCu4b92Vmz3w==
Received: from [192.168.178.25] (134.169.9.110) by Hermes02.ad.tu-bs.de
 (134.169.4.130) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 12 Jun
 2025 16:55:29 +0200
Message-ID: <cb83e3e4-9e22-4457-bf61-5614cc4396ad@tu-bs.de>
Date: Thu, 12 Jun 2025 16:55:28 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Alan Stern <stern@rowland.harvard.edu>, Andrea Parri
	<parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin
	<npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave
	<j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E.
 McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel
 Lustig <dlustig@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<lkmm@lists.linux.dev>
CC: <hernan.poncedeleon@huaweicloud.com>, <jonas.oberhauser@huaweicloud.com>,
	"r.maseli@tu-bs.de" <r.maseli@tu-bs.de>
From: Thomas Haas <t.haas@tu-bs.de>
Subject: [RFC] Potential problem in qspinlock due to mixed-size accesses
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: Hermes02.ad.tu-bs.de (134.169.4.130) To
 Hermes02.ad.tu-bs.de (134.169.4.130)

We have been taking a look if mixed-size accesses (MSA) can affect the 
correctness of qspinlock.
We are focusing on aarch64 which is the only memory model with MSA 
support [1].
For this we extended the dartagnan [2] tool to support MSA and now it 
reports liveness, synchronization, and mutex issues.
Notice that we did something similar in the past for LKMM, but we were 
ignoring MSA [3].

The culprit of all these issues is that atomicity of single load 
instructions is not guaranteed in the presence of smaller-sized stores 
(observed on real hardware according to [1] and Fig. 21/22)
Consider the following pseudo code:

     int16 old = xchg16_rlx(&lock, 42);
     int32 l = load32_acq(&lock);

Then the hardware can treat the code as (likely due to store-forwarding)

     int16 old = xchg16_rlx(&lock, 42);
     int16 l1 = load16_acq(&lock);
     int16 l2 = load16_acq(&lock + 2); // Assuming byte-precise pointer 
arithmetic

and reorder it to

     int16 l2 = load16_acq(&lock + 2);
     int16 old = xchg16_rlx(&lock, 42);
     int16 l1 = load16_acq(&lock);

Now another thread can overwrite "lock" in between the first two 
accesses so that the original l (l1 and l2) ends up containing
parts of a lock value that is older than what the xchg observed.

Let us now explain how this can break qspinlock.
We need 3 threads going the slowpath, T1, T2, and T3.
T1 is a setup-thread that takes the lock just so that T2 and T3 observe 
contention and try to enqueue themselves.
So consider a situation where
     - T3's node is the only enqueued node (due to previous contention 
with T1).
     - T2 is about to enqueue its node.
     - T3 is about to take the lock because it sees no contention (lock 
is free, no pending bits are set, it has the only node in the queue).
     - the lock is released (T1 is already done)

We focus on the following lines of code in qspinlock.c:

         // <- T2 is here, but executes part of line 328 first.
         277: old = xchg_tail(lock, tail);    // ~ xchg_rlx(&lock->tail, 
tail)
         // ...
         328: val = atomic_cond_read_acquire(&lock->val, !(VAL & 
_Q_LOCKED_PENDING_MASK));
         // ...
         // <- T3 is here
         352: if ((val & _Q_TAIL_MASK) == tail) {
                     if (atomic_try_cmpxchg_relaxed(&lock->val, &val, 
_Q_LOCKED_VAL))
                         goto release; /* No contention */
         355: }


Then the following sequence of operations is problematic:

(1) T2 reads half of the lock (the half that is not lock->tail, i.e., it 
"only" reads lock->lock_pending)

         328: val = atomic_cond_read_acquire(&lock->val, !(VAL & 
_Q_LOCKED_PENDING_MASK)); // P1
         // Roughly: val_lock_pending = load_acquire(&lock->lock_pending);

      T2 observes a free lock and no pending bits set.

(2) T3 takes the lock because it does not observe contention

         352: if ((val & _Q_TAIL_MASK) == tail) {  // Satisfied because 
only T3's node is enqueued and lock is free
                     if (atomic_try_cmpxchg_relaxed(&lock->val, &val, 
_Q_LOCKED_VAL))
                         goto release; /* No contention */
         355: }

     T3 clears the tail and claims the lock. The queue is empty now.

(3) T2 enqueues itself

         277: old = xchg_tail(lock, tail);

     T2 sees an empty queue (old == 0) because T3 just cleared it, and 
enqueues its node.

(4) T2 reads the remaining half of the lock from (1), reading the tail 
(lock->tail) it just inserted.

         328: val = atomic_cond_read_acquire(&lock->val, !(VAL & 
_Q_LOCKED_PENDING_MASK)); // P2
         // Roughly: val_tail = load_acquire(&lock->tail);

     T2 observes its own tail + lock is free and no pending bits are set 
(from (1))


Now there are two continuations, one leading to broken synchronisation, 
another leading to non-termination or failure of mutual exclusion.
We first consider the synchronisation issue.


(5a) T3 finishes its critical section and releases the lock


(6a) T2 takes the lock with the same code as in point (2):

          352: if ((val & _Q_TAIL_MASK) == tail) {     // Satisfied 
because only T2's node is enqueued and lock is free
                     if (atomic_try_cmpxchg_relaxed(&lock->val, &val, 
_Q_LOCKED_VAL))
                         goto release; /* No contention */
          355: }

       Notice that the "atomic_try_cmpxchg_relaxed" would fail if the 
lock was still taken by T3, because "val" has no lock bits set (as T2 
observed the lock to be free).
       Although T2 now properly enters the CS after T3 has finished, the 
synchronisation is broken since T2 did not perform an acquire operation 
to synchronise with the lock release.
       Indeed, dartagnan reports no safety violations (with 3 threads) 
if the CAS is made an acquire or the CS itself contains an acquire 
barrier (smb_rmb or smb_mb).


Now, let's consider the alternative continuation that leads to 
non-termination or failure of mutual exclusion.


(5b) T2 tries to take the lock as above in (6a) but the CAS fails 
because the lock is still taken by T3.


(6b) Due to the failing CAS, T2 observes contention (at least it thinks 
so). It sets the lock (although T3 might still have it!) and waits until 
the (non-existent) "contending thread" enqueues its node:

         /*
          * Either somebody is queued behind us or _Q_PENDING_VAL got set
          * which will then detect the remaining tail and queue behind us
          * ensuring we'll see a @next.
          */
         362: set_locked(lock);

         /*
          * contended path; wait for next if not observed yet, release.
          */
         367: if (!next)
         368:    next = smp_cond_load_relaxed(&node->next, (VAL));


   The first comment suggests that the assumed situation is that either 
another thread enqueued a node or the pending bits got set. But neither is
   true in the current execution: we got here because the lock was taken.
   Now there are two outcomes:
     - Non-termination: the "smp_cond_load_relaxed" waits forever, 
because there is no other thread that enqueues another node.
     - Broken mutex: another thread (T4) enqueues a node and therefore 
releases T2 from its loop. Now T2 enters the CS while T3 still executes 
its CS.
        Indeed, dartagnan reports this safety violation only with 4+ 
threads.


NOTE: For the above examples we forced all threads to take the slowpath 
of qspinlock by removing the fastpath. With the fastpath present, 
another thread (T0) is needed to force the other threads into the 
slowpath, i.e., we need 4-5 threads to witness the issues.

### Solutions

The problematic executions rely on the fact that T2 can move half of its 
load operation (1) to before the xchg_tail (3).
Preventing this reordering solves all issues. Possible solutions are:
     - make the xchg_tail full-sized (i.e, also touch lock/pending bits).
       Note that if the kernel is configured with >= 16k cpus, then the 
tail becomes larger than 16 bits and needs to be encoded in parts of the 
pending byte as well.
       In this case, the kernel makes a full-sized (32-bit) access for 
the xchg. So the above bugs are only present in the < 16k cpus setting.
     - make the xchg_tail an acquire operation.
     - make the xchg_tail a release operation (this is an odd solution 
by itself but works for aarch64 because it preserves REL->ACQ ordering). 
In this case, maybe the preceding "smp_wmb()" can be removed.
     - put some other read-read barrier between the xchg_tail and the load.


### Implications for qspinlock executed on non-ARM architectures.

Unfortunately, there are no MSA extensions for other hardware memory 
models, so we have to speculate based on whether the problematic 
reordering is permitted if the problematic load was treated as two 
individual instructions.
It seems Power and RISCV would have no problem reordering the 
instructions, so qspinlock might also break on those architectures.
TSO, on the other hand, does not permit such reordering. Also, the 
xchg_tail is a rmw operation which acts like a full memory barrier under 
TSO, so even if load-load reordering was permitted, the rmw would 
prevent this.


[1] https://dl.acm.org/doi/10.1145/3458926
[2] https://github.com/hernanponcedeleon/Dat3M
[3] https://lkml.org/lkml/2022/8/26/597

-- 
=====================================

Thomas Haas

Technische Universität Braunschweig
Institut für Theoretische Informatik
Mühlenpfordtstr. 23, Raum IZ 343
38106 Braunschweig | Germany

t.haas@tu-braunschweig.de
https://www.tu-braunschweig.de/tcs/team/thomas-haas


