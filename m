Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6EE8501FF2
	for <lists+linux-arch@lfdr.de>; Fri, 15 Apr 2022 03:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348310AbiDOBMK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Apr 2022 21:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348342AbiDOBMJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Apr 2022 21:12:09 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4F22BB08;
        Thu, 14 Apr 2022 18:09:42 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id c1so5653042qvl.3;
        Thu, 14 Apr 2022 18:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f7S9Nf0iOB82baXteCdpXugH6eTdDEypH4RQLkPdzMA=;
        b=m4BT/K/0yJDzWkiBmM5y4I2etTUOAhnNFnHc1jDMHcc/IJ8ioruOoc/NbNgbkzhA5v
         XuduPHH2yTBaxzrLm++6WtL0LxrwFnnM3GaJGS64OgFN1FWUH3oTCEylxd2oEsiLLM3Q
         2qhHdt6QOrVuFjj/JjwMktFia5+Iv66P5yM8mJSXMuGEKHpJZ5+WfEuOLPRSPFH6tpch
         SoCnbuA0qIXQjhex2DdHaPZFKwDUpS1PURP9nwdydJRNNm94sMLuuKFlT0fLxdP3DjSY
         jkSTmCtZHY0ZMJH63+cVzrEWanJgpr2cHep+AAWv+GLw0r5fXALJfJxJAeLx4LkjbO6W
         tVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f7S9Nf0iOB82baXteCdpXugH6eTdDEypH4RQLkPdzMA=;
        b=PKn5ERYY0a3+OnvfN7O2pPE0LIHKJR/DJHQU5HqyPmU+gaSOeafuRkS9RqsCfP0prY
         5nDbAIijbOw/P+VFHcIgN5ehCDJAXs2bS+wl1GdsaZMfYuAhlVuJPllbrRXO7SPmrDuM
         5GNj9sL/FIa44VrZngMJKIESC7qq2Y2EqtbhwCOsiaEjMv5g68+VxcWU1/295CovDFeq
         VqvioNvIF6vxYs9Dnuf/WqTEIZiuddETrlYvPCJaacNlgcwBLKYPZyR8EhMFMcFKsLy6
         pq74ShpNDZvXf9aPNHAkfnoRfze+jCJRxrnksKleN0kD5kw/G+QfyBjs71+SNlKqoVHo
         eBTw==
X-Gm-Message-State: AOAM533mPeh5Xzyv07hk/ITxyro/tC3oCEE0ScvmWLNO6DBjj+aCAb5s
        FTubExDdeRrbP2QpPtTyulk=
X-Google-Smtp-Source: ABdhPJxZaCk2t3Z2mAVbMOl1k3tozE+aw0NygrHYGlnKCqc3bDs8ZvhmLdhGi60f+KClyCxX+RpTpw==
X-Received: by 2002:a05:6214:5188:b0:446:23f5:1483 with SMTP id kl8-20020a056214518800b0044623f51483mr4871615qvb.19.1649984981121;
        Thu, 14 Apr 2022 18:09:41 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id b126-20020a37b284000000b0069a11927e57sm1683932qkf.101.2022.04.14.18.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 18:09:40 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 56D2A27C0054;
        Thu, 14 Apr 2022 21:09:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 14 Apr 2022 21:09:39 -0400
X-ME-Sender: <xms:0cVYYvEVRk05lqcQuaQgszGcrKLff809n50Kk33Q3BxhQYSltIbWVA>
    <xme:0cVYYsX5r17r0tVf-BmCxeZi0qozEZp_NCNNLMmN1bFcFJeoKKXp4aDp62X7x3qKA
    iKVuQo-Chx2vsv7sw>
X-ME-Received: <xmr:0cVYYhKvUHrBHqaa6d6RO44OIP_FUSTk3Jyucfqwz1AlzOuVWvkrYjXKBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudelgedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepueehjeejieevueeuteeileeuvddvvedvieeltddtudekgeegueelvddtkeet
    tdevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:0cVYYtEiINehftBfnsWz51MZ3a_LWDix7mCuUt_KvEZgNO8nTXq8rg>
    <xmx:0cVYYlVd5goVUJGEXIcjpEfwpEEUbf3oBMFntPZI-xwqVu5v40pkxQ>
    <xmx:0cVYYoO3Mt2xz6lZeNqIlpkPrwp3_e1TCisBV6zZVeJmzBkEZHmY1g>
    <xmx:08VYYj0wViiy6PaRet8aHnSm0agVsfRSRC3NM2gjVf6MrMEgqxZNmEovS7U>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Apr 2022 21:09:35 -0400 (EDT)
Date:   Fri, 15 Apr 2022 09:09:29 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, heiko@sntech.de, guoren@kernel.org,
        shorne@gmail.com, peterz@infradead.org, mingo@redhat.com,
        Will Deacon <will@kernel.org>, longman@redhat.com,
        jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        macro@orcam.me.uk, Greg KH <gregkh@linuxfoundation.org>,
        sudipm.mukherjee@gmail.com, wangkefeng.wang@huawei.com,
        jszhang@kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, openrisc@lists.librecores.org,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 1/7] asm-generic: ticket-lock: New generic
 ticket-based spinlock
Message-ID: <YljFyY7acyRDBmK7@tardis>
References: <20220414220214.24556-1-palmer@rivosinc.com>
 <20220414220214.24556-2-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vliStJTlDzun4Idq"
Content-Disposition: inline
In-Reply-To: <20220414220214.24556-2-palmer@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--vliStJTlDzun4Idq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 14, 2022 at 03:02:08PM -0700, Palmer Dabbelt wrote:
> From: Peter Zijlstra <peterz@infradead.org>
>=20
> This is a simple, fair spinlock.  Specifically it doesn't have all the
> subtle memory model dependencies that qspinlock has, which makes it more
> suitable for simple systems as it is more likely to be correct.  It is
> implemented entirely in terms of standard atomics and thus works fine
> without any arch-specific code.
>=20
> This replaces the existing asm-generic/spinlock.h, which just errored
> out on SMP systems.
>=20
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  include/asm-generic/spinlock.h       | 85 +++++++++++++++++++++++++---
>  include/asm-generic/spinlock_types.h | 17 ++++++
>  2 files changed, 94 insertions(+), 8 deletions(-)
>  create mode 100644 include/asm-generic/spinlock_types.h
>=20
> diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinloc=
k.h
> index adaf6acab172..ca829fcb9672 100644
> --- a/include/asm-generic/spinlock.h
> +++ b/include/asm-generic/spinlock.h
> @@ -1,12 +1,81 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __ASM_GENERIC_SPINLOCK_H
> -#define __ASM_GENERIC_SPINLOCK_H
> +
>  /*
> - * You need to implement asm/spinlock.h for SMP support. The generic
> - * version does not handle SMP.
> + * 'Generic' ticket-lock implementation.
> + *
> + * It relies on atomic_fetch_add() having well defined forward progress
> + * guarantees under contention. If your architecture cannot provide this=
, stick
> + * to a test-and-set lock.
> + *
> + * It also relies on atomic_fetch_add() being safe vs smp_store_release(=
) on a
> + * sub-word of the value. This is generally true for anything LL/SC alth=
ough
> + * you'd be hard pressed to find anything useful in architecture specifi=
cations
> + * about this. If your architecture cannot do this you might be better o=
ff with
> + * a test-and-set.
> + *
> + * It further assumes atomic_*_release() + atomic_*_acquire() is RCpc an=
d hence
> + * uses atomic_fetch_add() which is SC to create an RCsc lock.
> + *
> + * The implementation uses smp_cond_load_acquire() to spin, so if the
> + * architecture has WFE like instructions to sleep instead of poll for w=
ord
> + * modifications be sure to implement that (see ARM64 for example).
> + *
>   */
> -#ifdef CONFIG_SMP
> -#error need an architecture specific asm/spinlock.h
> -#endif
> =20
> -#endif /* __ASM_GENERIC_SPINLOCK_H */
> +#ifndef __ASM_GENERIC_TICKET_LOCK_H
> +#define __ASM_GENERIC_TICKET_LOCK_H
> +
> +#include <linux/atomic.h>
> +#include <asm-generic/spinlock_types.h>
> +
> +static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
> +{
> +	u32 val =3D atomic_fetch_add(1<<16, lock); /* SC, gives us RCsc */
> +	u16 ticket =3D val >> 16;
> +
> +	if (ticket =3D=3D (u16)val)
> +		return;
> +
> +	atomic_cond_read_acquire(lock, ticket =3D=3D (u16)VAL);

Looks like my follow comment is missing:

	https://lore.kernel.org/lkml/YjM+P32I4fENIqGV@boqun-archlinux/

Basically, I suggested that 1) instead of "SC", use "fully-ordered" as
that's a complete definition in our atomic API ("RCsc" is fine), 2)
introduce a RCsc atomic_cond_read_acquire() or add a full barrier here
to make arch_spin_lock() RCsc otherwise arch_spin_lock() is RCsc on
fastpath but RCpc on slowpath.

Regards,
Boqun

> +}
> +
> +static __always_inline bool arch_spin_trylock(arch_spinlock_t *lock)
> +{
> +	u32 old =3D atomic_read(lock);
> +
> +	if ((old >> 16) !=3D (old & 0xffff))
> +		return false;
> +
> +	return atomic_try_cmpxchg(lock, &old, old + (1<<16)); /* SC, for RCsc */
> +}
> +
[...]

--vliStJTlDzun4Idq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAmJYxcUACgkQSXnow7UH
+rihtgf/QlwBFoAeUTlH4MhKKy3Fr6WrwXq/WIgA71uyveBP8XeJF92iatARzevG
wKLiIQzO4VzrpLJ8Ydy+o4ia1xb+nCqwVE0MD2oqPjxwvvyi/7HxZFBI4iq3PZHm
3FRwaGPnNrQGfFmyjM/byXc6uQ/NlPY65rZJcR5wS5j14F5NXAUjOBXrWVQT8nBU
livaSZhbWwyn5oEnzsy/G/oAeD16LIJbjF2pQyX3FPtd1sIlIdOCjWN3TSIM2e2+
enFK5X7w489U+pKfVIOygTWHe95dd9JNsEsSyDmXkTJQnn/cCbYNfI+BR/H2Hc9G
HyLCBV1KDHETDNQ25uo2WoTdfceyNQ==
=T3Uh
-----END PGP SIGNATURE-----

--vliStJTlDzun4Idq--
