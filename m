Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FC04F92E6
	for <lists+linux-arch@lfdr.de>; Fri,  8 Apr 2022 12:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbiDHKaz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Apr 2022 06:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbiDHKaz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Apr 2022 06:30:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C60C31A294;
        Fri,  8 Apr 2022 03:28:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECEB5B82A1E;
        Fri,  8 Apr 2022 10:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00713C385A3;
        Fri,  8 Apr 2022 10:28:47 +0000 (UTC)
Date:   Fri, 8 Apr 2022 11:28:44 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Christoph Hellwig <hch@infradead.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 6/7] mm/mmap: Drop arch_filter_pgprot()
Message-ID: <YlAOXG9XbQW1xPaT@arm.com>
References: <20220407103251.1209606-1-anshuman.khandual@arm.com>
 <20220407103251.1209606-7-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407103251.1209606-7-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 07, 2022 at 04:02:50PM +0530, Anshuman Khandual wrote:
> There are no platforms left which subscribe ARCH_HAS_FILTER_PGPROT. Hence
> drop generic arch_filter_pgprot() and also config ARCH_HAS_FILTER_PGPROT.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
