Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AEB515EC6
	for <lists+linux-arch@lfdr.de>; Sat, 30 Apr 2022 17:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382957AbiD3PlZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Apr 2022 11:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242932AbiD3PlT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Apr 2022 11:41:19 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03991A0BC3
        for <linux-arch@vger.kernel.org>; Sat, 30 Apr 2022 08:37:56 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n14so2570519plf.3
        for <linux-arch@vger.kernel.org>; Sat, 30 Apr 2022 08:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=z18FUB9s7KBEskqVTf7aP0q/WSmapl+AGV7tm/Rzx+w=;
        b=FFgRoVbZwMv/agjgfBQeiD4RduxnvL5RXSepip5M3kO2MagsWbSqQqxN8cL5qUbeSF
         BYxou0ljjXmk//t8pH9P0AP/HLxtAE0BLwIcoy+Ou0Lpi2MlCzGQ6f682gOG6CuxBpM2
         nwCLJBaCh5RV2r+qT1H5KRlCTIZUXo7CJ4l12KZINBErQtyavfgirI9l4JGBZus3gpLe
         R/LbIsa9B1VFw3791kqpL2EF7PWqMzHmRevq+xETQxk+DF6ipj782xSdFBUvyauIwqQ5
         aCr8I9PL5iINM/w5oq+qM/NT//BBL45/kvYgK8Ddw1j+NpxzLAepCkGEW3FID5OiPVqO
         qAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=z18FUB9s7KBEskqVTf7aP0q/WSmapl+AGV7tm/Rzx+w=;
        b=GrOqr5UG3kRG2QFZYhFZC4aOzcfGFADavGuL0n6esLwUl2S4N/W8NY5zgazy/bl0xI
         4bMSEh5Wv2HuQ3YXWBWRKsr3TojQQo0GPemy1pE1L+bBCcE7b/FH9pzJ+RmTIi3AGHZI
         IObo9lTLFhadk17bgpFWtxBOC0QJl0VXLZ/yprFHzNZLbN6KAFH7TUi/srlOAL6ZiYmt
         hK5uSGCIgLdDlDxQHtzWSOgz4B6hyxkalTI2rIfO1b8L8GyGE826c0hqDbAbq3S00ob9
         RRJueNLNW3dmTinHpA6yJDv9F7AEqgZXfYWupl4Td4UPH28FlKoTxNbCPG0BIzNITXSq
         DCHA==
X-Gm-Message-State: AOAM5312GGde/13Y48DjwBVFgFbXK0IFcbT+luu7pjqv48ILaYZgAwF3
        wrGEaLmLFaxAh8zpPzZ4BkDvBg==
X-Google-Smtp-Source: ABdhPJzOcQtcQr8kDnX5vfoKXrEejVF7HXmixwlBQw/BjGtWP2W5ppTBL/zygWmxy79MN6V3JkKj7Q==
X-Received: by 2002:a17:90b:688:b0:1d9:9ddd:1f71 with SMTP id m8-20020a17090b068800b001d99ddd1f71mr9480283pjz.207.1651333075503;
        Sat, 30 Apr 2022 08:37:55 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id y14-20020a62b50e000000b0050dc7628165sm1669724pfe.63.2022.04.30.08.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 08:37:55 -0700 (PDT)
Subject: [PATCH v4 2/7] asm-generic: qspinlock: Indicate the use of mixed-size atomics
Date:   Sat, 30 Apr 2022 08:36:21 -0700
Message-Id: <20220430153626.30660-3-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220430153626.30660-1-palmer@rivosinc.com>
References: <20220430153626.30660-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     guoren@kernel.org, peterz@infradead.org, mingo@redhat.com,
        Will Deacon <will@kernel.org>, longman@redhat.com,
        boqun.feng@gmail.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        sudipm.mukherjee@gmail.com, macro@orcam.me.uk, jszhang@kernel.org,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        openrisc@lists.librecores.org, linux-riscv@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

The qspinlock implementation depends on having well behaved mixed-size
atomics.  This is true on the more widely-used platforms, but these
requirements are somewhat subtle and may not be satisfied by all the
platforms that qspinlock is used on.

Document these requirements, so ports that use qspinlock can more easily
determine if they meet these requirements.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 include/asm-generic/qspinlock.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index d74b13825501..95be3f3c28b5 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -2,6 +2,37 @@
 /*
  * Queued spinlock
  *
+ * A 'generic' spinlock implementation that is based on MCS locks. An
+ * architecture that's looking for a 'generic' spinlock, please first consider
+ * ticket-lock.h and only come looking here when you've considered all the
+ * constraints below and can show your hardware does actually perform better
+ * with qspinlock.
+ *
+ *
+ * It relies on atomic_*_release()/atomic_*_acquire() to be RCsc (or no weaker
+ * than RCtso if you're power), where regular code only expects atomic_t to be
+ * RCpc.
+ *
+ * It relies on a far greater (compared to asm-generic/spinlock.h) set of
+ * atomic operations to behave well together, please audit them carefully to
+ * ensure they all have forward progress. Many atomic operations may default to
+ * cmpxchg() loops which will not have good forward progress properties on
+ * LL/SC architectures.
+ *
+ * One notable example is atomic_fetch_or_acquire(), which x86 cannot (cheaply)
+ * do. Carefully read the patches that introduced
+ * queued_fetch_set_pending_acquire().
+ *
+ * It also heavily relies on mixed size atomic operations, in specific it
+ * requires architectures to have xchg16; something which many LL/SC
+ * architectures need to implement as a 32bit and+or in order to satisfy the
+ * forward progress guarantees mentioned above.
+ *
+ * Further reading on mixed size atomics that might be relevant:
+ *
+ *   http://www.cl.cam.ac.uk/~pes20/popl17/mixed-size.pdf
+ *
+ *
  * (C) Copyright 2013-2015 Hewlett-Packard Development Company, L.P.
  * (C) Copyright 2015 Hewlett-Packard Enterprise Development LP
  *
-- 
2.34.1

