Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EA9207DE9
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 22:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391589AbgFXU65 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 16:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389792AbgFXU6X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 16:58:23 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7DAC0617BA
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:58:20 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id o11so2449025qti.23
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Nq9F0z4123tt4UqM776+npgcQr2vACSfzkMX0VOkyz8=;
        b=BxVsCiRl31FUZaXeXGi8TV70WMTRIEfLDWFsMjf9VqWbt1aplCwkMUV6du/2DbXHDA
         nmIqbT++UfoVt2spbm6O4fmSAaacN8xjQv9Vk7mvxhaVZJ9BPTkHJu8aBCdCnIu51P5m
         wZ24eLo2g5qlSjSP/eIlooA1u/pqdwQEihkdjLYouX/8rVxWrLxhZOX/WQfJheEnbE5o
         v0W7rWqeaGSn+q7Ev6eTL12tKFayk99cr69qnKqzeZeUGe9TC4veYRnMtqICU6y6UEt0
         7wl+R6AWP851Ken+D6iQ9SXiZ9pQ1MwxBJLG5X11cZGeJs5LD4j/ew5gVX1NXLQSps+b
         CAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Nq9F0z4123tt4UqM776+npgcQr2vACSfzkMX0VOkyz8=;
        b=oXCSAyrwYZBihuJb0fAilG+6gbEAEyL+kTCcapGP9bLJhpk+Z7nosCTlnM3TCZs5Hm
         6Ohw9vYLTcYdzQA8ziRCl3ExfcBonKhSBiMKOB0818M81BRY4j8vjXiQP/4RpuYn3fFG
         C6uhcaRClVy8rwkkO17JPAyw8cCDb0CvoD5sw//0wVLq9NcUYS1WZyjOsRx0Igm7cKr8
         vx9FoD/gVpuNIQDwiq6mF3cpWkh2BKhTQX92aVyc9E8/PeaAKW09TmjnFCMI18yEtReS
         kRCK7SHS6hq5/cFVPY+ofLoVoqpegDViY4FQ8aDZDEgqX2qrxJWJM720AW0IL6UlUD6k
         E94w==
X-Gm-Message-State: AOAM532AfFEsE2lBWamj+MLfULqhFgrHxIhKjKYARLB0kUnXGnkBQKaQ
        jFVXdEtdUuBI2eCPdFlN7OtEPeMgyOT4UlEzInTMEA==
X-Google-Smtp-Source: ABdhPJzQqVhx61203uYXm1i0yxcc0AnVKozIfTJnOAmP5bxUytYJO1bkE34YZASYNKaxdzL6HRViJV73fScMedut3CXRZg==
X-Received: by 2002:a0c:ecc6:: with SMTP id o6mr32877909qvq.243.1593032299582;
 Wed, 24 Jun 2020 13:58:19 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:55:45 -0700
In-Reply-To: <20200624205550.215599-1-brendanhiggins@google.com>
Message-Id: <20200624205550.215599-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200624205550.215599-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v4 06/11] arch: xtensa: add linker section for KUnit test suites
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        monstr@monstr.eu, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, chris@zankel.net, jcmvbkbc@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a linker section to xtensa where KUnit can put references to its
test suites. This patch is an early step in transitioning to dispatching
all KUnit tests from a centralized executor rather than having each as
its own separate late_initcall.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/xtensa/kernel/vmlinux.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/xtensa/kernel/vmlinux.lds.S b/arch/xtensa/kernel/vmlinux.lds.S
index d23a6e38f0625..9aec4ef67d0b0 100644
--- a/arch/xtensa/kernel/vmlinux.lds.S
+++ b/arch/xtensa/kernel/vmlinux.lds.S
@@ -216,6 +216,10 @@ SECTIONS
     INIT_RAM_FS
   }
 
+  .kunit_test_suites : {
+  	KUNIT_TEST_SUITES
+  }
+
   PERCPU_SECTION(XCHAL_ICACHE_LINESIZE)
 
   /* We need this dummy segment here */
-- 
2.27.0.212.ge8ba1cc988-goog

