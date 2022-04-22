Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7AC50B540
	for <lists+linux-arch@lfdr.de>; Fri, 22 Apr 2022 12:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446652AbiDVKjA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Apr 2022 06:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446631AbiDVKiv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Apr 2022 06:38:51 -0400
Received: from mailout2.rbg.tum.de (mailout2.rbg.tum.de [IPv6:2a09:80c0::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D9354FAD;
        Fri, 22 Apr 2022 03:35:54 -0700 (PDT)
Received: from mailrelay1.rbg.tum.de (mailrelay1.in.tum.de [131.159.254.14])
        by mailout2.rbg.tum.de (Postfix) with ESMTPS id 7C0704C02B0;
        Fri, 22 Apr 2022 12:35:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.tum.de;
        s=20220209; t=1650623749;
        bh=bCNDShSNWamzrapZyCH2+MaOYLPQy3BG0jVzD+WNbD4=;
        h=Date:From:To:Cc:Subject:From;
        b=dT+Zo14Mw3Zm1XxiUb4lp1L+yp/xGGuTBLjGLo5o8N/e9+BZaFpaWXuulYOOhz6Ib
         oKaQ3sSQ9GiWnhU1giBGZwJQyLv9Vw/JKzbWwJ9gEXhuCT9ytBiie1yu2ib53kNJ3y
         aDsCRtWsWp3Y3882MQVZ5hPSYXSOdLwe+rRZIbEGTC8ckRolOWQEBB1O4l3bmLtjEe
         a7FHmnSmgjO2veh/5kLbGHVY7kJEs1CPL+daN7HoJ3DfEr0F2otg/uN3wwYHayQudm
         0UCgCPpAozOgr/clanEiNpP0eUk80HirH/bI5BSGD1xUqeFWuIcD7rXeBtIudnzkfp
         57ZbauIKayR0Q==
Received: by mailrelay1.rbg.tum.de (Postfix, from userid 112)
        id 763FE6D8; Fri, 22 Apr 2022 12:35:49 +0200 (CEST)
Received: from mailrelay1.rbg.tum.de (localhost [127.0.0.1])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTP id 41EF06D7;
        Fri, 22 Apr 2022 12:35:49 +0200 (CEST)
Received: from mail.in.tum.de (vmrbg426.in.tum.de [131.159.0.73])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTPS id 3CF2D55F;
        Fri, 22 Apr 2022 12:35:49 +0200 (CEST)
Received: by mail.in.tum.de (Postfix, from userid 112)
        id 1AEA74A037C; Fri, 22 Apr 2022 12:35:49 +0200 (CEST)
Received: (Authenticated sender: heidekrp)
        by mail.in.tum.de (Postfix) with ESMTPSA id 496B74A01EC;
        Fri, 22 Apr 2022 12:35:48 +0200 (CEST)
        (Extended-Queue-bit xtech_eq@fff.in.tum.de)
Date:   Fri, 22 Apr 2022 12:35:41 +0200
From:   Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>,
        Soham Shakraborty <s.s.chakraborty@tudelft.nl>,
        Martin Fink <martin.fink@in.tum.de>
Subject: Broken Address Dependency in mm/ksm.c::cmp_and_merge_page()
Message-ID: <YmKE/XgmRnGKrBbB@Pauls-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all, 

My dependency checker is flagging yet another broken dependency. For
context, see [1].

Thankfully, it is fairly straight-forward to explain this time.

> stable_node = page_stable_node(page);

Line 2032 in mm/ksm.c::cmp_and_merge_page() sees the return value of a
call to "page_stable_node()", which can depend on a "READ_ONCE()", being
assigned to "stable_node".

> if (stable_node) {
>         if (stable_node->head != &migrate_nodes &&
>             get_kpfn_nid(READ_ONCE(stable_node->kpfn)) != 
>             NUMA(stable_node->nid)) {
>                 stable_node_dup_del(stable_node); ‣dup: stable_node
>                 stable_node->head = &migrate_nodes;
>                 list_add(&stable_node->list, stable_node->head);

The dependency chain then runs into the two following if's, through an
assignment of "migrate_nodes" to "stable_node->head" (line 2038) and
finally reaches a call to "list_add()" (line 2039) where
"stable_node->head" gets passed as the second function argument. 

>         }
> }
> 
> static inline void list_add(struct list_head *new, struct list_head *head)
> {
>         __list_add(new, head, head->next);
> }
> 
> static inline void __list_add(struct list_head *new,
>                               struct list_head *prev,
>                               struct list_head *next)
> {
>         if (!__list_add_valid(new, prev, next))
>                 return;
> 
>         next->prev = new;
>         new->next = next;
>         new->prev = prev;
>         WRITE_ONCE(prev->next, new);
> }

By being passed into "list_add()" via "stable_node->head", the
dependency chain eventually reaches a "WRITE_ONCE()" in "__list_add()"
whose destination address, "stable_node->head->next", is part of the
dependency chain and therefore carries an address dependency. 

However, as a result of the assignment in line 2038, Clang knows that
"stable_node->head" is "migrate_nodes" and replaces it, thereby breaking
the dependency chain. 

What do you think?

Many thanks,
Paul

--
[1]: https://lore.kernel.org/all/Yk7%2FT8BJITwz+Og1@Pauls-MacBook-Pro.local/

