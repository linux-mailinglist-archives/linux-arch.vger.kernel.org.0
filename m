Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5231F46DCFD
	for <lists+linux-arch@lfdr.de>; Wed,  8 Dec 2021 21:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236676AbhLHUaQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Dec 2021 15:30:16 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:36956 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240286AbhLHUaL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Dec 2021 15:30:11 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:44736)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mv3WQ-004DCX-32; Wed, 08 Dec 2021 13:26:38 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:39446 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mv3WN-00CjR6-Ld; Wed, 08 Dec 2021 13:26:37 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed,  8 Dec 2021 14:25:30 -0600
Message-Id: <20211208202532.16409-8-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mv3WN-00CjR6-Ld;;;mid=<20211208202532.16409-8-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/67RwQvqkRKIzMUrTzQyljKeVYifGhbo4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.9 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,T_TooManySym_01,XMGappySubj_01,
        XMNoVowels,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1786 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (0.6%), b_tie_ro: 10 (0.5%), parse: 1.24
        (0.1%), extract_message_metadata: 14 (0.8%), get_uri_detail_list: 5.0
        (0.3%), tests_pri_-1000: 13 (0.7%), tests_pri_-950: 1.11 (0.1%),
        tests_pri_-900: 0.99 (0.1%), tests_pri_-90: 625 (35.0%), check_bayes:
        624 (34.9%), b_tokenize: 19 (1.1%), b_tok_get_all: 13 (0.7%),
        b_comp_prob: 2.9 (0.2%), b_tok_touch_all: 585 (32.8%), b_finish: 0.97
        (0.1%), tests_pri_0: 1105 (61.9%), check_dkim_signature: 0.69 (0.0%),
        check_dkim_adsp: 2.5 (0.1%), poll_dns_idle: 0.71 (0.0%), tests_pri_10:
        2.4 (0.1%), tests_pri_500: 9 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 08/10] exit: Rename complete_and_exit to kthread_complete_and_exit
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Update complete_and_exit to call kthread_exit instead of do_exit.

Change the name to reflect this change in functionality.  All of the
users of complete_and_exit are causing the current kthread to exit so
this change makes it clear what is happening.

Move the implementation of kthread_complete_and_exit from
kernel/exit.c to to kernel/kthread.c.  As this function is kthread
specific it makes most sense to live with the kthread functions.

There are no functional change.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 drivers/net/wireless/rsi/rsi_91x_coex.c      |  2 +-
 drivers/net/wireless/rsi/rsi_91x_main.c      |  2 +-
 drivers/net/wireless/rsi/rsi_91x_sdio_ops.c  |  2 +-
 drivers/net/wireless/rsi/rsi_91x_usb_ops.c   |  2 +-
 drivers/pnp/pnpbios/core.c                   |  6 +++---
 drivers/staging/rts5208/rtsx.c               | 16 +++++++--------
 drivers/usb/atm/usbatm.c                     |  2 +-
 drivers/usb/gadget/function/f_mass_storage.c |  2 +-
 fs/jffs2/background.c                        |  2 +-
 include/linux/kernel.h                       |  1 -
 include/linux/kthread.h                      |  1 +
 kernel/exit.c                                |  9 ---------
 kernel/kthread.c                             | 21 ++++++++++++++++++++
 lib/kunit/try-catch.c                        |  4 ++--
 tools/objtool/check.c                        |  2 +-
 15 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_coex.c b/drivers/net/wireless/rsi/rsi_91x_coex.c
index a0c5d02ae88c..8a3d86897ea8 100644
--- a/drivers/net/wireless/rsi/rsi_91x_coex.c
+++ b/drivers/net/wireless/rsi/rsi_91x_coex.c
@@ -63,7 +63,7 @@ static void rsi_coex_scheduler_thread(struct rsi_common *common)
 		rsi_coex_sched_tx_pkts(coex_cb);
 	} while (atomic_read(&coex_cb->coex_tx_thread.thread_done) == 0);
 
-	complete_and_exit(&coex_cb->coex_tx_thread.completion, 0);
+	kthread_complete_and_exit(&coex_cb->coex_tx_thread.completion, 0);
 }
 
 int rsi_coex_recv_pkt(struct rsi_common *common, u8 *msg)
diff --git a/drivers/net/wireless/rsi/rsi_91x_main.c b/drivers/net/wireless/rsi/rsi_91x_main.c
index f1bf71e6c608..c7f5cec5e446 100644
--- a/drivers/net/wireless/rsi/rsi_91x_main.c
+++ b/drivers/net/wireless/rsi/rsi_91x_main.c
@@ -260,7 +260,7 @@ static void rsi_tx_scheduler_thread(struct rsi_common *common)
 		if (common->init_done)
 			rsi_core_qos_processor(common);
 	} while (atomic_read(&common->tx_thread.thread_done) == 0);
-	complete_and_exit(&common->tx_thread.completion, 0);
+	kthread_complete_and_exit(&common->tx_thread.completion, 0);
 }
 
 #ifdef CONFIG_RSI_COEX
diff --git a/drivers/net/wireless/rsi/rsi_91x_sdio_ops.c b/drivers/net/wireless/rsi/rsi_91x_sdio_ops.c
index 8ace1874e5cb..b2b47a0abcbf 100644
--- a/drivers/net/wireless/rsi/rsi_91x_sdio_ops.c
+++ b/drivers/net/wireless/rsi/rsi_91x_sdio_ops.c
@@ -75,7 +75,7 @@ void rsi_sdio_rx_thread(struct rsi_common *common)
 
 	rsi_dbg(INFO_ZONE, "%s: Terminated SDIO RX thread\n", __func__);
 	atomic_inc(&sdev->rx_thread.thread_done);
-	complete_and_exit(&sdev->rx_thread.completion, 0);
+	kthread_complete_and_exit(&sdev->rx_thread.completion, 0);
 }
 
 /**
diff --git a/drivers/net/wireless/rsi/rsi_91x_usb_ops.c b/drivers/net/wireless/rsi/rsi_91x_usb_ops.c
index 4ffcdde1acb1..5130b0e72adc 100644
--- a/drivers/net/wireless/rsi/rsi_91x_usb_ops.c
+++ b/drivers/net/wireless/rsi/rsi_91x_usb_ops.c
@@ -56,6 +56,6 @@ void rsi_usb_rx_thread(struct rsi_common *common)
 out:
 	rsi_dbg(INFO_ZONE, "%s: Terminated thread\n", __func__);
 	skb_queue_purge(&dev->rx_q);
-	complete_and_exit(&dev->rx_thread.completion, 0);
+	kthread_complete_and_exit(&dev->rx_thread.completion, 0);
 }
 
diff --git a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
index 669ef4700c1a..f7e86ae9f72f 100644
--- a/drivers/pnp/pnpbios/core.c
+++ b/drivers/pnp/pnpbios/core.c
@@ -160,7 +160,7 @@ static int pnp_dock_thread(void *unused)
 			 * No dock to manage
 			 */
 		case PNP_FUNCTION_NOT_SUPPORTED:
-			complete_and_exit(&unload_sem, 0);
+			kthread_complete_and_exit(&unload_sem, 0);
 		case PNP_SYSTEM_NOT_DOCKED:
 			d = 0;
 			break;
@@ -170,7 +170,7 @@ static int pnp_dock_thread(void *unused)
 		default:
 			pnpbios_print_status("pnp_dock_thread", status);
 			printk(KERN_WARNING "PnPBIOS: disabling dock monitoring.\n");
-			complete_and_exit(&unload_sem, 0);
+			kthread_complete_and_exit(&unload_sem, 0);
 		}
 		if (d != docked) {
 			if (pnp_dock_event(d, &now) == 0) {
@@ -183,7 +183,7 @@ static int pnp_dock_thread(void *unused)
 			}
 		}
 	}
-	complete_and_exit(&unload_sem, 0);
+	kthread_complete_and_exit(&unload_sem, 0);
 }
 
 static int pnpbios_get_resources(struct pnp_dev *dev)
diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
index 91fcf85e150a..5a58dac76c88 100644
--- a/drivers/staging/rts5208/rtsx.c
+++ b/drivers/staging/rts5208/rtsx.c
@@ -450,13 +450,13 @@ static int rtsx_control_thread(void *__dev)
 	 * after the down() -- that's necessary for the thread-shutdown
 	 * case.
 	 *
-	 * complete_and_exit() goes even further than this -- it is safe in
-	 * the case that the thread of the caller is going away (not just
-	 * the structure) -- this is necessary for the module-remove case.
-	 * This is important in preemption kernels, which transfer the flow
-	 * of execution immediately upon a complete().
+	 * kthread_complete_and_exit() goes even further than this --
+	 * it is safe in the case that the thread of the caller is going away
+	 * (not just the structure) -- this is necessary for the module-remove
+	 * case.  This is important in preemption kernels, which transfer the
+	 * flow of execution immediately upon a complete().
 	 */
-	complete_and_exit(&dev->control_exit, 0);
+	kthread_complete_and_exit(&dev->control_exit, 0);
 }
 
 static int rtsx_polling_thread(void *__dev)
@@ -501,7 +501,7 @@ static int rtsx_polling_thread(void *__dev)
 		mutex_unlock(&dev->dev_mutex);
 	}
 
-	complete_and_exit(&dev->polling_exit, 0);
+	kthread_complete_and_exit(&dev->polling_exit, 0);
 }
 
 /*
@@ -682,7 +682,7 @@ static int rtsx_scan_thread(void *__dev)
 		/* Should we unbind if no devices were detected? */
 	}
 
-	complete_and_exit(&dev->scanning_done, 0);
+	kthread_complete_and_exit(&dev->scanning_done, 0);
 }
 
 static void rtsx_init_options(struct rtsx_chip *chip)
diff --git a/drivers/usb/atm/usbatm.c b/drivers/usb/atm/usbatm.c
index da17be1ef64e..e3a49d837609 100644
--- a/drivers/usb/atm/usbatm.c
+++ b/drivers/usb/atm/usbatm.c
@@ -969,7 +969,7 @@ static int usbatm_do_heavy_init(void *arg)
 	instance->thread = NULL;
 	mutex_unlock(&instance->serialize);
 
-	complete_and_exit(&instance->thread_exited, ret);
+	kthread_complete_and_exit(&instance->thread_exited, ret);
 }
 
 static int usbatm_heavy_init(struct usbatm_data *instance)
diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index 752439690fda..46dd11dcb3a8 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -2547,7 +2547,7 @@ static int fsg_main_thread(void *common_)
 	up_write(&common->filesem);
 
 	/* Let fsg_unbind() know the thread has exited */
-	complete_and_exit(&common->thread_notifier, 0);
+	kthread_complete_and_exit(&common->thread_notifier, 0);
 }
 
 
diff --git a/fs/jffs2/background.c b/fs/jffs2/background.c
index 2b4d5013dc5d..6da92ecaf66d 100644
--- a/fs/jffs2/background.c
+++ b/fs/jffs2/background.c
@@ -161,5 +161,5 @@ static int jffs2_garbage_collect_thread(void *_c)
 	spin_lock(&c->erase_completion_lock);
 	c->gc_task = NULL;
 	spin_unlock(&c->erase_completion_lock);
-	complete_and_exit(&c->gc_thread_exit, 0);
+	kthread_complete_and_exit(&c->gc_thread_exit, 0);
 }
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 77755ac3e189..055eb203c00e 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -187,7 +187,6 @@ static inline void might_fault(void) { }
 #endif
 
 void do_exit(long error_code) __noreturn;
-void complete_and_exit(struct completion *, long) __noreturn;
 
 extern int num_to_str(char *buf, int size,
 		      unsigned long long num, unsigned int width);
diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 22c43d419687..d86a7e3b9a52 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -71,6 +71,7 @@ int kthread_park(struct task_struct *k);
 void kthread_unpark(struct task_struct *k);
 void kthread_parkme(void);
 void kthread_exit(long result) __noreturn;
+void kthread_complete_and_exit(struct completion *, long) __noreturn;
 
 int kthreadd(void *unused);
 extern struct task_struct *kthreadd_task;
diff --git a/kernel/exit.c b/kernel/exit.c
index 57afac845a0a..6c4b04531f17 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -891,15 +891,6 @@ void __noreturn make_task_dead(int signr)
 	do_exit(signr);
 }
 
-void complete_and_exit(struct completion *comp, long code)
-{
-	if (comp)
-		complete(comp);
-
-	do_exit(code);
-}
-EXPORT_SYMBOL(complete_and_exit);
-
 SYSCALL_DEFINE1(exit, int, error_code)
 {
 	do_exit((error_code&0xff)<<8);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 77b7c3f23f18..4388d6694a7f 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -283,6 +283,27 @@ void __noreturn kthread_exit(long result)
 	do_exit(result);
 }
 
+/**
+ * kthread_complete_and exit - Exit the current kthread.
+ * @comp: Completion to complete
+ * @code: The integer value to return to kthread_stop().
+ *
+ * If present complete @comp and the reuturn code to kthread_stop().
+ *
+ * A kernel thread whose module may be removed after the completion of
+ * @comp can use this function exit safely.
+ *
+ * Does not return.
+ */
+void __noreturn kthread_complete_and_exit(struct completion *comp, long code)
+{
+	if (comp)
+		complete(comp);
+
+	kthread_exit(code);
+}
+EXPORT_SYMBOL(kthread_complete_and_exit);
+
 static int kthread(void *_create)
 {
 	static const struct sched_param param = { .sched_priority = 0 };
diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
index 0dd434e40487..be38a2c5ecc2 100644
--- a/lib/kunit/try-catch.c
+++ b/lib/kunit/try-catch.c
@@ -17,7 +17,7 @@
 void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_catch)
 {
 	try_catch->try_result = -EFAULT;
-	complete_and_exit(try_catch->try_completion, -EFAULT);
+	kthread_complete_and_exit(try_catch->try_completion, -EFAULT);
 }
 EXPORT_SYMBOL_GPL(kunit_try_catch_throw);
 
@@ -27,7 +27,7 @@ static int kunit_generic_run_threadfn_adapter(void *data)
 
 	try_catch->try(try_catch->context);
 
-	complete_and_exit(try_catch->try_completion, 0);
+	kthread_complete_and_exit(try_catch->try_completion, 0);
 }
 
 static unsigned long kunit_test_timeout(void)
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 120e9598c11a..282273a1ffa5 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -171,7 +171,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"kthread_exit",
 		"make_task_dead",
 		"__module_put_and_kthread_exit",
-		"complete_and_exit",
+		"kthread_complete_and_exit",
 		"__reiserfs_panic",
 		"lbug_with_loc",
 		"fortify_panic",
-- 
2.29.2

