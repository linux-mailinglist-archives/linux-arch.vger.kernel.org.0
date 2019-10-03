Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42C49C95D2
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2019 02:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfJCA2m (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Oct 2019 20:28:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729614AbfJCA0z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Oct 2019 20:26:55 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C8F8222CD;
        Thu,  3 Oct 2019 00:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570062415;
        bh=O+cZyCAFgCGKKLXpdo/DfJ7oqtdcbhNDwHCF/bYAQmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gJkjOZjBHT01IIEIEE33EygNEpSEkQXhzWToGR9b9JwEKWgIANv59YbX+hh1DfqnL
         DCGUqsbAuOG4awocngBZ6X8o4D1S+8fhlFbyISfuT2eV9y69YUkzdKplVkYI+DO89u
         CfZgqC5SgXmNJesZ/g9ugXqdFYGqA1xECntgvPb8=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 10/32] tools/memory-model: Update parseargs.sh for hardware verification
Date:   Wed,  2 Oct 2019 17:26:28 -0700
Message-Id: <20191003002650.11249-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003001039.GA8027@paulmck-ThinkPad-P72>
References: <20191003001039.GA8027@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

This commit adds a --hw argument to parseargs.sh to specify the CPU
family for a hardware verification.  For example, "--hw AArch64" will
specify that a C-language litmus test is to be translated to ARMv8 and
the result verified.  This will set the LKMM_HW_MAP_FILE environment
variable accordingly.  If there is no --hw argument, this environment
variable will be set to the empty string.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/parseargs.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/memory-model/scripts/parseargs.sh b/tools/memory-model/scripts/parseargs.sh
index afe7bd2..5f016fc 100755
--- a/tools/memory-model/scripts/parseargs.sh
+++ b/tools/memory-model/scripts/parseargs.sh
@@ -27,6 +27,7 @@ initparam () {
 
 initparam LKMM_DESTDIR "."
 initparam LKMM_HERD_OPTIONS "-conf linux-kernel.cfg"
+initparam LKMM_HW_MAP_FILE ""
 initparam LKMM_JOBS `getconf _NPROCESSORS_ONLN`
 initparam LKMM_PROCS "3"
 initparam LKMM_TIMEOUT "1m"
@@ -37,10 +38,11 @@ usagehelp () {
 	echo "Usage $scriptname [ arguments ]"
 	echo "      --destdir path (place for .litmus.out, default by .litmus)"
 	echo "      --herdopts -conf linux-kernel.cfg ..."
+	echo "      --hw AArch64"
 	echo "      --jobs N (number of jobs, default one per CPU)"
 	echo "      --procs N (litmus tests with at most this many processes)"
 	echo "      --timeout N (herd7 timeout (e.g., 10s, 1m, 2hr, 1d, '')"
-	echo "Defaults: --destdir '$LKMM_DESTDIR_DEF' --herdopts '$LKMM_HERD_OPTIONS_DEF' --jobs '$LKMM_JOBS_DEF' --procs '$LKMM_PROCS_DEF' --timeout '$LKMM_TIMEOUT_DEF'"
+	echo "Defaults: --destdir '$LKMM_DESTDIR_DEF' --herdopts '$LKMM_HERD_OPTIONS_DEF' --hw '$LKMM_HW_MAP_FILE' --jobs '$LKMM_JOBS_DEF' --procs '$LKMM_PROCS_DEF' --timeout '$LKMM_TIMEOUT_DEF'"
 	exit 1
 }
 
@@ -95,6 +97,11 @@ do
 		LKMM_HERD_OPTIONS="$2"
 		shift
 		;;
+	--hw)
+		checkarg --hw "(.map file architecture name)" "$#" "$2" '^[A-Za-z0-9_-]\+' '^--'
+		LKMM_HW_MAP_FILE="$2"
+		shift
+		;;
 	-j[1-9]*)
 		njobs="`echo $1 | sed -e 's/^-j//'`"
 		trailchars="`echo $njobs | sed -e 's/[0-9]\+\(.*\)$/\1/'`"
-- 
2.9.5

