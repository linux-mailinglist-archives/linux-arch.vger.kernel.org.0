Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FF7552653
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jun 2022 23:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245324AbiFTVQZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jun 2022 17:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245567AbiFTVQX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2022 17:16:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FEE665B2
        for <linux-arch@vger.kernel.org>; Mon, 20 Jun 2022 14:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655759781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lZhHQwIP7ahDScS1KF5bFADmc8igjElNlRZM3fUDtks=;
        b=BH/1ahN/IBz4POLy2z/ouapMl1pIqAhQ/WNdncTctlM3dDtRrcLsPAQByOMGtyTKTFcD8b
        iW+EarP4e2Q4NQwXjz6ErqMTIUolzIqVsLZcEyWVe3igkMwppOLfWyHWG/11nnB9XZhdfW
        Hq6xVz54HSJtXSdjFPRXtzDB5WbrbmE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-363-vY5Lfy5bNyG3eOm35UQymw-1; Mon, 20 Jun 2022 17:16:17 -0400
X-MC-Unique: vY5Lfy5bNyG3eOm35UQymw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68E2E3C02B75;
        Mon, 20 Jun 2022 21:16:16 +0000 (UTC)
Received: from [10.22.32.175] (unknown [10.22.32.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB067141510C;
        Mon, 20 Jun 2022 21:16:15 +0000 (UTC)
Message-ID: <f6513b4f-ef62-fd40-b031-27c9b7f57e00@redhat.com>
Date:   Mon, 20 Jun 2022 17:16:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V5] riscv: Add qspinlock support
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
References: <20220620155404.1968739-1-guoren@kernel.org>
 <CAK8P3a2enbvE9a5V=JpUFt7FfyDGLQHTWTszibqqLVoeiMAo5Q@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CAK8P3a2enbvE9a5V=JpUFt7FfyDGLQHTWTszibqqLVoeiMAo5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 6/20/22 16:42, Arnd Bergmann wrote:
> On Mon, Jun 20, 2022 at 5:54 PM <guoren@kernel.org> wrote:
>>> +config RISCV_USE_QUEUED_SPINLOCKS
>> +       bool "Using queued spinlock instead of ticket-lock"
> Maybe we can just make ARCH_USE_QUEUED_SPINLOCKS
> user visible and give users the choice between the two generic
> implementations across all architectures that support the qspinlock
> variant.
>
> In arch/riscv, you'd then just have a
>
>          select ARCH_HAVE_QUEUED_SPINLOCKS
>
> diff --git a/arch/riscv/include/asm/spinlock.h
> b/arch/riscv/include/asm/spinlock.h
>> new file mode 100644
>> index 000000000000..fd3fd09cff52
>> --- /dev/null
>> +++ b/arch/riscv/include/asm/spinlock.h
>> @@ -0,0 +1,12 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __ASM_SPINLOCK_H
>> +#define __ASM_SPINLOCK_H
>> +
>> +#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
>> +#include <asm/qspinlock.h>
>> +#include <asm/qrwlock.h>
>> +#else
>> +#include <asm-generic/spinlock.h>
>> +#endif
>> +
> Along the same lines:
>
> I think I'd prefer the header changes to be done in the asm-generic
> version of this file, so this can be shared across all architectures
> that want to give the choice between ticket and queued spinlock.

I concur. Qspinlock is only needed if we want to support systems with a 
large number of CPUs. For systems with a small number of CPUs. It 
doesn't matter if qspinlock or the ticket lock is being used.

Cheers,
Longman

