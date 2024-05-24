Return-Path: <linux-arch+bounces-4515-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E658CE075
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 06:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CE3C1F216D0
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 04:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB823839C;
	Fri, 24 May 2024 04:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrAORZaX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F06828E3;
	Fri, 24 May 2024 04:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716526245; cv=none; b=X2cwip2crT9/kV72E1RsOxnae7LrLxNgh90KaTCUfdBV9VVH/dOZYg3wbKuui0oiw7PaR8bsxmU4c5uZKDG9pWZI9UoRc6xi1vgBX2l64U4kXj0hPn56d19ADhNyaPWMPwzmxgLImm8LNAErl40HrkuH8RRC0fJ8N8FYqw+4Ghg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716526245; c=relaxed/simple;
	bh=ZPWeYL/M8BoD4LoPUMjAiO4jhFdlLax9jM14Clchk1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CITkNwBtKYaQiON4xVm5FCGKp20X6e06CAS9wRgoTJF64b0Uj6kPmm1luwFkWlyLtSjXhS/fMYX7gdFQaavIk+/owoXV9Krr6/aoW9YfPuDwVhwaFy8FmBvAlmTQ3+B3Ak2yJS8yW5BUmG04cD+gUe64JAHApn4osleXkVDkeZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrAORZaX; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f3310a21d8so17478765ad.1;
        Thu, 23 May 2024 21:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716526243; x=1717131043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OIptIV19IdFhks5FxO4qOze6Xd4kuAo9MJ+XTfG/tCk=;
        b=RrAORZaX8yAGaDYPhbFOhZOlzUqr6jT9uvgbp3dY9sDI8HpUDZEfkPrqK0T1zM62EJ
         wtIE0YRLkCzarscsK0uB07efWKBe9jIy4c7Cs8rYwsxQlzIexXM21zeH59jXhRuKRQbr
         yJnqQkA86rC1XwRllJJ9dJt45QKti8OuBB36PcSAcSudcbtBfgUhEAsSSRGgeG0Wb8L7
         bUmL44eilINxA552NGRCAVfJqyKtSuT+XVwnAiUULWOcx1RRKra+DhCGsTR8x3OeWQIM
         msnBzVp/qAMsOOWfyMvC1cgjwvucJwBYIKz2BFDAJhK/3P+X6txJxH82KeGI2yShR/uz
         HS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716526243; x=1717131043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIptIV19IdFhks5FxO4qOze6Xd4kuAo9MJ+XTfG/tCk=;
        b=GwpAiQDMWKH35VLO5CpSjqi0ahBZRhRQVq2oX62hQJjK8QMZJDmxmz2mScKMX9CVNc
         Y69H3tbxyLIUmWLVsjCVLJMQGltRv+8Q+Mn+a9YMLBYhb1A7/qvrsydQor0achugwcwo
         Io18TBau61Vg13/9e0Dl2BfBW45SWQZsDf3a4Tr9FL+8VUnzcGtHOLFr0sPpPtgZTKrs
         LPlxX0qsbQLPLKtczko54ErJcxpRwE4XBFxZaD56BcGF3pvftac08CIC2tqH6We9qroJ
         ZH9oqKZcz+agn3eap6IsbWf1jkPk6ZGY/y2kcxGYWZ8g40u0wCIG08AcPP+fupheQSBz
         29sw==
X-Forwarded-Encrypted: i=1; AJvYcCW/qSqu6Tb4gCMm0M56H1UtG3Ja2FtkKf389StotIxTTheV2jWJah2lfOVzv/HEQ/x51nFCSUwNJaQNN6zQ4X24ytiL9joRs7HIi+lpk6yiGIp7xIqJv9bDXePTgRBBRtX1CWDTiUa4Vg==
X-Gm-Message-State: AOJu0YzyOMCb3WwEwrJ1vTwJa4z1EJE8vNxr/G3ofqLcEEE9GCGW0nKu
	9JbpXYx7wLBY1vfc7l8GZFFfwcDC6Px8lZG1bE89SyMqs4x4qRMl
X-Google-Smtp-Source: AGHT+IGph2ngJGkIc2ZoYCJl38SlsP/yXGoytXnEgHL9Q+wVYFcQgbKU4AH+MCEZUe8DoMBNd28k3w==
X-Received: by 2002:a17:902:64d7:b0:1f3:3f33:2873 with SMTP id d9443c01a7336-1f4486ed8afmr11797375ad.25.1716526243411;
        Thu, 23 May 2024 21:50:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c7ab7fasm4449235ad.81.2024.05.23.21.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 21:50:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 23 May 2024 21:50:40 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH v4 13/15] drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
Message-ID: <eeffaec3-df63-4e55-ab7a-064a65c00efa@roeck-us.net>
References: <20240329072441.591471-1-samuel.holland@sifive.com>
 <20240329072441.591471-14-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329072441.591471-14-samuel.holland@sifive.com>

Hi,

On Fri, Mar 29, 2024 at 12:18:28AM -0700, Samuel Holland wrote:
> Now that all previously-supported architectures select
> ARCH_HAS_KERNEL_FPU_SUPPORT, this code can depend on that symbol instead
> of the existing list of architectures. It can also take advantage of the
> common kernel-mode FPU API and method of adjusting CFLAGS.
> 
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

With this patch in the mainline kernel, I get the following build error
when trying to build powerpc:ppc32_allmodconfig.

powerpc64-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o uses hard float, drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.o uses soft float
powerpc64-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o

[ repeated many times ]

The problem is no longer seen after reverting this patch.

Guenter

