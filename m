Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98C94268A5
	for <lists+linux-arch@lfdr.de>; Fri,  8 Oct 2021 13:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240126AbhJHLY2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Oct 2021 07:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240084AbhJHLY1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Oct 2021 07:24:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEDFC061570
        for <linux-arch@vger.kernel.org>; Fri,  8 Oct 2021 04:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Wpos95iylg095UsnNd0rlORwCu4Pilf9lSCl83VJs5E=; b=mjnHjiFL8fgTvCgRAlskuGnJns
        u03K1QDnbK+Pdbv03xYUPsoHOdn5MDbONdpfxyOF7/eDxA6vcgOVmNh3KKmO6ihKcAMqSQKRtdQT2
        9/AZ247GgZ8mnpWU9h2VLauiyKfp89lZEzOulxDk0NkELDEYdlAZYEMB+TBJTUxINy9nUkC9HhWVv
        5J3MxVLC+rotWT2KRsMWKD+JjlrMZQL0fQrwfcWQjCnmfnuHyTXIBdxchmo7+DRCtEz/hveNnP6fz
        izWRikGm6y6hJW/PpGd6BS5GUg+cqe//iUj+OKTBYJmkvChJ9rwN8gxYkQ591AwMYWcJmwWzc8QdD
        UO9S2pWw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYnsI-0032fz-VL; Fri, 08 Oct 2021 11:17:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 93FA3302A20;
        Fri,  8 Oct 2021 13:17:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DAF102DB84A68; Fri,  8 Oct 2021 13:17:07 +0200 (CEST)
Message-ID: <20211008111626.211281780@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 08 Oct 2021 13:15:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     keescook@chromium.org, jannh@google.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        vcaputo@pengaru.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, amistry@google.com,
        Kenta.Tada@sony.com, legion@kernel.org,
        michael.weiss@aisec.fraunhofer.de, mhocko@suse.com, deller@gmx.de,
        zhengqi.arch@bytedance.com, me@tobin.cc, tycho@tycho.pizza,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com,
        mark.rutland@arm.com, axboe@kernel.dk, metze@samba.org,
        laijs@linux.alibaba.com, luto@kernel.org,
        dave.hansen@linux.intel.com, ebiederm@xmission.com,
        ohoono.kwon@samsung.com, kaleshsingh@google.com,
        yifeifz2@illinois.edu, jpoimboe@redhat.com,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        vgupta@kernel.org, linux@armlinux.org.uk, will@kernel.org,
        guoren@kernel.org, bcain@codeaurora.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        jonas@southpole.se, mpe@ellerman.id.au, paul.walmsley@sifive.com,
        hca@linux.ibm.com, ysato@users.sourceforge.jp, davem@davemloft.net,
        chris@zankel.net
Subject: [PATCH 3/7] proc: Use task_is_running() for wchan in /proc/$pid/stat
References: <20211008111527.438276127@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

The implementations of get_wchan() can be expensive. The only information
imparted here is whether or not a process is currently blocked in the
scheduler (and even this doesn't need to be exact). Avoid doing the
heavy lifting of stack walking and just report that information by using
task_is_running().

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 fs/proc/array.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -541,7 +541,7 @@ static int do_task_stat(struct seq_file
 	}
 
 	if (permitted && (!whole || num_threads < 2))
-		wchan = get_wchan(task);
+		wchan = !task_is_running(task);
 	if (!whole) {
 		min_flt = task->min_flt;
 		maj_flt = task->maj_flt;
@@ -606,10 +606,7 @@ static int do_task_stat(struct seq_file
 	 *
 	 * This works with older implementations of procps as well.
 	 */
-	if (wchan)
-		seq_puts(m, " 1");
-	else
-		seq_puts(m, " 0");
+	seq_put_decimal_ull(m, " ", wchan);
 
 	seq_put_decimal_ull(m, " ", 0);
 	seq_put_decimal_ull(m, " ", 0);


