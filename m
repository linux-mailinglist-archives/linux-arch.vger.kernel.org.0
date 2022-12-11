Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B176492D7
	for <lists+linux-arch@lfdr.de>; Sun, 11 Dec 2022 07:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiLKGUH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Dec 2022 01:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiLKGTP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Dec 2022 01:19:15 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C18113D1F
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:17:54 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id k7so8949071pll.6
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFAlMyj3IF3/UUq4jeZZxRRFhowQr+t72U/mQuwI0sM=;
        b=yHxJkCASry9DK7zl53ox7lXGcZoz7rY1YanNRAvckyROqQ/kLJdQuBBuna8RDFUqJ/
         to/1sqVC35uQvujqmotmJe5tRXkcneYzKTvW6Zx9A8BtEwMtvbZ/VWT1RmrkpuVYtk5o
         /L4t92+PZxshuGGrKPbjYeEhoNVlyMBBf9R8QXHICItf/yBm7N0RjuuXdNjJx7NkACRH
         awo8z8JXKVEvoC8S8Tp5ZXMAAGN0D6UORCKWSXQ5Utli3zUaWWlv6myidpdw9TdhFN6U
         axLQ68BVYBURr+oOURNCohtuVm9uvv8VCvZ+KDaiQoW3kdG63pHuxozTYo25RPUq26gK
         1Pug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFAlMyj3IF3/UUq4jeZZxRRFhowQr+t72U/mQuwI0sM=;
        b=rZS6JAL+z9nEpyTzM5KkHpgjkQoLtNj78DL5djjlRe7RFzdADWjeFhuA1zihMcDHMc
         uypPjXwfBR/DallcXZLKA1T0ec+jGDtxGXHaJ51+7nOxVD9cHV9/PsNbCcP4IkDyAHLE
         ThLjhP9yh6DU5IK5zmlzoVFc1OgKN4QR+l16B08rBdLDdtnaZqxf+/2xK7wAdWix0bFR
         X0KLY2rfn3KUHBz4D15shiy1dw+12bFbZ3U5FQRnAT3dxcdeXAnBWC104a5sgdDNFriP
         MTRD6e2xjm/oPet5tVpGgJrbiXzJJesouHFIVuX9wFgRARmV08zc1DBwn0I9CgyBcsp9
         lTvA==
X-Gm-Message-State: ANoB5pklIaGvIZtwMVNSRTWDoBwqYizOF0qq0EkHloPzCorC0fHvrm6H
        y8abH8lZ4dvYmJ6zdwg9HzsxOw==
X-Google-Smtp-Source: AA0mqf7Nw7DLg0w0NyAD+blbU0WWO5ob2T4ftyD4oCKx4LV0pzA53JU05HAYCBgLK7SfHSGhpVebew==
X-Received: by 2002:a05:6a20:6f0e:b0:a6:f26b:558 with SMTP id gt14-20020a056a206f0e00b000a6f26b0558mr13334325pzb.16.1670739473716;
        Sat, 10 Dec 2022 22:17:53 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id ij30-20020a170902ab5e00b0018b025d9a40sm3785176plb.256.2022.12.10.22.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 22:17:53 -0800 (PST)
Subject: [PATCH v2 20/24] powerpc: Remove empty <uapi/asm/setup.h>
Date:   Sat, 10 Dec 2022 22:13:54 -0800
Message-Id: <20221211061358.28035-21-palmer@rivosinc.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/powerpc/include/uapi/asm/setup.h | 5 -----
 1 file changed, 5 deletions(-)
 delete mode 100644 arch/powerpc/include/uapi/asm/setup.h

diff --git a/arch/powerpc/include/uapi/asm/setup.h b/arch/powerpc/include/uapi/asm/setup.h
deleted file mode 100644
index f2ca747aa45b..000000000000
--- a/arch/powerpc/include/uapi/asm/setup.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _UAPI_ASM_POWERPC_SETUP_H
-#define _UAPI_ASM_POWERPC_SETUP_H
-
-#endif /* _UAPI_ASM_POWERPC_SETUP_H */
-- 
2.38.1

