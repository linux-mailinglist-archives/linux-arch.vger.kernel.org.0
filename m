Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3BA9EB19
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2019 16:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfH0OeM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Aug 2019 10:34:12 -0400
Received: from foss.arm.com ([217.140.110.172]:46004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbfH0OeM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Aug 2019 10:34:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5732D337;
        Tue, 27 Aug 2019 07:34:11 -0700 (PDT)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7AF13F59C;
        Tue, 27 Aug 2019 07:34:09 -0700 (PDT)
Subject: Re: [RFC PATCH 5/7] arm64: smp: use generic SMP stop common code
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mark.rutland@arm.com, peterz@infradead.org,
        catalin.marinas@arm.com, takahiro.akashi@linaro.org,
        james.morse@arm.com, hidehiro.kawai.ez@hitachi.com,
        will@kernel.org, dave.martin@arm.com,
        linux-arm-kernel@lists.infradead.org
References: <20190823115720.605-1-cristian.marussi@arm.com>
 <20190823115720.605-6-cristian.marussi@arm.com>
 <20190826153236.GA9591@infradead.org>
 <c6a86709-6faf-bf84-08aa-c41dab61c58f@arm.com>
 <alpine.DEB.2.21.1908270025340.1939@nanos.tec.linutronix.de>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <2f1b7e1f-5ba2-37b4-193b-133a93a3f6ea@arm.com>
Date:   Tue, 27 Aug 2019 15:34:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908270025340.1939@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi

On 26/08/2019 23:26, Thomas Gleixner wrote:
> On Mon, 26 Aug 2019, Cristian Marussi wrote:
>> On 8/26/19 4:32 PM, Christoph Hellwig wrote:
>>>> +config ARCH_USE_COMMON_SMP_STOP
>>>> +	def_bool y if SMP
>>>
>>> The option belongs into common code and the arch code shoud only
>>> select it.
>>>
>>
>> In fact that was my first approach, but then I noticed that in kernel/ topdir
>> there was no generic Kconfig but only subsystem specific ones:
>>
>> Kconfig.freezer  Kconfig.hz       Kconfig.locks    Kconfig.preempt
> 
> arch/Kconfig
> 

Ok I'll move it there in v2.

Thanks for the review.

Cristian

> Thanks,
> 
> 	tglx
> 

