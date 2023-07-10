Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8057374DFA8
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jul 2023 22:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjGJUpZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 16:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjGJUpA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 16:45:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5A31BF;
        Mon, 10 Jul 2023 13:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=A7RcetqmNW3btMImHl/BZfdcqRl9coUa9L9XZZv1508=; b=WgSSkXyo6wHIO77DHamsAtL5yS
        QPw+3CNlMjYUWUL/cmn1npceGfaf+29pfTh1AWihDxltm3qKIFPVy5zVYjvclsnFpXKYetM/YBD+t
        pDQiNiNl9LpEoGB8KmBRwWmkDxMJDuHj5GlmENIK0nNp8MTh/wrwhCI2z1kpRHwF5n0P8/2o0TOIw
        lnX0H/DLnXPWpzmVouo1J7c0g3n5+cegiGdOuSGV97zLi9NShKpz20OELw2TBUrUBocDgTJYn7oY0
        d4t9+1dGZsxpyK/6oTDLRRXJ10U4eXy3U5L8PQIq7FLntXSPG6i3HPw2LOBx3gqBtNDv1YMvvQTgb
        wQnxk6dA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qIxjR-00EuoE-3L; Mon, 10 Jul 2023 20:43:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/38] minmax: Add in_range() macro
Date:   Mon, 10 Jul 2023 21:43:02 +0100
Message-Id: <20230710204339.3554919-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230710204339.3554919-1-willy@infradead.org>
References: <20230710204339.3554919-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Determine if a value lies within a range more efficiently (subtraction +
comparison vs two comparisons and an AND).  It also has useful (under
some circumstances) behaviour if the range exceeds the maximum value of
the type.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/minmax.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 396df1121bff..028069a1f7ef 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -158,6 +158,32 @@
  */
 #define clamp_val(val, lo, hi) clamp_t(typeof(val), val, lo, hi)
 
+static inline bool in_range64(u64 val, u64 start, u64 len)
+{
+	return (val - start) < len;
+}
+
+static inline bool in_range32(u32 val, u32 start, u32 len)
+{
+	return (val - start) < len;
+}
+
+/**
+ * in_range - Determine if a value lies within a range.
+ * @val: Value to test.
+ * @start: First value in range.
+ * @len: Number of values in range.
+ *
+ * This is more efficient than "if (start <= val && val < (start + len))".
+ * It also gives a different answer if @start + @len overflows the size of
+ * the type by a sufficient amount to encompass @val.  Decide for yourself
+ * which behaviour you want, or prove that start + len never overflow.
+ * Do not blindly replace one form with the other.
+ */
+#define in_range(val, start, len)					\
+	sizeof(start) <= sizeof(u32) ? in_range32(val, start, len) :	\
+		in_range64(val, start, len)
+
 /**
  * swap - swap values of @a and @b
  * @a: first value
-- 
2.39.2

