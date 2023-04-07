Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835F66DAED2
	for <lists+linux-arch@lfdr.de>; Fri,  7 Apr 2023 16:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjDGOXn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Apr 2023 10:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjDGOXm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Apr 2023 10:23:42 -0400
X-Greylist: delayed 3601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 07 Apr 2023 07:23:40 PDT
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D8D44A9;
        Fri,  7 Apr 2023 07:23:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4PtJHy5pvrz9v7cC;
        Fri,  7 Apr 2023 20:55:26 +0800 (CST)
Received: from [10.48.128.209] (unknown [10.48.128.209])
        by APP2 (Coremail) with SMTP id GxC2BwDXj0b_FDBkTTUBAg--.175S2;
        Fri, 07 Apr 2023 14:05:13 +0100 (CET)
Message-ID: <159545c3-0093-3cbd-e822-7298ae764966@huaweicloud.com>
Date:   Fri, 7 Apr 2023 15:05:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: Litmus test names
To:     Joel Fernandes <joel@joelfernandes.org>, paulmck@kernel.org
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
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <3908932E-17D4-4B87-AB0C-D10564F10623@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwDXj0b_FDBkTTUBAg--.175S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr4fJw1xWw4xGr15ZF1rXrb_yoW8AF4Upa
        yjka42y398JayFvrn2vr45WF4Iyw1UAw1UCwn0yr98Ga4DXrn3Gr17Wr15Z3WDZFs5u3ZF
        q3yUG34kZ345ZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IUbG2NtUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 4/7/2023 2:12 AM, Joel Fernandes wrote:
>
>
>> On Apr 6, 2023, at 6:34 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>>
>> ﻿On Thu, Apr 06, 2023 at 05:36:13PM -0400, Alan Stern wrote:
>>> Paul:
>>>
>>> I just saw that two of the files in tools/memory-model/litmus-tests 
>>> have
>>> almost identical names:
>>>
>>>  Z6.0+pooncelock+pooncelock+pombonce.litmus
>>>  Z6.0+pooncelock+poonceLock+pombonce.litmus
>>>
>>> They differ only by a lower-case 'l' vs. a capital 'L'.  It's not at 
>>> all
>>> easy to see, and won't play well in case-insensitive filesystems.
>>>
>>> Should one of them be renamed?
>>
>> Quite possibly!
>>
>> The "L" denotes smp_mb__after_spinlock().  The only code difference
>> between these is that Z6.0+pooncelock+poonceLock+pombonce.litmus has
>> smp_mb__after_spinlock() and Z6.0+pooncelock+pooncelock+pombonce.litmus
>> does not.
>>
>> Suggestions for a better name?  We could capitalize all the letters
>> in LOCK, I suppose...

I don't think capitalizing LOCK is helpful.

To be honest, almost all the names are extremely cryptic to newcomers 
like me (like, what does Z6.0 mean? Is it some magic incantation?).
And that's not something that's easy to fix.

The only use case I can think of for spending time improving the names 
is that sometimes you wanna say something like "oh, this is like 
Z6.0+pooncelock+pooncelockmb+pombonce". And then people can look up what 
that is.
For that, it's important that the names are easy to disambiguate by 
humans, and I think Joel's suggestion is an improvement.
(and it also fixes the issue brought up by Alan about case-insensitive 
file systems)

>
> Z6.0+pooncelock+pooncelockmb+pombonce.litmus ?
>
> Thanks,
>
>  - Joel
>


have fun, jonas

