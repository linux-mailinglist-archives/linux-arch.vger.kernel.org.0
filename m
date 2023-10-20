Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE237D136F
	for <lists+linux-arch@lfdr.de>; Fri, 20 Oct 2023 18:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377853AbjJTQA7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Oct 2023 12:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377861AbjJTQA6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Oct 2023 12:00:58 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E13D73;
        Fri, 20 Oct 2023 09:00:55 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SBpnG4JFyz9v7cQ;
        Fri, 20 Oct 2023 23:45:06 +0800 (CST)
Received: from [10.81.210.100] (unknown [10.81.210.100])
        by APP1 (Coremail) with SMTP id LxC2BwBXsJEUpDJl+6eWAg--.65134S2;
        Fri, 20 Oct 2023 17:00:30 +0100 (CET)
Message-ID: <0bf4cda3-cc43-0e77-e47b-43e1402ed276@huaweicloud.com>
Date:   Fri, 20 Oct 2023 18:00:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH memory-model] docs: memory-barriers: Add note on compiler
 transformation and address deps
To:     paulmck@kernel.org
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
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <ceaeba0a-fc30-4635-802a-668c859a58b2@paulmck-laptop>
 <4110a58a-8db5-57c4-2f5a-e09ee054baaa@huaweicloud.com>
 <1c731fdc-9383-21f2-b2d0-2c879b382687@huaweicloud.com>
 <f363d6e0-5682-43e7-9a3f-6b896c3cd920@paulmck-laptop>
 <b96cfbc1-f6b0-2fa6-b72d-d57c34bbf14b@huaweicloud.com>
 <2694e6e1-3282-4a69-b955-06afd7d7f87f@paulmck-laptop>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <2694e6e1-3282-4a69-b955-06afd7d7f87f@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwBXsJEUpDJl+6eWAg--.65134S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF13WrWkGrWUtFykXw1DKFg_yoWrJw1Dpr
        W7uF12kF4DAw13Cw1ktw10yFyIvrWrAF45Gr93Kr1DZa98urySkF47tw45uF98Crs5Zr1j
        qrZIq397Z34qvaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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


Am 10/20/2023 um 3:57 PM schrieb Paul E. McKenney:
> On Fri, Oct 20, 2023 at 11:29:24AM +0200, Jonas Oberhauser wrote:
>> Am 10/19/2023 um 6:39 PM schrieb Paul E. McKenney:
>>> On Wed, Oct 18, 2023 at 12:11:58PM +0200, Jonas Oberhauser wrote:
>>>> Hi Paul,
>>>> [...]
>>> The compiler is forbidden from inventing pointer comparisons.
>> TIL :) Btw, do you remember a discussion where this is clarified? A quick
>> search didn't turn up anything.
> This was a verbal discussion with Richard Smith at the 2020 C++ Standards
> Committee meeting in Prague.  I honestly do not know what standardese
> supports this.


Then this e-mail thread shall be my evidence for future discussion.


>
>>>> Best wishes,
>>>>
>>>> jonas
>>>>
>>>> Am 10/6/2023 um 6:39 PM schrieb Jonas Oberhauser:
>>>>> Hi Paul,
>>>>>
>>>>> The "more up-to-date information" makes it sound like (some of) the
>>>>> information in this section is out-of-date/no longer valid.
>>> The old smp_read_barrier_depends() that these section cover really
>>> does no longer exist.
>>
>> (and the parts that are still there are all still relevant, while the parts
>> that only the authors know was intended to be there and is out-of-date is
>> already gone).
> The question is instead what parts that are still relevant are missing
> from rcu_dereference.rst.
>
>> So I would add a disclaimer specifying that (since 4.15) *all* marked
>> accesses imply read dependency barriers which resolve most of the issues
>> mentioned in the remainder of the article.
>> However, some issues remain because the dependencies that are preserved by
>> such barriers are just *semantic* dependencies, and readers should check
>> rcu_dereference.rst for examples of what that implies.
> Or maybe it is now time to remove those sections from memory-barriers.txt,
> leaving only the first section's pointer to rcu_dereference.rst.


That would also make sense to me.


> It still feels a bit early to me, and I am still trying to figure out
> why you care so much about these sections.  ;-)


I honestly don't care about the sections themselves, but I do care about 
1) address dependency ordering and 2) not confusing people more than 
necessary.
IMHO the sections right now are more confusing than necessary.
As I said before, I think they should clarify what exactly is historical 
in a short sentence. E.g.

  (2) Address-dependency barriers (historical).
      [!] This section is marked as HISTORICAL: it covers the obsolete barrier
      smp_read_barrier_depends(), the semantics of which is now implicit in all
      marked accesses. For more up-to-date information, including how compiler
      transformations related to pointer comparisons can sometimes cause problems,
      see Documentation/RCU/rcu_dereference.rst.

I think this tiny rewrite makes it much more clear. Specifically it tells *why* the text is historical (and why we maybe don't need to read it anymore).

Btw, when I raised my concerns about what should be there I didn't mean to imply those points are missing, just trying to sketch what the paragraph should look like in my opinion.
The paragraphs you are adding already had several of those points.


>>> The longer-term direction, perhaps a few years from now, is for the
>>> first section to simply reference rcu_dereference.rst and for the second
>>> section to be removed completely.
>> Sounds good to me, but that doesn't mean we need to compromise the
>> readability in the interim :)
> Some compromise is needed for people that read the document some time
> back and are looking for something specific.

Yes. But the compromise should be "there's a blob of text other people 
don't need to read", not "there's a blob of text that will leave other 
people confused".


Best wishes,

jonas

