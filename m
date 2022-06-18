Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A525504E2
	for <lists+linux-arch@lfdr.de>; Sat, 18 Jun 2022 14:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbiFRMvB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Jun 2022 08:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiFRMvA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Jun 2022 08:51:00 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7481A60D1
        for <linux-arch@vger.kernel.org>; Sat, 18 Jun 2022 05:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1655556654; bh=IXkz4yFfHv4KGGQdolooZQBRBBDkTchZCc0yfNdHTm8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=P6/h6W3tZEp+WXvDCsXHYbt1HSkroSs+DEs+PZFFnr4qX6zV+rCZVGkFKXQ42Prpu
         LwY9GILZGG/q+o2uEMq3zqIDlyKQG1UGVCs5WhBOKSeZhtYR1FwVUtDtmYswcXizNM
         Eb1aNPz9l4OGq/0CnHZoasOk8hJ0rncTPC3jPUNA=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 81932600B5;
        Sat, 18 Jun 2022 20:50:54 +0800 (CST)
Message-ID: <bcc38a55-30dc-98a8-cbfc-5a51924b9373@xen0n.name>
Date:   Sat, 18 Jun 2022 20:50:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:103.0) Gecko/20100101
 Thunderbird/103.0a1
Subject: Re: [PATCH] LoongArch: Add qspinlock support
To:     Guo Ren <guoren@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>
References: <20220617145705.581985-1-chenhuacai@loongson.cn>
 <CAK8P3a2nD_Zxv5X_LB7AbO=kxHQyk3vz09fQZ-TTX4PL0b3g1g@mail.gmail.com>
 <CAJF2gTT_etFg7-N4f=A4LMOYvd3+H505e0xt8NyxK4uPtkuEXg@mail.gmail.com>
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAJF2gTT_etFg7-N4f=A4LMOYvd3+H505e0xt8NyxK4uPtkuEXg@mail.gmail.com>
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

On 6/18/22 01:45, Guo Ren wrote:
>
>> I see that the qspinlock() code actually calls a 'relaxed' version of xchg16(),
>> but you only implement the one with the full barrier. Is it possible to
>> directly provide a relaxed version that has something less than the
>> __WEAK_LLSC_MB?
> I am also curious that __WEAK_LLSC_MB is very magic. How does it
> prevent preceded accesses from happening after sc for a strong
> cmpxchg?
>
> #define __cmpxchg_asm(ld, st, m, old, new)                              \
> ({                                                                      \
>          __typeof(old) __ret;                                            \
>                                                                          \
>          __asm__ __volatile__(                                           \
>          "1:     " ld "  %0, %2          # __cmpxchg_asm \n"             \
>          "       bne     %0, %z3, 2f                     \n"             \
>          "       or      $t0, %z4, $zero                 \n"             \
>          "       " st "  $t0, %1                         \n"             \
>          "       beq     $zero, $t0, 1b                  \n"             \
>          "2:                                             \n"             \
>          __WEAK_LLSC_MB                                                  \
>
> And its __smp_mb__xxx are just defined as a compiler barrier()?
> #define __smp_mb__before_atomic()       barrier()
> #define __smp_mb__after_atomic()        barrier()
I know this one. There is only one type of barrier defined in the v1.00 
of LoongArch, that is the full barrier, but this is going to change. 
Huacai hinted in the bringup patchset that 3A6000 and later models would 
have finer-grained barriers. So these indeed could be relaxed in the 
future, just that Huacai has to wait for their embargo to expire.
