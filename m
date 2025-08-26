Return-Path: <linux-arch+bounces-13287-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CECF4B35F58
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 14:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7394605AC
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 12:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE442C15A8;
	Tue, 26 Aug 2025 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ihBLUCYD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCE129D280
	for <linux-arch@vger.kernel.org>; Tue, 26 Aug 2025 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212154; cv=none; b=EXflPuxlLvjvhmWC/GjUavAKiOjs5VY3LrQr1/R6XUIcV30WXxJ1cJq2Hbn56RF+YBWhhlYBUOuOHqb+GYvTvlnCj1uxiYHGuhrUIctDOlbnPd9NfIHdXRJvtijnmImNcvyXif6zcoiACB32F2E5u2SIRtN07StBdS0bx9lkeHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212154; c=relaxed/simple;
	bh=S0Bpq4OtfC8Cw6JaOppgM0dRbUEeZh7tZ/ZTZm1OrYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rvms8HqaTWMyImki71zn3xcmRr4gCyWAbVnOLd5lRYklylyg23eDnnA3TRByQbMdtLPcSjm68jfmICnRu8Z/nfVuwpTkLLM37E5jtxKjQblLIS41ZIRaVYinXd0NMH6shG86zm/p1D/5iFYGDJOymTbdJ/50yskRsq9xCyioeS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ihBLUCYD; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4c29d2ea05so1115574a12.0
        for <linux-arch@vger.kernel.org>; Tue, 26 Aug 2025 05:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756212152; x=1756816952; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ihIdRxo3zaCFTaaQOEAUMowWjAiYBG/G7mxYDcyFFLY=;
        b=ihBLUCYDzwULSF4TLow/lDM5TpUFw8h4oqEU5RBFZiDRMf16CSlb95UiCafJba/rIf
         ue+wQz6eNDcZBNsmdCkyz6HdHEQ+AcAFjPv9NOzQbu5N5LezfKA5KeLOw8YkuRkBoBy3
         fL6X5j8IiX2dGdzF8dQFa/Po4NSl/iwxfgNMWDl2rNWxqQT0UyvYRoTJAOTcj1aKBr0G
         FkrMAVtbdQTaDFrd9zkbiBwMeBm6JoYsKkfDFAj6A2XVakWc426ofPmarZMAewZPwwwU
         NcyskADqey3q1nyK+gvuTxipIsV9fXTDize3tvcoOLbKOAWjphFvRBe7jR7N6Jd2Edaa
         qdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756212152; x=1756816952;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ihIdRxo3zaCFTaaQOEAUMowWjAiYBG/G7mxYDcyFFLY=;
        b=b4G7r40qetCo8czaWYqXYdZRvVX7c4uyZEIs9Z/zQANVFqT76ALqhMmdQMVDhVBD6W
         T0kEhiAiFI3Q+hbNAuArnHP/GQOegGM/+yTQQCtipnsG7Gh5b6O8TFotrnoOl1cbEtPi
         QqK9ANKwXFFTrKUzYbKPrOLypi4iZP4wvV0JHQAaRczXV7HhvuxX1RK0YH0HFa4JcM4W
         dHzj+Ko7GNegY22f6KgaIsRk5MKDHYSLQ8Uov7rOlCuE/gSNYjUSe+APUVCiLv/K0tc9
         k71avN6St1fq+S5fB+yOO6mNglVTywvBGVbzVOebRhoWDyPz91oD3kD4qlyc2TuzkkOK
         ClGw==
X-Gm-Message-State: AOJu0Yzk1Soc+2LB1j/aKsTEvfHsdU4P7IQxb7yEAfJmlqabDFpEk/Xv
	cDPilumrwn/f59L26oXB6kqnv5hyaRQ47ae8hoi7HuJiVmGh1+XMdIZTU7LhaxxxKI2VlgTy8qJ
	9cZ/1xao3BPm81W426fS4gjLk5nkFe+VFQja7P0MajNBGDWxIswJK+AI=
X-Gm-Gg: ASbGncuhCHoeF8XU4WcVVKGj9gpuFy6NHP2K0SYTDgovO16GRK9C7DdDwZPicd3JYL4
	0iXb7eDVR2iI9lQ57+aKpKYrXX0fgsj3fM3ewkw82Y0sLimKbJRLMM2dpBRX9YQb337nAFFtlXq
	ig50q8dWpqssFFOLvFOwRjAhvO/DsYVYvmaMQXTJaFyjS5XJau5z8XxaC/BQ4xqqXDxzSzFiMtx
	DIUnJH07BZLMR0M2Hh0MZDLSpldqV8JrkQc+Uc6
X-Google-Smtp-Source: AGHT+IH4NyVaZSDy6n4rrA41KU9v9fWAF+kl8XT24+x2ai2ACAdw9OAw+btvXA9avZlDxdZPOwNmJ8qepSzZ92IMffg=
X-Received: by 2002:a17:902:dac3:b0:246:bba8:9b8e with SMTP id
 d9443c01a7336-24875397544mr14665275ad.21.1756212151245; Tue, 26 Aug 2025
 05:42:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuR9auMS=hg9Ri+A2SeCQ0jHkW7mN3k9RDG66vE5cfJdQ@mail.gmail.com>
In-Reply-To: <CA+G9fYuR9auMS=hg9Ri+A2SeCQ0jHkW7mN3k9RDG66vE5cfJdQ@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 26 Aug 2025 18:12:19 +0530
X-Gm-Features: Ac12FXxhveQA1vmrTzmCHnzem-lWe0TWCdRXPN4ReZjhi1Wfyu2PglXf3y83Y8w
Message-ID: <CA+G9fYuLx27WRsS185pDnCVOtsLhn_WQRY4EoDBU8dT-hm88Rw@mail.gmail.com>
Subject: Re: next-20250825: arc: seqlock.h:876:2: error: implicit declaration
 of function 'spin_lock' [-Werror=implicit-function-declaration]
To: Linux-Arch <linux-arch@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Waiman Long <longman@redhat.com>, Vineet Gupta <vgupta@kernel.org>, Ye Liu <liuye@kylinos.cn>, 
	Zi Yan <ziy@nvidia.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Dev Jain <dev.jain@arm.com>, 
	David Hildenbrand <david@redhat.com>, Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Aug 2025 at 12:05, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> The following build warnings / errors noticed with arc defconfig with
> gcc-9 toolchain.
>
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
>
> Build regression: next-20250825 arc seqlock.h:876:2: error: implicit
> declaration of function 'spin_lock'
> [-Werror=implicit-function-declaration]
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> arc:
>   build:
>     * gcc-9-allnoconfig
>     * gcc-9-tinyconfig
>     * gcc-9-vdk_hs38_smp_defconfig
>     * gcc-9-defconfig
>     * gcc-9-axs103_defconfig
>
> ## Build log
> In file included from include/linux/mmzone.h:17,
>                  from include/linux/gfp.h:7,
>                  from include/linux/mm.h:7,
>                  from arch/arc/include/asm/arcregs.h:149,
>                  from arch/arc/include/asm/irqflags-arcv2.h:9,
>                  from arch/arc/include/asm/irqflags.h:13,
>                  from include/linux/irqflags.h:18,
>                  from include/linux/spinlock.h:59,
>                  from include/linux/sched.h:37,
>                  from arch/arc/kernel/asm-offsets.c:6:
> include/linux/seqlock.h: In function 'write_seqlock':
> include/linux/seqlock.h:876:2: error: implicit declaration of function
> 'spin_lock' [-Werror=implicit-function-declaration]
>   876 |  spin_lock(&sl->lock);
>       |  ^~~~~~~~~
> include/linux/seqlock.h: In function 'write_sequnlock':
> include/linux/seqlock.h:890:2: error: implicit declaration of function
> 'spin_unlock' [-Werror=implicit-function-declaration]
>   890 |  spin_unlock(&sl->lock);
>       |  ^~~~~~~~~~~
> include/linux/seqlock.h: In function 'write_seqlock_bh':
> include/linux/seqlock.h:902:2: error: implicit declaration of function
> 'spin_lock_bh' [-Werror=implicit-function-declaration]
>   902 |  spin_lock_bh(&sl->lock);
>       |  ^~~~~~~~~~~~
> include/linux/seqlock.h: In function 'write_sequnlock_bh':
> include/linux/seqlock.h:917:2: error: implicit declaration of function
> 'spin_unlock_bh' [-Werror=implicit-function-declaration]
>   917 |  spin_unlock_bh(&sl->lock);
>       |  ^~~~~~~~~~~~~~
> include/linux/seqlock.h: In function 'write_seqlock_irq':
> include/linux/seqlock.h:929:2: error: implicit declaration of function
> 'spin_lock_irq' [-Werror=implicit-function-declaration]
>   929 |  spin_lock_irq(&sl->lock);
>       |  ^~~~~~~~~~~~~
> include/linux/seqlock.h: In function 'write_sequnlock_irq':
> include/linux/seqlock.h:943:2: error: implicit declaration of function
> 'spin_unlock_irq'; did you mean 'write_sequnlock_irq'?
> [-Werror=implicit-function-declaration]
>   943 |  spin_unlock_irq(&sl->lock);
>       |  ^~~~~~~~~~~~~~~
>       |  write_sequnlock_irq
> include/linux/seqlock.h: In function '__write_seqlock_irqsave':
> include/linux/seqlock.h:950:2: error: implicit declaration of function
> 'spin_lock_irqsave' [-Werror=implicit-function-declaration]
>   950 |  spin_lock_irqsave(&sl->lock, flags);
>       |  ^~~~~~~~~~~~~~~~~
> include/linux/seqlock.h: In function 'write_sequnlock_irqrestore':
> include/linux/seqlock.h:981:2: error: implicit declaration of function
> 'spin_unlock_irqrestore'; did you mean 'write_sequnlock_irqrestore'?
> [-Werror=implicit-function-declaration]
>   981 |  spin_unlock_irqrestore(&sl->lock, flags);
>       |  ^~~~~~~~~~~~~~~~~~~~~~
>       |  write_sequnlock_irqrestore
> In file included from include/linux/sched.h:15,
>                  from arch/arc/kernel/asm-offsets.c:6:
> include/linux/rcupdate.h: In function 'rcu_read_lock_sched_held':
> include/linux/preempt.h:227:49: error: implicit declaration of
> function 'irqs_disabled' [-Werror=implicit-function-declaration]
>   227 | #define preemptible() (preempt_count() == 0 && !irqs_disabled())
>       |                                                 ^~~~~~~~~~~~~
>                           ^
> cc1: some warnings being treated as errors

Anders bisected this and found,
 # first bad commit:
   [7cf258e5720ffdd5505faa04ab5afa9732ef0f6e]
   mm-replace-20-page_shift-with-common-macros-for-pages-mb-conversion-fix

> ## Source
> * Kernel version: 6.17.0-rc3-next-20250825
> * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> * Git describe: next-20250825
> * Git commit: 6c68f4c0a147c025ae0b25fab688c7c47964a02f
> * Architectures: arc
> * Toolchains: gcc-9
> * Kconfigs: defconfig
>
> ## Build
> * Build log: https://qa-reports.linaro.org/api/testruns/29652436/log_file/
> * Build details:
> https://regressions.linaro.org/lkft/linux-next-master/next-20250825/build/gcc-9-defconfig/
> * Build error details:
> https://regressions.linaro.org/lkft/linux-next-master/next-20250825/log-parser-build-gcc/gcc-compiler-include_asm-generic_getorder_h-error-implicit-declaration-of-function-ilog/
> * Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/31lrYki7MzYyqtJKnutAe2oawoq
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/31lrYki7MzYyqtJKnutAe2oawoq/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/31lrYki7MzYyqtJKnutAe2oawoq/config
>
> --
> Linaro LKFT
> https://lkft.linaro.org

