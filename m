Return-Path: <linux-arch+bounces-5472-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B15BC93406E
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 18:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F7641F2107B
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 16:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDC517FAB0;
	Wed, 17 Jul 2024 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3+eLu9U"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EF5181CE4;
	Wed, 17 Jul 2024 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721233756; cv=none; b=ds8hfIczJLZ1hEQjEUc17w+WNi6Id3juZ8qDirIYCF7MT7fC1X/b+CVCnu4dizT4+ecfuOnspuvsJOTz9AvaD5J31ZKbqQ9c2wahwRUWJUxTW7YqH1zusWKmbY2UDM/jtug90ovHM4oQjn7+++8Km4RNPH4JoxbrHjvanmrCLtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721233756; c=relaxed/simple;
	bh=5/vFyYizuwP+jcx5JB7tkayCrYU7UvfJKjKsa4tu/gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pv3JdpJ8MN7zMmIkTHdteywiSHQjw6OQtAx1BvujbMnQ4Rqq9xmKmb6W9wfPP2J7eVbkPCmBxdtAG525Ef8gHmQ2MrmcoGz4N+SCqQG3eYmcVzXHVYPK6rKWy41adYYHVcwaPMUkWevQYVQ9hnBzT4kQbl0tsd8IvIeYsMCCaB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3+eLu9U; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-58b966b41fbso8507693a12.1;
        Wed, 17 Jul 2024 09:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721233753; x=1721838553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pnyhXHGX9J34to8BXWeIBkKgNznQFH+294/77VN85Ck=;
        b=a3+eLu9UldsRRmjfwh+VHnvrdar4q5iNRGm+xul+MqtVQ/oGLQOfeBv3OGCmsbYkcu
         8bfmve9jA39QSkz0gZ2J+uAuzI76jx/JSFIkUpiLSSqEc9Zfn88wcaI/nsE+FhkxElTu
         uNtUPN3iX3enSoleJhDu5vLGWdMDs6Ttzg2n4ApDNvkzdopzmU/2/Z0bcfVD1vk6AI2J
         5tLe/wMWCKqQcApjyBUgx+U4jjTqbLKEIQtN0UjeNUp0Dnk2/2//2XHaGX9E5XTK1h8E
         MitiFu5HIOFK6CUS4LEs0vzxFDKBXhWJq0S02r2kdyKHgn97xsb0z4KZEmAquHrkPVFz
         dcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721233753; x=1721838553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnyhXHGX9J34to8BXWeIBkKgNznQFH+294/77VN85Ck=;
        b=t1DGYPxEzR5T34q7iceDqxvCtAde6USm89Syr/JKxy5oKDb7QTP+dcmPLlGc/uD6OZ
         Xu2tqi3GKK6/bdP2I/AFYUepQjwXdaMl8S7xm3jpKkxc/S7emVI3h8eoEvf2hUOOxtjH
         TYWqPUJWXVJslXO/zJlf9Mg+H21MlHJw7uuq8SNwfaoc6SnCsDjbjWALr8ZykvQmzdmN
         7YJ+HWjm470ufpDBprrAJc8/j2FqI5MQnBbwOf29qXvytzD7pII1b0CZDLGt1mLG9P72
         fAuejyAIVLWY2jC6F328rIBDc0Kg9voDmUBgRN8y9bMTRfvfZiyH9PPllLATriYt9tbW
         ahNA==
X-Forwarded-Encrypted: i=1; AJvYcCUFwNNq88FAq3baofCi8P5ncCSKvZ8EiG29FVbpwS6uIw16kV2G7uKAxlCXb9Pl1Sev3Ns4gBDP1iYj0mSRhbVp4UT1iQw3OCwb8i/1Zumi0UaWZNB27ViIPVA8e8gQCPQw7Lz7nNg/ZuyIpeWt9t5t3exd+otCpUMtL1/SqBbRSnxAwg==
X-Gm-Message-State: AOJu0YzqwrbyryovsimVDUeD8j6ge945gYNdEsS2+x/1RqCXuZrJLZ1J
	2puLAMDEoFHWGNDxocUxOcORuFMCOUvqychqB5L5L4vqUi9neaSp
X-Google-Smtp-Source: AGHT+IEiGOScEB11q2BazGjrBsyNU9lXDX/xWG9npgJidiQaGTVMjkHKOuzXX42R4QAigL+Etd3Dew==
X-Received: by 2002:a50:d593:0:b0:58c:6edf:d5d2 with SMTP id 4fb4d7f45d1cf-5a05bad527fmr1578661a12.15.1721233752500;
        Wed, 17 Jul 2024 09:29:12 -0700 (PDT)
Received: from andrea ([84.242.162.60])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b255253absm7201108a12.42.2024.07.17.09.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 09:29:10 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:29:06 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
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
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 11/11] riscv: Add qspinlock support
Message-ID: <ZpfxUvIx+0ClOqCc@andrea>
References: <20240717061957.140712-1-alexghiti@rivosinc.com>
 <20240717061957.140712-12-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717061957.140712-12-alexghiti@rivosinc.com>

> +config RISCV_QUEUED_SPINLOCKS

I'm seeing the following warnings with CONFIG_RISCV_QUEUED_SPINLOCKS=y:

In file included from ./arch/riscv/include/generated/asm/qspinlock.h:1,
                 from kernel/locking/qspinlock.c:24:
./include/asm-generic/qspinlock.h:144:9: warning: "arch_spin_is_locked" redefined
  144 | #define arch_spin_is_locked(l)          queued_spin_is_locked(l)
      |         ^~~~~~~~~~~~~~~~~~~
In file included from ./arch/riscv/include/generated/asm/ticket_spinlock.h:1,
                 from ./arch/riscv/include/asm/spinlock.h:33,
                 from ./include/linux/spinlock.h:95,
                 from ./include/linux/sched.h:2142,
                 from ./include/linux/percpu.h:13,
                 from kernel/locking/qspinlock.c:19:
./include/asm-generic/ticket_spinlock.h:97:9: note: this is the location of the previous definition
   97 | #define arch_spin_is_locked(l)          ticket_spin_is_locked(l)
      |         ^~~~~~~~~~~~~~~~~~~
./include/asm-generic/qspinlock.h:145:9: warning: "arch_spin_is_contended" redefined
  145 | #define arch_spin_is_contended(l)       queued_spin_is_contended(l)
      |         ^~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/ticket_spinlock.h:98:9: note: this is the location of the previous definition
   98 | #define arch_spin_is_contended(l)       ticket_spin_is_contended(l)
      |         ^~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/qspinlock.h:146:9: warning: "arch_spin_value_unlocked" redefined
  146 | #define arch_spin_value_unlocked(l)     queued_spin_value_unlocked(l)
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/ticket_spinlock.h:99:9: note: this is the location of the previous definition
   99 | #define arch_spin_value_unlocked(l)     ticket_spin_value_unlocked(l)
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/qspinlock.h:147:9: warning: "arch_spin_lock" redefined
  147 | #define arch_spin_lock(l)               queued_spin_lock(l)
      |         ^~~~~~~~~~~~~~
./include/asm-generic/ticket_spinlock.h:100:9: note: this is the location of the previous definition
  100 | #define arch_spin_lock(l)               ticket_spin_lock(l)
      |         ^~~~~~~~~~~~~~
./include/asm-generic/qspinlock.h:148:9: warning: "arch_spin_trylock" redefined
  148 | #define arch_spin_trylock(l)            queued_spin_trylock(l)
      |         ^~~~~~~~~~~~~~~~~
./include/asm-generic/ticket_spinlock.h:101:9: note: this is the location of the previous definition
  101 | #define arch_spin_trylock(l)            ticket_spin_trylock(l)
      |         ^~~~~~~~~~~~~~~~~
./include/asm-generic/qspinlock.h:149:9: warning: "arch_spin_unlock" redefined
  149 | #define arch_spin_unlock(l)             queued_spin_unlock(l)
      |         ^~~~~~~~~~~~~~~~
./include/asm-generic/ticket_spinlock.h:102:9: note: this is the location of the previous definition
  102 | #define arch_spin_unlock(l)             ticket_spin_unlock(l)


The following diff resolves them for me (please double check):

diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
index 4856d50006f28..2d59f56a9e2d1 100644
--- a/arch/riscv/include/asm/spinlock.h
+++ b/arch/riscv/include/asm/spinlock.h
@@ -30,7 +30,11 @@ SPINLOCK_BASE_DECLARE(value_unlocked, int, arch_spinlock_t)
 
 #else
 
+#if defined(CONFIG_RISCV_TICKET_SPINLOCKS)
 #include <asm/ticket_spinlock.h>
+#elif defined(CONFIG_RISCV_QUEUED_SPINLOCKS)
+#include <asm/qspinlock.h>
+#endif
 
 #endif


> +DEFINE_STATIC_KEY_TRUE(qspinlock_key);
> +EXPORT_SYMBOL(qspinlock_key);
> +
> +static void __init riscv_spinlock_init(void)
> +{
> +	char *using_ext;
> +
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) &&
> +	    IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {
> +		using_ext = "using Zabha";
> +
> +		asm goto(ALTERNATIVE("j %[no_zacas]", "nop", 0, RISCV_ISA_EXT_ZACAS, 1)
> +			 : : : : no_zacas);
> +		asm goto(ALTERNATIVE("nop", "j %[qspinlock]", 0, RISCV_ISA_EXT_ZABHA, 1)
> +			 : : : : qspinlock);
> +	}
> +
> +no_zacas:
> +	using_ext = "using Ziccrse";
> +	asm goto(ALTERNATIVE("nop", "j %[qspinlock]", 0,
> +			     RISCV_ISA_EXT_ZICCRSE, 1)
> +		 : : : : qspinlock);
> +
> +	static_branch_disable(&qspinlock_key);
> +	pr_info("Ticket spinlock: enabled\n");
> +
> +	return;
> +
> +qspinlock:
> +	pr_info("Queued spinlock %s: enabled\n", using_ext);
> +}
> +

Your commit message suggests that riscv_spinlock_init() doesn't need to
do anything if CONFIG_RISCV_COMBO_SPINLOCKS=n:

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index d7c31c9b8ead2..b2be1b0b700d2 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -244,6 +244,7 @@ static void __init parse_dtb(void)
 #endif
 }
 
+#if defined(CONFIG_RISCV_COMBO_SPINLOCKS)
 DEFINE_STATIC_KEY_TRUE(qspinlock_key);
 EXPORT_SYMBOL(qspinlock_key);
 
@@ -275,6 +276,11 @@ static void __init riscv_spinlock_init(void)
 qspinlock:
 	pr_info("Queued spinlock %s: enabled\n", using_ext);
 }
+#else
+static void __init riscv_spinlock_init(void)
+{
+}
+#endif
 
 extern void __init init_rt_signal_env(void);


Makes sense?  What am I missing?

  Andrea

