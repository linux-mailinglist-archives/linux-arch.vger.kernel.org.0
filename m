Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0862572DE27
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 11:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241705AbjFMJrM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 05:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239987AbjFMJq6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 05:46:58 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAA210EC;
        Tue, 13 Jun 2023 02:46:38 -0700 (PDT)
Received: from tp8.. (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4BC2B7F9;
        Tue, 13 Jun 2023 09:46:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4BC2B7F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1686649595; bh=Qo56z2IvRa1HAZxuU6eMDg1Xfv7BI9bYCGhGj0/XqOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HrFfniOxN0lBlCMP4QkQ10hFTpkRtQrGkV8gySbd60OM/ZLQpGreJPgNE9dc0Vn5K
         vGAG1hPmQF041iw8dCOJ6KJwV/siHs2e/A4rcuF15GeyzckbCrQWkEmlvwcMnI9K6+
         S1he/jR97oGDDA8l/IHFf8lq4bNN3XllIhXnsLADD/shOc66q+N+roOBYfl/6UoHN0
         b59h6QSkN4E3xIkeAex1eFbiQ+S5DWKXL8vmylD8HomUBfk3JzEKpllXFp1NuDl0y9
         DMxPmg9J4Nge1TmjIZKb6CM+jFiFgnwUT1JIKbq60+OC4HtGWIaXPQvU7aiL/TPu4G
         PbRtXJYZb5rPg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [PATCH 4/5] mm: Fix a dangling Documentation/arm64 reference
Date:   Tue, 13 Jun 2023 03:46:05 -0600
Message-Id: <20230613094606.334687-5-corbet@lwn.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613094606.334687-1-corbet@lwn.net>
References: <20230613094606.334687-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The arm64 documentation has moved under Documentation/arch/.  Fix up a
reference in mm/mremap.c to match.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 mm/mremap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index b11ce6c92099..3185724d8b13 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -914,7 +914,8 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	 * mapping address intact. A non-zero tag will cause the subsequent
 	 * range checks to reject the address as invalid.
 	 *
-	 * See Documentation/arm64/tagged-address-abi.rst for more information.
+	 * See Documentation/arch/arm64/tagged-address-abi.rst for more
+	 * information.
 	 */
 	addr = untagged_addr(addr);
 
-- 
2.40.1

