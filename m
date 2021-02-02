Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C42A30BDBB
	for <lists+linux-arch@lfdr.de>; Tue,  2 Feb 2021 13:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhBBMIK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Feb 2021 07:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhBBMIF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Feb 2021 07:08:05 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9199C061573;
        Tue,  2 Feb 2021 04:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ff/wpjr28khgZASsQau1yxjR8C0J+5ugrzPgigwTWJ0=; b=g+zlPNAWAiJW5GOWEjHNIVmqA
        0i1nsvoEBElLib6NPI+ewFmTSmVP7JGSQ7ZLly3jTDpFtnIDio9CEcaBiQSFwcgmPHoMvRYCbwGWt
        PkjTmE1MYLjA2QUDOjN2Mn234zZSJtnzMrVt+Kc4GD8aK1RdS6EgeyWWIM9ttIO1LsqlzqeuKm1bX
        hC3JYtKbNMb2qpSdXuDo/qCblleoKhE5dft21RMev3iDIm67Fs0AiDx4do2YnTx+1m42FvFdXA9/n
        hFly2dtJBy7Hrr+SaHO+q+VcPF9VPjlgiUyfr22h++1gaon0GMT8fIpHV/Ua3BRHpputjXSfiebb7
        f+YrLjvrA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38196)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1l6uSd-0004KH-MO; Tue, 02 Feb 2021 12:07:11 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1l6uSa-00030y-Hf; Tue, 02 Feb 2021 12:07:08 +0000
Date:   Tue, 2 Feb 2021 12:07:08 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Ding Tianhong <dingtianhong@huawei.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v12 01/14] ARM: mm: add missing pud_page define to
 2-level page tables
Message-ID: <20210202120708.GM1463@shell.armlinux.org.uk>
References: <20210202110515.3575274-1-npiggin@gmail.com>
 <20210202110515.3575274-2-npiggin@gmail.com>
 <20210202111319.GL1463@shell.armlinux.org.uk>
 <d1f661f2-f473-1dd8-94cc-fe76714249b5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1f661f2-f473-1dd8-94cc-fe76714249b5@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 02, 2021 at 07:47:04PM +0800, Ding Tianhong wrote:
> On 2021/2/2 19:13, Russell King - ARM Linux admin wrote:
> > On Tue, Feb 02, 2021 at 09:05:02PM +1000, Nicholas Piggin wrote:
> >> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
> >> index c02f24400369..d63a5bb6bd0c 100644
> >> --- a/arch/arm/include/asm/pgtable.h
> >> +++ b/arch/arm/include/asm/pgtable.h
> >> @@ -166,6 +166,9 @@ extern struct page *empty_zero_page;
> >>  
> >>  extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
> >>  
> >> +#define pud_page(pud)		pmd_page(__pmd(pud_val(pud)))
> >> +#define pud_write(pud)		pmd_write(__pmd(pud_val(pud)))
> > 
> > As there is no PUD, does it really make sense to return a valid
> > struct page (which will be the PTE page) for pud_page(), which is
> > several tables above?
> > 
> --- a/arch/arm/include/asm/pgtable-2level.h
> +++ b/arch/arm/include/asm/pgtable-2level.h
> 
> +static inline int pud_none(pud_t pud)
> +{
> +          return 0;
> +}
> 
> I think it could be fix like this.

We already have that.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
