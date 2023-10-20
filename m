Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C587D0BBC
	for <lists+linux-arch@lfdr.de>; Fri, 20 Oct 2023 11:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376594AbjJTJaE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Oct 2023 05:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376615AbjJTJaD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Oct 2023 05:30:03 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F03AD55;
        Fri, 20 Oct 2023 02:29:59 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4SBf9N6h68z9ynvD;
        Fri, 20 Oct 2023 17:16:56 +0800 (CST)
Received: from [10.81.210.100] (unknown [10.81.210.100])
        by APP1 (Coremail) with SMTP id LxC2BwC3D5F1SDJl3TSSAg--.64782S2;
        Fri, 20 Oct 2023 10:29:35 +0100 (CET)
Message-ID: <b96cfbc1-f6b0-2fa6-b72d-d57c34bbf14b@huaweicloud.com>
Date:   Fri, 20 Oct 2023 11:29:24 +0200
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
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <f363d6e0-5682-43e7-9a3f-6b896c3cd920@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwC3D5F1SDJl3TSSAg--.64782S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZFW8Gw45AF1ruryDAryfCrg_yoWrZryUpr
        W3K3Z0kF4DJr12kw10yw17AFW0vrWfJFW5Jr93Gw1Uu398WrySyrsFyr4j9FyDC395Zw1j
        vrZIqr9xZ34DZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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


Am 10/19/2023 um 6:39 PM schrieb Paul E. McKenney:
> On Wed, Oct 18, 2023 at 12:11:58PM +0200, Jonas Oberhauser wrote:
>> Hi Paul,
>> [...]
> The compiler is forbidden from inventing pointer comparisons.

TIL :) Btw, do you remember a discussion where this is clarified? A 
quick search didn't turn up anything.


>> Best wishes,
>>
>> jonas
>>
>> Am 10/6/2023 um 6:39 PM schrieb Jonas Oberhauser:
>>> Hi Paul,
>>>
>>> The "more up-to-date information" makes it sound like (some of) the
>>> information in this section is out-of-date/no longer valid.
> The old smp_read_barrier_depends() that these section cover really
> does no longer exist.


You mean that they *intend to* cover? smp_read_barrier_depends never 
appears in the text, so anyone reading this section without prior 
knowledge has no way of realizing that this is what the sections are 
talking about.

On the other hand the implicit address dependency barriers that do exist 
are mentioned in the text. And that part is still true.


>
>>> But after reading the sections, it seems the information is valid, but
>>> discusses mostly the history of address dependency barriers.
>>>
>>> Given that the sepcond part  specifically already starts with a
>>> disclaimer that this information is purely relevant to people interested
>>> in history or working on alpha, I think it would make more sense to
>>> modify things slightly differently.
>>>
>>> Firstly I'd remove the "historical" part in the first section, and add
>>> two short paragraphs explaining that
>>>
>>> - every marked access implies a address dependency barrier
> This is covered in rcu_dereference.rst.

Let me quote a much wiser man than myself here: "

The problem is that people insist on diving into the middle of documents,
so sometimes repetition is a necessary form of self defense.  ;-)

"

The main reason I would like to add this here at the very top is that

- this section serves to frigthen children about the dangers of address 
dependencies,

- never mentions a way to add them - I need to happen to read another 
section of the manual to find that out

- and says this information is historical without specifying which parts 
are still relevant

(and the parts that are still there are all still relevant, while the 
parts that only the authors know was intended to be there and is 
out-of-date is already gone).

So I would add a disclaimer specifying that (since 4.15) *all* marked 
accesses imply read dependency barriers which resolve most of the issues 
mentioned in the remainder of the article.
However, some issues remain because the dependencies that are preserved 
by such barriers are just *semantic* dependencies, and readers should 
check rcu_dereference.rst for examples of what that implies.


> [...]
> most situations would be better served by an _acquire() suffix than by
> a relaxed version of [...] an atomic [...]


I completely agree. I even considered removing address dependencies 
altogether from the company-internal memory models.
But people sometimes get a little bit angry and start asking many questions.
The valuable time of the model maintainer should be considered when 
designing memory models.


>
>>> - address dependencies considered by the model are *semantic*
>>> dependencies, meaning that a *syntactic* dependency is not sufficient to
>>> imply ordering; see the rcu file for some examples where compilers can
>>> elide syntactic dependencies
> There is a bunch of text in rcu_dereference.rst to this effect.  Or
> is there some aspect that is missing from that document?


That's what I meant by "see the rcu file" --- include a link to 
rcu_dereference.rst in that paragraph.
So that people know to check out rcu_dereference.rst for more 
explanations to this effect.


> The longer-term direction, perhaps a few years from now, is for the
> first section to simply reference rcu_dereference.rst and for the second
> section to be removed completely.


Sounds good to me, but that doesn't mean we need to compromise the 
readability in the interim :)


>
> [...]
> The problem is that people insist on diving into the middle of documents,
> so sometimes repetition is a necessary form of self defense.  ;-)
>
> But I very much appreciate your review and feedback, and I also apologize
> for my slowness.
>
> 							Thanx, Paul
>

Thanks for the response, I started thinking my mails aren't getting 
through again.

Have fun,

jonas

