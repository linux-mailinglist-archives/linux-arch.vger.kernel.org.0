Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8B52994CC
	for <lists+linux-arch@lfdr.de>; Mon, 26 Oct 2020 19:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788999AbgJZSET (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Oct 2020 14:04:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30678 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1783355AbgJZSET (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Oct 2020 14:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603735457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xyYk0jDTOiwDBvTIIH8x0g5Fzg4mMedC/eOz+dtv1vA=;
        b=EGoMAB8c70N2Vd6harlkQ/FzmyntIYF1UqIzYUMlG4GJ0mt+GsCdiuRF2tp/2eA/CdvdsB
        yfosjulY4q6xeR5ptcNfEir0xqQElsSHC+XrBXYGs7bne9kLfAHFheHXPa45SyDbfqGdyo
        rH9MeR1Ju7nUvUBb3J5JTpTYSrcQOOk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-CJKsKjOFOAGlKBQTJpbv8A-1; Mon, 26 Oct 2020 14:03:11 -0400
X-MC-Unique: CJKsKjOFOAGlKBQTJpbv8A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12AD91015ED6;
        Mon, 26 Oct 2020 18:03:09 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-122.rdu2.redhat.com [10.10.118.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 762FD19647;
        Mon, 26 Oct 2020 18:03:07 +0000 (UTC)
Subject: Re: [PATCH] qspinlock: use signed temporaries for cmpxchg
To:     Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Matthew Wilcox <willy@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201026165807.3724647-1-arnd@kernel.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <022365e9-f7fe-5589-7867-d2ad2d33cfa3@redhat.com>
Date:   Mon, 26 Oct 2020 14:03:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20201026165807.3724647-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/26/20 12:57 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> When building with W=2, the build log is flooded with
>
> include/asm-generic/qrwlock.h:65:56: warning: pointer targets in passing argument 2 of 'atomic_try_cmpxchg_acquire' differ in signedness [-Wpointer-sign]
> include/asm-generic/qrwlock.h:92:53: warning: pointer targets in passing argument 2 of 'atomic_try_cmpxchg_acquire' differ in signedness [-Wpointer-sign]
> include/asm-generic/qspinlock.h:68:55: warning: pointer targets in passing argument 2 of 'atomic_try_cmpxchg_acquire' differ in signedness [-Wpointer-sign]
> include/asm-generic/qspinlock.h:82:52: warning: pointer targets in passing argument 2 of 'atomic_try_cmpxchg_acquire' differ in signedness [-Wpointer-sign]
>
> The atomics are built on top of signed integers, but the caller
> doesn't actually care. Just use signed types as well.
>
> Fixes: 27df89689e25 ("locking/spinlocks: Remove an instruction from spin and write locks")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   include/asm-generic/qrwlock.h   | 8 ++++----
>   include/asm-generic/qspinlock.h | 4 ++--
>   2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
> index 3aefde23dcea..84ce841ce735 100644
> --- a/include/asm-generic/qrwlock.h
> +++ b/include/asm-generic/qrwlock.h
> @@ -37,7 +37,7 @@ extern void queued_write_lock_slowpath(struct qrwlock *lock);
>    */
>   static inline int queued_read_trylock(struct qrwlock *lock)
>   {
> -	u32 cnts;
> +	int cnts;
>   
>   	cnts = atomic_read(&lock->cnts);
>   	if (likely(!(cnts & _QW_WMASK))) {
> @@ -56,7 +56,7 @@ static inline int queued_read_trylock(struct qrwlock *lock)
>    */
>   static inline int queued_write_trylock(struct qrwlock *lock)
>   {
> -	u32 cnts;
> +	int cnts;
>   
>   	cnts = atomic_read(&lock->cnts);
>   	if (unlikely(cnts))
> @@ -71,7 +71,7 @@ static inline int queued_write_trylock(struct qrwlock *lock)
>    */
>   static inline void queued_read_lock(struct qrwlock *lock)
>   {
> -	u32 cnts;
> +	int cnts;
>   
>   	cnts = atomic_add_return_acquire(_QR_BIAS, &lock->cnts);
>   	if (likely(!(cnts & _QW_WMASK)))
> @@ -87,7 +87,7 @@ static inline void queued_read_lock(struct qrwlock *lock)
>    */
>   static inline void queued_write_lock(struct qrwlock *lock)
>   {
> -	u32 cnts = 0;
> +	int cnts = 0;
>   	/* Optimize for the unfair lock case where the fair flag is 0. */
>   	if (likely(atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED)))
>   		return;
> diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
> index 4fe7fd0fe834..d74b13825501 100644
> --- a/include/asm-generic/qspinlock.h
> +++ b/include/asm-generic/qspinlock.h
> @@ -60,7 +60,7 @@ static __always_inline int queued_spin_is_contended(struct qspinlock *lock)
>    */
>   static __always_inline int queued_spin_trylock(struct qspinlock *lock)
>   {
> -	u32 val = atomic_read(&lock->val);
> +	int val = atomic_read(&lock->val);
>   
>   	if (unlikely(val))
>   		return 0;
> @@ -77,7 +77,7 @@ extern void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
>    */
>   static __always_inline void queued_spin_lock(struct qspinlock *lock)
>   {
> -	u32 val = 0;
> +	int val = 0;
>   
>   	if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL)))
>   		return;

Yes, it shouldn't really matter if the value is defined as int or u32. 
However, the only caveat that I see is queued_spin_lock_slowpath() is 
expecting a u32 argument. Maybe you should cast it back to (u32) when 
calling it.

Cheers,
Longman

