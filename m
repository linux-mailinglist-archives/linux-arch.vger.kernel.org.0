Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13105502BA8
	for <lists+linux-arch@lfdr.de>; Fri, 15 Apr 2022 16:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349701AbiDOOWX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Apr 2022 10:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiDOOWV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Apr 2022 10:22:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FCD2E9FC;
        Fri, 15 Apr 2022 07:19:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3AB85B82E4F;
        Fri, 15 Apr 2022 14:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F6BC385A9;
        Fri, 15 Apr 2022 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650032388;
        bh=PnzKnVm/gknku93o5/D+LhE3lbAawiE5lgc06fqsmzU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=P2+a/UaCyoabpbJawE16NNL2G/au1uOpU0zZY74BzEEcmE7XMKDF12Bc9uGEnKQ83
         t4UteRHXUG0n7++RupUFl7k1PkJdxaKqoUOAHk2L2rqc+qBCO7rJGKfxphiMF7BsDH
         6GdKAV5Q8rziMl35w+mQixu+yl/IkeeIQzVxmPaea8YqmSgb6AWBNSAmEB2RfBpu1E
         9XmMM5qXPtCrN0vel5q1iqHpEVpF86xCI4yzH4nzp7EAqFnUpv8dkQtrMpDebF7bTb
         e1W5QhfE+yShYW1ZpevEBfh4X10+5RUkqxLRKIMHQ5Pb7mXdpGkT5Zq7fzf9jcEK6n
         O1emJWfNgwPag==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6BC2A5C034B; Fri, 15 Apr 2022 07:19:48 -0700 (PDT)
Date:   Fri, 15 Apr 2022 07:19:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        llvm@lists.linux.dev, Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>
Subject: Re: Dangerous addr to ctrl dependency transformation in
 fs/nfs/delegation.c::nfs_server_return_marked_delegations()?
Message-ID: <20220415141948.GH4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Yk7/T8BJITwz+Og1@Pauls-MacBook-Pro.local>
 <20220411182141.GZ4285@paulmck-ThinkPad-P17-Gen-1>
 <YlV1D2RmZgx/PJn5@Pauls-MacBook-Pro.local>
 <20220412152649.GF4285@paulmck-ThinkPad-P17-Gen-1>
 <Ylfjqk0a6rAiIIB8@Pauls-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ylfjqk0a6rAiIIB8@Pauls-MacBook-Pro.local>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 14, 2022 at 11:04:42AM +0200, Paul Heidekrüger wrote:
> On Tue, Apr 12, 2022 at 08:26:49AM -0700, Paul E. McKenney wrote:
> > On Tue, Apr 12, 2022 at 02:48:15PM +0200, Paul Heidekrüger wrote:
> > > On Mon, Apr 11, 2022 at 11:21:41AM -0700, Paul E. McKenney wrote:
> > > > On Thu, Apr 07, 2022 at 05:12:15PM +0200, Paul Heidekrüger wrote:
> > > > > Hi all,
> > > > > 
> > > > > work on my dependency checker tool is progressing nicely, and it is
> > > > > flagging, what I believe is, a harmful addr to ctrl dependency
> > > > > transformation. For context, see [1] and [2]. I'm using the Clang
> > > > > compiler.
> > > > > 
> > > > > The dependency in question runs from line 618 into the for loop
> > > > > increment, i.e. the third expresion in the for loop condition, in line
> > > > > 622 of fs/nfs/delegation.c::nfs_server_return_marked_delegations().
> > > > > 
> > > > > I did my best to reverse-engineer some pseudocode from Clang's IR for
> > > > > showing what I think is going on.
> > > > 
> > > > First, thank you very much for doing this work!
> > > > 
> > > > > Clang's unoptimised version:
> > > > > 
> > > > > > restart:
> > > > > > 	if(place_holder != NULL)
> > > > > > 		delegation = rcu_dereference(place_holder->delegation); /* 618 */
> > > > > > 	if(delegation != NULL)
> > > > > > 		if(delegation != place_holder_deleg)
> > > > > > 			delegation = list_entry_rcu(server->delegations.next, struct nfs_delegation, super_list); /* 620 */
> > > > > > 
> > > > > > 	for( ; &(delegation)->super_list != &server->delegations; delegation = list_entry_rcu(delegation->super_list.next, typeof(*(delegation)), super_list)) { /* 622 */
> > > > > > 		/*
> > > > > > 		 * Can continue, "goto restart" or "goto break" (after loop). 
> > > > > > 		 * Can reassign "delegation", "place_holder", "place_holder_deleg".
> > > > > > 		 * "delegation" might be assigned either a value depending on 
> > > > > > 		 * "delegation" itself, i.e. it is part of the dependency chain, 
> > > > > > 		 * or NULL.
> > > > > > 		 * Can modifiy fields of the "nfs_delegation" struct "delegation" 
> > > > > > 		 * points to.
> > > > > > 		 * Assume line 618 has been executed and line 620 hasn't. Then, 
> > > > > > 		 * there exists a path s.t. "delegation" isn't reassigned NULL 
> > > > > > 		 * and the for loop's increment is executed.
> > > > > > 		 */
> > > > > > 	}
> > > > > 
> > > > > Clang's optimised version:
> > > > > 
> > > > > > restart:
> > > > > > 	if(place_holder == NULL) {
> > > > > > 		delegation = list_entry_rcu(server->delegations.next, struct nfs_delegation, super_list);
> > > > > > 	} else {
> > > > > > 		cmp = rcu_dereference(place_holder->delegation); /* 618 */
> > > > > > 		if(cmp != NULL) { /* Transformation to ctrl dep */
> > > > > > 			if(cmp == place_holder_deleg) {
> > > > > > 				delegation = place_holder_deleg;
> > > > > > 			} else {
> > > > > > 				delegation = list_entry_rcu(server->delegations.nex, struct nfs_delegation, super_list);
> > > > > > 			}
> > > > > > 		} else {
> > > > > > 			delegation = list_entry_rcu(server->delegations.next, struct nfs_delegation, super_list);
> > > > > > 		}
> > > > > > 	}
> > > > > > 
> > > > > > 	for( ; &(delegation)->super_list != &server->delegations; delegation = list_entry_rcu(delegation->super_list.next, typeof(*(delegation)), super_list)) {
> > > > > > 		/*
> > > > > > 		 * At this point, "delegation" cannot depend on line 618 anymore
> > > > > > 		 * since the "rcu_dereference()" was only used for an assignment
> > > > > > 		 * to "cmp" and a subsequent comparison (ctrl dependency).
> > > > > > 		 * Therefore, the loop increment cannot depend on the
> > > > > > 		 * "rcu_dereference()" either. The dependency chain has been
> > > > > > 		 * broken.
> > > > > > 		 */
> > > > > >         }
> > > > > 
> > > > > The above is an abstraction of the following control flow path in
> > > > > "nfs_server_return_marked_delegations()":
> > > > > 
> > > > > 1. When "nfs_server_return_marked_delegations()" gets called, it has no
> > > > > choice but to skip the dependency beginning in line 620, since
> > > > > "place_holder" is NULL the first time round.
> > > > > 
> > > > > 2. Now take a path until "place_holder", the condition for the
> > > > > dependency beginning, becomes true and "!delegation || delegation !=
> > > > > place_holder_deleg", the condition for the assignment in line 620,
> > > > > becomes false. Then, enter the loop again and take a path to one of the
> > > > > "goto restart" statements without reassigning to "delegation".
> > > > > 
> > > > > 3. After going back to "restart", since the condition for line 618
> > > > > became true, "rcu_dereference()" into "delegation".
> > > > > 
> > > > > 4. Enter the for loop again, but avoid the "goto restart" statements in
> > > > > the first iteration and ensure that "&(delegation)->super_list !=
> > > > > &server->delegations", the loop condition, remains true and "delegation"
> > > > > isn't assigned NULL.
> > > > > 
> > > > > 5. When the for loop condition is reached for the second time, the loop
> > > > > increment is executed and there is an address dependency.
> > > > > 
> > > > > Now, why would the compiler decide to assign "place_holder_deleg" to
> > > > > "delegation" instead of what "rcu_dereference()" returned? Here's my
> > > > > attempt at explaining.
> > > > > 
> > > > > In the pseudo code above, i.e. in the optimised IR, the assignment of
> > > > > "place_holder_deleg" is guarded by two conditions. It is executed iff
> > > > > "place_holder" isn't NULL and the "rcu_dereference()" didn't return
> > > > > NULL. In other words, iff "place_holder != NULL && rcu_dereference() !=
> > > > > NULL" holds at line 617, then "delegation == rcu_dereference() ==
> > > > > place_holder_deleg" must hold at line 622. Otherwise, the optimisation
> > > > > would be wrong.
> > > > > 
> > > > > Assume control flow has just reached the first if, i.e. line 617, in
> > > > > source code. Since "place_holder" isn't NULL, it will execute the first
> > > > > if's body and "rcu_dereference()" into "delegation" (618). Now it has
> > > > > reached the second if. Per our aussmption, "rcu_dereference()" returned
> > > > > something that wasn't NULL. Therefore, "!delegation", the first part of
> > > > > the second if condition's OR, will be false.
> > > > > 
> > > > > However, if we want "rcu_dereference() == delegation" to hold after the
> > > > > two if's, we can't enter the second if anyway, as it will overwrite
> > > > > "delegation" with a value that might not be equal to what
> > > > > "rcu_dereference()" returned. So, we want the second part of the second
> > > > > if condition's OR, i.e.  "delegation != place_holder_deleg" to be false
> > > > > as well.
> > > > > 
> > > > > When is that the case? It is the case when "delegation ==
> > > > > place_holder_deleg" holds.
> > > > > 
> > > > > So, if we want "delegation == rcu_dereference() == place_holder_deleg"
> > > > > to hold after the two if's, "place_holder != NULL && rcu_dereference()
> > > > > != NULL" must hold before the two if's, which is what we wanted to show
> > > > > and what the compiler figured out too.
> > > > > 
> > > > > TL;DR: it appears the compiler optimisation is plausible, yet it still
> > > > > breaks the address dependency.
> > > > > 
> > > > > For those interested, I have made the unoptimised and optimised IR CFGs
> > > > > available. In the optimised one, the interesting part is the transition
> > > > > from "if.end" to "if.end13".
> > > > > 
> > > > > Unoptimised: https://raw.githubusercontent.com/gist/PBHDK/700bf7bdf968fe25c82506de58143bbe/raw/54bf2c1e1a72fb30120f7e812f05ef01ca86b78f/O0-nfs_server_return_marked_delegations.svg
> > > > > 
> > > > > Optimised: https://raw.githubusercontent.com/gist/PBHDK/700bf7bdf968fe25c82506de58143bbe/raw/54bf2c1e1a72fb30120f7e812f05ef01ca86b78f/O2-nfs_server_return_marked_delegations.svg
> > > > > 
> > > > > What do you think?
> > > > > 
> > > > > Many thanks,
> > > > > Paul
> > > > > 
> > > > > [1]: https://linuxplumbersconf.org/event/7/contributions/821/attachments/598/1075/LPC_2020_--_Dependency_ordering.pdf
> > > > > [2]: https://lore.kernel.org/llvm/YXknxGFjvaB46d%2Fp@Pauls-MacBook-Pro/T/#u
> > > > 
> > > > If I understand this correctly (rather unlikely), this stems from
> > > > violating the following rule in Documentation/RCU/rcu_dereference.rst:
> > > > 
> > > > ------------------------------------------------------------------------
> > > > 
> > > > -	Be very careful about comparing pointers obtained from
> > > > 	rcu_dereference() against non-NULL values.  As Linus Torvalds
> > > > 	explained, if the two pointers are equal, the compiler could
> > > > 	substitute the pointer you are comparing against for the pointer
> > > > 	obtained from rcu_dereference().  For example::
> > > > 
> > > > 		p = rcu_dereference(gp);
> > > > 		if (p == &default_struct)
> > > > 			do_default(p->a);
> > > > 
> > > > 	Because the compiler now knows that the value of "p" is exactly
> > > > 	the address of the variable "default_struct", it is free to
> > > > 	transform this code into the following::
> > > > 
> > > > 		p = rcu_dereference(gp);
> > > > 		if (p == &default_struct)
> > > > 			do_default(default_struct.a);
> > > > 
> > > > 	On ARM and Power hardware, the load from "default_struct.a"
> > > > 	can now be speculated, such that it might happen before the
> > > > 	rcu_dereference().  This could result in bugs due to misordering.
> > > > 
> > > > 	However, comparisons are OK in the following cases:
> > > > 
> > > > 	-	The comparison was against the NULL pointer.  If the
> > > > 		compiler knows that the pointer is NULL, you had better
> > > > 		not be dereferencing it anyway.  If the comparison is
> > > > 		non-equal, the compiler is none the wiser.  Therefore,
> > > > 		it is safe to compare pointers from rcu_dereference()
> > > > 		against NULL pointers.
> > > > 
> > > > 	-	The pointer is never dereferenced after being compared.
> > > > 		Since there are no subsequent dereferences, the compiler
> > > > 		cannot use anything it learned from the comparison
> > > > 		to reorder the non-existent subsequent dereferences.
> > > > 		This sort of comparison occurs frequently when scanning
> > > > 		RCU-protected circular linked lists.
> > > > 
> > > > 		Note that if checks for being within an RCU read-side
> > > > 		critical section are not required and the pointer is never
> > > > 		dereferenced, rcu_access_pointer() should be used in place
> > > > 		of rcu_dereference().
> > > > 
> > > > 	-	The comparison is against a pointer that references memory
> > > > 		that was initialized "a long time ago."  The reason
> > > > 		this is safe is that even if misordering occurs, the
> > > > 		misordering will not affect the accesses that follow
> > > > 		the comparison.  So exactly how long ago is "a long
> > > > 		time ago"?  Here are some possibilities:
> > > > 
> > > > 		-	Compile time.
> > > > 
> > > > 		-	Boot time.
> > > > 
> > > > 		-	Module-init time for module code.
> > > > 
> > > > 		-	Prior to kthread creation for kthread code.
> > > > 
> > > > 		-	During some prior acquisition of the lock that
> > > > 			we now hold.
> > > > 
> > > > 		-	Before mod_timer() time for a timer handler.
> > > > 
> > > > 		There are many other possibilities involving the Linux
> > > > 		kernel's wide array of primitives that cause code to
> > > > 		be invoked at a later time.
> > > > 
> > > > 	-	The pointer being compared against also came from
> > > > 		rcu_dereference().  In this case, both pointers depend
> > > > 		on one rcu_dereference() or another, so you get proper
> > > > 		ordering either way.
> > > > 
> > > > 		That said, this situation can make certain RCU usage
> > > > 		bugs more likely to happen.  Which can be a good thing,
> > > > 		at least if they happen during testing.  An example
> > > > 		of such an RCU usage bug is shown in the section titled
> > > > 		"EXAMPLE OF AMPLIFIED RCU-USAGE BUG".
> > > > 
> > > > 	-	All of the accesses following the comparison are stores,
> > > > 		so that a control dependency preserves the needed ordering.
> > > > 		That said, it is easy to get control dependencies wrong.
> > > > 		Please see the "CONTROL DEPENDENCIES" section of
> > > > 		Documentation/memory-barriers.txt for more details.
> > > > 
> > > > 	-	The pointers are not equal *and* the compiler does
> > > > 		not have enough information to deduce the value of the
> > > > 		pointer.  Note that the volatile cast in rcu_dereference()
> > > > 		will normally prevent the compiler from knowing too much.
> > > > 
> > > > 		However, please note that if the compiler knows that the
> > > > 		pointer takes on only one of two values, a not-equal
> > > > 		comparison will provide exactly the information that the
> > > > 		compiler needs to deduce the value of the pointer.
> > > > 
> > > > ------------------------------------------------------------------------
> > > > 
> > > > But it would be good to support this use case, for example, by having
> > > > the compiler provide some way of marking the "delegation" variable as
> > > > carrying a full dependency.
> > > > 
> > > > Or did I miss a turn in here somewhere?
> > > > 
> > > > 							Thanx, Paul
> > > 
> > > Actually, I think you're spot on! The original source code has a,
> > > allbeit nested, comparison of "delegation" against a non-NULL value,
> > > which is exactly what the documentation discourages as it helps the
> > > compiler figure out the value of "delegation".
> > 
> > Sometimes I get lucky.  ;-)
> > 
> > > I'll try to prepare a patch, using my dependency checker tool to verify
> > > that this was indeed the issue.
> > 
> > This would be a kernel patch to avoid the comparison?  Or a patch to
> > the compiler to tell it that the "delegation" variable carries a full
> > dependency?  Either would be useful, just curious.
> 
> Ah, sorry, ambiguous. I was referring to a kernel patch which avoids the
> comparions. But we, i.e. everyone involved with the dependency checker
> tool, are also aware of the value of a dependency-preserving compiler
> and have had some discussions around the topic. Not making any promises
> in that regard though :-)

Thank you for the information!

Is there a reasonable way to hide the comparison from the compiler?
Two unreasonable ways are to implement an asm or an external function
that does the comparison.  ;-)

							Thanx, Paul
