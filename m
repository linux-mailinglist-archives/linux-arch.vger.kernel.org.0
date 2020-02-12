Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF19F15A534
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2020 10:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgBLJnr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Feb 2020 04:43:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46606 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbgBLJno (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 04:43:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=bTlY8PGhCYzSVjFt/mma9u9atqHaB4/S7WhFaJNCETg=; b=Gvbxpj63SlusCN6Dzw/w+tioui
        mXMS+wYeKZCzpl6vh67GQ+rpdH7w6KiKvpCvDWPH/uS8XV9qVxx6xB4pRowPtkTdAF5ABCLWeeWBE
        ANsB7ynEG0r0w3FjgH6cou7mHRzj/dB1eE8/8EKUgla/zDd4xApPGTM7Dar0azLbDzvInm5U6uIAs
        fMnUAp2t9yJvEY1xs+KUd2AGBGcsmA9ahlje2GJ/oIvUACaynNgc1UzsjXe2Y2bNmnM2OakRsrMYN
        SiPg9Th3zeyU6hwLa9xvjEMuy0aTrjpz6SyWo6JDhoHfSnBmfYWRsKNRwwHbZtlnWwVNQdezKUWl9
        MhFfW5pg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1oYG-0006zW-9T; Wed, 12 Feb 2020 09:43:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5C6D03077DC;
        Wed, 12 Feb 2020 10:41:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 46FA720148932; Wed, 12 Feb 2020 10:43:21 +0100 (CET)
Message-Id: <20200212093210.468391728@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 12 Feb 2020 10:32:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: [PATCH 0/8] tracing vs rcu vs nmi
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

These here patches are the result of Mathieu and Steve trying to get commit
865e63b04e9b2 ("tracing: Add back in rcu_irq_enter/exit_irqson() for rcuidle
tracepoints") reverted again.

One of the things discovered is that tracing MUST NOT happen before nmi_enter()
or after nmi_exit(). I've only fixed x86, but quickly gone through other
architectures and there is definitely more stuff to be fixed (simply grep for
nmi_enter in your arch).



