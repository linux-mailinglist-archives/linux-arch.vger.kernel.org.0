Return-Path: <linux-arch+bounces-13286-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6784CB354AA
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 08:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10C6A7B2E94
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 06:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9A017A2E1;
	Tue, 26 Aug 2025 06:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pJQ4iuGp"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C046821FF29
	for <linux-arch@vger.kernel.org>; Tue, 26 Aug 2025 06:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756190167; cv=none; b=mkwz5kk4pawtBpURu1CpsrY0pyKb9G8f3JlqpT2S3HswWMH9arULm1R6vopR1Vut6BTNOgoM4f8/1GONhlnvhY9ci2eEonXLkfGws8r4Y4NJCawWuJsgkwLHo8c+Z7TVAA0m82wiC8C0RNNCCb4dbHImkYvC2I0W6tlBnp2DUr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756190167; c=relaxed/simple;
	bh=2BqXMcZnoG8t6tVC4Nu0TiARTMl3Fi3Qmn7b0TTYb0s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JaV4l08dlN93+RXByVO8CWwiX+d8SoaM/xI8cxyMzdeccomJJO/e5+PfpMXiVSjF8sjBa8koR0d3BEpmlLT6Ary5F0DY543+iOrlqp54wk9Pu9ZUwzSczd24PwlH8gb7rwRTIeVTQc/G3HyldlFoScdAQyFG/ZmSrAs/g/fBsTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pJQ4iuGp; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b49dcdf018bso1497023a12.0
        for <linux-arch@vger.kernel.org>; Mon, 25 Aug 2025 23:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756190161; x=1756794961; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZCZJrCEqdKPb4Dv2x8k8eTvQ61vGgPIzxIHFjirYy9A=;
        b=pJQ4iuGpzl+/9WVGNqWob+MbEuWuxbMDHe05LXsFpAnKlkGkR7Y0nHNKU+SwnFWL+g
         kaljpOgOoVC6WtPsBEftB7NfRRcdyI6/ppLDiFATst28txGiwsY0MMqu+mdv3/hSAxoL
         JTgYDd/IqJ+GMJl+iZmneCDjzyoQBVG3nV2OErZfRQgBoBIAU2adTEJ5/xw7alqOUqwe
         8LxARAXGu3QsZZkPevYfpuzOx8rok84UbF2lmyFp/x3O6wO1j8TZTi5rrftW0r77IZJf
         16E+ZO33p944iWIaNGVt/HVcEWcwL3ORjKwYZ4xH4rD4Rn9Vl6nQt1Ot4HVzApoBkbp7
         ujFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756190161; x=1756794961;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZCZJrCEqdKPb4Dv2x8k8eTvQ61vGgPIzxIHFjirYy9A=;
        b=Sb+BGzN25NP3EDAWlAixUxVuD95ITFix0qrbmTvwQYgY9G4aX3Pk7outzj2dL86FBC
         EVTY8IieK9JnEJ0n919IoZk/SUl6O8VGRGC6g3NXRqysvdHJ4Bysyq30SxxZt6XC9spU
         bB2O6JFiKwbd1LowrzeS70JzwwO1SWC7+Qj9ryp+tt8fBBDyqczf76UYacgFFYH9lmgl
         4uC3qgHqd2XGvaBap7q/g+h0ZVeCPB1X6213MSelUigcDx+OiTj6D+9bNVkAye0p64Oj
         zzEYbzpUWV+IUBBjz5Pv6/kicXbm2As86VK4uJ6SJbCZPDAoMBc0UsRHDMQxbPvvHsz5
         DpJw==
X-Gm-Message-State: AOJu0YwBpovI3jHCEM0eGai6gcdik0k1Sj31Y36PSINXAi8n4cqyVl/4
	UmB1LIBLuCZ+lZMQ9x3BPjHtRLEaNdOmht1i3CnOyRz7Hq7NqGihTiGVzMiD4sbcXQT5+UJ+AUP
	7HOsvmaUjDRT2kRuFwz7MCos+qanR3Rgpybb5qvavIGltQmVeXft1uUc=
X-Gm-Gg: ASbGncuTfHO7PXtOWXmwZtjnsSZEqAyjkYkzfByW1GjrrGFOJa3Lf9pSy6Bv+lKX2Ax
	fhFpav4pbhdkYSHtN6y+i8z6fGEunx692q6137/V7kTU6LoODmekz3IEKp2CQh267SVakeoHdmo
	eWqBeMjYZSLb79n6qu2Pr9y49f4hcdx0FksY/nwm+qVuuDNlzSkusE7nn8pH4LQW4oRAeVLEs9c
	M9tMPYk87g0POY5i9XoaV9LKmrMTrggftz8PRI=
X-Google-Smtp-Source: AGHT+IEQn4WiuIgZyEMURTgqGtjunWBRbpXl5so57HtpTznUyYEK7Ey9gxQd0qtxzwA+AVUwTTM+dZG94+sYVO8I9HM=
X-Received: by 2002:a17:902:f64b:b0:246:7a43:3f82 with SMTP id
 d9443c01a7336-2467a4378cbmr141502145ad.45.1756190159816; Mon, 25 Aug 2025
 23:35:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 26 Aug 2025 12:05:48 +0530
X-Gm-Features: Ac12FXyuAWdifk3AbEFJtNbFPLOMAyfmI2knp7BoLYQE5klP6No3TL9rR5qjI0I
Message-ID: <CA+G9fYuR9auMS=hg9Ri+A2SeCQ0jHkW7mN3k9RDG66vE5cfJdQ@mail.gmail.com>
Subject: next-20250825: arc: seqlock.h:876:2: error: implicit declaration of
 function 'spin_lock' [-Werror=implicit-function-declaration]
To: Linux-Arch <linux-arch@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"

The following build warnings / errors noticed with arc defconfig with
gcc-9 toolchain.

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Build regression: next-20250825 arc seqlock.h:876:2: error: implicit
declaration of function 'spin_lock'
[-Werror=implicit-function-declaration]

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

arc:
  build:
    * gcc-9-allnoconfig
    * gcc-9-tinyconfig
    * gcc-9-vdk_hs38_smp_defconfig
    * gcc-9-defconfig
    * gcc-9-axs103_defconfig

## Build log
In file included from include/linux/mmzone.h:17,
                 from include/linux/gfp.h:7,
                 from include/linux/mm.h:7,
                 from arch/arc/include/asm/arcregs.h:149,
                 from arch/arc/include/asm/irqflags-arcv2.h:9,
                 from arch/arc/include/asm/irqflags.h:13,
                 from include/linux/irqflags.h:18,
                 from include/linux/spinlock.h:59,
                 from include/linux/sched.h:37,
                 from arch/arc/kernel/asm-offsets.c:6:
include/linux/seqlock.h: In function 'write_seqlock':
include/linux/seqlock.h:876:2: error: implicit declaration of function
'spin_lock' [-Werror=implicit-function-declaration]
  876 |  spin_lock(&sl->lock);
      |  ^~~~~~~~~
include/linux/seqlock.h: In function 'write_sequnlock':
include/linux/seqlock.h:890:2: error: implicit declaration of function
'spin_unlock' [-Werror=implicit-function-declaration]
  890 |  spin_unlock(&sl->lock);
      |  ^~~~~~~~~~~
include/linux/seqlock.h: In function 'write_seqlock_bh':
include/linux/seqlock.h:902:2: error: implicit declaration of function
'spin_lock_bh' [-Werror=implicit-function-declaration]
  902 |  spin_lock_bh(&sl->lock);
      |  ^~~~~~~~~~~~
include/linux/seqlock.h: In function 'write_sequnlock_bh':
include/linux/seqlock.h:917:2: error: implicit declaration of function
'spin_unlock_bh' [-Werror=implicit-function-declaration]
  917 |  spin_unlock_bh(&sl->lock);
      |  ^~~~~~~~~~~~~~
include/linux/seqlock.h: In function 'write_seqlock_irq':
include/linux/seqlock.h:929:2: error: implicit declaration of function
'spin_lock_irq' [-Werror=implicit-function-declaration]
  929 |  spin_lock_irq(&sl->lock);
      |  ^~~~~~~~~~~~~
include/linux/seqlock.h: In function 'write_sequnlock_irq':
include/linux/seqlock.h:943:2: error: implicit declaration of function
'spin_unlock_irq'; did you mean 'write_sequnlock_irq'?
[-Werror=implicit-function-declaration]
  943 |  spin_unlock_irq(&sl->lock);
      |  ^~~~~~~~~~~~~~~
      |  write_sequnlock_irq
include/linux/seqlock.h: In function '__write_seqlock_irqsave':
include/linux/seqlock.h:950:2: error: implicit declaration of function
'spin_lock_irqsave' [-Werror=implicit-function-declaration]
  950 |  spin_lock_irqsave(&sl->lock, flags);
      |  ^~~~~~~~~~~~~~~~~
include/linux/seqlock.h: In function 'write_sequnlock_irqrestore':
include/linux/seqlock.h:981:2: error: implicit declaration of function
'spin_unlock_irqrestore'; did you mean 'write_sequnlock_irqrestore'?
[-Werror=implicit-function-declaration]
  981 |  spin_unlock_irqrestore(&sl->lock, flags);
      |  ^~~~~~~~~~~~~~~~~~~~~~
      |  write_sequnlock_irqrestore
In file included from include/linux/sched.h:15,
                 from arch/arc/kernel/asm-offsets.c:6:
include/linux/rcupdate.h: In function 'rcu_read_lock_sched_held':
include/linux/preempt.h:227:49: error: implicit declaration of
function 'irqs_disabled' [-Werror=implicit-function-declaration]
  227 | #define preemptible() (preempt_count() == 0 && !irqs_disabled())
      |                                                 ^~~~~~~~~~~~~
                          ^
cc1: some warnings being treated as errors

## Source
* Kernel version: 6.17.0-rc3-next-20250825
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: next-20250825
* Git commit: 6c68f4c0a147c025ae0b25fab688c7c47964a02f
* Architectures: arc
* Toolchains: gcc-9
* Kconfigs: defconfig

## Build
* Build log: https://qa-reports.linaro.org/api/testruns/29652436/log_file/
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250825/build/gcc-9-defconfig/
* Build error details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250825/log-parser-build-gcc/gcc-compiler-include_asm-generic_getorder_h-error-implicit-declaration-of-function-ilog/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/31lrYki7MzYyqtJKnutAe2oawoq
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/31lrYki7MzYyqtJKnutAe2oawoq/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/31lrYki7MzYyqtJKnutAe2oawoq/config

--
Linaro LKFT
https://lkft.linaro.org

