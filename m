Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E1C79C94D
	for <lists+linux-arch@lfdr.de>; Tue, 12 Sep 2023 10:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjILIIY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Sep 2023 04:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjILIIE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Sep 2023 04:08:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8741C1738;
        Tue, 12 Sep 2023 01:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694506078; x=1726042078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4dV0kV+KXW7UJb+9tqUaPdb1gu1yn8BbHk8/t4Bxq1g=;
  b=XNWSAaWJ2RwihAcsy0YobrK6ODitNIqzKgtAQ11uX1FMUz/dlykasZpT
   DcJJyLQAduPeJ/V4sGZ+jk1RAm43P0kYe4OrwyynshWrRzMdiQ8rElFCL
   dC1jN9d11Hk7LD1hW50pgm29vmM8SxkahsyJrT5dwHsovie85wDAI+Z8H
   JArGmhFE3H/3zgQM2joXNVCzp7juUqFjXtDB3kmBYk+03jLv5xpmiOnwv
   l7Mqt72GVHMY88meIyXeWNSNpOk8EBv2Lv0GkmMnxN2W5MzCTwY66HS0+
   cvSSeVyXcN4M3E5kgZvuUVTWLeU/ij1nXAGdfSAkasxzv8deHwnIoFAqn
   Q==;
X-CSE-ConnectionGUID: 7hms3/EVQU6kwoNgywT1gw==
X-CSE-MsgGUID: Wxbwhb0NT0acycYnDfqITw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="asc'?scan'208";a="4155476"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Sep 2023 01:07:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 12 Sep 2023 01:07:49 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 12 Sep 2023 01:07:44 -0700
Date:   Tue, 12 Sep 2023 09:07:28 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Guo Ren <guoren@kernel.org>
CC:     Conor Dooley <conor@kernel.org>, <paul.walmsley@sifive.com>,
        <anup@brainfault.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <will@kernel.org>, <palmer@rivosinc.com>, <longman@redhat.com>,
        <boqun.feng@gmail.com>, <tglx@linutronix.de>, <paulmck@kernel.org>,
        <rostedt@goodmis.org>, <rdunlap@infradead.org>,
        <catalin.marinas@arm.com>, <xiaoguang.xing@sophgo.com>,
        <bjorn@rivosinc.com>, <alexghiti@rivosinc.com>,
        <keescook@chromium.org>, <greentime.hu@sifive.com>,
        <ajones@ventanamicro.com>, <jszhang@kernel.org>, <wefu@redhat.com>,
        <wuwei2016@iscas.ac.cn>, <leobras@redhat.com>,
        <linux-arch@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <kvm@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <linux-csky@vger.kernel.org>, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V11 00/17] riscv: Add Native/Paravirt qspinlock support
Message-ID: <20230912-snitch-astronaut-41e1b694d24f@wendy>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910-esteemed-exodus-706aaae940b1@spud>
 <CAJF2gTRQd_dNuZHNwfg3SwD0XERaYXYUdFUFQiarym40kpxFRQ@mail.gmail.com>
 <20230910-baggage-accent-ec5331b58c8e@spud>
 <CAJF2gTS8Vh5XdMUcgLA_GJzW6Nm3JKHxuMN9jYSNe_YCEjgCXA@mail.gmail.com>
 <20230910-facsimile-answering-60d1452b8c10@spud>
 <CAJF2gTSP1rxVhuwOKyWiE2vFFijJFc2aKRU2=0rTK9nDc8AbsQ@mail.gmail.com>
 <20230911-nimbly-outcome-496efae7adc6@wendy>
 <CAJF2gTTSDtnc7WRAZ0eLjiwZHZFbOcPZaQ_c8LiLcctBNsKCaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j7Df9CobqEwFv6J/"
Content-Disposition: inline
In-Reply-To: <CAJF2gTTSDtnc7WRAZ0eLjiwZHZFbOcPZaQ_c8LiLcctBNsKCaA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--j7Df9CobqEwFv6J/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 09:33:57AM +0800, Guo Ren wrote:
> On Mon, Sep 11, 2023 at 8:53=E2=80=AFPM Conor Dooley <conor.dooley@microc=
hip.com> wrote:

> > I added the new "riscv,isa-extensions" property in part to make
> > communicating vendor extensions like this easier. Please try to use
> > that. "qspinlock" is software configuration though, the vendor extension
> > should focus on the guarantee of strong forward progress, since that is
> > the non-standard aspect of your IP.
>=20
> The qspinlock contains three paths:
>  - Native qspinlock, this is your strong forward progress.
>  - virt_spin_lock, for KVM guest when paravirt qspinlock disabled.
>    https://lore.kernel.org/linux-riscv/20230910082911.3378782-9-guoren@ke=
rnel.org/
>  - paravirt qspinlock, for KVM guest
>=20
> So, we need a software configuration here, "riscv,isa-extensions" is
> all about vendor extension.

Ah right, yes it would only be able to be used to determine whether or
not the platform is capable of supporting these spinlocks, not whether or
not the kernel is a guest. I think I misinterpreted that snippet you posted,
thinking you were trying to disable your new spinlock for KVM, sorry.
On that note though, what about other sorts of guests? Will non-KVM
guests not also want to use this virt spinlock?

Thanks,
Conor.

--j7Df9CobqEwFv6J/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQAcMgAKCRB4tDGHoIJi
0qK3AQDulJZGiGgA+E47R8Ud6R5oEN/4EtWOAnkckiastVsR5QEA6lHxhL+c0RXG
ffHqBpd4a2z2HVNcuw9EEcI8bR26oQE=
=j90q
-----END PGP SIGNATURE-----

--j7Df9CobqEwFv6J/--
