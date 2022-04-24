Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202BC50D034
	for <lists+linux-arch@lfdr.de>; Sun, 24 Apr 2022 09:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238471AbiDXHcn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Apr 2022 03:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbiDXHcm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Apr 2022 03:32:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9E315045E;
        Sun, 24 Apr 2022 00:29:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77DABB80E02;
        Sun, 24 Apr 2022 07:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7105AC385AB;
        Sun, 24 Apr 2022 07:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650785380;
        bh=c+1KCRzUnFxjDmuVpnOdcsSp5aV3DJ1p6cblWhjPyzI=;
        h=From:To:Cc:Subject:Date:From;
        b=C8mWVbMbfPg1vnTAhzV49bvJ/p6noHVgVeOAVtFyKgqvZno6m9v+CczlmmUx+Zb7m
         Pm5tLI+edkznWutKUSs67BIoi9Uyi12eP70PpLUhcEQukE+EGpPT23oZ41s+Uq5CeQ
         WzzTsLf063geD2Z1BNs2STQzLpMXuY/X660ZWxHpoJmWjdoGaKyhtF+Rv1MLrKvEHT
         vqReRaIm1BsKlRzLXvtLDy+xhqHx0AGE6daBeZnvS9jn86x5xmOL/wdVgXs3dHuCaR
         5c5KGvsKKC6LardVdEoFBWNnHB8lOLsvlujc7ayXanZveQIXT9OgPazOkTPy58rE0I
         enLaQ4PiMKaYA==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de, mark.rutland@arm.com,
        boqun.feng@gmail.com, peterz@infradead.org, will@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V4 0/3] csky: Optimize atomic_ops & cmpxchg
Date:   Sun, 24 Apr 2022 15:29:15 +0800
Message-Id: <20220424072918.2596899-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Changes in V4:
 - Remove RELEASE_FENCE in ldex/stex loop by Buoqun's advice

Changes in V3:
 - Add arch_atomic_(fetch_add_unless, inc_unless_negative,
   dec_unless_positive, dec_if_positive)

Changes in V2:
 - Fixup use of acquire + release for barrier semantics by Rutland.

Guo Ren (3):
  csky: atomic: Optimize cmpxchg with acquire & release
  csky: atomic: Add custom atomic.h implementation
  csky: atomic: Add conditional atomic operations' optimization

 arch/csky/include/asm/atomic.h  | 237 ++++++++++++++++++++++++++++++++
 arch/csky/include/asm/barrier.h |  11 +-
 arch/csky/include/asm/cmpxchg.h |  64 ++++++++-
 3 files changed, 304 insertions(+), 8 deletions(-)
 create mode 100644 arch/csky/include/asm/atomic.h

-- 
2.25.1

