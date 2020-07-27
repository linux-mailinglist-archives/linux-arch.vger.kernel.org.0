Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C5922F647
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jul 2020 19:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgG0RMh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 13:12:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728045AbgG0RMh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Jul 2020 13:12:37 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B562206E7;
        Mon, 27 Jul 2020 17:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595869956;
        bh=WogOJT1SpSbDm9BIS5mq+VMEccrmGTd/fbEvNfTWPgM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lQ1Z9K59C8/AlkD1/eM/JwEqvlO7ySlctuRPoQqZ36nRK1Dy7JlBuq/54o4cIjEcD
         cbn9dbymYVSeLmrss7+oAwKbKw0LEVhdVjYi0OVwO3tnBP+DzAKy8Wn2N0a0srie7z
         DjhgZiDTdIYE3B13+xlYN3P1+D7OOQalV77YMcwg=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k06fy-00FNOn-Va; Mon, 27 Jul 2020 18:12:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 27 Jul 2020 18:12:34 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        steven.price@arm.com, mark.rutland@arm.com, ascull@google.com,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org,
        xiexiangyou@huawei.com
Subject: Re: [RESEND RFC PATCH v1] arm64: kvm: flush tlbs by range in
 unmap_stage2_range function
In-Reply-To: <f74277fd-5af2-c46f-169f-c15a321165cd@huawei.com>
References: <20200724134315.805-1-yezhenyu2@huawei.com>
 <5d54c860b3b4e7a98e4d53397e6424ae@kernel.org>
 <f74277fd-5af2-c46f-169f-c15a321165cd@huawei.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <fb4756b58892fbc2022cf1f5b9320c27@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yezhenyu2@huawei.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, steven.price@arm.com, mark.rutland@arm.com, ascull@google.com, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Zhenyu,

On 2020-07-27 15:51, Zhenyu Ye wrote:
> Hi Marc,
> 
> On 2020/7/26 1:40, Marc Zyngier wrote:
>> On 2020-07-24 14:43, Zhenyu Ye wrote:
>>> Now in unmap_stage2_range(), we flush tlbs one by one just after the
>>> corresponding pages cleared.  However, this may cause some 
>>> performance
>>> problems when the unmap range is very large (such as when the vm
>>> migration rollback, this may cause vm downtime too loog).
>> 
>> You keep resending this patch, but you don't give any numbers
>> that would back your assertion.
> 
> I have tested the downtime of vm migration rollback on arm64, and found
> the downtime could even take up to 7s.  Then I traced the cost of
> unmap_stage2_range() and found it could take a maximum of 1.2s.  The
> vm configuration is as follows (with high memory pressure, the dirty
> rate is about 500MB/s):
> 
>   <memory unit='GiB'>192</memory>
>   <vcpu placement='static'>48</vcpu>
>   <memoryBacking>
>     <hugepages>
>       <page size='1' unit='GiB' nodeset='0'/>
>     </hugepages>
>   </memoryBacking>

This means nothing to me, I'm afraid.

> 
> After this patch applied, the cost of unmap_stage2_range() can reduce 
> to
> 16ms, and VM downtime can be less than 1s.
> 
> The following figure shows a clear comparison:
> 
> 	      |	vm downtime  |	cost of unmap_stage2_range()
> --------------+--------------+----------------------------------
> before change |		7s   |		1200 ms
> after  change |		1s   |		  16 ms
> --------------+--------------+----------------------------------

I don't see how you turn a 1.184s reduction into a 6s gain.
Surely there is more to it than what you posted.

>>> +
>>> +    if ((end - start) >= 512 << (PAGE_SHIFT - 12)) {
>>> +        __tlbi(vmalls12e1is);
>> 
>> And what is this magic value based on? You don't even mention in the
>> commit log that you are taking this shortcut.
>> 
> 
> 
> If the page num is bigger than 512, flush all tlbs of this vm to avoid
> soft lock-ups on large TLB flushing ranges.  Just like what the
> flush_tlb_range() does.

I'm not sure this is applicable here, and it doesn't mean
this is as good on other systems.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
