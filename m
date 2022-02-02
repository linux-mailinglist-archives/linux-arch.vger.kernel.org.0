Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8D14A7BC1
	for <lists+linux-arch@lfdr.de>; Thu,  3 Feb 2022 00:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiBBXeV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Feb 2022 18:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiBBXeU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Feb 2022 18:34:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D219C061714;
        Wed,  2 Feb 2022 15:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=Jh/EL1diuD4J1JZYZhhqdPKhDKb1uRzo1pLWpqiNQQs=; b=bbPsm2Rw+E4ZQJ3Gw3fUrZTGnO
        k4tL7MeTqglU0jb/1hlbW+xa+BanJ470QCRr4yvg9ENXOU2gryoa8LYF82kJSVm7rsgG66ol4IQIB
        4/NUNG9bTcqBoUNlRLR79ulXI5LQ8DO9tyJXr2y/Fv9KrPLoBlvZA1cDIJzUHMsFE1Fey8aLqAfOf
        VTd/zevfqWmzF29UOcxH+pTAcxesxVHVrFq84jSfiqdsVaDkC7y8br5ZVE6/lkN20W8qroOQ3Ky4N
        jJcXiP+owiRm5ttbkmMnRJD/ijuNsP/Yey+trKKLUNXCQgLLs692qSL3uR1aCH1A4SvHMLK+Dystg
        kSCXI3vw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFP8h-00H4m1-Uf; Wed, 02 Feb 2022 23:34:15 +0000
Date:   Wed, 2 Feb 2022 15:34:15 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Jessica Yu <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 6/7] modules: Add
 CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
Message-ID: <YfsU9wuMKr4awYce@bombadil.infradead.org>
References: <cover.1643015752.git.christophe.leroy@csgroup.eu>
 <848d857871f457f4df37e80fad468d615b237c24.1643015752.git.christophe.leroy@csgroup.eu>
 <YfBnNuXpR2l2AuCP@bombadil.infradead.org>
 <b49235ef-1fc3-7b8f-7e23-79f461d83e18@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b49235ef-1fc3-7b8f-7e23-79f461d83e18@csgroup.eu>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 26, 2022 at 06:38:30AM +0000, Christophe Leroy wrote:
> 
> 
> Le 25/01/2022 à 22:10, Luis Chamberlain a écrit :
> > On Mon, Jan 24, 2022 at 09:22:34AM +0000, Christophe Leroy wrote:
> >> This can also be useful on other powerpc/32 in order to maximize the
> >> chance of code being close enough to kernel core to avoid branch
> >> trampolines.
> > 
> > Curious about all this branch trampoline talk. Do you have data to show
> > negative impact with things as-is?
> 
> See 
> https://github.com/linuxppc/linux/commit/2ec13df167040cd153c25c4d96d0ffc573ac4c40
> 
> Or 
> https://github.com/linuxppc/linux/commit/7d485f647c1f4a6976264c90447fb0dbf07b111d


This was useful and fun to read, thanks.

> > Also, was powerpc/32 broken then without this? The commit log seems to
> > suggest so, but I don't think that's the case. How was this issue noticed?
> 
> 
> Your question is related to the trampoline topic or the exec/noexec 
> flagging ?
> 
> Regarding trampoline, everything is working OK. That's just cherry on 
> the cake, when putting data away you can have more code closer to the 
> kernel. But that would not have been a reason in itself for this series.
> 
> Regarding the exec/noexec discussion, it's a real issue. powerpc/32 
> doesn't honor page exec flag, so when you select STRICT_MODULES_RWX and 
> flag module data as no-exec, it remains executable. That's because 
> powerpc/32 MMU doesn't have a per page exec flag but only a per 
> 256Mbytes segment exec flag.
> 
> Typical PPC32 layount:
> 0xf0000000-0xffffffff : VMALLOC AREA ==> NO EXEC
> 0xc0000000-0xefffffff : Linear kernel memory mapping
> 0xb0000000-0xbfffffff : MODULES AREA ==> EXEC
> 0x00000000-0xafffffff : User space ==> EXEC
> 
> So STRICT_MODULES_RWX is broken on some powerpc/32

You know, this is the sort of information that I think would be
very useful for the commit log. Can you ammend?

> > 
> > Are there other future CPU families being planned where this is all true for
> > as well? Are they goin to be 32-bit as well?
> 
> Future I don't know.
> 
> Regarding the trampoline stuff, I see at least the following existing 
> architectures with a similar constraint:
> 
> ARM:
> 
> https://elixir.bootlin.com/linux/v5.16/source/arch/arm/include/asm/memory.h#L55
> 
> ARM even has a config item to allow trampolines or not. I might add the 
> same to powerpc to reduce number of pages used by modules.
> 
> https://elixir.bootlin.com/linux/v5.16/source/arch/arm/Kconfig#L1514
> 
> NDS32 has the constraint
> 
> https://elixir.bootlin.com/linux/v5.16/source/arch/nds32/include/asm/memory.h#L41
> 
> NIOS2 has the constraint, allthough they handled it in a different way:
> 
> https://elixir.bootlin.com/linux/v5.16/source/arch/nios2/kernel/module.c#L30
> 
> 
> 
> Even ARM64 benefits from modules closer to kernel:
> 
> https://elixir.bootlin.com/linux/v5.16/source/arch/arm64/Kconfig#L1848
> 
> 
> Another future opportunity with the ability to allocate module parts 
> separately is the possibility to then use huge vmalloc mappings.
> 
> Today huge vmalloc mappings cannot be used for modules, see recent 
> discussion at 
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20211227145903.187152-4-wangkefeng.wang@huawei.com/

Alrighty, this is sufficient information, thanks!

  Luis
