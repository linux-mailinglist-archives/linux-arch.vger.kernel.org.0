Return-Path: <linux-arch+bounces-7217-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 427B8975C28
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 23:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5AA1281D17
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 21:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8216A143C6C;
	Wed, 11 Sep 2024 21:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSMbUBCV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CEB5337F;
	Wed, 11 Sep 2024 21:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726088756; cv=none; b=NO02FXEkQ6fNJV21A5NOkEg39szQODf3KlAYCvj5BfRDVM8MzlEzFCfVjUsI9KgHpKYJnPEega3gPLUOC6nvF28V0gYMpVX0ONs/k+7CheFwecPrjWC0mmU3ih8jpe1iujYHw9QYK/yloMd/GkNDZqGF/lCvq2LYWAxYeYsVDXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726088756; c=relaxed/simple;
	bh=j9bVDpdHTr/1FohU2bEAGVdU9wt0NXPDQcAD3KGyF5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qnkuyBXWRb9k6SKu81rJ4UVCqQ5UDqzeLjKlAS07KxsxKO/mU8k6xNY1jGNUVcihGbJaozNO1OhgAhFTSaJTsjm/RLCB6pei2NMz7v3muuAVq7CL2tFi82NtqZiOvO5ASvHA6i1hozCjTPfGyTzbAtCVE+58BGYCFuRw5225530=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSMbUBCV; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7d5119d6fedso991753a12.0;
        Wed, 11 Sep 2024 14:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726088754; x=1726693554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DHLF4MY6pVr9Kzo+6gRF8kyn4T6UnEAKjrilBjTMSw=;
        b=GSMbUBCVpUB84HfBhYlz17uadzl1Hls9YcKrPYwGckxR/9vmsmAIEZdswxTc3O4qAz
         X8k6zMXMXjDNBK3MvLFmFGqh6N9Pfkbo4xklb160VJJHdxMUQAJSneM7YTdRKeHCdTjm
         UDb6TkrHgSI+HE+7SM5MIJbiPPqfr5QuQWKp89bpFGHRVvU3TTSqJDr7rUFY24ycXaDZ
         JNGByMRUAXAXPofNN7dgstdjFfHb7BXkQYRYzIH3S1xOv5TYf8zBQAnBTlUXmltU0fEB
         nYojrez2KLCvAi+iPCBKpUc5yhbskDdOabhv7w3slCXSKb/CZXQxQ7yVwWc+nGxdExpk
         9F+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726088754; x=1726693554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DHLF4MY6pVr9Kzo+6gRF8kyn4T6UnEAKjrilBjTMSw=;
        b=nChUFEfnkDDKepdpGhKWLreAk3hyrf0L7yIX/EzyzlIAVkpRKxyHoxqQIJtjr3xboo
         9s/tTEzTHHqCDnyS1LaZ251lZFQQp7E91B8uhyYWv5GFdkrhWulgO2sCXjPzFFUGPWvo
         HM/XEEoHOU9E7RERn1gDulWP2bCHa9mFMeW5rzl6OfC1qM7r271Pup42JQt/QUez9SM5
         lO+RNSyfjhmRgr6BWtn2OmHS93KU8Hmw7a5EK9/AIjvtWpimVt5CKzhYwXNynor+Wj8A
         hVsxicec8Jp1gaVVtdJGlnwNVVQxbD0DwZJ7rslE3E+czZrK8zdSo+dnf1Bv/IOavhQE
         9slg==
X-Forwarded-Encrypted: i=1; AJvYcCWcdT+sthDDobW+9FyCb7YjWqZN+1GJdzClIZRF7D+XbuWmjviDtHL35KZuAvYZJgWiti5Y86kK4t9DcCDO@vger.kernel.org, AJvYcCX7bFlnfZDJo+8UzJpZ4oupPO5QkX8iIcV19ZG83Jy3Y4PjLLqqR1jO/UJze0yvzmui3uI=@vger.kernel.org, AJvYcCXC0Ad13bt53Sa6QTG04RJ9JHRBhjjsZpTEU4sQidOSxlfejF0ceKlDmX0efiRsc91/LNYquPkbZcoRaw==@vger.kernel.org, AJvYcCXtb5w2s29tdv1mTqlA7BC9FyYwy9ZsLl8FdiVqcH/v8ztFnwcLMV7ckeEZeq4eozePII+hZSskXUlFYdMv@vger.kernel.org
X-Gm-Message-State: AOJu0YxEsf0k4hkKSpLI4VYeAViGAKWiezHxAt3O675JPZGrWwyvzlAa
	+wsEc3nwHL/mKFn43dKFTChyHw/q4uEYjLZ7BB51iPxz5E4muAL6uMbgS6kZVQB+AhHRemeqOKi
	yzU7QFboIVbt4bABaeJTIqU/ijchPH1Hy
X-Google-Smtp-Source: AGHT+IG9FN2L9J1WPB82uOhxRbi0vhpRNmO6zSO+AgTDIVSplvohYBiTKJRbgJ3+Zi4SFQGrVqjt+8RmoBj1E2LP96o=
X-Received: by 2002:a17:90a:6447:b0:2da:50e6:5ab with SMTP id
 98e67ed59e1d1-2db67226181mr12233286a91.18.1726088754328; Wed, 11 Sep 2024
 14:05:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911110401.598586-1-masahiroy@kernel.org>
In-Reply-To: <20240911110401.598586-1-masahiroy@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Sep 2024 14:05:42 -0700
Message-ID: <CAEf4BzZHuCERKRub+8HoWYR=SHj-MAkhmbdC1eUJaMrkbLaqCQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] btf: remove redundant CONFIG_BPF test in scripts/link-vmlinux.sh
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org, linux-arch@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 4:04=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> CONFIG_DEBUG_INFO_BTF depends on CONFIG_BPF_SYSCALL, which in turn
> selects CONFIG_BPF.
>
> When CONFIG_DEBUG_INFO_BTF=3Dy, CONFIG_BPF=3Dy is always met.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/link-vmlinux.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index bd196944e350..cfffc41e20ed 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -288,7 +288,7 @@ strip_debug=3D
>  vmlinux_link vmlinux
>
>  # fill in BTF IDs
> -if is_enabled CONFIG_DEBUG_INFO_BTF && is_enabled CONFIG_BPF; then
> +if is_enabled CONFIG_DEBUG_INFO_BTF; then
>         info BTFIDS vmlinux
>         ${RESOLVE_BTFIDS} vmlinux
>  fi
> --
> 2.43.0
>

