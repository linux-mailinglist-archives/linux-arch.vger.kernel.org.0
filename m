Return-Path: <linux-arch+bounces-10384-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A21A6A46764
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 18:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6003A47CE
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 17:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B096E22371A;
	Wed, 26 Feb 2025 17:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/8x3DgJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B4E221DA1;
	Wed, 26 Feb 2025 17:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589599; cv=none; b=CaEeYgcns8BONft+EgJNvRfBAfjeDwKA8KD8rJbgYjpVxbuNK2kfV3xAxbRsWoB7yEAV/IUO43e2u9Acv3Lgja47HgHI/z+iWtP9VHhJs23tNiZC8xmFMCxehYwdZAjtKlwTRUSKeQQUFA1GnP/Sy9fIbA2Gb4IrS2/+3SjC9pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589599; c=relaxed/simple;
	bh=2R180IJ7APaALd1g+yyfkVhGYnf3hIvGDgk8lsKLG8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m8TRhcxJ8E3aPz7bLSpfkPrnIcocCIott6ZVLDDO4z+gY8rni9T+BvmmjRIctFzF+QofmMWLcAbFzwExQjXQKv+VdbrC7nG5puN8Tlh/W1fTC0RneefW5rLhcyxMzR4OaDhIurtyCinpqBw8CK1ldNMHBnFs7mFA3Ih+1KSupnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/8x3DgJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC56BC116B1;
	Wed, 26 Feb 2025 17:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740589599;
	bh=2R180IJ7APaALd1g+yyfkVhGYnf3hIvGDgk8lsKLG8A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a/8x3DgJgskglabgyo16PGJtzrAVaL3wlI4GWiUa2t3h6Arsj1fdxCDGHHUKE1qz+
	 MkWqGYj4HEBPBct7yYViRQUjlal1IbYHMnBCcmswporwMRHlB0Nx9dMjqXBPC9R6BF
	 4qXyHcAPiRTt8nxgOwp7kjYrgjhT3u1JQIevs3oxA6uy6x3/jSFm7QuEaI+C811iY+
	 4AL2jhdvnuhR4d5R91R5M0A3eER7PnxdjHvqOLqUclMX+1F16ZGFfW+dcq/tsjnLMP
	 kSGz3A674HrBV9uFQqMNpCDNbxrVVIxuFXU3Ie1gj1RsPLiIjEfUxTtzaPunB5VN6E
	 gP899WOFULZWA==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5fcd811d939so580383eaf.0;
        Wed, 26 Feb 2025 09:06:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1vPJFgkoyBTCdNw1rIiYiW8YUNF9HhM9VaqAZ4B4yEPdqoAAbEIDZ0o0Q6Rg5rux9WYh+meLb8lRKx12/@vger.kernel.org, AJvYcCUSDPE2Kl8M+7tbz7bCGjoKzqd1onjZylURVRI7FCYD6YzZyFNz6OdTPv/yOB0vjrMYKxRtBtjs5iD/hQ==@vger.kernel.org, AJvYcCUe+0MrzgLg5q81ot+3P7kXDFDDpCqjtquPJiLom3G8IZ/8+eEHtpmsu/JMEky5b95OP+iinJOa40YGBQ==@vger.kernel.org, AJvYcCV4bSwqvhjKgmoG7xQK1fRFqHrNEzNyFrQKgf8A3P/jZ7IA907+RNDZvJBWZJ6Bpirf5av6EhxOGc/4pd4ID/0=@vger.kernel.org, AJvYcCVPbHi1at06YwsIaMt0Yofh9Iwv1VohDT4wWsmGIcx4EpBCu4T/tD7p9UEfYG9rlvSwSAoVlLHREZrQFlwV@vger.kernel.org, AJvYcCVTiZbwv8Bom8+ndrw4bl9f5hnk6gLmH0fayyhA5BVKbndv4YgviLbEX6DI8qlpCDqPcjsvG5kv@vger.kernel.org, AJvYcCXMHLoZc61wf+WW7M961lIzX55prjUjgLz7iTtu4ijfS77SVyJYe4v5UlPajl+1kFx25VCrojkxJ0Oz@vger.kernel.org, AJvYcCXZPGPzuoeF0XjVRL9NSA/jtSnHijtGwqtGUeFEJ6VjYlVg8dhoxntEjp6qhuAJqrAI7eQ0MD8Nyrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUiLgECOSOV+P096p4zKi6lxpj31zoCwRXzUM5tyAHOu1AF5mD
	ZW3hbalWNlyMwAQpTLuHY8M5UEb3cCkCAJm1MCd6JNjTztaTELU4KRvgfYXrI+t+qzqkEFYJi52
	bSGcfhHiGLdpvzdJFsVkC6RobjMc=
X-Google-Smtp-Source: AGHT+IHyPLVjXp7kw5kgInAMNb4jd7h5cWQZCWKEZs0yMGYHKslrekdKrqf86zX892n/fj3IchT6bMpb2Dem6Q8+U3o=
X-Received: by 2002:a05:6871:d20d:b0:2bd:286:d713 with SMTP id
 586e51a60fabf-2c155700434mr67466fac.11.1740589597661; Wed, 26 Feb 2025
 09:06:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221-rmv_return-v1-0-cc8dff275827@quicinc.com> <20250221-rmv_return-v1-14-cc8dff275827@quicinc.com>
In-Reply-To: <20250221-rmv_return-v1-14-cc8dff275827@quicinc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Feb 2025 18:06:26 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i-_08mhOpsecuU+XzS8rKbk9mtgr_Kwx-QGRPh9jumKw@mail.gmail.com>
X-Gm-Features: AQ5f1Jo18T3Py72uAV75_Jf5fdQvWu4rZ8JYWNQWcMOGXjnJR1QY3tpi4Yj9mbE
Message-ID: <CAJZ5v0i-_08mhOpsecuU+XzS8rKbk9mtgr_Kwx-QGRPh9jumKw@mail.gmail.com>
Subject: Re: [PATCH *-next 14/18] PM: wakeup: Remove needless return in three
 void APIs
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Lee Jones <lee@kernel.org>, Thomas Graf <tgraf@suug.ch>, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Zijun Hu <zijun_hu@icloud.com>, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 2:03=E2=80=AFPM Zijun Hu <quic_zijuhu@quicinc.com> =
wrote:
>
> Remove needless 'return' in the following void APIs:
>
>  __pm_wakeup_event()
>  pm_wakeup_event()
>  pm_wakeup_hard_event()
>
> Since both the API and callee involved are void functions.
>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  include/linux/pm_wakeup.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
> index d501c09c60cd..51e0e8dd5f9e 100644
> --- a/include/linux/pm_wakeup.h
> +++ b/include/linux/pm_wakeup.h
> @@ -205,17 +205,17 @@ static inline void device_set_awake_path(struct dev=
ice *dev)
>
>  static inline void __pm_wakeup_event(struct wakeup_source *ws, unsigned =
int msec)
>  {
> -       return pm_wakeup_ws_event(ws, msec, false);
> +       pm_wakeup_ws_event(ws, msec, false);
>  }
>
>  static inline void pm_wakeup_event(struct device *dev, unsigned int msec=
)
>  {
> -       return pm_wakeup_dev_event(dev, msec, false);
> +       pm_wakeup_dev_event(dev, msec, false);
>  }
>
>  static inline void pm_wakeup_hard_event(struct device *dev)
>  {
> -       return pm_wakeup_dev_event(dev, 0, true);
> +       pm_wakeup_dev_event(dev, 0, true);
>  }
>
>  /**
>
> --

Applied as 6.15 material, thanks!

