Return-Path: <linux-arch+bounces-5840-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 905FC9448BD
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 11:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99401C23F16
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 09:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A1816EB55;
	Thu,  1 Aug 2024 09:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeKnW2KV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31276EEB3;
	Thu,  1 Aug 2024 09:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722505710; cv=none; b=BnVm7eDez0CFh3jm+zsHbKaWcl4GOWC/BXhEvvZNKtkEpCcUcqEV6y1FzybJZdlGEUBmK3ki+KFergIPPbojC8f2Tco1+Q9D5sabZ/7NkQeNDkbRf33hVt2tf42Xped0aBKlroT4DagiSNBTpZ2gWU+tRGNSju341rnIlGELp1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722505710; c=relaxed/simple;
	bh=yzRx3qqsne4CO9bKA5CWL5HvidOc6mapjYG4wdAwzlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIkry8qYN/IhH+2Hz2lZXcoAUOU2VcBf/ewjOkjGnZDmMUuB9Yca8th9gYTMCDe4qUkrkdP5+dQySkSR3R//SbEe3OWu4fnesunZRBVYfiVv13GYTbRknhc5MD0zzhabXI6zLu1CQKRoy4mAfb1w8R+Fwys4C8EUOXwFJH2+ezY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YeKnW2KV; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a94478a4eso355318566b.1;
        Thu, 01 Aug 2024 02:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722505707; x=1723110507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BDG653oQy+GL48j0SxqopLPxRNvx49Ogi7ORA8x2yNw=;
        b=YeKnW2KVgFAsRnrpYfFFcNfXS4UTD5oSk6Q2fhFrPwtd25r1FiVTupa5LR+SruIKon
         gvLyYh31GtjEjgxi9sT1NWp1Idt1rPo3do+gW6QN6YthbHQqKM0NUfFT4upduEEjdAVt
         pOdtow7mFYtICFDBe3WMX2dv6bqWLMLIpfax4wRVLuNZLGUDn+PHWp7qNBmPM/RepV3v
         fRgA21hldcQhaJX6Qu7lHHVCpIqY4B/48+9l7H4zzQ6g8udIJfC/sIqoXN/OVInYuuU3
         CRzuD2xyu0+OT29EmdXkNUctnX82B+GKXRqc6t+vOwf8mqlErej6nc/9MpehblncbEJL
         Mplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722505707; x=1723110507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDG653oQy+GL48j0SxqopLPxRNvx49Ogi7ORA8x2yNw=;
        b=X0XjGfM088SJmT0LLB2uoVRtCZEReNuC6IGdATM3o5L6/oT4oLVS9Umxj9CpUeS6Nw
         QnrClutOjLvg2prTE/WEtM7wAydjKa/+2ILe15bve36Fi4yubCaJvthNTDxQVUPYPKXr
         eQQY0RBquiPBsN9pteUABvXV+hucO9lFt3qcY+TrtKdxmXAnc2BgJUo6C6cY38L7TAtv
         mfocWlwqsX3FKJBWE0QiFdV7UZnHFH7FOnCWxt5Heg+j6JZANcDIZKzWaFMETE54ju+8
         SkUWtzT39yDostEVTCTs50w0wepxAwwo3i1sAX79pBcs8xhPgzTghzSmrWhr4S9sIFA6
         M9bA==
X-Forwarded-Encrypted: i=1; AJvYcCUXoLnMd1zjp5ktr0Z3Swwjq9WShgH1c7k5770SPZ5bJs0SgKLGzHjHnSVBe8RKGb1QUBTc9g6HziEr/DLRs+iEtFOPP1dJehKIPQMwxbqhYRjTzQh0+6ARI1FUgdU8QoJUJXAKRbZwyxX9vJfVDK5BvrARJleX1NHtURsLu79rl50hCOCanrIxQWd90858iuNunuhvcJmABFG8ardmJoI=
X-Gm-Message-State: AOJu0Yy1igvq46nt4FEkEyTopOD6oU3JvjIW5Etvart68Oypl7fkMA1V
	Vko+HQNPfpTznQG+eT9XGBETXK4ZIWKwwJS33gT02o+97pcj8g/w
X-Google-Smtp-Source: AGHT+IF3lwwawnwTWt8F/aGq/kCA5hNUzo/KaoRrwwZ2TsMiC/6Rwj5bGNPTZcyTVgVZH5sX8BBxwA==
X-Received: by 2002:a17:907:980e:b0:a7a:c7f3:580d with SMTP id a640c23a62f3a-a7dbccac77dmr72577866b.25.1722505706707;
        Thu, 01 Aug 2024 02:48:26 -0700 (PDT)
Received: from andrea ([151.76.3.213])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad414e2sm874500666b.127.2024.08.01.02.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 02:48:26 -0700 (PDT)
Date: Thu, 1 Aug 2024 11:48:21 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v4 13/13] riscv: Add qspinlock support
Message-ID: <ZqtZ5V3ejYG6yscm@andrea>
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
 <20240731072405.197046-14-alexghiti@rivosinc.com>
 <20240731-ce25dcdc5ce9ccc6c82912c0@orel>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731-ce25dcdc5ce9ccc6c82912c0@orel>

> > +	select ARCH_WEAK_RELEASE_ACQUIRE if ARCH_USE_QUEUED_SPINLOCKS
> 
> Why do we need this? Also, we presumably would prefer not to have it
> when we end up using ticket spinlocks when combo spinlocks is selected.
> Is there no way to avoid it?

Probably not what you had in mind but we should be able to drop the full
barriers in the ticket-lock implementation, deferring/confining them to
RCU code; this way no separate treatment would be needed for either lock:

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c9ff8081efc1a..d37afe3bb20cb 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -79,7 +79,7 @@ config RISCV
 	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
-	select ARCH_WEAK_RELEASE_ACQUIRE if ARCH_USE_QUEUED_SPINLOCKS
+	select ARCH_WEAK_RELEASE_ACQUIRE
 	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
 	select BUILDTIME_TABLE_SORT if MMU
 	select CLINT_TIMER if RISCV_M_MODE
diff --git a/include/asm-generic/ticket_spinlock.h b/include/asm-generic/ticket_spinlock.h
index 325779970d8a0..47522640e5e39 100644
--- a/include/asm-generic/ticket_spinlock.h
+++ b/include/asm-generic/ticket_spinlock.h
@@ -13,10 +13,8 @@
  * about this. If your architecture cannot do this you might be better off with
  * a test-and-set.
  *
- * It further assumes atomic_*_release() + atomic_*_acquire() is RCpc and hence
- * uses atomic_fetch_add() which is RCsc to create an RCsc hot path, along with
- * a full fence after the spin to upgrade the otherwise-RCpc
- * atomic_cond_read_acquire().
+ * It further assumes atomic_*_release() + atomic_*_acquire() is RCtso, where
+ * regular code only expects atomic_t to be RCpc.
  *
  * The implementation uses smp_cond_load_acquire() to spin, so if the
  * architecture has WFE like instructions to sleep instead of poll for word
@@ -32,22 +30,13 @@
 
 static __always_inline void ticket_spin_lock(arch_spinlock_t *lock)
 {
-	u32 val = atomic_fetch_add(1<<16, &lock->val);
+	u32 val = atomic_fetch_add_acquire(1<<16, &lock->val);
 	u16 ticket = val >> 16;
 
 	if (ticket == (u16)val)
 		return;
 
-	/*
-	 * atomic_cond_read_acquire() is RCpc, but rather than defining a
-	 * custom cond_read_rcsc() here we just emit a full fence.  We only
-	 * need the prior reads before subsequent writes ordering from
-	 * smb_mb(), but as atomic_cond_read_acquire() just emits reads and we
-	 * have no outstanding writes due to the atomic_fetch_add() the extra
-	 * orderings are free.
-	 */
 	atomic_cond_read_acquire(&lock->val, ticket == (u16)VAL);
-	smp_mb();
 }
 
 static __always_inline bool ticket_spin_trylock(arch_spinlock_t *lock)
@@ -57,7 +46,7 @@ static __always_inline bool ticket_spin_trylock(arch_spinlock_t *lock)
 	if ((old >> 16) != (old & 0xffff))
 		return false;
 
-	return atomic_try_cmpxchg(&lock->val, &old, old + (1<<16)); /* SC, for RCsc */
+	return atomic_try_cmpxchg_acquire(&lock->val, &old, old + (1<<16));
 }
 
 static __always_inline void ticket_spin_unlock(arch_spinlock_t *lock)

https://lore.kernel.org/lkml/ZlnyKclZOQdrJTtU@andrea/ provides additional
context.

But enough presumably,  ;-)  How do the above changes look in your tests?
other suggestions?

  Andrea

