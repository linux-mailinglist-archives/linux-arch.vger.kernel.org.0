Return-Path: <linux-arch+bounces-11990-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D350ABBC94
	for <lists+linux-arch@lfdr.de>; Mon, 19 May 2025 13:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE90189328B
	for <lists+linux-arch@lfdr.de>; Mon, 19 May 2025 11:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923EA27586B;
	Mon, 19 May 2025 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="pXTAcIz/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0214275112
	for <linux-arch@vger.kernel.org>; Mon, 19 May 2025 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747654632; cv=none; b=Zwyk+bopDx8OGEOjPI1wChEWVHJcTXQB3e500eeRRQ6lU0A2sVUuWw3CMpjopca7DOdlRCZNWeDKuHQNVUgvimEmgPBezCldbEpxLNkliCDagj1HYpejKL6wjMtsn9uCmnkngZ2+tl4aflQYj6EPYy5gDqPpZmFCwOFQlUt5juo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747654632; c=relaxed/simple;
	bh=GFhTh8qt5cp6q80eo9lSCWZXWbRWYcGWMwJc66usfSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6a1OkG+jVa01LmUQK/BfRW0muwJqUuIqQVIEFWMzc5bfuP12bB86hoksRE/VEVzyI5rmyvWi7hO0zpJGZML/gYV7tVWDYr3rEZ9pTyzo6AySxl8fe9wqcvKKz06bCf0OJEt8XsTkLg9D+Uvcn0CyJhKWJC6ebEmh13Jae8B/Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=pXTAcIz/; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso3713520b3a.2
        for <linux-arch@vger.kernel.org>; Mon, 19 May 2025 04:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1747654629; x=1748259429; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DkYbc28ZqmxwTCsqpy3spmOraOHqionupf/htIjrysQ=;
        b=pXTAcIz/GgulyAu0QLlBT9UeD2DHbX4hsEBS6moydy6FP2YFBc9EthoupgN62flhpp
         xn4ElzxeEaMRoUdjcGLCr/6T8U743jjlDHrhPc3nJlHNeJ9D90PDD/0qwvCbTEtXXnQ1
         RPgaQQzoByYMNfLhMY+SSeSgYFHJurzhD/epDXsLrHJ8QKO7/mzSdR8ta0wu1TJyzets
         o/9yD05HLIBtFYJ+IxgsqFOQ7YKNTaFJLRWWee9LxcELfTQnG9oVJybE/EP025yFndXb
         f9adaN7VXFOsgSuBp7xl2mwq7q5rjr2T9EvmymBmqQ1mhIcKEwe4NG3DJCgDkmIhbGVz
         5ryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747654629; x=1748259429;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DkYbc28ZqmxwTCsqpy3spmOraOHqionupf/htIjrysQ=;
        b=jvyo+zJPpPW3GQZkzD1057IvRWSIqejshiA41Jut442JcCqsDIgLsz3VxWfBmsJ+mt
         TO85HgyPxczA30nuY7L/9GnoSfmGkQl2ENk/Vha0nnOB5lI0acx9PPH0ZuEPPOtHMuLY
         RCp4r7GgqZEe4mDVZnUJb0mOwKmSkSuQK1SWKU1EmdJSu1qMuxavzmXfCzjRY6OK/u8P
         0YLet/6TNfpwv5O/ITTvKOBIVN3r8blxwWDvVU0/HHqRBUnsPKLxhq6Qw9F2N+279kG1
         Hk6egubR1GNvGEPfnSGg99k8O1/V88QLsrbTFm8CWo3bJYgwkxAxDKFG/K0d43zs5L8A
         PR5A==
X-Forwarded-Encrypted: i=1; AJvYcCUNWd4TA95msIm10Pk4578vt3YAooVTMKicw/jBXhsWnc28XEqi8hbsGSszujKsXy9RmTifz26ZG9LV@vger.kernel.org
X-Gm-Message-State: AOJu0Yys1BZ8yDv2yVDHyzqV6w0EkEuC07VJhr7/A0kwxKG+2kFcPsJl
	tOeDEVaW+jaD0E8jCfUSHJ/K8FEVzGNOwPNXQZONjF1y/nZOZ1jBxmkzNarvzsoGrEg=
X-Gm-Gg: ASbGnct7AnzxVqFYtagHwzKofsDH+YUtEtup8AtpRcnecckI1yt4CDXqcuSDj9QbG/F
	1rUBvFG6FKcHYREloFgxY1PoeG61klSwlmHuu0K+ynyj25k4THFfadM9LHeZlBk5g5lUjL+YsK1
	pIrrOLmRU/sQW80TSCCbzWUt4+uN4L4MlBZVxEDb5DgV7WPsXX2l0j3ZSTrIlr3hCF9fKHSFZJT
	QqKr9DODxvud1u0zr/o1lKHFzIWNCAiVFnzXqiHurjubGdkjb9V0H7raQt1k1xcQ+OwG2z7f3w3
	O5L+HXy1Nbly+NvjzWf/0vN1qCDjhEyAn8LHnL9YjAWf2p6qiigyW37o++LE4CIKLF4MZKsElom
	ZVSRXySQF2ovjgnZ4AuNRqgpY/7c=
X-Google-Smtp-Source: AGHT+IEUy25uZy6yhylI082QEDzxGQ+0mJz25NQX6XuPMH4jpAhK+MU3tNtraGB6TKng6SdbDnt0Eg==
X-Received: by 2002:a05:6a00:3a20:b0:736:a6e0:e66d with SMTP id d2e1a72fcca58-742a97a6df2mr15123631b3a.6.1747654628667;
        Mon, 19 May 2025 04:37:08 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a973a2f8sm5957134b3a.81.2025.05.19.04.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 04:37:08 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uGyno-00000005Si8-44qA;
	Mon, 19 May 2025 21:37:04 +1000
Date: Mon, 19 May 2025 21:37:04 +1000
From: Dave Chinner <david@fromorbit.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Tyler Hicks <code@tyhicks.com>, Miklos Szeredi <miklos@szeredi.hu>,
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
	Linux-Arch <linux-arch@vger.kernel.org>, selinux@vger.kernel.org,
	ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
	linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v5 0/7] fs: introduce file_getattr and file_setattr
 syscalls
Message-ID: <aCsX4LTpAnGfFjHg@dread.disaster.area>
References: <20250513-xattrat-syscall-v5-0-22bb9c6c767f@kernel.org>
 <399fdabb-74d3-4dd6-9eee-7884a986dab1@app.fastmail.com>
 <20250515-bedarf-absagen-464773be3e72@brauner>
 <CAOQ4uxicuEkOas2UR4mqfus9Q2RAeKKYTwbE2XrkcE_zp8oScQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxicuEkOas2UR4mqfus9Q2RAeKKYTwbE2XrkcE_zp8oScQ@mail.gmail.com>

On Thu, May 15, 2025 at 12:33:31PM +0200, Amir Goldstein wrote:
> On Thu, May 15, 2025 at 11:02 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Tue, May 13, 2025 at 11:53:23AM +0200, Arnd Bergmann wrote:
> > > On Tue, May 13, 2025, at 11:17, Andrey Albershteyn wrote:
> > >
> > > >
> > > >     long syscall(SYS_file_getattr, int dirfd, const char *pathname,
> > > >             struct fsxattr *fsx, size_t size, unsigned int at_flags);
> > > >     long syscall(SYS_file_setattr, int dirfd, const char *pathname,
> > > >             struct fsxattr *fsx, size_t size, unsigned int at_flags);
> > >
> > > I don't think we can have both the "struct fsxattr" from the uapi
> > > headers, and a variable size as an additional argument. I would
> > > still prefer not having the extensible structure at all and just
> >
> > We're not going to add new interfaces that are fixed size unless for the
> > very basic cases. I don't care if we're doing that somewhere else in the
> > kernel but we're not doing that for vfs apis.
> >
> > > use fsxattr, but if you want to make it extensible in this way,
> > > it should use a different structure (name). Otherwise adding
> > > fields after fsx_pad[] would break the ioctl interface.
> >
> > Would that really be a problem? Just along the syscall simply add
> > something like:
> >
> > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > index c91fd2b46a77..d3943805c4be 100644
> > --- a/fs/ioctl.c
> > +++ b/fs/ioctl.c
> > @@ -868,12 +868,6 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
> >         case FS_IOC_SETFLAGS:
> >                 return ioctl_setflags(filp, argp);
> >
> > -       case FS_IOC_FSGETXATTR:
> > -               return ioctl_fsgetxattr(filp, argp);
> > -
> > -       case FS_IOC_FSSETXATTR:
> > -               return ioctl_fssetxattr(filp, argp);
> > -
> >         case FS_IOC_GETFSUUID:
> >                 return ioctl_getfsuuid(filp, argp);
> >
> > @@ -886,6 +880,20 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
> >                 break;
> >         }
> >
> > +       switch (_IOC_NR(cmd)) {
> > +       case _IOC_NR(FS_IOC_FSGETXATTR):
> > +               if (WARN_ON_ONCE(_IOC_TYPE(cmd) != _IOC_TYPE(FS_IOC_FSGETXATTR)))
> > +                       return SOMETHING_SOMETHING;
> > +               /* Only handle original size. */
> > +               return ioctl_fsgetxattr(filp, argp);
> > +
> > +       case _IOC_NR(FFS_IOC_FSSETXATTR):
> > +               if (WARN_ON_ONCE(_IOC_TYPE(cmd) != _IOC_TYPE(FFS_IOC_FSSETXATTR)))
> > +                       return SOMETHING_SOMETHING;
> > +               /* Only handle original size. */
> > +               return ioctl_fssetxattr(filp, argp);
> > +       }
> > +
> 
> I think what Arnd means is that we will not be able to change struct
> sfxattr in uapi
> going forward, because we are not going to deprecate the ioctls and

There's no need to deprecate anything to rev an ioctl API.  We have
had to solve this "changing struct size" problem previously in XFS
ioctls. See XFS_IOC_FSGEOMETRY and the older XFS_IOC_FSGEOMETRY_V4
and XFS_IOC_FSGEOMETRY_V1 versions of the API/ABI.

If we need to increase the structure size, we can rename the existing
ioctl and struct to fix the version in the API, then use the
original name for the new ioctl and structure definition.

The only thing we have to make sure of is that the old and new
structures have exactly the same overlapping structure. i.e.
extension must always be done by appending new varibles, they can't
be put in the middle of the structure.

This way applications being rebuild will pick up the new definition
automatically when the system asserts that it is suppored, whilst
existing binaries will always still be supported by the kernel.

If the application wants/needs to support all possible kernels, then
if XFS_IOC_FSGEOMETRY is not supported, call XFS_IOC_FSGEOMETRY_V4,
and if that fails (only on really old irix!) or you only need
something in that original subset, call XFS_IOC_FSGEOMETRY_V1 which
will always succeed....

> Should we will need to depart from this struct definition and we might
> as well do it for the initial release of the syscall rather than later on, e.g.:
> 
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -148,6 +148,17 @@ struct fsxattr {
>         unsigned char   fsx_pad[8];
>  };
> 
> +/*
> + * Variable size structure for file_[sg]et_attr().
> + */
> +struct fsx_fileattr {
> +       __u32           fsx_xflags;     /* xflags field value (get/set) */
> +       __u32           fsx_extsize;    /* extsize field value (get/set)*/
> +       __u32           fsx_nextents;   /* nextents field value (get)   */
> +       __u32           fsx_projid;     /* project identifier (get/set) */
> +       __u32           fsx_cowextsize; /* CoW extsize field value (get/set)*/
> +};
> +
> +#define FSXATTR_SIZE_VER0 20
> +#define FSXATTR_SIZE_LATEST FSXATTR_SIZE_VER0

If all the structures overlap the same, all that is needed in the
code is to define the structure size that should be copied in and
parsed. i.e:

	case FSXATTR..._V1:
		return ioctl_fsxattr...(args, sizeof(fsx_fileattr_v1));
	case FSXATTR..._V2:
		return ioctl_fsxattr...(args, sizeof(fsx_fileattr_v2));
	case FSXATTR...:
		return ioctl_fsxattr...(args, sizeof(fsx_fileattr));

-Dave.
-- 
Dave Chinner
david@fromorbit.com

