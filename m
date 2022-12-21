Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0356533FD
	for <lists+linux-arch@lfdr.de>; Wed, 21 Dec 2022 17:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiLUQ3v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Dec 2022 11:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiLUQ3t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Dec 2022 11:29:49 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20AE8FE0;
        Wed, 21 Dec 2022 08:29:47 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p81yS-0002TE-S7; Wed, 21 Dec 2022 17:29:44 +0100
Message-ID: <0ab93345-18e1-15c9-a4a3-066ea1cd862b@leemhuis.info>
Date:   Wed, 21 Dec 2022 17:29:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: BUG: arm64: missing build-id from vmlinux
Content-Language: en-US, de-DE
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, Dennis Gilmore <dennis@ausil.us>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <CAABkxwuQoz1CTbyb57n0ZX65eSYiTonFCU8-LCQc=74D=xE=rA@mail.gmail.com>
 <26bd2928-9d62-32b3-4f9f-9dd9293cefeb@leemhuis.info>
 <CAK7LNAQ5VVRdrewtxrBdw561LL=yY8fdr=i1e7pp4DRht=r_Ww@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CAK7LNAQ5VVRdrewtxrBdw561LL=yY8fdr=i1e7pp4DRht=r_Ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1671640188;6abf3486;
X-HE-SMSGID: 1p81yS-0002TE-S7
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 21.12.22 16:39, Masahiro Yamada wrote:
> On Wed, Dec 21, 2022 at 5:23 PM Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
>>
>> Hi, this is your Linux kernel regression tracker. CCing the regression
>> mailing list, as it should be in the loop for all regressions:
>> https://docs.kernel.org/admin-guide/reporting-regressions.html
>>
>> On 18.12.22 21:51, Dennis Gilmore wrote:
>>> The changes in https://lore.kernel.org/linux-arm-kernel/166783716442.32724.935158280857906499.b4-ty@kernel.org/T/
>>> result in vmlinux no longer having a build-id.
>>
>> FWIW, that's 994b7ac1697b ("arm64: remove special treatment for the link
>> order of head.o") from Masahiro merged through Will this cycle.
>>
>>> At the least, this
>>> causes rpm builds to fail. Reverting the patch does bring back a
>>> build-id, but there may be a different way to fix the regression
>>
>> Makes me wonder if other distros or CIs relying on the build-id are
>> broken, too.
>>
>> Anyway, the holiday season is upon us, hence I also wonder if it would
>> be best to revert above change quickly and leave further debugging for 2023.
>>
>> Masahiro, Will, what's your option on this?

Masahiro, many thx for looking into this.

> I do not understand why you rush into the revert so quickly.
> We are before -rc1.
> We have 7 weeks before the 6.2 release
> (assuming we will have up to -rc7).
> 
> If we get -rc6 or -rc7 and we still do not
> solve the issue, we should consider reverting it.

Because it looked like a regression that makes it harder for people and
CI systems to build and test mainline. To quote
Documentation/process/handling-regressions.rst (
https://docs.kernel.org/process/handling-regressions.html ):

"""
 * Fix regressions within two or three days, if they are critical for
some reason – for example, if the issue is likely to affect many users
of the kernel series in question on all or certain architectures. Note,
this includes mainline, as issues like compile errors otherwise might
prevent many testers or continuous integration systems from testing the
series.
"""

I suspect that other distros rely on the build-id as well. Maybe I'm
wrong with that, but even if only Fedora and derivatives are effected it
will annoy some people. Sure, each can apply the revert, but before that
everyone affected will spend time debugging the issue first. A quick
revert in mainline (with a reapply later together with a fix) thus IMHO
is the most efficient approach afaics.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
