Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 059941396F5
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jan 2020 18:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgAMRFw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jan 2020 12:05:52 -0500
Received: from foss.arm.com ([217.140.110.172]:41904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbgAMRFv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Jan 2020 12:05:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 317CB11B3;
        Mon, 13 Jan 2020 09:05:51 -0800 (PST)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3A583F534;
        Mon, 13 Jan 2020 09:05:44 -0800 (PST)
Subject: Re: [RFC PATCH v3 00/12] Unify SMP stop generic logic to common code
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mark.rutland@arm.com, peterz@infradead.org,
        catalin.marinas@arm.com, takahiro.akashi@linaro.org,
        james.morse@arm.com, hidehiro.kawai.ez@hitachi.com,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
        mingo@redhat.com, x86@kernel.org, dzickus@redhat.com,
        ehabkost@redhat.com, linux@armlinux.org.uk, davem@davemloft.net,
        sparclinux@vger.kernel.org, hch@infradead.org
References: <20191219121905.26905-1-cristian.marussi@arm.com>
 <20200113164029.GE4458@willie-the-truck>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <7937f12d-8aba-733a-c313-f446857a1447@arm.com>
Date:   Mon, 13 Jan 2020 17:05:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200113164029.GE4458@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Will

On 13/01/2020 16:40, Will Deacon wrote:
> On Thu, Dec 19, 2019 at 12:18:53PM +0000, Cristian Marussi wrote:
>> the logic underlying SMP stop and kexec crash procedures, beside containing
>> some arch-specific bits, is mostly generic and common across all archs:
>> despite this fact, such logic is now scattered across all architectures and
>> on some of them is flawed, in such a way that, under some specific
>> conditions, you can end up with a CPU left still running after a panic and
>> possibly lost across a subsequent kexec crash reboot. [1]
> 
> Is this still the case even after 20bb759a66be ("panic: ensure preemption is
> disabled during panic()")?
> 

v3 is based on 5.5-rc2 which seems to include 20bb759a66be, and when I tested before
re-posting a few weeks ago it was still failing as usual, i.e. kernel still alive after panic.
[but please be aware that to reproduce it, you need to have only one core online and another one
 panicing while starting up (while still marked offline)]

Thanks

Cristian


