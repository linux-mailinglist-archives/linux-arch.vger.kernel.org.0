Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB844A99BE
	for <lists+linux-arch@lfdr.de>; Fri,  4 Feb 2022 14:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350006AbiBDNMB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Feb 2022 08:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349939AbiBDNMA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Feb 2022 08:12:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B54BC061714
        for <linux-arch@vger.kernel.org>; Fri,  4 Feb 2022 05:12:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDD1FB83738
        for <linux-arch@vger.kernel.org>; Fri,  4 Feb 2022 13:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE56C004E1;
        Fri,  4 Feb 2022 13:11:55 +0000 (UTC)
Date:   Fri, 4 Feb 2022 13:11:52 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org, Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v8 2/4] arm64: Enable BTI for main executable as well as
 the interpreter
Message-ID: <Yf0mGI8ucW6gKXMo@arm.com>
References: <20220124150704.2559523-1-broonie@kernel.org>
 <20220124150704.2559523-3-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124150704.2559523-3-broonie@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 24, 2022 at 03:07:02PM +0000, Mark Brown wrote:
> Currently for dynamically linked ELF executables we only enable BTI for
> the interpreter, expecting the interpreter to do this for the main
> executable. This is a bit inconsistent since we do map main executable and
> is causing issues with systemd's MemoryDenyWriteExecute feature which is
> implemented using a seccomp filter which prevents setting PROT_EXEC on
> already mapped memory and lacks the context to be able to detect that
> memory is already mapped with PROT_EXEC.
> 
> Resolve this by checking the BTI property for the main executable and
> enabling BTI if it is present when doing the initial mapping. This does
> mean that we may get more code with BTI enabled if running on a system
> without BTI support in the dynamic linker, this is expected to be a safe
> configuration and testing seems to confirm that.

Alternatively we could only enable BTI on the main executable if the
interpreter is also compiled with the BTI attributes. But it still feels
a bit inconsistent as a BTI-capable interpreter doesn't necessarily mean
it had to be compiled with BTI support.

> It also reduces the
> flexibility userspace has to disable BTI but it is expected that for cases
> where there are problems which require BTI to be disabled it is more likely
> that it will need to be disabled on a system level.

That's my expectation as well. I'm not aware of any plans to make a
dynamic loader choose BTI based on some environment variable (not sure
about Android zygote, I haven't heard anything either).

> Signed-off-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> Tested-by: Jeremy Linton <jeremy.linton@arm.com>

For this patch:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
