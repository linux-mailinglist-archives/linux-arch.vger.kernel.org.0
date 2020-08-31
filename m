Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2C1257E99
	for <lists+linux-arch@lfdr.de>; Mon, 31 Aug 2020 18:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgHaQWY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 12:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbgHaQWU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Aug 2020 12:22:20 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5359EC061755;
        Mon, 31 Aug 2020 09:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nXWPA5uglIyw8NOR1fui+EZFOlSP7Ta11J/zRDiIoHQ=; b=r0z/QkjZivPkrJCb7f+L9zwh5f
        4IIa7un7mz+f/CQjuSWhwrAdcZMXXoHqcR6Phcf/CP76ypP+QG9wiTuVUfQXopIFdiGp0jtGoZt8/
        6m2Eh9A1MvSTxBCbsCqMHE741aRCdqNxiwjIaDorsX+5hViH7DeqxTsiYWT4JaNomcOSEZWXQ7j8X
        fS3G/Rtd5dxtEV3Yv8oPU1A5fSI46Ku4JIcQsV4Kmg77QypKwMh7Ah2sYYPQcZZsj7gFXewTa3auv
        Ci0WctbP67UG57shPTjLezNWGZGM5IpgDY6d+ybCtPfiNBMMaiHYppvaqS0WXOJzdf3JKL5UO87pN
        N8it1++w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCmZ6-0006jC-IA; Mon, 31 Aug 2020 16:21:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 97F91300F7A;
        Mon, 31 Aug 2020 18:21:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 81A8B203A64B1; Mon, 31 Aug 2020 18:21:50 +0200 (CEST)
Date:   Mon, 31 Aug 2020 18:21:50 +0200
From:   peterz@infradead.org
To:     albert.linde@gmail.com
Cc:     akpm@linux-foundation.org, bp@alien8.de, mingo@redhat.com,
        corbet@lwn.net, tglx@linutronix.de, arnd@arndb.de,
        akinobu.mita@gmail.com, hpa@zytor.com, viro@zeniv.linux.org.uk,
        glider@google.com, andreyknvl@google.com, dvyukov@google.com,
        elver@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, Albert van der Linde <alinde@google.com>
Subject: Re: [PATCH v2 2/3] lib, uaccess: add failure injection to usercopy
 functions
Message-ID: <20200831162150.GR1362448@hirez.programming.kicks-ass.net>
References: <20200828141344.2277088-1-alinde@google.com>
 <20200828141344.2277088-3-alinde@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828141344.2277088-3-alinde@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 28, 2020 at 02:13:43PM +0000, albert.linde@gmail.com wrote:
> @@ -82,6 +83,8 @@ __copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
>  static __always_inline __must_check unsigned long
>  __copy_from_user(void *to, const void __user *from, unsigned long n)
>  {
> +	if (should_fail_usercopy())
> +		return n;
>  	might_fault();
>  	instrument_copy_from_user(to, from, n);
>  	check_object_size(to, n, false);

> @@ -124,7 +131,7 @@ _copy_from_user(void *to, const void __user *from, unsigned long n)
>  {
>  	unsigned long res = n;
>  	might_fault();
> -	if (likely(access_ok(from, n))) {
> +	if (!should_fail_usercopy() && likely(access_ok(from, n))) {
>  		instrument_copy_from_user(to, from, n);
>  		res = raw_copy_from_user(to, from, n);
>  	}

You're inconsistent with your order against might_fault() throughout the
patch. After is the right place.
