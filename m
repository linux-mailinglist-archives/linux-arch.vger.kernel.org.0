Return-Path: <linux-arch+bounces-11156-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C69BA72C8B
	for <lists+linux-arch@lfdr.de>; Thu, 27 Mar 2025 10:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C313E16B663
	for <lists+linux-arch@lfdr.de>; Thu, 27 Mar 2025 09:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28F420CCFA;
	Thu, 27 Mar 2025 09:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aPUVrtRY"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17BA20CCC4
	for <linux-arch@vger.kernel.org>; Thu, 27 Mar 2025 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743068037; cv=none; b=JssDqMBlo4ldOptxXGG515Rsv22F4Rc9GaJHX6piMui1R+NQf6IprmOHQl1MTHvCDpqIX1QVJivqykPluNzgK0YERdr+2DQTlLwcBIFKC51CeHoILPFjvFxtinCT82PtD93GLV5QO4hq8R7YJ8PLo0hUpQ554Nn19TBBYnYu71g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743068037; c=relaxed/simple;
	bh=Ux2uTvJSKDFlMu3udvsF6mFtz0qXJP724SLPGRRJ9wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtKTPw4zAJE6ZNA/0hhvN2gMOIRevG7qUWUkrsJ5Ff3gnSKrz/t4LhdOMqA4hzCP7sAKLSStmXzpK/lCcoQamIbGhZWl0S0vVWpAySxPT6zMZ1WbRii1kb1qN1h2pfDXyyef8yHBADJaUTgDxvwLF83ID8u8Am/GVJI/DN5roaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aPUVrtRY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743068033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h5CNfk8nfXsjqd7Al/TA3/xzYA4Q3Hci3BjuX9fq6Hk=;
	b=aPUVrtRYOQtJ2L+tR7sL6cHKz7s6DrTZWVcI0kVc/Mc0u6z05FJ0C8gKXSuVhF8OLtl6hn
	ovGpsmw5FStcEAGXmL67YVjC6xR06fggP4g7/bSCwi+upNPVMjQ8q5gRNmRaK0s40soGTM
	kNS/oukt7pEWp6YkqtcoGJMFdH3LEp4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-jnyIk45EPo6nQcA9BLv3SA-1; Thu, 27 Mar 2025 05:33:51 -0400
X-MC-Unique: jnyIk45EPo6nQcA9BLv3SA-1
X-Mimecast-MFC-AGG-ID: jnyIk45EPo6nQcA9BLv3SA_1743068030
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac37ed2b99fso65798466b.3
        for <linux-arch@vger.kernel.org>; Thu, 27 Mar 2025 02:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743068030; x=1743672830;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h5CNfk8nfXsjqd7Al/TA3/xzYA4Q3Hci3BjuX9fq6Hk=;
        b=DsaBD7tr++erEmDMeDHpw/fYMzDXdBUyRBKMbSARgWQPSyvjjghAgiW8DRlMbJ2Yu7
         px7J/ETxEtmQaUq5r881gaHQ/CmSHChZ8YRbrwgdCAWxa7ST0dV5Q9cnGaFShQv3nhYV
         GVBI3D5497m0/zNjGtucPzY8RlAZgMpRf1E5NPXcS/lEd6eY12PTkdCTsjZ1Pu/czxff
         42yuUIBm+23cinlc8FPG132QmWCFhjGgD1j61jtkRzaqK+aZ5Oyybx1vZmA0M7BnngCX
         YZAkw1igQ14Y5b1HNGkVFw0SOZdASH8PT4iiDCX4MoOyOjTYowSbf0mzxxwWiJlSFOqh
         Jn7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjMy02UpuSnSOH+UuBf7Q1u7LJJ/DReLLfFxZKe1TBES6j1GGw7KXNA3Gt4HKEsQsOkmcqU/VYl95i@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe5TX43HQZdoNAwxSRrA+8ZaH5B3BVUBdPPf9wP/Yw65d/3vHU
	PW9CKvO47ZIzW3RYo9gAl+xqIiRgqv0qmRZfpwdmTq8xeKB84zyH2A9N+JmuKNm5LFcXKRmX0aF
	05JSFDuWITOuAKS1mw0Fn40AAHZ3FZuWzWhYsja9BzwoSQ00Ze4NLKHK4rQ==
X-Gm-Gg: ASbGncudyoi4m3XkdbX6R5CCNCQCbbkJFZJGsXnHs/+FWxaLUaeJnAWafVS24RtqU0e
	VyijgMYpnfYnWmLkK5TxOuTJrxGt5vGhhBCcyU/9X0ZfjrhGiOZFCm4oo/W9mTyheXgTnFvRL7I
	GXV2lXGgcEb4OmYFhYYUXHH1184HWeSFqovlFAJFdTZrjSMm6Otuq2+oiFh/vgtmdL37UJHKgo4
	KB8vHZVoio1A/+/ArgoZxQ/8C2Be/fjakYYQ1YjoM9gThNP8yw/7jhbEWSfQRJOI0ui4eNw/xlz
	HQ4INaNQe7amhv7H3vGpamvQJaNeJ+X3L7A=
X-Received: by 2002:a17:907:9485:b0:ac2:87b0:e4a5 with SMTP id a640c23a62f3a-ac6faeaf925mr243560366b.2.1743068030173;
        Thu, 27 Mar 2025 02:33:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2zYSC7bMfUbOdY5puF0aDWWJJczWfClUA+AIABeR6/ROC8MRiCRtqFsrSolJNpWyhPAQwww==
X-Received: by 2002:a17:907:9485:b0:ac2:87b0:e4a5 with SMTP id a640c23a62f3a-ac6faeaf925mr243555966b.2.1743068029638;
        Thu, 27 Mar 2025 02:33:49 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efd47f44sm1185448066b.163.2025.03.27.02.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 02:33:49 -0700 (PDT)
Date: Thu, 27 Mar 2025 10:33:47 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
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
	"Serge E. Hallyn" <serge@hallyn.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v4 3/3] fs: introduce getfsxattrat and setfsxattrat
 syscalls
Message-ID: <faqun3wrpvwrhwukql3niqvvauy5ngrpytx5bxbrv5xkounez3@m7j2znjuzapu>
References: <20250321-xattrat-syscall-v4-0-3e82e6fb3264@kernel.org>
 <20250321-xattrat-syscall-v4-3-3e82e6fb3264@kernel.org>
 <CAOQ4uxj2Fqmc_pSD4bqqoQu7QjmgSVp2V15FbmBdTNqQ03aPGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj2Fqmc_pSD4bqqoQu7QjmgSVp2V15FbmBdTNqQ03aPGQ@mail.gmail.com>

On 2025-03-23 09:56:25, Amir Goldstein wrote:
> On Fri, Mar 21, 2025 at 8:49 PM Andrey Albershteyn <aalbersh@redhat.com> wrote:
> >
> > From: Andrey Albershteyn <aalbersh@redhat.com>
> >
> > Introduce getfsxattrat and setfsxattrat syscalls to manipulate inode
> > extended attributes/flags. The syscalls take parent directory fd and
> > path to the child together with struct fsxattr.
> >
> > This is an alternative to FS_IOC_FSSETXATTR ioctl with a difference
> > that file don't need to be open as we can reference it with a path
> > instead of fd. By having this we can manipulated inode extended
> > attributes not only on regular files but also on special ones. This
> > is not possible with FS_IOC_FSSETXATTR ioctl as with special files
> > we can not call ioctl() directly on the filesystem inode using fd.
> >
> > This patch adds two new syscalls which allows userspace to get/set
> > extended inode attributes on special files by using parent directory
> > and a path - *at() like syscall.
> >
> > CC: linux-api@vger.kernel.org
> > CC: linux-fsdevel@vger.kernel.org
> > CC: linux-xfs@vger.kernel.org
> > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> ...
> > +SYSCALL_DEFINE5(setfsxattrat, int, dfd, const char __user *, filename,
> > +               struct fsxattr __user *, ufsx, size_t, usize,
> > +               unsigned int, at_flags)
> > +{
> > +       struct fileattr fa;
> > +       struct path filepath;
> > +       int error;
> > +       unsigned int lookup_flags = 0;
> > +       struct filename *name;
> > +       struct mnt_idmap *idmap;.
> 
> > +       struct dentry *dentry;
> > +       struct vfsmount *mnt;
> > +       struct fsxattr fsx = {};
> > +
> > +       BUILD_BUG_ON(sizeof(struct fsxattr) < FSXATTR_SIZE_VER0);
> > +       BUILD_BUG_ON(sizeof(struct fsxattr) != FSXATTR_SIZE_LATEST);
> > +
> > +       if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
> > +               return -EINVAL;
> > +
> > +       if (!(at_flags & AT_SYMLINK_NOFOLLOW))
> > +               lookup_flags |= LOOKUP_FOLLOW;
> > +
> > +       if (at_flags & AT_EMPTY_PATH)
> > +               lookup_flags |= LOOKUP_EMPTY;
> > +
> > +       if (usize > PAGE_SIZE)
> > +               return -E2BIG;
> > +
> > +       if (usize < FSXATTR_SIZE_VER0)
> > +               return -EINVAL;
> > +
> > +       error = copy_struct_from_user(&fsx, sizeof(struct fsxattr), ufsx, usize);
> > +       if (error)
> > +               return error;
> > +
> > +       fsxattr_to_fileattr(&fsx, &fa);
> > +
> > +       name = getname_maybe_null(filename, at_flags);
> > +       if (!name) {
> > +               CLASS(fd, f)(dfd);
> > +
> > +               if (fd_empty(f))
> > +                       return -EBADF;
> > +
> > +               idmap = file_mnt_idmap(fd_file(f));
> > +               dentry = file_dentry(fd_file(f));
> > +               mnt = fd_file(f)->f_path.mnt;
> > +       } else {
> > +               error = filename_lookup(dfd, name, lookup_flags, &filepath,
> > +                                       NULL);
> > +               if (error)
> > +                       return error;
> > +
> > +               idmap = mnt_idmap(filepath.mnt);
> > +               dentry = filepath.dentry;
> > +               mnt = filepath.mnt;
> > +       }
> > +
> > +       error = mnt_want_write(mnt);
> > +       if (!error) {
> > +               error = vfs_fileattr_set(idmap, dentry, &fa);
> > +               if (error == -ENOIOCTLCMD)
> > +                       error = -EOPNOTSUPP;
> 
> This is awkward.
> vfs_fileattr_set() should return -EOPNOTSUPP.
> ioctl_setflags() could maybe convert it to -ENOIOCTLCMD,
> but looking at similar cases ioctl_fiemap(), ioctl_fsfreeze() the
> ioctl returns -EOPNOTSUPP.
> 
> I don't think it is necessarily a bad idea to start returning
>  -EOPNOTSUPP instead of -ENOIOCTLCMD for the ioctl
> because that really reflects the fact that the ioctl is now implemented
> in vfs and not in the specific fs.
> 
> and I think it would not be a bad idea at all to make that change
> together with the merge of the syscalls as a sort of hint to userspace
> that uses the ioctl, that the sycalls API exists.
> 
> Thanks,
> Amir.
> 

Hmm, not sure what you're suggesting here. I see it as:
- get/setfsxattrat should return EOPNOTSUPP as it make more sense
  than ENOIOCTLCMD
- ioctl_setflags returns ENOIOCTLCMD which also expected

Don't really see a reason to change what vfs_fileattr_set() returns
and then copying this if() to other places or start returning
EOPNOTSUPP.

-- 
- Andrey


