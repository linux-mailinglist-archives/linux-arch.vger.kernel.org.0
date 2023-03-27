Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749446CA617
	for <lists+linux-arch@lfdr.de>; Mon, 27 Mar 2023 15:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjC0NiZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Mar 2023 09:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjC0NiY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Mar 2023 09:38:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8B61718;
        Mon, 27 Mar 2023 06:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1679924302; x=1711460302;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dVJBi1CSJbvncILoFNPRbdwLCRiIlKW5OwVx2Vpb/Z4=;
  b=nq5kbpR22XBChluk5yNyFVK9sx7I1OM6t7zW8H3iXxpDqywZzII55aCm
   MaD68xRw1RcZrcgiAfkroA3YSu6NMbf4NNc0pCmCo0lXSjM6E67DOiQnF
   sWwDx4B+wXiab89uUbgzDreeaaC7jqcU4Bj1G6qYruIH680w/ZoWa30X0
   MHTx+Ji465+USwe+4AAHM38+KtwZnrFH0Mv5mzKh5dyTpilZ5ygvcO0QB
   R2wQm/fCfAD3Pnp0kiw/erAwctan/Rs7Eso71KVBp5RevRg/U1/cfKKI1
   dCgEyL/J198vQXp3Ln+YjVH41LDbFvmEWXFcWTRHzkj4glRsjncvc9ZsP
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,294,1673938800"; 
   d="asc'?scan'208";a="203613708"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Mar 2023 06:38:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 06:38:20 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 27 Mar 2023 06:38:17 -0700
Date:   Mon, 27 Mar 2023 14:49:34 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Guo Ren <guoren@kernel.org>
CC:     <arnd@arndb.de>, <palmer@rivosinc.com>, <tglx@linutronix.de>,
        <peterz@infradead.org>, <luto@kernel.org>, <heiko@sntech.de>,
        <jszhang@kernel.org>, <lazyparser@gmail.com>, <falcon@tinylab.org>,
        <chenhuacai@kernel.org>, <apatel@ventanamicro.com>,
        <atishp@atishpatra.org>, <mark.rutland@arm.com>,
        <bjorn@kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH -next V11 1/3] riscv: stack: Support
 HAVE_IRQ_EXIT_ON_IRQ_STACK
Message-ID: <77e67121-3857-4389-897b-77a6506a3443@spud>
References: <20230324071239.151677-1-guoren@kernel.org>
 <20230324071239.151677-2-guoren@kernel.org>
 <f170c68c-4975-4f71-ac50-979483cb5848@spud>
 <CAJF2gTSwt1XkC=kisOAf0_aHmi6E6ty-EV0eSA110E1DzvWc2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bZdHL0QuALWZLGDg"
Content-Disposition: inline
In-Reply-To: <CAJF2gTSwt1XkC=kisOAf0_aHmi6E6ty-EV0eSA110E1DzvWc2Q@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--bZdHL0QuALWZLGDg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2023 at 09:32:51PM +0800, Guo Ren wrote:
> On Mon, Mar 27, 2023 at 7:30=E2=80=AFPM Conor Dooley <conor.dooley@microc=
hip.com> wrote:
> >
> > On Fri, Mar 24, 2023 at 03:12:37AM -0400, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > Add independent irq stacks for percpu to prevent kernel stack overflo=
ws.
> > > It is also compatible with VMAP_STACK by implementing
> > > arch_alloc_vmap_stack.  Many architectures have supported
> > > HAVE_IRQ_EXIT_ON_IRQ_STACK, riscv should follow up.
> > >
> > > Tested-by: Jisheng Zhang <jszhang@kernel.org>
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Signed-off-by: Guo Ren <guoren@kernel.org>
> >
> > > --- a/arch/riscv/kernel/irq.c
> > > +++ b/arch/riscv/kernel/irq.c
> > > @@ -9,6 +9,37 @@
> > >  #include <linux/irqchip.h>
> > >  #include <linux/seq_file.h>
> > >  #include <asm/smp.h>
> > > +#include <asm/vmap_stack.h>
> > > +
> > > +#ifdef CONFIG_IRQ_STACKS
> > > +DEFINE_PER_CPU(ulong *, irq_stack_ptr);
> >
> > btw, sparse is complaining about this variable:
> > ../arch/riscv/kernel/irq.c:15:1: warning: symbol '__pcpu_scope_irq_stac=
k_ptr' was not declared. Should it be static?

> I declared it in traps.c, maybe I should put it in the vmap_stack.h.

Ahh, I was distracted by the DEFINE_PER_CPU above and didn't look at
where the actual declaration was.. Moving it to a header sounds good to
me, thanks.

--bZdHL0QuALWZLGDg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCGe7gAKCRB4tDGHoIJi
0mLWAP4rp/MPI/P/M/C92bO7bf4f3lX+L/7fmSNZrzm/FLCMdwD6A0aWsBLYPXVt
7GpynNcJOjN1reQhsOA4nhNcMQCVLAY=
=KsYo
-----END PGP SIGNATURE-----

--bZdHL0QuALWZLGDg--
