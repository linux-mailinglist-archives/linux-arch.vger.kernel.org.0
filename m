Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF0F490FF3
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jan 2022 18:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238034AbiAQRyU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Jan 2022 12:54:20 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58136 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbiAQRyU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Jan 2022 12:54:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F048060F78
        for <linux-arch@vger.kernel.org>; Mon, 17 Jan 2022 17:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977F8C36AE7;
        Mon, 17 Jan 2022 17:54:17 +0000 (UTC)
Date:   Mon, 17 Jan 2022 17:54:14 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Will Deacon <will@kernel.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v7 0/4] arm64: Enable BTI for the executable as well as
 the interpreter
Message-ID: <YeWtRk0H30q38eM8@arm.com>
References: <20211115152714.3205552-1-broonie@kernel.org>
 <YbD4LKiaxG2R0XxN@arm.com>
 <20211209111048.GM3294453@arm.com>
 <YdSEkt72V1oeVx5E@sirena.org.uk>
 <101d8e84-7429-bbf1-0271-5436eca0eea2@arm.com>
 <YdbL5kIzi0xqVTVd@arm.com>
 <8550afd2-268d-a25f-88fd-0dd0b184ca23@arm.com>
 <YdcxUZ06f60UQMKM@arm.com>
 <Ydc+AuagOD9GSooP@sirena.org.uk>
 <YdgrjWVxRGRtnf5b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdgrjWVxRGRtnf5b@arm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 07, 2022 at 12:01:17PM +0000, Catalin Marinas wrote:
> I think we can look at this from two angles:
> 
> 1. Ignoring MDWE, should whoever does the original mmap() also honour
>    PROT_BTI? We do this for static binaries but, for consistency, should
>    we extend it to dynamic executable?
> 
> 2. A 'simple' fix to allow MDWE together with BTI.

Thinking about it, (1) is not that different from the kernel setting
PROT_EXEC on the main executable when the dynamic loader could've done
it as well. There is a case for making this more consistent: whoever
does the mmap() should use the full attributes.

Question for the toolchain people: would the compiler ever generate
relocations in the main executable that the linker needs to resolve via
an mprotect(READ|WRITE) followed by mprotect(READ|EXEC)? If yes, we'd
better go for a proper MDWE implementation in the kernel.

-- 
Catalin
