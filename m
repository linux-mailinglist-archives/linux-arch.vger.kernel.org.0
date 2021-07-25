Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAF53D4B1B
	for <lists+linux-arch@lfdr.de>; Sun, 25 Jul 2021 05:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhGYCZt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 24 Jul 2021 22:25:49 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:41679 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229609AbhGYCZs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sat, 24 Jul 2021 22:25:48 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id C24C62B0117B;
        Sat, 24 Jul 2021 23:06:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 24 Jul 2021 23:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=Y
        0C2NEWyArUxSdY7/JsNw6bRjfSzmv0TzsC81VlPyAA=; b=o12QDCitBfNqIdYks
        l5hTFNOc8KVRK502MYwa9+hKFuKgKtfjIddbmduHdJH/YTS7Iw5zM4PRbLk2nCiZ
        H3MhD+HUyuesvefHaoELK7u8viFLYau6tOmkSkuH4sa6bBVl5m/FHLE03wxqoUR4
        OMp1+rtcI9lI3/SgANSuBktNtrjjJzT3ZCAMUttPv4l2twjx8/8Wr3yCvcNjJXlJ
        7vtSCOZB0oZTI3rbKlITlsb2W1ioDhV7pFqWtezS8RLyzcswdrzcpjAgkLNN0gGw
        Pk2P0AbssxTWwLJIMjHjaC0wRy9lRwlsj3lWSgqMZ79ryawbtBY5eF2tZMTlrYdE
        fdgjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=Y0C2NEWyArUxSdY7/JsNw6bRjfSzmv0TzsC81VlPy
        AA=; b=iz7KAXLJR7LpD1P5sTtN/4lMCha5jryj+NC2/GdajH6RIRuSvp8b33h4u
        0GjGbwoCQsY7YtV0X4qThNqeBP44DF1FsFyFYxPf2K+wOwMnXG0g9i8ku7N15wzv
        xbYusqFxpimmMBStC59/nNz8BM3ZFS8yuKH/OeainZg84QwqCTclw6Gr6oLfqgr9
        AKkeHHEkrxe9705/KP0AKoYJ3FezkSl2yQboCGBjBNj4t+5ilKN0nHFOdkcj5B3w
        od7oS8ptNrC4h2AO0OVp2I8EL0VDi9RREABsf50VSC90iK6QCgRbdSRmEmZSON/J
        xvKt++olE3d5omzHxEnLJpdbxZO4A==
X-ME-Sender: <xms:KNX8YIA3JWQ0jlakIYu-efqIVeDo-07Je-BWtui56DGaZeM3Ardg2w>
    <xme:KNX8YKi9q4WSC2uuNpEZPvzwU8UaJ2mLhmq3gncLsv4xsfWExE9TpVMewqOcGa8SG
    GQ-SzYOHJ4xpunITLc>
X-ME-Received: <xmr:KNX8YLkIxbRDbZgVNkh6boPKAVnARdf70L5YkaHZGZ2iCXIJhTPpmb-rNCPpse63>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrgedugdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnheptdduffeifefhhfeiudejhefhlefgiefhudeuheejhefhvdduvefh
    hffgieejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehf
    lhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:KNX8YOxYKrt_uBAdwymLYNfDgJomjS6LgEwHy4JeILC45m-fuVAj9w>
    <xmx:KNX8YNSov5oQeh7Wic6HFgtIWIts2a0CVqdqyVCdWeO10QvrqCe2yQ>
    <xmx:KNX8YJb2nxFfJFXUPqMIrjSmxEtCY-k0YOPESmIXA3X_gOu471aPIQ>
    <xmx:KtX8YCIYclo3EezqwdFP-A3Ouft3MvqSQbNZBmZ4XORA3zjoylRm7szOOZ4>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 Jul 2021 23:06:12 -0400 (EDT)
Subject: Re: [PATCH RFC 1/2] arch: Introduce ARCH_HAS_HW_XCHG_SMALL
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Rui Wang <wangrui@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>
References: <20210724123617.3525377-1-chenhuacai@loongson.cn>
 <CAK8P3a0ZabB0cBR_SnOhi2=qxdQOYPGPEJeOqV0em1+bsvZKWw@mail.gmail.com>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <ec727497-7fe9-a52c-3063-ccd0459159fe@flygoat.com>
Date:   Sun, 25 Jul 2021 11:06:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0ZabB0cBR_SnOhi2=qxdQOYPGPEJeOqV0em1+bsvZKWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



在 2021/7/25 上午3:24, Arnd Bergmann 写道:
> On Sat, Jul 24, 2021 at 2:36 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
>> Introduce a new Kconfig option ARCH_HAS_HW_XCHG_SMALL, which means arch
>> has hardware sub-word xchg/cmpxchg support. This option will be used as
>> an indicator to select the bit-field definition in the qspinlock data
>> structure.
>>
>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> Adding a Kconfig conditional sounds like a good idea, but I have two
> concerns about the specific implementation:
>
> - I think we should have separate symbols for 8-bit, 16-bit and 64-bit
>    cmpxchg(). I think every architecture needs to support at least 32-bit
>    cmpxchg() and 64-bit architectures also need to support cmpxchg64().
>    I actually have a prototype patch that introduces cmpxchg8() and
>    cmpxchg16() helpers with the purpose of no longer supporting these
>    width in the normal cmpxchg(), but that is mostly independent of
>    whether we want a conditional or not.
Yeah that seems a better solution to make supporting status clear,

>
> - If I remember correctly, there were some concerns about whether using
>    this information for picking the qspinlock implementation is a good idea.
We've checked previous attempt made by Guo Ren about
ARCH_USE_QUEUED_SPINLOCKS_XCHG32[1], the concerns of potential livelock 
do exist.

So in this patch Huacai took another, dropping the whole standalone 
tailing logic to remove
the usage of sub-word xchg. It could be understood as partial revert of  
69f9cae9 ("
locking/qspinlock: Optimize for smaller NR_CPUS") [2] on these 
architectures.

>
>           Arnd
[1]: 
https://lore.kernel.org/linux-csky/1617201040-83905-2-git-send-email-guoren@kernel.org/
[2]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=69f9cae90907e09af95fb991ed384670cef8dd32

Thanks.

- Jiaxun
