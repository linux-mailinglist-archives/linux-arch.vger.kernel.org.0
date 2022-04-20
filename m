Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB09950854B
	for <lists+linux-arch@lfdr.de>; Wed, 20 Apr 2022 11:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355138AbiDTKAc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Apr 2022 06:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377415AbiDTKA2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Apr 2022 06:00:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042F83ED33
        for <linux-arch@vger.kernel.org>; Wed, 20 Apr 2022 02:57:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 700FA616C4
        for <linux-arch@vger.kernel.org>; Wed, 20 Apr 2022 09:57:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A935C385A1;
        Wed, 20 Apr 2022 09:57:34 +0000 (UTC)
Date:   Wed, 20 Apr 2022 10:57:30 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, jeremy.linton@arm.com,
        hjl.tools@gmail.com, libc-alpha@sourceware.org,
        szabolcs.nagy@arm.com, yu-cheng.yu@intel.com,
        ebiederm@xmission.com, linux-arch@vger.kernel.org
Subject: Re: [PATCH v13 0/2] arm64: Enable BTI for the executable as well as
 the interpreter
Message-ID: <Yl/ZCvPB2Qx98+OG@arm.com>
References: <20220419105156.347168-1-broonie@kernel.org>
 <165043278356.1481705.13924459838445776007.b4-ty@chromium.org>
 <20220420093612.GB6954@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420093612.GB6954@willie-the-truck>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 20, 2022 at 10:36:13AM +0100, Will Deacon wrote:
> On Tue, Apr 19, 2022 at 10:33:06PM -0700, Kees Cook wrote:
> > On Tue, 19 Apr 2022 11:51:54 +0100, Mark Brown wrote:
> > > Deployments of BTI on arm64 have run into issues interacting with
> > > systemd's MemoryDenyWriteExecute feature.  Currently for dynamically
> > > linked executables the kernel will only handle architecture specific
> > > properties like BTI for the interpreter, the expectation is that the
> > > interpreter will then handle any properties on the main executable.
> > > For BTI this means remapping the executable segments PROT_EXEC |
> > > PROT_BTI.
> > > 
> > > [...]
> > 
> > Applied to for-next/execve, thanks!
> > 
> > [1/2] elf: Allow architectures to parse properties on the main executable
> >       https://git.kernel.org/kees/c/b2f2553c8e89
> > [2/2] arm64: Enable BTI for main executable as well as the interpreter
> >       https://git.kernel.org/kees/c/b65c760600e2
> 
> Kees, please can you drop this series while Catalin's alternative solution
> is under discussion (his Reviewed-by preceded the other patches)?
> 
> https://lore.kernel.org/r/20220413134946.2732468-1-catalin.marinas@arm.com
> 
> Both series expose new behaviours to userspace and we don't need both.

I agree. Even though the patches have my reviewed-by, I think we should
postpone them until we figure out a better W^X solution that does not
affect BTI (and if we can't, we revisit these patches).

Arguably, the two approaches are complementary but the way this series
turned out is for the BTI on main executable to be default off. I have a
worry that the feature won't get used, so we just carry unnecessary code
in the kernel. Jeremy also found this approach less than ideal:

https://lore.kernel.org/r/59fc8a58-5013-606b-f544-8277cda18e50@arm.com

-- 
Catalin
