Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C3B683177
	for <lists+linux-arch@lfdr.de>; Tue, 31 Jan 2023 16:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjAaP1K (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Jan 2023 10:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjAaP05 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Jan 2023 10:26:57 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6E6118;
        Tue, 31 Jan 2023 07:26:53 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4P5pCY4h1Vz9xFGX;
        Tue, 31 Jan 2023 23:01:13 +0800 (CST)
Received: from [10.45.157.21] (unknown [10.45.157.21])
        by APP1 (Coremail) with SMTP id LxC2BwDHTgrwLtlj32nhAA--.28633S2;
        Tue, 31 Jan 2023 16:08:46 +0100 (CET)
Message-ID: <2f121e2d-8e4c-de99-5672-93350fbb52af@huaweicloud.com>
Date:   Tue, 31 Jan 2023 16:08:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] locking/atomic: atomic: Use arch_atomic_{read,set} in
 generic atomic ops
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
        =?UTF-8?Q?Paul_Heidekr=c3=bcger?= <paul.heidekrueger@in.tum.de>,
        Marco Elver <elver@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
References: <20230126173354.13250-1-jmaselbas@kalray.eu>
 <Y9Oy9ZAj/DQ7O+6e@hirez.programming.kicks-ass.net>
 <20230127134946.GJ5952@tellis.lin.mbt.kalray.eu>
 <Y9Pg+aNM9f48SY5Z@hirez.programming.kicks-ass.net>
 <Y9RLpYGmzW1KPksE@boqun-archlinux>
 <2f4717b3-268f-8db3-e380-4af0a5479901@huaweicloud.com>
 <Y9gOjzGaWy2hIAmu@boqun-archlinux>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y9gOjzGaWy2hIAmu@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwDHTgrwLtlj32nhAA--.28633S2
X-Coremail-Antispam: 1UD129KBjvJXoW3CFW7Xr4xJFW7KF4fuFWUXFb_yoWDWF1DpF
        WxK3WfCF4DJrn2k34vyw4xWa4SkwsYyFy5Jr95Gw1kZ3s8WFyftF1fKa1Y9F98uw4xK34j
        qr4j9a4Dua4DZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
        WxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbJ73DUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 1/30/2023 7:38 PM, Boqun Feng wrote:
> On Mon, Jan 30, 2023 at 01:23:28PM +0100, Jonas Oberhauser wrote:
>>
>> On 1/27/2023 11:09 PM, Boqun Feng wrote:
>>> On Fri, Jan 27, 2023 at 03:34:33PM +0100, Peter Zijlstra wrote:
>>>>> I also noticed that GCC has some builtin/extension to do such things,
>>>>> __atomic_OP_fetch and __atomic_fetch_OP, but I do not know if this
>>>>> can be used in the kernel.
>>>> On a per-architecture basis only, the C/C++ memory model does not match
>>>> the Linux Kernel memory model so using the compiler to generate the
>>>> atomic ops is somewhat tricky and needs architecture audits.
>>> Hijack this thread a little bit, but while we are at it, do you think it
>>> makes sense that we have a config option that allows archs to
>>> implement LKMM atomics via C11 (volatile) atomics? I know there are gaps
>>> between two memory models, but the option is only for fallback/generic
>>> implementation so we can put extra barriers/orderings to make things
>>> guaranteed to work.
>> Another is that the C11 model is more about atomic locations than atomic
>> accesses, and there are several places in the kernel where a location is
>> accessed both atomically and non-atomically. This API mismatch is more
>> severe than the semantic differences in my opinion, since you don't have
>> guarantees of what the layout of atomics is going to be.
>>
> True, but the same problem for our asm implemented atomics, right? My
> plan is to do (volatile atomic_int *) casts on these locations.

Do you? I think LKMM atomic types are always exactly as big as the 
underlying types.
With C you might get into a case where the atomic_int is actually [lock 
; non-atomic int] and when you access the location in a mixed way, you 
will non-atomically read the lock part but the atomic accesses modify 
the int part (protected by the lock).

>
>> Perhaps you could instead rely on the compiler builtins? Note that this may
> These are less formal/defined to me, and not much research on them I
> assume, I'd rather not use them.

I think that it's easy enough to define a formal model of these that is 
a bit conservative, and then just add mb()s to make them safe.

>
>> invalidate some progress properties, e.g., ticket locks become unfair if the
>> increment (for taking a ticket) is implemented with a CAS loop (because a
>> thread can fail forever to get a ticket if the ticket counter is contended,
>> and thus starve). There may be some linux atomics that don't map to any
>> compiler builtins and need to implemented with such CAS loops, potentially
>> leading to such problems.
>>
>> I'm also curious whether link time optimization can resolve the inlining
>> issue?
>>
> For Rust case, cross-language LTO is needed I think, and last time I
> tried, it didn't work.

In German we say "Was noch nicht ist kann ja noch werden", translated as 
"what isn't can yet become", I don't feel like putting too much effort 
into something that hardly affects performance and will hopefully become 
obsolete at some point in the near future.

>
>> I think another big question for me is to which extent it makes sense
>> anyways to have shared memory concurrency between the Rust code and the C
>> code. It seems all the bad concurrency stuff from the C world would flow
>> into the Rust world, right?
> What do you mean by "bad" ;-) ;-) ;-)

Uh oh. Let's pretend I didn't say anything :D

>> If you can live without shared Rust & C concurrency, then perhaps you can
>> get away without using LKMM in Rust at all, and just rely on its (C11-like)
>> memory model internally and talk to the C code through synchronous, safer
>> ways.
>>
> First I don't think I can avoid using LKMM in Rust, besides the
> communication from two sides, what if kernel developers just want to
> use the memory model they learn and understand (i.e. LKMM) in a new Rust
> driver?

I'd rather people think 10 times before relying on atomics to write Rust 
code.
There may be cases where it can't be avoided because of performance 
reasons, but Rust has a much more convenient concurrency model to offer 
than atomics.
I think a lot more people understand Rust mutexes or channels compared 
to atomics.
Unfortunately I haven't written much driver code so I don't have 
experience to what extent it's generally necessary to rely on atomics :(


> They probably already have a working parallel algorithm based on
> LKMM.
>
> Further, let's say we make C and Rust talk without shared memory
> concurrency, what would that be? Will it more defined/formal the LKMM?

Normal FFI with sequential shared memory (passing a buffer sequentially 
through FFI)?

> How's the cost if we use synchronous ways? I personally think there are
> places in core kernel where Rust can be tried, whatever the mechanism is
> used, it cannot sarcrifed.

Note that if you turn a C atomics-based implementation into a Rust 
atomics-based implementation, you'll probably need some unsafe when you 
"consume" the data synchronized through atomics (Sebastian Humenda and 
Jonathan Schwender explained this to me recently), and any memory safety 
bugs coming from that unsafe part can be due to incorrect use of the 
atomics in the rest of the algorithm. So you don't really gain much 
memory safety compared to the C implementation.

Hopefully you can write a small safe Rust API around your mechanism, and 
then constrain its possibly unsafe atomics use inside the library.
But the motivation for porting that mechanism to Rust atomics rather 
than relying on FFI is low for me.

>> I'm not against having a fallback builtin-based implementation of LKMM, and
>> I don't think that it really needs architecture audits. What it needs is
> Fun fact, there exist some "optimizations" that don't generate the asm
> code as you want:
>
> 	https://github.com/llvm/llvm-project/issues/56450
>
> Needless to say, they are bugs, and will be fixed, besides making atomic
> volatile seems to avoid these "optimizations"


Haha. Reminds me of a similar issue with failed CAS, which are usually 
only reads but are considered to write back the same value in some 
papers, leading to some incorrect results.


>> some additional compiler barriers and memory barriers, to ensure that the
>> arguments about dependencies and non-atomics still hold. E.g., a release
>> store may not just be "builtin release store" but may need to have a
>> compiler barrier to prevent the release store being moved in program order.
>> And a "full barrier" exchange may need an mb() infront of the operation to
>> avoid "roach motel ordering" (i.e.,  x=1 ; "full barrier exchange"; y = 1
>> allows y=1 to execute before x=1 in the compiler builtins as far as I
>> remember). And there may be some other cases like this.
>>
> Agreed. And this is another reason I want to do it: I'm curious about
> how far C11 memory model and LKMM are different, and whether there is a
> way to implement one by another, what are the gaps (theorical and
> pratical), whether the ordering we have in LKMM can be implemented by
> compilers (mostly dependencies).


I could imagine you'll find lots of differences, starting from SC 
ordering, dependencies, local ordering of barriers, propagation...
I generally categorize memory models in 4 tiers:
- po | rfe | coe | fre is acyclic  (SC)
- ppo | rfe | coe | fre is acyclic (Arm, x86)
- ppo | rfe | pb is acyclic (LKMM, Power)
- synchronize-with | po is acyclic (C11)

Just structurally, C11 and LKMM are extremely different. Because C11 has 
no notion of ppo, barriers have no local ordering effect. Only globally 
when matched with another barrier on another thread.
Bridging this gap will be hard!


> More importantly, we could improve both
> to get something better? With the ability to exactly express the
> programmers' intention yet still allow optimization by the compilers.


In my humble opinion, programmers shouldn't have the intention of 
relying on dependency ordering :D
I've had a few times people ask me if some barrier could be relaxed due 
to dependency ordering, and I've said "I honestly don't care if it can 
be relaxed until there's some evidence it improves performance".
And I haven't yet seen any convincing evidence that relying on a 
dependency rather than an acquire improves end-to-end performance, which 
isn't surprising considering the hardware optimizations for acquire. 
(But we also haven't measured on PowerPC, where perhaps the lwsync might 
be a tad more expensive).

Nevertheless, ruling out OOTA has some nice practical properties for 
verification methodology.
I think most of the potential improvement is in identifying the cases in 
which compilers won't eliminate dependencies, and showing that this 
covers all the ones that are necessary to rule out OOTA. Namely the ones 
in which the store might be observed by other threads, and the values of 
the read that lead to this store being produced can only come from 
specific stores of other threads.
And then C can follow Viktor's suggestion to just explicitly rule out 
OOTA, without any concrete explanation of how (and without making 
dependencies provide order beyond that).

That said, for a huge code base like Linux where some code just *does* 
rely on dependency ordering, you can't go and kick out that ordering 
from the model. That's why I think it's important to keep it in LKMM, 
but not necessarily add it to C.


>> But I currently don't see that this implementation would be noticeably
>> faster than paying the overhead of lack of inline.
>>
> You are not wrong, surely we will need to real benchmark to know. But my
> rationale is 1) in theory this is faster, 2) we also get a chance to try
> out code based on LKMM with C11 atomics to see where it hurts. Therefore
> I asked ;-)

I think one beautiful thing about open source is that nobody can stop 
you from trying it out yourself :D
It's currently not something I would personally put resources into though.
You could pick a DPDK or CK algorithm and port it to a version using FFI 
instead of using atomics directly, and measure the impact on some 
microbenchmarks.
Then consider that the end-to-end impact on Linux will probably be at 
least one or two orders of magnitude less.

Have fun, jonas

