Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3166167F21
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 14:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgBUNu1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 08:50:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56308 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbgBUNu0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 08:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=/7FTmAZ9HylxggVZ5DJyooZDKHmy7BhA9eGB1mudgDk=; b=u+ZqjxtLoACewMEDhItDZDvlIb
        B93+c7BvzqNVTJujmMmxNErMbDpEFQNE1vHkKoxasaXQMIN/ibjP8hB8aTMCZx24Xuidk1STLtydI
        1BpgVCAbvP5NvyYZntxiDMKieuB9kpyrB1cWf42py3/zRxpyY5bVV2Jj1Fz+w35aIj24C8mqd5GIF
        8pYW6AWCvpo42m7ci4atK0Zl7izvS2skyWlv+cmc1b39c4uGVoMEL0Z9+ontcB6sf9dhGjg+H1zmD
        nYXgyzfmQ9Yw+3+bCUiXRdLd5PgXd7tgH06F3Vfc9eJpIWyBIiGgwK+g8hQsv6ioqvHpErvTckE/u
        tzKkhwSg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j58gx-00014B-05; Fri, 21 Feb 2020 13:50:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8E0C330785A;
        Fri, 21 Feb 2020 14:48:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4827029D740B9; Fri, 21 Feb 2020 14:50:01 +0100 (CET)
Message-Id: <20200221134216.803627089@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Feb 2020 14:34:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: [PATCH v4 26/27] x86/int3: Inline bsearch()
References: <20200221133416.777099322@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Avoid calling out to bsearch() by inlining it, for normal kernel
configs this was the last external call and poke_int3_handler() is now
fully self sufficient -- no calls to external code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -979,7 +979,7 @@ static __always_inline void *text_poke_a
 	return _stext + tp->rel_addr;
 }
 
-static int notrace patch_cmp(const void *key, const void *elt)
+static __always_inline int patch_cmp(const void *key, const void *elt)
 {
 	struct text_poke_loc *tp = (struct text_poke_loc *) elt;
 
@@ -989,7 +989,6 @@ static int notrace patch_cmp(const void
 		return 1;
 	return 0;
 }
-NOKPROBE_SYMBOL(patch_cmp);
 
 int notrace poke_int3_handler(struct pt_regs *regs)
 {
@@ -1024,9 +1023,9 @@ int notrace poke_int3_handler(struct pt_
 	 * Skip the binary search if there is a single member in the vector.
 	 */
 	if (unlikely(desc->nr_entries > 1)) {
-		tp = bsearch(ip, desc->vec, desc->nr_entries,
-			     sizeof(struct text_poke_loc),
-			     patch_cmp);
+		tp = __bsearch(ip, desc->vec, desc->nr_entries,
+			       sizeof(struct text_poke_loc),
+			       patch_cmp);
 		if (!tp)
 			goto out_put;
 	} else {


