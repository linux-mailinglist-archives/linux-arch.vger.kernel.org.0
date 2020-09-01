Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6964225912B
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 16:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgIAOrQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 10:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbgIAOPt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 10:15:49 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670DDC06125C;
        Tue,  1 Sep 2020 07:15:49 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u20so879811pfn.0;
        Tue, 01 Sep 2020 07:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gRMZTfF+7DDMzzPkhZwJ7VQo0zinLl/ycwSJOrxIz0o=;
        b=PyMSULK18qWenOPbSwNLyCnYQpqVLLfJScBRvmypxjLsHLM054xPCE1dM8kzvb6F09
         6bmFiOy02czIVSFJQYAOr/C7ih9cHLbvBV/9joy1bUpkIni9uby2C5tgSUuBLZMGM0A9
         XuPW+w7ttoWi1l33DJbDu2/9N3RaOHwLwsFcXuGyxs+uSes1Qa40VMe0Ox+EKJJzBg/E
         E/i4dIeFOu80hz7TU6r9wLMtYJAXEDT1iYbOaAL+VVqeG9CGtwfVp5kp1z7Q6mIO4Tdw
         yfs1D+WhK3JWahge/buirMHm34i2HEpD/nwHvJCSTQDLMtb9jRtLfGoMmfXG2z12iK2H
         vmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gRMZTfF+7DDMzzPkhZwJ7VQo0zinLl/ycwSJOrxIz0o=;
        b=sa+ithFWnCEoJwFE5wcJFB5dqETkcceHq2n/7iUVCLyQZm1NnteBWe9DYqHDNL+dy+
         RSifKbYL3f5FoIe9kz2WsuPvvvFk1E1yXUZRpKl+K3BPUkKbyDsEaCy663vMeBWW9Rgh
         MVOwzT/wE4G5eEIB0TSH5SxjakYmiKqmq49JNHypP6r5CxsOggoel4MI7VMPfkmefBHt
         XQAge+FSiquYewBkoi2VHgKQ29TmATDma4uUsHuEG7eVJY3E6lqZYvZjOylIritR3bql
         9la2iqcv83U8zJOZNViOYKA/+FT7AA/kdxCo1R71iWrkofOxaiwXOQRCIIWsizbsM+W5
         lvxw==
X-Gm-Message-State: AOAM530qXCR8U2XyUMlmNYwBm8KIHShLaBai+6tbh9tLPEEw+fBgnrfL
        whI3UV5bxr+tmOAe5toPdUjPTYDeKx0=
X-Google-Smtp-Source: ABdhPJw4up6Oy40sGL30tEm2Av/lC7PrC16VMpBZwq7V5ZKVGlh8PekAkGENa/slvcseBFfY+yviQw==
X-Received: by 2002:a62:8443:: with SMTP id k64mr2073858pfd.252.1598969748672;
        Tue, 01 Sep 2020 07:15:48 -0700 (PDT)
Received: from bobo.ibm.com ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id w9sm2212816pgg.76.2020.09.01.07.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 07:15:48 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 00/23] Use asm-generic for mmu_context no-op functions
Date:   Wed,  2 Sep 2020 00:15:16 +1000
Message-Id: <20200901141539.1757549-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

It would be nice to be able to modify mmu_context functions or add a
hook without updating all architectures, many of which will be no-ops.

The motivation for this series is a change to lazy mmu handling, but
this series stands on its own as a good cleanup whether or not we end
up making that change.

Since v2:
- Fixed build failure on arm64 (fingers crossed), did more cross
  compiling.
- Accounted for feedback and added acks (thanks all).

Arnd, most of the main archs have acks, and I asked for ack/nack
from ones which are missing. We could give those a bit more time
then merge.

Thanks,
Nick

Nicholas Piggin (23):
  asm-generic: add generic MMU versions of mmu context functions
  alpha: use asm-generic/mmu_context.h for no-op implementations
  arc: use asm-generic/mmu_context.h for no-op implementations
  arm: use asm-generic/mmu_context.h for no-op implementations
  arm64: use asm-generic/mmu_context.h for no-op implementations
  csky: use asm-generic/mmu_context.h for no-op implementations
  hexagon: use asm-generic/mmu_context.h for no-op implementations
  ia64: use asm-generic/mmu_context.h for no-op implementations
  m68k: use asm-generic/mmu_context.h for no-op implementations
  microblaze: use asm-generic/mmu_context.h for no-op implementations
  mips: use asm-generic/mmu_context.h for no-op implementations
  nds32: use asm-generic/mmu_context.h for no-op implementations
  nios2: use asm-generic/mmu_context.h for no-op implementations
  openrisc: use asm-generic/mmu_context.h for no-op implementations
  parisc: use asm-generic/mmu_context.h for no-op implementations
  powerpc: use asm-generic/mmu_context.h for no-op implementations
  riscv: use asm-generic/mmu_context.h for no-op implementations
  s390: use asm-generic/mmu_context.h for no-op implementations
  sh: use asm-generic/mmu_context.h for no-op implementations
  sparc: use asm-generic/mmu_context.h for no-op implementations
  um: use asm-generic/mmu_context.h for no-op implementations
  x86: use asm-generic/mmu_context.h for no-op implementations
  xtensa: use asm-generic/mmu_context.h for no-op implementations

 arch/alpha/include/asm/mmu_context.h         | 12 ++--
 arch/arc/include/asm/mmu_context.h           | 17 +++---
 arch/arm/include/asm/mmu_context.h           | 26 +--------
 arch/arm64/include/asm/mmu_context.h         |  7 +--
 arch/c6x/include/asm/mmu_context.h           |  6 ++
 arch/csky/include/asm/mmu_context.h          |  8 +--
 arch/hexagon/include/asm/mmu_context.h       | 33 ++---------
 arch/ia64/include/asm/mmu_context.h          | 17 ++----
 arch/m68k/include/asm/mmu_context.h          | 37 +++----------
 arch/microblaze/include/asm/mmu_context.h    |  2 +-
 arch/microblaze/include/asm/mmu_context_mm.h |  8 +--
 arch/microblaze/include/asm/processor.h      |  3 -
 arch/mips/include/asm/mmu_context.h          | 11 ++--
 arch/nds32/include/asm/mmu_context.h         | 10 +---
 arch/nios2/include/asm/mmu_context.h         | 21 ++-----
 arch/openrisc/include/asm/mmu_context.h      |  8 +--
 arch/parisc/include/asm/mmu_context.h        | 12 ++--
 arch/powerpc/include/asm/mmu_context.h       | 13 +++--
 arch/riscv/include/asm/mmu_context.h         | 22 +-------
 arch/s390/include/asm/mmu_context.h          |  9 ++-
 arch/sh/include/asm/mmu_context.h            |  7 +--
 arch/sh/include/asm/mmu_context_32.h         |  9 ---
 arch/sparc/include/asm/mmu_context_32.h      | 10 ++--
 arch/sparc/include/asm/mmu_context_64.h      | 10 ++--
 arch/um/include/asm/mmu_context.h            | 12 ++--
 arch/x86/include/asm/mmu_context.h           |  6 ++
 arch/xtensa/include/asm/mmu_context.h        | 11 +---
 arch/xtensa/include/asm/nommu_context.h      | 26 +--------
 include/asm-generic/mmu_context.h            | 58 +++++++++++++++-----
 include/asm-generic/nommu_context.h          | 19 +++++++
 30 files changed, 174 insertions(+), 276 deletions(-)
 create mode 100644 arch/c6x/include/asm/mmu_context.h
 create mode 100644 include/asm-generic/nommu_context.h

-- 
2.23.0

