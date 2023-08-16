Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FE077E399
	for <lists+linux-arch@lfdr.de>; Wed, 16 Aug 2023 16:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343584AbjHPObO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Aug 2023 10:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343627AbjHPObB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Aug 2023 10:31:01 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF5426A1;
        Wed, 16 Aug 2023 07:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1692196256;
        bh=hgoPYYIe9xRFO6KCoQOHP/vx3O7LK2flG9gZgBby4f8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bbpIM0Vim8X5cbMr7E24CZlesvlPLjSo7iv7NkLrJggQ5a3L+Oy+heLs/jVjeIKQv
         GrrG/+Vf29lJyJZi0Nxo4MOZUZdeiMrsEzuMnfWyG+qAMh+EO9/DWhTF+NhYSYOSoL
         0ACbfUnZUP24/uQJpFCR0v5dNoT0VXgh7OBt6tVTo+LaBO9WcpUsguT2CeToPEVeBI
         VO1VBLG+bHHZJyJQSCDBd48+mA9VTqfzeI9IowAVPfwq3fR7I9MDgFaci2q+EypAHC
         MTjEI4EoqZcKq9sc2zi/zsYaQ/Ujlo6quiUopBEKQ+okPf1Q/000ZwUGQNqqSzjiQ+
         PSKzxOIh/CdRA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RQrCg5w8Mz1LRf;
        Wed, 16 Aug 2023 10:30:55 -0400 (EDT)
Message-ID: <4f8e3429-e0aa-6146-055a-6b20f546ade6@efficios.com>
Date:   Wed, 16 Aug 2023 10:31:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC] Bridging the gap between the Linux Kernel Memory
 Consistency Model (LKMM) and C11/C++11 atomics
Content-Language: en-US
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        Olivier Dion <odion@efficios.com>, rnk@google.com,
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
        Tom Rix <trix@redhat.com>,
        =?UTF-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        gcc@gcc.gnu.org, llvm@lists.linux.dev
References: <87ttukdcow.fsf@laura>
 <357752c2-4fb0-708e-4b05-564e37a234be@huaweicloud.com> <87y1jrfxbp.fsf@laura>
 <75caf089-be17-a518-6efa-bd17d96d4451@huaweicloud.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <75caf089-be17-a518-6efa-bd17d96d4451@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/10/23 10:32, Jonas Oberhauser wrote:
> 
> Am 7/7/2023 um 7:25 PM schrieb Olivier Dion:
>> On Fri, 07 Jul 2023, Jonas Oberhauser 
>> <jonas.oberhauser@huaweicloud.com> wrote:
>> [...]
>>>> This is a request for comments on extending the atomic builtins API to
>>>> help avoiding redundant memory barriers.  Indeed, there are
>>>> discrepancies between the Linux kernel consistency memory model (LKMM)
>>>> and the C11/C++11 memory consistency model [0].  For example,
>>>> fully-ordered atomic operations like xchg and cmpxchg success in LKMM
>>>> have implicit memory barriers before/after the operations [1-2], while
>>>> atomic operations using the __ATOMIC_SEQ_CST memory order in C11/C++11
>>>> do not have any ordering guarantees of an atomic thread fence
>>>> __ATOMIC_SEQ_CST with respect to other non-SEQ_CST operations [3].
>>>
>>> The issues run quite a bit deeper than this. The two models have two
>>> completely different perspectives that are quite much incompatible.
>> Agreed.  Our intent is not to close the gap completely, but to reduce
>> the gap between the two models, by supporting the "full barrier
>> before/after" semantic of LKMM in the C11/C++11 memory model.
> 

Hi Jonas,

> 
> I think what you're trying to achieve has nothing to do with the gap at 
> all. (But do check out the IMM paper https://plv.mpi-sws.org/imm/ for 
> what is involved in bridging the gap between LKMM-like and C11-like 
> models).
> 
> What you're trying to achieve is to certify some urcu algorithms, 
> without making the code unnecessarily slower.

You are correct. Ideally we also want to move away from maintaining our
own implementation of atomic operations in liburcu and just rely on
compiler atomic builtins to reduce overall complexity.

> Your problem is that the algorithm is implemented using the LKMM API, 
> and you want to check it with a tool (TSAN) meant to (dynamically) 
> analyze C11 code that relies on a subset of C11's memory model.

There are two aspects to this:

1) The first aspect is with respect to the implementation of liburcu per
se. We have recently implemented changes to the liburcu master branch
which add support for C11 atomics and modify the liburcu algorithms to
add all hb relationships needed to make TSAN understand liburcu's RCU
and lock-free data structures implementation.

2) The second aspect is maintaining compatibility of a public API for
external users of liburcu. This is the main part that hurts when users
are building liburcu using the new "--enable-compiler-atomic-builtins"
configure option, because external users relying on LKMM style
atomic operations will observe a performance degradation due to those
duplicated barriers. This is the main target of the proposal discussed
here.

> 
> What I still don't understand is whether using TSAN as-is is a formal 
> requirement from the certification you are trying to achieve, or whether 
> you could either slightly modify the TSAN toolchain to give answers 
> consistent with the behavior on LKMM, or use a completely different tool.

Our requirement comes from ISC for their use of liburcu as a dependency
of the BIND9 DNS server. They use TSAN to validate BIND9, and asked us
to work on making liburcu's implementation understood by TSAN.

In our evaluation, the most direct route towards this goal was to
implement liburcu atomics in terms of C11 atomics, and adapt liburcu
algorithms to express hb relationships (e.g. release/acquire) in terms
of C11 where they were unclear.

This effort has various benefits, including:

- Add ability to validate liburcu's implementation and use with TSAN,
- Self-document liburcu's code by clearly expressing hb relationships,
- Reduce overall complexity by using C11 atomics rather than maintaining
   custom assembler for each supported architecture.

> 
> For example, you could eliminate the worry about the unnecessary 
> barriers by including the extra barriers only in the TSAN' (modified 
> TSAN) analysis.
> In that case TSAN' adds additional, redundant barriers in some cases 
> during the analysis process, but those barriers would be gone the moment 
> you stop using TSAN'.
> 
> You would need to argue that this additional instrumentation doesn't 
> hide any data races, but I suspect that wouldn't be too hard.

We have made the changes to liburcu that were needed to make TSAN happy,
and in order to make sure we let it keep track of hb relationships
within the liburcu implementation, this involved introducing
release/acquire relationship semantic in the code. I prefer this
fine-grained approach to the big hammer of adding extra TSAN barriers
because the latter approach prevents TSAN from having a deep
understanding of the hb relationships (AFAIU it can introduce
false-negatives).

> 
> Another possibility is to use a tool like Dat3M that supports LKMM to 
> try and verify your code, but I'm not sure if these tools are 
> feature-complete enough to verify the specific algorithms you have in 
> mind (e.g., mixed-size accesses are an issue, and Paul told me there's a 
> few of those in (U)RCU. But maybe the cost of changing the code to 
> full-sized accesses might be cheaper than relying on extra barriers.)

Our requirement to use TSAN comes from real-world users (BIND9), so
this is part of the problem statement. Extending TSAN (if needed) to
better understand liburcu would also be an option, but so far we have
not seen any need to do so.

> 
> FWIW your current solution of adding a whole class of fences to 
> essentially C11 and the toolchain, and modifying the code to use these 
> fences, isn't a way I would want to take.

I suspect the alternative there is to emit the duplicated fences (as
we currently do) and wait for the compiler to eventually do a better
job at eliminating those. It's good to receive the input from the
community on this topic, and this RFC is mainly a way to raise
awareness.

> 
> 
>>> I think all you can really do is bridge the gap at the level of the
>>> generated assembly.  I.e., don't bridge the gap between LKMM and the
>>> C11 MCM. Bridge the gap between the assembly code generated by C11
>>> atomics and the one generated by LKMM. But I'm not sure that's really
>>> the task here.
>> [...]
>> However, nothing prevents a toolchain from changing the emitted
>> assembler in the future, which would make things fragile.  The only
>> thing that is guaranteed to not change is the definitions in the
>> standard (C11/C++11).  Anything else is fair game for optimizations.
> 
> Not quite. If you rely on the LKMM API to generate the final code, you 
> can definitely prove that the LKMM API implementation has a C11-like 
> memory model abstraction.
> For example, you might be able to prove that the LKMM implementation of 
> a strong xchg guarantees at least the same ordering as a seq_cst fence ; 
> seq_cst xchg ; seq_cst fence sequence in C11.
> I don't think it's that fragile since 1) it's a manually written 
> volatile assembler mapping, so there's not really a lot the toolchains 
> can do about it and 2) the LKMM implementation of atomics rarely 
> changes, and should still have similar guarantees after the change.

One aspect here is that we'd like to move away from maintaining our own
atomics implementation within liburcu.

The second aspect is linked to the definition of SEQ_CST atomic operations:
AFAIR, they are documented to be sequentially consistent
only with respect to _other_ SEQ_CST atomic operations and fences.
Therefore, anything written in assembly falls outside of the score of
this sequential consistency guarantee.

So although the implementation of the assembler won't change, nothing
prevents a future compiler from changing the implementation of C11 atomic
seq-cst operations in a way that breaks their interaction with the
hand-written assembler.

> 
> The main issue will be as we discussed before and below that TSAN will 
> still trigger false positives.

If the issue was only TSAN false positives, we could extend either TSAN
or liburcu to make TSAN aware of those liburcu atomic operations.
This approach appears to globally add complexity compared to an approach
where liburcu just moves to C11 atomics though.

[...]

> 
>>> You mentioned that the goal is to check some code written using LKMM
>>> primitives with TSAN due to some formal requirements. What exactly do
>>> these requirements entail? Do you need to check the code exactly as it
>>> will be executed (modulo the TSAN instrumentation)? Is it an option to
>>> map to normal builtins with suboptimal performance just for the
>>> verification purpose, but then run the slightly more optimized
>>> original code later?
>> We aim to validate with TSAN the code that will run during production,
>> minus TSAN itself.
>>
>>> Specifically for TSAN's ordering requirements, you may need to make
>>> LKMM's RMWs into acq+rel with an extra mb, even if all that extra
>>> ordering isn't necessary at the assembler level.
>>>
>>>
>>> Also note that no matter what you do, due to the two different
>>> perspectives, TSAN's hb relation may introduce false positive data
>>> races w.r.t. LKMM.  For example, if the happens-before ordering is
>>> guaranteed through pb starting with coe/fre.
>> This is why we have implemented our primitives and changed our
>> algorithms so that they use the acquire/release semantics of the
>> C11/C++11 memory model.
>>
>>> Without thinking too hard, it seems to me no matter what fences and
>>> barriers you introduce, TSAN will not see this kind of ordering and
>>> consider the situation a data race.
>> We have come to the same conclusion, mainly because TSAN does not
>> support thread fence in its verifications.
> 
> That's also a concern (although I thought they fixed that a year or two 
> ago, but I must be mistaken).

AFAIR TSAN rely on explicit hb relationships. Adding thread fences
in liburcu was not sufficient to let TSAN become aware of the hb
relationship guaranteed by RCU and lock-free data structures: we had
to explicitly "tag" release/acquire relationships with C11 atomics
within the liburcu implementation to make it work.

> 
> What I mean is that even if TSAN appropriately used all fences for 
> hb-analysis, and even if you added strong fences all over your code, 
> there are (as far as I can see) still cases where TSAN will tell you 
> there's a data race (on C11) but there isn't one on LKMM.

AFAIU, the issue with barriers like "thread fence" is that it creates
implicit hb relationships between various loads/stores to memory which
are typically not relevant to track from a TSAN perspective. Therefore
I suspect the working set of loads/stores that would need to be
tracked by TSAN would become impractically large.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

