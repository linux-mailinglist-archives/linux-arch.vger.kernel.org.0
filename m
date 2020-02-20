Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB56165C35
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2020 11:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgBTKyt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Feb 2020 05:54:49 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34572 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbgBTKyt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Feb 2020 05:54:49 -0500
Received: from zn.tnic (p200300EC2F0ADE00D586D1EBA124F86F.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:de00:d586:d1eb:a124:f86f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E5F731EC0CF0;
        Thu, 20 Feb 2020 11:54:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582196087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=L/A+VxeJqYqepTcE9OSVJYnnTX9Xg+x3AIGZ8rU8RCU=;
        b=O8QNiiVr0siUUJE4FhN7MdsrvI2Kt4UYs3ZkcTa7mCoiH50WVFtDpFdBymYta1DkTQYj8d
        OJEDxM04BuHw4wzEItMKXk/6ZqhdDKvLnksICB6DcLOo1vyqGt/htsc8+63bPgJZnDf/Ni
        UJxL6Nc+K5J4C2WhZ+bEBMPJGJZAeCE=
Date:   Thu, 20 Feb 2020 11:54:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v3 03/22] x86: Replace ist_enter() with nmi_enter()
Message-ID: <20200220105439.GA507@zn.tnic>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.547288232@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200219150744.547288232@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 03:47:27PM +0100, Peter Zijlstra wrote:
> @@ -1220,7 +1220,7 @@ static void mce_kill_me_maybe(struct cal
>   * MCE broadcast. However some CPUs might be broken beyond repair,
>   * so be always careful when synchronizing with others.
>   */
> -void do_machine_check(struct pt_regs *regs, long error_code)
> +notrace void do_machine_check(struct pt_regs *regs, long error_code)

Is there a convention where the notrace marker should come in the
function signature? I see all possible combinations while grepping...

>  {
>  	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
>  	DECLARE_BITMAP(toclear, MAX_NR_BANKS);
> @@ -1254,10 +1254,10 @@ void do_machine_check(struct pt_regs *re
>  	 */
>  	int lmce = 1;
>  
> -	if (__mc_check_crashing_cpu(cpu))
> -		return;
> +	nmi_enter();
>  
> -	ist_enter(regs);
> +	if (__mc_check_crashing_cpu(cpu))
> +		goto out;
>  
>  	this_cpu_inc(mce_exception_count);
>  

Should that __mc_check_crashing_cpu() happen before nmi_enter? The
function is doing only a bunch of checks and clearing MSRs for bystander
CPUs...

> @@ -1346,7 +1346,7 @@ void do_machine_check(struct pt_regs *re
>  	sync_core();
>  
>  	if (worst != MCE_AR_SEVERITY && !kill_it)
> -		goto out_ist;
> +		goto out;
>  
>  	/* Fault was in user mode and we need to take some action */
>  	if ((m.cs & 3) == 3) {
> @@ -1362,10 +1362,11 @@ void do_machine_check(struct pt_regs *re
>  			mce_panic("Failed kernel mode recovery", &m, msg);
>  	}
>  
> -out_ist:
> -	ist_exit(regs);
> +out:
> +	nmi_exit();
>  }
>  EXPORT_SYMBOL_GPL(do_machine_check);
> +NOKPROBE_SYMBOL(do_machine_check);

Yah, that's a good idea regardless.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
