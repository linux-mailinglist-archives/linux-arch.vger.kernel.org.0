Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145D653CB69
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jun 2022 16:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244720AbiFCOOj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jun 2022 10:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240024AbiFCOOi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jun 2022 10:14:38 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347A13EBB6;
        Fri,  3 Jun 2022 07:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1654265671; bh=othfUBeCgIWwvNgS19Qxvk9oJwBpnSgFLwDEof8nHew=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=J6p4vJWMqJaB2TgUXZNx3DVsQZyOks2t08tu3ZxCfAPZt9esFy9b9XdnjQm1Fs9/f
         hDlcVQmB2CMwXsk2LQIwgbVWWULZ5BJoeJpIJ9K4wtkooQx7h8sEv3DQ9owIIsPOmH
         0jwwcMUMynWlWVk96KQbQLZkH2tuQxy7x979ggrY=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id EA95760104;
        Fri,  3 Jun 2022 22:14:30 +0800 (CST)
Message-ID: <e78940bc-9be2-2fe7-026f-9e64a1416c9f@xen0n.name>
Date:   Fri, 3 Jun 2022 22:14:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:103.0) Gecko/20100101
 Thunderbird/103.0a1
Subject: Re: [PATCH V15 10/24] LoongArch: Add other common headers
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        WANG Xuerui <git@xen0n.name>
References: <20220603072053.35005-1-chenhuacai@loongson.cn>
 <20220603072053.35005-11-chenhuacai@loongson.cn> <YpoPZjJ/Adfu3uH9@zx2c4.com>
 <CAK8P3a0iASLd768imA8pG32Cc2RsqG8-ZyN+Obcg+PksVj1FJg@mail.gmail.com>
 <YpoURwkAbqRlr7Yi@zx2c4.com>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <YpoURwkAbqRlr7Yi@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/3/22 22:01, Jason A. Donenfeld wrote:
> Hi Arnd,
>
> On Fri, Jun 03, 2022 at 03:55:27PM +0200, Arnd Bergmann wrote:
>> On Fri, Jun 3, 2022 at 3:40 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>>> On Fri, Jun 03, 2022 at 03:20:39PM +0800, Huacai Chen wrote:
>>>> diff --git a/arch/loongarch/include/asm/timex.h b/arch/loongarch/include/asm/timex.h
>>> "Currently only used on SMP for scheduling" isn't quite correct. It's
>>> also used by random_get_entropy(). And anything else that uses
>>> get_cycles() for, e.g., benchmarking, might use it too.
>>>
>>> You wrote also, "we know that all SMP capable CPUs have cycle counters",
>>> so if I gather from this statement that some !SMP CPUs don't have a
>>> cycle counter, though some do. If that's a correct supposition, then
>>> you may need to rewrite this file to be something like:
>> The file is based on the mips version that deals with a variety of
>> implementations
>> and has the same comment.
>>
>> I assume the loongarch chips all behave the same way here, and won't need
>> a special case for non-SMP.
> Oh good. In that case, the code is fine and I suppose the comment could
> just be removed.

In addition, the rdtime family of instructions is in fact guaranteed to 
be available on LoongArch; LoongArch's subsets all contain them, even 
the 32-bit "Primary" subset intended for university teaching -- they 
provide the rdtimeh.w and rdtimel.w pair of instructions that access the 
same 64-bit counter. So I think the comments are probably just leftovers 
from a very early port; the LoongArch development started way before it 
was publicized.

And yes, the comment block re get_cycles usage can be removed altogether.

