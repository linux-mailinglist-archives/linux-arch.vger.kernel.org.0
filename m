Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3AC73382A
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jun 2023 20:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjFPSco (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Jun 2023 14:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjFPScn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Jun 2023 14:32:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DC01FD5;
        Fri, 16 Jun 2023 11:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686940361; x=1718476361;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tper6WBGtN45xcFTk83HOawz3cY+JsxWPECyDAmcnDU=;
  b=kr3Oj+wylZwCRA8D0+riKn446juzY9euBhfgNuDM989SmWvBqCRLnqh2
   2V3b/bQJtsMN3ruKcqgcy4yJGPTpJlHjmNScDgT0MLyj1KmV/FtTpBV6k
   rAfIF7hSLfHv6heR7y8FswatC7iQSUg5Kx+VYlkfoQTNCWlFClEFvwE5t
   0jZuNS9DeBnTqFd1bgs2uAiRi851wWdJh4sWP61w3POUcuWQKzvm3PgJO
   HfdArwdLoTNU8NDsi0syH1oYu4YqIsXBsMFyUnZDTq82KcqJpXbph800B
   Ur3dmQMIUS8QnUveTHOjFmxKJAImgXoC0XWMSm0+ULjPJ1ViPxJ/0v9Wb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="388071647"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="388071647"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 11:32:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="887194961"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="887194961"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orsmga005.jf.intel.com with ESMTP; 16 Jun 2023 11:32:40 -0700
From:   Sohil Mehta <sohil.mehta@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, Sohil Mehta <sohil.mehta@intel.com>
Subject: [PATCH] syscalls: Fix file path names in the header comments
Date:   Fri, 16 Jun 2023 18:31:20 +0000
Message-Id: <20230616183120.1706378-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Some of the syscall definitions have moved due to the original source
file being moved into a sub-directory. Update the file path names to
reflect that.

A couple of syscalls such as lookup_dcookie() and nfsservctl() don't
have a syscall definition anymore. Clear the filename and leave the
original subsystem name intact for reference.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---

Arguably, having filenames in comments might not be the best idea.  If the
intention is to make it easier to find a syscall definition, it is probably
faster to just use 'git grep SYSCALL_DEFINE | grep <syscall_name>'.  Please let
me know if it would be preferable to just get rid of these comments all
together.

---
 include/linux/compat.h                  | 12 ++++++------
 include/linux/syscalls.h                | 24 +++++++++++------------
 include/uapi/asm-generic/unistd.h       | 24 +++++++++++------------
 kernel/sys_ni.c                         | 26 +++++++++++--------------
 tools/include/uapi/asm-generic/unistd.h | 24 +++++++++++------------
 5 files changed, 52 insertions(+), 58 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 44b1736c95b5..21a659870f7f 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -582,7 +582,7 @@ asmlinkage long compat_sys_io_pgetevents_time64(compat_aio_context_t ctx_id,
 					struct __kernel_timespec __user *timeout,
 					const struct __compat_aio_sigset __user *usig);
 
-/* fs/cookies.c */
+/* fs/ */
 asmlinkage long compat_sys_lookup_dcookie(u32, u32, char __user *, compat_size_t);
 
 /* fs/eventpoll.c */
@@ -650,7 +650,7 @@ asmlinkage long compat_sys_pwritev64(unsigned long fd,
 		unsigned long vlen, loff_t pos);
 #endif
 
-/* fs/sendfile.c */
+/* fs/read_write.c */
 asmlinkage long compat_sys_sendfile(int out_fd, int in_fd,
 				    compat_off_t __user *offset, compat_size_t count);
 asmlinkage long compat_sys_sendfile64(int out_fd, int in_fd,
@@ -708,7 +708,7 @@ asmlinkage long
 compat_sys_get_robust_list(int pid, compat_uptr_t __user *head_ptr,
 			   compat_size_t __user *len_ptr);
 
-/* kernel/itimer.c */
+/* kernel/time/itimer.c */
 asmlinkage long compat_sys_getitimer(int which,
 				     struct old_itimerval32 __user *it);
 asmlinkage long compat_sys_setitimer(int which,
@@ -721,7 +721,7 @@ asmlinkage long compat_sys_kexec_load(compat_ulong_t entry,
 				      struct compat_kexec_segment __user *,
 				      compat_ulong_t flags);
 
-/* kernel/posix-timers.c */
+/* kernel/time/posix-timers.c */
 asmlinkage long compat_sys_timer_create(clockid_t which_clock,
 			struct compat_sigevent __user *timer_event_spec,
 			timer_t __user *created_timer_id);
@@ -772,13 +772,13 @@ asmlinkage long compat_sys_setrlimit(unsigned int resource,
 				     struct compat_rlimit __user *rlim);
 asmlinkage long compat_sys_getrusage(int who, struct compat_rusage __user *ru);
 
-/* kernel/time.c */
+/* kernel/time/time.c */
 asmlinkage long compat_sys_gettimeofday(struct old_timeval32 __user *tv,
 		struct timezone __user *tz);
 asmlinkage long compat_sys_settimeofday(struct old_timeval32 __user *tv,
 		struct timezone __user *tz);
 
-/* kernel/timer.c */
+/* kernel/sys.c */
 asmlinkage long compat_sys_sysinfo(struct compat_sysinfo __user *info);
 
 /* ipc/mqueue.c */
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 33a0ee3bcb2e..c53688211f5c 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -374,7 +374,7 @@ asmlinkage long sys_fremovexattr(int fd, const char __user *name);
 /* fs/dcache.c */
 asmlinkage long sys_getcwd(char __user *buf, unsigned long size);
 
-/* fs/cookies.c */
+/* fs/ */
 asmlinkage long sys_lookup_dcookie(u64 cookie64, char __user *buf, size_t len);
 
 /* fs/eventfd.c */
@@ -403,7 +403,7 @@ asmlinkage long sys_fcntl64(unsigned int fd,
 				unsigned int cmd, unsigned long arg);
 #endif
 
-/* fs/inotify_user.c */
+/* fs/notify/inotify/inotify_user.c */
 asmlinkage long sys_inotify_init1(int flags);
 asmlinkage long sys_inotify_add_watch(int fd, const char __user *path,
 					u32 mask);
@@ -413,7 +413,7 @@ asmlinkage long sys_inotify_rm_watch(int fd, __s32 wd);
 asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd,
 				unsigned long arg);
 
-/* fs/ioprio.c */
+/* block/ioprio.c */
 asmlinkage long sys_ioprio_set(int which, int who, int ioprio);
 asmlinkage long sys_ioprio_get(int which, int who);
 
@@ -440,8 +440,6 @@ asmlinkage long sys_mount(char __user *dev_name, char __user *dir_name,
 asmlinkage long sys_pivot_root(const char __user *new_root,
 				const char __user *put_old);
 
-/* fs/nfsctl.c */
-
 /* fs/open.c */
 asmlinkage long sys_statfs(const char __user * path,
 				struct statfs __user *buf);
@@ -481,7 +479,7 @@ asmlinkage long sys_vhangup(void);
 /* fs/pipe.c */
 asmlinkage long sys_pipe2(int __user *fildes, int flags);
 
-/* fs/quota.c */
+/* fs/quota/quota.c */
 asmlinkage long sys_quotactl(unsigned int cmd, const char __user *special,
 				qid_t id, void __user *addr);
 asmlinkage long sys_quotactl_fd(unsigned int fd, unsigned int cmd, qid_t id,
@@ -516,7 +514,7 @@ asmlinkage long sys_preadv(unsigned long fd, const struct iovec __user *vec,
 asmlinkage long sys_pwritev(unsigned long fd, const struct iovec __user *vec,
 			    unsigned long vlen, unsigned long pos_l, unsigned long pos_h);
 
-/* fs/sendfile.c */
+/* fs/read_write.c */
 asmlinkage long sys_sendfile64(int out_fd, int in_fd,
 			       loff_t __user *offset, size_t count);
 
@@ -626,13 +624,13 @@ asmlinkage long sys_futex_waitv(struct futex_waitv *waiters,
 				unsigned int nr_futexes, unsigned int flags,
 				struct __kernel_timespec __user *timeout, clockid_t clockid);
 
-/* kernel/hrtimer.c */
+/* kernel/time/hrtimer.c */
 asmlinkage long sys_nanosleep(struct __kernel_timespec __user *rqtp,
 			      struct __kernel_timespec __user *rmtp);
 asmlinkage long sys_nanosleep_time32(struct old_timespec32 __user *rqtp,
 				     struct old_timespec32 __user *rmtp);
 
-/* kernel/itimer.c */
+/* kernel/time/itimer.c */
 asmlinkage long sys_getitimer(int which, struct __kernel_old_itimerval __user *value);
 asmlinkage long sys_setitimer(int which,
 				struct __kernel_old_itimerval __user *value,
@@ -643,13 +641,13 @@ asmlinkage long sys_kexec_load(unsigned long entry, unsigned long nr_segments,
 				struct kexec_segment __user *segments,
 				unsigned long flags);
 
-/* kernel/module.c */
+/* kernel/module/main.c */
 asmlinkage long sys_init_module(void __user *umod, unsigned long len,
 				const char __user *uargs);
 asmlinkage long sys_delete_module(const char __user *name_user,
 				unsigned int flags);
 
-/* kernel/posix-timers.c */
+/* kernel/time/posix-timers.c */
 asmlinkage long sys_timer_create(clockid_t which_clock,
 				 struct sigevent __user *timer_event_spec,
 				 timer_t __user * created_timer_id);
@@ -684,7 +682,7 @@ asmlinkage long sys_clock_nanosleep_time32(clockid_t which_clock, int flags,
 				struct old_timespec32 __user *rqtp,
 				struct old_timespec32 __user *rmtp);
 
-/* kernel/printk.c */
+/* kernel/printk/printk.c */
 asmlinkage long sys_syslog(int type, char __user *buf, int len);
 
 /* kernel/ptrace.c */
@@ -773,7 +771,7 @@ asmlinkage long sys_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 asmlinkage long sys_getcpu(unsigned __user *cpu, unsigned __user *node, struct getcpu_cache __user *cache);
 
-/* kernel/time.c */
+/* kernel/time/time.c */
 asmlinkage long sys_gettimeofday(struct __kernel_old_timeval __user *tv,
 				struct timezone __user *tz);
 asmlinkage long sys_settimeofday(struct __kernel_old_timeval __user *tv,
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 45fa180cc56a..77dc4259dcc1 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -73,7 +73,7 @@ __SYSCALL(__NR_fremovexattr, sys_fremovexattr)
 #define __NR_getcwd 17
 __SYSCALL(__NR_getcwd, sys_getcwd)
 
-/* fs/cookies.c */
+/* fs/ */
 #define __NR_lookup_dcookie 18
 __SC_COMP(__NR_lookup_dcookie, sys_lookup_dcookie, compat_sys_lookup_dcookie)
 
@@ -97,7 +97,7 @@ __SYSCALL(__NR_dup3, sys_dup3)
 #define __NR3264_fcntl 25
 __SC_COMP_3264(__NR3264_fcntl, sys_fcntl64, sys_fcntl, compat_sys_fcntl64)
 
-/* fs/inotify_user.c */
+/* fs/notify/inotify/inotify_user.c */
 #define __NR_inotify_init1 26
 __SYSCALL(__NR_inotify_init1, sys_inotify_init1)
 #define __NR_inotify_add_watch 27
@@ -109,7 +109,7 @@ __SYSCALL(__NR_inotify_rm_watch, sys_inotify_rm_watch)
 #define __NR_ioctl 29
 __SC_COMP(__NR_ioctl, sys_ioctl, compat_sys_ioctl)
 
-/* fs/ioprio.c */
+/* block/ioprio.c */
 #define __NR_ioprio_set 30
 __SYSCALL(__NR_ioprio_set, sys_ioprio_set)
 #define __NR_ioprio_get 31
@@ -144,7 +144,7 @@ __SYSCALL(__NR_mount, sys_mount)
 #define __NR_pivot_root 41
 __SYSCALL(__NR_pivot_root, sys_pivot_root)
 
-/* fs/nfsctl.c */
+/* fs/ */
 #define __NR_nfsservctl 42
 __SYSCALL(__NR_nfsservctl, sys_ni_syscall)
 
@@ -191,7 +191,7 @@ __SYSCALL(__NR_vhangup, sys_vhangup)
 #define __NR_pipe2 59
 __SYSCALL(__NR_pipe2, sys_pipe2)
 
-/* fs/quota.c */
+/* fs/quota/quota.c */
 #define __NR_quotactl 60
 __SYSCALL(__NR_quotactl, sys_quotactl)
 
@@ -219,7 +219,7 @@ __SC_COMP(__NR_preadv, sys_preadv, compat_sys_preadv)
 #define __NR_pwritev 70
 __SC_COMP(__NR_pwritev, sys_pwritev, compat_sys_pwritev)
 
-/* fs/sendfile.c */
+/* fs/read_write.c */
 #define __NR3264_sendfile 71
 __SYSCALL(__NR3264_sendfile, sys_sendfile64)
 
@@ -328,13 +328,13 @@ __SC_COMP(__NR_set_robust_list, sys_set_robust_list, \
 __SC_COMP(__NR_get_robust_list, sys_get_robust_list, \
 	  compat_sys_get_robust_list)
 
-/* kernel/hrtimer.c */
+/* kernel/time/hrtimer.c */
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_nanosleep 101
 __SC_3264(__NR_nanosleep, sys_nanosleep_time32, sys_nanosleep)
 #endif
 
-/* kernel/itimer.c */
+/* kernel/time/itimer.c */
 #define __NR_getitimer 102
 __SC_COMP(__NR_getitimer, sys_getitimer, compat_sys_getitimer)
 #define __NR_setitimer 103
@@ -344,13 +344,13 @@ __SC_COMP(__NR_setitimer, sys_setitimer, compat_sys_setitimer)
 #define __NR_kexec_load 104
 __SC_COMP(__NR_kexec_load, sys_kexec_load, compat_sys_kexec_load)
 
-/* kernel/module.c */
+/* kernel/module/main.c */
 #define __NR_init_module 105
 __SYSCALL(__NR_init_module, sys_init_module)
 #define __NR_delete_module 106
 __SYSCALL(__NR_delete_module, sys_delete_module)
 
-/* kernel/posix-timers.c */
+/* kernel/time/posix-timers.c */
 #define __NR_timer_create 107
 __SC_COMP(__NR_timer_create, sys_timer_create, compat_sys_timer_create)
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
@@ -377,7 +377,7 @@ __SC_3264(__NR_clock_nanosleep, sys_clock_nanosleep_time32, \
 	  sys_clock_nanosleep)
 #endif
 
-/* kernel/printk.c */
+/* kernel/printk/printk.c */
 #define __NR_syslog 116
 __SYSCALL(__NR_syslog, sys_syslog)
 
@@ -507,7 +507,7 @@ __SYSCALL(__NR_prctl, sys_prctl)
 #define __NR_getcpu 168
 __SYSCALL(__NR_getcpu, sys_getcpu)
 
-/* kernel/time.c */
+/* kernel/time/time.c */
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_gettimeofday 169
 __SC_COMP(__NR_gettimeofday, sys_gettimeofday, compat_sys_gettimeofday)
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 860b2dcf3ac4..d64be96409d2 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -56,7 +56,7 @@ COND_SYSCALL(io_uring_register);
 
 /* fs/dcache.c */
 
-/* fs/cookies.c */
+/* fs/ */
 COND_SYSCALL(lookup_dcookie);
 COND_SYSCALL_COMPAT(lookup_dcookie);
 
@@ -73,14 +73,14 @@ COND_SYSCALL_COMPAT(epoll_pwait2);
 
 /* fs/fcntl.c */
 
-/* fs/inotify_user.c */
+/* fs/notify/inotify/inotify_user.c */
 COND_SYSCALL(inotify_init1);
 COND_SYSCALL(inotify_add_watch);
 COND_SYSCALL(inotify_rm_watch);
 
 /* fs/ioctl.c */
 
-/* fs/ioprio.c */
+/* block/ioprio.c */
 COND_SYSCALL(ioprio_set);
 COND_SYSCALL(ioprio_get);
 
@@ -91,13 +91,11 @@ COND_SYSCALL(flock);
 
 /* fs/namespace.c */
 
-/* fs/nfsctl.c */
-
 /* fs/open.c */
 
 /* fs/pipe.c */
 
-/* fs/quota.c */
+/* fs/quota/quota.c */
 COND_SYSCALL(quotactl);
 COND_SYSCALL(quotactl_fd);
 
@@ -105,8 +103,6 @@ COND_SYSCALL(quotactl_fd);
 
 /* fs/read_write.c */
 
-/* fs/sendfile.c */
-
 /* fs/select.c */
 
 /* fs/signalfd.c */
@@ -152,21 +148,21 @@ COND_SYSCALL(get_robust_list);
 COND_SYSCALL_COMPAT(get_robust_list);
 COND_SYSCALL(futex_waitv);
 
-/* kernel/hrtimer.c */
+/* kernel/time/hrtimer.c */
 
-/* kernel/itimer.c */
+/* kernel/time/itimer.c */
 
 /* kernel/kexec.c */
 COND_SYSCALL(kexec_load);
 COND_SYSCALL_COMPAT(kexec_load);
 
-/* kernel/module.c */
+/* kernel/module/main.c */
 COND_SYSCALL(init_module);
 COND_SYSCALL(delete_module);
 
-/* kernel/posix-timers.c */
+/* kernel/time/posix-timers.c */
 
-/* kernel/printk.c */
+/* kernel/printk/printk.c */
 COND_SYSCALL(syslog);
 
 /* kernel/ptrace.c */
@@ -187,9 +183,9 @@ COND_SYSCALL(setfsgid);
 COND_SYSCALL(setgroups);
 COND_SYSCALL(getgroups);
 
-/* kernel/time.c */
+/* kernel/time/time.c */
 
-/* kernel/timer.c */
+/* kernel/time/timer.c */
 
 /* ipc/mqueue.c */
 COND_SYSCALL(mq_open);
diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 45fa180cc56a..77dc4259dcc1 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -73,7 +73,7 @@ __SYSCALL(__NR_fremovexattr, sys_fremovexattr)
 #define __NR_getcwd 17
 __SYSCALL(__NR_getcwd, sys_getcwd)
 
-/* fs/cookies.c */
+/* fs/ */
 #define __NR_lookup_dcookie 18
 __SC_COMP(__NR_lookup_dcookie, sys_lookup_dcookie, compat_sys_lookup_dcookie)
 
@@ -97,7 +97,7 @@ __SYSCALL(__NR_dup3, sys_dup3)
 #define __NR3264_fcntl 25
 __SC_COMP_3264(__NR3264_fcntl, sys_fcntl64, sys_fcntl, compat_sys_fcntl64)
 
-/* fs/inotify_user.c */
+/* fs/notify/inotify/inotify_user.c */
 #define __NR_inotify_init1 26
 __SYSCALL(__NR_inotify_init1, sys_inotify_init1)
 #define __NR_inotify_add_watch 27
@@ -109,7 +109,7 @@ __SYSCALL(__NR_inotify_rm_watch, sys_inotify_rm_watch)
 #define __NR_ioctl 29
 __SC_COMP(__NR_ioctl, sys_ioctl, compat_sys_ioctl)
 
-/* fs/ioprio.c */
+/* block/ioprio.c */
 #define __NR_ioprio_set 30
 __SYSCALL(__NR_ioprio_set, sys_ioprio_set)
 #define __NR_ioprio_get 31
@@ -144,7 +144,7 @@ __SYSCALL(__NR_mount, sys_mount)
 #define __NR_pivot_root 41
 __SYSCALL(__NR_pivot_root, sys_pivot_root)
 
-/* fs/nfsctl.c */
+/* fs/ */
 #define __NR_nfsservctl 42
 __SYSCALL(__NR_nfsservctl, sys_ni_syscall)
 
@@ -191,7 +191,7 @@ __SYSCALL(__NR_vhangup, sys_vhangup)
 #define __NR_pipe2 59
 __SYSCALL(__NR_pipe2, sys_pipe2)
 
-/* fs/quota.c */
+/* fs/quota/quota.c */
 #define __NR_quotactl 60
 __SYSCALL(__NR_quotactl, sys_quotactl)
 
@@ -219,7 +219,7 @@ __SC_COMP(__NR_preadv, sys_preadv, compat_sys_preadv)
 #define __NR_pwritev 70
 __SC_COMP(__NR_pwritev, sys_pwritev, compat_sys_pwritev)
 
-/* fs/sendfile.c */
+/* fs/read_write.c */
 #define __NR3264_sendfile 71
 __SYSCALL(__NR3264_sendfile, sys_sendfile64)
 
@@ -328,13 +328,13 @@ __SC_COMP(__NR_set_robust_list, sys_set_robust_list, \
 __SC_COMP(__NR_get_robust_list, sys_get_robust_list, \
 	  compat_sys_get_robust_list)
 
-/* kernel/hrtimer.c */
+/* kernel/time/hrtimer.c */
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_nanosleep 101
 __SC_3264(__NR_nanosleep, sys_nanosleep_time32, sys_nanosleep)
 #endif
 
-/* kernel/itimer.c */
+/* kernel/time/itimer.c */
 #define __NR_getitimer 102
 __SC_COMP(__NR_getitimer, sys_getitimer, compat_sys_getitimer)
 #define __NR_setitimer 103
@@ -344,13 +344,13 @@ __SC_COMP(__NR_setitimer, sys_setitimer, compat_sys_setitimer)
 #define __NR_kexec_load 104
 __SC_COMP(__NR_kexec_load, sys_kexec_load, compat_sys_kexec_load)
 
-/* kernel/module.c */
+/* kernel/module/main.c */
 #define __NR_init_module 105
 __SYSCALL(__NR_init_module, sys_init_module)
 #define __NR_delete_module 106
 __SYSCALL(__NR_delete_module, sys_delete_module)
 
-/* kernel/posix-timers.c */
+/* kernel/time/posix-timers.c */
 #define __NR_timer_create 107
 __SC_COMP(__NR_timer_create, sys_timer_create, compat_sys_timer_create)
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
@@ -377,7 +377,7 @@ __SC_3264(__NR_clock_nanosleep, sys_clock_nanosleep_time32, \
 	  sys_clock_nanosleep)
 #endif
 
-/* kernel/printk.c */
+/* kernel/printk/printk.c */
 #define __NR_syslog 116
 __SYSCALL(__NR_syslog, sys_syslog)
 
@@ -507,7 +507,7 @@ __SYSCALL(__NR_prctl, sys_prctl)
 #define __NR_getcpu 168
 __SYSCALL(__NR_getcpu, sys_getcpu)
 
-/* kernel/time.c */
+/* kernel/time/time.c */
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_gettimeofday 169
 __SC_COMP(__NR_gettimeofday, sys_gettimeofday, compat_sys_gettimeofday)
-- 
2.34.1

