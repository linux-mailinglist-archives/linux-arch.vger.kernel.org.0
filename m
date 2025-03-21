Return-Path: <linux-arch+bounces-11040-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B02A6C539
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 22:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94C087A36EC
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 21:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A758F231A2B;
	Fri, 21 Mar 2025 21:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fIRjMm4y"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B241F099D
	for <linux-arch@vger.kernel.org>; Fri, 21 Mar 2025 21:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742592750; cv=none; b=HP3olebD5+L57xD8du0QD7GlY8BblJOvVPl2UcDIs7mtHqt5zDcUZUAi2KlpYHoqm2u0bUSGF/wCZcT4LsYBAjM/M3qKN58x3HXvMP4GwKjDW0uNCO8ZG7yHqHPQkR0/rsc6UzcKvuSAmvwyj4I25OYA+1sa6+f1CJfq+rW/GMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742592750; c=relaxed/simple;
	bh=yG1Qzi6F+aGsBMpdWaT175/M25TWqxBfzW0aBc2Mby8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=GKUO6Yce7eec4EALQ7LkJfBU5YiucK0MzVvQLeSLISdHFIf1ludixa6bVjRrBA94t5V3TRWaF5H2fDVdI6uY6Up8BiqIWjU/UF4b57Aq2VxXSY2QNHBE1kgOaco4PNCdHEAplu/deXtnCMjBiVn0/XH4pPncmxAxaGQ9sXIygXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fIRjMm4y; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4767b3f8899so35811901cf.0
        for <linux-arch@vger.kernel.org>; Fri, 21 Mar 2025 14:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1742592747; x=1743197547; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WkEW7se4kA9gakYYehbVu1ZGmOR39c99GGBG3Q74ESA=;
        b=fIRjMm4y38rt6rR4EiVKrVqg8BgTJNJQzyxdGM3k4y0k9FWSEYB11GkLVZzJlOJC6P
         LYoP8Lc8BN7MqvRpg1M6uwz5/HCvBNBnnUPff9qC9ZraQOsQ5GUQEawk8nwSJ2R7w19Z
         Sk01Pvd8sjpeKYJJxvykAYmwnre5DsbtRyrfPhzlWJPMAhta6i64rgRDiNja4KVmxnVP
         rzhGnDTCiEHE+V04jIUKueIyxF6Gr30GDSoRcl/LOSRTXDBhiSsLptTCSi6lTO7cgJdu
         3HHzCXJxe7cd89ONE4gDisu7v9DNNUwILVxBToovN+8GcAfKKh+8f8rSbRrLTA/ycUPn
         SCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742592747; x=1743197547;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WkEW7se4kA9gakYYehbVu1ZGmOR39c99GGBG3Q74ESA=;
        b=Nx0BnYhFYxYCWcIc7W9iqZui/NorLnNxIr7BdxZnQkbYvrTnm+yTDN2dda9O0tD8BN
         CAzvo6MU2FTFTzwioDN/Ho7iFQuqme9b2cmE05VbxA6Gwdz4B5elcZK+gpmpFfQzGIXJ
         5/ooAEG7FSBBTrP3HO31fcto2VeiwBo06Z95sfM0yAlMyCHUYP6tjvoZ0GiOIlsqbBMI
         sNICF27SPMJC4MRr1FLfMswFQrmht1ao6PeRSoHmrZweabK/IVFPu868iQWVVlchegrm
         BMtYg3wKnoAOiohC9CJrAD0j79y4Dd7nTSdtIonCSLOAaUKiaI9jsRB9ZbVomKrLNnEP
         UM9A==
X-Forwarded-Encrypted: i=1; AJvYcCWxDjmUPmimGmp8rI4U1FiPRJdhUVEswG6Az/H2un7RafjImUG5PuTd+WqhRUPdsNIGswXKzi1ib0L4@vger.kernel.org
X-Gm-Message-State: AOJu0YymIC86H+W+rlYrwPiEkGOn6uov5bRoLzQFNxmO2SjkNPbrvA5Y
	giRVSgzI6xjtosk41dKuNE1dggRhBnPdbWOkUNUVXAqsp1t2Sdt/n9NqOZ2HNQ==
X-Gm-Gg: ASbGncsKo7vbTkV8M+2hvc65nyc5V/fSoX8W5N2vYF63EIeG4WcXbbz76NuPAb3e415
	xrMNXqsLjueYvAe8KMgz+vgl+H3eZeHsyGcmRO80QnxMRIWtrw6Tglc20O+E7hG34KqJ4ZqA0Z4
	7uNu6A0dU17+jhPkOnNo1AyMVTif4TE1+URV8JRd8dkAA1/u59V0VnDx2329Odk4IJCoRF9F3zn
	yCF63kKtuuiXC7KMtUb0GWbfNqwojpO8uH3LbDz3p8QFWkoMuEMDvuL7vBV1zUBeuXcBcXa9GCt
	H82ju+1mvLtcaOEjcnzch4HDH14AyFaTqd4bzUmMqdOdeRvPa62lLsbZlHSw5TmViyNKuLKDbtB
	3WocFMoZlCVzUjA==
X-Google-Smtp-Source: AGHT+IEqvMs9f3zdHkqatEuHHMLq+Pp1CGQwo1N+6m68HBYAt0XjQifVPk3cXxCHJ8EdFG+VR82ouA==
X-Received: by 2002:a05:622a:1f98:b0:471:fef5:ee84 with SMTP id d75a77b69052e-4771d924e1emr70292591cf.7.1742592746683;
        Fri, 21 Mar 2025 14:32:26 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4771d64d5f6sm16343541cf.81.2025.03.21.14.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 14:32:26 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:32:25 -0400
Message-ID: <e2d5b27847fde03e0b4b9fc7a464fd87@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250320_1749/pstg-lib:20250320_2248/pstg-pwork:20250320_1749
From: Paul Moore <paul@paul-moore.com>
To: Andrey Albershteyn <aalbersh@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, selinux@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v4 1/3] lsm: introduce new hooks for setting/getting inode  fsxattr
References: <20250321-xattrat-syscall-v4-1-3e82e6fb3264@kernel.org>
In-Reply-To: <20250321-xattrat-syscall-v4-1-3e82e6fb3264@kernel.org>

On Mar 21, 2025 Andrey Albershteyn <aalbersh@redhat.com> wrote:
> 
> Introduce new hooks for setting and getting filesystem extended
> attributes on inode (FS_IOC_FSGETXATTR).
> 
> Cc: selinux@vger.kernel.org
> Cc: Paul Moore <paul@paul-moore.com>
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/ioctl.c                    |  7 ++++++-
>  include/linux/lsm_hook_defs.h |  4 ++++
>  include/linux/security.h      | 16 ++++++++++++++++
>  security/security.c           | 32 ++++++++++++++++++++++++++++++++
>  4 files changed, 58 insertions(+), 1 deletion(-)

Thanks Andrey, one small change below, but otherwise this looks pretty
good.  If you feel like trying to work up the SELinux implementation but
need some assitance please let me know, I'll be happy to help :)

> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 638a36be31c14afc66a7fd6eb237d9545e8ad997..4434c97bc5dff5a3e8635e28745cd99404ff353e 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -525,10 +525,15 @@ EXPORT_SYMBOL(fileattr_fill_flags);
>  int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
>  {
>  	struct inode *inode = d_inode(dentry);
> +	int error;
>  
>  	if (!inode->i_op->fileattr_get)
>  		return -ENOIOCTLCMD;
>  
> +	error = security_inode_getfsxattr(inode, fa);
> +	if (error)
> +		return error;
> +
>  	return inode->i_op->fileattr_get(dentry, fa);
>  }
>  EXPORT_SYMBOL(vfs_fileattr_get);
> @@ -692,7 +697,7 @@ int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
>  			fa->flags |= old_ma.flags & ~FS_COMMON_FL;
>  		}
>  		err = fileattr_set_prepare(inode, &old_ma, fa);
> -		if (!err)
> +		if (!err && !security_inode_setfsxattr(inode, fa))
>  			err = inode->i_op->fileattr_set(idmap, dentry, fa);
>  	}
>  	inode_unlock(inode);

I don't believe we want to hide or otherwise drop the LSM return code as
that could lead to odd behavior, e.g. returning 0/success despite not
having executed the fileattr_set operation.

--
paul-moore.com

