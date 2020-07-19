Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C22B224ED3
	for <lists+linux-arch@lfdr.de>; Sun, 19 Jul 2020 05:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgGSDRg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Jul 2020 23:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgGSDRg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Jul 2020 23:17:36 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3DDC0619D2;
        Sat, 18 Jul 2020 20:17:35 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwzpV-00FQNz-EZ; Sun, 19 Jul 2020 03:17:33 +0000
Date:   Sun, 19 Jul 2020 04:17:33 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] raw_copy_from_user() semantics
Message-ID: <20200719031733.GI2786714@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

	Back in 2017 I'd made a bogus promise regarding raw_copy_from_user().
 Namely, that in case of short copy it will copy at least something unless
nothing could've been read at all.

	Such property could've been used by code that would want to squeeze
every byte, by doing copy_from_user() in a loop, advancing the source and
destination by the amount copied until we stop getting any progress.

	There are two problems with that.  First of all, the promise was
bogus - there are architectures where it is simply not true.  E.g. ppc
(or alpha, or sparc, or...)  can have copy_from_user() called with source
one word prior to an unmapped page, fetch that word, fail to fetch the next
one and bugger off without doing any stores.

	So any byte-squeezing loop of that sort would break on a bunch
of architectures.  Another problem is that we simply don't have a lot
of such loops.	Looking through the mainline kernel has found only two
such beasts - one in vcs_write() and another in iomap_dio_inline_actor().
Both are in write(2) and write(2) has never made any warranties regarding
the situation when a part of buffer we want to write is unreadable.
In particular, it does *not* squeeze every last byte out - not for
regular files on local filesystems, not for NFS, not for pipes, not for
sockets, etc.

	E.g. in case of generic_perform_write() we treat "nothing has
been copied" as "try to fault in, fail if that's not possible, retry the
attempt to copy otherwise"; we have to, since we are doing the copying
with pagefaults disabled, so a failure to copy anything may be simply
due to a page evicted by memory pressure.  And if we have an evicted page
followed by genuinely unreadable one, we can very well have fault-in fail
(and write stop) while we still have a couple of kilobytes worth of data
yet to be copied from the evicted page.

	We could try to make the promise true; that would mean messing
with a lot of unpleasant asm code (in exception handlers, at that) and
I don't believe it's worth the bother.  We could add a "squeeze every
last byte" helper, but I don't see any valid users for it right now.

	BTW, "do copy_from_user() in a loop" is not a good way to do such
helper anyway - if we stop copying on a fault and lose some data already
fetched, that data is not going to be more than a few registers worth,
so it's better to have this helper do a byte-by-byte get_user() loop
for dealing with that case.

	IMO we should simply remove the bogus promise, document the real
situation and if somebody needs the "squeeze every last byte" helper,
let them say so.  Audit of the current mainline shows only two places
that might be trying something like that and AFAICS both are accidental.

	Does anybody object against the following?

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 7bcadca22100..083fda6aa384 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -30,10 +30,11 @@
  * starting at from.  All data past to + size - N must be left unmodified.
  *
  * If copying succeeds, the return value must be 0.  If some data cannot be
- * fetched, it is permitted to copy less than had been fetched; the only
- * hard requirement is that not storing anything at all (i.e. returning size)
- * should happen only when nothing could be copied.  In other words, you don't
- * have to squeeze as much as possible - it is allowed, but not necessary.
+ * fetched, it is permitted to copy less than had been fetched.  In other
+ * words, you don't have to squeeze as much as possible - it is allowed, but
+ * not necessary.  In particular, it is possible to have some bytes fetched
+ * and nothing copied, so do _not_ assume that doing copies until we get to
+ * "nothing copied" will copy every byte that can be fetched.
  *
  * For raw_copy_from_user() to always points to kernel memory and no faults
  * on store should happen.  Interpretation of from is affected by set_fs().
