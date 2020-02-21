Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 425EF167F42
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 14:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgBUNvq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 08:51:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56318 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbgBUNu1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 08:50:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=hSu90YkExU+GY6s1yDHokNBrPYH7JUpisO2iRBcfO2g=; b=hfjtFN05ZGGp3NTWtVJmN3X9kp
        WsGd2Ddf0d7WOyLAqzvp4VDDKtZ1wjxlGgU1wdKWgDzfPdPS/AuskXmVGE/2RusTjN1nusCNHbQEA
        AFl1qLIH1Gr/mnFdzNkx+MUsxYnoBSDLHvcGK6xDpfjLWGi5Glf0evq8XtLa5+66SJ5LPNW54RJzb
        4+VIub9NaoZ10i0xvxIXuupaAXvjkcjZW3UeVIM937kOZ2O9Qwwmv6zSlH+7eXFYyYPYcsAgzlTCD
        ecGvnzwwDvnXyvKtmbJwNRwrU3EYGoQWyixDhcB4dMr3rqQTj/LSUCIfYCmSK8JPu6MCQ0bCOOnyY
        0usq4+Bg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j58gw-00013M-U8; Fri, 21 Feb 2020 13:50:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 88FBC30782A;
        Fri, 21 Feb 2020 14:48:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2BD7729D740AC; Fri, 21 Feb 2020 14:50:01 +0100 (CET)
Message-Id: <20200221134216.573806438@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Feb 2020 14:34:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: [PATCH v4 22/27] compiler: Simple READ/WRITE_ONCE() implementations
References: <20200221133416.777099322@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Because I need WRITE_ONCE_NOCHECK() and in anticipation of Will's
READ_ONCE rewrite, provide __{READ,WRITE}_ONCE_SCALAR().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/compiler.h |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -289,6 +289,14 @@ unsigned long read_word_at_a_time(const
 	__u.__val;					\
 })
 
+#define __READ_ONCE_SCALAR(x)			\
+	(*(const volatile typeof(x) *)&(x))
+
+#define __WRITE_ONCE_SCALAR(x, val)		\
+do {						\
+	*(volatile typeof(x) *)&(x) = val;	\
+} while (0)
+
 #endif /* __KERNEL__ */
 
 /*


