Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3B97A1F43
	for <lists+linux-arch@lfdr.de>; Fri, 15 Sep 2023 14:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbjIOMxq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Sep 2023 08:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbjIOMxq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Sep 2023 08:53:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140201BEB;
        Fri, 15 Sep 2023 05:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694782416; x=1726318416;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fy5E7iactUuOk/E7Asavn2wfTbB47hTdkHiZ8f3/+lM=;
  b=yGTldwrVe87bDZX4RJ7DkycD7q9Mt7nsN8ILBQrUsz4L0lHZrS+xbkKK
   CGc6fOVu+8h4L5ACxJfz4Z3JunTxbcTJ0Wr8/AnPGnGhm1CszU7GS2pqm
   8WYW36uQVd0XoSM4SxP2bqvKIQmhTBq8LFIGHrLgjvwrwxRASIYRBr9al
   C7DTeyZhHd24VvmKRxvxX7aHu+2mIX+RwqW1d/9Xb6z7TIgm8wne1EWBj
   0LQ95mnV2CFX9Ri+aQJwFTrtKNbWoIyVyL5vL6TH/7lCXDktYYyexLDyo
   TkM5BOzGZLNG4e4NqHarDpGi6KWoyd3NrsCKeuZSX90ZBOqw7VdGh+HuL
   Q==;
X-CSE-ConnectionGUID: 3TZVR8qTTNydN499RGxjdA==
X-CSE-MsgGUID: bgKT2ZCwQAaHMVFXG3kIKw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="asc'?scan'208";a="4859799"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Sep 2023 05:53:30 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 15 Sep 2023 05:53:25 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 15 Sep 2023 05:53:17 -0700
Date:   Fri, 15 Sep 2023 13:53:00 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     <guoren@kernel.org>, <paul.walmsley@sifive.com>,
        <anup@brainfault.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <will@kernel.org>, <palmer@rivosinc.com>, <longman@redhat.com>,
        <boqun.feng@gmail.com>, <tglx@linutronix.de>, <paulmck@kernel.org>,
        <rostedt@goodmis.org>, <rdunlap@infradead.org>,
        <catalin.marinas@arm.com>, <xiaoguang.xing@sophgo.com>,
        <bjorn@rivosinc.com>, <alexghiti@rivosinc.com>,
        <keescook@chromium.org>, <greentime.hu@sifive.com>,
        <jszhang@kernel.org>, <wefu@redhat.com>, <wuwei2016@iscas.ac.cn>,
        <leobras@redhat.com>, <linux-arch@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <kvm@vger.kernel.org>, <virtualization@lists.linux-foundation.org>,
        <linux-csky@vger.kernel.org>, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V11 03/17] riscv: Use Zicbop in arch_xchg when available
Message-ID: <20230915-unseated-runway-7f519a57034f@wendy>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-4-guoren@kernel.org>
 <20230914-892327a75b4b86badac5de02@orel>
 <20230914-74d0cf00633c199758ee3450@orel>
 <20230915-removing-flaky-44c66da669ae@wendy>
 <20230915-ff4bd6cd721ed9bc4c4eb101@orel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AHl5K11HRR7A6/jr"
Content-Disposition: inline
In-Reply-To: <20230915-ff4bd6cd721ed9bc4c4eb101@orel>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--AHl5K11HRR7A6/jr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 02:14:40PM +0200, Andrew Jones wrote:
> On Fri, Sep 15, 2023 at 12:37:50PM +0100, Conor Dooley wrote:
> > On Thu, Sep 14, 2023 at 04:47:18PM +0200, Andrew Jones wrote:
> > > On Thu, Sep 14, 2023 at 04:25:53PM +0200, Andrew Jones wrote:
> > > > On Sun, Sep 10, 2023 at 04:28:57AM -0400, guoren@kernel.org wrote:
> > > > > From: Guo Ren <guoren@linux.alibaba.com>

> > > So, we could maybe proceed with assuming we
> > > can use zicbom_block_size for prefetch, for now. If a platform comes =
along
> > > that interpreted the spec differently, requiring prefetch block size =
to
> > > be specified separately, then we'll cross that bridge when we get the=
re.
> >=20
> > That said, I think I suggested originally having the zicboz stuff defau=
lt
> > to the zicbom size too, so I'd be happy with prefetch stuff working
> > exclusively that way until someone comes along looking for different si=
zes.
> > The binding should be updated though since
> >=20
> >   riscv,cbom-block-size:
> >     $ref: /schemas/types.yaml#/definitions/uint32
> >     description:
> >       The blocksize in bytes for the Zicbom cache operations.
> >=20
> > would no longer be a complete description.
> >=20
> > While thinking about new wording though, it feels really clunky to desc=
ribe
> > it like:
> > 	The block size in bytes for the Zicbom cache operations, Zicbop
> > 	cache operations will default to this block size where not
> > 	explicitly defined.
> >=20
> > since there's then no way to actually define the block size if it is
> > different. Unless you've got some magic wording, I'd rather document
> > riscv,cbop-block-size, even if we are going to use riscv,cbom-block-size
> > as the default.
> >
>=20
> Sounds good to me, but if it's documented, then we should probably
> implement its parsing. Then, at that point, I wonder if it makes sense to
> have the fallback at all, or if it's not better just to require all the
> DTs to be explicit (even if redundant).

Sure, why not I guess.

--AHl5K11HRR7A6/jr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQRTrAAKCRB4tDGHoIJi
0jC/AP4yIa3GuPAqy1hpoYpYwpy0ZYwvAT8Pxx/ZnbMaKl8GOAEAx6w8VycBziq2
ENX9YTMH8AbfihyqNUkRC963e+VggwY=
=kCxr
-----END PGP SIGNATURE-----

--AHl5K11HRR7A6/jr--
