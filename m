Return-Path: <linux-arch+bounces-746-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE09808B2C
	for <lists+linux-arch@lfdr.de>; Thu,  7 Dec 2023 15:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75D71C20B39
	for <lists+linux-arch@lfdr.de>; Thu,  7 Dec 2023 14:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E0A44378;
	Thu,  7 Dec 2023 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXN7/jhR"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD0DAC;
	Thu,  7 Dec 2023 06:57:09 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a1d450d5c11so123961566b.3;
        Thu, 07 Dec 2023 06:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701961028; x=1702565828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjO+EmVAcgMYQOFWsnqPhTs0jze6OHRX9SLzDiaddCI=;
        b=ZXN7/jhR2U35RWuQgH5jjl7tVQoKSVyAb1cTBbXVCLiHBQPFkajxNuYa08zS9Aeyhe
         urMw9KJi7LVYSRpwOSRM3MQhPv/9zp+ey14WVzy2+am/mPoGqBMOKPo02W8QKmuH56la
         6YXGD6jF9iOLhNAfHs8Zm/emcTz8mFw0QP5MKSShFw+VKdJmfe4QsLNTM/h4HCWd8LEC
         BEY6rJNmYJZbrKeC85eIwQoFwWSnS4de786t7E5nqHBtqNbKFhRDqP3YbKLex/+j42MM
         kIragEG4Ql9gvLhrLDDEcVzdkugbfvc3LVy8JLcKDfZYxTqJ4RiY2f7dYacfRY+lo7d9
         jBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701961028; x=1702565828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjO+EmVAcgMYQOFWsnqPhTs0jze6OHRX9SLzDiaddCI=;
        b=VdtjODmIC3DWyb/qTC93RwoRchG0llFzXSRgHjTokp4yoGUlz4ijrOAaJEF7XjOQ+B
         58hpsw06iAcNJOjt8HmAEgbu6GIpzu5uJULMuv0KuOr9QMRZPSJMB5sZBib7mQrenBCV
         0UOa5kak6uyG+7U8gJqUe05oGrworCDF/mb/NFPazRIvVl0vEq3U1JgxC7XiOCU/fDU4
         2PllevFREgM6ss+REtWi8sl4wa7TvUDqwTq5lN81XJ4FFU7o2QpxQ/XUnp61F1B6nV7k
         xUmHVB/I8TWrgyDtOfZ/m+dfCf4XYkz8brH907Ov3zxaZSRBeAZPSgxSZib2k+UrDj8f
         TTVg==
X-Gm-Message-State: AOJu0Yw7O5uPPCjKjbGqZNFwHPan6/TEilmiYkFiGkin2JyGOsDZqXsi
	xch6BKB+ZC2JwRq3Ac4v4w==
X-Google-Smtp-Source: AGHT+IEH55TOuzrB8F4p8kP/vkgBcD1yAQQocMdM6HWrGdQLoBFnymWCiACeHR1CL4EyUBHMRIGn1A==
X-Received: by 2002:a17:906:af98:b0:a19:a19b:55ee with SMTP id mj24-20020a170906af9800b00a19a19b55eemr1627699ejb.126.1701961027670;
        Thu, 07 Dec 2023 06:57:07 -0800 (PST)
Received: from p183 ([46.53.254.107])
        by smtp.gmail.com with ESMTPSA id q5-20020a1709060e4500b00a1d17c92ef3sm923271eji.51.2023.12.07.06.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:57:07 -0800 (PST)
Date: Thu, 7 Dec 2023 17:57:05 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Florian Weimer <fweimer@redhat.com>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v2] ELF: supply userspace with available page shifts
 (AT_PAGE_SHIFT_MASK)
Message-ID: <4f5f29d4-9c50-453c-8ad3-03a92fed192e@p183>
References: <6b399b86-a478-48b0-92a1-25240a8ede54@p183>
 <87v89dvuxg.fsf@oldenburg.str.redhat.com>
 <1d679805-8a82-44a4-ba14-49d4f28ff597@p183>
 <202312061236.DE847C52AA@keescook>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202312061236.DE847C52AA@keescook>

On Wed, Dec 06, 2023 at 12:47:27PM -0800, Kees Cook wrote:
> On Tue, Dec 05, 2023 at 07:01:34PM +0300, Alexey Dobriyan wrote:
> > Report available page shifts in arch independent manner, so that
> > userspace developers won't have to parse /proc/cpuinfo hunting
> > for arch specific strings:
> > 
> > Note!
> > 
> > This is strictly for userspace, if some page size is shutdown due
> > to kernel command line option or CPU bug workaround, than is must not
> > be reported in aux vector!
> 
> Given Florian in CC, I assume this is something glibc would like to be
> using? Please mention this in the commit log.

glibc can use it. Main user is libhugetlbfs, I guess:

	https://github.com/libhugetlbfs/libhugetlbfs/blob/master/hugeutils.c#L915

Loop inside getauxval() can run faster than opendir().

> > x86_64 machine with 1 GiB pages:
> > 
> > 	00000030  06 00 00 00 00 00 00 00  00 10 00 00 00 00 00 00
> > 	00000040  1d 00 00 00 00 00 00 00  00 10 20 40 00 00 00 00
> > 
> > x86_64 machine with 2 MiB pages only:
> > 
> > 	00000030  06 00 00 00 00 00 00 00  00 10 00 00 00 00 00 00
> > 	00000040  1d 00 00 00 00 00 00 00  00 10 20 00 00 00 00 00
> > 
> > AT_PAGESZ is always 4096 which is not that interesting.
> 
> That's not always true. For example, see arm64:
> arch/arm64/include/asm/elf.h:#define ELF_EXEC_PAGESIZE  PAGE_SIZE

Yes, I'm x86_64 guy, AT_PAGESZ remark is about x86_64.

> I'm not actually sure why x86 forces it to 4096. I'd need to go look
> through the history there.

> > --- a/arch/x86/include/asm/elf.h
> > +++ b/arch/x86/include/asm/elf.h
> > @@ -358,6 +358,18 @@ else if (IS_ENABLED(CONFIG_IA32_EMULATION))				\
> >  
> >  #define COMPAT_ELF_ET_DYN_BASE	(TASK_UNMAPPED_BASE + 0x1000000)
> >  
> > +#define ARCH_AT_PAGE_SHIFT_MASK					\
> > +	do {							\
> > +		u32 val = 1 << 12;				\
> > +		if (boot_cpu_has(X86_FEATURE_PSE)) {		\
> > +			val |= 1 << 21;				\
> > +		}						\
> > +		if (boot_cpu_has(X86_FEATURE_GBPAGES)) {	\
> > +			val |= 1 << 30;				\
> > +		}						\
> > +		NEW_AUX_ENT(AT_PAGE_SHIFT_MASK, val);		\
> > +	} while (0)
> > +
> >  #endif /* !CONFIG_X86_32 */
> 
> Can't we have a generic ARCH_AT_PAGE_SHIFT_MASK too? Something like:
> 
> #ifndef ARCH_AT_PAGE_SHIFT_MASK
> #define ARCH_AT_PAGE_SHIFT_MASK
> 	NEW_AUX_ENT(AT_PAGE_SHIFT_MASK, 1 << PAGE_SHIFT)
> #endif
> 
> Or am I misunderstanding something here?

1) Arch maintainers can opt into this new way to report information at
   their own pace.

2) AT_PAGE_SHIFT_MASK is about _all_ pagesizes supported by CPU.
   Reporting just one is missing the point.

   I'll clarify comment: mmap() support require many things including
   tests for hugetlbfs being mounted, this is about CPU support.

> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -240,6 +240,9 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
> >  #endif
> >  	NEW_AUX_ENT(AT_HWCAP, ELF_HWCAP);
> >  	NEW_AUX_ENT(AT_PAGESZ, ELF_EXEC_PAGESIZE);
> > +#ifdef ARCH_AT_PAGE_SHIFT_MASK
> > +	ARCH_AT_PAGE_SHIFT_MASK;
> > +#endif
> 
> That way we can avoid an #ifdef in the .c file.

That's a false economy. ifdefs aren't bad inherently.
When all archs implement AT_PAGE_SHIFT_MASK, ifdef will be removed.

> > --- a/include/uapi/linux/auxvec.h
> > +++ b/include/uapi/linux/auxvec.h
> > @@ -33,6 +33,20 @@
> >  #define AT_RSEQ_FEATURE_SIZE	27	/* rseq supported feature size */
> >  #define AT_RSEQ_ALIGN		28	/* rseq allocation alignment */
> >  
> > +/*
> > + * Page sizes available for mmap(2) encoded as bitmask.
> > + *
> > + * Example: x86_64 system with pse, pdpe1gb /proc/cpuinfo flags reports
> > + * 4 KiB, 2 MiB and 1 GiB page support.
> > + *
> > + *	$ hexdump -C /proc/self/auxv
> 
> FWIW, a more readable form is: $ LD_SHOW_AUXV=1 /bin/true

OK. It doesn't show new values as text, but OK.

> > + *	00000030  06 00 00 00 00 00 00 00  00 10 00 00 00 00 00 00
> > + *	00000040  1d 00 00 00 00 00 00 00  00 10 20 40 00 00 00 00
> > + *
> > + * For 2^64 hugepage support please contact your Universe sales representative.
> > + */
> > +#define AT_PAGE_SHIFT_MASK	29
> 
> ... hmm, why is 29 unused?
> 
> > +
> >  #define AT_EXECFN  31	/* filename of program */
> >  
> >  #ifndef AT_MINSIGSTKSZ
> 
> This will need a man page update for "getauxval" as well...

Hear, hear!

