Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727C54577C3
	for <lists+linux-arch@lfdr.de>; Fri, 19 Nov 2021 21:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbhKSUep (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Nov 2021 15:34:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43003 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235324AbhKSUeo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Nov 2021 15:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637353902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P2sZkZbNWImGK5CgW7dFwBi8zGA25zK0xwbZ1WxQTIw=;
        b=a5BVsP7ax71OMAd5sXb8IGikIbDCvilB09m5KWI8ntkxRE3zmRnygJRfCm5SDvj0FRoGbi
        W/jHP0cQsqyMtmHKG76g0yrGeS4Ip7J1+CVXa5IsxEHwKP7FJC0wUIsdwHQU3Y6hAdqBqx
        jbg8VhMWfHmzOTO+4Phc3qM2nVI2HVU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-51-0ojlN1cENyuUzd85nYI-YA-1; Fri, 19 Nov 2021 15:31:40 -0500
X-MC-Unique: 0ojlN1cENyuUzd85nYI-YA-1
Received: by mail-qk1-f198.google.com with SMTP id q5-20020a05620a0d8500b0045edb4779dbso8848373qkl.2
        for <linux-arch@vger.kernel.org>; Fri, 19 Nov 2021 12:31:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P2sZkZbNWImGK5CgW7dFwBi8zGA25zK0xwbZ1WxQTIw=;
        b=MNLXkXuYgjXpu4YZxScFE0rMkRnuWonrq9hAViIsj0Q3utFj+saYuywG6RV/tdls5R
         46GLRKfUOiSzZCqwJMo1X/1Gghpo8ACDCdUAwFDNIAM6cEGDq/K0lsM8QZmhJM+TmKHr
         IPOkfKsDOf6bQvmjCP65klfNnst1GQPNJus/AAhTQHyzfHfqTQSJe8lJeaAQYTimsTKd
         3qgzL7Siqe7y29xrA6S0gtm3/JTMfVW5vWY55RNL+quZDJnATTWti1C1F3FFrBPYN9aH
         zLN0BspDm3S7XDwoxD7UjakdTYtyzoopz89CWZPOebUoMr1tA1afWrPtuDFarWd2veAS
         cGRA==
X-Gm-Message-State: AOAM5331tnHzaa1ri8HxLQ9ZvQgmTCk/ieIhdMMb7ipRR7nWPMWMiNuC
        HHX0d5nzNnCSn0Mpxq7VtjAUK0r/iBhAUF5TpJhgI59Dd+u1udGqHhtZkX5yv7lEu0qjsIOScmq
        J7OjEA7J5nSIYLDzLBn1mKg==
X-Received: by 2002:ac8:7f52:: with SMTP id g18mr9425058qtk.190.1637353900217;
        Fri, 19 Nov 2021 12:31:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxkAXs81p/9fcPnMbXqzRfyHNHU69K8pzzXpDVQagmkQJ2qJyjzDlmUAcOqpRVDqAvK3rgV/w==
X-Received: by 2002:ac8:7f52:: with SMTP id g18mr9425020qtk.190.1637353899973;
        Fri, 19 Nov 2021 12:31:39 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id z13sm374393qkj.1.2021.11.19.12.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 12:31:39 -0800 (PST)
Date:   Fri, 19 Nov 2021 12:31:35 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
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
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v2 23/23] objtool, kcsan: Remove memory barrier
 instrumentation from noinstr
Message-ID: <20211119203135.clplwzh3hyo5xddg@treble>
References: <20211118081027.3175699-1-elver@google.com>
 <20211118081027.3175699-24-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211118081027.3175699-24-elver@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 18, 2021 at 09:10:27AM +0100, Marco Elver wrote:
> @@ -1071,12 +1071,7 @@ static void annotate_call_site(struct objtool_file *file,
>  		return;
>  	}
>  
> -	/*
> -	 * Many compilers cannot disable KCOV with a function attribute
> -	 * so they need a little help, NOP out any KCOV calls from noinstr
> -	 * text.
> -	 */
> -	if (insn->sec->noinstr && sym->kcov) {
> +	if (insn->sec->noinstr && sym->removable_instr) {
>  		if (reloc) {
>  			reloc->type = R_NONE;
>  			elf_write_reloc(file->elf, reloc);

I'd love to have a clearer name than 'removable_instr', though I'm
having trouble coming up with something.

'profiling_func'?

Profiling isn't really accurate but maybe it gets the point across.  I'm
definitely open to other suggestions.

Also, the above code isn't very self-evident so there still needs to be
a comment there, like:

	/*
	 * Many compilers cannot disable KCOV or sanitizer calls with a
	 * function attribute so they need a little help, NOP out any
	 * such calls from noinstr text.
	 */

> @@ -1991,6 +1986,32 @@ static int read_intra_function_calls(struct objtool_file *file)
>  	return 0;
>  }
>  
> +static bool is_removable_instr(const char *name)


> +{
> +	/*
> +	 * Many compilers cannot disable KCOV with a function attribute so they
> +	 * need a little help, NOP out any KCOV calls from noinstr text.
> +	 */
> +	if (!strncmp(name, "__sanitizer_cov_", 16))
> +		return true;

A comment is good here, but the NOP-ing bit seems out of place.

-- 
Josh

