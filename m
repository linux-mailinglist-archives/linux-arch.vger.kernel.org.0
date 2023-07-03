Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB5E746342
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jul 2023 21:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjGCTUh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jul 2023 15:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjGCTUg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jul 2023 15:20:36 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEC9B3;
        Mon,  3 Jul 2023 12:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1688412032;
        bh=jxOPC/016rQUAJ86KvUUTABuWnm3gI0d4EZfOSGzCFk=;
        h=From:To:Subject:CC:Date:From;
        b=s5FuGTcKspu2++8NQH160HpqnQCHAYrcb2I+glO8d8scigkZ2+GbT65uxfFgR9ZZr
         B19kqv0q+TGRkO7t4ziFtbDiLFW3crb/uGagZ/KoR9hWuwq9SzOGVe5c2FiKRkwTyc
         BMh221izOxoI5Fbr24MXfDQJ4c8zl4bKveKGhioNBVnoZ1w1S0GAlD/v0UdVmjH0NV
         uxYm5EQcr1o4v5Z5XM6EUzTay22tfIHxPFRRLSXkkebUFlFuBGAFk4kIMQ689F7GfR
         xRIFQXaBZFlTlsCpmYLgL3v8Tys18V/jod6chxuwWFlKwzCJrMhGwN6maYK09pule4
         aX2Pra0aHTHBw==
Received: from localhost (modemcable094.169-200-24.mc.videotron.ca [24.200.169.94])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Qvwk80Z1Fz1G3J;
        Mon,  3 Jul 2023 15:20:32 -0400 (EDT)
From:   Olivier Dion <odion@efficios.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, rnk@google.com,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Subject: [RFC] Bridging the gap between the Linux Kernel Memory Consistency
 Model (LKMM) and C11/C++11 atomics
Organization: EfficiOS
CC:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        gcc@gcc.gnu.org, llvm@lists.linux.dev
Date:   Mon, 03 Jul 2023 15:20:31 -0400
Message-ID: <87ttukdcow.fsf@laura>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

This is a request for comments on extending the atomic builtins API to
help avoiding redundant memory barriers.  Indeed, there are
discrepancies between the Linux kernel consistency memory model (LKMM)
and the C11/C++11 memory consistency model [0].  For example,
fully-ordered atomic operations like xchg and cmpxchg success in LKMM
have implicit memory barriers before/after the operations [1-2], while
atomic operations using the __ATOMIC_SEQ_CST memory order in C11/C++11
do not have any ordering guarantees of an atomic thread fence
__ATOMIC_SEQ_CST with respect to other non-SEQ_CST operations [3].

For a little bit of context here, we are porting liburcu [4] to atomic
builtins.  Before that, liburcu was using its own implementation for
atomic operations and its CMM memory consistency model was mimicking the
LKMM.  liburcu is now extending its CMM memory consistency model to
become close to the C11/C++11 memory consistency model, with the
exception of the extra SEQ_CST_FENCE memory order that is similar to
SEQ_CST, but ensure that a thread fence is emitted.  This is necessary
for backward compatibility of the liburcu uatomic API, but also for
closing the gap between the LKMM and the C11/C+11 memory consistency
model.  For example, to make Read-Modify-Write (RMW) operations match
the Linux kernel "full barrier before/after" semantics, the liburcu's
uatomic API has to emit both a SEQ_CST RMW operation and a subsequent
thread fence SEQ_CST, which leads to duplicated barriers in some cases.

Consider for example the following Dekker and the resulting assemblers
generated:

  int x = 0;
  int y = 0;
  int r0, r1;

  int dummy;

  void t0(void)
  {
          __atomic_store_n(&x, 1, __ATOMIC_RELAXED);

          __atomic_exchange_n(&dummy, 1, __ATOMIC_SEQ_CST);
          __atomic_thread_fence(__ATOMIC_SEQ_CST);

          r0 = __atomic_load_n(&y, __ATOMIC_RELAXED);
  }

  void t1(void)
  {
          __atomic_store_n(&y, 1, __ATOMIC_RELAXED);
          __atomic_thread_fence(__ATOMIC_SEQ_CST);
          r1 = __atomic_load_n(&x, __ATOMIC_RELAXED);
  }

  // BUG_ON(r0 == 0 && r1 == 0)

On x86-64 (gcc 13.1 -O2) we get:

  t0():
          movl    $1, x(%rip)
          movl    $1, %eax
          xchgl   dummy(%rip), %eax
          lock orq $0, (%rsp)       ;; Redundant with previous exchange.
          movl    y(%rip), %eax
          movl    %eax, r0(%rip)
          ret
  t1():
          movl    $1, y(%rip)
          lock orq $0, (%rsp)
          movl    x(%rip), %eax
          movl    %eax, r1(%rip)
          ret

On x86-64 (clang 16 -O2) we get:

  t0():
          movl    $1, x(%rip)
          movl    $1, %eax
          xchgl   %eax, dummy(%rip)
          mfence                    ;; Redundant with previous exchange.
          movl    y(%rip), %eax
          movl    %eax, r0(%rip)
          retq
  t1():
          movl    $1, y(%rip)
          mfence
          movl    x(%rip), %eax
          movl    %eax, r1(%rip)
          retq

On armv8-a (gcc 13.1 -O2) we get:

  t0():
          adrp    x0, .LANCHOR0
          mov     w1, 1
          add     x0, x0, :lo12:.LANCHOR0
          str     w1, [x0]
          add     x1, x0, 4
          mov     w2, 1
  .L3:
          ldaxr   w3, [x1]
          stlxr   w4, w2, [x1]
          cbnz    w4, .L3
          dmb     ish                   ;; Okay!
          add     x1, x0, 8
          ldr     w1, [x1]
          str     w1, [x0, 12]
          ret
  t1():
          adrp    x0, .LANCHOR0
          add     x0, x0, :lo12:.LANCHOR0
          add     x1, x0, 8
          mov     w2, 1
          str     w2, [x1]
          dmb     ish
          ldr     w1, [x0]
          str     w1, [x0, 16]
          ret

On armv8.1-a (gcc 13.1 -O2) we get:

  t0():
          adrp    x0, .LANCHOR0
          mov     w1, 1
          add     x0, x0, :lo12:.LANCHOR0
          str     w1, [x0]
          add     x2, x0, 4
          swpal   w1, w1, [x2]
          dmb     ish                   ;; Okay!
          add     x1, x0, 8
          ldr     w1, [x1]
          str     w1, [x0, 12]
          ret
  t1():
          adrp    x0, .LANCHOR0
          add     x0, x0, :lo12:.LANCHOR0
          add     x1, x0, 8
          mov     w2,p 1
          str     w2, [x1]
          dmb     ish
          ldr     w1, [x0]
          str     w1, [x0, 16]
          ret

For the initial transition to the atomic builtins in liburcu, we plan on
emitting memory barriers to ensure correctness at the expense of
performance.  However, new primitives in the atomic builtins API would
help avoiding the redundant thread fences.

Indeed, eliminating redundant memory fences is often done in the Linux
kernel.  For example in kernel/sched/core.c:try_to_wake_up():

  /*
   * smp_mb__after_spinlock() provides the equivalent of a full memory
   * barrier between program-order earlier lock acquisitions and
   * program-order later memory accesses.
   * ...
   * Since most load-store architectures implement ACQUIRE with an
   * smp_mb() after the LL/SC loop, they need no further barriers.
   * Similarly all our TSO architectures imply an smp_mb() for each
   * atomic instruction and equally don't need more.
   */
  raw_spin_lock_irqsave(&p->pi_lock, flags);
  smp_mb__after_spinlock();

Therefore, we propose to add the following primitives to the atomic
builtins API:

  __atomic_thread_fence_before_load(int load_memorder, int fence_memorder)
  __atomic_thread_fence_after_load(int load_memorder, int fence_memorder)

  __atomic_thread_fence_before_store(int store_memorder, int fence_memorder)
  __atomic_thread_fence_after_store(int store_memorder, int fence_memorder)

  __atomic_thread_fence_before_clear(int clear_memorder, int fence_memorder)
  __atomic_thread_fence_after_clear(int clear_memorder, int fence_memorder)

  __atomic_thread_fence_before_rmw(int rmw_memorder, int fence_memorder)
  __atomic_thread_fence_after_rmw(int rmw_memorder, int fence_memorder)

All primitives follow the template:

  __atomic_thread_fence_{before|after}_<operation>(int OM, int FM)

Depending on the implementation of <operation> with memory order OM, a
thread fence may be emitted {before|after} with memory order FM.  The
`rmw' operation is an umbrella term for all operations which does a RMW
sequence for keeping the proposal short.  More primitives could be
added, allowing greater flexibility for the toolchains in their
implementation.

In the previous Dekker, t0() can now be re-written as:

  void t0(void)
  {
          __atomic_store_n(&x, 1, __ATOMIC_RELAXED);

          __atomic_exchange_n(&dummy, 1, __ATOMIC_SEQ_CST);
          __atomic_thread_fence_after_rmw(__ATOMIC_SEQ_CST,
                                          __ATOMIC_SEQ_CST);

          r0 = __atomic_load_n(&y, __ATOMIC_RELAXED);
  }

because the exchange has a memory order of SEQ_CST and we want a thread
fence with memory order SEQ_CST after the operation.

Finally, here is what we could expect for some architectures:

On x86-64 we would have (based on gcc 13.1 [5]):

  // Always emit thread fence.
  __atomic_thread_fence_{before,after}_load(int load_memorder,
                                            int fence_memorder)

  // NOP for store_memorder == SEQ_CST.
  // Otherwise, emit thread fence.
  __atomic_thread_fence_{before,after}_store(int store_memorder,
                                             int fence_memorder)

   // NOP for clear_memorder == SEQ_CST.
   // Otherwise, emit thread fence.
  __atomic_thread_fence_{before,after}_clear(int clear_memorder,
                                             int fence_memorder)

   // Always NOP.
  __atomic_thread_fence_{before,after}_rmw(int rmw_memorder,
                                           int fence_memorder)

On aarch64 we would have (based on gcc 13.1 [6]):

  // Always emit thread fence.
  __atomic_thread_fence_{before,after}_load(int load_memorder,
                                            int fence_memorder)

  // Always emit thread fence.
  __atomic_thread_fence_{before,after}_store(int store_memorder,
                                             int fence_memorder)

  // Always emit thread fence.
  __atomic_thread_fence_{before,after}_clear(int clear_memorder,
                                             int fence_memorder)

  // Always emit thread fence.
  __atomic_thread_fence_{before,after}_rmw(int rmw_memorder,
                                           int fence_memorder)

NOTE: On x86-64, we found at least one corner case [7] with Clang where
a RELEASE exchange is optimized to a RELEASE store, when the returned
value of the exchange is unused, breaking the above expectations.
Although this type of optimization respect the standard "as-if"
statement, we question its pertinence since a user should simply do a
RELEASE store instead of an exchange in that case.  With the
introduction of these new primitives, these type of optimizations should
be revisited.

NOTE 2: You can test the Dekker -- without the memory barrier in t0() --
in CppMem [8] with this code [9] to see that r0 == 0 && r1 == 0 is
possible.  The exchange is replaced by a store in this example because
the tool does not support exchange.

 [0] https://www.open-std.org/JTC1/SC22/WG21/docs/papers/2020/p0124r7.html#So%20You%20Want%20Your%20Arch%20To%20Use%20C11%20Atomics...

 [1] Linux kernel Documentation/atomic_t.txt

 [2] Linux kernel Documentation/memory-barriers.txt

 [3] https://en.cppreference.com/w/c/atomic/memory_order#Sequentially-consistent_ordering

 [4] https://liburcu.org

 [5] https://godbolt.org/z/ch1j3bW93

  Reproduce with x86-64 gcc 13.1 -O2:
--8<---------------cut here---------------start------------->8---
int load_relaxed(int *x)
{
        return __atomic_load_n(x, __ATOMIC_RELAXED);
}

int load_consume(int *x)
{
        return __atomic_load_n(x, __ATOMIC_CONSUME);
}

int load_acquire(int *x)
{
        return __atomic_load_n(x, __ATOMIC_ACQUIRE);
}

int load_seq_cst(int *x)
{
        return __atomic_load_n(x, __ATOMIC_SEQ_CST);
}

void store_relaxed(int *x, int y)
{
        __atomic_store_n(x, y, __ATOMIC_RELAXED);
}

void store_release(int *x, int y)
{
        __atomic_store_n(x, y, __ATOMIC_RELEASE);
}

void store_seq_cst(int *x, int y)
{
        __atomic_store_n(x, y, __ATOMIC_SEQ_CST);
}

void clear_relaxed(char *x)
{
        __atomic_clear(x, __ATOMIC_RELAXED);
}

void clear_release(char *x)
{
        __atomic_clear(x, __ATOMIC_RELEASE);
}

void clear_seq_cst(char *x)
{
        __atomic_clear(x, __ATOMIC_SEQ_CST);
}

int exchange_relaxed(int *x, int y)
{
        return __atomic_exchange_n(x, y, __ATOMIC_RELAXED);
}

int exchange_consume(int *x, int y)
{
        return __atomic_exchange_n(x, y, __ATOMIC_CONSUME);
}

int exchange_acquire(int *x, int y)
{
        return __atomic_exchange_n(x, y, __ATOMIC_ACQUIRE);
}

int exchange_release(int *x, int y)
{
        return __atomic_exchange_n(x, y, __ATOMIC_RELEASE);
}

int exchange_acq_rel(int *x, int y)
{
        return __atomic_exchange_n(x, y, __ATOMIC_ACQ_REL);
}

int exchange_seq_cst(int *x, int y)
{
        return __atomic_exchange_n(x, y, __ATOMIC_SEQ_CST);
}
--8<---------------cut here---------------end--------------->8---

 [6] https://godbolt.org/z/WT4qj636b

  Reproduce with ARM64 gcc 13.1.0 -O2 -march=armv8.1-a:
--8<---------------cut here---------------start------------->8---
int load_relaxed(int *x)
{
        return __atomic_load_n(x, __ATOMIC_RELAXED);
}

int load_consume(int *x)
{
        return __atomic_load_n(x, __ATOMIC_CONSUME);
}

int load_acquire(int *x)
{
        return __atomic_load_n(x, __ATOMIC_ACQUIRE);
}

int load_seq_cst(int *x)
{
        return __atomic_load_n(x, __ATOMIC_SEQ_CST);
}

void store_relaxed(int *x, int y)
{
        __atomic_store_n(x, y, __ATOMIC_RELAXED);
}

void store_release(int *x, int y)
{
        __atomic_store_n(x, y, __ATOMIC_RELEASE);
}

void store_seq_cst(int *x, int y)
{
        __atomic_store_n(x, y, __ATOMIC_SEQ_CST);
}

void clear_relaxed(char *x)
{
        __atomic_clear(x, __ATOMIC_RELAXED);
}

void clear_release(char *x)
{
        __atomic_clear(x, __ATOMIC_RELEASE);
}

void clear_seq_cst(char *x)
{
        __atomic_clear(x, __ATOMIC_SEQ_CST);
}

int exchange_relaxed(int *x, int y)
{
        return __atomic_exchange_n(x, y, __ATOMIC_RELAXED);
}

int exchange_consume(int *x, int y)
{
        return __atomic_exchange_n(x, y, __ATOMIC_CONSUME);
}

int exchange_acquire(int *x, int y)
{
        return __atomic_exchange_n(x, y, __ATOMIC_ACQUIRE);
}

int exchange_release(int *x, int y)
{
        return __atomic_exchange_n(x, y, __ATOMIC_RELEASE);
}

int exchange_acq_rel(int *x, int y)
{
        return __atomic_exchange_n(x, y, __ATOMIC_ACQ_REL);
}

int exchange_seq_cst(int *x, int y)
{
        return __atomic_exchange_n(x, y, __ATOMIC_SEQ_CST);
}
--8<---------------cut here---------------end--------------->8---

 [7] https://godbolt.org/z/ssvbr9qvE

  Reproduce with x86-64 clang 16.0.0 -O2:
--8<---------------cut here---------------start------------->8---
void exchange_release_no_return(int *x, int y)
{
        __atomic_exchange_n(x, y, __ATOMIC_RELEASE);
}

int exchange_release(int *x, int y)
{
        return __atomic_exchange_n(x, y, __ATOMIC_RELEASE);
}
--8<---------------cut here---------------end--------------->8---

 [8] http://svr-pes20-cppmem.cl.cam.ac.uk/cppmem/

 [9]:
--8<---------------cut here---------------start------------->8---
int main()
{
        atomic_int x=0;
        atomic_int y=0;
        atomic_int dummy=0;

        {{{
                {
                        x.store(1, memory_order_relaxed);
                        // CPPMem does not support exchange.
                        dummy.store(1, memory_order_seq_cst);
                        r0 = y.load(memory_order_relaxed);
                }

                |||

                {
                        y.store(1, memory_order_relaxed);
                        atomic_thread_fence(memory_order_seq_cst);
                        r1 = x.load(memory_order_relaxed);
                }
        }}}

        return 0;
}
--8<---------------cut here---------------end--------------->8---
-- 
Olivier Dion
EfficiOS Inc.
https://www.efficios.com

