Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939286A89DA
	for <lists+linux-arch@lfdr.de>; Thu,  2 Mar 2023 20:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjCBT5Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Mar 2023 14:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCBT5C (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2023 14:57:02 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09954743A;
        Thu,  2 Mar 2023 11:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r+p3XE54gIXRBSc1Xwon4gGUeURnRrQNa2oyvHJuCaM=; b=nKH5vW/pT39uCrfcSgbjJyMUYC
        +lKRMpvN+JQtoMqtHMrK93E8gRTgr/W6uYdQUac9LDsG+y/xZtXyilGDKEmLWYMUNhkxAPJ/q/Bc5
        TtnjX1CPeM8aR7jMPG3B7QEstFq+eV0giComaBIksQ/Thk1SXqWnrBhD13s4EzOQGBHCW36iVMT2A
        BSwZSeBSsYcmDQcHzL0qsabqSAPmg8TFrhQK9O0u4gfL62dMVzLzcplUjtoFYflZCdAAzbZ5dQYHB
        /Hn05CFTn8Y/2bO/8xb9ZmdhXkaNPD28KO4uL3R5p2T+U5zLgrC79uFMHLdZEmE9q/PAHz3TNTTnG
        uLRnBoFQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXp2y-003Cjr-MO; Thu, 02 Mar 2023 19:57:00 +0000
Date:   Thu, 2 Mar 2023 11:57:00 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, geert@linux-m68k.org,
        hch@infradead.org
Subject: Re: [PATCH v2 0/2] arch/*/io.h: remove ioremap_uc in some
 architectures
Message-ID: <ZAD/jLaacr0Xu+/M@bombadil.infradead.org>
References: <20230301102208.148490-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301102208.148490-1-bhe@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 01, 2023 at 06:22:06PM +0800, Baoquan He wrote:
> This patchset tries to remove ioremap_uc() in the current architectures
> except of x86 and ia64. They will use the default ioremap_uc definition
> in <asm-generic/io.h> which returns NULL.
> 
> If any arch sees a breakage caused by the default ioremap_uc(), it can
> provide a sepcific one for its own usage.

Feel free to add:

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
