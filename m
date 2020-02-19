Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3B2164818
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 16:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgBSPOh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 10:14:37 -0500
Received: from merlin.infradead.org ([205.233.59.134]:52038 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgBSPOh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 10:14:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=hSu90YkExU+GY6s1yDHokNBrPYH7JUpisO2iRBcfO2g=; b=B8a2YB5UlaGTGrMX9nL3hUqgPt
        ybLvEUZB9cLng1hieOmtgDWElQBOcwHpVQQWoHg20vCXc6zrB8cqMCkAH52NNuJb2V4L15CibwOC0
        eGTeL1ZkcBB2mw0iXc25nGLXHhkva63HiIqZDAt3c0QWHs4tZIQ3k8cI6KAUE0WaRBd3A1BbxCYBu
        wOhlUPSMKdmv/KSIeRVclbGtr1Bh1ZrFQhUNTK6uLfGZVTYyr3WtQ41Js/HbfanZFz30gb8tgwvjn
        BWEQn1dc084m0YO6oVY+REEySQS33xQEFL6RfBQsL5BgIKFO5FdogHYEmuwt/BGGJhQxD9I4xSpiF
        HbKadD+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4R39-0007fN-RV; Wed, 19 Feb 2020 15:14:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 19ECB30785A;
        Wed, 19 Feb 2020 16:12:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BE01A2B4D7B8A; Wed, 19 Feb 2020 16:14:03 +0100 (CET)
Message-Id: <20200219150745.474563308@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 19 Feb 2020 15:47:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: [PATCH v3 19/22] compiler: Simple READ/WRITE_ONCE() implementations
References: <20200219144724.800607165@infradead.org>
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


