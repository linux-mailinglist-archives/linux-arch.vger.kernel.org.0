Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE267D13C7
	for <lists+linux-arch@lfdr.de>; Fri, 20 Oct 2023 18:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjJTQOT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Oct 2023 12:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjJTQOQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Oct 2023 12:14:16 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81903124;
        Fri, 20 Oct 2023 09:14:14 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4SBq7p12GRz9v7H5;
        Sat, 21 Oct 2023 00:01:10 +0800 (CST)
Received: from [10.81.210.100] (unknown [10.81.210.100])
        by APP2 (Coremail) with SMTP id GxC2BwBH67YvpzJlfqKNAg--.3883S2;
        Fri, 20 Oct 2023 17:13:47 +0100 (CET)
Message-ID: <8322165e-c287-6e43-239e-3fcd0b375c1e@huaweicloud.com>
Date:   Fri, 20 Oct 2023 18:13:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH memory-model] docs: memory-barriers: Add note on compiler
 transformation and address deps
To:     Akira Yokosawa <akiyks@gmail.com>, paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <ceaeba0a-fc30-4635-802a-668c859a58b2@paulmck-laptop>
 <4110a58a-8db5-57c4-2f5a-e09ee054baaa@huaweicloud.com>
 <1c731fdc-9383-21f2-b2d0-2c879b382687@huaweicloud.com>
 <f363d6e0-5682-43e7-9a3f-6b896c3cd920@paulmck-laptop>
 <b96cfbc1-f6b0-2fa6-b72d-d57c34bbf14b@huaweicloud.com>
 <2694e6e1-3282-4a69-b955-06afd7d7f87f@paulmck-laptop>
 <03ea8aea-2d0c-48ab-bb0d-e585571f1926@gmail.com>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <03ea8aea-2d0c-48ab-bb0d-e585571f1926@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwBH67YvpzJlfqKNAg--.3883S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw15Gr1xCw1kXF1rGryrXrb_yoW8Xr4kpF
        ZxGw4YkFnxur47Cr4qqws8Ja4jvFZ8Xa15W3s3GrykAFW5ZFW3Crs29r12vrsxZrZ3K34Y
        vw1ava98ArWktaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UdxhLUUUUU=
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Am 10/20/2023 um 5:24 PM schrieb Akira Yokosawa:
> Hi Paul,
>
> On 2023/10/20 22:57, Paul E. McKenney wrote:
> [...]
>> So if there are things that rcu_dereference.rst is missing, they do
>> need to be added.
> As far as I can see, there is no mention of "address dependency"
> in rcu_dereference.rst.
> Yes, I see the discussion in rcu_dereference.rst is all about how
> not to break address dependency by proper uses of rcu_dereference()
> and its friends.  But that might not be obvious for readers who
> followed the references placed in memory-barriers.txt.
>
> Using the term "address dependency" somewhere in rcu_dereference.rst
> should help such readers, I guess.


I think that's a good point.


>
> [...]
>>> Thanks for the response, I started thinking my mails aren't getting through
>>> again.
> Jonas, FWIW, your email archived at
>
>      https://lore.kernel.org/linux-doc/1c731fdc-9383-21f2-b2d0-2c879b382687@huaweicloud.com/
>
> didn't reach my gmail inbox.  I looked for it in the spam folder,
> but couldn't find it there either.
>
> Your first reply on Oct 6, which is archived at
>
>      https://lore.kernel.org/linux-doc/4110a58a-8db5-57c4-2f5a-e09ee054baaa@huaweicloud.com/
>
> ended up in my spam folder.
>
> I have no idea why gmail has trouble with your emails so often ...
>
> Anyway, LKML did accept your mails this time.
>
> HTH,
>          Akira


Thanks Akira!

I wrote the gmail support a while ago, but no response.

Currently no idea who to talk to... Oh well.



