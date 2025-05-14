Return-Path: <linux-arch+bounces-11924-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C51A8AB6970
	for <lists+linux-arch@lfdr.de>; Wed, 14 May 2025 13:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88B61774B4
	for <lists+linux-arch@lfdr.de>; Wed, 14 May 2025 11:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DEA27467A;
	Wed, 14 May 2025 11:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I15Wzgb4"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D7F225A50
	for <linux-arch@vger.kernel.org>; Wed, 14 May 2025 11:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747220558; cv=none; b=pL+Ut0SPYxI4qSVvciDoW7MHK5yiTJjMZBCnUY2Z4amk2o+i0KxrIv166fvZa63BNNyPxntTs8/KJ///t7vorMP3gzwrjnIFKKxrQd4hyuLUgN8AssKgGwgMB9syUvq0v23qu4ofOnQ6vi1Nshn9fFO2BqgDGSddanwQS/ycqXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747220558; c=relaxed/simple;
	bh=g6FsWqajrTcVSIHknD3zeLY9flfbWnzSw3aQFZLECpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=misX1YmGskmQS4shiBI1NYHhOkIiNcmSIhhk0eTG2L8DBHtelYJ6nlBdffFb5H6NTQq+Id/ZTbgaQEoLXUQzeq07cpBWtTmhQu0IACV4eqqnu0AWKlKBlHJxoSEbo1eDwTZO+7YAB7qwTkL74tHy2n9qOLdRFmBZqILKjPfgq5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I15Wzgb4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747220554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cav3Z4NY5VTBc23C/qTtaVoA8kEGEB5wAcjksldNIvE=;
	b=I15Wzgb4KH+oyoPc6ukXT/0Rwdg5uNuvsAl9IB61zrfdLL64n3zJsde/cQlpOL63vmRgqh
	eIv0oGHsyLYob1U9Fx4UGZG6Ey1R5cIe9TH/vN63/4zQN/PjxsRIT1AnWpkbjir82ox2zz
	gOhrSEgIy0Z5w8YIy6dkuIs0UXJ1P4g=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-Bz5SeUB7Oj2bNAXA0XM0vw-1; Wed, 14 May 2025 07:02:32 -0400
X-MC-Unique: Bz5SeUB7Oj2bNAXA0XM0vw-1
X-Mimecast-MFC-AGG-ID: Bz5SeUB7Oj2bNAXA0XM0vw_1747220551
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5fbfdf7d306so6122819a12.3
        for <linux-arch@vger.kernel.org>; Wed, 14 May 2025 04:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747220551; x=1747825351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cav3Z4NY5VTBc23C/qTtaVoA8kEGEB5wAcjksldNIvE=;
        b=ae9YycOZsGu0718RKmldRO3MU2L/8EqyElsnBov/YeAlPOlMh2l75Tcx2z7RQCbEHf
         vapx1jWfWQfL5MerYblF4Ygbso1d2aPnkpUOdu+0lsJgQx7IU7Z5CpcvkiWAvlwi3rb1
         vIRrvEM4JZylASPC0UPNMIJCuy8e9LKRfWX3CUdMdQeUGLwGa4mlLhanN9seUe3Umsek
         tG3weXJMyJD0U54d44Yo8+3U2usOnmbBqydWpRWin0sKikZIOEjdglrKh9+ASdoQkkl9
         btfZq7LnK8g/R9Qzz/XUoSvX+bAi4wSFUAzXmBuHMs5b7WDl6rkhOovDqenJW/9yzWc2
         4uxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3GSrsOJ9vr0/sfGU4VPWcJcDOQuXdy+3gBG+miF4TF3HF6vZUEqqo1uwK1WR8e+joMKgDwvWPraDK@vger.kernel.org
X-Gm-Message-State: AOJu0YxlWC8gmHxvxnrkuXhTSY0axcFs6DEErUL56deiFLowWmF4o6GV
	1JO8TAgxnNBpF2xjovEGK6B1+AzKPWoJBtK9Aunj8uaQwsFU9TbuCBBo/RxzIHgmNV8F1Kg7lez
	U4xJ3iijWQb8ZACu1NIk9Nj2DNUq50/GwS1hUPf7VQPI9mxMc8Rd3/hM5wQ==
X-Gm-Gg: ASbGncte9G0l1xmlzbLUFUylLqNUNfEJrU/evWG0CzsoBEzJ4sShDxW+NY1oVqdK/xc
	ua2wO/jeC/9fRodjoYrQT24cYchNaIYoeI1amTcX36VEbsncv8ssBNJI8v69YZ6tSk0CaWg+gEF
	lnvX8JhUL0OnVJL2unq5IeYsCLmpU7gJjE4/eL4K4uBwLpXc1wDqq7gQwCY7R1Qn/Qui5Qs9Mcv
	lAj5uLXNQpeR7seUWcpkaTeyrxzcEQn+InVoppr2hCdkgcVLEb3FQuNtt0QtQs///M1QkGHdh+G
	4g==
X-Received: by 2002:a05:6402:234d:b0:5f4:ade4:88c5 with SMTP id 4fb4d7f45d1cf-5ff988dd135mr2082982a12.34.1747220551048;
        Wed, 14 May 2025 04:02:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs3ORoNcv9GW9V4gupozuqWmYmwSxEEUINo5zQzLXzCm36ngPWceLYKaaZhwPfqmrqY5iYdA==
X-Received: by 2002:a05:6402:234d:b0:5f4:ade4:88c5 with SMTP id 4fb4d7f45d1cf-5ff988dd135mr2082854a12.34.1747220550339;
        Wed, 14 May 2025 04:02:30 -0700 (PDT)
Received: from thinky ([2a0e:fd87:a051:1:e664:4a86:4c01:c774])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fe43357d45sm4879817a12.54.2025.05.14.04.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 04:02:29 -0700 (PDT)
Date: Wed, 14 May 2025 13:02:13 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
	Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	selinux@vger.kernel.org, ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v5 2/7] lsm: introduce new hooks for setting/getting
 inode fsxattr
Message-ID: <kgl5h2iruqnhmad65sonlvneu6mdj6jl3sd4aoc3us3lvrgviy@imce27t4nk2e>
References: <20250512-xattrat-syscall-v5-0-4cd6821e8ff7@kernel.org>
 <20250512-xattrat-syscall-v5-2-4cd6821e8ff7@kernel.org>
 <f700845d-f332-4336-a441-08f98cd7f075@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f700845d-f332-4336-a441-08f98cd7f075@schaufler-ca.com>

On 2025-05-12 08:43:32, Casey Schaufler wrote:
> On 5/12/2025 6:25 AM, Andrey Albershteyn wrote:
> > Introduce new hooks for setting and getting filesystem extended
> > attributes on inode (FS_IOC_FSGETXATTR).
> >
> > Cc: selinux@vger.kernel.org
> > Cc: Paul Moore <paul@paul-moore.com>
> >
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> >  fs/file_attr.c                | 19 ++++++++++++++++---
> >  include/linux/lsm_hook_defs.h |  2 ++
> >  include/linux/security.h      | 16 ++++++++++++++++
> >  security/security.c           | 30 ++++++++++++++++++++++++++++++
> >  4 files changed, 64 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/file_attr.c b/fs/file_attr.c
> > index 2910b7047721..be62d97cc444 100644
> > --- a/fs/file_attr.c
> > +++ b/fs/file_attr.c
> > @@ -76,10 +76,15 @@ EXPORT_SYMBOL(fileattr_fill_flags);
> >  int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
> >  {
> >  	struct inode *inode = d_inode(dentry);
> > +	int error;
> >  
> >  	if (!inode->i_op->fileattr_get)
> >  		return -ENOIOCTLCMD;
> >  
> > +	error = security_inode_file_getattr(dentry, fa);
> > +	if (error)
> > +		return error;
> > +
> 
> If you're changing VFS behavior to depend on LSMs supporting the new
> hooks I'm concerned about the impact it will have on the LSMs that you
> haven't supplied hooks for. Have you tested these changes with anything
> besides SELinux?

Sorry, this thread is incomplete, I've resent full patchset again.
If you have any further comments please comment in that thread [1]

I haven't tested with anything except SELinux, but I suppose if
module won't register any hooks, then security_inode_file_*() will
return 0. Reverting SELinux implementation of the hooks doesn't
cause any errors.

I'm not that familiar with LSMs/selinux and its codebase, if you can
recommend what need to be tested while adding new hooks, I will try
to do that for next revision.

[1]: https://lore.kernel.org/linux-fsdevel/CAOQ4uxgOAxg7N1OUJfb1KMp7oWOfN=KV9Lzz6ZrX0=XRGOQrEQ@mail.gmail.com/T/#t

-- 
- Andrey


