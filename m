Return-Path: <linux-arch+bounces-11917-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833FFAB4F8C
	for <lists+linux-arch@lfdr.de>; Tue, 13 May 2025 11:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCD143B260D
	for <lists+linux-arch@lfdr.de>; Tue, 13 May 2025 09:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B65E213E61;
	Tue, 13 May 2025 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uvps3OOM"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C154C2222C9
	for <linux-arch@vger.kernel.org>; Tue, 13 May 2025 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747127928; cv=none; b=s8lEwzslLJW9JVQCf15SBIS6t3YTqgGi6fnl7hGdNxoTruzNw3M4fjwekJgXh3R4TjtHz2j7Xt6cPkgOZWZlHB4WJPlp6pbZmDmSS86FFEB74auPAtM1xiQKtiOH+44jD4xpPoxHNNhiIT06SUXEjVQ5NkdLtCPoDSs5LOqdiSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747127928; c=relaxed/simple;
	bh=Mia1bN9eufb3RXyVeuoVbbxF0ymp/knX5VaozIUqEjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GXuhMXcQNUaL+RepyoZu/wpP5i9cTUDleXoUUZvPPDYNU9YkT8gC0awJKK4mkPEryQFkHOR17DpT7XCrgJex4t7X9TatbRQQlaXotkCoaka94rFMctR0tAZZWsIjRqGZcljnIVyDzzNuYy0IAqM/jRvjEJxgbsdsZj7WJ/Lrtv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uvps3OOM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747127916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bcl+kZS6mFiE1wsAKkd2DJwYRwWXFkHCZUkRMeOzSpo=;
	b=Uvps3OOMqD3itpK5vxXyekuBa6Mn8pHDTWk3yZ8155SlrEWhXWo8zPXXfEQyRZsYaOz2XG
	j3o3adtarVcp+eUutJs8fHq99BBIpprU4ETN4agjY97cxnPPnbGTZMrnF95WzHgZRVjY20
	boZ97WFFdJ1HE0s6ltXhWB4rYiEr9i0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-InRzwN4iPnSXuweyeItwZQ-1; Tue, 13 May 2025 05:18:32 -0400
X-MC-Unique: InRzwN4iPnSXuweyeItwZQ-1
X-Mimecast-MFC-AGG-ID: InRzwN4iPnSXuweyeItwZQ_1747127911
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43efa869b0aso40166735e9.3
        for <linux-arch@vger.kernel.org>; Tue, 13 May 2025 02:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747127911; x=1747732711;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bcl+kZS6mFiE1wsAKkd2DJwYRwWXFkHCZUkRMeOzSpo=;
        b=CTi7zQ/sNj/4ftCOcfWxCl5w95Bpt488N4qPHHzBUC9gjFKLtlJXttj6zzgEUCGSQl
         Gbr90GSi/AhsdnINUi7Y8xvvbJPMUe8/kK2kZ4m36LDiezr1rqpGWzjnJHVU1/u2yMEZ
         cpNjpQs8m5+Zo41Y5Zetyz8oD/+7ZYhCYXQnCwtDk0SWLJsflWprKPDb+GuRNntuKw0f
         EimEztJQq0/VRuT/vXiTbxxIQ9Q5CX0yO8jLF3LrTWj7b/fO5PQbBDPIZKYy1PUjRw4b
         EXryYipDdrnh4qQI+jwQP4z0uIaJi3G7BYn9G8fA2LJtmXgaoUmcdle+HHBroe6C0Yed
         t37A==
X-Forwarded-Encrypted: i=1; AJvYcCV4jZ3zi1X+PmBl2yLvytnYnOEVNWYZT72Y7MSDQku4YW0rFEdpoqSTFJHnb0sSBJe/KT+dt4DMlXXF@vger.kernel.org
X-Gm-Message-State: AOJu0YwyS6p7X/8YyIJyyRySxXaqBfh7HEsTVys6l13AvB4kqW632QVH
	GfF4M+epEplbNrGN+Y5tLJZRooNgT/nup9TBOxByDE0O34j0cbdUq57xbShejGuMFNydvR2T/IJ
	ejpVT6vXNPXeCrzmD9z0VcdvLLAH0b1C6i3vBcuOPMaTIZUOBnhK6R0Kt+g==
X-Gm-Gg: ASbGnctyLkbr5465+FK9YjVU4rnLc5742+4JS+M3PgENI7Rtm3YuzUZkX7PX/z5NTfF
	sDeMTC3G2OO7ZaXOKg0W3/5sMgYPpRs5t+5GG29SdVEOs6sy5pXG6mgYN92XceQoThUqBwTRqwZ
	Ffon6+rqlJ+KA2EsspbXBHZSgDY5XbQvNM9OFPzH2N4K/JbJ1ZgaQKrmvX+3PE1dJj5krBrryl1
	N29gcmc1SRcl+GhEITVR3z+vAOBAHRVPDNkF9uXQ7QWCMVG+U1FOwxSU9x7zmAZdHE9TneKFPBH
	0pCVyZ6cd9xBZewgcsumyqzxYKPfqENeOYepGSq2raoVQO4=
X-Received: by 2002:a05:600c:6487:b0:43c:e70d:44f0 with SMTP id 5b1f17b1804b1-442d6d516efmr151085625e9.19.1747127910837;
        Tue, 13 May 2025 02:18:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnyzrm9Ien0HpYmMjVN4TJc2CwxGJx7XTbAEX+5KbU06PX2NgfS3fPS2A63BWK6Dk9wq8Y/w==
X-Received: by 2002:a05:600c:6487:b0:43c:e70d:44f0 with SMTP id 5b1f17b1804b1-442d6d516efmr151084915e9.19.1747127910301;
        Tue, 13 May 2025 02:18:30 -0700 (PDT)
Received: from [127.0.0.2] (109-92-26-237.static.isp.telekom.rs. [109.92.26.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442ed666dc7sm12345655e9.18.2025.05.13.02.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 02:18:29 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Tue, 13 May 2025 11:18:00 +0200
Subject: [PATCH v5 7/7] fs: introduce file_getattr and file_setattr
 syscalls
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250513-xattrat-syscall-v5-7-22bb9c6c767f@kernel.org>
References: <20250513-xattrat-syscall-v5-0-22bb9c6c767f@kernel.org>
In-Reply-To: <20250513-xattrat-syscall-v5-0-22bb9c6c767f@kernel.org>
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
 Andrey Albershteyn <aalbersh@redhat.com>, 
 Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=16327; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=awxLkgMEWWl9qWLy5HjROs2HQUw87mCuZEl/Dhy79+Y=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMpT5vLnjuIO1/mxvbtsnHrp2xV93xs7Hnw4+SJhxw
 SsmcnMRH1tHKQuDGBeDrJgiyzppralJRVL5Rwxq5GHmsDKBDGHg4hSAifByM/wPSBR5nGL49ov4
 0/Ler/NcmcJsb5z6pbE+X5rPMmnDhW+TGf77p9fsy2/L8RVbeaLyyCeRnrdsSqWrvGaEbaw8s1b
 g+HdmAD4SRq0=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: Andrey Albershteyn <aalbersh@redhat.com>

Introduce file_getattr and file_setattr syscalls to manipulate inode
extended attributes/flags. The syscalls take parent directory fd and
path to the child together with struct fsxattr.

This is an alternative to FS_IOC_FSSETXATTR ioctl with a difference
that file don't need to be open as we can reference it with a path
instead of fd. By having this we can manipulated inode extended
attributes not only on regular files but also on special ones. This
is not possible with FS_IOC_FSSETXATTR ioctl as with special files
we can not call ioctl() directly on the filesystem inode using fd.

This patch adds two new syscalls which allows userspace to get/set
extended inode attributes on special files by using parent directory
and a path - *at() like syscall.

CC: linux-api@vger.kernel.org
CC: linux-fsdevel@vger.kernel.org
CC: linux-xfs@vger.kernel.org
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/kernel/syscalls/syscall.tbl      |   2 +
 arch/arm/tools/syscall.tbl                  |   2 +
 arch/arm64/tools/syscall_32.tbl             |   2 +
 arch/m68k/kernel/syscalls/syscall.tbl       |   2 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   2 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   2 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   2 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |   2 +
 arch/parisc/kernel/syscalls/syscall.tbl     |   2 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |   2 +
 arch/s390/kernel/syscalls/syscall.tbl       |   2 +
 arch/sh/kernel/syscalls/syscall.tbl         |   2 +
 arch/sparc/kernel/syscalls/syscall.tbl      |   2 +
 arch/x86/entry/syscalls/syscall_32.tbl      |   2 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   2 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   2 +
 fs/file_attr.c                              | 119 ++++++++++++++++++++++++++++
 include/linux/syscalls.h                    |   6 ++
 include/uapi/asm-generic/unistd.h           |   8 +-
 include/uapi/linux/fs.h                     |   3 +
 20 files changed, 167 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 2dd6340de6b4efddc406f0c235701c15cf02f650..16dca28ebf17e5df2230f640f3686835dc5a1f76 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -507,3 +507,5 @@
 575	common	listxattrat			sys_listxattrat
 576	common	removexattrat			sys_removexattrat
 577	common	open_tree_attr			sys_open_tree_attr
+578	common	file_getattr			sys_file_getattr
+579	common	file_setattr			sys_file_setattr
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 27c1d5ebcd91c8c296dc6676307f66bfdf4ab78d..b07e699aaa3c2840452109c0004529fc68e153ac 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -482,3 +482,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr
diff --git a/arch/arm64/tools/syscall_32.tbl b/arch/arm64/tools/syscall_32.tbl
index 0765b3a8d6d600d7b9f83182d401d9f80c03476c..8d9088bc577df0c6dba6d5d0c227585283789a3f 100644
--- a/arch/arm64/tools/syscall_32.tbl
+++ b/arch/arm64/tools/syscall_32.tbl
@@ -479,3 +479,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 9fe47112c586f152662af38a9a7f90957cb96cf8..f41d38dfbf1382339316f4e3e6e79c75dc2804ec 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -467,3 +467,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 7b6e97828e552d4da90046ddfcd4a55723e522bb..580af574fe733af29ea69f40ae6e902ad2166ab2 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -473,3 +473,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index aa70e371bb54ab5d9c8dd8923b6ecf9693ee914d..d824ffe9a01496a13194710d5278dcc443e40894 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -406,3 +406,5 @@
 465	n32	listxattrat			sys_listxattrat
 466	n32	removexattrat			sys_removexattrat
 467	n32	open_tree_attr			sys_open_tree_attr
+468	n32	file_getattr			sys_file_getattr
+469	n32	file_setattr			sys_file_setattr
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 1e8c44c7b61492eabf00c777831e457a7a6e579c..7a7049c2c307885fe8be33aedb503cfe8afbfb24 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -382,3 +382,5 @@
 465	n64	listxattrat			sys_listxattrat
 466	n64	removexattrat			sys_removexattrat
 467	n64	open_tree_attr			sys_open_tree_attr
+468	n64	file_getattr			sys_file_getattr
+469	n64	file_setattr			sys_file_setattr
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 114a5a1a62302e32dd74d1679ff423a2d57c3c6b..d330274f06010c9f9bf80d55898d0bd38994ef58 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -455,3 +455,5 @@
 465	o32	listxattrat			sys_listxattrat
 466	o32	removexattrat			sys_removexattrat
 467	o32	open_tree_attr			sys_open_tree_attr
+468	o32	file_getattr			sys_file_getattr
+469	o32	file_setattr			sys_file_setattr
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 94df3cb957e9d547d192e8732c0cf23ef2b5ce5d..88a788a7b18d17967019098b33d2be48a430aed3 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -466,3 +466,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 9a084bdb892694bc562f514b55212d167cbac12f..b453e80dfc003796a08f022f6bd44cf76a5f82ab 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -558,3 +558,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index a4569b96ef06c54ce7aa795d039541c90a38284f..8a6744d658db3986f0ac0fd3c90592cdbd27249c 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -470,3 +470,5 @@
 465  common	listxattrat		sys_listxattrat			sys_listxattrat
 466  common	removexattrat		sys_removexattrat		sys_removexattrat
 467  common	open_tree_attr		sys_open_tree_attr		sys_open_tree_attr
+468  common	file_getattr		sys_file_getattr		sys_file_getattr
+469  common	file_setattr		sys_file_setattr		sys_file_setattr
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 52a7652fcff6394b96ace1f3b0ed72250ee5e669..5e9c9eff5539e24113bb757f1e5b51bd7c32864e 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -471,3 +471,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 83e45eb6c095a36baaf749927628e6052fe900e6..ebb7d06d1044fa9b113b0a3fe0316c77f48fc3d0 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -513,3 +513,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index ac007ea00979dc28b0ef7c002a0615ce86dd3101..4877e16da69a50f2225088e556661051dbe3c7a3 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -473,3 +473,5 @@
 465	i386	listxattrat		sys_listxattrat
 466	i386	removexattrat		sys_removexattrat
 467	i386	open_tree_attr		sys_open_tree_attr
+468	i386	file_getattr		sys_file_getattr
+469	i386	file_setattr		sys_file_setattr
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index cfb5ca41e30de1a4e073750096f5b51a2ec137d2..92cf0fe2291eb99b536e4de4201aec16b3472094 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -391,6 +391,8 @@
 465	common	listxattrat		sys_listxattrat
 466	common	removexattrat		sys_removexattrat
 467	common	open_tree_attr		sys_open_tree_attr
+468	common	file_getattr		sys_file_getattr
+469	common	file_setattr		sys_file_setattr
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index f657a77314f8667fa019a01e10c84ea270024adc..374e4cb788d8a6d4e1f3358b949ea8b600013e1c 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -438,3 +438,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr
diff --git a/fs/file_attr.c b/fs/file_attr.c
index 6cd1e820f7b108c12c06654df843104f460b94cf..791a97bb2b612b2a0f2c06b7cfb41bac469ea5d1 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -3,6 +3,10 @@
 #include <linux/security.h>
 #include <linux/fscrypt.h>
 #include <linux/fileattr.h>
+#include <linux/syscalls.h>
+#include <linux/namei.h>
+
+#include "internal.h"
 
 /**
  * fileattr_fill_xflags - initialize fileattr with xflags
@@ -354,3 +358,118 @@ int ioctl_fssetxattr(struct file *file, void __user *argp)
 	return err;
 }
 EXPORT_SYMBOL(ioctl_fssetxattr);
+
+SYSCALL_DEFINE5(file_getattr, int, dfd, const char __user *, filename,
+		struct fsxattr __user *, ufsx, size_t, usize,
+		unsigned int, at_flags)
+{
+	struct fileattr fa = {};
+	struct path filepath __free(path_put) = {};
+	int error;
+	unsigned int lookup_flags = 0;
+	struct filename *name;
+	struct fsxattr fsx = {};
+
+	BUILD_BUG_ON(sizeof(struct fsxattr) < FSXATTR_SIZE_VER0);
+	BUILD_BUG_ON(sizeof(struct fsxattr) != FSXATTR_SIZE_LATEST);
+
+	if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
+		return -EINVAL;
+
+	if (!(at_flags & AT_SYMLINK_NOFOLLOW))
+		lookup_flags |= LOOKUP_FOLLOW;
+
+	if (usize > PAGE_SIZE)
+		return -E2BIG;
+
+	if (usize < FSXATTR_SIZE_VER0)
+		return -EINVAL;
+
+	name = getname_maybe_null(filename, at_flags);
+	if (IS_ERR(name))
+		return PTR_ERR(name);
+
+	if (!name && dfd >= 0) {
+		CLASS(fd, f)(dfd);
+
+		filepath = fd_file(f)->f_path;
+		path_get(&filepath);
+	} else {
+		error = filename_lookup(dfd, name, lookup_flags, &filepath,
+					NULL);
+		putname(name);
+		if (error)
+			return error;
+	}
+
+	error = vfs_fileattr_get(filepath.dentry, &fa);
+	if (error)
+		return error;
+
+	fileattr_to_fsxattr(&fa, &fsx);
+	error = copy_struct_to_user(ufsx, usize, &fsx, sizeof(struct fsxattr),
+				    NULL);
+
+	return error;
+}
+
+SYSCALL_DEFINE5(file_setattr, int, dfd, const char __user *, filename,
+		struct fsxattr __user *, ufsx, size_t, usize,
+		unsigned int, at_flags)
+{
+	struct fileattr fa;
+	struct path filepath __free(path_put) = {};
+	int error;
+	unsigned int lookup_flags = 0;
+	struct filename *name;
+	struct fsxattr fsx = {};
+
+	BUILD_BUG_ON(sizeof(struct fsxattr) < FSXATTR_SIZE_VER0);
+	BUILD_BUG_ON(sizeof(struct fsxattr) != FSXATTR_SIZE_LATEST);
+
+	if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
+		return -EINVAL;
+
+	if (!(at_flags & AT_SYMLINK_NOFOLLOW))
+		lookup_flags |= LOOKUP_FOLLOW;
+
+	if (usize > PAGE_SIZE)
+		return -E2BIG;
+
+	if (usize < FSXATTR_SIZE_VER0)
+		return -EINVAL;
+
+	error = copy_struct_from_user(&fsx, sizeof(struct fsxattr), ufsx, usize);
+	if (error)
+		return error;
+
+	error = fsxattr_to_fileattr(&fsx, &fa);
+	if (error)
+		return error;
+
+	name = getname_maybe_null(filename, at_flags);
+	if (IS_ERR(name))
+		return PTR_ERR(name);
+
+	if (!name && dfd >= 0) {
+		CLASS(fd, f)(dfd);
+
+		filepath = fd_file(f)->f_path;
+		path_get(&filepath);
+	} else {
+		error = filename_lookup(dfd, name, lookup_flags, &filepath,
+					NULL);
+		putname(name);
+		if (error)
+			return error;
+	}
+
+	error = mnt_want_write(filepath.mnt);
+	if (!error) {
+		error = vfs_fileattr_set(mnt_idmap(filepath.mnt),
+					 filepath.dentry, &fa);
+		mnt_drop_write(filepath.mnt);
+	}
+
+	return error;
+}
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e5603cc91963dabb79324d6e9e2274f327311245..f2a747479718f9c93f6a448cdab2e60f7ee87709 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -371,6 +371,12 @@ asmlinkage long sys_removexattrat(int dfd, const char __user *path,
 asmlinkage long sys_lremovexattr(const char __user *path,
 				 const char __user *name);
 asmlinkage long sys_fremovexattr(int fd, const char __user *name);
+asmlinkage long sys_file_getattr(int dfd, const char __user *filename,
+				 struct fsxattr __user *ufsx, size_t usize,
+				 unsigned int at_flags);
+asmlinkage long sys_file_setattr(int dfd, const char __user *filename,
+				 struct fsxattr __user *ufsx, size_t usize,
+				 unsigned int at_flags);
 asmlinkage long sys_getcwd(char __user *buf, unsigned long size);
 asmlinkage long sys_eventfd2(unsigned int count, int flags);
 asmlinkage long sys_epoll_create1(int flags);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 2892a45023af6d3eb941623d4fed04841ab07e02..04e0077fb4c97a4d565da86d3d0d1d243f32336e 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -852,8 +852,14 @@ __SYSCALL(__NR_removexattrat, sys_removexattrat)
 #define __NR_open_tree_attr 467
 __SYSCALL(__NR_open_tree_attr, sys_open_tree_attr)
 
+/* fs/inode.c */
+#define __NR_file_getattr 468
+__SYSCALL(__NR_file_getattr, sys_file_getattr)
+#define __NR_file_setattr 469
+__SYSCALL(__NR_file_setattr, sys_file_setattr)
+
 #undef __NR_syscalls
-#define __NR_syscalls 468
+#define __NR_syscalls 470
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index e762e1af650c4bf08766ba7a8ab7a2288e987039..bc1467b44b80e1db3527dd1b70f1a3a3ca7e4484 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -148,6 +148,9 @@ struct fsxattr {
 	unsigned char	fsx_pad[8];
 };
 
+#define FSXATTR_SIZE_VER0 28
+#define FSXATTR_SIZE_LATEST FSXATTR_SIZE_VER0
+
 /*
  * Flags for the fsx_xflags field
  */

-- 
2.47.2


