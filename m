Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE76577A21
	for <lists+linux-arch@lfdr.de>; Mon, 18 Jul 2022 06:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbiGREhR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Jul 2022 00:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGREhQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Jul 2022 00:37:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6BD10545;
        Sun, 17 Jul 2022 21:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h1dNvGxjCE8fsWPX0rqsPsfL/JqXGMXn4wNKGsUwRbg=; b=IFLwUHjSJ+aCRPMOv5C0EA3tlT
        8dCgyvAsBnZ/3yGLB8/vuVFYv83v7RAI1pTwZ/qUzcR1EMmP3egyL5RCXAhVjjYzXOGriYXCnbjfr
        FTTqMy1cM9/ZoL7u+biUCoKMvqa7ylAsgfW2I+sw6mqMCciU9BYuQXjPO8yWJIKgrpgkbAIG6klb3
        PnL6HQjJa+BfZ8Om+OQZ06PjVIu3H/GD+1SZvoR44ZSE4aS02PAvNHHfJJT+B7CXAdrTqjFITMq/Q
        xwgAGbEfhkfHofIDrOkNWm0XZgIIWcBBt5pP3ZZG+ikYlqAKEvGxUs9z7QtBrYHGlquL4ixkFpzPY
        IQu1pHFA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDIVM-00Atct-TK; Mon, 18 Jul 2022 04:37:12 +0000
Date:   Sun, 17 Jul 2022 21:37:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-um@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 2/2] asm-generic: Add new pci.h and use it
Message-ID: <YtTjeEnKr8f8z4JS@infradead.org>
References: <20220717033453.2896843-1-shorne@gmail.com>
 <20220717033453.2896843-3-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220717033453.2896843-3-shorne@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jul 17, 2022 at 12:34:53PM +0900, Stafford Horne wrote:
> Two things to note are:
> 
>  - isa_dma_bridge_buggy, traditionally this is defined in asm/dma.h but
>    these architectures avoid creating that file and add the definition
>    to asm/pci.h.

This doesn't have anyting to do with PCI support.  I think adding a
separate header just for this that always stubs it out unless a config
option is set (which x86 then selects) is the besy idea here.  I also
think the isa_dma_bridge_buggy needs to move out of the PCI code as
well.
