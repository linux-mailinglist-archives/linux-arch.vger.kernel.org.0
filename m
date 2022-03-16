Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1F54DBB09
	for <lists+linux-arch@lfdr.de>; Thu, 17 Mar 2022 00:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347538AbiCPX3t (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Mar 2022 19:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346003AbiCPX3m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Mar 2022 19:29:42 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC64167C8
        for <linux-arch@vger.kernel.org>; Wed, 16 Mar 2022 16:28:26 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id a5so5419482pfv.2
        for <linux-arch@vger.kernel.org>; Wed, 16 Mar 2022 16:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=ofUFlPn1fFr6Pz05IWJLvQM8LyheEnwZgHIcbcC4aPw=;
        b=S5EoqvKolpNViVFVC6Nzsj4aBgAWTlxXUWEEMY7p3wEb0057ehZpzaUnP8f4GDTFJs
         zse0vx0vaol845GXW+EPh58H5hafan3CLwS2NebIMBjef8U0HNWEx3yRz3jPiV3uJlEC
         YXWJrMiwVe+oiaYZPhnxkOPG0gNmZ72sB2JgKC7u3KkkHP6Mrza8LqpBn+wgIhU0+wXO
         eiGMxzeY0dkF1fMYunyzzQlM6whMlxgT8yXppR7Shy3VF4INxmMTGDdTecXUZiBbWpJi
         KxadBRMOObu8VavJ+IpQtZPAu2dQ5o1nwyDfes8oJeqdvEAFgSJuP+TqCD4jDajWtIKl
         w7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=ofUFlPn1fFr6Pz05IWJLvQM8LyheEnwZgHIcbcC4aPw=;
        b=EFjF1FxE+PyQYiItV/p7nWx7Vbt2ECVCQ5p+tMD+y2/cMMNIAsiGPFHCURGNR5Cihy
         tOiLlzDvM0/wwaN29n+K09XQ7V1ZlfqxpeHbz9faNQDeDrz+u3n4ZD7UPq6jQyrpvFIk
         FWZvmrgB7N4Msz6kOWE8L4AHrK+fo1qO3rkyb5JiFsVwRZA4HPgmu8dnpXoct8aY8N0Z
         JPQn0GNkfNv59zT6H0ni3HOvasd9och57CdpqRTppMjU5/0HNpPVBXuGKVM7t9a+0hTK
         n/5SeU8iJlLMqrXcCUy7c+vkFIF2tLZgKSzltg+lMp3wA6YFFt9EynaB6hovZnJfHPyu
         fY+g==
X-Gm-Message-State: AOAM531L2adXV93VYKy/lxjg3/RVqL4MO4RGB2uKSOq7htM6i5h51/LL
        3TYrn59mcRgfp/haGCzoEMSwwA==
X-Google-Smtp-Source: ABdhPJxYRrhM5pW5WVasmxAVWyXeEsoX5VSiHkFO1pWtO6NNC1CxKjdOixv6tMKvEgnHK4ZptvG9zQ==
X-Received: by 2002:a63:5855:0:b0:380:a9f7:e373 with SMTP id i21-20020a635855000000b00380a9f7e373mr1418979pgm.557.1647473305604;
        Wed, 16 Mar 2022 16:28:25 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id l186-20020a633ec3000000b003820485172asm145763pga.65.2022.03.16.16.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 16:28:25 -0700 (PDT)
Subject: [PATCH 1/5] asm-generic: qspinlock: Indicate the use of mixed-size atomics
Date:   Wed, 16 Mar 2022 16:25:56 -0700
Message-Id: <20220316232600.20419-2-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220316232600.20419-1-palmer@rivosinc.com>
References: <20220316232600.20419-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        shorne@gmail.com, mingo@redhat.com, Will Deacon <will@kernel.org>,
        longman@redhat.com, boqun.feng@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, jszhang@kernel.org,
        wangkefeng.wang@huawei.com, openrisc@lists.librecores.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arch@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:         linux-riscv@lists.infradead.org, peterz@infradead.org
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

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

---

I have specifically not included Peter's SOB on this, as he sent his
original patch
<https://lore.kernel.org/lkml/YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net/>
without one.
---
 include/asm-generic/qspinlock.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index d74b13825501..a7a1296b0b4d 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -2,6 +2,36 @@
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
+ * It relies on a far greater (compared to ticket-lock.h) set of atomic
+ * operations to behave well together, please audit them carefully to ensure
+ * they all have forward progress. Many atomic operations may default to
+ * cmpxchg() loops which will not have good forward progress properties on
+ * LL/SC architectures.
+ *
+ * One notable example is atomic_fetch_or_acquire(), which x86 cannot (cheaply)
+ * do. Carefully read the patches that introduced queued_fetch_set_pending_acquire().
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

