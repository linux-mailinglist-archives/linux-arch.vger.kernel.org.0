Return-Path: <linux-arch+bounces-9099-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F309C930A
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 21:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26ED828537D
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 20:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7801AC885;
	Thu, 14 Nov 2024 20:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZND+Sptg"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89DE1ABEB1;
	Thu, 14 Nov 2024 20:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731615247; cv=none; b=hgd45yJYQq4qJ96+ZkfmU4WRFQY0L0qWymho1FknA+jxy5/DqWNvhtoACMbulI9kuZj/MbNqUbv/wtnwHJD7V3JCDiTJxW+28aEfRyeo90fTfPstCXrfxdrlOgEythc/jrtObTrg7K7p3T5wuebUOoBJxlOldhw19kMWsjS4+5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731615247; c=relaxed/simple;
	bh=3AnO/8ZV27kP0QyUAzkv+si5CrbZ1Sbbzjbc7nRe4ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GUco+ymFWkxllwhj8GPqj2zao/E8WpcdyCaSfzo0bPHXPjl+GPcDpNktX1R81QffeWHZ/Gc6lj9JGkjzaSPWGYz9vT0c31Cbdr6t6F4Rxxb4SYwdqcXNkmm6bATqyF1tF3cAThi9EfH5MlSJvc7MaF/jvoBHhZlyK66iCVZMBHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZND+Sptg; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb5740a03bso11587591fa.1;
        Thu, 14 Nov 2024 12:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731615244; x=1732220044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=av/9TFaJbFWal8BUloZTyUIxlmKHSA+RDh/rnTL+oJs=;
        b=ZND+Sptgb0BjPL+FIZsB6vTFitXe5gM6RiP9JUpe7x4+DNjyagJBvGHSCFZ80co+HB
         vB0WLaEXAIcQeQUjBrF2X5pdOPZDAQKOwcAnd5m+mDhckirXzv7C0VeQRSpdULwGI2QY
         9L5BINyVF1Nom8CjDv4i8sgUSMYoYwaHzY3496sKxHCQhtRlJY1U8LYXhmmo48sdiL/1
         9Sbuaw+qgyNkG7NwEnAztqoBTYxsKUyU0R3MGtl6mICaiVq2DBXyT6o05mKTdAGQFMiZ
         qGncYJla0qDuW5DSYyz4qpANRIpb1WSO3+AFc7Z83Dhyq9/6K4OmD74LH+UQrzZUVSa6
         kVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731615244; x=1732220044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=av/9TFaJbFWal8BUloZTyUIxlmKHSA+RDh/rnTL+oJs=;
        b=U28a8YoVvDfOKGBf3ZnhcAnY81fm2zNgBiqt2UashrUXA0OFHcIRRT54bPsIb4TCSC
         dwXLDkNX72bC2NPkONP8QKijXQ8oUkox6uJWijvNhn+/Jlrz7OnrhWqxVIuyQtRY3iGO
         wNnIG8JziCHAuW5P9OZRAN/WbqYHR3BGVxUp7TXdv+DmrChm3C2QrUMfJg2nuPVMoj2k
         4LzrpeA4fxxVJzRGCF2gydcKVadrDjb1t1VXKxVMzLnKKEz7jif2HaVApGsg9MXdQcd5
         QZ6C0KIjCv6mcN/KndS8+q4Hd+DLa+/wgHIuoVoOOQRIhnOcm6XsmjktrJis9R/LQuub
         FaqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2Yb5/GHZtX5GNUGLZF1FFfoAqgusLZ+iYnG6ZkTjbfntfOctR3lSs6KFDIn0Lb49jfNDHKMPYshPU@vger.kernel.org
X-Gm-Message-State: AOJu0YwjG9ppxyorwdr1tWhkRXyq5WLKRuqXg4/fuRZvFco3cuioF0DS
	/tU4SVa8YVvMVsO1/eFCbXP7nbowDz7U47x/pU4XkkF4xSowFEqY84n9dm/6S1kdHwCYW5dYNIn
	IGOwmhMy5t0dDdm03wBLJQ5qHN6Y=
X-Google-Smtp-Source: AGHT+IGznMbloXILAQ3orLPc7WleInXZdIqxmlq+WbL661Q0VlrRsVonaRhMcJCqU8eeuNzcAyOBO7ShhaNTEOoTfkk=
X-Received: by 2002:a05:651c:2120:b0:2fb:382e:410b with SMTP id
 38308e7fff4ca-2ff606de9e5mr1844751fa.32.1731615243754; Thu, 14 Nov 2024
 12:14:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114194436.389961-1-suravee.suthikulpanit@amd.com> <20241114194436.389961-5-suravee.suthikulpanit@amd.com>
In-Reply-To: <20241114194436.389961-5-suravee.suthikulpanit@amd.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 14 Nov 2024 21:13:52 +0100
Message-ID: <CAFULd4b9U9K=LjY+iW7Ectqy+-UpvytozELV6DGx0wNqE-z72A@mail.gmail.com>
Subject: Re: [PATCH v11 4/9] iommu/amd: Introduce helper function to update
 256-bit DTE
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org, 
	robin.murphy@arm.com, vasant.hegde@amd.com, arnd@arndb.de, 
	linux-arch@vger.kernel.org, jgg@nvidia.com, kevin.tian@intel.com, 
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com, 
	kumaranand@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 8:45=E2=80=AFPM Suravee Suthikulpanit
<suravee.suthikulpanit@amd.com> wrote:
>
> The current implementation does not follow 128-bit write requirement
> to update DTE as specified in the AMD I/O Virtualization Techonology
> (IOMMU) Specification.
>
> Therefore, modify the struct dev_table_entry to contain union of u128 dat=
a
> array, and introduce a helper functions update_dte256() to update DTE usi=
ng
> two 128-bit cmpxchg operations to update 256-bit DTE with the modified
> structure, and take into account the DTE[V, GV] bits when programming
> the DTE to ensure proper order of DTE programming and flushing.
>
> In addition, introduce a per-DTE spin_lock struct dev_data.dte_lock to
> provide synchronization when updating the DTE to prevent cmpxchg128
> failure.
>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Suggested-by: Uros Bizjak <ubizjak@gmail.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  10 ++-
>  drivers/iommu/amd/iommu.c           | 123 ++++++++++++++++++++++++++++
>  2 files changed, 132 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_=
iommu_types.h
> index ae5f1e031722..ea7922b06325 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -427,9 +427,13 @@
>  #define DTE_GCR3_SHIFT_C       43
>
>  #define DTE_GPT_LEVEL_SHIFT    54
> +#define DTE_GPT_LEVEL_MASK     GENMASK_ULL(55, 54)
>
>  #define GCR3_VALID             0x01ULL
>
> +/* DTE[128:179] | DTE[184:191] */
> +#define DTE_DATA2_INTR_MASK    ~GENMASK_ULL(55, 52)
> +
>  #define IOMMU_PAGE_MASK (((1ULL << 52) - 1) & ~0xfffULL)
>  #define IOMMU_PTE_PRESENT(pte) ((pte) & IOMMU_PTE_PR)
>  #define IOMMU_PTE_DIRTY(pte) ((pte) & IOMMU_PTE_HD)
> @@ -842,6 +846,7 @@ struct devid_map {
>  struct iommu_dev_data {
>         /*Protect against attach/detach races */
>         struct mutex mutex;
> +       spinlock_t dte_lock;              /* DTE lock for 256-bit access =
*/
>
>         struct list_head list;            /* For domain->dev_list */
>         struct llist_node dev_data_list;  /* For global dev_data_list */
> @@ -886,7 +891,10 @@ extern struct list_head amd_iommu_list;
>   * Structure defining one entry in the device table
>   */
>  struct dev_table_entry {
> -       u64 data[4];
> +       union {
> +               u64 data[4];
> +               u128 data128[2];
> +       };
>  };
>
>  /*
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 5ce8e6504ba7..7e0b62f2268a 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -83,12 +83,125 @@ static int amd_iommu_attach_device(struct iommu_doma=
in *dom,
>  static void set_dte_entry(struct amd_iommu *iommu,
>                           struct iommu_dev_data *dev_data);
>
> +static void iommu_flush_dte_sync(struct amd_iommu *iommu, u16 devid);
> +
>  /***********************************************************************=
*****
>   *
>   * Helper functions
>   *
>   ***********************************************************************=
*****/
>
> +static __always_inline void amd_iommu_atomic128_set(__int128 *ptr, __int=
128 val)
> +{
> +       /*
> +        * Note:
> +        * We use arch_try_cmpxchg128_local() because:
> +        * - Need cmpxchg16b instruction mainly for 128-bit store to DTE
> +        *   (not necessary for cmpxchg since this function is already
> +        *   protected by a spin_lock for this DTE).
> +        * - Neither need LOCK_PREFIX nor try loop because of the spin_lo=
ck.
> +        */
> +       arch_try_cmpxchg128_local(ptr, ptr, val);

Just use arch_cmpxchg128_local() here.

With that:

Acked-by: Uros Bizjak <ubizjak@gmail.com>.

Uros.

