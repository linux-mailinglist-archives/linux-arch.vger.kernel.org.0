Return-Path: <linux-arch+bounces-3532-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D9389F189
	for <lists+linux-arch@lfdr.de>; Wed, 10 Apr 2024 13:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C631F21442
	for <lists+linux-arch@lfdr.de>; Wed, 10 Apr 2024 11:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683AF15ADAD;
	Wed, 10 Apr 2024 11:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzWGbFT0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330D01494D6;
	Wed, 10 Apr 2024 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712750289; cv=none; b=cs600o/+zWgpkPKooha44d3/MDQgeO4dniFxJsxThV4Uxk2uxuPwLH/hQaW6iQBt4J6TPiAlIpCEtSzLhaBNNgQcNGLTM9JJXDzjE+t1XXmtYU1AC4iPO+sbI4arvO3wdUYH59vBJ0OtaAPoNVEihsuAfIUuNZteRJMHkKNJ/wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712750289; c=relaxed/simple;
	bh=NNn9PFSTYD7cqCl6hz0HImhdmwtK0pBHKxKy9hV4DKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7gmFfTG3LUU4byB8dPK7jeaQCE6tB90HFYz3xAh4x4odKHgr/dTl6A7nn1mDXeo0WSPzga+R+FfxK2IGWU2AbQPuf8XOLSKXpr2hFnu0wDDzXrf7Ge9+AvqklFYCY4eCOyqBE7LRHfxEVzz0fXwzhWYKantmSYUpPvaeylkVdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzWGbFT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79EFAC433F1;
	Wed, 10 Apr 2024 11:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712750288;
	bh=NNn9PFSTYD7cqCl6hz0HImhdmwtK0pBHKxKy9hV4DKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CzWGbFT0pQPr5PGe5Mcpjxw+oeW+QocsoylRdvqaI5HLgB/f62hSvN+KLluR14H3A
	 smtVRLg7hWq30aJc0OtF9AkgPjXk4vdGiUZTqVnIiCWiuq9ym6kXsvJrz/sR+f8LIX
	 3vG8UsYAU08EoVHW7xqRYL0OeFU0whxwBhRaKMuYc1emqwVMTYOQOxCy69w1IsYpjy
	 qvvpk7I1MXLnliKVw6Eh0e9XcgtmXLAOtcLSyXjCnUFC1C1G5UjslgeuhsKAJC80VB
	 JVZz7+uAoUUFLtMnpOcf4GaFRMGB86qujVcjf2mXX39UZ0Elock/AgrsExJQtkfL2a
	 7xzQfVgNVQLxg==
Date: Wed, 10 Apr 2024 06:58:06 -0500
From: Rob Herring <robh@kernel.org>
To: Deepak Gupta <debug@rivosinc.com>
Cc: paul.walmsley@sifive.com, rick.p.edgecombe@intel.com,
	broonie@kernel.org, Szabolcs.Nagy@arm.com, kito.cheng@sifive.com,
	keescook@chromium.org, ajones@ventanamicro.com,
	conor.dooley@microchip.com, cleger@rivosinc.com,
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com,
	alexghiti@rivosinc.com, samuel.holland@sifive.com, conor@kernel.org,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, corbet@lwn.net, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, krzysztof.kozlowski+dt@linaro.org,
	oleg@redhat.com, akpm@linux-foundation.org, arnd@arndb.de,
	ebiederm@xmission.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	lstoakes@gmail.com, shuah@kernel.org, brauner@kernel.org,
	andy.chiu@sifive.com, jerry.shih@sifive.com,
	hankuan.chen@sifive.com, greentime.hu@sifive.com, evan@rivosinc.com,
	xiao.w.wang@intel.com, charlie@rivosinc.com,
	apatel@ventanamicro.com, mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com, sameo@rivosinc.com,
	shikemeng@huaweicloud.com, willy@infradead.org,
	vincent.chen@sifive.com, guoren@kernel.org, samitolvanen@google.com,
	songshuaishuai@tinylab.org, gerg@kernel.org, heiko@sntech.de,
	bhe@redhat.com, jeeheng.sia@starfivetech.com, cyy@cyyself.name,
	maskray@google.com, ancientmodern4@gmail.com,
	mathis.salmen@matsal.de, cuiyunhui@bytedance.com,
	bgray@linux.ibm.com, mpe@ellerman.id.au, baruch@tkos.co.il,
	alx@kernel.org, david@redhat.com, catalin.marinas@arm.com,
	revest@chromium.org, josh@joshtriplett.org, shr@devkernel.io,
	deller@gmx.de, omosnace@redhat.com, ojeda@kernel.org,
	jhubbard@nvidia.com
Subject: Re: [PATCH v3 04/29] riscv: zicfilp / zicfiss in dt-bindings
 (extensions.yaml)
Message-ID: <20240410115806.GA4044117-robh@kernel.org>
References: <20240403234054.2020347-1-debug@rivosinc.com>
 <20240403234054.2020347-5-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403234054.2020347-5-debug@rivosinc.com>

On Wed, Apr 03, 2024 at 04:34:52PM -0700, Deepak Gupta wrote:
> Make an entry for cfi extensions in extensions.yaml.
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  .../devicetree/bindings/riscv/extensions.yaml          | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
> index 63d81dc895e5..45b87ad6cc1c 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -317,6 +317,16 @@ properties:
>              The standard Zicboz extension for cache-block zeroing as ratified
>              in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
>  
> +        - const: zicfilp
> +          description:
> +            The standard Zicfilp extension for enforcing forward edge control-flow
> +            integrity in commit 3a20dc9 of riscv-cfi and is in public review.

Does in public review mean the commit sha is going to change?

> +
> +        - const: zicfiss
> +          description:
> +            The standard Zicfiss extension for enforcing backward edge control-flow
> +            integrity in commit 3a20dc9 of riscv-cfi and is in publc review.
> +
>          - const: zicntr
>            description:
>              The standard Zicntr extension for base counters and timers, as
> -- 
> 2.43.2
> 

