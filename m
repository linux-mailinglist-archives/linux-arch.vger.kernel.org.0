Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C657364567E
	for <lists+linux-arch@lfdr.de>; Wed,  7 Dec 2022 10:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiLGJc3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Dec 2022 04:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiLGJc2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Dec 2022 04:32:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8533F29CA9;
        Wed,  7 Dec 2022 01:32:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D4BCB81B99;
        Wed,  7 Dec 2022 09:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CB5C433C1;
        Wed,  7 Dec 2022 09:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670405544;
        bh=C2Qa7eO4zQqZVnZMMcDQ10lrJR5JlYJLYE/HH767lRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lo6cuRBNx512Shd/pKt+RH5NrQdFx5FbLrfNf9ugYuUB7uy85iueP+9LeSiuAxtvH
         5Izxj51Ja/X8TYy5vY/N6DkIYq0cl3RIr9ZFB6RrNSf0KmVM+WtaE3C2xCrZ5LdpVy
         K9cYsYh8WcJqUEDocjfqf6eVEsmMqtY4Kw899xC3lCJpUBXEcoPztQwgdO1jpvhgi/
         eJF5YpSMenAX0XKPOBfARDockhuE1KiefAOMqwdimRmjHFRpRe4DBdq+dhD87wsmp9
         +QmXX6uOCGzRsaRdSyya1lzifeBHA8oHO/bArUbrY+Z5LCtLjsrldupGlaahY2vbGf
         oHLLHTiP8g9yw==
Date:   Wed, 7 Dec 2022 09:32:20 +0000
From:   Conor Dooley <conor@kernel.org>
To:     guoren@kernel.org
Cc:     palmer@rivosinc.com, conor.dooley@microchip.com,
        liaochang1@huawei.com, lizhengyu3@huawei.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] riscv: Fixup compile error with !MMU
Message-ID: <Y5BdpHrKrRCw9izQ@spud>
References: <20221207091112.2258674-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1Kg3KXAqPRPhThI7"
Content-Disposition: inline
In-Reply-To: <20221207091112.2258674-1-guoren@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--1Kg3KXAqPRPhThI7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2022 at 04:11:12AM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>=20
> Current nommu_virt_defconfig can't compile:
>=20
> In file included from
> arch/riscv/kernel/crash_core.c:3:
> arch/riscv/kernel/crash_core.c:
> In function 'arch_crash_save_vmcoreinfo':
> arch/riscv/kernel/crash_core.c:8:27:
> error: 'VA_BITS' undeclared (first use in this function)
>     8 |         VMCOREINFO_NUMBER(VA_BITS);
>       |                           ^~~~~~~
>=20
> Add MMU dependency for KEXEC_FILE.
>=20
> Fixes: 6261586e0c91 ("RISC-V: Add kexec_file support")
> Reported-by: Conor Dooley <conor@kernel.org>

FWIW (but certainly don't resend for this)
s/conor@kernel.org/conor.dooley@microchip.com

Thanks for the quick fix, there's other issues w/ that config for me,
but this fixed the kexec bits :)
Tested-by: Conor Dooley <conor.dooley@microchip.com>

> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> ---
>  arch/riscv/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index ef8d66de5f38..91319044fd13 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -496,7 +496,7 @@ config KEXEC_FILE
>  	select KEXEC_CORE
>  	select KEXEC_ELF
>  	select HAVE_IMA_KEXEC if IMA
> -	depends on 64BIT
> +	depends on 64BIT && MMU
>  	help
>  	  This is new version of kexec system call. This system call is
>  	  file based and takes file descriptors as system call argument
> --=20
> 2.36.1
>=20

--1Kg3KXAqPRPhThI7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY5BdpAAKCRB4tDGHoIJi
0su2AP9L8GJrDHopTVfnWYXYEFOLjQEaJZfNXA0Xoy5+iOgxEAEAgOSw/WcDDknk
9s5gANOjt2ba7ciDE2ephouE16QLBA8=
=hTdX
-----END PGP SIGNATURE-----

--1Kg3KXAqPRPhThI7--
