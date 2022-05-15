Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47908527550
	for <lists+linux-arch@lfdr.de>; Sun, 15 May 2022 06:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbiEOENr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 15 May 2022 00:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiEOENq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 15 May 2022 00:13:46 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB2024F30;
        Sat, 14 May 2022 21:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1652588019; bh=lc3ngU5nSuKbe6EtREIVXc2ZMyuln1EUfr40RDHFWBA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=es5Iv0rA29f3lk6MuVEmPmVGLyL+h85kELo5lxwD+S2cqIFGuRd3k/rrhOxbNARhd
         tsSHji69dvNdqM0pzK2H7p30IuJoUPPRpXfaXrJCNAOeaen3KBq+EStRu5y7yySWBF
         Bzb44x2ZIm2jM7OzaJ8Wkp0ykPQ959Q67aeA8WIA=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 43BED600B5;
        Sun, 15 May 2022 12:13:39 +0800 (CST)
Message-ID: <689e103a-07f0-a55c-9b34-073cf81f84c0@xen0n.name>
Date:   Sun, 15 May 2022 12:13:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0a1
Subject: Re: [PATCH V3 03/22] LoongArch: Add elf-related definitions
Content-Language: en-US
To:     Huacai Chen <chenhuacai@gmail.com>, WANG Xuerui <kernel@xen0n.name>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20220514080402.2650181-1-chenhuacai@loongson.cn>
 <20220514080402.2650181-4-chenhuacai@loongson.cn>
 <25efb0c1-f2e7-0052-c925-08dd778d7ad7@xen0n.name>
 <CAAhV-H6rBtmTQTpxdZtk26sP9SJui5dpv2e-2ZUyWTtpxpf9FQ@mail.gmail.com>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAAhV-H6rBtmTQTpxdZtk26sP9SJui5dpv2e-2ZUyWTtpxpf9FQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/14/22 22:11, Huacai Chen wrote:

> Hi, Xuerui,
>
> On Sat, May 14, 2022 at 9:29 PM WANG Xuerui <kernel@xen0n.name> wrote:
>> Hi,
>>
>> Why this patch is from V3? I guess it's by mistake so would you re-send
>> a proper v10?
> This is just a typo, it is really V10.
Okay, got it.
>
> Huacai
>> On 5/14/22 16:03, Huacai Chen wrote:
>>> Add elf-related definitions for LoongArch, including: EM_LOONGARCH,
>>> KEXEC_ARCH_LOONGARCH, AUDIT_ARCH_LOONGARCH32, AUDIT_ARCH_LOONGARCH64
>>> and NT_LOONGARCH_*.
>>>
>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>>> ---
>>>    include/uapi/linux/audit.h  | 2 ++
>>>    include/uapi/linux/elf-em.h | 1 +
>>>    include/uapi/linux/elf.h    | 5 +++++
>>>    include/uapi/linux/kexec.h  | 1 +
>>>    scripts/sorttable.c         | 5 +++++
>>>    5 files changed, 14 insertions(+)

The code changes all look good to me, only minor typographic nit: please 
change "elf" to "ELF".

With that:

Reviewed-by: WANG Xuerui <git@xen0n.name>

