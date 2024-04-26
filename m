Return-Path: <linux-arch+bounces-4025-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 227BC8B3FA1
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 20:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4AF1F24678
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 18:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63D2B64A;
	Fri, 26 Apr 2024 18:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJg/iu+I"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEF0AD58;
	Fri, 26 Apr 2024 18:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714157437; cv=none; b=dE0fYPzBr1CZS1lnJka6XTJ4Pep/EtOkLC/lRkWDVIJVlO7cxkvDHm+EoiEM+Wgiu9JdWd4+cCobPV7SqX7p6MzjGLAeh9/Uk6IMfwvum/OceORC/TqhnbO0VWttp3e/BnV9jPlbN8VjIWOKliRVkWwUGVs+UvY31p2iseIfjK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714157437; c=relaxed/simple;
	bh=qzSv2gnEZ82yuyykHlGJGrukq6yL7NdagG67pBjWhfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t13AGvJ4NDcOkpRRGg+BPPdRzgj54Qrw9nvJ0D6l69oKjrkI9PypOA00d9LaLBo8mONsb0YWz+QnJ469B7z9i8H6SKzVYuk+uEnL/1hemkZevc4WjvHzXf+oow3AnHRrs675ZsBCkTibjC7W1OUKvhyxQaDGQD6B4M/DL9jvXys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJg/iu+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19893C113CD;
	Fri, 26 Apr 2024 18:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714157437;
	bh=qzSv2gnEZ82yuyykHlGJGrukq6yL7NdagG67pBjWhfw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MJg/iu+I4/bxeBy74ivwxjpibDvi17+LcvTxexZ733qg7mWsQP/TJR4hKVFLvYJGV
	 nNQ5r0UMnswsV8YccCUbyXAInJmZICJGYI5xbZk0RGClIypeXKJAM+IdtmCAxuH7QU
	 0n0+7lFLssjIzQYU6rhHTGirgxd3BlpcsYG1QNdYaQYP+jcCVKDGl9x+45jlK4Qfpv
	 4PTzjVysJABGLG2mjl0Jb0tx74YMFI6RGvm/5cgcQkai0fGR5EfLmI5+6oudIp0t7Y
	 D6A3w6VsJmjI3y6DUg0T/EcnQBedEgtsyc+lC8SIBwQHefuoaJKDYIxEIij+CkoPND
	 ck4iV3+++E/iA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516d68d7a8bso2313815e87.1;
        Fri, 26 Apr 2024 11:50:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCULS9SEt8RG5APHpkY2OvLyl3tkfKhy/LGGFV485RDAq73WobqMIAhUrpc29wmK12sGYK7iANW4HF6k1ioetiTf+FL4cHfaAEW/6pL7uU0z11UbacnjJC8LHBDY3j49WgwZKhPmQjbehG4RMVUoex3yGaicCwua7bDnCKsAklpj6F0YF1CS2Rtg5167b1B5pBoHZuEkiGbyK5TfJzGXvskeYP8ITbk6y3A61MXwx9dYW/Nj4vxKh6HaujJgT43aC2IPXDouAqLrdThpfK4jwjz6q+ixKMiyvFlAnDvzeGo0SHAWfxNc9n/syvrDhRt7zV/ZF/UO3P9EFsUKRrwmRA4heXGeo0Oolg5EaxQPIZRMYGJNAnPIbclMNECqNdpysxKx2lTyhtQBcbit4w0=
X-Gm-Message-State: AOJu0YwqfRoA/JO5x/obZyQJiKaIp+P7ENGXo5QMMbEXVN/7X1P+7qCY
	whf2DyZg2ynSQoX+r058cSc78debKkPmE8z5c0ZbyJo53qNZvuqp+tLe2mTcRYFEvuQglEygeFV
	Zp+cYxv4hQCM7hSMgsHlYTa5kDj8=
X-Google-Smtp-Source: AGHT+IEtbFUWWfDryHUamYvitrmf8tAKbyELfuzd/vDmOPU4uvcIS74lAE+iFPq4wKESZs2zgaxMHYvoVHUDPQWBV9c=
X-Received: by 2002:a05:6512:3116:b0:516:ce34:e4fc with SMTP id
 n22-20020a056512311600b00516ce34e4fcmr167995lfb.31.1714157435505; Fri, 26 Apr
 2024 11:50:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426082854.7355-1-rppt@kernel.org> <20240426082854.7355-7-rppt@kernel.org>
In-Reply-To: <20240426082854.7355-7-rppt@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 26 Apr 2024 11:50:24 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6FZqYXvk4anxby8MccwejPPK5DNU-NGmg7_6T1XDU=Hg@mail.gmail.com>
Message-ID: <CAPhsuW6FZqYXvk4anxby8MccwejPPK5DNU-NGmg7_6T1XDU=Hg@mail.gmail.com>
Subject: Re: [PATCH v6 06/16] mm: introduce execmem_alloc() and execmem_free()
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
> module_alloc() is used everywhere as a mean to allocate memory for code.
>
> Beside being semantically wrong, this unnecessarily ties all subsystems
> that need to allocate code, such as ftrace, kprobes and BPF to modules an=
d
> puts the burden of code allocation to the modules code.
>
> Several architectures override module_alloc() because of various
> constraints where the executable memory can be located and this causes
> additional obstacles for improvements of code allocation.
>
> Start splitting code allocation from modules by introducing execmem_alloc=
()
> and execmem_free() APIs.
>
> Initially, execmem_alloc() is a wrapper for module_alloc() and
> execmem_free() is a replacement of module_memfree() to allow updating all
> call sites to use the new APIs.
>
> Since architectures define different restrictions on placement,
> permissions, alignment and other parameters for memory that can be used b=
y
> different subsystems that allocate executable memory, execmem_alloc() tak=
es
> a type argument, that will be used to identify the calling subsystem and =
to
> allow architectures define parameters for ranges suitable for that
> subsystem.
>
> No functional changes.
>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Song Liu <song@kernel.org>

