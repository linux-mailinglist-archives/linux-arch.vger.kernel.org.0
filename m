Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDC273929D
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 00:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjFUWhE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jun 2023 18:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjFUWhD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2023 18:37:03 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C91193;
        Wed, 21 Jun 2023 15:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687387019; x=1718923019;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jwLa2waIn89Pp4Nx3gf3hMa3j5x+fkKMq+MjmrTUAjQ=;
  b=f89eRxBow4N7p6EHbW5BLYhvEyqi4hff/WbilZVM+Ge0Kpu4xZUnxQdO
   A9RxMvJ+LidC+hr6nPDiLMQxJ7rps7d/O5HY2pd0xXlF3RTjk6fo5OhUt
   LtBJWknf9k3OJXT5MFT463He40U/6Uijan8ediIk7JY9qcO96uYXq0Zln
   YdqechD5QsRjPYJtntr+9n9YiSlIO0bZHdP4d2w/Uz7oOWDebqEMZwgP9
   12wgCVrIyNzQDJygIYCFPNfElSFOrlUoC/Jjeq1xAZ3Gc1c9gNrUjrYWl
   u/lWSoaPxOqoAbTwSBeo+Vt6bLrQVOf0D1ZMTn9PwcLN2wNZaSzJ5vKm3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="357821580"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="357821580"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 15:36:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="827646421"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="827646421"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jun 2023 15:36:57 -0700
From:   Sohil Mehta <sohil.mehta@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, Sohil Mehta <sohil.mehta@intel.com>
Subject: [PATCH] syscalls: Remove file path comments from headers
Date:   Wed, 21 Jun 2023 22:36:00 +0000
Message-Id: <20230621223600.1348693-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e1a2665d-2e11-7722-a7ae-ef534829ed37@intel.com>
References: <e1a2665d-2e11-7722-a7ae-ef534829ed37@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Source file locations for syscall definitions can change over a period
of time. File paths in comments get stale and are hard to maintain long
term. Also, their usefulness is questionable since it would be easier to
locate a syscall definition using the SYSCALL_DEFINEx() macro.

Remove all source file path comments from the syscall headers. Also,
equalize the uneven line spacing (some of which is introduced due to the
deletions).

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 include/linux/compat.h                  |  82 ++------------
 include/linux/syscalls.h                | 140 +++---------------------
 include/uapi/asm-generic/unistd.h       | 129 +++++-----------------
 kernel/sys_ni.c                         | 110 +------------------
 tools/include/uapi/asm-generic/unistd.h | 129 +++++-----------------
 5 files changed, 85 insertions(+), 505 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 44b1736c95b5..1cfa4f0f490a 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -581,11 +581,7 @@ asmlinkage long compat_sys_io_pgetevents_time64(compat_aio_context_t ctx_id,
 					struct io_event __user *events,
 					struct __kernel_timespec __user *timeout,
 					const struct __compat_aio_sigset __user *usig);
-
-/* fs/cookies.c */
 asmlinkage long compat_sys_lookup_dcookie(u32, u32, char __user *, compat_size_t);
-
-/* fs/eventpoll.c */
 asmlinkage long compat_sys_epoll_pwait(int epfd,
 			struct epoll_event __user *events,
 			int maxevents, int timeout,
@@ -597,18 +593,12 @@ asmlinkage long compat_sys_epoll_pwait2(int epfd,
 			const struct __kernel_timespec __user *timeout,
 			const compat_sigset_t __user *sigmask,
 			compat_size_t sigsetsize);
-
-/* fs/fcntl.c */
 asmlinkage long compat_sys_fcntl(unsigned int fd, unsigned int cmd,
 				 compat_ulong_t arg);
 asmlinkage long compat_sys_fcntl64(unsigned int fd, unsigned int cmd,
 				   compat_ulong_t arg);
-
-/* fs/ioctl.c */
 asmlinkage long compat_sys_ioctl(unsigned int fd, unsigned int cmd,
 				 compat_ulong_t arg);
-
-/* fs/open.c */
 asmlinkage long compat_sys_statfs(const char __user *pathname,
 				  struct compat_statfs __user *buf);
 asmlinkage long compat_sys_statfs64(const char __user *pathname,
@@ -623,13 +613,9 @@ asmlinkage long compat_sys_ftruncate(unsigned int, compat_ulong_t);
 /* No generic prototype for truncate64, ftruncate64, fallocate */
 asmlinkage long compat_sys_openat(int dfd, const char __user *filename,
 				  int flags, umode_t mode);
-
-/* fs/readdir.c */
 asmlinkage long compat_sys_getdents(unsigned int fd,
 				    struct compat_linux_dirent __user *dirent,
 				    unsigned int count);
-
-/* fs/read_write.c */
 asmlinkage long compat_sys_lseek(unsigned int, compat_off_t, unsigned int);
 /* No generic prototype for pread64 and pwrite64 */
 asmlinkage ssize_t compat_sys_preadv(compat_ulong_t fd,
@@ -649,14 +635,10 @@ asmlinkage long compat_sys_pwritev64(unsigned long fd,
 		const struct iovec __user *vec,
 		unsigned long vlen, loff_t pos);
 #endif
-
-/* fs/sendfile.c */
 asmlinkage long compat_sys_sendfile(int out_fd, int in_fd,
 				    compat_off_t __user *offset, compat_size_t count);
 asmlinkage long compat_sys_sendfile64(int out_fd, int in_fd,
 				    compat_loff_t __user *offset, compat_size_t count);
-
-/* fs/select.c */
 asmlinkage long compat_sys_pselect6_time32(int n, compat_ulong_t __user *inp,
 				    compat_ulong_t __user *outp,
 				    compat_ulong_t __user *exp,
@@ -677,68 +659,45 @@ asmlinkage long compat_sys_ppoll_time64(struct pollfd __user *ufds,
 				 struct __kernel_timespec __user *tsp,
 				 const compat_sigset_t __user *sigmask,
 				 compat_size_t sigsetsize);
-
-/* fs/signalfd.c */
 asmlinkage long compat_sys_signalfd4(int ufd,
 				     const compat_sigset_t __user *sigmask,
 				     compat_size_t sigsetsize, int flags);
-
-/* fs/stat.c */
 asmlinkage long compat_sys_newfstatat(unsigned int dfd,
 				      const char __user *filename,
 				      struct compat_stat __user *statbuf,
 				      int flag);
 asmlinkage long compat_sys_newfstat(unsigned int fd,
 				    struct compat_stat __user *statbuf);
-
-/* fs/sync.c: No generic prototype for sync_file_range and sync_file_range2 */
-
-/* kernel/exit.c */
+/* No generic prototype for sync_file_range and sync_file_range2 */
 asmlinkage long compat_sys_waitid(int, compat_pid_t,
 		struct compat_siginfo __user *, int,
 		struct compat_rusage __user *);
-
-
-
-/* kernel/futex.c */
 asmlinkage long
 compat_sys_set_robust_list(struct compat_robust_list_head __user *head,
 			   compat_size_t len);
 asmlinkage long
 compat_sys_get_robust_list(int pid, compat_uptr_t __user *head_ptr,
 			   compat_size_t __user *len_ptr);
-
-/* kernel/itimer.c */
 asmlinkage long compat_sys_getitimer(int which,
 				     struct old_itimerval32 __user *it);
 asmlinkage long compat_sys_setitimer(int which,
 				     struct old_itimerval32 __user *in,
 				     struct old_itimerval32 __user *out);
-
-/* kernel/kexec.c */
 asmlinkage long compat_sys_kexec_load(compat_ulong_t entry,
 				      compat_ulong_t nr_segments,
 				      struct compat_kexec_segment __user *,
 				      compat_ulong_t flags);
-
-/* kernel/posix-timers.c */
 asmlinkage long compat_sys_timer_create(clockid_t which_clock,
 			struct compat_sigevent __user *timer_event_spec,
 			timer_t __user *created_timer_id);
-
-/* kernel/ptrace.c */
 asmlinkage long compat_sys_ptrace(compat_long_t request, compat_long_t pid,
 				  compat_long_t addr, compat_long_t data);
-
-/* kernel/sched/core.c */
 asmlinkage long compat_sys_sched_setaffinity(compat_pid_t pid,
 				     unsigned int len,
 				     compat_ulong_t __user *user_mask_ptr);
 asmlinkage long compat_sys_sched_getaffinity(compat_pid_t pid,
 				     unsigned int len,
 				     compat_ulong_t __user *user_mask_ptr);
-
-/* kernel/signal.c */
 asmlinkage long compat_sys_sigaltstack(const compat_stack_t __user *uss_ptr,
 				       compat_stack_t __user *uoss_ptr);
 asmlinkage long compat_sys_rt_sigsuspend(compat_sigset_t __user *unewset,
@@ -763,25 +722,17 @@ asmlinkage long compat_sys_rt_sigtimedwait_time64(compat_sigset_t __user *uthese
 asmlinkage long compat_sys_rt_sigqueueinfo(compat_pid_t pid, int sig,
 				struct compat_siginfo __user *uinfo);
 /* No generic prototype for rt_sigreturn */
-
-/* kernel/sys.c */
 asmlinkage long compat_sys_times(struct compat_tms __user *tbuf);
 asmlinkage long compat_sys_getrlimit(unsigned int resource,
 				     struct compat_rlimit __user *rlim);
 asmlinkage long compat_sys_setrlimit(unsigned int resource,
 				     struct compat_rlimit __user *rlim);
 asmlinkage long compat_sys_getrusage(int who, struct compat_rusage __user *ru);
-
-/* kernel/time.c */
 asmlinkage long compat_sys_gettimeofday(struct old_timeval32 __user *tv,
 		struct timezone __user *tz);
 asmlinkage long compat_sys_settimeofday(struct old_timeval32 __user *tv,
 		struct timezone __user *tz);
-
-/* kernel/timer.c */
 asmlinkage long compat_sys_sysinfo(struct compat_sysinfo __user *info);
-
-/* ipc/mqueue.c */
 asmlinkage long compat_sys_mq_open(const char __user *u_name,
 			int oflag, compat_mode_t mode,
 			struct compat_mq_attr __user *u_attr);
@@ -790,22 +741,14 @@ asmlinkage long compat_sys_mq_notify(mqd_t mqdes,
 asmlinkage long compat_sys_mq_getsetattr(mqd_t mqdes,
 			const struct compat_mq_attr __user *u_mqstat,
 			struct compat_mq_attr __user *u_omqstat);
-
-/* ipc/msg.c */
 asmlinkage long compat_sys_msgctl(int first, int second, void __user *uptr);
 asmlinkage long compat_sys_msgrcv(int msqid, compat_uptr_t msgp,
 		compat_ssize_t msgsz, compat_long_t msgtyp, int msgflg);
 asmlinkage long compat_sys_msgsnd(int msqid, compat_uptr_t msgp,
 		compat_ssize_t msgsz, int msgflg);
-
-/* ipc/sem.c */
 asmlinkage long compat_sys_semctl(int semid, int semnum, int cmd, int arg);
-
-/* ipc/shm.c */
 asmlinkage long compat_sys_shmctl(int first, int second, void __user *uptr);
 asmlinkage long compat_sys_shmat(int shmid, compat_uptr_t shmaddr, int shmflg);
-
-/* net/socket.c */
 asmlinkage long compat_sys_recvfrom(int fd, void __user *buf, compat_size_t len,
 			    unsigned flags, struct sockaddr __user *addr,
 			    int __user *addrlen);
@@ -813,20 +756,13 @@ asmlinkage long compat_sys_sendmsg(int fd, struct compat_msghdr __user *msg,
 				   unsigned flags);
 asmlinkage long compat_sys_recvmsg(int fd, struct compat_msghdr __user *msg,
 				   unsigned int flags);
-
-/* mm/filemap.c: No generic prototype for readahead */
-
-/* security/keys/keyctl.c */
+/* No generic prototype for readahead */
 asmlinkage long compat_sys_keyctl(u32 option,
 			      u32 arg2, u32 arg3, u32 arg4, u32 arg5);
-
-/* arch/example/kernel/sys_example.c */
 asmlinkage long compat_sys_execve(const char __user *filename, const compat_uptr_t __user *argv,
 		     const compat_uptr_t __user *envp);
-
-/* mm/fadvise.c: No generic prototype for fadvise64_64 */
-
-/* mm/, CONFIG_MMU only */
+/* No generic prototype for fadvise64_64 */
+/* CONFIG_MMU only */
 asmlinkage long compat_sys_rt_tgsigqueueinfo(compat_pid_t tgid,
 					compat_pid_t pid, int sig,
 					struct compat_siginfo __user *uinfo);
@@ -896,18 +832,18 @@ asmlinkage long compat_sys_ustat(unsigned dev, struct compat_ustat __user *u32);
 asmlinkage long compat_sys_recv(int fd, void __user *buf, compat_size_t len,
 				unsigned flags);
 
-/* obsolete: fs/readdir.c */
+/* obsolete */
 asmlinkage long compat_sys_old_readdir(unsigned int fd,
 				       struct compat_old_linux_dirent __user *,
 				       unsigned int count);
 
-/* obsolete: fs/select.c */
+/* obsolete */
 asmlinkage long compat_sys_old_select(struct compat_sel_arg_struct __user *arg);
 
-/* obsolete: ipc */
+/* obsolete */
 asmlinkage long compat_sys_ipc(u32, int, int, u32, compat_uptr_t, u32);
 
-/* obsolete: kernel/signal.c */
+/* obsolete */
 #ifdef __ARCH_WANT_SYS_SIGPENDING
 asmlinkage long compat_sys_sigpending(compat_old_sigset_t __user *set);
 #endif
@@ -922,7 +858,7 @@ asmlinkage long compat_sys_sigaction(int sig,
                                    struct compat_old_sigaction __user *oact);
 #endif
 
-/* obsolete: net/socket.c */
+/* obsolete */
 asmlinkage long compat_sys_socketcall(int call, u32 __user *args);
 
 #ifdef __ARCH_WANT_COMPAT_TRUNCATE64
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 33a0ee3bcb2e..8c37cf91c12d 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -346,8 +346,6 @@ asmlinkage long sys_io_uring_enter(unsigned int fd, u32 to_submit,
 				const void __user *argp, size_t argsz);
 asmlinkage long sys_io_uring_register(unsigned int fd, unsigned int op,
 				void __user *arg, unsigned int nr_args);
-
-/* fs/xattr.c */
 asmlinkage long sys_setxattr(const char __user *path, const char __user *name,
 			     const void __user *value, size_t size, int flags);
 asmlinkage long sys_lsetxattr(const char __user *path, const char __user *name,
@@ -370,17 +368,9 @@ asmlinkage long sys_removexattr(const char __user *path,
 asmlinkage long sys_lremovexattr(const char __user *path,
 				 const char __user *name);
 asmlinkage long sys_fremovexattr(int fd, const char __user *name);
-
-/* fs/dcache.c */
 asmlinkage long sys_getcwd(char __user *buf, unsigned long size);
-
-/* fs/cookies.c */
 asmlinkage long sys_lookup_dcookie(u64 cookie64, char __user *buf, size_t len);
-
-/* fs/eventfd.c */
 asmlinkage long sys_eventfd2(unsigned int count, int flags);
-
-/* fs/eventpoll.c */
 asmlinkage long sys_epoll_create1(int flags);
 asmlinkage long sys_epoll_ctl(int epfd, int op, int fd,
 				struct epoll_event __user *event);
@@ -393,8 +383,6 @@ asmlinkage long sys_epoll_pwait2(int epfd, struct epoll_event __user *events,
 				 const struct __kernel_timespec __user *timeout,
 				 const sigset_t __user *sigmask,
 				 size_t sigsetsize);
-
-/* fs/fcntl.c */
 asmlinkage long sys_dup(unsigned int fildes);
 asmlinkage long sys_dup3(unsigned int oldfd, unsigned int newfd, int flags);
 asmlinkage long sys_fcntl(unsigned int fd, unsigned int cmd, unsigned long arg);
@@ -402,25 +390,15 @@ asmlinkage long sys_fcntl(unsigned int fd, unsigned int cmd, unsigned long arg);
 asmlinkage long sys_fcntl64(unsigned int fd,
 				unsigned int cmd, unsigned long arg);
 #endif
-
-/* fs/inotify_user.c */
 asmlinkage long sys_inotify_init1(int flags);
 asmlinkage long sys_inotify_add_watch(int fd, const char __user *path,
 					u32 mask);
 asmlinkage long sys_inotify_rm_watch(int fd, __s32 wd);
-
-/* fs/ioctl.c */
 asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd,
 				unsigned long arg);
-
-/* fs/ioprio.c */
 asmlinkage long sys_ioprio_set(int which, int who, int ioprio);
 asmlinkage long sys_ioprio_get(int which, int who);
-
-/* fs/locks.c */
 asmlinkage long sys_flock(unsigned int fd, unsigned int cmd);
-
-/* fs/namei.c */
 asmlinkage long sys_mknodat(int dfd, const char __user * filename, umode_t mode,
 			    unsigned dev);
 asmlinkage long sys_mkdirat(int dfd, const char __user * pathname, umode_t mode);
@@ -431,18 +409,12 @@ asmlinkage long sys_linkat(int olddfd, const char __user *oldname,
 			   int newdfd, const char __user *newname, int flags);
 asmlinkage long sys_renameat(int olddfd, const char __user * oldname,
 			     int newdfd, const char __user * newname);
-
-/* fs/namespace.c */
 asmlinkage long sys_umount(char __user *name, int flags);
 asmlinkage long sys_mount(char __user *dev_name, char __user *dir_name,
 				char __user *type, unsigned long flags,
 				void __user *data);
 asmlinkage long sys_pivot_root(const char __user *new_root,
 				const char __user *put_old);
-
-/* fs/nfsctl.c */
-
-/* fs/open.c */
 asmlinkage long sys_statfs(const char __user * path,
 				struct statfs __user *buf);
 asmlinkage long sys_statfs64(const char __user *path, size_t sz,
@@ -477,22 +449,14 @@ asmlinkage long sys_close(unsigned int fd);
 asmlinkage long sys_close_range(unsigned int fd, unsigned int max_fd,
 				unsigned int flags);
 asmlinkage long sys_vhangup(void);
-
-/* fs/pipe.c */
 asmlinkage long sys_pipe2(int __user *fildes, int flags);
-
-/* fs/quota.c */
 asmlinkage long sys_quotactl(unsigned int cmd, const char __user *special,
 				qid_t id, void __user *addr);
 asmlinkage long sys_quotactl_fd(unsigned int fd, unsigned int cmd, qid_t id,
 				void __user *addr);
-
-/* fs/readdir.c */
 asmlinkage long sys_getdents64(unsigned int fd,
 				struct linux_dirent64 __user *dirent,
 				unsigned int count);
-
-/* fs/read_write.c */
 asmlinkage long sys_llseek(unsigned int fd, unsigned long offset_high,
 			unsigned long offset_low, loff_t __user *result,
 			unsigned int whence);
@@ -515,12 +479,8 @@ asmlinkage long sys_preadv(unsigned long fd, const struct iovec __user *vec,
 			   unsigned long vlen, unsigned long pos_l, unsigned long pos_h);
 asmlinkage long sys_pwritev(unsigned long fd, const struct iovec __user *vec,
 			    unsigned long vlen, unsigned long pos_l, unsigned long pos_h);
-
-/* fs/sendfile.c */
 asmlinkage long sys_sendfile64(int out_fd, int in_fd,
 			       loff_t __user *offset, size_t count);
-
-/* fs/select.c */
 asmlinkage long sys_pselect6(int, fd_set __user *, fd_set __user *,
 			     fd_set __user *, struct __kernel_timespec __user *,
 			     void __user *);
@@ -533,19 +493,13 @@ asmlinkage long sys_ppoll(struct pollfd __user *, unsigned int,
 asmlinkage long sys_ppoll_time32(struct pollfd __user *, unsigned int,
 			  struct old_timespec32 __user *, const sigset_t __user *,
 			  size_t);
-
-/* fs/signalfd.c */
 asmlinkage long sys_signalfd4(int ufd, sigset_t __user *user_mask, size_t sizemask, int flags);
-
-/* fs/splice.c */
 asmlinkage long sys_vmsplice(int fd, const struct iovec __user *iov,
 			     unsigned long nr_segs, unsigned int flags);
 asmlinkage long sys_splice(int fd_in, loff_t __user *off_in,
 			   int fd_out, loff_t __user *off_out,
 			   size_t len, unsigned int flags);
 asmlinkage long sys_tee(int fdin, int fdout, size_t len, unsigned int flags);
-
-/* fs/stat.c */
 asmlinkage long sys_readlinkat(int dfd, const char __user *path, char __user *buf,
 			       int bufsiz);
 asmlinkage long sys_newfstatat(int dfd, const char __user *filename,
@@ -556,8 +510,6 @@ asmlinkage long sys_fstat64(unsigned long fd, struct stat64 __user *statbuf);
 asmlinkage long sys_fstatat64(int dfd, const char __user *filename,
 			       struct stat64 __user *statbuf, int flag);
 #endif
-
-/* fs/sync.c */
 asmlinkage long sys_sync(void);
 asmlinkage long sys_fsync(unsigned int fd);
 asmlinkage long sys_fdatasync(unsigned int fd);
@@ -565,8 +517,6 @@ asmlinkage long sys_sync_file_range2(int fd, unsigned int flags,
 				     loff_t offset, loff_t nbytes);
 asmlinkage long sys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
 					unsigned int flags);
-
-/* fs/timerfd.c */
 asmlinkage long sys_timerfd_create(int clockid, int flags);
 asmlinkage long sys_timerfd_settime(int ufd, int flags,
 				    const struct __kernel_itimerspec __user *utmr,
@@ -577,39 +527,25 @@ asmlinkage long sys_timerfd_gettime32(int ufd,
 asmlinkage long sys_timerfd_settime32(int ufd, int flags,
 				   const struct old_itimerspec32 __user *utmr,
 				   struct old_itimerspec32 __user *otmr);
-
-/* fs/utimes.c */
 asmlinkage long sys_utimensat(int dfd, const char __user *filename,
 				struct __kernel_timespec __user *utimes,
 				int flags);
 asmlinkage long sys_utimensat_time32(unsigned int dfd,
 				const char __user *filename,
 				struct old_timespec32 __user *t, int flags);
-
-/* kernel/acct.c */
 asmlinkage long sys_acct(const char __user *name);
-
-/* kernel/capability.c */
 asmlinkage long sys_capget(cap_user_header_t header,
 				cap_user_data_t dataptr);
 asmlinkage long sys_capset(cap_user_header_t header,
 				const cap_user_data_t data);
-
-/* kernel/exec_domain.c */
 asmlinkage long sys_personality(unsigned int personality);
-
-/* kernel/exit.c */
 asmlinkage long sys_exit(int error_code);
 asmlinkage long sys_exit_group(int error_code);
 asmlinkage long sys_waitid(int which, pid_t pid,
 			   struct siginfo __user *infop,
 			   int options, struct rusage __user *ru);
-
-/* kernel/fork.c */
 asmlinkage long sys_set_tid_address(int __user *tidptr);
 asmlinkage long sys_unshare(unsigned long unshare_flags);
-
-/* kernel/futex/syscalls.c */
 asmlinkage long sys_futex(u32 __user *uaddr, int op, u32 val,
 			  const struct __kernel_timespec __user *utime,
 			  u32 __user *uaddr2, u32 val3);
@@ -625,31 +561,21 @@ asmlinkage long sys_set_robust_list(struct robust_list_head __user *head,
 asmlinkage long sys_futex_waitv(struct futex_waitv *waiters,
 				unsigned int nr_futexes, unsigned int flags,
 				struct __kernel_timespec __user *timeout, clockid_t clockid);
-
-/* kernel/hrtimer.c */
 asmlinkage long sys_nanosleep(struct __kernel_timespec __user *rqtp,
 			      struct __kernel_timespec __user *rmtp);
 asmlinkage long sys_nanosleep_time32(struct old_timespec32 __user *rqtp,
 				     struct old_timespec32 __user *rmtp);
-
-/* kernel/itimer.c */
 asmlinkage long sys_getitimer(int which, struct __kernel_old_itimerval __user *value);
 asmlinkage long sys_setitimer(int which,
 				struct __kernel_old_itimerval __user *value,
 				struct __kernel_old_itimerval __user *ovalue);
-
-/* kernel/kexec.c */
 asmlinkage long sys_kexec_load(unsigned long entry, unsigned long nr_segments,
 				struct kexec_segment __user *segments,
 				unsigned long flags);
-
-/* kernel/module.c */
 asmlinkage long sys_init_module(void __user *umod, unsigned long len,
 				const char __user *uargs);
 asmlinkage long sys_delete_module(const char __user *name_user,
 				unsigned int flags);
-
-/* kernel/posix-timers.c */
 asmlinkage long sys_timer_create(clockid_t which_clock,
 				 struct sigevent __user *timer_event_spec,
 				 timer_t __user * created_timer_id);
@@ -683,15 +609,9 @@ asmlinkage long sys_clock_getres_time32(clockid_t which_clock,
 asmlinkage long sys_clock_nanosleep_time32(clockid_t which_clock, int flags,
 				struct old_timespec32 __user *rqtp,
 				struct old_timespec32 __user *rmtp);
-
-/* kernel/printk.c */
 asmlinkage long sys_syslog(int type, char __user *buf, int len);
-
-/* kernel/ptrace.c */
 asmlinkage long sys_ptrace(long request, long pid, unsigned long addr,
 			   unsigned long data);
-/* kernel/sched/core.c */
-
 asmlinkage long sys_sched_setparam(pid_t pid,
 					struct sched_param __user *param);
 asmlinkage long sys_sched_setscheduler(pid_t pid, int policy,
@@ -710,8 +630,6 @@ asmlinkage long sys_sched_rr_get_interval(pid_t pid,
 				struct __kernel_timespec __user *interval);
 asmlinkage long sys_sched_rr_get_interval_time32(pid_t pid,
 						 struct old_timespec32 __user *interval);
-
-/* kernel/signal.c */
 asmlinkage long sys_restart_syscall(void);
 asmlinkage long sys_kill(pid_t pid, int sig);
 asmlinkage long sys_tkill(pid_t pid, int sig);
@@ -737,8 +655,6 @@ asmlinkage long sys_rt_sigtimedwait_time32(const sigset_t __user *uthese,
 				const struct old_timespec32 __user *uts,
 				size_t sigsetsize);
 asmlinkage long sys_rt_sigqueueinfo(pid_t pid, int sig, siginfo_t __user *uinfo);
-
-/* kernel/sys.c */
 asmlinkage long sys_setpriority(int which, int who, int niceval);
 asmlinkage long sys_getpriority(int which, int who);
 asmlinkage long sys_reboot(int magic1, int magic2, unsigned int cmd,
@@ -772,16 +688,12 @@ asmlinkage long sys_umask(int mask);
 asmlinkage long sys_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 asmlinkage long sys_getcpu(unsigned __user *cpu, unsigned __user *node, struct getcpu_cache __user *cache);
-
-/* kernel/time.c */
 asmlinkage long sys_gettimeofday(struct __kernel_old_timeval __user *tv,
 				struct timezone __user *tz);
 asmlinkage long sys_settimeofday(struct __kernel_old_timeval __user *tv,
 				struct timezone __user *tz);
 asmlinkage long sys_adjtimex(struct __kernel_timex __user *txc_p);
 asmlinkage long sys_adjtimex_time32(struct old_timex32 __user *txc_p);
-
-/* kernel/sys.c */
 asmlinkage long sys_getpid(void);
 asmlinkage long sys_getppid(void);
 asmlinkage long sys_getuid(void);
@@ -790,8 +702,6 @@ asmlinkage long sys_getgid(void);
 asmlinkage long sys_getegid(void);
 asmlinkage long sys_gettid(void);
 asmlinkage long sys_sysinfo(struct sysinfo __user *info);
-
-/* ipc/mqueue.c */
 asmlinkage long sys_mq_open(const char __user *name, int oflag, umode_t mode, struct mq_attr __user *attr);
 asmlinkage long sys_mq_unlink(const char __user *name);
 asmlinkage long sys_mq_timedsend(mqd_t mqdes, const char __user *msg_ptr, size_t msg_len, unsigned int msg_prio, const struct __kernel_timespec __user *abs_timeout);
@@ -806,8 +716,6 @@ asmlinkage long sys_mq_timedsend_time32(mqd_t mqdes,
 			const char __user *u_msg_ptr,
 			unsigned int msg_len, unsigned int msg_prio,
 			const struct old_timespec32 __user *u_abs_timeout);
-
-/* ipc/msg.c */
 asmlinkage long sys_msgget(key_t key, int msgflg);
 asmlinkage long sys_old_msgctl(int msqid, int cmd, struct msqid_ds __user *buf);
 asmlinkage long sys_msgctl(int msqid, int cmd, struct msqid_ds __user *buf);
@@ -815,8 +723,6 @@ asmlinkage long sys_msgrcv(int msqid, struct msgbuf __user *msgp,
 				size_t msgsz, long msgtyp, int msgflg);
 asmlinkage long sys_msgsnd(int msqid, struct msgbuf __user *msgp,
 				size_t msgsz, int msgflg);
-
-/* ipc/sem.c */
 asmlinkage long sys_semget(key_t key, int nsems, int semflg);
 asmlinkage long sys_semctl(int semid, int semnum, int cmd, unsigned long arg);
 asmlinkage long sys_old_semctl(int semid, int semnum, int cmd, unsigned long arg);
@@ -828,15 +734,11 @@ asmlinkage long sys_semtimedop_time32(int semid, struct sembuf __user *sops,
 				const struct old_timespec32 __user *timeout);
 asmlinkage long sys_semop(int semid, struct sembuf __user *sops,
 				unsigned nsops);
-
-/* ipc/shm.c */
 asmlinkage long sys_shmget(key_t key, size_t size, int flag);
 asmlinkage long sys_old_shmctl(int shmid, int cmd, struct shmid_ds __user *buf);
 asmlinkage long sys_shmctl(int shmid, int cmd, struct shmid_ds __user *buf);
 asmlinkage long sys_shmat(int shmid, char __user *shmaddr, int shmflg);
 asmlinkage long sys_shmdt(char __user *shmaddr);
-
-/* net/socket.c */
 asmlinkage long sys_socket(int, int, int);
 asmlinkage long sys_socketpair(int, int, int, int __user *);
 asmlinkage long sys_bind(int, struct sockaddr __user *, int);
@@ -856,18 +758,12 @@ asmlinkage long sys_getsockopt(int fd, int level, int optname,
 asmlinkage long sys_shutdown(int, int);
 asmlinkage long sys_sendmsg(int fd, struct user_msghdr __user *msg, unsigned flags);
 asmlinkage long sys_recvmsg(int fd, struct user_msghdr __user *msg, unsigned flags);
-
-/* mm/filemap.c */
 asmlinkage long sys_readahead(int fd, loff_t offset, size_t count);
-
-/* mm/nommu.c, also with MMU */
 asmlinkage long sys_brk(unsigned long brk);
 asmlinkage long sys_munmap(unsigned long addr, size_t len);
 asmlinkage long sys_mremap(unsigned long addr,
 			   unsigned long old_len, unsigned long new_len,
 			   unsigned long flags, unsigned long new_addr);
-
-/* security/keys/keyctl.c */
 asmlinkage long sys_add_key(const char __user *_type,
 			    const char __user *_description,
 			    const void __user *_payload,
@@ -879,8 +775,6 @@ asmlinkage long sys_request_key(const char __user *_type,
 				key_serial_t destringid);
 asmlinkage long sys_keyctl(int cmd, unsigned long arg2, unsigned long arg3,
 			   unsigned long arg4, unsigned long arg5);
-
-/* arch/example/kernel/sys_example.c */
 #ifdef CONFIG_CLONE_BACKWARDS
 asmlinkage long sys_clone(unsigned long, unsigned long, int __user *, unsigned long,
 	       int __user *);
@@ -899,11 +793,9 @@ asmlinkage long sys_clone3(struct clone_args __user *uargs, size_t size);
 asmlinkage long sys_execve(const char __user *filename,
 		const char __user *const __user *argv,
 		const char __user *const __user *envp);
-
-/* mm/fadvise.c */
 asmlinkage long sys_fadvise64_64(int fd, loff_t offset, loff_t len, int advice);
 
-/* mm/, CONFIG_MMU only */
+/* CONFIG_MMU only */
 asmlinkage long sys_swapon(const char __user *specialfile, int swap_flags);
 asmlinkage long sys_swapoff(const char __user *specialfile);
 asmlinkage long sys_mprotect(unsigned long start, size_t len,
@@ -941,7 +833,6 @@ asmlinkage long sys_move_pages(pid_t pid, unsigned long nr_pages,
 				const int __user *nodes,
 				int __user *status,
 				int flags);
-
 asmlinkage long sys_rt_tgsigqueueinfo(pid_t tgid, pid_t  pid, int sig,
 		siginfo_t __user *uinfo);
 asmlinkage long sys_perf_event_open(
@@ -954,7 +845,6 @@ asmlinkage long sys_recvmmsg(int fd, struct mmsghdr __user *msg,
 asmlinkage long sys_recvmmsg_time32(int fd, struct mmsghdr __user *msg,
 			     unsigned int vlen, unsigned flags,
 			     struct old_timespec32 __user *timeout);
-
 asmlinkage long sys_wait4(pid_t pid, int __user *stat_addr,
 				int options, struct rusage __user *ru);
 asmlinkage long sys_prlimit64(pid_t pid, unsigned int resource,
@@ -1063,7 +953,7 @@ asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long l
  * Architecture-specific system calls
  */
 
-/* arch/x86/kernel/ioport.c */
+/* x86 */
 asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on);
 
 /* pciconfig: alpha, arm, arm64, ia64, sparc */
@@ -1171,11 +1061,11 @@ asmlinkage long sys_sysfs(int option,
 				unsigned long arg1, unsigned long arg2);
 asmlinkage long sys_fork(void);
 
-/* obsolete: kernel/time/time.c */
+/* obsolete */
 asmlinkage long sys_stime(__kernel_old_time_t __user *tptr);
 asmlinkage long sys_stime32(old_time32_t __user *tptr);
 
-/* obsolete: kernel/signal.c */
+/* obsolete */
 asmlinkage long sys_sigpending(old_sigset_t __user *uset);
 asmlinkage long sys_sigprocmask(int how, old_sigset_t __user *set,
 				old_sigset_t __user *oset);
@@ -1195,19 +1085,19 @@ asmlinkage long sys_sgetmask(void);
 asmlinkage long sys_ssetmask(int newmask);
 asmlinkage long sys_signal(int sig, __sighandler_t handler);
 
-/* obsolete: kernel/sched/core.c */
+/* obsolete */
 asmlinkage long sys_nice(int increment);
 
-/* obsolete: kernel/kexec_file.c */
+/* obsolete */
 asmlinkage long sys_kexec_file_load(int kernel_fd, int initrd_fd,
 				    unsigned long cmdline_len,
 				    const char __user *cmdline_ptr,
 				    unsigned long flags);
 
-/* obsolete: kernel/exit.c */
+/* obsolete */
 asmlinkage long sys_waitpid(pid_t pid, int __user *stat_addr, int options);
 
-/* obsolete: kernel/uid16.c */
+/* obsolete */
 #ifdef CONFIG_HAVE_UID16
 asmlinkage long sys_chown16(const char __user *filename,
 				old_uid_t user, old_gid_t group);
@@ -1234,10 +1124,10 @@ asmlinkage long sys_getgid16(void);
 asmlinkage long sys_getegid16(void);
 #endif
 
-/* obsolete: net/socket.c */
+/* obsolete */
 asmlinkage long sys_socketcall(int call, unsigned long __user *args);
 
-/* obsolete: fs/stat.c */
+/* obsolete */
 asmlinkage long sys_stat(const char __user *filename,
 			struct __old_kernel_stat __user *statbuf);
 asmlinkage long sys_lstat(const char __user *filename,
@@ -1247,13 +1137,13 @@ asmlinkage long sys_fstat(unsigned int fd,
 asmlinkage long sys_readlink(const char __user *path,
 				char __user *buf, int bufsiz);
 
-/* obsolete: fs/select.c */
+/* obsolete */
 asmlinkage long sys_old_select(struct sel_arg_struct __user *arg);
 
-/* obsolete: fs/readdir.c */
+/* obsolete */
 asmlinkage long sys_old_readdir(unsigned int, struct old_linux_dirent __user *, unsigned int);
 
-/* obsolete: kernel/sys.c */
+/* obsolete */
 asmlinkage long sys_gethostname(char __user *name, int len);
 asmlinkage long sys_uname(struct old_utsname __user *);
 asmlinkage long sys_olduname(struct oldold_utsname __user *);
@@ -1261,11 +1151,11 @@ asmlinkage long sys_olduname(struct oldold_utsname __user *);
 asmlinkage long sys_old_getrlimit(unsigned int resource, struct rlimit __user *rlim);
 #endif
 
-/* obsolete: ipc */
+/* obsolete */
 asmlinkage long sys_ipc(unsigned int call, int first, unsigned long second,
 		unsigned long third, void __user *ptr, long fifth);
 
-/* obsolete: mm/ */
+/* obsolete */
 asmlinkage long sys_mmap_pgoff(unsigned long addr, unsigned long len,
 			unsigned long prot, unsigned long flags,
 			unsigned long fd, unsigned long pgoff);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 45fa180cc56a..dd7d8e10f16d 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -38,12 +38,12 @@ __SYSCALL(__NR_io_destroy, sys_io_destroy)
 __SC_COMP(__NR_io_submit, sys_io_submit, compat_sys_io_submit)
 #define __NR_io_cancel 3
 __SYSCALL(__NR_io_cancel, sys_io_cancel)
+
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_io_getevents 4
 __SC_3264(__NR_io_getevents, sys_io_getevents_time32, sys_io_getevents)
 #endif
 
-/* fs/xattr.c */
 #define __NR_setxattr 5
 __SYSCALL(__NR_setxattr, sys_setxattr)
 #define __NR_lsetxattr 6
@@ -68,58 +68,38 @@ __SYSCALL(__NR_removexattr, sys_removexattr)
 __SYSCALL(__NR_lremovexattr, sys_lremovexattr)
 #define __NR_fremovexattr 16
 __SYSCALL(__NR_fremovexattr, sys_fremovexattr)
-
-/* fs/dcache.c */
 #define __NR_getcwd 17
 __SYSCALL(__NR_getcwd, sys_getcwd)
-
-/* fs/cookies.c */
 #define __NR_lookup_dcookie 18
 __SC_COMP(__NR_lookup_dcookie, sys_lookup_dcookie, compat_sys_lookup_dcookie)
-
-/* fs/eventfd.c */
 #define __NR_eventfd2 19
 __SYSCALL(__NR_eventfd2, sys_eventfd2)
-
-/* fs/eventpoll.c */
 #define __NR_epoll_create1 20
 __SYSCALL(__NR_epoll_create1, sys_epoll_create1)
 #define __NR_epoll_ctl 21
 __SYSCALL(__NR_epoll_ctl, sys_epoll_ctl)
 #define __NR_epoll_pwait 22
 __SC_COMP(__NR_epoll_pwait, sys_epoll_pwait, compat_sys_epoll_pwait)
-
-/* fs/fcntl.c */
 #define __NR_dup 23
 __SYSCALL(__NR_dup, sys_dup)
 #define __NR_dup3 24
 __SYSCALL(__NR_dup3, sys_dup3)
 #define __NR3264_fcntl 25
 __SC_COMP_3264(__NR3264_fcntl, sys_fcntl64, sys_fcntl, compat_sys_fcntl64)
-
-/* fs/inotify_user.c */
 #define __NR_inotify_init1 26
 __SYSCALL(__NR_inotify_init1, sys_inotify_init1)
 #define __NR_inotify_add_watch 27
 __SYSCALL(__NR_inotify_add_watch, sys_inotify_add_watch)
 #define __NR_inotify_rm_watch 28
 __SYSCALL(__NR_inotify_rm_watch, sys_inotify_rm_watch)
-
-/* fs/ioctl.c */
 #define __NR_ioctl 29
 __SC_COMP(__NR_ioctl, sys_ioctl, compat_sys_ioctl)
-
-/* fs/ioprio.c */
 #define __NR_ioprio_set 30
 __SYSCALL(__NR_ioprio_set, sys_ioprio_set)
 #define __NR_ioprio_get 31
 __SYSCALL(__NR_ioprio_get, sys_ioprio_get)
-
-/* fs/locks.c */
 #define __NR_flock 32
 __SYSCALL(__NR_flock, sys_flock)
-
-/* fs/namei.c */
 #define __NR_mknodat 33
 __SYSCALL(__NR_mknodat, sys_mknodat)
 #define __NR_mkdirat 34
@@ -130,25 +110,21 @@ __SYSCALL(__NR_unlinkat, sys_unlinkat)
 __SYSCALL(__NR_symlinkat, sys_symlinkat)
 #define __NR_linkat 37
 __SYSCALL(__NR_linkat, sys_linkat)
+
 #ifdef __ARCH_WANT_RENAMEAT
 /* renameat is superseded with flags by renameat2 */
 #define __NR_renameat 38
 __SYSCALL(__NR_renameat, sys_renameat)
 #endif /* __ARCH_WANT_RENAMEAT */
 
-/* fs/namespace.c */
 #define __NR_umount2 39
 __SYSCALL(__NR_umount2, sys_umount)
 #define __NR_mount 40
 __SYSCALL(__NR_mount, sys_mount)
 #define __NR_pivot_root 41
 __SYSCALL(__NR_pivot_root, sys_pivot_root)
-
-/* fs/nfsctl.c */
 #define __NR_nfsservctl 42
 __SYSCALL(__NR_nfsservctl, sys_ni_syscall)
-
-/* fs/open.c */
 #define __NR3264_statfs 43
 __SC_COMP_3264(__NR3264_statfs, sys_statfs64, sys_statfs, \
 	       compat_sys_statfs64)
@@ -161,7 +137,6 @@ __SC_COMP_3264(__NR3264_truncate, sys_truncate64, sys_truncate, \
 #define __NR3264_ftruncate 46
 __SC_COMP_3264(__NR3264_ftruncate, sys_ftruncate64, sys_ftruncate, \
 	       compat_sys_ftruncate64)
-
 #define __NR_fallocate 47
 __SC_COMP(__NR_fallocate, sys_fallocate, compat_sys_fallocate)
 #define __NR_faccessat 48
@@ -186,20 +161,12 @@ __SYSCALL(__NR_openat, sys_openat)
 __SYSCALL(__NR_close, sys_close)
 #define __NR_vhangup 58
 __SYSCALL(__NR_vhangup, sys_vhangup)
-
-/* fs/pipe.c */
 #define __NR_pipe2 59
 __SYSCALL(__NR_pipe2, sys_pipe2)
-
-/* fs/quota.c */
 #define __NR_quotactl 60
 __SYSCALL(__NR_quotactl, sys_quotactl)
-
-/* fs/readdir.c */
 #define __NR_getdents64 61
 __SYSCALL(__NR_getdents64, sys_getdents64)
-
-/* fs/read_write.c */
 #define __NR3264_lseek 62
 __SC_3264(__NR3264_lseek, sys_llseek, sys_lseek)
 #define __NR_read 63
@@ -218,12 +185,9 @@ __SC_COMP(__NR_pwrite64, sys_pwrite64, compat_sys_pwrite64)
 __SC_COMP(__NR_preadv, sys_preadv, compat_sys_preadv)
 #define __NR_pwritev 70
 __SC_COMP(__NR_pwritev, sys_pwritev, compat_sys_pwritev)
-
-/* fs/sendfile.c */
 #define __NR3264_sendfile 71
 __SYSCALL(__NR3264_sendfile, sys_sendfile64)
 
-/* fs/select.c */
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_pselect6 72
 __SC_COMP_3264(__NR_pselect6, sys_pselect6_time32, sys_pselect6, compat_sys_pselect6_time32)
@@ -231,21 +195,17 @@ __SC_COMP_3264(__NR_pselect6, sys_pselect6_time32, sys_pselect6, compat_sys_psel
 __SC_COMP_3264(__NR_ppoll, sys_ppoll_time32, sys_ppoll, compat_sys_ppoll_time32)
 #endif
 
-/* fs/signalfd.c */
 #define __NR_signalfd4 74
 __SC_COMP(__NR_signalfd4, sys_signalfd4, compat_sys_signalfd4)
-
-/* fs/splice.c */
 #define __NR_vmsplice 75
 __SYSCALL(__NR_vmsplice, sys_vmsplice)
 #define __NR_splice 76
 __SYSCALL(__NR_splice, sys_splice)
 #define __NR_tee 77
 __SYSCALL(__NR_tee, sys_tee)
-
-/* fs/stat.c */
 #define __NR_readlinkat 78
 __SYSCALL(__NR_readlinkat, sys_readlinkat)
+
 #if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
 #define __NR3264_fstatat 79
 __SC_3264(__NR3264_fstatat, sys_fstatat64, sys_newfstatat)
@@ -253,13 +213,13 @@ __SC_3264(__NR3264_fstatat, sys_fstatat64, sys_newfstatat)
 __SC_3264(__NR3264_fstat, sys_fstat64, sys_newfstat)
 #endif
 
-/* fs/sync.c */
 #define __NR_sync 81
 __SYSCALL(__NR_sync, sys_sync)
 #define __NR_fsync 82
 __SYSCALL(__NR_fsync, sys_fsync)
 #define __NR_fdatasync 83
 __SYSCALL(__NR_fdatasync, sys_fdatasync)
+
 #ifdef __ARCH_WANT_SYNC_FILE_RANGE2
 #define __NR_sync_file_range2 84
 __SC_COMP(__NR_sync_file_range2, sys_sync_file_range2, \
@@ -270,9 +230,9 @@ __SC_COMP(__NR_sync_file_range, sys_sync_file_range, \
 	  compat_sys_sync_file_range)
 #endif
 
-/* fs/timerfd.c */
 #define __NR_timerfd_create 85
 __SYSCALL(__NR_timerfd_create, sys_timerfd_create)
+
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_timerfd_settime 86
 __SC_3264(__NR_timerfd_settime, sys_timerfd_settime32, \
@@ -282,45 +242,35 @@ __SC_3264(__NR_timerfd_gettime, sys_timerfd_gettime32, \
 	  sys_timerfd_gettime)
 #endif
 
-/* fs/utimes.c */
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_utimensat 88
 __SC_3264(__NR_utimensat, sys_utimensat_time32, sys_utimensat)
 #endif
 
-/* kernel/acct.c */
 #define __NR_acct 89
 __SYSCALL(__NR_acct, sys_acct)
-
-/* kernel/capability.c */
 #define __NR_capget 90
 __SYSCALL(__NR_capget, sys_capget)
 #define __NR_capset 91
 __SYSCALL(__NR_capset, sys_capset)
-
-/* kernel/exec_domain.c */
 #define __NR_personality 92
 __SYSCALL(__NR_personality, sys_personality)
-
-/* kernel/exit.c */
 #define __NR_exit 93
 __SYSCALL(__NR_exit, sys_exit)
 #define __NR_exit_group 94
 __SYSCALL(__NR_exit_group, sys_exit_group)
 #define __NR_waitid 95
 __SC_COMP(__NR_waitid, sys_waitid, compat_sys_waitid)
-
-/* kernel/fork.c */
 #define __NR_set_tid_address 96
 __SYSCALL(__NR_set_tid_address, sys_set_tid_address)
 #define __NR_unshare 97
 __SYSCALL(__NR_unshare, sys_unshare)
 
-/* kernel/futex.c */
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_futex 98
 __SC_3264(__NR_futex, sys_futex_time32, sys_futex)
 #endif
+
 #define __NR_set_robust_list 99
 __SC_COMP(__NR_set_robust_list, sys_set_robust_list, \
 	  compat_sys_set_robust_list)
@@ -328,43 +278,40 @@ __SC_COMP(__NR_set_robust_list, sys_set_robust_list, \
 __SC_COMP(__NR_get_robust_list, sys_get_robust_list, \
 	  compat_sys_get_robust_list)
 
-/* kernel/hrtimer.c */
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_nanosleep 101
 __SC_3264(__NR_nanosleep, sys_nanosleep_time32, sys_nanosleep)
 #endif
 
-/* kernel/itimer.c */
 #define __NR_getitimer 102
 __SC_COMP(__NR_getitimer, sys_getitimer, compat_sys_getitimer)
 #define __NR_setitimer 103
 __SC_COMP(__NR_setitimer, sys_setitimer, compat_sys_setitimer)
-
-/* kernel/kexec.c */
 #define __NR_kexec_load 104
 __SC_COMP(__NR_kexec_load, sys_kexec_load, compat_sys_kexec_load)
-
-/* kernel/module.c */
 #define __NR_init_module 105
 __SYSCALL(__NR_init_module, sys_init_module)
 #define __NR_delete_module 106
 __SYSCALL(__NR_delete_module, sys_delete_module)
-
-/* kernel/posix-timers.c */
 #define __NR_timer_create 107
 __SC_COMP(__NR_timer_create, sys_timer_create, compat_sys_timer_create)
+
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_timer_gettime 108
 __SC_3264(__NR_timer_gettime, sys_timer_gettime32, sys_timer_gettime)
 #endif
+
 #define __NR_timer_getoverrun 109
 __SYSCALL(__NR_timer_getoverrun, sys_timer_getoverrun)
+
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_timer_settime 110
 __SC_3264(__NR_timer_settime, sys_timer_settime32, sys_timer_settime)
 #endif
+
 #define __NR_timer_delete 111
 __SYSCALL(__NR_timer_delete, sys_timer_delete)
+
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_clock_settime 112
 __SC_3264(__NR_clock_settime, sys_clock_settime32, sys_clock_settime)
@@ -377,15 +324,10 @@ __SC_3264(__NR_clock_nanosleep, sys_clock_nanosleep_time32, \
 	  sys_clock_nanosleep)
 #endif
 
-/* kernel/printk.c */
 #define __NR_syslog 116
 __SYSCALL(__NR_syslog, sys_syslog)
-
-/* kernel/ptrace.c */
 #define __NR_ptrace 117
 __SC_COMP(__NR_ptrace, sys_ptrace, compat_sys_ptrace)
-
-/* kernel/sched/core.c */
 #define __NR_sched_setparam 118
 __SYSCALL(__NR_sched_setparam, sys_sched_setparam)
 #define __NR_sched_setscheduler 119
@@ -406,13 +348,13 @@ __SYSCALL(__NR_sched_yield, sys_sched_yield)
 __SYSCALL(__NR_sched_get_priority_max, sys_sched_get_priority_max)
 #define __NR_sched_get_priority_min 126
 __SYSCALL(__NR_sched_get_priority_min, sys_sched_get_priority_min)
+
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_sched_rr_get_interval 127
 __SC_3264(__NR_sched_rr_get_interval, sys_sched_rr_get_interval_time32, \
 	  sys_sched_rr_get_interval)
 #endif
 
-/* kernel/signal.c */
 #define __NR_restart_syscall 128
 __SYSCALL(__NR_restart_syscall, sys_restart_syscall)
 #define __NR_kill 129
@@ -431,18 +373,18 @@ __SC_COMP(__NR_rt_sigaction, sys_rt_sigaction, compat_sys_rt_sigaction)
 __SC_COMP(__NR_rt_sigprocmask, sys_rt_sigprocmask, compat_sys_rt_sigprocmask)
 #define __NR_rt_sigpending 136
 __SC_COMP(__NR_rt_sigpending, sys_rt_sigpending, compat_sys_rt_sigpending)
+
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_rt_sigtimedwait 137
 __SC_COMP_3264(__NR_rt_sigtimedwait, sys_rt_sigtimedwait_time32, \
 	  sys_rt_sigtimedwait, compat_sys_rt_sigtimedwait_time32)
 #endif
+
 #define __NR_rt_sigqueueinfo 138
 __SC_COMP(__NR_rt_sigqueueinfo, sys_rt_sigqueueinfo, \
 	  compat_sys_rt_sigqueueinfo)
 #define __NR_rt_sigreturn 139
 __SC_COMP(__NR_rt_sigreturn, sys_rt_sigreturn, compat_sys_rt_sigreturn)
-
-/* kernel/sys.c */
 #define __NR_setpriority 140
 __SYSCALL(__NR_setpriority, sys_setpriority)
 #define __NR_getpriority 141
@@ -507,7 +449,6 @@ __SYSCALL(__NR_prctl, sys_prctl)
 #define __NR_getcpu 168
 __SYSCALL(__NR_getcpu, sys_getcpu)
 
-/* kernel/time.c */
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_gettimeofday 169
 __SC_COMP(__NR_gettimeofday, sys_gettimeofday, compat_sys_gettimeofday)
@@ -517,7 +458,6 @@ __SC_COMP(__NR_settimeofday, sys_settimeofday, compat_sys_settimeofday)
 __SC_3264(__NR_adjtimex, sys_adjtimex_time32, sys_adjtimex)
 #endif
 
-/* kernel/sys.c */
 #define __NR_getpid 172
 __SYSCALL(__NR_getpid, sys_getpid)
 #define __NR_getppid 173
@@ -534,12 +474,11 @@ __SYSCALL(__NR_getegid, sys_getegid)
 __SYSCALL(__NR_gettid, sys_gettid)
 #define __NR_sysinfo 179
 __SC_COMP(__NR_sysinfo, sys_sysinfo, compat_sys_sysinfo)
-
-/* ipc/mqueue.c */
 #define __NR_mq_open 180
 __SC_COMP(__NR_mq_open, sys_mq_open, compat_sys_mq_open)
 #define __NR_mq_unlink 181
 __SYSCALL(__NR_mq_unlink, sys_mq_unlink)
+
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_mq_timedsend 182
 __SC_3264(__NR_mq_timedsend, sys_mq_timedsend_time32, sys_mq_timedsend)
@@ -547,12 +486,11 @@ __SC_3264(__NR_mq_timedsend, sys_mq_timedsend_time32, sys_mq_timedsend)
 __SC_3264(__NR_mq_timedreceive, sys_mq_timedreceive_time32, \
 	  sys_mq_timedreceive)
 #endif
+
 #define __NR_mq_notify 184
 __SC_COMP(__NR_mq_notify, sys_mq_notify, compat_sys_mq_notify)
 #define __NR_mq_getsetattr 185
 __SC_COMP(__NR_mq_getsetattr, sys_mq_getsetattr, compat_sys_mq_getsetattr)
-
-/* ipc/msg.c */
 #define __NR_msgget 186
 __SYSCALL(__NR_msgget, sys_msgget)
 #define __NR_msgctl 187
@@ -561,20 +499,18 @@ __SC_COMP(__NR_msgctl, sys_msgctl, compat_sys_msgctl)
 __SC_COMP(__NR_msgrcv, sys_msgrcv, compat_sys_msgrcv)
 #define __NR_msgsnd 189
 __SC_COMP(__NR_msgsnd, sys_msgsnd, compat_sys_msgsnd)
-
-/* ipc/sem.c */
 #define __NR_semget 190
 __SYSCALL(__NR_semget, sys_semget)
 #define __NR_semctl 191
 __SC_COMP(__NR_semctl, sys_semctl, compat_sys_semctl)
+
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_semtimedop 192
 __SC_3264(__NR_semtimedop, sys_semtimedop_time32, sys_semtimedop)
 #endif
+
 #define __NR_semop 193
 __SYSCALL(__NR_semop, sys_semop)
-
-/* ipc/shm.c */
 #define __NR_shmget 194
 __SYSCALL(__NR_shmget, sys_shmget)
 #define __NR_shmctl 195
@@ -583,8 +519,6 @@ __SC_COMP(__NR_shmctl, sys_shmctl, compat_sys_shmctl)
 __SC_COMP(__NR_shmat, sys_shmat, compat_sys_shmat)
 #define __NR_shmdt 197
 __SYSCALL(__NR_shmdt, sys_shmdt)
-
-/* net/socket.c */
 #define __NR_socket 198
 __SYSCALL(__NR_socket, sys_socket)
 #define __NR_socketpair 199
@@ -615,40 +549,30 @@ __SYSCALL(__NR_shutdown, sys_shutdown)
 __SC_COMP(__NR_sendmsg, sys_sendmsg, compat_sys_sendmsg)
 #define __NR_recvmsg 212
 __SC_COMP(__NR_recvmsg, sys_recvmsg, compat_sys_recvmsg)
-
-/* mm/filemap.c */
 #define __NR_readahead 213
 __SC_COMP(__NR_readahead, sys_readahead, compat_sys_readahead)
-
-/* mm/nommu.c, also with MMU */
 #define __NR_brk 214
 __SYSCALL(__NR_brk, sys_brk)
 #define __NR_munmap 215
 __SYSCALL(__NR_munmap, sys_munmap)
 #define __NR_mremap 216
 __SYSCALL(__NR_mremap, sys_mremap)
-
-/* security/keys/keyctl.c */
 #define __NR_add_key 217
 __SYSCALL(__NR_add_key, sys_add_key)
 #define __NR_request_key 218
 __SYSCALL(__NR_request_key, sys_request_key)
 #define __NR_keyctl 219
 __SC_COMP(__NR_keyctl, sys_keyctl, compat_sys_keyctl)
-
-/* arch/example/kernel/sys_example.c */
 #define __NR_clone 220
 __SYSCALL(__NR_clone, sys_clone)
 #define __NR_execve 221
 __SC_COMP(__NR_execve, sys_execve, compat_sys_execve)
-
 #define __NR3264_mmap 222
 __SC_3264(__NR3264_mmap, sys_mmap2, sys_mmap)
-/* mm/fadvise.c */
 #define __NR3264_fadvise64 223
 __SC_COMP(__NR3264_fadvise64, sys_fadvise64_64, compat_sys_fadvise64_64)
 
-/* mm/, CONFIG_MMU only */
+/* CONFIG_MMU only */
 #ifndef __ARCH_NOMMU
 #define __NR_swapon 224
 __SYSCALL(__NR_swapon, sys_swapon)
@@ -691,6 +615,7 @@ __SC_COMP(__NR_rt_tgsigqueueinfo, sys_rt_tgsigqueueinfo, \
 __SYSCALL(__NR_perf_event_open, sys_perf_event_open)
 #define __NR_accept4 242
 __SYSCALL(__NR_accept4, sys_accept4)
+
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_recvmmsg 243
 __SC_COMP_3264(__NR_recvmmsg, sys_recvmmsg_time32, sys_recvmmsg, compat_sys_recvmmsg_time32)
@@ -706,6 +631,7 @@ __SC_COMP_3264(__NR_recvmmsg, sys_recvmmsg_time32, sys_recvmmsg, compat_sys_recv
 #define __NR_wait4 260
 __SC_COMP(__NR_wait4, sys_wait4, compat_sys_wait4)
 #endif
+
 #define __NR_prlimit64 261
 __SYSCALL(__NR_prlimit64, sys_prlimit64)
 #define __NR_fanotify_init 262
@@ -716,10 +642,12 @@ __SYSCALL(__NR_fanotify_mark, sys_fanotify_mark)
 __SYSCALL(__NR_name_to_handle_at, sys_name_to_handle_at)
 #define __NR_open_by_handle_at         265
 __SYSCALL(__NR_open_by_handle_at, sys_open_by_handle_at)
+
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_clock_adjtime 266
 __SC_3264(__NR_clock_adjtime, sys_clock_adjtime32, sys_clock_adjtime)
 #endif
+
 #define __NR_syncfs 267
 __SYSCALL(__NR_syncfs, sys_syncfs)
 #define __NR_setns 268
@@ -770,15 +698,19 @@ __SYSCALL(__NR_pkey_alloc,    sys_pkey_alloc)
 __SYSCALL(__NR_pkey_free,     sys_pkey_free)
 #define __NR_statx 291
 __SYSCALL(__NR_statx,     sys_statx)
+
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_io_pgetevents 292
 __SC_COMP_3264(__NR_io_pgetevents, sys_io_pgetevents_time32, sys_io_pgetevents, compat_sys_io_pgetevents)
 #endif
+
 #define __NR_rseq 293
 __SYSCALL(__NR_rseq, sys_rseq)
 #define __NR_kexec_file_load 294
 __SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
+
 /* 295 through 402 are unassigned to sync up with generic numbers, don't use */
+
 #if defined(__SYSCALL_COMPAT) || __BITS_PER_LONG == 32
 #define __NR_clock_gettime64 403
 __SYSCALL(__NR_clock_gettime64, sys_clock_gettime)
@@ -844,13 +776,14 @@ __SYSCALL(__NR_fsmount, sys_fsmount)
 __SYSCALL(__NR_fspick, sys_fspick)
 #define __NR_pidfd_open 434
 __SYSCALL(__NR_pidfd_open, sys_pidfd_open)
+
 #ifdef __ARCH_WANT_SYS_CLONE3
 #define __NR_clone3 435
 __SYSCALL(__NR_clone3, sys_clone3)
 #endif
+
 #define __NR_close_range 436
 __SYSCALL(__NR_close_range, sys_close_range)
-
 #define __NR_openat2 437
 __SYSCALL(__NR_openat2, sys_openat2)
 #define __NR_pidfd_getfd 438
@@ -865,7 +798,6 @@ __SC_COMP(__NR_epoll_pwait2, sys_epoll_pwait2, compat_sys_epoll_pwait2)
 __SYSCALL(__NR_mount_setattr, sys_mount_setattr)
 #define __NR_quotactl_fd 443
 __SYSCALL(__NR_quotactl_fd, sys_quotactl_fd)
-
 #define __NR_landlock_create_ruleset 444
 __SYSCALL(__NR_landlock_create_ruleset, sys_landlock_create_ruleset)
 #define __NR_landlock_add_rule 445
@@ -877,12 +809,11 @@ __SYSCALL(__NR_landlock_restrict_self, sys_landlock_restrict_self)
 #define __NR_memfd_secret 447
 __SYSCALL(__NR_memfd_secret, sys_memfd_secret)
 #endif
+
 #define __NR_process_mrelease 448
 __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
-
 #define __NR_futex_waitv 449
 __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
-
 #define __NR_set_mempolicy_home_node 450
 __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 860b2dcf3ac4..f207236002e9 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -51,99 +51,35 @@ COND_SYSCALL_COMPAT(io_pgetevents);
 COND_SYSCALL(io_uring_setup);
 COND_SYSCALL(io_uring_enter);
 COND_SYSCALL(io_uring_register);
-
-/* fs/xattr.c */
-
-/* fs/dcache.c */
-
-/* fs/cookies.c */
 COND_SYSCALL(lookup_dcookie);
 COND_SYSCALL_COMPAT(lookup_dcookie);
-
-/* fs/eventfd.c */
 COND_SYSCALL(eventfd2);
-
-/* fs/eventfd.c */
 COND_SYSCALL(epoll_create1);
 COND_SYSCALL(epoll_ctl);
 COND_SYSCALL(epoll_pwait);
 COND_SYSCALL_COMPAT(epoll_pwait);
 COND_SYSCALL(epoll_pwait2);
 COND_SYSCALL_COMPAT(epoll_pwait2);
-
-/* fs/fcntl.c */
-
-/* fs/inotify_user.c */
 COND_SYSCALL(inotify_init1);
 COND_SYSCALL(inotify_add_watch);
 COND_SYSCALL(inotify_rm_watch);
-
-/* fs/ioctl.c */
-
-/* fs/ioprio.c */
 COND_SYSCALL(ioprio_set);
 COND_SYSCALL(ioprio_get);
-
-/* fs/locks.c */
 COND_SYSCALL(flock);
-
-/* fs/namei.c */
-
-/* fs/namespace.c */
-
-/* fs/nfsctl.c */
-
-/* fs/open.c */
-
-/* fs/pipe.c */
-
-/* fs/quota.c */
 COND_SYSCALL(quotactl);
 COND_SYSCALL(quotactl_fd);
-
-/* fs/readdir.c */
-
-/* fs/read_write.c */
-
-/* fs/sendfile.c */
-
-/* fs/select.c */
-
-/* fs/signalfd.c */
 COND_SYSCALL(signalfd4);
 COND_SYSCALL_COMPAT(signalfd4);
-
-/* fs/splice.c */
-
-/* fs/stat.c */
-
-/* fs/sync.c */
-
-/* fs/timerfd.c */
 COND_SYSCALL(timerfd_create);
 COND_SYSCALL(timerfd_settime);
 COND_SYSCALL(timerfd_settime32);
 COND_SYSCALL(timerfd_gettime);
 COND_SYSCALL(timerfd_gettime32);
-
-/* fs/utimes.c */
-
-/* kernel/acct.c */
 COND_SYSCALL(acct);
-
-/* kernel/capability.c */
 COND_SYSCALL(capget);
 COND_SYSCALL(capset);
-
-/* kernel/exec_domain.c */
-
-/* kernel/exit.c */
-
-/* kernel/fork.c */
 /* __ARCH_WANT_SYS_CLONE3 */
 COND_SYSCALL(clone3);
-
-/* kernel/futex/syscalls.c */
 COND_SYSCALL(futex);
 COND_SYSCALL(futex_time32);
 COND_SYSCALL(set_robust_list);
@@ -151,29 +87,11 @@ COND_SYSCALL_COMPAT(set_robust_list);
 COND_SYSCALL(get_robust_list);
 COND_SYSCALL_COMPAT(get_robust_list);
 COND_SYSCALL(futex_waitv);
-
-/* kernel/hrtimer.c */
-
-/* kernel/itimer.c */
-
-/* kernel/kexec.c */
 COND_SYSCALL(kexec_load);
 COND_SYSCALL_COMPAT(kexec_load);
-
-/* kernel/module.c */
 COND_SYSCALL(init_module);
 COND_SYSCALL(delete_module);
-
-/* kernel/posix-timers.c */
-
-/* kernel/printk.c */
 COND_SYSCALL(syslog);
-
-/* kernel/ptrace.c */
-
-/* kernel/sched/core.c */
-
-/* kernel/sys.c */
 COND_SYSCALL(setregid);
 COND_SYSCALL(setgid);
 COND_SYSCALL(setreuid);
@@ -186,12 +104,6 @@ COND_SYSCALL(setfsuid);
 COND_SYSCALL(setfsgid);
 COND_SYSCALL(setgroups);
 COND_SYSCALL(getgroups);
-
-/* kernel/time.c */
-
-/* kernel/timer.c */
-
-/* ipc/mqueue.c */
 COND_SYSCALL(mq_open);
 COND_SYSCALL_COMPAT(mq_open);
 COND_SYSCALL(mq_unlink);
@@ -203,8 +115,6 @@ COND_SYSCALL(mq_notify);
 COND_SYSCALL_COMPAT(mq_notify);
 COND_SYSCALL(mq_getsetattr);
 COND_SYSCALL_COMPAT(mq_getsetattr);
-
-/* ipc/msg.c */
 COND_SYSCALL(msgget);
 COND_SYSCALL(old_msgctl);
 COND_SYSCALL(msgctl);
@@ -214,8 +124,6 @@ COND_SYSCALL(msgrcv);
 COND_SYSCALL_COMPAT(msgrcv);
 COND_SYSCALL(msgsnd);
 COND_SYSCALL_COMPAT(msgsnd);
-
-/* ipc/sem.c */
 COND_SYSCALL(semget);
 COND_SYSCALL(old_semctl);
 COND_SYSCALL(semctl);
@@ -224,8 +132,6 @@ COND_SYSCALL_COMPAT(old_semctl);
 COND_SYSCALL(semtimedop);
 COND_SYSCALL(semtimedop_time32);
 COND_SYSCALL(semop);
-
-/* ipc/shm.c */
 COND_SYSCALL(shmget);
 COND_SYSCALL(old_shmctl);
 COND_SYSCALL(shmctl);
@@ -234,8 +140,6 @@ COND_SYSCALL_COMPAT(old_shmctl);
 COND_SYSCALL(shmat);
 COND_SYSCALL_COMPAT(shmat);
 COND_SYSCALL(shmdt);
-
-/* net/socket.c */
 COND_SYSCALL(socket);
 COND_SYSCALL(socketpair);
 COND_SYSCALL(bind);
@@ -256,30 +160,18 @@ COND_SYSCALL(sendmsg);
 COND_SYSCALL_COMPAT(sendmsg);
 COND_SYSCALL(recvmsg);
 COND_SYSCALL_COMPAT(recvmsg);
-
-/* mm/filemap.c */
-
-/* mm/nommu.c, also with MMU */
 COND_SYSCALL(mremap);
-
-/* security/keys/keyctl.c */
 COND_SYSCALL(add_key);
 COND_SYSCALL(request_key);
 COND_SYSCALL(keyctl);
 COND_SYSCALL_COMPAT(keyctl);
-
-/* security/landlock/syscalls.c */
 COND_SYSCALL(landlock_create_ruleset);
 COND_SYSCALL(landlock_add_rule);
 COND_SYSCALL(landlock_restrict_self);
-
-/* arch/example/kernel/sys_example.c */
-
-/* mm/fadvise.c */
 COND_SYSCALL(fadvise64_64);
 COND_SYSCALL_COMPAT(fadvise64_64);
 
-/* mm/, CONFIG_MMU only */
+/* CONFIG_MMU only */
 COND_SYSCALL(swapon);
 COND_SYSCALL(swapoff);
 COND_SYSCALL(mprotect);
diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 45fa180cc56a..dd7d8e10f16d 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -38,12 +38,12 @@ __SYSCALL(__NR_io_destroy, sys_io_destroy)
 __SC_COMP(__NR_io_submit, sys_io_submit, compat_sys_io_submit)
 #define __NR_io_cancel 3
 __SYSCALL(__NR_io_cancel, sys_io_cancel)
+
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_io_getevents 4
 __SC_3264(__NR_io_getevents, sys_io_getevents_time32, sys_io_getevents)
 #endif
 
-/* fs/xattr.c */
 #define __NR_setxattr 5
 __SYSCALL(__NR_setxattr, sys_setxattr)
 #define __NR_lsetxattr 6
@@ -68,58 +68,38 @@ __SYSCALL(__NR_removexattr, sys_removexattr)
 __SYSCALL(__NR_lremovexattr, sys_lremovexattr)
 #define __NR_fremovexattr 16
 __SYSCALL(__NR_fremovexattr, sys_fremovexattr)
-
-/* fs/dcache.c */
 #define __NR_getcwd 17
 __SYSCALL(__NR_getcwd, sys_getcwd)
-
-/* fs/cookies.c */
 #define __NR_lookup_dcookie 18
 __SC_COMP(__NR_lookup_dcookie, sys_lookup_dcookie, compat_sys_lookup_dcookie)
-
-/* fs/eventfd.c */
 #define __NR_eventfd2 19
 __SYSCALL(__NR_eventfd2, sys_eventfd2)
-
-/* fs/eventpoll.c */
 #define __NR_epoll_create1 20
 __SYSCALL(__NR_epoll_create1, sys_epoll_create1)
 #define __NR_epoll_ctl 21
 __SYSCALL(__NR_epoll_ctl, sys_epoll_ctl)
 #define __NR_epoll_pwait 22
 __SC_COMP(__NR_epoll_pwait, sys_epoll_pwait, compat_sys_epoll_pwait)
-
-/* fs/fcntl.c */
 #define __NR_dup 23
 __SYSCALL(__NR_dup, sys_dup)
 #define __NR_dup3 24
 __SYSCALL(__NR_dup3, sys_dup3)
 #define __NR3264_fcntl 25
 __SC_COMP_3264(__NR3264_fcntl, sys_fcntl64, sys_fcntl, compat_sys_fcntl64)
-
-/* fs/inotify_user.c */
 #define __NR_inotify_init1 26
 __SYSCALL(__NR_inotify_init1, sys_inotify_init1)
 #define __NR_inotify_add_watch 27
 __SYSCALL(__NR_inotify_add_watch, sys_inotify_add_watch)
 #define __NR_inotify_rm_watch 28
 __SYSCALL(__NR_inotify_rm_watch, sys_inotify_rm_watch)
-
-/* fs/ioctl.c */
 #define __NR_ioctl 29
 __SC_COMP(__NR_ioctl, sys_ioctl, compat_sys_ioctl)
-
-/* fs/ioprio.c */
 #define __NR_ioprio_set 30
 __SYSCALL(__NR_ioprio_set, sys_ioprio_set)
 #define __NR_ioprio_get 31
 __SYSCALL(__NR_ioprio_get, sys_ioprio_get)
-
-/* fs/locks.c */
 #define __NR_flock 32
 __SYSCALL(__NR_flock, sys_flock)
-
-/* fs/namei.c */
 #define __NR_mknodat 33
 __SYSCALL(__NR_mknodat, sys_mknodat)
 #define __NR_mkdirat 34
@@ -130,25 +110,21 @@ __SYSCALL(__NR_unlinkat, sys_unlinkat)
 __SYSCALL(__NR_symlinkat, sys_symlinkat)
 #define __NR_linkat 37
 __SYSCALL(__NR_linkat, sys_linkat)
+
 #ifdef __ARCH_WANT_RENAMEAT
 /* renameat is superseded with flags by renameat2 */
 #define __NR_renameat 38
 __SYSCALL(__NR_renameat, sys_renameat)
 #endif /* __ARCH_WANT_RENAMEAT */
 
-/* fs/namespace.c */
 #define __NR_umount2 39
 __SYSCALL(__NR_umount2, sys_umount)
 #define __NR_mount 40
 __SYSCALL(__NR_mount, sys_mount)
 #define __NR_pivot_root 41
 __SYSCALL(__NR_pivot_root, sys_pivot_root)
-
-/* fs/nfsctl.c */
 #define __NR_nfsservctl 42
 __SYSCALL(__NR_nfsservctl, sys_ni_syscall)
-
-/* fs/open.c */
 #define __NR3264_statfs 43
 __SC_COMP_3264(__NR3264_statfs, sys_statfs64, sys_statfs, \
 	       compat_sys_statfs64)
@@ -161,7 +137,6 @@ __SC_COMP_3264(__NR3264_truncate, sys_truncate64, sys_truncate, \
 #define __NR3264_ftruncate 46
 __SC_COMP_3264(__NR3264_ftruncate, sys_ftruncate64, sys_ftruncate, \
 	       compat_sys_ftruncate64)
-
 #define __NR_fallocate 47
 __SC_COMP(__NR_fallocate, sys_fallocate, compat_sys_fallocate)
 #define __NR_faccessat 48
@@ -186,20 +161,12 @@ __SYSCALL(__NR_openat, sys_openat)
 __SYSCALL(__NR_close, sys_close)
 #define __NR_vhangup 58
 __SYSCALL(__NR_vhangup, sys_vhangup)
-
-/* fs/pipe.c */
 #define __NR_pipe2 59
 __SYSCALL(__NR_pipe2, sys_pipe2)
-
-/* fs/quota.c */
 #define __NR_quotactl 60
 __SYSCALL(__NR_quotactl, sys_quotactl)
-
-/* fs/readdir.c */
 #define __NR_getdents64 61
 __SYSCALL(__NR_getdents64, sys_getdents64)
-
-/* fs/read_write.c */
 #define __NR3264_lseek 62
 __SC_3264(__NR3264_lseek, sys_llseek, sys_lseek)
 #define __NR_read 63
@@ -218,12 +185,9 @@ __SC_COMP(__NR_pwrite64, sys_pwrite64, compat_sys_pwrite64)
 __SC_COMP(__NR_preadv, sys_preadv, compat_sys_preadv)
 #define __NR_pwritev 70
 __SC_COMP(__NR_pwritev, sys_pwritev, compat_sys_pwritev)
-
-/* fs/sendfile.c */
 #define __NR3264_sendfile 71
 __SYSCALL(__NR3264_sendfile, sys_sendfile64)
 
-/* fs/select.c */
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_pselect6 72
 __SC_COMP_3264(__NR_pselect6, sys_pselect6_time32, sys_pselect6, compat_sys_pselect6_time32)
@@ -231,21 +195,17 @@ __SC_COMP_3264(__NR_pselect6, sys_pselect6_time32, sys_pselect6, compat_sys_psel
 __SC_COMP_3264(__NR_ppoll, sys_ppoll_time32, sys_ppoll, compat_sys_ppoll_time32)
 #endif
 
-/* fs/signalfd.c */
 #define __NR_signalfd4 74
 __SC_COMP(__NR_signalfd4, sys_signalfd4, compat_sys_signalfd4)
-
-/* fs/splice.c */
 #define __NR_vmsplice 75
 __SYSCALL(__NR_vmsplice, sys_vmsplice)
 #define __NR_splice 76
 __SYSCALL(__NR_splice, sys_splice)
 #define __NR_tee 77
 __SYSCALL(__NR_tee, sys_tee)
-
-/* fs/stat.c */
 #define __NR_readlinkat 78
 __SYSCALL(__NR_readlinkat, sys_readlinkat)
+
 #if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
 #define __NR3264_fstatat 79
 __SC_3264(__NR3264_fstatat, sys_fstatat64, sys_newfstatat)
@@ -253,13 +213,13 @@ __SC_3264(__NR3264_fstatat, sys_fstatat64, sys_newfstatat)
 __SC_3264(__NR3264_fstat, sys_fstat64, sys_newfstat)
 #endif
 
-/* fs/sync.c */
 #define __NR_sync 81
 __SYSCALL(__NR_sync, sys_sync)
 #define __NR_fsync 82
 __SYSCALL(__NR_fsync, sys_fsync)
 #define __NR_fdatasync 83
 __SYSCALL(__NR_fdatasync, sys_fdatasync)
+
 #ifdef __ARCH_WANT_SYNC_FILE_RANGE2
 #define __NR_sync_file_range2 84
 __SC_COMP(__NR_sync_file_range2, sys_sync_file_range2, \
@@ -270,9 +230,9 @@ __SC_COMP(__NR_sync_file_range, sys_sync_file_range, \
 	  compat_sys_sync_file_range)
 #endif
 
-/* fs/timerfd.c */
 #define __NR_timerfd_create 85
 __SYSCALL(__NR_timerfd_create, sys_timerfd_create)
+
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_timerfd_settime 86
 __SC_3264(__NR_timerfd_settime, sys_timerfd_settime32, \
@@ -282,45 +242,35 @@ __SC_3264(__NR_timerfd_gettime, sys_timerfd_gettime32, \
 	  sys_timerfd_gettime)
 #endif
 
-/* fs/utimes.c */
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_utimensat 88
 __SC_3264(__NR_utimensat, sys_utimensat_time32, sys_utimensat)
 #endif
 
-/* kernel/acct.c */
 #define __NR_acct 89
 __SYSCALL(__NR_acct, sys_acct)
-
-/* kernel/capability.c */
 #define __NR_capget 90
 __SYSCALL(__NR_capget, sys_capget)
 #define __NR_capset 91
 __SYSCALL(__NR_capset, sys_capset)
-
-/* kernel/exec_domain.c */
 #define __NR_personality 92
 __SYSCALL(__NR_personality, sys_personality)
-
-/* kernel/exit.c */
 #define __NR_exit 93
 __SYSCALL(__NR_exit, sys_exit)
 #define __NR_exit_group 94
 __SYSCALL(__NR_exit_group, sys_exit_group)
 #define __NR_waitid 95
 __SC_COMP(__NR_waitid, sys_waitid, compat_sys_waitid)
-
-/* kernel/fork.c */
 #define __NR_set_tid_address 96
 __SYSCALL(__NR_set_tid_address, sys_set_tid_address)
 #define __NR_unshare 97
 __SYSCALL(__NR_unshare, sys_unshare)
 
-/* kernel/futex.c */
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_futex 98
 __SC_3264(__NR_futex, sys_futex_time32, sys_futex)
 #endif
+
 #define __NR_set_robust_list 99
 __SC_COMP(__NR_set_robust_list, sys_set_robust_list, \
 	  compat_sys_set_robust_list)
@@ -328,43 +278,40 @@ __SC_COMP(__NR_set_robust_list, sys_set_robust_list, \
 __SC_COMP(__NR_get_robust_list, sys_get_robust_list, \
 	  compat_sys_get_robust_list)
 
-/* kernel/hrtimer.c */
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_nanosleep 101
 __SC_3264(__NR_nanosleep, sys_nanosleep_time32, sys_nanosleep)
 #endif
 
-/* kernel/itimer.c */
 #define __NR_getitimer 102
 __SC_COMP(__NR_getitimer, sys_getitimer, compat_sys_getitimer)
 #define __NR_setitimer 103
 __SC_COMP(__NR_setitimer, sys_setitimer, compat_sys_setitimer)
-
-/* kernel/kexec.c */
 #define __NR_kexec_load 104
 __SC_COMP(__NR_kexec_load, sys_kexec_load, compat_sys_kexec_load)
-
-/* kernel/module.c */
 #define __NR_init_module 105
 __SYSCALL(__NR_init_module, sys_init_module)
 #define __NR_delete_module 106
 __SYSCALL(__NR_delete_module, sys_delete_module)
-
-/* kernel/posix-timers.c */
 #define __NR_timer_create 107
 __SC_COMP(__NR_timer_create, sys_timer_create, compat_sys_timer_create)
+
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_timer_gettime 108
 __SC_3264(__NR_timer_gettime, sys_timer_gettime32, sys_timer_gettime)
 #endif
+
 #define __NR_timer_getoverrun 109
 __SYSCALL(__NR_timer_getoverrun, sys_timer_getoverrun)
+
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_timer_settime 110
 __SC_3264(__NR_timer_settime, sys_timer_settime32, sys_timer_settime)
 #endif
+
 #define __NR_timer_delete 111
 __SYSCALL(__NR_timer_delete, sys_timer_delete)
+
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_clock_settime 112
 __SC_3264(__NR_clock_settime, sys_clock_settime32, sys_clock_settime)
@@ -377,15 +324,10 @@ __SC_3264(__NR_clock_nanosleep, sys_clock_nanosleep_time32, \
 	  sys_clock_nanosleep)
 #endif
 
-/* kernel/printk.c */
 #define __NR_syslog 116
 __SYSCALL(__NR_syslog, sys_syslog)
-
-/* kernel/ptrace.c */
 #define __NR_ptrace 117
 __SC_COMP(__NR_ptrace, sys_ptrace, compat_sys_ptrace)
-
-/* kernel/sched/core.c */
 #define __NR_sched_setparam 118
 __SYSCALL(__NR_sched_setparam, sys_sched_setparam)
 #define __NR_sched_setscheduler 119
@@ -406,13 +348,13 @@ __SYSCALL(__NR_sched_yield, sys_sched_yield)
 __SYSCALL(__NR_sched_get_priority_max, sys_sched_get_priority_max)
 #define __NR_sched_get_priority_min 126
 __SYSCALL(__NR_sched_get_priority_min, sys_sched_get_priority_min)
+
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_sched_rr_get_interval 127
 __SC_3264(__NR_sched_rr_get_interval, sys_sched_rr_get_interval_time32, \
 	  sys_sched_rr_get_interval)
 #endif
 
-/* kernel/signal.c */
 #define __NR_restart_syscall 128
 __SYSCALL(__NR_restart_syscall, sys_restart_syscall)
 #define __NR_kill 129
@@ -431,18 +373,18 @@ __SC_COMP(__NR_rt_sigaction, sys_rt_sigaction, compat_sys_rt_sigaction)
 __SC_COMP(__NR_rt_sigprocmask, sys_rt_sigprocmask, compat_sys_rt_sigprocmask)
 #define __NR_rt_sigpending 136
 __SC_COMP(__NR_rt_sigpending, sys_rt_sigpending, compat_sys_rt_sigpending)
+
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_rt_sigtimedwait 137
 __SC_COMP_3264(__NR_rt_sigtimedwait, sys_rt_sigtimedwait_time32, \
 	  sys_rt_sigtimedwait, compat_sys_rt_sigtimedwait_time32)
 #endif
+
 #define __NR_rt_sigqueueinfo 138
 __SC_COMP(__NR_rt_sigqueueinfo, sys_rt_sigqueueinfo, \
 	  compat_sys_rt_sigqueueinfo)
 #define __NR_rt_sigreturn 139
 __SC_COMP(__NR_rt_sigreturn, sys_rt_sigreturn, compat_sys_rt_sigreturn)
-
-/* kernel/sys.c */
 #define __NR_setpriority 140
 __SYSCALL(__NR_setpriority, sys_setpriority)
 #define __NR_getpriority 141
@@ -507,7 +449,6 @@ __SYSCALL(__NR_prctl, sys_prctl)
 #define __NR_getcpu 168
 __SYSCALL(__NR_getcpu, sys_getcpu)
 
-/* kernel/time.c */
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_gettimeofday 169
 __SC_COMP(__NR_gettimeofday, sys_gettimeofday, compat_sys_gettimeofday)
@@ -517,7 +458,6 @@ __SC_COMP(__NR_settimeofday, sys_settimeofday, compat_sys_settimeofday)
 __SC_3264(__NR_adjtimex, sys_adjtimex_time32, sys_adjtimex)
 #endif
 
-/* kernel/sys.c */
 #define __NR_getpid 172
 __SYSCALL(__NR_getpid, sys_getpid)
 #define __NR_getppid 173
@@ -534,12 +474,11 @@ __SYSCALL(__NR_getegid, sys_getegid)
 __SYSCALL(__NR_gettid, sys_gettid)
 #define __NR_sysinfo 179
 __SC_COMP(__NR_sysinfo, sys_sysinfo, compat_sys_sysinfo)
-
-/* ipc/mqueue.c */
 #define __NR_mq_open 180
 __SC_COMP(__NR_mq_open, sys_mq_open, compat_sys_mq_open)
 #define __NR_mq_unlink 181
 __SYSCALL(__NR_mq_unlink, sys_mq_unlink)
+
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_mq_timedsend 182
 __SC_3264(__NR_mq_timedsend, sys_mq_timedsend_time32, sys_mq_timedsend)
@@ -547,12 +486,11 @@ __SC_3264(__NR_mq_timedsend, sys_mq_timedsend_time32, sys_mq_timedsend)
 __SC_3264(__NR_mq_timedreceive, sys_mq_timedreceive_time32, \
 	  sys_mq_timedreceive)
 #endif
+
 #define __NR_mq_notify 184
 __SC_COMP(__NR_mq_notify, sys_mq_notify, compat_sys_mq_notify)
 #define __NR_mq_getsetattr 185
 __SC_COMP(__NR_mq_getsetattr, sys_mq_getsetattr, compat_sys_mq_getsetattr)
-
-/* ipc/msg.c */
 #define __NR_msgget 186
 __SYSCALL(__NR_msgget, sys_msgget)
 #define __NR_msgctl 187
@@ -561,20 +499,18 @@ __SC_COMP(__NR_msgctl, sys_msgctl, compat_sys_msgctl)
 __SC_COMP(__NR_msgrcv, sys_msgrcv, compat_sys_msgrcv)
 #define __NR_msgsnd 189
 __SC_COMP(__NR_msgsnd, sys_msgsnd, compat_sys_msgsnd)
-
-/* ipc/sem.c */
 #define __NR_semget 190
 __SYSCALL(__NR_semget, sys_semget)
 #define __NR_semctl 191
 __SC_COMP(__NR_semctl, sys_semctl, compat_sys_semctl)
+
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_semtimedop 192
 __SC_3264(__NR_semtimedop, sys_semtimedop_time32, sys_semtimedop)
 #endif
+
 #define __NR_semop 193
 __SYSCALL(__NR_semop, sys_semop)
-
-/* ipc/shm.c */
 #define __NR_shmget 194
 __SYSCALL(__NR_shmget, sys_shmget)
 #define __NR_shmctl 195
@@ -583,8 +519,6 @@ __SC_COMP(__NR_shmctl, sys_shmctl, compat_sys_shmctl)
 __SC_COMP(__NR_shmat, sys_shmat, compat_sys_shmat)
 #define __NR_shmdt 197
 __SYSCALL(__NR_shmdt, sys_shmdt)
-
-/* net/socket.c */
 #define __NR_socket 198
 __SYSCALL(__NR_socket, sys_socket)
 #define __NR_socketpair 199
@@ -615,40 +549,30 @@ __SYSCALL(__NR_shutdown, sys_shutdown)
 __SC_COMP(__NR_sendmsg, sys_sendmsg, compat_sys_sendmsg)
 #define __NR_recvmsg 212
 __SC_COMP(__NR_recvmsg, sys_recvmsg, compat_sys_recvmsg)
-
-/* mm/filemap.c */
 #define __NR_readahead 213
 __SC_COMP(__NR_readahead, sys_readahead, compat_sys_readahead)
-
-/* mm/nommu.c, also with MMU */
 #define __NR_brk 214
 __SYSCALL(__NR_brk, sys_brk)
 #define __NR_munmap 215
 __SYSCALL(__NR_munmap, sys_munmap)
 #define __NR_mremap 216
 __SYSCALL(__NR_mremap, sys_mremap)
-
-/* security/keys/keyctl.c */
 #define __NR_add_key 217
 __SYSCALL(__NR_add_key, sys_add_key)
 #define __NR_request_key 218
 __SYSCALL(__NR_request_key, sys_request_key)
 #define __NR_keyctl 219
 __SC_COMP(__NR_keyctl, sys_keyctl, compat_sys_keyctl)
-
-/* arch/example/kernel/sys_example.c */
 #define __NR_clone 220
 __SYSCALL(__NR_clone, sys_clone)
 #define __NR_execve 221
 __SC_COMP(__NR_execve, sys_execve, compat_sys_execve)
-
 #define __NR3264_mmap 222
 __SC_3264(__NR3264_mmap, sys_mmap2, sys_mmap)
-/* mm/fadvise.c */
 #define __NR3264_fadvise64 223
 __SC_COMP(__NR3264_fadvise64, sys_fadvise64_64, compat_sys_fadvise64_64)
 
-/* mm/, CONFIG_MMU only */
+/* CONFIG_MMU only */
 #ifndef __ARCH_NOMMU
 #define __NR_swapon 224
 __SYSCALL(__NR_swapon, sys_swapon)
@@ -691,6 +615,7 @@ __SC_COMP(__NR_rt_tgsigqueueinfo, sys_rt_tgsigqueueinfo, \
 __SYSCALL(__NR_perf_event_open, sys_perf_event_open)
 #define __NR_accept4 242
 __SYSCALL(__NR_accept4, sys_accept4)
+
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_recvmmsg 243
 __SC_COMP_3264(__NR_recvmmsg, sys_recvmmsg_time32, sys_recvmmsg, compat_sys_recvmmsg_time32)
@@ -706,6 +631,7 @@ __SC_COMP_3264(__NR_recvmmsg, sys_recvmmsg_time32, sys_recvmmsg, compat_sys_recv
 #define __NR_wait4 260
 __SC_COMP(__NR_wait4, sys_wait4, compat_sys_wait4)
 #endif
+
 #define __NR_prlimit64 261
 __SYSCALL(__NR_prlimit64, sys_prlimit64)
 #define __NR_fanotify_init 262
@@ -716,10 +642,12 @@ __SYSCALL(__NR_fanotify_mark, sys_fanotify_mark)
 __SYSCALL(__NR_name_to_handle_at, sys_name_to_handle_at)
 #define __NR_open_by_handle_at         265
 __SYSCALL(__NR_open_by_handle_at, sys_open_by_handle_at)
+
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_clock_adjtime 266
 __SC_3264(__NR_clock_adjtime, sys_clock_adjtime32, sys_clock_adjtime)
 #endif
+
 #define __NR_syncfs 267
 __SYSCALL(__NR_syncfs, sys_syncfs)
 #define __NR_setns 268
@@ -770,15 +698,19 @@ __SYSCALL(__NR_pkey_alloc,    sys_pkey_alloc)
 __SYSCALL(__NR_pkey_free,     sys_pkey_free)
 #define __NR_statx 291
 __SYSCALL(__NR_statx,     sys_statx)
+
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_io_pgetevents 292
 __SC_COMP_3264(__NR_io_pgetevents, sys_io_pgetevents_time32, sys_io_pgetevents, compat_sys_io_pgetevents)
 #endif
+
 #define __NR_rseq 293
 __SYSCALL(__NR_rseq, sys_rseq)
 #define __NR_kexec_file_load 294
 __SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
+
 /* 295 through 402 are unassigned to sync up with generic numbers, don't use */
+
 #if defined(__SYSCALL_COMPAT) || __BITS_PER_LONG == 32
 #define __NR_clock_gettime64 403
 __SYSCALL(__NR_clock_gettime64, sys_clock_gettime)
@@ -844,13 +776,14 @@ __SYSCALL(__NR_fsmount, sys_fsmount)
 __SYSCALL(__NR_fspick, sys_fspick)
 #define __NR_pidfd_open 434
 __SYSCALL(__NR_pidfd_open, sys_pidfd_open)
+
 #ifdef __ARCH_WANT_SYS_CLONE3
 #define __NR_clone3 435
 __SYSCALL(__NR_clone3, sys_clone3)
 #endif
+
 #define __NR_close_range 436
 __SYSCALL(__NR_close_range, sys_close_range)
-
 #define __NR_openat2 437
 __SYSCALL(__NR_openat2, sys_openat2)
 #define __NR_pidfd_getfd 438
@@ -865,7 +798,6 @@ __SC_COMP(__NR_epoll_pwait2, sys_epoll_pwait2, compat_sys_epoll_pwait2)
 __SYSCALL(__NR_mount_setattr, sys_mount_setattr)
 #define __NR_quotactl_fd 443
 __SYSCALL(__NR_quotactl_fd, sys_quotactl_fd)
-
 #define __NR_landlock_create_ruleset 444
 __SYSCALL(__NR_landlock_create_ruleset, sys_landlock_create_ruleset)
 #define __NR_landlock_add_rule 445
@@ -877,12 +809,11 @@ __SYSCALL(__NR_landlock_restrict_self, sys_landlock_restrict_self)
 #define __NR_memfd_secret 447
 __SYSCALL(__NR_memfd_secret, sys_memfd_secret)
 #endif
+
 #define __NR_process_mrelease 448
 __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
-
 #define __NR_futex_waitv 449
 __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
-
 #define __NR_set_mempolicy_home_node 450
 __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 
-- 
2.34.1

