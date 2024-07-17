Return-Path: <linux-arch+bounces-5455-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E0F9339EC
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 11:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517401C20902
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 09:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5C14503B;
	Wed, 17 Jul 2024 09:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsyL02OW"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E94244C93;
	Wed, 17 Jul 2024 09:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721208770; cv=none; b=LLXrHK21eImzvYaAjasbvsClzmGtcvX8Y3igy6rZvBjW0yzcZ8uVs59wukuwSZGbtzC716cmy0UDtjXn9HumsWyhJ9ib439nZY90ChWha9qZOvsMUEsUcLku0mplesCsRZ0JJupt56GTYllNnb4Gf8/paB1lzi3yM+YbA0n9t4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721208770; c=relaxed/simple;
	bh=BPoikN4eZbA2j6qnyQHeGQ3/OcpZNXn5SlombO1h5qQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oIzQJXxBJCfNAWJDELGeaS3xgYVnZZYaVTL5Vzahg0NmkJuhU2GplV822HvdHPOYv4O4pTVaaj9ysNq5327Ew5647c5p0BsG12xTXJp4R1ydJgSk8CO+nREWkXUNYGISnAAp4+k73bVM8lxFi72yIsdha4IjOhEisTXopWcJo4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsyL02OW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4D9C4AF0C;
	Wed, 17 Jul 2024 09:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721208770;
	bh=BPoikN4eZbA2j6qnyQHeGQ3/OcpZNXn5SlombO1h5qQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FsyL02OWCdPudNvDch8VJkS2pL8BXFbouQhrvOES9HNNPe7aVLlXyyeZJwQmAcHbN
	 +nKwa/GfHpp4/GlPOaO1BaY9hvGdoYxPyy2PiRdZc2P+/owYMxB4ySL4vVIL4zV1wi
	 9kt5XFq8flxXCc3X6GAPBhTH8M/IGinUnZdgj0xOrA7sNFKJQoovMsP1sO1YkczafW
	 OJwTaeuB6xkvOptTNk/OKKqWuAJNNgESTTjyPgVOu1BcIqVpeH5XYZQXaM+kDw+qS3
	 qCbLDq4zAzI+fifZvm+LB4+pUTTMOWTwRvMbMANLKcVhDbG1d3wSe2ydWMCEu8p7fq
	 V/LbXCDm4Ln0g==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eea7e2b0e6so89386731fa.3;
        Wed, 17 Jul 2024 02:32:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGyj//kwLwIGcM22+9APJfSioDguWdPiPEzlvPnOKkGHzmwodqtW7gthhpZrzkUGVdU6Imx3oKlccOPnTWw7rX02dwxUqzkusTRIH9i65IjlU6H/gV5RK7b4/T9/xEPC1gDExkLELsTWpWhArgY7+m6BuDcgE54Ser2Xf2lAYxEgu0mw==
X-Gm-Message-State: AOJu0YxCAWic5xS/FETprR69Lm7hvdB2uIV23ZuFcwiXCPxJrOZEz5/W
	CCDXpPsLxTnLQS8JewrYqoHGH2Uyz8d4u84BbIVCr5KgYUQQZg5S8wLqH4YiqWs82/m2SOWTz5t
	lwR4gzvhV0TKSHRgVLmWVL0WafUg=
X-Google-Smtp-Source: AGHT+IG7M8ib0gDD7vtyWehz0t3NlPOXfHBE2/04rhjPNb3w6EkGrjJ+E+Vh6YALH0AXX9TE2DCx448+9eEQnyUh1yM=
X-Received: by 2002:a05:651c:232:b0:2ee:d5c3:3878 with SMTP id
 38308e7fff4ca-2eefd14cf55mr7287111fa.37.1721208768530; Wed, 17 Jul 2024
 02:32:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717061957.140712-1-alexghiti@rivosinc.com> <20240717061957.140712-3-alexghiti@rivosinc.com>
In-Reply-To: <20240717061957.140712-3-alexghiti@rivosinc.com>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 17 Jul 2024 17:32:37 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ2W5c1ObdtOosxsjg6gzfW5qL5LAxh4Fg6dg9aWfczMA@mail.gmail.com>
Message-ID: <CAJF2gTQ2W5c1ObdtOosxsjg6gzfW5qL5LAxh4Fg6dg9aWfczMA@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] dt-bindings: riscv: Add Zabha ISA extension description
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 2:22=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> Add description for the Zabha ISA extension which was ratified in April
> 2024.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index 468c646247aa..e6436260bdeb 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -171,6 +171,12 @@ properties:
>              memory types as ratified in the 20191213 version of the priv=
ileged
>              ISA specification.
>
> +        - const: zabha
> +          description: |
> +            The Zabha extension for Byte and Halfword Atomic Memory Oper=
ations
> +            as ratified at commit 49f49c842ff9 ("Update to Rafified stat=
e") of
> +            riscv-zabha.
> +
>          - const: zacas
>            description: |
>              The Zacas extension for Atomic Compare-and-Swap (CAS) instru=
ctions
> --
> 2.39.2
>
Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren

