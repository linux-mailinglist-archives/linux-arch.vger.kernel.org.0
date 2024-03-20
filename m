Return-Path: <linux-arch+bounces-3050-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C988812A9
	for <lists+linux-arch@lfdr.de>; Wed, 20 Mar 2024 14:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07571F24541
	for <lists+linux-arch@lfdr.de>; Wed, 20 Mar 2024 13:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94FC41E22;
	Wed, 20 Mar 2024 13:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AA8xkoGy"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA1645974;
	Wed, 20 Mar 2024 13:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710942581; cv=none; b=HKiLDtDBJsshcwfM+yI0AVpDs2OpkXNfP52H4+X8uLDXSbXvmU1XNSMCeCKXcYXFLceSHdp96I9p3rONW+JJQl0oJ/rYW8YDs7P3aasJDFo/uLBAZhtz6I0NmU5HJF3Qd84y+vU3VJmsy8ikDwasd5QsbubyoKwt1ZWg6wwJIKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710942581; c=relaxed/simple;
	bh=EAbJvDEPuUAEHqsHcIRB3brQrJYzFil/dHVXDW9zweU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sc5P2eoe+spqfhiMoKgKMEW5i+JC/xVEt1ifSU5uLtGT8KyWTWrJMIfKhvQ0nUlFPBDenZMojDLVrXSZOTQiRSpXTFmJTfJvkaaBZGHh5w0X+Re6YhBvd/+VlOujbwjADBLwYr5Z7jCclizmIyLddpb0T/mpri42dqfuWqOQgeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AA8xkoGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0C2C43330;
	Wed, 20 Mar 2024 13:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710942581;
	bh=EAbJvDEPuUAEHqsHcIRB3brQrJYzFil/dHVXDW9zweU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AA8xkoGyJTDUSmLTVP3F3lutWqk879LSCt3IDdjao/9DHtBwzFCbmcgycwK9ECMBs
	 5hUQ90mYCPnEQqHiJvSwm08EE1h3ZvW0QzhsD5g3jRoNpY5cVeh3TbSM9hhUW2XPwp
	 mUiQID8k/GrCYhSxLa1A1ChsHXo67+IH7AgkZDmRbYAl/BPIPhUaydmBoBlzrbttPX
	 Z1cviJzRTc07w3MAIamWlCEpBFznuCV5SmvsKoiQmpZ/hYpKHzaJHqxwyTs7M360Jf
	 L6BM0ekPACyf1RcWfaLSyFs7N6f4ptbTc1eDrSdOPdfuD5PsLzeCyZwQHYq0C4o5AM
	 1lGTvdPT9SsyQ==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a4644bde1d4so885777366b.3;
        Wed, 20 Mar 2024 06:49:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxw2sTxIBQhdvbAz1z+idq/GilEPCG9Pj0cv2NG2kZp852gyRxPZwU4h1KGJmOd3ptI76x0LHcOedNsdZDkE8UuIVK1D3qc3tjkzZ9dZiZovEZxFq8hDRfYa74lUHrYoyKR8MYRXM/Gs6oR0a7Lb1h05mv3SX1cqrmOUSbOEWNbQ==
X-Gm-Message-State: AOJu0YzL7nN0AzdipP8YiLuIhWg4Ss/9cYbD5HgbleKNeGjByCeMALGd
	PK2zej89txIgIRXcOpNnrgHnoNA1/ESyBvSuaUzgfvTntlTGjeZ4kty231Z+h4gCN23tOsD/SDS
	AjeV7hQ7poYpI7SXkP6TrS7Mkzj0=
X-Google-Smtp-Source: AGHT+IG6MEm+BI8Pn1pGEfr7VXutNJ95vBdKRwS15/HX3UTZBvRAgB1kEBIUPyvnMpx6ZshWbj6yijLu46BWmCWVtow=
X-Received: by 2002:a17:906:af07:b0:a46:1fba:2c6d with SMTP id
 lx7-20020a170906af0700b00a461fba2c6dmr1416970ejb.20.1710942579777; Wed, 20
 Mar 2024 06:49:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315024526.394772-1-chenhuacai@loongson.cn> <e8c4062df63f3e8bc8bb2d7209fa2a2a44bd7ed3.camel@xry111.site>
In-Reply-To: <e8c4062df63f3e8bc8bb2d7209fa2a2a44bd7ed3.camel@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 20 Mar 2024 21:49:28 +0800
X-Gmail-Original-Message-ID: <CAAhV-H59EzR7gN0UiJP5x2wbs2_TZCej-NE==OZxVcP0cvt7hg@mail.gmail.com>
Message-ID: <CAAhV-H59EzR7gN0UiJP5x2wbs2_TZCej-NE==OZxVcP0cvt7hg@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Change __my_cpu_offset definition to avoid mis-optimization
To: Xi Ruoyao <xry111@xry111.site>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev, 
	linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, 
	Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org, 
	loongson-kernel@lists.loongnix.cn, stable@vger.kernel.org, 
	Xiaotian Wu <wuxiaotian@loongson.cn>, Miao Wang <shankerwangmiao@gmail.com>, 
	Xing Li <lixing@loongson.cn>, Hongchen Zhang <zhanghongchen@loongson.cn>, 
	Rui Wang <wangrui@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Ruoyao,

On Wed, Mar 20, 2024 at 6:27=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> On Fri, 2024-03-15 at 10:45 +0800, Huacai Chen wrote:
> > From GCC commit 3f13154553f8546a ("df-scan: remove ad-hoc handling of
> > global regs in asms"), global registers will no longer be forced to add
> > to the def-use chain. Then current_thread_info(), current_stack_pointer
> > and __my_cpu_offset may be lifted out of the loop because they are no
> > longer treated as "volatile variables".
>
> Ooops...  I'm wondering why this issue has not blown up our systems
> before.  The referred GCC commit is far before LoongArch CPUs are taped.
>
> > This optimization is still correct for the current_thread_info() and
> > current_stack_pointer usages because they are associated to a thread.
> > However it is wrong for __my_cpu_offset because it is associated to a
> > CPU rather than a thread: if the thread migrates to a different CPU in
> > the loop, __my_cpu_offset should be changed.
> >
> > Change __my_cpu_offset definition to treat it as a "volatile variable",
> > in order to avoid such a mis-optimization.
> >
> > Cc: stable@vger.kernel.org
>
> I suppose we should add Fixes: 5b0b14e550a0 ("LoongArch: Add
> atomic/locking header") here.
You are right, but since this patch is in loongarch-next for the pull
request, I don't want to change things.

Huacai

>
> > Reported-by: Xiaotian Wu <wuxiaotian@loongson.cn>
> > Reported-by: Miao Wang <shankerwangmiao@gmail.com>
> > Signed-off-by: Xing Li <lixing@loongson.cn>
> > Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> > Signed-off-by: Rui Wang <wangrui@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  arch/loongarch/include/asm/percpu.h | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/loongarch/include/asm/percpu.h b/arch/loongarch/inclu=
de/asm/percpu.h
> > index 9b36ac003f89..03b98491d301 100644
> > --- a/arch/loongarch/include/asm/percpu.h
> > +++ b/arch/loongarch/include/asm/percpu.h
> > @@ -29,7 +29,12 @@ static inline void set_my_cpu_offset(unsigned long o=
ff)
> >       __my_cpu_offset =3D off;
> >       csr_write64(off, PERCPU_BASE_KS);
> >  }
> > -#define __my_cpu_offset __my_cpu_offset
> > +
> > +#define __my_cpu_offset                                      \
> > +({                                                   \
> > +     __asm__ __volatile__("":"+r"(__my_cpu_offset)); \
> > +     __my_cpu_offset;                                \
> > +})
> >
> >  #define PERCPU_OP(op, asm_op, c_op)                                  \
> >  static __always_inline unsigned long __percpu_##op(void *ptr,         =
       \
>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University

