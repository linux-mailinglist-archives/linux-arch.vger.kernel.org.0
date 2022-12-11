Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468096492CB
	for <lists+linux-arch@lfdr.de>; Sun, 11 Dec 2022 07:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiLKGTZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Dec 2022 01:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiLKGS0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Dec 2022 01:18:26 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EECF6153
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:17:44 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 62so6157061pgb.13
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKoO61y1D5Fc3JAsT335OlXBmbeAtig1hKjfXnIQFN8=;
        b=ppwMAmfq0vj3RT+9g4Dtvbz5MLdO6zpF3ph3yn8rPhNRloGZcb8A1WcQpTH8P0FFfU
         U7F7ASJc4eKLY58bBejeAI4zdTF7KBVDnzI8xFKzLgqb/LSGU/3FPwKaUkOUyUWc98fc
         ectUowvJ4L+nhPM5PLsoLoFnBlFZP6v/zCSigWDiE3xM9N2vK+SWI5wTfZ7r3ranMop/
         9vnmOseFziJnPSWBOeqAvIOlLpmZZREHtVkaJuD08cqpV19xcMDxu/0NU/Qbwvsn7dpY
         fvgJRhfD7MkQHL57ke4vRUFswgcXDtH2yWWSTjO/vn7H1BCbq/qUbOXV64n+g2BejGdK
         sl/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKoO61y1D5Fc3JAsT335OlXBmbeAtig1hKjfXnIQFN8=;
        b=Mr0YPzBVqptUSTkIjCxWwEBHBUFRfOzSFhhC8ikyfjJQlkWts3cmDlECNbgUBIJbCn
         FeKZfUBriGBVL/NNSZPB6YLoQc7+ANJl467XM0pHaxc+spu5/DvXFu4sHdb36kues+k2
         yVKL1Mro61kvNr5j7EZv1yiDLWfEuS4rSqWX4d7YwbKkFejswVw+ECZMJIFZ2IoWYSBP
         gtdckpoo5ZIvtBVpm6hEnt9eHmyiBx5BgzQOWwDHo7ogyWHYwb74JRXMY92i0s3zvU19
         eE88BDtmUyKFwnTwRY8+haSmEMlghdsk3B5mItw3oLlSNUY9riu7o09hQ4CDYxAVcq3j
         Aolw==
X-Gm-Message-State: ANoB5pk0MQ4I76bbxu0l2aol/evvKGzgcsjzDMiyXi8iAZGISPwqlMHJ
        eNILX9cRnLVxrwEjBneWWVRl+w==
X-Google-Smtp-Source: AA0mqf6t27hPYqiZYgJWsMkysnZ60J/iBmswbu3w2XBWCpgWsC4ttNvM594aSxL78zWit3NJ2RLsuA==
X-Received: by 2002:a62:1c97:0:b0:56b:b3f1:55a7 with SMTP id c145-20020a621c97000000b0056bb3f155a7mr11114471pfc.21.1670739463913;
        Sat, 10 Dec 2022 22:17:43 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id q1-20020aa79821000000b00574ee8d8779sm3528342pfl.65.2022.12.10.22.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 22:17:43 -0800 (PST)
Subject: [PATCH v2 12/24] asm-generic: Remove COMMAND_LINE_SIZE from uapi
Date:   Sat, 10 Dec 2022 22:13:46 -0800
Message-Id: <20221211061358.28035-13-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221211061358.28035-1-palmer@rivosinc.com>
References: <20221211061358.28035-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

As far as I can tell this is not used by userspace and thus should not
be part of the user-visible API.  Since <uapi/asm-generic/setup.h> only
contains COMMAND_LINE_SIZE we can just move it out of uapi to hide the
definition and fix up the only direct use in Loongarch.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
Link: https://lore.kernel.org/r/20210423025545.313965-1-palmer@dabbelt.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
The various empty <uapi/asm/setup.h> will soon be removed.
---
 Documentation/admin-guide/kernel-parameters.rst | 2 +-
 arch/loongarch/include/asm/setup.h              | 2 +-
 include/{uapi => }/asm-generic/setup.h          | 0
 include/uapi/asm-generic/Kbuild                 | 1 -
 4 files changed, 2 insertions(+), 3 deletions(-)
 rename include/{uapi => }/asm-generic/setup.h (100%)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 959f73a32712..3ba84ef68c4d 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -208,7 +208,7 @@ The number of kernel parameters is not limited, but the length of the
 complete command line (parameters including spaces etc.) is limited to
 a fixed number of characters. This limit depends on the architecture
 and is between 256 and 4096 characters. It is defined in the file
-./include/uapi/asm-generic/setup.h as COMMAND_LINE_SIZE.
+./include/asm-generic/setup.h as COMMAND_LINE_SIZE.
 
 Finally, the [KMG] suffix is commonly described after a number of kernel
 parameter values. These 'K', 'M', and 'G' letters represent the _binary_
diff --git a/arch/loongarch/include/asm/setup.h b/arch/loongarch/include/asm/setup.h
index ca373f8e3c4d..7a2afc95cc25 100644
--- a/arch/loongarch/include/asm/setup.h
+++ b/arch/loongarch/include/asm/setup.h
@@ -7,7 +7,7 @@
 #define _LOONGARCH_SETUP_H
 
 #include <linux/types.h>
-#include <uapi/asm/setup.h>
+#include <asm-generic/setup.h>
 
 #define VECSIZE 0x200
 
diff --git a/include/uapi/asm-generic/setup.h b/include/asm-generic/setup.h
similarity index 100%
rename from include/uapi/asm-generic/setup.h
rename to include/asm-generic/setup.h
diff --git a/include/uapi/asm-generic/Kbuild b/include/uapi/asm-generic/Kbuild
index ebb180aac74e..0e7122339ee9 100644
--- a/include/uapi/asm-generic/Kbuild
+++ b/include/uapi/asm-generic/Kbuild
@@ -20,7 +20,6 @@ mandatory-y += posix_types.h
 mandatory-y += ptrace.h
 mandatory-y += resource.h
 mandatory-y += sembuf.h
-mandatory-y += setup.h
 mandatory-y += shmbuf.h
 mandatory-y += sigcontext.h
 mandatory-y += siginfo.h
-- 
2.38.1

