Return-Path: <linux-arch+bounces-6421-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9678595A009
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 16:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428A71F21CCD
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 14:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206BE132111;
	Wed, 21 Aug 2024 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="QT0rUCBF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80719136E37
	for <linux-arch@vger.kernel.org>; Wed, 21 Aug 2024 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250957; cv=none; b=UsIUimzALMamj5igarsrnl6Rm2ek5QjBkYV9sM+IPo0zTFh9cTdExJJx5Cs5+yDGcniFJiSdDO/cJXfItYm552hLHdBKh00d6xLVUZPlz6/tR6MwDrb34o9y555lvk2lCN8to6j60kNYVcjUDVTFudoZzQSf5be+REwtlVa2X/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250957; c=relaxed/simple;
	bh=xPN3fp+HqP7NTF7k97te02bUt1dqhkQj2xhwfzzRhOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1eHGJSCcFArfrXxpL1q0+4r1JEmVXQPRrkiH1CYreqBha2CpZolMyl4g1zcznoe3cbOyZmtX1nmB3bc9j/u8BNNt8TGCtByRsAelpZ7XSzFVm5tkpTfzC+o9fKGW0itbEm3Dq0AqiAbkfqMPau3WsitzobjiYXd7dW0XSoriDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=QT0rUCBF; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso74174085e9.3
        for <linux-arch@vger.kernel.org>; Wed, 21 Aug 2024 07:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1724250954; x=1724855754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fvwZ5YwSqjVjAyJCShHqzpR3GyktjwhDKbfpd5HNn9I=;
        b=QT0rUCBFgP14JGDyc2rP7hzDbVLe4N4XagqiqPziDXcm7tn5t+l0HZkOiqaW9Emov6
         Y8kborlvdrE5uiL0Ab8dbXViZ0cbY1t6PAPaBOGX4d352XTodw3r6qpwNOTzY3Kr2HG3
         Ws+4ExlxIi4zLTfK4XVk3Po1gj84Od6aofScAcOELE8IjmtpNgrUz+lzDqxhjunt+R02
         OR0K1qRQWru1AKJbBSSxDxiue95NOWGCmjdMBGKDuX19tEGp9OU3jejUCwV9Rtd8PFAz
         GGFPIDU4cfDM9tDQUq7IBmiYy59LXAy9F6tcuSPtCJ87nizl2Qn8qZ1ClPPBfWifFhbr
         8Apg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724250954; x=1724855754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvwZ5YwSqjVjAyJCShHqzpR3GyktjwhDKbfpd5HNn9I=;
        b=LT1EbvbP7xZyQb9z66XC0xlFjuGXrOpFhWt0oVHoWwYCZv03ie4dujg3Re42RPgvlM
         ZVjNvw9L9e1qKmPc/X3jP8HmD6C5TwZBh71cD09Hgjay/Yh/MdCzBHs6KHVgmxbyC2bO
         OUunwywdyFlxIYNXpRzC5Lo6YfjEOXN4sZzV4o1usj76q4vk7EYQAqAlJ6sBoAdwN9FU
         zsG3j+A4ItiZRru8Y60ubGvazF1NX+1bcyE57wsC8l/3By6PzprioohSHgGagyLHZmZZ
         gVt0wByw/JSG7TJAyui06tfKkUqBBG9jXYbE1DYPG7pCrulyRCl67Zm77IKj6lDHn2F2
         souw==
X-Forwarded-Encrypted: i=1; AJvYcCWn430UZ47K9LHXmzAD6byRTWJzOGCgfI8qJJ02FaJVCxTtYLIeeKlK5VIdWwzppSEPtosMP0xgOGki@vger.kernel.org
X-Gm-Message-State: AOJu0YxKayD+FfRTsxdLnYkUMR7+lb3tozK/+gJRKPJkLBWRun4Tzf2v
	2JiZvKyhV91xX84RT4OeLbUb1JoiiWHmK+xPzatrD8Q+DSbyUUY18SeJkUgOhnU=
X-Google-Smtp-Source: AGHT+IGKUdmvaw7fp6jVH5UhYyWJ0984BCjDbxk9W2P6qBYfR0XWj8kIWEpSBhCOcvDzSAZMrXgjRA==
X-Received: by 2002:adf:ed10:0:b0:371:8e24:1191 with SMTP id ffacd0b85a97d-372fd731e99mr1837015f8f.53.1724250953491;
        Wed, 21 Aug 2024 07:35:53 -0700 (PDT)
Received: from localhost (cst2-173-13.cust.vodafone.cz. [31.30.173.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718984c0d0sm15793407f8f.38.2024.08.21.07.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 07:35:53 -0700 (PDT)
Date: Wed, 21 Aug 2024 16:35:52 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v5 12/13] dt-bindings: riscv: Add Ziccrse ISA extension
 description
Message-ID: <20240821-6cb6f81cbf450f400444014b@orel>
References: <20240818063538.6651-1-alexghiti@rivosinc.com>
 <20240818063538.6651-13-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818063538.6651-13-alexghiti@rivosinc.com>

On Sun, Aug 18, 2024 at 08:35:37AM GMT, Alexandre Ghiti wrote:
> Add description for the Ziccrse ISA extension which was ratified in
> the riscv profiles specification v1.0.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> ---
>  Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
> index a63578b95c4a..4f174c4c08ff 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -289,6 +289,12 @@ properties:
>              in commit 64074bc ("Update version numbers for Zfh/Zfinx") of
>              riscv-isa-manual.
>  
> +        - const: ziccrse
> +          description:
> +            The standard Ziccrse extension which provides forward progress
> +            guarantee on LR/SC sequences, as ratified in commit b1d806605f87
> +            ("Updated to ratified state.") of the riscv profiles specification.
> +
>          - const: zk
>            description:
>              The standard Zk Standard Scalar cryptography extension as ratified
> -- 
> 2.39.2
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

