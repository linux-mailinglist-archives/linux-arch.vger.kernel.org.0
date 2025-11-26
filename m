Return-Path: <linux-arch+bounces-15080-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2C6C888A1
	for <lists+linux-arch@lfdr.de>; Wed, 26 Nov 2025 09:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBB464E2C1D
	for <lists+linux-arch@lfdr.de>; Wed, 26 Nov 2025 08:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B49429D269;
	Wed, 26 Nov 2025 08:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHoH3Dgo"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C102877D9
	for <linux-arch@vger.kernel.org>; Wed, 26 Nov 2025 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764144172; cv=none; b=rJu1xL9Zsb4jTRCYZfiDqvB21te5gjReSH/oz65P6L1YAMGPtZaRcgI1BYXaQ8sbc0+z7H8TwzCH8IxXzNqnfs9axH5N/Y1t6bFV6QW6oRel21NqOWyYc1LQxPHd+TBE7uPOZPwvUCmQQohEmGNH3d+/paEl3maBWGms2bTZKbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764144172; c=relaxed/simple;
	bh=VrVVNYgQQe2YqVbBdaNiWgaQnQvw8/RbxdtxMN/zYMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWmj6Wv7FuenSy1ey5dn7qhwsYzKabedR8Nk5VDGDGmeF8V9Ob99Y4r3l3HhHZEQ/JiWLHt1SfQlyjU45PXQ/87s5JSNMHQSPV/q+9yxmth61A84SlDZdEBnQL65tkPEObPw9x22R3qIup2FNVDvz6kVr3e2vs1UQC1myok/r1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHoH3Dgo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4274C116D0
	for <linux-arch@vger.kernel.org>; Wed, 26 Nov 2025 08:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764144171;
	bh=VrVVNYgQQe2YqVbBdaNiWgaQnQvw8/RbxdtxMN/zYMg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tHoH3Dgo4TRSlMkVJrJjE8Q4Az28rNtMCzpoMSZRGEcdwcmtEvbwszIrMm3xL1i2B
	 XIarIWDn1fK5Q7U6bc5p/SSYEtB2g3vxr4q7QbPA36UBtqlca3lnhqgMJYO8e9OHlw
	 iIP79LLTYcS/uuouC2gj8q5FnVxAxMkYE3etjzYZVCY0fpAB3gvuika5C4Mrapy1w+
	 8BX8v9Nztm7MzWwsb+YSmgtTsluPza1RBFlbp6fqFMq2cLBYkxYDeXDYfKbSwmdAeo
	 pwykR/7M84KPDAJ/hcunAc7at8gPRIyAlW8CrM9SdplMMWK1BhohVK/4m5jKHZr7ep
	 6FhVhfMECHSjQ==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b762de65c07so464706066b.2
        for <linux-arch@vger.kernel.org>; Wed, 26 Nov 2025 00:02:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXbKkFZHtFE0HtUJxdtzLFH8l9VxyWBDZf3ZK3qAJhBxYVgO4pUAeDfUJbk/P5FXVMaqWu1GL10D7b7@vger.kernel.org
X-Gm-Message-State: AOJu0YyIJA9hWEIjqtHJkfh19BeJ0x2NRBQjv2CsC+6Rh+9VvLWh3Wxp
	hLl0i+5m/7VEErrAfGlWxE3uwplGgXF9UwOpKPHCavh6JFff44//R8b35vh+olMWqa+sXg3ZlzX
	0yPwq06nu2ZfkVGpNEqlVWt1XHF1RMa4=
X-Google-Smtp-Source: AGHT+IFPdB9GrEj8p0VC5xTh31pkH2puuW/Mtnce1zb0KHNsSpM0nLVPXZv02VaFB9C/TQ3cERS6/3GRiMNuGKZ3CjU=
X-Received: by 2002:a17:907:1ca8:b0:b76:4c16:6b06 with SMTP id
 a640c23a62f3a-b76c546d9demr642647266b.1.1764144170323; Wed, 26 Nov 2025
 00:02:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122043634.3447854-1-chenhuacai@loongson.cn>
 <20251122043634.3447854-14-chenhuacai@loongson.cn> <0b2bf90e-f148-46ad-92e4-b177d412fd11@t-8ch.de>
 <3407d536-a9b5-48e8-a9cf-4bb590941d0a@app.fastmail.com> <CAAhV-H4Df+c47ocBn2SN3iHDbFWGg9-i2+wY27TvtcpBa=pp7Q@mail.gmail.com>
 <4c58592d-224b-481c-a728-3c279f8e55cd@app.fastmail.com>
In-Reply-To: <4c58592d-224b-481c-a728-3c279f8e55cd@app.fastmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 26 Nov 2025 16:02:54 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5D=4ZhDLQOupyO0OOkuq2AWOGFBLpR8yAxaJcXb=QmRA@mail.gmail.com>
X-Gm-Features: AWmQ_bl1vrMInXIOqwtLq2Ibt5NuiLQHamZuZ-w5BxZH3xqyYJowxFarxnY9pHg
Message-ID: <CAAhV-H5D=4ZhDLQOupyO0OOkuq2AWOGFBLpR8yAxaJcXb=QmRA@mail.gmail.com>
Subject: Re: [PATCH V3 13/14] LoongArch: Adjust default config files for 32BIT/64BIT
To: Arnd Bergmann <arnd@arndb.de>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev, 
	Linux-Arch <linux-arch@vger.kernel.org>, Xuefeng Li <lixuefeng@loongson.cn>, 
	guoren <guoren@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 1:55=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Sat, Nov 22, 2025, at 15:13, Huacai Chen wrote:
> > On Sat, Nov 22, 2025 at 7:57=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
> >> On Sat, Nov 22, 2025, at 10:45, Thomas Wei=C3=9Fschuh wrote:
> >> > On 2025-11-22 12:36:33+0800, Huacai Chen wrote:
> >> >> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> >> >> index 96ca1a688984..cf9373786969 100644
> >> >> --- a/arch/loongarch/Makefile
> >> >> +++ b/arch/loongarch/Makefile
> >> >> @@ -5,7 +5,12 @@
> >> >>
> >> >>  boot        :=3D arch/loongarch/boot
> >> >>
> >> >> -KBUILD_DEFCONFIG :=3D loongson3_defconfig
> >> >> +ifdef CONFIG_32BIT
> >> >
> >> > Testing for CONFIG options here doesn't make sense, as the config is=
 not yet
> >> > created.
> >>
> >> > Either test for $(ARCH) or uname or just use one unconditionally.
> >>
> >> I don't really like the $(ARCH) hacks, nobody is going to build kernel=
s
> >> natively on loongarch32, and for the rest it's fine to set the option.
> > OK, I will use 'uname -m' for checking. Though native builds on
> > loongarch32 will hardly happen, we can give a small chance to use
> > loongson32_defconfig, in all other cases, let's use
> > loongson64_defconfig.
>
> What I meant is not to guess the CONFIG_64BIT option from any
> part of the build environment other than the actual .config settings.
>
> $(ARCH) is initialized from 'uname -m' in scripts/subarch.include,
> and I think this should stay unchanged.
>
> >> > Also as mentioned before, snippets can reduce the duplication.
> >> >
> >> >> +KBUILD_DEFCONFIG :=3D loongson32_defconfig
> >> >> +else
> >> >> +KBUILD_DEFCONFIG :=3D loongson64_defconfig
> >> >> +endif
> >> >> +
> >>
> >> This is also not the change I had suggested in my review. I think this
> >> should be a fragment along the lines of arch/mips/configs/generic/32r2=
.config
> >> and arch/powerpc/configs/book3s_32.config.
> >
> > Sorry for that. I know that the default config file is usually
> > generated by 'make savedefconfig', and the main purpose is
> > significantly reducing file size. I did that, but manually add some
> > lines such as CONFIG_LOONGARCH, CONFIG_32BIT/64BIT, CONFIG_ACPI,
> > CONFIG_EFI, etc. My original goal of doing this is to let users easily
> > know those fundamental options without reading Kconfig files (of
> > course we should not increase the defconfig too much).
> >
> > Sorry again for not explaining about this in the previous version.
>
> I don't mind having the extra options in the generic defconfig
> file, that is unusual but I see your logic there.
>
> My point here is that you should absolutely not duplicate the
> contents but only put the differences into the new file, such
> as
>
> +++ arch/loongarch/configs/loongson32.config
> CONFIG_32BIT=3Dy
> # CONFIG_64BIT is not set
> CONFIG_32BIT_STANDARD=3Dy
> CONFIG_MACH_LOONGSON32=3Dy
> # CONFIG_SMP is not set
> # CONFIG_LOONGSON3_CPUFREQ is not set
> # CONFIG_IPMI_HANDLER is not set
> # CONFIG_TCG_TPM is not set
> # CONFIG_I2C_LS2X is not set
> # CONFIG_PINCTRL_LOONGSON2 is not set
> CONFIG_GPIO_LOONGSON1=3Dy
> # CONFIG_GPIO_LOONGSON is not set
> CONFIG_WATCHDOG=3Dy
> CONFIG_LOONGSON1_WDT=3Dm
> # CONFIG_LOONGSON2_THERMAL=3Dm is not set
>  # CONFIG_IOMMU_SUPPORT is not set
> CONFIG_LOONGSON1_APB_DMA=3Dy
> # CONFIG_LOONGSON2_APB_DMA is not set
> # CONFIG_PWM_LOONGSON is not set
OK,  now I completely understand your point, thank you.

>
> This way, running 'make defconfig; make loongson32.config'
> should produce the same output as your current
> 'make loongson32_defconfig', but it is much easier to keep
> the two in sync because any future changes only
> have to be done in the shared file.
This solution solve the synchronization issue, but break a widely used work=
flow:
cp xxxx_defconfig .config
make menuconfig  # or something similar
make

If there is a solution similar to dts/dtsi (different dts include the
same dtsi as a common basis), that will be better.

But for now, I prefer to use two independent config files. Fortunately
there are only two so synchronization is not a big problem...

Huacai

>
>      Arnd
>

