Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138CF5A01C1
	for <lists+linux-arch@lfdr.de>; Wed, 24 Aug 2022 21:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbiHXTE7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Aug 2022 15:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239332AbiHXTE4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Aug 2022 15:04:56 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8027CDC6;
        Wed, 24 Aug 2022 12:04:51 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id z14-20020a7bc7ce000000b003a5db0388a8so2198408wmk.1;
        Wed, 24 Aug 2022 12:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=KOYj/KZzJyn1yioXAws/79qDD2FxJ/jHzKlCImdU9FU=;
        b=dXvNIiN2Gi97Ctsor+07/oekN8I+zqDMoACbyezEAaFM5lE18+FFdtkFzSwG3kySPV
         P/J0BP9voyB28PBPAL8OdMJzKFNFlwg/RJLFFsWlIv5hm18xVeGH+xrwFFR9qDvq4AJb
         ECaPCMcZCtsALzUrAD6rsHMOSjXQOaTPkwxWbyBfvP2RIRfGr/b3bblpn7n9TLtsCwCw
         pGHHEq8uRkAQW9N+5UEO7tIjSH6fZ3W9DaLJD9bMnWjQOcrqccF01liYEqHlz91LFVu8
         GIc0VeMh/Phs3RDn6pVgC41O/hiB2wFbAJkah9oz29Yhe4//nOJStvq7nItKVPA8YFhm
         VLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=KOYj/KZzJyn1yioXAws/79qDD2FxJ/jHzKlCImdU9FU=;
        b=ImdPP7XawPoicpJzoTmGs7XjnbGr48OyC+ZUFkKqzXQPjXB5Xx4ccJmmK3sE+nxzUp
         B2Rbxdp3v/Nj5vxywnRG5J1Yx5hQEumXzwac4ArLu9vCiH0kx/4e+B+EBrIuMCcagnFP
         F10BgWlr8cXaDh5dPqmnj82MfohLqGKsLuXW/XWQUq5p2gEhe0oXV9udbQC26FBIpGvf
         l5W4/ztxeKLUEw4yAZkIbit2TpglS95dWqpAiJFfZqMxMFcomtBMWJZ8NK9ds5lJk4ZH
         JhYYoetxiyLDSrukxSw99P6vxC7QqZEMiE5f7w6lY3LNYfcEji9WwytCz0N8VVW3nYJ7
         QMQQ==
X-Gm-Message-State: ACgBeo2k853FJZwUh1wr4mj+5G1keB/ey3JqyAO7ONA6YAJqnmHIPyTe
        GXL82F82hanir6svM1Q904szxQ1yRD4=
X-Google-Smtp-Source: AA6agR6VQHOTY393NuoMMDDQWRhnmQAPZlq3y5yma2lRjErFWo3kH+t7olwNFBURFLr8gMguVa8W+A==
X-Received: by 2002:a05:600c:4ed0:b0:3a6:de8:5e7d with SMTP id g16-20020a05600c4ed000b003a60de85e7dmr6067341wmq.181.1661367889798;
        Wed, 24 Aug 2022 12:04:49 -0700 (PDT)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id bj5-20020a0560001e0500b002206203ed3dsm18880799wrb.29.2022.08.24.12.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 12:04:49 -0700 (PDT)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Zack Weinberg <zackw@panix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        glibc <libc-alpha@sourceware.org>, GCC <gcc-patches@gcc.gnu.org>,
        bpf <bpf@vger.kernel.org>, LTP List <ltp@lists.linux.it>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Joseph Myers <joseph@codesourcery.com>,
        Florian Weimer <fweimer@redhat.com>,
        Cyril Hrubis <chrubis@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>
Subject: [PATCH v3] Many pages: Document fixed-width types with ISO C naming
Date:   Wed, 24 Aug 2022 20:55:06 +0200
Message-Id: <20220824185505.56382-1-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20210423230609.13519-1-alx.manpages@gmail.com>
References: <20210423230609.13519-1-alx.manpages@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=73831; i=alx.manpages@gmail.com;
 h=from:subject; bh=a4BBCeCTDoM1KRLlgxL7nrHsRHv+O6LjnlG3ulvLiUo=;
 b=owEBbQKS/ZANAwAKAZ6MGvu+/9syAcsmYgBjBnQH81o4NDFtytykm5+xF4ob9/eZg82NRwyTsman
 vNr4ZG6JAjMEAAEKAB0WIQTqOofwpOugMORd8kCejBr7vv/bMgUCYwZ0BwAKCRCejBr7vv/bMvd1D/
 4kJEiH06UknSAvPn/qUuPNb0rLjIwrJolxqVQEE2DhUK4HhF14+zSsSFPEcQBE03daWD3J9kRnQg8Q
 G1s2lxhjCQkD66E2bNChR5UERvCYHNgtypuYTM7bS+5lQ4eDEf3IxX/MbfcAJQ/akajo7QJbo6IDCZ
 fSHdOV62NV4U5JUaeqyc1lBMSHANvaX2YwO0kCrnexzSEpZi2Oh/RpeCQQcEIeZG5EDq/Axrs3tCgT
 tbnPG6D2W6Y9v2+xfSJqxRTMXqisQQbgpJzZnkWuJCWpheizzcqcxVThsWQX3fj+t+mZuXlh2ikCDi
 S7yHS5OpyWEyNswxRqaZPcmfJbOPB8KWLqyerTi5q+aWjyKbXIsEmv2EeJLyggDJ0tagUgoFQIrYGq
 SeZnXG3K9FwvsVYEpRWo8/9Oz+1qh4h8IXVNFBYvQM0j7H/PTzI5STJLeyH7LB52nqiHvrlzEZQK3A
 yzxmPTz6UA19N7ofS0KMh9YgRPOj273pjuQHOGW3iuT2f6wQq96oeJj7xHbzlRlZoExMS+EeZUIR79
 I0KTrOYbwbU70qzA26RVbvFS8wzeOtmVnQReeKvatcby2kWMhrCwwDrOhps+WtFtesErjhRQAXxguN
 EMY0FA4wMU5omkuYXu5dsUqJ4kwCyHKpxjJnJr9rPSUugl/DRip8yQh2g0PA==
X-Developer-Key: i=alx.manpages@gmail.com; a=openpgp; fpr=A9348594CE31283A826FBDD8D57633D441E25BB5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Kernel __u64 and similar types are ABI-compatible, and mostly
API-compatible with ISO C types.  User-space programmers don't
care about kernel details, and should only use libc types.
Document syscalls and structures provided by the Linux kernel as
if they used libc types.

There's work in the kernel to remove this small API
incompatibility, which is only for pointers or printf specifiers.

Since I couldn't find any structure that uses pointers, there
shouldn't be any issues here.  Also, the only pointer I found was
in a syscall parameter, but since syscall(2) doesn't check its
arguments' types, we're also safe there.

This patch doesn't go without controversy.  Check the discussions
in the links below.

Found with:

$ grep -rn '\b_*[su][8136][624]*\b' man* \
  | grep -v -e /bpf-helpers.7 -e /proc.5 -e /epoll_event.3type -e /wcscmp.3 \
            -e /crypt.3 -e /mempcpy.3 -e /memcmp.3 -e /string.3 -e /wcsncmp.3 \
            -e /wcscasecmp.3 -e /wmemcmp.3 -e /strcasecmp.3 -e /bcmp.3 \
            -e /bstring.3 -e /endian.3 -e /strverscmp.3 -e /wcsncasecmp.3 \
            -e /strcoll.3 -e /strcmp.3 \
  | tee /dev/tty \
  | wc -l;

Link: <https://lore.kernel.org/linux-man/20210423230609.13519-1-alx.manpages@gmail.com/T/>
Link: <https://lore.kernel.org/lkml/YZvIlz7J6vOEY+Xu@yuki/T/>
Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
Nacked-by: Alexei Starovoitov <ast@kernel.org>
Nacked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Nacked-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Zack Weinberg <zackw@panix.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: glibc <libc-alpha@sourceware.org>
Cc: GCC <gcc-patches@gcc.gnu.org>
Cc: bpf <bpf@vger.kernel.org>
Cc: LTP List <ltp@lists.linux.it>
Cc: Linux API <linux-api@vger.kernel.org>
Cc: linux-arch <linux-arch@vger.kernel.org>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Joseph Myers <joseph@codesourcery.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Cyril Hrubis <chrubis@suse.cz>
Cc: David Howells <dhowells@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Rich Felker <dalias@libc.org>
Cc: Adhemerval Zanella <adhemerval.zanella@linaro.org>
---

Hi,

I removed attributes from this patch.  It now only changes types,
and only types that don't have anything special in them.  __be64
or things like that are not included in this patch.  __aligned_u64
isn't either.

I made clear what the incompatibilities are, and I hope Cyril
fixes them soon, but anyway, they shouldn't affect for the cases
documented here.  And if they affect somehow, a programmer will
probably know the reason; but I'd consider that a kernel bug, or
at least something to improve there.

I'm decided to push for this change, and would like to see the
kernel making the necessary steps to make it smoother, since it
shouldn't be hard (the patch is there already; it only needs a
little bit of love).

Anyway, I don't think it will cause important problems to readers
of the manual pages, and instead expect an improvement.

Cheers,

Alex


 man2/bpf.2                     |  28 +-
 man2/capget.2                  |  10 +-
 man2/clone.2                   |  36 +--
 man2/getunwind.2               |   6 +-
 man2/io_submit.2               |  22 +-
 man2/ioctl_ficlonerange.2      |   8 +-
 man2/ioctl_fideduperange.2     |  20 +-
 man2/ioctl_getfsmap.2          |  28 +-
 man2/ioctl_userfaultfd.2       |  37 +--
 man2/kcmp.2                    |   6 +-
 man2/keyctl.2                  |   8 +-
 man2/landlock_add_rule.2       |   4 +-
 man2/landlock_create_ruleset.2 |   2 +-
 man2/mount_setattr.2           |   8 +-
 man2/perf_event_open.2         | 486 ++++++++++++++++-----------------
 man2/ptrace.2                  |  40 +--
 man2/sched_setattr.2           |  20 +-
 man2/seccomp.2                 |  24 +-
 man2/seccomp_unotify.2         |  32 +--
 man2/statx.2                   |  42 +--
 man2/userfaultfd.2             |  28 +-
 man2type/open_how.2type        |   6 +-
 man3type/epoll_event.3type     |   2 +-
 man4/loop.4                    |   6 +-
 man4/random.4                  |   6 +-
 man7/fanotify.7                |  28 +-
 man7/netdevice.7               |   2 +-
 man7/netlink.7                 |  14 +-
 man7/packet.7                  |  16 +-
 man7/rtnetlink.7               |  20 +-
 man7/sock_diag.7               | 122 +++++----
 31 files changed, 568 insertions(+), 549 deletions(-)

diff --git a/man2/bpf.2 b/man2/bpf.2
index d05b73ec2..84d1b62e5 100644
--- a/man2/bpf.2
+++ b/man2/bpf.2
@@ -169,34 +169,34 @@ commands:
 .EX
 union bpf_attr {
     struct {    /* Used by BPF_MAP_CREATE */
-        __u32         map_type;
-        __u32         key_size;    /* size of key in bytes */
-        __u32         value_size;  /* size of value in bytes */
-        __u32         max_entries; /* maximum number of entries
+        uint32_t      map_type;
+        uint32_t      key_size;    /* size of key in bytes */
+        uint32_t      value_size;  /* size of value in bytes */
+        uint32_t      max_entries; /* maximum number of entries
                                       in a map */
     };
 
     struct {    /* Used by BPF_MAP_*_ELEM and BPF_MAP_GET_NEXT_KEY
                    commands */
-        __u32         map_fd;
+        uint32_t      map_fd;
         __aligned_u64 key;
         union {
             __aligned_u64 value;
             __aligned_u64 next_key;
         };
-        __u64         flags;
+        uint64_t      flags;
     };
 
     struct {    /* Used by BPF_PROG_LOAD */
-        __u32         prog_type;
-        __u32         insn_cnt;
+        uint32_t      prog_type;
+        uint32_t      insn_cnt;
         __aligned_u64 insns;      /* \(aqconst struct bpf_insn *\(aq */
         __aligned_u64 license;    /* \(aqconst char *\(aq */
-        __u32         log_level;  /* verbosity level of verifier */
-        __u32         log_size;   /* size of user buffer */
+        uint32_t      log_level;  /* verbosity level of verifier */
+        uint32_t      log_size;   /* size of user buffer */
         __aligned_u64 log_buf;    /* user supplied \(aqchar *\(aq
                                      buffer */
-        __u32         kern_version;
+        uint32_t      kern_version;
                                   /* checked when prog_type=kprobe
                                      (since Linux 4.1) */
 .\"                 commit 2541517c32be2531e0da59dfd7efc1ce844644f5
@@ -317,7 +317,7 @@ of 1 and the eBPF program contains
 .in +4n
 .EX
 value = bpf_map_lookup_elem(...);
-*(u32 *) value = 1;
+*(uint32_t *) value = 1;
 .EE
 .in
 .IP
@@ -1212,7 +1212,7 @@ main(int argc, char *argv[])
         BPF_LD_ABS(BPF_B, ETH_HLEN + offsetof(struct iphdr, protocol)),
                                 /* r0 = ip\->proto */
         BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, \-4),
-                                /* *(u32 *)(fp \- 4) = r0 */
+                                /* *(uint32_t *)(fp \- 4) = r0 */
         BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),       /* r2 = fp */
         BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, \-4),      /* r2 = r2 \- 4 */
         BPF_LD_MAP_FD(BPF_REG_1, map_fd),           /* r1 = map_fd */
@@ -1222,7 +1222,7 @@ main(int argc, char *argv[])
                                 /* if (r0 == 0) goto pc+2 */
         BPF_MOV64_IMM(BPF_REG_1, 1),                /* r1 = 1 */
         BPF_XADD(BPF_DW, BPF_REG_0, BPF_REG_1, 0, 0),
-                                /* lock *(u64 *) r0 += r1 */
+                                /* lock *(uint64_t *) r0 += r1 */
 .\"                                == atomic64_add
         BPF_MOV64_IMM(BPF_REG_0, 0),                /* r0 = 0 */
         BPF_EXIT_INSN(),                            /* return r0 */
diff --git a/man2/capget.2 b/man2/capget.2
index 5820c29f1..1e155075f 100644
--- a/man2/capget.2
+++ b/man2/capget.2
@@ -71,14 +71,14 @@ The structures are defined as follows.
 #define _LINUX_CAPABILITY_U32S_3     2
 
 typedef struct __user_cap_header_struct {
-   __u32 version;
-   int pid;
+   uint32_t  version;
+   int       pid;
 } *cap_user_header_t;
 
 typedef struct __user_cap_data_struct {
-   __u32 effective;
-   __u32 permitted;
-   __u32 inheritable;
+   uint32_t  effective;
+   uint32_t  permitted;
+   uint32_t  inheritable;
 } *cap_user_data_t;
 .EE
 .in
diff --git a/man2/clone.2 b/man2/clone.2
index e3f8e6904..8964c5607 100644
--- a/man2/clone.2
+++ b/man2/clone.2
@@ -188,24 +188,24 @@ is a structure of the following form:
 .in +4n
 .EX
 struct clone_args {
-    u64 flags;        /* Flags bit mask */
-    u64 pidfd;        /* Where to store PID file descriptor
-                         (\fIint *\fP) */
-    u64 child_tid;    /* Where to store child TID,
-                         in child\(aqs memory (\fIpid_t *\fP) */
-    u64 parent_tid;   /* Where to store child TID,
-                         in parent\(aqs memory (\fIpid_t *\fP) */
-    u64 exit_signal;  /* Signal to deliver to parent on
-                         child termination */
-    u64 stack;        /* Pointer to lowest byte of stack */
-    u64 stack_size;   /* Size of stack */
-    u64 tls;          /* Location of new TLS */
-    u64 set_tid;      /* Pointer to a \fIpid_t\fP array
-                         (since Linux 5.5) */
-    u64 set_tid_size; /* Number of elements in \fIset_tid\fP
-                         (since Linux 5.5) */
-    u64 cgroup;       /* File descriptor for target cgroup
-                         of child (since Linux 5.7) */
+    uint64_t  flags;        /* Flags bit mask */
+    uint64_t  pidfd;        /* Where to store PID file descriptor
+                               (\fIint *\fP) */
+    uint64_t  child_tid;    /* Where to store child TID,
+                               in child\(aqs memory (\fIpid_t *\fP) */
+    uint64_t  parent_tid;   /* Where to store child TID,
+                               in parent\(aqs memory (\fIpid_t *\fP) */
+    uint64_t  exit_signal;  /* Signal to deliver to parent on
+                               child termination */
+    uint64_t  stack;        /* Pointer to lowest byte of stack */
+    uint64_t  stack_size;   /* Size of stack */
+    uint64_t  tls;          /* Location of new TLS */
+    uint64_t  set_tid;      /* Pointer to a \fIpid_t\fP array
+                               (since Linux 5.5) */
+    uint64_t  set_tid_size; /* Number of elements in \fIset_tid\fP
+                               (since Linux 5.5) */
+    uint64_t  cgroup;       /* File descriptor for target cgroup
+                               of child (since Linux 5.7) */
 };
 .EE
 .in
diff --git a/man2/getunwind.2 b/man2/getunwind.2
index 94935ba02..fb64a1185 100644
--- a/man2/getunwind.2
+++ b/man2/getunwind.2
@@ -55,9 +55,9 @@ The unwind table contains entries of the following form:
 .PP
 .in +4n
 .EX
-u64 start;      (64\-bit address of start of function)
-u64 end;        (64\-bit address of end of function)
-u64 info;       (BUF\-relative offset to unwind info)
+uint64_t  start;      (64\-bit address of start of function)
+uint64_t  end;        (64\-bit address of end of function)
+uint64_t  info;       (BUF\-relative offset to unwind info)
 .EE
 .in
 .PP
diff --git a/man2/io_submit.2 b/man2/io_submit.2
index 308d90575..7eccba170 100644
--- a/man2/io_submit.2
+++ b/man2/io_submit.2
@@ -54,17 +54,17 @@ defines the parameters that control the I/O operation.
 #include <linux/aio_abi.h>
 
 struct iocb {
-    __u64   aio_data;
-    __u32   PADDED(aio_key, aio_rw_flags);
-    __u16   aio_lio_opcode;
-    __s16   aio_reqprio;
-    __u32   aio_fildes;
-    __u64   aio_buf;
-    __u64   aio_nbytes;
-    __s64   aio_offset;
-    __u64   aio_reserved2;
-    __u32   aio_flags;
-    __u32   aio_resfd;
+    uint64_t  aio_data;
+    uint32_t  PADDED(aio_key, aio_rw_flags);
+    uint16_t  aio_lio_opcode;
+    int16_t   aio_reqprio;
+    uint32_t  aio_fildes;
+    uint64_t  aio_buf;
+    uint64_t  aio_nbytes;
+    int64_t   aio_offset;
+    uint64_t  aio_reserved2;
+    uint32_t  aio_flags;
+    uint32_t  aio_resfd;
 };
 .EE
 .in
diff --git a/man2/ioctl_ficlonerange.2 b/man2/ioctl_ficlonerange.2
index c16d14b8b..71d546578 100644
--- a/man2/ioctl_ficlonerange.2
+++ b/man2/ioctl_ficlonerange.2
@@ -52,10 +52,10 @@ the following form:
 .in +4n
 .EX
 struct file_clone_range {
-    __s64 src_fd;
-    __u64 src_offset;
-    __u64 src_length;
-    __u64 dest_offset;
+    int64_t   src_fd;
+    uint64_t  src_offset;
+    uint64_t  src_length;
+    uint64_t  dest_offset;
 };
 .EE
 .in
diff --git a/man2/ioctl_fideduperange.2 b/man2/ioctl_fideduperange.2
index 573022aac..ee857510f 100644
--- a/man2/ioctl_fideduperange.2
+++ b/man2/ioctl_fideduperange.2
@@ -44,11 +44,11 @@ This information is conveyed in a structure of the following form:
 .in +4n
 .EX
 struct file_dedupe_range {
-    __u64 src_offset;
-    __u64 src_length;
-    __u16 dest_count;
-    __u16 reserved1;
-    __u32 reserved2;
+    uint64_t  src_offset;
+    uint64_t  src_length;
+    uint16_t  dest_count;
+    uint16_t  reserved1;
+    uint32_t  reserved2;
     struct file_dedupe_range_info info[0];
 };
 .EE
@@ -70,11 +70,11 @@ and the destination information is conveyed in the following form:
 .in +4n
 .EX
 struct file_dedupe_range_info {
-    __s64 dest_fd;
-    __u64 dest_offset;
-    __u64 bytes_deduped;
-    __s32 status;
-    __u32 reserved;
+    int64_t   dest_fd;
+    uint64_t  dest_offset;
+    uint64_t  bytes_deduped;
+    int32_t   status;
+    uint32_t  reserved;
 };
 .EE
 .in
diff --git a/man2/ioctl_getfsmap.2 b/man2/ioctl_getfsmap.2
index 0cc41cef5..6625041f3 100644
--- a/man2/ioctl_getfsmap.2
+++ b/man2/ioctl_getfsmap.2
@@ -28,25 +28,25 @@ The sole argument to this operation should be a pointer to a single
 .in +4n
 .EX
 struct fsmap {
-    __u32 fmr_device;      /* Device ID */
-    __u32 fmr_flags;       /* Mapping flags */
-    __u64 fmr_physical;    /* Device offset of segment */
-    __u64 fmr_owner;       /* Owner ID */
-    __u64 fmr_offset;      /* File offset of segment */
-    __u64 fmr_length;      /* Length of segment */
-    __u64 fmr_reserved[3]; /* Must be zero */
+    uint32_t  fmr_device;      /* Device ID */
+    uint32_t  fmr_flags;       /* Mapping flags */
+    uint64_t  fmr_physical;    /* Device offset of segment */
+    uint64_t  fmr_owner;       /* Owner ID */
+    uint64_t  fmr_offset;      /* File offset of segment */
+    uint64_t  fmr_length;      /* Length of segment */
+    uint64_t  fmr_reserved[3]; /* Must be zero */
 };
 
 struct fsmap_head {
-    __u32 fmh_iflags;       /* Control flags */
-    __u32 fmh_oflags;       /* Output flags */
-    __u32 fmh_count;        /* # of entries in array incl. input */
-    __u32 fmh_entries;      /* # of entries filled in (output) */
-    __u64 fmh_reserved[6];  /* Must be zero */
+    uint32_t  fmh_iflags;      /* Control flags */
+    uint32_t  fmh_oflags;      /* Output flags */
+    uint32_t  fmh_count;       /* # of entries in array incl. input*/
+    uint32_t  fmh_entries;     /* # of entries filled in (output) */
+    uint64_t  fmh_reserved[6]; /* Must be zero */
 
-    struct fsmap fmh_keys[2];  /* Low and high keys for
+    struct fsmap  fmh_keys[2]; /* Low and high keys for
                                   the mapping search */
-    struct fsmap fmh_recs[];   /* Returned records */
+    struct fsmap  fmh_recs[];  /* Returned records */
 };
 .EE
 .in
diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
index 88876ce4e..fe047dea1 100644
--- a/man2/ioctl_userfaultfd.2
+++ b/man2/ioctl_userfaultfd.2
@@ -72,9 +72,9 @@ structure, defined as:
 .in +4n
 .EX
 struct uffdio_api {
-    __u64 api;        /* Requested API version (input) */
-    __u64 features;   /* Requested features (input/output) */
-    __u64 ioctls;     /* Available ioctl() operations (output) */
+    uint64_t  api;       /* Requested API version (input) */
+    uint64_t  features;  /* Requested features (input/output) */
+    uint64_t  ioctls;    /* Available ioctl() operations (output) */
 };
 .EE
 .in
@@ -278,14 +278,14 @@ structure, defined as:
 .in +4n
 .EX
 struct uffdio_range {
-    __u64 start;    /* Start of range */
-    __u64 len;      /* Length of range (bytes) */
+    uint64_t  start;    /* Start of range */
+    uint64_t  len;      /* Length of range (bytes) */
 };
 
 struct uffdio_register {
     struct uffdio_range range;
-    __u64 mode;     /* Desired mode of operation (input) */
-    __u64 ioctls;   /* Available ioctl() operations (output) */
+    uint64_t  mode;     /* Desired mode of operation (input) */
+    uint64_t  ioctls;   /* Available ioctl() operations (output) */
 };
 .EE
 .in
@@ -447,11 +447,11 @@ structure pointed to by
 .in +4n
 .EX
 struct uffdio_copy {
-    __u64 dst;    /* Destination of copy */
-    __u64 src;    /* Source of copy */
-    __u64 len;    /* Number of bytes to copy */
-    __u64 mode;   /* Flags controlling behavior of copy */
-    __s64 copy;   /* Number of bytes copied, or negated error */
+    uint64_t  dst;   /* Destination of copy */
+    uint64_t  src;   /* Source of copy */
+    uint64_t  len;   /* Number of bytes to copy */
+    uint64_t  mode;  /* Flags controlling behavior of copy */
+    int64_t   copy;  /* Number of bytes copied, or negated error */
 };
 .EE
 .in
@@ -564,8 +564,8 @@ structure pointed to by
 .EX
 struct uffdio_zeropage {
     struct uffdio_range range;
-    __u64 mode;     /* Flags controlling behavior of copy */
-    __s64 zeropage; /* Number of bytes zeroed, or negated error */
+    uint64_t mode;     /* Flags controlling behavior of copy */
+    int64_t  zeropage; /* Number of bytes zeroed, or negated error */
 };
 .EE
 .in
@@ -700,7 +700,7 @@ structure as shown below:
 .EX
 struct uffdio_writeprotect {
     struct uffdio_range range; /* Range to change write permission*/
-    __u64 mode;                /* Mode to change write permission */
+    uint64_t  mode;            /* Mode to change write permission */
 };
 .EE
 .in
@@ -769,9 +769,10 @@ structure as shown below:
 .in +4n
 .EX
 struct uffdio_continue {
-    struct uffdio_range range; /* Range to install PTEs for and continue */
-    __u64 mode;                /* Flags controlling the behavior of continue */
-    __s64 mapped;              /* Number of bytes mapped, or negated error */
+    struct uffdio_range range;
+                     /* Range to install PTEs for and continue */
+    uint64_t mode;   /* Flags controlling the behavior of continue */
+    int64_t  mapped; /* Number of bytes mapped, or negated error */
 };
 .EE
 .in
diff --git a/man2/kcmp.2 b/man2/kcmp.2
index 886d5d66c..0c5e5096a 100644
--- a/man2/kcmp.2
+++ b/man2/kcmp.2
@@ -165,9 +165,9 @@ This structure has the form:
 .in +4n
 .EX
 struct kcmp_epoll_slot {
-    __u32 efd;
-    __u32 tfd;
-    __u64 toff;
+    uint32_t  efd;
+    uint32_t  tfd;
+    uint64_t  toff;
 };
 .EE
 .in
diff --git a/man2/keyctl.2 b/man2/keyctl.2
index 2b57b5e12..a3cc0202d 100644
--- a/man2/keyctl.2
+++ b/man2/keyctl.2
@@ -1489,10 +1489,10 @@ parameters of the KDF operation to be applied:
 .in +4n
 .EX
 struct keyctl_kdf_params {
-    char *hashname;     /* Hash algorithm name */
-    char *otherinfo;    /* SP800\-56A OtherInfo */
-    __u32 otherinfolen; /* Length of otherinfo data */
-    __u32 __spare[8];   /* Reserved */
+    char     *hashname;     /* Hash algorithm name */
+    char     *otherinfo;    /* SP800\-56A OtherInfo */
+    uint32_t  otherinfolen; /* Length of otherinfo data */
+    uint32_t  __spare[8];   /* Reserved */
 };
 .EE
 .in
diff --git a/man2/landlock_add_rule.2 b/man2/landlock_add_rule.2
index 61a39f702..cf0892f50 100644
--- a/man2/landlock_add_rule.2
+++ b/man2/landlock_add_rule.2
@@ -53,8 +53,8 @@ points to the following structure:
 .in +4n
 .EX
 struct landlock_path_beneath_attr {
-    __u64 allowed_access;
-    __s32 parent_fd;
+    uint64_t  allowed_access;
+    int32_t   parent_fd;
 } __attribute__((packed));
 .EE
 .in
diff --git a/man2/landlock_create_ruleset.2 b/man2/landlock_create_ruleset.2
index 92a640e7e..aa1cb6350 100644
--- a/man2/landlock_create_ruleset.2
+++ b/man2/landlock_create_ruleset.2
@@ -39,7 +39,7 @@ It points to the following structure:
 .in +4n
 .EX
 struct landlock_ruleset_attr {
-    __u64 handled_access_fs;
+    uint64_t  handled_access_fs;
 };
 .EE
 .in
diff --git a/man2/mount_setattr.2 b/man2/mount_setattr.2
index 160fd2526..c106c0fee 100644
--- a/man2/mount_setattr.2
+++ b/man2/mount_setattr.2
@@ -130,10 +130,10 @@ is a structure of the following form:
 .in +4n
 .EX
 struct mount_attr {
-    __u64 attr_set;     /* Mount properties to set */
-    __u64 attr_clr;     /* Mount properties to clear */
-    __u64 propagation;  /* Mount propagation type */
-    __u64 userns_fd;    /* User namespace file descriptor */
+    uint64_t  attr_set;     /* Mount properties to set */
+    uint64_t  attr_clr;     /* Mount properties to clear */
+    uint64_t  propagation;  /* Mount propagation type */
+    uint64_t  userns_fd;    /* User namespace file descriptor */
 };
 .EE
 .in
diff --git a/man2/perf_event_open.2 b/man2/perf_event_open.2
index 8186c21c7..baae6b403 100644
--- a/man2/perf_event_open.2
+++ b/man2/perf_event_open.2
@@ -195,88 +195,88 @@ for the event being created.
 .in +4n
 .EX
 struct perf_event_attr {
-    __u32 type;                 /* Type of event */
-    __u32 size;                 /* Size of attribute structure */
-    __u64 config;               /* Type\-specific configuration */
+    uint32_t  type;               /* Type of event */
+    uint32_t  size;               /* Size of attribute structure */
+    uint64_t  config;             /* Type\-specific configuration */
 
     union {
-        __u64 sample_period;    /* Period of sampling */
-        __u64 sample_freq;      /* Frequency of sampling */
+        uint64_t  sample_period;  /* Period of sampling */
+        uint64_t  sample_freq;    /* Frequency of sampling */
     };
 
-    __u64 sample_type;  /* Specifies values included in sample */
-    __u64 read_format;  /* Specifies values returned in read */
+    uint64_t  sample_type;  /* Specifies values included in sample */
+    uint64_t  read_format;  /* Specifies values returned in read */
 
-    __u64 disabled       : 1,   /* off by default */
-          inherit        : 1,   /* children inherit it */
-          pinned         : 1,   /* must always be on PMU */
-          exclusive      : 1,   /* only group on PMU */
-          exclude_user   : 1,   /* don\(aqt count user */
-          exclude_kernel : 1,   /* don\(aqt count kernel */
-          exclude_hv     : 1,   /* don\(aqt count hypervisor */
-          exclude_idle   : 1,   /* don\(aqt count when idle */
-          mmap           : 1,   /* include mmap data */
-          comm           : 1,   /* include comm data */
-          freq           : 1,   /* use freq, not period */
-          inherit_stat   : 1,   /* per task counts */
-          enable_on_exec : 1,   /* next exec enables */
-          task           : 1,   /* trace fork/exit */
-          watermark      : 1,   /* wakeup_watermark */
-          precise_ip     : 2,   /* skid constraint */
-          mmap_data      : 1,   /* non\-exec mmap data */
-          sample_id_all  : 1,   /* sample_type all events */
-          exclude_host   : 1,   /* don\(aqt count in host */
-          exclude_guest  : 1,   /* don\(aqt count in guest */
-          exclude_callchain_kernel : 1,
-                                /* exclude kernel callchains */
-          exclude_callchain_user   : 1,
-                                /* exclude user callchains */
-          mmap2          :  1,  /* include mmap with inode data */
-          comm_exec      :  1,  /* flag comm events that are
-                                   due to exec */
-          use_clockid    :  1,  /* use clockid for time fields */
-          context_switch :  1,  /* context switch data */
-          write_backward :  1,  /* Write ring buffer from end
-                                   to beginning */
-          namespaces     :  1,  /* include namespaces data */
-          ksymbol        :  1,  /* include ksymbol events */
-          bpf_event      :  1,  /* include bpf events */
-          aux_output     :  1,  /* generate AUX records
-                                   instead of events */
-          cgroup         :  1,  /* include cgroup events */
-          text_poke      :  1,  /* include text poke events */
+    uint64_t  disabled       : 1,  /* off by default */
+              inherit        : 1,  /* children inherit it */
+              pinned         : 1,  /* must always be on PMU */
+              exclusive      : 1,  /* only group on PMU */
+              exclude_user   : 1,  /* don\(aqt count user */
+              exclude_kernel : 1,  /* don\(aqt count kernel */
+              exclude_hv     : 1,  /* don\(aqt count hypervisor */
+              exclude_idle   : 1,  /* don\(aqt count when idle */
+              mmap           : 1,  /* include mmap data */
+              comm           : 1,  /* include comm data */
+              freq           : 1,  /* use freq, not period */
+              inherit_stat   : 1,  /* per task counts */
+              enable_on_exec : 1,  /* next exec enables */
+              task           : 1,  /* trace fork/exit */
+              watermark      : 1,  /* wakeup_watermark */
+              precise_ip     : 2,  /* skid constraint */
+              mmap_data      : 1,  /* non\-exec mmap data */
+              sample_id_all  : 1,  /* sample_type all events */
+              exclude_host   : 1,  /* don\(aqt count in host */
+              exclude_guest  : 1,  /* don\(aqt count in guest */
+              exclude_callchain_kernel : 1,
+                                   /* exclude kernel callchains */
+              exclude_callchain_user   : 1,
+                                   /* exclude user callchains */
+              mmap2          : 1,  /* include mmap with inode data */
+              comm_exec      : 1,  /* flag comm events that are
+                                      due to exec */
+              use_clockid    : 1,  /* use clockid for time fields */
+              context_switch : 1,  /* context switch data */
+              write_backward : 1,  /* Write ring buffer from end
+                                      to beginning */
+              namespaces     : 1,  /* include namespaces data */
+              ksymbol        : 1,  /* include ksymbol events */
+              bpf_event      : 1,  /* include bpf events */
+              aux_output     : 1,  /* generate AUX records
+                                      instead of events */
+              cgroup         : 1,  /* include cgroup events */
+              text_poke      : 1,  /* include text poke events */
 
-          __reserved_1   : 30;
+              __reserved_1   :30;
 
     union {
-        __u32 wakeup_events;    /* wakeup every n events */
-        __u32 wakeup_watermark; /* bytes before wakeup */
+        uint32_t wakeup_events;    /* wakeup every n events */
+        uint32_t wakeup_watermark; /* bytes before wakeup */
     };
 
-    __u32     bp_type;          /* breakpoint type */
+    uint32_t     bp_type;          /* breakpoint type */
 
     union {
-        __u64 bp_addr;          /* breakpoint address */
-        __u64 kprobe_func;      /* for perf_kprobe */
-        __u64 uprobe_path;      /* for perf_uprobe */
-        __u64 config1;          /* extension of config */
+        uint64_t bp_addr;          /* breakpoint address */
+        uint64_t kprobe_func;      /* for perf_kprobe */
+        uint64_t uprobe_path;      /* for perf_uprobe */
+        uint64_t config1;          /* extension of config */
     };
 
     union {
-        __u64 bp_len;           /* breakpoint length */
-        __u64 kprobe_addr;      /* with kprobe_func == NULL */
-        __u64 probe_offset;     /* for perf_[k,u]probe */
-        __u64 config2;          /* extension of config1 */
+        uint64_t bp_len;           /* breakpoint length */
+        uint64_t kprobe_addr;      /* with kprobe_func == NULL */
+        uint64_t probe_offset;     /* for perf_[k,u]probe */
+        uint64_t config2;          /* extension of config1 */
     };
-    __u64 branch_sample_type;   /* enum perf_branch_sample_type */
-    __u64 sample_regs_user;     /* user regs to dump on samples */
-    __u32 sample_stack_user;    /* size of stack to dump on
-                                   samples */
-    __s32 clockid;              /* clock to use for time fields */
-    __u64 sample_regs_intr;     /* regs to dump on samples */
-    __u32 aux_watermark;        /* aux bytes before wakeup */
-    __u16 sample_max_stack;     /* max frames in callchain */
-    __u16 __reserved_2;         /* align to u64 */
+    uint64_t  branch_sample_type;  /* enum perf_branch_sample_type */
+    uint64_t  sample_regs_user;    /* user regs to dump on samples */
+    uint32_t  sample_stack_user;   /* size of stack to dump on
+                                      samples */
+    int32_t   clockid;             /* clock to use for time fields */
+    uint64_t  sample_regs_intr;    /* regs to dump on samples */
+    uint32_t  aux_watermark;       /* aux bytes before wakeup */
+    uint16_t  sample_max_stack;    /* max frames in callchain */
+    uint16_t  __reserved_2;        /* align to uint64_t  */
 
 };
 .EE
@@ -1121,12 +1121,12 @@ The layout is described by this pseudo-structure:
 .in +4n
 .EX
 struct sample_id {
-    { u32 pid, tid; }   /* if PERF_SAMPLE_TID set */
-    { u64 time;     }   /* if PERF_SAMPLE_TIME set */
-    { u64 id;       }   /* if PERF_SAMPLE_ID set */
-    { u64 stream_id;}   /* if PERF_SAMPLE_STREAM_ID set  */
-    { u32 cpu, res; }   /* if PERF_SAMPLE_CPU set */
-    { u64 id;       }   /* if PERF_SAMPLE_IDENTIFIER set */
+    { uint32_t  pid, tid; } /* if PERF_SAMPLE_TID set */
+    { uint64_t  time;     } /* if PERF_SAMPLE_TIME set */
+    { uint64_t  id;       } /* if PERF_SAMPLE_ID set */
+    { uint64_t  stream_id;} /* if PERF_SAMPLE_STREAM_ID set */
+    { uint32_t  cpu, res; } /* if PERF_SAMPLE_CPU set */
+    { uint64_t  id;       } /* if PERF_SAMPLE_IDENTIFIER set*/
 };
 .EE
 .in
@@ -1492,12 +1492,12 @@ was specified to allow reading all events in a group at once:
 .in +4n
 .EX
 struct read_format {
-    u64 nr;            /* The number of events */
-    u64 time_enabled;  /* if PERF_FORMAT_TOTAL_TIME_ENABLED */
-    u64 time_running;  /* if PERF_FORMAT_TOTAL_TIME_RUNNING */
+    uint64_t  nr;           /* The number of events */
+    uint64_t  time_enabled; /* if PERF_FORMAT_TOTAL_TIME_ENABLED */
+    uint64_t  time_running; /* if PERF_FORMAT_TOTAL_TIME_RUNNING */
     struct {
-        u64 value;     /* The value of the event */
-        u64 id;        /* if PERF_FORMAT_ID */
+        uint64_t  value;    /* The value of the event */
+        uint64_t  id;       /* if PERF_FORMAT_ID */
     } values[nr];
 };
 .EE
@@ -1512,10 +1512,10 @@ specified:
 .in +4n
 .EX
 struct read_format {
-    u64 value;         /* The value of the event */
-    u64 time_enabled;  /* if PERF_FORMAT_TOTAL_TIME_ENABLED */
-    u64 time_running;  /* if PERF_FORMAT_TOTAL_TIME_RUNNING */
-    u64 id;            /* if PERF_FORMAT_ID */
+    uint64_t  value;        /* The value of the event */
+    uint64_t  time_enabled; /* if PERF_FORMAT_TOTAL_TIME_ENABLED */
+    uint64_t  time_running; /* if PERF_FORMAT_TOTAL_TIME_RUNNING */
+    uint64_t  id;           /* if PERF_FORMAT_ID */
 };
 .EE
 .in
@@ -1572,36 +1572,36 @@ The structure of the first metadata mmap page is as follows:
 .in +4n
 .EX
 struct perf_event_mmap_page {
-    __u32 version;        /* version number of this structure */
-    __u32 compat_version; /* lowest version this is compat with */
-    __u32 lock;           /* seqlock for synchronization */
-    __u32 index;          /* hardware counter identifier */
-    __s64 offset;         /* add to hardware counter value */
-    __u64 time_enabled;   /* time event active */
-    __u64 time_running;   /* time event on CPU */
+    uint32_t  version;        /* version number of this structure */
+    uint32_t  compat_version; /* lowest version this is compat with*/
+    uint32_t  lock;           /* seqlock for synchronization */
+    uint32_t  index;          /* hardware counter identifier */
+    int64_t   offset;         /* add to hardware counter value */
+    uint64_t  time_enabled;   /* time event active */
+    uint64_t  time_running;   /* time event on CPU */
     union {
-        __u64   capabilities;
+        uint64_t     capabilities;
         struct {
-            __u64 cap_usr_time / cap_usr_rdpmc / cap_bit0 : 1,
-                  cap_bit0_is_deprecated : 1,
-                  cap_user_rdpmc         : 1,
-                  cap_user_time          : 1,
-                  cap_user_time_zero     : 1,
+            uint64_t cap_usr_time / cap_usr_rdpmc / cap_bit0 : 1,
+                     cap_bit0_is_deprecated : 1,
+                     cap_user_rdpmc         : 1,
+                     cap_user_time          : 1,
+                     cap_user_time_zero     : 1,
         };
     };
-    __u16 pmc_width;
-    __u16 time_shift;
-    __u32 time_mult;
-    __u64 time_offset;
-    __u64 __reserved[120];   /* Pad to 1 k */
-    __u64 data_head;         /* head in the data section */
-    __u64 data_tail;         /* user\-space written tail */
-    __u64 data_offset;       /* where the buffer starts */
-    __u64 data_size;         /* data buffer size */
-    __u64 aux_head;
-    __u64 aux_tail;
-    __u64 aux_offset;
-    __u64 aux_size;
+    uint16_t  pmc_width;
+    uint16_t  time_shift;
+    uint32_t  time_mult;
+    uint64_t  time_offset;
+    uint64_t  __reserved[120];   /* Pad to 1 k */
+    uint64_t  data_head;         /* head in the data section */
+    uint64_t  data_tail;         /* user\-space written tail */
+    uint64_t  data_offset;       /* where the buffer starts */
+    uint64_t  data_size;         /* data buffer size */
+    uint64_t  aux_head;
+    uint64_t  aux_tail;
+    uint64_t  aux_offset;
+    uint64_t  aux_size;
 
 }
 .EE
@@ -1681,9 +1681,9 @@ the following code can be used to do a read:
 .IP
 .in +4n
 .EX
-u32 seq, time_mult, time_shift, idx, width;
-u64 count, enabled, running;
-u64 cyc, time_offset;
+uint32_t  seq, time_mult, time_shift, idx, width;
+uint64_t  count, enabled, running;
+uint64_t  cyc, time_offset;
 
 do {
     seq = pc\->lock;
@@ -1749,11 +1749,11 @@ delta since
 .IP
 .in +4n
 .EX
-u64 quot, rem;
-u64 delta;
+uint64_t  quot, rem;
+uint64_t  delta;
 
 quot  = cyc >> time_shift;
-rem   = cyc & (((u64)1 << time_shift) \- 1);
+rem   = cyc & (((uint64_t) 1 << time_shift) \- 1);
 delta = time_offset + quot * time_mult +
         ((rem * time_mult) >> time_shift);
 .EE
@@ -1808,7 +1808,7 @@ And vice versa:
 .in +4n
 .EX
 quot = cyc >> time_shift;
-rem  = cyc & (((u64)1 << time_shift) \- 1);
+rem  = cyc & (((uint64_t) 1 << time_shift) \- 1);
 timestamp = time_zero + quot * time_mult +
             ((rem * time_mult) >> time_shift);
 .EE
@@ -1910,9 +1910,9 @@ The mmap values start with a header:
 .in +4n
 .EX
 struct perf_event_header {
-    __u32   type;
-    __u16   misc;
-    __u16   size;
+    uint32_t  type;
+    uint16_t  misc;
+    uint16_t  size;
 };
 .EE
 .in
@@ -2031,12 +2031,12 @@ They have the following structure:
 .in +4n
 .EX
 struct {
-    struct perf_event_header header;
-    u32    pid, tid;
-    u64    addr;
-    u64    len;
-    u64    pgoff;
-    char   filename[];
+    struct perf_event_header  header;
+    uint32_t  pid, tid;
+    uint64_t  addr;
+    uint64_t  len;
+    uint64_t  pgoff;
+    char      filename[];
 };
 .EE
 .in
@@ -2064,10 +2064,10 @@ This record indicates when events are lost.
 .in +4n
 .EX
 struct {
-    struct perf_event_header header;
-    u64    id;
-    u64    lost;
-    struct sample_id sample_id;
+    struct perf_event_header  header;
+    uint64_t  id;
+    uint64_t  lost;
+    struct sample_id  sample_id;
 };
 .EE
 .in
@@ -2086,11 +2086,11 @@ This record indicates a change in the process name.
 .in +4n
 .EX
 struct {
-    struct perf_event_header header;
-    u32    pid;
-    u32    tid;
-    char   comm[];
-    struct sample_id sample_id;
+    struct perf_event_header  header;
+    uint32_t  pid;
+    uint32_t  tid;
+    char      comm[];
+    struct sample_id  sample_id;
 };
 .EE
 .in
@@ -2112,11 +2112,11 @@ This record indicates a process exit event.
 .in +4n
 .EX
 struct {
-    struct perf_event_header header;
-    u32    pid, ppid;
-    u32    tid, ptid;
-    u64    time;
-    struct sample_id sample_id;
+    struct perf_event_header  header;
+    uint32_t  pid, ppid;
+    uint32_t  tid, ptid;
+    uint64_t  time;
+    struct sample_id  sample_id;
 };
 .EE
 .in
@@ -2127,11 +2127,11 @@ This record indicates a throttle/unthrottle event.
 .in +4n
 .EX
 struct {
-    struct perf_event_header header;
-    u64    time;
-    u64    id;
-    u64    stream_id;
-    struct sample_id sample_id;
+    struct perf_event_header  header;
+    uint64_t  time;
+    uint64_t  id;
+    uint64_t  stream_id;
+    struct sample_id  sample_id;
 };
 .EE
 .in
@@ -2142,11 +2142,11 @@ This record indicates a fork event.
 .in +4n
 .EX
 struct {
-    struct perf_event_header header;
-    u32    pid, ppid;
-    u32    tid, ptid;
-    u64    time;
-    struct sample_id sample_id;
+    struct perf_event_header  header;
+    uint32_t  pid, ppid;
+    uint32_t  tid, ptid;
+    uint64_t  time;
+    struct sample_id  sample_id;
 };
 .EE
 .in
@@ -2157,10 +2157,10 @@ This record indicates a read event.
 .in +4n
 .EX
 struct {
-    struct perf_event_header header;
-    u32    pid, tid;
-    struct read_format values;
-    struct sample_id sample_id;
+    struct perf_event_header  header;
+    uint32_t  pid, tid;
+    struct read_format  values;
+    struct sample_id    sample_id;
 };
 .EE
 .in
@@ -2172,39 +2172,39 @@ This record indicates a sample.
 .EX
 struct {
     struct perf_event_header header;
-    u64    sample_id;   /* if PERF_SAMPLE_IDENTIFIER */
-    u64    ip;          /* if PERF_SAMPLE_IP */
-    u32    pid, tid;    /* if PERF_SAMPLE_TID */
-    u64    time;        /* if PERF_SAMPLE_TIME */
-    u64    addr;        /* if PERF_SAMPLE_ADDR */
-    u64    id;          /* if PERF_SAMPLE_ID */
-    u64    stream_id;   /* if PERF_SAMPLE_STREAM_ID */
-    u32    cpu, res;    /* if PERF_SAMPLE_CPU */
-    u64    period;      /* if PERF_SAMPLE_PERIOD */
+    uint64_t  sample_id;  /* if PERF_SAMPLE_IDENTIFIER */
+    uint64_t  ip;         /* if PERF_SAMPLE_IP */
+    uint32_t  pid, tid;   /* if PERF_SAMPLE_TID */
+    uint64_t  time;       /* if PERF_SAMPLE_TIME */
+    uint64_t  addr;       /* if PERF_SAMPLE_ADDR */
+    uint64_t  id;         /* if PERF_SAMPLE_ID */
+    uint64_t  stream_id;  /* if PERF_SAMPLE_STREAM_ID */
+    uint32_t  cpu, res;   /* if PERF_SAMPLE_CPU */
+    uint64_t  period;     /* if PERF_SAMPLE_PERIOD */
     struct read_format v;
-                        /* if PERF_SAMPLE_READ */
-    u64    nr;          /* if PERF_SAMPLE_CALLCHAIN */
-    u64    ips[nr];     /* if PERF_SAMPLE_CALLCHAIN */
-    u32    size;        /* if PERF_SAMPLE_RAW */
-    char   data[size];  /* if PERF_SAMPLE_RAW */
-    u64    bnr;         /* if PERF_SAMPLE_BRANCH_STACK */
+                          /* if PERF_SAMPLE_READ */
+    uint64_t  nr;         /* if PERF_SAMPLE_CALLCHAIN */
+    uint64_t  ips[nr];    /* if PERF_SAMPLE_CALLCHAIN */
+    uint32_t  size;       /* if PERF_SAMPLE_RAW */
+    char      data[size]; /* if PERF_SAMPLE_RAW */
+    uint64_t  bnr;        /* if PERF_SAMPLE_BRANCH_STACK*/
     struct perf_branch_entry lbr[bnr];
-                        /* if PERF_SAMPLE_BRANCH_STACK */
-    u64    abi;         /* if PERF_SAMPLE_REGS_USER */
-    u64    regs[weight(mask)];
-                        /* if PERF_SAMPLE_REGS_USER */
-    u64    size;        /* if PERF_SAMPLE_STACK_USER */
-    char   data[size];  /* if PERF_SAMPLE_STACK_USER */
-    u64    dyn_size;    /* if PERF_SAMPLE_STACK_USER &&
-                           size != 0 */
-    u64    weight;      /* if PERF_SAMPLE_WEIGHT */
-    u64    data_src;    /* if PERF_SAMPLE_DATA_SRC */
-    u64    transaction; /* if PERF_SAMPLE_TRANSACTION */
-    u64    abi;         /* if PERF_SAMPLE_REGS_INTR */
-    u64    regs[weight(mask)];
-                        /* if PERF_SAMPLE_REGS_INTR */
-    u64    phys_addr;   /* if PERF_SAMPLE_PHYS_ADDR */
-    u64    cgroup;      /* if PERF_SAMPLE_CGROUP */
+                          /* if PERF_SAMPLE_BRANCH_STACK*/
+    uint64_t  abi;        /* if PERF_SAMPLE_REGS_USER */
+    uint64_t  regs[weight(mask)];
+                          /* if PERF_SAMPLE_REGS_USER */
+    uint64_t  size;       /* if PERF_SAMPLE_STACK_USER */
+    char      data[size]; /* if PERF_SAMPLE_STACK_USER */
+    uint64_t  dyn_size;   /* if PERF_SAMPLE_STACK_USER &&
+                             size != 0 */
+    uint64_t  weight;     /* if PERF_SAMPLE_WEIGHT */
+    uint64_t  data_src;   /* if PERF_SAMPLE_DATA_SRC */
+    uint64_t  transaction;/* if PERF_SAMPLE_TRANSACTION */
+    uint64_t  abi;        /* if PERF_SAMPLE_REGS_INTR */
+    uint64_t  regs[weight(mask)];
+                          /* if PERF_SAMPLE_REGS_INTR */
+    uint64_t  phys_addr;  /* if PERF_SAMPLE_PHYS_ADDR */
+    uint64_t  cgroup;     /* if PERF_SAMPLE_CGROUP */
 };
 .EE
 .in
@@ -2654,20 +2654,20 @@ shared mappings.
 .in +4n
 .EX
 struct {
-    struct perf_event_header header;
-    u32    pid;
-    u32    tid;
-    u64    addr;
-    u64    len;
-    u64    pgoff;
-    u32    maj;
-    u32    min;
-    u64    ino;
-    u64    ino_generation;
-    u32    prot;
-    u32    flags;
-    char   filename[];
-    struct sample_id sample_id;
+    struct perf_event_header  header;
+    uint32_t  pid;
+    uint32_t  tid;
+    uint64_t  addr;
+    uint64_t  len;
+    uint64_t  pgoff;
+    uint32_t  maj;
+    uint32_t  min;
+    uint64_t  ino;
+    uint64_t  ino_generation;
+    uint32_t  prot;
+    uint32_t  flags;
+    char      filename[];
+    struct sample_id  sample_id;
 };
 .EE
 .in
@@ -2718,11 +2718,11 @@ AUX buffer region.
 .in +4n
 .EX
 struct {
-    struct perf_event_header header;
-    u64    aux_offset;
-    u64    aux_size;
-    u64    flags;
-    struct sample_id sample_id;
+    struct perf_event_header  header;
+    uint64_t  aux_offset;
+    uint64_t  aux_size;
+    uint64_t  flags;
+    struct sample_id  sample_id;
 };
 .EE
 .in
@@ -2757,9 +2757,9 @@ addresses in the AUX buffer with the proper executable.
 .in +4n
 .EX
 struct {
-    struct perf_event_header header;
-    u32    pid;
-    u32    tid;
+    struct perf_event_header  header;
+    uint32_t  pid;
+    uint32_t  tid;
 };
 .EE
 .in
@@ -2780,9 +2780,9 @@ indicates some number of samples that may have been lost.
 .in +4n
 .EX
 struct {
-    struct perf_event_header header;
-    u64    lost;
-    struct sample_id sample_id;
+    struct perf_event_header  header;
+    uint64_t  lost;
+    struct sample_id  sample_id;
 };
 .EE
 .in
@@ -2829,10 +2829,10 @@ or away from the current process.
 .in +4n
 .EX
 struct {
-    struct perf_event_header header;
-    u32 next_prev_pid;
-    u32 next_prev_tid;
-    struct sample_id sample_id;
+    struct perf_event_header  header;
+    uint32_t  next_prev_pid;
+    uint32_t  next_prev_tid;
+    struct sample_id  sample_id;
 };
 .EE
 .in
@@ -2854,12 +2854,12 @@ This record includes various namespace information of a process.
 .in +4n
 .EX
 struct {
-    struct perf_event_header header;
-    u32    pid;
-    u32    tid;
-    u64    nr_namespaces;
-    struct { u64 dev, inode } [nr_namespaces];
-    struct sample_id sample_id;
+    struct perf_event_header  header;
+    uint32_t  pid;
+    uint32_t  tid;
+    uint64_t  nr_namespaces;
+    struct { uint64_t dev, inode } [nr_namespaces];
+    struct sample_id  sample_id;
 };
 .EE
 .in
@@ -2912,13 +2912,13 @@ This record indicates kernel symbol register/unregister events.
 .in +4n
 .EX
 struct {
-    struct perf_event_header header;
-    u64    addr;
-    u32    len;
-    u16    ksym_type;
-    u16    flags;
-    char   name[];
-    struct sample_id sample_id;
+    struct perf_event_header  header;
+    uint64_t  addr;
+    uint32_t  len;
+    uint16_t  ksym_type;
+    uint16_t  flags;
+    char      name[];
+    struct sample_id  sample_id;
 };
 .EE
 .in
@@ -2952,12 +2952,12 @@ This record indicates BPF program is loaded or unloaded.
 .in +4n
 .EX
 struct {
-    struct perf_event_header header;
-    u16 type;
-    u16 flags;
-    u32 id;
-    u8 tag[BPF_TAG_SIZE];
-    struct sample_id sample_id;
+    struct perf_event_header  header;
+    uint16_t  type;
+    uint16_t  flags;
+    uint32_t  id;
+    uint8_t   tag[BPF_TAG_SIZE];
+    struct sample_id  sample_id;
 };
 .EE
 .in
@@ -2991,10 +2991,10 @@ This record indicates a new cgroup is created and activated.
 .in +4n
 .EX
 struct {
-    struct perf_event_header header;
-    u64    id;
-    char   path[];
-    struct sample_id sample_id;
+    struct perf_event_header  header;
+    uint64_t  id;
+    char      path[];
+    struct sample_id  sample_id;
 };
 .EE
 .in
@@ -3019,12 +3019,12 @@ and the corresponding length is zero in this case.
 .in +4n
 .EX
 struct {
-    struct perf_event_header header;
-    u64    addr;
-    u16    old_len;
-    u16    new_len;
-    u8     bytes[];
-    struct sample_id sample_id;
+    struct perf_event_header  header;
+    uint64_t  addr;
+    uint16_t  old_len;
+    uint16_t  new_len;
+    uint8_t   bytes[];
+    struct sample_id  sample_id;
 };
 .EE
 .in
@@ -3282,9 +3282,9 @@ The argument is a pointer to a structure
 .in +4n
 .EX
 struct perf_event_query_bpf {
-    __u32    ids_len;
-    __u32    prog_cnt;
-    __u32    ids[0];
+    uint32_t  ids_len;
+    uint32_t  prog_cnt;
+    uint32_t  ids[0];
 };
 .EE
 .in
diff --git a/man2/ptrace.2 b/man2/ptrace.2
index 734645d29..d552d0256 100644
--- a/man2/ptrace.2
+++ b/man2/ptrace.2
@@ -395,10 +395,10 @@ etc.) that are not otherwise exposed to user space.
 .in +4n
 .EX
 struct ptrace_peeksiginfo_args {
-    u64 off;    /* Ordinal position in queue at which
-                   to start copying signals */
-    u32 flags;  /* PTRACE_PEEKSIGINFO_SHARED or 0 */
-    s32 nr;     /* Number of signals to copy */
+    uint64_t  off;    /* Ordinal position in queue at which
+                         to start copying signals */
+    uint32_t  flags;  /* PTRACE_PEEKSIGINFO_SHARED or 0 */
+    int32_t   nr;     /* Number of signals to copy */
 };
 .EE
 .in
@@ -1041,28 +1041,28 @@ structure contains the following fields:
 .in +4n
 .EX
 struct ptrace_syscall_info {
-    __u8 op;        /* Type of system call stop */
-    __u32 arch;     /* AUDIT_ARCH_* value; see seccomp(2) */
-    __u64 instruction_pointer; /* CPU instruction pointer */
-    __u64 stack_pointer;    /* CPU stack pointer */
+    uint8_t  op;   /* Type of system call stop */
+    uint32_t arch; /* AUDIT_ARCH_* value; see seccomp(2) */
+    uint64_t instruction_pointer; /* CPU instruction pointer*/
+    uint64_t stack_pointer;       /* CPU stack pointer */
     union {
         struct {    /* op == PTRACE_SYSCALL_INFO_ENTRY */
-            __u64 nr;       /* System call number */
-            __u64 args[6];  /* System call arguments */
+            uint64_t nr;       /* System call number */
+            uint64_t args[6];  /* System call arguments */
         } entry;
         struct {    /* op == PTRACE_SYSCALL_INFO_EXIT */
-            __s64 rval;     /* System call return value */
-            __u8 is_error;  /* System call error flag;
-                               Boolean: does rval contain
-                               an error value (\-ERRCODE) or
-                               a nonerror return value? */
+            int64_t  rval;     /* System call return value */
+            uint8_t  is_error; /* System call error flag;
+                                  Boolean: does rval contain
+                                  an error value (\-ERRCODE) or
+                                  a nonerror return value? */
         } exit;
         struct {    /* op == PTRACE_SYSCALL_INFO_SECCOMP */
-            __u64 nr;       /* System call number */
-            __u64 args[6];  /* System call arguments */
-            __u32 ret_data; /* SECCOMP_RET_DATA portion
-                               of SECCOMP_RET_TRACE
-                               return value */
+            uint64_t nr;       /* System call number */
+            uint64_t args[6];  /* System call arguments */
+            uint32_t ret_data; /* SECCOMP_RET_DATA portion
+                                  of SECCOMP_RET_TRACE
+                                  return value */
         } seccomp;
     };
 };
diff --git a/man2/sched_setattr.2 b/man2/sched_setattr.2
index 701970369..221438336 100644
--- a/man2/sched_setattr.2
+++ b/man2/sched_setattr.2
@@ -87,17 +87,17 @@ This structure has the following form:
 .in +4n
 .EX
 struct sched_attr {
-    u32 size;              /* Size of this structure */
-    u32 sched_policy;      /* Policy (SCHED_*) */
-    u64 sched_flags;       /* Flags */
-    s32 sched_nice;        /* Nice value (SCHED_OTHER,
-                              SCHED_BATCH) */
-    u32 sched_priority;    /* Static priority (SCHED_FIFO,
-                              SCHED_RR) */
+    uint32_t  size;              /* Size of this structure */
+    uint32_t  sched_policy;      /* Policy (SCHED_*) */
+    uint64_t  sched_flags;       /* Flags */
+    int32_t   sched_nice;        /* Nice value (SCHED_OTHER,
+                                    SCHED_BATCH) */
+    uint32_t  sched_priority;    /* Static priority (SCHED_FIFO,
+                                    SCHED_RR) */
     /* Remaining fields are for SCHED_DEADLINE */
-    u64 sched_runtime;
-    u64 sched_deadline;
-    u64 sched_period;
+    uint64_t  sched_runtime;
+    uint64_t  sched_deadline;
+    uint64_t  sched_period;
 };
 .EE
 .in
diff --git a/man2/seccomp.2 b/man2/seccomp.2
index c49076ea3..a3a0e6fa1 100644
--- a/man2/seccomp.2
+++ b/man2/seccomp.2
@@ -275,9 +275,9 @@ which has the following form:
 .IP
 .EX
 struct seccomp_notif_sizes
-    __u16 seccomp_notif;      /* Size of notification structure */
-    __u16 seccomp_notif_resp; /* Size of response structure */
-    __u16 seccomp_data;       /* Size of \(aqstruct seccomp_data\(aq */
+    uint16_t seccomp_notif;   /* Size of notification structure */
+    uint16_t seccomp_notif_resp; /* Size of response structure */
+    uint16_t seccomp_data;    /* Size of \(aqstruct seccomp_data\(aq */
 };
 .EE
 .IP
@@ -306,10 +306,10 @@ Each program must contain one or more BPF instructions:
 .in +4n
 .EX
 struct sock_filter {            /* Filter block */
-    __u16 code;                 /* Actual filter code */
-    __u8  jt;                   /* Jump true */
-    __u8  jf;                   /* Jump false */
-    __u32 k;                    /* Generic multiuse field */
+    uint16_t  code;             /* Actual filter code */
+    uint8_t   jt;               /* Jump true */
+    uint8_t   jf;               /* Jump false */
+    uint32_t  k;                /* Generic multiuse field */
 };
 .EE
 .in
@@ -328,11 +328,11 @@ buffer of the following form:
 .in +4n
 .EX
 struct seccomp_data {
-    int   nr;                   /* System call number */
-    __u32 arch;                 /* AUDIT_ARCH_* value
-                                   (see <linux/audit.h>) */
-    __u64 instruction_pointer;  /* CPU instruction pointer */
-    __u64 args[6];              /* Up to 6 system call arguments */
+    int       nr;                   /* System call number */
+    uint32_t  arch;                 /* AUDIT_ARCH_* value
+                                       (see <linux/audit.h>) */
+    uint64_t  instruction_pointer;  /* CPU instruction pointer */
+    uint64_t  args[6];              /* Up to 6 system call arguments */
 };
 .EE
 .in
diff --git a/man2/seccomp_unotify.2 b/man2/seccomp_unotify.2
index bfb968014..b75160a6b 100644
--- a/man2/seccomp_unotify.2
+++ b/man2/seccomp_unotify.2
@@ -23,7 +23,7 @@ Standard C library
 .BI "          struct seccomp_notif *" req );
 .BI "int ioctl(int " fd ", SECCOMP_IOCTL_NOTIF_SEND,"
 .BI "          struct seccomp_notif_resp *" resp );
-.BI "int ioctl(int " fd ", SECCOMP_IOCTL_NOTIF_ID_VALID, __u64 *" id );
+.BI "int ioctl(int " fd ", SECCOMP_IOCTL_NOTIF_ID_VALID, uint64_t *" id );
 .BI "int ioctl(int " fd ", SECCOMP_IOCTL_NOTIF_ADDFD,"
 .BI "          struct seccomp_notif_addfd *" addfd );
 .fi
@@ -321,10 +321,10 @@ This structure must be zeroed out before the call.
 .in +4n
 .EX
 struct seccomp_notif {
-    __u64  id;              /* Cookie */
-    __u32  pid;             /* TID of target thread */
-    __u32  flags;           /* Currently unused (0) */
-    struct seccomp_data data;   /* See seccomp(2) */
+    uint64_t  id;              /* Cookie */
+    uint32_t  pid;             /* TID of target thread */
+    uint32_t  flags;           /* Currently unused (0) */
+    struct seccomp_data data;  /* See seccomp(2) */
 };
 .EE
 .in
@@ -503,10 +503,10 @@ argument of this structure is a pointer to a structure of the following form:
 .in +4n
 .EX
 struct seccomp_notif_resp {
-    __u64 id;           /* Cookie value */
-    __s64 val;          /* Success return value */
-    __s32 error;        /* 0 (success) or negative error number */
-    __u32 flags;        /* See below */
+    uint64_t  id;     /* Cookie value */
+    int64_t   val;    /* Success return value */
+    int32_t   error;  /* 0 (success) or negative error number */
+    uint32_t  flags;  /* See below */
 };
 .EE
 .in
@@ -694,13 +694,13 @@ argument is a pointer to a structure of the following form:
 .in +4n
 .EX
 struct seccomp_notif_addfd {
-    __u64 id;           /* Cookie value */
-    __u32 flags;        /* Flags */
-    __u32 srcfd;        /* Local file descriptor number */
-    __u32 newfd;        /* 0 or desired file descriptor
-                           number in target */
-    __u32 newfd_flags;  /* Flags to set on target file
-                           descriptor */
+    uint64_t  id;           /* Cookie value */
+    uint32_t  flags;        /* Flags */
+    uint32_t  srcfd;        /* Local file descriptor number */
+    uint32_t  newfd;        /* 0 or desired file descriptor
+                               number in target */
+    uint32_t  newfd_flags;  /* Flags to set on target file
+                               descriptor */
 };
 .EE
 .in
diff --git a/man2/statx.2 b/man2/statx.2
index 0d1b4591f..c339c65f3 100644
--- a/man2/statx.2
+++ b/man2/statx.2
@@ -31,20 +31,20 @@ The returned buffer is a structure of the following type:
 .in +4n
 .EX
 struct statx {
-    __u32 stx_mask;        /* Mask of bits indicating
-                              filled fields */
-    __u32 stx_blksize;     /* Block size for filesystem I/O */
-    __u64 stx_attributes;  /* Extra file attribute indicators */
-    __u32 stx_nlink;       /* Number of hard links */
-    __u32 stx_uid;         /* User ID of owner */
-    __u32 stx_gid;         /* Group ID of owner */
-    __u16 stx_mode;        /* File type and mode */
-    __u64 stx_ino;         /* Inode number */
-    __u64 stx_size;        /* Total size in bytes */
-    __u64 stx_blocks;      /* Number of 512B blocks allocated */
-    __u64 stx_attributes_mask;
-                           /* Mask to show what\(aqs supported
-                              in stx_attributes */
+    uint32_t  stx_mask;        /* Mask of bits indicating
+                                  filled fields */
+    uint32_t  stx_blksize;     /* Block size for filesystem I/O */
+    uint64_t  stx_attributes;  /* Extra file attribute indicators */
+    uint32_t  stx_nlink;       /* Number of hard links */
+    uint32_t  stx_uid;         /* User ID of owner */
+    uint32_t  stx_gid;         /* Group ID of owner */
+    uint16_t  stx_mode;        /* File type and mode */
+    uint64_t  stx_ino;         /* Inode number */
+    uint64_t  stx_size;        /* Total size in bytes */
+    uint64_t  stx_blocks;      /* Number of 512B blocks allocated */
+    uint64_t  stx_attributes_mask;
+                               /* Mask to show what\(aqs supported
+                                  in stx_attributes */
 
     /* The following fields are file timestamps */
     struct statx_timestamp stx_atime;  /* Last access */
@@ -54,14 +54,14 @@ struct statx {
 
     /* If this file represents a device, then the next two
        fields contain the ID of the device */
-    __u32 stx_rdev_major;  /* Major ID */
-    __u32 stx_rdev_minor;  /* Minor ID */
+    uint32_t  stx_rdev_major;  /* Major ID */
+    uint32_t  stx_rdev_minor;  /* Minor ID */
 
     /* The next two fields contain the ID of the device
        containing the filesystem where the file resides */
-    __u32 stx_dev_major;   /* Major ID */
-    __u32 stx_dev_minor;   /* Minor ID */
-    __u64 stx_mnt_id;      /* Mount ID */
+    uint32_t  stx_dev_major;   /* Major ID */
+    uint32_t  stx_dev_minor;   /* Minor ID */
+    uint64_t  stx_mnt_id;      /* Mount ID */
 };
 .EE
 .in
@@ -71,8 +71,8 @@ The file timestamps are structures of the following type:
 .in +4n
 .EX
 struct statx_timestamp {
-    __s64 tv_sec;    /* Seconds since the Epoch (UNIX time) */
-    __u32 tv_nsec;   /* Nanoseconds since tv_sec */
+    int64_t   tv_sec;    /* Seconds since the Epoch (UNIX time) */
+    uint32_t  tv_nsec;   /* Nanoseconds since tv_sec */
 };
 .EE
 .in
diff --git a/man2/userfaultfd.2 b/man2/userfaultfd.2
index a49bc984c..eda0ca10d 100644
--- a/man2/userfaultfd.2
+++ b/man2/userfaultfd.2
@@ -397,31 +397,31 @@ or an event required for the non-cooperative userfaultfd usage:
 .in +4n
 .EX
 struct uffd_msg {
-    __u8  event;            /* Type of event */
+    uint8_t  event;             /* Type of event */
     ...
     union {
         struct {
-            __u64 flags;    /* Flags describing fault */
-            __u64 address;  /* Faulting address */
+            uint64_t  flags;    /* Flags describing fault */
+            uint64_t  address;  /* Faulting address */
             union {
-                __u32 ptid; /* Thread ID of the fault */
+                uint32_t  ptid; /* Thread ID of the fault */
             } feat;
         } pagefault;
 
-        struct {            /* Since Linux 4.11 */
-            __u32 ufd;      /* Userfault file descriptor
-                               of the child process */
+        struct {                /* Since Linux 4.11 */
+            uint32_t  ufd;      /* Userfault file descriptor
+                                   of the child process */
         } fork;
 
-        struct {            /* Since Linux 4.11 */
-            __u64 from;     /* Old address of remapped area */
-            __u64 to;       /* New address of remapped area */
-            __u64 len;      /* Original mapping length */
+        struct {                /* Since Linux 4.11 */
+            uint64_t  from;     /* Old address of remapped area */
+            uint64_t  to;       /* New address of remapped area */
+            uint64_t  len;      /* Original mapping length */
         } remap;
 
-        struct {            /* Since Linux 4.11 */
-            __u64 start;    /* Start address of removed area */
-            __u64 end;      /* End address of removed area */
+        struct {                /* Since Linux 4.11 */
+            uint64_t  start;    /* Start address of removed area */
+            uint64_t  end;      /* End address of removed area */
         } remove;
         ...
     } arg;
diff --git a/man2type/open_how.2type b/man2type/open_how.2type
index 6037f0a01..311feafc3 100644
--- a/man2type/open_how.2type
+++ b/man2type/open_how.2type
@@ -13,9 +13,9 @@ Linux kernel headers
 .B #include <linux/openat2.h>
 .PP
 .B struct open_how {
-.BR "    u64  flags;" "    /* " O_ "* flags */"
-.BR "    u64  mode;" "     /* Mode for " O_ { CREAT , TMPFILE "} */"
-.BR "    u64  resolve;" "  /* " RESOLVE_ "* flags */"
+.BR "    uint64_t  flags;" "    /* " O_ "* flags */"
+.BR "    uint64_t  mode;" "     /* Mode for " O_ { CREAT , TMPFILE "} */"
+.BR "    uint64_t  resolve;" "  /* " RESOLVE_ "* flags */"
     /* ... */
 .B };
 .fi
diff --git a/man3type/epoll_event.3type b/man3type/epoll_event.3type
index 761dce591..743d0cee5 100644
--- a/man3type/epoll_event.3type
+++ b/man3type/epoll_event.3type
@@ -46,7 +46,7 @@ with a slightly different definition:
 
 struct epoll_event {
     __poll_t  events;
-    __u64     data;
+    uint64_t  data;
 };
 .EE
 .in
diff --git a/man4/loop.4 b/man4/loop.4
index f4d4e7df2..f016ffd9e 100644
--- a/man4/loop.4
+++ b/man4/loop.4
@@ -185,10 +185,10 @@ as:
 .in +4n
 .EX
 struct loop_config {
-    __u32               fd;
-    __u32               block_size;
+    uint32_t            fd;
+    uint32_t            block_size;
     struct loop_info64  info;
-    __u64               __reserved[8];
+    uint64_t            __reserved[8];
 };
 .EE
 .in
diff --git a/man4/random.4 b/man4/random.4
index 273bc051d..be515691f 100644
--- a/man4/random.4
+++ b/man4/random.4
@@ -306,9 +306,9 @@ The following structure is used:
 .in +4n
 .EX
 struct rand_pool_info {
-    int    entropy_count;
-    int    buf_size;
-    __u32  buf[0];
+    int       entropy_count;
+    int       buf_size;
+    uint32_t  buf[0];
 };
 .EE
 .in
diff --git a/man7/fanotify.7 b/man7/fanotify.7
index 0f9750ab4..c68e374b8 100644
--- a/man7/fanotify.7
+++ b/man7/fanotify.7
@@ -125,13 +125,13 @@ the read buffer contains one or more of the following structures:
 .in +4n
 .EX
 struct fanotify_event_metadata {
-    __u32 event_len;
-    __u8 vers;
-    __u8 reserved;
-    __u16 metadata_len;
+    uint32_t  event_len;
+    uint8_t   vers;
+    uint8_t   reserved;
+    uint16_t  metadata_len;
     __aligned_u64 mask;
-    __s32 fd;
-    __s32 pid;
+    int32_t   fd;
+    int32_t   pid;
 };
 .EE
 .in
@@ -223,7 +223,7 @@ structure within the read buffer:
 .EX
 struct fanotify_event_info_pidfd {
         struct fanotify_event_info_header hdr;
-        __s32 pidfd;
+        int32_t  pidfd;
 };
 .EE
 .in
@@ -241,8 +241,8 @@ This structure is defined as follows:
 .EX
 struct fanotify_event_info_error {
     struct fanotify_event_info_header hdr;
-    __s32 error;
-    __u32 error_count;
+    int32_t   error;
+    uint32_t  error_count;
 };
 .EE
 .in
@@ -258,9 +258,9 @@ This structure is defined as follows:
 .in +4n
 .EX
 struct fanotify_event_info_header {
-	__u8 info_type;
-	__u8 pad;
-	__u16 len;
+	uint8_t   info_type;
+	uint8_t   pad;
+	uint16_t  len;
 };
 .EE
 .in
@@ -743,8 +743,8 @@ fanotify file descriptor:
 .in +4n
 .EX
 struct fanotify_response {
-    __s32 fd;
-    __u32 response;
+    int32_t   fd;
+    uint32_t  response;
 };
 .EE
 .in
diff --git a/man7/netdevice.7 b/man7/netdevice.7
index 769fec19b..df0c39097 100644
--- a/man7/netdevice.7
+++ b/man7/netdevice.7
@@ -66,7 +66,7 @@ structure:
 .EX
 struct in6_ifreq {
     struct in6_addr     ifr6_addr;
-    u32                 ifr6_prefixlen;
+    uint32_t            ifr6_prefixlen;
     int                 ifr6_ifindex; /* Interface index */
 };
 .EE
diff --git a/man7/netlink.7 b/man7/netlink.7
index 667cae0a6..68bf67a1d 100644
--- a/man7/netlink.7
+++ b/man7/netlink.7
@@ -169,11 +169,11 @@ the payload follows.
 .in +4n
 .EX
 struct nlmsghdr {
-    __u32 nlmsg_len;    /* Length of message including header */
-    __u16 nlmsg_type;   /* Type of message content */
-    __u16 nlmsg_flags;  /* Additional flags */
-    __u32 nlmsg_seq;    /* Sequence number */
-    __u32 nlmsg_pid;    /* Sender port ID */
+    uint32_t  nlmsg_len;    /* Length of message including header */
+    uint16_t  nlmsg_type;   /* Type of message content */
+    uint16_t  nlmsg_flags;  /* Additional flags */
+    uint32_t  nlmsg_seq;    /* Sequence number */
+    uint32_t  nlmsg_pid;    /* Sender port ID */
 };
 .EE
 .in
@@ -363,7 +363,7 @@ struct sockaddr_nl {
     sa_family_t     nl_family;  /* AF_NETLINK */
     unsigned short  nl_pad;     /* Zero */
     pid_t           nl_pid;     /* Port ID */
-    __u32           nl_groups;  /* Multicast groups mask */
+    uint32_t        nl_groups;  /* Multicast groups mask */
 };
 .EE
 .in
@@ -465,7 +465,7 @@ Join/leave a group specified by
 Retrieve all groups a socket is a member of.
 .I optval
 is a pointer to
-.B __u32
+.B uint32_t
 and
 .I optlen
 is the size of the array.
diff --git a/man7/packet.7 b/man7/packet.7
index 2f04ab258..d3c1d8a7b 100644
--- a/man7/packet.7
+++ b/man7/packet.7
@@ -259,14 +259,14 @@ It is defined as
 .in +4n
 .EX
 struct tpacket_auxdata {
-    __u32 tp_status;
-    __u32 tp_len;      /* packet length */
-    __u32 tp_snaplen;  /* captured length */
-    __u16 tp_mac;
-    __u16 tp_net;
-    __u16 tp_vlan_tci;
-    __u16 tp_vlan_tpid; /* Since Linux 3.14; earlier, these
-                           were unused padding bytes */
+    uint32_t tp_status;
+    uint32_t tp_len;       /* packet length */
+    uint32_t tp_snaplen;   /* captured length */
+    uint16_t tp_mac;
+    uint16_t tp_net;
+    uint16_t tp_vlan_tci;
+    uint16_t tp_vlan_tpid; /* Since Linux 3.14; earlier, these
+                              were unused padding bytes */
 .\" commit a0cdfcf39362410d5ea983f4daf67b38de129408 added tp_vlan_tpid
 };
 .EE
diff --git a/man7/rtnetlink.7 b/man7/rtnetlink.7
index f85d6a683..21d5f9220 100644
--- a/man7/rtnetlink.7
+++ b/man7/rtnetlink.7
@@ -435,16 +435,16 @@ structure.
 struct ndmsg {
     unsigned char ndm_family;
     int           ndm_ifindex;  /* Interface index */
-    __u16         ndm_state;    /* State */
-    __u8          ndm_flags;    /* Flags */
-    __u8          ndm_type;
+    uint16_t      ndm_state;    /* State */
+    uint8_t       ndm_flags;    /* Flags */
+    uint8_t       ndm_type;
 };
 
 struct nda_cacheinfo {
-    __u32         ndm_confirmed;
-    __u32         ndm_used;
-    __u32         ndm_updated;
-    __u32         ndm_refcnt;
+    uint32_t      ndm_confirmed;
+    uint32_t      ndm_used;
+    uint32_t      ndm_updated;
+    uint32_t      ndm_refcnt;
 };
 .EE
 .IP
@@ -513,9 +513,9 @@ attributes.
 struct tcmsg {
     unsigned char    tcm_family;
     int              tcm_ifindex;   /* interface index */
-    __u32            tcm_handle;    /* Qdisc handle */
-    __u32            tcm_parent;    /* Parent qdisc */
-    __u32            tcm_info;
+    uint32_t         tcm_handle;    /* Qdisc handle */
+    uint32_t         tcm_parent;    /* Parent qdisc */
+    uint32_t         tcm_info;
 };
 .EE
 .TS
diff --git a/man7/sock_diag.7 b/man7/sock_diag.7
index c412d9b10..bc8db13b8 100644
--- a/man7/sock_diag.7
+++ b/man7/sock_diag.7
@@ -55,8 +55,8 @@ a common part shared by all address families:
 .in +4n
 .EX
 struct sock_diag_req {
-    __u8 sdiag_family;
-    __u8 sdiag_protocol;
+    uint8_t  sdiag_family;
+    uint8_t  sdiag_protocol;
 };
 .EE
 .in
@@ -112,13 +112,13 @@ For UNIX domain sockets the request is represented in the following structure:
 .in +4n
 .EX
 struct unix_diag_req {
-    __u8    sdiag_family;
-    __u8    sdiag_protocol;
-    __u16   pad;
-    __u32   udiag_states;
-    __u32   udiag_ino;
-    __u32   udiag_show;
-    __u32   udiag_cookie[2];
+    uint8_t   sdiag_family;
+    uint8_t   sdiag_protocol;
+    uint16_t  pad;
+    uint32_t  udiag_states;
+    uint32_t  udiag_ino;
+    uint32_t  udiag_show;
+    uint32_t  udiag_cookie[2];
 };
 .EE
 .in
@@ -177,8 +177,8 @@ structure:
 .in +4n
 .EX
 struct unix_diag_vfs {
-    __u32 udiag_vfs_dev;
-    __u32 udiag_vfs_ino;
+    uint32_t udiag_vfs_dev;
+    uint32_t udiag_vfs_ino;
 };
 .EE
 .in
@@ -196,14 +196,18 @@ The inode number of the corresponding on-disk socket inode.
 .B UDIAG_SHOW_PEER
 The attribute reported in answer to this request is
 .BR UNIX_DIAG_PEER .
-The payload associated with this attribute is a __u32 value
+The payload associated with this attribute is a
+.I uint32_t
+value
 which is the peer's inode number.
 This attribute is reported for connected sockets only.
 .TP
 .B UDIAG_SHOW_ICONS
 The attribute reported in answer to this request is
 .BR UNIX_DIAG_ICONS .
-The payload associated with this attribute is an array of __u32 values
+The payload associated with this attribute is an array of
+.I uint32_t
+values
 which are inode numbers of sockets that has passed the
 .BR connect (2)
 call, but hasn't been processed with
@@ -220,8 +224,8 @@ structure:
 .in +4n
 .EX
 struct unix_diag_rqlen {
-    __u32 udiag_rqueue;
-    __u32 udiag_wqueue;
+    uint32_t  udiag_rqueue;
+    uint32_t  udiag_wqueue;
 };
 .EE
 .in
@@ -251,13 +255,17 @@ the amount of memory available for sending.
 .B UDIAG_SHOW_MEMINFO
 The attribute reported in answer to this request is
 .BR UNIX_DIAG_MEMINFO .
-The payload associated with this attribute is an array of __u32 values
+The payload associated with this attribute is an array of
+.I uint32_t
+values
 described below in the subsection "Socket memory information".
 .PP
 The following attributes are reported back without any specific request:
 .TP
 .B UNIX_DIAG_SHUTDOWN
-The payload associated with this attribute is __u8 value which represents
+The payload associated with this attribute is
+.I uint8_t
+value which represents
 bits of
 .BR shutdown (2)
 state.
@@ -275,12 +283,12 @@ The response to a query for UNIX domain sockets is represented as an array of
 .in +4n
 .EX
 struct unix_diag_msg {
-    __u8    udiag_family;
-    __u8    udiag_type;
-    __u8    udiag_state;
-    __u8    pad;
-    __u32   udiag_ino;
-    __u32   udiag_cookie[2];
+    uint8_t   udiag_family;
+    uint8_t   udiag_type;
+    uint8_t   udiag_state;
+    uint8_t   pad;
+    uint32_t  udiag_ino;
+    uint32_t  udiag_cookie[2];
 };
 .EE
 .in
@@ -323,11 +331,11 @@ the request is represented in the following structure:
 .in +4n
 .EX
 struct inet_diag_req_v2 {
-    __u8    sdiag_family;
-    __u8    sdiag_protocol;
-    __u8    idiag_ext;
-    __u8    pad;
-    __u32   idiag_states;
+    uint8_t   sdiag_family;
+    uint8_t   sdiag_protocol;
+    uint8_t   idiag_ext;
+    uint8_t   pad;
+    uint32_t  idiag_states;
     struct inet_diag_sockid id;
 };
 .EE
@@ -340,12 +348,12 @@ is defined as follows:
 .in +4n
 .EX
 struct inet_diag_sockid {
-    __be16  idiag_sport;
-    __be16  idiag_dport;
-    __be32  idiag_src[4];
-    __be32  idiag_dst[4];
-    __u32   idiag_if;
-    __u32   idiag_cookie[2];
+    __be16    idiag_sport;
+    __be16    idiag_dport;
+    __be32    idiag_src[4];
+    __be32    idiag_dst[4];
+    uint32_t  idiag_if;
+    uint32_t  idiag_cookie[2];
 };
 .EE
 .in
@@ -375,16 +383,22 @@ as described below:
 .RS
 .TP
 .B INET_DIAG_TOS
-The payload associated with this attribute is a __u8 value
+The payload associated with this attribute is a
+.I uint8_t
+value
 which is the TOS of the socket.
 .TP
 .B INET_DIAG_TCLASS
-The payload associated with this attribute is a __u8 value
+The payload associated with this attribute is a
+.I uint8_t
+value
 which is the TClass of the socket.
 IPv6 sockets only.
 For LISTEN and CLOSE sockets, this is followed by
 .B INET_DIAG_SKV6ONLY
-attribute with associated __u8 payload value meaning whether the socket
+attribute with associated
+.I uint8_t
+payload value meaning whether the socket
 is IPv6-only or not.
 .TP
 .B INET_DIAG_MEMINFO
@@ -394,10 +408,10 @@ structure:
 .in +4n
 .EX
 struct inet_diag_meminfo {
-    __u32 idiag_rmem;
-    __u32 idiag_wmem;
-    __u32 idiag_fmem;
-    __u32 idiag_tmem;
+    uint32_t  idiag_rmem;
+    uint32_t  idiag_wmem;
+    uint32_t  idiag_fmem;
+    uint32_t  idiag_tmem;
 };
 .EE
 .in
@@ -419,7 +433,9 @@ The amount of data in send queue.
 .RE
 .TP
 .B INET_DIAG_SKMEMINFO
-The payload associated with this attribute is an array of __u32 values
+The payload associated with this attribute is an array of
+.I uint32_t
+values
 described below in the subsection "Socket memory information".
 .TP
 .B INET_DIAG_INFO
@@ -478,18 +494,18 @@ The response to a query for IPv4 or IPv6 sockets is represented as an array of
 .in +4n
 .EX
 struct inet_diag_msg {
-    __u8    idiag_family;
-    __u8    idiag_state;
-    __u8    idiag_timer;
-    __u8    idiag_retrans;
+    uint8_t   idiag_family;
+    uint8_t   idiag_state;
+    uint8_t   idiag_timer;
+    uint8_t   idiag_retrans;
 
     struct inet_diag_sockid id;
 
-    __u32   idiag_expires;
-    __u32   idiag_rqueue;
-    __u32   idiag_wqueue;
-    __u32   idiag_uid;
-    __u32   idiag_inode;
+    uint32_t  idiag_expires;
+    uint32_t  idiag_rqueue;
+    uint32_t  idiag_wqueue;
+    uint32_t  idiag_uid;
+    uint32_t  idiag_inode;
 };
 .EE
 .in
@@ -571,7 +587,9 @@ The payload associated with
 .B UNIX_DIAG_MEMINFO
 and
 .B INET_DIAG_SKMEMINFO
-netlink attributes is an array of the following __u32 values:
+netlink attributes is an array of the following
+.I uint32_t
+values:
 .TP
 .B SK_MEMINFO_RMEM_ALLOC
 The amount of data in receive queue.
-- 
2.37.2

