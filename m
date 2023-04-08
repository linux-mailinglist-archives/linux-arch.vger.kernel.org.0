Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5CF6DBC7C
	for <lists+linux-arch@lfdr.de>; Sat,  8 Apr 2023 20:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjDHS6h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Apr 2023 14:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDHS6g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Apr 2023 14:58:36 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14D99741;
        Sat,  8 Apr 2023 11:58:34 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Pv45k1Hz5z9xFGX;
        Sun,  9 Apr 2023 02:49:14 +0800 (CST)
Received: from [10.45.159.72] (unknown [10.45.159.72])
        by APP1 (Coremail) with SMTP id LxC2BwAnsAs3uTFkERIJAg--.354S2;
        Sat, 08 Apr 2023 19:58:10 +0100 (CET)
Message-ID: <e4a2059d-8199-b74e-d776-116c99c73fe6@huaweicloud.com>
Date:   Sat, 8 Apr 2023 20:57:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: Litmus test names
To:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        =?UTF-8?Q?Paul_Heidekr=c3=bcger?= <paul.heidekrueger@in.tum.de>,
        Will Deacon <will@kernel.org>
References: <ea9376b4-4b3d-48ee-9c27-ad8de8a7b5cb@paulmck-laptop>
 <3908932E-17D4-4B87-AB0C-D10564F10623@joelfernandes.org>
 <159545c3-0093-3cbd-e822-7298ae764966@huaweicloud.com>
 <d32901a8-3a07-440c-9089-36b37c3f04e5@paulmck-laptop>
 <20230408164956.GA680332@google.com>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <20230408164956.GA680332@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwAnsAs3uTFkERIJAg--.354S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1DWry8Jw1Duw48KryDWrg_yoW8Kw48pF
        yUKFsxGws8Jr4Fqwn7tw4Duw4IyanrJw1UZ3WDXr15ZFyqqr98KF1UWr909Fyjvrs3XFWD
        Jr4Uta47AFy5ZaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-0.1 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 4/8/2023 6:49 PM, Joel Fernandes wrote:
> On Fri, Apr 07, 2023 at 05:49:02PM -0700, Paul E. McKenney wrote:
>> On Fri, Apr 07, 2023 at 03:05:01PM +0200, Jonas Oberhauser wrote:
>>>
>>> On 4/7/2023 2:12 AM, Joel Fernandes wrote:
>>>>
>>>>> On Apr 6, 2023, at 6:34 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>>>>>
>>>>> ﻿On Thu, Apr 06, 2023 at 05:36:13PM -0400, Alan Stern wrote:
>>>>>> Paul:
>>>>>>
>>>>>> I just saw that two of the files in
>>>>>> tools/memory-model/litmus-tests have
>>>>>> almost identical names:
>>>>>>
>>>>>>   Z6.0+pooncelock+pooncelock+pombonce.litmus
>>>>>>   Z6.0+pooncelock+poonceLock+pombonce.litmus
>>>>>>
>>>>>> They differ only by a lower-case 'l' vs. a capital 'L'.  It's
>>>>>> not at all
>>>>>> easy to see, and won't play well in case-insensitive filesystems.
>>>>>>
>>>>>> Should one of them be renamed?
>>>>>
> FWIW, if I move that smp_mb_after..() a step lower, that also makes the test
> work (see below).
>
> If you may look over quickly my analysis of why this smp_mb_after..() is
> needed, it is because what I marked as a and d below don't have an hb
> relation right?

I think a and d have an hb relation due to the
a ->po-rel X ->rfe Y ->acq-po d
edges (where X and Y are the unlock/lock events I annotated in your 
example below).

Generally, an mb_unlock_lock isn't used to give you hb, but to turn some 
(coe/fre) ; hb* edges into pb edges

In this case, that would probably be
f ->fre a ->hb* f   (where a ->hb* f comes from a ->hb* d ->hb e ->hb f)
By adding the mb_unlock_lock_po in one of the right places, this becomes 
f ->pb f,
thus forbidden.


Have fun,
jonas


>
> (*
>    b ->rf c
>
>    d ->co e
>
>    e ->hb f
>
>    basically the issue is a ->po b ->rf c ->po d    does not imply a ->hb d
> *)
>
> P0(int *x, int *y, spinlock_t *mylock)
> {
> 	spin_lock(mylock);
> 	WRITE_ONCE(*x, 1); // a
> 	WRITE_ONCE(*y, 1); // b
> 	spin_unlock(mylock); // X
> }
>
> P1(int *y, int *z, spinlock_t *mylock)
> {
> 	int r0;
>
> 	spin_lock(mylock); // Y
> 	r0 = READ_ONCE(*y); // c
> 	smp_mb__after_spinlock(); // moving this a bit lower also works fwiw.
> 	WRITE_ONCE(*z, 1);  // d
> 	spin_unlock(mylock);
> }
>
> P2(int *x, int *z)
> {
> 	int r1;
>
> 	WRITE_ONCE(*z, 2);  // e
> 	smp_mb();
> 	r1 = READ_ONCE(*x); // f
> }
>
> exists (1:r0=1 /\ z=2 /\ 2:r1=0)
>
>
>> Would someone like to to a "git mv" send the resulting patch?
> Yes I can do that in return as I am thankful in advance for the above
> discussion. ;)
>
> thanks,
>
>   - Joel
>

