Return-Path: <linux-arch+bounces-11896-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D362AB389C
	for <lists+linux-arch@lfdr.de>; Mon, 12 May 2025 15:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8C137A279B
	for <lists+linux-arch@lfdr.de>; Mon, 12 May 2025 13:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5912957B5;
	Mon, 12 May 2025 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OfaL87gB"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F439292912
	for <linux-arch@vger.kernel.org>; Mon, 12 May 2025 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747055971; cv=none; b=t9fsuikLSWOVwc+XlivEqdxNNU7M4lK0U40o7dEj+rr2VqTVxU2MDO13NzbrD/5fDglTHSXbXGujeRFUoHYridZhrQCbkvK51/SW9Uoaqf0hPhMkNElAEVPIHhhY83xNLlNRr1AHJwFP/pKsyFgRJMqjXyB42NnDWU2DbiMqDGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747055971; c=relaxed/simple;
	bh=EE7KRw5zpeu2NPRaS4FGB5R9ATQBOE/dVjbJqb/tg1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U+KDX3xwMIzd63gQvQito9a4QvQwvqD6D/m5RhJa9y9XZMZKE86CVujOyze9EJ/XZJrj354dWMRESonr+SYChkF+eB7/Wmp2k5ZuhaPLt3jYppswcKiqlWNGq4PUpdt+fGEo0FI6OcliIHkQpbZID7VK7yrj91luIBLFjcloTKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OfaL87gB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747055966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9zdzYFU67QL/yrQjWemjUC5iC/W3DMR3kub6Fg2erUY=;
	b=OfaL87gBz6maLcgGEvPQroXnsOPUDETFHd7vPBwdbFEd8ksmc0KvpnBkv2VJG0axUv3E0+
	jnYpEoMjhPFL+nrIlBEM19CtSyebyV2Capgfa6AVFgaC+sxD4+jB2c+s/jvMEb49FmWKMu
	XTDKm8FCspjIadrWGvoZTlWvU684yRk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-c-7POcR7MQOPdrqvurPJGQ-1; Mon, 12 May 2025 09:19:23 -0400
X-MC-Unique: c-7POcR7MQOPdrqvurPJGQ-1
X-Mimecast-MFC-AGG-ID: c-7POcR7MQOPdrqvurPJGQ_1747055962
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-acbbb00099eso413930866b.2
        for <linux-arch@vger.kernel.org>; Mon, 12 May 2025 06:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747055962; x=1747660762;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zdzYFU67QL/yrQjWemjUC5iC/W3DMR3kub6Fg2erUY=;
        b=UKXuEMa9CR/lDiAri46ZnYqKMqQVmguW+MeC6jHux7PU7kOfvOwgpVUnC7pAJU3Vsf
         JpA6BdnmJ9O2FON+QRnWOkO4JSDHZsy8JRdwGn+1xSEvpd3O+z/ioSjBN/yNzNIMPZRN
         wN6/BszxoMfwmIaP1iMnE/Bxl8qYceNZvO8ska8akiOZaDz43mMOb213P24Fsru7/ytq
         kgSbX/6f48k+kqESLZm1RLDV3nw68JmdeGwMRx7k05zIGLwSpv36AhmrYcapaN/+d3ux
         CiNOmt+/RX5HHM3lAPcP1Kk7JSXHfzlf80au6ZxKu20USK3uApWdXwXn4MOerDV64hHw
         hxfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTUMOs7e/lF02e3zaFSE+822b3d4IBgVN2ePwWntWgUBqlYDttZ/FEyu8O2kV9TR1CEhnwc/ImNeAX@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Rc2qdNGBN8YOGXhUMq8XwC4Oo78UcH9LnZUM/jIB8SR092JK
	6TOw3IL2MstGoFojrJwgW1GkOK2CjMTWvm5XrhfbLpFx6zlhpjSr4fXfWwYHmfDJVKkLZv5cy3M
	54ayr7NI1sGFwfXzvrrGafYWFTPus7w5t33BWgt7qfA5TXH+2nc9RZAqOnA==
X-Gm-Gg: ASbGnctLmmtYyJKDv11MIqEuKZzK/j92+HzaRFo6i1f3Ck54bgmdtGVR93XDXZ6pDr/
	XrAm4G1L4PaNT0/Gnqf3lRpaBNPRNC9fZUnVMa69QjHl6bTPSRCLOUn6N+wbTKnNMGSbn5QXGuk
	0PpkV9+/tJpcb8VYgNOTCriExef3QnPxZX2JhiocdT0aot8gLXbOV/5sNDZXzGjZXI0LYILKLgD
	/Ug+NT9zYqI5eT/EvVRM1/hXSrTtNYWORTVSCbzu6FoqHBbF+BJs7TixIrmKs0QZxAIEYcB23rC
	+AEVPGLmEq4gzQ3NPpDJ4GY+yXs=
X-Received: by 2002:a17:907:a0ca:b0:ad2:15c4:e251 with SMTP id a640c23a62f3a-ad218fe426emr1343611966b.24.1747055962362;
        Mon, 12 May 2025 06:19:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFR/z7VDwfPtY8RsgAeuRrfPYWT/NcxxNpELBaV6FMBaH3fzY01enrQOOWsy73GCPQ9UU83A==
X-Received: by 2002:a17:907:a0ca:b0:ad2:15c4:e251 with SMTP id a640c23a62f3a-ad218fe426emr1343605466b.24.1747055961884;
        Mon, 12 May 2025 06:19:21 -0700 (PDT)
Received: from [127.0.0.1] (109-92-26-237.static.isp.telekom.rs. [109.92.26.237])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2197bde09sm612328766b.125.2025.05.12.06.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 06:19:21 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 12 May 2025 15:18:55 +0200
Subject: [PATCH v5 2/7] lsm: introduce new hooks for setting/getting inode
 fsxattr
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250512-xattrat-syscall-v5-2-a88b20e37aae@kernel.org>
References: <20250512-xattrat-syscall-v5-0-a88b20e37aae@kernel.org>
In-Reply-To: <20250512-xattrat-syscall-v5-0-a88b20e37aae@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
 selinux@vger.kernel.org, ecryptfs@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5194; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=EE7KRw5zpeu2NPRaS4FGB5R9ATQBOE/dVjbJqb/tg1Q=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMhS/+u+a2qTr//H1X+175RWTuif9Vdgzuygzeult4
 xbu8myDe0c6SlkYxLgYZMUUWdZJa01NKpLKP2JQIw8zh5UJZAgDF6cATORvOsP/wLccOxWuLrOQ
 taiM5tdRk110NOf2mQ//vXRO/8r/omD7l+F/vkEV77MDx1v28j7RO6TdzCm3fdruwNUJ5afPuf+
 8kH+WFwBp50vr
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

Introduce new hooks for setting and getting filesystem extended
attributes on inode (FS_IOC_FSGETXATTR).

Cc: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/file_attr.c                | 19 ++++++++++++++++---
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      | 16 ++++++++++++++++
 security/security.c           | 30 ++++++++++++++++++++++++++++++
 4 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 2910b7047721..be62d97cc444 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -76,10 +76,15 @@ EXPORT_SYMBOL(fileattr_fill_flags);
 int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
+	int error;
 
 	if (!inode->i_op->fileattr_get)
 		return -ENOIOCTLCMD;
 
+	error = security_inode_file_getattr(dentry, fa);
+	if (error)
+		return error;
+
 	return inode->i_op->fileattr_get(dentry, fa);
 }
 EXPORT_SYMBOL(vfs_fileattr_get);
@@ -242,12 +247,20 @@ int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
 		} else {
 			fa->flags |= old_ma.flags & ~FS_COMMON_FL;
 		}
+
 		err = fileattr_set_prepare(inode, &old_ma, fa);
-		if (!err)
-			err = inode->i_op->fileattr_set(idmap, dentry, fa);
+		if (err)
+			goto out;
+		err = security_inode_file_setattr(dentry, fa);
+		if (err)
+			goto out;
+		err = inode->i_op->fileattr_set(idmap, dentry, fa);
+		if (err)
+			goto out;
 	}
+
+out:
 	inode_unlock(inode);
-
 	return err;
 }
 EXPORT_SYMBOL(vfs_fileattr_set);
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index bf3bbac4e02a..9600a4350e79 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -157,6 +157,8 @@ LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *name)
 LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dentry,
 	 const char *name)
+LSM_HOOK(int, 0, inode_file_setattr, struct dentry *dentry, struct fileattr *fa)
+LSM_HOOK(int, 0, inode_file_getattr, struct dentry *dentry, struct fileattr *fa)
 LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
 LSM_HOOK(void, LSM_RET_VOID, inode_post_set_acl, struct dentry *dentry,
diff --git a/include/linux/security.h b/include/linux/security.h
index cc9b54d95d22..d2da2f654345 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -451,6 +451,10 @@ int security_inode_listxattr(struct dentry *dentry);
 int security_inode_removexattr(struct mnt_idmap *idmap,
 			       struct dentry *dentry, const char *name);
 void security_inode_post_removexattr(struct dentry *dentry, const char *name);
+int security_inode_file_setattr(struct dentry *dentry,
+			      struct fileattr *fa);
+int security_inode_file_getattr(struct dentry *dentry,
+			      struct fileattr *fa);
 int security_inode_need_killpriv(struct dentry *dentry);
 int security_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry);
 int security_inode_getsecurity(struct mnt_idmap *idmap,
@@ -1053,6 +1057,18 @@ static inline void security_inode_post_removexattr(struct dentry *dentry,
 						   const char *name)
 { }
 
+static inline int security_inode_file_setattr(struct dentry *dentry,
+					      struct fileattr *fa)
+{
+	return 0;
+}
+
+static inline int security_inode_file_getattr(struct dentry *dentry,
+					      struct fileattr *fa)
+{
+	return 0;
+}
+
 static inline int security_inode_need_killpriv(struct dentry *dentry)
 {
 	return cap_inode_need_killpriv(dentry);
diff --git a/security/security.c b/security/security.c
index fb57e8fddd91..09c891e6027d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2622,6 +2622,36 @@ void security_inode_post_removexattr(struct dentry *dentry, const char *name)
 	call_void_hook(inode_post_removexattr, dentry, name);
 }
 
+/**
+ * security_inode_file_setattr() - check if setting fsxattr is allowed
+ * @dentry: file to set filesystem extended attributes on
+ * @fa: extended attributes to set on the inode
+ *
+ * Called when file_setattr() syscall or FS_IOC_FSSETXATTR ioctl() is called on
+ * inode
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_inode_file_setattr(struct dentry *dentry, struct fileattr *fa)
+{
+	return call_int_hook(inode_file_setattr, dentry, fa);
+}
+
+/**
+ * security_inode_file_getattr() - check if retrieving fsxattr is allowed
+ * @dentry: file to retrieve filesystem extended attributes from
+ * @fa: extended attributes to get
+ *
+ * Called when file_getattr() syscall or FS_IOC_FSGETXATTR ioctl() is called on
+ * inode
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_inode_file_getattr(struct dentry *dentry, struct fileattr *fa)
+{
+	return call_int_hook(inode_file_getattr, dentry, fa);
+}
+
 /**
  * security_inode_need_killpriv() - Check if security_inode_killpriv() required
  * @dentry: associated dentry

-- 
2.47.2


