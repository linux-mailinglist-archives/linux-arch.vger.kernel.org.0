Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87322456EA
	for <lists+linux-arch@lfdr.de>; Sun, 16 Aug 2020 11:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgHPJJS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 Aug 2020 05:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgHPJJR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 Aug 2020 05:09:17 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A06C061756;
        Sun, 16 Aug 2020 02:09:17 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k18so6666966pfp.7;
        Sun, 16 Aug 2020 02:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nrJg5dHzARiyIgQKcQeBmx5MsP72TzRX4UN4jKQ0FKU=;
        b=WLvoIRIzkAfofpEParlRFy972z69/RbpgtcgqW5BIqiYhP/rvrHlxmqvSHGCq6cXxh
         KWCKFOBQJNHewsjEkigYGaGoIeRmGo36LpOp6988mQpaJulfeI8Kn7aWXEALzOk2YgNe
         YzrnK6UeGwiFiMy7u81dbGKyMq3cgKctsyCaY1QzU1VztYbPgmoJwOz6mYd2rCkNdExZ
         C3kQKTj/iP7gJoam9/wSfc31fblhQsD+6XCPRM7fzCiEHYeEN6WkS3e2P1o7Gagyteey
         61w+j3zr6jrdEKg29APNHXKmxMAIX0OP6IM5cVYB5usU2he5EXr8z3W2k7V4CFuRAOtM
         Fz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nrJg5dHzARiyIgQKcQeBmx5MsP72TzRX4UN4jKQ0FKU=;
        b=OvRSCGCBSUdWhgo5fSgbMg7/LkHhS9mBNNzOPuIelnQ9NHjJDNW2yavI0xaGRxivhN
         zr2su3MFu1hCNWhPXRx8Y6f60vtbj2mNz9aZCNpplgLY72gjrZ+WxXGigmI73zM+qz8L
         acBiUdWXaY/3zsdorVQq+gTCGYjL5a68lrNUjf7NCQTQr8ENElavHV7RhO5ywAt75UHk
         x+9TvY2u2OjnGPuI4qCuluxpKBB6qI3QGuN5IfZeKHqu0lVN8wbXi7MYGZhRE60Fxv45
         Ztf41Vf6aF7knDH1MFSuS6UtZ/vT3OEEVR6yLK4ysBdkHgfyctJ1OMYe/hPkuq0bnFLx
         HFuQ==
X-Gm-Message-State: AOAM532Dnttc6u8dlgwo/8FgYH7XWHQK3+3JvMEhqge+fx4SqbvHzQc4
        zYXtNzOHnRr78eyLEBJdzR0cTcK9H8Q=
X-Google-Smtp-Source: ABdhPJyzIFpwRi/Ye1hyQXChNaeuAzQ4Swk/DOVybSf+u7iXsUyYbQPKNoluotDUjitLamCitTCoeQ==
X-Received: by 2002:a63:cc49:: with SMTP id q9mr6397442pgi.390.1597568956323;
        Sun, 16 Aug 2020 02:09:16 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (193-116-193-175.tpgi.com.au. [193.116.193.175])
        by smtp.gmail.com with ESMTPSA id o19sm12768369pjs.8.2020.08.16.02.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 02:09:15 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v4 0/8] huge vmalloc mappings
Date:   Sun, 16 Aug 2020 19:08:56 +1000
Message-Id: <20200816090904.83947-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Let's try again.

Thanks,
Nick

Since v3:
- Fixed an off-by-one bug in a loop
- Fix !CONFIG_HAVE_ARCH_HUGE_VMAP build fail
- Hopefully this time fix the arm64 vmap stack bug, thanks Jonathan
  Cameron for debugging the cause of this (hopefully).

Since v2:
- Rebased on vmalloc cleanups, split series into simpler pieces.
- Fixed several compile errors and warnings
- Keep the page array and accounting in small page units because
  struct vm_struct is an interface (this should fix x86 vmap stack debug
  assert). [Thanks Zefan]

Nicholas Piggin (8):
  mm/vmalloc: fix vmalloc_to_page for huge vmap mappings
  mm: apply_to_pte_range warn and fail if a large pte is encountered
  mm/vmalloc: rename vmap_*_range vmap_pages_*_range
  lib/ioremap: rename ioremap_*_range to vmap_*_range
  mm: HUGE_VMAP arch support cleanup
  mm: Move vmap_range from lib/ioremap.c to mm/vmalloc.c
  mm/vmalloc: add vmap_range_noflush variant
  mm/vmalloc: Hugepage vmalloc mappings

 .../admin-guide/kernel-parameters.txt         |   2 +
 arch/arm64/mm/mmu.c                           |  12 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c      |  10 +-
 arch/x86/mm/ioremap.c                         |  12 +-
 include/linux/io.h                            |   9 -
 include/linux/vmalloc.h                       |  13 +
 init/main.c                                   |   1 -
 mm/ioremap.c                                  | 231 +--------
 mm/memory.c                                   |  60 ++-
 mm/vmalloc.c                                  | 445 +++++++++++++++---
 10 files changed, 461 insertions(+), 334 deletions(-)

-- 
2.23.0

