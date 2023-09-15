Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D577A1D6C
	for <lists+linux-arch@lfdr.de>; Fri, 15 Sep 2023 13:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbjIOL1M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Sep 2023 07:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjIOL1L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Sep 2023 07:27:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD7F189;
        Fri, 15 Sep 2023 04:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694777226; x=1726313226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sgc0zSrGefo9HpfyefwEBfCgGDwPriLtMeMOJfh1oi8=;
  b=udyOjCOQ3nh8cuhwC2WrkYr52zeT70xpoVUoUfXBgY1aRVGG3d/cf8ym
   Wgk8KD6CrvFF5NPj+KQJHHvi08KlRMXgHlyeXwWIr8cPPHKycpMJXJW4s
   nxvkY/ZCFZOtGgsZHOkS9V0ibGrM74vT8NfghlhyW7bYlaO1HjzwmnOyQ
   NIR5fQRjCyk2uGb4GdDJPLiWsJ+mGqU9ujkaPIgSOwaGKoqYTN0NtM0in
   pXyazt2V2cVYjVNLMcB3DpkUunecyrbDkAQwPuZmjMuUwNzQCSPlQxTJl
   NGTjeWcsDc/fHoLa7QDS+zc6DIVBFEMeETpKuqzHGHWyDLss4NU36QGL2
   g==;
X-CSE-ConnectionGUID: h+LRxpatS5WlkHJ+ChtJQA==
X-CSE-MsgGUID: RII97ImpT4KJbiXHzs9jaA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="asc'?scan'208";a="4716320"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Sep 2023 04:26:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 15 Sep 2023 04:26:42 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 15 Sep 2023 04:26:37 -0700
Date:   Fri, 15 Sep 2023 12:26:20 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     Leonardo Bras <leobras@redhat.com>, <guoren@kernel.org>,
        <paul.walmsley@sifive.com>, <anup@brainfault.org>,
        <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
        <palmer@rivosinc.com>, <longman@redhat.com>,
        <boqun.feng@gmail.com>, <tglx@linutronix.de>, <paulmck@kernel.org>,
        <rostedt@goodmis.org>, <rdunlap@infradead.org>,
        <catalin.marinas@arm.com>, <xiaoguang.xing@sophgo.com>,
        <bjorn@rivosinc.com>, <alexghiti@rivosinc.com>,
        <keescook@chromium.org>, <greentime.hu@sifive.com>,
        <jszhang@kernel.org>, <wefu@redhat.com>, <wuwei2016@iscas.ac.cn>,
        <linux-arch@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <kvm@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <linux-csky@vger.kernel.org>, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V11 03/17] riscv: Use Zicbop in arch_xchg when available
Message-ID: <20230915-take-virus-1245c5dfed0a@wendy>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-4-guoren@kernel.org>
 <20230914-1ce4f391a14e56b456d88188@orel>
 <ZQQUQjOaAIc95GXP@redhat.com>
 <20230915-85238ac7734cf543bff3ddad@orel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="knBYdCMC+fHqQTry"
Content-Disposition: inline
In-Reply-To: <20230915-85238ac7734cf543bff3ddad@orel>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--knBYdCMC+fHqQTry
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 01:07:40PM +0200, Andrew Jones wrote:
> On Fri, Sep 15, 2023 at 05:22:26AM -0300, Leonardo Bras wrote:
> > On Thu, Sep 14, 2023 at 03:47:59PM +0200, Andrew Jones wrote:
> > > On Sun, Sep 10, 2023 at 04:28:57AM -0400, guoren@kernel.org wrote:
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> ...
> > > > diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include=
/asm/insn-def.h
> > > > index 6960beb75f32..dc590d331894 100644
> > > > --- a/arch/riscv/include/asm/insn-def.h
> > > > +++ b/arch/riscv/include/asm/insn-def.h
> > > > @@ -134,6 +134,7 @@
> > > > =20
> > > >  #define RV_OPCODE_MISC_MEM	RV_OPCODE(15)
> > > >  #define RV_OPCODE_SYSTEM	RV_OPCODE(115)
> > > > +#define RV_OPCODE_PREFETCH	RV_OPCODE(19)
> > >=20
> > > This should be named RV_OPCODE_OP_IMM and be placed in
> > > numerical order with the others, i.e. above SYSTEM.
> > >=20
> > > > =20
> > > >  #define HFENCE_VVMA(vaddr, asid)				\
> > > >  	INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(17),		\
> > > > @@ -196,4 +197,8 @@
> > > >  	INSN_I(OPCODE_MISC_MEM, FUNC3(2), __RD(0),		\
> > > >  	       RS1(base), SIMM12(4))
> > > > =20
> > > > +#define CBO_prefetchw(base)					\
> > >=20
> > > Please name this 'PREFETCH_w' and it should take an immediate paramet=
er,
> > > even if we intend to pass 0 for it.
> >=20
> > It makes sense.
> >=20
> > The mnemonic in the previously mentioned documentation is:
> >=20
> > prefetch.w offset(base)
> >=20
> > So yeah, makes sense to have both offset and base as parameters for=20
> > CBO_prefetchw (or PREFETCH_w, I have no strong preference).
>=20
> I have a strong preference :-)
>=20
> PREFETCH_w is consistent with the naming we already have for e.g.
> cbo.clean, which is CBO_clean. The instruction we're picking a name
> for now is prefetch.w, not cbo.prefetchw.

btw, the CBO_foo stuff was named that way as we were using them in
alternatives originally as an argument, that manifested as:
"cbo." __stringify(_op) " (a0)\n\t"
That was later changed to
CBO_##_op(a0)
but the then un-needed (AFAICT) capitalisation was kept to avoid
touching the callsites of the alternative. Maybe you remember better
than I do drew, since the idea was yours & I forgot I even wrote that
pattch.
If this isn't being used in a similar manner, then the w has no reason
to be in the odd lowercase form.

Cheers,
Conor.

>=20
> >=20
> > >=20
> > > > +	INSN_R(OPCODE_PREFETCH, FUNC3(6), FUNC7(0),		\
> > > > +	       RD(x0), RS1(base), RS2(x0))
> > >=20
> > > prefetch.w is not an R-type instruction, it's an S-type. While the bit
> > > shifts are the same, the names are different. We need to add S-type
> > > names while defining this instruction.=20
> >=20
> > That is correct, it is supposed to look like a store instruction (S-typ=
e),=20
> > even though documentation don't explicitly state that.
> >=20
> > Even though it works fine with the R-type definition, code documentatio=
n=20
> > would be wrong, and future changes could break it.
> >=20
> > > Then, this define would be
> > >=20
> > >  #define PREFETCH_w(base, imm) \
>=20
> I should have suggested 'offset' instead of 'imm' for the second parameter
> name.
>=20
> > >      INSN_S(OPCODE_OP_IMM, FUNC3(6), IMM_11_5(imm), __IMM_4_0(0), \
> > >             RS1(base), __RS2(3))
> >=20
> > s/OPCODE_OP_IMM/OPCODE_PREFETCH
> > 0x4 vs 0x13
>=20
> There's no major opcode named "PREFETCH" and the spec says that the major
> opcode used for prefetch instructions is OP-IMM. That's why we want to
> name this OPCODE_OP_IMM. I'm not sure where the 0x4 you're referring to
> comes from. A 32-bit instruction has the lowest two bits set (figure 1.1
> of the unpriv spec) and table 27.1 of the unpriv spec shows OP-IMM is
> 0b00100xx, so we have 0b0010011. Keeping the naming of the opcode macros
> consistent with the spec also keeps them consistent with the .insn
> directive where we could even use the names directly, i.e.
>=20
>  .insn s OP_IMM, 6, x3, 0(a0)
>=20
> > >=20
> > > When the assembler as insn_r I hope it will validate that
>=20
> I meant insn_s here, which would be the macro for '.insn s'
>=20
> > > (imm & 0xfe0) =3D=3D imm
>=20
> I played with it. It won't do what we want for prefetch, only
> what works for s-type instructions in general, i.e. it allows
> +/-2047 offsets and fails for everything else. That's good enough.
> We can just mask off the low 5 bits here in our macro
>=20
>  #define PREFETCH_w(base, offset) \
>     INSN_S(OPCODE_OP_IMM, FUNC3(6), IMM_11_5((offset) & ~0x1f), \
>            __IMM_4_0(0), RS1(base), __RS2(3))
>=20
> Thanks,
> drew

--knBYdCMC+fHqQTry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQQ/WwAKCRB4tDGHoIJi
0k/nAQDp+dy+ZT4Y9lm9o52hPyYtqPA9KT7uRZt7JH5/zNJr8QD/X89zTYc2GZc/
LcKv3s8xeYmBUzj9PEUmk7NVNybe8AQ=
=4wqu
-----END PGP SIGNATURE-----

--knBYdCMC+fHqQTry--
