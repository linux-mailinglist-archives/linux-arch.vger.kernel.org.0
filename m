Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B417F3CA31A
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jul 2021 18:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhGOQul (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Jul 2021 12:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhGOQuk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jul 2021 12:50:40 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B48DC06175F;
        Thu, 15 Jul 2021 09:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=r4iZBSBArnzjTS6KLDRlSR7w7S6swyImdOsNDPS7Sis=; b=hXyaSz1urrT6N85UjIGFUt7af
        PiwXb128VN8Nd6dy5SRYwLWwy0SU/ypNmQ5JkYOh1JS2knojDgYLwXthStegnsrmI09YsBKkM5MPT
        OFWdJtkr7MnIGIFr7Eu7JUWtgArfiSNHXwRV9gQpKR7ScC2Ix9rrzYF2dvjCFdX/L00fOFO76Of4w
        hfdI4vD/xWj3aJ5FF/avwPxEPbK5jVDDQhEdaOQcff3CqVbPu67/A/baLdEvLiryu7GoHqX4uA6Jq
        sI/hDfVhZXyZM218k0a5xjDhDyNTv0Fs4cTLfiUQQBY6IBzO7IExkNkK9UfN7Fkbsk7TGJ83IM+Fn
        E9B14gOZQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46186)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1m44WV-000147-6i; Thu, 15 Jul 2021 17:47:43 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1m44WT-0002L1-Ek; Thu, 15 Jul 2021 17:47:41 +0100
Date:   Thu, 15 Jul 2021 17:47:41 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm: Rename PMD_ORDER to PMD_TABLE_ORDER
Message-ID: <20210715164740.GN22278@shell.armlinux.org.uk>
References: <20210715134612.809280-1-willy@infradead.org>
 <20210715134612.809280-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715134612.809280-2-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 15, 2021 at 02:46:10PM +0100, Matthew Wilcox (Oracle) wrote:
> This is the order of the page table allocation, not the order of a PMD.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  arch/arm/kernel/head.S | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index 9eb0b4dbcc12..6da39a1d70ba 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -38,10 +38,10 @@
>  #ifdef CONFIG_ARM_LPAE
>  	/* LPAE requires an additional page for the PGD */
>  #define PG_DIR_SIZE	0x5000
> -#define PMD_ORDER	3
> +#define PMD_TABLE_ORDER	3
>  #else
>  #define PG_DIR_SIZE	0x4000
> -#define PMD_ORDER	2
> +#define PMD_TABLE_ORDER	2

I think PMD_ENTRY_ORDER would make more sense here - this is the
power-of-2 of an individual PMD entry, not of the entire table.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
