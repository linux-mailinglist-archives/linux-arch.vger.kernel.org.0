Return-Path: <linux-arch+bounces-14214-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73615BF37EA
	for <lists+linux-arch@lfdr.de>; Mon, 20 Oct 2025 22:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0DD84F0C37
	for <lists+linux-arch@lfdr.de>; Mon, 20 Oct 2025 20:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64092E11DC;
	Mon, 20 Oct 2025 20:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K829CxD5"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811411F37A1
	for <linux-arch@vger.kernel.org>; Mon, 20 Oct 2025 20:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993338; cv=none; b=BFze697eDJdjPMh1EYxNrM578gL0VP/VSS45r2t6ecQLPMjCKCQNaihwKb+wy9fDATHfhwrBfTy6XKEXddTDcLHPDGpWeqDsXrz+w0miUBM7XdlbocOE8K0Brq24PUsSorzDcWLS3hc8LTQ+ZwZKTjgY3/xiQt+RlKDD36jcicw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993338; c=relaxed/simple;
	bh=M4AhKATDdg4iYlPRuYd6QFWM30DidNdfhwLv4ITgdIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQk+bXdyA7WVJ2L3N8bY1XKd5rpn3jE/obcOwNAjLK9AuVN8yEZkVRVCfQu4bqUzi5KQHkiiWEtdJmwfPkpgzLZ8k41ZBL+YjQsVPEqNMDUEMwgeZQOG+daO0uF93c/iEsque6/HGBzuFSYH63mlFo/wzaekX1BoejSjlWxxRLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K829CxD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD25C19424
	for <linux-arch@vger.kernel.org>; Mon, 20 Oct 2025 20:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760993338;
	bh=M4AhKATDdg4iYlPRuYd6QFWM30DidNdfhwLv4ITgdIw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K829CxD5OX1nOQtT+azyZy6+Bf6FXv2m7iGJ2yoNGG+9DkQglIm5Q4A1izFGIF5Vn
	 1FsqSqZY/mwktcwB4imdUkkv87bfdDSmsbkHziNFVQ0y1sagzj1XagLjmpJ5lO84Av
	 qGRnfTsjp28NIlNiSbE2RhDmbEi0IMecWzh7mrfXy8o/kE9PCuuqGB+lUQG4ka5g14
	 kP2LtsRDNjIx7T/YwK/ke5cLWr4zK6EP6QkgKEpSjv86RhqNnuOvFkqbXd2QoFMCga
	 cuhOq4MQyep0G+qUcE9zNdmkw2cUGeuHtOkFbMipnquujs4ocII+K6j0n8EC762uN5
	 7OKEFpN8IX/Sg==
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4283be7df63so1305517f8f.1
        for <linux-arch@vger.kernel.org>; Mon, 20 Oct 2025 13:48:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWmmtnmtDsmLn1RZ/3BXsd0qbEA+VuNoR2ffnWqGM/RrxijgPciujYwKMgA9/VBaJU7mTFEhYdhst5I@vger.kernel.org
X-Gm-Message-State: AOJu0YydP8G7thVzDfqgHn5oSx8qcRkftyA8cae74QkDIr+B+UY4ab2u
	mkm5T7uNyYGJ+8KtoPRg6dDqw1Fds+PjSjLUrBFIdCNBZk5j+V/XfuMIz47liC+vZHF8T05oIFz
	3PN5yxw3v39mD9OZqmJEdf5YT8zT8XKU=
X-Google-Smtp-Source: AGHT+IG85s9AQnEsN7IduXkEM9P74jpZPvDj12tUe87rhadJgIBF0s8dfM3ZjxeutaFi0HHg6DtIskHC6u5jFK5v1HM=
X-Received: by 2002:a05:6000:26c4:b0:427:202:d4d2 with SMTP id
 ffacd0b85a97d-42704db5b02mr9514161f8f.58.1760993336717; Mon, 20 Oct 2025
 13:48:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006224208.1060990-1-mrathor@linux.microsoft.com>
 <20251017223300.GB632885@liuwe-devbox-debian-v2.local> <20251017225732.GC632885@liuwe-devbox-debian-v2.local>
 <74e019ac-afc7-3178-0f0a-dc903af5c4ca@linux.microsoft.com>
 <SN6PR02MB4157C70EBD25315F098DB3A1D4F7A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <4a4fa302-18fa-ba01-ec06-d4bf0cc84032@linux.microsoft.com>
In-Reply-To: <4a4fa302-18fa-ba01-ec06-d4bf0cc84032@linux.microsoft.com>
From: Wei Liu <wei.liu@kernel.org>
Date: Mon, 20 Oct 2025 13:48:44 -0700
X-Gmail-Original-Message-ID: <CAHd7WqzLaUXX_O6vw9YRUnPWNyTZgCANK+ZDVMYkTM4ozcZxGg@mail.gmail.com>
X-Gm-Features: AS18NWA_4_fWQVMLOfg9SHFybsBj35x7jD_NSU21S2po6A7IjEienZKubJKF8UI
Message-ID: <CAHd7WqzLaUXX_O6vw9YRUnPWNyTZgCANK+ZDVMYkTM4ozcZxGg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Hyper-V: Implement hypervisor core collection
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>, Wei Liu <wei.liu@kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "kys@microsoft.com" <kys@microsoft.com>, 
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de" <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Oct 2025 at 12:05, Mukesh R <mrathor@linux.microsoft.com> wrote:
>
> On 10/17/25 19:54, Michael Kelley wrote:
> > From: Mukesh R <mrathor@linux.microsoft.com> Sent: Friday, October 17, 2025 4:58 PM
> >>
> >> On 10/17/25 15:57, Wei Liu wrote:
> >>> On Fri, Oct 17, 2025 at 10:33:00PM +0000, Wei Liu wrote:
> >>>> On Mon, Oct 06, 2025 at 03:42:02PM -0700, Mukesh Rathor wrote:
> >>>> [...]
> >>>>> Mukesh Rathor (6):
> >>>>>   x86/hyperv: Rename guest crash shutdown function
> >>>>>   hyperv: Add two new hypercall numbers to guest ABI public header
> >>>>>   hyperv: Add definitions for hypervisor crash dump support
> >>>>>   x86/hyperv: Add trampoline asm code to transition from hypervisor
> >>>>>   x86/hyperv: Implement hypervisor RAM collection into vmcore
> >>>>>   x86/hyperv: Enable build of hypervisor crashdump collection files
> >>>>>
> >>>>
> >>>> Applied to hyperv-next. Thanks.
> >>>
> >>> This breaks i386 build.
> >>>
> >>> /work/linux-on-hyperv/linux.git/arch/x86/hyperv/hv_init.c: In function ?hyperv_init?:
> >>> /work/linux-on-hyperv/linux.git/arch/x86/hyperv/hv_init.c:557:17: error: implicit declaration of function ?hv_root_crash_init? [-Werror=implicit-function-declaration]
> >>>   557 |                 hv_root_crash_init();
> >>>       |                 ^~~~~~~~~~~~~~~~~~
> >>>
> >>> That's because CONFIG_MSHV_ROOT is only available on x86_64. And the
> >>> crash feature is guarded by CONFIG_MSHV_ROOT.
> >>>
> >>> Applying the following diff fixes the build.
> >>
> >>
> >> Thanks. A bit surprising tho that CONFIG_MSHV_ROOT doesn't have
> >> hard dependency on x86_64. It should, no?
> >
> > CONFIG_MSHV_ROOT *does* have a hard dependency on X86_64.
> >
> > But the problem is actually more pervasive than just 32-bit builds. Because
> > of the hard dependency, 32-bit builds imply CONFIG_MSHV_ROOT=n, which is
> > the real problem. In arch/x86/include/asm/mshyperv.h the declaration for
> > hv_root_crash_init() is available only when CONFIG_MSHV_ROOT is defined
> > (m or y). There's a stub hv_root_crash_init() if CONFIG_MSHV_ROOT is defined
> > and CONFIG_CRASH_DUMP=n, but not if CONFIG_MSHV_ROOT=n. The solution
> > is to add a stub when CONFIG_MSHV_ROOT=n, as below:
> >
> > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> > index 76582affefa8..a5b258d268ed 100644
> > --- a/arch/x86/include/asm/mshyperv.h
> > +++ b/arch/x86/include/asm/mshyperv.h
> > @@ -248,6 +248,8 @@ void hv_crash_asm_end(void);
> >  static inline void hv_root_crash_init(void) {}
> >  #endif  /* CONFIG_CRASH_DUMP */
> >
> > +#else   /* CONFIG_MSHV_ROOT */
> > +static inline void hv_root_crash_init(void) {}
> >  #endif  /* CONFIG_MSHV_ROOT */
> >
> >  #else /* CONFIG_HYPERV */
> >
> > Annoyingly, this solution duplicates the hv_root_crash_init() stub.  So
> > an alternate approach that changes a few more lines of code is this:
> >
> > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> > index 76582affefa8..1342d55c2545 100644
> > --- a/arch/x86/include/asm/mshyperv.h
> > +++ b/arch/x86/include/asm/mshyperv.h
> > @@ -237,18 +237,14 @@ static __always_inline u64 hv_raw_get_msr(unsigned int reg)
> >  }
> >  int hv_apicid_to_vp_index(u32 apic_id);
> >
> > -#if IS_ENABLED(CONFIG_MSHV_ROOT)
> > -
> > -#ifdef CONFIG_CRASH_DUMP
> > +#if IS_ENABLED(CONFIG_MSHV_ROOT) && IS_ENABLED(CONFIG_CRASH_DUMP)
> >  void hv_root_crash_init(void);
> >  void hv_crash_asm32(void);
> >  void hv_crash_asm64(void);
> >  void hv_crash_asm_end(void);
> > -#else   /* CONFIG_CRASH_DUMP */
> > +#else   /* CONFIG_MSHV_ROOT && CONFIG_CRASH_DUMP */
> >  static inline void hv_root_crash_init(void) {}
> > -#endif  /* CONFIG_CRASH_DUMP */
> > -
> > -#endif  /* CONFIG_MSHV_ROOT */
> > +#endif  /* CONFIG_MSHV_ROOT && CONFIG_CRASH_DUMP */
> >
> >  #else /* CONFIG_HYPERV */
> >  static inline void hyperv_init(void) {}
> >
> > Michael
>
> Thanks. Yeah, either of the above two is ok. The latter does not
> duplicate, so may be tiny bit better. Wei will pick one and apply
> directly.
>

I fixed hyperv-next using the second option.

Wei

