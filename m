Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4337118A2
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 23:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241058AbjEYVBF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 May 2023 17:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjEYVBC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2023 17:01:02 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D9F1B0;
        Thu, 25 May 2023 14:00:59 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-53f448cde66so224a12.1;
        Thu, 25 May 2023 14:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685048459; x=1687640459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plByf+i5Fok3NQ/XAuXTsKM1rTLN/fzcmyU+yIiV4ic=;
        b=ky1DBxa8WM/81sXdcWNsMFPfMbMP9MSiSdnrHilDQ/bSg2mSQmbDjXxAj/wajJaFUp
         2gHwA6b91A/ZdrHsNZAZV/2bMQXTNbmu9qNkC/KU0o1CB4hFllmUSgChAccRy4BFisHs
         hhRd6ZfPQ5bTE1jlxQYbLXLkgZLIfV6YYgsMjhvW2xuU5vMy2ZmzUrBc+/kZRMeVcMKg
         ff9XqIFg5W3W3DzqWq0SHrWXHHv2SgUDWGPxuba7+I5YkxQLmn1ay4zak4VMFOxDzlFF
         5hQWwXHIqlw1J2bO7BYDEhq6PJu3rAiTxW0yUtTf9WOJj4FDfs0Aywdwxa4b9BY73ZPN
         esRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685048459; x=1687640459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plByf+i5Fok3NQ/XAuXTsKM1rTLN/fzcmyU+yIiV4ic=;
        b=WMI2MKRo6aQegeV7QGyseWvYbH72NEEEvIjkHllQI1sOc2lsGzrZ5/esqKtD3mrS6j
         2QSW0fkXrWhjwv1eEEPPIJpnfQsOKS2bU3xvk3jCKTuZpreA+6tm/fyTlJG6ia2vzuC3
         PY99HicvJd+rtuSHo0c1GVUDgzJfhh3TEptrU7g1oPPAniO9TGosHiaZTlun6QrdGrM0
         x6JNoVWlAisSgmjKNzz5xaPHzlIbILDocWinXkf5u7rfgRPwCws381FjUl9wKYKciB+3
         1en1FpYZciPgbLLkREfHwVdvfSrcuNTDx2nXb2VcEHEagtk3trN9HifqOVP4hsgjoKO3
         jW+g==
X-Gm-Message-State: AC+VfDybzzIfzv80vN+i5u+YK9kgc9sGH6uIQZ1RahZ9w/Dn2Ifa8HJf
        aO8cVc6OE4757UfMR3X82Dc=
X-Google-Smtp-Source: ACHHUZ7UrhDd6a4VRrtTE4n7Efva9/49QNhzVnRsKhhDcKekFkWhLzvnIW2XMR2EkOUzCI4bsE9+IA==
X-Received: by 2002:a17:903:32c3:b0:1af:9b8a:9c79 with SMTP id i3-20020a17090332c300b001af9b8a9c79mr3676440plr.34.1685048459053;
        Thu, 25 May 2023 14:00:59 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j21-20020a170902c3d500b001ae8587d60csm1807673plj.265.2023.05.25.14.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 14:00:58 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Thomas Gleixner" <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-um@lists.infradead.org,
        Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org,
        "Andy Lutomirski" <luto@kernel.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Borislav Petkov" <bp@alien8.de>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH v2 2/3] compiler: inline does not imply notrace
Date:   Thu, 25 May 2023 14:00:39 -0700
Message-Id: <20230525210040.3637-3-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230525210040.3637-1-namit@vmware.com>
References: <20230525210040.3637-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Functions that are marked as "inline" are currently also not tracable.
This limits tracing functionality for many functions for no reason.
Apparently, this has been done for two reasons.

First, as described in commit 5963e317b1e9d2a ("ftrace/x86: Do not
change stacks in DEBUG when calling lockdep"), it was intended to
prevent some functions that cannot be traced from being traced as these
functions were marked as inline (among others).

Yet, this change has been done a decade ago, and according to Steven
Rostedt, ftrace should have improved and hopefully resolved nested
tracing issues by now. Arguably, if functions that should be traced -
for instance since they are used during tracing - still exist, they
should be marked as notrace explicitly.

The second reason, which Steven raised, is that attaching "notrace" to
"inline" prevented tracing differences between different configs, which
caused various problem. This consideration is not very strong, and tying
"inline" and "notrace" does not seem very beneficial. The "inline"
keyword is just a hint, and many functions are currently not tracable
due to this reason.

Disconnect "inline" from "notrace".

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 include/linux/compiler_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 547ea1ff806e..bab3e25bbe3f 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -184,7 +184,7 @@ struct ftrace_likely_data {
  * of extern inline functions at link time.
  * A lot of inline functions can cause havoc with function tracing.
  */
-#define inline inline __gnu_inline __inline_maybe_unused notrace
+#define inline inline __gnu_inline __inline_maybe_unused
 
 /*
  * gcc provides both __inline__ and __inline as alternate spellings of
-- 
2.25.1

