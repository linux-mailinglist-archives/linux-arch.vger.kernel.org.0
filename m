Return-Path: <linux-arch+bounces-2029-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A35F6847C56
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 23:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C83561C21F22
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 22:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79C4126F1D;
	Fri,  2 Feb 2024 22:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LEshHdlO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A76126F1A
	for <linux-arch@vger.kernel.org>; Fri,  2 Feb 2024 22:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706913015; cv=none; b=Q8jmN9/fmjE7iCkJi//syk/U9aJm4Zacsp5VOEi5Up7FLF++GvHAv4Q/XOiuatHGlgVzYzBD9rSw+W1Uge0fcwsw6I6MiUR+48yR/IvGlzGdoOGZh6/VPrKErT/gXc2yc19Afo2qlGbIfZl/EbbXItlBMmyP9xxz1wy/9V1/ryU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706913015; c=relaxed/simple;
	bh=OKtyV3UcUMJMPvy1ECKXZVqMjFEDtE8zKK3U8e5aNc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iRyFinloAktBevtbqEMxJL5d6xeaD0viVJlyolXsPx4ypnnZCEjupgJjgkUls/C2p2LJuydGzKtJ+CVcSRo4+TNcD1QfVETjA1oyN1SbTZhQ9QUur3W5US3EyUZ20cQawk7xts6vccoNJUguId4yQV+GM8jPLnoE/SpRyFTHjvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LEshHdlO; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d89f0ab02bso13645ad.1
        for <linux-arch@vger.kernel.org>; Fri, 02 Feb 2024 14:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706913012; x=1707517812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gHfXsDd1+NPNrp7/zCgopLQIxA18bpbncOGieuL0yc=;
        b=LEshHdlOppSpzoGJr8WruYK1DTNCt03hKGKI8sXlRdlXppWl4kSGtqrrZIHPL8AdgZ
         yPAvHazvbYeP3UW10EuIS7/gfckqo//sFstRHgRNjY5QeZxqdpuBoOgVsFZyBRJfYfvm
         QObiDtuZG5KFqWvrELcd5o+HSoNo3yPtOsgKz6NmKbd7moG56psGseipQeyHlMtGVVEa
         ajtwZzlTbO3hkxPC30dn5gvEua/9cmXp2gJLpLSRAnd21tHC4cTCBNvl20ePBFTg90if
         C3K+uIkPoptT6yZurR6Ezt+52XOd6VF4OGxtz3RacOZxirHfUmF7HjS6m1MvMXR2NUQr
         bfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706913012; x=1707517812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gHfXsDd1+NPNrp7/zCgopLQIxA18bpbncOGieuL0yc=;
        b=CHMQcaAHUqrQm1xGZZ/5NeJ/2QGzM16Lomsi8g7cgDuIrCTKMZM1goNcORyFncSoa9
         F0jRnxlz19fWNIMSnx9mzDGHTFalgRtd8UEbCOqlQx0/H6l0ahZ1ow2mZC/Bk4SeHlnG
         oZR5ePl06AWBLR3BHwt6+pKF0GBYlUZ47H07mtndacABIXMKOz0JRFS6sp9QfUnedosK
         fzN6k1OMXfhCjiTHcLirkJcnMjA5D8V7g0950KQF9LYqkAS3W5orr3vL4mT+Iz4V8CjT
         b5OTsXhU6jfo67mqSyKUmMQINghjNYzmsxWh1zP3KmNCqFPUYNJeh+0poK78yfPfrjTn
         Nscw==
X-Gm-Message-State: AOJu0Yx4DZjILKbC2+fdAsFI0Ly0qkPhhwPa1uVUci4EoUCkj5Cfl9Cu
	U5vQghI+7tncwjqTiqvyLa1mkj5VECFsDJgUZhST2BwUJdbn0gDh/FmNO8YXRMSCkqR/tL+s4Qu
	s4qZ8hcBLjQFCZZsdsTvVhk7GvB/ZQaPw9X6q
X-Google-Smtp-Source: AGHT+IGYPtzOWKJUHpZOUv3WD2/u8xqCH2po02LT82xgQd99fQsVzRN06AKewo08mu5evakZqsXkrrjcw9wBJU3p9vw=
X-Received: by 2002:a17:903:2349:b0:1d8:aada:a7e3 with SMTP id
 c9-20020a170903234900b001d8aadaa7e3mr26544plh.3.1706913011645; Fri, 02 Feb
 2024 14:30:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125164256.4147-1-alexandru.elisei@arm.com> <20240125164256.4147-23-alexandru.elisei@arm.com>
In-Reply-To: <20240125164256.4147-23-alexandru.elisei@arm.com>
From: Evgenii Stepanov <eugenis@google.com>
Date: Fri, 2 Feb 2024 14:30:00 -0800
Message-ID: <CAFKCwrhNE5PR7cu7tN8qMmSEUhdJ7ensGGrB-oodh-J_fdoRcw@mail.gmail.com>
Subject: Re: [PATCH RFC v3 22/35] arm64: mte: Enable tag storage if CMA areas
 have been activated
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev, 
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	mhiramat@kernel.org, rppt@kernel.org, hughd@google.com, pcc@google.com, 
	steven.price@arm.com, anshuman.khandual@arm.com, vincenzo.frascino@arm.com, 
	david@redhat.com, kcc@google.com, hyesoo.yu@samsung.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 8:44=E2=80=AFAM Alexandru Elisei
<alexandru.elisei@arm.com> wrote:
>
> Before enabling MTE tag storage management, make sure that the CMA areas
> have been successfully activated. If a CMA area fails activation, the pag=
es
> are kept as reserved. Reserved pages are never used by the page allocator=
.
>
> If this happens, the kernel would have to manage tag storage only for som=
e
> of the memory, but not for all memory, and that would make the code
> unreasonably complicated.
>
> Choose to disable tag storage management altogether if a CMA area fails t=
o
> be activated.
>
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>
> Changes since v2:
>
> * New patch.
>
>  arch/arm64/include/asm/mte_tag_storage.h | 12 ++++++
>  arch/arm64/kernel/mte_tag_storage.c      | 50 ++++++++++++++++++++++++
>  2 files changed, 62 insertions(+)
>
> diff --git a/arch/arm64/include/asm/mte_tag_storage.h b/arch/arm64/includ=
e/asm/mte_tag_storage.h
> index 3c2cd29e053e..7b3f6bff8e6f 100644
> --- a/arch/arm64/include/asm/mte_tag_storage.h
> +++ b/arch/arm64/include/asm/mte_tag_storage.h
> @@ -6,8 +6,20 @@
>  #define __ASM_MTE_TAG_STORAGE_H
>
>  #ifdef CONFIG_ARM64_MTE_TAG_STORAGE
> +
> +DECLARE_STATIC_KEY_FALSE(tag_storage_enabled_key);
> +
> +static inline bool tag_storage_enabled(void)
> +{
> +       return static_branch_likely(&tag_storage_enabled_key);
> +}
> +
>  void mte_init_tag_storage(void);
>  #else
> +static inline bool tag_storage_enabled(void)
> +{
> +       return false;
> +}
>  static inline void mte_init_tag_storage(void)
>  {
>  }
> diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_=
tag_storage.c
> index 9a1a8a45171e..d58c68b4a849 100644
> --- a/arch/arm64/kernel/mte_tag_storage.c
> +++ b/arch/arm64/kernel/mte_tag_storage.c
> @@ -19,6 +19,8 @@
>
>  #include <asm/mte_tag_storage.h>
>
> +__ro_after_init DEFINE_STATIC_KEY_FALSE(tag_storage_enabled_key);
> +
>  struct tag_region {
>         struct range mem_range; /* Memory associated with the tag storage=
, in PFNs. */
>         struct range tag_range; /* Tag storage memory, in PFNs. */
> @@ -314,3 +316,51 @@ void __init mte_init_tag_storage(void)
>         num_tag_regions =3D 0;
>         pr_info("MTE tag storage region management disabled");
>  }
> +
> +static int __init mte_enable_tag_storage(void)
> +{
> +       struct range *tag_range;
> +       struct cma *cma;
> +       int i, ret;
> +
> +       if (num_tag_regions =3D=3D 0)
> +               return 0;
> +
> +       for (i =3D 0; i < num_tag_regions; i++) {
> +               tag_range =3D &tag_regions[i].tag_range;
> +               cma =3D tag_regions[i].cma;
> +               /*
> +                * CMA will keep the pages as reserved when the region fa=
ils
> +                * activation.
> +                */
> +               if (PageReserved(pfn_to_page(tag_range->start)))
> +                       goto out_disabled;
> +       }
> +
> +       static_branch_enable(&tag_storage_enabled_key);
> +       pr_info("MTE tag storage region management enabled");
> +
> +       return 0;
> +
> +out_disabled:
> +       for (i =3D 0; i < num_tag_regions; i++) {
> +               tag_range =3D &tag_regions[i].tag_range;
> +               cma =3D tag_regions[i].cma;
> +
> +               if (PageReserved(pfn_to_page(tag_range->start)))
> +                       continue;
> +
> +               /* Try really hard to reserve the tag storage. */
> +               ret =3D cma_alloc(cma, range_len(tag_range), 8, true);
> +               /*
> +                * Tag storage is still in use for data, memory and/or ta=
g
> +                * corruption will ensue.
> +                */
> +               WARN_ON_ONCE(ret);

cma_alloc returns (page *), so this condition needs to be inverted,
and the type of `ret` changed.
Not sure how it slipped through, this is a compile error with clang.

> +       }
> +       num_tag_regions =3D 0;
> +       pr_info("MTE tag storage region management disabled");
> +
> +       return -EINVAL;
> +}
> +arch_initcall(mte_enable_tag_storage);
> --
> 2.43.0
>

