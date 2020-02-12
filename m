Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB4415B3F4
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2020 23:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgBLWiV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Feb 2020 17:38:21 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35204 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbgBLWiU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 17:38:20 -0500
Received: by mail-qk1-f195.google.com with SMTP id v2so3811186qkj.2
        for <linux-arch@vger.kernel.org>; Wed, 12 Feb 2020 14:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wZAgduaulew5xs0mDPyKP8Dt1/4k4uuQj0GhkxD82NU=;
        b=OHUFj0mVm/niHRieSJJsyde147mXao42JpBXjmrBE46NbFcv7REFDzwKwhMNXUmwA2
         HyssDB+2lB3+spXMTqRVVEBo/DM797tmAkZ2Gpx4+jIiI8qdqOg0B/x0+NNuUsoGAs8k
         cXv2lr6mdmY9kQuWXmlQiIC1g+SPJO8Vms1us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wZAgduaulew5xs0mDPyKP8Dt1/4k4uuQj0GhkxD82NU=;
        b=UJsnXtde/pYrTvNIfutZVl6LH3APceakKBacHpP0B36nsqT4a6zodbbbqjBP5aM3NC
         DlCax7QU+DJfQDpWTpmAGLVdTjiUjfBGNfpkunr565vxA7vOFlKQK9g2zPifIeBxg1p3
         fuqLU4r470n1qPMP3UfjVLGKa1PT+WcOzCr22F9EBtiCe8UIWfYnzM07ORSrYqKym9L4
         XXpx86+c2aU6lYVykmnX2r19W+VmJOvNo7C7miyhnCyyvPQhZOfMVfZ98b7QwGQsj9ZV
         BJcQJlHx4LxNKfT/dxtYefmOfD7Ny7lsuSGspgQQQXZE1PHfty9o/KYwPYfBfBzjZ1Er
         nfQA==
X-Gm-Message-State: APjAAAWi0IfCd/5F+L2m//JP/kcGmDOR+n7DHUcaf62Qrs9l6qY+w3Sa
        6lmdwmTJN20AUnSZKGzqCvjP5g==
X-Google-Smtp-Source: APXvYqwrwDORsqMvXp6lWqe5/mlr67wfSg2ox7qEAyWpjxvOye3bYqC3ZzKxpguP4UYez14gI6De0w==
X-Received: by 2002:ae9:f442:: with SMTP id z2mr13280596qkl.130.1581547099598;
        Wed, 12 Feb 2020 14:38:19 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id b7sm184312qka.67.2020.02.12.14.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 14:38:19 -0800 (PST)
Date:   Wed, 12 Feb 2020 17:38:18 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com
Subject: Re: [PATCH v2 2/9] rcu: Mark rcu_dynticks_curr_cpu_in_eqs() inline
Message-ID: <20200212223818.GA115917@google.com>
References: <20200212210139.382424693@infradead.org>
 <20200212210749.915180520@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212210749.915180520@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 12, 2020 at 10:01:41PM +0100, Peter Zijlstra wrote:
> Since rcu_is_watching() is notrace (and needs to be, as it can be
> called from the tracers), make sure everything it in turn calls is
> notrace too.
> 
> To that effect, mark rcu_dynticks_curr_cpu_in_eqs() inline, which
> implies notrace, as the function is tiny.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/rcu/tree.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -294,7 +294,7 @@ static void rcu_dynticks_eqs_online(void
>   *
>   * No ordering, as we are sampling CPU-local information.
>   */
> -static bool rcu_dynticks_curr_cpu_in_eqs(void)
> +static inline bool rcu_dynticks_curr_cpu_in_eqs(void)

I think there are ways to turn off function inlining, such as gcc's:
-fkeep-inline-functions

And just to be sure weird compilers (clang *cough*) don't screw this up,
could we make it static inline notrace?

Build tested it on the tip tree on top of your patch:

---8<-----------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f3cb824fe5bbf..078d56951c8e7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -294,7 +294,7 @@ static void rcu_dynticks_eqs_online(void)
  *
  * No ordering, as we are sampling CPU-local information.
  */
-static inline bool rcu_dynticks_curr_cpu_in_eqs(void)
+static inline notrace bool rcu_dynticks_curr_cpu_in_eqs(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
