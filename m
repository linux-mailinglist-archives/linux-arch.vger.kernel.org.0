Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492F650AE77
	for <lists+linux-arch@lfdr.de>; Fri, 22 Apr 2022 05:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443699AbiDVDXi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Apr 2022 23:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379874AbiDVDXh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Apr 2022 23:23:37 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33C24CD5B;
        Thu, 21 Apr 2022 20:20:45 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id y129so5009864qkb.2;
        Thu, 21 Apr 2022 20:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HSXDPKVmRDQ3fdXtXVRafT/POiCTG+cTtelapFejT74=;
        b=OZfIw+/9EMSbBNMh31fT6U1TGrHQhK8LSNzLewjOMWhK7mIYSZP6NBNXvgwy0JERYi
         6O6uTePOvoKjTiBkFkpTK0pkysSkYwYeJ6mhNZvel7Dl19SZUy+EEzHwl7mQAtOw1M4b
         xE1w+koCh0tNUM0Gb4tSeFzBqK9EfCUPvPUMQg3JtC1VabhOZGB+JwOcyDi2xLs5SCCE
         83TQUmI0XmhXhhCD++vPqMyEnwLk30j/xdgqOS1G3wcp8Rr/aYEaph4bS35Fh+ZkfzN1
         A239ArmSY/PTzAsPei059e5gWqDpoWJaQ1rkxsbGnY2Ynd5pqlVgGY60bayRsKR4ZRlY
         pxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HSXDPKVmRDQ3fdXtXVRafT/POiCTG+cTtelapFejT74=;
        b=CeTXxbXoUG73ANJzHLgr3/4hy8XE+5zt04srrh5e6AX8aKnCt9LeNDGqer7iF2KY8l
         YcQQRCc1J3cTUS9/R5aQ7e27byQzTnt3Osi575GvGvYVyOcf76QyhbVdYzigySKZaRwW
         exNYD9CY6mOfGqmOUlPqVOTkcDGTyFRYoo2bazxIM9CzcgvRazDBMdpVkr2E9AA0MYh2
         JsLk6wZ2OL6ElmZLVxkgc/8VzAiXxfxsYlb+5uoE9SRI7CZqPdWzm4IDkBfJplm2FY3V
         a8onES6kIcufhpEtLlG0E6fVanHiETqepgjmA92FHpr6bD9c4DKn3YmepSKOK1Yh5R3D
         ja4Q==
X-Gm-Message-State: AOAM532QxPBcuQneEhsHtgE2tr8v+kFj8pITLlyaBuF2W+p7spADpDtg
        LzaIy/i9GY81U0ctXllXl0E=
X-Google-Smtp-Source: ABdhPJxiZ871PeHOAMsIyyPkU+sFuHlJctPo4fQmfadpD5ZwQd9npDaqi9MuLhHzgW8JVHne82CxEg==
X-Received: by 2002:a37:de12:0:b0:69b:f132:c606 with SMTP id h18-20020a37de12000000b0069bf132c606mr1415344qkj.695.1650597645011;
        Thu, 21 Apr 2022 20:20:45 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id j1-20020ac85c41000000b002f24ed4fc04sm617470qtj.83.2022.04.21.20.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 20:20:44 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id ACF9727C005A;
        Thu, 21 Apr 2022 23:20:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 21 Apr 2022 23:20:43 -0400
X-ME-Sender: <xms:Cx9iYttYM_mGj8amkK67bH46I4j3neQVl7YJMj0QMjygxUDMQ0x8SQ>
    <xme:Cx9iYmezi1h9aUYjHjQDWafT4O6UADl7sMRRICOmw07648aKIt_-pm1K4UsXZwAfP
    wUzr7pMwOS-QqDi3Q>
X-ME-Received: <xmr:Cx9iYgxF_uKYSgBXjm52MWjFb38Hhunu8V-LKpIwSffs6PeMKWzzjgsBdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdefgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepiefggeefveejkedvlefgkedvieevtdeileehgeetvddvvdejudeivedtvdev
    heevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:Cx9iYkOaP2zAUvWSjglBBA6M0zW-ND370zoJg07m3zPMxap8HeNWbA>
    <xmx:Cx9iYt-ktMcupJSsYc7sfPkwajmjFr5ySMFFouZC5EqIVOuibDtq6Q>
    <xmx:Cx9iYkUphTSPCgue_WqbUocWowlIhGh-PuiE1N9LrtjN94yChCR7iw>
    <xmx:Cx9iYpSIOKBkhnkwVyNjd7Y-JK2SR8SwWYiaHOMohEqw6i9layc9Bg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Apr 2022 23:20:42 -0400 (EDT)
Date:   Fri, 22 Apr 2022 11:20:38 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, mark.rutland@arm.com, peterz@infradead.org,
        will@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V3 1/3] csky: cmpxchg: Optimize with acquire & release
Message-ID: <YmIfBmisFVBu8Z5R@tardis>
References: <20220417083204.2048364-1-guoren@kernel.org>
 <20220417083204.2048364-2-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TH7M6FGIUa4H6/lg"
Content-Disposition: inline
In-Reply-To: <20220417083204.2048364-2-guoren@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--TH7M6FGIUa4H6/lg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 17, 2022 at 04:32:02PM +0800, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>=20
> Optimize arch_xchg|cmpxchg|cmpxchg_local with ASM acquire|release
> instructions instead of previous C based.
>=20
> Important reference comment by Rutland:
> 8e86f0b409a4 ("arm64: atomics: fix use of acquire + release for
> full barrier semantics")
>=20
> Link: https://lore.kernel.org/linux-riscv/CAJF2gTSAxpAi=3DLbAdu7jntZRUa=
=3D-dJwL0VfmDfBV5MHB=3DrcZ-w@mail.gmail.com/T/#m27a0f1342995deae49ce1d0e1f2=
683f8a181d6c3
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>  arch/csky/include/asm/barrier.h | 11 +++---
>  arch/csky/include/asm/cmpxchg.h | 64 ++++++++++++++++++++++++++++++---
>  2 files changed, 67 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/csky/include/asm/barrier.h b/arch/csky/include/asm/barr=
ier.h
> index f4045dd53e17..fb63335ffa33 100644
> --- a/arch/csky/include/asm/barrier.h
> +++ b/arch/csky/include/asm/barrier.h
> @@ -37,17 +37,21 @@
>   * bar.brar
>   * bar.bwaw
>   */
> +#define ACQUIRE_FENCE		".long 0x8427c000\n"
> +#define RELEASE_FENCE		".long 0x842ec000\n"
> +#define FULL_FENCE		".long 0x842fc000\n"
> +
>  #define __bar_brw()	asm volatile (".long 0x842cc000\n":::"memory")
>  #define __bar_br()	asm volatile (".long 0x8424c000\n":::"memory")
>  #define __bar_bw()	asm volatile (".long 0x8428c000\n":::"memory")
>  #define __bar_arw()	asm volatile (".long 0x8423c000\n":::"memory")
>  #define __bar_ar()	asm volatile (".long 0x8421c000\n":::"memory")
>  #define __bar_aw()	asm volatile (".long 0x8422c000\n":::"memory")
> -#define __bar_brwarw()	asm volatile (".long 0x842fc000\n":::"memory")
> -#define __bar_brarw()	asm volatile (".long 0x8427c000\n":::"memory")
> +#define __bar_brwarw()	asm volatile (FULL_FENCE:::"memory")
> +#define __bar_brarw()	asm volatile (ACQUIRE_FENCE:::"memory")
>  #define __bar_bwarw()	asm volatile (".long 0x842bc000\n":::"memory")
>  #define __bar_brwar()	asm volatile (".long 0x842dc000\n":::"memory")
> -#define __bar_brwaw()	asm volatile (".long 0x842ec000\n":::"memory")
> +#define __bar_brwaw()	asm volatile (RELEASE_FENCE:::"memory")
>  #define __bar_brar()	asm volatile (".long 0x8425c000\n":::"memory")
>  #define __bar_brar()	asm volatile (".long 0x8425c000\n":::"memory")
>  #define __bar_bwaw()	asm volatile (".long 0x842ac000\n":::"memory")
> @@ -56,7 +60,6 @@
>  #define __smp_rmb()	__bar_brar()
>  #define __smp_wmb()	__bar_bwaw()
> =20
> -#define ACQUIRE_FENCE		".long 0x8427c000\n"
>  #define __smp_acquire_fence()	__bar_brarw()
>  #define __smp_release_fence()	__bar_brwaw()
> =20
> diff --git a/arch/csky/include/asm/cmpxchg.h b/arch/csky/include/asm/cmpx=
chg.h
> index d1bef11f8dc9..06c550448bf1 100644
> --- a/arch/csky/include/asm/cmpxchg.h
> +++ b/arch/csky/include/asm/cmpxchg.h
> @@ -64,15 +64,71 @@ extern void __bad_xchg(void);
>  #define arch_cmpxchg_relaxed(ptr, o, n) \
>  	(__cmpxchg_relaxed((ptr), (o), (n), sizeof(*(ptr))))
> =20
> -#define arch_cmpxchg(ptr, o, n) 				\
> +#define __cmpxchg_acquire(ptr, old, new, size)			\
>  ({								\
> +	__typeof__(ptr) __ptr =3D (ptr);				\
> +	__typeof__(new) __new =3D (new);				\
> +	__typeof__(new) __tmp;					\
> +	__typeof__(old) __old =3D (old);				\
> +	__typeof__(*(ptr)) __ret;				\
> +	switch (size) {						\
> +	case 4:							\
> +		asm volatile (					\
> +		"1:	ldex.w		%0, (%3) \n"		\
> +		"	cmpne		%0, %4   \n"		\
> +		"	bt		2f       \n"		\
> +		"	mov		%1, %2   \n"		\
> +		"	stex.w		%1, (%3) \n"		\
> +		"	bez		%1, 1b   \n"		\
> +		ACQUIRE_FENCE					\
> +		"2:				 \n"		\
> +			: "=3D&r" (__ret), "=3D&r" (__tmp)		\
> +			: "r" (__new), "r"(__ptr), "r"(__old)	\
> +			:);					\
> +		break;						\
> +	default:						\
> +		__bad_xchg();					\
> +	}							\
> +	__ret;							\
> +})
> +
> +#define arch_cmpxchg_acquire(ptr, o, n) \
> +	(__cmpxchg_acquire((ptr), (o), (n), sizeof(*(ptr))))
> +
> +#define __cmpxchg(ptr, old, new, size)				\
> +({								\
> +	__typeof__(ptr) __ptr =3D (ptr);				\
> +	__typeof__(new) __new =3D (new);				\
> +	__typeof__(new) __tmp;					\
> +	__typeof__(old) __old =3D (old);				\
>  	__typeof__(*(ptr)) __ret;				\
> -	__smp_release_fence();					\
> -	__ret =3D arch_cmpxchg_relaxed(ptr, o, n);		\
> -	__smp_acquire_fence();					\
> +	switch (size) {						\
> +	case 4:							\
> +		asm volatile (					\
> +		"1:	ldex.w		%0, (%3) \n"		\
> +		"	cmpne		%0, %4   \n"		\
> +		"	bt		2f       \n"		\
> +		"	mov		%1, %2   \n"		\
> +		RELEASE_FENCE					\

FWIW, you probably need to make sure that a barrier instruction inside
an lr/sc loop is a good thing. IIUC, the execution time of a barrier
instruction is determined by the status of store buffers and invalidate
queues (and probably other stuffs), so it may increase the execution
time of the lr/sc loop, and make it unlikely to succeed. But this really
depends on how the arch executes these instructions.

Regards,
Boqun

> +		"	stex.w		%1, (%3) \n"		\
> +		"	bez		%1, 1b   \n"		\
> +		FULL_FENCE					\
> +		"2:				 \n"		\
> +			: "=3D&r" (__ret), "=3D&r" (__tmp)		\
> +			: "r" (__new), "r"(__ptr), "r"(__old)	\
> +			:);					\
> +		break;						\
> +	default:						\
> +		__bad_xchg();					\
> +	}							\
>  	__ret;							\
>  })
> =20
> +#define arch_cmpxchg(ptr, o, n) \
> +	(__cmpxchg((ptr), (o), (n), sizeof(*(ptr))))
> +
> +#define arch_cmpxchg_local(ptr, o, n)				\
> +	(__cmpxchg_relaxed((ptr), (o), (n), sizeof(*(ptr))))
>  #else
>  #include <asm-generic/cmpxchg.h>
>  #endif
> --=20
> 2.25.1
>=20

--TH7M6FGIUa4H6/lg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAmJiHwIACgkQSXnow7UH
+rjwAggAhPjHtuQaNrA11zRm2SsqkpHi+UbJyXdPP2+rtu7Ftk0jOyxbdNFb9RQ8
IAz3G62BmTVjf6YdtF4MsH9quvo6v17qdW2x7OwxG2SAPtTsW2t3QLZEh1kLXGnw
RRLDiJfEWmk2UdK10/Sfx9aORysMS4WFROEXGqX0IDP2M3+iVAVhSftwQvbUAjLv
0BmLj+0rkqKJTZVKnBhf/JxhiYh5NA07MbS4U65dVIa3a4bXI87JVY27zwJfFCjs
c20sU1ZkGMRrNpCP9o4PyF82lQ1nSPPz8fM8KK9xMptjf93CKeMrooijESYHPOY1
HXpucNediIK5Esb+kh7pm7ac5uukJA==
=nH1d
-----END PGP SIGNATURE-----

--TH7M6FGIUa4H6/lg--
