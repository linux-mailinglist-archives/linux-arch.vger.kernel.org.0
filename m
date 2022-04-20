Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42012508511
	for <lists+linux-arch@lfdr.de>; Wed, 20 Apr 2022 11:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377261AbiDTJjH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Apr 2022 05:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377260AbiDTJjG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Apr 2022 05:39:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E101C108
        for <linux-arch@vger.kernel.org>; Wed, 20 Apr 2022 02:36:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B60AB81DD2
        for <linux-arch@vger.kernel.org>; Wed, 20 Apr 2022 09:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D94ACC385A0;
        Wed, 20 Apr 2022 09:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650447379;
        bh=k3qNwbkssMSTRHzehS5gucI/pQo3ZUjkEH/8VG1kxGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b3MmlZT90yvA5z5d/PS34SbXjByTp+cN+TJE4GtUvpogp5O/scziyTH+CHb5j9YQb
         wgpgwNgG3aHKCZbBWzBOgDikUFqAh4RMg4oPNOcnoaVTVn/jSBFoGkvDi2oBzApZ3f
         A5uY+WLtDeuj6WwBysJh1C0ROllEPPKcyhw/oZ8s1JVuHXNCMUshRHbiXXZ+pGC2x4
         t85WVh7/Rf8ltqrTySLhGjcRn7nOoICW+yjYnGRSTkgzVmb0m5QJp+kRWs/7Rfll2P
         6DSOEda8L3tfHOUOLviq9YFbZrnfax12O+IJcDo893O4qZmsO+p9Na5QteIADdl6g8
         vcWOnpprGLa6g==
Date:   Wed, 20 Apr 2022 10:36:13 +0100
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     broonie@kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, jeremy.linton@arm.com,
        hjl.tools@gmail.com, libc-alpha@sourceware.org,
        szabolcs.nagy@arm.com, yu-cheng.yu@intel.com,
        ebiederm@xmission.com, linux-arch@vger.kernel.org
Subject: Re: [PATCH v13 0/2] arm64: Enable BTI for the executable as well as
 the interpreter
Message-ID: <20220420093612.GB6954@willie-the-truck>
References: <20220419105156.347168-1-broonie@kernel.org>
 <165043278356.1481705.13924459838445776007.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165043278356.1481705.13924459838445776007.b4-ty@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 19, 2022 at 10:33:06PM -0700, Kees Cook wrote:
> On Tue, 19 Apr 2022 11:51:54 +0100, Mark Brown wrote:
> > Deployments of BTI on arm64 have run into issues interacting with
> > systemd's MemoryDenyWriteExecute feature.  Currently for dynamically
> > linked executables the kernel will only handle architecture specific
> > properties like BTI for the interpreter, the expectation is that the
> > interpreter will then handle any properties on the main executable.
> > For BTI this means remapping the executable segments PROT_EXEC |
> > PROT_BTI.
> > 
> > [...]
> 
> Applied to for-next/execve, thanks!
> 
> [1/2] elf: Allow architectures to parse properties on the main executable
>       https://git.kernel.org/kees/c/b2f2553c8e89
> [2/2] arm64: Enable BTI for main executable as well as the interpreter
>       https://git.kernel.org/kees/c/b65c760600e2

Kees, please can you drop this series while Catalin's alternative solution
is under discussion (his Reviewed-by preceded the other patches)?

https://lore.kernel.org/r/20220413134946.2732468-1-catalin.marinas@arm.com

Both series expose new behaviours to userspace and we don't need both.

Thanks,

Will
