Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D925784066
	for <lists+linux-arch@lfdr.de>; Tue, 22 Aug 2023 14:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbjHVMKM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Aug 2023 08:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjHVMKL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Aug 2023 08:10:11 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCB2893;
        Tue, 22 Aug 2023 05:09:57 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.102])
        by gateway (Coremail) with SMTP id _____8CxfOqUpeRkWugaAA--.27989S3;
        Tue, 22 Aug 2023 20:09:56 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.102])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxzyORpeRkVkZgAA--.62529S3;
        Tue, 22 Aug 2023 20:09:55 +0800 (CST)
Message-ID: <bee90784-e53c-4a30-b1f5-feeba46c7f5a@loongson.cn>
Date:   Tue, 22 Aug 2023 20:09:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] docs/zh_CN: add zh_CN translation for
 memory-barriers.txt
To:     Gang Li <gang.li@linux.dev>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
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
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <214aed18-5df5-1014-b73d-a1748c0cca13@linux.dev>
 <20230819162526.GA274478@leoy-huanghe.lan>
 <f7eac106-abe4-aba1-14df-6c9d1bfdf3b3@linux.dev>
 <20230821125322.GB57731@leoy-huanghe.lan>
Content-Language: en-US
From:   Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20230821125322.GB57731@leoy-huanghe.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxzyORpeRkVkZgAA--.62529S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKrW5AFy7Xw15GryxXrW3XFc_yoWkAwb_ua
        4Y9F4kAr4DXF4Ikan2kr48CayvqaykXr1UJF40qw4fArZ2qFykWFnYvrZ2vwn5JFs3JwnI
        kr1vq3W2q39FqosvyTuYvTs0mTUanT9S1TB71UUUU1DqnTZGkaVYY2UrUUUUj1kv1TuYvT
        s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
        cSsGvfJTRUUUbS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
        vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1ln4kS14v26r1q6r43M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
        6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
        xGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
        JVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
        xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
        wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jxDG5UUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


在 2023/8/21 20:53, Leo Yan 写道:
> On Mon, Aug 21, 2023 at 02:39:15PM +0800, Gang Li wrote:
>> Thanks for your review!
>>
>> Your suggestions will be integrated into the next version(v2).
>>
>> On 2023/8/20 00:25, Leo Yan wrote:
>>>> +		|       |   :   |        |   :   |       |
>>>> +		|       |   :   |        |   :   |       |
>>>> +		| CPU 1 |<----->|  内存  |<----->| CPU 2 |
>>> Unalignment caused by extra space around "内存".
>>>
>> If using Chinese, it is impossible to align properly no matter
>> how it is modified. If strict alignment is needed, the text in the
>> charts should not be translated.
> In my editor (vim), a Chinese character is two-width of English
> character.  So you could see in above, I can simply remove a space for
> alignment.

Hi Gang,


Yes, we will use vim to make adjustments in the end, no matter what 
editor we use for this work.


BTW, The title should also be aligned, with one Chinese character and 
two "=".

Just like:

-+==========
-+免责声明
-+==========
++========
++免责声明
++========


Thanks,

Yanteng

> Anyway, if you have different editor or configuration, using either
> langauge is fine for me.
>
> Please expect I will have more review.
>
> Thanks,
> Leo

