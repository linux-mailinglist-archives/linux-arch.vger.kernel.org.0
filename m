Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523E22D935F
	for <lists+linux-arch@lfdr.de>; Mon, 14 Dec 2020 07:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438683AbgLNGyC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Dec 2020 01:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438682AbgLNGyC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Dec 2020 01:54:02 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569A4C0613CF;
        Sun, 13 Dec 2020 22:53:22 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id lb18so5736780pjb.5;
        Sun, 13 Dec 2020 22:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=836ueWsqhXJFS2jsaV/+MeW0snlTaUrAFFynrxAzOKk=;
        b=q6GEshR5RFezy4+EprhXJG3fpkvIJHTaEh/EvfhfVA5FfUUDnQ3+4cDCpIRFRC/Mm2
         ZbtvniEPDGviRpZFiQEw8za5h5Z+oWiIlhCu6JBrMnylhIiZhpvC1s1wknSQzDFn0sBw
         8JBT7WhTHfWQfd/wi8sI02TaNRGE436yalS6VtVi39Gml2AGcKkbCiNmqS+4M4ZvGaeu
         xyWfWZoDpWHAvjMESrmKu4FJkOpTQ9ExYrWUgUdh4fCFUa3xeWlwuMz2sCEkKblW5gxy
         +XHxC0WI5idDR3jZr0BQTqsOClCl3URK8jdwMk8i0+K2wgfBGhE4DdSap9b1vIhgbLvC
         7w7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=836ueWsqhXJFS2jsaV/+MeW0snlTaUrAFFynrxAzOKk=;
        b=fyYTfwzmEaZEOzHspzBi7tjrG/WkkNw7reR7XDe5PJAFbAw+eC63soyt59Rb5CuWsL
         IiyjrpnfKnHNYmznNHVlAk8z4uFZpg90f+GtmwIgzoOLm9y4Faj/cNJAScM/FiaHfoLu
         H1AMyVHZFGCdRInoFdSt8Ouf9cp0pA58c1R1xoUmVXYoReGxC+JyLN6spJptrWcD08g2
         81yfJmVChwf4lxqLPbeIKeUAeaSbBO5ZDXMukO0N24j4M9xQdOTTQy7noh6BtRC6BSO4
         5QuOOIizYDnuW0+80EVSEfpPU3dlUwmsaaQFDPrzQHp8Ofl1HFhg1eYqHqglNIqY7N7R
         S8jw==
X-Gm-Message-State: AOAM533YMPxdFvNc5vYgRf0VgrpCS0QxtmpcoEMiko7BeFOYis6BS1Tu
        AhunRdHth/GJYOnglJega80DR+a6pxc=
X-Google-Smtp-Source: ABdhPJyoH0x/t5iFpjCJhCQTVS//5zozzcYJHAEPewzZkngQ9RzGM8cWtjfAj/AvxA1N7fuXpEPEMA==
X-Received: by 2002:a17:90a:a45:: with SMTP id o63mr24426408pjo.146.1607928801482;
        Sun, 13 Dec 2020 22:53:21 -0800 (PST)
Received: from bobo.ozlabs.ibm.com ([220.240.228.148])
        by smtp.gmail.com with ESMTPSA id 84sm19570018pfy.9.2020.12.13.22.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 22:53:20 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        Anton Blanchard <anton@ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 0/5] shoot lazy tlbs
Date:   Mon, 14 Dec 2020 16:53:07 +1000
Message-Id: <20201214065312.270062-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is another rebase, on top of mainline now (don't need the
asm-generic tree), and without any x86 or membarrier changes.
This makes the series far smaller and more manageable and
without the controversial bits.

Thanks,
Nick

Nicholas Piggin (5):
  lazy tlb: introduce lazy mm refcount helper functions
  lazy tlb: allow lazy tlb mm switching to be configurable
  lazy tlb: shoot lazies, a non-refcounting lazy tlb option
  powerpc: use lazy mm refcount helper functions
  powerpc/64s: enable MMU_LAZY_TLB_SHOOTDOWN

 arch/Kconfig                         | 30 ++++++++++
 arch/arm/mach-rpc/ecard.c            |  2 +-
 arch/powerpc/Kconfig                 |  1 +
 arch/powerpc/kernel/smp.c            |  2 +-
 arch/powerpc/mm/book3s64/radix_tlb.c |  4 +-
 fs/exec.c                            |  4 +-
 include/linux/sched/mm.h             | 20 +++++++
 kernel/cpu.c                         |  2 +-
 kernel/exit.c                        |  2 +-
 kernel/fork.c                        | 52 ++++++++++++++++
 kernel/kthread.c                     | 11 ++--
 kernel/sched/core.c                  | 88 ++++++++++++++++++++--------
 kernel/sched/sched.h                 |  4 +-
 13 files changed, 184 insertions(+), 38 deletions(-)

-- 
2.23.0

