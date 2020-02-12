Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA45215ABC2
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2020 16:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgBLPNr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Feb 2020 10:13:47 -0500
Received: from mail.efficios.com ([167.114.26.124]:35668 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgBLPNq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 10:13:46 -0500
X-Greylist: delayed 353 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Feb 2020 10:13:46 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id EA699256630;
        Wed, 12 Feb 2020 10:07:52 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jbDkN1MOyTZm; Wed, 12 Feb 2020 10:07:52 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 864FB2565C9;
        Wed, 12 Feb 2020 10:07:52 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 864FB2565C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1581520072;
        bh=XqwTStxhGy9NhMPxxcBJbdJMRdCChNgVrogMKyJSuj0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=NoVYdBzGwtawBLyB8iYWvKl2MvHCNV+C1HDF/muRlw889COo8WmLwUyJ+Po5GMi0D
         DL4HaGukbHTAw4W5V3CCEdxBzQbULaeuMw1PjP6IVFbGYWrwqVo27I3PZEcKOow/ex
         KTgMYHKBNjxO14/aF6LQuNMoFYC66vT7gUa5DZZcJfDvPVmt3a/Js+Z8KSHZKs4E54
         56LwMTpnWguc6JsLTZE5llzvmVUHDsAnjgZZtMs5gvLCsrOksew/vHyFqHwZm7QI+P
         ZE/h7j/wAGJ2zIMzVhQuSxsEH3qihcMbmFCfE+5m7lKcBO18SE62qnks6RRvUpWJie
         Q1XFV/ezOfNBQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tX3YLiAZHgPy; Wed, 12 Feb 2020 10:07:52 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 6428E25653F;
        Wed, 12 Feb 2020 10:07:52 -0500 (EST)
Date:   Wed, 12 Feb 2020 10:07:51 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Message-ID: <736090577.117.1581520071732.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200212092655.4ba6cd79@gandalf.local.home>
References: <20200212093210.468391728@infradead.org> <20200212094107.951346701@infradead.org> <20200212092655.4ba6cd79@gandalf.local.home>
Subject: Re: [PATCH 6/8] perf,tracing: Prepare the perf-trace interface for
 RCU changes
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3899 (ZimbraWebClient - FF72 (Linux)/8.8.15_GA_3895)
Thread-Topic: perf,tracing: Prepare the perf-trace interface for RCU changes
Thread-Index: VvottGhSyh8E2rHXp+3mD6dLT1bn1A==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Feb 12, 2020, at 9:26 AM, rostedt rostedt@goodmis.org wrote:

> On Wed, 12 Feb 2020 10:32:16 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
>> The tracepoint interface will stop providing regular RCU context; make
>> sure we do it ourselves, since perf makes use of regular RCU protected
>> data.
>> 
> 
> Suggested-by: Steven Rostedt (VMware) <rosted@goodmis.org>

and

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks :)

Mathieu

> 
>  ;-)
> 
> -- Steve
> 
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> ---
>>  kernel/events/core.c |    5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -8950,6 +8950,7 @@ void perf_tp_event(u16 event_type, u64 c
>>  {
>>  	struct perf_sample_data data;
>>  	struct perf_event *event;
>> +	unsigned long rcu_flags;
>>  
>>  	struct perf_raw_record raw = {
>>  		.frag = {
>> @@ -8961,6 +8962,8 @@ void perf_tp_event(u16 event_type, u64 c
>>  	perf_sample_data_init(&data, 0, 0);
>>  	data.raw = &raw;
>>  
>> +	rcu_flags = trace_rcu_enter();
>> +
>>  	perf_trace_buf_update(record, event_type);
>>  
>>  	hlist_for_each_entry_rcu(event, head, hlist_entry) {
>> @@ -8996,6 +8999,8 @@ void perf_tp_event(u16 event_type, u64 c
>>  	}
>>  
>>  	perf_swevent_put_recursion_context(rctx);
>> +
>> +	trace_rcu_exit(rcu_flags);
>>  }
>>  EXPORT_SYMBOL_GPL(perf_tp_event);
>>  

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
