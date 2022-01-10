Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2851489654
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jan 2022 11:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243902AbiAJK2a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jan 2022 05:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239431AbiAJK21 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jan 2022 05:28:27 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77ADC06173F;
        Mon, 10 Jan 2022 02:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5ujuOQpALmWNb+JnVkNXks4oy9Vot+hJ1tVe7cai2Bo=; b=RgJAIg7QuUrS4CP360xltXYM/5
        xP3V5zg+ztj1yY2vUCPu6g19KHW5lfiS0Pz/I+9EmlA5uMzORzL+eruuQh44UGXWT1fiCgP7nl1Ov
        BzUOATcv42sXj1wuQ/nYPU30iLVzhAP27Pnj2QSU1lN+TFtJbraBYeodIHZg961mbkRHorL6wJ01P
        IQ4IGFbppwBiP+x5tClglrj90RmSK43pkt1JemvPtb7rXc8k09gntq3o5Q4ISwhcW5zmDR+ZPQRn6
        bPXbI9w8SLCiMQduYaisxsrzFWezgqVxFDcYNQcST+TUJ8Pk5X5hbH4YLstUYxHUBb3+zKWd0gKlu
        z/zDfy9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6ruG-000Nph-Gd; Mon, 10 Jan 2022 10:28:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 23C43300237;
        Mon, 10 Jan 2022 11:28:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BE06020195520; Mon, 10 Jan 2022 11:28:01 +0100 (CET)
Date:   Mon, 10 Jan 2022 11:28:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0000/2297] [ANNOUNCE, RFC] "Fast Kernel Headers" Tree
 -v1: Eliminate the Linux kernel's "Dependency Hell"
Message-ID: <YdwKMfNkB7P1tm/m@hirez.programming.kicks-ass.net>
References: <YdIfz+LMewetSaEB@gmail.com>
 <YdLL0kaFhm6rp9NS@kroah.com>
 <YdLaMvaM9vq4W6f1@gmail.com>
 <YdL+IwQGTLFQyVz2@kroah.com>
 <YdMkTjGSQFLEV5VB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdMkTjGSQFLEV5VB@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 03, 2022 at 05:29:02PM +0100, Ingo Molnar wrote:
> Yeah, so I *did* find this somewhat suboptimal too, and developed an 
> earlier version that used linker section tricks to gain the field offsets 
> more automatically.
> 
> It was an unmitigated disaster: was fragile on x86 already (which has a zoo 
> of linking quirks with no precedent of doing this before bounds.c 
> processing), but on ARM64 and probably on most of the other RISC-ish 
> architectures there was also a real runtime code generation cost of using 
> linker tricks: 2-3 extra instructions per per_task() use - clearly 
> unacceptable.
> 
> Found this out the hard way after making it boot & work on ARM64 and 
> looking at the assembly output, trying to figure out why the generated code 
> size increased. :-/

Right, I suggested you do the per-cpu thing. And then Mark reported that
code-gen issue on arm64.

I'm still thinking the toolchains ought to look at fixing that. It'll be
too late to use for per-task, but at least the current per-cpu usages
will (eventually) get better code-gen.


