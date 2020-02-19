Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51CF2164AB7
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 17:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgBSQjf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 11:39:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:60850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgBSQjf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 11:39:35 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D851724654;
        Wed, 19 Feb 2020 16:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582130374;
        bh=/CX8XIpaKr86fJuFzYlFh8LeDEIxxg1IRlMhB0yl2rk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ax5CMFITNCdHNpbnOkvKU+C1twFP5c8MOR0MfOSxGS8MQRWa5+JMZoPwaJjaRZ4MD
         cM+oT9cVnmTFXacu0OLqV1rOi9IDr3VNFlnty02cvaPZ8ar8ZNsxWuGFohErKCaUSC
         Ezofaa6c6li6Vpq/aVFyEoasoR8P5fe5FXyIQWoA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B382935209B0; Wed, 19 Feb 2020 08:39:34 -0800 (PST)
Date:   Wed, 19 Feb 2020 08:39:34 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v3 07/22] rcu: Mark rcu_dynticks_curr_cpu_in_eqs() inline
Message-ID: <20200219163934.GA2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200219144724.800607165@infradead.org>
 <20200219150744.775936989@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219150744.775936989@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 03:47:31PM +0100, Peter Zijlstra wrote:
> Since rcu_is_watching() is notrace (and needs to be, as it can be
> called from the tracers), make sure everything it in turn calls is
> notrace too.
> 
> To that effect, mark rcu_dynticks_curr_cpu_in_eqs() inline, which
> implies notrace, as the function is tiny.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

There was some controversy over inline vs. notrace, leading me to
ask whether we should use both inline and notrace here.  ;-)

Assuming that the usual tracing suspects are OK with it:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

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
>  {
>  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  
> 
> 
