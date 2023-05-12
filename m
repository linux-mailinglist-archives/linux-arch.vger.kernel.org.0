Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBEEC700C3D
	for <lists+linux-arch@lfdr.de>; Fri, 12 May 2023 17:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242008AbjELPrn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 May 2023 11:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241702AbjELPrm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2023 11:47:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA2D1BD7;
        Fri, 12 May 2023 08:47:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A765657D8;
        Fri, 12 May 2023 15:47:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A997EC433D2;
        Fri, 12 May 2023 15:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683906460;
        bh=Wy0d3uxrayVh8WVU98eTSh4D1SlUzUScL1EpN1S6WTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MF8gzeRDQ4w0pQGc7hu/dQ17aba5pqapc5AeMc0dugON74rTOWl2kDmGwbd9RBCtS
         KwaHGS8Md1r+snXTbF8trozWhOschtu+++qm5KndWeAEo9pmNPMUT0tWtjsIRCZvQA
         zlE5NYeCuxN8YQcASlhIBJaLMKNYHso75qDdiEEsECxdvalv3mZd+5lbSu0wwe97rq
         uRIP8L+WZ3lD1TvDeDW4206klCdl36/u7MrHfscSGBAbu0xviEUjYJdDZPiEMBX9Qn
         oOx6QfGyIxj499kuGIAWiwMDb3xu1krt7hg705FhQHzXuCgjHGlsbCqrJQpWOQqRq1
         bvy3NtK5C30Mw==
Date:   Fri, 12 May 2023 23:36:32 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/4] riscv: vmlinux-xip.lds.S: remove .alternative section
Message-ID: <ZF5dAG1XZoWA1Om2@xhacker>
References: <20230511141211.2418-1-jszhang@kernel.org>
 <20230511141211.2418-2-jszhang@kernel.org>
 <20230512-lunar-overbook-e34b468dda65@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230512-lunar-overbook-e34b468dda65@wendy>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 12, 2023 at 02:51:56PM +0100, Conor Dooley wrote:
> On Thu, May 11, 2023 at 10:12:08PM +0800, Jisheng Zhang wrote:
> > ALTERNATIVE mechanism can't work on XIP, and this is also reflected by
> > below Kconfig dependency:
> > 
> > RISCV_ALTERNATIVE
> > 	...
> > 	depends on !XIP_KERNEL
> > 	...
> > 
> > So there's no .alternative section at all for XIP case, remove it.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Just to note, this series doesn't apply on top of -rc1 - what is the
> base that you used?

rc1 + Palmer's fix branch

Thanks
> 
> Cheers,
> Conor.
> 
> > ---
> >  arch/riscv/kernel/vmlinux-xip.lds.S | 6 ------
> >  1 file changed, 6 deletions(-)
> > 
> > diff --git a/arch/riscv/kernel/vmlinux-xip.lds.S b/arch/riscv/kernel/vmlinux-xip.lds.S
> > index eab9edc3b631..50767647fbc6 100644
> > --- a/arch/riscv/kernel/vmlinux-xip.lds.S
> > +++ b/arch/riscv/kernel/vmlinux-xip.lds.S
> > @@ -98,12 +98,6 @@ SECTIONS
> >  		__soc_builtin_dtb_table_end = .;
> >  	}
> >  
> > -	. = ALIGN(8);
> > -	.alternative : {
> > -		__alt_start = .;
> > -		*(.alternative)
> > -		__alt_end = .;
> > -	}
> >  	__init_end = .;
> >  
> >  	. = ALIGN(16);
> > -- 
> > 2.40.1
> > 


