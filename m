Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FD66443C6
	for <lists+linux-arch@lfdr.de>; Tue,  6 Dec 2022 14:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbiLFNAb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Dec 2022 08:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbiLFNAJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Dec 2022 08:00:09 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397582B1B4;
        Tue,  6 Dec 2022 04:59:45 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 6so13278430pgm.6;
        Tue, 06 Dec 2022 04:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/khFb5lazp4vCm4xRZ42I7pi8oBjZDH7uh4Ihyi5+A=;
        b=bFBCIcEGpsLoH1hh+w81wsAexoD/dPFAEsNeviWFtexVhoTEcy2osBHLD/x3nsZx6f
         pRnrNB4ctrsgiFOAQ1yNvY5UuysdtpXqJh66W5P2wbYvLMKVrFBlowQlmxChlwofNkVl
         fjuHrnDSt9bp7PSPZiiAuO/N7Hx0l0FLR/b1Ts0afyrDx/7qDW5b/5x4ylSoVIaVQppp
         Mtf6UNHdHldeEW135OPr53rQem+H91fpkH6K2kLVJKHGlw7JvAIAQY8jfvNH4CfR7XNw
         C+l7WHOgzL++BeNTzOcjFHU6UPUECVmWx5ZJdW8WZQ0iqRcyJl+myak6gEPXMAAj14Ld
         fNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/khFb5lazp4vCm4xRZ42I7pi8oBjZDH7uh4Ihyi5+A=;
        b=sVYJJ+SXj7U/pend4x2PI2cIMp3f6l6DMmwPeGMFs+glWmyz6kt8/YxticslTeCezM
         3RlEhiMD3TUSdtaH9whEBqqStciArgyX2kp1rKyB2QfWhbyMuVoAsMONuPD1U8ANfv7C
         kYAX5UgEdMSCjUnxRdfHVDZTCRFoBvfjwGrocoPpZGao3/rAMPnJIfH6Kna4wnNsqiws
         29g8Z7t6J9Z1AJtqcOE4vjoy/NdGOXOdRvGlnCXRv/YimJYlso/cghAeA2TB9SCUQTM9
         fhPVdESeM1cpecLCTV65EXQZWR6N6GZGj9zoymN6Y+9Oe/sSulK/vKJbmhY0M39iTb6a
         RPzA==
X-Gm-Message-State: ANoB5pnnsEIAD9MjCIyIt6qIBj/WSpwhbzepJHiKN60H703/t/MYjjQx
        sxJaxbCPVYYDUpKl7doc3gk=
X-Google-Smtp-Source: AA0mqf6HljOKz6kDuZ5/Re9QTFy0xo4TdBHZzFPCqs48LWjol+KrIax/xCp+eTe64SOrModeKPRB/w==
X-Received: by 2002:a63:195a:0:b0:477:c9d9:f8a0 with SMTP id 26-20020a63195a000000b00477c9d9f8a0mr52705642pgz.228.1670331584718;
        Tue, 06 Dec 2022 04:59:44 -0800 (PST)
Received: from localhost.localdomain ([190.92.242.52])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902a3ce00b0018968d1c6f3sm12510631plb.59.2022.12.06.04.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 04:59:44 -0800 (PST)
From:   Liam Ni <zhiguangni01@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     zhiguangni01@gmail.com
Subject: [PATCH] x86/boot: Check if the input parameter (buffer) of the function is a null pointer
Date:   Tue,  6 Dec 2022 20:59:29 +0800
Message-Id: <20221206125929.12237-1-zhiguangni01@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

If the variable buffer is a null pointer, it may cause the kernel to crash.

Signed-off-by: Liam Ni <zhiguangni01@gmail.com>
---
 arch/x86/boot/cmdline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/cmdline.c b/arch/x86/boot/cmdline.c
index 21d56ae83cdf..d0809f66054c 100644
--- a/arch/x86/boot/cmdline.c
+++ b/arch/x86/boot/cmdline.c
@@ -39,7 +39,7 @@ int __cmdline_find_option(unsigned long cmdline_ptr, const char *option, char *b
 		st_bufcpy	/* Copying this to buffer */
 	} state = st_wordstart;
 
-	if (!cmdline_ptr)
+	if (!cmdline_ptr || buffer == NULL)
 		return -1;      /* No command line */
 
 	cptr = cmdline_ptr & 0xf;
-- 
2.25.1

