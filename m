Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DC759AA81
	for <lists+linux-arch@lfdr.de>; Sat, 20 Aug 2022 03:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbiHTBfA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Aug 2022 21:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiHTBe7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2022 21:34:59 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D27E8D3EEF;
        Fri, 19 Aug 2022 18:34:57 -0700 (PDT)
Received: from [10.130.0.63] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx72s4OgBjOHUFAA--.22927S3;
        Sat, 20 Aug 2022 09:34:50 +0800 (CST)
Subject: Re: [PATCH 1/9] LoongArch/ftrace: Add basic support
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jinyang He <hejinyang@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20220819081403.7143-1-zhangqing@loongson.cn>
 <20220819081403.7143-2-zhangqing@loongson.cn>
 <f9b12eed-a7a0-0f2b-4679-1f465e22cad6@loongson.cn>
 <20220819125343.1623d850@gandalf.local.home>
From:   Qing Zhang <zhangqing@loongson.cn>
Message-ID: <06575d5e-7451-17ca-b5a8-4153816b3808@loongson.cn>
Date:   Sat, 20 Aug 2022 09:34:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20220819125343.1623d850@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx72s4OgBjOHUFAA--.22927S3
X-Coremail-Antispam: 1UD129KBjvdXoWruF1xWF4DCFy3AFykZF4xJFb_yoWfKFcE9F
        1Sgryfurs7ur1kG3s3Cr17GFZIyr47WFyUArWvvFW2vay3Xay5ArZxJFn3Jr43ta40gF15
        KrnF9r1S93s0qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbsxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
        WxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
        jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
        ZFpf9x0JUChFxUUUUU=
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2022/8/20 上午12:53, Steven Rostedt wrote:
> On Fri, 19 Aug 2022 17:29:29 +0800
> Jinyang He <hejinyang@loongson.cn> wrote:
> 
>> It seems this patch adds non-dynamic ftrace, this code should not
>> appear here.
>> BTW is it really necessary for non-dynamic ftrace? I do not use it
>> directly and frequently, IMHO, non-dynamic can be completely
>>
>> replaced dynamic?
> 
> Note, I keep the non dynamic ftrace around for debugging purposes.
> 
> But sure, it's pretty useless. It's also good for bringing ftrace to a new
> architecture (like this patch is doing), as it is easier to implement than
> dynamic ftrace, and getting the non-dynamic working is usually the first
> step in getting dynamic ftrace working.
> 
> But it's really up to the arch maintainers to keep it or not.
>
Before submitting, I saw that other architectures almost kept 
non-dynamic methods without cleaning up, I tend to keep them.
How do you think, Huacai. :)

Thanks,
- Qing
> -- Steve
> 

