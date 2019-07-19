Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB3D46E235
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2019 10:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfGSIEo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Jul 2019 04:04:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfGSIEo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Jul 2019 04:04:44 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92CAD20665;
        Fri, 19 Jul 2019 08:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563523483;
        bh=R9hD24Tj+KSZAJ28RSPSUwPQVIMBYE4b6HdUPoO5ENo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m8MOrcHmD7GUTE+3OqkFDbOKMNS9fnRrLxrB7nLIQkjljVojmxNAdqsPbJ5fOThya
         mPOeyalN6YXDdpXe7XSJL5yRtQx9zsxHlRo+8r62FsFHDCIkp4aqDtw/7yKEWCTs6c
         YBeOG8iYEDoFccPxedp3h0UP/Fk3hxTZWN2j6Yu8=
Date:   Fri, 19 Jul 2019 09:04:36 +0100
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
Subject: Re: [PATCH] arm64: vdso: Cleanup Makefiles.
Message-ID: <20190719080435.f3nlecyu3ysnsnpv@willie-the-truck>
References: <20190712153746.5dwwptgrle3z25m7@willie-the-truck>
 <20190718114121.33024-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718114121.33024-1-vincenzo.frascino@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 18, 2019 at 12:41:21PM +0100, Vincenzo Frascino wrote:
> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
> index 21009ed5a755..6c4e496309c4 100644
> --- a/arch/arm64/kernel/vdso32/Makefile
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -155,17 +155,17 @@ $(asm-obj-vdso): %.o: %.S FORCE
>  	$(call if_changed_dep,vdsoas)
>  
>  # Actual build commands
> -quiet_cmd_vdsold_and_vdso_check = LD      $@
> +quiet_cmd_vdsold_and_vdso_check = VDSOLIB $@
>        cmd_vdsold_and_vdso_check = $(cmd_vdsold); $(cmd_vdso_check)
>  
> -quiet_cmd_vdsold = VDSOL   $@
> +quiet_cmd_vdsold = VDSOLD  $@

I think we should be more consistent about whether or not we prefix things
with VDSO, so either go with "VDSOLD, VDSOCC and VDSOAS" or stick to "LD,
CC and AS" rather than mixing between them.

I think my suggestion would be something along the lines of CC, LD, AS for
the native vdso and CC32, LD32, AS32 for the compat vdso.

Will
