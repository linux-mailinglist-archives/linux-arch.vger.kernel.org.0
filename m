Return-Path: <linux-arch+bounces-10743-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB30A5FD61
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 18:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1356E7A3C36
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 17:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2344126AAB8;
	Thu, 13 Mar 2025 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOimpLfw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610FE26AA9D;
	Thu, 13 Mar 2025 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886094; cv=none; b=mq7C5cR89NWZO2QbNmKPA2Vk5q2eVYr9b1tPvwgD+PaFN0w4odEqY6/XAsWRVnRntc4Rx9hkPb3NCqE4pUeQlEEoP/vQRjjhP1fU6VRqudYx5ynxk7T1BkjNcv2N6M8L+sxv7E27XvSnUIypmm55tuaUGoHrmNkfC3kXHS8kHPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886094; c=relaxed/simple;
	bh=Z0R4Knirkvu+jEmc1w5aGtkeADSH26ueKwL0dPhNn7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jrM1C/1SxxWEQwvuLUGH3P+C0SA3CPCJ1Ye4nHxTjmp+HEMlFym8CMYiyGszj718b1CxKRz/otEVIrRnB1t5iXkkQe9022MGe6fhskwuBay4kh/pbHQaPT+91uQtzA7t22b6uLsSs2Cr7efR8ybfRgnfNm18ruHbiOb1uhL9Iss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOimpLfw; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso2228694a91.1;
        Thu, 13 Mar 2025 10:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741886092; x=1742490892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3DVX2jUUT8USovuBtaAWfLwoCZG/vTo0soqbEn/R/c=;
        b=cOimpLfwOsJiKE9zqThVaUQT49FF1dUz73n612/el2IC/OjalZOYFquXY2F5uUEPBP
         lJlOSdEMkN7v3YXxIYSBk0vEYbo0jxYU41mn9rcxEyrOLw4W+Pvc7Lnl2b32uIYrT7T2
         XBgS7TpSuPg895A7kcyW4pFB3R1Az2ohe0HfMYT9BxTpWKLCFYRdkrF3+St87a48wl2i
         kT24xckDqNXwW2rHvGWRn8JVSgykI/gxf+Pk0tQtZF0sYxdpD0LKIvs+s58hzbUYc6qy
         C5RoSbi+Q4UJ5ifJx4j8VmodUBb4IZFmadkAr+diIyIBt4VusvwCxmQ8WjdP+i82e2uh
         m1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741886092; x=1742490892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3DVX2jUUT8USovuBtaAWfLwoCZG/vTo0soqbEn/R/c=;
        b=JAddBkSY1z7DdLGlC5vn3v9YnuMopgi9sPDxNvGY0JO3faVuY9bNkrBjqdX83umGzU
         lSOJaeELQPm5D8B1YwWHnpk4+iWxo2XYP0KNdAKLSrngemLhwb08gT0huGlYwxKIz1Yf
         Vmx+7pBHJB2dFPaXbRfUWspo9V2Jrsc907HfA8NniFsqW7mjkDkwzJUniMbJsHd6lzht
         LxYp405uatpih/FiTHGcA8iLihqfwbKbcaktqvJGv3aB96HYF/U0fH/Pr5FXBlFJ10k/
         p5isdlkn6Obsb90tH0bazKP+H9lH8zTdvnQcKmDGTZPKzmllFB9JBwBc/PPWXU08hBlu
         lm4A==
X-Forwarded-Encrypted: i=1; AJvYcCU/1Dr4r3BWYRCNy9SSqfbYhfK0+nh+0q1f8CkmQSx15G5iTyRChJfaqXT3dZlnyB4OR/tUlgZdMIOjUQ==@vger.kernel.org, AJvYcCU2KJKyzozYmMbNP2UEV/xf6ZaUz5ewxSaTg2+WY+Arq3nXxI0FHnbb5mLpUdsk4uw+KALC0e4w0BtJiA==@vger.kernel.org, AJvYcCUbI0hZuyaYyhFwZpXBev6+jT8uAbjySuI/WIkfmwv04l68zIRTdw6i84wG7NapMl/6QjzcvpG6xyHfoFBD@vger.kernel.org, AJvYcCUjvCmjXMxrSQvAZC07MG9KjWOqLaOpgWRtX1WMubJeWg6pKxViz72eFrJ3BL26o1QwXN59ng/M0Ubtgg==@vger.kernel.org, AJvYcCUlZnxdyKmA/1rwK2czB7azKTFuh6kPRkyJkMnlKNe8/nDb7pK0t5UwFGIu4I4mUiFHEww0MnRs/zI=@vger.kernel.org, AJvYcCUyPODGAIHCv2N60UzEAHS7K1QY3rbyVJLD3xEFiGRWKzGkU16Y/Al9fsOztjiX2x+zEdijWIXJpEiy9w==@vger.kernel.org, AJvYcCWXoJOCLDyvjvSGTKYUMg413st2pO3GopK60J6uifXq2DyHeszXaAby5K5fAhVZj3ynvXFCiX8PxQK1S3Yw8A==@vger.kernel.org, AJvYcCWY/7BPMC/c0W5T9jpWkyGaqjNa8pC/b9C2hnL4rbgjUaNt1M/DFWn22otkwTT3ZdFkTKk5heH6ak0cqmBY@vger.kernel.org, AJvYcCX066NzYUWvciJP3yhUbZygNkgBPdFPg8kG1m9Q6dHO71FAaEc0tYItJBvZ9cAHns6WNSFxd4zxgfyEng==@vger.kernel.org, AJvYcCXmcd7V1HGb
 4ilm3c+jPMnLESvzx31Qc+t2i7qGQIZvVCIQFO08Xuq37oys9gaHzOsxOmRapZaKthEUSvqSyxA=@vger.kernel.org, AJvYcCXpXqoHnScRBfMr+wv5nia70nioFqe7GEOsG1HCZM78T3UgNuyEUTFuxRbbhj7eNVXJr/QTLeV9AJWTng==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNmz9YPks/sZFgydvLcrs3S0PNWCJPJOW3w/IUcuwuP7oM2vwA
	Ur0P/q+CmUu6aQMmKkJrCz0yz2PY7Z/8uw/0ii4gLQCNv8kN6tQ0NkfXTzza5ZXvnOHzNNczBEC
	XIVc0qV9TrUwg0YYWrDUxQJxBJ+U=
X-Gm-Gg: ASbGnctnpg+2qwjmPSk8wtEvDxiXiS6zVjAIi9JskCEupmWnbNJqFoPvCX9oe2aAE7p
	xcN/lT44JW6SBwIVqHSX3CZtiQp+835Q14qsUEi9IaJsseGXfWJt2GF7WWpx5++VLjOOeUJW846
	V8CPD+c4u4rcbUf7O23aiGZTjDT9M=
X-Google-Smtp-Source: AGHT+IE1qRePjrPlGe/k7DXmrY+KtJaOvGWQ1A7tyU5eLBTz7VxuSMi4hxEC/EMElopjpnT6L0bRBsC6lDv+GByhQbc=
X-Received: by 2002:a17:90b:5608:b0:2fe:b8ba:62e1 with SMTP id
 98e67ed59e1d1-3014ea24aa4mr365923a91.28.1741886091572; Thu, 13 Mar 2025
 10:14:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313135003.836600-1-rppt@kernel.org> <20250313135003.836600-9-rppt@kernel.org>
In-Reply-To: <20250313135003.836600-9-rppt@kernel.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 13 Mar 2025 20:14:39 +0300
X-Gm-Features: AQ5f1JpOtVR6fLnH8b4t6Wo35MeP6GXSndMXHGPmpker_QqVMpVf1FbK9Hm_3_Y
Message-ID: <CAMo8Bf+_8QdcWmk-k6dpUUnvVtVsYCgcviK+fF=CsKjT3nFxHg@mail.gmail.com>
Subject: Re: [PATCH v2 08/13] xtensa: split out printing of virtual memory
 layout to a function
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Guo Ren <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, 
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Mark Brown <broonie@kernel.org>, Matt Turner <mattst88@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, 
	Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>, 
	Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 4:52=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> This will help with pulling out memblock_free_all() to the generic
> code and reducing code duplication in arch::mem_init().
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/xtensa/mm/init.c | 97 ++++++++++++++++++++++---------------------
>  1 file changed, 50 insertions(+), 47 deletions(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max

