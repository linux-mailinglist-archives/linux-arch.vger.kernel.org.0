Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBF16492CD
	for <lists+linux-arch@lfdr.de>; Sun, 11 Dec 2022 07:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiLKGT1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Dec 2022 01:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiLKGSa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Dec 2022 01:18:30 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA349FD6
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:17:45 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id t18so6442755pfq.13
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XIVlf99jUtMyotgTeTzLoujO1268/Odirxh24Uxg0o=;
        b=eHbllOtyUNKzq2JERop0iEv9kl/KteKzots8RAY8NV3TJyHXHv1QX7y9sYTgCqjj9M
         kzppbUUCOTHkSkhMR5TA76ufrk0a1ix+J6+BLxgL4pgH2BJiEhztZf+8yIIDsL5Xe77w
         ZkG2+4yioFE4mopndWcWsmF18aiAsnTN0BkIFz29gTahW0DJKR358kpiH26QPzH5s0ar
         PD1t8R+qEUPEzfjiz8JSihszOzzq28YbcjlDz+m5bgRtElOZ0A5TVZxl1z7ILgPM94pT
         AXU0RKI61bh9cQht0bLb5YildYMuR7RgjqT0e68+0Sy2dJUwCkYIpqSqErJPUR2B8Hv2
         602A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XIVlf99jUtMyotgTeTzLoujO1268/Odirxh24Uxg0o=;
        b=SjSxAAQDfsAsVckjMWSU3M1SzlByu2gzWyLRHzoi0GZYcrINUoLj73pj+ejj5eRfvI
         saX4OEGCeqLKo4ijs6aIXn306Jvct900u1ixehEYFdk7DxW+g3IutXDzsnqn81rkKZAu
         UmuBL2V1YvCa8i0/C4fMUXDBuEga90wY82BYIc4ahoALd33yaWxDLWujqncGiJUGQFOB
         /sHMW3l9uC0Dtcu2lTtRdklvMmAqMe3ieliLGEdRu6owQ4pyF2XsK2tc/UXm0tKg1E5F
         HBlxecsW9IWHu7QVDZnVCetIILeJ12L6y/seDzivxbzIOvUx8meY0fSP9EmBgZMFbHnd
         r/zg==
X-Gm-Message-State: ANoB5pml8uCaqCvmJFDoLZtZug+b53T0caEcgYp2UPHOGlN3dokbkTaa
        F/QWLf2CZMytKDHuQwrjc962yw==
X-Google-Smtp-Source: AA0mqf4UYmz1c1uv4LH56Im3ErHkmgnQ40ZyUM3VMm4ucRU94cyhQ8vkPoGQrDX3jGJTyZ288HcI1Q==
X-Received: by 2002:a62:b40e:0:b0:56b:d328:5441 with SMTP id h14-20020a62b40e000000b0056bd3285441mr12255090pfn.11.1670739464969;
        Sat, 10 Dec 2022 22:17:44 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id g202-20020a6252d3000000b0056b6a22d6c9sm3497451pfb.212.2022.12.10.22.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 22:17:44 -0800 (PST)
Subject: [PATCH v2 13/24] alpha: Remove empty <uapi/asm/setup.h>
Date:   Sat, 10 Dec 2022 22:13:47 -0800
Message-Id: <20221211061358.28035-14-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221211061358.28035-1-palmer@rivosinc.com>
References: <20221211061358.28035-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
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

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/alpha/include/uapi/asm/setup.h | 5 -----
 1 file changed, 5 deletions(-)
 delete mode 100644 arch/alpha/include/uapi/asm/setup.h

diff --git a/arch/alpha/include/uapi/asm/setup.h b/arch/alpha/include/uapi/asm/setup.h
deleted file mode 100644
index 9b3b5ba39b1d..000000000000
--- a/arch/alpha/include/uapi/asm/setup.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _UAPI__ALPHA_SETUP_H
-#define _UAPI__ALPHA_SETUP_H
-
-#endif /* _UAPI__ALPHA_SETUP_H */
-- 
2.38.1

