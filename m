Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17C791602E8
	for <lists+linux-arch@lfdr.de>; Sun, 16 Feb 2020 09:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgBPIXV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 Feb 2020 03:23:21 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:44812 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgBPIXU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 Feb 2020 03:23:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+8Uhu2wgUq8Ulq+yn7pGlyiEpl5L2cWMg1W6oSitXX8=; b=eZ+pxZ5QnjK4dWUII5qW9jbf8
        eHQaXZHQb+St/fNO4odIF1+oXNFmG9JyWOQyfNVp/YnjMm8+v9aiI+5lsbrKHrZZMx/nek8Kqd5TP
        2W8OtU17ICPE2UgLtdc9R5GSAIEv8D7oLBooYFlzt/1m+U1xt3Lrzg8xA2WrwUIRgXUZkmT5OSjiz
        v4iLBDbN3Jl9AzWwjfvTWiezYEvzjfDwRTq0N3FjcotV54dXrt1kPyxekt0I2b9RcgIp0XHoHzce1
        5fM/0Ipqg2sO442zcz74Ifmz05LfxOSewibl5FPqzdimV68xwJR331lGU1QToFVHsC5S11UIPKhv/
        xpuaPP69A==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:41020)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1j3FCS-0001uE-Q8; Sun, 16 Feb 2020 08:22:49 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1j3FCA-0005C0-Sx; Sun, 16 Feb 2020 08:22:30 +0000
Date:   Sun, 16 Feb 2020 08:22:30 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brian Cain <bcain@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guan Xuetao <gxt@pku.edu.cn>,
        James Morse <james.morse@arm.com>,
        Jonas Bonn <jonas@southpole.se>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        kvmarm@lists.cs.columbia.edu, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, nios2-dev@lists.rocketboards.org,
        openrisc@lists.librecores.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 00/13] mm: remove __ARCH_HAS_5LEVEL_HACK
Message-ID: <20200216082230.GV25745@shell.armlinux.org.uk>
References: <20200216081843.28670-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200216081843.28670-1-rppt@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Feb 16, 2020 at 10:18:30AM +0200, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Hi,
> 
> These patches convert several architectures to use page table folding and
> remove __ARCH_HAS_5LEVEL_HACK along with include/asm-generic/5level-fixup.h.
> 
> The changes are mostly about mechanical replacement of pgd accessors with p4d
> ones and the addition of higher levels to page table traversals.
> 
> All the patches were sent separately to the respective arch lists and
> maintainers hence the "v2" prefix.

You fail to explain why this change which adds 488 additional lines of
code is desirable.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
