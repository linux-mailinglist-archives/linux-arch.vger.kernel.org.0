Return-Path: <linux-arch+bounces-2007-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CCA847676
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 18:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3078A1F27229
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 17:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3995C14C586;
	Fri,  2 Feb 2024 17:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SlVx6PbB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703DE14A4F0
	for <linux-arch@vger.kernel.org>; Fri,  2 Feb 2024 17:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895795; cv=none; b=B1zyckocJjNJ6lzcjTVu4PzjJapZ+rnxxShVRkOXUw6chPXfsNfsjLDm6X0I7sGwxuEa+Q64/4YraGPPU+CpLrOeBtZXjWK9dNpxLzuMXdfCzYf9I5ejUesS+YreFihgoS3L9ogON2vTmUL4Gbl9HzsyQ4zdpimubJz13D0OY7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895795; c=relaxed/simple;
	bh=T+NxqikMqY8zMy1caHhysblQq9xG1f252fz6RtPoVcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P4lX0Nr3UW1VOb3tztYNWly0BGDa0x61SXyIPzL/iScGpA+KHUN1CF31rgn4MXuptluEgaBqKx/Al8gti2wuJPtYLMz+YO9VML0bCDMl9IlDOLAiPGuY+yH8UHnU0Dl3q71Ktqi+QNHjndEkxsMNO2hlLDoDEJY0fRLNEPuV+D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SlVx6PbB; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so2106206276.1
        for <linux-arch@vger.kernel.org>; Fri, 02 Feb 2024 09:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706895791; x=1707500591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+NxqikMqY8zMy1caHhysblQq9xG1f252fz6RtPoVcE=;
        b=SlVx6PbB7PYS11tWyXl1FRKQN9gJVKiolOghLgYliRP+lkaopifg6QQvJZOYzHj2RP
         qn7frcav8E4KPXfnOhzhwD0bxDEnRhD6MTvxMcwo+ZVoifkRppGPZdFuzySzyvut6js0
         5zV8CZ3pPYntE97AjeD4gOQzVeyY5Ipy02Qsq04dfWDRX//ylGr+L3smhB0L8SKU9TKx
         /ZlyAY47wVqCFy1kj40ntfbpw3MQe6ry/uZLoD5oXJqrD8ZOg/e0hTzdm0yN9Q23Gp7Z
         OHzNMhiuS9PNAiYfhrbhwkDKtj7stnQ45MmUKPWeIn0v/0mXl1o4vaiLutdSwM5unWkT
         0EGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895791; x=1707500591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+NxqikMqY8zMy1caHhysblQq9xG1f252fz6RtPoVcE=;
        b=E8HBEjadkNrt9FfQ5f6jfAuyDAUH97Yh6IhBE/qEeDeRSibKaljUQtB8g2BPUhX98w
         uhbW/emtmkZzm5HytPOImlkw4BmfTXuDqPnPD9QXE0hL67hswI15pNgxcaNcCl3ADGKB
         JAvQBPejRYCB/w5rvsu4q8QospX+p0+BoxYelN0IBx7iRBkDia/6Gfdom6wD/+9VPr/7
         61emcgecfctPoVR/Ym3wr5Pn9HzpkUShDTWW5F5X+qy8HvmosCohJzrJ8bIp9aIZqL8j
         bslGW7dXcNPwKsFWhtVGlKfoL5j3QsNoiEpQcgvEh4Cjn9RT08Tyw06jpO08yxPgR3yd
         QK4A==
X-Gm-Message-State: AOJu0YwqgYul/CrkkXSqZfOWw3CRXfvKIu7z3bim/9kywLaA+vYWxk61
	V245p/2Hv/9g2pMQdnu5dQDpSPpyeo6JuJ0PEyjWiiKrn+RDzquH6rIlPHjIJpIJkpU/RqHsilR
	Pp+4tJo7e1KMILyCX5F9UsdO7ieA0RlOxsYxRlg==
X-Google-Smtp-Source: AGHT+IHTaFiLwtqyLg8kSKQCyZ9cLuPMVYmKAcJIt8eLghpONdnZGm3WBgei2TskaAhjfRZa6yT6FKg3E1ONuoiITUs=
X-Received: by 2002:a25:5f49:0:b0:dc6:af04:2e05 with SMTP id
 h9-20020a255f49000000b00dc6af042e05mr6356972ybm.7.1706895791304; Fri, 02 Feb
 2024 09:43:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202140550.9886-1-yan.y.zhao@intel.com>
In-Reply-To: <20240202140550.9886-1-yan.y.zhao@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 Feb 2024 18:43:00 +0100
Message-ID: <CACRpkdarfWFhvJ8vrDZXOk-nhDkgfwOLB+EytVm1S=-dEFKy3A@mail.gmail.com>
Subject: Re: [PATCH] mm: Remove broken pfn_to_virt() on arch csky/hexagon/openrisc
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: arnd@arndb.de, guoren@kernel.org, bcain@quicinc.com, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 3:35=E2=80=AFPM Yan Zhao <yan.y.zhao@intel.com> wrot=
e:

> Remove the broken pfn_to_virt() on architectures csky/hexagon/openrisc.
>
> The pfn_to_virt() on those architectures takes PFN instead of PA as the
> input to macro __va(), with PAGE_SHIFT applying to the converted VA, whic=
h
> is not right, especially when there's a non-zero offset in __va(). [1]
>
> The broken pfn_to_virt() was noticed when checking how page_to_virt() is
> unfolded on x86. It turns out that the one in linux/mm.h instead of in
> asm-generic/page.h is compiled for x86. However, page_to_virt() in
> asm-generic/page.h is found out expanding to pfn_to_virt() with a bug
> described above. The pfn_to_virt() is found out not right as well on
> architectures csky/hexagon/openrisc.
>
> Since there's no single caller on csky/hexagon/openrisc to pfn_to_virt()
> and there are functions doing similar things as pfn_to_virt() --
> - pfn_to_kaddr() in asm/page.h for csky,
> - page_to_virt() in asm/page.h for hexagon, and
> - page_to_virt() in linux/mm.h for openrisc,
> just delete the pfn_to_virt() on those architectures.
>
> The pfn_to_virt() in asm-generic/page.h is not touched in this patch as
> it's referenced by page_to_virt() in that header while the whole header i=
s
> going to be removed as a whole due to no one including it.
>
> Link:https://lore.kernel.org/all/20240131055159.2506-1-yan.y.zhao@intel.c=
om [1]
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>

Thanks for making the kernel a better place!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

