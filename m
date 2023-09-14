Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811307A0BB1
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 19:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239044AbjINR02 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 13:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240437AbjINR0I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 13:26:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F4C830EA
        for <linux-arch@vger.kernel.org>; Thu, 14 Sep 2023 10:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694712245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N0ikbkJVQghcPjJgsQrA+sUTUrPSvE6Jh+YB8KXgR/g=;
        b=LxL+JCMoq+wsN2L8GhWUCwWLcS7s4cupfTunPzkyk3Iz8u5lQsG1HxGSOVBRHZLQq/s5XL
        Ivm71M2V8OaiAI3GtEHehjN5h0CmUrG0MSNqYteTiuF4/Ff6M7FNZts6OPnO6Sh8keg+zU
        i4+u6NFdjV17sbVESFblka4Htvr1ej8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-41-mt1uKXGTNm6m770irEEv9Q-1; Thu, 14 Sep 2023 13:24:02 -0400
X-MC-Unique: mt1uKXGTNm6m770irEEv9Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1F4684ACAA;
        Thu, 14 Sep 2023 17:24:00 +0000 (UTC)
Received: from [10.22.34.133] (unknown [10.22.34.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5003640C2070;
        Thu, 14 Sep 2023 17:23:57 +0000 (UTC)
Message-ID: <fb7d6e67-f396-dfe7-1461-8790bdeaad01@redhat.com>
Date:   Thu, 14 Sep 2023 13:23:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V11 07/17] riscv: qspinlock: Introduce qspinlock param for
 command line
Content-Language: en-US
To:     Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>
Cc:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, boqun.feng@gmail.com, tglx@linutronix.de,
        paulmck@kernel.org, rostedt@goodmis.org, rdunlap@infradead.org,
        catalin.marinas@arm.com, conor.dooley@microchip.com,
        xiaoguang.xing@sophgo.com, bjorn@rivosinc.com,
        alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-8-guoren@kernel.org>
 <5ba0b8f3-f8f5-3a25-e9b7-f29a1abe654a@redhat.com>
 <CAJF2gTT2hRxgnQt+WJ9P0YBWnUaZJ1-9g3ZE9tOz_MiLSsUjwQ@mail.gmail.com>
 <ZQK2-CIL9U_QdMjh@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZQK2-CIL9U_QdMjh@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/14/23 03:32, Leonardo Bras wrote:
> On Tue, Sep 12, 2023 at 09:08:34AM +0800, Guo Ren wrote:
>> On Mon, Sep 11, 2023 at 11:34 PM Waiman Long <longman@redhat.com> wrote:
>>> On 9/10/23 04:29, guoren@kernel.org wrote:
>>>> From: Guo Ren <guoren@linux.alibaba.com>
>>>>
>>>> Allow cmdline to force the kernel to use queued_spinlock when
>>>> CONFIG_RISCV_COMBO_SPINLOCKS=y.
>>>>
>>>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>>>> Signed-off-by: Guo Ren <guoren@kernel.org>
>>>> ---
>>>>    Documentation/admin-guide/kernel-parameters.txt |  2 ++
>>>>    arch/riscv/kernel/setup.c                       | 16 +++++++++++++++-
>>>>    2 files changed, 17 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>>> index 7dfb540c4f6c..61cacb8dfd0e 100644
>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>> @@ -4693,6 +4693,8 @@
>>>>                        [KNL] Number of legacy pty's. Overwrites compiled-in
>>>>                        default number.
>>>>
>>>> +     qspinlock       [RISCV] Force to use qspinlock or auto-detect spinlock.
>>>> +
>>>>        qspinlock.numa_spinlock_threshold_ns=   [NUMA, PV_OPS]
>>>>                        Set the time threshold in nanoseconds for the
>>>>                        number of intra-node lock hand-offs before the
>>>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>>>> index a447cf360a18..0f084f037651 100644
>>>> --- a/arch/riscv/kernel/setup.c
>>>> +++ b/arch/riscv/kernel/setup.c
>>>> @@ -270,6 +270,15 @@ static void __init parse_dtb(void)
>>>>    }
>>>>
>>>>    #ifdef CONFIG_RISCV_COMBO_SPINLOCKS
>>>> +bool enable_qspinlock_key = false;
>>> You can use __ro_after_init qualifier for enable_qspinlock_key. BTW,
>>> this is not a static key, just a simple flag. So what is the point of
>>> the _key suffix?
>> Okay, I would change it to:
>> bool enable_qspinlock_flag __ro_after_init = false;
> IIUC, this bool / flag is used in a single file, so it makes sense for it
> to be static. Being static means it does not need to be initialized to
> false, as it's standard to zero-fill this areas.
>
> Also, since it's a bool, it does not need to be called _flag.
>
> I would go with:
>
> static bool enable_qspinlock __ro_after_init;

I actually was thinking about the same suggestion to add static. Then I 
realized that the flag was also used in another file in a later patch. 
Of course, if it turns out that this flag is no longer needed outside of 
this file, it should be static.

Cheers,
Longman

