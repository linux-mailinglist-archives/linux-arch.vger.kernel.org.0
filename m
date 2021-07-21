Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E9D3D18C0
	for <lists+linux-arch@lfdr.de>; Wed, 21 Jul 2021 23:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhGUU33 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jul 2021 16:29:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229669AbhGUU33 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Jul 2021 16:29:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 459F961208;
        Wed, 21 Jul 2021 21:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901805;
        bh=O3fYbw1yzcdhQ3YhMPLOzXAM8TD1dNNVCuBzRAISN7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VOpHH1KEiiVBrhh8wNb4WTJ85orJQHL0HlQKqdFLJ6C7kvQBoZKx1F5xAu24y3eus
         m8mz/gHthJu7OFO/v7pffVyQQuhmSpp4wckMKqCGpfl7Rnpi/yZMRAQ49lEJJe6FJX
         0hFRKSx+O4/DPF0ofRROs6FjFEsGG+EgVwSbqK4LUZqrkZ/CkhCTXH5i1JQWkfAKbL
         HzPN336ykvprBS7+CPWhqZPi2/9J0tLIT3BkKc6fA08dteScRkZjuV/o9tYh1lP8aW
         Kq/0JZyfRHq1tBVyIxyBXIGIm2PYo3VRMdu+ALiqjXuPj2/4q1c9G2qyMdUixPe1gx
         SM44XLuiNiWcQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0D85D5C09A4; Wed, 21 Jul 2021 14:10:05 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH memory-model 1/4] tools/memory-model: Make read_foo_diagnostic() more clearly diagnostic
Date:   Wed, 21 Jul 2021 14:10:00 -0700
Message-Id: <20210721211003.869892-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721210726.GA828672@paulmck-ThinkPad-P17-Gen-1>
References: <20210721210726.GA828672@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The current definition of read_foo_diagnostic() in the "Lock Protection
With Lockless Diagnostic Access" section returns a value, which could
be use for any purpose.  This could mislead people into incorrectly
using data_race() in cases where READ_ONCE() is required.  This commit
therefore makes read_foo_diagnostic() simply print the value read.

Reported-by: Manfred Spraul <manfred@colorfullife.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/access-marking.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/Documentation/access-marking.txt b/tools/memory-model/Documentation/access-marking.txt
index 1ab189f51f55d..58bff26198767 100644
--- a/tools/memory-model/Documentation/access-marking.txt
+++ b/tools/memory-model/Documentation/access-marking.txt
@@ -259,9 +259,9 @@ diagnostic purposes.  The code might look as follows:
 		return ret;
 	}
 
-	int read_foo_diagnostic(void)
+	void read_foo_diagnostic(void)
 	{
-		return data_race(foo);
+		pr_info("Current value of foo: %d\n", data_race(foo));
 	}
 
 The reader-writer lock prevents the compiler from introducing concurrency
-- 
2.31.1.189.g2e36527f23

