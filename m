Return-Path: <linux-arch+bounces-9843-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F211BA1832E
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2025 18:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D764F7A1FEF
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2025 17:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD631F55ED;
	Tue, 21 Jan 2025 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yO547tQD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D213E1E9B38
	for <linux-arch@vger.kernel.org>; Tue, 21 Jan 2025 17:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737481570; cv=none; b=snxd0/yw04yf+vMaXS8wj/KHCGWeGEXTyjVDUhGILgwHvarCmZC9QZbRZ5k8tJewMUo88HmJJrM3ptUn82wMhABQBX0CTaUXL/RD9W3dlJGLOnjNCF1k03eQjarGCWljxsoIkah3VHmjZnYtcbHcw+KfCUs7u5bHJSupYgBDWUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737481570; c=relaxed/simple;
	bh=uolMWjkRwog15wLHtUnNAgJ2+dDra/fTMVYKCdY/71I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7wdBvvPepZnzrttoHROrC/LFMR592MMEfUY1CRE2a43G6zfLD/FVpSI+S8FkgR/+keJoeusQg9W2dS9OrrbzmWw/x9PGzdUATd4m49dRo/FK8a/beMMv6vjyy5LBLf1iuC3Te6+sLKAwKD982ofhnQhWebzh/xNoOJpE+/Qz8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yO547tQD; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-467896541e1so4891cf.0
        for <linux-arch@vger.kernel.org>; Tue, 21 Jan 2025 09:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737481567; x=1738086367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bx8WAbX+Bf/ENrO43oH1TTXYHStkZFkZKs48Y9wFiVw=;
        b=yO547tQDkFjDi6wU9Gd4mkG/R6uKyNjazbeUjkhALQKD964lXSET7dc3sbyn/Ckki7
         VSvyipUl4XJAbfFCZi+qRoS7ZZkIQhyTT327a973j7Tp9jbpxyr9R5VdSWBkTlVujVc8
         TI8dDt1jELt37TXzGPtKlV7gAxdtt5VSe2B46974cedarQhKSfnynBXDYNk+OKVbNDnm
         x12Py4jzVulOluOV2sBtxM8sLucic2PUZaY3iTOHp2AV52EA1weJWzxO8YaajmlaG9GW
         OvfSmTN4HnKvnC7QHECiB/osEN6EP+SpHDIJhl/BcK0PPLnShVuGDgQZo82InANtn71e
         3VQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737481567; x=1738086367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bx8WAbX+Bf/ENrO43oH1TTXYHStkZFkZKs48Y9wFiVw=;
        b=JfwQCESJpzjowRyGzS+m+/7YeJm8sclg85kE3fKR1tLxBiKdbUduqNFevpowfLxN7+
         SX4vko7RG3KAPQsSRVuiBawc+snBJb9GKPDEv3Z55IE2Ea1KvsxPQAonDjn2bsE5CKBp
         X2F5P1lS05VL/bGKbMqeZBAjPaky/em4qTA00/l3CxandZSaD9FiSQTM4BEJklHqx0ec
         Fw5ti9sKjMho8uYXW8R8DCdM1tAq43ZY58s88tCMYxLeoq28hyuHSyq29iYp3CX1bK0D
         qA58z4Eiq4rvdB45u/pc4Iy5IOhaXC/s3V/WlgQQQbgMYzMWq5q91eZ0qTHIdreYK1YC
         xbAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJNIs70wiRllsqdbH24XJMlBCTpnxwFXPoutI18K5osl9H8/orYU91Q8O3cQlNNFRSPXLGHSwpzgvU@vger.kernel.org
X-Gm-Message-State: AOJu0YxCtN+uEQiEQ8eTa9JFkdRRBVArB+ff+8xl7GW0WV/UpTGb1Is2
	ZbwbViJj8oa2nej9DV2h+sxjeypUFuz8TA64z1dsVa/7Kl9ByCcUiYLUQUquGR8acCqx0jDNeuC
	r145GGwMmCnhCpA+bFZJjnLCTZ4r5EMH15aI0
X-Gm-Gg: ASbGncvmyMhadQk21pYIGply7E+qHs6FeHzydjcqvG2I4AcxKoYHZ/KyASLQ7taM4G1
	afgqs0+fi2l73vfof56M1uKhSDp5l2NKra2unKNYO4QU4Y18t9zBUW7zwk4HxoCZWrhwIO6PVFk
	ZmfPp4Eg==
X-Google-Smtp-Source: AGHT+IGd0/Z0rV2uyahLRAJzwEWM90n2xUjYQM8Nd/X2t9nhAEmY/ceslLrJI2CjEt53OBeRuRBjrcmowYTHlHU3kK4=
X-Received: by 2002:ac8:5f4b:0:b0:46c:70b1:c5e4 with SMTP id
 d75a77b69052e-46e21081d40mr11291001cf.3.1737481566464; Tue, 21 Jan 2025
 09:46:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120212839.1675696-1-arnd@kernel.org>
In-Reply-To: <20250120212839.1675696-1-arnd@kernel.org>
From: Rong Xu <xur@google.com>
Date: Tue, 21 Jan 2025 09:45:54 -0800
X-Gm-Features: AWEUYZmEwIAZYDGYiWvXqx4GdOYlgecHA034aBbe62gbYaNi1kci1k83ZczQ4hI
Message-ID: <CAF1bQ=QFxE8AvnpOeSjSeL1buxDDACKVNufLjw99cQir0pyS_Q@mail.gmail.com>
Subject: Re: [PATCH] [RFC, DO NOT APPLY] vmlinux.lds: revert link speed regression
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, regressions@lists.linux.dev, 
	Han Shen <shenhan@google.com>, Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 1:29=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> I noticed a regression in the time it takes to fully link some randconfig
> kernels and bisected this to commit 0043ecea2399 ("vmlinux.lds.h: Adjust
> symbol ordering in text output section"), which (among other changes) mov=
es
> .text.unlikely ahead of .text.
>
> Partially reverting this makes the final link over six times faster again=
,
> back to what it was in linux-6.12:
>
>                 linux-6.12      linux-6.13
> ld.lld v20      1.2s            1.2s
> ld.bfd v2.36    3.2s            5.2s
> ld.bfd v2.39    59s             388s
>
> According to the commit description, that revert is not allowed here
> because with CONFIG_LD_DEAD_CODE_DATA_ELIMINATION, the .text.unlikely
> section name conflicts with the function-section names. On the other
> hand, the excessive link time happens both with and without that
> option, so the order could be conditional.

Yes. The order could be conditional. As a matter of fact, the first
version was conditional.
I changed it based on the reviewer comments to reduce conditions for
more maintainable code.
I would like to work from the ld.bfd side to see if we can fix the problem.

-Rong

>
> I did not try to bisect the linker beyond trying multiple versions
> I had installed already, and it does feel like the behavior of recent
> versions (tested 2.39 and 2.42 with identical results) is broken in
> some form that earlier versions were not. According to 'perf', most
> of the time is spent in elf_link_adjust_relocs() and ext64l_r_offset().
>
> I also did not try to narrow the problem down to specific kernel
> configuration options, but from my first impression it does appear
> to be rare, and unrelated to the Propeller options added in 6.13.
>
> Cc: regressions@lists.linux.dev
> Cc: Han Shen <shenhan@google.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Kees Cook <kees@kernel.org>
> Fixes: 0043ecea2399 ("vmlinux.lds.h: Adjust symbol ordering in text outpu=
t section")
> Link: https://pastebin.com/raw/sWpbkapL (config)
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/asm-generic/vmlinux.lds.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmli=
nux.lds.h
> index 54504013c749..61fa047023b5 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -588,10 +588,10 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PRO=
PELLER_CLANG)
>                 *(.text.asan.* .text.tsan.*)                            \
>                 *(.text.unknown .text.unknown.*)                        \
>                 TEXT_SPLIT                                              \
> -               TEXT_UNLIKELY                                           \
>                 . =3D ALIGN(PAGE_SIZE);                                  =
 \
>                 TEXT_HOT                                                \
>                 *(TEXT_MAIN .text.fixup)                                \
> +               TEXT_UNLIKELY                                           \
>                 NOINSTR_TEXT                                            \
>                 *(.ref.text)
>
> --
> 2.39.5
>

