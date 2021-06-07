Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E09539EA65
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 01:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhFGXve (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 19:51:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230389AbhFGXvd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Jun 2021 19:51:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56A56610E7;
        Mon,  7 Jun 2021 23:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1623109775;
        bh=wxUVyz8qev8tVhu8PQWcp+37ij3S9w/4BeA7vonLCSk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=asVX63awTfqg/iMMlsQL0INhiGLCFajgpBC0a1YCIfWFg/m2ij2+9NeD5Q5ip2hTT
         TAAVAn85Gr+4WdPiHXwr6HZhgU3/9wd+ld+G27FnFkb+JtAFkzEnmbfbBfq53rBeKg
         MzmrWw6bOnh6JWFKPU8ptpSBevb3gFf+L8saSdT8=
Date:   Mon, 7 Jun 2021 16:49:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, Anton Blanchard <anton@ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v4 1/4] lazy tlb: introduce lazy mm refcount helper
 functions
Message-Id: <20210607164934.d453adcc42473e84beb25db3@linux-foundation.org>
In-Reply-To: <20210605014216.446867-2-npiggin@gmail.com>
References: <20210605014216.446867-1-npiggin@gmail.com>
        <20210605014216.446867-2-npiggin@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat,  5 Jun 2021 11:42:13 +1000 Nicholas Piggin <npiggin@gmail.com> wrote:

> Add explicit _lazy_tlb annotated functions for lazy mm refcounting.
> This makes lazy mm references more obvious, and allows explicit
> refcounting to be removed if it is not used.
> 
> ...
>
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -1314,14 +1314,14 @@ void kthread_use_mm(struct mm_struct *mm)
>  	WARN_ON_ONCE(!(tsk->flags & PF_KTHREAD));
>  	WARN_ON_ONCE(tsk->mm);
>  
> +	mmgrab(mm);
> +
>  	task_lock(tsk);
>  	/* Hold off tlb flush IPIs while switching mm's */
>  	local_irq_disable();
>  	active_mm = tsk->active_mm;
> -	if (active_mm != mm) {
> -		mmgrab(mm);
> +	if (active_mm != mm)
>  		tsk->active_mm = mm;
> -	}

Looks like a functional change.  What's happening here?


