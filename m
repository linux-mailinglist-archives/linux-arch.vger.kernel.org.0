Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF70651A49
	for <lists+linux-arch@lfdr.de>; Tue, 20 Dec 2022 06:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiLTFmB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Dec 2022 00:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLTFl7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Dec 2022 00:41:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F7C95BC;
        Mon, 19 Dec 2022 21:41:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8724AB80B4A;
        Tue, 20 Dec 2022 05:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03933C433D2;
        Tue, 20 Dec 2022 05:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671514916;
        bh=aobfGfEvD4AGl4vRZJIYk0SEFsUj+YmTUfc3k7PaaFE=;
        h=From:To:Cc:Subject:Date:From;
        b=dyv9hCR8Y5cKQ80uJ7AOscEh/kDAsDsF/psMVIGEwc0LkdOg5NUaH5C0HkfiCuFW8
         APy2e/R0Sv2c/yUAuAtJCbtRZ2YpFw+9nNcCAAIhNvWkiCmFo9Ni48HLJ8f6owdZz9
         bvaGPQwFQJy8ILpQHBlW733ozfua0bPZIqY1z8QoB67C+m86a2FImqFuVLu8uNHKmM
         zdPiDDH9x/QnQYik3ctlDWzw+wmZQEc1cHg9bs3J66Nb5NHUxPLb/IsfXd98KFi1Ou
         7LJMOzENRw1+SpzJX8XSSYpYhuu4B2HkJHZUDT6gZsEnrpvnLuzKE9H0GScTlzcIAS
         1DDhFajrzTg3w==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net,
        will@kernel.org, boqun.feng@gmail.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, Herbert Xu <herbert@gondor.apana.org.au>,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org
Subject: [PATCH 0/3] crypto: x86/ghash cleanups
Date:   Mon, 19 Dec 2022 21:40:39 -0800
Message-Id: <20221220054042.188537-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
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

These patches are a replacement for Peter Zijlstra's patch
"[RFC][PATCH 02/12] crypto/ghash-clmulni: Use (struct) be128"
(https://lore.kernel.org/r/20221219154118.955831880@infradead.org).

Eric Biggers (3):
  crypto: x86/ghash - fix unaligned access in ghash_setkey()
  crypto: x86/ghash - use le128 instead of u128
  crypto: x86/ghash - add comment and fix broken link

 arch/x86/crypto/ghash-clmulni-intel_asm.S  |  6 +--
 arch/x86/crypto/ghash-clmulni-intel_glue.c | 45 +++++++++++++++-------
 2 files changed, 35 insertions(+), 16 deletions(-)


base-commit: 6feb57c2fd7c787aecf2846a535248899e7b70fa
-- 
2.39.0

