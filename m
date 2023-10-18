Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FF37CD92D
	for <lists+linux-arch@lfdr.de>; Wed, 18 Oct 2023 12:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjJRK2i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Oct 2023 06:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJRK2h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Oct 2023 06:28:37 -0400
X-Greylist: delayed 964 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Oct 2023 03:28:35 PDT
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1899F95;
        Wed, 18 Oct 2023 03:28:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4S9RCT5wZNz9xFgV;
        Wed, 18 Oct 2023 17:59:33 +0800 (CST)
Received: from [10.45.155.178] (unknown [10.45.155.178])
        by APP2 (Coremail) with SMTP id GxC2BwB3G7dsry9lwGlpAg--.60243S2;
        Wed, 18 Oct 2023 11:12:07 +0100 (CET)
Message-ID: <1c731fdc-9383-21f2-b2d0-2c879b382687@huaweicloud.com>
Date:   Wed, 18 Oct 2023 12:11:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH memory-model] docs: memory-barriers: Add note on compiler
 transformation and address deps
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
To:     paulmck@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <ceaeba0a-fc30-4635-802a-668c859a58b2@paulmck-laptop>
 <4110a58a-8db5-57c4-2f5a-e09ee054baaa@huaweicloud.com>
In-Reply-To: <4110a58a-8db5-57c4-2f5a-e09ee054baaa@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwB3G7dsry9lwGlpAg--.60243S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr1rAFW5GFy5ZF1kuw47CFg_yoWrGr17pr
        WfKFnIqFZrJr18Cw1UJw17AryUAFZ5Ca13GrnI9F1kuF909rnYvrnFgr4F9FyDC395Aa4U
        XrWqvrsxZw1DAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Paul,

on a second thought. Why can't the compiler always do, e.g.,

     int *p = READ_ONCE(shared_ptr);

     assert (*p == 0);

~>

     int *p = READ_ONCE(shared_ptr);

     int val = x; // x is some object that definitely won't segfault, 
but may very well be owned by another thread right now
     if (p != &x) val = *p;

     assert (val == 0);

and in case p == &x, the address dependency is elided


Best wishes,

jonas

Am 10/6/2023 um 6:39 PM schrieb Jonas Oberhauser:
> Hi Paul,
>
> The "more up-to-date information" makes it sound like (some of) the 
> information in this section is out-of-date/no longer valid.
>
> But after reading the sections, it seems the information is valid, but 
> discusses mostly the history of address dependency barriers.
>
> Given that the sepcond part  specifically already starts with a 
> disclaimer that this information is purely relevant to people 
> interested in history or working on alpha, I think it would make more 
> sense to modify things slightly differently.
>
> Firstly I'd remove the "historical" part in the first section, and add 
> two short paragraphs explaining that
>
> - every marked access implies a address dependency barrier
>
> - address dependencies considered by the model are *semantic* 
> dependencies, meaning that a *syntactic* dependency is not sufficient 
> to imply ordering; see the rcu file for some examples where compilers 
> can elide syntactic dependencies
>
> Secondly, I'd not add the disclaimer to the second section; there's 
> already a link to rcu_dereference in that section ( 
> https://github.com/torvalds/linux/blob/master/Documentation/memory-barriers.txt#L634 
> ), and already a small text explaining that the section is historical.
>
>
> Best wishes,
>
> jonas
>
>
> Am 10/5/2023 um 6:53 PM schrieb Paul E. McKenney:
>> The compiler has the ability to cause misordering by destroying
>> address-dependency barriers if comparison operations are used. Add a
>> note about this to memory-barriers.txt in the beginning of both the
>> historical address-dependency sections and point to rcu-dereference.rst
>> for more information.
>>
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>
>> diff --git a/Documentation/memory-barriers.txt 
>> b/Documentation/memory-barriers.txt
>> index 06e14efd8662..d414e145f912 100644
>> --- a/Documentation/memory-barriers.txt
>> +++ b/Documentation/memory-barriers.txt
>> @@ -396,6 +396,10 @@ Memory barriers come in four basic varieties:
>>        (2) Address-dependency barriers (historical).
>> +     [!] This section is marked as HISTORICAL: For more up-to-date
>> +     information, including how compiler transformations related to 
>> pointer
>> +     comparisons can sometimes cause problems, see
>> +     Documentation/RCU/rcu_dereference.rst.
>>          An address-dependency barrier is a weaker form of read 
>> barrier.  In the
>>        case where two loads are performed such that the second 
>> depends on the
>> @@ -556,6 +560,9 @@ There are certain things that the Linux kernel 
>> memory barriers do not guarantee:
>>     ADDRESS-DEPENDENCY BARRIERS (HISTORICAL)
>>   ----------------------------------------
>> +[!] This section is marked as HISTORICAL: For more up-to-date 
>> information,
>> +including how compiler transformations related to pointer 
>> comparisons can
>> +sometimes cause problems, see Documentation/RCU/rcu_dereference.rst.
>>     As of v4.15 of the Linux kernel, an smp_mb() was added to 
>> READ_ONCE() for
>>   DEC Alpha, which means that about the only people who need to pay 
>> attention

