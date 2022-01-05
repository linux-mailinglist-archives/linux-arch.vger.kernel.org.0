Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747B3485BC5
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jan 2022 23:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245110AbiAEWmE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jan 2022 17:42:04 -0500
Received: from foss.arm.com ([217.140.110.172]:48108 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244876AbiAEWmE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 5 Jan 2022 17:42:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8311311D4;
        Wed,  5 Jan 2022 14:42:03 -0800 (PST)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19D4E3F66F;
        Wed,  5 Jan 2022 14:42:03 -0800 (PST)
Message-ID: <101d8e84-7429-bbf1-0271-5436eca0eea2@arm.com>
Date:   Wed, 5 Jan 2022 16:42:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v7 0/4] arm64: Enable BTI for the executable as well as
 the interpreter
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org, Mark Rutland <mark.rutland@arm.com>
References: <20211115152714.3205552-1-broonie@kernel.org>
 <YbD4LKiaxG2R0XxN@arm.com> <20211209111048.GM3294453@arm.com>
 <YdSEkt72V1oeVx5E@sirena.org.uk>
From:   Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <YdSEkt72V1oeVx5E@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 1/4/22 11:32, Mark Brown wrote:
> On Thu, Dec 09, 2021 at 11:10:48AM +0000, Szabolcs Nagy wrote:
>> The 12/08/2021 18:23, Catalin Marinas wrote:
>>> On Mon, Nov 15, 2021 at 03:27:10PM +0000, Mark Brown wrote:
> 
>>>> memory is already mapped with PROT_EXEC.  This series resolves this by
>>>> handling the BTI property for both the interpreter and the main
>>>> executable.
> 
>>> Given the silence on this series over the past months, I propose we drop
>>> it. It's a bit unfortunate that systemd's MemoryDenyWriteExecute cannot
>>> work with BTI but I also think the former is a pretty blunt hardening
>>> mechanism (rejecting any mprotect(PROT_EXEC) regardless of the previous
>>> attributes).
> 
>> i still think it would be better if the kernel dealt with
>> PROT_BTI for the exe loaded by the kernel.
> 
> The above message from Catalin isn't quite the full story here - my
> understanding from backchannel is that there's concern from others that
> we might be creating future issues by enabling PROT_BTI, especially in
> the case where the same permissions issue prevents the dynamic linker
> disabling PROT_BTI.  They'd therefore rather stick with the status quo
> and not create any new ABI.  Unfortunately that's not something people
> have been willing to say on the list, hopefully the above captures the
> thinking well enough.
> 
> Personally I'm a bit ambivalent on this, I do see the potential issue
> but I'm having trouble constructing an actual scenario and my instinct
> is that since we handle PROT_EXEC we should also handle PROT_BTI for
> consistency.
> 

I'm hardly a security expert, but it seems to me that BTI hardens 
against a wider set of possible exploits than MDWE. Yet, we are silently 
turning it off for systemd services which are considered some of the 
most security critical things in the machine right now (ex:logind, etc). 
So despite 'systemd-analyze secuirty` flagging those services as the 
most secure ones on a system, they might actually be less secure.

It also seems that getting BTI turned on earlier, as this patch is doing 
is itself a win.

So, mentally i'm having a hard time balancing the hypothetical problem 
laid out, as it should only really exist in an environment similar to 
the MDWE one, since AFAIK, its possible today to just flip it back off 
unless MDWE stops that from happening.

What are the the remaining alternatives? A new syscall? But that is by 
definition a new ABI, and wouldn't benefit from having BTI turned on as 
early as this patch is doing. Should we disable MDWE on a BTI machine? 
I'm not sure that is a good look, particularly if MDWE happens to 
successfully stop some exploit. AFAIK, MDWE+BTI are a good strong 
combination, it seems a shame if we can't get them both working together.

I hesitate to suggest it, but maybe this patch should be conditional 
somehow, that way !systemd/MDWE machines can behave as they do today, 
and systemd/MDWE machines can request BTI be turned on by the kernel 
automatically?


