Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73FF81E6FAE
	for <lists+linux-arch@lfdr.de>; Fri, 29 May 2020 00:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437403AbgE1Wyf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 May 2020 18:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437395AbgE1Wy3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 May 2020 18:54:29 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807CCC08C5C9
        for <linux-arch@vger.kernel.org>; Thu, 28 May 2020 15:54:29 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 205so589767qkg.3
        for <linux-arch@vger.kernel.org>; Thu, 28 May 2020 15:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+zdBNPOW7cOm3saj18R6cxycqoLSohMFP/QJpLGzg1E=;
        b=HBd2vw5otsK1Ic+ZhoaAv5DjPeJWRNR1ElMMQA/Hm7cNcLoSsn1A5cpbisfjoJoDSs
         GIsps7HmWKCV1WFFSh+XteZ2SENcTyGF0G42D0TQeyFND14KbnUgxz4L0h6+s55JGLzy
         Dz3nZ49LsNvuZPuqF9abr/oFvAFXNyZZjOXEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+zdBNPOW7cOm3saj18R6cxycqoLSohMFP/QJpLGzg1E=;
        b=ENsHD/2aRRbCnmZTvrr/f7qSP5KcEhP/cPOUgo4s+KHJUkHKuN3fqLGaAHwYBfGUpu
         ZdqYrZAvXDMDHHFD6UpDcUCy8LmdzUyaoe7SsoZ0UtDN2WMN5o5pse6Z4BJeWxcgIiNm
         6DLJrfZacYdNAB6ZycQGOAFKH0bjePDR/xBYNuiY9qJAhuDQ98YKrJJXi076LUcWFFTX
         effYS9l1iTK20g1HC6dk6HfFu1rTZ3UtXQ7VbTytdPvvOcfZbIgX1H25uOtNBo8OSp1m
         3QeRsbvIYn4g/SLZa4IhcAJIZlHDHThdW5snNyvX7LJd3MOQfMQr21hozbTJLzYHno9z
         q1fQ==
X-Gm-Message-State: AOAM530QdLXrAHZy1XikVBy9XDzor7RnG4j0U6avy6I2cB4/gfItzsrd
        S1zQtN6+Ds+fAEqsYBSnJ0zaYQ==
X-Google-Smtp-Source: ABdhPJzhTMeBJ00IWmmVqjA7IjEXo6/Clp1WbKxbGJLKmJaqeGr0WCvwCQbPbJ5Sk971Zv/URXRHYg==
X-Received: by 2002:a37:ef08:: with SMTP id j8mr5304678qkk.442.1590706468511;
        Thu, 28 May 2020 15:54:28 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id m10sm6350677qtg.94.2020.05.28.15.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 15:54:28 -0700 (PDT)
Date:   Thu, 28 May 2020 18:54:27 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, paulmck@kernel.org,
        stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, andrii.nakryiko@gmail.com,
        kernel-team@fb.com
Subject: Re: [PATCH linux-rcu] docs/litmus-tests: add BPF ringbuf MPSC litmus
 tests
Message-ID: <20200528225427.GA225299@google.com>
References: <20200528062408.547149-1-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528062408.547149-1-andriin@fb.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello Andrii,
This is quite exciting. Some comments below:

On Wed, May 27, 2020 at 11:24:08PM -0700, Andrii Nakryiko wrote:
[...]
> diff --git a/Documentation/litmus-tests/bpf-rb/bpf-rb+1p1c+bounded.litmus b/Documentation/litmus-tests/bpf-rb/bpf-rb+1p1c+bounded.litmus
> new file mode 100644
> index 000000000000..558f054fb0b4
> --- /dev/null
> +++ b/Documentation/litmus-tests/bpf-rb/bpf-rb+1p1c+bounded.litmus
> @@ -0,0 +1,91 @@
> +C bpf-rb+1p1c+bounded
> +
> +(*
> + * Result: Always
> + *
> + * This litmus test validates BPF ring buffer implementation under the
> + * following assumptions:
> + * - 1 producer;
> + * - 1 consumer;
> + * - ring buffer has capacity for only 1 record.
> + *
> + * Expectations:
> + * - 1 record pushed into ring buffer;
> + * - 0 or 1 element is consumed.
> + * - no failures.
> + *)
> +
> +{
> +	atomic_t dropped;
> +}
> +
> +P0(int *lenFail, int *len1, int *cx, int *px)
> +{
> +	int *rLenPtr;
> +	int rLen;
> +	int rPx;
> +	int rCx;
> +	int rFail;
> +
> +	rFail = 0;
> +
> +	rCx = smp_load_acquire(cx);
> +	rPx = smp_load_acquire(px);

Is it possible for you to put some more comments around which ACQUIRE is
paired with which RELEASE? And, in general more comments around the reason
for a certain memory barrier and what pairs with what. In the kernel sources,
the barriers needs a comment anyway.

> +	if (rCx < rPx) {
> +		if (rCx == 0) {
> +			rLenPtr = len1;
> +		} else {
> +			rLenPtr = lenFail;
> +			rFail = 1;
> +		}
> +
> +		rLen = smp_load_acquire(rLenPtr);
> +		if (rLen == 0) {
> +			rFail = 1;
> +		} else if (rLen == 1) {
> +			rCx = rCx + 1;
> +			smp_store_release(cx, rCx);
> +		}
> +	}
> +}
> +
> +P1(int *lenFail, int *len1, spinlock_t *rb_lock, int *px, int *cx, atomic_t *dropped)
> +{
> +	int rPx;
> +	int rCx;
> +	int rFail;
> +	int *rLenPtr;
> +
> +	rFail = 0;
> +
> +	rCx = smp_load_acquire(cx);
> +	spin_lock(rb_lock);
> +
> +	rPx = *px;
> +	if (rPx - rCx >= 1) {
> +		atomic_inc(dropped);

Why does 'dropped' need to be atomic if you are always incrementing under a
lock?

> +		spin_unlock(rb_lock);
> +	} else {
> +		if (rPx == 0) {
> +			rLenPtr = len1;
> +		} else {
> +			rLenPtr = lenFail;
> +			rFail = 1;
> +		}
> +
> +		*rLenPtr = -1;

Clarify please the need to set the length intermittently to -1. Thanks.

> +		smp_store_release(px, rPx + 1);
> +
> +		spin_unlock(rb_lock);
> +
> +		smp_store_release(rLenPtr, 1);
> +	}
> +}
> +
> +exists (
> +	0:rFail=0 /\ 1:rFail=0
> +	/\
> +	(
> +		(dropped=0 /\ px=1 /\ len1=1 /\ (cx=0 \/ cx=1))
> +	)
> +)
> diff --git a/Documentation/litmus-tests/bpf-rb/bpf-rb+1p1c+unbound.litmus b/Documentation/litmus-tests/bpf-rb/bpf-rb+1p1c+unbound.litmus
> new file mode 100644
> index 000000000000..7ab5d0e6e49f
> --- /dev/null
> +++ b/Documentation/litmus-tests/bpf-rb/bpf-rb+1p1c+unbound.litmus

I wish there was a way to pass args to litmus tests, then perhaps it would
have been possible to condense some of these tests. :-)

> diff --git a/Documentation/litmus-tests/bpf-rb/bpf-rb+2p1c+bounded.litmus b/Documentation/litmus-tests/bpf-rb/bpf-rb+2p1c+bounded.litmus
> new file mode 100644
> index 000000000000..83f80328c92b
> --- /dev/null
> +++ b/Documentation/litmus-tests/bpf-rb/bpf-rb+2p1c+bounded.litmus
[...]
> +P0(int *lenFail, int *len1, int *cx, int *px)
> +{
> +	int *rLenPtr;
> +	int rLen;
> +	int rPx;
> +	int rCx;
> +	int rFail;
> +
> +	rFail = 0;
> +
> +	rCx = smp_load_acquire(cx);
> +	rPx = smp_load_acquire(px);
> +	if (rCx < rPx) {
> +		if (rCx == 0) {
> +			rLenPtr = len1;
> +		} else if (rCx == 1) {
> +			rLenPtr = len1;
> +		} else {
> +			rLenPtr = lenFail;
> +			rFail = 1;
> +		}
> +
> +		rLen = smp_load_acquire(rLenPtr);
> +		if (rLen == 0) {
> +			rFail = 1;
> +		} else if (rLen == 1) {
> +			rCx = rCx + 1;
> +			smp_store_release(cx, rCx);
> +		}
> +	}
> +
> +	rPx = smp_load_acquire(px);
> +	if (rCx < rPx) {
> +		if (rCx == 0) {
> +			rLenPtr = len1;
> +		} else if (rCx == 1) {
> +			rLenPtr = len1;
> +		} else {
> +			rLenPtr = lenFail;
> +			rFail = 1;
> +		}
> +
> +		rLen = smp_load_acquire(rLenPtr);
> +		if (rLen == 0) {
> +			rFail = 1;
> +		} else if (rLen == 1) {
> +			rCx = rCx + 1;
> +			smp_store_release(cx, rCx);
> +		}
> +	}
> +}
> +
> +P1(int *lenFail, int *len1, spinlock_t *rb_lock, int *px, int *cx, atomic_t *dropped)
> +{
> +	int rPx;
> +	int rCx;
> +	int rFail;
> +	int *rLenPtr;
> +
> +	rFail = 0;
> +	rLenPtr = lenFail;
> +
> +	rCx = smp_load_acquire(cx);
> +	spin_lock(rb_lock);
> +
> +	rPx = *px;
> +	if (rPx - rCx >= 1) {
> +		atomic_inc(dropped);
> +		spin_unlock(rb_lock);
> +	} else {
> +		if (rPx == 0) {
> +			rLenPtr = len1;
> +		} else if (rPx == 1) {
> +			rLenPtr = len1;
> +		} else {
> +			rLenPtr = lenFail;
> +			rFail = 1;
> +		}
> +
> +		*rLenPtr = -1;
> +		smp_store_release(px, rPx + 1);
> +
> +		spin_unlock(rb_lock);
> +
> +		smp_store_release(rLenPtr, 1);

I ran a test replacing the last 2 statements above with the following and it
still works:

                spin_unlock(rb_lock);
                WRITE_ONCE(*rLenPtr, 1);

Wouldn't you expect the test to catch an issue? The spin_unlock is already a
RELEASE barrier.

Suggestion: It is hard to review the patch because it is huge, it would be
good to split this up into 4 patches for each of the tests. But upto you :)

thanks,

 - Joel

[...]

