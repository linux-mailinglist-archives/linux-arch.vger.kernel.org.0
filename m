Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6791468FF9
	for <lists+linux-arch@lfdr.de>; Mon,  6 Dec 2021 06:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbhLFFIY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Dec 2021 00:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhLFFIX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Dec 2021 00:08:23 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40574C0613F8;
        Sun,  5 Dec 2021 21:04:55 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id t8so9024365ilu.8;
        Sun, 05 Dec 2021 21:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tDhe7b+IhPRxxignxx1nDXp2K4ORmwOTZ8ivGctx3KA=;
        b=gDBAKWrWkjW69MD6bJRbbC4IAUISs6K3clEQYe9+qhYEM+3/ei2QA1p+eyWPl//PkZ
         MZs1sJjHKYkDAoANTwNTADXYKpdEjYIoi0R38SWvQThsyk9W7siLDhWHxaTtIEwvznxX
         KsHy0EM0d6MDcPv/1xG1+2t90T3HhVUCpqNxDVZnsHkUi1Y6eq+fBTeGiPCxYug4x2bg
         SVkrAd1qAIS0Ux/lvZ2x7r2K+56gFzhT1fwfVTxWtoVnmExYkIVzYe5aVUeiB2rCVfQ2
         5yZPU9xKsAoMWF//IutAF8y9BC+AT6LIYHiIOXQZDA7ya17atidzw1OsV6Xm7smQnWZ3
         PWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tDhe7b+IhPRxxignxx1nDXp2K4ORmwOTZ8ivGctx3KA=;
        b=bEk+VLgf+EWMSFSKiEl7DKR24zzVrji8VWMyXyY0HJ82OsG+4OXZvmfkT5YBqduZP6
         tWEwn04zdX99oIKtSIpgqcAEgPubNbe19M4cIT64/MsMoZ+MVjHthAGETWcA4hEOJvwN
         nLNbEA+Akgm7YODFK0MoqluAtNRJMgzetkKU9uC/wN5KbU4SrlO9q79m4SIRBA6qqOGb
         y6dB2HC5gqUUur9hwsWbHCHWeX/+9JGsZthGlKPxeEEju46K3eBalJ6CUNSl3X/uUrpY
         Tk8baGvuBTUIDnSLEKGZ+/OCKYXx6qqZmjEUkUvP66GFkuhcLt7vOkwARxdlCQH+weC2
         YlOA==
X-Gm-Message-State: AOAM531TIzom+lnkhuMZiZT4CsQbSIkgcLMKNiLJAkyxpIpvKWNlK0hy
        liXQN1JjGnkzBRLMiCEWWy4=
X-Google-Smtp-Source: ABdhPJwaVNNy8KXHPX0diE+9BqZRmxfh/F+tlyo2HmuHIUQC0d5++KCQ+YdgK0rTeMwJsEVyI2Orbg==
X-Received: by 2002:a05:6e02:1aa2:: with SMTP id l2mr31908443ilv.7.1638767094542;
        Sun, 05 Dec 2021 21:04:54 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id c22sm5776377ioz.15.2021.12.05.21.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 21:04:53 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0841227C0054;
        Mon,  6 Dec 2021 00:04:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 06 Dec 2021 00:04:52 -0500
X-ME-Sender: <xms:85mtYXWw3oDZ0NxfzGmSkDWVDwODn54pQ3vkyqYQpDkpb-hF89cz7A>
    <xme:85mtYflbLFvAzyeoTuOKXu2W8_C3GV0Z_k5wT2Koe6rGc-MOKqU5wJb3_OEdT8uip
    _9vNCV9I3JoCTN_6Q>
X-ME-Received: <xmr:85mtYTY3cVvAZ0O5xOh8r4B7zeUpWVBWDze0NubZ-LuL89xCy_zGvkEaSiE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrjedvgdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:85mtYSVyeqXNTvxyxUKsjXeJUcfFiIAmWmDHaJss1eMI7ycPzfiJXw>
    <xmx:85mtYRmcDwTjVFRx64ILk_o3jPn2_It-kF0eEAZKrowIK0kxCG3gDA>
    <xmx:85mtYfeI1tYn0Hy_XlBfSO2fu3lpX1xkTId5vyZ3rVDIn8TYewPeMw>
    <xmx:85mtYQfmvxb8sPHyPVqy-diUzzcHKKuEPRHuW3DggOsRZcB3DDkbF_4ncNk>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Dec 2021 00:04:50 -0500 (EST)
Date:   Mon, 6 Dec 2021 13:03:33 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH v3 08/25] kcsan: Show location access was reordered to
Message-ID: <Ya2Zpf8qpgDYiGqM@boqun-archlinux>
References: <20211130114433.2580590-1-elver@google.com>
 <20211130114433.2580590-9-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130114433.2580590-9-elver@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On Tue, Nov 30, 2021 at 12:44:16PM +0100, Marco Elver wrote:
> Also show the location the access was reordered to. An example report:
> 
> | ==================================================================
> | BUG: KCSAN: data-race in test_kernel_wrong_memorder / test_kernel_wrong_memorder
> |
> | read-write to 0xffffffffc01e61a8 of 8 bytes by task 2311 on cpu 5:
> |  test_kernel_wrong_memorder+0x57/0x90
> |  access_thread+0x99/0xe0
> |  kthread+0x2ba/0x2f0
> |  ret_from_fork+0x22/0x30
> |
> | read-write (reordered) to 0xffffffffc01e61a8 of 8 bytes by task 2310 on cpu 7:
> |  test_kernel_wrong_memorder+0x57/0x90
> |  access_thread+0x99/0xe0
> |  kthread+0x2ba/0x2f0
> |  ret_from_fork+0x22/0x30
> |   |
> |   +-> reordered to: test_kernel_wrong_memorder+0x80/0x90
> |

Should this be "reordered from" instead of "reordered to"? For example,
if the following case needs a smp_mb() between write to A and write to
B, I think currently it will report as follow:

	foo() {
		WRITE_ONCE(A, 1); // let's say A's address is 0xaaaa
		bar() {
			WRITE_ONCE(B, 1); // Assume B's address is 0xbbbb
					  // KCSAN find the problem here
		}
	}

	<report>
	| write (reordered) to 0xaaaa of ...:
	| bar+0x... // address of the write to B
	| foo+0x... // address of the callsite to bar()
	| ...
	|  |
	|  +-> reordered to: foo+0x... // address of the write to A

But since the access reported here is the write to A, so it's a
"reordered from" instead of "reordered to"?

Regards,
Boqun

> | Reported by Kernel Concurrency Sanitizer on:
> | CPU: 7 PID: 2310 Comm: access_thread Not tainted 5.14.0-rc1+ #18
> | Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
> | ==================================================================
> 
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  kernel/kcsan/report.c | 35 +++++++++++++++++++++++------------
>  1 file changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
> index 1b0e050bdf6a..67794404042a 100644
> --- a/kernel/kcsan/report.c
> +++ b/kernel/kcsan/report.c
> @@ -308,10 +308,12 @@ static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries
>  
>  /*
>   * Skips to the first entry that matches the function of @ip, and then replaces
> - * that entry with @ip, returning the entries to skip.
> + * that entry with @ip, returning the entries to skip with @replaced containing
> + * the replaced entry.
>   */
>  static int
> -replace_stack_entry(unsigned long stack_entries[], int num_entries, unsigned long ip)
> +replace_stack_entry(unsigned long stack_entries[], int num_entries, unsigned long ip,
> +		    unsigned long *replaced)
>  {
>  	unsigned long symbolsize, offset;
>  	unsigned long target_func;
> @@ -330,6 +332,7 @@ replace_stack_entry(unsigned long stack_entries[], int num_entries, unsigned lon
>  		func -= offset;
>  
>  		if (func == target_func) {
> +			*replaced = stack_entries[skip];
>  			stack_entries[skip] = ip;
>  			return skip;
>  		}
> @@ -342,9 +345,10 @@ replace_stack_entry(unsigned long stack_entries[], int num_entries, unsigned lon
>  }
>  
>  static int
> -sanitize_stack_entries(unsigned long stack_entries[], int num_entries, unsigned long ip)
> +sanitize_stack_entries(unsigned long stack_entries[], int num_entries, unsigned long ip,
> +		       unsigned long *replaced)
>  {
> -	return ip ? replace_stack_entry(stack_entries, num_entries, ip) :
> +	return ip ? replace_stack_entry(stack_entries, num_entries, ip, replaced) :
>  			  get_stack_skipnr(stack_entries, num_entries);
>  }
>  
> @@ -360,6 +364,14 @@ static int sym_strcmp(void *addr1, void *addr2)
>  	return strncmp(buf1, buf2, sizeof(buf1));
>  }
>  
> +static void
> +print_stack_trace(unsigned long stack_entries[], int num_entries, unsigned long reordered_to)
> +{
> +	stack_trace_print(stack_entries, num_entries, 0);
> +	if (reordered_to)
> +		pr_err("  |\n  +-> reordered to: %pS\n", (void *)reordered_to);
> +}
> +
>  static void print_verbose_info(struct task_struct *task)
>  {
>  	if (!task)
> @@ -378,10 +390,12 @@ static void print_report(enum kcsan_value_change value_change,
>  			 struct other_info *other_info,
>  			 u64 old, u64 new, u64 mask)
>  {
> +	unsigned long reordered_to = 0;
>  	unsigned long stack_entries[NUM_STACK_ENTRIES] = { 0 };
>  	int num_stack_entries = stack_trace_save(stack_entries, NUM_STACK_ENTRIES, 1);
> -	int skipnr = sanitize_stack_entries(stack_entries, num_stack_entries, ai->ip);
> +	int skipnr = sanitize_stack_entries(stack_entries, num_stack_entries, ai->ip, &reordered_to);
>  	unsigned long this_frame = stack_entries[skipnr];
> +	unsigned long other_reordered_to = 0;
>  	unsigned long other_frame = 0;
>  	int other_skipnr = 0; /* silence uninit warnings */
>  
> @@ -394,7 +408,7 @@ static void print_report(enum kcsan_value_change value_change,
>  	if (other_info) {
>  		other_skipnr = sanitize_stack_entries(other_info->stack_entries,
>  						      other_info->num_stack_entries,
> -						      other_info->ai.ip);
> +						      other_info->ai.ip, &other_reordered_to);
>  		other_frame = other_info->stack_entries[other_skipnr];
>  
>  		/* @value_change is only known for the other thread */
> @@ -434,10 +448,9 @@ static void print_report(enum kcsan_value_change value_change,
>  		       other_info->ai.cpu_id);
>  
>  		/* Print the other thread's stack trace. */
> -		stack_trace_print(other_info->stack_entries + other_skipnr,
> +		print_stack_trace(other_info->stack_entries + other_skipnr,
>  				  other_info->num_stack_entries - other_skipnr,
> -				  0);
> -
> +				  other_reordered_to);
>  		if (IS_ENABLED(CONFIG_KCSAN_VERBOSE))
>  			print_verbose_info(other_info->task);
>  
> @@ -451,9 +464,7 @@ static void print_report(enum kcsan_value_change value_change,
>  		       get_thread_desc(ai->task_pid), ai->cpu_id);
>  	}
>  	/* Print stack trace of this thread. */
> -	stack_trace_print(stack_entries + skipnr, num_stack_entries - skipnr,
> -			  0);
> -
> +	print_stack_trace(stack_entries + skipnr, num_stack_entries - skipnr, reordered_to);
>  	if (IS_ENABLED(CONFIG_KCSAN_VERBOSE))
>  		print_verbose_info(current);
>  
> -- 
> 2.34.0.rc2.393.gf8c9666880-goog
> 
