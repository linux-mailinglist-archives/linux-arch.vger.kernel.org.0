Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54320DAF61
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2019 16:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439914AbfJQONi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Oct 2019 10:13:38 -0400
Received: from mail-wr1-f73.google.com ([209.85.221.73]:52770 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439909AbfJQONi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Oct 2019 10:13:38 -0400
Received: by mail-wr1-f73.google.com with SMTP id j2so1022191wrg.19
        for <linux-arch@vger.kernel.org>; Thu, 17 Oct 2019 07:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Or9Dc22i/7f/YW0tvEwykVYSyBSv8lYxv1cGbeL+tYY=;
        b=voVDOFtDURoWe70EuQZCthSF4tD+2HviE8KiUDoZJebZXoc3UgAdXxg7qaGc9AGVaZ
         GtJZxsVBVW46GSQkOk4GAQ89qRShVQrpWynH6YdD2kSsbKwKycryapmSVHoxbTfPs04t
         sw0sx+0IxkNcRxmAy4XmrMeLEHE7OTeiYHBUh3u2Cf3QQF/Zl/z//Y1aIbMULyUO30oB
         wGY45VHtdoATYap0TVPEnCcqQY+fkmhnUP8ami7DPFm3ItBDKeV4RzcppiY4pjfNcuAD
         f1pqBKONeL8Ae58OXvOuGnM5Jkbv/wbQTk47JtWSHJR9Aor94CrWNg3/kW1KHoEaiKfA
         zE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Or9Dc22i/7f/YW0tvEwykVYSyBSv8lYxv1cGbeL+tYY=;
        b=DeDZDB3esRpkrN41AX0nXU/55ONtkbm4z/KOOf8EmUzKFf+t2gm7+zBkgqIFOjjIVj
         msNg9Q2KAa0/c7Zqah3FK5VQ0RNN2XZM8P5UaSARcVbluptTdyOPvChfbzZzlvs09GyH
         Z+5pKraXNzoPGMpTLgORErCSC9URq5cQwhsmvn8D6tFte6trKBE8MxbJCHTpJvs4OIcC
         0EwjsM05JD0GU+Pk2HxVVOjTIAjvlIUMPLkarc7KaJhQdWp04UtjAIT5M9Q5KWUYsPho
         GwP0mpJX3T8/5WsDXM5mKgJF61kOO7y7Chvv3OyQZKqBzsywn3OUi3XLnuQpLRrXdrCT
         HILA==
X-Gm-Message-State: APjAAAV+QWAj3GIp9aZUms51pomyAMs68sui0zcW9q5H0moacQR9lQx+
        gam/UwUBSXLYRTElS3xduHGDWKZr8g==
X-Google-Smtp-Source: APXvYqySWeHIYT3gM4LE6tLQKxjcIwMACvHv82ozZkl1Q2uA5IxL/HJvvNLVJ3NfQtyBkgQSVxyoRD6HNA==
X-Received: by 2002:adf:db4c:: with SMTP id f12mr2777929wrj.379.1571321615653;
 Thu, 17 Oct 2019 07:13:35 -0700 (PDT)
Date:   Thu, 17 Oct 2019 16:13:00 +0200
In-Reply-To: <20191017141305.146193-1-elver@google.com>
Message-Id: <20191017141305.146193-4-elver@google.com>
Mime-Version: 1.0
References: <20191017141305.146193-1-elver@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v2 3/8] build, kcsan: Add KCSAN build exceptions
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com,
        parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, arnd@arndb.de, boqun.feng@gmail.com,
        bp@alien8.de, dja@axtens.net, dlustig@nvidia.com,
        dave.hansen@linux.intel.com, dhowells@redhat.com,
        dvyukov@google.com, hpa@zytor.com, mingo@redhat.com,
        j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net,
        jpoimboe@redhat.com, luc.maranget@inria.fr, mark.rutland@arm.com,
        npiggin@gmail.com, paulmck@linux.ibm.com, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This blacklists several compilation units from KCSAN. See the respective
inline comments for the reasoning.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/Makefile       | 5 +++++
 kernel/sched/Makefile | 6 ++++++
 mm/Makefile           | 8 ++++++++
 3 files changed, 19 insertions(+)

diff --git a/kernel/Makefile b/kernel/Makefile
index 74ab46e2ebd1..4a597a68b8bc 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -23,6 +23,9 @@ endif
 # Prevents flicker of uninteresting __do_softirq()/__local_bh_disable_ip()
 # in coverage traces.
 KCOV_INSTRUMENT_softirq.o := n
+# Avoid KCSAN instrumentation in softirq ("No shared variables, all the data
+# are CPU local" => assume no data-races), to reduce overhead in interrupts.
+KCSAN_SANITIZE_softirq.o = n
 # These are called from save_stack_trace() on slub debug path,
 # and produce insane amounts of uninteresting coverage.
 KCOV_INSTRUMENT_module.o := n
@@ -30,6 +33,7 @@ KCOV_INSTRUMENT_extable.o := n
 # Don't self-instrument.
 KCOV_INSTRUMENT_kcov.o := n
 KASAN_SANITIZE_kcov.o := n
+KCSAN_SANITIZE_kcov.o := n
 CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
 
 # cond_syscall is currently not LTO compatible
@@ -118,6 +122,7 @@ obj-$(CONFIG_RSEQ) += rseq.o
 
 obj-$(CONFIG_GCC_PLUGIN_STACKLEAK) += stackleak.o
 KASAN_SANITIZE_stackleak.o := n
+KCSAN_SANITIZE_stackleak.o := n
 KCOV_INSTRUMENT_stackleak.o := n
 
 $(obj)/configs.o: $(obj)/config_data.gz
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 21fb5a5662b5..e9307a9c54e7 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -7,6 +7,12 @@ endif
 # that is not a function of syscall inputs. E.g. involuntary context switches.
 KCOV_INSTRUMENT := n
 
+# There are numerous races here, however, most of them due to plain accesses.
+# This would make it even harder for syzbot to find reproducers, because these
+# bugs trigger without specific input. Disable by default, but should re-enable
+# eventually.
+KCSAN_SANITIZE := n
+
 ifneq ($(CONFIG_SCHED_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
 # needed for x86 only.  Why this used to be enabled for all architectures is beyond
diff --git a/mm/Makefile b/mm/Makefile
index d996846697ef..33ea0154dd2d 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -7,6 +7,14 @@ KASAN_SANITIZE_slab_common.o := n
 KASAN_SANITIZE_slab.o := n
 KASAN_SANITIZE_slub.o := n
 
+# These produce frequent data-race reports: most of them are due to races on
+# the same word but accesses to different bits of that word. Re-enable KCSAN
+# for these when we have more consensus on what to do about them.
+KCSAN_SANITIZE_slab_common.o := n
+KCSAN_SANITIZE_slab.o := n
+KCSAN_SANITIZE_slub.o := n
+KCSAN_SANITIZE_page_alloc.o := n
+
 # These files are disabled because they produce non-interesting and/or
 # flaky coverage that is not a function of syscall inputs. E.g. slab is out of
 # free pages, or a task is migrated between nodes.
-- 
2.23.0.866.gb869b98d4c-goog

