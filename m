Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E3C1A66A2
	for <lists+linux-arch@lfdr.de>; Mon, 13 Apr 2020 15:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbgDMM7p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Apr 2020 08:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729673AbgDMM7o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Apr 2020 08:59:44 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955F1C008749;
        Mon, 13 Apr 2020 05:54:17 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id w3so3359832plz.5;
        Mon, 13 Apr 2020 05:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eLerIzKtSl3zsn2Oymq5fsiJKLq+NQe813C4SL5fbLw=;
        b=D3TacET4LkxgSZwrtk0YaO57GIAKjGq2FPxhPIibWo0sfykUkoRPbtT1f79Yc1c0me
         Jg6ubg805mJwW/UIK0xFjVnvaAhSuErW6yXPEECe9C+aijrMJqQi12GvPnicnJXPQkAD
         7s5ZhWNwDiR14hLg1/l5CXCsGNCCoW09+cbd+G7vLYprIu8mAYrfJt5Z7Ej+3+oEbWCm
         negw6h/cLHxbJGqVoj0xGCTjzWVbxBdALQozOIeVH71ZFyuZ+tbY4voNU7sWACEIebF3
         JVVOML3yuc3rFmdAauFn6vfYwVjRjOsHKMlXRUgQBOAmXItxjBRIE1V3smOcR1mge9fP
         +3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eLerIzKtSl3zsn2Oymq5fsiJKLq+NQe813C4SL5fbLw=;
        b=rg6S73pwG4Q7icl6RQdQujMnAOn+/zFlQKZZPK/pX5mVQTE8TBXgGEUsyYjOP22EHy
         hYC/9GuFF1tEFu/N1wcciKVkwhqGFyA1UNAwkCrwGhhcn+b9u/HbRU1Ifv65VE5yzx9m
         PFrnbfAMWdAgDtPbcdAoJoD+I1tHXKUEA/INs+JeJq7OaoHB/G5GnltTtOSUVr7tWsH8
         z0YQa6f3RFFUG34uU7xxZpaxio6XfjLwMPKL3/sVySfvLtIzdzyuU7AMR4CfS/J565Oc
         saoC3UTgKUtxj2KobkaOkeJlTwfoUa+dnCQAqsV0QVIoRhx2zXRCBHCoRi1yX8i+yILj
         5XRg==
X-Gm-Message-State: AGi0PubGFZwkWthmoYmhV6gjvDZaLJVUebv/al5odT4w/FlHbML5rnnH
        q7wejAmuUlHKnwy8NCjwPb4=
X-Google-Smtp-Source: APiQypIuKwevaVe7P950qwu0WviRlHpRByIKxXMptZO8oQOn38nAcJkm8e5eaH+Vq6duTZluVkSCtw==
X-Received: by 2002:a17:902:464:: with SMTP id 91mr17811244ple.261.1586782456770;
        Mon, 13 Apr 2020 05:54:16 -0700 (PDT)
Received: from bobo.ibm.com (60-241-117-97.tpgi.com.au. [60.241.117.97])
        by smtp.gmail.com with ESMTPSA id j24sm9235610pji.20.2020.04.13.05.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 05:54:15 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 0/4] huge vmalloc mappings
Date:   Mon, 13 Apr 2020 22:52:59 +1000
Message-Id: <20200413125303.423864-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We can get a significant win with larger mappings for some of the big
global hashes.

Since RFC, relevant architectures have added p?d_leaf accessors so no
real arch changes required, and I changed it not to allocate huge
mappings for modules and a bunch of other fixes.

Nicholas Piggin (4):
  mm/vmalloc: fix vmalloc_to_page for huge vmap mappings
  mm: Move ioremap page table mapping function to mm/
  mm: HUGE_VMAP arch query functions cleanup
  mm/vmalloc: Hugepage vmalloc mappings

 arch/arm64/mm/mmu.c                      |   8 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c |   6 +-
 arch/x86/mm/ioremap.c                    |   6 +-
 include/linux/io.h                       |   3 -
 include/linux/vmalloc.h                  |  15 +
 lib/ioremap.c                            | 203 +----------
 mm/vmalloc.c                             | 413 +++++++++++++++++++----
 7 files changed, 380 insertions(+), 274 deletions(-)

-- 
2.23.0

