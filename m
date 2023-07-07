Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0322E74AED6
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jul 2023 12:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjGGKks (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jul 2023 06:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGGKkp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jul 2023 06:40:45 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CD3172B;
        Fri,  7 Jul 2023 03:40:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Qy8lq1cCpz9v7Ys;
        Fri,  7 Jul 2023 18:29:43 +0800 (CST)
Received: from [10.81.205.205] (unknown [10.81.205.205])
        by APP1 (Coremail) with SMTP id LxC2BwBn7gmH66dk1qY5BA--.59757S2;
        Fri, 07 Jul 2023 11:40:19 +0100 (CET)
Message-ID: <357752c2-4fb0-708e-4b05-564e37a234be@huaweicloud.com>
Date:   Fri, 7 Jul 2023 12:40:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
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
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <87ttukdcow.fsf@laura>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBn7gmH66dk1qY5BA--.59757S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw15tr4xKFy5GrWruF45Wrg_yoWrXr4UpF
        W8KFy8Kw1kGrn7Zw1kAa1DC3yruan5tay5WFy8Ar1UCw1ag3WIvr47KrZ0vrZrAF4kJw1j
        qrs0v3W3W34DJFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,


Am 7/3/2023 um 9:20 PM schrieb Olivier Dion:
> Hi all,
>
> This is a request for comments on extending the atomic builtins API to
> help avoiding redundant memory barriers.  Indeed, there are
> discrepancies between the Linux kernel consistency memory model (LKMM)
> and the C11/C++11 memory consistency model [0].  For example,
> fully-ordered atomic operations like xchg and cmpxchg success in LKMM
> have implicit memory barriers before/after the operations [1-2], while
> atomic operations using the __ATOMIC_SEQ_CST memory order in C11/C++11
> do not have any ordering guarantees of an atomic thread fence
> __ATOMIC_SEQ_CST with respect to other non-SEQ_CST operations [3].


The issues run quite a bit deeper than this. The two models have two 
completely different perspectives that are quite much incompatible.
I think all you can really do is bridge the gap at the level of the 
generated assembly.
I.e., don't bridge the gap between LKMM and the C11 MCM. Bridge the gap 
between the assembly code generated by C11 atomics and the one generated 
by LKMM. But I'm not sure that's really the task here.


>
> [...] For example, to make Read-Modify-Write (RMW) operations match
> the Linux kernel "full barrier before/after" semantics, the liburcu's
> uatomic API has to emit both a SEQ_CST RMW operation and a subsequent
> thread fence SEQ_CST, which leads to duplicated barriers in some cases.


Does it have to though? Can't you just do e.g. an release RMW operation 
followed by an after_atomic  fence?
And for loads, a SEQ_CST fence followed by an acquire load? Analogously 
(but: mirrored) for stores.



>    // Always emit thread fence.
>    __atomic_thread_fence_{before,after}_load(int load_memorder,
>                                              int fence_memorder)
>
>    // NOP for store_memorder == SEQ_CST.
>    // Otherwise, emit thread fence.
>    __atomic_thread_fence_{before,after}_store(int store_memorder,
>                                               int fence_memorder)
>
>     // NOP for clear_memorder == SEQ_CST.
>     // Otherwise, emit thread fence.
>    __atomic_thread_fence_{before,after}_clear(int clear_memorder,
>                                               int fence_memorder)
>
>     // Always NOP.
>    __atomic_thread_fence_{before,after}_rmw(int rmw_memorder,
>                                             int fence_memorder)


I currently don't feel comfortable adding such extensions to LKMM (or a 
compiler API for that matter).


You mentioned that the goal is to check some code written using LKMM 
primitives with TSAN due to some formal requirements. What exactly do 
these requirements entail? Do you need to check the code exactly as it 
will be executed (modulo the TSAN instrumentation)? Is it an option to 
map to normal builtins with suboptimal performance just for the 
verification purpose, but then run the slightly more optimized original 
code later?

Specifically for TSAN's ordering requirements, you may need to make 
LKMM's RMWs into acq+rel with an extra mb, even if all that extra 
ordering isn't necessary at the assembler level.


Also note that no matter what you do, due to the two different 
perspectives, TSAN's hb relation may introduce false positive data races 
w.r.t. LKMM.  For example, if the happens-before ordering is guaranteed 
through pb starting with coe/fre.

Without thinking too hard, it seems to me no matter what fences and 
barriers you introduce, TSAN will not see this kind of ordering and 
consider the situation a data race.

(And at least in our own verification methodology for rcu/smr, ordering 
through fre appears when the rscs reads something that is later 
overwritten by the writer. Not sure off the top of my head if this fre 
ordering is what prevents the data race though, or there's some 
additional ordering that TSAN may also detect.

As a side note, according to LKMM we would also have data races in our 
critical sections, but I believe use of rcu_dereference would fix that, 
so you may not experience such data races in your code).


best wishes,
jonas

