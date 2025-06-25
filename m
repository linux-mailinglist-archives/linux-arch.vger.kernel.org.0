Return-Path: <linux-arch+bounces-12456-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831FCAE8933
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jun 2025 18:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C189016B8AE
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jun 2025 16:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F3D2BD59C;
	Wed, 25 Jun 2025 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l+o3JLEU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA2E2701D8
	for <linux-arch@vger.kernel.org>; Wed, 25 Jun 2025 16:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867660; cv=none; b=BTw8qJa6KOtcK8aM+i30FJyDwUpfYh7bTBkbKEaINqm1lDmWVofsbIQLzYZKB19RLEwUJtT2uehHlXFb49hGdEDscNQP2R/xO51hWUG6SO1H7B4CQi79qf7F9JJ8s4eAyhooClzfBLPIWSfm+qK34Pt6JUb9snnHUU3UC9cyTkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867660; c=relaxed/simple;
	bh=PmLKnatmcArjaqzkFbJF6iubiesxiEHtv6p0vrH87PU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KqLYxRg0yC5LlbcuchsEf8t6o2Wevb41M2aq/pyVLdqfykgZZQq2QIf7MOhWeOjoK2ps1lgPxxIiFLbc0tMW3g6xA6QdNMkf+4BoS1pNm3iGM6HbJxIIU7PtyMQHmE7Y5Yg3azPz6vS8pJUszwb5nA3F6ZhMCSWWFr9T+0kHndU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l+o3JLEU; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-47e9fea29easo464731cf.1
        for <linux-arch@vger.kernel.org>; Wed, 25 Jun 2025 09:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750867658; x=1751472458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2kSE53PozQNQP+6R+o2GRPmYUVj66J2/LIU6nQDQ3k=;
        b=l+o3JLEUQoOmHPFFARPZm1hTn5iY0YGuBa2KshP4nCLy9AUToOH9dARTwT6kkBanan
         4iJdu6H8Exv/bXotGvYNXNAV7bcO6AijeckcaInSYStYCFbkHCBNaTKk2M3UVcZDaXfT
         36k0y4LxgzNeVyUmYHQQZrevFJ/zTDIBw2W1hITGpYb7U4M15bVyA4aFlWTWN3VzsJRe
         n/sBW98Q0B3llrcKSj2P63rHnAClg3rv+QUv6b8TVO44TJ0tmdzHy1nmu4QO3TsyIUap
         l4bsxdxJQubna77VPV1Tw4QbZihI0eXc1YU4c2TxS/dpGatPa/62uVru0pBTw9SYreBo
         AC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750867658; x=1751472458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2kSE53PozQNQP+6R+o2GRPmYUVj66J2/LIU6nQDQ3k=;
        b=wn54u7RKY3H5oMZiJ8RBDS/2FSXuoi1aLp0UQT6BFfG6URvlMNlMJo+lVNLTnGc0Nn
         lWHa+E8cziklbPT0NH7RpUOJvp1wjLcbtAG2rBoH7iJFcdzfNXuMSIadhNw3awr3u2mo
         IUi0u/spFVBvS8kSVWWubNiyypUqtNDRp+dBcOgQihFC9Gu9h/9dt+UxFGhyhMz82K68
         4wtDzZpCS6cHzXMxCw04FMghh92Ef4Zj72/wZkTPiTRDeoQo3wZWZ1mNXNtZn5tkWK+O
         Lkt0LKjoVdkXLRNb+VgwKud1iKKUz4P4gLHx8fcNY5rU3Ur2I6aOKJzinH6jw1o3F7EF
         FYFg==
X-Forwarded-Encrypted: i=1; AJvYcCVx8QoU5sA9NsI6IvG9ln2w9a7ruVaAOkKJesHJEH/pvaFPIiPY7eMXpZphL7j9MdH5FDhx1AmEitQo@vger.kernel.org
X-Gm-Message-State: AOJu0YyGI1/CWQnNwWl0byNBm4rX+ulDKKCKtcylR9XbYBiBgDiYJnD3
	yBnVkPCnNvrimdgstUuSwzyqUB8oBqvU90NQLiGNftXruOV0MwcFyJZXiwzD5ayWuGX7+0rOWW9
	RTuxOE9L55P+jrHuznaOXv0wH5/EoXKhIlITGFFvl
X-Gm-Gg: ASbGnct0aQO3DkMgQ9ieavUoDXaXVASbzgBv49OLbapkuxEjOzdeqFRQoR0uXuzU33b
	Imqa6ZRnKStBjJBe16JhMdwA0nJQsIeAZAzCp4Y8bRO8sXV7//7KB5ox1l7EJlGjWZxNQh4CHVP
	41pTARGrGdVwaH5VP8cbPW0dcYCYLA6wu++S3FGnDARA==
X-Google-Smtp-Source: AGHT+IEKTFo972c6FUomRFX6TTuvtcbQhZlTwD1AoLa3bGcnE2hHiBorQJ20QzhOgsiiVShTDRPJT+ULmhy04NwuUhM=
X-Received: by 2002:a05:622a:8d1c:b0:471:f34d:1d83 with SMTP id
 d75a77b69052e-4a7c70b82bemr2870931cf.7.1750867657865; Wed, 25 Jun 2025
 09:07:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618125037.53182-1-petr.pavlu@suse.com>
In-Reply-To: <20250618125037.53182-1-petr.pavlu@suse.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 25 Jun 2025 09:07:26 -0700
X-Gm-Features: Ac12FXwWUvrVId3iEH6F7cARj25951BIhaDjfYAOAdNuZpJPAx-cEVSASoHkK9o
Message-ID: <CAJuCfpGeLXn4UGudJZywOJWUECE6oJUm9OyCvQ__SWE4qCLHbA@mail.gmail.com>
Subject: Re: [PATCH v2] codetag: Avoid unused alloc_tags sections/symbols
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Arnd Bergmann <arnd@arndb.de>, Casey Chen <cachen@purestorage.com>, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 5:50=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> With CONFIG_MEM_ALLOC_PROFILING=3Dn, vmlinux and all modules unnecessaril=
y
> contain the symbols __start_alloc_tags and __stop_alloc_tags, which defin=
e
> an empty range. In the case of modules, the presence of these symbols als=
o
> forces the linker to create an empty .codetag.alloc_tags section.
>
> Update codetag.lds.h to make the data conditional on
> CONFIG_MEM_ALLOC_PROFILING.
>
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Thanks!

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
>
> Changes since v1 [1]:
> - Trivially rebased the patch on top of "alloc_tag: remove empty module t=
ag
>   section" [2].
>
> [1] https://lore.kernel.org/all/20250313143002.9118-1-petr.pavlu@suse.com=
/
> [2] https://lore.kernel.org/all/20250610162258.324645-1-cachen@purestorag=
e.com/
>
>  include/asm-generic/codetag.lds.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/include/asm-generic/codetag.lds.h b/include/asm-generic/code=
tag.lds.h
> index a45fe3d141a1..a14f4bdafdda 100644
> --- a/include/asm-generic/codetag.lds.h
> +++ b/include/asm-generic/codetag.lds.h
> @@ -2,6 +2,12 @@
>  #ifndef __ASM_GENERIC_CODETAG_LDS_H
>  #define __ASM_GENERIC_CODETAG_LDS_H
>
> +#ifdef CONFIG_MEM_ALLOC_PROFILING
> +#define IF_MEM_ALLOC_PROFILING(...) __VA_ARGS__
> +#else
> +#define IF_MEM_ALLOC_PROFILING(...)
> +#endif
> +
>  #define SECTION_WITH_BOUNDARIES(_name) \
>         . =3D ALIGN(8);                   \
>         __start_##_name =3D .;            \
> @@ -9,7 +15,7 @@
>         __stop_##_name =3D .;
>
>  #define CODETAG_SECTIONS()             \
> -       SECTION_WITH_BOUNDARIES(alloc_tags)
> +       IF_MEM_ALLOC_PROFILING(SECTION_WITH_BOUNDARIES(alloc_tags))
>
>  #define MOD_SEPARATE_CODETAG_SECTION(_name)    \
>         .codetag.##_name : {                    \
> @@ -22,6 +28,6 @@
>   * unload them individually once unused.
>   */
>  #define MOD_SEPARATE_CODETAG_SECTIONS()                \
> -       MOD_SEPARATE_CODETAG_SECTION(alloc_tags)
> +       IF_MEM_ALLOC_PROFILING(MOD_SEPARATE_CODETAG_SECTION(alloc_tags))
>
>  #endif /* __ASM_GENERIC_CODETAG_LDS_H */
>
> base-commit: 52da431bf03b5506203bca27fe14a97895c80faf
> prerequisite-patch-id: acb6e2f6708cd75488806308bfecf682b2367dc9
> --
> 2.49.0
>

