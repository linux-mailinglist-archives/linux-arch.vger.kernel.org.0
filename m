Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7081E1F53
	for <lists+linux-arch@lfdr.de>; Tue, 26 May 2020 12:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgEZKGo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 May 2020 06:06:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728048AbgEZKGo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 May 2020 06:06:44 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19D322073B;
        Tue, 26 May 2020 10:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590487603;
        bh=B4uPhDHjSVrp5Z1BTqTDVVNDXQrB8e6lZd/oVVso0Vc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DVxmcYvh133LIfkvYu6hpKkcHDal8m+FWme32nz9ggBejva328OorzmHpE1v7Wor8
         x445J6QxV0qJ7YqJNwwszFbC3aOKhs5EEaQ1AJmS4F4Db11GQD/rlOZsgvSpqdf49e
         TJR1zhlzCrvkWOqJqnHlC1sMcFXf07k64X4A3qlc=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jdWTp-00FLzx-Fx; Tue, 26 May 2020 11:06:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 26 May 2020 11:06:41 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        catalin.marinas@arm.com, peterz@infradead.org,
        mark.rutland@arm.com, will@kernel.org, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de,
        rostedt@goodmis.org, suzuki.poulose@arm.com, tglx@linutronix.de,
        yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com,
        broonie@kernel.org, guohanjun@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org,
        xiexiangyou@huawei.com, prime.zeng@hisilicon.com,
        zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
Subject: Re: [PATCH v3 1/6] arm64: Detect the ARMv8.4 TTL feature
In-Reply-To: <050b7ee6-c7aa-5d61-4dff-4792a411464e@huawei.com>
References: <20200525125300.794-1-yezhenyu2@huawei.com>
 <20200525125300.794-2-yezhenyu2@huawei.com>
 <c6b6eb07-2606-9fc0-280a-e53b81a6491c@arm.com>
 <050b7ee6-c7aa-5d61-4dff-4792a411464e@huawei.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <872737c7e0690df3f42103365c651ad4@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yezhenyu2@huawei.com, anshuman.khandual@arm.com, catalin.marinas@arm.com, peterz@infradead.org, mark.rutland@arm.com, will@kernel.org, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-05-26 07:40, Zhenyu Ye wrote:
> Hi Anshuman,
> 
> On 2020/5/26 10:39, Anshuman Khandual wrote:
>> This patch (https://patchwork.kernel.org/patch/11557359/) is adding 
>> some
>> more ID_AA64MMFR2 features including the TTL. I am going to respin 
>> parts
>> of the V4 series patches along with the above mentioned patch. So 
>> please
>> rebase this series accordingly, probably on latest next.

No. Please.

>> 
> 
> I noticed that some patches of your series have been merged into arm64
> tree (for-next/cpufeature), such as TLB range, but this one not. Why?
> 
> BTW, this patch is provided by Marc in his NV series [1], maybe you
> should also let him know.
> 
> I will rebase my series after your patch is merged.

Please don't rebase on -next. That's the worse thing to do. Always base
your series on a well known -rc, and stick to that. Maintainers can
always do the rebase and resolve conflicts.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
