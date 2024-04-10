Return-Path: <linux-arch+bounces-3531-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FAA89EEE3
	for <lists+linux-arch@lfdr.de>; Wed, 10 Apr 2024 11:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186E01C208B0
	for <lists+linux-arch@lfdr.de>; Wed, 10 Apr 2024 09:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FFC155382;
	Wed, 10 Apr 2024 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhOBnFEx"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978F8155395;
	Wed, 10 Apr 2024 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712741464; cv=none; b=HzP0eCqaEzUan2lMfyAKoQcTWlCNyd7n2BpLn04HkMmOAG7DMJtNH6zrif2tDxkWQM/hYDpx/Isz/pqVmB58DYvQPNM3WYfLVLrFFSu0iCZ1lcTtjx1A6yB5xnCrm/QlmV6Xag6boSJ/IyOmc9E8dClZ/l5AARmCKr+bcmLWyYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712741464; c=relaxed/simple;
	bh=nhHI9fHSltvD1estAVRb7o/I4ULuwlJhbC+74FB2fdA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2jIrSVLaVpkk4dYJepO8kgSDhrHz+iWXju68s/doPo4S017U6Bf9nLs21n5LYjEyho5Mq+uAjOzQpWr/7BreEI7g067LhLL+005FpwwZc25C1bc1csHSzelwRKT2offtVuTYORtUH5/YrufwhhPy1xf4sz5E3ejFIXIEzjiOwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhOBnFEx; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4173f9e5df7so1824385e9.1;
        Wed, 10 Apr 2024 02:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712741461; x=1713346261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0qpI8O6kKK0PrygsY2Xv/GsxwrpqvrQMkPbdf409z4A=;
        b=GhOBnFExItZfZw6U468FIlx3uZcLdSaAa9E0osufvzfldAwdhIq65/n40ZenHElDdY
         9Yvu6uw/6apmLiHYNjV2XlFO0isvKuyflFYev1zft16pbUGelovVcwzsa15ViGhfwpAh
         PfAPWgSD+hB8XNIBaYSwA1+fMrnCm1anHgHBzj4j5Q2ttJQ75xt0mx9aFWNxCosCUiHQ
         /nbVm78UtPbqn34tbPKaU9FXp+xPM06jruJoBYdB7jMQn2kO90AqphXd09sxs7jsN+S7
         R35KqyJemtGk/eFhwd0Mn2iLtf5iAL2TMmYMu/u+4yrMCt2c4gyBJ7khMGLu50TU/zJN
         WlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712741461; x=1713346261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qpI8O6kKK0PrygsY2Xv/GsxwrpqvrQMkPbdf409z4A=;
        b=saI4H45bbR7bZ8r/J3Z0yHGgcx+hMf6NBUeZKWYTbdLVGqq91GCsuYsx9s/p3bgTff
         PyEPWD6nbysyEwdTVHfCz9/e9gmSJXvJO/8MK31ej3B8ZyU8/pKWBPZrtGHAuuqmFPLQ
         r3PelYkohawE6sooW8icGxYVOqSBkazXdOYyDpdOaOcoyHmISMTu8YBYK8n0BMYAroUM
         vWlw+rh+mrGYkVIOdE+2fH995zlll3f0nWc9nHZnvx9ghWBycIia5nuFOzkF0VTushA+
         KiU46/GgDs8eE6AVh4adGMJlr0CYCRisAlRD2bqFOJmHADYHSHyxl6yq4IP97fDjfxua
         RZJg==
X-Forwarded-Encrypted: i=1; AJvYcCU4dFeybwpO09NAsFaLAI9F7Ntefw7UVOaW8W+Y8v2Oc9H9JuA4Mdwpfj7OW0MsN8w6Xcj40HHcj7Scl9rdAVEqsLZuqxI7dbo4cNX3Ho7/pIBeCQiZXe3srAwKNVE/iEKNww+I2a0X3Ga6SPBGNTFXRVwCd2ZBdXlHww72iM1SUnp0iB+cv9uvZ8y3VF74v6C6xDfgJRw+TEOQVA==
X-Gm-Message-State: AOJu0YysA+jAUQ59MpnScML1NKu3S3C+m9wWWKe1E7xKXLK6ApZ8wTsP
	7VY1WN4ShNreOnjqXJ1jb9ku3nlKxGnyG555kNA54iZ6F/uHDlJv
X-Google-Smtp-Source: AGHT+IGB2wrhys8kVYIQpZEClhaj2Q9FjNa2ZL1sCDzhpRN0HgrQo3DfB4dqX+dhLxroV5ql0ed2YA==
X-Received: by 2002:adf:f64f:0:b0:343:97b0:fd1c with SMTP id x15-20020adff64f000000b0034397b0fd1cmr1405551wrp.13.1712741460856;
        Wed, 10 Apr 2024 02:31:00 -0700 (PDT)
Received: from krava ([2a02:168:f656:0:bbb9:17bc:93d7:223])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d5091000000b00341ba91c1f5sm13395108wrt.102.2024.04.10.02.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 02:31:00 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 10 Apr 2024 11:30:58 +0200
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Ard Biesheuvel <ardb+git@google.com>,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Martin KaFai Lau <martin.lau@linux.dev>, linux-arch@vger.kernel.org,
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v2 3/3] btf: Avoid weak external references
Message-ID: <ZhZcUkU6PoGNwTdQ@krava>
References: <20240409150132.4097042-5-ardb+git@google.com>
 <20240409150132.4097042-8-ardb+git@google.com>
 <ZhZMITbXAR63hkoD@krava>
 <CAMj1kXHuHVJn9H62GeA8kHNXm8L39BdCowebFkeCcNfYN29DjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHuHVJn9H62GeA8kHNXm8L39BdCowebFkeCcNfYN29DjA@mail.gmail.com>

On Wed, Apr 10, 2024 at 10:37:42AM +0200, Ard Biesheuvel wrote:
> On Wed, 10 Apr 2024 at 10:22, Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Tue, Apr 09, 2024 at 05:01:36PM +0200, Ard Biesheuvel wrote:
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > If the BTF code is enabled in the build configuration, the start/stop
> > > BTF markers are guaranteed to exist in the final link but not during the
> > > first linker pass.
> > >
> > > Avoid GOT based relocations to these markers in the final executable by
> > > providing preliminary definitions that will be used by the first linker
> > > pass, and superseded by the actual definitions in the subsequent ones.
> > >
> > > Make the preliminary definitions dependent on CONFIG_DEBUG_INFO_BTF so
> > > that inadvertent references to this section will trigger a link failure
> > > if they occur in code that does not honour CONFIG_DEBUG_INFO_BTF.
> > >
> > > Note that Clang will notice that taking the address of__start_BTF cannot
> > > yield NULL any longer, so testing for that condition is no longer
> > > needed.
> > >
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  include/asm-generic/vmlinux.lds.h | 9 +++++++++
> > >  kernel/bpf/btf.c                  | 4 ++--
> > >  kernel/bpf/sysfs_btf.c            | 6 +++---
> > >  3 files changed, 14 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > > index e8449be62058..4cb3d88449e5 100644
> > > --- a/include/asm-generic/vmlinux.lds.h
> > > +++ b/include/asm-generic/vmlinux.lds.h
> > > @@ -456,6 +456,7 @@
> > >   * independent code.
> > >   */
> > >  #define PRELIMINARY_SYMBOL_DEFINITIONS                                       \
> > > +     PRELIMINARY_BTF_DEFINITIONS                                     \
> > >       PROVIDE(kallsyms_addresses = .);                                \
> > >       PROVIDE(kallsyms_offsets = .);                                  \
> > >       PROVIDE(kallsyms_names = .);                                    \
> > > @@ -466,6 +467,14 @@
> > >       PROVIDE(kallsyms_markers = .);                                  \
> > >       PROVIDE(kallsyms_seqs_of_names = .);
> > >
> > > +#ifdef CONFIG_DEBUG_INFO_BTF
> > > +#define PRELIMINARY_BTF_DEFINITIONS                                  \
> > > +     PROVIDE(__start_BTF = .);                                       \
> > > +     PROVIDE(__stop_BTF = .);
> > > +#else
> > > +#define PRELIMINARY_BTF_DEFINITIONS
> > > +#endif
> >
> > hi,
> > I'm getting following compilation fail when CONFIG_DEBUG_INFO_BTF is disabled
> >
> >         [jolsa@krava linux-qemu]$ make
> >           CALL    scripts/checksyscalls.sh
> >           DESCEND objtool
> >           INSTALL libsubcmd_headers
> >           UPD     include/generated/utsversion.h
> >           CC      init/version-timestamp.o
> >           LD      .tmp_vmlinux.kallsyms1
> >         ld: kernel/bpf/btf.o: in function `btf_parse_vmlinux':
> >         /home/jolsa/kernel/linux-qemu/kernel/bpf/btf.c:5988: undefined reference to `__start_BTF'
> >         ld: /home/jolsa/kernel/linux-qemu/kernel/bpf/btf.c:5989: undefined reference to `__stop_BTF'
> >         ld: /home/jolsa/kernel/linux-qemu/kernel/bpf/btf.c:5989: undefined reference to `__start_BTF'
> >         make[2]: *** [scripts/Makefile.vmlinux:37: vmlinux] Error 1
> >         make[1]: *** [/home/jolsa/kernel/linux-qemu/Makefile:1160: vmlinux] Error 2
> >         make: *** [Makefile:240: __sub-make] Error 2
> >
> > maybe the assumption was that kernel/bpf/btf.o is compiled only
> > for CONFIG_DEBUG_INFO_BTF, but it's actually:
> >
> >   obj-$(CONFIG_BPF_SYSCALL) += btf.o memalloc.o
> >
> 
> Interesting. I did build test this with and without
> CONFIG_DEBUG_INFO_BTF, but not with CONFIG_BPF_SYSCALL=y and
> CONFIG_DEBUG_INFO_BTF=n.
> 
> > I guess we just need !CONFIG_DEBUG_INFO_BTF version of btf_parse_vmlinux
> > function
> >
> 
> The below gives me a working build.
> 
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -5971,6 +5971,9 @@ struct btf *btf_parse_vmlinux(void)
>         struct btf *btf = NULL;
>         int err;
> 
> +       if (!IS_ENABLED(CONFIG_DEBUG_INFO_BTF))
> +               return ERR_PTR(-ENOENT);

nice, so this basically eliminates the rest of the function,
I did not know this would work

build's fine now, thanks

jirka

> +
>         env = kzalloc(sizeof(*env), GFP_KERNEL | __GFP_NOWARN);
>         if (!env)
>                 return ERR_PTR(-ENOMEM);

