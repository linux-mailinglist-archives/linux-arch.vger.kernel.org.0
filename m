Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA82B22C623
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 15:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgGXNPP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jul 2020 09:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgGXNPN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2020 09:15:13 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68507C0619D3;
        Fri, 24 Jul 2020 06:15:13 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a23so5065530pfk.13;
        Fri, 24 Jul 2020 06:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DHpBnVvFWixE9Yg0d0OK10tzA3221PSUyt4Cx2IH5+E=;
        b=myWsbPv3/UUglRzV+TMSS2ZZiFNk38LMgSBpDNrQsTIDc5WH7gUklbGO1enhGGySAz
         E7YzZBxilSJCpvzkCjCU/0CNuVBNZLByMjo8KxMsr1RuI7lIPVyR0vvJxZNF+vEP0Mzk
         Sn2h0sLrOt+aOi0ATgnWf89dVNz1bvDrQqo3cj6OoyWX8xCVLnNfJaAqKtDhCjUwNgA0
         5Y/+beDc9ULzpOBEBVXgkQuIV6fUalwLPPpQY5i02r9TLUCpOAqwCxnak+DcBatC0Jyv
         PKBIC5be55ZRIMw4PLKztz9Klrbzm6QA2rbct7J2sE+V6G3FLRbUvMgFLeL3276GLo0m
         WAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DHpBnVvFWixE9Yg0d0OK10tzA3221PSUyt4Cx2IH5+E=;
        b=jVXkEbwRDRfdesW1bwxsE3Jqg53CwuOd2/pdiVzsRQSwyIUXte2PjBxM32n8U2K4Fr
         mCTCk8QVcYK8L1iATGulUcxs5HLlkJwEp8RQRgXA7zWLsTqEJMDPDA+OLaLjMwGobT+O
         TrD5YbrCa3azWqeTinyw7xLpeR0MAKfwonaSe+23nPsUYCyqYSkLOpcYFK4dz+ZmQEUh
         sIMPzQ2BEFjYI6tyGr85sjOg+MKoJDxF69OII1Z7oNELE2XqxylzZArKDrHVcxW4zjD8
         Pdq4+1SgsB6QV1/ji944H2lh7y3r+pA1mPJCb+ZQQIbp3+wl211FVlQxK88+xWLtDPtF
         aMQA==
X-Gm-Message-State: AOAM533kDo+c+0R+U3yMyjEYN/e6Glgu9ObXL4GBf2P72Dsj40JCTkM8
        c1cv1/bYrs4c+6+/cud0Uzk=
X-Google-Smtp-Source: ABdhPJyisx6hCRDrbmPNpGytS1qqjnTFZwITCd6wO1vkmRzyL31lFJNP7UVIeTdb2pnJAPV4vPWvTg==
X-Received: by 2002:aa7:942e:: with SMTP id y14mr8909386pfo.58.1595596512969;
        Fri, 24 Jul 2020 06:15:12 -0700 (PDT)
Received: from bobo.ibm.com (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id az16sm5871998pjb.7.2020.07.24.06.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 06:15:12 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v4 6/6] powerpc: implement smp_cond_load_relaxed
Date:   Fri, 24 Jul 2020 23:14:23 +1000
Message-Id: <20200724131423.1362108-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200724131423.1362108-1-npiggin@gmail.com>
References: <20200724131423.1362108-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This implements smp_cond_load_relaed with the slowpath busy loop using the
preferred SMT priority pattern.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/barrier.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index 123adcefd40f..9b4671d38674 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -76,6 +76,20 @@ do {									\
 	___p1;								\
 })
 
+#define smp_cond_load_relaxed(ptr, cond_expr) ({		\
+	typeof(ptr) __PTR = (ptr);				\
+	__unqual_scalar_typeof(*ptr) VAL;			\
+	VAL = READ_ONCE(*__PTR);				\
+	if (unlikely(!(cond_expr))) {				\
+		spin_begin();					\
+		do {						\
+			VAL = READ_ONCE(*__PTR);		\
+		} while (!(cond_expr));				\
+		spin_end();					\
+	}							\
+	(typeof(*ptr))VAL;					\
+})
+
 #ifdef CONFIG_PPC_BOOK3S_64
 #define NOSPEC_BARRIER_SLOT   nop
 #elif defined(CONFIG_PPC_FSL_BOOK3E)
-- 
2.23.0

