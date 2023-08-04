Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD3A76FE25
	for <lists+linux-arch@lfdr.de>; Fri,  4 Aug 2023 12:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjHDKIG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Aug 2023 06:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjHDKHb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Aug 2023 06:07:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ABB4C37;
        Fri,  4 Aug 2023 03:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691143647; x=1722679647;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wKN3d8eeDXqlTBQixSdvl3Wq7r2YvBLUa2tQIqAHrC8=;
  b=rOpo8DgFbBroXW2POQddcNuvYsxFuaIT2BRMh1+NcvsaUqAbox/LwHf2
   JWEC6APWHFHhDZG3dlAIZb2Gwq+3Idp4ljMYMcOFS9N/M9Hr+IHmi5pXX
   HNgqRJzy7Tij722Z8PG3Di6pmjQtZOHkIvcuMriuvi8elHqKYEc9B/cce
   OmeTL791giarOHZMpEzSZhIcZHceXFSZEc1BfX1+tu52uKfl7rsDbG4c/
   r1Z7wiRxK++bXNrPzaJgNGnszc2OvynQmFUUKzlE1M9fvFYTNnG3UOPDD
   y15ZmryabhDa6k4U/GhkDYinmIUTHxb+W5AgxM2NIt/LwDXrKepOTglJE
   A==;
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="asc'?scan'208";a="164838139"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Aug 2023 03:07:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 4 Aug 2023 03:07:23 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 4 Aug 2023 03:07:18 -0700
Date:   Fri, 4 Aug 2023 11:06:42 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Guo Ren <guoren@kernel.org>
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
Message-ID: <20230804-throwaway-requisite-c73ebe3fee8c@wendy>
References: <20230802164701.192791-1-guoren@kernel.org>
 <20230802164701.192791-8-guoren@kernel.org>
 <20230804-refract-avalanche-9adb6b4b74e9@wendy>
 <CAJF2gTTfLmCe7eDhfPU1qFTBoVZN8oFACEd4NmTyZaAVtdMK-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6ux3xtC3FvsADk3y"
Content-Disposition: inline
In-Reply-To: <CAJF2gTTfLmCe7eDhfPU1qFTBoVZN8oFACEd4NmTyZaAVtdMK-w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--6ux3xtC3FvsADk3y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 04, 2023 at 05:53:35PM +0800, Guo Ren wrote:
> On Fri, Aug 4, 2023 at 5:06=E2=80=AFPM Conor Dooley <conor.dooley@microch=
ip.com> wrote:
> > On Wed, Aug 02, 2023 at 12:46:49PM -0400, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>

> > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufe=
ature.c
> > > index f8dbbe1bbd34..d9694fe40a9a 100644
> > > --- a/arch/riscv/kernel/cpufeature.c
> > > +++ b/arch/riscv/kernel/cpufeature.c
> > > @@ -342,7 +342,8 @@ void __init riscv_fill_hwcap(void)
> > >                * spinlock value, the only way is to change from queue=
d_spinlock to
> > >                * ticket_spinlock, but can not be vice.
> > >                */
> > > -             if (!force_qspinlock) {
> > > +             if (!force_qspinlock &&
> > > +                 !riscv_has_errata_thead_qspinlock()) {
> > >                       set_bit(RISCV_ISA_EXT_XTICKETLOCK, isainfo->isa=
);
> >
> > Is this a generic vendor extension (lol @ that misnomer) or is it an
> > erratum? Make your mind up please. As has been said on other series, NAK
> > to using march/vendor/imp IDs for feature probing.
>
> The RISCV_ISA_EXT_XTICKETLOCK is a feature extension number,

No, that is not what "ISA_EXT" means, nor what the X in "XTICKETLOCK"
would imply.

The comment above these reads:
  These macros represent the logical IDs of each multi-letter RISC-V ISA
  extension and are used in the ISA bitmap.

> and it's
> set by default for forward-compatible. We also define a vendor
> extension (riscv_has_errata_thead_qspinlock) to force all our
> processors to use qspinlock; others still stay on ticket_lock.

No, "riscv_has_errata_thead_qspinlock()" would be an _erratum_, not a
vendor extension. We need to have a discussion about how to support
non-standard extensions etc, not abuse errata. That discussion has been
started on the v0.7.1 vector patches, but has not made progress yet.

> The only possible changing direction is from qspinlock to ticket_lock
> because ticket_lock would dirty the lock value, which prevents
> changing to qspinlock next. So startup with qspinlock and change to
> ticket_lock before smp up. You also could use cmdline to try qspinlock
> (force_qspinlock).

I don't see what the relevance of this is, sorry. I am only commenting
on how you are deciding that the hardware is capable of using qspinlocks,
I don't intend getting into the detail unless the powers that be deem
this series worthwhile, as I mentioned:
> > I've got some thoughts on other parts of this series too, but I'm not
> > going to spend time on it unless the locking people and Palmer ascent
> > to this series.


--6ux3xtC3FvsADk3y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMzNsgAKCRB4tDGHoIJi
0khLAP9+2g1IgFSD0vA1M3uPqS9mK54CvXWvT/+KgFMj04+U5AEAjDGL/J2yGNCs
uKAsNMtA7Mq5Y7xVkuHu857cBMMzPQU=
=HiRV
-----END PGP SIGNATURE-----

--6ux3xtC3FvsADk3y--
