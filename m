Return-Path: <linux-arch+bounces-11495-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD29A96EED
	for <lists+linux-arch@lfdr.de>; Tue, 22 Apr 2025 16:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC2D402AA9
	for <lists+linux-arch@lfdr.de>; Tue, 22 Apr 2025 14:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC64028C5BC;
	Tue, 22 Apr 2025 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnKVP2qg"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976B35FB95;
	Tue, 22 Apr 2025 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745332305; cv=none; b=C5GKsBdoudaRkL1mxOYa70B2qDFDKhDmeaorg8/TEkY+mymxtAAHyWnXeuB+I8VCSEnpYdiYsD/ryMtCYFrUPRDY1inb7YHgI3pkI4PHJqkJ1Y1zTNJMxtu/0kaoEEax3khtSxwJzFIIfVkN8rR9UtE7FERQ9+3kzebfIbViJw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745332305; c=relaxed/simple;
	bh=7UtTHz1OzXRKk72/53w5IsO8pN7dEsKHXzdKjN8mTNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwtipN35DR31NbGXj4fyhV6twckoziX1cYV1lH4S4XGM4+7nu77KvmMIFmplPGGxjXXvdFW6lOk/baTNSRxC5nKsIDy3m06DhSD6e3syWuiub3NhUAcME4LUXyrWHxoO9iMmLG8YwaEUVjEbc3lD1ygVgR8KUkm+YqNMBtBlsBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnKVP2qg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90596C4CEE9;
	Tue, 22 Apr 2025 14:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745332305;
	bh=7UtTHz1OzXRKk72/53w5IsO8pN7dEsKHXzdKjN8mTNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qnKVP2qgtO1hUN9mVrGyWaGTEWIq8jqpIHr3uY8inZjbNWCGzdRo0J9uDNoKMTac4
	 CvbGZZEvU2voGPjIOxRzKnGAQMMUdB8rkinceS5Q35tVPiweTvYOfb6F69Hp5kz9RK
	 Lxej1524mrJGhqPR5hjuNZxX40hVhV4VStcN7qi/M9g3RTAnXioB6T31JWdzgU+cxl
	 ZN20HhqG8eyKJyUJyJ0AVBKGkmtN4NO4E0W6r32ChQHQMVDyzsJScxz2LDwusrLjqq
	 KiNG5ZeX16W68bez2U3lfR+MKOHY4fO/OC1L6rAgNnvcTL+TCBgn7RKVCuDlfxb4RJ
	 B9aAONV7LjjUQ==
Date: Tue, 22 Apr 2025 16:31:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
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
Message-ID: <20250422-suchen-filmpreis-3573a913457c@brauner>
References: <20250321-xattrat-syscall-v4-0-3e82e6fb3264@kernel.org>
 <20250321-xattrat-syscall-v4-3-3e82e6fb3264@kernel.org>
 <CAOQ4uxj2Fqmc_pSD4bqqoQu7QjmgSVp2V15FbmBdTNqQ03aPGQ@mail.gmail.com>
 <faqun3wrpvwrhwukql3niqvvauy5ngrpytx5bxbrv5xkounez3@m7j2znjuzapu>
 <CAOQ4uxjs=Gg-ocwx_fkzc0gxQ_dHx-P9EAgz5ZwbdbrxV0T_EA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjs=Gg-ocwx_fkzc0gxQ_dHx-P9EAgz5ZwbdbrxV0T_EA@mail.gmail.com>

On Thu, Mar 27, 2025 at 12:39:28PM +0100, Amir Goldstein wrote:
> On Thu, Mar 27, 2025 at 10:33 AM Andrey Albershteyn <aalbersh@redhat.com> wrote:
> >
> > On 2025-03-23 09:56:25, Amir Goldstein wrote:
> > > On Fri, Mar 21, 2025 at 8:49 PM Andrey Albershteyn <aalbersh@redhat.com> wrote:
> > > >
> > > > From: Andrey Albershteyn <aalbersh@redhat.com>
> > > >
> > > > Introduce getfsxattrat and setfsxattrat syscalls to manipulate inode
> > > > extended attributes/flags. The syscalls take parent directory fd and
> > > > path to the child together with struct fsxattr.
> > > >
> > > > This is an alternative to FS_IOC_FSSETXATTR ioctl with a difference
> > > > that file don't need to be open as we can reference it with a path
> > > > instead of fd. By having this we can manipulated inode extended
> > > > attributes not only on regular files but also on special ones. This
> > > > is not possible with FS_IOC_FSSETXATTR ioctl as with special files
> > > > we can not call ioctl() directly on the filesystem inode using fd.
> > > >
> > > > This patch adds two new syscalls which allows userspace to get/set
> > > > extended inode attributes on special files by using parent directory
> > > > and a path - *at() like syscall.
> > > >
> > > > CC: linux-api@vger.kernel.org
> > > > CC: linux-fsdevel@vger.kernel.org
> > > > CC: linux-xfs@vger.kernel.org
> > > > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > > ---
> > > ...
> > > > +SYSCALL_DEFINE5(setfsxattrat, int, dfd, const char __user *, filename,
> > > > +               struct fsxattr __user *, ufsx, size_t, usize,
> > > > +               unsigned int, at_flags)
> > > > +{
> > > > +       struct fileattr fa;
> > > > +       struct path filepath;
> > > > +       int error;
> > > > +       unsigned int lookup_flags = 0;
> > > > +       struct filename *name;
> > > > +       struct mnt_idmap *idmap;.
> > >
> > > > +       struct dentry *dentry;
> > > > +       struct vfsmount *mnt;
> > > > +       struct fsxattr fsx = {};
> > > > +
> > > > +       BUILD_BUG_ON(sizeof(struct fsxattr) < FSXATTR_SIZE_VER0);
> > > > +       BUILD_BUG_ON(sizeof(struct fsxattr) != FSXATTR_SIZE_LATEST);
> > > > +
> > > > +       if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
> > > > +               return -EINVAL;
> > > > +
> > > > +       if (!(at_flags & AT_SYMLINK_NOFOLLOW))
> > > > +               lookup_flags |= LOOKUP_FOLLOW;
> > > > +
> > > > +       if (at_flags & AT_EMPTY_PATH)
> > > > +               lookup_flags |= LOOKUP_EMPTY;
> > > > +
> > > > +       if (usize > PAGE_SIZE)
> > > > +               return -E2BIG;
> > > > +
> > > > +       if (usize < FSXATTR_SIZE_VER0)
> > > > +               return -EINVAL;
> > > > +
> > > > +       error = copy_struct_from_user(&fsx, sizeof(struct fsxattr), ufsx, usize);
> > > > +       if (error)
> > > > +               return error;
> > > > +
> > > > +       fsxattr_to_fileattr(&fsx, &fa);
> > > > +
> > > > +       name = getname_maybe_null(filename, at_flags);
> > > > +       if (!name) {
> > > > +               CLASS(fd, f)(dfd);
> > > > +
> > > > +               if (fd_empty(f))
> > > > +                       return -EBADF;
> > > > +
> > > > +               idmap = file_mnt_idmap(fd_file(f));
> > > > +               dentry = file_dentry(fd_file(f));
> > > > +               mnt = fd_file(f)->f_path.mnt;
> > > > +       } else {
> > > > +               error = filename_lookup(dfd, name, lookup_flags, &filepath,
> > > > +                                       NULL);
> > > > +               if (error)
> > > > +                       return error;
> > > > +
> > > > +               idmap = mnt_idmap(filepath.mnt);
> > > > +               dentry = filepath.dentry;
> > > > +               mnt = filepath.mnt;
> > > > +       }
> > > > +
> > > > +       error = mnt_want_write(mnt);
> > > > +       if (!error) {
> > > > +               error = vfs_fileattr_set(idmap, dentry, &fa);
> > > > +               if (error == -ENOIOCTLCMD)
> > > > +                       error = -EOPNOTSUPP;
> > >
> > > This is awkward.
> > > vfs_fileattr_set() should return -EOPNOTSUPP.
> > > ioctl_setflags() could maybe convert it to -ENOIOCTLCMD,
> > > but looking at similar cases ioctl_fiemap(), ioctl_fsfreeze() the
> > > ioctl returns -EOPNOTSUPP.
> > >
> > > I don't think it is necessarily a bad idea to start returning
> > >  -EOPNOTSUPP instead of -ENOIOCTLCMD for the ioctl
> > > because that really reflects the fact that the ioctl is now implemented
> > > in vfs and not in the specific fs.
> > >
> > > and I think it would not be a bad idea at all to make that change
> > > together with the merge of the syscalls as a sort of hint to userspace
> > > that uses the ioctl, that the sycalls API exists.
> > >
> > > Thanks,
> > > Amir.
> > >
> >
> > Hmm, not sure what you're suggesting here. I see it as:
> > - get/setfsxattrat should return EOPNOTSUPP as it make more sense
> >   than ENOIOCTLCMD
> > - ioctl_setflags returns ENOIOCTLCMD which also expected
> >
> > Don't really see a reason to change what vfs_fileattr_set() returns
> > and then copying this if() to other places or start returning
> > EOPNOTSUPP.
> 
> ENOIOCTLCMD conceptually means that the ioctl command is unknown
> This is not the case since ->fileattr_[gs]et() became a vfs API

vfs_fileattr_{g,s}et() should not return ENOIOCTLCMD. Change the return
code to EOPNOTSUPP and then make EOPNOTSUPP be translated to ENOTTY on
on overlayfs and to ENOIOCTLCMD in ecryptfs and in fs/ioctl.c. This way
we get a clean VFS api while retaining current behavior. Amir can do his
cleanup based on that.

