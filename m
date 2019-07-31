Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDC17C9F7
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2019 19:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbfGaRJc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Jul 2019 13:09:32 -0400
Received: from foss.arm.com ([217.140.110.172]:52086 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727327AbfGaRJc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 31 Jul 2019 13:09:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CD78337;
        Wed, 31 Jul 2019 10:09:31 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B75903F71F;
        Wed, 31 Jul 2019 10:09:29 -0700 (PDT)
Date:   Wed, 31 Jul 2019 18:09:27 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, salyzyn@android.com, pcc@google.com,
        0x7f454c46@gmail.com, linux@rasmusvillemoes.dk,
        sthotton@marvell.com, andre.przywara@arm.com, luto@kernel.org,
        Matteo Croce <mcroce@redhat.com>
Subject: Re: [PATCH] arm64: vdso: Fix Makefile regression
Message-ID: <20190731170927.GD17773@arrakis.emea.arm.com>
References: <CAGnkfhyT=2kPsiUy-V=aCA_s-C4BXgD++hAZ9ii1h0p94mMVQA@mail.gmail.com>
 <20190729125421.32482-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729125421.32482-1-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 29, 2019 at 01:54:21PM +0100, Vincenzo Frascino wrote:
> Using an old .config in combination with "make oldconfig" can cause
> an incorrect detection of the compat compiler:
> 
> $ grep CROSS_COMPILE_COMPAT .config
> CONFIG_CROSS_COMPILE_COMPAT_VDSO=""
> 
> $ make oldconfig && make
> arch/arm64/Makefile:58: gcc not found, check CROSS_COMPILE_COMPAT.
> Stop.
> 
> Accordingly to the section 7.2 of the GNU Make manual "Syntax of
> Conditionals", "When the value results from complex expansions of
> variables and functions, expansions you would consider empty may
> actually contain whitespace characters and thus are not seen as
> empty. However, you can use the strip function to avoid interpreting
> whitespace as a non-empty value."
> 
> Fix the issue adding strip to the CROSS_COMPILE_COMPAT string
> evaluation.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Reported-by: Matteo Croce <mcroce@redhat.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Queued for 5.3-rc3. Thanks.

-- 
Catalin
