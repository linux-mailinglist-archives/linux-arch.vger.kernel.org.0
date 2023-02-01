Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEB56864C0
	for <lists+linux-arch@lfdr.de>; Wed,  1 Feb 2023 11:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjBAKwB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Feb 2023 05:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjBAKwA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Feb 2023 05:52:00 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D351940BE2;
        Wed,  1 Feb 2023 02:51:56 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4P6JRr3sN7z9v7bZ;
        Wed,  1 Feb 2023 18:43:36 +0800 (CST)
Received: from [10.81.213.150] (unknown [10.81.213.150])
        by APP1 (Coremail) with SMTP id LxC2BwC3M_8YRNpjWPLkAA--.12937S2;
        Wed, 01 Feb 2023 11:51:20 +0100 (CET)
Message-ID: <3b56b84d-92fa-873f-1ed8-19a54f6eee80@huaweicloud.com>
Date:   Wed, 1 Feb 2023 11:51:01 +0100
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
 <2f121e2d-8e4c-de99-5672-93350fbb52af@huaweicloud.com>
 <Y9mQNNhzkOF/+uuC@boqun-archlinux>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y9mQNNhzkOF/+uuC@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwC3M_8YRNpjWPLkAA--.12937S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtw13Wry7Gr4xZFWrJry3CFg_yoW7ZFW8pF
        WxKa1xGF4kJryYy3s7t3WIg3WFk3yftrW5Xr95Gw1kur90vFyfur1fKw4Y9Fy7Arn2g34j
        qr4jva47u3WrAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
        4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3
        Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VU1VOJ5UUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 1/31/2023 11:03 PM, Boqun Feng wrote:
> On Tue, Jan 31, 2023 at 04:08:29PM +0100, Jonas Oberhauser wrote:
>>
>> On 1/30/2023 7:38 PM, Boqun Feng wrote:
>>> On Mon, Jan 30, 2023 at 01:23:28PM +0100, Jonas Oberhauser wrote:
>>>> On 1/27/2023 11:09 PM, Boqun Feng wrote:
>>>>> On Fri, Jan 27, 2023 at 03:34:33PM +0100, Peter Zijlstra wrote:
>>>>>>> I also noticed that GCC has some builtin/extension to do such things,
>>>>>>> __atomic_OP_fetch and __atomic_fetch_OP, but I do not know if this
>>>>>>> can be used in the kernel.
>>>>>> On a per-architecture basis only, the C/C++ memory model does not match
>>>>>> the Linux Kernel memory model so using the compiler to generate the
>>>>>> atomic ops is somewhat tricky and needs architecture audits.
>>>>> Hijack this thread a little bit, but while we are at it, do you think it
>>>>> makes sense that we have a config option that allows archs to
>>>>> implement LKMM atomics via C11 (volatile) atomics? I know there are gaps
>>>>> between two memory models, but the option is only for fallback/generic
>>>>> implementation so we can put extra barriers/orderings to make things
>>>>> guaranteed to work.
>>>>>

>>>> [...]
>>>> I'm also curious whether link time optimization can resolve the inlining
>>>> issue?
>>>>
>>> For Rust case, cross-language LTO is needed I think, and last time I
>>> tried, it didn't work.
>> In German we say "Was noch nicht ist kann ja noch werden", translated as
>> "what isn't can yet become", I don't feel like putting too much effort into
> Not too much compared to wrapping LKMM atomics with Rust using FFI,
>
> Using FFI:
>
> 	impl Atomic {
> 		fn read_acquire(&self) -> i32 {
> 			// SAFTEY:
> 			unsafe { atomic_read_acquire(self as _) }
> 		}
> 	}
>
> Using standard atomics:
>
> 	impl Atomic {
> 		fn read_acquire(&self) -> i32 {
> 			// self.0 is a Rust AtomicI32
> 			compiler_fence(SeqCst); // Rust not support volatile atomic yet
> 			self.0.load(Acquire)
> 		}
> 	}
>
> Needless to say, if we really need LKMM atomics in Rust, it's kinda my
> job to implement these, so not much different for me ;-) Of course, any
> help is appreciate!

I think a lot more mental effort goes into figuring out where and which 
barriers go everywhere.
But of course if there's curiosity driving you, then that small 
trade-off may be acceptable : )

>> something that hardly affects performance and will hopefully become obsolete
>> at some point in the near future.
>>
>>>> I think another big question for me is to which extent it makes sense
>>>> anyways to have shared memory concurrency between the Rust code and the C
>>>> code. It seems all the bad concurrency stuff from the C world would flow
>>>> into the Rust world, right?
>>> What do you mean by "bad" ;-) ;-) ;-)
>> Uh oh. Let's pretend I didn't say anything :D
>>
>>>> If you can live without shared Rust & C concurrency, then perhaps you can
>>>> get away without using LKMM in Rust at all, and just rely on its (C11-like)
>>>> memory model internally and talk to the C code through synchronous, safer
>>>> ways.
>>>>
>>> First I don't think I can avoid using LKMM in Rust, besides the
>>> communication from two sides, what if kernel developers just want to
>>> use the memory model they learn and understand (i.e. LKMM) in a new Rust
>>> driver?
>> I'd rather people think 10 times before relying on atomics to write Rust
>> code.
>> There may be cases where it can't be avoided because of performance reasons,
>> but Rust has a much more convenient concurrency model to offer than atomics.
>> I think a lot more people understand Rust mutexes or channels compared to
>> atomics.
> C also has more convenient concurrency tools in kernel, and I'm happy
> that people use them. But there are also people (including me) working
> on building these tools/models, inevitably we need to use atomics.

:D

> 1.	Use Rust standard atomics and pretend different memory models
> 	work together (do we have model tools to handle code in
> 	different models communicating with each other?)

I'm not aware of any generic tools, and in particular for Rust and LKMM 
it will take some thought to create interoperability.
This is because the po | sw and ppo | rfe | pb styles are so different.

I did some previous work on letting SC and x86 talk to each other 
through shared memory, which is much easier because both can be 
understood through the ppo | rfe | coe | fre lense, just that on SC 
everything is preserved; it still wasn't completely trivial because the 
SC part was actually implemented efficiently on x86 as well, so it was a 
"partial-DRF-partial-SC" kind of deal.


>
> 2.	Use Rust standard atomics and add extra mb()s to enforce more
> 	ordering guarantee.
>
> 3.	Implement LKMM atomics in Rust and use them with caution when
> 	comes to implicit ordering guarantees such as ppo. In fact lots
> 	of implicit ordering guarantees are available since the compiler
> 	won't exploit the potential reordering to "optimize", we also
> 	kinda have tools to check:
>
> 		https://lpc.events/event/16/contributions/1174/attachments/1108/2121/Status%20Report%20-%20Broken%20Dependency%20Orderings%20in%20the%20Linux%20Kernel.pdf
>
> 	A good part of using Rust is that we may try out a few tricks
> 	(with proc-macro, compiler plugs, etc) to express some ordering
> 	expection, e.g. control dependencies.
>
> 	Two suboptions are:
>
> 	3.1	Implement LKMM atomics in Rust with FFI

I'd target this one ; ) It seems the most likely to work the way people 
want, with perhaps the least effort, and a good chance of not having 
overhead at some point in the future.

> 	3.2	Implement LKMM atomics in Rust with Rust standard
> 		atomics
>
> I'm happy to figure out pros and cons behind each option.
>


Best wishes, jonas

