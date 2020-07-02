Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91084211D61
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jul 2020 09:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgGBHtG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 03:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgGBHtE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 03:49:04 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5BFC08C5C1;
        Thu,  2 Jul 2020 00:49:04 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k5so2600119pjg.3;
        Thu, 02 Jul 2020 00:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fa9T6PNML2/xkl0bGh/Ztj2VCHxJI+rGnDXzulQp9g4=;
        b=PCTOgeyXmxCRHqkPbdWbNCD5RF4HWZdbQyTIojx6EjkOEWF+8/wPlG+BElrR7+YXPZ
         sLjTHouTQD0P60dVOilWpe+9ScH0g0t3DQfrJjVACgVsaQop6YHakwMXx0bTb/i9Kpyr
         IfE7/orhNh+x85icci2L+rRczXIMxKvjeObHUliBHpTheYNK4UHn2US9x2BpsMUNug+I
         EusvpjUPF/4LJKVp6u8AbSLcPZwrmIIEF3Y1b5zCKSh3qKcVdNqSh8SeyDBvoKorJgff
         xdbFqgnTG+Pi2peG6cNEYSMF+oKs2l5g3Bon66SblCaVCGRP5jxZmJeOVkncsl3jVmza
         hxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fa9T6PNML2/xkl0bGh/Ztj2VCHxJI+rGnDXzulQp9g4=;
        b=RM9r9tpa30RDaGDBwqAuiBOYCtpSZVZjNxxOSnAbXfngvLS+0WJ2/4upvXx63TemSh
         C61wdDIHuHwJ7EcBLQu8xcoH6cJLsbxRIXYPY+DmhNBCk0oVw2zRoCBPvQSO/S5mpgkv
         I8EeIrGvNXVCZCNqNulm+Tv27TePmD+s+oFrcGIzBCNzss6d4hiuJsirl9ihhLz+NFYW
         p6uJa1SRZ4E21spsMljapiaLFwOhC29jh05MYyLI50e5gTk5iFZPagZzNYDZ+dGNQOvH
         p9IjECy/1tGu2tMirhwY0HE1ldwjhF0sYRTk5z9lPpJm/0w8lGf7H9ZF95kgHigGgtBs
         pdhA==
X-Gm-Message-State: AOAM530OzTE275nCRXwcMMNkfuSSH10iahCp9H5XXB7yJI0kBmFIhn2q
        +fq3W0DnhwCngwb2Q5WRhjI=
X-Google-Smtp-Source: ABdhPJz0DrYb1pN7ZPb0vDXXXEcS0FJvLihL6IDzUc7haMlJV7H/L6XRfoSOyJ9cS7kxACtRgiESpQ==
X-Received: by 2002:a17:90a:950c:: with SMTP id t12mr32900004pjo.173.1593676144195;
        Thu, 02 Jul 2020 00:49:04 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-186-125.tpgi.com.au. [61.68.186.125])
        by smtp.gmail.com with ESMTPSA id 17sm6001953pfv.16.2020.07.02.00.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 00:49:03 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 2/8] powerpc/pseries: use smp_rmb() in H_CONFER spin yield
Date:   Thu,  2 Jul 2020 17:48:33 +1000
Message-Id: <20200702074839.1057733-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200702074839.1057733-1-npiggin@gmail.com>
References: <20200702074839.1057733-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There is no need for rmb(), this allows faster lwsync here.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/lib/locks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
index 6440d5943c00..47a530de733e 100644
--- a/arch/powerpc/lib/locks.c
+++ b/arch/powerpc/lib/locks.c
@@ -30,7 +30,7 @@ void splpar_spin_yield(arch_spinlock_t *lock)
 	yield_count = be32_to_cpu(lppaca_of(holder_cpu).yield_count);
 	if ((yield_count & 1) == 0)
 		return;		/* virtual cpu is currently running */
-	rmb();
+	smp_rmb();
 	if (lock->slock != lock_value)
 		return;		/* something has changed */
 	plpar_hcall_norets(H_CONFER,
@@ -56,7 +56,7 @@ void splpar_rw_yield(arch_rwlock_t *rw)
 	yield_count = be32_to_cpu(lppaca_of(holder_cpu).yield_count);
 	if ((yield_count & 1) == 0)
 		return;		/* virtual cpu is currently running */
-	rmb();
+	smp_rmb();
 	if (rw->lock != lock_value)
 		return;		/* something has changed */
 	plpar_hcall_norets(H_CONFER,
-- 
2.23.0

