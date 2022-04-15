Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1F0502E29
	for <lists+linux-arch@lfdr.de>; Fri, 15 Apr 2022 19:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbiDORFX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Apr 2022 13:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356098AbiDORFV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Apr 2022 13:05:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86B699D07C
        for <linux-arch@vger.kernel.org>; Fri, 15 Apr 2022 10:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650042171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZzBogzvEUo8J9TgEmB5sb1Fv1z0k0Lt5IOZ/xOeDFpw=;
        b=Fir3usGGicsxIIRRk3Hm1Xl7tY+M684AL5AETZWxr8Rn5BcLkaZCpPHnHiQdmVjqwj4l4V
        19xjTSu19GBx+l2OX2b9iUUGwY8I6BXEdfvzhHShvo1AwQbdTvdtDxXHXymFymtpwkL+1R
        OBOs+K2cmjBhSkmCrAZO4Q2/0lGp0Nk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-499-7v658Eh0O260N3sQjcrLhg-1; Fri, 15 Apr 2022 13:02:48 -0400
X-MC-Unique: 7v658Eh0O260N3sQjcrLhg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E2723C18535;
        Fri, 15 Apr 2022 17:02:47 +0000 (UTC)
Received: from [10.22.32.72] (unknown [10.22.32.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95928202F320;
        Fri, 15 Apr 2022 17:02:42 +0000 (UTC)
Message-ID: <8f2a3903-ab49-23cc-a362-a9857dc38410@redhat.com>
Date:   Fri, 15 Apr 2022 13:02:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/7] asm-generic: ticket-lock: New generic ticket-based
 spinlock
Content-Language: en-US
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, heiko@sntech.de, guoren@kernel.org,
        shorne@gmail.com, peterz@infradead.org, mingo@redhat.com,
        Will Deacon <will@kernel.org>, boqun.feng@gmail.com,
        jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, macro@orcam.me.uk,
        Greg KH <gregkh@linuxfoundation.org>,
        sudipm.mukherjee@gmail.com, wangkefeng.wang@huawei.com,
        jszhang@kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, openrisc@lists.librecores.org,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
References: <mhng-f4d144dd-b6ed-4f3f-bfc3-6dc29fab14e4@palmer-ri-x1c9>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <mhng-f4d144dd-b6ed-4f3f-bfc3-6dc29fab14e4@palmer-ri-x1c9>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/15/22 12:46, Palmer Dabbelt wrote:
>
>>> diff --git a/include/asm-generic/spinlock_types.h 
>>> b/include/asm-generic/spinlock_types.h
>>> new file mode 100644
>>> index 000000000000..e56ddb84d030
>>> --- /dev/null
>>> +++ b/include/asm-generic/spinlock_types.h
>>> @@ -0,0 +1,17 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +
>>> +#ifndef __ASM_GENERIC_TICKET_LOCK_TYPES_H
>>> +#define __ASM_GENERIC_TICKET_LOCK_TYPES_H
>>> +
>>> +#include <linux/types.h>
>>> +typedef atomic_t arch_spinlock_t;
>>> +
>>> +/*
>>> + * qrwlock_types depends on arch_spinlock_t, so we must typedef 
>>> that before the
>>> + * include.
>>> + */
>>> +#include <asm/qrwlock_types.h>
>>
>> I believe that if you guard the include line by
>>
>> #ifdef CONFIG_QUEUED_RWLOCK
>> #include <asm/qrwlock_types.h>
>> #endif
>>
>> You may not need to do the hack in patch 5.
>
> Yes, and we actually had it that way the first time around 
> (specifically the ARCH_USES_QUEUED_RWLOCKS, but IIUC that's the same 
> here).  The goal was to avoid adding the ifdef to the asm-generic code 
> and instead keep the oddness in arch/riscv, it's only there for that 
> one commit (and just so we can split out the spinlock conversion from 
> the rwlock conversion, in case there's a bug and these need to be 
> bisected later).
>
> I'd also considered renaming qrwlock* to rwlock*, which would avoid 
> the ifdef and make it a touch easier to override the rwlock 
> implementation, but that didn't seem useful enough to warrant the 
> diff.  These all seem a bit more coupled than I expected them to be 
> (both {spin,qrw}lock{,_types}.h and the bits in linux/), I looked into 
> cleaning that up a bit but it seemed like too much for just the one 
> patch set.

Then you are forcing arches that use asm_generic/spinlock.h to use 
qrwlock as well. Even though most of them probably will, but forcing it 
this way remove the flexibility an arch may want to have.

The difference between CONFIG_QUEUED_RWLOCK and ARCH_USES_QUEUED_RWLOCKS 
is that qrwlock will not be compiled in when PREEMPT_RT || !SMP. So 
CONFIG_QUEUED_RWLOCK is a more accurate guard as to whether qrwlock 
should really be used.

Cheers,
Longman

