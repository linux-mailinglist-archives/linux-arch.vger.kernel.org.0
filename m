Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3297C32EF05
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 16:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhCEPhT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 10:37:19 -0500
Received: from netrider.rowland.org ([192.131.102.5]:40167 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230401AbhCEPg4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Mar 2021 10:36:56 -0500
Received: (qmail 39458 invoked by uid 1000); 5 Mar 2021 10:36:55 -0500
Date:   Fri, 5 Mar 2021 10:36:55 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
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
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH] tools/memory-model: Fix smp_mb__after_spinlock() spelling
Message-ID: <20210305153655.GC38200@rowland.harvard.edu>
References: <20210305102823.415900-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210305102823.415900-1-bjorn.topel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 05, 2021 at 11:28:23AM +0100, Björn Töpel wrote:
> From: Björn Töpel <bjorn.topel@intel.com>
> 
> A misspelled invokation of git-grep, revealed that
-------------------^

Smetimes my brain is a little slow...  Do you confirm that this is a 
joke?

Alan
