Return-Path: <linux-arch+bounces-4555-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 523B58D1FE1
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2024 17:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74E3A1C22F82
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2024 15:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84F1171652;
	Tue, 28 May 2024 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="m7/NlM3S"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FC9171083
	for <linux-arch@vger.kernel.org>; Tue, 28 May 2024 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909059; cv=none; b=Cx3ecuH8GgJTx73zg5N4AFbMl+sH7B+/AIrElFtIopjJRw4K3dNVgVYEwHDB82xfuwDWyAbWXRi8IeotmwZ5PPHTCDoHM1FyXvooPRenZCwIabWN+mqb+eNmlv7p6xie9rAuMSfyM5SFTUvCCDQfWCkdKNqDCY4cFlx9/rTRq2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909059; c=relaxed/simple;
	bh=CJR5ijuAPP0OxGC2o3LndPnStx7BgQTf9sVBO3oNvzo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k353SMlv6IRZciz+ENqWMuYeKXpedzvtx3RdF5hubjzS1bOTS/6nY4CxmshbOS73uLv6FW87SPpoLGXvhwsTZNZErSZwB/LiOXGVwDvszoDmbeBBDcpx88WFORXZG/YPVOuGne+1sr1sBtlNsIFwzPTGXJjg80gqn7wSwhLxgZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=m7/NlM3S; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4202ca70289so7684955e9.1
        for <linux-arch@vger.kernel.org>; Tue, 28 May 2024 08:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716909055; x=1717513855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k0AGpQFir7bYkY6Hm/qOL+w8L3+MGNDSpFH+GMgURdQ=;
        b=m7/NlM3SphncbkbnwVkDjnP9JpIRjqVX89ff5dRcH0RkRw7lXcjxigQcCZa7prbWje
         almcX48vDmdlcWGaA1L6APIwY6fXRs+p/oUpW6MHwRz2N8v52uAh7e1zwAHu8LnjaLWE
         F5j13D/UKuVIeTnPYGG370f78BrGISkWKjQ31ZF26YvN88IkIIoMiJ+I35JOL8zJbIPh
         z07WreENbZHzt3Vd8KEkKhYKO3h5TTfQ0woJyalKc7+di4j/JYUh/9gY5v7nqsug+UNa
         zvAXPjwqBoxac8zpbuD0oKvhoLa9BD8Hf79FmfgvIaBA+1hObTptoaAOsVR6JGSZD++f
         RPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716909055; x=1717513855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k0AGpQFir7bYkY6Hm/qOL+w8L3+MGNDSpFH+GMgURdQ=;
        b=J4f6m5g1TiCR9Z0BoL+SVZPOr7BCEGGoViO01AVapplKqSWN7NgLPi2stTboSGNKSP
         fRTTwSK2UXssaZOObmg7BmIeZ+2ElaGW6c49Xw8fi/YMDZwe3nrvFqux7r1duTqqu9In
         pV2Y2Sq28VKMCJvBGa53b4xzCUXnKgSAgkUCALRYJYec2F6ZzmgHOCBgwl65nB9V3UeM
         OKSuzyfzCuyvumKHxp1ex5l5YgcKrzgTwnfFDvS/7mLLpCgHVFsmVSsBVf0TuDc5FhyU
         xqdQT/hLfNR9cuDrheZBMZIHOgHBd+BO/snXQo4YdKF0Vz4/7VNMXOfazymkYUt4MFXM
         Ln/g==
X-Forwarded-Encrypted: i=1; AJvYcCXO7RuXJ7wxUZdOa4oKruKNr5fmq1FvB56Z3yrZmGIrLvixI6LvvCOddcsNV5ak06K1Q5NCLA7E0M2GjUmj76ATaM5rLmEWuwlHBA==
X-Gm-Message-State: AOJu0YxWMcoF/dar29PmkBVh3pLtr4CTC/z1vJKUuoV9U5BtIDxH/oc0
	VK3/WqVtb4KQHzRmgHFV/P3xqVH6g0oc/jEzTbqDZDSWBZhXWNbPAn+2olJW0so=
X-Google-Smtp-Source: AGHT+IHwEZnGvgBLJ+odBijV5gGLQhEjsnEBuwZ3zDPr0k4TFSH0yVpvuN/r5/6VstbLixDjb6DW3w==
X-Received: by 2002:a05:600c:4703:b0:420:1fab:1798 with SMTP id 5b1f17b1804b1-421089fe2c2mr95474985e9.29.1716909054785;
        Tue, 28 May 2024 08:10:54 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7da64sm12293475f8f.4.2024.05.28.08.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 08:10:54 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 0/7] Zacas/Zabha support and qspinlocks
Date: Tue, 28 May 2024 17:10:45 +0200
Message-Id: <20240528151052.313031-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This implements [cmp]xchgXX() macros using Zacas and Zabha extensions
and finally uses those newly introduced macros to add support for
qspinlocks: note that this implementation of qspinlocks satisfies the
forward progress guarantee.

Thanks to Guo and Leonardo for their work!

Alexandre Ghiti (5):
  riscv: Implement cmpxchg32/64() using Zacas
  riscv: Implement cmpxchg8/16() using Zabha
  riscv: Implement arch_cmpxchg128() using Zacas
  riscv: Implement xchg8/16() using Zabha
  riscv: Add qspinlock support based on Zabha extension

Guo Ren (2):
  asm-generic: ticket-lock: Reuse arch_spinlock_t of qspinlock
  asm-generic: ticket-lock: Add separate ticket-lock.h

 .../locking/queued-spinlocks/arch-support.txt |   2 +-
 arch/riscv/Kconfig                            |  35 ++++++
 arch/riscv/Makefile                           |  21 ++++
 arch/riscv/include/asm/Kbuild                 |   4 +-
 arch/riscv/include/asm/cmpxchg.h              | 114 ++++++++++++++++--
 arch/riscv/include/asm/hwcap.h                |   1 +
 arch/riscv/include/asm/spinlock.h             |  39 ++++++
 arch/riscv/kernel/cpufeature.c                |   1 +
 arch/riscv/kernel/setup.c                     |  18 +++
 include/asm-generic/qspinlock.h               |   2 +
 include/asm-generic/spinlock.h                |  87 +------------
 include/asm-generic/spinlock_types.h          |  12 +-
 include/asm-generic/ticket_spinlock.h         | 105 ++++++++++++++++
 13 files changed, 336 insertions(+), 105 deletions(-)
 create mode 100644 arch/riscv/include/asm/spinlock.h
 create mode 100644 include/asm-generic/ticket_spinlock.h

-- 
2.39.2


