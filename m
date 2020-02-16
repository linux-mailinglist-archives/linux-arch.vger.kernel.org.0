Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 778FE160148
	for <lists+linux-arch@lfdr.de>; Sun, 16 Feb 2020 01:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgBPA6M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 15 Feb 2020 19:58:12 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45571 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgBPA6M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 15 Feb 2020 19:58:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id g3so15373983wrs.12;
        Sat, 15 Feb 2020 16:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RCDLALl/MTIpSe4w1aS0l0xdIrytoZNo1Wy/s//seUE=;
        b=DEPP1R8JW+LustojQY7QA403o9izrtf3TSwoB003aHPvx4RISqP81Jdm4NBIVbInBD
         DT5aBu1vdEMnk9UmiALfRRd/qAm8v6FIefInok6aPOyfGyzuRqAZ0zVqLFU0pfSMzy3h
         1zH/jns3P8Hi0zqfN1tlj72Ovi1l/lpHmeelSYyF2WiOU87Vr5bXR8L1zFGqn8lZsfI1
         pbe+Ukx9aFTXI7tc32hvNgdQBpwpblJ1eoCvZ+l9hUzZlFbBdIe1LiNKptbfY08KthhG
         RG1kW0d111skz5DcU3TaUXQbnEwDsAougxy6IOZ0+6GaETwUJ5/nn6Ig3eVMswm8RM6L
         PWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RCDLALl/MTIpSe4w1aS0l0xdIrytoZNo1Wy/s//seUE=;
        b=Zy1B1fFC2Oz4eEe8XZaGccmvtp9h8m1BO5zVTsxtS5QD46fMujdFpjzGVr9vL03ePT
         Z346e9cADdLirLNTEVjIrzNMo8wPg/SyZPHnRq1rgAUqLtzNgwQpniP9AzmUPppqV1jR
         N6p69CEvXDcKjZJKXl2DFHBVZLj7ILWMgLPQQpy5Fguhi0FEB300oM9MJKsYpXieS8SL
         MAbQCllOHACI8kRyTBgtvLX3/Q9pGz9H5r88TbEWWy1VO4BOUndEj5Wdxt6d0KOdgKMn
         O9cg/2GdgKg6PtV5qCLwWLnWuQ7cjWVyu2xbOljPrHEsF/P9V+KWQOU6EtsxOMKAVuY3
         Zaqw==
X-Gm-Message-State: APjAAAVPP3yfirVRs28Gs4KCXWk9KA0e2oWKgEd668mCNlHPsWUyW6Rd
        jN5suKzT1VN/g7OSKH3YBXg=
X-Google-Smtp-Source: APXvYqwSRX2xQqiK2IXILS90AZ/QGc0+LrRJsYx8r5sD4t0L7/ukx8iHvVvA4hQi7ts0HbNyVq1aTA==
X-Received: by 2002:a5d:6789:: with SMTP id v9mr13079863wru.55.1581814688042;
        Sat, 15 Feb 2020 16:58:08 -0800 (PST)
Received: from andrea (ip-213-220-200-127.net.upcbroadband.cz. [213.220.200.127])
        by smtp.gmail.com with ESMTPSA id y1sm13769417wrq.16.2020.02.15.16.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 16:58:07 -0800 (PST)
Date:   Sun, 16 Feb 2020 01:58:01 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, stern@rowland.harvard.edu,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH memory-model] Add recent references
Message-ID: <20200216005801.GA3581@andrea>
References: <20200214233139.GA12521@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214233139.GA12521@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 14, 2020 at 03:31:39PM -0800, Paul E. McKenney wrote:
> This commit updates the list of LKMM-related publications in
> Documentation/references.txt.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Acked-by: Andrea Parri <parri.andrea@gmail.com>

Thanks,
  Andrea


> 
> diff --git a/tools/memory-model/Documentation/references.txt b/tools/memory-model/Documentation/references.txt
> index b177f3e..ecbbaa5 100644
> --- a/tools/memory-model/Documentation/references.txt
> +++ b/tools/memory-model/Documentation/references.txt
> @@ -73,6 +73,18 @@ o	Christopher Pulte, Shaked Flur, Will Deacon, Jon French,
>  Linux-kernel memory model
>  =========================
>  
> +o	Jade Alglave, Will Deacon, Boqun Feng, David Howells, Daniel
> +	Lustig, Luc Maranget, Paul E. McKenney, Andrea Parri, Nicholas
> +	Piggin, Alan Stern, Akira Yokosawa, and Peter Zijlstra.
> +	2019. "Calibrating your fear of big bad optimizing compilers"
> +	Linux Weekly News.  https://lwn.net/Articles/799218/
> +
> +o	Jade Alglave, Will Deacon, Boqun Feng, David Howells, Daniel
> +	Lustig, Luc Maranget, Paul E. McKenney, Andrea Parri, Nicholas
> +	Piggin, Alan Stern, Akira Yokosawa, and Peter Zijlstra.
> +	2019. "Who's afraid of a big bad optimizing compiler?"
> +	Linux Weekly News.  https://lwn.net/Articles/793253/
> +
>  o	Jade Alglave, Luc Maranget, Paul E. McKenney, Andrea Parri, and
>  	Alan Stern.  2018. "Frightening small children and disconcerting
>  	grown-ups: Concurrency in the Linux kernel". In Proceedings of
> @@ -88,6 +100,11 @@ o	Jade Alglave, Luc Maranget, Paul E. McKenney, Andrea Parri, and
>  	Alan Stern.  2017.  "A formal kernel memory-ordering model (part 2)"
>  	Linux Weekly News.  https://lwn.net/Articles/720550/
>  
> +o	Jade Alglave, Luc Maranget, Paul E. McKenney, Andrea Parri, and
> +	Alan Stern.  2017-2019.  "A Formal Model of Linux-Kernel Memory
> +	Ordering" (backup material for the LWN articles)
> +	https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinuxMM/
> +
>  
>  Memory-model tooling
>  ====================
> @@ -110,5 +127,5 @@ Memory-model comparisons
>  ========================
>  
>  o	Paul E. McKenney, Ulrich Weigand, Andrea Parri, and Boqun
> -	Feng. 2016. "Linux-Kernel Memory Model". (6 June 2016).
> -	http://open-std.org/JTC1/SC22/WG21/docs/papers/2016/p0124r2.html.
> +	Feng. 2018. "Linux-Kernel Memory Model". (27 September 2018).
> +	http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/p0124r6.html.
