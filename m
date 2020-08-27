Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2774425449A
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 13:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbgH0Lx4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 07:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728934AbgH0Lu6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 07:50:58 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56942C06123C;
        Thu, 27 Aug 2020 04:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=awfRf66HgGbxCRr70kQw5NQ84A89ap4b1ms7NbzviQY=; b=MM43WGiCJfh+YM6OHLDNcC42DR
        pCMfp7AylWwoKAKC2yUp9DqtyVcDCvZ294vX53tJH+ONZFQUEoUj+CsnNi9VL5zbnJCrGCLb3bgSv
        /kY7uRJjUM0QaQHJH7VemyieIhcgfz4Bk/km3qYJg6n9d7k8rSpd1dRAjGEYgHLAL+4YJP1s4r5+0
        VQlVZVpXrpqQEonTGOUxbutnU2mLfQcGbcWW8xsuUilR48V9yyEvvW2yEcEdmr4LwFnSOEO2Lr82Z
        ElAvoFZbdnFEFKid73m8Jm54EhcyJH92Wudd/QC9ImfJPxq+eQYpDfw9fcL5Bbyvt2QnoJshuHXQj
        G++v5ebA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBGPC-0000TM-Ld; Thu, 27 Aug 2020 11:49:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 127FF301A66;
        Thu, 27 Aug 2020 13:49:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C22922C1263AB; Thu, 27 Aug 2020 13:49:19 +0200 (CEST)
Date:   Thu, 27 Aug 2020 13:49:19 +0200
From:   peterz@infradead.org
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Eddy Wu <Eddy_Wu@trendmicro.com>,
        x86@kernel.org, "David S . Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 15/15] kprobes: Free kretprobe_instance with rcu
 callback
Message-ID: <20200827114919.GB2674@hirez.programming.kicks-ass.net>
References: <159852811819.707944.12798182250041968537.stgit@devnote2>
 <159852826969.707944.15092569392287597887.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159852826969.707944.15092569392287597887.stgit@devnote2>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 27, 2020 at 08:37:49PM +0900, Masami Hiramatsu wrote:

> +void recycle_rp_inst(struct kretprobe_instance *ri)

Also note, that at this point there is no external caller of this
function anymore.
