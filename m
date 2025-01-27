Return-Path: <linux-arch+bounces-9912-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83986A1D2E9
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 10:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155CE161395
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 09:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729E81FC7CF;
	Mon, 27 Jan 2025 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBIDIQA2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F0886348;
	Mon, 27 Jan 2025 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737968750; cv=none; b=pww0ee6fj7G1I00p+Vw7gcQV39i+37F3t2Q8Ch/lEGjdEJZte6XSD6y36PrRGgWNceX4dcbtJ7gQ6/hXPJSXa0r16QNUd0nB66xRzx1YEXqVqYR/SM08T1x5XdhMlL0a5HjojV10HKxGoTz95ADvpLBbMkQCqpjTrGl03EsJb0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737968750; c=relaxed/simple;
	bh=sQGiOSFXQcB/cuKBWCQj3aB6Enw5rpIAAdVFTilt6zE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NVPGePCjmXsF/cDQ2FzJE2DM4td8m28gWlPY/tE8Jd1XGDIVek2SLYj1CMY4bcywSHVb8TbHU9gAhcWnRIVLojT01ahtA1OwiUDBWr1gcDEao2qScJEV65ZgYMHR7nZCU3gphZUizwu+/ix9D67cEP4MYAolLJoBT+wqEKbF3cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBIDIQA2; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e461015fbd4so6017382276.2;
        Mon, 27 Jan 2025 01:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737968748; x=1738573548; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sQGiOSFXQcB/cuKBWCQj3aB6Enw5rpIAAdVFTilt6zE=;
        b=TBIDIQA2HSSyPctU0nXyA54giiO4K51bUCn+Jirmn5O+Df9gVCONrgLMdClBdzJad5
         fj7GoZE2B+R3QNn3g8pHHTd5l0nwboGpyptiIQMUAEKA2NGFgn/EA2RncJwNqHVWrJ5m
         7eb1ivllGnfakBPUPrAaYsjUDpXC/GA0tUQwwqBzUY+JDyrqnTWUpQyod8a86fyZTifS
         7nGgz0czdON//Xg2EvZu05Rmnb2Kfo9dnti6fFfn9ShHtnKOcNcsB38CgYCZn8zyYjsX
         ljyUtxEQZV6D4CVIXKnCkwWBVa2pQhtvy4lmnUv7s7pWuMGqABJyM3Uw4FK77i6iolL3
         T3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737968748; x=1738573548;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQGiOSFXQcB/cuKBWCQj3aB6Enw5rpIAAdVFTilt6zE=;
        b=i/9rMPvArU15y6xCb18toui1OSn3ynzZbY9T/ADWDBSe+3hjTneg1ZaA1xa4HSfKEv
         rqulwITCu+r2GU4fvwlPuUAx/6F06BO621KHVqGxPheNYVN3+bbsTW/HK5R0kOE3sxvs
         moO/gzQjNsVp8caoNd9tHBUHmgD02qP8g6lZoKuwFgqOdQST73+QcP6R93QCe5wgodEp
         AeYi+aAPHTC5A5S/Hl/BFLRC7IKuSnTvZxcz9+zVLkervDwpHRf9cVcq7eRQxc/c1Wyb
         a0NF1iEpthA6BTVhwASXwCSMV4pfo1ip7pSFtx7KBXxnkUwu20Nxij8Pp9QwO8GhDkhd
         5Igw==
X-Forwarded-Encrypted: i=1; AJvYcCUEg5J0lbmOLlx1g+M6oJ8PMN6TTE8qfy8+6fy9LNpdL0bGjI0XD8eQSCHZo4TeE3V3U8on61b51Q3M@vger.kernel.org, AJvYcCXEOFbDDWI/WbiU8vFW5m2G2jYnYDR/VdQa8kHwdlJ4LpDaxNxt9JscJYNc+ZqPVqDQ7uCeQYlcapvYryAy@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+gHx3a9WyoJGUF8bxNtkiPlQdqQWN77FGgaVI+eoOQVa++q+U
	L6eWvF3mw/vZZQbGTgeY0LMN4CknHzJxMRPuPxOP8fpb8cCQzet4aZfkxyJ86lvwwXEijPjj63A
	LixK2GOcrsC1lDEQO1t67+prpGMA=
X-Gm-Gg: ASbGnctMfiVKC6xr9jQ+eoL92NkgXavsSj1hwVVqCpHkon8PR9IaCrYr9YTirFrHVCI
	aHUCv8xsGSdnMUTq6LQwfpZGFbaamDptU2VErR3DyUIKTC7SYBfyJkGOYU9FdnFY=
X-Google-Smtp-Source: AGHT+IGa7Yl6B8MJ5QHXf3TY07Rd7fNWx9mqcOicUKXP0SfBOOhR8dEmrgHpYp6Q1QN7SewjsNLFXRP6Yo9F5OKf/IM=
X-Received: by 2002:a05:6902:981:b0:e57:2a07:a975 with SMTP id
 3f1490d57ef6-e57b109e39bmr26749441276.29.1737968747818; Mon, 27 Jan 2025
 01:05:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125-virtgpu-mixed-page-size-v2-1-c40c555cf276@gmail.com> <4a1c7ab2-66b8-49ec-9662-6827c811ab69@suse.de>
In-Reply-To: <4a1c7ab2-66b8-49ec-9662-6827c811ab69@suse.de>
From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Date: Mon, 27 Jan 2025 10:05:36 +0100
X-Gm-Features: AWEUYZkb1KQh_RTJk_H3d8w0L3RB1N-n2GhnQODabid2mVrXgB_zFRDciDlhCzU
Message-ID: <CAMT+MTQY3JFuCUK1OeQ8zBoe51fqPyHs6x6QmuY0eHP_e61Hfw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/virtio: Align host mapping request to maximum
 platform page size
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Simona Vetter <simona@ffwll.ch>, "arnd@arndb.de" <arnd@arndb.de>, dri-devel@lists.freedesktop.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	asahi@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Jan 2025 at 08:31, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> This is per-architecture code and does not belong in a DRM driver.

I agree that this is not quite the place, and ideally i'd use MAX_PAGE_SIZE
from https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
however that series has not landed yet. Would a todo comment
with instructions to replace it with that when that lands be ok?

