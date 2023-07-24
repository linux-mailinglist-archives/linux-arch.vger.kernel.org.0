Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C13A75F22A
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jul 2023 12:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjGXKIm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jul 2023 06:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbjGXKI1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jul 2023 06:08:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE579658F;
        Mon, 24 Jul 2023 03:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690192881; x=1721728881;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7W6ps/8Cg91gSa3DYMMMR8pTKl+/b3TOAhGDrv2gtYk=;
  b=0XdZJKjqWU64DLW+AfWH9eJ+IWlUHBZjK8rdvLXSXfd8w0GcFzBeRvke
   vpI4IAFSBKlwJeJCivWdz3uadxNcHCKb5DV7+ujUajvl1LgOvpwAiERua
   CiEl4TrXFB9FnpA3J3TAc2Eph9RS+hmuWLr5Lth4qXVMfjzXLJ6u57T/7
   7ga8MOKZvVUokGbcTUBjTY/uyPm3ggqe7tr2HR4DgS3JdUmqIKw/s/Luq
   t5VKwmUga0xb7asw3GMOBuU9BAN+ADrvBsarkAd3npJ2jf+hYjXFcTEjW
   J9RHbvtjWXl8J6dvX3/jDZHRRMpdKukewQTEmxu63JU/cy7xgdDL0nOvi
   A==;
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="asc'?scan'208";a="226147368"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jul 2023 03:00:18 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 24 Jul 2023 03:00:17 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 24 Jul 2023 03:00:16 -0700
Date:   Mon, 24 Jul 2023 10:59:42 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jisheng Zhang <jszhang@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2] riscv: support PREEMPT_DYNAMIC with static keys
Message-ID: <20230724-work-headboard-b1a4f5286ada@wendy>
References: <20230716164925.1858-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LITXHKhDZjLv/zTW"
Content-Disposition: inline
In-Reply-To: <20230716164925.1858-1-jszhang@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--LITXHKhDZjLv/zTW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2023 at 12:49:25AM +0800, Jisheng Zhang wrote:
> Currently, each architecture can support PREEMPT_DYNAMIC through
> either static calls or static keys. To support PREEMPT_DYNAMIC on
> riscv, we face three choices:
>=20
> 1. only add static calls support to riscv
> As Mark pointed out in commit 99cf983cc8bc ("sched/preempt: Add
> PREEMPT_DYNAMIC using static keys"), static keys "...should have
> slightly lower overhead than non-inline static calls, as this
> effectively inlines each trampoline into the start of its callee. This
> may avoid redundant work, and may integrate better with CFI schemes."
> So even we add static calls(without inline static calls) to riscv,
> static keys is still a better choice.
>=20
> 2. add static calls and inline static calls to riscv
> Per my understanding, inline static calls requires objtool support
> which is not easy.
>=20
> 3. use static keys
>=20
> While riscv doesn't have static calls support, it supports static keys
> perfectly. So this patch selects HAVE_PREEMPT_DYNAMIC_KEY to enable
> support for PREEMPT_DYNAMIC on riscv, so that the preemption model can
> be chosen at boot time. It also patches asm-generic/preempt.h, mainly
> to add __preempt_schedule() and __preempt_schedule_notrace() macros
> for PREEMPT_DYNAMIC case. Other architectures which use generic
> preempt.h can also benefit from this patch by simply selecting
> HAVE_PREEMPT_DYNAMIC_KEY to enable PREEMPT_DYNAMIC if they supports
> static keys.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
> since v1:
>  - keep Kconfig entries sorted
>  - group asm-generic modifications under CONFIG_PREEMPT_DYNAMIC &&
>    CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
>=20
>  arch/riscv/Kconfig            |  1 +
>  include/asm-generic/preempt.h | 14 +++++++++++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 4c07b9189c86..686df6902947 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -130,6 +130,7 @@ config RISCV
>  	select HAVE_PERF_REGS
>  	select HAVE_PERF_USER_STACK_DUMP
>  	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
> +	select HAVE_PREEMPT_DYNAMIC_KEY if !XIP_KERNEL

Had a go of this, and it seems fine to me, as do the asm-generic bits
seem fine from a single arch perspective.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--LITXHKhDZjLv/zTW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZL5LjgAKCRB4tDGHoIJi
0nJOAQDVwcZ9xhtArPHW8vfa6H/+/R06yt6lycDcQIEurnKR9QEAmupS+LHdvohd
H0H9yLqR5F78hTmvW/ipHX4SxS+oxQQ=
=IK0A
-----END PGP SIGNATURE-----

--LITXHKhDZjLv/zTW--
