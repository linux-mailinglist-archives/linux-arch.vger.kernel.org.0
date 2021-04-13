Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9521535E827
	for <lists+linux-arch@lfdr.de>; Tue, 13 Apr 2021 23:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346010AbhDMVW3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Apr 2021 17:22:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:14834 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231955AbhDMVW3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Apr 2021 17:22:29 -0400
IronPort-SDR: fvbfg4xiS/fhTy/fCuxc4jsztc6zrmRpognrhk9AfEk71AcXCFPCKrolPXaRZN5EbVeNN7lyir
 A12oSrOn1yEQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="192378778"
X-IronPort-AV: E=Sophos;i="5.82,220,1613462400"; 
   d="scan'208";a="192378778"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 14:22:06 -0700
IronPort-SDR: 9rzF2Bdx0v7QOidNv5ZqjosswKNcLgHVc7HwI6vb1BBJ5JuIYIasptiFS+n5en9YJK33YUfQ8a
 Da5yQP51NiTA==
X-IronPort-AV: E=Sophos;i="5.82,220,1613462400"; 
   d="scan'208";a="424426038"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 14:22:04 -0700
Date:   Tue, 13 Apr 2021 14:22:03 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
Subject: Re: [External] : Re: [PATCH v14 4/6] locking/qspinlock: Introduce
 starvation avoidance into CNA
Message-ID: <20210413212203.GT3762101@tassilo.jf.intel.com>
References: <20210401153156.1165900-1-alex.kogan@oracle.com>
 <20210401153156.1165900-5-alex.kogan@oracle.com>
 <87mtu2vhzz.fsf@linux.intel.com>
 <CA1141EF-76A8-47A9-97B9-3CB2FC246B1A@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA1141EF-76A8-47A9-97B9-3CB2FC246B1A@oracle.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> > ms granularity seems very coarse grained for this. Surely
> > at some point of spinning you can afford a ktime_get? But ok.
> We are reading time when we are at the head of the (main) queue, but
> don’t have the lock yet. Not sure about the latency of ktime_get(), but
> anything reasonably fast but not necessarily precise should work.

Actually cpu_clock / sched_clock (see my other email). These should
be fast without corner cases and also monotonic.

> 
> > Could you turn that into a moduleparm which can be changed at runtime?
> > Would be strange to have to reboot just to play with this parameter
> Yes, good suggestion, thanks.
> 
> > This would also make the code a lot shorter I guess.
> So you don’t think we need the command-line parameter, just the module_param?

module_params can be changed at the command line too, so yes.

-Andi
