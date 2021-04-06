Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D191355B80
	for <lists+linux-arch@lfdr.de>; Tue,  6 Apr 2021 20:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhDFSgk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Apr 2021 14:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240602AbhDFSgh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Apr 2021 14:36:37 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDD6C061756;
        Tue,  6 Apr 2021 11:36:29 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id n44so2639799qvg.12;
        Tue, 06 Apr 2021 11:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OMBL51erj9+Vrtx9tqjkMZq1L3G+kUiG4cH78jXhyeQ=;
        b=o+Byowlye0BovqyyR1MH2/spfkEJ7gGL8mwESzGxs3PDJXpMe/oJPd8lHNCqANJnSv
         rvxlI6T/4rWpthfe134VWUvDFMA09gBrV9WMHXtpFgDMM4QzOHnZ2XcUV6W6nkflrfzg
         n4Zlb2MTKkNrqXwFlNRA03LKYaofLMWYz8H3xdUKj7IP4x8vSoXzS+xGUJs/jlGRCrsR
         flYJZ3Reb/VrgrblxQ7KjPMqa+op8UwBvv9RjdTpnbIxP+ydiwnehZXEb44ozUnQn2iR
         ztRVFsVAd6qMHHnCYz5ffYqdaE/miafS9brwq14o0L8w08SygCNeDUC2QqsBV1908sIH
         yR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OMBL51erj9+Vrtx9tqjkMZq1L3G+kUiG4cH78jXhyeQ=;
        b=rNxBAdDdlx1Uy3UbAz6viKZDIfoMN61inYV9BII/QgbBfPly03B6HdzDzYkaWPeae5
         70syCoYAf7cYa3OaPFd3OqCyOBRs4BvqDYSFeUUmMhciWjW4hCuyeSYpjd4/VqcpF5Cb
         fmog60K4piypl4Z3aIRtX4eFKU+VtSni9VEtD/EqPTKHId+6C5yBGgXXwn3hfYdaF42n
         cnbeaco5dXWlYTcBO3urrEhhGzn3EFG2NAMxEtta4JDXfzNILZpoeL+NCfQZ59S0SPRG
         CHzgjSnptwwMD15eDCs8fF6C+kAxNssYYRv23ICIvB6A1gSLsHWxc/I2Ws7x7OfS/1V1
         Sg2w==
X-Gm-Message-State: AOAM530FjQSEkRHkiWhI2WwRIuwJkRg8h3ZgffGC/2ciyn0vHL4ZXF4D
        AcqHwYa0955fja9PEHWJNXw=
X-Google-Smtp-Source: ABdhPJw86D/RS0RBX62jK4DDvGhhh9WVc4WvIH5LX9L9lxLCMBOsvjq9g7aRNNyR5FkA9SZwW3cq9A==
X-Received: by 2002:a0c:fca8:: with SMTP id h8mr19112484qvq.3.1617734188367;
        Tue, 06 Apr 2021 11:36:28 -0700 (PDT)
Received: from localhost ([2601:4c0:104:d5fc:c1b1:fa44:c411:7822])
        by smtp.gmail.com with ESMTPSA id k24sm15522255qtu.35.2021.04.06.11.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 11:36:27 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Yury Norov <yury.norov@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] h8300: rearrange headers inclusion order in asm/bitops
Date:   Tue,  6 Apr 2021 11:36:25 -0700
Message-Id: <20210406183625.794227-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The commit a5145bdad3ff ("arch: rearrange headers inclusion order in
asm/bitops for m68k and sh") on next-20210401 fixed header ordering issue.
h8300 has similar problem, which was overlooked by me.

h8300 includes bitmap/{find,le}.h prior to ffs/fls headers. New fast-path
implementation in find.h requires ffs/fls. Reordering the headers inclusion
sequence helps to prevent compile-time implicit function declaration error.

v2: change wording in the comment.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/h8300/include/asm/bitops.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/h8300/include/asm/bitops.h b/arch/h8300/include/asm/bitops.h
index 7aa16c732aa9..c867a80cab5b 100644
--- a/arch/h8300/include/asm/bitops.h
+++ b/arch/h8300/include/asm/bitops.h
@@ -9,6 +9,10 @@
 
 #include <linux/compiler.h>
 
+#include <asm-generic/bitops/fls.h>
+#include <asm-generic/bitops/__fls.h>
+#include <asm-generic/bitops/fls64.h>
+
 #ifdef __KERNEL__
 
 #ifndef _LINUX_BITOPS_H
@@ -173,8 +177,4 @@ static inline unsigned long __ffs(unsigned long word)
 
 #endif /* __KERNEL__ */
 
-#include <asm-generic/bitops/fls.h>
-#include <asm-generic/bitops/__fls.h>
-#include <asm-generic/bitops/fls64.h>
-
 #endif /* _H8300_BITOPS_H */
-- 
2.25.1

