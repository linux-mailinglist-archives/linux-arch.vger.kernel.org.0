Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637886D7F19
	for <lists+linux-arch@lfdr.de>; Wed,  5 Apr 2023 16:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238544AbjDEOTL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Apr 2023 10:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238488AbjDEOSd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Apr 2023 10:18:33 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DEE30EB;
        Wed,  5 Apr 2023 07:17:58 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y4so141541211edo.2;
        Wed, 05 Apr 2023 07:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680704274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOC1m1IyvFx7hqlIu85ltj9Okdj8PWnyI3fah+Gac6o=;
        b=dw4QAoMpVGLEOeYQ9Yo6hrg7uuDz1mqcfEuifQdcdnb1mCRfnp4USqcIZ/tj+yoqqd
         NuZo8Fl4HHUAk4my79oi/1gAt96ZaHSFf0NyBNIA2ujrdK0vV+BtAz9cZUh1HP/21L01
         ZfOBKFtABC40OHga/xcc6LZLy5bp81QTL5BA33wmnqyDDroTbAF7IVTNrZhDCZYY5uav
         cpNPwfW8+ndEboG7KmpMryAu2BP5Ht2BhpnVlW+EgEVP3Hv8o6yChfq1iPaWIKJDgzD/
         9Y/9bUrxWUeU4eBT8lu+LsRKzoAiRRbIgYAetGEXNMYLkTxdyCEUikhfLAP1CktMT2oa
         eHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680704274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOC1m1IyvFx7hqlIu85ltj9Okdj8PWnyI3fah+Gac6o=;
        b=fskONODB1V2ldmXITXJT7s4WB7h4edhjrUT+MGQFpF0nH9IS/QkXNe5utcGDXzwRp+
         w/zKKNyUEpVQ5EUupAmjs6CBx0TYYf4YF1ny0RWr42PyP+Tj5JXlKNn1nyh8isg7nlsP
         m2V5fX94uITi8CRYliQ0dOehfPPcV12tejLwIW878oMwViKVd7FignWve93uDqjQGFhC
         4negMbRNtZg8rBYCBHEY8nvgxWFZkY3IHMF2wpdhN8t7p/Pl+AV+YK74hw0/FF233dFB
         97JqOnhHJMp6ifCFLKTBOM4XWJ5+d6l1P3i7B0r0U5gmqDqqos95PmTtXzDB2RCdoGJU
         lyTw==
X-Gm-Message-State: AAQBX9c/6ONW1L39/eVXhms6kiJNrer/BlNP0/rPShlpDjJE6ejYgQbm
        jcF2ePQN5VozB+5gyCrxw8E3ASVtIbnZGhXp
X-Google-Smtp-Source: AKy350bz5YnNlQahgd6VXOTs26Uhu2FUvH9WVqbCQND0Gop8QRbR/cXdIQACyHoPPOUtbLiBje74GQ==
X-Received: by 2002:a17:906:4a8b:b0:944:43e:7983 with SMTP id x11-20020a1709064a8b00b00944043e7983mr3280252eju.67.1680704274221;
        Wed, 05 Apr 2023 07:17:54 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id g6-20020a170906348600b009334219656dsm7381246ejb.56.2023.04.05.07.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 07:17:53 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 4/5] locking/x86: Define arch_try_cmpxchg_local
Date:   Wed,  5 Apr 2023 16:17:09 +0200
Message-Id: <20230405141710.3551-5-ubizjak@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230405141710.3551-1-ubizjak@gmail.com>
References: <20230405141710.3551-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Define target specific arch_try_cmpxchg_local. This
definition overrides the generic arch_try_cmpxchg_local
fallback definition and enables target-specific
implementation of try_cmpxchg_local.

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
index 94fbe6ae7431..540573f515b7 100644
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
 
+#define arch_try_cmpxchg_local(ptr, pold, new)				\
+	__try_cmpxchg_local((ptr), (pold), (new), sizeof(*(ptr)))
+
 /*
  * xadd() adds "inc" to "*ptr" and atomically returns the previous
  * value of "*ptr".
-- 
2.39.2

