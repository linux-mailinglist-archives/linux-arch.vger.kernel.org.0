Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF496692F1
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jan 2023 10:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236680AbjAMJ3r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Jan 2023 04:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239903AbjAMJ1z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Jan 2023 04:27:55 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB61938A1;
        Fri, 13 Jan 2023 01:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673601824; x=1705137824;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/xAKBZhyJ8HlMGnG8R+tnMoMY4Yw1acK1pUdd5RRh4A=;
  b=aL9IGJlM/FkVtktAgqFV5JNzy5wCIqDOo4aDTMbZIJRQPSTeNlHZLGe3
   su6VOUdi5auzDPcSeXwX45tyW43lYRtzzAaFSpciTQBpauXEmQCy38X/c
   /AeHgl0WgJg1Ffn16psXZpj3r1ykEM5Fev7VdCMjGBbcRrGu0Rrpow77M
   uMrUREkVI1OSY8BFCl3OTkRQ8DvM9vBUr3JVRAyAZ0zYqfSMzsEFm3nXa
   VcHs2JkSP/121k57/dlTcxVtt7OPpqYDrTCe4tJjRlGXLhZ+JymAnIvGZ
   kWCO7uPUWcm4rFwROd2jLNq609jqqZcXzACl3MpNC16L4+n/VwJCwxFl+
   A==;
X-IronPort-AV: E=Sophos;i="5.97,213,1669100400"; 
   d="asc'?scan'208";a="195624611"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jan 2023 02:23:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 13 Jan 2023 02:23:40 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Fri, 13 Jan 2023 02:23:36 -0700
Date:   Fri, 13 Jan 2023 09:23:14 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <guoren@kernel.org>
CC:     <arnd@arndb.de>, <palmer@rivosinc.com>, <tglx@linutronix.de>,
        <peterz@infradead.org>, <luto@kernel.org>, <heiko@sntech.de>,
        <jszhang@kernel.org>, <lazyparser@gmail.com>, <falcon@tinylab.org>,
        <chenhuacai@kernel.org>, <apatel@ventanamicro.com>,
        <atishp@atishpatra.org>, <mark.rutland@arm.com>,
        <ben@decadent.org.uk>, <bjorn@kernel.org>,
        <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Yipeng Zou <zouyipeng@huawei.com>
Subject: Re: [PATCH -next V14 4/7] riscv: entry: Convert to generic entry
Message-ID: <Y8EjAt3DC4WC062n@wendy>
References: <20230112095848.1464404-1-guoren@kernel.org>
 <20230112095848.1464404-5-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Tn016RnVhEUTOGe2"
Content-Disposition: inline
In-Reply-To: <20230112095848.1464404-5-guoren@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--Tn016RnVhEUTOGe2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Guo Ren,

On Thu, Jan 12, 2023 at 04:58:45AM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>=20
> This patch converts riscv to use the generic entry infrastructure from
> kernel/entry/*. The generic entry makes maintainers' work easier and
> codes more elegant. Here are the changes:
>=20
>  - More clear entry.S with handle_exception and ret_from_exception
>  - Get rid of complex custom signal implementation
>  - Move syscall procedure from assembly to C, which is much more
>    readable.
>  - Connect ret_from_fork & ret_from_kernel_thread to generic entry.
>  - Wrap with irqentry_enter/exit and syscall_enter/exit_from_user_mode
>  - Use the standard preemption code instead of custom
>=20
> Suggested-by: Huacai Chen <chenhuacai@kernel.org>
> Reviewed-by: Bj=F6rn T=F6pel <bjorn@rivosinc.com>
> Tested-by: Yipeng Zou <zouyipeng@huawei.com>
> Tested-by: Jisheng Zhang <jszhang@kernel.org>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Ben Hutchings <ben@decadent.org.uk>

Unfortunately from this patch onwards, the !MMU build is broken.
Should be able to reproduce it with nommu_virt_defconfig.

Thanks,
Conor.


--Tn016RnVhEUTOGe2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8Ei5AAKCRB4tDGHoIJi
0hgHAP4zxYtVsZMV6BCEppbmfxRxpMW9oFKnWUOgUmHwNcSrhwD9Ff6CTDLxoiy3
sCNkTcezQudksEUbdB5Noc0qY6RioA0=
=OVvh
-----END PGP SIGNATURE-----

--Tn016RnVhEUTOGe2--
