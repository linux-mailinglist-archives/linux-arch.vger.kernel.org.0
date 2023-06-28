Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560C5740F59
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jun 2023 12:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjF1Kxn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jun 2023 06:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjF1Kxc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jun 2023 06:53:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4C48F;
        Wed, 28 Jun 2023 03:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3D0zkVphuK2SF+WTuA1GlLTLg0tSaGa1VzB0TRXOtHM=; b=Eyo0jXC+yZimEt3nWG+saiaJ+z
        pYrPTC8SzJdJoaw4RJQiFtynXIixHA02Ml1V5fMo6jR0qUUzE2zHOOOWtvTkFTnccHwvF44jT8Ahq
        6TLP7uuNlK5Gyf0S0c44WMYb2jhM7+fOjFNA9ybG/hJ0bpL8RlkhtnVTLlan+3nFUK/sn69f1uQGJ
        F2eMVT47vRJ7rmFT8EVlgjqMcu2nF4krrZeGqINsGQDqTvWiR11t5UOe2UjNI7KexcSTlvbDdDihv
        eytYP/jqcCEnMrSgMf041BbxfP3JZSnA5QEct/8qRisKMlGlpuEppQEbtRdrJu14yCWACHEoDSjQS
        DSELVNLg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qESnT-003i8K-4X; Wed, 28 Jun 2023 10:53:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 652BB3002C5;
        Wed, 28 Jun 2023 12:53:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3FB52247FBAAB; Wed, 28 Jun 2023 12:53:14 +0200 (CEST)
Date:   Wed, 28 Jun 2023 12:53:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tianyu Lan <ltykernel@gmail.com>, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, daniel.lezcano@linaro.org,
        arnd@arndb.de, michael.h.kelley@microsoft.com,
        Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: Re: [EXTERNAL] Re: [PATCH 5/9] x86/hyperv: Use vmmcall to implement
 Hyper-V hypercall in sev-snp enlightened guest
Message-ID: <20230628105314.GB2439977@hirez.programming.kicks-ass.net>
References: <20230601151624.1757616-1-ltykernel@gmail.com>
 <20230601151624.1757616-6-ltykernel@gmail.com>
 <20230608132127.GK998233@hirez.programming.kicks-ass.net>
 <8b93aa93-903f-3a69-77f9-0c6b694d826b@gmail.com>
 <d06bb33e-047f-c849-de6a-246bc361c7af@gmail.com>
 <20230627115002.GW83892@hirez.programming.kicks-ass.net>
 <20230627120502.GFZJrQbgSgOhj/44pW@fat_crate.local>
 <20230627133834.GA2412070@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627133834.GA2412070@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 27, 2023 at 03:38:35PM +0200, Peter Zijlstra wrote:

> That said; there is a tiny difference between:
> 
> ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2, flag2)
> 
> and
> 
> ALTERNATIVE(ALTERNATIVE(oldinst, newinst1, flag1),
> 	    newinst2, flag2)
> 
> and that is alt_instr::instrlen, when the inner alternative is the
> smaller, then the outer alternative will add additional padding that the
> inner (obviously) doesn't know about.

New version:

https://lkml.kernel.org/r/20230628104952.GA2439977%40hirez.programming.kicks-ass.net
