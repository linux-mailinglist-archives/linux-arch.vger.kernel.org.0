Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6C080128
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2019 21:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406265AbfHBTlk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Aug 2019 15:41:40 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43461 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406257AbfHBTlk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Aug 2019 15:41:40 -0400
Received: by mail-qk1-f195.google.com with SMTP id m14so30011018qka.10
        for <linux-arch@vger.kernel.org>; Fri, 02 Aug 2019 12:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WQAwxez96oUqOKhi5Otfo6AhSFIujCjLEKW9DkJRHyE=;
        b=gVnr52O9krwfQO7y4J7MjYdcZqCTJpMMIUn+Z08zsYXXmEldYmkrxz0coPApUy1ns/
         yAK8FI9kIlFe4gSaS3flfVCu+64pNIpWD8Nr6B9mGDiOGd4T+YruwYAE26ld3JoQYHSB
         WZlQQRQQ5yeCgDnStPHP5ReCPMMrnIx+7Qqs07vRfgEaTCfGaiOPC1jMRWP7/1sTRDL0
         FqWzYJT5bVZmot8Q9K9s8csJZvJE4DU2LHyqq2ddCmefRM0ilTCRJtCJw4bC3AycPHGP
         itefR9moAo171YUlBbl5L1+wChREPsXT4S9LhMGO1fbN5/LdsHuzVoT1iRp7wOD9pYOQ
         TBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WQAwxez96oUqOKhi5Otfo6AhSFIujCjLEKW9DkJRHyE=;
        b=UASZOEYE1a4qgTWvJ9WP6sA8qI0vj6uqK2NQ1T/OUbtQdjo6CnWFHxZdkXVv3R9yX4
         DUip4Taz4NRl8tVPbiBltCMncL7VpXYALaKTiFiQ2rC4k3/wKEiERZlDQOD8vcHd8/y7
         Q+x7tfbKDfzUmVq8NIxVpecaCvs0TaIDBqZKdlF2w9TdhseunEee5Pl6ztIu0P0Y8B9j
         H8UoD8Hh1kh+kx9CqPTvRWA1NEk4kOq/qfbSBPGvJhwJ9nhfjtkSdV9GvQxcCsqSPIr/
         XwCCygaXNLuh798Gn99/gGsL9aoXFrjFEDdIPvkMYng6W2upjnLdzTtzJGopvQD9QFOx
         0hsg==
X-Gm-Message-State: APjAAAUPMzb1RCH6/vDjTzKL44D+kakOEKl6BlkHC1Kb8VShnxu3VFLv
        LsWORhX4CJrt+bKu1gNfdeISdA==
X-Google-Smtp-Source: APXvYqynXU2mckBK2mwl5pSKz+zstWguPmWFjVj13oC2WPpCvJ7NZTmDSEt0zerfIF1SxvJdKDtbMA==
X-Received: by 2002:a37:48c7:: with SMTP id v190mr93631953qka.350.1564774899382;
        Fri, 02 Aug 2019 12:41:39 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 39sm41877782qts.41.2019.08.02.12.41.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 12:41:38 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     arnd@arndb.de, kirill.shutemov@linux.intel.com, mhocko@suse.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] asm-generic: fix variable 'p4d' set but not used
Date:   Fri,  2 Aug 2019 15:41:22 -0400
Message-Id: <1564774882-22926-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

GCC throws a warning on an arm64 system since the commit 9849a5697d3d
("arch, mm: convert all architectures to use 5level-fixup.h"),

mm/kasan/init.c: In function 'kasan_free_p4d':
mm/kasan/init.c:344:9: warning: variable 'p4d' set but not used
[-Wunused-but-set-variable]
  p4d_t *p4d;
         ^~~

because p4d_none() in "5level-fixup.h" is compiled away while it is a
static inline function in "pgtable-nopud.h". However, if converted
p4d_none() to a static inline there, powerpc would be unhappy as it
reads those in assembler language in
"arch/powerpc/include/asm/book3s/64/pgtable.h",

./include/asm-generic/5level-fixup.h: Assembler messages:
./include/asm-generic/5level-fixup.h:20: Error: unrecognized opcode:
`static'
./include/asm-generic/5level-fixup.h:21: Error: junk at end of line,
first unrecognized character is `{'
./include/asm-generic/5level-fixup.h:22: Error: unrecognized opcode:
`return'
./include/asm-generic/5level-fixup.h:23: Error: junk at end of line,
first unrecognized character is `}'
./include/asm-generic/5level-fixup.h:25: Error: unrecognized opcode:
`static'
./include/asm-generic/5level-fixup.h:26: Error: junk at end of line,
first unrecognized character is `{'
./include/asm-generic/5level-fixup.h:27: Error: unrecognized opcode:
`return'
./include/asm-generic/5level-fixup.h:28: Error: junk at end of line,
first unrecognized character is `}'
./include/asm-generic/5level-fixup.h:30: Error: unrecognized opcode:
`static'
./include/asm-generic/5level-fixup.h:31: Error: junk at end of line,
first unrecognized character is `{'
./include/asm-generic/5level-fixup.h:32: Error: unrecognized opcode:
`return'
./include/asm-generic/5level-fixup.h:33: Error: junk at end of line,
first unrecognized character is `}'
make[2]: *** [scripts/Makefile.build:375:
arch/powerpc/kvm/book3s_hv_rmhandlers.o] Error 1

Fix it by reference the variable in the macro instead.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 include/asm-generic/5level-fixup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/5level-fixup.h b/include/asm-generic/5level-fixup.h
index bb6cb347018c..2c3e14c924b6 100644
--- a/include/asm-generic/5level-fixup.h
+++ b/include/asm-generic/5level-fixup.h
@@ -19,7 +19,7 @@
 
 #define p4d_alloc(mm, pgd, address)	(pgd)
 #define p4d_offset(pgd, start)		(pgd)
-#define p4d_none(p4d)			0
+#define p4d_none(p4d)			((void)p4d, 0)
 #define p4d_bad(p4d)			0
 #define p4d_present(p4d)		1
 #define p4d_ERROR(p4d)			do { } while (0)
-- 
1.8.3.1

