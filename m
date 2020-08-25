Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CC5251BB7
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 17:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgHYPA3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Aug 2020 11:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgHYO7D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Aug 2020 10:59:03 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94D1C061574;
        Tue, 25 Aug 2020 07:59:02 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d22so7562934pfn.5;
        Tue, 25 Aug 2020 07:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gv+PP/wjBFW/QutbN7MDl66u1IlF9/srIH5l1WMUz8Y=;
        b=CehPsFgNdfZPYRARvszK0iCwlAZvJIxorhXqUBbsMR1owd1LyaUhv6KkQvkxGhxABE
         h3c8oVY4EFa6rJUgIrnLjCkRStwzaM9eK3BEMzyYASBFUKLmA+35vORx8gBhNYtW5z1x
         3s4yU9gOSNIa2NA3S2uwFMPR+o6NS9XnTAPYFEUJ/a2tvEAtbBjA1Mmp8fT2zjJBaCkA
         4TWe+7FbzU6KUDpftLPy16UTk04L6fVCaWwJOTS0ymSpOh99vhufmMr4F4IOV+GRRGFF
         GHMVyMWmrmX2CZxkpNlbupR524BD2hb59sZczST12PHUj62mzy25W0DZVP/E9GAWUSNh
         X5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gv+PP/wjBFW/QutbN7MDl66u1IlF9/srIH5l1WMUz8Y=;
        b=ukiYdhGW/sOewdeJKYq3R8zgqIM1N7Dna6indcMTFfewEe3n29ddMl8zRDZDngOE5X
         K4GtvWnwNWfjVuhJ05OghN7q+hVA2PpaugJJCmvDNstuudm0ULKR/BqmWxh08eW8zDoQ
         FmG4Vg5VSbU0984EXbRxMuVik9la+qhZFKifk2HH/IlGs/Rj21uCZkb3et+tJxZefRrh
         iGVilGLxMljtvHa4IEpCv8li09UDmXTtsmZy58UeRrqUd1cTrbiYtQDaCBBXLevjq1Yw
         T65q94uaOa48NaTUYm9w1CSA6BwAXa6CncfE7xSoUCIqx+LcSunxzIVpybPDJA5TgDsm
         zcHw==
X-Gm-Message-State: AOAM532O7E2rGJtZZ3eJUXITOPVah03tfo7/e0VXW2fVaI7KuCsGhOBu
        wo19elqqs0QSR4GUvi8z+b8=
X-Google-Smtp-Source: ABdhPJw/xmLmJIGKGVYgH1x/f+iaOst/Nn2dxedzrtxUqC/Tzcj9oxAGZQvDlxbNYOCi6LTdFZvEGg==
X-Received: by 2002:a62:6582:: with SMTP id z124mr7599734pfb.250.1598367542459;
        Tue, 25 Aug 2020 07:59:02 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id e29sm15755956pfj.92.2020.08.25.07.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 07:59:02 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v7 12/12] powerpc/64s/radix: Enable huge vmalloc mappings
Date:   Wed, 26 Aug 2020 00:57:53 +1000
Message-Id: <20200825145753.529284-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200825145753.529284-1-npiggin@gmail.com>
References: <20200825145753.529284-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 ++
 arch/powerpc/Kconfig                            | 1 +
 2 files changed, 3 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bdc1f33fd3d1..6f0b41289a90 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3190,6 +3190,8 @@
 
 	nohugeiomap	[KNL,X86,PPC] Disable kernel huge I/O mappings.
 
+	nohugevmalloc	[PPC] Disable kernel huge vmalloc mappings.
+
 	nosmt		[KNL,S390] Disable symmetric multithreading (SMT).
 			Equivalent to smt=1.
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1f48bbfb3ce9..9171d25ad7dc 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -175,6 +175,7 @@ config PPC
 	select GENERIC_TIME_VSYSCALL
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMAP		if PPC_BOOK3S_64 && PPC_RADIX_MMU
+	select HAVE_ARCH_HUGE_VMALLOC		if HAVE_ARCH_HUGE_VMAP
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KASAN			if PPC32 && PPC_PAGE_SHIFT <= 14
 	select HAVE_ARCH_KASAN_VMALLOC		if PPC32 && PPC_PAGE_SHIFT <= 14
-- 
2.23.0

