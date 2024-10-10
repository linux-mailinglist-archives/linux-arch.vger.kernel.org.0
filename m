Return-Path: <linux-arch+bounces-7988-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9657998E37
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 19:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D541C246BD
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 17:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D3219C576;
	Thu, 10 Oct 2024 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGQC3YGT"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFAC19AA6B;
	Thu, 10 Oct 2024 17:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728580712; cv=none; b=Kl2XB1eeRlt7qxPKIwMIMP7olnumK8gsjJMdy2L3KMxHkQaNbIfABk/e85bza+2ZV9kujedqmxgAsZ/7UHvHteAozt+gNCAh2sb1p5lkceC65fn97tZU/tZhUEfepe8lQT7Be24UTyQY55lDz+RPjCL2k3j29J71oGya5mYSaP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728580712; c=relaxed/simple;
	bh=vaucBuX2fMrEpT3kygwI4CcFnWG5blOdj+4yYIH1/lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VdyUqTy6CptoVSqVgvzdYJMqPU6hJwsDnJ2c5zqIj6cq6ZJnMSFz+hXc2D2YP6Tse4+y88y9zq6qQC1ceGSi9VIEQs4p9Plc0JwM+xWYtQbrO0SE/qLvB32fevMLBuTF7BrXn0G85g2OsFxS51nidUHgDFJa6qrYyTpEbUHrqSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGQC3YGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E86C4CED1;
	Thu, 10 Oct 2024 17:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728580711;
	bh=vaucBuX2fMrEpT3kygwI4CcFnWG5blOdj+4yYIH1/lc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YGQC3YGTpIM/Tv02Vn7usGJD/6tt+x+KTKu3UxnMO5NCC8+C7ZPh5ezrehFriglwe
	 0kHT558np8Wr8rw+tHrk6iFdI6TYZzj/XuDQyl1ohCHGBlLvqRKvMY9o2gFo+NuycW
	 y20uvBOD9Gdu+xnvXvzrx2PBIPwMfqD7Kk74Y5ZM4wURiZxI3kabAPnyXgltKV5Te8
	 nLgYuMl0XB6UP3CI6ocVV8lyp79EB210TDlqZm0fWRLk96yJAx28fczirFRv8Ok4xn
	 g28YaYfndtMh2lJkpow1r3uH0m1V9UcGEfvj2KBq6mV0UhVTJerIhIuFum/RTZvtMI
	 Z12HDd0NC/l1Q==
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-8354851fcabso48911939f.2;
        Thu, 10 Oct 2024 10:18:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNwS4nU0i1pFTedEe9QquUZznRCoLc+3xUgysql3JpZQ1HE+HaPatufKWc8qr0x/Ye2SQsxkziAepgcw==@vger.kernel.org, AJvYcCURTNsCKHxmNg85Q0OquBOAAn4jXzp/HSvwityJzy1FP4UBfrQS5ey7549dEMoRJBoqS9u+h2FK5J1O1Q==@vger.kernel.org, AJvYcCUnXjAFL7Vh4gBrRhVyEqBEd8t7lq75QzDLkU1jQpu2pPeqMTjdN0rG+XEjvXFfcEgIwZrUtX9iKlnYuZl1Iw==@vger.kernel.org, AJvYcCUpsoApLKAYKbB/pB5ltcSLmuksx4pmT57XP4Qx563kh6rXnFT7j/pvr+QRHXsv5PpsC1hMx2rrNHaaQA==@vger.kernel.org, AJvYcCUujDcBpwF8M6Qg6H2w77GxDLXtQ6Xokb0ZnQ0XkGg8nSLYIfwOopK4UFUL7XDf1Xq/gGar3qy1fSoKKIyQsQ==@vger.kernel.org, AJvYcCVceqbqnoD8upMwp/2rMzTQA+NnTmzxnZYka3o5PMZK0SOnabs3WzoIzYtuNHcGv17yAVbwdSAnLAP741oYp1068Njm@vger.kernel.org, AJvYcCVtUOzBZjY/yodlV6U3dIaM80pFkBdfOsoKfaz6TGmw57MrAN7kZC7WJeTmxobtSTkk1AoqdjwrNfc=@vger.kernel.org, AJvYcCVtYIpyyF4KPkwJbK0dSAr8z/fZQfE/nEvPhH1FlGGEIhNujLo9NzrcQWT8hZZGg1MM832Sv4mM5/YgOw==@vger.kernel.org, AJvYcCWMFvZbSRThFQeP2ZvabB4MrRYbmwFHdF4xKCT4Sau2vCUtG5OivWCBhzdTpUxAl7M41KjCuFW7bGqFhAY=@vger.kernel.org, AJvY
 cCWcPvgouWs6OFoewglssFG7UHTBjYz/7OKk2nN1Ovn1QIhK2B3HNcbOeqHTS/9TFy8wFXTOAnuPwbM7AxRY@vger.kernel.org, AJvYcCWgcrmvKS+saR8ChWJ38tf6CjCHieZyZn8se624ihvJDrH/8Hd8woMODD9mOtz/sMEzCi0=@vger.kernel.org, AJvYcCWsKsLVzkoC7SAiMH7xEL4hMOOAvV863DEiMnc42F7DPzDatuylHqJQNdtM5UIa2cyFJv+gpo5iu2pckVXg@vger.kernel.org, AJvYcCXfHFj95a4sWp51N7WEhfSNNqDmCkH5z7GRG7BzYeyhUFXbus+OhaAaGyRp8Kf0QQULH+MkcC0Xpe/rI66Tg44=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQR8Mgvc/yWBlexpByTgWAPe9ne4Og5hO9d59xlmOJSOhlNgN2
	cf5Fd0Crb6QwfYEcRnE0TZbARHYJQ6Xgji+ynd/D7NOUT8aORLlv06NQJVa7qMltWwCZRZY6TRu
	QtAxxGqpEubkGQgWES9J+UiGKsgE=
X-Google-Smtp-Source: AGHT+IGszKBBrf1gYsUhslMqcPNpC/f6sAFFbsmL+u+zGmeEd2sYZs3+7Tvb9T+CKCsx/nhk3yidKvoEgysxI18Lmn4=
X-Received: by 2002:a05:6e02:144d:b0:3a0:92e5:af68 with SMTP id
 e9e14a558f8ab-3a3b51daa94mr2839515ab.15.1728580710921; Thu, 10 Oct 2024
 10:18:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009180816.83591-1-rppt@kernel.org> <20241009180816.83591-5-rppt@kernel.org>
 <CAPhsuW66etfdU3Fvk0KsELXcgWD6_TkBFjJ-BTHQu5OejDsP2w@mail.gmail.com> <ZwdpnPKKQGF5DtSv@kernel.org>
In-Reply-To: <ZwdpnPKKQGF5DtSv@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 10 Oct 2024 10:18:19 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6gb76T_75TPzb-AvfyAcYE83iYhDpjJNHJQWDd3Fki_Q@mail.gmail.com>
Message-ID: <CAPhsuW6gb76T_75TPzb-AvfyAcYE83iYhDpjJNHJQWDd3Fki_Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] module: prepare to handle ROX allocations for text
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andreas Larsson <andreas@gaisler.com>, 
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christoph Hellwig <hch@infradead.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, 
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Kent Overstreet <kent.overstreet@linux.dev>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, 
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

On Wed, Oct 9, 2024 at 10:47=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Wed, Oct 09, 2024 at 03:23:40PM -0700, Song Liu wrote:
> > On Wed, Oct 9, 2024 at 11:10=E2=80=AFAM Mike Rapoport <rppt@kernel.org>=
 wrote:
> > [...]
> > > diff --git a/include/linux/module.h b/include/linux/module.h
> > > index 88ecc5e9f523..7039f609c6ef 100644
> > > --- a/include/linux/module.h
> > > +++ b/include/linux/module.h
> > > @@ -367,6 +367,8 @@ enum mod_mem_type {
> > >
> > >  struct module_memory {
> > >         void *base;
> > > +       void *rw_copy;
> > > +       bool is_rox;
> > >         unsigned int size;
> >
> > Do we really need to hold the rw_copy all the time?
>
> We hold it only during module initialization, it's freed in
> post_relocation.

Ah, I missed this part. Sorry for the noise.

Song

