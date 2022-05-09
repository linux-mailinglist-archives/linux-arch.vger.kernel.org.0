Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B425207C9
	for <lists+linux-arch@lfdr.de>; Tue, 10 May 2022 00:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiEIWhx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 May 2022 18:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiEIWgV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 May 2022 18:36:21 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7425F2B94FB
        for <linux-arch@vger.kernel.org>; Mon,  9 May 2022 15:32:26 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id x88so2798215pjj.1
        for <linux-arch@vger.kernel.org>; Mon, 09 May 2022 15:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=08o9m5Hkc1DwgHXwEhIgYa1O84W5gO7UU5kFrcD0IRY=;
        b=Ivfni2BR3drjv+XoR/hBXUrgG62qyubSK3Ofq7nGB2uI3j7DeKiw7jRrhjYIPRgbiL
         fX9foK05Y7Jog/gVmvwsgPmkiISwecG0vWlaNbZPsib7PJe/U0FrjNlpjZeqJTMnA4Ud
         xD2a5Ri7G1reYFJHWM8J0ABchfZtYYpFEJm7EacP6oMYWcpyn/f0Z1zDck1YxAxeMMcF
         un3MVzMWYPTLkAP7W6QyxETK9WwzzVdbB+7M0G8w56mYUpSu+iAgFJ/e7C0edwi86i0F
         9CtnFPdWIKaX25L03L6TPjghHJhiIfuQAKj24e211/mTSajbwfjFHu6V4QDWxV3ozgp7
         ADmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=08o9m5Hkc1DwgHXwEhIgYa1O84W5gO7UU5kFrcD0IRY=;
        b=vALaKOyRAwYemBBd8WrAKAMuudqtC03DDJvbKNubqo4n5RdPNbu/Fh4HFiAj/w2aD1
         3tH86Ln0y4Rrese3+WCxhxBw1W/Isqca8tyHTJAJjj3HWLOJEV/b58pngxb10c9y6yLC
         PUNIL0S/shIP9XWd47lwbYeXe6NXTtqmih0LYBwzVld0fDyS/U84Zq4e/IaCgQXVjmKf
         XCoWZ9h226VbmdMNeL3top2No9S/84+CxBGFCnoUk3E49ptBI1HFDQjLdrkVnqTJKAHs
         C7hsTsOekdLTM2RrLp5w8ZKJySyXITgFEGkXjgphDLcHsYQnIPPjcDPhFen35yZI5q1P
         ZeBg==
X-Gm-Message-State: AOAM533PlpY6JGtbxv1HMBvFfXFfFDBsAUjzmUTFg/pfzN2ozvjMQuFt
        tG5NyOFSU5IHXhuJwOgEF8MquQ==
X-Google-Smtp-Source: ABdhPJwfKDrkaUHJSNgn6XFJOuCcJbR4otch9RHfl10t4H02hdxl8ivFVYd6BH4xCpPZNyXowDk67w==
X-Received: by 2002:a17:903:1205:b0:15e:804c:fab4 with SMTP id l5-20020a170903120500b0015e804cfab4mr18051563plh.112.1652135545965;
        Mon, 09 May 2022 15:32:25 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id oa7-20020a17090b1bc700b001dcc0cb262asm224098pjb.17.2022.05.09.15.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 15:32:25 -0700 (PDT)
Subject: [PATCH v5 2/7] asm-generic: qspinlock: Indicate the use of mixed-size atomics
Date:   Mon,  9 May 2022 15:29:51 -0700
Message-Id: <20220509222956.2886-3-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220509222956.2886-1-palmer@rivosinc.com>
References: <20220509222956.2886-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     guoren@kernel.org, peterz@infradead.org, mingo@redhat.com,
        Will Deacon <will@kernel.org>, longman@redhat.com,
        boqun.feng@gmail.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, macro@orcam.me.uk,
        Greg KH <gregkh@linuxfoundation.org>,
        sudipm.mukherjee@gmail.com, jszhang@kernel.org,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        openrisc@lists.librecores.org, linux-riscv@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>
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
Reviewed-by: Arnd Bergmann <arnd@arndb.de
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 include/asm-generic/qspinlock.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index d74b13825501..995513fa2690 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -2,6 +2,35 @@
 /*
  * Queued spinlock
  *
+ * A 'generic' spinlock implementation that is based on MCS locks. For an
+ * architecture that's looking for a 'generic' spinlock, please first consider
+ * ticket-lock.h and only come looking here when you've considered all the
+ * constraints below and can show your hardware does actually perform better
+ * with qspinlock.
+ *
+ * qspinlock relies on atomic_*_release()/atomic_*_acquire() to be RCsc (or no
+ * weaker than RCtso if you're power), where regular code only expects atomic_t
+ * to be RCpc.
+ *
+ * qspinlock relies on a far greater (compared to asm-generic/spinlock.h) set
+ * of atomic operations to behave well together, please audit them carefully to
+ * ensure they all have forward progress. Many atomic operations may default to
+ * cmpxchg() loops which will not have good forward progress properties on
+ * LL/SC architectures.
+ *
+ * One notable example is atomic_fetch_or_acquire(), which x86 cannot (cheaply)
+ * do. Carefully read the patches that introduced
+ * queued_fetch_set_pending_acquire().
+ *
+ * qspinlock also heavily relies on mixed size atomic operations, in specific
+ * it requires architectures to have xchg16; something which many LL/SC
+ * architectures need to implement as a 32bit and+or in order to satisfy the
+ * forward progress guarantees mentioned above.
+ *
+ * Further reading on mixed size atomics that might be relevant:
+ *
+ *   http://www.cl.cam.ac.uk/~pes20/popl17/mixed-size.pdf
+ *
  * (C) Copyright 2013-2015 Hewlett-Packard Development Company, L.P.
  * (C) Copyright 2015 Hewlett-Packard Enterprise Development LP
  *
-- 
2.34.1

