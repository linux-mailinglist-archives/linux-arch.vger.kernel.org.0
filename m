Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04758258420
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 00:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgHaWe3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 18:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbgHaWe2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Aug 2020 18:34:28 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809ECC061573;
        Mon, 31 Aug 2020 15:34:26 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 17so1509297pfw.9;
        Mon, 31 Aug 2020 15:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AupFDJ4ADAlBb+Wf/zL43LdOmVjiJMJTnvFO4m/9Xf8=;
        b=pyjg6XZq6iZCA+VcOlqoMKlchi1S9inMjp6kM+jUOilc3ptygltszIUw+EgmBMTo5A
         AbJri9hi7/EjyT+iqYVT3KAWYCSdjBDpIO18+QmngOn6CKYjaJYy29d+9naHo+fgx0xP
         znz0Vp354ghQJQoZtMw/nf9EPkNH4pr+M4fz7BW89MUdkeCiQqWbyiobm3OSk7hbuwqC
         tg+jfJtA+KjWBH2/SSKjPp/qqR9K14CzR2SG1msPvgJVmwznnuz56lUy7yVSzRABpqk1
         zK0xRonB0Di6OLfd5SuMECgl2adQawfBDW9gx+Wsv7DlA2+4tGlOfexKYKwNiKGAPZRm
         LxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AupFDJ4ADAlBb+Wf/zL43LdOmVjiJMJTnvFO4m/9Xf8=;
        b=Ukhm1mf8H1r0HPXu3PsJ8W6EqYVEbZj+jR/hjfgRruu3ShAM1bfTtbzC36tM7ioMH6
         S0xUER5twEp0Re4jMv01lv1FYyAS0YTfLEjdUPXMOBeD75lGeINNyvdrN7o8kK15pFJ9
         e+AE9/txU3iq08pzQ/wZg4eCSypESo6ZpORdELilsnm1lT/evXC2aRAWbKMOBBgZXn9v
         GkxyChi+DbuNKaba8YDs8TRoy0BCcZ4NsK6157p5LG2oNp3daX2olXv2Y1Apcggf7ABS
         +0CiorELKwyNUM5QNN66j+bJRkRrF40IX1slVqIyP5Oa+ouV6UuIxzkAtzSAilGEJGNu
         R48w==
X-Gm-Message-State: AOAM533NGxdwiMpC+thjg2rG+ZBig2cEvuhOUk8d/p8vna9knc7wVY5P
        OVG+cFDWAARmgtEzNzlwu8m3LC/Hkfc=
X-Google-Smtp-Source: ABdhPJxEOvyNRmB02eUPOdMhi7Q4dcqybr8QPMKcPoyJkRsck6C5InZfRnBM9IJs21WOnzjxA6oC2A==
X-Received: by 2002:a63:6dc7:: with SMTP id i190mr2788710pgc.27.1598913265867;
        Mon, 31 Aug 2020 15:34:25 -0700 (PDT)
Received: from [192.168.11.3] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id g19sm8575954pgj.86.2020.08.31.15.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 15:34:25 -0700 (PDT)
Subject: Re: [PATCH kcsan 8/9] tools/memory-model: Document categories of
 ordering primitives
To:     paulmck@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com
References: <20200831182012.GA1965@paulmck-ThinkPad-P72>
 <20200831182037.2034-8-paulmck@kernel.org>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <48f1fcd2-de89-b21e-f5a6-96c8e8861706@gmail.com>
Date:   Tue, 1 Sep 2020 07:34:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200831182037.2034-8-paulmck@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 31 Aug 2020 11:20:36 -0700, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> The Linux kernel has a number of categories of ordering primitives, which
> are recorded in the LKMM implementation and hinted at by cheatsheet.txt.
> But there is no overview of these categories, and such an overview
> is needed in order to understand multithreaded LKMM litmus tests.
> This commit therefore adds an ordering.txt as well as extracting a
> control-dependencies.txt from memory-barriers.txt.  It also updates the
> README file.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  tools/memory-model/Documentation/README       |  24 +-
>  tools/memory-model/Documentation/ordering.txt | 462 ++++++++++++++++++++++++++
>  tools/memory-model/control-dependencies.txt   | 256 ++++++++++++++
>  3 files changed, 740 insertions(+), 2 deletions(-)
>  create mode 100644 tools/memory-model/Documentation/ordering.txt
>  create mode 100644 tools/memory-model/control-dependencies.txt

Hi Paul,

Didn't you mean to put control-dependencies.txt under tools/memory-model/Documentation/ ?

        Thanks, Akira

> 
> diff --git a/tools/memory-model/Documentation/README b/tools/memory-model/Documentation/README
> index 4326603..16177aa 100644
> --- a/tools/memory-model/Documentation/README
> +++ b/tools/memory-model/Documentation/README
> @@ -8,10 +8,19 @@ number of places.
>  
>  This document therefore describes a number of places to start reading
>  the documentation in this directory, depending on what you know and what
> -you would like to learn:
> +you would like to learn.  These are cumulative, that is, understanding
> +of the documents earlier in this list is required by the documents later
> +in this list.
>  
>  o	You are new to Linux-kernel concurrency: simple.txt
>  
> +o	You have some background in Linux-kernel concurrency, and would
> +	like an overview of the types of low-level concurrency primitives
> +	that are provided:  ordering.txt
> +
> +	Here, "low level" means atomic operations to single locations in
> +	memory.
> +
>  o	You are familiar with the concurrency facilities that you
>  	need, and just want to get started with LKMM litmus tests:
>  	litmus-tests.txt
> @@ -20,6 +29,9 @@ o	You are familiar with Linux-kernel concurrency, and would
>  	like a detailed intuitive understanding of LKMM, including
>  	situations involving more than two threads: recipes.txt
>  
> +o	You would like a detailed understanding of what your compiler can
> +	and cannot do to control dependencies: control-dependencies.txt
> +
>  o	You are familiar with Linux-kernel concurrency and the
>  	use of LKMM, and would like a cheat sheet to remind you
>  	of LKMM's guarantees: cheatsheet.txt
> @@ -37,12 +49,16 @@ o	You are interested in the publications related to LKMM, including
>  DESCRIPTION OF FILES
>  ====================
>  
> -Documentation/README
> +README
>  	This file.
>  
>  Documentation/cheatsheet.txt
>  	Quick-reference guide to the Linux-kernel memory model.
>  
> +Documentation/control-dependencies.txt
> +	A guide to preventing compiler optimizations from destroying
> +	your control dependencies.
> +
>  Documentation/explanation.txt
>  	Describes the memory model in detail.
[...]
