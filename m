Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764586344F5
	for <lists+linux-arch@lfdr.de>; Tue, 22 Nov 2022 20:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbiKVTyu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Nov 2022 14:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbiKVTyX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Nov 2022 14:54:23 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCECA3422;
        Tue, 22 Nov 2022 11:54:22 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso14707506pjt.0;
        Tue, 22 Nov 2022 11:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GY0uNCRJFDIBd1b/0xpSh6r2iyqgkDnm0VnIWHblR1Y=;
        b=bKvIp/q01sksIgeTfgdSxVX+C8Z+5Q5VPnMnDw6OkhkC00cIjOlJc/ZKdvrNIZSuH4
         zMlcdUwGyDqTO6G1LZzPLT9BnwQR8xtwtay3S85AFcj3Ih7Zwm8JuOrJofoPHiGDVUZn
         lfRF+Ji3Kjjbe3ne+2nHL5KjZXaDbKqLtDX/gW1qDNG8WoTknVg2lZWK+8qZ3lb6ZvRb
         i8AKbdnE/wzihMT1RF1KcEEAIrVCAAfZ1oSiTvtqo2qeTOLx5bwTTTeOA1fUj87O8jXW
         B2T84l9rtNUraM2bgG5WNhOSSFktEVM2kiDnXa+8QBdCYNhK88WuMRca5+ysknNexuhF
         c7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GY0uNCRJFDIBd1b/0xpSh6r2iyqgkDnm0VnIWHblR1Y=;
        b=FGTfT+8tHodQKSWKsGTlvcL4WSuOEPVWN0MAuvwUshEBy2bI9NpJe+V50Y9MlIvsQu
         9GQZVztxjFkLRteVrGRFi+KU263rRAt8GSRNS/kluccMBrUSd2nhepG5krNP+fTEBMXU
         dnzy8EpzuPAWuXqsMl27M19Pgmh0exdogQrWPXCCP+I8lMaY56pQMAzBnBt38Fr8+dhD
         iygch5rkf9zTrhpnJWbCpUIn8mIaOA2N2ihdJ1ysfRhaV0eTaOa9M6UJybOTb8ihykMp
         R58KRsaa4OCaw5GkSlKGMB66JqYUt4zfzlGN3sDqqDZRxNFqWAesTRP/mQCfaqPQDanc
         heqQ==
X-Gm-Message-State: ANoB5pmS3bx/6cLTWPbI0UOr/113qkac1sO8IaSNlMzTdgwfO1t8ihNK
        m2tMJTG4LKeixNLXF9+VRNc=
X-Google-Smtp-Source: AA0mqf5p/PgTkltwXUye0t/4vf1adJ89oZPxVRu7EA+GnjEPooxlfASEFNsR9HqYlDrW0Xze6NqM7g==
X-Received: by 2002:a17:902:d2c7:b0:189:d3b:61fe with SMTP id n7-20020a170902d2c700b001890d3b61femr5484441plc.168.1669146861753;
        Tue, 22 Nov 2022 11:54:21 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id a8-20020a63d408000000b00460fbe0d75esm9699252pgh.31.2022.11.22.11.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 11:54:21 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH 3/3] compiler: inline does not imply notrace
Date:   Tue, 22 Nov 2022 11:53:29 -0800
Message-Id: <20221122195329.252654-4-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221122195329.252654-1-namit@vmware.com>
References: <20221122195329.252654-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Functions that are marked as "inline" are currently also not tracable.
Apparently, this has been done to prevent differences between different
configs that caused different functions to be tracable on different
platforms.

Anyhow, this consideration is not very strong, and tying "inline" and
"notrace" does not seem very beneficial. The "inline" keyword is just a
hint, and many functions are currently not tracable due to this reason.

Disconnect "inline" from "notrace".

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 include/linux/compiler_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index eb0466236661..36a99ef03a1a 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -158,7 +158,7 @@ struct ftrace_likely_data {
  * of extern inline functions at link time.
  * A lot of inline functions can cause havoc with function tracing.
  */
-#define inline inline __gnu_inline __inline_maybe_unused notrace
+#define inline inline __gnu_inline __inline_maybe_unused
 
 /*
  * gcc provides both __inline__ and __inline as alternate spellings of
-- 
2.25.1

