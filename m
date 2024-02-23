Return-Path: <linux-arch+bounces-2696-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91198861052
	for <lists+linux-arch@lfdr.de>; Fri, 23 Feb 2024 12:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9271C20F35
	for <lists+linux-arch@lfdr.de>; Fri, 23 Feb 2024 11:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5509B657D5;
	Fri, 23 Feb 2024 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6V3ebCU"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9AE1758D;
	Fri, 23 Feb 2024 11:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708687594; cv=none; b=ldyhX1WuwN2ba3hUP8iv2zmv321sv4lEony2mhuPMuNulYJ7TqNhq7K1DiauQ4w+2yg5W7coEWCbimrquPPNc5j8E+uU+eYEFX1eZ3oJgwVT5Ezp2ffayI7S9v61ejRo2nX9mlmQB6Xiufu+/qPVWnZdtLT0q1ulfW0/ftH/GCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708687594; c=relaxed/simple;
	bh=AkZ+DKHwgXmC1lpk8RK9iEzg2PWS/JSY4R/vFXjVyms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rUvTvkAVr19Gh4CHpiyYCs2+4UaMHN0l1SPuUsVh387ugZAYv6CAupvNY5ihRT1H597axtIKGrmumzdHduHVXIJYZ+nXApek+CBYaDTtFjoh23MQSjtiqKicAgYN6scKdKmnQAnVdM8r0/epfH99Lj5nPKnAVJkW70qldCeuOcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6V3ebCU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1E3C433C7;
	Fri, 23 Feb 2024 11:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708687593;
	bh=AkZ+DKHwgXmC1lpk8RK9iEzg2PWS/JSY4R/vFXjVyms=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=o6V3ebCUP9eBSWueVzfMbIP437jjDseXjusXchRCi7Sz2LqXaMpad20mE3HHLIXrT
	 neXGLQNkBX1KU9s6yNl91Ey9Dn7gYkCTrxzhIDqaP6TZJDXf96Su1+ZHotOQ3CbhPv
	 iTdH56Z9Ut5LG8yHSyhf8z8nfxcqEgGVK/lhC8sEz9xyCBg7M+57MlA1x47izJeEeI
	 AVHIOEr2tWd71d/ghV5y29oICBhHZ5p+eWu/q7+Q/TaHYZTwQRd3H5uk87TjwJo1ni
	 qRGNOiQK40GHm3m8TsWFpnuahcSe5u1d7Uz79iH58V8gv+dfNR06QCRnAzMAAvdpsW
	 jWPvL3QEc92uA==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55f279dca99so964273a12.3;
        Fri, 23 Feb 2024 03:26:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWVnSgxw7KDq9R7jPCqw0VYEp3oTNDWMuYDXE19/i/q2uKdT9Wnj/MdzhYhgslt+Sbb31a6dCjsLFwQhx0hG+qIxvA7f1F8sIqRea+2+GACotmEchhOdV7DnoMEklqDq0CuaUyMBIJw929E4wiwK9ovjejb8SM5Hk7kGWJ/IdT7/8QnLW/JzOHZef8/DT322LPxOCfjCcYm75OivsfHwN6346awDV5Z25xyKPmyagSPB1PZBhugAdgJMvV3jyc1Xdpu6F8=
X-Gm-Message-State: AOJu0YwrXVhLE7Yoq3AcVDreBEcg77IeIQN5gMMIQv98w9K/3W8Wsk+g
	kMZYd6rggVJwrtTV9AkfZudgvm7cJ8yWFNgrv8sdxeLSK/JFMnttwMxxELa9iw7YS9q8cYIOTQr
	N7t/m5CYjKVzXjOzZSggb8dwKm50=
X-Google-Smtp-Source: AGHT+IEjMmw+014zjyQSAi0NcUE1X7qFFUby+lYqR8wiYzMGaFTlSKtY+ZDZVBYW+5DHEm2AVm+JIvQp0eWONX2p2C4=
X-Received: by 2002:aa7:c317:0:b0:564:bfe1:811f with SMTP id
 l23-20020aa7c317000000b00564bfe1811fmr976355edq.36.1708687591964; Fri, 23 Feb
 2024 03:26:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131055159.2506-1-yan.y.zhao@intel.com> <20240131055904.2652-1-yan.y.zhao@intel.com>
In-Reply-To: <20240131055904.2652-1-yan.y.zhao@intel.com>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 23 Feb 2024 19:26:20 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQh2Zv7H0-S1=f-Q0W7KFAEwExH1uuoJCsKnAm1_LzL_g@mail.gmail.com>
Message-ID: <CAJF2gTQh2Zv7H0-S1=f-Q0W7KFAEwExH1uuoJCsKnAm1_LzL_g@mail.gmail.com>
Subject: Re: [PATCH 2/4] csky: apply page shift to PFN instead of VA in pfn_to_virt
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: arnd@arndb.de, linus.walleij@linaro.org, bcain@quicinc.com, 
	jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 2:28=E2=80=AFPM Yan Zhao <yan.y.zhao@intel.com> wro=
te:
>
> Apply the page shift to PFN to get physical address for final VA.
> The macro __va should take physical address instead of PFN as input.
>
> Fixes: c1884e1e1164 ("csky: Make pfn accessors static inlines")
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
>  arch/csky/include/asm/page.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/csky/include/asm/page.h b/arch/csky/include/asm/page.h
> index 4a0502e324a6..2c4cc7825a7b 100644
> --- a/arch/csky/include/asm/page.h
> +++ b/arch/csky/include/asm/page.h
> @@ -84,7 +84,7 @@ static inline unsigned long virt_to_pfn(const void *kad=
dr)
>
>  static inline void * pfn_to_virt(unsigned long pfn)
>  {
> -       return (void *)((unsigned long)__va(pfn) << PAGE_SHIFT);
> +       return __va(pfn << PAGE_SHIFT);
>  }
Reviewed-by: Guo Ren <guoren@kernel.org>

>
>  #define MAP_NR(x)      PFN_DOWN((unsigned long)(x) - PAGE_OFFSET - \
> --
> 2.17.1
>


--=20
Best Regards
 Guo Ren

