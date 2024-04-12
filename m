Return-Path: <linux-arch+bounces-3641-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6688A34FF
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 19:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BC9B1C21FB2
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 17:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26C714D70F;
	Fri, 12 Apr 2024 17:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TECRcDw+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C9D14C587;
	Fri, 12 Apr 2024 17:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712943753; cv=none; b=dp6SD6jM7InRr0jZvzLiMlJiufYqpifqiUS45JBDCzJ7Y1sYn2xLKl1rSCy+xm7aRugBUrxK0tC8ETXnLLfVWJG0Zr30w0P7alujdRmX4eCjAjxiRz2Vo7jmLTLr12CaBqgf3zfF4T8+i2nDNrJSH4ewq6d4bDCELzsXZgmxqac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712943753; c=relaxed/simple;
	bh=/nAjwVyb6TKfp7Se1ZzwuZHLhLGc0ePlRQ+AGjPxbpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8WMhv/WPGice/K0imOy1kZKjqMbJYibOcjhh7o5n+0n+Ivs4+cH0bANDPrcQVfqJPq+YaFhzBoxMHSj4Q65JhFJX8bnyJYYjEhd1ehys2ha6SfoJxHLZNgI/+W5Wu373h/Vb5dqV1p/v9AL/6czUuUfyfKFbE9LKNG/q8L4kF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TECRcDw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C448C4AF08;
	Fri, 12 Apr 2024 17:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712943753;
	bh=/nAjwVyb6TKfp7Se1ZzwuZHLhLGc0ePlRQ+AGjPxbpo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TECRcDw+dXBulhLRwfv++i443/tRB6tthncDN+3DL3HhBt2A4EDnpgO02vexkmcU3
	 2LgDrH09+UuqO/u930N+XhYzdJ0aMZIze7JQkwfG1KzROQjoKkek6qm0y/IUGdbQ9D
	 F8vr6x1yYO7OgFOmMnkRTaUp3uod5XkHD3zUx1HYhCAQ8FMrGjPdDPkvh/d0OzdRxe
	 BZKbCDbT8f2pL+eu7SMtePgTaWadI5Ys+XN6vYTRMkrTHD1VpMXM+Sns5aaWkwNjOb
	 3I2MNj8n3ObiRn2J9BttjJFP8l4gdtqnp2a0wvsBCNMoVGpCQfyGynPikfH1QTd6PT
	 XIP7ufaACw6tQ==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-22ec8db3803so166401fac.1;
        Fri, 12 Apr 2024 10:42:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWWIxIIQgxZh/ACnoEczyyTrpF2jyxoeupFXqyuJnHCEVu/d6VDUGH2gnRG1lSv1zQ3Pdlt/fv3kN5Jf1uv4yFDsq7ZEHQ8v8aLy0ArrXXveWqCKKgSsNd5OAI4GLYSCgXXHbavCSLyDsKNDjThqx9sHuF+TtKBwO5ABZUWaLVnk9JTUhw=
X-Gm-Message-State: AOJu0YwwcvGh0ODHFPPomIww06MblF6i1avfeYnmZpCDdsYLzcLcnTf0
	qbkUlRQDNmXnQg/4CcuUlrv91h0V+VCsjM3hlXqq3yIUfzoLpSqgjW2V0PecX6UvjHgoU65cCWh
	2b9R4ZSxZoDGaBVB9ILAy6jmqfz0=
X-Google-Smtp-Source: AGHT+IEJkeZDJTEL4cW0rpgNkzY06HXCYCu+TPlftZJzus+GEzgTu7rAYtLbl0X+S7TeyXUBRD7Q6k9BVLA6c/AYvs4=
X-Received: by 2002:a05:6870:e9a9:b0:229:e46d:763a with SMTP id
 r41-20020a056870e9a900b00229e46d763amr3647483oao.0.1712943752217; Fri, 12 Apr
 2024 10:42:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412143719.11398-1-Jonathan.Cameron@huawei.com> <20240412143719.11398-2-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240412143719.11398-2-Jonathan.Cameron@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 12 Apr 2024 19:42:20 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gK1SjiHzUT05eWZ_G_43e7UzsimTdG_g+F=mVQ=812yA@mail.gmail.com>
Message-ID: <CAJZ5v0gK1SjiHzUT05eWZ_G_43e7UzsimTdG_g+F=mVQ=812yA@mail.gmail.com>
Subject: Re: [PATCH v5 01/18] cpu: Do not warn on arch_register_cpu()
 returning -EPROBE_DEFER
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-pm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, x86@kernel.org, Russell King <linux@armlinux.org.uk>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Miguel Luis <miguel.luis@oracle.com>, 
	James Morse <james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linuxarm@huawei.com, justin.he@arm.com, 
	jianyong.wu@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 4:37=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> For arm64 the CPU registration cannot complete until the ACPI intepretter
> us up and running so in those cases the arch specific
> arch_register_cpu() will return -EPROBE_DEFER at this stage and the
> registration will be attempted later.
>
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
> v5: New patch.
>     Note that for now no arch_register_cpu() calls return -EPROBE_DEFER
>     so it has no impact until the arm64 one is added later in this series=
.
> ---
>  drivers/base/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 56fba44ba391..b9d0d14e5960 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -558,7 +558,7 @@ static void __init cpu_dev_register_generic(void)
>
>         for_each_present_cpu(i) {
>                 ret =3D arch_register_cpu(i);
> -               if (ret)
> +               if (ret !=3D -EPROBE_DEFER)
>                         pr_warn("register_cpu %d failed (%d)\n", i, ret);
>         }
>  }
> --
> 2.39.2
>

