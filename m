Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA285504E7
	for <lists+linux-arch@lfdr.de>; Sat, 18 Jun 2022 14:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbiFRM4p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Jun 2022 08:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236026AbiFRM4p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Jun 2022 08:56:45 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC0812AB7
        for <linux-arch@vger.kernel.org>; Sat, 18 Jun 2022 05:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1655557001; bh=+ZJhD3kslwcqzlLuusGRIAUNOBNdrfPLk7bgsPvmgyM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O/A93laNcFVV9qGufGs1kJsjLBgInl9e5JS/qk3tY1bDWaqXvA/vi+x4Oio4FwkRn
         149Je0XuSCm6ICArEB9ezUDv0oEkzUsPZbYDNFZKwjMTUhgcQz020c+L1lAHSzjB5p
         D8eHt1xo+SE7BTX9qiZXayfWdB6jyluZVQNX6PqU=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id ABEF96011F;
        Sat, 18 Jun 2022 20:56:41 +0800 (CST)
Message-ID: <94bebe28-5988-d6b6-bf82-03ef5901cd69@xen0n.name>
Date:   Sat, 18 Jun 2022 20:56:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:103.0) Gecko/20100101
 Thunderbird/103.0a1
Subject: Re: [PATCH] LoongArch: Add vDSO syscall __vdso_getcpu()
Content-Language: en-US
To:     Huacai Chen <chenhuacai@kernel.org>, hev <r@hev.cc>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20220617145828.582117-1-chenhuacai@loongson.cn>
 <CAHirt9hRs_iTvAZ=UxBBK448j7p+pYxKsMVise=Jj2qCtNky2Q@mail.gmail.com>
 <CAAhV-H4=04qygAFqm36RBM-ktXhO7M8HMBeCPBOnB8xYz268Zw@mail.gmail.com>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAAhV-H4=04qygAFqm36RBM-ktXhO7M8HMBeCPBOnB8xYz268Zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/18/22 17:10, Huacai Chen wrote:
> Hi,
>
> On Fri, Jun 17, 2022 at 11:35 PM hev <r@hev.cc> wrote:
>> Hello,
>>
>> On Fri, Jun 17, 2022 at 10:57 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
>>> We test 20 million times of getcpu(), the real syscall version take 25
>>> seconds, while the vsyscall version take only 2.4 seconds.
>>>
>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>>> ---
>>>   arch/loongarch/include/asm/vdso.h      |  4 +++
>>>   arch/loongarch/include/asm/vdso/vdso.h | 10 +++++-
>>>   arch/loongarch/kernel/vdso.c           | 23 +++++++++-----
>>>   arch/loongarch/vdso/Makefile           |  3 +-
>>>   arch/loongarch/vdso/vdso.lds.S         |  1 +
>>>   arch/loongarch/vdso/vgetcpu.c          | 43 ++++++++++++++++++++++++++
>>>   6 files changed, 74 insertions(+), 10 deletions(-)
>>>   create mode 100644 arch/loongarch/vdso/vgetcpu.c
>>>
>>> diff --git a/arch/loongarch/include/asm/vdso.h b/arch/loongarch/include/asm/vdso.h
>>> index 8f8a0f9a4953..e76d5e37480d 100644
>>> --- a/arch/loongarch/include/asm/vdso.h
>>> +++ b/arch/loongarch/include/asm/vdso.h
>>> @@ -12,6 +12,10 @@
>>>
>>>   #include <asm/barrier.h>
>>>
>>> +typedef struct vdso_pcpu_data {
>>> +       u32 node;
>>> +} ____cacheline_aligned_in_smp vdso_pcpu_data;
>>> +
>>>   /*
>>>    * struct loongarch_vdso_info - Details of a VDSO image.
>>>    * @vdso: Pointer to VDSO image (page-aligned).
>>> diff --git a/arch/loongarch/include/asm/vdso/vdso.h b/arch/loongarch/include/asm/vdso/vdso.h
>>> index 5a01643a65b3..94055f7c54b7 100644
>>> --- a/arch/loongarch/include/asm/vdso/vdso.h
>>> +++ b/arch/loongarch/include/asm/vdso/vdso.h
>>> @@ -8,6 +8,13 @@
>>>
>>>   #include <asm/asm.h>
>>>   #include <asm/page.h>
>>> +#include <asm/vdso.h>
>>> +
>>> +#if PAGE_SIZE < SZ_16K
>>> +#define VDSO_DATA_SIZE SZ_16K
>> Whether we add members to the vdso data structure or extend
>> SMP_CACHE_BYTES/NR_CPUS, the static VDSO_DATA_SIZE may not match, and
>> there is no assertion checking to help us catch bugs early. So I
>> suggest defining VDSO_DATA_SIZE as ALIGN_UP(sizeof (struct vdso_data),
>> PAGE_SIZE).
> VSYSCALL usage is very limited (you know, VSYSCALL appears for so many
> years, but the number nearly doesn't increase until now), so I think
> 16KB is enough in the future.

I don't think omitting compile-time assertions for *correctness* is 
worth the negligible improvement in brevity and ease of maintenance. In 
fact, static checks for correctness actually *lightens* maintenance 
burden, by explicitly calling out the assumptions so that newcomers 
(i.e. me or some other random linux/arch developer refactoring code) 
would find them very helpful.

So I'm in support for declaring the VDSO_DATA_SIZE explicitly in terms 
of sizeof(struct vdso_data) and PAGE_SIZE.
