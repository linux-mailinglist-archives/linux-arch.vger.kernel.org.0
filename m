Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DF3730523
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jun 2023 18:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235887AbjFNQhl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jun 2023 12:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbjFNQhO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jun 2023 12:37:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A8410E9;
        Wed, 14 Jun 2023 09:37:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E85676409C;
        Wed, 14 Jun 2023 16:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2413C433C0;
        Wed, 14 Jun 2023 16:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686760629;
        bh=Bs+EyfsO2p9fJ/uqqvy28thI6wPfslvdFWG010Lc/Ns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YefGG52yVCQf3IypRiZPtyZ7PvmCO+Kdc2xodNzcw7+v5J6HaCpn0lu1wYeVgv6B+
         mj9gLO4vnTF99DdR2O/wyhsXvhnIm5KcwCJYE7ooevgccwXczE/2FNEYu2nCX6wPFt
         +/yrM8HKUUV2gLoLaApRLTjJF7UE54oDIVF3nJLckn8SaO8CCR2DqFIaOBlzvYOW/5
         hZ+eteDS3bzfgf7ql3+U1DEHXs4SrIy7t53ljQcXEi3JyVXeyL12JDz4fFg3SHkfUH
         89LHGk6N95J2D7jn1cAXKKUyBrX/z0bL1yPQdJL8Usn7k+hhhZsvRPUDRabsB6J2qh
         cAEiWwrW7Gc0g==
Date:   Thu, 15 Jun 2023 00:25:49 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 0/4] riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Message-ID: <ZInqDdXh6wNK3NHq@xhacker>
References: <20230523165502.2592-1-jszhang@kernel.org>
 <mhng-4483745f-f356-454c-8c2a-5f0e5b6c9739@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <mhng-4483745f-f356-454c-8c2a-5f0e5b6c9739@palmer-ri-x1c9>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On Wed, Jun 14, 2023 at 07:49:17AM -0700, Palmer Dabbelt wrote:
> On Tue, 23 May 2023 09:54:58 PDT (-0700), jszhang@kernel.org wrote:
> > When trying to run linux with various opensource riscv core on
> > resource limited FPGA platforms, for example, those FPGAs with less
> > than 16MB SDRAM, I want to save mem as much as possible. One of the
> > major technologies is kernel size optimizations, I found that riscv
> > does not currently support HAVE_LD_DEAD_CODE_DATA_ELIMINATION, which
> > passes -fdata-sections, -ffunction-sections to CFLAGS and passes the
> > --gc-sections flag to the linker.
> > 
> > This not only benefits my case on FPGA but also benefits defconfigs.
> > Here are some notable improvements from enabling this with defconfigs:
> > 
> > nommu_k210_defconfig:
> >    text    data     bss     dec     hex
> > 1112009  410288   59837 1582134  182436     before
> >  962838  376656   51285 1390779  1538bb     after
> > 
> > rv32_defconfig:
> >    text    data     bss     dec     hex
> > 8804455 2816544  290577 11911576 b5c198     before
> > 8692295 2779872  288977 11761144 b375f8     after
> > 
> > defconfig:
> >    text    data     bss     dec     hex
> > 9438267 3391332  485333 13314932 cb2b74     before
> > 9285914 3350052  483349 13119315 c82f53     after
> > 
> > patch1 and patch2 are clean ups.
> > patch3 fixes a typo.
> > patch4 finally enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION for riscv.
> > 
> > NOTE: Zhangjin Wu firstly sent out a patch to enable dead code
> > elimination for riscv several months ago, I didn't notice it until
> > yesterday. Although it missed some preparations and some sections's
> > keeping, he is the first person to enable this feature for riscv. To
> > ease merging, this series take his patch into my entire series and
> > makes patch4 authored by him after getting his ack to reflect
> > the above fact.
> > 
> > Since v1:
> >   - collect Reviewed-by, Tested-by tag
> >   - Make patch4 authored by Zhangjin Wu, add my co-developed-by tag
> > 
> > Jisheng Zhang (3):
> >   riscv: move options to keep entries sorted
> >   riscv: vmlinux-xip.lds.S: remove .alternative section
> >   vmlinux.lds.h: use correct .init.data.* section name
> > 
> > Zhangjin Wu (1):
> >   riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
> > 
> >  arch/riscv/Kconfig                  |  13 +-
> >  arch/riscv/kernel/vmlinux-xip.lds.S |   6 -
> >  arch/riscv/kernel/vmlinux.lds.S     |   6 +-
> >  include/asm-generic/vmlinux.lds.h   |   2 +-
> >  4 files changed, 11 insertions(+), 16 deletions(-)
> 
> Do you have a base commit for this?  It's not applying to 6.4-rc1 and the
> patchwork bot couldn't find one either.

Hi Palmer,

Commit 3b90b09af5be ("riscv: Fix orphan section warnings caused by
kernel/pi") touches vmlinux.lds.S, so to make the merge easy, this
series is based on 6.4-rc2.

Thanks
