Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAE94DCCDD
	for <lists+linux-arch@lfdr.de>; Thu, 17 Mar 2022 18:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbiCQRsV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Mar 2022 13:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237081AbiCQRsS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Mar 2022 13:48:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2F591F6F15
        for <linux-arch@vger.kernel.org>; Thu, 17 Mar 2022 10:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647539215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=llqjR9J1FmybTT0pHxsozwhPdyLYqoq+OgcFl5fMvI4=;
        b=W6Z+VFxTqMJjG986WwXZeCTShLGTa4JjoyItwsT7jfRu838qXWwT/PxJwwuh2zfzIB00Pd
        OSDrAbxF4Z+7XQ95MYeC6eIDx669LourM67FWbkLhVvFb0bwtS7LNrH4UYTT8GeBURHGut
        DZn9coZMXrSZELjThptPPih0hiJbXpk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-D_1JD0DkM1yNyRBj3b6jGg-1; Thu, 17 Mar 2022 13:46:49 -0400
X-MC-Unique: D_1JD0DkM1yNyRBj3b6jGg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A59218A6584;
        Thu, 17 Mar 2022 17:46:48 +0000 (UTC)
Received: from [10.22.8.95] (unknown [10.22.8.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4EC33401E87;
        Thu, 17 Mar 2022 17:46:47 +0000 (UTC)
Message-ID: <67ba2190-dd72-4ad0-32c2-de43418b73a2@redhat.com>
Date:   Thu, 17 Mar 2022 13:46:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/5] asm-generic: qspinlock: Indicate the use of
 mixed-size atomics
Content-Language: en-US
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        linux-riscv@lists.infradead.org, peterz@infradead.org
Cc:     jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        shorne@gmail.com, mingo@redhat.com, Will Deacon <will@kernel.org>,
        boqun.feng@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, jszhang@kernel.org,
        wangkefeng.wang@huawei.com, openrisc@lists.librecores.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20220316232600.20419-1-palmer@rivosinc.com>
 <20220316232600.20419-2-palmer@rivosinc.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220316232600.20419-2-palmer@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/16/22 19:25, Palmer Dabbelt wrote:
> From: Peter Zijlstra <peterz@infradead.org>
>
> The qspinlock implementation depends on having well behaved mixed-size
> atomics.  This is true on the more widely-used platforms, but these
> requirements are somewhat subtle and may not be satisfied by all the
> platforms that qspinlock is used on.
>
> Document these requirements, so ports that use qspinlock can more easily
> determine if they meet these requirements.
>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>
> ---
>
> I have specifically not included Peter's SOB on this, as he sent his
> original patch
> <https://lore.kernel.org/lkml/YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net/>
> without one.
> ---
>   include/asm-generic/qspinlock.h | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
>
> diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
> index d74b13825501..a7a1296b0b4d 100644
> --- a/include/asm-generic/qspinlock.h
> +++ b/include/asm-generic/qspinlock.h
> @@ -2,6 +2,36 @@
>   /*
>    * Queued spinlock
>    *
> + * A 'generic' spinlock implementation that is based on MCS locks. An
> + * architecture that's looking for a 'generic' spinlock, please first consider
> + * ticket-lock.h and only come looking here when you've considered all the
> + * constraints below and can show your hardware does actually perform better
> + * with qspinlock.
> + *
> + *
> + * It relies on atomic_*_release()/atomic_*_acquire() to be RCsc (or no weaker
> + * than RCtso if you're power), where regular code only expects atomic_t to be
> + * RCpc.
> + *
> + * It relies on a far greater (compared to ticket-lock.h) set of atomic
> + * operations to behave well together, please audit them carefully to ensure
> + * they all have forward progress. Many atomic operations may default to
> + * cmpxchg() loops which will not have good forward progress properties on
> + * LL/SC architectures.
> + *
> + * One notable example is atomic_fetch_or_acquire(), which x86 cannot (cheaply)
> + * do. Carefully read the patches that introduced queued_fetch_set_pending_acquire().
> + *
> + * It also heavily relies on mixed size atomic operations, in specific it
> + * requires architectures to have xchg16; something which many LL/SC
> + * architectures need to implement as a 32bit and+or in order to satisfy the
> + * forward progress guarantees mentioned above.
> + *
> + * Further reading on mixed size atomics that might be relevant:
> + *
> + *   http://www.cl.cam.ac.uk/~pes20/popl17/mixed-size.pdf
> + *
> + *
>    * (C) Copyright 2013-2015 Hewlett-Packard Development Company, L.P.
>    * (C) Copyright 2015 Hewlett-Packard Enterprise Development LP
>    *
Acked-by: Waiman Long <longman@redhat.com>

Note that it references ticket-lock.h. Perhaps we should reverse the 
order of patches 1 & 2.

Cheers,
Longman

