Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF9025A42D
	for <lists+linux-arch@lfdr.de>; Wed,  2 Sep 2020 05:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgIBDyz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 23:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBDyy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 23:54:54 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06916C061244;
        Tue,  1 Sep 2020 20:54:53 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id x12so2672235qtp.1;
        Tue, 01 Sep 2020 20:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HlV9ceNvzksFcv30Uxn9Xc+kYIG9dGoe3UtoGctT3TA=;
        b=eJFqOwmxdWn3Z66quZvnVjSlHiKcxRXdI6P7DNculVGgVn78I3WKsJAwqz3rSOt146
         DgekxtnBn5VFdkKSbfcM4hrRS8I+2HflY+f6hnIxV801ZE//PfkblMCZ1uVaQLm9KwYr
         pUvLr/Eg8In5wP0bt+m4peNSydvKe64vARKNm6hXa7ODHe3JUmhmQHH0TMnDg5j2aw7M
         XvD2lBKlHdcibhc7rb/JYylPmxIhZyU6ZWc3qVsoZHp1HVCFf88QhuyJ1fz6bn6gKdeT
         m5w2KzNMOVqUUciYLjvD/1+1wDVv2vM+bTe1I3R8kK+NBwRpyjbh9BwuGFTR6Z8drOKH
         V/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HlV9ceNvzksFcv30Uxn9Xc+kYIG9dGoe3UtoGctT3TA=;
        b=pKukamAxbMhRuGBRYrrnjPN+7uG6wqg9clLTnEoaSOhCNW3hH18LTw31NJx/ZMSQTN
         YBJdcRk5yY8aOFsKUHDVBCAWtXw48uAqjEkxEA5nO+tSO/+xTqMmTZhtzO8Gbj8xqayT
         3Bt3CgWAE9d0ZNRbZ7AAZnVROpebPEg1rlKmWndGIP6qZtmdcTAhnMd9245uCoAXBEhE
         syghiRUvru+Vp7/eg8G2/UpJB0FdtbUcu4CCXjKAaqjm6XIRo6pgraf0bnQV7JUmE4c3
         qN4F+GPv9NpGq8K727Ae7CpXYQywp5h4sPXbXS8U6iDQmmjLZ02KJilyGoMV7kaPaVNp
         qXlg==
X-Gm-Message-State: AOAM532BHa4EY7QAqqPYL6GIKv8xv41QF8/ITDVu5qj/4FYSFee1H3mJ
        8H6UUiQn/7zanKVy9RNR75A=
X-Google-Smtp-Source: ABdhPJzl4KivwOT8F3phBf97gSbd2nqKH/G1aJvVj3JNnzzK9j4dbHwhfCrwEMdVpfgxt5TMQTySzQ==
X-Received: by 2002:ac8:7c90:: with SMTP id y16mr5015497qtv.45.1599018892780;
        Tue, 01 Sep 2020 20:54:52 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id d16sm4092148qte.19.2020.09.01.20.54.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Sep 2020 20:54:52 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 02DC827C0054;
        Tue,  1 Sep 2020 23:54:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 01 Sep 2020 23:54:51 -0400
X-ME-Sender: <xms:ihdPXzlip1zbNTbImsQjJQDYVvN6gqw5UEnkngYnnfGMTYFi-I3xBA>
    <xme:ihdPX20kBhjpWNE27hq88dltCEtaBxg_axp0EJkSczsxYPufPvzurJHfV4y7qrHN9
    jbZdNzh5vR1lD9nFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefkedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehg
    mhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedvleeigedugfegveejhfejveeuve
    eiteejieekvdfgjeefudehfefhgfegvdegjeenucfkphephedvrdduheehrdduuddurdej
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:ihdPX5rIM9GG3iP2CEbiHkkrZYozXKPIfhvoWm3EeZtw-7FrsGVOEw>
    <xmx:ihdPX7kxIliCRTKwqxFpoPXr91ld8TOjpmO2dK7wzNiAaX8hm4Rf_w>
    <xmx:ihdPXx0mC8DYNg34hXBRz-D8oxUPcjtEL9fR8TmP3R5wYkCUP5CMYw>
    <xmx:ixdPX_NP_A3v67q5A0E__yX3HQ41CnGTFQifln_c0pUK96W3bdAulFtqVwg>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id C4565306005E;
        Tue,  1 Sep 2020 23:54:49 -0400 (EDT)
Date:   Wed, 2 Sep 2020 11:54:48 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH kcsan 6/9] tools/memory-model: Expand the cheatsheet.txt
 notion of relaxed
Message-ID: <20200902035448.GC49492@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200831182012.GA1965@paulmck-ThinkPad-P72>
 <20200831182037.2034-6-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831182037.2034-6-paulmck@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 31, 2020 at 11:20:34AM -0700, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> This commit adds a key entry enumerating the various types of relaxed
> operations.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  tools/memory-model/Documentation/cheatsheet.txt | 27 ++++++++++++++-----------
>  1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
> index 33ba98d..31b814d 100644
> --- a/tools/memory-model/Documentation/cheatsheet.txt
> +++ b/tools/memory-model/Documentation/cheatsheet.txt
> @@ -5,7 +5,7 @@
>  
>  Store, e.g., WRITE_ONCE()            Y                                       Y
>  Load, e.g., READ_ONCE()              Y                          Y   Y        Y
> -Unsuccessful RMW operation           Y                          Y   Y        Y
> +Relaxed operation                    Y                          Y   Y        Y
>  rcu_dereference()                    Y                          Y   Y        Y
>  Successful *_acquire()               R                   Y  Y   Y   Y    Y   Y
>  Successful *_release()         C        Y  Y    Y     W                      Y
> @@ -17,14 +17,17 @@ smp_mb__before_atomic()       CP        Y  Y    Y        a  a   a   a    Y
>  smp_mb__after_atomic()        CP        a  a    Y        Y  Y   Y   Y    Y
>  
>  
> -Key:	C:	Ordering is cumulative
> -	P:	Ordering propagates
> -	R:	Read, for example, READ_ONCE(), or read portion of RMW
> -	W:	Write, for example, WRITE_ONCE(), or write portion of RMW
> -	Y:	Provides ordering
> -	a:	Provides ordering given intervening RMW atomic operation
> -	DR:	Dependent read (address dependency)
> -	DW:	Dependent write (address, data, or control dependency)
> -	RMW:	Atomic read-modify-write operation
> -	SELF:	Orders self, as opposed to accesses before and/or after
> -	SV:	Orders later accesses to the same variable
> +Key:	Relaxed:  A relaxed operation is either a *_relaxed() RMW
> +		  operation, an unsuccessful RMW operation, or one of
> +		  the atomic_read() and atomic_set() family of operations.

To be accurate, atomic_set() doesn't return any value, so it cannot be
ordered against DR and DW ;-)

I think we can split the Relaxed family into two groups:

void Relaxed: atomic_set() or atomic RMW operations that don't return
              any value (e.g atomic_inc())

non-void Relaxed: a *_relaxed() RMW operation, an unsuccessful RMW
                  operation, or atomic_read().

And "void Relaxed" is similar to WRITE_ONCE(), only has "Self" and "SV"
equal "Y", while "non-void Relaxed" plays the same rule as "Relaxed"
in this patch.

Thoughts?

Regards,
Boqun


> +	C:	  Ordering is cumulative
> +	P:	  Ordering propagates
> +	R:	  Read, for example, READ_ONCE(), or read portion of RMW
> +	W:	  Write, for example, WRITE_ONCE(), or write portion of RMW
> +	Y:	  Provides ordering
> +	a:	  Provides ordering given intervening RMW atomic operation
> +	DR:	  Dependent read (address dependency)
> +	DW:	  Dependent write (address, data, or control dependency)
> +	RMW:	  Atomic read-modify-write operation
> +	SELF:	  Orders self, as opposed to accesses before and/or after
> +	SV:	  Orders later accesses to the same variable
> -- 
> 2.9.5
> 
