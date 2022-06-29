Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A5F560086
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jun 2022 14:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbiF2MxW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Jun 2022 08:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbiF2MxV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Jun 2022 08:53:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 506B626AE1
        for <linux-arch@vger.kernel.org>; Wed, 29 Jun 2022 05:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656507198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WawQclrD5oXLJMHnyF+hbLilMGfaF/QFoHaiLc0vsok=;
        b=MnW8q9vLimK0eCOK0gpyxqS4OsNJpArkL2fLkCd8JelZaNUQabrI6FJ6isXEz+MhCdBILk
        AkFKjfws8WpgzA+jWb3iFC3mD7xacXjHNZqKNvY01DOAngl1nQPryDFJf9saJCA5bccxxA
        i60kSukvoTb4cZSoN3gqxK/GkIg7Os0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357-xDH1LqjePcWGr5D--bAMXA-1; Wed, 29 Jun 2022 08:53:12 -0400
X-MC-Unique: xDH1LqjePcWGr5D--bAMXA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 072FC801233;
        Wed, 29 Jun 2022 12:53:12 +0000 (UTC)
Received: from [10.22.17.197] (unknown [10.22.17.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 87B5C492C3B;
        Wed, 29 Jun 2022 12:53:11 +0000 (UTC)
Message-ID: <1a6f3163-02af-0235-b212-b72c7db6865b@redhat.com>
Date:   Wed, 29 Jun 2022 08:53:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V7 4/5] asm-generic: spinlock: Add combo spinlock (ticket
 & queued)
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Guo Ren <guoren@kernel.org>, Palmer Dabbelt <palmer@rivosinc.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20220628081707.1997728-1-guoren@kernel.org>
 <20220628081707.1997728-5-guoren@kernel.org>
 <09abc75e-2ffb-1ab5-d0fc-1c15c943948d@redhat.com>
 <CAJF2gTQZzOtOsq0DV48Gi76UtBSa+vdY7dLZmoPD_OFUZ0Wbrg@mail.gmail.com>
 <5166750c-3dc6-9b09-4a1e-cd53141cdde8@redhat.com>
 <CAK8P3a2jQ+UQ54=QcpyVt91vXRyZrvUtOygFYOHWTBzse3q3rg@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CAK8P3a2jQ+UQ54=QcpyVt91vXRyZrvUtOygFYOHWTBzse3q3rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/29/22 03:08, Arnd Bergmann wrote:
> On Wed, Jun 29, 2022 at 3:34 AM Waiman Long <longman@redhat.com> wrote:
>> On 6/28/22 21:17, Guo Ren wrote:
>>> On Wed, Jun 29, 2022 at 2:13 AM Waiman Long <longman@redhat.com> wrote:
>>>> On 6/28/22 04:17, guoren@kernel.org wrote:
>>>>
>>>> So the current config setting determines if qspinlock will be used, not
>>>> some boot time parameter that user needs to specify. This patch will
>>>> just add useless code to lock/unlock sites. I don't see any benefit of
>>>> doing that.
>>> This is a startup patch for riscv. next, we could let vendors make choices.
>>> I'm not sure they like cmdline or vendor-specific errata style.
>>>
>>> Eventually, we would let one riscv Image support all machines, some
>>> use ticket-lock, and some use qspinlock.
>> OK. Maybe you can postpone this combo spinlock until there is a good use
>> case for it. Upstream usually don't accept patches that have no good use
>> case yet.
> I think the usecase on risc-v is this: there are cases where the qspinlock
> is preferred for performance reasons, but there are also CPU cores on
> which it is not safe to use. risc-v like most modern architectures has a
> strict rule about being able to build kernels that work on all machines,
> so without something like this, it would not be able to use qspinlock at all.

My objection for the current patch is really on the fact that everything 
is determined at compiled time. So there is no point to use static key 
if it cannot be changed at the boot time. Adding a boot time switch do 
make the use of static key more reasonable.


>
> On the other hand, I don't really like the idea of putting the static-key
> wrapper into the asm-generic header. Especially the ticket spinlock
> implementation should be simple and not depend on jump labels.
>
>  From looking at the header file dependencies on arm64, I know that
> putting jump labels into core infrastructure like the arch_spin_lock()
> makes a big mess of indirect includes and measurably slows down
> the kernel build.
>
> I think this can still be done in the riscv asm/spinlock.h header with
> minimal impact on the asm-generic file if the riscv maintainers see
> a significant enough advantage, but I don't want it in the common code.

I have a similar feeling. In addition, I don't like the idea of adding a 
static key to qspinlock.c that have nothing to do with the qspinlock 
logic. I would like to see it put elsewhere.

Cheers,
Longman

