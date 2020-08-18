Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C30248D24
	for <lists+linux-arch@lfdr.de>; Tue, 18 Aug 2020 19:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgHRRfT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Aug 2020 13:35:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52465 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgHRRej (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Aug 2020 13:34:39 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k85VK-0003E9-Cg; Tue, 18 Aug 2020 17:34:34 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hewllig <hch@infradead.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stafford Horne <shorne@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kars de Jong <jongk@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Greentime Hu <green.hu@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>, linux-doc@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, sparclinux@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net,
        linux-kselftest@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH 10/11] tracing: switch to kernel_clone()
Date:   Tue, 18 Aug 2020 19:34:10 +0200
Message-Id: <20200818173411.404104-11-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200818173411.404104-1-christian.brauner@ubuntu.com>
References: <20200818173411.404104-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The old _do_fork() helper is removed in favor of the new kernel_clone() helper.
The latter adheres to naming conventions for kernel internal syscall helpers.

Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: Tom Zanussi <zanussi@kernel.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 Documentation/trace/histogram.rst                  |  4 ++--
 samples/kprobes/kretprobe_example.c                |  4 ++--
 .../ftrace/test.d/dynevent/add_remove_kprobe.tc    |  2 +-
 .../ftrace/test.d/dynevent/clear_select_events.tc  |  2 +-
 .../ftrace/test.d/dynevent/generic_clear_event.tc  |  2 +-
 .../ftrace/test.d/ftrace/func-filter-stacktrace.tc |  4 ++--
 .../ftrace/test.d/kprobe/add_and_remove.tc         |  2 +-
 .../selftests/ftrace/test.d/kprobe/busy_check.tc   |  2 +-
 .../selftests/ftrace/test.d/kprobe/kprobe_args.tc  |  4 ++--
 .../ftrace/test.d/kprobe/kprobe_args_comm.tc       |  2 +-
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     |  4 ++--
 .../ftrace/test.d/kprobe/kprobe_args_symbol.tc     | 10 +++++-----
 .../ftrace/test.d/kprobe/kprobe_args_type.tc       |  2 +-
 .../ftrace/test.d/kprobe/kprobe_ftrace.tc          | 14 +++++++-------
 .../ftrace/test.d/kprobe/kprobe_multiprobe.tc      |  2 +-
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   | 12 ++++++------
 .../ftrace/test.d/kprobe/kretprobe_args.tc         |  4 ++--
 .../selftests/ftrace/test.d/kprobe/profile.tc      |  2 +-
 18 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 8408670d0328..f93333524a44 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -1495,7 +1495,7 @@ Extended error information
     #
 
     { stacktrace:
-             _do_fork+0x18e/0x330
+             kernel_clone+0x18e/0x330
              kernel_thread+0x29/0x30
              kthreadd+0x154/0x1b0
              ret_from_fork+0x3f/0x70
@@ -1588,7 +1588,7 @@ Extended error information
              SYSC_sendto+0xef/0x170
     } hitcount:         88
     { stacktrace:
-             _do_fork+0x18e/0x330
+             kernel_clone+0x18e/0x330
              SyS_clone+0x19/0x20
              entry_SYSCALL_64_fastpath+0x12/0x6a
     } hitcount:        244
diff --git a/samples/kprobes/kretprobe_example.c b/samples/kprobes/kretprobe_example.c
index 78a2da6fb3cd..0c40f7236989 100644
--- a/samples/kprobes/kretprobe_example.c
+++ b/samples/kprobes/kretprobe_example.c
@@ -8,7 +8,7 @@
  *
  * usage: insmod kretprobe_example.ko func=<func_name>
  *
- * If no func_name is specified, _do_fork is instrumented
+ * If no func_name is specified, kernel_clone is instrumented
  *
  * For more information on theory of operation of kretprobes, see
  * Documentation/staging/kprobes.rst
@@ -26,7 +26,7 @@
 #include <linux/limits.h>
 #include <linux/sched.h>
 
-static char func_name[NAME_MAX] = "_do_fork";
+static char func_name[NAME_MAX] = "kernel_clone";
 module_param_string(func, func_name, NAME_MAX, S_IRUGO);
 MODULE_PARM_DESC(func, "Function to kretprobe; this module will report the"
 			" function's execution time");
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
index 68550f97d3c3..3bcd4c3624ee 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
@@ -6,7 +6,7 @@
 echo 0 > events/enable
 echo > dynamic_events
 
-PLACE=_do_fork
+PLACE=kernel_clone
 
 echo "p:myevent1 $PLACE" >> dynamic_events
 echo "r:myevent2 $PLACE" >> dynamic_events
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/clear_select_events.tc b/tools/testing/selftests/ftrace/test.d/dynevent/clear_select_events.tc
index c969be9eb7de..438961971b7e 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/clear_select_events.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/clear_select_events.tc
@@ -6,7 +6,7 @@
 echo 0 > events/enable
 echo > dynamic_events
 
-PLACE=_do_fork
+PLACE=kernel_clone
 
 setup_events() {
 echo "p:myevent1 $PLACE" >> dynamic_events
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/generic_clear_event.tc b/tools/testing/selftests/ftrace/test.d/dynevent/generic_clear_event.tc
index 16d543eaac88..a8603bd23e0d 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/generic_clear_event.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/generic_clear_event.tc
@@ -6,7 +6,7 @@
 echo 0 > events/enable
 echo > dynamic_events
 
-PLACE=_do_fork
+PLACE=kernel_clone
 
 setup_events() {
 echo "p:myevent1 $PLACE" >> dynamic_events
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
index 0f41e441c203..98305d76bd04 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
@@ -4,9 +4,9 @@
 # requires: set_ftrace_filter
 # flags: instance
 
-echo _do_fork:stacktrace >> set_ftrace_filter
+echo kernel_clone:stacktrace >> set_ftrace_filter
 
-grep -q "_do_fork:stacktrace:unlimited" set_ftrace_filter
+grep -q "kernel_clone:stacktrace:unlimited" set_ftrace_filter
 
 (echo "forked"; sleep 1)
 
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/add_and_remove.tc b/tools/testing/selftests/ftrace/test.d/kprobe/add_and_remove.tc
index eba858c21815..9737cd0578a7 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/add_and_remove.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/add_and_remove.tc
@@ -3,7 +3,7 @@
 # description: Kprobe dynamic event - adding and removing
 # requires: kprobe_events
 
-echo p:myevent _do_fork > kprobe_events
+echo p:myevent kernel_clone > kprobe_events
 grep myevent kprobe_events
 test -d events/kprobes/myevent
 echo > kprobe_events
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/busy_check.tc b/tools/testing/selftests/ftrace/test.d/kprobe/busy_check.tc
index d10bf4f05bc8..f9a40af76888 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/busy_check.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/busy_check.tc
@@ -3,7 +3,7 @@
 # description: Kprobe dynamic event - busy event check
 # requires: kprobe_events
 
-echo p:myevent _do_fork > kprobe_events
+echo p:myevent kernel_clone > kprobe_events
 test -d events/kprobes/myevent
 echo 1 > events/kprobes/myevent/enable
 echo > kprobe_events && exit_fail # this must fail
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args.tc
index 61f2ac441aec..eb543d3cfe5f 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args.tc
@@ -3,13 +3,13 @@
 # description: Kprobe dynamic event with arguments
 # requires: kprobe_events
 
-echo 'p:testprobe _do_fork $stack $stack0 +0($stack)' > kprobe_events
+echo 'p:testprobe kernel_clone $stack $stack0 +0($stack)' > kprobe_events
 grep testprobe kprobe_events | grep -q 'arg1=\$stack arg2=\$stack0 arg3=+0(\$stack)'
 test -d events/kprobes/testprobe
 
 echo 1 > events/kprobes/testprobe/enable
 ( echo "forked")
-grep testprobe trace | grep '_do_fork' | \
+grep testprobe trace | grep 'kernel_clone' | \
   grep -q 'arg1=0x[[:xdigit:]]* arg2=0x[[:xdigit:]]* arg3=0x[[:xdigit:]]*$'
 
 echo 0 > events/kprobes/testprobe/enable
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_comm.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_comm.tc
index 05aaeed6987f..4e5b63be51c9 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_comm.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_comm.tc
@@ -5,7 +5,7 @@
 
 grep -A1 "fetcharg:" README | grep -q "\$comm" || exit_unsupported # this is too old
 
-echo 'p:testprobe _do_fork comm=$comm ' > kprobe_events
+echo 'p:testprobe kernel_clone comm=$comm ' > kprobe_events
 grep testprobe kprobe_events | grep -q 'comm=$comm'
 test -d events/kprobes/testprobe
 
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
index b5fa05443b39..a1d70588ab21 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
@@ -30,13 +30,13 @@ esac
 : "Test get argument (1)"
 echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):string" > kprobe_events
 echo 1 > events/kprobes/testprobe/enable
-echo "p:test _do_fork" >> kprobe_events
+echo "p:test kernel_clone" >> kprobe_events
 grep -qe "testprobe.* arg1=\"test\"" trace
 
 echo 0 > events/kprobes/testprobe/enable
 : "Test get argument (2)"
 echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):string arg2=+0(${ARG1}):string" > kprobe_events
 echo 1 > events/kprobes/testprobe/enable
-echo "p:test _do_fork" >> kprobe_events
+echo "p:test kernel_clone" >> kprobe_events
 grep -qe "testprobe.* arg1=\"test\" arg2=\"test\"" trace
 
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc
index b8c75a3d003c..bd25dd0ba0d0 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc
@@ -14,12 +14,12 @@ elif ! grep "$SYMBOL\$" /proc/kallsyms; then
 fi
 
 : "Test get basic types symbol argument"
-echo "p:testprobe_u _do_fork arg1=@linux_proc_banner:u64 arg2=@linux_proc_banner:u32 arg3=@linux_proc_banner:u16 arg4=@linux_proc_banner:u8" > kprobe_events
-echo "p:testprobe_s _do_fork arg1=@linux_proc_banner:s64 arg2=@linux_proc_banner:s32 arg3=@linux_proc_banner:s16 arg4=@linux_proc_banner:s8" >> kprobe_events
+echo "p:testprobe_u kernel_clone arg1=@linux_proc_banner:u64 arg2=@linux_proc_banner:u32 arg3=@linux_proc_banner:u16 arg4=@linux_proc_banner:u8" > kprobe_events
+echo "p:testprobe_s kernel_clone arg1=@linux_proc_banner:s64 arg2=@linux_proc_banner:s32 arg3=@linux_proc_banner:s16 arg4=@linux_proc_banner:s8" >> kprobe_events
 if grep -q "x8/16/32/64" README; then
-  echo "p:testprobe_x _do_fork arg1=@linux_proc_banner:x64 arg2=@linux_proc_banner:x32 arg3=@linux_proc_banner:x16 arg4=@linux_proc_banner:x8" >> kprobe_events
+  echo "p:testprobe_x kernel_clone arg1=@linux_proc_banner:x64 arg2=@linux_proc_banner:x32 arg3=@linux_proc_banner:x16 arg4=@linux_proc_banner:x8" >> kprobe_events
 fi
-echo "p:testprobe_bf _do_fork arg1=@linux_proc_banner:b8@4/32" >> kprobe_events
+echo "p:testprobe_bf kernel_clone arg1=@linux_proc_banner:b8@4/32" >> kprobe_events
 echo 1 > events/kprobes/enable
 (echo "forked")
 echo 0 > events/kprobes/enable
@@ -27,7 +27,7 @@ grep "testprobe_[usx]:.* arg1=.* arg2=.* arg3=.* arg4=.*" trace
 grep "testprobe_bf:.* arg1=.*" trace
 
 : "Test get string symbol argument"
-echo "p:testprobe_str _do_fork arg1=@linux_proc_banner:string" > kprobe_events
+echo "p:testprobe_str kernel_clone arg1=@linux_proc_banner:string" > kprobe_events
 echo 1 > events/kprobes/enable
 (echo "forked")
 echo 0 > events/kprobes/enable
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
index 0610e0b5587c..91fcce1c241c 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
@@ -4,7 +4,7 @@
 # requires: kprobe_events "x8/16/32/64":README
 
 gen_event() { # Bitsize
-  echo "p:testprobe _do_fork \$stack0:s$1 \$stack0:u$1 \$stack0:x$1 \$stack0:b4@4/$1"
+  echo "p:testprobe kernel_clone \$stack0:s$1 \$stack0:u$1 \$stack0:x$1 \$stack0:b4@4/$1"
 }
 
 check_types() { # s-type u-type x-type bf-type width
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc
index 81d8b58c03bc..0d179094191f 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc
@@ -5,29 +5,29 @@
 
 # prepare
 echo nop > current_tracer
-echo _do_fork > set_ftrace_filter
-echo 'p:testprobe _do_fork' > kprobe_events
+echo kernel_clone > set_ftrace_filter
+echo 'p:testprobe kernel_clone' > kprobe_events
 
 # kprobe on / ftrace off
 echo 1 > events/kprobes/testprobe/enable
 echo > trace
 ( echo "forked")
 grep testprobe trace
-! grep '_do_fork <-' trace
+! grep 'kernel_clone <-' trace
 
 # kprobe on / ftrace on
 echo function > current_tracer
 echo > trace
 ( echo "forked")
 grep testprobe trace
-grep '_do_fork <-' trace
+grep 'kernel_clone <-' trace
 
 # kprobe off / ftrace on
 echo 0 > events/kprobes/testprobe/enable
 echo > trace
 ( echo "forked")
 ! grep testprobe trace
-grep '_do_fork <-' trace
+grep 'kernel_clone <-' trace
 
 # kprobe on / ftrace on
 echo 1 > events/kprobes/testprobe/enable
@@ -35,11 +35,11 @@ echo function > current_tracer
 echo > trace
 ( echo "forked")
 grep testprobe trace
-grep '_do_fork <-' trace
+grep 'kernel_clone <-' trace
 
 # kprobe on / ftrace off
 echo nop > current_tracer
 echo > trace
 ( echo "forked")
 grep testprobe trace
-! grep '_do_fork <-' trace
+! grep 'kernel_clone <-' trace
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc
index 366b7e1b6718..45d90b6c763d 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc
@@ -4,7 +4,7 @@
 # requires: kprobe_events "Create/append/":README
 
 # Choose 2 symbols for target
-SYM1=_do_fork
+SYM1=kernel_clone
 SYM2=do_exit
 EVENT_NAME=kprobes/testevent
 
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
index b4d834675e59..c02ea50d63ea 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -86,15 +86,15 @@ esac
 
 # multiprobe errors
 if grep -q "Create/append/" README && grep -q "imm-value" README; then
-echo 'p:kprobes/testevent _do_fork' > kprobe_events
+echo 'p:kprobes/testevent kernel_clone' > kprobe_events
 check_error '^r:kprobes/testevent do_exit'	# DIFF_PROBE_TYPE
 
 # Explicitly use printf "%s" to not interpret \1
-printf "%s" 'p:kprobes/testevent _do_fork abcd=\1' > kprobe_events
-check_error 'p:kprobes/testevent _do_fork ^bcd=\1'	# DIFF_ARG_TYPE
-check_error 'p:kprobes/testevent _do_fork ^abcd=\1:u8'	# DIFF_ARG_TYPE
-check_error 'p:kprobes/testevent _do_fork ^abcd=\"foo"'	# DIFF_ARG_TYPE
-check_error '^p:kprobes/testevent _do_fork abcd=\1'	# SAME_PROBE
+printf "%s" 'p:kprobes/testevent kernel_clone abcd=\1' > kprobe_events
+check_error 'p:kprobes/testevent kernel_clone ^bcd=\1'	# DIFF_ARG_TYPE
+check_error 'p:kprobes/testevent kernel_clone ^abcd=\1:u8'	# DIFF_ARG_TYPE
+check_error 'p:kprobes/testevent kernel_clone ^abcd=\"foo"'	# DIFF_ARG_TYPE
+check_error '^p:kprobes/testevent kernel_clone abcd=\1'	# SAME_PROBE
 fi
 
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_args.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_args.tc
index 523fde6d1aa5..7ae492c204a4 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_args.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_args.tc
@@ -4,14 +4,14 @@
 # requires: kprobe_events
 
 # Add new kretprobe event
-echo 'r:testprobe2 _do_fork $retval' > kprobe_events
+echo 'r:testprobe2 kernel_clone $retval' > kprobe_events
 grep testprobe2 kprobe_events | grep -q 'arg1=\$retval'
 test -d events/kprobes/testprobe2
 
 echo 1 > events/kprobes/testprobe2/enable
 ( echo "forked")
 
-cat trace | grep testprobe2 | grep -q '<- _do_fork'
+cat trace | grep testprobe2 | grep -q '<- kernel_clone'
 
 echo 0 > events/kprobes/testprobe2/enable
 echo '-:testprobe2' >> kprobe_events
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc b/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc
index ff6c44adc8a0..c4093fc1a773 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc
@@ -4,7 +4,7 @@
 # requires: kprobe_events
 
 ! grep -q 'myevent' kprobe_profile
-echo p:myevent _do_fork > kprobe_events
+echo p:myevent kernel_clone > kprobe_events
 grep -q 'myevent[[:space:]]*0[[:space:]]*0$' kprobe_profile
 echo 1 > events/kprobes/myevent/enable
 ( echo "forked" )
-- 
2.28.0

