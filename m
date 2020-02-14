Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B49CB15D1F1
	for <lists+linux-arch@lfdr.de>; Fri, 14 Feb 2020 07:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbgBNGPp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Feb 2020 01:15:45 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34964 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbgBNGPp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Feb 2020 01:15:45 -0500
Received: by mail-qt1-f194.google.com with SMTP id n17so6287390qtv.2;
        Thu, 13 Feb 2020 22:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nLjjzSLzxsXY/bhp5Ddo3ITUR5xYRovctgYF6KTTt+0=;
        b=X2WT82wf1q5dEOBm/7ntpGUysP+yzIsUyom3LG1nAUgnglY8CCi8Ke+HbeLhmtYDaZ
         62bIaOaqmuhbiKNtULefZtTly4bLqwY4bc5tqQKmp862+RTRyJEmtc6/athdlJEil3YN
         S6TQivrqX2Ax/RzfUmS0vJfHRBwAZK0yQT0BwKwxd3gxSggZIYqiInw42ES3yWv4yYRW
         OCWUCzIPYpL4Ve1XGrJbI9ya6oVFUBLBfiij1mnnwDPGIvOGtK/vDVrlGQn35KOsmZdT
         7N7AsGC80bCndY5TtxRWfv2BMLLN1JqMvDkohRuhXmnTYHA3Q7XI8X8fA5OpF3w2nzU1
         i4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nLjjzSLzxsXY/bhp5Ddo3ITUR5xYRovctgYF6KTTt+0=;
        b=X+zrv/WbT8WYZ+EGfe3u6E01wq3K7O3CND9Up29zAUkU9BkHCvfEN+PHarAgVyZ0BF
         I5DmXQDjwwXH4UH3UYxn/+/RXAGXO3MoCiKJ4f/Fb05aJl0Z0JzFeej/sWaqX1OT2gIn
         LWvVfTGpRZNIIN9uzXNAuSZH2MI/06oCJQGIcky/3FjaS/l/8YDsmMDhWCNl9DRcEvhl
         RQzVa8XMHKovwnRq19jjRlSfV192+oSMqY6PUCY1ZoRwuYYof+6lxcONdINrYLH6yJuh
         cvEnyJwRILW6vjOL+MEzoYk4mGUo1Ld07WG0FJOE0qR8fFHeLKJ+2kq0zuWKDLL7Fb3f
         55Hg==
X-Gm-Message-State: APjAAAVQzOSxSc6jwCtigAXGrgBxSg5TRUeeUg7t84/9Y1/SXRvhMnii
        AHpUML3RVoEAA9nRC6JPg1s=
X-Google-Smtp-Source: APXvYqzID5BQFG1MxJUvETM/gntgvWO9e3HrAsmAWFiIEzjnfhe6vBt4l8Ri0GzbkgrqDP2tGAeUlQ==
X-Received: by 2002:ac8:3aa6:: with SMTP id x35mr1380813qte.38.1581660943655;
        Thu, 13 Feb 2020 22:15:43 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id l184sm2621149qkc.107.2020.02.13.22.15.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2020 22:15:43 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id D2CB521D51;
        Fri, 14 Feb 2020 01:15:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 14 Feb 2020 01:15:40 -0500
X-ME-Sender: <xms:CztGXh6UOvwVU8gbXDizyF1FDJ9A5ojOY6Lbb3Sf9-W9ScVE4veslw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrieelgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucfkphephedvrd
    duheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    eiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhl
    rdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:CztGXqxTr3F8P5yWriJiiqHdQ_pys3sIxNyAGMGftxQW1b6bos3frA>
    <xmx:CztGXj8Pd0AustypqxUW_r_v-P9_Po38ilQC7aH3eGgXst-rQ-qsvQ>
    <xmx:CztGXuEB621bNhdSsBGHKmu7JYjGzinHRo95-eT2L8rCkEpexgri2w>
    <xmx:DDtGXkitsDp2O-oFrp1lukU09QDCS14x_9j7bJBiAxGFS6Ecl8Adflhx_0k>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id D30623280069;
        Fri, 14 Feb 2020 01:15:38 -0500 (EST)
Date:   Fri, 14 Feb 2020 14:15:37 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [RFC 3/3] tools/memory-model: Add litmus test for RMW +
 smp_mb__after_atomic()
Message-ID: <20200214061537.GA20408@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200214040132.91934-1-boqun.feng@gmail.com>
 <20200214040132.91934-4-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214040132.91934-4-boqun.feng@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 14, 2020 at 12:01:32PM +0800, Boqun Feng wrote:
> We already use a litmus test in atomic_t.txt to describe atomic RMW +
> smp_mb__after_atomic() is "strong acquire" (both the read and the write
> part is ordered). So make it a litmus test in memory-model litmus-tests
> directory, so that people can access the litmus easily.
> 
> Additionally, change the processor numbers "P1, P2" to "P0, P1" in
> atomic_t.txt for the consistency with the processor numbers in the
> litmus test, which herd can handle.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  Documentation/atomic_t.txt                    |  6 ++--
>  ...+mb__after_atomic-is-strong-acquire.litmus | 29 +++++++++++++++++++
>  tools/memory-model/litmus-tests/README        |  5 ++++
>  3 files changed, 37 insertions(+), 3 deletions(-)
>  create mode 100644 tools/memory-model/litmus-tests/Atomic-RMW+mb__after_atomic-is-strong-acquire.litmus
> 
> diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
> index ceb85ada378e..e3ad4e4cd9ed 100644
> --- a/Documentation/atomic_t.txt
> +++ b/Documentation/atomic_t.txt
> @@ -238,14 +238,14 @@ strictly stronger than ACQUIRE. As illustrated:
>    {
>    }
>  
> -  P1(int *x, atomic_t *y)
> +  P0(int *x, atomic_t *y)
>    {
>      r0 = READ_ONCE(*x);
>      smp_rmb();
>      r1 = atomic_read(y);
>    }
>  
> -  P2(int *x, atomic_t *y)
> +  P1(int *x, atomic_t *y)
>    {
>      atomic_inc(y);
>      smp_mb__after_atomic();
> @@ -260,7 +260,7 @@ This should not happen; but a hypothetical atomic_inc_acquire() --
>  because it would not order the W part of the RMW against the following
>  WRITE_ONCE.  Thus:
>  
> -  P1			P2
> +  P0			P1
>  
>  			t = LL.acq *y (0)
>  			t++;
> diff --git a/tools/memory-model/litmus-tests/Atomic-RMW+mb__after_atomic-is-strong-acquire.litmus b/tools/memory-model/litmus-tests/Atomic-RMW+mb__after_atomic-is-strong-acquire.litmus
> new file mode 100644
> index 000000000000..e7216cf9d92a
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/Atomic-RMW+mb__after_atomic-is-strong-acquire.litmus
> @@ -0,0 +1,29 @@
> +C Atomic-RMW+mb__after_atomic-is-strong-acquire
> +
> +(*
> + * Result: Never
> + *
> + * Test of an atomic RMW followed by a smp_mb__after_atomic() is
> + * "strong-acquire": both the read and write part of the RMW is ordered before
> + * the subsequential memory accesses.
> + *)
> +
> +{
> +}
> +
> +P0(int *x, atomic_t *y)
> +{
> +	r0 = READ_ONCE(*x);
> +	smp_rmb();
> +	r1 = atomic_read(y);
> +}
> +
> +P1(int *x, atomic_t *y)
> +{
> +	atomic_inc(y);
> +	smp_mb__after_atomic();
> +	WRITE_ONCE(*x, 1);
> +}
> +
> +exists
> +(r0=1 /\ r1=0)

Hmm.. this should be "(0:r0=1 /\ 0:r1=0)", I will fix this in next
verison.

Regards,
Boqun

> diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
> index 81eeacebd160..774e10058c72 100644
> --- a/tools/memory-model/litmus-tests/README
> +++ b/tools/memory-model/litmus-tests/README
> @@ -2,6 +2,11 @@
>  LITMUS TESTS
>  ============
>  
> +Atomic-RMW+mb__after_atomic-is-strong-acquire
> +	Test of an atomic RMW followed by a smp_mb__after_atomic() is
> +	"strong-acquire": both the read and write part of the RMW is ordered
> +	before the subsequential memory accesses.
> +
>  Atomic-set-observable-to-RMW.litmus
>  	Test of the result of atomic_set() must be observable to atomic RMWs.
>  
> -- 
> 2.25.0
> 
