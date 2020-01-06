Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D709F130CB2
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jan 2020 05:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgAFEL2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Jan 2020 23:11:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:54602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727432AbgAFEL2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 5 Jan 2020 23:11:28 -0500
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17FED21582;
        Mon,  6 Jan 2020 04:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578283887;
        bh=B7LdXSi/JWjxK6Dm4iNqV5LXa5Xz3Zef96dIAiZ9mAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uuWXR9ITds1qYZMkEPs2chZJ3MZX82/ziVIIMlEk0mvXOpLJlDW7XQpmSofwFBHH7
         JZugrGnzEeMErDq+kCEbmphUKE8XGGr19kPQSjhgePQzUZTus3xs9Z8SpZDaJcYsyC
         eQv32KzvZ5D1tJNrJwjWv1dYcE6DPmZK/HhR/i3c=
Date:   Mon, 6 Jan 2020 05:11:25 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [patch V2 09/17] x86/entry: Remove _TIF_NOHZ from
 _TIF_WORK_SYSCALL_ENTRY
Message-ID: <20200106041124.GA26097@lenoir>
References: <20191023122705.198339581@linutronix.de>
 <20191023123118.491328859@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023123118.491328859@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 23, 2019 at 02:27:14PM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Evaluating _TIF_NOHZ to decide whether to use the slow syscall entry path
> is not only pointless, it's actually counterproductive:
> 
>  1) Context tracking code is invoked unconditionally before that flag is
>     evaluated.
> 
>  2) If the flag is set the slow path is invoked for nothing due to #1
> 
> Remove it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

I'm borrowing this patch for a series of mine. But if you apply
it in the meantime, that would be even better :-)

Thanks!
