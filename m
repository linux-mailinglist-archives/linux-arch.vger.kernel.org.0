Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C205339B836
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 13:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhFDLqb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 07:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbhFDLqa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 07:46:30 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89727C061761;
        Fri,  4 Jun 2021 04:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=639Vdy1X754oCgt0uLxPjt9dKAAacPG5P66VaaXaEgs=; b=HIqZHROBdzKVIUmAgmUduxDQs/
        K2WJt2cHsgp4jIIUOsq1m8mHquBTjH4z/6oRXmuzOqSVf63zxSzTszR82Dp1Nl/p7nmqtIhwthVqB
        9zEyKR4N+WeahZzzBPCPQGEucC5Dhcf6jC1LaRdg36v6RrmUNxjzNLKB0NYVgcbJX/lqPJtGVkMnH
        wGWOxFWaQJ78YJ+atbSkUkyD4sfAGBwNL7PxdLQ1Tq9uNa059WQt1mJuCZS3e8V8WuiPVBq4S4RcL
        pIAAxf4cWQ/1DjYWRaONPD2gK3j4n8vs02huqigpSZkDeHgMNpYyOYeTyCKSLhMxkbN50XgbWX0ej
        iAqzXDYw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lp8Fa-003QQD-V8; Fri, 04 Jun 2021 11:44:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4186830018A;
        Fri,  4 Jun 2021 13:44:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 263D82C8F28F2; Fri,  4 Jun 2021 13:44:37 +0200 (CEST)
Date:   Fri, 4 Jun 2021 13:44:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>, will@kernel.org,
        paulmck@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <YLoSJaOVbzKXU4/7@hirez.programming.kicks-ass.net>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 12:12:07PM +0200, Peter Zijlstra wrote:
> +/**
> + * volatile_if() - Provide a control-dependency
> + *
> + * volatile_if(READ_ONCE(A))
> + *	WRITE_ONCE(B, 1);
> + *
> + * will ensure that the STORE to B happens after the LOAD of A. Normally a
> + * control dependency relies on a conditional branch having a data dependency
> + * on the LOAD and an architecture's inability to speculate STOREs. IOW, this
> + * provides a LOAD->STORE order.
> + *
> + * Due to optimizing compilers extra care is needed; as per the example above
> + * the LOAD must be 'volatile' qualified in order to ensure the compiler
> + * actually emits the load, such that the data-dependency to the conditional
> + * branch can be formed.
> + *
> + * Secondly, the compiler must be prohibited from lifting anything out of the
> + * selection statement, as this would obviously also break the ordering.
> + *
> + * Thirdly, and this is the tricky bit, architectures that allow the
> + * LOAD->STORE reorder must ensure the compiler actually emits the conditional
> + * branch instruction, this isn't possible in generic.
> + *
> + * See the volatile_cond() wrapper.
> + */
> +#define volatile_if(cond) if (volatile_cond(cond))

On naming (sorry Paul for forgetting that in the initial mail); while I
think using the volatile qualifier for the language feature (can we haz
plz, kthxbai) makes perfect sense, Paul felt that we might use a
'better' name for the kernel use, ctrl_dep_if() was proposed.

Let us pain bike sheds :-)
