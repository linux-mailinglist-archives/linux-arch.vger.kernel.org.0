Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287D339C4E4
	for <lists+linux-arch@lfdr.de>; Sat,  5 Jun 2021 03:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhFEBp0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 21:45:26 -0400
Received: from mail-pj1-f53.google.com ([209.85.216.53]:42871 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhFEBp0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 21:45:26 -0400
Received: by mail-pj1-f53.google.com with SMTP id l23-20020a17090a0717b029016ae774f973so6209781pjl.1;
        Fri, 04 Jun 2021 18:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HN/yxlFRhCXI2lz6pRuRsVES8dA6IrWBhzB/BkiqJsM=;
        b=N0fg6MCuH9s4HsYj1nxf2+QZ+2ZtLPsunpN49Xp5z9VUsR5/shhK52a/meE/srVFid
         ft3AwOKvuTu/Ow2IgqFiVkW+hUu4T7Ionoz8cv1WWEoa5akwrzvX7R5m2v5rgExT+PF/
         80Sawjo8WzzUNSO196wSDIAJeVG//SnGL/MQYgOknM38h4n7joShRzKzbxANFS1n4ErI
         0waMLNoO0AdM0p+GbsvLSeQQaM3zAG+RNT/VsygJupHzRbiVdrvw3HkJXTiRWHSSZE2N
         SYuLVx7C6U51dFDBdLP7UeYGg5fDNixmKSsgJtcyUcv3cfd2uaIt1Nmq+H0oB3m4TYVt
         wCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HN/yxlFRhCXI2lz6pRuRsVES8dA6IrWBhzB/BkiqJsM=;
        b=LvwlZ+Bo4/z/KA1zUX4V0TlXM+eXpJuX4tdRZIabUyoIu6dndRxNpfEATfeJjk1ir0
         J9pLn5vQUPAYaLJqlxeQs0BzK525mBxzjYeX7WOXcXmufXvh/btM49WSI1WlLayfnOrt
         dC9i+tu38j+S5Zi/1IKyw0LSp3iPejGqP7nA//s5CNkpweFQsBbcf29eTCWls35KhBin
         vXFPhRJBU53ZKPNWwuDk5dqzKtHAd4XP83RmvmGe8cVaH8hQMZmIjDpkSZvomJB53t+R
         xCfhbKQL80IUOIOWhp4AElCo+RmVAyzRH+k/RCwz6Fnl6dY0T2/JfT7Ge44nIOexKqES
         KUVA==
X-Gm-Message-State: AOAM532zvOX0EQVAfiSeYvLIlD+Oe6hXH/DVJf6j+B6Bbk6MtFVSv1SM
        fOsml5zNvwwaPymruBVqF/k=
X-Google-Smtp-Source: ABdhPJzIPBaIsLM9CINwZgXyOGPdZc74cQHpiU2KKEGygcnKSh9Gm9bVFr7pTSjQUx6UdhKyvKVXDg==
X-Received: by 2002:a17:902:eccb:b029:106:def0:2717 with SMTP id a11-20020a170902eccbb0290106def02717mr7216193plh.66.1622857346021;
        Fri, 04 Jun 2021 18:42:26 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id q68sm5779056pjq.45.2021.06.04.18.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 18:42:25 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        Anton Blanchard <anton@ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v4 0/4] shoot lazy tlbs
Date:   Sat,  5 Jun 2021 11:42:12 +1000
Message-Id: <20210605014216.446867-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The additional unused config option was a valid criticism, so this now
purely just toggles refcounting of the lazy tlb mm.

Thanks,
Nick

Since v3:
- Removed the extra config option, MMU_LAZY_TLB=n. This can be
  resurrected if an arch wants it.

Nicholas Piggin (4):
  lazy tlb: introduce lazy mm refcount helper functions
  lazy tlb: allow lazy tlb mm refcounting to be configurable
  lazy tlb: shoot lazies, a non-refcounting lazy tlb option
  powerpc/64s: enable MMU_LAZY_TLB_SHOOTDOWN

 arch/Kconfig                         | 17 ++++++++++
 arch/arm/mach-rpc/ecard.c            |  2 +-
 arch/powerpc/Kconfig                 |  1 +
 arch/powerpc/kernel/smp.c            |  2 +-
 arch/powerpc/mm/book3s64/radix_tlb.c |  4 +--
 fs/exec.c                            |  4 +--
 include/linux/sched/mm.h             | 20 +++++++++++
 kernel/cpu.c                         |  2 +-
 kernel/exit.c                        |  2 +-
 kernel/fork.c                        | 51 ++++++++++++++++++++++++++++
 kernel/kthread.c                     | 11 +++---
 kernel/sched/core.c                  | 35 +++++++++++++------
 kernel/sched/sched.h                 |  4 ++-
 13 files changed, 132 insertions(+), 23 deletions(-)

-- 
2.23.0

