Return-Path: <linux-arch+bounces-6286-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A60AD955B55
	for <lists+linux-arch@lfdr.de>; Sun, 18 Aug 2024 08:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9561F21A4E
	for <lists+linux-arch@lfdr.de>; Sun, 18 Aug 2024 06:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E79D515;
	Sun, 18 Aug 2024 06:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Vu1Uj2dA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71358C8C7
	for <linux-arch@vger.kernel.org>; Sun, 18 Aug 2024 06:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723962945; cv=none; b=YBVW0+pbnvoKh215DS0McRJHvvay1cXWYSyoLqx0BQ8w3WtiOpDgrEWvDdxAO67eFgJyAz5PfTxMSgtz8j1vFer0Ndwlft8zKjwIG/STg5enjgxcPHUznsqMpTuyK6NLekfs3C6ebeQXK5DxhKTz+udZ2VuDlcQrU98NmCJ58oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723962945; c=relaxed/simple;
	bh=tLM5Z4bxoxRkAjVlUEax9m/c67WwO5YvO//pVYLZKsU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gRM40h1Gcm+N6XVHTyM+8dd/o3y0n9OejgCu7orDVbZkYLUes615f8qlbO4IVWSfs5uEL/ypIh38qXMesQapvMNK/gCbx+WfQlHmiQCdOEP3oyUlKzxg5uoAHgd5+cp8Vd+efxGsrv/Qx5lmpEUi0QgD196K7TqaBHiBnWGWfg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Vu1Uj2dA; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-428e1915e18so23566125e9.1
        for <linux-arch@vger.kernel.org>; Sat, 17 Aug 2024 23:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723962941; x=1724567741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p7mg4NRTTfSPHbPRie+gRphXLh6Di7RPJtVldjOET9U=;
        b=Vu1Uj2dAxYxsGAC06LuZx6BQLGVjNFTi3tFANJrvRlm+EROKDMacbicpKUb/BpgBbq
         ydP67PSGz+knm55sZzTNDu4cB/eZBK4jU73I/D0WX2JLhPs28mOUdr6lHz5ZxVe/PLQQ
         UQywcGrmoF2Df6tprGVJvACY7bVwQb74DvFTXemL/RNVZd1Ea3NWaBDOSeA2yX8mhy12
         ZIaCefYPRblQGxcjGZ9LF7mMO3N+Ey7YaYqaZJjI7ObZwKTLFKgDGhQf+g5NHA4fEVGl
         Dv76iILZ7VcrRe0vqHqgs+sG88Gfk2Va2DiSHnN1O6ktMxLxRuWx5v59kQzRI13GXsu3
         tsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723962941; x=1724567741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p7mg4NRTTfSPHbPRie+gRphXLh6Di7RPJtVldjOET9U=;
        b=KH2TjeXlFNNvkGS7AGS7HTQaTIQ9cFThLgUG4N0CTaU1PR+Iq8T8pWc4thQTfy2NC2
         G7En5kt/Sxurlencb5C2Kf2DrRzlXVYMKl1f0tyqd2wtY0nrDXSIBhD+hgHRs+xpXawg
         InTCLBuZAi8p5/NW2KuEluyfpvSd7s+BtOAPCSZcm3EOdast3UFOs4Dw83accmAjneha
         s1dqIvTXR6mC0681iHQVDeYYN31Sa+xJe0D/E4p3Kt6pCDXfsQayqwpC0YO8FwlshtdY
         myn+wEsCfF3oRthgQmLSQKW68hkdwIAim9ECVzUqlf/NiWDc8avIqef4/AyptxJavxXM
         Z3BA==
X-Forwarded-Encrypted: i=1; AJvYcCUVgx8W0QU5MfUmlSRWxL26i/PQEbSwsix7P3h/kgS76qZddNS5FEtS4yS73HOmWysNy49xy55lUnOW4Zd5A5Ord/MYQLmCt8LKNw==
X-Gm-Message-State: AOJu0Yy1+PESggn0WP9vC+GJpxNvKOoFbG8nyZrxzCE2cUlBPjtiLAht
	VGV7HwUaOd5pzXUuIxX59g3yRju819scWTdaDQS+B09YbjK0FsG6s5pOxHAjOu0=
X-Google-Smtp-Source: AGHT+IHWioXbEzbxYI9412gtwZ2YBYmHLePow18La6xW8gk33hEVNWfxlT5BodzLBQUIRfMGQUiRbg==
X-Received: by 2002:a05:600c:5103:b0:426:5cdf:2674 with SMTP id 5b1f17b1804b1-429ed7a5f52mr48827345e9.4.1723962941343;
        Sat, 17 Aug 2024 23:35:41 -0700 (PDT)
Received: from alex-rivos.guest.squarehotel.net ([130.93.157.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded2931asm118645775e9.17.2024.08.17.23.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 23:35:40 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v5 00/13] Zacas/Zabha support and qspinlocks
Date: Sun, 18 Aug 2024 08:35:25 +0200
Message-Id: <20240818063538.6651-1-alexghiti@rivosinc.com>
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

It also uses Ziccrse to provide the qspinlock implementation.

Thanks to Guo and Leonardo for their work!

v4: https://lore.kernel.org/linux-riscv/20240731072405.197046-1-alexghiti@rivosinc.com/
v3: https://lore.kernel.org/linux-riscv/20240717061957.140712-1-alexghiti@rivosinc.com/
v2: https://lore.kernel.org/linux-riscv/20240626130347.520750-1-alexghiti@rivosinc.com/
v1: https://lore.kernel.org/linux-riscv/20240528151052.313031-1-alexghiti@rivosinc.com/

Changes in v5:
- Remove useless include in cpufeature.h and add required ones (Drew)
- Add RB from Drew
- Add AB from Conor and Peter
- use macros to help readability of arch_cmpxchg_XXX() (Drew)
- restore the build_bug() for size > 8 (Drew)
- Update Ziccrse riscv profile spec version commit hash (Conor)

Changes in v4:
- rename sc_sfx into sc_cas_sfx in _arch_cmpxchg (Drew)
- cmpxchg() depends on 64BIT (Drew)
- rename xX register into tX (Drew)
- cas operations require the old value in rd, make this assignment more explicit
  as it seems to confuse people (Drew, Andrea)
- Fix ticket/queued configs build errors (Andrea)
- riscv_spinlock_init() is only needed for combo spinlocks but implement it
  anyway to inform of the type of spinlocks used (Andrea)
- Add RB from Guo
- Add NONPORTABLE to RISCV_QUEUED_SPINLOCKS (Samuel)
- Add a link to Guo's qspinlocks results on the sophgo platform
- Reorder ZICCRSE (Samuel)
- Use riscv_has_extention_unlikely() instead of direct asm goto, which is way
  cleaner and fixes the llvm 16 bug
- add dependency on RISCV_ALTERNATIVES in kconfig
- Rebase on top of 6.11, add patches to fix header circular dependency and
  to fix build_bug()

Changes in v3:
- Fix patch 4 to restrict the optimization to fully ordered AMO (Andrea)
- Move RISCV_ISA_EXT_ZABHA definition to patch 4 (Andrea)
- !Zacas at build time => no CAS from Zabha too (Andrea)
- drop patch 7 "riscv: Improve amoswap.X use in xchg()" (Andrea)
- Switch lr/sc and cas order (Guo)
- Combo spinlocks do not depend on Zabha
- Add a Kconfig for ticket/queued/combo (Guo)
- Use Ziccrse (Guo)

Changes in v2:
- Add patch for Zabha dtbinding (Conor)
- Fix cmpxchg128() build warnings missed in v1
- Make arch_cmpxchg128() fully ordered
- Improve Kconfig help texts for both extensions (Conor)
- Fix Makefile dependencies by requiring TOOLCHAIN_HAS_XXX (Nathan)
- Fix compilation errors when the toolchain does not support the
  extensions (Nathan)
- Fix C23 warnings about label at the end of coumpound statements (Nathan)
- Fix Zabha and !Zacas configurations (Andrea)
- Add COMBO spinlocks (Guo)
- Improve amocas fully ordered operations by using .aqrl semantics and
  removing the fence rw, rw (Andrea)
- Rebase on top "riscv: Fix fully ordered LR/SC xchg[8|16]() implementations"
- Add ARCH_WEAK_RELEASE_ACQUIRE (Andrea)
- Remove the extension version in march for LLVM since it is only required
  for experimental extensions (Nathan)
- Fix cmpxchg128() implementation by adding both registers of a pair
  in the list of input/output operands

Alexandre Ghiti (11):
  riscv: Move cpufeature.h macros into their own header
  riscv: Do not fail to build on byte/halfword operations with Zawrs
  riscv: Implement cmpxchg32/64() using Zacas
  dt-bindings: riscv: Add Zabha ISA extension description
  riscv: Implement cmpxchg8/16() using Zabha
  riscv: Improve zacas fully-ordered cmpxchg()
  riscv: Implement arch_cmpxchg128() using Zacas
  riscv: Implement xchg8/16() using Zabha
  riscv: Add ISA extension parsing for Ziccrse
  dt-bindings: riscv: Add Ziccrse ISA extension description
  riscv: Add qspinlock support

Guo Ren (2):
  asm-generic: ticket-lock: Reuse arch_spinlock_t of qspinlock
  asm-generic: ticket-lock: Add separate ticket-lock.h

 .../devicetree/bindings/riscv/extensions.yaml |  12 +
 .../locking/queued-spinlocks/arch-support.txt |   2 +-
 arch/riscv/Kconfig                            |  69 +++++
 arch/riscv/Makefile                           |   6 +
 arch/riscv/include/asm/Kbuild                 |   4 +-
 arch/riscv/include/asm/cmpxchg.h              | 286 +++++++++++++-----
 arch/riscv/include/asm/cpufeature-macros.h    |  66 ++++
 arch/riscv/include/asm/cpufeature.h           |  61 +---
 arch/riscv/include/asm/hwcap.h                |   2 +
 arch/riscv/include/asm/spinlock.h             |  47 +++
 arch/riscv/kernel/cpufeature.c                |   2 +
 arch/riscv/kernel/setup.c                     |  37 +++
 include/asm-generic/qspinlock.h               |   2 +
 include/asm-generic/spinlock.h                |  87 +-----
 include/asm-generic/spinlock_types.h          |  12 +-
 include/asm-generic/ticket_spinlock.h         | 105 +++++++
 16 files changed, 567 insertions(+), 233 deletions(-)
 create mode 100644 arch/riscv/include/asm/cpufeature-macros.h
 create mode 100644 arch/riscv/include/asm/spinlock.h
 create mode 100644 include/asm-generic/ticket_spinlock.h

-- 
2.39.2


