Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4051F48F386
	for <lists+linux-arch@lfdr.de>; Sat, 15 Jan 2022 01:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiAOAmK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Jan 2022 19:42:10 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56766 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiAOAmK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Jan 2022 19:42:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22135620B1;
        Sat, 15 Jan 2022 00:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC7CC36AE7;
        Sat, 15 Jan 2022 00:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642207329;
        bh=RFdd/d/h9ZEjW1WZXJI2ulzeQRya7tL/XKx/GmIbLQg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HGKxtIKYShk97LVY70gcDHbbSgJqrTKiTt7051VATJzlcOCGUmSQ7/J5QkoAEJV1v
         KbOIcLWDZSTeoqZrfk/6IS+haPjUjHUyiPyAl4bqdIGp9RIlNHnsql+/V4K9pfVvzl
         IpWprY2ZdQ4f+MtWBwPV5/4jUtZ1p0B/9yS/NGlD82AdjDzTkiA+uQXln+P/liQSGX
         NEVBMwTLUicmGm0420K3QgmTgsVgJhnI009vTH9cULqkZKcD18dVScgj5OsmnDJ6D3
         qHn76+Ydx05Bl5q4+MTytVzNCfbR8dpS9Qsi8JXH8ldGItlkWe8zAGRnAIVBJjOuBm
         UDq9YmoKVfyDA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1BE385C0373; Fri, 14 Jan 2022 16:42:09 -0800 (PST)
Date:   Fri, 14 Jan 2022 16:42:09 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0000/2297] [ANNOUNCE, RFC] "Fast Kernel Headers" Tree
 -v1: Eliminate the Linux kernel's "Dependency Hell"
Message-ID: <20220115004209.GA985568@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YdIfz+LMewetSaEB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdIfz+LMewetSaEB@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jan 02, 2022 at 10:57:35PM +0100, Ingo Molnar wrote:
> 
> I'm pleased to announce the first public version of my new "Fast Kernel 
> Headers" project that I've been working on since late 2020, which is a 
> comprehensive rework of the Linux kernel's header hierarchy & header 
> dependencies, with the dual goals of:
> 
>  - speeding up the kernel build (both absolute and incremental build times)
> 
>  - decoupling subsystem type & API definitions from each other

Yow!!!  ;-)

[ . . . ]

>       headers/uninline: Uninline multi-use function: finish_rcuwait()

This one looks fine on its own merits, so I grabbed it from your git tree:

ecdadb5289d1 ("headers/uninline: Uninline multi-use function: finish_rcuwait()")

>       headers/deps: RCU: Remove __read_mostly annotations from externs

And same with this one:

1c8af2245fd7 ("headers/deps: RCU: Remove __read_mostly annotations from externs")


Of course, if you would rather keep these, please let me know and I will
drop them.

							Thanx, Paul
