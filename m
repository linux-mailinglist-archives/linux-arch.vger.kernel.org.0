Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCE64AB07C
	for <lists+linux-arch@lfdr.de>; Sun,  6 Feb 2022 17:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244303AbiBFQAK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Feb 2022 11:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237803AbiBFQAJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Feb 2022 11:00:09 -0500
Received: from talisker.home.drummond.us (drummond.us [74.95.14.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E77CC043184
        for <linux-arch@vger.kernel.org>; Sun,  6 Feb 2022 08:00:09 -0800 (PST)
Received: from talisker.home.drummond.us (localhost [127.0.0.1])
        by talisker.home.drummond.us (8.15.2/8.15.2/Debian-20) with ESMTP id 216FnCIm2355965;
        Sun, 6 Feb 2022 07:49:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=home.drummond.us;
        s=default; t=1644162552;
        bh=C0SGrdD0bHER6z6tzFAueoA7f+uAqZowOEaDKBDt4aw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DhtOVt4f61DooeJVSmXijShgM7VraTmww4/6eaVCj2rydDXgCMSB/Y13Vi1m/3xDx
         KV8lyPqjGDJhQlqio1792gXowICHBJEZLXO3uuC8D1VtUxCDjUnQjeKpj53jf/GA+D
         20HhEk4r4bWbXrLtDH++IkNTDsNvg1gcURNN/WB/k12SBS4tqAqbHwNb7jwmEsNH7o
         smPrQYVQikvzCPQGnL3RjGt9NeVnXWUXstMvHQCetN1Did/caYW0cD764om3kwBCMv
         5/nArkFHBskLMQijfGlWBT9yfWP/dL+CTlvoygh8VMvinOSjdc60d/T+TfuM8QiIkW
         Dcw5LLKBwZRCg==
Received: (from walt@localhost)
        by talisker.home.drummond.us (8.15.2/8.15.2/Submit) id 216FnBsV2355964;
        Sun, 6 Feb 2022 07:49:11 -0800
From:   Walt Drummond <walt@drummond.us>
To:     agordeev@linux.ibm.com, arnd@arndb.de, benh@kernel.crashing.org,
        borntraeger@de.ibm.com, chris@zankel.net, davem@davemloft.net,
        gregkh@linuxfoundation.org, hca@linux.ibm.com, deller@gmx.de,
        ink@jurassic.park.msu.ru, James.Bottomley@HansenPartnership.com,
        jirislaby@kernel.org, mattst88@gmail.com, jcmvbkbc@gmail.com,
        mpe@ellerman.id.au, paulus@samba.org, rth@twiddle.net,
        dalias@libc.org, tsbogend@alpha.franken.de, gor@linux.ibm.com,
        ysato@users.osdn.me
Cc:     linux-kernel@vger.kernel.org, ar@cs.msu.ru, walt@drummond.us,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: [PATCH v2 1/3] vstatus: Allow the n_tty line dicipline to write to a user tty
Date:   Sun,  6 Feb 2022 07:48:52 -0800
Message-Id: <20220206154856.2355838-2-walt@drummond.us>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220206154856.2355838-1-walt@drummond.us>
References: <20220206154856.2355838-1-walt@drummond.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Refactor the implementation of n_tty_write() into do_n_tty_write(),
and change n_tty_write() to call do_n_tty_write() after acquiring
tty.termios_rwsem.

This allows the n_tty line dicipline to write to a user tty via
do_n_tty_write() when already holding tty.termios_rwsem.

Signed-off-by: Walt Drummond <walt@drummond.us>
---
 drivers/tty/n_tty.c | 69 +++++++++++++++++++++++++++------------------
 include/linux/tty.h |  2 +-
 2 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 0ec93f1a61f5..64a058a4c63b 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2231,45 +2231,24 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 	return retval;
 }
 
-/**
- *	n_tty_write		-	write function for tty
- *	@tty: tty device
- *	@file: file object
- *	@buf: userspace buffer pointer
- *	@nr: size of I/O
- *
- *	Write function of the terminal device.  This is serialized with
- *	respect to other write callers but not to termios changes, reads
- *	and other such events.  Since the receive code will echo characters,
- *	thus calling driver write methods, the output_lock is used in
- *	the output processing functions called here as well as in the
- *	echo processing function to protect the column state and space
- *	left in the buffer.
- *
- *	This code must be sure never to sleep through a hangup.
- *
- *	Locking: output_lock to protect column state and space left
- *		 (note that the process_output*() functions take this
- *		  lock themselves)
- */
-
-static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
-			   const unsigned char *buf, size_t nr)
+static ssize_t do_n_tty_write(struct tty_struct *tty, struct file *file,
+			      const unsigned char *buf, size_t nr)
 {
 	const unsigned char *b = buf;
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	int c;
 	ssize_t retval = 0;
 
+	lockdep_assert_held_read(&tty->termios_rwsem);
+
 	/* Job control check -- must be done at start (POSIX.1 7.1.1.4). */
-	if (L_TOSTOP(tty) && file->f_op->write_iter != redirected_tty_write) {
+	if (L_TOSTOP(tty) &&
+	    !(file && file->f_op->write_iter != redirected_tty_write)) {
 		retval = tty_check_change(tty);
 		if (retval)
 			return retval;
 	}
 
-	down_read(&tty->termios_rwsem);
-
 	/* Write out any echoed characters that are still pending */
 	process_echoes(tty);
 
@@ -2336,10 +2315,44 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 	remove_wait_queue(&tty->write_wait, &wait);
 	if (nr && tty->fasync)
 		set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
-	up_read(&tty->termios_rwsem);
+
 	return (b - buf) ? b - buf : retval;
 }
 
+/**
+ *	n_tty_write		-	write function for tty
+ *	@tty: tty device
+ *	@file: file object
+ *	@buf: userspace buffer pointer
+ *	@nr: size of I/O
+ *
+ *	Write function of the terminal device.  This is serialized with
+ *	respect to other write callers but not to termios changes, reads
+ *	and other such events.  Since the receive code will echo characters,
+ *	thus calling driver write methods, the output_lock is used in
+ *	the output processing functions called here as well as in the
+ *	echo processing function to protect the column state and space
+ *	left in the buffer.
+ *
+ *	This code must be sure never to sleep through a hangup.
+ *
+ *	Locking: output_lock to protect column state and space left
+ *		 (note that the process_output*() functions take this
+ *		  lock themselves)
+ */
+
+static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
+			   const unsigned char *buf, size_t nr)
+{
+	ssize_t retval = 0;
+
+	down_read(&tty->termios_rwsem);
+	retval = do_n_tty_write(tty, file, buf, nr);
+	up_read(&tty->termios_rwsem);
+
+	return retval;
+}
+
 /**
  *	n_tty_poll		-	poll method for N_TTY
  *	@tty: terminal device
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 168e57e40bbb..cbe5d535a69d 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -237,7 +237,7 @@ struct tty_file_private {
 
 static inline bool tty_io_nonblock(struct tty_struct *tty, struct file *file)
 {
-	return file->f_flags & O_NONBLOCK ||
+	return (file && file->f_flags & O_NONBLOCK) ||
 		test_bit(TTY_LDISC_CHANGING, &tty->flags);
 }
 
-- 
2.30.2

