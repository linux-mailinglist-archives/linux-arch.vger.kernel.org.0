Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C020046DCFA
	for <lists+linux-arch@lfdr.de>; Wed,  8 Dec 2021 21:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhLHUaK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Dec 2021 15:30:10 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:36940 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240294AbhLHUaI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Dec 2021 15:30:08 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:44652)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mv3WM-004DCE-8J; Wed, 08 Dec 2021 13:26:35 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:39446 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mv3WK-00CjR6-JS; Wed, 08 Dec 2021 13:26:33 -0700
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
Date:   Wed,  8 Dec 2021 14:25:29 -0600
Message-Id: <20211208202532.16409-7-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mv3WK-00CjR6-JS;;;mid=<20211208202532.16409-7-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19MLHpXMwI3BhfvYtjqimYwwOHUStQ52Ik=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMGappySubj_01,XMGappySubj_02,
        XMNoVowels,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 XMGappySubj_02 Gappier still
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1039 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 14 (1.3%), b_tie_ro: 12 (1.2%), parse: 2.2 (0.2%),
         extract_message_metadata: 15 (1.5%), get_uri_detail_list: 4.7 (0.5%),
        tests_pri_-1000: 13 (1.3%), tests_pri_-950: 1.46 (0.1%),
        tests_pri_-900: 1.24 (0.1%), tests_pri_-90: 108 (10.4%), check_bayes:
        107 (10.3%), b_tokenize: 12 (1.2%), b_tok_get_all: 11 (1.1%),
        b_comp_prob: 2.5 (0.2%), b_tok_touch_all: 75 (7.2%), b_finish: 1.26
        (0.1%), tests_pri_0: 855 (82.3%), check_dkim_signature: 0.73 (0.1%),
        check_dkim_adsp: 3.2 (0.3%), poll_dns_idle: 1.42 (0.1%), tests_pri_10:
        2.6 (0.3%), tests_pri_500: 21 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 07/10] exit: Rename module_put_and_exit to module_put_and_kthread_exit
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Update module_put_and_exit to call kthread_exit instead of do_exit.

Change the name to reflect this change in functionality.  All of the
users of module_put_and_exit are causing the current kthread to exit
so this change makes it clear what is happening.  There is no
functional change.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 crypto/algboss.c          | 4 ++--
 fs/cifs/connect.c         | 2 +-
 fs/nfs/callback.c         | 4 ++--
 fs/nfs/nfs4state.c        | 2 +-
 fs/nfsd/nfssvc.c          | 2 +-
 include/linux/module.h    | 6 +++---
 kernel/module.c           | 6 +++---
 net/bluetooth/bnep/core.c | 2 +-
 net/bluetooth/cmtp/core.c | 2 +-
 net/bluetooth/hidp/core.c | 2 +-
 tools/objtool/check.c     | 2 +-
 11 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/crypto/algboss.c b/crypto/algboss.c
index 1814d2c5188a..eb5fe84efb83 100644
--- a/crypto/algboss.c
+++ b/crypto/algboss.c
@@ -67,7 +67,7 @@ static int cryptomgr_probe(void *data)
 	complete_all(&param->larval->completion);
 	crypto_alg_put(&param->larval->alg);
 	kfree(param);
-	module_put_and_exit(0);
+	module_put_and_kthread_exit(0);
 }
 
 static int cryptomgr_schedule_probe(struct crypto_larval *larval)
@@ -190,7 +190,7 @@ static int cryptomgr_test(void *data)
 	crypto_alg_tested(param->driver, err);
 
 	kfree(param);
-	module_put_and_exit(0);
+	module_put_and_kthread_exit(0);
 }
 
 static int cryptomgr_schedule_test(struct crypto_alg *alg)
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 82577a7a5bb1..39fbe9acbf51 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -1139,7 +1139,7 @@ cifs_demultiplex_thread(void *p)
 	}
 
 	memalloc_noreclaim_restore(noreclaim_flag);
-	module_put_and_exit(0);
+	module_put_and_kthread_exit(0);
 }
 
 /*
diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 86d856de1389..3c86a559a321 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -93,7 +93,7 @@ nfs4_callback_svc(void *vrqstp)
 		svc_process(rqstp);
 	}
 	svc_exit_thread(rqstp);
-	module_put_and_exit(0);
+	module_put_and_kthread_exit(0);
 	return 0;
 }
 
@@ -137,7 +137,7 @@ nfs41_callback_svc(void *vrqstp)
 		}
 	}
 	svc_exit_thread(rqstp);
-	module_put_and_exit(0);
+	module_put_and_kthread_exit(0);
 	return 0;
 }
 
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index ecc4594299d6..ea41af731978 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2689,6 +2689,6 @@ static int nfs4_run_state_manager(void *ptr)
 	allow_signal(SIGKILL);
 	nfs4_state_manager(clp);
 	nfs_put_client(clp);
-	module_put_and_exit(0);
+	module_put_and_kthread_exit(0);
 	return 0;
 }
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 80431921e5d7..5ce9f14318c4 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -986,7 +986,7 @@ nfsd(void *vrqstp)
 
 	/* Release module */
 	mutex_unlock(&nfsd_mutex);
-	module_put_and_exit(0);
+	module_put_and_kthread_exit(0);
 	return 0;
 }
 
diff --git a/include/linux/module.h b/include/linux/module.h
index c9f1200b2312..f03be97e9ec1 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -595,9 +595,9 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 /* Look for this name: can be of form module:name. */
 unsigned long module_kallsyms_lookup_name(const char *name);
 
-extern void __noreturn __module_put_and_exit(struct module *mod,
+extern void __noreturn __module_put_and_kthread_exit(struct module *mod,
 			long code);
-#define module_put_and_exit(code) __module_put_and_exit(THIS_MODULE, code)
+#define module_put_and_kthread_exit(code) __module_put_and_kthread_exit(THIS_MODULE, code)
 
 #ifdef CONFIG_MODULE_UNLOAD
 int module_refcount(struct module *mod);
@@ -790,7 +790,7 @@ static inline int unregister_module_notifier(struct notifier_block *nb)
 	return 0;
 }
 
-#define module_put_and_exit(code) do_exit(code)
+#define module_put_and_kthread_exit(code) kthread_exit(code)
 
 static inline void print_modules(void)
 {
diff --git a/kernel/module.c b/kernel/module.c
index 84a9141a5e15..a3aa00bf270d 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -337,12 +337,12 @@ static inline void add_taint_module(struct module *mod, unsigned flag,
  * A thread that wants to hold a reference to a module only while it
  * is running can call this to safely exit.  nfsd and lockd use this.
  */
-void __noreturn __module_put_and_exit(struct module *mod, long code)
+void __noreturn __module_put_and_kthread_exit(struct module *mod, long code)
 {
 	module_put(mod);
-	do_exit(code);
+	kthread_exit(code);
 }
-EXPORT_SYMBOL(__module_put_and_exit);
+EXPORT_SYMBOL(__module_put_and_kthread_exit);
 
 /* Find a module section: 0 means not found. */
 static unsigned int find_sec(const struct load_info *info, const char *name)
diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index c9add7753b9f..40baa6b7321a 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -535,7 +535,7 @@ static int bnep_session(void *arg)
 
 	up_write(&bnep_session_sem);
 	free_netdev(dev);
-	module_put_and_exit(0);
+	module_put_and_kthread_exit(0);
 	return 0;
 }
 
diff --git a/net/bluetooth/cmtp/core.c b/net/bluetooth/cmtp/core.c
index 0a2d78e811cf..9bfded6b74b3 100644
--- a/net/bluetooth/cmtp/core.c
+++ b/net/bluetooth/cmtp/core.c
@@ -323,7 +323,7 @@ static int cmtp_session(void *arg)
 	up_write(&cmtp_session_sem);
 
 	kfree(session);
-	module_put_and_exit(0);
+	module_put_and_kthread_exit(0);
 	return 0;
 }
 
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 80848dfc01db..5940744a8cd8 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -1305,7 +1305,7 @@ static int hidp_session_thread(void *arg)
 	l2cap_unregister_user(session->conn, &session->user);
 	hidp_session_put(session);
 
-	module_put_and_exit(0);
+	module_put_and_kthread_exit(0);
 	return 0;
 }
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 90108fe5610d..120e9598c11a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -170,7 +170,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"do_task_dead",
 		"kthread_exit",
 		"make_task_dead",
-		"__module_put_and_exit",
+		"__module_put_and_kthread_exit",
 		"complete_and_exit",
 		"__reiserfs_panic",
 		"lbug_with_loc",
-- 
2.29.2

