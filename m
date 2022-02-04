Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3A44A9995
	for <lists+linux-arch@lfdr.de>; Fri,  4 Feb 2022 14:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242418AbiBDNAM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Feb 2022 08:00:12 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:49462 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240522AbiBDNAM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Feb 2022 08:00:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2CFC5CE22C7
        for <linux-arch@vger.kernel.org>; Fri,  4 Feb 2022 13:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A3DC340E9;
        Fri,  4 Feb 2022 13:00:07 +0000 (UTC)
Date:   Fri, 4 Feb 2022 13:00:04 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org, Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v8 1/4] elf: Allow architectures to parse properties on
 the main executable
Message-ID: <Yf0jVHDJJzpmfHfz@arm.com>
References: <20220124150704.2559523-1-broonie@kernel.org>
 <20220124150704.2559523-2-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124150704.2559523-2-broonie@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 24, 2022 at 03:07:01PM +0000, Mark Brown wrote:
> Currently the ELF code only attempts to parse properties on the image
> that will start execution, either the interpreter or for statically linked
> executables the main executable. The expectation is that any property
> handling for the main executable will be done by the interpreter. This is
> a bit inconsistent since we do map the executable and is causing problems
> for the arm64 BTI support when used in conjunction with systemd's use of
> seccomp to implement MemoryDenyWriteExecute which stops the dynamic linker
> adjusting the permissions of executable segments.
> 
> Allow architectures to handle properties for both the dynamic linker and
> main executable, adjusting arch_parse_elf_properties() to have a new
> flag is_interp flag as with arch_elf_adjust_prot() and calling it for
> both the main executable and any intepreter.
> 
> The user of this code, arm64, is adapted to ensure that there is no
> functional change.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Tested-by: Jeremy Linton <jeremy.linton@arm.com>
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
