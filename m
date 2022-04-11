Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D914FBF94
	for <lists+linux-arch@lfdr.de>; Mon, 11 Apr 2022 16:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243701AbiDKOyT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Apr 2022 10:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241348AbiDKOyT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Apr 2022 10:54:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4905E1B9;
        Mon, 11 Apr 2022 07:52:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3261B81647;
        Mon, 11 Apr 2022 14:52:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CABC385A9;
        Mon, 11 Apr 2022 14:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649688722;
        bh=9PlZ+Nvnf9pX/GAkoaPUAxYmAa9bWiviBOne6kisTGY=;
        h=From:To:Cc:Subject:Date:From;
        b=DnZHOxmidU9neSWd4X7QEuMwWksP0TzWset4i/HgYyXKgpEmbfAVqKf2gvocnowZl
         gwVbEgpMdT6taWEdNnhHnqPJw9Y1WyzVW05fXY7C9d19lIAvnPXA9QbmUyNXM7zu7a
         84+H0Nxa46OXiUd+RWj8+/M8Sg9MJijocAtVNdLgjBW3LYf8k9S+w497R/BRv1cyyy
         cuLVLm3uLw2Bsl9o+5xL0neM5KzG1nQsYCXverZYA7mNxwRsJlx9N4ZKQgrBejJVZm
         p9GsCBIKP0S3Drl0XWvIZ0UiGMzPrNLl8TddaMEszaYtNN8RV3uCshSGcA93pzGeaK
         lsCaq9bEq5wdQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de, mark.rutland@arm.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 0/2] csky: Optimize with acquire & release for atomic & cmpxchg
Date:   Mon, 11 Apr 2022 22:51:44 +0800
Message-Id: <20220411145146.920314-1-guoren@kernel.org>
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

Important reference comment by Rutland:
8e86f0b409a4 ("arm64: atomics: fix use of acquire + release for
full barrier semantics")

Changes in V2:
 - Fixup use of acquire + release for barrier semantics by Rutland.

Guo Ren (2):
  csky: cmpxchg: Optimize with acquire & release
  csky: atomic: Add custom atomic.h implementation

 arch/csky/include/asm/atomic.h  | 130 ++++++++++++++++++++++++++++++++
 arch/csky/include/asm/barrier.h |   8 +-
 arch/csky/include/asm/cmpxchg.h |  61 +++++++++++++--
 3 files changed, 190 insertions(+), 9 deletions(-)
 create mode 100644 arch/csky/include/asm/atomic.h

-- 
2.25.1

