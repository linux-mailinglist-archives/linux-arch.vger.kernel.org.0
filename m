Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0452553D9
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 06:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgH1EoH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 00:44:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgH1EoH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Aug 2020 00:44:07 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD67A2073A;
        Fri, 28 Aug 2020 04:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598589846;
        bh=DoBqWPSj15yxexAypVDKWQzqgpP6VEcY2bLYc76sI/4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FXziRmDmZisdz7C5DvALNB7D7RuMquP2RHGB8p+j/neX3HpEuXvIorjykCcbdP7NR
         PqzC05bOGp6MaOqwwfUwZAug8BibrZSCT5VftlncEiooak+zZj+/8Xed0xpDXHnZSD
         1hUFCwzLlb59HWQn9D4B0U6XDD3OXCIiVwpZqfuQ=
Date:   Fri, 28 Aug 2020 13:44:01 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, rostedt@goodmis.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, cameron@moodycamel.com,
        oleg@redhat.com, will@kernel.org, paulmck@kernel.org
Subject: Re: [RFC][PATCH 3/7] kprobes: Remove kretprobe hash
Message-Id: <20200828134401.51e936ab4aa983b52535d2b0@kernel.org>
In-Reply-To: <20200827161754.359432340@infradead.org>
References: <20200827161237.889877377@infradead.org>
        <20200827161754.359432340@infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 27 Aug 2020 18:12:40 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> @@ -1313,25 +1261,28 @@ void kprobe_busy_end(void)
>  void kprobe_flush_task(struct task_struct *tk)
>  {
>  	struct kretprobe_instance *ri;
> -	struct hlist_head *head, empty_rp;
> +	struct hlist_head empty_rp;
> +	struct llist_node *node;
>  	struct hlist_node *tmp;

We don't need this tmp anymore.

> @@ -1935,71 +1932,45 @@ unsigned long __kretprobe_trampoline_han
>  					unsigned long trampoline_address,
>  					void *frame_pointer)
>  {
> +	kprobe_opcode_t *correct_ret_addr = NULL;
>  	struct kretprobe_instance *ri = NULL;
> -	struct hlist_head *head, empty_rp;
> +	unsigned long orig_ret_address = 0;
> +	struct llist_node *first, *node;
> +	struct hlist_head empty_rp;
>  	struct hlist_node *tmp;

Here too.

I'm trying to port this patch on my v4 series. I'll add my RFC patch of
kretprobe_holder too.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
