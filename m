Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D39C77B984
	for <lists+linux-arch@lfdr.de>; Mon, 14 Aug 2023 15:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjHNNPN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Aug 2023 09:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjHNNOs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Aug 2023 09:14:48 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBB1AE77;
        Mon, 14 Aug 2023 06:14:45 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.245])
        by gateway (Coremail) with SMTP id _____8DxVujEKNpkOTcYAA--.14309S3;
        Mon, 14 Aug 2023 21:14:44 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.245])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxviO_KNpkvQBaAA--.49407S3;
        Mon, 14 Aug 2023 21:14:41 +0800 (CST)
Message-ID: <97c18b17-047d-4ec9-8698-8d4afffbc27b@loongson.cn>
Date:   Mon, 14 Aug 2023 21:14:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v1] docs/zh_CN: add zh_CN translation for
 memory-barriers.txt
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, Gang Li <gang.li@linux.dev>
Cc:     Alex Shi <alexs@kernel.org>, Akira Yokosawa <akiyks@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230811080851.84497-1-gang.li@linux.dev>
 <2f519a69-8f12-4c07-bf20-6776a5ada256@loongson.cn>
 <f8de40bf-1743-793f-7723-232adbfab623@linux.dev>
 <479156cf-1bdb-421a-8dab-0db8ff73012b@loongson.cn>
 <87o7j9wzx1.fsf@meer.lwn.net>
From:   Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <87o7j9wzx1.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxviO_KNpkvQBaAA--.49407S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7CFWkCF13ur4fKF1fJry7Arc_yoW8tr43pa
        yrAF4q9F4DJrZrCw1Iyr1YkryrK3ySkw45W34DAryvkr90vr1rKr4ft398CFyvgr1kGFy2
        vr42y343Zr15JagCm3ZEXasCq-sJn29KB7ZKAUJUUUUJ529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
        6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
        0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
        v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
        xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0L0ePUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


在 2023/8/14 20:50, Jonathan Corbet 写道:
> Yanteng Si <siyanteng@loongson.cn> writes:
>
>> 在 2023/8/14 10:40, Gang Li 写道:
>>> Hi,
>>>
>>> On 2023/8/12 19:00, Yanteng Si wrote:
>>>> 在 2023/8/11 16:08, Gang Li 写道:
>>>>> +译注：
>>>>> +本文仅为方便汉语阅读，不保证与英文版本同步;
>>>>> +若有疑问，请阅读英文版本;
>>>>> +若有翻译问题，请通知译者；
>>>>> +若想修改文档，也请先修改英文版本。
>>>> In fact, we already have an easier way to do this, just include
>>>> disclaimer-zh_CN.
>>>>
>>>> If you observe the files under .../zh_CN/, they all have a similar
>>>> header, and we can completely follow them.
>>>>
>>> Thanks. I just noticed that there are txt files under
>>> "zh_CN/arch/arm64/" and "zh_CN/video4linux/". They have the same
>>> header, and I will
>>> refer to them in v2.
>>>
>>>> But you should also have noticed that memory-barriers are not a
>>>> standard rst file and will not be built, which will result in it only
>>>> staying in the development tree.
>>>> It won't appear at:
>>> https://docs.kernel.org
>>> https://www.kernel.org/doc/html/latest/
>>>
>>> But people can still access the txt document in this way:
>>> https://www.kernel.org/doc/Documentation/memory-barriers.txt
>>>
>>>> Finally, this patch is too huge and we may need some time to review it.
>>>>
>>> Of course. Would it be more convenient if I split the file into multiple
>>> patches and send them as one series?
>> You didn't have to.
>>
>>
>> If you want to send a series, you can refactor the original document
>> into rst format and make it the first patch of the series.
>>
>> Just like:
>>
>> [PATCH  v2 0/2] docs: Refactor memory-barriers.txt and translate it into
>> Chinese
>>
>> [PATCH  v2 1/2] docs: convert memory-barriers.txt to RST
> For $REASONS, memory-barriers.txt is staying as .txt, thus, as Gang Li
> pointed out, the wrapper page that pulls it in.  The proper solution is
> to create a wrapper for the translated .txt file as well.

Okay.


Hi Gang,


As Jon said, you need to create a wrapper for the translated 
memory-barriers.txt.


Thanks,

Yanteng

