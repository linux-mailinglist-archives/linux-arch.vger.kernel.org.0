Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C6F4F8AF6
	for <lists+linux-arch@lfdr.de>; Fri,  8 Apr 2022 02:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbiDGXWh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Apr 2022 19:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiDGXW3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Apr 2022 19:22:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1639630B;
        Thu,  7 Apr 2022 16:20:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BE2860F26;
        Thu,  7 Apr 2022 23:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64848C385A0;
        Thu,  7 Apr 2022 23:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649373625;
        bh=3fTd4/oB9ZoXEdf+K+L8T8ud1sgeiHXYri5q9XU2dws=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZSvawR2SP4z25+5v05hEzD/SNY3BquUg00da51rb2XpIhfun/uRj9F50//O4lmLVK
         mMLQ0SBSzdnOSHOJqeZeyVk3ZlzylTqp4UUO/tQPLTSgSiMH0RDrND71V5dVeKi6ET
         qbMbsgu4SDWZr0njwS/0ZGtXu6KbiDlG0yFJTssU=
Date:   Thu, 7 Apr 2022 16:20:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Christoph Hellwig <hch@infradead.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 0/7] mm/mmap: Drop arch_vm_get_page_prot() and
 arch_filter_pgprot()
Message-Id: <20220407162024.7747ee14092d04082f13aa9d@linux-foundation.org>
In-Reply-To: <20220407103251.1209606-1-anshuman.khandual@arm.com>
References: <20220407103251.1209606-1-anshuman.khandual@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu,  7 Apr 2022 16:02:44 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> protection_map[] is an array based construct that translates given vm_flags
> combination. This array contains page protection map, which is populated by
> the platform via [__S000 .. __S111] and [__P000 .. __P111] exported macros.
> Primary usage for protection_map[] is for vm_get_page_prot(), which is used
> to determine page protection value for a given vm_flags. vm_get_page_prot()
> implementation, could again call platform overrides arch_vm_get_page_prot()
> and arch_filter_pgprot(). Some platforms override protection_map[] that was
> originally built with __SXXX/__PXXX with different runtime values.
> 
> Currently there are multiple layers of abstraction i.e __SXXX/__PXXX macros
> , protection_map[], arch_vm_get_page_prot() and arch_filter_pgprot() built
> between the platform and generic MM, finally defining vm_get_page_prot().
> 
> Hence this series proposes to drop later two abstraction levels and instead
> just move the responsibility of defining vm_get_page_prot() to the platform
> (still utilizing generic protection_map[] array) itself making it clean and
> simple.
> 
> This first introduces ARCH_HAS_VM_GET_PAGE_PROT which enables the platforms
> to define custom vm_get_page_prot(). This starts converting platforms that
> define the overrides arch_filter_pgprot() or arch_vm_get_page_prot() which
> enables for those constructs to be dropped off completely.
> 
> The series has been inspired from an earlier discuss with Christoph Hellwig
> 
> https://lore.kernel.org/all/1632712920-8171-1-git-send-email-anshuman.khandual@arm.com/
> 
> This series applies on 5.18-rc1 after the following patch.
> 
> https://lore.kernel.org/all/1643004823-16441-1-git-send-email-anshuman.khandual@arm.com/

Confusing.  That patch is already in 5.18-rc1.

But the version which was merged (24e988c7fd1ee701e) lacked the change
to arch/arm64/Kconfig.  I seem to recall that this patch went through a
few issues and perhaps the arm64 change was dropped.  Can you please
check?

(It would be easier for me to track all this down if the original patch
had had cc:linux-mm.  Please cc linux-mm!)

