Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580582281DB
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 16:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgGUOTK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 10:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgGUOTJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 10:19:09 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D9BC0619DA;
        Tue, 21 Jul 2020 07:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eXpfk1ooDp9WmjVCuYrQskrwc9qrONU71/gOTT/8jIs=; b=dAhgFPlVD3G9z+H8gQSZ6CNDD4
        a8tKY26rktKszNHdh/s+554HFR+4m5iwgWaKIE7O5QOte4l/YH+BVXk5K7QK8YI55DdmlEwLq+Z0e
        19IADhFrEzHC6r96axPMo7w3lSfBms3Ol0hj0NleZYid91Wa7Gktc7027grlpWebsxytQJy0m+eSg
        5WrUr1e1KSA/9BL70cf0m8zt1f4b9PiNG8XFazPjcxpErYTHJNO+8XnpMrK4SzbIHcZr3Qdeu7s08
        YLTNxTxJdbQN7z1vfp+Xt6Cp+hl/D5voGSuDkCb3mrku4E+ihNkLPogOs575xSW/aBVN+Q7vogpt1
        +7z3X0IA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxt6j-0000fh-HN; Tue, 21 Jul 2020 14:19:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2B0323060EF;
        Tue, 21 Jul 2020 16:18:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 15E50203B8783; Tue, 21 Jul 2020 16:18:59 +0200 (CEST)
Date:   Tue, 21 Jul 2020 16:18:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, will@kernel.org, arnd@arndb.de,
        mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 8/8] locking/atomics: Use read-write instrumentation for
 atomic RMWs
Message-ID: <20200721141859.GC10769@hirez.programming.kicks-ass.net>
References: <20200721103016.3287832-1-elver@google.com>
 <20200721103016.3287832-9-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721103016.3287832-9-elver@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 21, 2020 at 12:30:16PM +0200, Marco Elver wrote:

> diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
> index 6afadf73da17..5cdcce703660 100755
> --- a/scripts/atomic/gen-atomic-instrumented.sh
> +++ b/scripts/atomic/gen-atomic-instrumented.sh
> @@ -5,9 +5,10 @@ ATOMICDIR=$(dirname $0)
>  
>  . ${ATOMICDIR}/atomic-tbl.sh
>  
> -#gen_param_check(arg)
> +#gen_param_check(meta, arg)
>  gen_param_check()
>  {
> +	local meta="$1"; shift
>  	local arg="$1"; shift
>  	local type="${arg%%:*}"
>  	local name="$(gen_param_name "${arg}")"
> @@ -17,17 +18,24 @@ gen_param_check()
>  	i) return;;
>  	esac
>  
> -	# We don't write to constant parameters
> -	[ ${type#c} != ${type} ] && rw="read"
> +	if [ ${type#c} != ${type} ]; then
> +		# We don't write to constant parameters
> +		rw="read"
> +	elif [ "${meta}" != "s" ]; then
> +		# Atomic RMW
> +		rw="read_write"
> +	fi

If we have meta, should we then not be consistent and use it for read
too? Mark?

>  
>  	printf "\tinstrument_atomic_${rw}(${name}, sizeof(*${name}));\n"
>  }
>  
> -#gen_param_check(arg...)
> +#gen_params_checks(meta, arg...)
>  gen_params_checks()
>  {
> +	local meta="$1"; shift
> +
>  	while [ "$#" -gt 0 ]; do
> -		gen_param_check "$1"
> +		gen_param_check "$meta" "$1"
>  		shift;
>  	done
>  }
> @@ -77,7 +85,7 @@ gen_proto_order_variant()
>  
>  	local ret="$(gen_ret_type "${meta}" "${int}")"
>  	local params="$(gen_params "${int}" "${atomic}" "$@")"
> -	local checks="$(gen_params_checks "$@")"
> +	local checks="$(gen_params_checks "${meta}" "$@")"
>  	local args="$(gen_args "$@")"
>  	local retstmt="$(gen_ret_stmt "${meta}")"
>  
> -- 
> 2.28.0.rc0.105.gf9edc3c819-goog
> 
