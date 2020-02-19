Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 109BB164B8A
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 18:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgBSRHz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 12:07:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37136 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgBSRHy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 12:07:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2xN/67dkbMYjl8utBRoK3KoAvhWmqTFf76Sk2gS40xQ=; b=tJgwSjzoN+WUNV7puG9hFY/ykA
        YHoCQ/AJ1Ca1eVqD2pg5eMy3goeHDGH7kIJ8diYJCgY4mJf06A7yS/aSUsjAChvDpA3wCwge7eRJt
        jqc65Ha8YU8y4ErKlwNq/Znw5TPZm42MdmYizp1rGMbxohlw1bA/wLUjpNeC8RK91FcdWdD+2xUqj
        iuE2iDI97h6c8pDTHBoXtUc7YcOsWmVL9DAKl9nN6wbGyURddIETe+pXtJnaSv0DjHEmWR+xrMNG5
        DWReefJ8A4jedOZpsT22R+svm5kK0CZRjgFhaRRWitqczRrtqFTWAyrSci309BZ6k2Y/rvlpAekc1
        XZ/rSVsQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4Sop-0001Ax-FG; Wed, 19 Feb 2020 17:07:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 526D9300565;
        Wed, 19 Feb 2020 18:05:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF588202287DD; Wed, 19 Feb 2020 18:07:25 +0100 (CET)
Date:   Wed, 19 Feb 2020 18:07:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, mingo@kernel.org,
        joel@joelfernandes.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com,
        frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 01/22] hardirq/nmi: Allow nested nmi_enter()
Message-ID: <20200219170725.GO18400@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.428764577@infradead.org>
 <20200219103126.33f67cf3@gandalf.local.home>
 <20200219165650.GB32346@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219165650.GB32346@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 05:56:50PM +0100, Borislav Petkov wrote:
> On Wed, Feb 19, 2020 at 10:31:26AM -0500, Steven Rostedt wrote:
> > Probably should document somewhere (in a comment above nmi_enter()?)
> > that we allow nmi_enter() to nest up to 15 times.
> 
> Yah, and can we make the BUG_ON() WARN_ON or so instead, so that there's
> at least a chance to be able to catch it for debugging. Or is the box
> going to be irreparably wedged after the 4 bits overflow?

It's going to be fairly buggered, because at that point in_nmi() is
going to be false again. It might survive for a little, it might not.
