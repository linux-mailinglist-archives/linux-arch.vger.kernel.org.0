Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9151443AC8C
	for <lists+linux-arch@lfdr.de>; Tue, 26 Oct 2021 09:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbhJZHD7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Oct 2021 03:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbhJZHD6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Oct 2021 03:03:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C789AC061745;
        Tue, 26 Oct 2021 00:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mDE+nIrUEwp9gdh7csFA4RkAg6IIsjAzd6M9miIHAew=; b=jg8Yj9hGaOgTZKFKecfny9To3N
        VjgU+bk075mGrzLbby/E/7eVQjjzC7zUWiC8BTQcjnh3pcXwhVWR+cFpcvqNVOB0gp2MQD+OW6ryg
        Bkc9ZwdWba8opu2f5VOMDhJB8PvoUIbTAHLuAGMca9YdrzJseFymGJnMP2jmzf/fZzGFwaIRj+em4
        wrH1q6AQNTz7O+tqUIYy/1idVnKnQ8F8CU5CMQxOKhp36yDhyPhvpbKuPoFcCd3PzjKC2IX90M41i
        w+oPAKmNEV8PVITFgv4bBpDqh7tcROWUyIeOfr2CIcZ+iTlrRuQNCAr4bnSheFspHTLcGKlXynw/a
        0zMbtgAA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfGSF-00CJJG-1l; Tue, 26 Oct 2021 07:01:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E38AB3001BF;
        Tue, 26 Oct 2021 09:01:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BE0FF2D80369F; Tue, 26 Oct 2021 09:01:00 +0200 (CEST)
Date:   Tue, 26 Oct 2021 09:01:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org,
        "Paul E . McKenney " <paulmck@kernel.org>,
        Dan Lustig <dlustig@nvidia.com>, Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Anvin <hpa@zytor.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Stephane Eranian <eranian@google.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mpe@ellerman.id.au,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC v2 3/3] tools/memory-model: litmus: Add two tests for
 unlock(A)+lock(B) ordering
Message-ID: <YXenrNeS+IaSDwvU@hirez.programming.kicks-ass.net>
References: <20211025145416.698183-1-boqun.feng@gmail.com>
 <20211025145416.698183-4-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025145416.698183-4-boqun.feng@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 25, 2021 at 10:54:16PM +0800, Boqun Feng wrote:
> diff --git a/tools/memory-model/litmus-tests/LB+unlocklockonceonce+poacquireonce.litmus b/tools/memory-model/litmus-tests/LB+unlocklockonceonce+poacquireonce.litmus
> new file mode 100644
> index 000000000000..955b9c7cdc7f
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/LB+unlocklockonceonce+poacquireonce.litmus
> @@ -0,0 +1,33 @@
> +C LB+unlocklockonceonce+poacquireonce
> +
> +(*
> + * Result: Never
> + *
> + * If two locked critical sections execute on the same CPU, all accesses
> + * in the first must execute before any accesses in the second, even if
> + * the critical sections are protected by different locks.

One small nit; the above "all accesses" reads as if:

	spin_lock(s);
	WRITE_ONCE(*x, 1);
	spin_unlock(s);
	spin_lock(t);
	r1 = READ_ONCE(*y);
	spin_unlock(t);

would also work, except of course that's the one reorder allowed by TSO.

> + *)
> +
> +{}
> +
> +P0(spinlock_t *s, spinlock_t *t, int *x, int *y)
> +{
> +	int r1;
> +
> +	spin_lock(s);
> +	r1 = READ_ONCE(*x);
> +	spin_unlock(s);
> +	spin_lock(t);
> +	WRITE_ONCE(*y, 1);
> +	spin_unlock(t);
> +}
> +
> +P1(int *x, int *y)
> +{
> +	int r2;
> +
> +	r2 = smp_load_acquire(y);
> +	WRITE_ONCE(*x, 1);
> +}
> +
> +exists (0:r1=1 /\ 1:r2=1)
