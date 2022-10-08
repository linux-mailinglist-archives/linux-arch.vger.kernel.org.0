Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5155F865B
	for <lists+linux-arch@lfdr.de>; Sat,  8 Oct 2022 19:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiJHRuA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Oct 2022 13:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiJHRty (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Oct 2022 13:49:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84EA17076;
        Sat,  8 Oct 2022 10:49:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4102160A56;
        Sat,  8 Oct 2022 17:49:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7558CC433C1;
        Sat,  8 Oct 2022 17:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665251391;
        bh=N5Mp1LMvYGmWidyUVou9/bUp0B2acFPwWxHvVp2oik0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hhFdUCtx3n3tzgvPWAIsaehNUYXR8qd3G0dkmmRF/AxDuR9QpJVhhh6kDoCN9ierb
         UfNGqMXhXlf9qHfANcLeUmZrM9g6MT8puDHAgCelgk0+jSSGSH+L1ZYvRMnD4PtxYs
         Aus6UlZv6apNS9X65rwIg5ysLA8M8iFLq3CCFNDnxUPJ7LbbB/qdgmF5mGkD17ny9S
         NSiIdBCCulKQ78UZrfMHW0Q8IvWSgpiLESTll9aJFXR3APCTEDudEefNpm5h6feD5V
         u135Rbp9JZsZ3vDds3RVnIQz5kknPejG7GUJ25rlyTX1XjDuSXKLXdbg8q0DpVNMfF
         CLeKBt/vO47CQ==
From:   SeongJae Park <sj@kernel.org>
To:     paulmck@kernel.org, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 1/4] docs/memory-barriers.txt: Add a missed closing parenthesis
Date:   Sat,  8 Oct 2022 10:49:25 -0700
Message-Id: <20221008174928.13479-2-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221008174928.13479-1-sj@kernel.org>
References: <20221008174928.13479-1-sj@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Description of io_stop_wc(), which added by commit d5624bb29f49
("asm-generic: introduce io_stop_wc() and add implementation for
ARM64"), have unclosed parenthesis.  This commit closes it.

Fixes: d5624bb29f49 ("asm-generic: introduce io_stop_wc() and add implementation for ARM64")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/memory-barriers.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 06f80e3785c5..cc621decd943 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1966,7 +1966,7 @@ There are some more advanced barrier functions:
  (*) io_stop_wc();
 
      For memory accesses with write-combining attributes (e.g. those returned
-     by ioremap_wc(), the CPU may wait for prior accesses to be merged with
+     by ioremap_wc()), the CPU may wait for prior accesses to be merged with
      subsequent ones. io_stop_wc() can be used to prevent the merging of
      write-combining memory accesses before this macro with those after it when
      such wait has performance implications.
-- 
2.17.1

