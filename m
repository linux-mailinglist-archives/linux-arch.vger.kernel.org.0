Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CC26FC48D
	for <lists+linux-arch@lfdr.de>; Tue,  9 May 2023 13:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbjEILHw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 May 2023 07:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbjEILHv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 May 2023 07:07:51 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE48219AF;
        Tue,  9 May 2023 04:07:49 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a50cb65c92so40243865ad.0;
        Tue, 09 May 2023 04:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683630469; x=1686222469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GrfixzbraZH9Q9ixn6Nkit2FqnHKmBjaOHnxSQju84U=;
        b=CsEvbAh+J4uE9iLr8y6EcDFVO7scBKKkTDYWsc76PmQGdiOpwEYrKSKaqw7FffLmIz
         RhhCbFHg3qhWSZm0kJSSaU+Lw4O6xkddIwfvoWDAQJPRMYLWMz5Asvaq7tu9ZJvawS/e
         Xwb9NMLnAGoSXgENfXxVjNcO2ZkUIWcKcrda85TIkZg+mQeAwvElz5Oi/QD7fPWQtszT
         T3EYAOupzDmGVMR/UnA0R9WYyiAam1Lzapaxg/ctlnIBnSrzpcSy9NGepIARzwvomDjh
         IuZHon74dTQzb4ViD4Bzco2L2UWNRhjsgpuVbA8p+M7CKyD2Od9/47wvM38yJs705Xr/
         jSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683630469; x=1686222469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GrfixzbraZH9Q9ixn6Nkit2FqnHKmBjaOHnxSQju84U=;
        b=TWnpZUVdLVSUAUc28+J33A6oEH06IWTyf5Fu8la38m2o4S6wBfd6tWB2+w1VkVpgmG
         o4K8Gk94bX4az6PdpUhJp2NLAiU5fzF+JeYTp40OFwm6O/WSjo8+L8ZVEawd/hNf/sE8
         vwKRpzgLoxsFnjBQEc4pmaqB1RthAmP0WfdgaRIFSKP2VvR8COsj6SBNkCaQAXxFB8cN
         J8h5Fthk4mhT5bR4cc+qbTSFt16+BzFZFljX2fYHGdMkto3KOEI+WAONvA6LILVlbw+I
         XppRP62AkOqaifOX1IW8wcWUYhV6aIYdYdTC0hYXnqjIZtyeJ0Cq6kVtl7AGWdzNLKZ2
         CjnQ==
X-Gm-Message-State: AC+VfDzZZIGfAPY88PLrvo3ZZS8R2pMgxNUn1Bb+jqBfr0DAb6Rt31CI
        HKrgUwj0t5lZzmOIj8eX7sGBnivuDT4=
X-Google-Smtp-Source: ACHHUZ6LRORx67H+n0hiniE3cE09LQJKDWrtWVc8q4Ho+j1++f9OQTtc1NYibPh2fH0UC8laIUkJ4A==
X-Received: by 2002:a17:902:7b91:b0:1ac:34fe:d040 with SMTP id w17-20020a1709027b9100b001ac34fed040mr12429222pll.50.1683630468717;
        Tue, 09 May 2023 04:07:48 -0700 (PDT)
Received: from wheely.local0.net ([118.208.131.108])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090270c500b001a641ea111fsm1269923plt.112.2023.05.09.04.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 04:07:48 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH 0/3] Prohibit irq disable when disabled or enable when enabled
Date:   Tue,  9 May 2023 21:07:36 +1000
Message-Id: <20230509110739.241735-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

Any thoughts on tightening this up and adding some warnings for this?
Motivated by a bug I added to powerpc which broke disabled-disable
callers.

Not that I necessarily want archs to be able to depend on this, it
would always be better to be tolerant. But it seems a risky pattern
for random code to be using.

This still fires off quite a few warnings on powerpc, and I haven't
test booted any other arch so probably wouldn't ask to upstream patch
3 just yet, but if there are no objections to the idea I might do a
bit more work on it.

Thanks,
Nick

Nicholas Piggin (3):
  hrtimer: balance irq save/restore
  init: Require archs call start_kernel with arch irqs disabled
  irqflags: Warn on irq disable when disabled and enable when enabled

 include/linux/irqflags.h       | 26 ++++++++++++++++++++++++--
 init/main.c                    |  6 +++++-
 kernel/locking/irqflag-debug.c | 14 ++++++++++++++
 kernel/time/hrtimer.c          | 22 +++++++++++-----------
 4 files changed, 54 insertions(+), 14 deletions(-)

-- 
2.40.1

