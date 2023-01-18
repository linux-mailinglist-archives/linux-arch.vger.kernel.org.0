Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34FA671673
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jan 2023 09:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjARIqL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Jan 2023 03:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjARIpX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Jan 2023 03:45:23 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E04436B09
        for <linux-arch@vger.kernel.org>; Wed, 18 Jan 2023 00:00:24 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id 20so8786742plo.3
        for <linux-arch@vger.kernel.org>; Wed, 18 Jan 2023 00:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/c+UEu1/betIkwkWD66Ls4sEbWMR7MDl6kLYjMdOV68=;
        b=M10VwdDxiyjR3MkXCt1kIacLOaoFMDhyYGfoN3hv49C7DrdZOq1oe294t353LIQwcM
         l2KY2y2Zc4rxy5Mg3Z728Ym4bWH5diPOXyzsHtMT83RGbaSgYIqIREU23EJGzgLI1Ov6
         N1OYK+iD4zTKGEGWh8IvWX2z6TOFlokAQYUq5hjG8xyZl4+f6z+DDXxK8Du9/vS/4tMg
         wmBdI3sEpKLtpt5MH8U5Bw1lHZF+5fxMmP69GiPiq3w4/kNF6+Kq0OCMnvfKaVIaj14M
         YoEav7fySPBIT0/7ILHa3NgDqx4uXGWF29GGOBUyZgpgm1r8bCwYgVI+XC5Nwmh6iP6r
         LC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/c+UEu1/betIkwkWD66Ls4sEbWMR7MDl6kLYjMdOV68=;
        b=rxOA4dSUsgbhUl3bLCNANqIXRxUMXrQNRqyFLm7jz3D16uG+MMbh4/crGFCymzqou6
         H+Qv2QeYNJBTbiV8SanJYjFGrrhM7L8WYMnM1Zylm9XdZ8vpATBnOoNGNF8yFzrkJeo3
         WdqBkqjUcrvS9Tz/JNyE02bTiDaWKD2ILhbHwgsJr1ALAWahasGqIPqPausLBcUp7vvu
         ol38ueyc6cS2hkyuNb6UuQltFcR0+JbZVqBHZceKeQmJXd0ST/BuB+egwcK0IGcKWpDy
         lmi03xbhjh+BXpbtyhV+UimMBAKRSZrGO87Ujj1kgvo/ud9VWIrqsiLAxLAVnY4FeiBm
         7QiQ==
X-Gm-Message-State: AFqh2kpxWxVvh4I4d8fNmfLNfa3M+CjDq3sN9QapTLWKtIvxrhQu8emS
        cnKY4uEeVgLVNEcDbD6cV0g=
X-Google-Smtp-Source: AMrXdXuopL1YCdkdtbKoGG/gjIRTEabwn/ENnFAHXgYRviGj73xTUB/xxw/XplI1n3AcRXREZspG9g==
X-Received: by 2002:a17:90a:f3d8:b0:228:da96:cfd2 with SMTP id ha24-20020a17090af3d800b00228da96cfd2mr5953879pjb.27.1674028822477;
        Wed, 18 Jan 2023 00:00:22 -0800 (PST)
Received: from bobo.ibm.com (193-116-102-45.tpgi.com.au. [193.116.102.45])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090a16c200b002272616d3e1sm738462pje.40.2023.01.18.00.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 00:00:21 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 0/5] shoot lazy tlbs
Date:   Wed, 18 Jan 2023 18:00:06 +1000
Message-Id: <20230118080011.2258375-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

It's time for that annual flamewar. Nothing really changed in core code
to clean things up or make it better for x86 last year, so I think we
can table that objection.

IIRC the situation left off with Andy proposing a different approach,
and Linus preferring to shoot the lazies at exit time (piggybacking on
the TLB flush IPI), which is what this series allows an arch to do.
Discussion thread here:

https://lore.kernel.org/linux-arch/7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org/

I don't think there was any movement on this or other alternatives, or
code cleanups since then, but correct me if I'm wrong.

Since v5 of this series, there has just been a minor rebase to upstream,
and some tweaking of comments and code style. No functional changes.

Also included patch 5 which is the optimisation that combines final TLB
shootdown with the lazy tlb mm shootdown IPIs. Included because Linus
expected to see it. It works fine, but I have some other powerpc changes
I would like to go ahead of it so I would like to take those through the
powerpc tree. And actually giving it a release cycle without that
optimization will help stress test the final IPI cleanup path too, which
I would like.

Even without the last patch, the additional IPIs caused by shoot lazy
is down in the noise so I'm not too concerned about it.

Thanks,
Nick

Nicholas Piggin (5):
  lazy tlb: introduce lazy tlb mm refcount helper functions
  lazy tlb: allow lazy tlb mm refcounting to be configurable
  lazy tlb: shoot lazies, non-refcounting lazy tlb mm reference handling
    scheme
  powerpc/64s: enable MMU_LAZY_TLB_SHOOTDOWN
  powerpc/64s/radix: combine final TLB flush and lazy tlb mm shootdown
    IPIs

 Documentation/mm/active_mm.rst       |  6 +++
 arch/Kconfig                         | 32 ++++++++++++++
 arch/arm/mach-rpc/ecard.c            |  2 +-
 arch/powerpc/Kconfig                 |  1 +
 arch/powerpc/kernel/smp.c            |  2 +-
 arch/powerpc/mm/book3s64/radix_tlb.c | 30 +++++++++++--
 fs/exec.c                            |  2 +-
 include/linux/sched/mm.h             | 28 ++++++++++++
 kernel/cpu.c                         |  2 +-
 kernel/exit.c                        |  2 +-
 kernel/fork.c                        | 65 ++++++++++++++++++++++++++++
 kernel/kthread.c                     | 21 +++++----
 kernel/sched/core.c                  | 35 ++++++++++-----
 kernel/sched/sched.h                 |  4 +-
 14 files changed, 205 insertions(+), 27 deletions(-)

-- 
2.37.2

