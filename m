Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28D0017633D
	for <lists+linux-arch@lfdr.de>; Mon,  2 Mar 2020 19:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgCBSw2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Mar 2020 13:52:28 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52894 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgCBSw2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2020 13:52:28 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so197499wmc.2;
        Mon, 02 Mar 2020 10:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N+92nMqwyvyqnvBWahI9x0clg05C+2OnWX3BXzruqvI=;
        b=AMAtFQWcB1swXshKwOXCZHsI4wxf/NlKaNf435jqL37KU7tkrKWFI5nCfgIweOg41R
         dGoGUgQcJYAIXCmkBAu2xx5WwNLo4TNtxA7i0oxWREkcWf/f89RsJSYM6cGvlzdkhijO
         TeS12crkWY4lDZGz/ah+6KGP+ZdfkBA4tIhIPXw44fF/AM6RnFUv2g1pJgCYM6Rca2Ca
         XM/P0ce1+LJhjRpTs9lvoIctIBgKPLPqf/YLQeliKptWdoc7lSECKErYWX7XJDJqIeKX
         8s8wGntRXu2bW7IVMb9HBIL93E3I8mFQzTYRyVi2S2uPJcKpquuXJ53CMfhplzaqgPiH
         lwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N+92nMqwyvyqnvBWahI9x0clg05C+2OnWX3BXzruqvI=;
        b=fuQ6v274i3hjjqNBq2q9gflnnS87s5XOTxpUiARHH6kOUUIzPECrSVL4W3iOby2nB5
         YLcSYtBUinR5nhZgYHFqT3rWG4jtW90xtSzpISVItCKuD81TAc7f0g9GitxXYO4/ToAH
         Sd/c0EO/12z4DuHvKO6Dh8EH2UHcefJgwGkU7OkFPw5Ym8lDenAfOidCEvYCe2NAYtA/
         0fyiMp40Tjn8MGi1BeCMWF8zNaclXHnn0yYP/deSUWb0z+mZ57ybSO7a9xVNCLvptYtE
         NO9+pLHvLlujmVLQhs46JM4b99QyGy5at5wJegYvi/eCse2GFNzirhgUK1MadFSr+0k7
         qNpw==
X-Gm-Message-State: ANhLgQ2Os7sqRoa7brANuL0gjFmqaBD/GQPaNqBxjrlSoIqzzs9Yj+0D
        6Re/aJHAuT+QbcYF4tbtI44=
X-Google-Smtp-Source: ADFU+vtAzXMfZgJYhKEk08s9yz5pxY8gnWercSv+ePF/LN8nXjEr4J4i+e4/MztO1Ef4td9Vdpd3VQ==
X-Received: by 2002:a1c:e108:: with SMTP id y8mr220600wmg.147.1583175143890;
        Mon, 02 Mar 2020 10:52:23 -0800 (PST)
Received: from andrea (ip-213-220-200-127.net.upcbroadband.cz. [213.220.200.127])
        by smtp.gmail.com with ESMTPSA id t187sm474548wmt.25.2020.03.02.10.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 10:52:22 -0800 (PST)
Date:   Mon, 2 Mar 2020 19:52:16 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        stern@rowland.harvard.edu, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, paulmck@kernel.org,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v3] tools/memory-model/Documentation: Fix "conflict"
 definition
Message-ID: <20200302185216.GA5320@andrea>
References: <20200302172101.157917-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302172101.157917-1-elver@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 02, 2020 at 06:21:01PM +0100, Marco Elver wrote:
> The definition of "conflict" should not include the type of access nor
> whether the accesses are concurrent or not, which this patch addresses.
> The definition of "data race" remains unchanged.
> 
> The definition of "conflict" as we know it and is cited by various
> papers on memory consistency models appeared in [1]: "Two accesses to
> the same variable conflict if at least one is a write; two operations
> conflict if they execute conflicting accesses."
> 
> The LKMM as well as the C11 memory model are adaptations of
> data-race-free, which are based on the work in [2]. Necessarily, we need
> both conflicting data operations (plain) and synchronization operations
> (marked). For example, C11's definition is based on [3], which defines a
> "data race" as: "Two memory operations conflict if they access the same
> memory location, and at least one of them is a store, atomic store, or
> atomic read-modify-write operation. In a sequentially consistent
> execution, two memory operations from different threads form a type 1
> data race if they conflict, at least one of them is a data operation,
> and they are adjacent in <T (i.e., they may be executed concurrently)."
> 
> [1] D. Shasha, M. Snir, "Efficient and Correct Execution of Parallel
>     Programs that Share Memory", 1988.
> 	URL: http://snir.cs.illinois.edu/listed/J21.pdf
> 
> [2] S. Adve, "Designing Memory Consistency Models for Shared-Memory
>     Multiprocessors", 1993.
> 	URL: http://sadve.cs.illinois.edu/Publications/thesis.pdf
> 
> [3] H.-J. Boehm, S. Adve, "Foundations of the C++ Concurrency Memory
>     Model", 2008.
> 	URL: https://www.hpl.hp.com/techreports/2008/HPL-2008-56.pdf
> 
> Signed-off-by: Marco Elver <elver@google.com>
> Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

LGTM:

Acked-by: Andrea Parri <parri.andrea@gmail.com>

Thank you both,

  Andrea


> ---
> v3:
> * Apply Alan's suggestion.
> * s/two race candidates/race candidates/
> 
> v2: http://lkml.kernel.org/r/20200302141819.40270-1-elver@google.com
> * Apply Alan's suggested version.
>   - Move "from different CPUs (or threads)" from "conflict" to "data
>     race" definition. Update "race candidate" accordingly.
> * Add citations to commit message.
> 
> v1: http://lkml.kernel.org/r/20200228164621.87523-1-elver@google.com
> ---
>  .../Documentation/explanation.txt             | 83 ++++++++++---------
>  1 file changed, 45 insertions(+), 38 deletions(-)
> 
> diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> index e91a2eb19592a..993f800659c6a 100644
> --- a/tools/memory-model/Documentation/explanation.txt
> +++ b/tools/memory-model/Documentation/explanation.txt
> @@ -1987,28 +1987,36 @@ outcome undefined.
>  
>  In technical terms, the compiler is allowed to assume that when the
>  program executes, there will not be any data races.  A "data race"
> -occurs when two conflicting memory accesses execute concurrently;
> -two memory accesses "conflict" if:
> +occurs when there are two memory accesses such that:
>  
> -	they access the same location,
> +1.	they access the same location,
>  
> -	they occur on different CPUs (or in different threads on the
> -	same CPU),
> +2.	at least one of them is a store,
>  
> -	at least one of them is a plain access,
> +3.	at least one of them is plain,
>  
> -	and at least one of them is a store.
> +4.	they occur on different CPUs (or in different threads on the
> +	same CPU), and
>  
> -The LKMM tries to determine whether a program contains two conflicting
> -accesses which may execute concurrently; if it does then the LKMM says
> -there is a potential data race and makes no predictions about the
> -program's outcome.
> +5.	they execute concurrently.
>  
> -Determining whether two accesses conflict is easy; you can see that
> -all the concepts involved in the definition above are already part of
> -the memory model.  The hard part is telling whether they may execute
> -concurrently.  The LKMM takes a conservative attitude, assuming that
> -accesses may be concurrent unless it can prove they cannot.
> +In the literature, two accesses are said to "conflict" if they satisfy
> +1 and 2 above.  We'll go a little farther and say that two accesses
> +are "race candidates" if they satisfy 1 - 4.  Thus, whether or not two
> +race candidates actually do race in a given execution depends on
> +whether they are concurrent.
> +
> +The LKMM tries to determine whether a program contains race candidates
> +which may execute concurrently; if it does then the LKMM says there is
> +a potential data race and makes no predictions about the program's
> +outcome.
> +
> +Determining whether two accesses are race candidates is easy; you can
> +see that all the concepts involved in the definition above are already
> +part of the memory model.  The hard part is telling whether they may
> +execute concurrently.  The LKMM takes a conservative attitude,
> +assuming that accesses may be concurrent unless it can prove they
> +are not.
>  
>  If two memory accesses aren't concurrent then one must execute before
>  the other.  Therefore the LKMM decides two accesses aren't concurrent
> @@ -2171,8 +2179,8 @@ again, now using plain accesses for buf:
>  	}
>  
>  This program does not contain a data race.  Although the U and V
> -accesses conflict, the LKMM can prove they are not concurrent as
> -follows:
> +accesses are race candidates, the LKMM can prove they are not
> +concurrent as follows:
>  
>  	The smp_wmb() fence in P0 is both a compiler barrier and a
>  	cumul-fence.  It guarantees that no matter what hash of
> @@ -2326,12 +2334,11 @@ could now perform the load of x before the load of ptr (there might be
>  a control dependency but no address dependency at the machine level).
>  
>  Finally, it turns out there is a situation in which a plain write does
> -not need to be w-post-bounded: when it is separated from the
> -conflicting access by a fence.  At first glance this may seem
> -impossible.  After all, to be conflicting the second access has to be
> -on a different CPU from the first, and fences don't link events on
> -different CPUs.  Well, normal fences don't -- but rcu-fence can!
> -Here's an example:
> +not need to be w-post-bounded: when it is separated from the other
> +race-candidate access by a fence.  At first glance this may seem
> +impossible.  After all, to be race candidates the two accesses must
> +be on different CPUs, and fences don't link events on different CPUs.
> +Well, normal fences don't -- but rcu-fence can!  Here's an example:
>  
>  	int x, y;
>  
> @@ -2367,7 +2374,7 @@ concurrent and there is no race, even though P1's plain store to y
>  isn't w-post-bounded by any marked accesses.
>  
>  Putting all this material together yields the following picture.  For
> -two conflicting stores W and W', where W ->co W', the LKMM says the
> +race-candidate stores W and W', where W ->co W', the LKMM says the
>  stores don't race if W can be linked to W' by a
>  
>  	w-post-bounded ; vis ; w-pre-bounded
> @@ -2380,8 +2387,8 @@ sequence, and if W' is plain then they also have to be linked by a
>  
>  	w-post-bounded ; vis ; r-pre-bounded
>  
> -sequence.  For a conflicting load R and store W, the LKMM says the two
> -accesses don't race if R can be linked to W by an
> +sequence.  For race-candidate load R and store W, the LKMM says the
> +two accesses don't race if R can be linked to W by an
>  
>  	r-post-bounded ; xb* ; w-pre-bounded
>  
> @@ -2413,20 +2420,20 @@ is, the rules governing the memory subsystem's choice of a store to
>  satisfy a load request and its determination of where a store will
>  fall in the coherence order):
>  
> -	If R and W conflict and it is possible to link R to W by one
> -	of the xb* sequences listed above, then W ->rfe R is not
> -	allowed (i.e., a load cannot read from a store that it
> +	If R and W are race candidates and it is possible to link R to
> +	W by one of the xb* sequences listed above, then W ->rfe R is
> +	not allowed (i.e., a load cannot read from a store that it
>  	executes before, even if one or both is plain).
>  
> -	If W and R conflict and it is possible to link W to R by one
> -	of the vis sequences listed above, then R ->fre W is not
> -	allowed (i.e., if a store is visible to a load then the load
> -	must read from that store or one coherence-after it).
> +	If W and R are race candidates and it is possible to link W to
> +	R by one of the vis sequences listed above, then R ->fre W is
> +	not allowed (i.e., if a store is visible to a load then the
> +	load must read from that store or one coherence-after it).
>  
> -	If W and W' conflict and it is possible to link W to W' by one
> -	of the vis sequences listed above, then W' ->co W is not
> -	allowed (i.e., if one store is visible to a second then the
> -	second must come after the first in the coherence order).
> +	If W and W' are race candidates and it is possible to link W
> +	to W' by one of the vis sequences listed above, then W' ->co W
> +	is not allowed (i.e., if one store is visible to a second then
> +	the second must come after the first in the coherence order).
>  
>  This is the extent to which the LKMM deals with plain accesses.
>  Perhaps it could say more (for example, plain accesses might
> -- 
> 2.25.0.265.gbab2e86ba0-goog
> 
