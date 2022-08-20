Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A48F59AAE1
	for <lists+linux-arch@lfdr.de>; Sat, 20 Aug 2022 05:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242674AbiHTDQR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Aug 2022 23:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239003AbiHTDQP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2022 23:16:15 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DCCA2AD6;
        Fri, 19 Aug 2022 20:16:13 -0700 (PDT)
Received: from localhost.localdomain (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxrmvzUQBjXo4FAA--.13173S3;
        Sat, 20 Aug 2022 11:16:05 +0800 (CST)
Subject: Re: [PATCH 1/9] LoongArch/ftrace: Add basic support
To:     Steven Rostedt <rostedt@goodmis.org>
References: <20220819081403.7143-1-zhangqing@loongson.cn>
 <20220819081403.7143-2-zhangqing@loongson.cn>
 <20220819132509.127a1353@gandalf.local.home>
 <246779c0-b834-16a6-ec68-c06d8f9a375d@loongson.cn>
 <20220819215240.3caf89e2@gandalf.local.home>
Cc:     Qing Zhang <zhangqing@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
From:   Jinyang He <hejinyang@loongson.cn>
Message-ID: <de7584d4-56ff-aafe-42ec-702924fbcf64@loongson.cn>
Date:   Sat, 20 Aug 2022 11:16:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20220819215240.3caf89e2@gandalf.local.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxrmvzUQBjXo4FAA--.13173S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Gr45WrWkZr4DJry3AF15XFb_yoW8Jr4xpF
        yFg3yxCFZ7tFWavan2vw17Wr13uFn5AFZ3tr1rKry8Aryrur1avw4avrnFqryvyw1kGrW2
        qr4DK3yUCFn8C37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE
        67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14
        v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
        C2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 08/20/2022 09:52 AM, Steven Rostedt wrote:

> On Sat, 20 Aug 2022 09:38:21 +0800
> Jinyang He <hejinyang@loongson.cn> wrote:
>
>> I think we have implemented CONFIG_FTRACE_WITH_ARGS in dynamic ftrace
>> in the [Patch3/9].
> Sorry, I must have missed it.
And there is still something left to do, Qing will do that.

>
>> But, for non dynamic ftrace, it is hardly to
>> implement it. Because the LoongArch compiler gcc treats mount as a
> Don't bother implementing it for non-dynamic. I would just add a:
>
> config HAVE_FTRACE_WITH_ARGS if DYNAMIC_FTRACE
>
> and be done with it.
Yes, it is clear.

>
>> really call, like 'call _mcount(__builtin_return_address(0))'. That
>> means, they decrease stack, save args to callee saved regs and may
>> do some optimization before calling mcount. It is difficult to find the
>> original args and apply changes from tracers.
> Right, there's no point in implementing it for non dynamic. Like I said,
> non-dynamic is just a stepping stone for getting dynamic working. Once you
> have dynamic working, it's up to you to throw out the non-dynamic. It's not
> useful for anything other than porting to a new architecture or for
> academic purposes.
>
Thanks for your detail answers.
Jinyang

