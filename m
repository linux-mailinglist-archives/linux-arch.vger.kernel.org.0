Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DAF255820
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 12:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgH1KAg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 06:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgH1KAe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Aug 2020 06:00:34 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCE0C061264;
        Fri, 28 Aug 2020 03:00:34 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 17so397981pfw.9;
        Fri, 28 Aug 2020 03:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hTusVnD1ClA8mtLb09fp9NQDzSnVoJXOXrpjrekC98M=;
        b=I8laPJoF5gq/Tx/yo6hHGNcnujKhq4w+OTtKVT+dhkE1mpMjlhx7SkoFUIwm36XWc0
         CMKdSgQvRMqB5mbglvUzmti6RR/1pIeLzak+egHk0fGTFbObciEP/5YzzZ95YjwG96b1
         r87VD6xFdBSiplVmoEnpiVUwATIxQ79dhCAlK/HqEciXnasv4yReH5uWTTBcya1bxHHI
         q+5PZzBYEas2ktSEm9L47JY//7SoSkYVarDDWTS2Z5hEj47aU6Jhm1zYQ/DONWwDZDCT
         o2EFr5ebo2ozIQnkYIm1NsQDYrnBAmIGVN4tnl6bli7pV+O6MSA1Y/ONeK0Snn55EbA/
         HsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hTusVnD1ClA8mtLb09fp9NQDzSnVoJXOXrpjrekC98M=;
        b=dvTRuqrOKuwka9A3AKKos+dDXdZc3owowo0ctO+Xu3QEKu9bED7GCNW7THwxf0F3IH
         qTIHIT9e5DzwqPNDX4P1C5Xgm6kfXR1z+sPu8hnC2gWgDTk3Iiu/Fgc3zmx3eEugeu6X
         rlF0B0OgrYn/aBMNX2b2Gq2/uxgDKKF2cMpDIxhUlH66vP4esXISeYTj4qYFK97lpMu7
         jj1SvHJJQQkqk26TrF2ZS9RneBDOcYGg6Ymt/PGb7/nmRNrbKnZ5LB1ltPJNME9yv1hT
         wBoFWeukm2CIi7ArO48c6UDSVZ9Upt8jqjrQ3mERzApmvndx/6K4DDAn39pi6ZkaWgSy
         CsmQ==
X-Gm-Message-State: AOAM532B+Sel+VBqmodDhMYtRM4dS0sUcU3ER4VkbXPl9i9RELiP+ZY4
        TV43/Pp/IkePYpI/7LWJNZY=
X-Google-Smtp-Source: ABdhPJySkqUl0R+DKjCAETRrCLwUUvZBNU7lZcOeYY/aEtoZsU6VUskB25O9sStm08Vp5gP3u/2QEw==
X-Received: by 2002:a63:d20e:: with SMTP id a14mr653429pgg.231.1598608832848;
        Fri, 28 Aug 2020 03:00:32 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id 78sm1068608pfv.200.2020.08.28.03.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 03:00:32 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 0/4] more mm switching vs TLB shootdown and lazy tlb
Date:   Fri, 28 Aug 2020 20:00:18 +1000
Message-Id: <20200828100022.1099682-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an attempt to fix a few different related issues around
switching mm, TLB flushing, and lazy tlb mm handling.

This will require all architectures to eventually move to disabling
irqs over activate_mm, but it's possible we could add another arch
call after irqs are re-enabled for those few which can't do their
entire activation with irqs disabled.

I'd like some feedback on the sparc/powerpc vs kthread_use_mm
problem too.

Thanks,
Nick

Nicholas Piggin (4):
  mm: fix exec activate_mm vs TLB shootdown and lazy tlb switching race
  powerpc: select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
  sparc64: remove mm_cpumask clearing to fix kthread_use_mm race
  powerpc/64s/radix: Fix mm_cpumask trimming race vs kthread_use_mm

 arch/Kconfig                           |  7 +++
 arch/powerpc/Kconfig                   |  1 +
 arch/powerpc/include/asm/mmu_context.h |  2 +-
 arch/powerpc/include/asm/tlb.h         | 13 ------
 arch/powerpc/mm/book3s64/radix_tlb.c   | 23 ++++++---
 arch/sparc/kernel/smp_64.c             | 65 ++++++--------------------
 fs/exec.c                              | 17 ++++++-
 7 files changed, 54 insertions(+), 74 deletions(-)

-- 
2.23.0

