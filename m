Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B531504715
	for <lists+linux-arch@lfdr.de>; Sun, 17 Apr 2022 10:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbiDQIe4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 17 Apr 2022 04:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbiDQIez (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 17 Apr 2022 04:34:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A27270A;
        Sun, 17 Apr 2022 01:32:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F13A61156;
        Sun, 17 Apr 2022 08:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B82C385A7;
        Sun, 17 Apr 2022 08:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650184339;
        bh=qxn6V9hPC6xWyUrdMF0MqKwXynUnSClaaMiSRy58f4k=;
        h=From:To:Cc:Subject:Date:From;
        b=DgDPQEztAnta1e/OxjJVjBKQ2OhfqdBRA16brTmYHkjUOY9O+ViDCzEeIQqdhDcy3
         Fcmz45ONZ64CmDfiGbCtmVuVxMe2hbGtYzeR7UH1QETvYfCzOkt66UBJHb6puoTi5E
         u48twiVcZnBXzmOJhVlYXdiuhJlucv/kIy/Dbspe3stNVbOPkNTgCU2miLC9Qx6MRZ
         vt9Fody4TaHuKL4N8WODNh+8XsrBtalOtmktYNqSWnJAHDCGL2HG+omhR255WnuOu9
         M0FGKXEDQZ9G45iSMH9BreQF+QnhtBqOWyjBvWuuTagMm7kwcP9a3E5D2Zgrqi7Lhw
         fcVRu1QLLh+gQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de, mark.rutland@arm.com,
        boqun.feng@gmail.com, peterz@infradead.org, will@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V3 0/3] csky: Optimize with acquire & release for atomic & cmpxchg
Date:   Sun, 17 Apr 2022 16:32:01 +0800
Message-Id: <20220417083204.2048364-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Optimize arch_xchg|cmpxchg|cmpxchg_local with ASM acquire|release
instructions instead of previous C based.

The generic atomic.h used cmpxchg to implement the atomic
operations, it will cause daul loop to reduce the forward
guarantee. The patch implement csky custom atomic operations with
ldex/stex instructions for the best performance.

Important reference commit:
8e86f0b409a4 ("arm64: atomics: fix use of acquire + release for
full barrier semantics")

Changes in V3:
 - Add arch_atomic_(fetch_add_unless, inc_unless_negative,
   dec_unless_positive, dec_if_positive)

Changes in V2:
 - Fixup use of acquire + release for barrier semantics by Rutland.

Guo Ren (3):
  csky: cmpxchg: Optimize with acquire & release
  csky: atomic: Add custom atomic.h implementation
  csky: atomic: Add conditional atomic operations' optimization

 arch/csky/include/asm/atomic.h  | 249 ++++++++++++++++++++++++++++++++
 arch/csky/include/asm/barrier.h |  11 +-
 arch/csky/include/asm/cmpxchg.h |  64 +++++++-
 3 files changed, 316 insertions(+), 8 deletions(-)
 create mode 100644 arch/csky/include/asm/atomic.h

-- 
2.25.1

