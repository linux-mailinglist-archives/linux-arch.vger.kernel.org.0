Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5904FC486
	for <lists+linux-arch@lfdr.de>; Mon, 11 Apr 2022 21:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242299AbiDKTFX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Apr 2022 15:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiDKTFW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Apr 2022 15:05:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CECC33334B;
        Mon, 11 Apr 2022 12:03:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75ABB1570;
        Mon, 11 Apr 2022 12:03:07 -0700 (PDT)
Received: from [192.168.122.164] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46AE23F70D;
        Mon, 11 Apr 2022 12:03:06 -0700 (PDT)
Message-ID: <b98efe11-a11e-5787-49a7-c151efdf9401@arm.com>
Date:   Mon, 11 Apr 2022 14:02:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: GCC 12 miscompilation of volatile asm (was: Re: [PATCH] arm64/io:
 Remind compiler that there is a memory side effect)
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, gcc@gcc.gnu.org,
        catalin.marinas@arm.com, will@kernel.org, marcan@marcan.st,
        maz@kernel.org, szabolcs.nagy@arm.com, f.fainelli@gmail.com,
        opendmb@gmail.com, Andrew Pinski <pinskia@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        andrew.cooper3@citrix.com
References: <20220401164406.61583-1-jeremy.linton@arm.com>
 <Ykc0xrLv391/jdJj@FVFF77S0Q05N> <Ykw7UnlTnx63z/Ca@FVFF77S0Q05N>
 <YlQDfC+J8BXHcvpk@FVFF77S0Q05N>
From:   Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <YlQDfC+J8BXHcvpk@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,


On 4/11/22 05:31, Mark Rutland wrote:
> On Tue, Apr 05, 2022 at 01:51:30PM +0100, Mark Rutland wrote:
>> Hi all,
>>
>> [adding kernel folk who work on asm stuff]
>>
>> As a heads-up, GCC 12 (not yet released) appears to erroneously optimize away
>> calls to functions with volatile asm. Szabolcs has raised an issue on the GCC
>> bugzilla:
>>
>>    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105160
>>
>> ... which is a P1 release blocker, and is currently being investigated.
> 
> Jan Hubicka fixed this in GCC commit:
> 
>    aabb9a261ef060cf ("Propagate nondeterministic and side_effects flags in modref summary after inlining")
> 
> ... and all my local tests look good with that applied.
> 
> Compiler explorer's trunk build now has that fix, so the examples from before
> now look good:
> 
>    aarch64: https://godbolt.org/z/vMczqjYvs
> 
>    x86_64: https://godbolt.org/z/cveff9hq5
> 
> Jeremy, now that the real issue has been identified and fixed, I assume you'll
> send a revert for commit:
> 
>    8d3ea3d402db94b6 ("net: bcmgenet: Use stronger register read/writes to assure ordering")
> 
> ... ?

Yes, that's the plan.

Thanks,

