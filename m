Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A572CDBC8
	for <lists+linux-arch@lfdr.de>; Thu,  3 Dec 2020 18:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgLCRGd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Dec 2020 12:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgLCRGd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Dec 2020 12:06:33 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1EEC061A4F
        for <linux-arch@vger.kernel.org>; Thu,  3 Dec 2020 09:05:53 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id o12so2027613qtw.14
        for <linux-arch@vger.kernel.org>; Thu, 03 Dec 2020 09:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Qbrb8i2YfiEPDxlw+wvNXikUmpcEcy9BW/zou/d27Yk=;
        b=ePOWK2/6kYVxket/SF6GfcbuPmPOmPzeA0baqmNP01ITblvLvShxFFmoPKNtQzqnFS
         Ei4LY+4oiS1Imvj50qvIeZ36Eey3/jBj55dZ2Aqzy3cCb6pfDMjo7i/EorJB8qqI6IHD
         fDXsbdfkGNlDikFblIPQX6pBzHAMcsH2pFYtJk3yX/xR88kg0xj5p5SsEw+evXlB2Weh
         8MlQMNjgMg3ZyF+SM5K3RFg/t+ueLH0avRip+UruPkJMHnoAtkqQbheRgLVFuyQ4zI0j
         5LOonZvHwrKTAthhe+z/0qOfrBebuMfH8Dmmvw4YMV7Tbg4Ev848ay/N3eEVwuzabYAo
         w6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Qbrb8i2YfiEPDxlw+wvNXikUmpcEcy9BW/zou/d27Yk=;
        b=dBI0gC2i4ANxzzAhTSZHsQj2GqKHDW5pG5WLxX3BP8ESjkwN+8WBtmKSZP4gCglx8h
         Ms5zTcKwV5liGOyUWZH6ZovzbOCluigQZh5BhfLdY8wtCOCnn1B1U5L3/hq/aI+jBvSB
         4KCsn0PIwdRO3qggCYl3BB4aAvcMjsaLwDblVtjavblG8BdkoQpTjz5tPMzS8OsZFI0b
         poFS/Qc8HX3pH6WPzallT3DtCYJvqxxpNPbBHcdjtxWSUOYlaFlIVSoa7KlY3Zm0mhv8
         4rbQkqCjJDz8dZ4DE8U2dmLr/eYH0s28jdUZiod7rVWfXddDK2PNoJJy88qkmDaggq+a
         G6LQ==
X-Gm-Message-State: AOAM533ZPzz7znQIZ2n9rhqc5ElDMNZKNl/y3ND84m4xtJFMHDqXUBen
        o1OHC7XyKa8aw6FSh1CgB3JPq0Lgqz7s
X-Google-Smtp-Source: ABdhPJxGXVmtu+oxyefg+ZGKiE48BU6y2F2sV+Thn8pEv3LX2+dqa0OSHJPRXJkG6qV6uNtFPTOxRPh1qmvJ
Sender: "maskray via sendgmr" <maskray@maskray1.svl.corp.google.com>
X-Received: from maskray1.svl.corp.google.com ([2620:15c:2ce:0:a6ae:11ff:fe11:4abb])
 (user=maskray job=sendgmr) by 2002:a0c:b18a:: with SMTP id
 v10mr4180101qvd.46.1607015152255; Thu, 03 Dec 2020 09:05:52 -0800 (PST)
Date:   Thu,  3 Dec 2020 09:05:29 -0800
Message-Id: <20201203170529.1029105-1-maskray@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH] firmware_loader: Align .builtin_fw to 8
From:   Fangrui Song <maskray@google.com>
To:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

arm64 references the start address of .builtin_fw (__start_builtin_fw)
with a pair of R_AARCH64_ADR_PREL_PG_HI21/R_AARCH64_LDST64_ABS_LO12_NC
relocations. The compiler is allowed to emit the
R_AARCH64_LDST64_ABS_LO12_NC relocation because struct builtin_fw in
include/linux/firmware.h is 8-byte aligned.

The R_AARCH64_LDST64_ABS_LO12_NC relocation requires the address to be a
multiple of 8, which may not be the case if .builtin_fw is empty.
Unconditionally align .builtin_fw to fix the linker error.

Fixes: 5658c76 ("firmware: allow firmware files to be built into kernel image")
Link: https://github.com/ClangBuiltLinux/linux/issues/1204
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Fangrui Song <maskray@google.com>
---
 include/asm-generic/vmlinux.lds.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b2b3d81b1535..3cd4bd1193ab 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -459,6 +459,7 @@
 	}								\
 									\
 	/* Built-in firmware blobs */					\
+	ALIGN_FUNCTION();						\
 	.builtin_fw        : AT(ADDR(.builtin_fw) - LOAD_OFFSET) {	\
 		__start_builtin_fw = .;					\
 		KEEP(*(.builtin_fw))					\
-- 
2.29.2.576.ga3fc446d84-goog

