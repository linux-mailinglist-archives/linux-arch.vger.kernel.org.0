Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68993D9966
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2019 20:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbfJPSpF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Oct 2019 14:45:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47646 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728538AbfJPSpF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2019 14:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Xkj+IPEJ6D9FNAsOyKv+xxTO5cnYq7m4+bjOEldOn7U=; b=RUtfEOh4CN2XG3g+2p4F5E59U
        uH8zd6ysB/TYLiCt3L1YeAm69Q+wHntC69+c0JrQQ5R6VNXzeroYN3C/snKxMewnTOgZDGlBVp/NB
        MaL8EQ8ux/EaNk5bQOd5GOm2PthRHrHm769GXcFoWVhoBOBwlCNRbXnBcM6JMe3l11+QMFJG+TuuX
        b4sxXIB/+Ifi5OVFmwaxI9DM7JWW0a0nu9euoCXKguWyEz8z59H8S27xwIJZ7Ph2tqcAWmfrchsjX
        IU3OY2jpOYBpUVtLNOxXmacibZzbJw+eL4iF7tlpfi9+by4cmr2vv8snTS3N48Gdxc8T7X9JIBx3U
        cgV/d5WGA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKoH4-0007gT-0F; Wed, 16 Oct 2019 18:43:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E1E46303807;
        Wed, 16 Oct 2019 20:42:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C50B629E86612; Wed, 16 Oct 2019 20:43:46 +0200 (CEST)
Date:   Wed, 16 Oct 2019 20:43:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com,
        parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, arnd@arndb.de, boqun.feng@gmail.com,
        bp@alien8.de, dja@axtens.net, dlustig@nvidia.com,
        dave.hansen@linux.intel.com, dhowells@redhat.com,
        dvyukov@google.com, hpa@zytor.com, mingo@redhat.com,
        j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net,
        jpoimboe@redhat.com, luc.maranget@inria.fr, mark.rutland@arm.com,
        npiggin@gmail.com, paulmck@linux.ibm.com, tglx@linutronix.de,
        will@kernel.org, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH 1/8] kcsan: Add Kernel Concurrency Sanitizer
 infrastructure
Message-ID: <20191016184346.GT2328@hirez.programming.kicks-ass.net>
References: <20191016083959.186860-1-elver@google.com>
 <20191016083959.186860-2-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016083959.186860-2-elver@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 16, 2019 at 10:39:52AM +0200, Marco Elver wrote:

> +bool __kcsan_check_watchpoint(const volatile void *ptr, size_t size,
> +			      bool is_write)
> +{
> +	atomic_long_t *watchpoint;
> +	long encoded_watchpoint;
> +	unsigned long flags;
> +	enum kcsan_report_type report_type;
> +
> +	if (unlikely(!is_enabled()))
> +		return false;
> +
> +	watchpoint = find_watchpoint((unsigned long)ptr, size, !is_write,
> +				     &encoded_watchpoint);
> +	if (watchpoint == NULL)
> +		return true;
> +
> +	flags = user_access_save();

Could use a comment on why find_watchpoint() is save to call without
user_access_save() on.

> +	if (!try_consume_watchpoint(watchpoint, encoded_watchpoint)) {
> +		/*
> +		 * The other thread may not print any diagnostics, as it has
> +		 * already removed the watchpoint, or another thread consumed
> +		 * the watchpoint before this thread.
> +		 */
> +		kcsan_counter_inc(kcsan_counter_report_races);
> +		report_type = kcsan_report_race_check_race;
> +	} else {
> +		report_type = kcsan_report_race_check;
> +	}
> +
> +	/* Encountered a data-race. */
> +	kcsan_counter_inc(kcsan_counter_data_races);
> +	kcsan_report(ptr, size, is_write, raw_smp_processor_id(), report_type);
> +
> +	user_access_restore(flags);
> +	return false;
> +}
> +EXPORT_SYMBOL(__kcsan_check_watchpoint);
> +
> +void __kcsan_setup_watchpoint(const volatile void *ptr, size_t size,
> +			      bool is_write)
> +{
> +	atomic_long_t *watchpoint;
> +	union {
> +		u8 _1;
> +		u16 _2;
> +		u32 _4;
> +		u64 _8;
> +	} expect_value;
> +	bool is_expected = true;
> +	unsigned long ua_flags = user_access_save();
> +	unsigned long irq_flags;
> +
> +	if (!should_watch(ptr))
> +		goto out;
> +
> +	if (!check_encodable((unsigned long)ptr, size)) {
> +		kcsan_counter_inc(kcsan_counter_unencodable_accesses);
> +		goto out;
> +	}
> +
> +	/*
> +	 * Disable interrupts & preemptions, to ignore races due to accesses in
> +	 * threads running on the same CPU.
> +	 */
> +	local_irq_save(irq_flags);
> +	preempt_disable();

Is there a point to that preempt_disable() here?
