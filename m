Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02103A3E02
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jun 2021 10:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhFKIco (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Jun 2021 04:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbhFKIco (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Jun 2021 04:32:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F06C061574;
        Fri, 11 Jun 2021 01:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Jg9GjCOAJZeFR6C5IJzM4EeQXj0lnsG2Ld/sAmQtTM8=; b=g+bexOiWVidKTC90tnCq5elN0M
        YKGQHzZ8Rz+MO53MOViIs5dDRQaMOuXu7KIOrZCsnfcj+YKFJgP6l5z2GfNeEtlIPdioXwBpkFF7O
        FYOL8hDn2ifIp6Elc3D1WmL+YZKHXt+tBR2YQ2OdFOm6mscFFEJ1SlIufzEs/E24SzeRnjyHWICVQ
        NtThK8Zqe1wvqILg1crQkJRxghWu+lbIP3jP/8oRL+y57e58wdT72B3nzDspz9WBM/X+p2SDEe9FD
        /a06DyRiYTr1cUWa40NQlDIsSqvPqIl75Dkd68QUNd3WqhJE/zllo+t8RGQl813R+KgtI+KdqeEUP
        teo5x2nA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lrcXt-005p83-Qy; Fri, 11 Jun 2021 08:29:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0612830022B;
        Fri, 11 Jun 2021 10:29:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E111320709437; Fri, 11 Jun 2021 10:29:42 +0200 (CEST)
Message-ID: <20210611082838.160855222@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 11 Jun 2021 10:28:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH v2 1/7] sched: Unbreak wakeups
References: <20210611082810.970791107@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Remove broken task->state references and let wake_up_process() DTRT.

The anti-pattern in these patches breaks the ordering of ->state vs
COND as described in the comment near set_current_state() and can lead
to missed wakeups:

	(OoO load, observes RUNNING)<-.
	for (;;) {                    |
	  t->state = UNINTERRUPTIBLE; |
	  smp_mb();          ,----->  | (observes !COND)
                             |        /
	  if (COND) ---------'       |	COND = 1;
		break;		     `- if (t->state != RUNNING)
					  wake_up_process(t); // not done
	  schedule(); // forever waiting
	}
	t->state = TASK_RUNNING;

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Will Deacon <will@kernel.org>
---
 drivers/net/ethernet/qualcomm/qca_spi.c |    6 ++----
 drivers/usb/gadget/udc/max3420_udc.c    |   15 +++++----------
 drivers/usb/host/max3421-hcd.c          |    3 +--
 kernel/softirq.c                        |    2 +-
 4 files changed, 9 insertions(+), 17 deletions(-)

--- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -653,8 +653,7 @@ qcaspi_intr_handler(int irq, void *data)
 	struct qcaspi *qca = data;
 
 	qca->intr_req++;
-	if (qca->spi_thread &&
-	    qca->spi_thread->state != TASK_RUNNING)
+	if (qca->spi_thread)
 		wake_up_process(qca->spi_thread);
 
 	return IRQ_HANDLED;
@@ -777,8 +776,7 @@ qcaspi_netdev_xmit(struct sk_buff *skb,
 
 	netif_trans_update(dev);
 
-	if (qca->spi_thread &&
-	    qca->spi_thread->state != TASK_RUNNING)
+	if (qca->spi_thread)
 		wake_up_process(qca->spi_thread);
 
 	return NETDEV_TX_OK;
--- a/drivers/usb/gadget/udc/max3420_udc.c
+++ b/drivers/usb/gadget/udc/max3420_udc.c
@@ -509,8 +509,7 @@ static irqreturn_t max3420_vbus_handler(
 			     ? USB_STATE_POWERED : USB_STATE_NOTATTACHED);
 	spin_unlock_irqrestore(&udc->lock, flags);
 
-	if (udc->thread_task &&
-	    udc->thread_task->state != TASK_RUNNING)
+	if (udc->thread_task)
 		wake_up_process(udc->thread_task);
 
 	return IRQ_HANDLED;
@@ -529,8 +528,7 @@ static irqreturn_t max3420_irq_handler(i
 	}
 	spin_unlock_irqrestore(&udc->lock, flags);
 
-	if (udc->thread_task &&
-	    udc->thread_task->state != TASK_RUNNING)
+	if (udc->thread_task)
 		wake_up_process(udc->thread_task);
 
 	return IRQ_HANDLED;
@@ -1093,8 +1091,7 @@ static int max3420_wakeup(struct usb_gad
 
 	spin_unlock_irqrestore(&udc->lock, flags);
 
-	if (udc->thread_task &&
-	    udc->thread_task->state != TASK_RUNNING)
+	if (udc->thread_task)
 		wake_up_process(udc->thread_task);
 	return ret;
 }
@@ -1117,8 +1114,7 @@ static int max3420_udc_start(struct usb_
 	udc->todo |= UDC_START;
 	spin_unlock_irqrestore(&udc->lock, flags);
 
-	if (udc->thread_task &&
-	    udc->thread_task->state != TASK_RUNNING)
+	if (udc->thread_task)
 		wake_up_process(udc->thread_task);
 
 	return 0;
@@ -1137,8 +1133,7 @@ static int max3420_udc_stop(struct usb_g
 	udc->todo |= UDC_START;
 	spin_unlock_irqrestore(&udc->lock, flags);
 
-	if (udc->thread_task &&
-	    udc->thread_task->state != TASK_RUNNING)
+	if (udc->thread_task)
 		wake_up_process(udc->thread_task);
 
 	return 0;
--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -1169,8 +1169,7 @@ max3421_irq_handler(int irq, void *dev_i
 	struct spi_device *spi = to_spi_device(hcd->self.controller);
 	struct max3421_hcd *max3421_hcd = hcd_to_max3421(hcd);
 
-	if (max3421_hcd->spi_thread &&
-	    max3421_hcd->spi_thread->state != TASK_RUNNING)
+	if (max3421_hcd->spi_thread)
 		wake_up_process(max3421_hcd->spi_thread);
 	if (!test_and_set_bit(ENABLE_IRQ, &max3421_hcd->todo))
 		disable_irq_nosync(spi->irq);
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -76,7 +76,7 @@ static void wakeup_softirqd(void)
 	/* Interrupts are disabled: no need to stop preemption */
 	struct task_struct *tsk = __this_cpu_read(ksoftirqd);
 
-	if (tsk && tsk->state != TASK_RUNNING)
+	if (tsk)
 		wake_up_process(tsk);
 }
 


