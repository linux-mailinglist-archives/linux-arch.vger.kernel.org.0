Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD21279F221
	for <lists+linux-arch@lfdr.de>; Wed, 13 Sep 2023 21:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjIMTdV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Sep 2023 15:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjIMTdU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Sep 2023 15:33:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62657B7
        for <linux-arch@vger.kernel.org>; Wed, 13 Sep 2023 12:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694633550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hr0iocCjf//0RhyjTv2/Yc2Az/JEnnVmtYVPY2/RBDU=;
        b=aLSH4bclwxxQznSyueRBs+IwstsW1xgFFyaolWRV2Zbq0OZYVk8780R8TwG2dSXRgnAAel
        Wtes0GevJRuQerbFwHT7Eix4L40mz7oNFHYBjzn3P0ZyZHCt7XESTcYu9b0hCHB8Te8qKA
        AqQLAKGJP8Nh0KpaJVEOncKOaQ4yu8I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-rrV5uf9TM-OJdx_9e_fpbg-1; Wed, 13 Sep 2023 15:32:27 -0400
X-MC-Unique: rrV5uf9TM-OJdx_9e_fpbg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78504801FA0;
        Wed, 13 Sep 2023 19:32:25 +0000 (UTC)
Received: from [10.18.17.156] (dhcp-17-156.bos.redhat.com [10.18.17.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4016140C6EBF;
        Wed, 13 Sep 2023 19:32:23 +0000 (UTC)
Message-ID: <1f02232b-2ffc-797c-2331-a164322594d2@redhat.com>
Date:   Wed, 13 Sep 2023 15:32:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V10 07/19] riscv: qspinlock: errata: Introduce
 ERRATA_THEAD_QSPINLOCK
Content-Language: en-US
To:     Palmer Dabbelt <palmer@rivosinc.com>, sorear@fastmail.com
Cc:     guoren@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        anup@brainfault.org, peterz@infradead.org, mingo@redhat.com,
        Will Deacon <will@kernel.org>, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, Catalin Marinas <catalin.marinas@arm.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        xiaoguang.xing@sophgo.com, Bjorn Topel <bjorn@rivosinc.com>,
        alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, guoren@linux.alibaba.com
References: <mhng-ee184bd2-7666-402d-b0df-d484ed6d8236@palmer-ri-x1c9>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <mhng-ee184bd2-7666-402d-b0df-d484ed6d8236@palmer-ri-x1c9>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/13/23 14:54, Palmer Dabbelt wrote:
> On Sun, 06 Aug 2023 22:23:34 PDT (-0700), sorear@fastmail.com wrote:
>> On Wed, Aug 2, 2023, at 12:46 PM, guoren@kernel.org wrote:
>>> From: Guo Ren <guoren@linux.alibaba.com>
>>>
>>> According to qspinlock requirements, RISC-V gives out a weak LR/SC
>>> forward progress guarantee which does not satisfy qspinlock. But
>>> many vendors could produce stronger forward guarantee LR/SC to
>>> ensure the xchg_tail could be finished in time on any kind of
>>> hart. T-HEAD is the vendor which implements strong forward
>>> guarantee LR/SC instruction pairs, so enable qspinlock for T-HEAD
>>> with errata help.
>>>
>>> T-HEAD early version of processors has the merge buffer delay
>>> problem, so we need ERRATA_WRITEONCE to support qspinlock.
>>>
>>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>>> Signed-off-by: Guo Ren <guoren@kernel.org>
>>> ---
>>>  arch/riscv/Kconfig.errata              | 13 +++++++++++++
>>>  arch/riscv/errata/thead/errata.c       | 24 ++++++++++++++++++++++++
>>>  arch/riscv/include/asm/errata_list.h   | 20 ++++++++++++++++++++
>>>  arch/riscv/include/asm/vendorid_list.h |  3 ++-
>>>  arch/riscv/kernel/cpufeature.c         |  3 ++-
>>>  5 files changed, 61 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
>>> index 4745a5c57e7c..eb43677b13cc 100644
>>> --- a/arch/riscv/Kconfig.errata
>>> +++ b/arch/riscv/Kconfig.errata
>>> @@ -96,4 +96,17 @@ config ERRATA_THEAD_WRITE_ONCE
>>>
>>>        If you don't know what to do here, say "Y".
>>>
>>> +config ERRATA_THEAD_QSPINLOCK
>>> +    bool "Apply T-Head queued spinlock errata"
>>> +    depends on ERRATA_THEAD
>>> +    default y
>>> +    help
>>> +      The T-HEAD C9xx processors implement strong fwd guarantee 
>>> LR/SC to
>>> +      match the xchg_tail requirement of qspinlock.
>>> +
>>> +      This will apply the QSPINLOCK errata to handle the non-standard
>>> +      behavior via using qspinlock instead of ticket_lock.
>>> +
>>> +      If you don't know what to do here, say "Y".
>>
>> If this is to be applied, I would like to see a detailed explanation 
>> somewhere,
>> preferably with citations, of:
>>
>> (a) The memory model requirements for qspinlock

The part of qspinlock that causes problem with many RISC architectures 
is its use of a 16-bit xchg() function call which many RISC 
architectures cannot do it natively and have to be emulated with 
hopefully some forward progress guarantee. Except that one call, the 
other atomic operations are all 32 bit in size.

Cheers,
Longman

