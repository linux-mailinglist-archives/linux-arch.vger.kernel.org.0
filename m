Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA69501DFB
	for <lists+linux-arch@lfdr.de>; Fri, 15 Apr 2022 00:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245734AbiDNWHr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Apr 2022 18:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbiDNWHp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Apr 2022 18:07:45 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6A3ADD47
        for <linux-arch@vger.kernel.org>; Thu, 14 Apr 2022 15:05:17 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id bg9so5911752pgb.9
        for <linux-arch@vger.kernel.org>; Thu, 14 Apr 2022 15:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=z18FUB9s7KBEskqVTf7aP0q/WSmapl+AGV7tm/Rzx+w=;
        b=4yj8GNYwMFBt5S0TCYDexDsiDgZ+CphToZcr69BGb+YO1dX8XzN0DW+MGc/xCJDeXb
         Hcz0uIdoJnuNbkWJiV2+Fo3CA8vLW0C1IgS1CVVzH9aUg5j68NMCEbjwNgdXnkv7fEqz
         F6CZHlw5j34X9Ls84Zrx86UjvsRc7ZpFw0TYHUhHn1yyKX3+gl4msFSRvBIaTAhSTZdL
         2YApeozR+Yfgpu19kZ4rinoHRC5MkmRhG0bqlbbT5bTMnVca/5C3iwU5CORogN7li9gJ
         eSftO1vHZa891P1ksAqxpAa0QJfvz+pd7dN+ERBzaFvvo1jYWPruym4OXs80BdrcFNBg
         2lPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=z18FUB9s7KBEskqVTf7aP0q/WSmapl+AGV7tm/Rzx+w=;
        b=w3m/gR0QPCdv0YWPTgm2b+4KFkHWlU3h2gJbd1aQNJsPzz3yrTOfS0LawXbjEBqbTP
         JJz36uENrE/qXuhFiePtxEjQuJSznBo1gKG2jXJ/4mrUT6NdvfybhDfNyh8uff8ANGVS
         p0XR9otyfYyAqEt4n7k4U4bRuGiEa/WOosgZNAp2ISD44ksq+1FJfeDW7KYGlO3+IWX0
         8JFWcEz9hjNoBe4PfOmxb1wLjB5IZL97dh1nzYHNritoIoN+6zTAm3chwXJwjUzjEGKp
         10rA1qOojRWqMJUv076z6LGgfFHxG9wNNoNmnK4ZVIj40+BY/QndhydWmo7CNTFhWRtZ
         OuMg==
X-Gm-Message-State: AOAM531r84gIbBuZcV/m4aH1W/JDT1xBkxzJsOd455nM7APLcGyy8VJ0
        7bE/bM+19hzrH8vS3xKEUSvXog==
X-Google-Smtp-Source: ABdhPJy61GZpC7zZcOHBW9CQYGCxUgM5MW1Ir+LhmYjjwp3P+2wGDB1OrlzNEu7uootqzIZd255ezw==
X-Received: by 2002:a05:6a00:1a06:b0:4fc:d6c5:f3d7 with SMTP id g6-20020a056a001a0600b004fcd6c5f3d7mr5841959pfv.53.1649973916890;
        Thu, 14 Apr 2022 15:05:16 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id n19-20020a635c53000000b0039dc2ea9876sm2697213pgm.49.2022.04.14.15.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 15:05:16 -0700 (PDT)
Subject: [PATCH v3 2/7] asm-generic: qspinlock: Indicate the use of mixed-size atomics
Date:   Thu, 14 Apr 2022 15:02:09 -0700
Message-Id: <20220414220214.24556-3-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220414220214.24556-1-palmer@rivosinc.com>
References: <20220414220214.24556-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     peterz@infradead.org, mingo@redhat.com,
        Will Deacon <will@kernel.org>, longman@redhat.com,
        boqun.feng@gmail.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, macro@orcam.me.uk,
        Greg KH <gregkh@linuxfoundation.org>,
        sudipm.mukherjee@gmail.com, wangkefeng.wang@huawei.com,
        jszhang@kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, openrisc@lists.librecores.org,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>, heiko@sntech.de, guoren@kernel.org,
        shorne@gmail.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

