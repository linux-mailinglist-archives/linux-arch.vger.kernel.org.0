Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7231B46BB3
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jun 2019 23:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfFNVRL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Jun 2019 17:17:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbfFNVRL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 Jun 2019 17:17:11 -0400
Received: from localhost (unknown [131.107.159.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CEBA2184B;
        Fri, 14 Jun 2019 21:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560547030;
        bh=3qZBnSeXO8K4oYa3/N25KQYrBFfoH3IDbPh/Ayhnk1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wSQKJ/fpvZ2VNMj+Ci4k6VkUSRmnCwxH0B3QSi4pAXHaafCyjkLk5Ay1FlTE8nu4t
         G9JhtzPQKgDEUCIAmnZTe5zgfu4bvGevKrkwx5eb89dokUpJIBwpcuH1xlDk/nCpvt
         xMI4C4u1OBkryDfNx63vmnnkfSFUTeuK+DAqJlh4=
Date:   Fri, 14 Jun 2019 17:17:10 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>
Subject: Re: [PATCH v6 18/19] x86: Add support for generic vDSO
Message-ID: <20190614211710.GQ1513@sasha-vm>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-19-vincenzo.frascino@arm.com>
 <BYAPR21MB1221D54FCEC97509EEF7395CD7180@BYAPR21MB1221.namprd21.prod.outlook.com>
 <alpine.DEB.2.21.1906141313150.1722@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906141313150.1722@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 14, 2019 at 01:15:23PM +0200, Thomas Gleixner wrote:
>On Thu, 30 May 2019, Michael Kelley wrote:
>> Vincenzo -- these changes for Hyper-V are a subset of a larger patch set
>> I have that moves all of the Hyper-V clock/timer code into a separate
>> clocksource driver in drivers/clocksource, with an include file in
>> includes/clocksource.  That new include file should be able to work
>> instead of your new mshyperv-tsc.h.  It also has the benefit of being
>> ISA neutral, so it will work with my in-progress patch set to support
>> Linux on Hyper-V on ARM64.  See https://lkml.org/lkml/2019/5/27/231
>> for the new clocksource driver patch set.
>
>Grrr. That's queued in hyperv-next for whatever reasons.

I queue up our future pull requests there to give them some soaking in
-next.

>Sasha, can you please provide me the branch to pull from so I can have a
>common base for all the various changes floating around?

I'll send you a unified pull request for these changes.

--
Thanks,
Sasha
