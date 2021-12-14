Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5929E473B22
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 03:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244628AbhLNCzk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Dec 2021 21:55:40 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:41871 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbhLNCz2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Dec 2021 21:55:28 -0500
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 1BE2s0bm012823;
        Tue, 14 Dec 2021 11:54:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 1BE2s0bm012823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1639450451;
        bh=Uo2wVxpq5SIkUQ/3oMi05zuPyyww+WvElNbVfIYdJLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AIecPvYWD6lNmekG0+UAJrV6XABX8t59eeqEJaOO0VjCiO5j5qDOWro9hKhHKcV1c
         nPthLbLAVJPyGpB7QxJI/DTFZXk5v+/IxYSwZnOgVKBWf+XN92NmMennHq3lzjw0up
         5GKfr/bcNsF6omCaR/95DogWgKA0Lj8O05/GZhHUXCqxlR9rp9rJWxeYPIq9/dMxEc
         3BANcXh1pEkaEg2SOYCHO7d7rzKV09fAL46XnBY1Tv60G8PPZfzUcDK2Ju/Sakimai
         TvYbHbAP1uvkak3k4e/CERQirnmWQvR2R3DSNcm5s7mVCBRxvCFBB2sB7Xwbgzj27N
         5H1kctIxDiayQ==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arch@vger.kernel.org, David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Nicolas Schier <n.schier@avm.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 11/11] microblaze: use built-in function to get CPU_{MAJOR,MINOR,REV}
Date:   Tue, 14 Dec 2021 11:53:55 +0900
Message-Id: <20211214025355.1267796-12-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211214025355.1267796-1-masahiroy@kernel.org>
References: <20211214025355.1267796-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use built-in functions instead of shell commands to avoid forking
processes.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <n.schier@avm.de>
---

(no changes since v1)

 arch/microblaze/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
index a25e76d89e86..1826d9ce4459 100644
--- a/arch/microblaze/Makefile
+++ b/arch/microblaze/Makefile
@@ -6,9 +6,9 @@ UTS_SYSNAME = -DUTS_SYSNAME=\"Linux\"
 # What CPU version are we building for, and crack it open
 # as major.minor.rev
 CPU_VER   := $(CONFIG_XILINX_MICROBLAZE0_HW_VER)
-CPU_MAJOR := $(shell echo $(CPU_VER) | cut -d '.' -f 1)
-CPU_MINOR := $(shell echo $(CPU_VER) | cut -d '.' -f 2)
-CPU_REV   := $(shell echo $(CPU_VER) | cut -d '.' -f 3)
+CPU_MAJOR := $(word 1, $(subst ., , $(CPU_VER)))
+CPU_MINOR := $(word 2, $(subst ., , $(CPU_VER)))
+CPU_REV   := $(word 3, $(subst ., , $(CPU_VER)))
 
 export CPU_VER CPU_MAJOR CPU_MINOR CPU_REV
 
-- 
2.32.0

