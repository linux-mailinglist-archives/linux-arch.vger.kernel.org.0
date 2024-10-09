Return-Path: <linux-arch+bounces-7940-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F3B99786C
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 00:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0B01C226E8
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 22:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB861E32C5;
	Wed,  9 Oct 2024 22:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wiwa3rlr"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A7816BE3A;
	Wed,  9 Oct 2024 22:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728512633; cv=none; b=ZFo8BFFJTy6kc/8ZL25UxCnTBthkV7yoiGVu6a9s6EBCleeckbd4w9UGshJWOPY9C1oXc1rSEFNiclMpNrXhBbV2irQH+mYaiQIPvrOKDPQVuL0RNPMV1c7xe86nwfpPgXHDcu7/uliYIZKF3arUQln6RyucfWHpiMlghB+yP3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728512633; c=relaxed/simple;
	bh=w4l9dzDzlilO4E+6HL//zAT4zhaj8ld4amfc5zECEfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BgZFNti6Cp5Zfvo74gnk4Y8sLJAE2yWeVysachcCehMVU98fZPCD6GG8MhgZ7YuMkXblZpnp/uSOOh6Fmb/P8mNrKQwAZMewbybzD/XACx8v86FzAZG7HvMag8xUwjXsZowwlyicC2jB2InIeWDF+mHEezf9NUBZfSYXQMXOLpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wiwa3rlr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8D7C4CECC;
	Wed,  9 Oct 2024 22:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728512632;
	bh=w4l9dzDzlilO4E+6HL//zAT4zhaj8ld4amfc5zECEfQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Wiwa3rlrYH9BC46EoCHkt+QLbJoTT1X2QA01HAqIYKjAte3oUq44GaeL+zZ4AkJ2c
	 2fmhTarWCgJZzvugjgiXFaapdrUxRw+aMHjQkxk7R7tMQ4X8TAISQfJF8mwZjkVS1k
	 P8ckfmO9JeSeyS8x4lu0kJaTjkOtHpLIIPYKJmo4HQ1/9VWZa6uO3ff20ntiwcvv+8
	 WNsOi1fvz3WyQp8/mTsIKp1bTZX1Q46ddgghD/obeQF4nyOrExSGPC7njchLh/Wo1L
	 w8uAfe7NKlqBlMlX1oAMsBsi5zUdQStu0GaxZpBZ0z6hB0R3qZA3l0SEImsa2B3CEC
	 jNcMMmsZn1/Ag==
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a394418442so1476475ab.0;
        Wed, 09 Oct 2024 15:23:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU61D2CRcLaVMIBuI6bY2KR8gDO+54vJTIDrd9dXpGnlhfz9PSeIgFxDEo0aa683hEME9WacFNEcK75/Q==@vger.kernel.org, AJvYcCU6d3T+xfYZy2ZFXy9VmY0Bz4A9MHDIH3H1Dt3ynUChED1Q2uAlSOfIdOM6LQQ9gJ3QHvtJ58hVz3HIyt6ZAg==@vger.kernel.org, AJvYcCUAd9vKSVac0AFdqFCSYRMUhYB+UQLfnbKVNt9XTL7TY1kal0FuLABW1DsLU43cPhtJW/5DDpstPUugb0hi@vger.kernel.org, AJvYcCUYrvTnCSh4MK873qv36UUCOhdtHj19TbOGgvM8d0S8sWOsfqIyiJ6jPS0CEqCe9YN2eoeS1IyefRRd1mNpLA==@vger.kernel.org, AJvYcCVI5+g2UIN13rDvUyTWLgNl03epMtsNWRHbF8T6c3XzRTEe5Te85331sYOS5vLSJ23RA4w=@vger.kernel.org, AJvYcCW5r0tPZikGROllmLilDHOQcXRNzPcUchdGX0JolS0jcZy30DBVKz4HMtBSYTVRlFHWXAQCfX1lLLx0fw==@vger.kernel.org, AJvYcCWIF2EZtnabVrRizeMQ/Tep9LTVr87ZDxZx83HJvZQQQ86NsOwKQHEzOKDN0Xqawqdss2IsMK+oO/OFnG3apSU=@vger.kernel.org, AJvYcCWW7Pza1E4TOk00NSKM83YK/yh7inog4RCog7HafeZksnpyNXVeFZSoFS5NHHbNTJ47fNcRqy0QITM+Vw==@vger.kernel.org, AJvYcCXCTVRsAhw+rPuKzky04p2bXjw8VQZ82+vrCqfA4Yx0DnKKYncBjkvhgSv79h37ER6NxmrHjY27AuB+/w==@vger.kernel.org, AJvYcCXZRssXwAo/
 AoVv+xF31T8SbmiHry76PkvJONpDdg1KO/SSvumEAS5ouqmtI6xptdmebRNO62viHxFfT5k=@vger.kernel.org, AJvYcCXbg/L4OaMANur3cTXZeXkAmiqmyFSK97rxe7C5AHGfqMAi/4MIVi9X8X3oe03WPJ1PJjJxhdVnmVODVzTSzoA8gESi@vger.kernel.org, AJvYcCXpMyniBp7nUwtryj0Diu50gmpx6gzO6of+c7dZofHAtVJRf6vBep9vIVdkig4y3/RA7XDZODFZ33O86nEc@vger.kernel.org, AJvYcCXvXb0vrL9zsDB5gWaymu5B7GP/LIsC0kSisKZlo3yGno3edCKU/B6Jm+pbe0yvNRKmGUHLzNlxAFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXv35Vz6MPYXtnQB6bXHLaTDBgUIz1+Bcw9ur/SOVy01qpX3mK
	8AU3HMd55oMTZ91TqFK75LVJk+fRg3aWoLiA1riG08HddGm4Y6BbnmK+3053It5O/qJYBG15IR0
	V5jvbKTFl4U5B0UDDgnKBlf2+VeQ=
X-Google-Smtp-Source: AGHT+IE+0c/kMVosLTSGHy+n6QvIYJcOAn6W5BXDQkMmjF/nhxZwOJHSZ6SOjh26Vu9mUcUiW0DFRwoy/+Y0vdg6KQk=
X-Received: by 2002:a05:6e02:1fe6:b0:3a0:aac2:a0a4 with SMTP id
 e9e14a558f8ab-3a397cffa21mr40549325ab.9.1728512631542; Wed, 09 Oct 2024
 15:23:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009180816.83591-1-rppt@kernel.org> <20241009180816.83591-5-rppt@kernel.org>
In-Reply-To: <20241009180816.83591-5-rppt@kernel.org>
From: Song Liu <song@kernel.org>
Date: Wed, 9 Oct 2024 15:23:40 -0700
X-Gmail-Original-Message-ID: <CAPhsuW66etfdU3Fvk0KsELXcgWD6_TkBFjJ-BTHQu5OejDsP2w@mail.gmail.com>
Message-ID: <CAPhsuW66etfdU3Fvk0KsELXcgWD6_TkBFjJ-BTHQu5OejDsP2w@mail.gmail.com>
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

On Wed, Oct 9, 2024 at 11:10=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
[...]
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 88ecc5e9f523..7039f609c6ef 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -367,6 +367,8 @@ enum mod_mem_type {
>
>  struct module_memory {
>         void *base;
> +       void *rw_copy;
> +       bool is_rox;
>         unsigned int size;

Do we really need to hold the rw_copy all the time? I was
thinking we only need a temporary buffer when we want to
update anything. The buffer might be much smaller than "size".

Thanks,
Song

[...]

