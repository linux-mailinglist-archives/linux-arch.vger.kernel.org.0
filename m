Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551CD445987
	for <lists+linux-arch@lfdr.de>; Thu,  4 Nov 2021 19:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbhKDSXY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Nov 2021 14:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbhKDSXY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Nov 2021 14:23:24 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417DCC061714;
        Thu,  4 Nov 2021 11:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CTMgu48D5xrqZkVRkHn0Ok/wYvOBUq4l67vNS1ppUJ0=; b=wOY07QEE2cjfGMszfimeZ58LkM
        1I6fsH17SoGntuT+2pW1LYNpfvAHf9Odniy7Em5lz8tNlhapR7b4lWhb3f8Ejsn7WbjyiCUt9AJq7
        lZBgIxLxO0HU91Ope1VmZ1etWszOc0KIjPAt2Cj6c55y4/iHbVJxYYTsD2IfUWPPux1bPS2Bc57pf
        cJIF0nJezqfm2nQ7VbYyWleceN1fib/ju42YRHdpDA3XL4q/r7nswjIXhgrPyil/3TfC7ykXaef4h
        hFAaQqiPpeLecazmT4xNltLizhR81mEUu6KEwQxGFkCSZlP5dVMjQtR7I7IMVQCj93r6FVpiSVlcg
        XPfDVYow==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55488)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mihLs-0006Dz-Gt; Thu, 04 Nov 2021 18:20:40 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mihLp-0007Ws-JS; Thu, 04 Nov 2021 18:20:37 +0000
Date:   Thu, 4 Nov 2021 18:20:37 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: flush_dcache_page vs kunmap_local
Message-ID: <YYQkdUcSLFPlzGFH@shell.armlinux.org.uk>
References: <YYP1lAq46NWzhOf0@casper.infradead.org>
 <CAHk-=wiKac4t-fOP_3fAf7nETfFLhT3ShmRmBq2J96y6jAr56Q@mail.gmail.com>
 <YYQQPuhVUHqfldDg@arm.com>
 <CAHk-=wiDjjL50BBU=i8BFz3Rv5+-pGysEyCD+mcc_K_g0140oQ@mail.gmail.com>
 <YYQgvTn2NQdZK2Ku@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYQgvTn2NQdZK2Ku@arm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 04, 2021 at 06:04:45PM +0000, Catalin Marinas wrote:
> The cachetlb.rst doc states the two cases where flush_dcache_page()
> should be called:
> 
> 1. After writing to a page cache page (that's what we need on arm64 for
>    the I-cache).
> 
> 2. Before reading from a page cache page and user mappings potentially
>    exist. I think arm32 ensures the D-cache user aliases are coherent
>    with the kernel one (added rmk to confirm).

Yes, where necessary, we flush the user aliases in flush_dcache_page().

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
