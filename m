Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF3053A4BA
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jun 2022 14:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352125AbiFAMS6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jun 2022 08:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352111AbiFAMS5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2022 08:18:57 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACCC5D5E4;
        Wed,  1 Jun 2022 05:18:56 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 068A15C0278;
        Wed,  1 Jun 2022 08:18:56 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute4.internal (MEProxy); Wed, 01 Jun 2022 08:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1654085936; x=
        1654172336; bh=ck6jV8ttB6Cc5FpNzx7+BJgi2hR0Y7XaiuRUWcfFgQs=; b=m
        CQhUDR1PAkTM260qLvHxronKQb6UMJxm4fdOnxTqW0YtFcBZjju47Gge/jPB1cq1
        8WZtVipcj/5r4REVMaOa9xwHJhF1W2/G+mDcyqomi192ji6H9eVAq37GzdmB4H5w
        2pyRy2zfS0yBrCQvkciorhR+jqZPT0yJ/3oqJwiHQ5Jkk6jSkFr5ohmBzaXCklPt
        kgFpWxRSUqswwFRiCgAcsbs30g+hkVls9LgdMW+vTE/jhyNmMIsUrDBDs1IrT5Vp
        hFklGIKufrE077QUYkFw86dSYIYz7Qd4EZ9mS8zH7mH/POSzKVQ4tv3RQRUnC6w1
        HN38uzrAsYUEeDkD7cNDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1654085936; x=
        1654172336; bh=ck6jV8ttB6Cc5FpNzx7+BJgi2hR0Y7XaiuRUWcfFgQs=; b=M
        SXnkMLkfCGTXqjw+vptWSgTtehxogqGcXv4exIJsDAqQnB5pvzVKc9cGV7ZxE4fX
        E8WY0JsRqm+P+wNiuOAOTWjV0cZJu8lCmEzs/GjWvms6kjrOawCHDa6pCWd3aDbb
        bYXMheqGBper3pGZTCB0/T69EGq0rgP8xOXyl7QfmdH8KHGDb38Z608EZCUWGZdV
        1EQX+Qr7QMkQs4RZ5xJ7FgMVu1WCOepCH7FO5OdNmTFNL5AWjQjOoNQ6ZUoooeXC
        q4fZt3M7LWWujappI51KO6Vinl4Uth04O9PcLscgnIdGSui1xu8/5cctvxrurQEF
        8e4jcsc0ciiLaOg90mJgA==
X-ME-Sender: <xms:L1mXYp07122YCQz2XtwcXFoeWiBKqpJwFpgcATvSad03odJRBgpjug>
    <xme:L1mXYgGM5YZ2MhUfPqAr-iJIq2nL63C4i4gB4cZpOdjyWpljJwzu0WpP9ocPbtJZU
    b1vPIOz6_4sahMA-io>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrledtgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
    rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    eqnecuggftrfgrthhtvghrnhepudefgeeftedugeehffdtheefgfevffelfefghefhjeeu
    geevtefhudduvdeihefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:L1mXYp7a0ZFTcocxTGXeCCkXnpwLu6wAvUuzV-K1BLdydtLyshzrtg>
    <xmx:L1mXYm11T3NZ-hPydAvdy1TkiKTrwuxKzJT2YI4lvvAuz-pcmf2J4w>
    <xmx:L1mXYsGxFH8OCJAckOfRANeio789m3WiKHdcbBrfnQt_uBSg_W6S3w>
    <xmx:MFmXYqX__o5QH6CNOaUwpPA4dzhnioAOi_QnLWsYTEk5vkdSgUHa6g>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A496D36A006F; Wed,  1 Jun 2022 08:18:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-591-gfe6c3a2700-fm-20220427.001-gfe6c3a27
Mime-Version: 1.0
Message-Id: <1ccd9ba8-3984-49e9-b1b2-805acdf3090c@www.fastmail.com>
In-Reply-To: <20220601100005.2989022-6-chenhuacai@loongson.cn>
References: <20220601100005.2989022-1-chenhuacai@loongson.cn>
 <20220601100005.2989022-6-chenhuacai@loongson.cn>
Date:   Wed, 01 Jun 2022 13:18:35 +0100
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Huacai Chen" <chenhuacai@loongson.cn>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "David Airlie" <airlied@linux.ie>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Xuefeng Li" <lixuefeng@loongson.cn>,
        "Yanteng Si" <siyanteng@loongson.cn>,
        "Huacai Chen" <chenhuacai@gmail.com>,
        "Guo Ren" <guoren@kernel.org>, "Xuerui Wang" <kernel@xen0n.name>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        "WANG Xuerui" <git@xen0n.name>
Subject: Re: [PATCH V12 05/24] LoongArch: Add ELF-related definitions
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



=E5=9C=A82022=E5=B9=B46=E6=9C=881=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8A=E5=
=8D=8810:59=EF=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
> Add ELF-related definitions for LoongArch, including: EM_LOONGARCH,
> KEXEC_ARCH_LOONGARCH, AUDIT_ARCH_LOONGARCH32, AUDIT_ARCH_LOONGARCH64
> and NT_LOONGARCH_*.
>
> Reviewed-by: WANG Xuerui <git@xen0n.name>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>


> ---
>  include/uapi/linux/audit.h  | 2 ++
>  include/uapi/linux/elf-em.h | 1 +
>  include/uapi/linux/elf.h    | 5 +++++
>  include/uapi/linux/kexec.h  | 1 +
>  scripts/sorttable.c         | 5 +++++
>  5 files changed, 14 insertions(+)
>
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 8eda133ca4c1..7c1dc818b1d5 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -439,6 +439,8 @@ enum {
>  #define AUDIT_ARCH_UNICORE	(EM_UNICORE|__AUDIT_ARCH_LE)
>  #define=20
> AUDIT_ARCH_X86_64	(EM_X86_64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
>  #define AUDIT_ARCH_XTENSA	(EM_XTENSA)
> +#define AUDIT_ARCH_LOONGARCH32	(EM_LOONGARCH|__AUDIT_ARCH_LE)
> +#define=20
> AUDIT_ARCH_LOONGARCH64	(EM_LOONGARCH|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_L=
E)
>=20
>  #define AUDIT_PERM_EXEC		1
>  #define AUDIT_PERM_WRITE	2
> diff --git a/include/uapi/linux/elf-em.h b/include/uapi/linux/elf-em.h
> index f47e853546fa..ef38c2bc5ab7 100644
> --- a/include/uapi/linux/elf-em.h
> +++ b/include/uapi/linux/elf-em.h
> @@ -51,6 +51,7 @@
>  #define EM_RISCV	243	/* RISC-V */
>  #define EM_BPF		247	/* Linux BPF - in-kernel virtual machine */
>  #define EM_CSKY		252	/* C-SKY */
> +#define EM_LOONGARCH	258	/* LoongArch */
>  #define EM_FRV		0x5441	/* Fujitsu FR-V */
>=20
>  /*
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index c4abd09c3da9..2b9f5e9985e5 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -438,6 +438,11 @@ typedef struct elf64_shdr {
>  #define NT_MIPS_DSP	0x800		/* MIPS DSP ASE registers */
>  #define NT_MIPS_FP_MODE	0x801		/* MIPS floating-point mode */
>  #define NT_MIPS_MSA	0x802		/* MIPS SIMD registers */
> +#define NT_LOONGARCH_CPUCFG	0xa00	/* LoongArch CPU config registers */
> +#define NT_LOONGARCH_CSR	0xa01	/* LoongArch control and status=20
> registers */
> +#define NT_LOONGARCH_LSX	0xa02	/* LoongArch Loongson SIMD Extension=20
> registers */
> +#define NT_LOONGARCH_LASX	0xa03	/* LoongArch Loongson Advanced SIMD=20
> Extension registers */
> +#define NT_LOONGARCH_LBT	0xa04	/* LoongArch Loongson Binary=20
> Translation registers */
>=20
>  /* Note types with note name "GNU" */
>  #define NT_GNU_PROPERTY_TYPE_0	5
> diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
> index fb7e2ef60825..981016e05cfa 100644
> --- a/include/uapi/linux/kexec.h
> +++ b/include/uapi/linux/kexec.h
> @@ -43,6 +43,7 @@
>  #define KEXEC_ARCH_MIPS    ( 8 << 16)
>  #define KEXEC_ARCH_AARCH64 (183 << 16)
>  #define KEXEC_ARCH_RISCV   (243 << 16)
> +#define KEXEC_ARCH_LOONGARCH	(258 << 16)
>=20
>  /* The artificial cap on the number of segments passed to kexec_load.=
 */
>  #define KEXEC_SEGMENT_MAX 16
> diff --git a/scripts/sorttable.c b/scripts/sorttable.c
> index d00504c5f530..fba40e99f354 100644
> --- a/scripts/sorttable.c
> +++ b/scripts/sorttable.c
> @@ -60,6 +60,10 @@
>  #define EM_RISCV	243
>  #endif
>=20
> +#ifndef EM_LOONGARCH
> +#define EM_LOONGARCH	258
> +#endif
> +
>  static uint32_t (*r)(const uint32_t *);
>  static uint16_t (*r2)(const uint16_t *);
>  static uint64_t (*r8)(const uint64_t *);
> @@ -313,6 +317,7 @@ static int do_file(char const *const fname, void *=
addr)
>  	case EM_ARCOMPACT:
>  	case EM_ARCV2:
>  	case EM_ARM:
> +	case EM_LOONGARCH:
>  	case EM_MICROBLAZE:
>  	case EM_MIPS:
>  	case EM_XTENSA:
> --=20
> 2.27.0

--=20
- Jiaxun
