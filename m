Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D25D697D36
	for <lists+linux-arch@lfdr.de>; Wed, 15 Feb 2023 14:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjBON1J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Feb 2023 08:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbjBON1H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Feb 2023 08:27:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C127C35B0
        for <linux-arch@vger.kernel.org>; Wed, 15 Feb 2023 05:26:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79EF2B82209
        for <linux-arch@vger.kernel.org>; Wed, 15 Feb 2023 13:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1149AC433A0;
        Wed, 15 Feb 2023 13:26:45 +0000 (UTC)
Date:   Wed, 15 Feb 2023 13:26:43 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org
Subject: Re: [PATCH 9/7] arm64: Implement the new page table range API
Message-ID: <Y+zdk3VyXyZk9mhi@arm.com>
References: <20230211033948.891959-1-willy@infradead.org>
 <20230215000446.1655635-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215000446.1655635-1-willy@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 15, 2023 at 12:04:42AM +0000, Matthew Wilcox wrote:
> Add set_ptes(), update_mmu_cache_range() and flush_dcache_folio().
> 
> The PG_dcache_clear flag changes from being a per-page bit to being a
> per-folio bit.

Nit: s/PG_dcache_clear/PG_dcache_clean/

I should do the same with PG_mte_tagged bit (I already started but got
distracted by other things).

For this patch:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
