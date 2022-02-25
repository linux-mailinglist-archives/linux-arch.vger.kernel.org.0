Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CA34C46F0
	for <lists+linux-arch@lfdr.de>; Fri, 25 Feb 2022 14:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiBYNyc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Feb 2022 08:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238218AbiBYNyc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 25 Feb 2022 08:54:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38D41C2D97
        for <linux-arch@vger.kernel.org>; Fri, 25 Feb 2022 05:53:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8DAB2B831D3
        for <linux-arch@vger.kernel.org>; Fri, 25 Feb 2022 13:53:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72485C340F1;
        Fri, 25 Feb 2022 13:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645797237;
        bh=ye5CqF5m/giHWTTPMc2ZX0zR1vx3XB7Lg4x9Qgp6q64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aYtsX5FO7PLQiXuu8zjZrTygRX5vXQYNEParE8Jy5NBxXfzCYozM05g2wvmzRbGyo
         PYSx/MaD4VOF4Hcd/WqGblwDoPxeaDJrSSJJC4GZ0WLR71Zp5mpWpF+KgZIPawPOJh
         HNQqZGso9WFvyMgml6qbxcYFMF49UL5alouhMldGBTej563/kk5/3EAwdXnUpI5X8X
         NRXaMI/HJMlb9QW5rA2s262VEVdZNJAIjTXODdDPSPjxvIv3dJf14FU1sGhMpqdgOw
         OWCtKOplKzWa/uDUql042UqjotUVqUo48GZzFQ6G1sdsG8RMxZzX3UFOAUNlJEY1U/
         6qwjcDKcNDStw==
Date:   Fri, 25 Feb 2022 13:53:51 +0000
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org
Subject: Re: [PATCH v8 0/4] arm64: Enable BTI for the executable as well as
 the interpreter
Message-ID: <20220225135350.GA19698@willie-the-truck>
References: <20220124150704.2559523-1-broonie@kernel.org>
 <20220215183456.GB9026@willie-the-truck>
 <Ygz9YX3jBY0MpepU@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ygz9YX3jBY0MpepU@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 16, 2022 at 01:34:25PM +0000, Catalin Marinas wrote:
> On Tue, Feb 15, 2022 at 06:34:56PM +0000, Will Deacon wrote:
> > On Mon, Jan 24, 2022 at 03:07:00PM +0000, Mark Brown wrote:
> > > Deployments of BTI on arm64 have run into issues interacting with
> > > systemd's MemoryDenyWriteExecute feature.  Currently for dynamically
> > > linked executables the kernel will only handle architecture specific
> > > properties like BTI for the interpreter, the expectation is that the
> > > interpreter will then handle any properties on the main executable.
> > > For BTI this means remapping the executable segments PROT_EXEC |
> > > PROT_BTI.
> > > 
> > > This interacts poorly with MemoryDenyWriteExecute since that is
> > > implemented using a seccomp filter which prevents setting PROT_EXEC on
> > > already mapped memory and lacks the context to be able to detect that
> > > memory is already mapped with PROT_EXEC.  This series resolves this by
> > > handling the BTI property for both the interpreter and the main
> > > executable.
> > 
> > This appears to be a user-visible change which cannot be detected or
> > disabled from userspace. If there is code out there which does not work
> > when BTI is enabled, won't that now explode when the kernel enables it?
> > How are we supposed to handle such a regression?
> 
> If this ever happens, the only workaround is to disable BTI on the
> kernel command line. If we need a knob closer to user, we could add a
> sysctl option (as we did for the tagged address ABI, though I doubt
> people are even aware that exists). The dynamic loader doesn't do
> anything smart when deciding to map objects with PROT_BTI (like env
> variables), it simply relies on the ELF information.
> 
> I think that's very unlikely and feedback from Szabolcs in the past and
> additional testing by Mark and Jeremy was that it should be fine. The
> architecture allows interworking between BTI and non-BTI objects and on
> distros with both BTI and MDWE enabled, this is already the case: the
> main executable is mapped without PROT_BTI while the libraries will be
> mapped with PROT_BTI. The new behaviour allows both to be mapped with
> PROT_BTI, just as if MDWE was disabled.
> 
> I think the only difference would be with a BTI-unware dynamic loader
> (e.g. older distro). Here the main executable, if compiled with BTI,
> would be mapped as executable while the rest of the libraries are
> non-BTI. The interworking should be fine but we can't test everything
> since such BTI binaries would not normally be part of the distro.
> 
> If there are dodgy libraries out there that do tricks and branch into
> the middle of a function in the main executable, they will fail with
> this series but also fail if MDWE is disabled and the dynamic linker is
> BTI-aware. So this hardly counts as a use-case.
> 
> For consistency, I think whoever does the initial mapping should also
> set the correct attributes as we do for static binaries. If you think
> another knob is needed other than the cmdline, I'm fine with it.

I still think this new behaviour should be opt-in, so adding a sysctl for
that would be my preference if we proceed with this approach.

Will
