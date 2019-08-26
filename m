Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D35E9D93F
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2019 00:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfHZWfO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Aug 2019 18:35:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:47046 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfHZWfN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Aug 2019 18:35:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id q139so12702763pfc.13;
        Mon, 26 Aug 2019 15:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZTtLxIEFBiFvvirLNk7rJCpHyKJsG3UuT12vwumOc6c=;
        b=V4Yj/mgKIET0UoJp2BRwZVUfM8V2AmczCU0x1SnvT/ZOx56IgJ9BD2GVGSi/vhq8VT
         fCApXRmB4ctSw9Qja4Kg0K+GcJl8Q6DdxLSq+q61/ftTv9i5CG6gwcSj3xiWeRzQ1qWl
         KifPe7A7QjANncPafKhoJI2VCx5usWEIbMg0ZGE/I7ZdFFUTesd1FXWT2Q07SZVnGF/Y
         1IDGhaTKkYwZyw0MpgLx9S1ru+lG8BGfGNGS/7INVWaXjpxI9Pp2t+OVu436nKa8238G
         oNqZKQK8uVFD/nAamPO86nU17D7TwmRoXDUF53i42+GF5eIES6p9m9cXmSCrdSiQLsco
         z2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZTtLxIEFBiFvvirLNk7rJCpHyKJsG3UuT12vwumOc6c=;
        b=nXa7cdpQs4fAp0JQDqNhFW1/q5a1TOcaz1dPML6uxVxHd1GNxBnbyYXxFltgXqLs8E
         LB5dVjllsKU5VN7t++oz4YZqsMfSoZICG4svurMf0rQ7XXlnb+DSaY5BzAcFGmnRRO/m
         NElHBqm5bd0c4VVkgPBLEaYzi0RZqSIGM6gKSzGeFcGXpma1QMTOkDa60sQRw+VltEgy
         ICHm9/yJ3e2J9/rph73YAq6ogsE417i6JDQw3f1YJEjULTxJVkza4gwUtPuc6zcB4st8
         oW6wHjWmtTrYUDOkUfxc76IMzI3yMy01PDQ8NWQw0J94TDdiuw5unKjG9AJ0pOjuKn2M
         NWWg==
X-Gm-Message-State: APjAAAVa9R3ukcXSwynRhgouykVnCBGMKrkMQ9xuJulfitjOQRzwv8c3
        13QHs/dUORMXGyBlbYYJbz0=
X-Google-Smtp-Source: APXvYqx9fB2zz3reQwDJm1c/UTcOst3U1UlmTMEEGuwoeB+hHpMqnGwoyiFnFyuGEv6PeBIfrwI1hg==
X-Received: by 2002:a65:62d7:: with SMTP id m23mr18488160pgv.358.1566858912811;
        Mon, 26 Aug 2019 15:35:12 -0700 (PDT)
Received: from mail.google.com ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id s5sm474687pjo.26.2019.08.26.15.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 15:35:12 -0700 (PDT)
Date:   Tue, 27 Aug 2019 06:35:02 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, Jessica Yu <jeyu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 05/11] ftrace: create memcache for hash entries
Message-ID: <20190826223501.ymj3g4ftrf5eqhzq@mail.google.com>
References: <20190825132330.5015-1-changbin.du@gmail.com>
 <20190825132330.5015-6-changbin.du@gmail.com>
 <20190826074437.GM2369@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826074437.GM2369@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 26, 2019 at 09:44:37AM +0200, Peter Zijlstra wrote:
> On Sun, Aug 25, 2019 at 09:23:24PM +0800, Changbin Du wrote:
> > When CONFIG_FTRACE_FUNC_PROTOTYPE is enabled, thousands of
> > ftrace_func_entry instances are created. So create a dedicated
> > memcache to enhance performance.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  kernel/trace/ftrace.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index a314f0768b2c..cfcb8dad93ea 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -94,6 +94,8 @@ struct ftrace_ops *function_trace_op __read_mostly = &ftrace_list_end;
> >  /* What to set function_trace_op to */
> >  static struct ftrace_ops *set_function_trace_op;
> >  
> > +struct kmem_cache *hash_entry_cache;
> > +
> >  static bool ftrace_pids_enabled(struct ftrace_ops *ops)
> >  {
> >  	struct trace_array *tr;
> > @@ -1169,7 +1171,7 @@ static int add_hash_entry(struct ftrace_hash *hash, unsigned long ip,
> >  {
> >  	struct ftrace_func_entry *entry;
> >  
> > -	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
> > +	entry = kmem_cache_alloc(hash_entry_cache, GFP_KERNEL);
> >  	if (!entry)
> >  		return -ENOMEM;
> >  
> > @@ -6153,6 +6155,15 @@ void __init ftrace_init(void)
> >  	if (ret)
> >  		goto failed;
> >  
> > +	hash_entry_cache = kmem_cache_create("ftrace-hash",
> > +					     sizeof(struct ftrace_func_entry),
> > +					     sizeof(struct ftrace_func_entry),
> > +					     0, NULL);
> > +	if (!hash_entry_cache) {
> > +		pr_err("failed to create ftrace hash entry cache\n");
> > +		goto failed;
> > +	}
> 
> Wait what; you already have then in the binary image, now you're
> allocating extra memory for each of them?
>
No, here we only allocate ftrace hash entries. The prototype data is not copied.
The entry->priv points to prototype data in binary.

> Did you look at what ORC does? Is the binary search really not fast
> enough?
For ftrace, binary search is not enough. Just like the hash tables
(ftrace_graph_notrace_hash, ftrace_graph_hash) we already have which is used to
filter traced functions.


-- 
Cheers,
Changbin Du
