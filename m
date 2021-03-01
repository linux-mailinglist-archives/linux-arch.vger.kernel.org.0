Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67697327C09
	for <lists+linux-arch@lfdr.de>; Mon,  1 Mar 2021 11:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbhCAK00 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Mar 2021 05:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbhCAK0V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Mar 2021 05:26:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8F4C061756;
        Mon,  1 Mar 2021 02:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=trqoC5wBgL/X8MgZrSVu3kAhefwSXoctPUi4q1p7FZg=; b=KAPCI+jJOFVmU+KEDzcR693871
        xN58xOfKZoquLBZT92dYxxlLBBYa4Sf2Y9xBxho1c0r69g8RS2r7JBj3gW0J7btXwom2eFo2zgxKt
        f8XOQczhSlhCrzr2Qu5Ya9kjls33oRKcrF1qRoZGixRrw2K6ap6L+1OTPuwsmIFy5kTvYRY0wf+/f
        0KT1DBQkTBM8LQIK9oGpd71gPY86yulTVGL7z+UyYzhLVqJ+ca/DG/2rmIajG4ntCQyb5WcBtWtOa
        0cTFQOL7015SUyRpc0aHUAI054I0x7AZ71qxeRXh1gcBAd2lkjuJ6RIDcCeC4YF4TgYUZiis8xGiX
        8VL18pmg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lGfjX-00Fajk-Af; Mon, 01 Mar 2021 10:25:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 70A203019CE;
        Mon,  1 Mar 2021 11:24:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5CC9120B7CA2F; Mon,  1 Mar 2021 11:24:58 +0100 (CET)
Date:   Mon, 1 Mar 2021 11:24:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guo Ren <guoren@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-csky@vger.kernel.org
Subject: Re: [GIT PULL] csky changes for v5.12-rc1
Message-ID: <YDzA+nGPWc+SzCtB@hirez.programming.kicks-ass.net>
References: <20210228034300.1090149-1-guoren@kernel.org>
 <CAHk-=wjM+kCsKqNdb=c0hKsv=J7-3Q1zmM15vp6_=8S5XfGMtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjM+kCsKqNdb=c0hKsv=J7-3Q1zmM15vp6_=8S5XfGMtA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Feb 28, 2021 at 12:36:29PM -0800, Linus Torvalds wrote:
> So this is entirely unrelated to the csky pull request, and is more of
> a generic "the perf CPU hotplug thing seems a complete mess".

Yes, I've noticed that a few times but it never seemed to have made it
to the top of the todo list :/ Let me see what I can do about that.
