Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F2572AE8F
	for <lists+linux-arch@lfdr.de>; Sat, 10 Jun 2023 22:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjFJUJt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 10 Jun 2023 16:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjFJUJs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Jun 2023 16:09:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F047C3598;
        Sat, 10 Jun 2023 13:09:46 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686427785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VN3pKad915lgXyIEKLmAqU9HFdxhV2U8JR5HtaJJWAo=;
        b=ZJPuUMqPysjPBQOtwRD8hr8P3yWoBfFxIFRfQbmUhqrHISkVZgbVnK1l0yUcMF13n0ef88
        A2mJqnviZJYpqgkQxY2B/Iddyx7txFX0h7NoqsWvq/aS5ZDorHIECmwNtSrRXy99v55CFX
        vZk43IJuf1X9d6CQLl075CFuu5/Oys6EwYSawzk0iZamSVUjy9LANvOHsSKUag4l5ZR9nR
        Q3HlMi8k3dy1cxqrx9MNhyByLxphQeKZcd+bAxaElUyTvpVkQJS4oaIFSPIPWBwG7gb0HL
        AChWt/fe3Tma07iCZKUYsldPKXecOY2zpmpzjEFW0m1Ll51NyD0YY7gKE/Zb1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686427785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VN3pKad915lgXyIEKLmAqU9HFdxhV2U8JR5HtaJJWAo=;
        b=qeRl1VvSqXcJA/dkR81UjTvbzFNl35KrBMfEEJ9dLP6GgKhRJYWyergbo9UAvaIL3/t4PF
        efaD08GmnCbVq0CA==
To:     Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        ldufour@linux.ibm.com, bp@alien8.de, dave.hansen@linux.intel.com,
        mingo@redhat.com, x86@kernel.org
Subject: Re: [PATCH 6/9] cpu/SMT: Allow enabling partial SMT states via sysfs
In-Reply-To: <20230524155630.794584-6-mpe@ellerman.id.au>
References: <20230524155630.794584-1-mpe@ellerman.id.au>
 <20230524155630.794584-6-mpe@ellerman.id.au>
Date:   Sat, 10 Jun 2023 22:09:44 +0200
Message-ID: <87r0qj84fr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 25 2023 at 01:56, Michael Ellerman wrote:
> There is a hook which allows arch code to control how many threads per

Can you please write out architecture in changelogs and comments?

I know 'arch' is commonly used but while my brain parser tolerates
'arch_' prefixes it raises an exception on 'arch' in prose as 'arch' is
a regular word with a completely different meaning. Changelogs and
comments are not space constraint.

> @@ -2505,20 +2505,38 @@ __store_smt_control(struct device *dev, struct device_attribute *attr,
>  	if (cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
>  		return -ENODEV;
>  
> -	if (sysfs_streq(buf, "on"))
> +	if (sysfs_streq(buf, "on")) {
>  		ctrlval = CPU_SMT_ENABLED;
> -	else if (sysfs_streq(buf, "off"))
> +		num_threads = cpu_smt_max_threads;
> +	} else if (sysfs_streq(buf, "off")) {
>  		ctrlval = CPU_SMT_DISABLED;
> -	else if (sysfs_streq(buf, "forceoff"))
> +		num_threads = 1;
> +	} else if (sysfs_streq(buf, "forceoff")) {
>  		ctrlval = CPU_SMT_FORCE_DISABLED;
> -	else
> +		num_threads = 1;
> +	} else if (kstrtoint(buf, 10, &num_threads) == 0) {
> +		if (num_threads == 1)
> +			ctrlval = CPU_SMT_DISABLED;
> +		else if (num_threads > 1 && topology_smt_threads_supported(num_threads))
> +			ctrlval = CPU_SMT_ENABLED;
> +		else
> +			return -EINVAL;
> +	} else {
>  		return -EINVAL;
> +	}
>  
>  	ret = lock_device_hotplug_sysfs();
>  	if (ret)
>  		return ret;
>  
> -	if (ctrlval != cpu_smt_control) {
> +	orig_threads = cpu_smt_num_threads;
> +	cpu_smt_num_threads = num_threads;
> +
> +	if (num_threads > orig_threads) {
> +		ret = cpuhp_smt_enable();
> +	} else if (num_threads < orig_threads) {
> +		ret = cpuhp_smt_disable(ctrlval);
> +	} else if (ctrlval != cpu_smt_control) {
>  		switch (ctrlval) {
>  		case CPU_SMT_ENABLED:
>  			ret = cpuhp_smt_enable();

This switch case does not make sense anymore.

The only situation which reaches this is when the control value goes
from CPU_SMT_DISABLED to CPU_SMT_FORCE_DISABLED because that's not
changing the number of threads.

So something like this is completely sufficient:

	if (num_threads > orig_threads)
		ret = cpuhp_smt_enable();
        else if (num_threads < orig_threads || ctrval == CPU_SMT_FORCE_DISABLED)
		ret = cpuhp_smt_disable(ctrlval);

No?

Thanks,

        tglx
