Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68080E166F
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2019 11:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404060AbfJWJlj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 05:41:39 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:57066 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403799AbfJWJlj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Oct 2019 05:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Zj5XfgeeJGpKuLcZ9xIMs7v8y6wlyVmuVne2tYjeW1M=; b=tSh0TWsLv0zTB/+cgvenf9Alp
        bJ97VOL1Q4Q/wIuvnA12UaDMLRf78wnJjHpbggLuo4iMGeNglZ1as6l8RASl1TDll+uOHTPG25/pR
        acvy9GNDVqZ7KfBh47xSWs+PI5asIdAhm13tXE6BItpl+2VzngNhBvzuj+zOzsXjQrFsNNJCGjnRC
        AbTb9a1MpJm1fedkHTRfoEwRE0vhBKPst8jQpneLESyhJ64OYxELIPZrr0oJy1xuGi9RVf/xLwxxe
        lNgreE5Mr25YZDU0qQD3g4xFyjZHQ8a3w8RDULX7AAdieMMMEEubl0LuajXBuQGADa2mAfoNErhWi
        9nNtjsKOg==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:46362)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iND8K-00047D-6h; Wed, 23 Oct 2019 10:40:48 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iND7x-0005NN-6r; Wed, 23 Oct 2019 10:40:25 +0100
Date:   Wed, 23 Oct 2019 10:40:25 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jeff Dike <jdike@addtoit.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Richard Weinberger <richard@nod.at>,
        Sam Creasey <sammy@sammy.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-parisc@vger.kernel.org, linux-um@lists.infradead.org,
        sparclinux@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 02/12] arm: nommu: use pgtable-nopud instead of
 4level-fixup
Message-ID: <20191023094025.GY25745@shell.armlinux.org.uk>
References: <1571822941-29776-1-git-send-email-rppt@kernel.org>
 <1571822941-29776-3-git-send-email-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571822941-29776-3-git-send-email-rppt@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 23, 2019 at 12:28:51PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The generic nommu implementation of page table manipulation takes care of
> folding of the upper levels and does not require fixups.
> 
> Simply replace of include/asm-generic/4level-fixup.h with
> include/asm-generic/pgtable-nopud.h.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks.

> ---
>  arch/arm/include/asm/pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
> index 3ae120c..eabcb48 100644
> --- a/arch/arm/include/asm/pgtable.h
> +++ b/arch/arm/include/asm/pgtable.h
> @@ -12,7 +12,7 @@
>  
>  #ifndef CONFIG_MMU
>  
> -#include <asm-generic/4level-fixup.h>
> +#include <asm-generic/pgtable-nopud.h>
>  #include <asm/pgtable-nommu.h>
>  
>  #else
> -- 
> 2.7.4
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
