Return-Path: <linux-arch+bounces-165-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9AA7E8EB8
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 07:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1E71C2042E
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 06:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883255252;
	Sun, 12 Nov 2023 06:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNp1V4JK"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D58A5235
	for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 06:18:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7A1C43397;
	Sun, 12 Nov 2023 06:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699769904;
	bh=lBeUMNOs/hGCqxEibPqpp7A9oyHUvY+MVkAUbSUv13Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VNp1V4JKQmXTYAc0Y6hZletG3bC2go9bi1V3CwPXQKsEJUXdISnUT+ruGjB/Ep4zZ
	 7K7aV6siUkCR35ommO3wCoA/a/nwHaLFyj+rNTd901lQ4B2d/KzxBtT2AHWLg4i8QV
	 5YaIePrBO6KZEc7chitzVbk3GMqw/3bveniKMb7LiVllgtYcFqA/a65QsAH0qxi0NU
	 ZFF90/reQLudz5ayCxUn/+nCLIQTiKaycu5uzJBHvLW2x52P7O9ZPQoQFwDkPpRqFC
	 OgIwdxKZxU/TnAk0VRnWy3Mm1cqrdlmTV6VNIPXVejRniT0xgCHWvFyZ6qrEJKOAZE
	 L7YW5UuCr3bag==
From: guoren@kernel.org
To: arnd@arndb.de,
	guoren@kernel.org,
	palmer@rivosinc.com,
	tglx@linutronix.de,
	conor.dooley@microchip.com,
	heiko@sntech.de,
	apatel@ventanamicro.com,
	atishp@atishpatra.org,
	bjorn@kernel.org,
	paul.walmsley@sifive.com,
	anup@brainfault.org,
	jiawei@iscas.ac.cn,
	liweiwei@iscas.ac.cn,
	wefu@redhat.com,
	U2FsdGVkX1@gmail.com,
	wangjunqiang@iscas.ac.cn,
	kito.cheng@sifive.com,
	andy.chiu@sifive.com,
	vincent.chen@sifive.com,
	greentime.hu@sifive.com,
	wuwei2016@iscas.ac.cn,
	jrtc27@jrtc27.com,
	luto@kernel.org,
	fweimer@redhat.com,
	catalin.marinas@arm.com,
	hjl.tools@gmail.com
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH V2 29/38] riscv: s64ilp32: Introduce ARCH_HAS_64ILP32_KERNEL for syscall
Date: Sun, 12 Nov 2023 01:15:05 -0500
Message-Id: <20231112061514.2306187-30-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231112061514.2306187-1-guoren@kernel.org>
References: <20231112061514.2306187-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

When the kernel is built with ILP32 memory model on 64bit ISA and
supports ILP32 memory model on 32bit ISA in userspace, the ABIs are
different between kernel and userspace, similar to COMPAT, so the option
converts the 64-bit arguments of 32ILP32 syscalls to 64ILP32 calling
convention.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/Kconfig             | 10 ++++++++++
 arch/riscv/Kconfig       |  1 +
 fs/open.c                | 22 ++++++++++++++++++++++
 fs/read_write.c          | 17 +++++++++++++++++
 fs/sync.c                | 22 ++++++++++++++++++++++
 include/linux/syscalls.h | 35 +++++++++++++++++++++++++----------
 mm/fadvise.c             | 24 ++++++++++++++++++++++++
 7 files changed, 121 insertions(+), 10 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index aff2746c8af2..a77764d581cc 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1479,6 +1479,16 @@ config ARCH_HAS_NONLEAF_PMD_YOUNG
 	  address translations. Page table walkers that clear the accessed bit
 	  may use this capability to reduce their search space.
 
+config ARCH_HAS_64ILP32_KERNEL
+	bool
+	depends on 32BIT
+	help
+          Architectures that select this option build the kernel with the ILP32 memory
+	  model and support the ILP32 memory model on 32bit ISA in userspace, the ABIs
+	  are different between kernel and userspace, similar to COMPAT, so the option
+	  converts the 64-bit arguments of 32ILP32 syscalls to 64ILP32 calling
+	  convention.
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 57b98f1990b3..5106eab17811 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -345,6 +345,7 @@ config ARCH_RV64ILP32
 	select 32BIT
 	select MMU
 	select VDSO64ILP32
+	select ARCH_HAS_64ILP32_KERNEL
 
 endchoice
 
diff --git a/fs/open.c b/fs/open.c
index 0c55c8e7f837..533938e11536 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -214,6 +214,17 @@ COMPAT_SYSCALL_DEFINE2(ftruncate, unsigned int, fd, compat_ulong_t, length)
 
 /* LFS versions of truncate are only needed on 32 bit machines */
 #if BITS_PER_LONG == 32
+#ifdef CONFIG_ARCH_HAS_64ILP32_KERNEL
+SYSCALL_DEFINE3(truncate64, const char __user *, path, compat_arg_u64_dual(length))
+{
+	return do_sys_truncate(path, compat_arg_u64_glue(length));
+}
+
+SYSCALL_DEFINE3(ftruncate64, unsigned int, fd, compat_arg_u64_dual(length))
+{
+	return do_sys_ftruncate(fd, compat_arg_u64_glue(length), 0);
+}
+#else
 SYSCALL_DEFINE2(truncate64, const char __user *, path, loff_t, length)
 {
 	return do_sys_truncate(path, length);
@@ -223,6 +234,7 @@ SYSCALL_DEFINE2(ftruncate64, unsigned int, fd, loff_t, length)
 {
 	return do_sys_ftruncate(fd, length, 0);
 }
+#endif
 #endif /* BITS_PER_LONG == 32 */
 
 #if defined(CONFIG_COMPAT) && defined(__ARCH_WANT_COMPAT_TRUNCATE64)
@@ -350,10 +362,20 @@ int ksys_fallocate(int fd, int mode, loff_t offset, loff_t len)
 	return error;
 }
 
+#ifdef CONFIG_ARCH_HAS_64ILP32_KERNEL
+SYSCALL_DEFINE6(fallocate, int, fd, int, mode,
+		compat_arg_u64_dual(offset),
+		compat_arg_u64_dual(len))
+{
+	return ksys_fallocate(fd, mode, compat_arg_u64_glue(offset),
+					compat_arg_u64_glue(len));
+}
+#else
 SYSCALL_DEFINE4(fallocate, int, fd, int, mode, loff_t, offset, loff_t, len)
 {
 	return ksys_fallocate(fd, mode, offset, len);
 }
+#endif
 
 #if defined(CONFIG_COMPAT) && defined(__ARCH_WANT_COMPAT_FALLOCATE)
 COMPAT_SYSCALL_DEFINE6(fallocate, int, fd, int, mode, compat_arg_u64_dual(offset),
diff --git a/fs/read_write.c b/fs/read_write.c
index b07de77ef126..f6d90d52dec9 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -669,11 +669,19 @@ ssize_t ksys_pread64(unsigned int fd, char __user *buf, size_t count,
 	return ret;
 }
 
+#ifdef CONFIG_ARCH_HAS_64ILP32_KERNEL
+SYSCALL_DEFINE5(pread64, unsigned int, fd, char __user *, buf,
+			size_t, count, compat_arg_u64_dual(pos))
+{
+	return ksys_pread64(fd, buf, count, compat_arg_u64_glue(pos));
+}
+#else
 SYSCALL_DEFINE4(pread64, unsigned int, fd, char __user *, buf,
 			size_t, count, loff_t, pos)
 {
 	return ksys_pread64(fd, buf, count, pos);
 }
+#endif
 
 #if defined(CONFIG_COMPAT) && defined(__ARCH_WANT_COMPAT_PREAD64)
 COMPAT_SYSCALL_DEFINE5(pread64, unsigned int, fd, char __user *, buf,
@@ -703,11 +711,20 @@ ssize_t ksys_pwrite64(unsigned int fd, const char __user *buf,
 	return ret;
 }
 
+#ifdef CONFIG_ARCH_HAS_64ILP32_KERNEL
+SYSCALL_DEFINE5(pwrite64, unsigned int, fd, const char __user *, buf,
+			 size_t, count, compat_arg_u64_dual(pos))
+{
+	return ksys_pwrite64(fd, buf, count, compat_arg_u64_glue(pos));
+}
+
+#else
 SYSCALL_DEFINE4(pwrite64, unsigned int, fd, const char __user *, buf,
 			 size_t, count, loff_t, pos)
 {
 	return ksys_pwrite64(fd, buf, count, pos);
 }
+#endif
 
 #if defined(CONFIG_COMPAT) && defined(__ARCH_WANT_COMPAT_PWRITE64)
 COMPAT_SYSCALL_DEFINE5(pwrite64, unsigned int, fd, const char __user *, buf,
diff --git a/fs/sync.c b/fs/sync.c
index dc725914e1ed..d25c95d13d96 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -367,11 +367,22 @@ int ksys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
 	return ret;
 }
 
+#ifdef CONFIG_ARCH_HAS_64ILP32_KERNEL
+SYSCALL_DEFINE6(sync_file_range, int, fd,
+				compat_arg_u64_dual(offset),
+				compat_arg_u64_dual(nbytes),
+				unsigned int, flags)
+{
+	return ksys_sync_file_range(fd, compat_arg_u64_glue(offset),
+					compat_arg_u64_glue(nbytes), flags);
+}
+#else
 SYSCALL_DEFINE4(sync_file_range, int, fd, loff_t, offset, loff_t, nbytes,
 				unsigned int, flags)
 {
 	return ksys_sync_file_range(fd, offset, nbytes, flags);
 }
+#endif
 
 #if defined(CONFIG_COMPAT) && defined(__ARCH_WANT_COMPAT_SYNC_FILE_RANGE)
 COMPAT_SYSCALL_DEFINE6(sync_file_range, int, fd, compat_arg_u64_dual(offset),
@@ -384,8 +395,19 @@ COMPAT_SYSCALL_DEFINE6(sync_file_range, int, fd, compat_arg_u64_dual(offset),
 
 /* It would be nice if people remember that not all the world's an i386
    when they introduce new system calls */
+#ifdef CONFIG_ARCH_HAS_64ILP32_KERNEL
+SYSCALL_DEFINE6(sync_file_range2, int, fd, unsigned int, flags,
+				compat_arg_u64_dual(offset),
+				compat_arg_u64_dual(nbytes))
+{
+	return ksys_sync_file_range(fd, compat_arg_u64_glue(offset),
+					compat_arg_u64_glue(nbytes),
+					flags);
+}
+#else
 SYSCALL_DEFINE4(sync_file_range2, int, fd, unsigned int, flags,
 				 loff_t, offset, loff_t, nbytes)
 {
 	return ksys_sync_file_range(fd, offset, nbytes, flags);
 }
+#endif
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 03e3d0121d5e..b559b0e676a9 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -313,6 +313,13 @@ static inline void addr_limit_user_check(void)
  * include the prototypes if CONFIG_ARCH_HAS_SYSCALL_WRAPPER is enabled.
  */
 #ifndef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
+
+#ifdef CONFIG_ARCH_HAS_64ILP32_KERNEL
+#define arg_loff_t(name)	compat_arg_u64(name)
+#else
+#define arg_loff_t(name)	loff_t  name
+#endif
+
 asmlinkage long sys_io_setup(unsigned nr_reqs, aio_context_t __user *ctx);
 asmlinkage long sys_io_destroy(aio_context_t ctx);
 asmlinkage long sys_io_submit(aio_context_t, long,
@@ -427,10 +434,11 @@ asmlinkage long sys_fstatfs64(unsigned int fd, size_t sz,
 asmlinkage long sys_truncate(const char __user *path, long length);
 asmlinkage long sys_ftruncate(unsigned int fd, unsigned long length);
 #if BITS_PER_LONG == 32
-asmlinkage long sys_truncate64(const char __user *path, loff_t length);
-asmlinkage long sys_ftruncate64(unsigned int fd, loff_t length);
+asmlinkage long sys_truncate64(const char __user *path, arg_loff_t(length));
+asmlinkage long sys_ftruncate64(unsigned int fd, arg_loff_t(length));
 #endif
-asmlinkage long sys_fallocate(int fd, int mode, loff_t offset, loff_t len);
+asmlinkage long sys_fallocate(int fd, int mode, arg_loff_t(offset),
+						arg_loff_t(len));
 asmlinkage long sys_faccessat(int dfd, const char __user *filename, int mode);
 asmlinkage long sys_faccessat2(int dfd, const char __user *filename, int mode,
 			       int flags);
@@ -474,9 +482,9 @@ asmlinkage long sys_writev(unsigned long fd,
 			   const struct iovec __user *vec,
 			   unsigned long vlen);
 asmlinkage long sys_pread64(unsigned int fd, char __user *buf,
-			    size_t count, loff_t pos);
+			    size_t count, arg_loff_t(pos));
 asmlinkage long sys_pwrite64(unsigned int fd, const char __user *buf,
-			     size_t count, loff_t pos);
+			     size_t count, arg_loff_t(pos));
 asmlinkage long sys_preadv(unsigned long fd, const struct iovec __user *vec,
 			   unsigned long vlen, unsigned long pos_l, unsigned long pos_h);
 asmlinkage long sys_pwritev(unsigned long fd, const struct iovec __user *vec,
@@ -516,9 +524,13 @@ asmlinkage long sys_sync(void);
 asmlinkage long sys_fsync(unsigned int fd);
 asmlinkage long sys_fdatasync(unsigned int fd);
 asmlinkage long sys_sync_file_range2(int fd, unsigned int flags,
-				     loff_t offset, loff_t nbytes);
-asmlinkage long sys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
-					unsigned int flags);
+				     arg_loff_t(offset),
+				     arg_loff_t(nbytes));
+asmlinkage long sys_sync_file_range(int fd,
+				    arg_loff_t(offset),
+				    arg_loff_t(nbytes),
+				    unsigned int flags);
+
 asmlinkage long sys_timerfd_create(int clockid, int flags);
 asmlinkage long sys_timerfd_settime(int ufd, int flags,
 				    const struct __kernel_itimerspec __user *utmr,
@@ -795,7 +807,10 @@ asmlinkage long sys_clone3(struct clone_args __user *uargs, size_t size);
 asmlinkage long sys_execve(const char __user *filename,
 		const char __user *const __user *argv,
 		const char __user *const __user *envp);
-asmlinkage long sys_fadvise64_64(int fd, loff_t offset, loff_t len, int advice);
+asmlinkage long sys_fadvise64_64(int fd,
+				 arg_loff_t(offset),
+				 arg_loff_t(len),
+				 int advice);
 
 /* CONFIG_MMU only */
 asmlinkage long sys_swapon(const char __user *specialfile, int swap_flags);
@@ -1023,7 +1038,7 @@ asmlinkage long sys_newstat(const char __user *filename,
 				struct stat __user *statbuf);
 asmlinkage long sys_newlstat(const char __user *filename,
 				struct stat __user *statbuf);
-asmlinkage long sys_fadvise64(int fd, loff_t offset, size_t len, int advice);
+asmlinkage long sys_fadvise64(int fd, arg_loff_t(offset), size_t len, int advice);
 
 /* __ARCH_WANT_SYSCALL_DEPRECATED */
 asmlinkage long sys_alarm(unsigned int seconds);
diff --git a/mm/fadvise.c b/mm/fadvise.c
index 6c39d42f16dc..0f56cbe8496b 100644
--- a/mm/fadvise.c
+++ b/mm/fadvise.c
@@ -202,18 +202,42 @@ int ksys_fadvise64_64(int fd, loff_t offset, loff_t len, int advice)
 	return ret;
 }
 
+#ifdef CONFIG_ARCH_HAS_64ILP32_KERNEL
+
+SYSCALL_DEFINE6(fadvise64_64, int, fd, compat_arg_u64_dual(offset),
+		       compat_arg_u64_dual(len), int, advice)
+{
+	return ksys_fadvise64_64(fd, compat_arg_u64_glue(offset),
+				 compat_arg_u64_glue(len), advice);
+}
+
+#else
+
 SYSCALL_DEFINE4(fadvise64_64, int, fd, loff_t, offset, loff_t, len, int, advice)
 {
 	return ksys_fadvise64_64(fd, offset, len, advice);
 }
 
+#endif
+
 #ifdef __ARCH_WANT_SYS_FADVISE64
 
+#ifdef CONFIG_ARCH_HAS_64ILP32_KERNEL
+
+SYSCALL_DEFINE5(fadvise64, int, fd, loff_t, compat_arg_u64_dual(offset),
+			size_t, len, int, advice)
+{
+	return ksys_fadvise64_64(fd, compat_arg_u64_glue(offset), len, advice);
+}
+
+#else
+
 SYSCALL_DEFINE4(fadvise64, int, fd, loff_t, offset, size_t, len, int, advice)
 {
 	return ksys_fadvise64_64(fd, offset, len, advice);
 }
 
+#endif
 #endif
 
 #if defined(CONFIG_COMPAT) && defined(__ARCH_WANT_COMPAT_FADVISE64_64)
-- 
2.36.1


