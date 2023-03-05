Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F3D6AB24F
	for <lists+linux-arch@lfdr.de>; Sun,  5 Mar 2023 21:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCEU54 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Mar 2023 15:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCEU52 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Mar 2023 15:57:28 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B80D1ADC4;
        Sun,  5 Mar 2023 12:57:09 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id ay14so27095169edb.11;
        Sun, 05 Mar 2023 12:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678049827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Rhi81UV6n4gJ23KpYxVv3UnO+FDfYmlmuIH3bT2sEE=;
        b=aaSodGvZdSV4IP+c2rumCkx8LxrQY+OBcusU42ckg9I4HKl7svI97bHUL8PVa79jUn
         xPkYv74szn3W9Ezoiv7g17E92uqKZF9Q6lBk+rGSEagwXuvpV3i07e8Pkz9ghdOWM4i1
         iAl7K94WX200NR6mzgorkcWMi2oDE5W7MB8oFzbbHYstFEsoUP9VT8+2rb1+kLDxgFBE
         ZcscWfl9eYRBg4Ct/7ikk8jQHl/U1WRWKyYDrbRBQqttA6QIp2sq8CY+PM01/wuGFC2y
         y6zmednb1IPxVz9Qo9+FsPJS256xZdDaz0IlmMKsI4jFxJQKu6pKz93CrGfjPPmVLESV
         KAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678049827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Rhi81UV6n4gJ23KpYxVv3UnO+FDfYmlmuIH3bT2sEE=;
        b=3P4QvqNAOohXYUexSieKsg2EcmBBTrUQrVrI/5G39VMvWPcEJP01BweJXo7kVSSe3h
         jbh+oqMAl69VhcjS5ZwmIM01lvFadwrDk2GnOwoTdy/FQjXBQNfpPeXGKvpazfLUkNeX
         z2a2/Cj4MSaFFwLjYwHkkdfzkJiGfKDicJrmsIJ/YXx1wxqbMOswIdgyC9aXT8AoODfv
         HsQV6iMfPQLYsAuTBap9uNQORXJM0IYECMbrsCvY6JkviBY8jV00Nd64zQJeStQ68lm+
         pzJiBQVGa8sXVECGfsc3jt5Dy9xC6a/pO9ixIQ50En1wyWhp4ZGLIWz0dteYmjyfRFx0
         M3Qg==
X-Gm-Message-State: AO0yUKWf81NDMCS75ekX5w6GNDy5AqVnsKwK7OAEcOdk3rX5tPo0KOcR
        KZJiFOXZ8t04ypBrYaSePg6PEbxcM0ziev0x
X-Google-Smtp-Source: AK7set9KsKppg5AWKoMtA+hKEWxwqg26/PPfzfADGxEx0JJl9+WRzjaOFmjzce84cTTXvCp3CMtMKA==
X-Received: by 2002:a17:906:408f:b0:8b1:7968:7fb8 with SMTP id u15-20020a170906408f00b008b179687fb8mr9606766ejj.62.1678049827406;
        Sun, 05 Mar 2023 12:57:07 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ay24-20020a170906d29800b0090953b9da51sm3615436ejb.194.2023.03.05.12.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 12:57:07 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 09/10] locking/x86: Enable local{,64}_try_cmpxchg
Date:   Sun,  5 Mar 2023 21:56:27 +0100
Message-Id: <20230305205628.27385-10-ubizjak@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230305205628.27385-1-ubizjak@gmail.com>
References: <20230305205628.27385-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Enable local_try_cmpxchg and also local64_try_cmpxchg for x86_64.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/include/asm/cmpxchg.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
index 94fbe6ae7431..e8f939e8432e 100644
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -221,9 +221,15 @@ extern void __add_wrong_size(void)
 #define __try_cmpxchg(ptr, pold, new, size)				\
 	__raw_try_cmpxchg((ptr), (pold), (new), (size), LOCK_PREFIX)
 
+#define __try_cmpxchg_local(ptr, pold, new, size)			\
+	__raw_try_cmpxchg((ptr), (pold), (new), (size), "")
+
 #define arch_try_cmpxchg(ptr, pold, new) 				\
 	__try_cmpxchg((ptr), (pold), (new), sizeof(*(ptr)))
 
+#define arch_try_cmpxchg_local(ptr, pold, new) 				\
+	__try_cmpxchg_local((ptr), (pold), (new), sizeof(*(ptr)))
+
 /*
  * xadd() adds "inc" to "*ptr" and atomically returns the previous
  * value of "*ptr".
-- 
2.39.2

