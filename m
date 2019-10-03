Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0FC1C959B
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2019 02:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbfJCA1A (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Oct 2019 20:27:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729683AbfJCA07 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Oct 2019 20:26:59 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 237A52245D;
        Thu,  3 Oct 2019 00:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570062419;
        bh=rTZ6wEyPg46xESmYS8KmK5z4QVTnQ52Yw+EykJrks1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oVrL2Y6AZeeVXSCKc2yHKEh/Qa+AVQgPI7fwCnUo5qAyOZXmjvqNcdNOL71v6NyED
         L9SIFwPUTgftbUFtYY4yMxtLz1egURZtwub1LrbP0BXSneTg9gK1ynQwXnPloUrOns
         xFS0DaB/xz+BjI8jy+WQhUUOsNKj4Zjg3nT6HzGs=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 24/32] tools/memory-model: Fix scripting --jobs argument
Date:   Wed,  2 Oct 2019 17:26:42 -0700
Message-Id: <20191003002650.11249-24-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003001039.GA8027@paulmck-ThinkPad-P72>
References: <20191003001039.GA8027@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

The parseargs.sh regular expression for the --jobs argument incorrectly
requires that the number of jobs be at least 10, that is, have at least
two digits.  This commit therefore adjusts this regular expression to
allow single-digit numbers of jobs to be specified.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/parseargs.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/scripts/parseargs.sh b/tools/memory-model/scripts/parseargs.sh
index 5f016fc..25a81ac 100755
--- a/tools/memory-model/scripts/parseargs.sh
+++ b/tools/memory-model/scripts/parseargs.sh
@@ -113,7 +113,7 @@ do
 		LKMM_JOBS="`echo $njobs | sed -e 's/^\([0-9]\+\).*$/\1/'`"
 		;;
 	--jobs|--job|-j)
-		checkarg --jobs "(number)" "$#" "$2" '^[1-9][0-9]\+$' '^--'
+		checkarg --jobs "(number)" "$#" "$2" '^[1-9][0-9]*$' '^--'
 		LKMM_JOBS="$2"
 		shift
 		;;
-- 
2.9.5

