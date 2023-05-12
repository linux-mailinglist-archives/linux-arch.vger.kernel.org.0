Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1F070098B
	for <lists+linux-arch@lfdr.de>; Fri, 12 May 2023 15:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240690AbjELNyd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 May 2023 09:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241280AbjELNyb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2023 09:54:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0103D13857;
        Fri, 12 May 2023 06:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683899669; x=1715435669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fKA8Wz0olEp08ryiuI9Xy2pZsT93duPTdIQf+NSHyVM=;
  b=y04/M6z9+4THv84Xllfp2O4D7OWLq5Towz3qlfw1JnYR/fr393ch4F2c
   JZdNjp1VdHV+XrXKPDOmk9alRPOGyUwAowT7gpImeyTOhlXL7jrlGfYor
   ui6iEy85u4McB4MVBzzZYW23GiPSI9AIosqdUzvmvacZi5Ksu+DI/o0Yh
   4qA340R5Opi33biJd1fpEFjF3nohg+Qh0a9fkQNNMqlkj+9BK92OAqTVT
   hchn/9eJDJLjGcIPHEnFlONeUBDRuuoRptrtY2IeNI53jXYMcq/qMVI5K
   A7V3ifhZC5ty8N8FVdVfngXlhYrJjC1c5klfxHbYpy6umt4ZWVdN79WLy
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,269,1677567600"; 
   d="asc'?scan'208";a="210975834"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 May 2023 06:54:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 12 May 2023 06:54:25 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 12 May 2023 06:54:23 -0700
Date:   Fri, 12 May 2023 14:54:03 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jisheng Zhang <jszhang@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 2/4] riscv: move HAVE_RETHOOK to keep entries sorted
Message-ID: <20230512-humming-nebula-247ccd45674c@wendy>
References: <20230511141211.2418-1-jszhang@kernel.org>
 <20230511141211.2418-3-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qxL1yz6psSH+KTHa"
Content-Disposition: inline
In-Reply-To: <20230511141211.2418-3-jszhang@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--qxL1yz6psSH+KTHa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2023 at 10:12:09PM +0800, Jisheng Zhang wrote:
> Commit b57c2f124098 ("riscv: add riscv rethook implementation") selects
> the HAVE_RETHOOK option for the first time in riscv, but it breaks the
> entries order. Properly move its location to keep entries sorted.

The entries need a rework in general, but it's only really worth doing
the whole lot during the merge window to avoid a rake of conflicts.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 348c0fa1fc8c..f0663b52d052 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -110,7 +110,6 @@ config RISCV
>  	select HAVE_KPROBES if !XIP_KERNEL
>  	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
>  	select HAVE_KRETPROBES if !XIP_KERNEL
> -	select HAVE_RETHOOK if !XIP_KERNEL
>  	select HAVE_MOVE_PMD
>  	select HAVE_MOVE_PUD
>  	select HAVE_PCI
> @@ -119,6 +118,7 @@ config RISCV
>  	select HAVE_PERF_USER_STACK_DUMP
>  	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
>  	select HAVE_REGS_AND_STACK_ACCESS_API
> +	select HAVE_RETHOOK if !XIP_KERNEL
>  	select HAVE_RSEQ
>  	select HAVE_STACKPROTECTOR
>  	select HAVE_SYSCALL_TRACEPOINTS
> --=20
> 2.40.1
>=20

--qxL1yz6psSH+KTHa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZF5E+wAKCRB4tDGHoIJi
0qIkAP4h1wGTMEuPQYUmv5MtUZW0KshBDKL0NAIFpcdNpWbPXAD/bnHmXzCccO7b
vu3eMlCL4qwuQmizdGLUuA36jpHjhQA=
=DvPo
-----END PGP SIGNATURE-----

--qxL1yz6psSH+KTHa--
