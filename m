Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7466E396D43
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jun 2021 08:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbhFAGYx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Jun 2021 02:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbhFAGYx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Jun 2021 02:24:53 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73BEC061574;
        Mon, 31 May 2021 23:23:11 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id 11so2816913plk.12;
        Mon, 31 May 2021 23:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R9w3VBsyynBzvrOKhGUnor+2tF9n4dKvU0meQmd4evY=;
        b=W4LHJGrOxmR9j6iCI+qXHFE0u44HsMkEPSrrEziVpXFsxYWySDL75LZQzT+eozQx6/
         P8LxHQ5OcolPa8nnCg84G8q8lEuhN3sQtaXAEoIMKiECXWrX5Vuw3h4AHSktWZjfXT3k
         GOKZ0H0zkcANaZBcbker5dcVfOvLYKdCyfXLoDJp37S9pO8j43wTpw0HSoIiilA472e8
         lUiH99RrUo829uszk+oFNeq6ezF9ZkpTUWhsSaQGJb0GLvo4XJD5RW65i1NKgEZ5dLdC
         5TQBZGZWAP2c+ZS749kKFePyP69Nwzx2DPvyhAXBMdUg1OrSZQXOMSJ2NweUTxt6SIg+
         3ANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R9w3VBsyynBzvrOKhGUnor+2tF9n4dKvU0meQmd4evY=;
        b=j38q2CoWws7g3rZfysiUDgmaiIrCYMAGzeQG6PFKJeTIlAfAvA4lhSL2yzuFMlg9vm
         5ELTXOngZyXK4x8pDssqAR7TQcZ8qZzWLw63Pz2znoZiXINo6vCBwOiAe+1rCLrekBtu
         x4VDFXrHGNowZYttZe2YBr9ieP4fQFeampUclaB3Gcb5j0wuDZKCB2g7MXxvp1wR1Cfo
         sL77gw0mGI03Z7EsDtiA7ewEwghI9TAV0jYcBCSraV1xxh0WGvyI81UO2yTaCWbWPFBe
         F6HggYbJPkumXQQeQQq9VnKeZWkWrqlyBqSC2IUTozdmp9KGtqBbjwRb0Ff0Jhae1jhL
         GJvg==
X-Gm-Message-State: AOAM53147+NnAPb8qZN6L+jaYIaazjFexQfedBBM4vm5SZcD6lqoRZk8
        SIAJ1HPD6wYkH5yaudVQoNk=
X-Google-Smtp-Source: ABdhPJxdBCBt6kjcsuYhTACpiaI01k2nCclazEEWA4VvIVS22YbO1VZ/TPZyZ/KCQQgJxi56faaOqw==
X-Received: by 2002:a17:902:f68c:b029:102:e6b5:f8c8 with SMTP id l12-20020a170902f68cb0290102e6b5f8c8mr12494108plg.70.1622528591450;
        Mon, 31 May 2021 23:23:11 -0700 (PDT)
Received: from bobo.ibm.com (60-241-69-122.static.tpgi.com.au. [60.241.69.122])
        by smtp.gmail.com with ESMTPSA id h1sm12519100pfh.72.2021.05.31.23.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 23:23:11 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        Anton Blanchard <anton@ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 0/4] shoot lazy tlbs
Date:   Tue,  1 Jun 2021 16:22:59 +1000
Message-Id: <20210601062303.3932513-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There haven't been objections to the series since last posting, this
is just a rebase and tidies up a few comments minor patch rearranging.

Thanks,
Nick

Nicholas Piggin (4):
  lazy tlb: introduce lazy mm refcount helper functions
  lazy tlb: allow lazy tlb mm switching to be configurable
  lazy tlb: shoot lazies, a non-refcounting lazy tlb option
  powerpc/64s: enable MMU_LAZY_TLB_SHOOTDOWN

 arch/Kconfig                         | 38 ++++++++++++
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
 13 files changed, 192 insertions(+), 38 deletions(-)

-- 
2.23.0

