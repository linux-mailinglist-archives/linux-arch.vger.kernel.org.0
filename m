Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4459E2A0C11
	for <lists+linux-arch@lfdr.de>; Fri, 30 Oct 2020 18:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgJ3RE7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Oct 2020 13:04:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbgJ3RE7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Oct 2020 13:04:59 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60BCC2075E;
        Fri, 30 Oct 2020 17:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604077498;
        bh=sTMMeRXS4t67nM5gmOt3UYj86onUPB8Ug7BKiB+axBQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Yc4j6IbrNzushS2lQJtwlEA+9yCDp1UbBLZoJImP+2ZdO1X4jp0i22kvPBRDuG64Z
         CwCZoyQ7thZHwznDrADdyEDEFPeF2NBOIPpjSmaVgNY06AuPbHx8WqND10gbpyb9na
         v3e0e+Cvn+qGE/CrWUrNTR5ydDcV2UiBozFbEiVk=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kYXpg-005oH3-1f; Fri, 30 Oct 2020 17:04:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 30 Oct 2020 17:04:55 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@android.com,
        Qais Yousef <qais.yousef@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        linux-arch@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 0/6] An alternative series for asymmetric AArch32 systems
In-Reply-To: <20201030162419.GB32700@willie-the-truck>
References: <20201027215118.27003-1-will@kernel.org>
 <160407459118.3016487.12247105988100320673.b4-ty@kernel.org>
 <20201030162419.GB32700@willie-the-truck>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <9aa6cbc2c55b4d9102d97f5d2695ed88@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, peterz@infradead.org, kernel-team@android.com, qais.yousef@arm.com, catalin.marinas@arm.com, morten.rasmussen@arm.com, linux-arch@vger.kernel.org, surenb@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-10-30 16:24, Will Deacon wrote:
> On Fri, Oct 30, 2020 at 04:16:48PM +0000, Marc Zyngier wrote:
>> On Tue, 27 Oct 2020 21:51:12 +0000, Will Deacon wrote:
>> > I was playing around with the asymmetric AArch32 RFCv2 from Qais:
>> >
>> > https://lore.kernel.org/r/20201021104611.2744565-1-qais.yousef@arm.com
>> >
>> > and ended up writing my own implementation this afternoon. I think it's
>> > smaller, simpler and easier to work with. In particular:
>> >
>> > [...]
>> 
>> Applied to next, thanks!
>> 
>> [1/1] KVM: arm64: Handle Asymmetric AArch32 systems
>>       commit: 22f553842b14a1289c088a79a67fb479d3fa2a4e
> 
> Got to be honest, this gave me a heart attack at first! First patch is
> good though, just please don't apply the rest of this stuff :)

The only reason I took this patch is that it actually prevent these
silly configuration from being actively harmful. As for the rest,
I have no desire to touch them!

         M.
-- 
Jazz is not dead. It just smells funny...
