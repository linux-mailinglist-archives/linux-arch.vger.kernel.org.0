Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F674F82B6
	for <lists+linux-arch@lfdr.de>; Thu,  7 Apr 2022 17:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241711AbiDGPYj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Apr 2022 11:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344585AbiDGPYe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Apr 2022 11:24:34 -0400
X-Greylist: delayed 602 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Apr 2022 08:22:30 PDT
Received: from mailout2.rbg.tum.de (mailout2.rbg.tum.de [IPv6:2a09:80c0::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C204E20C1A5;
        Thu,  7 Apr 2022 08:22:30 -0700 (PDT)
Received: from mailrelay1.rbg.tum.de (mailrelay1.in.tum.de [IPv6:2a09:80c0:254::14])
        by mailout2.rbg.tum.de (Postfix) with ESMTPS id 912AB4C0234;
        Thu,  7 Apr 2022 17:12:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.tum.de;
        s=20220209; t=1649344344;
        bh=Yda2j6lrq6q/8Qr9IDcdSxoBwSuVmTqIZ8v84YOihVo=;
        h=Date:From:To:Cc:Subject:From;
        b=TJgGnxlrKn8w/dTVJabinCWu1YmEkCvUpZAU6BV90HfAEYs22cvbp1/htmgqBGhbL
         PkKQZpacG0Z9yoSTt5pz/mxO6ykFwvj0wZDIz2cWyhNACgdbpnKhicDJkzj63tAKy2
         3ZuX7wM8Azckyzg31tuX6amKQ8dRZCsa2RfCYWqs+Lintbih9xgxxyRkyXlR5ImnUv
         /XxlXZwh5HYdgVk6wOOBsUqSuGJM2ma97tQjavRixV4YTCNjKjD/nmj5zIkgKnfX6D
         YFa4bh/mNtvr+Zsf6+Wj4d/9fDhJFOJ4z3INYB64mQ/xQWOOMyCRcde9S4WEfJ67VE
         DgPfsPQLGvzVA==
Received: by mailrelay1.rbg.tum.de (Postfix, from userid 112)
        id 8CEDA254; Thu,  7 Apr 2022 17:12:24 +0200 (CEST)
Received: from mailrelay1.rbg.tum.de (localhost [127.0.0.1])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTP id 5FBA3252;
        Thu,  7 Apr 2022 17:12:24 +0200 (CEST)
Received: from mail.in.tum.de (mailproxy.in.tum.de [IPv6:2a09:80c0::78])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTPS id 5BD1024E;
        Thu,  7 Apr 2022 17:12:24 +0200 (CEST)
Received: by mail.in.tum.de (Postfix, from userid 112)
        id 3C8BB4A02E4; Thu,  7 Apr 2022 17:12:24 +0200 (CEST)
Received: (Authenticated sender: heidekrp)
        by mail.in.tum.de (Postfix) with ESMTPSA id 847E94A0238;
        Thu,  7 Apr 2022 17:12:20 +0200 (CEST)
        (Extended-Queue-bit xtech_fn@fff.in.tum.de)
Date:   Thu, 7 Apr 2022 17:12:15 +0200
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
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>
Subject: Dangerous addr to ctrl dependency transformation in
 fs/nfs/delegation.c::nfs_server_return_marked_delegations()?
Message-ID: <Yk7/T8BJITwz+Og1@Pauls-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

work on my dependency checker tool is progressing nicely, and it is
flagging, what I believe is, a harmful addr to ctrl dependency
transformation. For context, see [1] and [2]. I'm using the Clang
compiler.

The dependency in question runs from line 618 into the for loop
increment, i.e. the third expresion in the for loop condition, in line
622 of fs/nfs/delegation.c::nfs_server_return_marked_delegations().

I did my best to reverse-engineer some pseudocode from Clang's IR for
showing what I think is going on.

Clang's unoptimised version:

> restart:
> 	if(place_holder != NULL)
> 		delegation = rcu_dereference(place_holder->delegation); /* 618 */
> 	if(delegation != NULL)
> 		if(delegation != place_holder_deleg)
> 			delegation = list_entry_rcu(server->delegations.next, struct nfs_delegation, super_list); /* 620 */
> 
> 	for( ; &(delegation)->super_list != &server->delegations; delegation = list_entry_rcu(delegation->super_list.next, typeof(*(delegation)), super_list)) { /* 622 */
> 		/*
> 		 * Can continue, "goto restart" or "goto break" (after loop). 
> 		 * Can reassign "delegation", "place_holder", "place_holder_deleg".
> 		 * "delegation" might be assigned either a value depending on 
> 		 * "delegation" itself, i.e. it is part of the dependency chain, 
> 		 * or NULL.
> 		 * Can modifiy fields of the "nfs_delegation" struct "delegation" 
> 		 * points to.
> 		 * Assume line 618 has been executed and line 620 hasn't. Then, 
> 		 * there exists a path s.t. "delegation" isn't reassigned NULL 
> 		 * and the for loop's increment is executed.
> 		 */
> 	}

Clang's optimised version:

> restart:
> 	if(place_holder == NULL) {
> 		delegation = list_entry_rcu(server->delegations.next, struct nfs_delegation, super_list);
> 	} else {
> 		cmp = rcu_dereference(place_holder->delegation); /* 618 */
> 		if(cmp != NULL) { /* Transformation to ctrl dep */
> 			if(cmp == place_holder_deleg) {
> 				delegation = place_holder_deleg;
> 			} else {
> 				delegation = list_entry_rcu(server->delegations.nex, struct nfs_delegation, super_list);
> 			}
> 		} else {
> 			delegation = list_entry_rcu(server->delegations.next, struct nfs_delegation, super_list);
> 		}
> 	}
> 
> 	for( ; &(delegation)->super_list != &server->delegations; delegation = list_entry_rcu(delegation->super_list.next, typeof(*(delegation)), super_list)) {
> 		/*
> 		 * At this point, "delegation" cannot depend on line 618 anymore
> 		 * since the "rcu_dereference()" was only used for an assignment
> 		 * to "cmp" and a subsequent comparison (ctrl dependency).
> 		 * Therefore, the loop increment cannot depend on the
> 		 * "rcu_dereference()" either. The dependency chain has been
> 		 * broken.
> 		 */
>         }

The above is an abstraction of the following control flow path in
"nfs_server_return_marked_delegations()":

1. When "nfs_server_return_marked_delegations()" gets called, it has no
choice but to skip the dependency beginning in line 620, since
"place_holder" is NULL the first time round.

2. Now take a path until "place_holder", the condition for the
dependency beginning, becomes true and "!delegation || delegation !=
place_holder_deleg", the condition for the assignment in line 620,
becomes false. Then, enter the loop again and take a path to one of the
"goto restart" statements without reassigning to "delegation".

3. After going back to "restart", since the condition for line 618
became true, "rcu_dereference()" into "delegation".

4. Enter the for loop again, but avoid the "goto restart" statements in
the first iteration and ensure that "&(delegation)->super_list !=
&server->delegations", the loop condition, remains true and "delegation"
isn't assigned NULL.

5. When the for loop condition is reached for the second time, the loop
increment is executed and there is an address dependency.

Now, why would the compiler decide to assign "place_holder_deleg" to
"delegation" instead of what "rcu_dereference()" returned? Here's my
attempt at explaining.

In the pseudo code above, i.e. in the optimised IR, the assignment of
"place_holder_deleg" is guarded by two conditions. It is executed iff
"place_holder" isn't NULL and the "rcu_dereference()" didn't return
NULL. In other words, iff "place_holder != NULL && rcu_dereference() !=
NULL" holds at line 617, then "delegation == rcu_dereference() ==
place_holder_deleg" must hold at line 622. Otherwise, the optimisation
would be wrong.

Assume control flow has just reached the first if, i.e. line 617, in
source code. Since "place_holder" isn't NULL, it will execute the first
if's body and "rcu_dereference()" into "delegation" (618). Now it has
reached the second if. Per our aussmption, "rcu_dereference()" returned
something that wasn't NULL. Therefore, "!delegation", the first part of
the second if condition's OR, will be false.

However, if we want "rcu_dereference() == delegation" to hold after the
two if's, we can't enter the second if anyway, as it will overwrite
"delegation" with a value that might not be equal to what
"rcu_dereference()" returned. So, we want the second part of the second
if condition's OR, i.e.  "delegation != place_holder_deleg" to be false
as well.

When is that the case? It is the case when "delegation ==
place_holder_deleg" holds.

So, if we want "delegation == rcu_dereference() == place_holder_deleg"
to hold after the two if's, "place_holder != NULL && rcu_dereference()
!= NULL" must hold before the two if's, which is what we wanted to show
and what the compiler figured out too.

TL;DR: it appears the compiler optimisation is plausible, yet it still
breaks the address dependency.

For those interested, I have made the unoptimised and optimised IR CFGs
available. In the optimised one, the interesting part is the transition
from "if.end" to "if.end13".

Unoptimised: https://raw.githubusercontent.com/gist/PBHDK/700bf7bdf968fe25c82506de58143bbe/raw/54bf2c1e1a72fb30120f7e812f05ef01ca86b78f/O0-nfs_server_return_marked_delegations.svg

Optimised: https://raw.githubusercontent.com/gist/PBHDK/700bf7bdf968fe25c82506de58143bbe/raw/54bf2c1e1a72fb30120f7e812f05ef01ca86b78f/O2-nfs_server_return_marked_delegations.svg

What do you think?

Many thanks,
Paul

[1]: https://linuxplumbersconf.org/event/7/contributions/821/attachments/598/1075/LPC_2020_--_Dependency_ordering.pdf
[2]: https://lore.kernel.org/llvm/YXknxGFjvaB46d%2Fp@Pauls-MacBook-Pro/T/#u
