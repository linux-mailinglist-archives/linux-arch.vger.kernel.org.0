Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E0721755D
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jul 2020 19:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgGGRni (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Jul 2020 13:43:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727777AbgGGRni (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 7 Jul 2020 13:43:38 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61FE820675;
        Tue,  7 Jul 2020 17:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594143817;
        bh=6g1M+4dRP+O92pz2AsymoTapmF+HBsCWQq3yJ8xje58=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jOQrg9e8tkl8YFDzAoOzcnv4HIUjaxYMOZPFxQTqwcWyjGnyy2UOSA5BN3Re8hnCP
         mxn7kdW14EI6KAhhIrnO5dZF0nIo0KNrseYk5WWDR7NDcAKABxDqJJym9pTo0iLRvX
         bFOIG2GMPdFcnXvkZkXTu9uhGOg5euhPZXI3PSuo=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jsrd1-009pmF-VP; Tue, 07 Jul 2020 18:43:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 07 Jul 2020 18:43:35 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Zhenyu Ye <yezhenyu2@huawei.com>, will@kernel.org,
        suzuki.poulose@arm.com, steven.price@arm.com, guohanjun@huawei.com,
        olof@lixom.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com,
        prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com,
        kuhn.chenqun@huawei.com
Subject: Re: [RFC PATCH v4 2/2] arm64: tlb: Use the TLBI RANGE feature in
 arm64
In-Reply-To: <20200707173617.GA32331@gaia>
References: <20200601144713.2222-1-yezhenyu2@huawei.com>
 <20200601144713.2222-3-yezhenyu2@huawei.com> <20200707173617.GA32331@gaia>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <d26f23960443a7f270847c90242e07ab@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: catalin.marinas@arm.com, yezhenyu2@huawei.com, will@kernel.org, suzuki.poulose@arm.com, steven.price@arm.com, guohanjun@huawei.com, olof@lixom.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-07-07 18:36, Catalin Marinas wrote:
> On Mon, Jun 01, 2020 at 10:47:13PM +0800, Zhenyu Ye wrote:
>> @@ -59,6 +69,47 @@
>>  		__ta;						\
>>  	})
>> 
>> +/*
>> + * __TG defines translation granule of the system, which is decided 
>> by
>> + * PAGE_SHIFT.  Used by TTL.
>> + *  - 4KB	: 1
>> + *  - 16KB	: 2
>> + *  - 64KB	: 3
>> + */
>> +#define __TG	((PAGE_SHIFT - 12) / 2 + 1)
> 
> Nitpick: maybe something like __TLBI_TG to avoid clashes in case 
> someone
> else defines a __TG macro.

I have commented on this in the past, and still maintain that this
would be better served by a switch statement similar to what is used
for TTL already (I don't think this magic formula exists in the
ARM ARM).

         M.
-- 
Jazz is not dead. It just smells funny...
