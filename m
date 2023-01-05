Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEAD65E245
	for <lists+linux-arch@lfdr.de>; Thu,  5 Jan 2023 02:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjAEBKM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Jan 2023 20:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjAEBJ6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Jan 2023 20:09:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE0D3056B;
        Wed,  4 Jan 2023 17:09:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5E2FB8167B;
        Thu,  5 Jan 2023 01:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E43C433D2;
        Thu,  5 Jan 2023 01:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672880994;
        bh=3rJgk+HG3HzNQPwHWGNkSihqjzUP/qOuNtY986a0YCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U9fno5jye6FHCf9BozocTVBaOLVQo/x18qjtP3hvOHxWo0EC6ocdc9yS/n5st0t02
         //8sZKTyq/IP3xb+IhEtbVLY/U0YrA450JAU+5/03lexxSYPvFP/FUQHvlBKWLitKR
         3hpVjkhhOHex3YyP77t088rJ0mQARUhbSwfNHXYM6Bx1j4bE8NraWMMMbQf4xqBnvg
         P+5w5K7cbVmGhafHR+96gPYE+lDxcXQcLiMNQAntmZvYoJMoK42k2KZEMNdWN37hUl
         iPxFPPfX4ngmRWTEVkuwH/IvQIRz+h1Y8FrU8Zvi5Tt8nopEyP5u4qFWCk+pJAVi2f
         W+FEOTJAuAxbg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 685395C08E5; Wed,  4 Jan 2023 17:09:54 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, Kushagra Verma <kushagra765@outlook.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 3/4] Documentation: Fixed a typo in atomic_t.txt
Date:   Wed,  4 Jan 2023 17:09:51 -0800
Message-Id: <20230105010952.1774272-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105010944.GA1774169@paulmck-ThinkPad-P17-Gen-1>
References: <20230105010944.GA1774169@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Kushagra Verma <kushagra765@outlook.com>

Fixed a typo in the word 'architecture'.

Signed-off-by: Kushagra Verma <kushagra765@outlook.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/atomic_t.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
index 0f1ffa03db09a..d7adc6d543db4 100644
--- a/Documentation/atomic_t.txt
+++ b/Documentation/atomic_t.txt
@@ -324,7 +324,7 @@ atomic operations.
 
 Specifically 'simple' cmpxchg() loops are expected to not starve one another
 indefinitely. However, this is not evident on LL/SC architectures, because
-while an LL/SC architecure 'can/should/must' provide forward progress
+while an LL/SC architecture 'can/should/must' provide forward progress
 guarantees between competing LL/SC sections, such a guarantee does not
 transfer to cmpxchg() implemented using LL/SC. Consider:
 
-- 
2.31.1.189.g2e36527f23

