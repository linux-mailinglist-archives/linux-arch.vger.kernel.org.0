Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AF9791C18
	for <lists+linux-arch@lfdr.de>; Mon,  4 Sep 2023 19:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347632AbjIDRon (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Sep 2023 13:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjIDRol (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Sep 2023 13:44:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56AAAF;
        Mon,  4 Sep 2023 10:44:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39FF760FFB;
        Mon,  4 Sep 2023 17:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF822C433C7;
        Mon,  4 Sep 2023 17:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693849475;
        bh=YvrmulUiFFn/NobkUjd6sOl1dt0QMsFH5NPz/lhd9Ak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DUaW/2wfixpVSCoxOkzamyqusPm1ayWPvKAYivsybGuMUieEjwCwHuqEdL4Fpo6wb
         eRjw2NElkfQ7PdK+XJE4HU08dbDA4KF6yUkGnvgWB7/mA0Ity95eh6TzeR6ue8oJw1
         OIlqHYVBg8XuTINrjEMJCZ4SdNmfbM2l7mrx7Q0jFDmTsI0Rf0JcO1GyvwESkcNy4C
         Z/Z9QBNFBIH+cY2eorlfSTYf8IzBOB7DXKlGoVoVZ394DHjQK7eZVJq1uMjp2UV6GR
         kWTGzghngoM1U9neksj/nvyCwv3fIuzqR03RrQDsEKyDLhMMfKp4k1h6gWzWEw4taO
         scTpMEFunrAkA==
Date:   Mon, 4 Sep 2023 20:43:50 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: Re: [PATCH v6 26/38] sparc64: Implement the new page table range API
Message-ID: <20230904174350.GF3223@kernel.org>
References: <20230802151406.3735276-1-willy@infradead.org>
 <20230802151406.3735276-27-willy@infradead.org>
 <2513a500-920d-4e32-8231-f428175c7182@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2513a500-920d-4e32-8231-f428175c7182@roeck-us.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 04, 2023 at 08:36:44AM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Wed, Aug 02, 2023 at 04:13:54PM +0100, Matthew Wilcox (Oracle) wrote:
> > Add set_ptes(), update_mmu_cache_range(), flush_dcache_folio() and
> > flush_icache_pages().  Convert the PG_dcache_dirty flag from being
> > per-page to per-folio.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: sparclinux@vger.kernel.org
> 
> This patch causes all my sparc64 qemu boot tests to crash.
> 
> [    4.890744] Unable to handle kernel NULL pointer dereference
> [    4.891273] tsk->{mm,active_mm}->context = 0000000000000001
> [    4.891475] tsk->{mm,active_mm}->pgd = fffff80005452000
> [    4.891660]               \|/ ____ \|/
> [    4.891660]               "@'/ .. \`@"
> [    4.891660]               /_| \__/ |_\
> [    4.891660]                  \__U_/
> [    4.892116] modprobe(45): Oops [#1]
> [    4.892555] CPU: 0 PID: 45 Comm: modprobe Tainted: G                 N 6.5.0+ #1
> [    4.892949] TSTATE: 0000004411001601 TPC: 00000000004565d8 TNPC: 00000000004565dc Y: 00000008    Tainted: G                 N

...

> [    4.901535] note: modprobe[45] exited with preempt_count 2

This should fix it:

From 8181d1f582a309b51fe4cb02a783628257b91c86 Mon Sep 17 00:00:00 2001
From: "Mike Rapoport (IBM)" <rppt@kernel.org>
Date: Mon, 4 Sep 2023 20:37:59 +0300
Subject: [PATCH] sparc64: add missing initialization of folio in
 tlb_batch_add()

Commit 1a10a44dfc1d ("sparc64: implement the new page table range API")
missed initialization of folio variable in tlb_batch_add() which causes
boot tests to crash.

Add missing initialization.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 1a10a44dfc1d ("sparc64: implement the new page table range API")
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/sparc/mm/tlb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index 0d41c94ec3ac..b44d79d778c7 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -128,6 +128,7 @@ void tlb_batch_add(struct mm_struct *mm, unsigned long vaddr,
 			goto no_cache_flush;
 
 		/* A real file page? */
+		folio = page_folio(page);
 		mapping = folio_flush_mapping(folio);
 		if (!mapping)
 			goto no_cache_flush;
-- 
2.39.2

 
> Guenter
> 

-- 
Sincerely yours,
Mike.
