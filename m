Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49042807C0
	for <lists+linux-arch@lfdr.de>; Thu,  1 Oct 2020 21:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbgJATaP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Oct 2020 15:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729993AbgJATaP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Oct 2020 15:30:15 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F334FC0613D0;
        Thu,  1 Oct 2020 12:30:14 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kO4H8-00A0dq-BS; Thu, 01 Oct 2020 19:29:58 +0000
Date:   Thu, 1 Oct 2020 20:29:58 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: Litmus test for question from Al Viro
Message-ID: <20201001192958.GH3421308@ZenIV.linux.org.uk>
References: <20201001045116.GA5014@paulmck-ThinkPad-P72>
 <20201001161529.GA251468@rowland.harvard.edu>
 <20201001163646.GG3421308@ZenIV.linux.org.uk>
 <20201001183925.GA259470@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001183925.GA259470@rowland.harvard.edu>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 01, 2020 at 02:39:25PM -0400, Alan Stern wrote:

> The problem with a plain write is that it isn't guaranteed to be atomic 
> in any sense.  In principle, the compiler could generate code for CPU1 
> which would write 0 to V->A more than once.
> 
> Although I strongly doubt that any real compiler would actually do this, 
> the memory model does allow for it, out of an overabundance of caution.  

Point...  OK, not a problem - actually there will be WRITE_ONCE() for other
reasons; the real-life (pseudo-)code is
        spin_lock(&file->f_lock);
        to_free = NULL;
        head = file->f_ep;
        if (head->first == &epitem->fllink && epitem->fllink.next == NULL) {
		/* the set will go empty */
                file->f_ep = NULL;
                if (!is_file_epoll(file)) {
			/*
			 * not embedded into struct eventpoll; we want it
			 * freed unless it's on the check list, in which
			 * case we leave it for reverse path check to free.
			 */
                        v = container_of(head, struct ep_head, epitems);
                        if (!smp_load_acquire(&v->next))
                                to_free = v;
                }
        }
        hlist_del_rcu(&epitem->fllink);
        spin_unlock(file->f_lock);
        kfree(to_free);
and hlist_del_rcu() will use WRITE_ONCE() to store the updated forward links.

That goes into ep_remove() and CPU1 side of that thing is the final (set-emptying)
call.  CPU2 side is the list traversal step in reverse_path_check() and
in clear_tfile_check_list():
	// under rcu_read_lock()
        to_free = head;
        epitem = rcu_dereference(hlist_first_rcu(&head->epitems));
        if (epitem) {
                spin_lock(&epitem->file->f_lock);
                if (!hlist_empty(&head->epitems))
                        to_free = NULL;
                head->next = NULL;
                spin_unlock(&epitem->file->f_lock);
        }
        kfree(to_free);
