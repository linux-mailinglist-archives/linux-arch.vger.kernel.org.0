Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DD97D1D41
	for <lists+linux-arch@lfdr.de>; Sat, 21 Oct 2023 15:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjJUNhA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 21 Oct 2023 09:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjJUNg7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 21 Oct 2023 09:36:59 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC98E7;
        Sat, 21 Oct 2023 06:36:57 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SCMXf5gN9z9v7c5;
        Sat, 21 Oct 2023 21:21:06 +0800 (CST)
Received: from [10.45.152.169] (unknown [10.45.152.169])
        by APP1 (Coremail) with SMTP id LxC2BwBHoJHV0zNlXRWlAg--.4153S2;
        Sat, 21 Oct 2023 14:36:32 +0100 (CET)
Message-ID: <591279ff-3316-d64b-8b25-6baefcecaad1@huaweicloud.com>
Date:   Sat, 21 Oct 2023 15:36:21 +0200
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
 <0bf4cda3-cc43-0e77-e47b-43e1402ed276@huaweicloud.com>
 <79233008-4be2-4442-9600-f9ac1a654312@paulmck-laptop>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <79233008-4be2-4442-9600-f9ac1a654312@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBHoJHV0zNlXRWlAg--.4153S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WryxXF15XF48Ar1xGF4rXwb_yoW8tF4Upr
        WfuF4kKF1DAw1S9ws2yw1YqFy2vrW5ta15Xry5Jr18Aas09FnakF47GF45CF90grs3Zr1j
        vrWxtas3Zr1jyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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


Am 10/20/2023 um 8:13 PM schrieb Paul E. McKenney:
> On Fri, Oct 20, 2023 at 06:00:19PM +0200, Jonas Oberhauser wrote:
>> Am 10/20/2023 um 3:57 PM schrieb Paul E. McKenney:
>>> On Fri, Oct 20, 2023 at 11:29:24AM +0200, Jonas Oberhauser wrote:
>>>> Am 10/19/2023 um 6:39 PM schrieb Paul E. McKenney:
>>>>> On Wed, Oct 18, 2023 at 12:11:58PM +0200, Jonas Oberhauser wrote:
>>>>>> Hi Paul,
>>>>>> [...]
>>>>> The compiler is forbidden from inventing pointer comparisons.
>>>> TIL :) Btw, do you remember a discussion where this is clarified? A quick
>>>> search didn't turn up anything.
>>> This was a verbal discussion with Richard Smith at the 2020 C++ Standards
>>> Committee meeting in Prague.  I honestly do not know what standardese
>>> supports this.
>> Richard Smith
>> Then this e-mail thread shall be my evidence for future discussion.
> I am sure that Richard will be delighted, especially given that he
> did not seem at all happy with this don't-invent-pointer-comparisons
> rule.  ;-)


Neither am I :D
He can voice his delightenment or lack thereof to me if we ever happen 
to meet in person.


>> I think this tiny rewrite makes it much more clear. Specifically it tells *why* the text is historical (and why we maybe don't need to read it anymore).
> Good point!  I reworked this a bit and added it to both HISTORICAL
> sections, with your Suggested-by.


The new version looks good to me!


>>>>> The longer-term direction, perhaps a few years from now, is for the
>>>>> first section to simply reference rcu_dereference.rst and for the second
>>>>> section to be removed completely.
>>>> Sounds good to me, but that doesn't mean we need to compromise the
>>>> readability in the interim :)
>>> Some compromise is needed for people that read the document some time
>>> back and are looking for something specific.
>> Yes. But the compromise should be "there's a blob of text other people don't
>> need to read", not "there's a blob of text that will leave other people
>> confused".
> Fair enough in general, but I cannot promise to never confuse people.
> This is after all memory ordering.  And different people will be confused
> by different things.


You can say that twice. In fact I suspect this is not the first time you 
say that :))

   jonas

