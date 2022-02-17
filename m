Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AB04BA5F9
	for <lists+linux-arch@lfdr.de>; Thu, 17 Feb 2022 17:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243287AbiBQQb2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Feb 2022 11:31:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238237AbiBQQbZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2022 11:31:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320FF1B8925;
        Thu, 17 Feb 2022 08:31:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BECD6B821AE;
        Thu, 17 Feb 2022 16:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE7EC340E9;
        Thu, 17 Feb 2022 16:31:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="dbNpSV7Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645115463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2QY2mZgOV60Kbrn2Y05ZSmgIZIkCZL9pkjx2/BQNMMo=;
        b=dbNpSV7Q3uSu9oKOeH1MLqEJknYhhjA6o4ycxcxMcK7Sy8v2cUv/tQX2gz+9xMKeAqUq1c
        xIcbU/vGMq2X/5W+dP5BXNkNdnPXuRcFE9latLb6OY0Nntyuw7jJo+5qFjqIZruiaPBksJ
        BMwnnzWeFsTEk+dHhaPe+Tfx/J0BpFQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4b2b80a7 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 17 Feb 2022 16:31:02 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "David S . Miller" <davem@davemloft.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Borislav Petkov <bp@alien8.de>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Joshua Kinard <kumba@gentoo.org>,
        David Laight <David.Laight@aculab.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v1] random: block in /dev/urandom
Date:   Thu, 17 Feb 2022 17:28:48 +0100
Message-Id: <20220217162848.303601-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This topic has come up countless times, and usually doesn't go anywhere.
This time I thought I'd bring it up with a slightly narrower focus,
updated for some developments over the last three years: we finally can
make /dev/urandom always secure, in light of the fact that our RNG is
now always seeded.

Ever since Linus' 50ee7529ec45 ("random: try to actively add entropy
rather than passively wait for it"), the RNG does a haveged-style jitter
dance around the scheduler, in order to produce entropy (and credit it)
for the case when we're stuck in wait_for_random_bytes(). How ever you
feel about the Linus Jitter Dance is beside the point: it's been there
for three years and usually gets the RNG initialized in a second or so.

As a matter of fact, this is what happens currently when people use
getrandom(). It's already there and working, and most people have been
using it for years without realizing.

So, given that the kernel has grown this mechanism for seeding itself
from nothing, and that this procedure happens pretty fast, maybe there's
no point any longer in having /dev/urandom give insecure bytes. In the
past we didn't want the boot process to deadlock, which was
understandable. But now, in the worst case, a second goes by, and the
problem is resolved. It seems like maybe we're finally at a point when
we can get rid of the infamous "urandom read hole".

The one slight drawback is that the Linus Jitter Dance relies on random_
get_entropy() being implemented. The first lines of try_to_generate_
entropy() are:

	stack.now = random_get_entropy();
	if (stack.now == random_get_entropy())
		return;

On most platforms, random_get_entropy() is simply aliased to get_cycles().
The number of machines without a cycle counter or some other
implementation of random_get_entropy() in 2022, which can also run a
mainline kernel, and at the same time have a both broken and out of date
userspace that relies on /dev/urandom never blocking at boot is thought
to be exceedingly low. And to be clear: those museum pieces without
cycle counters will continue to run Linux just fine, and even
/dev/urandom will be operable just like before; the RNG just needs to be
seeded first through the usual means, which should already be the case
now.

On systems that really do want unseeded randomness, we already offer
getrandom(GRND_INSECURE), which is in use by, e.g., systemd for seeding
their hash tables at boot. Nothing in this commit would affect
GRND_INSECURE, and it remains the means of getting those types of random
numbers.

This patch goes a long way toward eliminating a long overdue userspace
crypto footgun. After several decades of endless user confusion, we will
finally be able to say, "use any single one of our random interfaces and
you'll be fine. They're all the same. It doesn't matter." And that, I
think, is really something. Finally all of those blog posts and
disagreeing forums and contradictory articles will all become correct
about whatever they happened to recommend, and along with it, a whole
class of vulnerabilities eliminated.

With very minimal downside, we're finally in a position where we can
make this change.

Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Nick Hu <nickhu@andestech.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Guo Ren <guoren@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Joshua Kinard <kumba@gentoo.org>
Cc: David Laight <David.Laight@aculab.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Having learned that MIPS32 isn't affected by this (initially my largest
worry), and then heartened today upon reading LWN's summary of our
previous discussion ("it would seem there are no huge barriers to
removing the final distinction between /dev/random and /dev/urandom"), I
figured I'd go ahead and submit a v1 of this. It seems at least worth
trying and seeing if somebody arrives with legitimate complaints. To
that end I've also widened the CC list quite a bit.

Changes v0->v1:
- We no longer touch GRND_INSECURE at all, in anyway. Lennart (and to an
  extent, Andy) pointed out that getting insecure numbers immediately at
  boot is still something that has legitimate use cases, so this patch
  no longer touches that code.

 drivers/char/mem.c     |  2 +-
 drivers/char/random.c  | 51 ++++++------------------------------------
 include/linux/random.h |  2 +-
 3 files changed, 9 insertions(+), 46 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index cc296f0823bd..9f586025dbe6 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -707,7 +707,7 @@ static const struct memdev {
 	 [5] = { "zero", 0666, &zero_fops, FMODE_NOWAIT },
 	 [7] = { "full", 0666, &full_fops, 0 },
 	 [8] = { "random", 0666, &random_fops, 0 },
-	 [9] = { "urandom", 0666, &urandom_fops, 0 },
+	 [9] = { "urandom", 0666, &random_fops, 0 },
 #ifdef CONFIG_PRINTK
 	[11] = { "kmsg", 0644, &kmsg_fops, 0 },
 #endif
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 8d5abeefcc4f..fda5182d655d 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -89,8 +89,6 @@ static LIST_HEAD(random_ready_list);
 /* Control how we warn userspace. */
 static struct ratelimit_state unseeded_warning =
 	RATELIMIT_STATE_INIT("warn_unseeded_randomness", HZ, 3);
-static struct ratelimit_state urandom_warning =
-	RATELIMIT_STATE_INIT("warn_urandom_randomness", HZ, 3);
 static int ratelimit_disable __read_mostly;
 module_param_named(ratelimit_disable, ratelimit_disable, int, 0644);
 MODULE_PARM_DESC(ratelimit_disable, "Disable random ratelimit suppression");
@@ -336,11 +334,6 @@ static void crng_reseed(void)
 				  unseeded_warning.missed);
 			unseeded_warning.missed = 0;
 		}
-		if (urandom_warning.missed) {
-			pr_notice("%d urandom warning(s) missed due to ratelimiting\n",
-				  urandom_warning.missed);
-			urandom_warning.missed = 0;
-		}
 	}
 }
 
@@ -993,10 +986,8 @@ int __init rand_initialize(void)
 		pr_notice("crng init done (trusting CPU's manufacturer)\n");
 	}
 
-	if (ratelimit_disable) {
-		urandom_warning.interval = 0;
+	if (ratelimit_disable)
 		unseeded_warning.interval = 0;
-	}
 	return 0;
 }
 
@@ -1382,20 +1373,16 @@ static void try_to_generate_entropy(void)
  * getrandom(2) is the primary modern interface into the RNG and should
  * be used in preference to anything else.
  *
- * Reading from /dev/random has the same functionality as calling
- * getrandom(2) with flags=0. In earlier versions, however, it had
- * vastly different semantics and should therefore be avoided, to
- * prevent backwards compatibility issues.
- *
- * Reading from /dev/urandom has the same functionality as calling
- * getrandom(2) with flags=GRND_INSECURE. Because it does not block
- * waiting for the RNG to be ready, it should not be used.
+ * Reading from /dev/random and /dev/urandom both have the same effect
+ * as calling getrandom(2) with flags=0. (In earlier versions, however,
+ * they each had different semantics.)
  *
  * Writing to either /dev/random or /dev/urandom adds entropy to
  * the input pool but does not credit it.
  *
- * Polling on /dev/random indicates when the RNG is initialized, on
- * the read side, and when it wants new entropy, on the write side.
+ * Polling on /dev/random or /dev/urandom indicates when the RNG
+ * is initialized, on the read side, and when it wants new entropy,
+ * on the write side.
  *
  * Both /dev/random and /dev/urandom have the same set of ioctls for
  * adding entropy, getting the entropy count, zeroing the count, and
@@ -1480,21 +1467,6 @@ static ssize_t random_write(struct file *file, const char __user *buffer,
 	return (ssize_t)count;
 }
 
-static ssize_t urandom_read(struct file *file, char __user *buf, size_t nbytes,
-			    loff_t *ppos)
-{
-	static int maxwarn = 10;
-
-	if (!crng_ready() && maxwarn > 0) {
-		maxwarn--;
-		if (__ratelimit(&urandom_warning))
-			pr_notice("%s: uninitialized urandom read (%zd bytes read)\n",
-				  current->comm, nbytes);
-	}
-
-	return get_random_bytes_user(buf, nbytes);
-}
-
 static ssize_t random_read(struct file *file, char __user *buf, size_t nbytes,
 			   loff_t *ppos)
 {
@@ -1581,15 +1553,6 @@ const struct file_operations random_fops = {
 	.llseek = noop_llseek,
 };
 
-const struct file_operations urandom_fops = {
-	.read = urandom_read,
-	.write = random_write,
-	.unlocked_ioctl = random_ioctl,
-	.compat_ioctl = compat_ptr_ioctl,
-	.fasync = random_fasync,
-	.llseek = noop_llseek,
-};
-
 
 /********************************************************************
  *
diff --git a/include/linux/random.h b/include/linux/random.h
index d7354de9351e..38ff777aad19 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -44,7 +44,7 @@ extern void del_random_ready_callback(struct random_ready_callback *rdy);
 extern size_t __must_check get_random_bytes_arch(void *buf, size_t nbytes);
 
 #ifndef MODULE
-extern const struct file_operations random_fops, urandom_fops;
+extern const struct file_operations random_fops;
 #endif
 
 u32 get_random_u32(void);
-- 
2.35.0

