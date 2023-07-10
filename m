Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5B874D913
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jul 2023 16:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbjGJOdk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 10:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGJOdj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 10:33:39 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED766F2;
        Mon, 10 Jul 2023 07:33:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4R05n06lh5z9xFQh;
        Mon, 10 Jul 2023 22:22:28 +0800 (CST)
Received: from [10.81.201.45] (unknown [10.81.201.45])
        by APP2 (Coremail) with SMTP id GxC2BwCnVz6VFqxk3ZpTBA--.64987S2;
        Mon, 10 Jul 2023 15:33:09 +0100 (CET)
Message-ID: <75caf089-be17-a518-6efa-bd17d96d4451@huaweicloud.com>
Date:   Mon, 10 Jul 2023 16:32:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC] Bridging the gap between the Linux Kernel Memory
 Consistency Model (LKMM) and C11/C++11 atomics
To:     Olivier Dion <odion@efficios.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rnk@google.com, Alan Stern <stern@rowland.harvard.edu>,
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
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        gcc@gcc.gnu.org, llvm@lists.linux.dev
References: <87ttukdcow.fsf@laura>
 <357752c2-4fb0-708e-4b05-564e37a234be@huaweicloud.com> <87y1jrfxbp.fsf@laura>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <87y1jrfxbp.fsf@laura>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwCnVz6VFqxk3ZpTBA--.64987S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AryxWr48Ww18tF45CF17Jrb_yoW3JrWrpF
        WYk3Wvkw1ktwn7Z3WkA3W7Z3y3AayrJ3y5JF95Kr18Aw1Ygw1xKr4xKrW5uFZrJrs7Jw12
        qr4jywnru3WUZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU13rcDUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Am 7/7/2023 um 7:25 PM schrieb Olivier Dion:
> On Fri, 07 Jul 2023, Jonas Oberhauser <jonas.oberhauser@huaweicloud.com> wrote:
> [...]
>>> This is a request for comments on extending the atomic builtins API to
>>> help avoiding redundant memory barriers.  Indeed, there are
>>> discrepancies between the Linux kernel consistency memory model (LKMM)
>>> and the C11/C++11 memory consistency model [0].  For example,
>>> fully-ordered atomic operations like xchg and cmpxchg success in LKMM
>>> have implicit memory barriers before/after the operations [1-2], while
>>> atomic operations using the __ATOMIC_SEQ_CST memory order in C11/C++11
>>> do not have any ordering guarantees of an atomic thread fence
>>> __ATOMIC_SEQ_CST with respect to other non-SEQ_CST operations [3].
>>
>> The issues run quite a bit deeper than this. The two models have two
>> completely different perspectives that are quite much incompatible.
> Agreed.  Our intent is not to close the gap completely, but to reduce
> the gap between the two models, by supporting the "full barrier
> before/after" semantic of LKMM in the C11/C++11 memory model.


I think what you're trying to achieve has nothing to do with the gap at 
all. (But do check out the IMM paper https://plv.mpi-sws.org/imm/ for 
what is involved in bridging the gap between LKMM-like and C11-like models).

What you're trying to achieve is to certify some urcu algorithms, 
without making the code unnecessarily slower.
Your problem is that the algorithm is implemented using the LKMM API, 
and you want to check it with a tool (TSAN) meant to (dynamically) 
analyze C11 code that relies on a subset of C11's memory model.

What I still don't understand is whether using TSAN as-is is a formal 
requirement from the certification you are trying to achieve, or whether 
you could either slightly modify the TSAN toolchain to give answers 
consistent with the behavior on LKMM, or use a completely different tool.

For example, you could eliminate the worry about the unnecessary 
barriers by including the extra barriers only in the TSAN' (modified 
TSAN) analysis.
In that case TSAN' adds additional, redundant barriers in some cases 
during the analysis process, but those barriers would be gone the moment 
you stop using TSAN'.

You would need to argue that this additional instrumentation doesn't 
hide any data races, but I suspect that wouldn't be too hard.

Another possibility is to use a tool like Dat3M that supports LKMM to 
try and verify your code, but I'm not sure if these tools are 
feature-complete enough to verify the specific algorithms you have in 
mind (e.g., mixed-size accesses are an issue, and Paul told me there's a 
few of those in (U)RCU. But maybe the cost of changing the code to 
full-sized accesses might be cheaper than relying on extra barriers.)


FWIW your current solution of adding a whole class of fences to 
essentially C11 and the toolchain, and modifying the code to use these 
fences, isn't a way I would want to take.


>> I think all you can really do is bridge the gap at the level of the
>> generated assembly.  I.e., don't bridge the gap between LKMM and the
>> C11 MCM. Bridge the gap between the assembly code generated by C11
>> atomics and the one generated by LKMM. But I'm not sure that's really
>> the task here.
> [...]
> However, nothing prevents a toolchain from changing the emitted
> assembler in the future, which would make things fragile.  The only
> thing that is guaranteed to not change is the definitions in the
> standard (C11/C++11).  Anything else is fair game for optimizations.

Not quite. If you rely on the LKMM API to generate the final code, you 
can definitely prove that the LKMM API implementation has a C11-like 
memory model abstraction.
For example, you might be able to prove that the LKMM implementation of 
a strong xchg guarantees at least the same ordering as a seq_cst fence ; 
seq_cst xchg ; seq_cst fence sequence in C11.
I don't think it's that fragile since 1) it's a manually written 
volatile assembler mapping, so there's not really a lot the toolchains 
can do about it and 2) the LKMM implementation of atomics rarely 
changes, and should still have similar guarantees after the change.

The main issue will be as we discussed before and below that TSAN will 
still trigger false positives.


>>> [...] For example, to make Read-Modify-Write (RMW) operations match
>>> the Linux kernel "full barrier before/after" semantics, the liburcu's
>>> uatomic API has to emit both a SEQ_CST RMW operation and a subsequent
>>> thread fence SEQ_CST, which leads to duplicated barriers in some cases.
>> Does it have to though? Can't you just do e.g. an release RMW
>> operation followed by an after_atomic  fence?  And for loads, a
>> SEQ_CST fence followed by an acquire load? Analogously (but: mirrored)
>> for stores.
> That would not improve anything for RMW.  Consider the following example
> and its resulting assembler on x86-64 gcc 13.1 -O2:
>
> 	int exchange(int *x, int y)
> 	{
> 		int r = __atomic_exchange_n(x, y, __ATOMIC_RELEASE);
> 		__atomic_thread_fence(__ATOMIC_SEQ_CST);
>
> 		return r;
> 	}
>
>          exchange:
> 	       	movl    %esi, %eax
> 	       	xchgl   (%rdi), %eax
> 	       	lock orq $0, (%rsp) ;; Redundant with previous exchange
>         		ret


I specifically meant the after_atomic fence from LKMM, which will 
compile to nothing on x86 (not even a compiler barrier).
However, at that point I also wasn't clear on what you're trying to 
achieve. I see now that using LKMM barriers doesn't help you here.



>> You mentioned that the goal is to check some code written using LKMM
>> primitives with TSAN due to some formal requirements. What exactly do
>> these requirements entail? Do you need to check the code exactly as it
>> will be executed (modulo the TSAN instrumentation)? Is it an option to
>> map to normal builtins with suboptimal performance just for the
>> verification purpose, but then run the slightly more optimized
>> original code later?
> We aim to validate with TSAN the code that will run during production,
> minus TSAN itself.
>
>> Specifically for TSAN's ordering requirements, you may need to make
>> LKMM's RMWs into acq+rel with an extra mb, even if all that extra
>> ordering isn't necessary at the assembler level.
>>
>>
>> Also note that no matter what you do, due to the two different
>> perspectives, TSAN's hb relation may introduce false positive data
>> races w.r.t. LKMM.  For example, if the happens-before ordering is
>> guaranteed through pb starting with coe/fre.
> This is why we have implemented our primitives and changed our
> algorithms so that they use the acquire/release semantics of the
> C11/C++11 memory model.
>
>> Without thinking too hard, it seems to me no matter what fences and
>> barriers you introduce, TSAN will not see this kind of ordering and
>> consider the situation a data race.
> We have come to the same conclusion, mainly because TSAN does not
> support thread fence in its verifications.

That's also a concern (although I thought they fixed that a year or two 
ago, but I must be mistaken).

What I mean is that even if TSAN appropriately used all fences for 
hb-analysis, and even if you added strong fences all over your code, 
there are (as far as I can see) still cases where TSAN will tell you 
there's a data race (on C11) but there isn't one on LKMM.


good luck

jonas

