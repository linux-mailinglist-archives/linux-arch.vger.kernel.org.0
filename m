Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A584C2C6AA7
	for <lists+linux-arch@lfdr.de>; Fri, 27 Nov 2020 18:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732293AbgK0Rcc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Nov 2020 12:32:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:60230 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730603AbgK0Rcc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Nov 2020 12:32:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A5E57ABD7;
        Fri, 27 Nov 2020 17:32:30 +0000 (UTC)
Date:   Fri, 27 Nov 2020 18:32:29 +0100
From:   Borislav Petkov <bp@suse.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
        x86@kernel.org, len.brown@intel.com, dave.hansen@intel.com,
        hjl.tools@gmail.com, Dave.Martin@arm.com, mpe@ellerman.id.au,
        tony.luck@intel.com, ravi.v.shankar@intel.com,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/4] selftest/x86/signal: Include test cases for
 validating sigaltstack
Message-ID: <20201127173229.GA13262@zn.tnic>
References: <20201119190237.626-1-chang.seok.bae@intel.com>
 <20201119190237.626-5-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201119190237.626-5-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 19, 2020 at 11:02:37AM -0800, Chang S. Bae wrote:
> +static void test_sigaltstack(void *altstack, unsigned long size)
> +{
> +	if (setup_altstack(altstack, size))
> +		err(1, "sigaltstack()");
> +
> +	sigalrm_expected = (size > at_minstack_size) ? true : false;
> +
> +	sethandler(SIGSEGV, sigsegv, 0);
> +	sethandler(SIGALRM, sigalrm, SA_ONSTACK);
> +
> +	if (sigsetjmp(jmpbuf, 1) == 0) {
> +		printf("[RUN]\tTest an %s sigaltstack\n",

[RUN]   Test an enough sigaltstack

That's not english, pls try again.

[OK]    SIGALRM signal expectedly delivered.

What is "expectedly delivered"?

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
