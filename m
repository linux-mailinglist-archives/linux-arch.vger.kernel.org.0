Return-Path: <linux-arch+bounces-11906-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68638AB393B
	for <lists+linux-arch@lfdr.de>; Mon, 12 May 2025 15:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FB953AE807
	for <lists+linux-arch@lfdr.de>; Mon, 12 May 2025 13:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BAC295DB1;
	Mon, 12 May 2025 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxahRL+G"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FB72951D9
	for <linux-arch@vger.kernel.org>; Mon, 12 May 2025 13:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747056497; cv=none; b=jDs7pjTwpwphjZwqxW550yxybWBNgN4HsUjg9QNQZqyZlKhp0EIXYqtRTEFTuuvFQ1l5aE3MkVJ/SGjHC9wyhFvf0yI1dJaFruTgIF5lqtOF8lF+nzdKwn+d+IbLOk1RJfUxMwrGC4aMUnhCZvhJ/E2YV8p/5m0n4RaEnOsdEzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747056497; c=relaxed/simple;
	bh=N3CsCOiUNSYi75zMs133iMwtQDHcERHaCi0LQeCA0w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otSsUvqO0tPzHX4yBlJW7FJ/Yszn0qWWQMoCzgFHdR02GvaBNZT4CQSiQ9nzugey5EO7Zal89j/mkjemDgMdbvCN6jpQnZn/K7KhLzrrO8scbUZU51d5J+qZMbk2KLepGlDjyTTzaWqvulId4NwBG8+9jW3CNrdGjrmrsaWzsew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dxahRL+G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747056493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hcnvSuplSyay+P2opMqH32jrlib56+gcaC7o9TzxSEk=;
	b=dxahRL+GY00pbtJ5F1LI2w6bms6dti3j4u3IMWYP57q/Cm4prwQ4R69BvdSghyMbM3aeL0
	NKhkdyZi50W8w+4JmuodEmIZKFdxNgK5tRDShUB+NLl0MDC0cR2OWFkhqHyBtAzeLaIei/
	U3G43qFu4xz4GwNZBU79oCAJev2quD8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-bpdgxWs1O-GSK3d7THIf-g-1; Mon, 12 May 2025 09:28:11 -0400
X-MC-Unique: bpdgxWs1O-GSK3d7THIf-g-1
X-Mimecast-MFC-AGG-ID: bpdgxWs1O-GSK3d7THIf-g_1747056490
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5fbf5fce18dso4612493a12.0
        for <linux-arch@vger.kernel.org>; Mon, 12 May 2025 06:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747056490; x=1747661290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcnvSuplSyay+P2opMqH32jrlib56+gcaC7o9TzxSEk=;
        b=YeyMj40uv5FIopoSI2BHe2EvvuOEXC0LYvAMCgaJs1ShGGGvaXhyqnxeaO6maGwMtN
         uYaNPG/iEqpyiyl/AFR9GxMJXIuAAcdaeAX2lIzir5YiAz+F3dfRuR++NGm4jclyloji
         I//ubxcS8Pxkpw/AQ5PYJqerntgzkptcmJxlIi7ztaxRVqzHuU/I50r8cgrpnBoKinp8
         tY3ze3VSGxYWtL3ZqITzJcv/uxGZSMUPDGA1kE/HL/7WT21HkETC50dhUAoFKEcay7I+
         Fe8eT6tZFywpkVuBPHjkOwFLCGdGYTUAuvzI5gHzSCkNp27ZlPuzYzZUMqZi/q3ufsGv
         XPwA==
X-Forwarded-Encrypted: i=1; AJvYcCVHxjwfKfoBUttDXuZM29eRB9j0XH/PQXBNuffddi4neft56cW1gtdLBqO/E0fx4/yTY+KDxqbmtpD5@vger.kernel.org
X-Gm-Message-State: AOJu0YxaxuDyj/nlUYMv7wM3p76Wvpd8kH629dore4NK0j4gfCEQqEFJ
	wGG/HwI5+8ynx8a+WgqPVQEbE28LKz8K+lYDTVXC3bbxT8jyk/xIt5Rpnay3QNGvvZ+ECK9WtkF
	TdCFWM+ooGuzgoa9VJkQU/wXubUtBJgQq2V2hwnHwtXFLqDEp4MQXMhPDCg==
X-Gm-Gg: ASbGncurNhT7MK0Cho1ySmFYeJtXzrJ2YENrmMaqVmXuJcZVRSOn6nrQonkyUPvZMqe
	89EQbR00YvsFCqHiV8pJvCl36cHWrtFfNpImcD5rEN/zhRCEgV2Yg4CaYl6rsb4QYR4tL5DWG7x
	RxafWIFpTLbOlUbxXBYxssk2NolK0nEHLz1DLz5YIzogYw7GxMZE+6232qZzsLbQHMOseZaLg5M
	719vZwmu4cbCfnvvO850JNMiY7/zPDvcNel0y9WYNI6+gXqVM2lqJNmCxL3lA8ns2nqyZhwy9eV
	1addVUON6XLV6ygkBBB/kfarlOmrdh0svZbCb42m
X-Received: by 2002:a05:6402:3587:b0:5fb:ad3c:d0c0 with SMTP id 4fb4d7f45d1cf-5fca073083emr11051403a12.1.1747056490198;
        Mon, 12 May 2025 06:28:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/W3zfYCJV6dhk/YZKJFqJ9p8o4bGVFJt+zvzzr59oo3YaKk/Q+HsESIm+YNLNDtoLhaP3/g==
X-Received: by 2002:a05:6402:3587:b0:5fb:ad3c:d0c0 with SMTP id 4fb4d7f45d1cf-5fca073083emr11051305a12.1.1747056489536;
        Mon, 12 May 2025 06:28:09 -0700 (PDT)
Received: from thinky (109-92-26-237.static.isp.telekom.rs. [109.92.26.237])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cc2633bsm5791532a12.20.2025.05.12.06.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 06:28:09 -0700 (PDT)
Date: Mon, 12 May 2025 15:28:05 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
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
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	selinux@vger.kernel.org, ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v5 5/7] fs: make vfs_fileattr_[get|set] return -EOPNOSUPP
Message-ID: <ayokvlxinxeoehids35l62ollqdwvai7jorefi7s4k263vvztp@hdfwbsmmfdba>
References: <20250512-xattrat-syscall-v5-0-ffbc7c477332@kernel.org>
 <20250512-xattrat-syscall-v5-5-ffbc7c477332@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512-xattrat-syscall-v5-5-ffbc7c477332@kernel.org>

On 2025-05-12 15:22:52, Andrey Albershteyn wrote:
> Future patches will add new syscalls which use these functions. As
> this interface won't be used for ioctls only the EOPNOSUPP is more
> appropriate return code.
> 
> This patch coverts return code from ENOIOCTLCMD to EOPNOSUPP for
> vfs_fileattr_get and vfs_fileattr_set. To save old behavior
> translate EOPNOSUPP back for current users - overlayfs, encryptfs
> and fs/ioctl.c.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/ecryptfs/inode.c  |  8 +++++++-
>  fs/file_attr.c       | 12 ++++++++++--
>  fs/overlayfs/inode.c |  2 +-
>  3 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index 51a5c54eb740..6bf08ff4d7f7 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -1124,7 +1124,13 @@ static int ecryptfs_removexattr(struct dentry *dentry, struct inode *inode,
>  
>  static int ecryptfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
>  {
> -	return vfs_fileattr_get(ecryptfs_dentry_to_lower(dentry), fa);
> +	int rc;
> +
> +	rc = vfs_fileattr_get(ecryptfs_dentry_to_lower(dentry), fa);
> +	if (rc == -EOPNOTSUPP)
> +		rc = -ENOIOCTLCMD;
> +
> +	return rc;
>  }
>  
>  static int ecryptfs_fileattr_set(struct mnt_idmap *idmap,
> diff --git a/fs/file_attr.c b/fs/file_attr.c
> index d9eab553dc25..d696f440fa4f 100644
> --- a/fs/file_attr.c
> +++ b/fs/file_attr.c
> @@ -79,7 +79,7 @@ int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
>  	int error;
>  
>  	if (!inode->i_op->fileattr_get)
> -		return -ENOIOCTLCMD;
> +		return -EOPNOTSUPP;
>  
>  	error = security_inode_file_getattr(dentry, fa);
>  	if (error)
> @@ -239,7 +239,7 @@ int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
>  	int err;
>  
>  	if (!inode->i_op->fileattr_set)
> -		return -ENOIOCTLCMD;
> +		return -EOPNOTSUPP;
>  
>  	if (!inode_owner_or_capable(idmap, inode))
>  		return -EPERM;
> @@ -281,6 +281,8 @@ int ioctl_getflags(struct file *file, unsigned int __user *argp)
>  	int err;
>  
>  	err = vfs_fileattr_get(file->f_path.dentry, &fa);
> +	if (err == -EOPNOTSUPP)
> +		err = -ENOIOCTLCMD;
>  	if (!err)
>  		err = put_user(fa.flags, argp);
>  	return err;
> @@ -302,6 +304,8 @@ int ioctl_setflags(struct file *file, unsigned int __user *argp)
>  			fileattr_fill_flags(&fa, flags);
>  			err = vfs_fileattr_set(idmap, dentry, &fa);
>  			mnt_drop_write_file(file);
> +			if (err == -EOPNOTSUPP)
> +				err = -ENOIOCTLCMD;
>  		}
>  	}
>  	return err;
> @@ -314,6 +318,8 @@ int ioctl_fsgetxattr(struct file *file, void __user *argp)
>  	int err;
>  
>  	err = vfs_fileattr_get(file->f_path.dentry, &fa);
> +	if (err == -EOPNOTSUPP)
> +		err = -ENOIOCTLCMD;
>  	if (!err)
>  		err = copy_fsxattr_to_user(&fa, argp);
>  
> @@ -334,6 +340,8 @@ int ioctl_fssetxattr(struct file *file, void __user *argp)
>  		if (!err) {
>  			err = vfs_fileattr_set(idmap, dentry, &fa);
>  			mnt_drop_write_file(file);
> +			if (err == -EOPNOTSUPP)
> +				err = -ENOIOCTLCMD;
>  		}
>  	}
>  	return err;
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index 6f0e15f86c21..096d44712bb1 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -721,7 +721,7 @@ int ovl_real_fileattr_get(const struct path *realpath, struct fileattr *fa)
>  		return err;
>  
>  	err = vfs_fileattr_get(realpath->dentry, fa);
> -	if (err == -ENOIOCTLCMD)
> +	if (err == -EOPNOTSUPP)
>  		err = -ENOTTY;
>  	return err;
>  }
> 
> -- 
> 2.47.2
> 
> 
> -- 
> - Andrey

Ignore please, sorry, wrong in-reply-to

-- 
- Andrey


