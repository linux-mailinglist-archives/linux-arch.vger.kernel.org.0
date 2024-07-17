Return-Path: <linux-arch+bounces-5457-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E494C933A32
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 11:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A11402842E4
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 09:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7390D14A097;
	Wed, 17 Jul 2024 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRyzN9+M"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483A7224FA;
	Wed, 17 Jul 2024 09:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721209337; cv=none; b=cwSxxLzBRIwxy6xtEtrHIO65mEPGZ7QqbztWIqNaOTKgIDBTAYsE1HULZEmvHMewIWz+z6M4UBCPeYhcY29nd0NPDuPGHThpDRN6Fcnfa68zCCb7hCar0YT6BFycEhvqbyKkZuL+XTnDDXqLneVOmv0CF1bySiJVqpe4/UbjPAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721209337; c=relaxed/simple;
	bh=4wsWKtT4pzbR3ZnSQuInnMNaiV+eFoZ7JNsZBHRlVZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CzRv/V0ina9WP2qX3Al//dgAqMwUbs2mFd6jldds/waSwZNfvSE7BGR6ortP2tdvA4b6cC6+FjO/O2wnPKaSg07WI4QH/Gub16+9M8F36gmkIDUVLB7c3tVqls9RmpwHBOIVEo9taziHoOszaLvlyBsihH87rCo13IYrV1FlzQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRyzN9+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AD7C4AF15;
	Wed, 17 Jul 2024 09:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721209336;
	bh=4wsWKtT4pzbR3ZnSQuInnMNaiV+eFoZ7JNsZBHRlVZs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VRyzN9+MaTsL1fzKS9dRhvspzof/X5Mah4RnJPHPYcIp3cwyvZAV/NRdmCLxFzWDB
	 ErM9VEKHPp1NV6bTn7eHTPWV8Y/JxJEYK0SQv6CQqZHEOW1ik20NTGEVjENzZIMKXN
	 MiEL+30s8w29cSBvLxGB0ZppHRWVGISilrxjOwij0dTea8kDVlTku62UHCw0h/AzAO
	 d8IW6CAo/Z3NTSds6sw1Fxy4sdQGxNdrNs9vZmP1yFp5jA6Kogs9MqsUYkTwUlgP2M
	 T2+mZyXKvv6MsDxUHlZ6jg6fRWayutquo+53hClZRZHeLxrjoqG4eFruL3gqInOvxU
	 MBBFxrSj7jwAQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58d24201934so1098138a12.0;
        Wed, 17 Jul 2024 02:42:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXY9PFPrsBd2vf5yClF+it89OcHA2MecKio1hAy3JXTqvccy2WsNzhWvNwoPS6K+Vxk1ntP9iDxL5MGHts1nrw8F2oZ30vzGpF6kIswuSomdAM3ObxEDFqFu3REyqAO0yDHUq+JLemQPkb+dEJoHZ3mv5Q0BhjdehEqtXm8HMelTaBnWA==
X-Gm-Message-State: AOJu0Yz7+5kZF23qmHm+/+LUVwNMv195wnf9IJIXhrl6P7LNlTCSMOh3
	E5N8aVB2Bn8FYVpFd8l3bEpFCeXoJmn1lYrzCYuI/Skn1H9b+NhqmZFNpxv10fxftpdywnS1Q3u
	1IkI1tZeagRVB9PDnqsSb9Pq9YTk=
X-Google-Smtp-Source: AGHT+IGiAh07Q4bbOoU7hNbdq3a1E1po4+o3FRxrUjYkTgr0fGJMGJBP0KlzYZojtvYYoe1XftYpOs7aU54iRzxyjoo=
X-Received: by 2002:a50:d7c1:0:b0:59c:50c3:af65 with SMTP id
 4fb4d7f45d1cf-5a069e9bfa2mr1331551a12.14.1721209335328; Wed, 17 Jul 2024
 02:42:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717061957.140712-1-alexghiti@rivosinc.com> <20240717061957.140712-11-alexghiti@rivosinc.com>
In-Reply-To: <20240717061957.140712-11-alexghiti@rivosinc.com>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 17 Jul 2024 17:42:03 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRSeoa+_w_bp4D9i3w61D769OZBcMAPPhbSadkvouwrLw@mail.gmail.com>
Message-ID: <CAJF2gTRSeoa+_w_bp4D9i3w61D769OZBcMAPPhbSadkvouwrLw@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] dt-bindings: riscv: Add Ziccrse ISA extension description
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

On Wed, Jul 17, 2024 at 2:30=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> Add description for the Ziccrse ISA extension which was introduced in
> the riscv profiles specification v0.9.2.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index e6436260bdeb..b08bf1a8d8f8 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -245,6 +245,12 @@ properties:
>              in commit 64074bc ("Update version numbers for Zfh/Zfinx") o=
f
>              riscv-isa-manual.
>
> +        - const: ziccrse
> +          description:
> +            The standard Ziccrse extension which provides forward progre=
ss
> +            guarantee on LR/SC sequences, as introduced in the riscv pro=
files
> +            specification v0.9.2.
> +
>          - const: zk
>            description:
>              The standard Zk Standard Scalar cryptography extension as ra=
tified
> --
> 2.39.2
>
Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren

