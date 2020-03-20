Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 899A118CBE9
	for <lists+linux-arch@lfdr.de>; Fri, 20 Mar 2020 11:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgCTKoP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Mar 2020 06:44:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41737 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgCTKoP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Mar 2020 06:44:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id h9so6790180wrc.8;
        Fri, 20 Mar 2020 03:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=060szZC6QmLV3+Eb2WDyVKIvNPeE2q+SdnXFuvRQ94k=;
        b=eP/aF0r2NMTeZVcyIAF1ieyf5XL3zv5xK1LtYbpeGW7UUmhbvwZxTaV1q5PVHkynaB
         L7YPQ6RNvpNTZRwWxzBujDz6KH8w4yH9yRZfdiPI/Lu+KvTTcDRBjvMhRD6cHcwe4KIX
         RAMHzn26FCg80znGaaXGPEVkenrznNYZKg2d8e3TPFXiTxgoUfIaYM67I2n7nOGdRRUk
         j1dtHrq8UM2OMu/WkV2i2pLTxS4ZpwB+/rHALwIxeDVjtwanmSeUxonTTLUKwsjXVoHX
         Rn29x2WAGlYVzxHbDug77O1mtoaOBc01WDinu9aJlc+G45M3jgmwww90FM399kxiZnsi
         M98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=060szZC6QmLV3+Eb2WDyVKIvNPeE2q+SdnXFuvRQ94k=;
        b=sHBY/IJKbSYdaeKkdRmPQLCbE4eCb+aO8qKsqFi02OvvS9v1U+eRcJUTJGgVigz8yX
         fIPZm/uuHlgr2ft2AVD0ciwj65CMNL4p/T8dhMkWvVfz9+tKO9ocC4DEJlXjUZOtasHr
         Vjy2A5dkic+vaEJNWcvOwyf1LftZImYC3S2GsxZlRyaE2Q6pnZF3QO9UWUl7yi03fSQ6
         TNbsrY8TqXkbwRB9yqI+Q+UhOIQFBi3CIxm9YzRW6qAx8bE9h3AL07814d8D8szyrZ8F
         FtCce6uE3C0lpM+G2u4LqfXIjB5DdrkPAws1boduI1uY9w5Bp5Dnp+Krh0M4zs6PK8YL
         Ojew==
X-Gm-Message-State: ANhLgQ2besUdUMoclyL1o3LSKQ2G9svTSk0K5AAcdL+UvrzMYXvd/3dt
        kASS23xF9Yw4xGB0KxeiOTo=
X-Google-Smtp-Source: ADFU+vtSR6pBettOEt78xoX+0ncFyJkGIK39TvuGH9VcsISBWj2xWqVBzb4nH8EwWoe7i9oFNwuZiA==
X-Received: by 2002:adf:ec82:: with SMTP id z2mr10707771wrn.302.1584701051808;
        Fri, 20 Mar 2020 03:44:11 -0700 (PDT)
Received: from andrea ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id n2sm8074696wro.25.2020.03.20.03.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 03:44:11 -0700 (PDT)
Date:   Fri, 20 Mar 2020 11:44:04 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/3] LKMM: Add litmus test for RCU GP guarantee where
 updater frees object
Message-ID: <20200320104404.GA24635@andrea>
References: <20200320065552.253696-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320065552.253696-1-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 20, 2020 at 02:55:50AM -0400, Joel Fernandes (Google) wrote:
> This adds an example for the important RCU grace period guarantee, which
> shows an RCU reader can never span a grace period.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  .../litmus-tests/RCU+sync+free.litmus         | 40 +++++++++++++++++++

I forgot to mention: this should probably come with an update of the
list of tests reported in tools/memory-model/litmus-tests/README and
similarly for patches #2 and #3; #2, #3 looked otherwise fine to me.

Thanks,
  Andrea


>  1 file changed, 40 insertions(+)
>  create mode 100644 tools/memory-model/litmus-tests/RCU+sync+free.litmus
> 
> diff --git a/tools/memory-model/litmus-tests/RCU+sync+free.litmus b/tools/memory-model/litmus-tests/RCU+sync+free.litmus
> new file mode 100644
> index 0000000000000..c4682502dd296
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/RCU+sync+free.litmus
> @@ -0,0 +1,40 @@
> +C RCU+sync+free
> +
> +(*
> + * Result: Never
> + *
> + * This litmus test demonstrates that an RCU reader can never see a write after
> + * the grace period, if it saw writes that happen before the grace period. This
> + * is a typical pattern of RCU usage, where the write before the grace period
> + * assigns a pointer, and the writes after destroy the object that the pointer
> + * points to.
> + *
> + * This guarantee also implies, an RCU reader can never span a grace period and
> + * is an important RCU grace period memory ordering guarantee.
> + *)
> +
> +{
> +x = 1;
> +y = x;
> +z = 1;
> +}
> +
> +P0(int *x, int *z, int **y)
> +{
> +	int r0;
> +	int r1;
> +
> +	rcu_read_lock();
> +	r0 = rcu_dereference(*y);
> +	r1 = READ_ONCE(*r0);
> +	rcu_read_unlock();
> +}
> +
> +P1(int *x, int *z, int **y)
> +{
> +	rcu_assign_pointer(*y, z);
> +	synchronize_rcu();
> +	WRITE_ONCE(*x, 0);
> +}
> +
> +exists (0:r0=x /\ 0:r1=0)
> -- 
> 2.25.1.696.g5e7596f4ac-goog
> 
