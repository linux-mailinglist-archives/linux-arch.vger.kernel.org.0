Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A448484702
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jan 2022 18:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbiADRcM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 12:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbiADRcL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jan 2022 12:32:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F010C061761
        for <linux-arch@vger.kernel.org>; Tue,  4 Jan 2022 09:32:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA3ADB8179D
        for <linux-arch@vger.kernel.org>; Tue,  4 Jan 2022 17:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C74DC36AED;
        Tue,  4 Jan 2022 17:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641317528;
        bh=gjFCmCrJQ2CTxnlBj9d+/IXJ4kX3i37amdZZsM9VzvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z7Gv/xIGzdrnLBB5hYNQ3eAWdZNCxsBzUaVwB2DdBLV0EP92xL4ZA1kiSUksQ/7B5
         B9OhB+mU0+UHgu2oYmShewJaevprEzXkSfZk8bU/aBO02u8GTjmstYNvbQc2HWl4rG
         HTD3K4YvFY2IkROrrmo6Jfpswx5c9jXK5aVZktAY0UwaYayY3JAo4F5eRNyXuAzbim
         s2I5Ale/k0E47ROckTLaXp3AyW9+uC/ecRNQJ42cOnapvFpsJM00rmAkRCLdsKpzEH
         Z3EVp+zCMdusxGvGZ/vfq5t8qokiD5BWfZm7sfmeA/b+yKkZOPUs0T8x9do6HvsFAa
         +YiRRcOCCFz4Q==
Date:   Tue, 4 Jan 2022 17:32:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v7 0/4] arm64: Enable BTI for the executable as well as
 the interpreter
Message-ID: <YdSEkt72V1oeVx5E@sirena.org.uk>
References: <20211115152714.3205552-1-broonie@kernel.org>
 <YbD4LKiaxG2R0XxN@arm.com>
 <20211209111048.GM3294453@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nI5cG/Ch8LIoYrmt"
Content-Disposition: inline
In-Reply-To: <20211209111048.GM3294453@arm.com>
X-Cookie: The horror... the horror!
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--nI5cG/Ch8LIoYrmt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 09, 2021 at 11:10:48AM +0000, Szabolcs Nagy wrote:
> The 12/08/2021 18:23, Catalin Marinas wrote:
> > On Mon, Nov 15, 2021 at 03:27:10PM +0000, Mark Brown wrote:

> > > memory is already mapped with PROT_EXEC.  This series resolves this by
> > > handling the BTI property for both the interpreter and the main
> > > executable.

> > Given the silence on this series over the past months, I propose we drop
> > it. It's a bit unfortunate that systemd's MemoryDenyWriteExecute cannot
> > work with BTI but I also think the former is a pretty blunt hardening
> > mechanism (rejecting any mprotect(PROT_EXEC) regardless of the previous
> > attributes).

> i still think it would be better if the kernel dealt with
> PROT_BTI for the exe loaded by the kernel.

The above message from Catalin isn't quite the full story here - my
understanding from backchannel is that there's concern from others that
we might be creating future issues by enabling PROT_BTI, especially in
the case where the same permissions issue prevents the dynamic linker
disabling PROT_BTI.  They'd therefore rather stick with the status quo
and not create any new ABI.  Unfortunately that's not something people
have been willing to say on the list, hopefully the above captures the
thinking well enough.

Personally I'm a bit ambivalent on this, I do see the potential issue
but I'm having trouble constructing an actual scenario and my instinct
is that since we handle PROT_EXEC we should also handle PROT_BTI for
consistency.

--nI5cG/Ch8LIoYrmt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHUhJIACgkQJNaLcl1U
h9Bqagf/eibaFSuGH07fGReZ72Hm2cZ/rQmgFzdC3g/atP19TbZr84YcP/vQPp4L
paQOqxeeRSeGvOCuo/ZCvUP/RxB7xFUNucfQW8LBalMm5oMBMNNaa4sxyYSf6K1m
bYNoYazImQ5jsCsaNzMdzg7wqfJ/v0oKPLg38JEACRyE3v6yQLBx7VVb3dWPxcTS
9dauSc/sUS4oPC361aBMK7aNTWan/7n9TiUqIcb4lSJcAvThYHDUuXIMK6+LSQoA
RLNIcxa5mi6q1OuMRkwxwkmVhv+tK1ERdQhdbOVeKn/FcHfc84LClIBWNt/Y7XmU
3yHKvPafAancN9yBxQLqQ9xL3LT6mw==
=Gt2s
-----END PGP SIGNATURE-----

--nI5cG/Ch8LIoYrmt--
