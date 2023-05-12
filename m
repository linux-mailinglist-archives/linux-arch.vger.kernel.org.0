Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203F4700C42
	for <lists+linux-arch@lfdr.de>; Fri, 12 May 2023 17:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242026AbjELPu2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 May 2023 11:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241304AbjELPu0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2023 11:50:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4B740F8;
        Fri, 12 May 2023 08:50:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11D9B657D8;
        Fri, 12 May 2023 15:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FE5C433D2;
        Fri, 12 May 2023 15:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683906624;
        bh=4hkHCupzGOuMqiw3YwQ6v+xlkODto1KsgLIqwYw321I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UewoEjUiWl69xJYbwoKS3AP5squS7pM/TUB6Duf3uzKqmzXM60uW3jRLTX/dJlSvU
         MeV0zd22G4mfXp4haj2JfrR0P31mlrxR2+6U5J48bcKgDVNlwj2B+FpHh7CjRfzg9n
         VwsHHCeMUQhmCKeg+FG66Jj+R9zgX7QMMGXTWu9p0NufHqlzH+MaNPlueluwTtRKbs
         dYC/iCYGsL3VTPklGka/sT8zR1CW8Berie7jWTvfbj1aG8SGHStxEmsHaO4H4oTg8q
         A+rIlE2Wt26WOvfT59rB08ESjRozq9JYab/7dTTranNoGfixToSP2t8DDzgTZqD8h4
         Gux1xro9qoPdw==
Date:   Fri, 12 May 2023 23:39:15 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 4/4] riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Message-ID: <ZF5do/iNVntdl3s7@xhacker>
References: <20230511141211.2418-1-jszhang@kernel.org>
 <20230511141211.2418-5-jszhang@kernel.org>
 <20230512-spouse-pang-87f2e579baa2@wendy>
 <20230512-garage-slacked-d16268c0726e@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230512-garage-slacked-d16268c0726e@spud>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 12, 2023 at 04:16:31PM +0100, Conor Dooley wrote:
> On Fri, May 12, 2023 at 02:58:49PM +0100, Conor Dooley wrote:
> > On Thu, May 11, 2023 at 10:12:11PM +0800, Jisheng Zhang wrote:
> > 
> > > diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> > > index e5f9f4677bbf..492dd4b8f3d6 100644
> > > --- a/arch/riscv/kernel/vmlinux.lds.S
> > > +++ b/arch/riscv/kernel/vmlinux.lds.S
> > > @@ -85,11 +85,11 @@ SECTIONS
> > >  	INIT_DATA_SECTION(16)
> > >  
> > >  	.init.pi : {
> > > -		*(.init.pi*)
> > > +		KEEP(*(.init.pi*))
> > >  	}
> > 
> > This section no longer exists in v6.4-rc1, it is now:
> > 	/* Those sections result from the compilation of kernel/pi/string.c */
> > 	.init.pidata : {
> > 		*(.init.srodata.cst8*)
> > 		*(.init__bug_table*)
> > 		*(.init.sdata*)
> > 	}
> 
> Ahh, I see what has happened. This series was made on top of
> riscv/fixes, but none of the patches are marked as a fix, leading to the

I need to touch the sections, and there's a fix in Palmer's tree which
will rename the section name, so rebased on the fix HEAD.

> automation testing this as new content.
> 
> Sorry for the noise on this patch.

Thank you for your review.
