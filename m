Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D4176FCE6
	for <lists+linux-arch@lfdr.de>; Fri,  4 Aug 2023 11:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjHDJJF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Aug 2023 05:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHDJIm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Aug 2023 05:08:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2314C10;
        Fri,  4 Aug 2023 02:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691139970; x=1722675970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HRKkBCsgZa2tr3CPFdaWMT/tn1Xo0mpaNu//7DKF8jQ=;
  b=rvxVGSbsFUxsVILqw32k908RCiy4CoZPKuUupl9K71kB8BfEO9vzfXqq
   gks9IsZql3vkagVHAn/v3TNiUEqWZOzZRcBC/6DkRiBF1qpM2oYTbEUG3
   NJ+A8Rv8RnU0Kn44Lm/JKFFeHhAh4T/TxjIZsBWWWj5rT6Ofkt8yW8xq3
   YXKZlz9/J30YtHK9er9oASJiNIEwqCGNV7LIaJjUpKk7YJHQYZAvv0fHa
   I6aqo7WbhNkTNncAM9/EUoOcop+pdHAc/L/mfQsyosNXpzYyKURiScsUR
   FdkD7HF0B+ZtYlUriVKqL9SCYkV2qsXZBFRQ/IqV1TOO/xJw/oFnVVHRQ
   g==;
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="asc'?scan'208";a="239780302"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Aug 2023 02:06:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 4 Aug 2023 02:06:06 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 4 Aug 2023 02:06:01 -0700
Date:   Fri, 4 Aug 2023 10:05:25 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <guoren@kernel.org>
CC:     <paul.walmsley@sifive.com>, <anup@brainfault.org>,
        <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
        <palmer@rivosinc.com>, <longman@redhat.com>,
        <boqun.feng@gmail.com>, <tglx@linutronix.de>, <paulmck@kernel.org>,
        <rostedt@goodmis.org>, <rdunlap@infradead.org>,
        <catalin.marinas@arm.com>, <xiaoguang.xing@sophgo.com>,
        <bjorn@rivosinc.com>, <alexghiti@rivosinc.com>,
        <keescook@chromium.org>, <greentime.hu@sifive.com>,
        <ajones@ventanamicro.com>, <jszhang@kernel.org>, <wefu@redhat.com>,
        <wuwei2016@iscas.ac.cn>, <linux-arch@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <kvm@vger.kernel.org>, <virtualization@lists.linux-foundation.org>,
        <linux-csky@vger.kernel.org>, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V10 07/19] riscv: qspinlock: errata: Introduce
 ERRATA_THEAD_QSPINLOCK
Message-ID: <20230804-refract-avalanche-9adb6b4b74e9@wendy>
References: <20230802164701.192791-1-guoren@kernel.org>
 <20230802164701.192791-8-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ElWjm7UHbiNPE9YP"
Content-Disposition: inline
In-Reply-To: <20230802164701.192791-8-guoren@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--ElWjm7UHbiNPE9YP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Guo Ren,

On Wed, Aug 02, 2023 at 12:46:49PM -0400, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>=20
> According to qspinlock requirements, RISC-V gives out a weak LR/SC
> forward progress guarantee which does not satisfy qspinlock. But
> many vendors could produce stronger forward guarantee LR/SC to
> ensure the xchg_tail could be finished in time on any kind of
> hart. T-HEAD is the vendor which implements strong forward
> guarantee LR/SC instruction pairs, so enable qspinlock for T-HEAD
> with errata help.
>=20
> T-HEAD early version of processors has the merge buffer delay
> problem, so we need ERRATA_WRITEONCE to support qspinlock.
>=20
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/Kconfig.errata              | 13 +++++++++++++
>  arch/riscv/errata/thead/errata.c       | 24 ++++++++++++++++++++++++
>  arch/riscv/include/asm/errata_list.h   | 20 ++++++++++++++++++++
>  arch/riscv/include/asm/vendorid_list.h |  3 ++-
>  arch/riscv/kernel/cpufeature.c         |  3 ++-
>  5 files changed, 61 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> index 4745a5c57e7c..eb43677b13cc 100644
> --- a/arch/riscv/Kconfig.errata
> +++ b/arch/riscv/Kconfig.errata
> @@ -96,4 +96,17 @@ config ERRATA_THEAD_WRITE_ONCE
> =20
>  	  If you don't know what to do here, say "Y".
> =20
> +config ERRATA_THEAD_QSPINLOCK
> +	bool "Apply T-Head queued spinlock errata"
> +	depends on ERRATA_THEAD
> +	default y
> +	help
> +	  The T-HEAD C9xx processors implement strong fwd guarantee LR/SC to
> +	  match the xchg_tail requirement of qspinlock.
> +
> +	  This will apply the QSPINLOCK errata to handle the non-standard
> +	  behavior via using qspinlock instead of ticket_lock.

Whatever about the acceptability of anything else in this series,
having _stronger_ guarantees is not an erratum, is it? We should not
abuse the errata stuff for this IMO.

> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index f8dbbe1bbd34..d9694fe40a9a 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -342,7 +342,8 @@ void __init riscv_fill_hwcap(void)
>  		 * spinlock value, the only way is to change from queued_spinlock to
>  		 * ticket_spinlock, but can not be vice.
>  		 */
> -		if (!force_qspinlock) {
> +		if (!force_qspinlock &&
> +		    !riscv_has_errata_thead_qspinlock()) {
>  			set_bit(RISCV_ISA_EXT_XTICKETLOCK, isainfo->isa);

Is this a generic vendor extension (lol @ that misnomer) or is it an
erratum? Make your mind up please. As has been said on other series, NAK
to using march/vendor/imp IDs for feature probing.

I've got some thoughts on other parts of this series too, but I'm not
going to spend time on it unless the locking people and Palmer ascent
to this series.

Cheers,
Conor.

--ElWjm7UHbiNPE9YP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMy/VQAKCRB4tDGHoIJi
0i4WAQCzkmqln57/kLaRZPtx560Zn+aRbe3oPrmbNsnASM/znAEAsOJHnqt7ygoV
utG4AXklmHWnwsLM0Qs5463EGKimzwY=
=9hTn
-----END PGP SIGNATURE-----

--ElWjm7UHbiNPE9YP--
