Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F6859C1CD
	for <lists+linux-arch@lfdr.de>; Mon, 22 Aug 2022 16:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiHVOnS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Aug 2022 10:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234896AbiHVOnR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Aug 2022 10:43:17 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D422EB;
        Mon, 22 Aug 2022 07:43:14 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MBFPs0hByzlWW5;
        Mon, 22 Aug 2022 22:40:01 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 22 Aug 2022 22:43:12 +0800
Received: from [127.0.0.1] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 22 Aug
 2022 22:43:12 +0800
Message-ID: <a271d041-08fa-c2db-f2ac-d64d9b119797@huawei.com>
Date:   Mon, 22 Aug 2022 22:43:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [RESEND PATCH] ARM: Recover kretprobes return address for EABI
 stack unwinder
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux@armlinux.org.uk>, <arnd@arndb.de>, <ardb@kernel.org>,
        <rmk+kernel@armlinux.org.uk>, <rostedt@goodmis.org>,
        <nick.hawkins@hpe.com>, <john@phrozen.org>, <mhiramat@kernel.org>
References: <20220815110240.18293-1-chenzhongjin@huawei.com>
 <CACRpkdZsdggUptPkPhzzu8vv9moSO+rjvZxZRb1VqJ2xWjY=HQ@mail.gmail.com>
Content-Language: en-US
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <CACRpkdZsdggUptPkPhzzu8vv9moSO+rjvZxZRb1VqJ2xWjY=HQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2022/8/22 19:20, Linus Walleij wrote:
> On Mon, Aug 15, 2022 at 1:06 PM Chen Zhongjin <chenzhongjin@huawei.com> wrote:
>
>> 'fed240d9c974 ("ARM: Recover kretprobe modified return address in stacktrace")'
>> has implemented kretprobes return address recovery for FP
>> unwinder, this patch makes it works for EABI unwinder.
>>
>> It saves __kretprobe_trampoline address in LR on stack to identify
>> and recover the correct return address in EABI unwinder.
>>
>> Since EABI doesn't use r11 as frame pointer, we need to use SP to
>> identify different kretprobes addresses. Here the value of SP has fixed
>> distance to conventional FP position so it's fine to use it.
>>
>> Passed kunit kprobes_test on QEMU.
>>
>> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> This looks correct to me FWIW I understand the assembly
> but I'm vaguely unfamiliar with the kprobe API, but anyway:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Would you please drop it into Russell's patch tracker?

Done for it.

Thanks for review!


Best,

Chen

> Yours,
> Linus Walleij

