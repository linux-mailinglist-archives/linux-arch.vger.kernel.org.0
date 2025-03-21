Return-Path: <linux-arch+bounces-11027-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37721A6C39A
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 20:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36CEE7A7D30
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 19:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1831522F3B8;
	Fri, 21 Mar 2025 19:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0IkaepE"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C283322DFA6
	for <linux-arch@vger.kernel.org>; Fri, 21 Mar 2025 19:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742586560; cv=none; b=GJhWzU8mMcb9HnUm3DpnaplXa95SVlnxss1YcksWnMuwW91b3FUBW2olfsK3UMBg/lIZ2x0CLHD0Z6pZziIfyZYf9k4rvGQu2MuTgeSKuf2e77L6rWmbnrwqncAe2HLe31L6AipNYxSibo81D7NjjqOJUKUsTF/go5ENMEW5+uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742586560; c=relaxed/simple;
	bh=+3PgL9e4pv3f6MCfYCBirhxZEuafw6SW80EvQcMyAKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hi4aWISQgKmTclE3SWU1HZ9kP9Vt6Ixo+TC2hX1494x8z19frhEBZkVn4OVHuZjOb9WlAnE+/rKEScvfwK3yzUvqoJyWcNiN0ar3LEqnz1ijCMWAMW2iFZm4ex7isBdVUfXrRoKnFmL5TwgCTk+Ju7xIruB12peiAjeye90c4Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y0IkaepE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742586556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sKu7K/L6aAgGXW9lSjE2s1++uZO1hHM3Uy8OChu+Qg0=;
	b=Y0IkaepEinUwV2mhwAcVUhyHJrpmGJoEZYK+5i04JjMmuAZB8A96KqpHc7LsnFm6F5JyPh
	oSRcC9gmuqlEpHkUMXfsjyD0JYT7JsCogIJhVDXEX2Pcg8yluy0+2mV1Y8fu1kVf06b2Dc
	DIDBII9KfaR7dTUmsJSzR9gqYv6suuM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-TwSvhUUONcu2MMgnxlX_Eg-1; Fri, 21 Mar 2025 15:49:14 -0400
X-MC-Unique: TwSvhUUONcu2MMgnxlX_Eg-1
X-Mimecast-MFC-AGG-ID: TwSvhUUONcu2MMgnxlX_Eg_1742586553
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac27f00a8a5so181665666b.3
        for <linux-arch@vger.kernel.org>; Fri, 21 Mar 2025 12:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742586553; x=1743191353;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKu7K/L6aAgGXW9lSjE2s1++uZO1hHM3Uy8OChu+Qg0=;
        b=TYmKKczoNOrXt2EXoNNY9QBV50YozKAjm3QNE6/W8r+J4yVYtnDsu7f12TA/SBfflR
         qV8ISUuDb8Xg86VdqbhSBQ9po65sVcwFoOUkm5SuGSRKT6yhHHLkfgcMhBehjwuKW1lG
         JUXgPsGQYoZWMazAUDp4iOHLxRRCCVBBEgM8WRGnY95LfmGNwfIs0W3m2/lRA2CVwnM5
         pIocqbyfh5L+j8tOZDJJrBJeOoOXAH4vCZF4ugvN5ScBKhiJrPog9wjkSeod0O2ptYun
         eravHYDy4tLXx6OKHlB3T9ux6PgXoA6futpjRMRxjerhXfmTDOZGFWuI9hcAz0MwjVB+
         +ITQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+JOAduYgoEANTZ/tg67WgiRcBL+VsKMIknuv/2omCy7uuK4CDnw60v4Pwiy5l+0oeJ/992chiJgS2@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmao06dTushTxArIUy8xhFE0LhNMMBJPILw9jUjl94J6tGguGG
	PmriWMiDg/WoN1ijHUXDb6+KpN8yNfvimR80uv+5S8RiwZyjWy2vIkZ4t+Iy4vfxM0SXfKUDRtM
	oaU3qJPEkRBFSdQh/ucM5T5Gz2Ru5/PBeBZJzc1JjBLjp5LSFqL0yWGNpjg==
X-Gm-Gg: ASbGncuhmnwkQ4XG0cCmSSqOtaQ23tsmX5fR71+MNuwdaCPLn1oqO3krKkNrLFK2eIv
	jC9zXXhrbEo+4SXRvufQnNjzaOWAn2t2cVyXzg2UwwCjfLkgY2oTNa9NyKRRg8RBoiItNSa4uQn
	A7n1BEisLNjpv+h6Wqjwk629CBGLdZYJXjxpq22lX/K3alcfSlR3YGhNM9kJJ8XoQmjeNKrvydY
	qaki14jlx1tOcQM8Xl9QK4trom14JwMCFJRthiWDnlxtLzzzcLPrmKhvRYXjbte6fAxa1xAdx8Q
	ColhMCIuQwel4TxHBvcrS1IW9o/W9I2/0hViJiqdyg==
X-Received: by 2002:a17:906:c111:b0:ac3:17d3:eba1 with SMTP id a640c23a62f3a-ac3f20b04d9mr442077266b.9.1742586553005;
        Fri, 21 Mar 2025 12:49:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTcWGXZFGLvLNSApjQmfZCT80qQ9P9pa9GSOScyG8GRTDGLhsdL5pTYdHkyK/vdXMP8DguIA==
X-Received: by 2002:a17:906:c111:b0:ac3:17d3:eba1 with SMTP id a640c23a62f3a-ac3f20b04d9mr442069766b.9.1742586552438;
        Fri, 21 Mar 2025 12:49:12 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8d3d38sm204412266b.39.2025.03.21.12.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 12:49:08 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Fri, 21 Mar 2025 20:48:40 +0100
Subject: [PATCH v4 1/3] lsm: introduce new hooks for setting/getting inode
 fsxattr
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-xattrat-syscall-v4-1-3e82e6fb3264@kernel.org>
References: <20250321-xattrat-syscall-v4-0-3e82e6fb3264@kernel.org>
In-Reply-To: <20250321-xattrat-syscall-v4-0-3e82e6fb3264@kernel.org>
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
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
 selinux@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5252; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=+3PgL9e4pv3f6MCfYCBirhxZEuafw6SW80EvQcMyAKc=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIY0u8e2mDyP3iXzIzGyzyvts0333f0+anqT8z+Zx9d2
 93ObXZz4Sv2jlIWBjEuBlkxRZZ10lpTk4qk8o8Y1MjDzGFlAhnCwMUpABPhyGL477dAsfnKfw52
 rX2BV01C9n1oPuplfSp/RlXO7GNcbLIv0hkZrsSafJ+9Wc1t76Ty8u6CijnM972f5zPMuZ6mnXI
 teNdtXgA8MUuQ
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

Introduce new hooks for setting and getting filesystem extended
attributes on inode (FS_IOC_FSGETXATTR).

Cc: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/ioctl.c                    |  7 ++++++-
 include/linux/lsm_hook_defs.h |  4 ++++
 include/linux/security.h      | 16 ++++++++++++++++
 security/security.c           | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 638a36be31c14afc66a7fd6eb237d9545e8ad997..4434c97bc5dff5a3e8635e28745cd99404ff353e 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -525,10 +525,15 @@ EXPORT_SYMBOL(fileattr_fill_flags);
 int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
+	int error;
 
 	if (!inode->i_op->fileattr_get)
 		return -ENOIOCTLCMD;
 
+	error = security_inode_getfsxattr(inode, fa);
+	if (error)
+		return error;
+
 	return inode->i_op->fileattr_get(dentry, fa);
 }
 EXPORT_SYMBOL(vfs_fileattr_get);
@@ -692,7 +697,7 @@ int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
 			fa->flags |= old_ma.flags & ~FS_COMMON_FL;
 		}
 		err = fileattr_set_prepare(inode, &old_ma, fa);
-		if (!err)
+		if (!err && !security_inode_setfsxattr(inode, fa))
 			err = inode->i_op->fileattr_set(idmap, dentry, fa);
 	}
 	inode_unlock(inode);
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index eb2937599cb029004f491012b3bf5a3d6d2731df..49e64d23e9049568af133bf3f30ca719c9ec5f25 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -157,6 +157,10 @@ LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *name)
 LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dentry,
 	 const char *name)
+LSM_HOOK(int, 0, inode_setfsxattr, const struct inode *inode,
+	 const struct fileattr *fa)
+LSM_HOOK(int, 0, inode_getfsxattr, const struct inode *inode,
+	 const struct fileattr *fa)
 LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
 LSM_HOOK(void, LSM_RET_VOID, inode_post_set_acl, struct dentry *dentry,
diff --git a/include/linux/security.h b/include/linux/security.h
index cbdba435b798660130779d6919388779edd41d54..dd58ace29c6e325ee49470596d0abb6ecc38ba07 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -439,6 +439,10 @@ int security_inode_listxattr(struct dentry *dentry);
 int security_inode_removexattr(struct mnt_idmap *idmap,
 			       struct dentry *dentry, const char *name);
 void security_inode_post_removexattr(struct dentry *dentry, const char *name);
+int security_inode_setfsxattr(const struct inode *inode,
+			      const struct fileattr *fa);
+int security_inode_getfsxattr(const struct inode *inode,
+			      const struct fileattr *fa);
 int security_inode_need_killpriv(struct dentry *dentry);
 int security_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry);
 int security_inode_getsecurity(struct mnt_idmap *idmap,
@@ -1042,6 +1046,18 @@ static inline void security_inode_post_removexattr(struct dentry *dentry,
 						   const char *name)
 { }
 
+static inline int security_inode_setfsxattr(const struct inode *inode,
+					    const struct fileattr *fa)
+{
+	return 0;
+}
+
+static inline int security_inode_getfsxattr(const struct inode *inode,
+					    const struct fileattr *fa)
+{
+	return 0;
+}
+
 static inline int security_inode_need_killpriv(struct dentry *dentry)
 {
 	return cap_inode_need_killpriv(dentry);
diff --git a/security/security.c b/security/security.c
index 09664e09fec9a1d502a23847aa2e87a6d19837db..d3b527f55ed52209d8e22c05adf278b164374d35 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2617,6 +2617,38 @@ void security_inode_post_removexattr(struct dentry *dentry, const char *name)
 	call_void_hook(inode_post_removexattr, dentry, name);
 }
 
+/**
+ * security_inode_setfsxattr() - check if setting fsxattr is allowed
+ * @inode: inode to set filesystem extended attributes on
+ * @fa: extended attributes to set on the inode
+ *
+ * Called when setfsxattrat() syscall or FS_IOC_FSSETXATTR ioctl() is called on
+ * inode
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_inode_setfsxattr(const struct inode *inode,
+			      const struct fileattr *fa)
+{
+	return call_int_hook(inode_setfsxattr, inode, fa);
+}
+
+/**
+ * security_inode_getfsxattr() - check if retrieving fsxattr is allowed
+ * @inode: inode to retrieve filesystem extended attributes from
+ * @fa: extended attributes to get
+ *
+ * Called when getfsxattrat() syscall or FS_IOC_FSGETXATTR ioctl() is called on
+ * inode
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_inode_getfsxattr(const struct inode *inode,
+			      const struct fileattr *fa)
+{
+	return call_int_hook(inode_getfsxattr, inode, fa);
+}
+
 /**
  * security_inode_need_killpriv() - Check if security_inode_killpriv() required
  * @dentry: associated dentry

-- 
2.47.2


