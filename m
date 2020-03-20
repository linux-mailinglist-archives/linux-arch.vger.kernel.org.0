Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C35818CB89
	for <lists+linux-arch@lfdr.de>; Fri, 20 Mar 2020 11:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgCTK0N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Mar 2020 06:26:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34228 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgCTK0M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Mar 2020 06:26:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id z15so6754050wrl.1;
        Fri, 20 Mar 2020 03:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZyIwrVMgZez2hQpkOQoJh24f4SGL/SDIbhfYd4+eFuM=;
        b=UAydlY7oGeViCzVQp1U34KBuIn8k1k64LWR2xxMnLoFWlAcCUoDO0dCGNB+PWe81pt
         wYBi1XdwwBltZFcOuNQOi9gu6CLA0OYl7wkOhn5ONpGa0lnNsQwla2MUCFyrYEdCcW5v
         TKmy3GA0gRA8WYfSZLEJzGW6yTkJPUNqhAIR7G01m0bAb8S8t1Z8WAFo5pIoc/1XqNt6
         Qnadq98BWOW6DHykQpwvMjL9SbGotiEeeHV0bwfOSTfA544vCLRrarNjwmCyFNan3lWJ
         CjHHXRdUcQ4WVMvNTVY0k3JlIGWSvzsqYfemOnxdx5SkmwBAE2dp618nXgGFDqFqcF5l
         GU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZyIwrVMgZez2hQpkOQoJh24f4SGL/SDIbhfYd4+eFuM=;
        b=jSx0CD+S0yJ/IdQxx2mlPFS7TWwpb9WrII4lfTuXSOIcuD2VxyzRGg1y63OdeIizFO
         OvVIegDB+f1fxaBTaAoxE1gcCPyfOV9OHTkRBQ9I9gX8zz+64xaq2k5NWBq8L7JAQ6OR
         MdA2/TiopMpIs4TU8PostbyTMO0c6MWJWpCFZn9w1LZIo2QmKL9nWpHTtAgGIQZ7BC51
         mUi1znaZSaSTodYt8VU/TKzD4M2pHqCtdbngPkXhBFEd0wl6WsXmVu7tsqX9PgN94P3t
         iU63X+Mh2k+nIBjyEgqoheWW+/pZ2W+yT8fg/nk4pFhWiDDnlsD6dZd3+b7lFVPW7qzx
         Pa/A==
X-Gm-Message-State: ANhLgQ0FPWPzX0HYwxkvbV7lASfpu5AvSzpYVdFNdKp0J5adh4wp4Hau
        xFx5593WMLptRQkTugC5Olc=
X-Google-Smtp-Source: ADFU+vtQ2Cvkij5WfY49IP4qyU4ueCsNgP4yapkmAybB1/czoNW9zB2MtX6kNEh7d7f+XLtkCCZR6g==
X-Received: by 2002:adf:90ee:: with SMTP id i101mr9888897wri.417.1584699969782;
        Fri, 20 Mar 2020 03:26:09 -0700 (PDT)
Received: from andrea ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id l12sm7423234wrt.73.2020.03.20.03.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 03:26:09 -0700 (PDT)
Date:   Fri, 20 Mar 2020 11:26:03 +0100
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
Message-ID: <20200320102603.GA22784@andrea>
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

FYI, this could become a little more readable if we wrote it as follows:

int x = 1;
int *y = &x;
int z = 1;

The LKMM tools are happy either way, just a matter of style/preference;
and yes, MP+onceassign+derefonce isn't currently following mine...  ;-/


> +}
> +
> +P0(int *x, int *z, int **y)
> +{
> +	int r0;

This would need to be "int *r0;" in order to make klitmus7(+gcc) happy.


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

AFAICT, you don't need this "RELEASE"; e.g., compare this test with the
example in:

  https://www.kernel.org/doc/Documentation/RCU/Design/Requirements/Requirements.html#Grace-Period%20Guarantee

What am I missing?

Thanks,
  Andrea


> +	synchronize_rcu();
> +	WRITE_ONCE(*x, 0);
> +}
> +
> +exists (0:r0=x /\ 0:r1=0)
> -- 
> 2.25.1.696.g5e7596f4ac-goog
> 
