Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1379B4C6922
	for <lists+linux-arch@lfdr.de>; Mon, 28 Feb 2022 11:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbiB1K7W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 05:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235415AbiB1K7S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 05:59:18 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704E45F48;
        Mon, 28 Feb 2022 02:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DM3iere1mz4IiAwYCVyOTU3E+xuCTYR85Md0nHyvzDc=; b=QSz7tR2zlZoaBSWZGCaio7Oilq
        VwpNbxcqDPOH5Kt8OjbQhKwhks/heDAW4JFpmDfExgUTPmIf+TJ10GIXRaXS+m7eIwuh+Zrmg7ard
        JKb4cBAyp9suGksD5aOyDCbwX+GG/5CmBp/gJRuLB3YTEup0rKS6dKesQIWN1THmbCdg+fDs9npwW
        3G62kcQtbbdR93/Yp8xWQeqnioTzargs6Wc3dgV6A9bObOsm+8HNJnnVTRueD5kTaHC4WKRDrKhk3
        sYEtwY/WuFW1YR5ryQKZcakT/DA1fRo7nFdF8mglYtoE5o2X2pzfPHjvtIcfU/vD9UYjeVFBIOfpb
        OWrBs5aQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57554)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nOdiU-00087R-Ua; Mon, 28 Feb 2022 10:57:22 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nOdiQ-00064t-9z; Mon, 28 Feb 2022 10:57:18 +0000
Date:   Mon, 28 Feb 2022 10:57:18 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, geert@linux-m68k.org,
        Christoph Hellwig <hch@infradead.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-alpha@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-parisc@vger.kernel.org,
        openrisc@lists.librecores.org, linux-um@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3 09/30] arm/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Message-ID: <Yhyqjo/4bozJB6j5@shell.armlinux.org.uk>
References: <1646045273-9343-1-git-send-email-anshuman.khandual@arm.com>
 <1646045273-9343-10-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646045273-9343-10-git-send-email-anshuman.khandual@arm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 28, 2022 at 04:17:32PM +0530, Anshuman Khandual wrote:
> This defines and exports a platform specific custom vm_get_page_prot() via
> subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
> macros can be dropped which are no longer needed.

What I would really like to know is why having to run _code_ to work out
what the page protections need to be is better than looking it up in a
table.

Not only is this more expensive in terms of CPU cycles, it also brings
additional code size with it.

I'm struggling to see what the benefit is.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
