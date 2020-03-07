Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F13AD17CBD1
	for <lists+linux-arch@lfdr.de>; Sat,  7 Mar 2020 05:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCGEAU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Mar 2020 23:00:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:49186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbgCGEAU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Mar 2020 23:00:20 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B2EA206D5;
        Sat,  7 Mar 2020 04:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583553618;
        bh=oV9dzypff0UA0jPadqQOWi55OmuNhXb+CU9VyawDDys=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SGgOZOJ38TBhL5PMq2t97iVlOYiTJrLFrJZwUFY+PkmX4j8DweXDMSJ8amOibPULY
         dukXRc++p/7grHQAkoJmRzC/WSXOXanM1qDKv14ejj7flbmiHB/27z6x/csQKB/k1O
         jFq+DE3IugyBsaFEvfl6ba2s2SLpEYfJdkqCDacY=
Date:   Fri, 6 Mar 2020 20:00:16 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
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
        Russell King <linux@armlinux.org.uk>,
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
Subject: Re: [PATCH v3 07/14] powerpc/32: drop get_pteptr()
Message-Id: <20200306200016.6f3865ada0daa68b645fe5d7@linux-foundation.org>
In-Reply-To: <20200227084608.18223-8-rppt@kernel.org>
References: <20200227084608.18223-1-rppt@kernel.org>
        <20200227084608.18223-8-rppt@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 27 Feb 2020 10:46:01 +0200 Mike Rapoport <rppt@kernel.org> wrote:

> Commit 8d30c14cab30 ("powerpc/mm: Rework I$/D$ coherency (v3)") and
> commit 90ac19a8b21b ("[POWERPC] Abolish iopa(), mm_ptov(),
> io_block_mapping() from arch/powerpc") removed the use of get_pteptr()
> outside of mm/pgtable_32.c
> 
> In mm/pgtable_32.c, the only user of get_pteptr() is __change_page_attr()
> which operates on kernel context and on lowmem pages only.
> 
> Move page table traversal to __change_page_attr() and drop get_pteptr().

People have been changing things in linux-next and the powerpc patches
are hurting.

I'll disable this patch series for now.  Can you please redo
powerpc-32-drop-get_pteptr.patch and
powerpc-add-support-for-folded-p4d-page-tables.patch (and
powerpc-add-support-for-folded-p4d-page-tables-fix.patch)?

Thanks.

