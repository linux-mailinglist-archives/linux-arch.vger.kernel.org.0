Return-Path: <linux-arch+bounces-10605-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0EEA594EB
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 13:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D43853AA63B
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 12:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC12227574;
	Mon, 10 Mar 2025 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYEfG9IY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C7D226D11;
	Mon, 10 Mar 2025 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741610486; cv=none; b=t4dS3mdcDc2PO04npzaMWscWumHLjc4P35yEr9wwV9HQx+ZpzSvOZ7iXPzo48fPM2kEvyn8d2d4KGVeJfEqC2Ud/FJ3lPaQi7I+CL5uycWVqtI3W3NVy1o2lTUBGC1HhTjqvTmmZDywvtxcldaNidkFX1qj6Xq0uCaZ0gNt+auM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741610486; c=relaxed/simple;
	bh=u2hb92Bf5/2pZjEymGfvJqesYHZmbFv63xQHrBpvJ/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbp7gUFDsoUtxomN4uOXuPPD/gK+CA8N3ej7BAhbyq3QnmX+Eu1F5p/kVPf9N4sABK/Gq7cso+nVRqGN01Hs/H84gH9TE+Sulbl11yBLjtnUkgMIODUkVlGcYN46iyGrpdwzQYP64RQAn/vxOiH6Rn2J61iP45fe5O4lzkCS0AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYEfG9IY; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e614da8615so3781033a12.1;
        Mon, 10 Mar 2025 05:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741610483; x=1742215283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2hb92Bf5/2pZjEymGfvJqesYHZmbFv63xQHrBpvJ/A=;
        b=NYEfG9IYonEalasQ9ZEuO9Sm6iR1UT+qGCc6vybQZKwRGbQ1MJeRmLgH2JV2Ho1pTB
         gfF3b/ZK1jK7o8nJjwTMMKeCSHn7BOqQVH4oBU/6BIo8+5OqHSHTWmwln/uF595P+bph
         E+n27ZhXj9qpGjQZj2/i3Z1lYAXVdscbHMJIVHqWXxHBB+5XtSjRGCJthsDH0s0TRaE6
         KqeVVOasS52fLs2HVKBPnArnZmKkXxPkXXYoNrZceBN3ba9jJ6Xw2II+avaSFt+1Vd5h
         qbTsd9uENAJTEBim6FXsfwqDMm7ASQEaCOwoVKtmv+u2017XP7vfJvh1sCW7/v72bSZD
         JEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741610483; x=1742215283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2hb92Bf5/2pZjEymGfvJqesYHZmbFv63xQHrBpvJ/A=;
        b=AsMZJbT9oyos9i1MSG3qMA8TSd9SakqD4MH8G1zoqunBupIm2PjxHzTvbRmJ7R1e4W
         0HXC73ZUXO+AJEyffb+WqHE6X9LMRYPjIaZDC1QdVGv5KQW6bz+542OGpnCXPiS/7Eu6
         sfZSW8nQ+xYrt8RTj5DsDBR7fhlvbSL/huPuB/i9l87CCVAxmsrRwaYi/lCWkK1GSn1q
         1LdLbhbiOxMRAz3d66ELBtTK+1VYcg7OkWP7C/xsSxTlyoCVU1iFC+zgyhzeW82Iw5l7
         kLxJWn5HK/ofuzvYRayI6KoP+5kfotUDoGCQz9o5A4zC7Fz7KeG5iv9zS7wuvfpo5Wk3
         yjfg==
X-Forwarded-Encrypted: i=1; AJvYcCU7ds+QJIc8pkRmdApUBh9PSLvEGcKtXCqNAZ5m2zj6OWm1GKlIVsgTRwJEylfE9rSl/9J/aqS2oxNkWw==@vger.kernel.org, AJvYcCUW6m28mYCnQ220RRVpfxis23crw/MTJEQHYR6ribD4UaZMXaoUOWIoL5oy3uHdu5GFyXfeLKfmgqG1@vger.kernel.org, AJvYcCUWllh4a99yJ6AGbK+D1zoEMZ3rYfBiJ/B59BUidQZNx4nV2BIoW95J8VYekYjMK+/ZcjDD1z5foAUxtIRu@vger.kernel.org
X-Gm-Message-State: AOJu0YwKteSMDaVH2yVFoc9cMzSFM3FtyC+MbrMM0rkobGSaUw2D3QcE
	3w7f5DOIUXWMMhaV8wLYo66BIalAsr8Hj7iykPrrJyaHANl6UGHxUvOfnV9BSqJkFJ2rbVry5Bw
	4vFfCOAQskVU8+WAePERF2yJslSY=
X-Gm-Gg: ASbGncuNIgcJl3M6kB+MeETJUQvPqTyVsZymsLSrqfc6WCqPzfo4eA+UhVDZy/PahVL
	XnS3Kuu9skNZYZLi4NLfvQEuL5NJDKH2MjPeJNua8rGWISeSibGTCJqndoXzUNSeeqJ8ppuCaoE
	rsNfxui+iZW1dZICF+1L9TzBSCRxzZcmFZiSZjUKdtgrwR
X-Google-Smtp-Source: AGHT+IGbhuSl05kaEcLr4vaNaYcnvbu8eAnHPI3X7260iUe/HNnjduw+l6Z5dyOdVihAIIZ0GFIAt8i2L6PXQgKu7P0=
X-Received: by 2002:a05:6402:34d6:b0:5e0:8a34:3b5c with SMTP id
 4fb4d7f45d1cf-5e614d92d51mr11025464a12.0.1741610482533; Mon, 10 Mar 2025
 05:41:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-10-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To: <1740611284-27506-10-git-send-email-nunodasneves@linux.microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Mon, 10 Mar 2025 20:40:46 +0800
X-Gm-Features: AQ5f1JpetGYU9QId_nDle89d5pd0l8CdMTUEIA_r5WaM_0vYFhAkX03EaOPPaVA
Message-ID: <CAMvTesB5dCD5Cx+CE8oPQ35OHC+C=tyXbHQ0BNxSABEFVK53Tg@mail.gmail.com>
Subject: Re: [PATCH v5 09/10] hyperv: Add definitions for root partition
 driver to hv headers
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org, kys@microsoft.com, 
	haiyangz@microsoft.com, wei.liu@kernel.org, mhklinux@outlook.com, 
	decui@microsoft.com, catalin.marinas@arm.com, will@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, daniel.lezcano@linaro.org, 
	joro@8bytes.org, robin.murphy@arm.com, arnd@arndb.de, 
	jinankjain@linux.microsoft.com, muminulrussell@gmail.com, 
	skinsburskii@linux.microsoft.com, mrathor@linux.microsoft.com, 
	ssengar@linux.microsoft.com, apais@linux.microsoft.com, 
	Tianyu.Lan@microsoft.com, stanislav.kinsburskiy@gmail.com, 
	gregkh@linuxfoundation.org, vkuznets@redhat.com, prapal@linux.microsoft.com, 
	muislam@microsoft.com, anrayabh@linux.microsoft.com, rafael@kernel.org, 
	lenb@kernel.org, corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 7:11=E2=80=AFAM Nuno Das Neves
<nunodasneves@linux.microsoft.com> wrote:
>
> A few additional definitions are required for the mshv driver code
> (to follow). Introduce those here and clean up a little bit while
> at it.
>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---

It may be better to unify data type u8, u16, u32, u64 or __u8, __u16,
__u32, __u64 in the hvhdk.h.

Others like good.

Reviewed-by: Tianyu Lan <tiala@microsoft.com>

--=20
Thanks
Tianyu Lan

