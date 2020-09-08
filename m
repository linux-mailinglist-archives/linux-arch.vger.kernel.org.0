Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B77D2610E1
	for <lists+linux-arch@lfdr.de>; Tue,  8 Sep 2020 13:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbgIHLjj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Sep 2020 07:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729741AbgIHLiX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Sep 2020 07:38:23 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79DEC061573;
        Tue,  8 Sep 2020 04:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3PuhP9uGjIipfkXqBzok/ejHi8BsHitcvoa7xFcrBwE=; b=cD4P+Wct6AGR6kYI5B+8HimOQk
        HV95HuTMSTEL65KIotpV+hS46xqlFMrGV3guc5saUbuFu3HLVU5O0p9xFIWo+tSDfsMOR311qWrkf
        Cf8IZoz7DZhSEkGLjNJacAyu/0yUt3keRVTYh6dUG6hLHL6nerlv/Omv9ZkY7HBkyYrM3yhl3LPsI
        RGzbskPglasw1fVUx+hRejR7E2DfI7Q9DAwFX+xniqcJoviyajNk02GRLqtyuCFayy6gmfJl0yWEQ
        jwQ7AoblGyki+qSw/Oxg7Bi+6UktcvDRYN9iWDJ9kXl6zLRcQ1KfGBMglDBVn27MVV46KfyUUQrad
        2pOsKkrg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFbsb-0004Ni-Ui; Tue, 08 Sep 2020 11:33:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 092EA300130;
        Tue,  8 Sep 2020 13:33:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B422923649288; Tue,  8 Sep 2020 13:33:39 +0200 (CEST)
Date:   Tue, 8 Sep 2020 13:33:39 +0200
From:   peterz@infradead.org
To:     "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
        "anil.s.keshavamurthy@intel.com" <anil.s.keshavamurthy@intel.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "cameron@moodycamel.com" <cameron@moodycamel.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "systemtap@sourceware.org" <systemtap@sourceware.org>
Subject: Re: [PATCH v5 00/21] kprobes: Unify kretprobe trampoline handlers
 and make kretprobe lockless
Message-ID: <20200908113339.GQ1362448@hirez.programming.kicks-ass.net>
References: <20200901190808.GK29142@worktop.programming.kicks-ass.net>
 <20200902093739.8bd13603380951eaddbcd8a5@kernel.org>
 <20200902070226.GG2674@hirez.programming.kicks-ass.net>
 <20200902171755.b126672093a3c5d1b3a62a4f@kernel.org>
 <20200902093613.GY1362448@hirez.programming.kicks-ass.net>
 <20200902221926.f5cae5b4ad00b8d8f9ad99c7@kernel.org>
 <20200902134252.GH1362448@hirez.programming.kicks-ass.net>
 <20200903103954.68f0c97da57b3679169ce3a7@kernel.org>
 <20200908103736.GP1362448@hirez.programming.kicks-ass.net>
 <dd1b7b1fdbd84d20ad06abf0c06b4747@trendmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd1b7b1fdbd84d20ad06abf0c06b4747@trendmicro.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 08, 2020 at 11:15:14AM +0000, Eddy_Wu@trendmicro.com wrote:
> > From: peterz@infradead.org <peterz@infradead.org>
> >
> > I'm now trying and failing to reproduce.... I can't seem to make it use
> > int3 today. It seems to want to use ftrace or refuses everything. I'm
> > probably doing it wrong.
> >
> 
> You can turn off CONFIG_KPROBES_ON_FTRACE (and also sysctl
> debug.kprobes-optimization) to make it use int3 handler

I'm fairly sure I used the sysctl like in your original reproducer.

I'll try again later.
