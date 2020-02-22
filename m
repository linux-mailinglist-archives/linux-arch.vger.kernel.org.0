Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A72E168E49
	for <lists+linux-arch@lfdr.de>; Sat, 22 Feb 2020 11:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgBVKkJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 22 Feb 2020 05:40:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:57030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbgBVKkJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 22 Feb 2020 05:40:09 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7B7D206E2;
        Sat, 22 Feb 2020 10:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582368009;
        bh=6Wmafw7bm+Sez1pspQxTJG8ckuulq3Dz0SOXvtDrc8A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hJ8vBz5YImwnzyR06r0PXFCCN11xWNCuBXVBewnggMEXfopP9vYh1WEsVMg+gPhTA
         Pta7BW5qW7O0b8swPoD0AcoUJLoyU8UZTxeguzE+JF5jwVXQCY094k+ou6/5ZW+9d2
         wWxV4aYnWdNzE/lGr7ZsYz7aTDrMVRFADKpQVn80=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1j5SCc-007C3Z-NX; Sat, 22 Feb 2020 10:40:06 +0000
Date:   Sat, 22 Feb 2020 10:40:05 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux@armlinux.org.uk, tglx@linutronix.de,
        luto@kernel.org, m.szyprowski@samsung.com, Mark.Rutland@arm.com
Subject: Re: [PATCH v2 0/3] Fix arm_arch_timer clockmode when vDSO disabled
Message-ID: <20200222104005.6fc4019d@why>
In-Reply-To: <20200221181849.40351-1-vincenzo.frascino@arm.com>
References: <20200221181849.40351-1-vincenzo.frascino@arm.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: vincenzo.frascino@arm.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, linux@armlinux.org.uk, tglx@linutronix.de, luto@kernel.org, m.szyprowski@samsung.com, Mark.Rutland@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 21 Feb 2020 18:18:46 +0000
Vincenzo Frascino <vincenzo.frascino@arm.com> wrote:

> The arm_arch_timer requires that VDSO_CLOCKMODE_ARCHTIMER to be
> defined to compile correctly. On arm the vDSO can be disabled and when
> this is the case the compilation ends prematurely with an error:
>=20
>  $ make ARCH=3Darm multi_v7_defconfig
>  $ ./scripts/config -d VDSO
>  $ make
>=20
>  drivers/clocksource/arm_arch_timer.c:73:44: error:
>  =E2=80=98VDSO_CLOCKMODE_ARCHTIMER=E2=80=99 undeclared here (not in a fun=
ction)
>  static enum vdso_clock_mode vdso_default =3D VDSO_CLOCKMODE_ARCHTIMER;
>                                             ^
>  scripts/Makefile.build:267: recipe for target
>  'drivers/clocksource/arm_arch_timer.o' failed
>  make[2]: *** [drivers/clocksource/arm_arch_timer.o] Error 1
>  make[2]: *** Waiting for unfinished jobs....
>  scripts/Makefile.build:505: recipe for target 'drivers/clocksource' fail=
ed
>  make[1]: *** [drivers/clocksource] Error 2
>  make[1]: *** Waiting for unfinished jobs....
>  Makefile:1683: recipe for target 'drivers' failed
>  make: *** [drivers] Error 2
>=20
> This patch series addresses the issue defining a default arch clockmode
> for arm and arm64 and using it to initialize the arm_arch_timer.

arm only. arm64 is just fine.

>=20
> Changes:
> --------
> v2:
>   - Addressed Marc Zyngier comments.
>   - Rebased on 5.6-rc2.

This doesn't apply to -rc2, and is rather against next.

>=20
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mark Rutland <Mark.Rutland@arm.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>=20
> Vincenzo Frascino (3):
>   arm: clocksource: Add VDSO default clockmode
>   arm64: clocksource: Add VDSO default clockmode
>   clocksource: Fix arm_arch_timer clockmode when vDSO disabled

Please squash the three patches into a single one. There is zero point
in having 3 patches for something that small.

	M.
--=20
Jazz is not dead. It just smells funny...
