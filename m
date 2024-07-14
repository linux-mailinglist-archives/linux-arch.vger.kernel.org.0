Return-Path: <linux-arch+bounces-5391-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F366930AF1
	for <lists+linux-arch@lfdr.de>; Sun, 14 Jul 2024 19:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2777D28111C
	for <lists+linux-arch@lfdr.de>; Sun, 14 Jul 2024 17:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA96313BC02;
	Sun, 14 Jul 2024 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Np/k4ysP"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677CFD27D;
	Sun, 14 Jul 2024 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720977773; cv=none; b=CJRTSAc0lgVtgAyIuluVVKSkupvf1b5cgJ6XQ1yYpiZCDjMMLYuRh7ZlrJMljeLeoixBk9621gHzEMMxJ7+1tx3bg0TiAAjMHvZNAdBTbNTHGC0GncBxN2lMtBQ1jFdvEelG8QuG6UoJp149EFtYRiEVspeB4jAekO9a8t58fyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720977773; c=relaxed/simple;
	bh=7xLPqy1jM0O+0195mcRA60FHmWtnGBVHJTGgtTxpOjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otWPQfpNIY95H74qhw+3RyYJwopaVPqH/SaOk7t6rXyYB4FXiEP2RBrj4sm2hxkXw78rbPC206BwR0HFzL7DImpmURmeLCsULxDbi1OKtQYr9Ev8/O+ch57XAJDGuqHXLV8f+LcycJwkfFtPvg4j0IcWcI7k7jHmdk+do6Jzerg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Np/k4ysP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13315C4AF52;
	Sun, 14 Jul 2024 17:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720977773;
	bh=7xLPqy1jM0O+0195mcRA60FHmWtnGBVHJTGgtTxpOjk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Np/k4ysPWfJGh/Vzr2yW3vI4rGlgUmizlgw7EEBEsv9eCLblCHD9MKYn7Y4lK5rKv
	 CvEpeHnwTHXXi+Fuo0HFdnwjqbaGWT+aPPCN3EMoPB5sY87mXioJBhuOa72Mj/5kS/
	 tiM1wNQtvLlGLpaAZHmQyE05p4mF6vz3hOrx1mR0+X6M+SiHXePabsj+YaMQ2aYy26
	 tNwBiyfhN6NjEBsb8ztjJnSDc5vbaa5yvjL4OclQ9xhSb7ayDX8kR7C5k7ySCG1sew
	 h9HqYsIPLZgLqxPeMPD6DKgywBsVGBMNy8zNezQcOfzlQY7Qxy3yi6Zz9I4ZGAHQW8
	 i3WCd4ViIlVtQ==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-58b447c519eso4683246a12.3;
        Sun, 14 Jul 2024 10:22:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW2dXsTFHoMn6RZLA6BTuJWg5MRNp4DotqAeCt8znc1YqhONxg+BQis8erVP8VsadEq49xbe894FTYi54a/rBuqJKOEOctEaJmAG5XRBl4uej1pNH9ZR0x8sD2NmkkoAoD1vWkdU5x7eDwSAqlcMSxNkM2jSju6WHia01iuJVFNzqG6iEFiDrOk4y+untSYLTAcRl8tY47ya2lwy0CXztU0hdjPQTQpEPpfWePjFfWrl4yVWFzcnUtJpNRwv3RCjCeuFkARPQhKQ+E1bIh5qYug7hR+FyNkx3uoreweZ99Maqs=
X-Gm-Message-State: AOJu0Yxn+DBnKxg32HqnNwP3Ju9aNdKimWuw4dQEjAKiFtnyiMvgIkPA
	AFGoq28Om/vngKUg4xCfIqFZwo5rXviPthhuLWTHTZUBvgbEQOEmPQpyltM5qcJ7tcigZqav+1V
	NKRthHyE5oRFIHVxHiTjJxqRFqhM=
X-Google-Smtp-Source: AGHT+IEqlf4co9CQdw2WGl/Xqoo4fkGgeyLA8K1xIwoAlG8h/Wd4OdPV3wQEkk7NltbZTH51erICKgVwW7rB3xSuihg=
X-Received: by 2002:a17:906:39d6:b0:a72:9963:eb8e with SMTP id
 a640c23a62f3a-a780b6b307emr939527966b.28.1720977771290; Sun, 14 Jul 2024
 10:22:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704143611.2979589-1-arnd@kernel.org> <20240704143611.2979589-13-arnd@kernel.org>
 <9b269c2a-c6b5-4fa0-801b-e5e1c3ccb671@app.fastmail.com>
In-Reply-To: <9b269c2a-c6b5-4fa0-801b-e5e1c3ccb671@app.fastmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 15 Jul 2024 01:22:40 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTDT=DyPs8NWe7gxvuNa0i_X9go2dgcBMGk9eqFdSwLTQ@mail.gmail.com>
Message-ID: <CAJF2gTTDT=DyPs8NWe7gxvuNa0i_X9go2dgcBMGk9eqFdSwLTQ@mail.gmail.com>
Subject: Re: [PATCH 12/17] csky: convert to generic syscall table
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Vineet Gupta <vgupta@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S . Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Christian Brauner <brauner@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, 
	"linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 6:27=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Thu, Jul 4, 2024, at 16:36, Arnd Bergmann wrote:
> > -
> > -#define __NR_set_thread_area (__NR_arch_specific_syscall + 0)
> > -__SYSCALL(__NR_set_thread_area, sys_set_thread_area)
> > -#define __NR_cacheflush              (__NR_arch_specific_syscall + 1)
> > -__SYSCALL(__NR_cacheflush, sys_cacheflush)
> > +#include <asm/unistd_32.h>
> > +#define __NR_sync_file_range2 __NR_sync_file_range
>
> A small update: I have folded this fixup into this patch
> and the hexagon one, to ensure we don't define both
> __NR_sync_file_range2 and __NR_sync_file_range. I already
> have patches to clean this up further to avoid both the
> #undef and #define, but that is part of a larger rework
> that is not ready before the merge window.
>
>      Arnd
>
> diff --git a/arch/csky/include/uapi/asm/unistd.h b/arch/csky/include/uapi=
/asm/unistd.h
> index 794adbc04e48..44882179a6e1 100644
> --- a/arch/csky/include/uapi/asm/unistd.h
> +++ b/arch/csky/include/uapi/asm/unistd.h
> @@ -1,4 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>
>  #include <asm/unistd_32.h>
> -#define __NR_sync_file_range2 __NR_sync_file_range
> +
> +#define __NR_sync_file_range2 84
> +#undef __NR_sync_file_range
For csky part:

Acked-by: Guo Ren <guoren@kernel.org>

> diff --git a/arch/hexagon/include/uapi/asm/unistd.h b/arch/hexagon/includ=
e/uapi/asm/unistd.h
> index 6f670347dd61..a3b0cac25580 100644
> --- a/arch/hexagon/include/uapi/asm/unistd.h
> +++ b/arch/hexagon/include/uapi/asm/unistd.h
> @@ -29,4 +29,5 @@
>
>  #include <asm/unistd_32.h>
>
> -#define __NR_sync_file_range2 __NR_sync_file_range
> +#define __NR_sync_file_range2 84
> +#undef __NR_sync_file_range



--=20
Best Regards
 Guo Ren

