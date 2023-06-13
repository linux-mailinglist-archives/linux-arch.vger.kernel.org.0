Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB08C72DE33
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 11:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241943AbjFMJrf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 05:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241594AbjFMJrD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 05:47:03 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B62819A4;
        Tue, 13 Jun 2023 02:46:48 -0700 (PDT)
Received: from tp8.. (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3B1FA7DE;
        Tue, 13 Jun 2023 09:46:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3B1FA7DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1686649600; bh=Ws0sgPK8ew7x5vxl+TuTJyXb8SBuL/KQ6lfSG/O9Xu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rFS60iFolb45Rs8MlzAbX9/IuNIHcSz+Kh3iCrSfaqXJXiHRzsDJjwhJAGdCK2fp/
         4tRCQQsJsJtnxTcol2K+zkySYho9KntiXdqkYfR2ZPVebcQTRVgCPP7MFKZN52p9cf
         0V9j0i2vmxH4u1OXTtuVk7c4taBYVMw15HJQA6XKCuJdmFOYyuOF/IIypZV6c5iHwY
         CofdjXO1zlP230wQ5GZyHzIpVxjd32GM0Z2FSsz9+ORhaG7EsQG2UtCS9nUlHs62u6
         KQs18KP840i93BAh1rlsDQL+7TmC6X3irvglULosWSeq8IQL+jWx17ZI9nJhoGcUld
         AJbXeYPk1aKpA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH 5/5] perf arm-spe: Fix a dangling Documentation/arm64 reference
Date:   Tue, 13 Jun 2023 03:46:06 -0600
Message-Id: <20230613094606.334687-6-corbet@lwn.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613094606.334687-1-corbet@lwn.net>
References: <20230613094606.334687-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The arm64 documentation has moved under Documentation/arch/.  Fix up a
dangling reference to match.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index f3918f290df5..ba807071d3c1 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -51,7 +51,7 @@ static u64 arm_spe_calc_ip(int index, u64 payload)
 		 * (bits [63:56]) is assigned as top-byte tag; so we only can
 		 * retrieve address value from bits [55:0].
 		 *
-		 * According to Documentation/arm64/memory.rst, if detects the
+		 * According to Documentation/arch/arm64/memory.rst, if detects the
 		 * specific pattern in bits [55:52] of payload which falls in
 		 * the kernel space, should fixup the top byte and this allows
 		 * perf tool to parse DSO symbol for data address correctly.
-- 
2.40.1

