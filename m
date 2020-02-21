Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 659D7168A78
	for <lists+linux-arch@lfdr.de>; Sat, 22 Feb 2020 00:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgBUXkF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 18:40:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:60428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729100AbgBUXkF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Feb 2020 18:40:05 -0500
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A531920722;
        Fri, 21 Feb 2020 23:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582328405;
        bh=QHfIxe9nnj+My2+C4Am5da6Z4rJloL88JjdUcIpSYJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sEdo5mq6U22YrWp/fsxUq+XcwITqfgimA8JN/rVQO5VnZQr5oVe3A64haS8giaiMC
         MPy1hjPzEMcSrreGHv0J5z+Xld9YqD01Tuja8rbolkR1BCFFOVenmSWIFaZw5DWaz/
         c1Y1mOLAuj6ZDxrCXPdoOHDLDOvaPTdn8PCgpw7c=
Date:   Sat, 22 Feb 2020 00:40:02 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, dan.carpenter@oracle.com,
        mhiramat@kernel.org
Subject: Re: [PATCH v4 04/27] x86/mce: Delete ist_begin_non_atomic()
Message-ID: <20200221234001.GC28251@lenoir>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.264229755@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221134215.264229755@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 21, 2020 at 02:34:20PM +0100, Peter Zijlstra wrote:
> It is an abomination; and in prepration of removing the whole
> ist_enter() thing, it needs to go.
> 
> Convert #MC over to using task_work_add() instead; it will run the
> same code slightly later, on the return to user path of the same
> exception.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
