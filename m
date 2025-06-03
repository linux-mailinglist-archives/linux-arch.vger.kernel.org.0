Return-Path: <linux-arch+bounces-12185-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 911B1ACBFB0
	for <lists+linux-arch@lfdr.de>; Tue,  3 Jun 2025 07:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C271D7A3DC2
	for <lists+linux-arch@lfdr.de>; Tue,  3 Jun 2025 05:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6011F3FF8;
	Tue,  3 Jun 2025 05:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0vXruVq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB951EF38E;
	Tue,  3 Jun 2025 05:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748929468; cv=none; b=kYcb1Uf/LfMx1ZEdOGou2x3YbmDMBBX1MnIcnIFYBP9/X4/XSCoEoH7+CfNY+i/KymZeGfMwMgFNq/OUkdE1gzF7XoyZQic5drYTGdP69P9WQ3wdUp1sHnMOSmkr2y+GD7teYHK7eEk6Hv20+KvVm7w/NGx4gCN8GhjHAWglDH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748929468; c=relaxed/simple;
	bh=dPPB+e2AKQjQRxjQXvvyG2LTlZlQK8dCkvNjuc80I34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcVhnOocKvdIol2Z3fUjfv+sT56L8g6+RhWQ962+sJEM7kdNlFundj0NqyCWVPc8qXnvtxBVXZBCGwBdEkAHfQJs/H0Vf+Ii8ISbsiD/A0W33ibEQUOiLcnbjkjYCFErfBgzRFcUqw30Eg6/hVpPmSyo9QCOU7Oqa9e1J0hDvm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0vXruVq; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23508d30142so54172885ad.0;
        Mon, 02 Jun 2025 22:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748929466; x=1749534266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aKpAgpUCHhlrOnuYk46IsDIW82QvDojs8/hkNeBtlKc=;
        b=E0vXruVqDK5soXNv6pczlBhcQn75raIbiZOKN3sNIca6hXVIPvwdkWbgdNsMvsGNwh
         IrD1J71yCuIS79QfpY5KpyExICYjGG7+cM3cslxmEp+H7uMIsLyhxe9q4fBzRmaL8WtA
         FL50Q6aC3s2ZAF9fOynRlfQ1SyMfymwZUE/Qp6XzOgFROZ8KDWqVpjjKY4NbSzELBDLC
         2UTnvB2nf3VZU7hTlest9/vKWFzIgV614ZDwj0qrpiTgb5hB0a0dIhn0kovtDLNrkpNu
         D1ypE1lLQCWhWjd+E3s26akRnioigwwy+tRCBnTr2y6eUoQai5uS7Zolvl4PrrZXFD/I
         +6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748929466; x=1749534266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKpAgpUCHhlrOnuYk46IsDIW82QvDojs8/hkNeBtlKc=;
        b=pR9nSLk/lWKTIen90pVTvnIbq2sCvCjAILl5XHcpQNFv8mhu95mxUZq3+gsPi9e/i3
         OpH9VMjQumzbhBAzV4RxtiA2X6ygPOzP/uR316RBfk0BRuLfJmptwYYBfYqFe0C2E6pw
         bNKpqyuPr925RzjhJLiOlz9C/dmdII0zdKwlRE/GheVw6u/g6D8S9/+rgooWHd7QK28c
         beUJcsMuWs49Zd7HLWVpP8KozEDtdZaf9K2Gy45Eg5DubC7njJJdDed0X9Hq2VRRX5te
         VlPlKDYq/dOJYxhdtfw3HlJeKZ+lYM9/JFyTNgeY7jGCVgA2Gm9Rf/7ZlPzjOCePqbaH
         LFjg==
X-Forwarded-Encrypted: i=1; AJvYcCUh1VIbyLAwrg1LQpSacmk/ShrdmMWZ3xD9/gWlu64nYvz7sosfXT0IhDduftY6lAGyS4Eq3aFcwLCgQqpB@vger.kernel.org, AJvYcCVzR5iCWNS7C2kDPuOEC2w1DXCLSWNY3QlAoW0e+tSLCmNYwLSpav3G7gy4ciET9VCEXR+9DWZrIvhw0lWs@vger.kernel.org, AJvYcCXu7OkwhCNK//Qa1lAUH9DtxZnX6oBkTjedc9ZTcpm/8tAVfIR3YgGyYz80ZhhSS/UnUKEYJCXxuGKk@vger.kernel.org
X-Gm-Message-State: AOJu0YwInFGi0aEoYVzSuo1SXB1PpRQX0casBdk22C/RfDlJ7uOODsoV
	zyhQTLrZtUtwTqX4jN/DbCjn8X4EdLVdyvoQ6mKfp7U5+TqHtynevh+x
X-Gm-Gg: ASbGncu+B553jzdGtHZjcm8vzmPrE/HH83Usulf+PhtuMlKBIm9YgzqXsjJ4pzeyACm
	S3htJ2fHQciyoB+mu7aoS8fV6krmVEgMAMgigGLli0Wt9Fr3hg2tcBBsi/Nh1ECmo8YqJkgdhkS
	dpgYYS954Gp52VwXLTka/urAN5mmCXgf7p7vxEN60JvoDV29aI/3Hf0BwtFDZX3Sp5RZNC9mDQY
	qNZHQetk8vR6OJSSwYGN/PcyF2znnsC0wN2svldMlRliaXP1PUTAT51teYc8GmMNB/I5DKrCFJ9
	ms00jiegQiCr+/TRfrvBtI/aHvf4tYDbEXpdOpuBXCqOl0xLcmI4QsKJNx3cJHOg
X-Google-Smtp-Source: AGHT+IE1VqfVkYV88+WJOAzxaRArGW9u48gtcbqgzCXLWxDE7uKmXgDwxTUrlP+CCGErpeNTzvEQxg==
X-Received: by 2002:a17:902:e94d:b0:234:eb6:a35d with SMTP id d9443c01a7336-235395a1e69mr204174135ad.27.1748929466385;
        Mon, 02 Jun 2025 22:44:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bc88a7sm80031165ad.39.2025.06.02.22.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 22:44:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 2 Jun 2025 22:44:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-arch@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic: Add sched.h inclusion in simd.h
Message-ID: <4c787fc1-637d-41dd-84eb-d11fbd71ddfb@roeck-us.net>
References: <20250530041658.909576-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530041658.909576-1-chenhuacai@loongson.cn>

On Fri, May 30, 2025 at 12:16:58PM +0800, Huacai Chen wrote:
> Commit 7ba8df47810f073 ("asm-generic: Make simd.h more resilient")
> causes a build error for PREEMPT_RT kernels:
> 
>   CC      lib/crypto/sha256.o
> In file included from ./include/asm-generic/simd.h:6,
>                  from ./arch/loongarch/include/generated/asm/simd.h:1,
>                  from ./include/crypto/internal/simd.h:9,
>                  from ./include/crypto/internal/sha2.h:6,
>                  from lib/crypto/sha256.c:15:
> ./include/asm-generic/simd.h: In function 'may_use_simd':
> ./include/linux/preempt.h:111:34: error: 'current' undeclared (first use in this function)
>   111 | # define softirq_count()        (current->softirq_disable_cnt & SOFTIRQ_MASK)
>       |                                  ^~~~~~~
> ./include/linux/preempt.h:112:82: note: in expansion of macro 'softirq_count'
>   112 | # define irq_count()            ((preempt_count() & (NMI_MASK | HARDIRQ_MASK)) | softirq_count())
>       |                                                                                  ^~~~~~~~~~~~~
> ./include/linux/preempt.h:143:34: note: in expansion of macro 'irq_count'
>   143 | #define in_interrupt()          (irq_count())
>       |                                  ^~~~~~~~~
> ./include/asm-generic/simd.h:18:17: note: in expansion of macro 'in_interrupt'
>    18 |         return !in_interrupt();
>       |                 ^~~~~~~~~~~~
> 
> So add sched.h inclusion in simd.h to fix it.
> 
> Fixes: 7ba8df47810f073 ("asm-generic: Make simd.h more resilient")
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  include/asm-generic/simd.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/asm-generic/simd.h b/include/asm-generic/simd.h
> index ac29a22eb7cf..70c8716ad32a 100644
> --- a/include/asm-generic/simd.h
> +++ b/include/asm-generic/simd.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/compiler_attributes.h>
>  #include <linux/preempt.h>
> +#include <linux/sched.h>
>  #include <linux/types.h>
>  
>  /*

