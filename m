Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3723D680DEF
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jan 2023 13:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbjA3Mly (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Jan 2023 07:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbjA3Mlx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Jan 2023 07:41:53 -0500
X-Greylist: delayed 1047 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 Jan 2023 04:41:52 PST
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C72526D;
        Mon, 30 Jan 2023 04:41:52 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4P56bk1kf1z9v7Zc;
        Mon, 30 Jan 2023 20:16:18 +0800 (CST)
Received: from [10.206.134.221] (unknown [10.206.134.221])
        by APP1 (Coremail) with SMTP id LxC2BwBHw_7Cttdj8WfcAA--.8512S2;
        Mon, 30 Jan 2023 13:23:47 +0100 (CET)
Message-ID: <2f4717b3-268f-8db3-e380-4af0a5479901@huaweicloud.com>
Date:   Mon, 30 Jan 2023 13:23:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] locking/atomic: atomic: Use arch_atomic_{read,set} in
 generic atomic ops
To:     Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jules Maselbas <jmaselbas@kalray.eu>,
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
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y9RLpYGmzW1KPksE@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBHw_7Cttdj8WfcAA--.8512S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw47WF45ZFWrWryDtFy5urg_yoWruFy8pF
        WSka13GF4DXF1Sq34kJa1xu3WFyw40y3y5Jr95KrykuF1Y9ryftr4xtr4YgFy7Cws7trW2
        qr1DK34DCa45ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
        4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
        3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUojjgUUUUU
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 1/27/2023 11:09 PM, Boqun Feng wrote:
> On Fri, Jan 27, 2023 at 03:34:33PM +0100, Peter Zijlstra wrote:
>>> I also noticed that GCC has some builtin/extension to do such things,
>>> __atomic_OP_fetch and __atomic_fetch_OP, but I do not know if this
>>> can be used in the kernel.
>> On a per-architecture basis only, the C/C++ memory model does not match
>> the Linux Kernel memory model so using the compiler to generate the
>> atomic ops is somewhat tricky and needs architecture audits.
> Hijack this thread a little bit, but while we are at it, do you think it
> makes sense that we have a config option that allows archs to
> implement LKMM atomics via C11 (volatile) atomics? I know there are gaps
> between two memory models, but the option is only for fallback/generic
> implementation so we can put extra barriers/orderings to make things
> guaranteed to work.
>
> It'll be a code version of this document:
>
> 	https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2020/p0124r7.html
>
> (although I realise there may be a few mistakes in that doc since I
> wasn't familiar with C11 memory model when I wrote part of the doc, but
> these can be fixed)
>
> Another reason I ask is that since Rust is coming, we need to provide
> our LKMM atomics in Rust so that C code and Rust code can talk via same
> atomic variables, since both sides need to use the same memory model.
> My choices are:
>
> 1.	Using FFI to call Linux atomic APIs: not inline therefore not
> 	efficient.
>
> 2.	Implementing Rust LKMM atomics in asm: much more work although
> 	I'm OK if we have to do it.
>
> 3.	Implementing Rust LKMM atomics with standard atomics (i.e. C/C++
> 	atomics):
>
> 	*	Requires Rust has "volatile" atomics, which is WIP but
> 		looks promising
> 	
> 	*	Less efficient compared to choice #2 but more efficient
> 		compared to choice #1
>
> Ideally, choice #2 is the best option for all architectures, however, if
> we have the generic implementation based on choice #3, for some archs it
> may be good enough.
>
> Thoughts?

Thanks for adding me to the discussion!

One reason not to rely on C11 is that old compilers don't support it, 
and there may be application scenarios in which new compilers haven't 
been certified.
I don't know if this is something that affects linux, but linux is so 
big and versatile I'd be surprised if that's irrelevant.

Another is that the C11 model is more about atomic locations than atomic 
accesses, and there are several places in the kernel where a location is 
accessed both atomically and non-atomically. This API mismatch is more 
severe than the semantic differences in my opinion, since you don't have 
guarantees of what the layout of atomics is going to be.

Perhaps you could instead rely on the compiler builtins? Note that this 
may invalidate some progress properties, e.g., ticket locks become 
unfair if the increment (for taking a ticket) is implemented with a CAS 
loop (because a thread can fail forever to get a ticket if the ticket 
counter is contended, and thus starve). There may be some linux atomics 
that don't map to any compiler builtins and need to implemented with 
such CAS loops, potentially leading to such problems.

I'm also curious whether link time optimization can resolve the inlining 
issue?

I think another big question for me is to which extent it makes sense 
anyways to have shared memory concurrency between the Rust code and the 
C code. It seems all the bad concurrency stuff from the C world would 
flow into the Rust world, right?
If you can live without shared Rust & C concurrency, then perhaps you 
can get away without using LKMM in Rust at all, and just rely on its 
(C11-like) memory model internally and talk to the C code through 
synchronous, safer ways.

I'm not against having a fallback builtin-based implementation of LKMM, 
and I don't think that it really needs architecture audits. What it 
needs is some additional compiler barriers and memory barriers, to 
ensure that the arguments about dependencies and non-atomics still hold. 
E.g., a release store may not just be "builtin release store" but may 
need to have a compiler barrier to prevent the release store being moved 
in program order. And a "full barrier" exchange may need an mb() infront 
of the operation to avoid "roach motel ordering" (i.e.,  x=1 ; "full 
barrier exchange"; y = 1 allows y=1 to execute before x=1 in the 
compiler builtins as far as I remember). And there may be some other 
cases like this.

But I currently don't see that this implementation would be noticeably 
faster than paying the overhead of lack of inline.

Best wishes, jonas

