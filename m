Return-Path: <linux-arch+bounces-4024-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9DA8B3F97
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 20:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44B75B2325D
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 18:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2406FB9;
	Fri, 26 Apr 2024 18:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCdWi+S2"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAEF63AE;
	Fri, 26 Apr 2024 18:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714157320; cv=none; b=tI0LubcI0g/Ae1K+9ugRS3nnb4qSmoqgSJgiqrpsYhDPtxhNfJlWCQn1Kfn56AD4ZYmGvoPKZ9kFd42bRZsszuOGCwrD5qL84ftO6H5ex0WMOogeuQTzrA5wIXWblVHz1+O/B+j8m2bUH9Hvb4y3fiQP8bkbxwRK+/gG3h9XFJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714157320; c=relaxed/simple;
	bh=Hyt9cSwCpY4B/TYQfJ50zYLktchyWIPJ9BFUEyet93w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJcebsZxWVr8K7ta/VbuGHtPUXpRxGvenjB2r9w3EKHIH1GDq1r49YxDv23ty+B185fpvlm5HDJTEIXrGu52n2PRcMfrbpuJPdkWcQo2gqdgO8kR0kDOpJ3g6tw2XBy4JwCtMQu+b+6/SFrCM45ZNRif2ZpiIDDnXcvLzi1+254=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCdWi+S2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6D6C4AF10;
	Fri, 26 Apr 2024 18:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714157319;
	bh=Hyt9cSwCpY4B/TYQfJ50zYLktchyWIPJ9BFUEyet93w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UCdWi+S2pz+UNVq1UKkb2l5BfKfb5BypBiEVk51zsbIHtMvVVJ6/yA6V7Bl+PvruT
	 MUIaV5kDBsPksqcke7WXM/mD1R8LEaQgeOpZGf+GmPvEj9GU0ZnleoQHnc1z6GsIlC
	 DrULKUJwT2OWGr082giBlHvwsDI5RBS/+rBFyWr58WyGAXPy+8lOymRKtaK/5a+E08
	 jbCK/GZQRQbODrzMbFro9BCoYgolHM35YKMj4uR+mH5yUUMDG2NcPMcDOQfM3PPheh
	 /dyTAguZ624xQvQMOhxbqqo7Rvtsw2WPg1Dr0mWCymf54PDXWxPWKDqFwOHtADYzE9
	 oh6AguA0ZVPyw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51ac5923ef6so2255731e87.0;
        Fri, 26 Apr 2024 11:48:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXImITJOXRKljlXrPdcHPI48Jk9jvUyjxvIM6YCbSZ5oclDngazwhJuZYj9wH15g8G557lgBSv3YnZr2oWG3gr/KOftfdw0sh9B0ue8XaAxrR52btSX4wQZ8ktOEgDXv9DrNNIR8eK0E8dwoY77x/XwL7G+1rqVqCFR8LRhjsH1AwG0ZJ1tn9c2x7Rv91M3qyCgF+yTowEVL9HLfHhb9gIg2/T50AQ4KOy9UwRhn+rfc4QQe+anv8s50kgBiuH26iqvyA03BPoRj284c/zV4w7PT8R64ay0ssfAyVR1zN8uxy+QjRI/6zU7fooC2fXuFT75lzhApzClrsgy+n0crEjnTBKGC6Us6BIWU3iMLJYPSxTf/HleDaDCY30P8zNW9edLhnQBMkq7WM6jRNs=
X-Gm-Message-State: AOJu0Yxi2F8SPIJ9xQmKwDoJAtM0z+5BDJF4X7bb83BgRz2mbJh3FpPy
	n+Bb4Vmcf0O/L3EFi1phxLKLBNXAPvM1YaAXMvEhTIemqjGR2oJvkeRJ7erG+Cj/4pOvW3Rqma1
	bjGEBnCqt0BiSyotrUolQAzSgy2A=
X-Google-Smtp-Source: AGHT+IFMUG93L8El2Q8N1eCq6gv3PwlvgFwZKVcKUA/i/TE/TYvbrOCl1aD96inecCeUz3meYOs5/CsGWzmxgWNQdJE=
X-Received: by 2002:a05:6512:5cb:b0:51a:cc71:b91d with SMTP id
 o11-20020a05651205cb00b0051acc71b91dmr149470lfo.19.1714157316791; Fri, 26 Apr
 2024 11:48:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426082854.7355-1-rppt@kernel.org> <20240426082854.7355-6-rppt@kernel.org>
In-Reply-To: <20240426082854.7355-6-rppt@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 26 Apr 2024 11:48:25 -0700
X-Gmail-Original-Message-ID: <CAPhsuW75813E1MrdMYrqJXvuunbiJ046vT_EoReXA-60HJxT+Q@mail.gmail.com>
Message-ID: <CAPhsuW75813E1MrdMYrqJXvuunbiJ046vT_EoReXA-60HJxT+Q@mail.gmail.com>
Subject: Re: [PATCH v6 05/16] module: make module_memory_{alloc,free} more self-contained
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, 
	Donald Dutile <ddutile@redhat.com>, Eric Chanudet <echanude@redhat.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Luis Chamberlain <mcgrof@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nadav Amit <nadav.amit@gmail.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Russell King <linux@armlinux.org.uk>, 
	Sam Ravnborg <sam@ravnborg.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Will Deacon <will@kernel.org>, bpf@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-modules@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 1:30=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>
> Move the logic related to the memory allocation and freeing into
> module_memory_alloc() and module_memory_free().
>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: Song Liu <song@kernel.org>

