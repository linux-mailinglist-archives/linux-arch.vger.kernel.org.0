Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C4A4B8A34
	for <lists+linux-arch@lfdr.de>; Wed, 16 Feb 2022 14:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbiBPNeo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Feb 2022 08:34:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiBPNen (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Feb 2022 08:34:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6633F2AB512
        for <linux-arch@vger.kernel.org>; Wed, 16 Feb 2022 05:34:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07DC961731
        for <linux-arch@vger.kernel.org>; Wed, 16 Feb 2022 13:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D8FC340EC;
        Wed, 16 Feb 2022 13:34:28 +0000 (UTC)
Date:   Wed, 16 Feb 2022 13:34:25 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org
Subject: Re: [PATCH v8 0/4] arm64: Enable BTI for the executable as well as
 the interpreter
Message-ID: <Ygz9YX3jBY0MpepU@arm.com>
References: <20220124150704.2559523-1-broonie@kernel.org>
 <20220215183456.GB9026@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215183456.GB9026@willie-the-truck>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 15, 2022 at 06:34:56PM +0000, Will Deacon wrote:
> On Mon, Jan 24, 2022 at 03:07:00PM +0000, Mark Brown wrote:
> > Deployments of BTI on arm64 have run into issues interacting with
> > systemd's MemoryDenyWriteExecute feature.  Currently for dynamically
> > linked executables the kernel will only handle architecture specific
> > properties like BTI for the interpreter, the expectation is that the
> > interpreter will then handle any properties on the main executable.
> > For BTI this means remapping the executable segments PROT_EXEC |
> > PROT_BTI.
> > 
> > This interacts poorly with MemoryDenyWriteExecute since that is
> > implemented using a seccomp filter which prevents setting PROT_EXEC on
> > already mapped memory and lacks the context to be able to detect that
> > memory is already mapped with PROT_EXEC.  This series resolves this by
> > handling the BTI property for both the interpreter and the main
> > executable.
> 
> This appears to be a user-visible change which cannot be detected or
> disabled from userspace. If there is code out there which does not work
> when BTI is enabled, won't that now explode when the kernel enables it?
> How are we supposed to handle such a regression?

If this ever happens, the only workaround is to disable BTI on the
kernel command line. If we need a knob closer to user, we could add a
sysctl option (as we did for the tagged address ABI, though I doubt
people are even aware that exists). The dynamic loader doesn't do
anything smart when deciding to map objects with PROT_BTI (like env
variables), it simply relies on the ELF information.

I think that's very unlikely and feedback from Szabolcs in the past and
additional testing by Mark and Jeremy was that it should be fine. The
architecture allows interworking between BTI and non-BTI objects and on
distros with both BTI and MDWE enabled, this is already the case: the
main executable is mapped without PROT_BTI while the libraries will be
mapped with PROT_BTI. The new behaviour allows both to be mapped with
PROT_BTI, just as if MDWE was disabled.

I think the only difference would be with a BTI-unware dynamic loader
(e.g. older distro). Here the main executable, if compiled with BTI,
would be mapped as executable while the rest of the libraries are
non-BTI. The interworking should be fine but we can't test everything
since such BTI binaries would not normally be part of the distro.

If there are dodgy libraries out there that do tricks and branch into
the middle of a function in the main executable, they will fail with
this series but also fail if MDWE is disabled and the dynamic linker is
BTI-aware. So this hardly counts as a use-case.

For consistency, I think whoever does the initial mapping should also
set the correct attributes as we do for static binaries. If you think
another knob is needed other than the cmdline, I'm fine with it.

-- 
Catalin
