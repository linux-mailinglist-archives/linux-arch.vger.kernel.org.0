Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE6C42409A
	for <lists+linux-arch@lfdr.de>; Wed,  6 Oct 2021 16:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239137AbhJFPBB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Oct 2021 11:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238226AbhJFPBB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Oct 2021 11:01:01 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F938C061746;
        Wed,  6 Oct 2021 07:59:09 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u18so9761172wrg.5;
        Wed, 06 Oct 2021 07:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YV9ztV9xa2SuX3HIxstgvWzEEnBcrdgp13MusSmPbpA=;
        b=ikzrDcGLA8Kd+BQ/z42ALgP7DgM7QpBp2X33jKpROLka6mn0oXSHZtKDBInUvuhYth
         vIvddKlCD+9WhI0/9Hs/Bb//zPomw2hHTHjYWkYhnSdAQLF0r7NdRUnI6xzXliYvmKrx
         eZORcANpDNELyeEYgEOPatkfCVtyp15mPfx+et20USafzaNrP0xTKJ9wl6q0JAAuS4NK
         q/3NefaWmm8NlFEVkpC7RwzyZIUQYVclm1OrhFmDLVwc+JGGQJHxsNPQgklVuSpY6hIe
         ToYlkiHvnJGnwfIGrUrF5N9wfONznGZfvQItOfc1ERdqnWH+KfWNGalolXQS/y5ZHJEq
         XmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YV9ztV9xa2SuX3HIxstgvWzEEnBcrdgp13MusSmPbpA=;
        b=65ul6DuZuYWK9RHBjjKyYc+KsY15YwJL14MDFOTlObpMqSv9D0uBaV8mBlzUUkqwEd
         eFP7IReGrgaH5GEwrNYAfo+QJGtJlWmZub+BTwHOfD1amG803uttotsZInCIGW5uH0nb
         HHge+nJFMWt6OxF7TFbePO6yARWtyfG4nFUna0PFHLF+dBJWknqOTadBUu3r+l+xKLg3
         ojjjFcrADh7Gg0J2+JGU1o8X67j91Mmf5dWxLrFAuz3Ioexv5kfAMoPRkXieJ5QZilGG
         5Ulelx64nLCR+47OprCmrciSfypQ7pvwGm3Da/a5ziteOuGqDR1ri0am0FmM1yDyh182
         WMPQ==
X-Gm-Message-State: AOAM532E7E1ywjUaOwAnxB5uGfo4+thmiImYgHeJJxovJt7MWqA5TbN3
        pK2gGfYuGOM08amRCYC2Hc8=
X-Google-Smtp-Source: ABdhPJzc7PF/Xen3kx4m+BH/K9IyR+PBDPrqUaxyO6vs8Z0w/F26OAw9+rYSrQIfTWym05fECsXIew==
X-Received: by 2002:a7b:c441:: with SMTP id l1mr10172275wmi.69.1633532347600;
        Wed, 06 Oct 2021 07:59:07 -0700 (PDT)
Received: from DEL01237W.ebgroup.elektrobit.com (eth1-fw1-nbg6.eb.noris.de. [213.95.148.172])
        by smtp.gmail.com with ESMTPSA id r205sm1886848wma.3.2021.10.06.07.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 07:59:07 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-arch@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] asm-generic: correct reference to GENERIC_LIB_DEVMEM_IS_ALLOWED
Date:   Wed,  6 Oct 2021 16:58:59 +0200
Message-Id: <20211006145859.9564-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Commit 527701eda5f1 ("lib: Add a generic version of devmem_is_allowed()")
introduces the config symbol GENERIC_LIB_DEVMEM_IS_ALLOWED, but then
falsely refers to CONFIG_GENERIC_DEVMEM_IS_ALLOWED (note the missing LIB
in the reference) in ./include/asm-generic/io.h.

Luckily, ./scripts/checkkconfigsymbols.py warns on non-existing configs:

GENERIC_DEVMEM_IS_ALLOWED
Referencing files: include/asm-generic/io.h

Correct the name of the config to the intended one.

Fixes: 527701eda5f1 ("lib: Add a generic version of devmem_is_allowed()")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 include/asm-generic/io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index cc7338f9e0d1..6364174504d7 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1125,7 +1125,7 @@ static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
 }
 #endif
 
-#ifndef CONFIG_GENERIC_DEVMEM_IS_ALLOWED
+#ifndef CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED
 extern int devmem_is_allowed(unsigned long pfn);
 #endif
 
-- 
2.26.2

