Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38A106FC60
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jul 2019 11:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfGVJls (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Jul 2019 05:41:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728265AbfGVJls (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Jul 2019 05:41:48 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 557A1218EA;
        Mon, 22 Jul 2019 09:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563788507;
        bh=jauXQmrxA9a72OrrDn+WjHiK7lIIU0c1xKoYSvyMSrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i9S0FprbkqfyWctXsZA1Cd2EZn1UqTyHuNPYd3xevoBzGz2iC/9Q8PkX3qUESdT6E
         akdBvvhER/yP1ZuvfuQyoQuZmvqG0ZjLipX41kySe+h0cGT3Yz6YONppDnqmfjyJuo
         IpL3qZTrZTilrO9HikY/dNScwqWR7VfIhsD9emg4=
Date:   Mon, 22 Jul 2019 10:41:41 +0100
From:   Will Deacon <will@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, arnd@arndb.de, linux@armlinux.org.uk,
        daniel.lezcano@linaro.org, tglx@linutronix.de, salyzyn@android.com,
        pcc@google.com, 0x7f454c46@gmail.com, linux@rasmusvillemoes.dk,
        huw@codeweavers.com, sthotton@marvell.com, andre.przywara@arm.com,
        luto@kernel.org, john.stultz@linaro.org, naohiro.aota@wdc.com,
        yamada.masahiro@socionext.com
Subject: Re: [PATCH v2] arm64: vdso: Cleanup Makefiles
Message-ID: <20190722094140.giv5vivoqm4bzl5t@willie-the-truck>
References: <20190712153746.5dwwptgrle3z25m7@willie-the-truck>
 <20190719101018.1984-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719101018.1984-1-vincenzo.frascino@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 19, 2019 at 11:10:18AM +0100, Vincenzo Frascino wrote:
> The recent changes to the vdso library for arm64 and the introduction of
> the compat vdso library have generated some misalignment in the
> Makefiles.
> 
> Cleanup the Makefiles for vdso and vdso32 libraries:
>   * Removing unused rules.
>   * Unifying the displayed compilation messages.
>   * Simplifying the generic library inclusion path for
>     arm64 vdso.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/kernel/vdso/Makefile   |  9 +++------
>  arch/arm64/kernel/vdso32/Makefile | 10 +++++-----
>  2 files changed, 8 insertions(+), 11 deletions(-)

Thanks, I'll queue this for -rc2.

Will
