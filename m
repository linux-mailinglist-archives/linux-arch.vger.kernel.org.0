Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5356539BA5F
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 15:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhFDN6T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 09:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbhFDN6S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 09:58:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11C9C061766;
        Fri,  4 Jun 2021 06:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p2it8iU4IhWDCY+3EQSjjfyGut5JOmcEhUIXviK/n3k=; b=qQTLkIxNvR3Emw9Pz4RmpsWpjk
        W6nmCpKAME3Vyn3zDadnRQfGJ5+aLYvHB/tB2uyV1TIUJIGxEepbKha/lrib/J56w+qFXfHKHK9X4
        N/BmR6/it7mzeColYEcbtM9+a90+7MjlYM4UFY8HmxZP+iO7EFTsof9cG2Ji/vpMYZGHfGwqII+nS
        gGKYae1reeXvMrCPPsDZZPjUB2YZFqGBsqi0CYfXJnGPOkSqLBBwdoc66P3+qhwcuaa9/PMdldCVQ
        7lQmCBdKaCCOzAJk92wLSOZML1AfIODX7DzE7apVgO5MLWY9+hNAkD80/gNzDcimbLzXPDNqDE3sK
        Sc6RoYbQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpAJ2-003S7E-7t; Fri, 04 Jun 2021 13:56:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 064F4300091;
        Fri,  4 Jun 2021 15:56:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DF2C32CCC78BB; Fri,  4 Jun 2021 15:56:16 +0200 (CEST)
Date:   Fri, 4 Jun 2021 15:56:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, paulmck@kernel.org,
        stern@rowland.harvard.edu, parri.andrea@gmail.com,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <YLoxAOua/qsZXNmY@hirez.programming.kicks-ass.net>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
 <20210604104359.GE2318@willie-the-truck>
 <YLoPJDzlTsvpjFWt@hirez.programming.kicks-ass.net>
 <20210604134422.GA2793@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604134422.GA2793@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 02:44:22PM +0100, Will Deacon wrote:
> On Fri, Jun 04, 2021 at 01:31:48PM +0200, Peter Zijlstra wrote:
> > On Fri, Jun 04, 2021 at 11:44:00AM +0100, Will Deacon wrote:
> > > On Fri, Jun 04, 2021 at 12:12:07PM +0200, Peter Zijlstra wrote:
> > 
> > > > Usage of volatile_if requires the @cond to be headed by a volatile load
> > > > (READ_ONCE() / atomic_read() etc..) such that the compiler is forced to
> > > > emit the load and the branch emitted will have the required
> > > > data-dependency. Furthermore, volatile_if() is a compiler barrier, which
> > > > should prohibit the compiler from lifting anything out of the selection
> > > > statement.
> > > 
> > > When building with LTO on arm64, we already upgrade READ_ONCE() to an RCpc
> > > acquire. In this case, it would be really good to avoid having the dummy
> > > conditional branch somehow, but I can't see a good way to achieve that.
> > 
> > #ifdef CONFIG_LTO
> > /* Because __READ_ONCE() is load-acquire */
> > #define volatile_cond(cond)	(cond)
> > #else
> > ....
> > #endif
> > 
> > Doesn't work? Bit naf, but I'm thinking it ought to do.
> 
> The problem is with relaxed atomic RMWs; we don't upgrade those to acquire
> atm as they're written in asm, but we'd need volatile_cond() to work with
> them. It's a shame, because we only have RCsc RMWs on arm64, so it would
> be a bit more expensive.

Urgh, I see. Compiler can't really help in that case either I'm afraid.
They'll never want to modify loads that originate in an asm(). They'll
say to use the C11 _Atomic crud.
