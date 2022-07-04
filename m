Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9084C5657A4
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jul 2022 15:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbiGDNq1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jul 2022 09:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbiGDNqX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jul 2022 09:46:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB86F2711;
        Mon,  4 Jul 2022 06:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9KSp83B2HRrIjEIK0/a7lJrmsuqlIZtZe0Q7lj9gHs0=; b=BczO17nwDoPRhpsSqmE5BjhON5
        j1HdkyxD9RPWKjGJVu9nYzRaWyNXM7qbeNkCN+/rnKhIh9PdgnCuQy0gr5nxnWzptHVlAZIw7TmqD
        7SKZ8bMcE6pF6hUT4+YfcUCViaEcC6COLv/Ntix+CAKrRyCnpinxt1oE5rHoyuwfSO2AKZzqTQ1nz
        Krq1OjAcT9PuPtP8IHydQPkuz3xJPsGT7mbXLpS7onmLH/+Fwy1EmCc4HwpfwbrEzh26WDdrZBMvU
        BzeH9k1ThpeVQ/81iT9jvyGZlkraWcdW7eOKkB2KDF9IRFJ7uYpCSmDpVi+rbvLMIJQdpVtK58F6Y
        CNK6cIuw==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8MOc-00H97I-4c; Mon, 04 Jul 2022 13:45:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2F4FD30033D;
        Mon,  4 Jul 2022 15:45:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1947D20294871; Mon,  4 Jul 2022 15:45:48 +0200 (CEST)
Date:   Mon, 4 Jul 2022 15:45:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V7 4/5] asm-generic: spinlock: Add combo spinlock (ticket
 & queued)
Message-ID: <YsLvDHYlLgmfzP4n@hirez.programming.kicks-ass.net>
References: <20220628081707.1997728-1-guoren@kernel.org>
 <20220628081707.1997728-5-guoren@kernel.org>
 <YsK5o8eiVHeS+7Iw@hirez.programming.kicks-ass.net>
 <CAJF2gTQ0cmGJHPR=TzeDJDigiEgBL5-KabbR2WkS=dGJV7jSJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTQ0cmGJHPR=TzeDJDigiEgBL5-KabbR2WkS=dGJV7jSJA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 04, 2022 at 09:13:40PM +0800, Guo Ren wrote:

> > Urggghhhh....
> >
> > I really don't think you want this in generic code. Also, I'm thinking
> > any arch that does this wants to make sure it doesn't inline any of this
> Your advice is the same with Arnd, I would move static_branch out of generic.
> 
> > stuff. That is, said arch must not have ARCH_INLINE_SPIN_*
> What do you mean? I've tested with ARCH_INLINE_SPIN_* and it's okay
> with EXPORT_SYMBOL(use_qspinlock_key).

Well, with the static_branch and the two paths I just don't see the code
being sane/small enough to inline. I mean, sure, you can force it to
inline the thing, but I'm not sure that's wise.
