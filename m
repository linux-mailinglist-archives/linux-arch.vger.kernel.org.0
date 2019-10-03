Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A63EC95B2
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2019 02:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfJCA1p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Oct 2019 20:27:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729695AbfJCA1A (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Oct 2019 20:27:00 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 054FC222CF;
        Thu,  3 Oct 2019 00:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570062420;
        bh=o+hZcG7ngt1zi3oQgpnb6ZerYFL9+QDRRjGbTu5AzGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dlQTwYDvsnlv+/Os5wxu4BsXpaKEg5tI79dMUy2xbqllWlYNnYGDbT4hdE6Oe1LoO
         j9+EoPV3GfeNwpClylR890pMsgnEno5M897w0ZGXhHRKGGBvVcuhJ+co7oO+AmoHm4
         iO1vC6znVO/V7PTPuPumiLcuqDkWazbe6vIXCzTA=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 27/32] tools/memory-model:  Add "--" to parseargs.sh for additional arguments
Date:   Wed,  2 Oct 2019 17:26:45 -0700
Message-Id: <20191003002650.11249-27-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003001039.GA8027@paulmck-ThinkPad-P72>
References: <20191003001039.GA8027@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

Currently, parseargs.sh expects to consume all the command-line arguments,
which prevents the calling script from having any of its own arguments.
This commit therefore causes parseargs.sh to stop consuming arguments
when it encounters a "--" argument, leaving any remaining arguments for
the calling script.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/parseargs.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/memory-model/scripts/parseargs.sh b/tools/memory-model/scripts/parseargs.sh
index 25a81ac..7aa5875 100755
--- a/tools/memory-model/scripts/parseargs.sh
+++ b/tools/memory-model/scripts/parseargs.sh
@@ -83,7 +83,7 @@ do
 			echo "Cannot create directory --destdir '$LKMM_DESTDIR'"
 			usage
 		fi
-		if test -d "$LKMM_DESTDIR" -a -w "$LKMM_DESTDIR" -a -x "$LKMM_DESTDIR"
+		if test -d "$LKMM_DESTDIR" -a -x "$LKMM_DESTDIR"
 		then
 			:
 		else
@@ -127,6 +127,10 @@ do
 		LKMM_TIMEOUT="$2"
 		shift
 		;;
+	--)
+		shift
+		break
+		;;
 	*)
 		echo Unknown argument $1
 		usage
-- 
2.9.5

