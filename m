Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42D4717C1AF
	for <lists+linux-arch@lfdr.de>; Fri,  6 Mar 2020 16:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgCFP0g (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Mar 2020 10:26:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:42412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbgCFP0g (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Mar 2020 10:26:36 -0500
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B58C2073B;
        Fri,  6 Mar 2020 15:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583508395;
        bh=LFduZrR2FMzRvYOKUqz/lBRfe1bOxAcCftgD5xvPBfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ybYruN+ZZ0Jnykl84atF4mXSe5iljcxrWE+iwALuX/yJ35ONLn/n8GGXR9lbC12l2
         xonT5x9qilyJrX8utYs181P/dX5jtd2+vLj0W72/8LZacVf4cGUwo9EVqtv3Y/CjlP
         XrkXzK62P5y99BsTzR5KvnqsIkvIIL75umGhhYVg=
Date:   Fri, 6 Mar 2020 16:26:33 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Alex Belits <abelits@marvell.com>
Cc:     "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prasun Kapoor <pkapoor@marvell.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-mm@vger.kernel.org" <linux-mm@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 03/12] task_isolation: userspace hard isolation from
 kernel
Message-ID: <20200306152632.GB8590@lenoir>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
 <36d84b8dd168a38e6a56549dedc15dd6ebf8c09e.camel@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36d84b8dd168a38e6a56549dedc15dd6ebf8c09e.camel@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 04, 2020 at 04:07:12PM +0000, Alex Belits wrote:
> +
> +/*
> + * Print message prefixed with the description of the current (or
> + * last) isolated task on a given CPU. Intended for isolation breaking
> + * messages that include target task for the user's convenience.
> + *
> + * Messages produced with this function may have obsolete task
> + * information if isolated tasks managed to exit, start and enter
> + * isolation multiple times, or multiple tasks tried to enter
> + * isolation on the same CPU at once. For those unusual cases it would
> + * contain a valid description of the cause for isolation breaking and
> + * target CPU number, just not the correct description of which task
> + * ended up losing isolation.
> + */
> +int task_isolation_message(int cpu, int level, bool supp, const char *fmt, ...)
> +{
> +	struct isol_task_desc *desc;
> +	struct task_struct *task;
> +	va_list args;
> +	char buf_prefix[TASK_COMM_LEN + 20 + 3 * 20];
> +	char buf[200];
> +	int curr_cpu, ind_counter, ind_counter_old, ind;
> +
> +	curr_cpu = get_cpu();
> +	desc = &per_cpu(isol_task_descs, cpu);
> +	ind_counter = atomic_read(&desc->curr_index);
> +
> +	if (curr_cpu == cpu) {
> +		/*
> +		 * Message is for the current CPU so current
> +		 * task_struct should be used instead of cached
> +		 * information.
> +		 *
> +		 * Like in other diagnostic messages, if issued from
> +		 * interrupt context, current will be the interrupted
> +		 * task. Unlike other diagnostic messages, this is
> +		 * always relevant because the message is about
> +		 * interrupting a task.
> +		 */
> +		ind = ind_counter & 1;
> +		if (supp && desc->warned[ind]) {
> +			/*
> +			 * If supp is true, skip the message if the
> +			 * same task was mentioned in the message
> +			 * originated on remote CPU, and it did not
> +			 * re-enter isolated state since then (warned
> +			 * is true). Only local messages following
> +			 * remote messages, likely about the same
> +			 * isolation breaking event, are skipped to
> +			 * avoid duplication. If remote cause is
> +			 * immediately followed by a local one before
> +			 * isolation is broken, local cause is skipped
> +			 * from messages.
> +			 */
> +			put_cpu();
> +			return 0;
> +		}
> +		task = current;
> +		snprintf(buf_prefix, sizeof(buf_prefix),
> +			 "isolation %s/%d/%d (cpu %d)",
> +			 task->comm, task->tgid, task->pid, cpu);
> +		put_cpu();
> +	} else {
> +		/*
> +		 * Message is for remote CPU, use cached information.
> +		 */
> +		put_cpu();
> +		/*
> +		 * Make sure, index remained unchanged while data was
> +		 * copied. If it changed, data that was copied may be
> +		 * inconsistent because two updates in a sequence could
> +		 * overwrite the data while it was being read.
> +		 */
> +		do {
> +			/* Make sure we are reading up to date values */
> +			smp_mb();
> +			ind = ind_counter & 1;
> +			snprintf(buf_prefix, sizeof(buf_prefix),
> +				 "isolation %s/%d/%d (cpu %d)",
> +				 desc->comm[ind], desc->tgid[ind],
> +				 desc->pid[ind], cpu);
> +			desc->warned[ind] = true;
> +			ind_counter_old = ind_counter;
> +			/* Record the warned flag, then re-read descriptor */
> +			smp_mb();
> +			ind_counter = atomic_read(&desc->curr_index);
> +			/*
> +			 * If the counter changed, something was updated, so
> +			 * repeat everything to get the current data
> +			 */
> +		} while (ind_counter != ind_counter_old);
> +	}

So the need to log the fact we are sending an event to a remote CPU that *may be*
running an isolated task makes things very complicated and even racy.

How bad would it be to only log those interruptions once they land on the target?

Thanks.
