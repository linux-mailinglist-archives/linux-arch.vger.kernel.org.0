Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 944AA1725AC
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2020 18:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbgB0Rww (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Feb 2020 12:52:52 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34906 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbgB0Rwv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Feb 2020 12:52:51 -0500
Received: by mail-wm1-f68.google.com with SMTP id m3so359744wmi.0;
        Thu, 27 Feb 2020 09:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oJzOQyGUdiyuY3HBRX4a1v3LKWNPTj5lhD17LyMZ2gU=;
        b=rszqU/q6TjoEHSZvLU3SjjNtlZUhdmojbgbag/J2EiP37I/+eMwD5f/30vb9DmCDUY
         eilL7t0XZevD+Fv6+5Eock2xfk+JJx7wwZgoCQtnfa/i3aothEYuzNCx0fjEgMOYiv+L
         PE3qisnuQrNZNZjNXWp4pe8OJjaYTBFWNzuHbpVUkmXuWBRLIVQPfbZCKYRzEbk2q+Ff
         Uqj5EgEQG8hE54jE/IubEcN7NPHdGdMug78Pd9XOK6U6Hch19txBjO9/JOq9zawM4jHb
         NATB7p0wZ/tshoGalieBmEQNNW9sOqCNfKiqEEkrURvRwOzYJssZ0r2zib17lPKZPTEj
         X60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oJzOQyGUdiyuY3HBRX4a1v3LKWNPTj5lhD17LyMZ2gU=;
        b=BXC5OnZ7syPU7nnlqXcSeaV6F9rOBN4T6zp9mgW6FMHUyN+PsqRPe1BetrleKnH9DQ
         Dc4WoWQZ6ErINqAfJyeDNWh1LiwfCh2Fqr2QN1ecqbx3C71ullFEJH5X0c+tz+NEBqwd
         C0buXV89l9K3eSV85mhRWJNmBYtMBgPvZNnYN7t4xJjVd1mPhvyW0J/gZCimboG42Ztw
         Jm5xcWXrljv9ELS7Plvc/EPzPxjf0jfXSnjjoVuGMiuKVDr9eZEV5giCiQjfXbqmNEZn
         y961w5SQlfffRbUVXCJejZBycCiYJISQKYGaGmIwX9HDe5EFjjNpG7Z0qkU1LZPshn9E
         lJ7g==
X-Gm-Message-State: APjAAAUnWg+DQOrsf4KrQi3PV+DyDpIWER8xokO6QiyjTgSvA8GFWCCB
        NO78jLdaCwUWD55wtk1gTU8=
X-Google-Smtp-Source: APXvYqxT+Z+0UBIpflHvqZ0pgfzA3CLtgsKUXQb+gdNtOOaStPTtxk+2QEj6M+dWRhmjbTPIuFIPNg==
X-Received: by 2002:a1c:cc06:: with SMTP id h6mr720524wmb.118.1582825967439;
        Thu, 27 Feb 2020 09:52:47 -0800 (PST)
Received: from andrea (ip-213-220-200-127.net.upcbroadband.cz. [213.220.200.127])
        by smtp.gmail.com with ESMTPSA id y7sm12885124wmd.1.2020.02.27.09.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 09:52:46 -0800 (PST)
Date:   Thu, 27 Feb 2020 18:52:40 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/5] tools/memory-model: Add an exception for
 limitations on _unless() family
Message-ID: <20200227175240.GA12046@andrea>
References: <20200227004049.6853-1-boqun.feng@gmail.com>
 <20200227004049.6853-2-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227004049.6853-2-boqun.feng@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 27, 2020 at 08:40:45AM +0800, Boqun Feng wrote:
> According to Luc, atomic_add_unless() is directly provided by herd7,
> therefore it can be used in litmus tests. So change the limitation
> section in README to unlimit the use of atomic_add_unless().
> 
> Cc: Luc Maranget <luc.maranget@inria.fr>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  tools/memory-model/README | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/memory-model/README b/tools/memory-model/README
> index fc07b52f2028..409211b1c544 100644
> --- a/tools/memory-model/README
> +++ b/tools/memory-model/README
> @@ -207,11 +207,15 @@ The Linux-kernel memory model (LKMM) has the following limitations:
>  		case as a store release.
>  
>  	b.	The "unless" RMW operations are not currently modeled:
> -		atomic_long_add_unless(), atomic_add_unless(),
> -		atomic_inc_unless_negative(), and
> -		atomic_dec_unless_positive().  These can be emulated
> +		atomic_long_add_unless(), atomic_inc_unless_negative(),
> +		and atomic_dec_unless_positive().  These can be emulated
>  		in litmus tests, for example, by using atomic_cmpxchg().
>  
> +		One exception of this limitation is atomic_add_unless(),
> +		which is provided directly by herd7 (so no corresponding
> +		definition in linux-kernel.def). atomic_add_unless() is

Nit: Two spaces after period?

  Andrea


> +		modeled by herd7 therefore it can be used in litmus tests.
> +
>  	c.	The call_rcu() function is not modeled.  It can be
>  		emulated in litmus tests by adding another process that
>  		invokes synchronize_rcu() and the body of the callback
> -- 
> 2.25.0
> 
