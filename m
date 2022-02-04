Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D9C4A9B81
	for <lists+linux-arch@lfdr.de>; Fri,  4 Feb 2022 15:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239362AbiBDOyD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Feb 2022 09:54:03 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48738 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiBDOyD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Feb 2022 09:54:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 298C8B837BA
        for <linux-arch@vger.kernel.org>; Fri,  4 Feb 2022 14:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED5AC004E1;
        Fri,  4 Feb 2022 14:53:58 +0000 (UTC)
Date:   Fri, 4 Feb 2022 14:53:55 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org, Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v8 3/4] elf: Remove has_interp property from
 arch_adjust_elf_prot()
Message-ID: <Yf0+A805DZdD3gwy@arm.com>
References: <20220124150704.2559523-1-broonie@kernel.org>
 <20220124150704.2559523-4-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124150704.2559523-4-broonie@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 24, 2022 at 03:07:03PM +0000, Mark Brown wrote:
> Since we have added an is_interp flag to arch_parse_elf_property() we can
> drop the has_interp flag from arch_elf_adjust_prot(), the only user was
> the arm64 code which no longer needs it and any future users will be able
> to use arch_parse_elf_properties() to determine if an interpreter is in
> use.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Tested-by: Jeremy Linton <jeremy.linton@arm.com>
> Reviewed-By: Dave Martin <Dave.Martin@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
