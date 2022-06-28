Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305E455EBFA
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jun 2022 20:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbiF1SGW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jun 2022 14:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbiF1SGE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jun 2022 14:06:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29FB51D31A
        for <linux-arch@vger.kernel.org>; Tue, 28 Jun 2022 11:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656439560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5GEsiZ5pfkbMA5kewtyoQDVS/PBlIbuW5xmHg+1qqHA=;
        b=AzTJqAMvZjTJ0cPd9c0C3lRIXHbJ3nSVwgb7CWzmfx1NfIrL72v7ukI0DDTgaQZWTZVJw9
        014ZETS255YO8b2ADhuvTJRAPxrC0aeXb79Hj7mNhErJrpse1Ynq0LIkNTb/QZWEykElxT
        5h5w8IwEBss4R91GlM9pQGwj20h5z40=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-127-oUIR4xKhNb2y20GilZVQww-1; Tue, 28 Jun 2022 14:05:56 -0400
X-MC-Unique: oUIR4xKhNb2y20GilZVQww-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4018389B841;
        Tue, 28 Jun 2022 18:05:56 +0000 (UTC)
Received: from [10.22.34.187] (unknown [10.22.34.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC80140334D;
        Tue, 28 Jun 2022 18:05:55 +0000 (UTC)
Message-ID: <218522c9-97b9-7659-ce31-2dbc4b0c6a60@redhat.com>
Date:   Tue, 28 Jun 2022 14:05:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V7 1/5] asm-generic: ticket-lock: Remove unnecessary
 atomic_read
Content-Language: en-US
To:     guoren@kernel.org, palmer@rivosinc.com, arnd@arndb.de,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20220628081707.1997728-1-guoren@kernel.org>
 <20220628081707.1997728-2-guoren@kernel.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220628081707.1997728-2-guoren@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/28/22 04:17, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Remove unnecessary atomic_read in arch_spin_value_unlocked(lock),
> because the value has been in lock. This patch could prevent
> arch_spin_value_unlocked contend spin_lock data again.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>   include/asm-generic/spinlock.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
> index fdfebcb050f4..f1e4fa100f5a 100644
> --- a/include/asm-generic/spinlock.h
> +++ b/include/asm-generic/spinlock.h
> @@ -84,7 +84,9 @@ static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
>   
>   static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
>   {
> -	return !arch_spin_is_locked(&lock);
> +	u32 val = lock.counter;
> +
> +	return ((val >> 16) == (val & 0xffff));
>   }
>   
>   #include <asm/qrwlock.h>

lockref.c is the only current user of arch_spin_value_unlocked(). This 
change is probably OK with this particular use case. Do you have any 
performance data about the improvement due to this change?

You may have to document that we have to revisit that if another use 
case shows up.

Cheers,
Longman

