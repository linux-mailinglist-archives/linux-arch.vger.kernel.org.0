Return-Path: <linux-arch+bounces-7953-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C51BB997EED
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 10:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7AE91C23BDF
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 08:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49B91B5EB0;
	Thu, 10 Oct 2024 07:27:48 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C9E19AD73;
	Thu, 10 Oct 2024 07:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728545268; cv=none; b=glno/+hFrhAsSDipzQOkIpWss3F9yLUrD9KhcwmXAWQnaCWFixnYXkimF7t5uLr5IOOQacFdCodq1q3XjJMwlef4zuz7S62tVrIjL7grNBO+IIfh0ZuSMKGp6R3PG4csuQ8N6AHZVC5fsNhzBqLQoiWbb2szSzOjvBLFayBik1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728545268; c=relaxed/simple;
	bh=l3tvN995WrTW85WorpTc0P1WzFKQ+3NtgLmALeDmXf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p0/syqbitwYpL3WrIRKyGeI2FnmYFxah21ZMBCC3w+N1t9rOPGFCJDd4fO07sRqDvXA156vcLOl5HlgM792jT/RsxlmXPFlwUwyqJLX2pXs6U9CyONjkdJnfta/1A1cXotjhoxFuo6JHbrwC7rFOkvCEWs0pSweWrBIyz4eyl9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e03b6d99c3so363573b6e.0;
        Thu, 10 Oct 2024 00:27:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728545265; x=1729150065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7cEkDPRbXErPkgoWEGdbZCw32b468GFBk0qa08gpGWY=;
        b=CJgCHC0Qexv5UZKHinbEnmnfRXYwjXp5rxSVbsiNnEUfIf3NOdcTV06DYs1YDf55YL
         qMeslOr7pMA9yf200+eFQplIjSAgYBa253NL1A77n1kPfMc4+w0GWd6a91dwt1KtSMD3
         58LQKqUy23UwHWCTShiILO6xQTvKdC0s2YqREPRuj47nZuw04KeAXyY7k71nrth9AuJX
         sBze91IEM5XjmKH8iR72AecVPDb1+ME2oYZePRFRFmDa5EqF5w5zhdiZYxNclNMcfnRi
         jYnrf5zKysWvLfCajVvyKrG7H4JnMXJ6n1C7d3NwPuVc9ZtdReecDQ15XawDRXnv7Gnp
         p+hw==
X-Forwarded-Encrypted: i=1; AJvYcCUug2MXpDzHQENPzfiNF/I1uIXhBDPW6NebiwxmzptY+gpM/xiRX5q9s7cJr6Kll5+96EggGaXMszVBUQ==@vger.kernel.org, AJvYcCV7LsQWSaY7utIH0AQdb/3mcPhDwHihXI0sJ5mng6Li/bT3N2yvanuxPy40iYg+bwlVFGQ=@vger.kernel.org, AJvYcCVDRJaOvryxQZIAtikiJ0E5t8FZX/zhosdozMzsZCTUybLbKAUG+5xD52cQ6agD/CycDxevMw2PCyk=@vger.kernel.org, AJvYcCVKzFsxkFJZl07rb2SX3U+WW+uK8aNg+tgWnUqd/ZFIaCpjQXIzb20kh7yRYjXdHLhAdVvzPMXi67Y/uvRDsfn/C7FV@vger.kernel.org, AJvYcCWEv3a+aBWk3uYT4UjAYWj0L800ZvoE3h2oyZtIO4Xg6O6+a984j5mAjNJnfodecfnMeyBzfqGoLkHheZIG@vger.kernel.org, AJvYcCWJKUNaJtT0I6N8auDs2jiyWKURIU7w836K8xq+8VukQPgIEisQSPxIDGoU7vPOXilloABjw0x+Ai2UmR8=@vger.kernel.org, AJvYcCWdnnVS728L+h9tNTV8pU+squ0g/FSYZtWTdxYsOyH1T/uLPGbWr6qPcFTYQ7Ow613CM6EwnBPKRstpVnA5RMI=@vger.kernel.org, AJvYcCWn2vNzod9rJ2UPZlWSAEMHD9MbuNoQcDmMOAXPBPYfrpzQfHNkcEVzve4aduXexIssw3PwbvrmC0F6SzDd@vger.kernel.org, AJvYcCWuypF92PX0zNnAiFgOsfYonoz+fto4zzbuDCw6DXp0rq/qFGCS3MkNnnGC3nH/gL+qi2+YKtUZ9NefnA==@vger.kernel.org, AJvYcCX+GfH4FFUKeWu1
 BcIhzPdX+1FrjdG0rgErztEYMvGU3gx/ZWOjhNjePqvwmymTlJg6LbzqMtvvQ5j2Hkl9qQ==@vger.kernel.org, AJvYcCX6UKG4P6RIK0OEs5tUhIoLnliOAbQ+0kZSUDdn8HkoDqGHtNBbDeORbjYSsBA1yMG9mB9AknYFy/4+jg==@vger.kernel.org, AJvYcCXox7yS65bX4/eB6/Vvy+xddjB75QkiKst+tUAPVKGKldbWhQoPx8YfvrfBmmeqwiQS84+B7aHvAcVUUwvVhQ==@vger.kernel.org, AJvYcCXoyg5HzQ0NC1hXATVyaPUz9rXLI1HFFINzbOegTWRbL8fFAzb7GHM6V97UGmt5//wZv2OI+IYzlPMmxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqwJvPTxFvInboUX3XdxRwKe2jKr3ZF26GmYwEV35dBoZpj6WJ
	CB/FGuisHxfCQfVPcFDeA5MU0zenigHB2nVNd8gmEtjEBc8qPe/EOdWBvEz5
X-Google-Smtp-Source: AGHT+IG9Coh8UjDwgsX6VZC8zxFTpOxW6eK1dKBNyh7mpGh8aiVbuqYoYnacrRQSEFLhjSnkOwaYJg==
X-Received: by 2002:a05:6808:180b:b0:3e3:a90f:3091 with SMTP id 5614622812f47-3e3e66ebff4mr5526055b6e.26.1728545265350;
        Thu, 10 Oct 2024 00:27:45 -0700 (PDT)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com. [209.85.215.181])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea44909bd7sm500604a12.50.2024.10.10.00.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 00:27:44 -0700 (PDT)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7c3e1081804so357649a12.3;
        Thu, 10 Oct 2024 00:27:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9cKaxrT3KMxHO48QaREe3rHkU5uFWc1HzTh5/s50P4Hh6yG2F+jj7iqrex1CjFkOLVYPEKzCO9zd/nA==@vger.kernel.org,
 AJvYcCUM02/WSbyK6ICj41CZUZcIiJqSitW+oCwakLbrE4uHX2tUN5DpQ9pNLG1C9ugcAXI1q8+NAzjshf3/E8mZVQk=@vger.kernel.org,
 AJvYcCUWVeWvXBjaZPXaM41+7CHirBIjO4KpHnd3kWErRt5zbVa/fStvxeslzG9wtkgrJ7mdBDM=@vger.kernel.org,
 AJvYcCUa8vcLT1MpI+v4QEv2A43SCo/8wVo60fy+9oBHndlYRvYH9KkF98gsH5rVdS/nC5k1tLqMmjKldvu74g==@vger.kernel.org,
 AJvYcCUotUWWfZCfh09XGaOf3O/M0IKZTuVIXz05kbiltdtiGPA+snkB6IZt4Blpb7Y4IXNdb+0CfDHTYgU=@vger.kernel.org,
 AJvYcCUyEf68ra5WHeQ/HIGvHpWHZVaTv/TgA/2m5MUXFz09U2XXLd1ecHZxRTfxa3WjTgEfv45NVqog5mfm79uVzw==@vger.kernel.org,
 AJvYcCV24DhrxdNOgwjEAkiFGV/+GhlPPb4CF+pgaBz3PhZt65owny6dDXbvc2rDEXchJMOEh34Hv7Vqr88/1wzvew==@vger.kernel.org,
 AJvYcCVPNPYHAPv/NCQW69xMISsKyuQ0vtA8cdWiCLTh/Xig2S5SbD9jLXREVifX2OyrnpEmoorSeYQHBElUi5Ec@vger.kernel.org,
 AJvYcCVYsbLsY2G/bUTHoJcwB+0IMiX491T8BfjQYDB3bIKOF4bpoM+YfO928Alq2ISKToQm6PHKNIGHTWs4Q1w8fFa5D+j4@vger.kernel.org,
 AJvYcCVnzASNqnPyzXNO/CZjYSSAFfCUXVDeo4f5G6nJngPeaVD85M+jwUJP9lRXBYPRBeF9nRur6CpLKx6w0A==@vger.kernel.org,
 AJvYcCVz/7quep/rr/0B80ky0XCHaCgvy2MFFBiP6fOwgIkwFmD0gT0g+VTHmrnSCPc2vYB7yxwG2Ous/zJLx5KP@vger.kernel.org,
 AJvYcCX612HB9VBSEhnPzlhdva0oJ42FYepCPbIQ2IayxReGa589aZf6xIGCqIm0/mJwIoF+dOVjnUjxr8Wr+w==@vger.kernel.org,
 AJvYcCX7G7cHrV73DdTjxGFGi3Izz7CF7+2F25lbj9HuKMnRaIbjXVtxxxK4i/g4WV9YFcnPW6pnjwTiakqosU0=@vger.kernel.org
X-Received: by 2002:a05:690c:60c2:b0:6b3:a6ff:7676 with SMTP id
 00721157ae682-6e3221867cemr55553697b3.3.1728544955686; Thu, 10 Oct 2024
 00:22:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009180816.83591-1-rppt@kernel.org> <20241009180816.83591-4-rppt@kernel.org>
In-Reply-To: <20241009180816.83591-4-rppt@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 10 Oct 2024 09:22:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV9TPH+mDJvvuRO3RBYfgWRwvv1kwyr_iLNju+iumb96Q@mail.gmail.com>
Message-ID: <CAMuHMdV9TPH+mDJvvuRO3RBYfgWRwvv1kwyr_iLNju+iumb96Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] asm-generic: introduce text-patching.h
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andreas Larsson <andreas@gaisler.com>, 
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christoph Hellwig <hch@infradead.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>, 
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Kent Overstreet <kent.overstreet@linux.dev>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>, 
	Stafford Horne <shorne@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Uladzislau Rezki <urezki@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, 
	bpf@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-modules@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-trace-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 8:09=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wrot=
e:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Several architectures support text patching, but they name the header
> files that declare patching functions differently.
>
> Make all such headers consistently named text-patching.h and add an empty
> header in asm-generic for architectures that do not support text patching=
.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

>  arch/m68k/include/asm/Kbuild                      |  1 +

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

