Return-Path: <linux-arch+bounces-2172-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6375B850BCA
	for <lists+linux-arch@lfdr.de>; Sun, 11 Feb 2024 23:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED9F1F2208B
	for <lists+linux-arch@lfdr.de>; Sun, 11 Feb 2024 22:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7B516410;
	Sun, 11 Feb 2024 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIFMKM/c"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ED71426A;
	Sun, 11 Feb 2024 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707691025; cv=none; b=iyq9b5JgEHQ8evO4YjzIbWG4+U51h7Nnz+/np+Cqwz5zvJ0CaP+ICMwOAeymjFYSGlIRnykscyBnwrybRPilY+ohT3ae+qPIUShwoQxI0bI30wkWy3jxSNKpd3fhcYRu4ysN2G4c6WUjpEheDqCkRKoTchcRjlrTkIyUQR7NLP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707691025; c=relaxed/simple;
	bh=v4G6ehhPG/T4ElMEaTqhlNoQjbCZltvlaQ9iSgQ/jqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CjWu3huFL3kI3GqJrKWyf7q2ID5d19xJ0lrgUmdcnjFrZ9xxOP7IHsWuXd29YAXjZ6Woga4rtbWdrCHyunEWY7gEr4w2f7sG65OM8JPdG5i4Egp3AENc7l+zzc26wjqT+Jkmn8xwzQ+wCR1y8dqlj6WwBC7Akc2r1LtnpRVigQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIFMKM/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3D6C43390;
	Sun, 11 Feb 2024 22:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707691025;
	bh=v4G6ehhPG/T4ElMEaTqhlNoQjbCZltvlaQ9iSgQ/jqs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TIFMKM/caEh5dJ+bulkCR0q0gdp8pENZGkgU9CkmDCd5Oq1bSaUzntyguvgsJOvv4
	 gjTjnGKCNzWlTToma07fms9Vcw2c+AZ0gxd1qaIR1L+7WNH8f+CnvuF/kDaPJJMAgG
	 OeXcjmQI/c3V4bHwvSaaqgOu2o7bzLd42KFmhOPW3zZSd25LDzQ1deBLdDJyQTCzkK
	 ikJMXpN0zJjpVanMBA070l+UVbhVC9+PLB5jUZdeLdtYULy1GMvyS17nC0QHaYBTIc
	 wJ2pxMbg199kFs/b3OTVOd+tYLkfoSzSiUWVWn3jKHzcu/N7DK8DUYZWSXVavA0Mo/
	 /2qdpBvaOXosg==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d0dc3fdd1bso26130321fa.0;
        Sun, 11 Feb 2024 14:37:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQ/g7EfLcg1gzoWUj9jQYcaXoZ2VERuquZ5TNFhkfE1K6LS1xULNTKgO/R3EPf8zM4mOFDPGye7x//F+qyXxobDwsVfXxPJL+/suJ44zlRDHftPQiflJ1gFvTZIyQnZPrfg7jWpgOJTA==
X-Gm-Message-State: AOJu0YwZEsIYefjsmgn+EReJXTSbAd8m3aC83NO/nsK/dYlUH4KnLoa/
	p+/5oHjTcRbuzvCLnXfgu6/ASh5jGzOf9rRi8l0vl9q/R8874FXQ58hG2br0nyI+NLBaRKjoQJv
	4C+zFU4FfdT2rci3v4sWpYl/WWBg=
X-Google-Smtp-Source: AGHT+IFl4zc+Ad1i+CBjqwi2XTTno9sUz3Cm/iJnlLj5Ldx7zEG3AwZJXSsOHOLHudvXqss07zu7p/FqLBwWJmYbkNc=
X-Received: by 2002:ac2:4579:0:b0:511:87b7:6d88 with SMTP id
 k25-20020ac24579000000b0051187b76d88mr1609035lfm.32.1707691023239; Sun, 11
 Feb 2024 14:37:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
 <20240129180502.4069817-27-ardb+git@google.com> <20240207132922.GSZcOFspSGaVluJo92@fat_crate.local>
 <CAMj1kXF+mHCYs08q58QFGuzZ4nzGd2sDr1gp2ydkOHHQ2LK5tQ@mail.gmail.com> <20240210104039.GAZcdSp7dRbgqBy3fg@fat_crate.local>
In-Reply-To: <20240210104039.GAZcdSp7dRbgqBy3fg@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 11 Feb 2024 23:36:51 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG5+KEAE5F0EFkZCkt1244M3UBJXH_O3ULg0oRHV2YnmQ@mail.gmail.com>
Message-ID: <CAMj1kXG5+KEAE5F0EFkZCkt1244M3UBJXH_O3ULg0oRHV2YnmQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/19] x86/startup_64: Drop global variables keeping
 track of LA57 state
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Glaze <dionnaglaze@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sat, 10 Feb 2024 at 11:41, Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Feb 09, 2024 at 01:55:02PM +0000, Ard Biesheuvel wrote:
> > I was trying to get rid of global variable assignments and accesses
> > from the 1:1 mapping, but since we cannot get rid of those entirely,
> > we might just keep __pgtable_l5_enabled but use RIP_REL_REF() in the
> > accessors, and move the assignment to the asm startup code.
>
> Yeah.
>
> >    asm(ALTERNATIVE_TERNARY(
> >        "movq %%cr4, %[reg] \n\t btl %[la57], %k[reg]" CC_SET(c),
> >        %P[feat], "stc", "clc")
> >        : [reg] "=r" (r), CC_OUT(c) (ret)
> >        : [feat] "i" (X86_FEATURE_LA57),
> >          [la57] "i" (X86_CR4_LA57_BIT)
> >        : "cc");
>
> Creative :)
>
> > but we'd still have two versions in that case.
>
> Yap. RIP_REL_REF() ain't too bad ...
>

We can actually rip all of that stuff out, and have only a single
implementation of pgtable_l5_enabled() that is not based on a variable
at all. It results in a nice cleanup, but I'll keep it as a separate
patch in the next revision so we can easily drop it if preferred.

