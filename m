Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0896E419F
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 09:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjDQHyT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 03:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDQHyS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 03:54:18 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483262136;
        Mon, 17 Apr 2023 00:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1681718054; bh=WzH97IkHTN5j9HY8diACslOsbTRmusXjr7HU3cFsWE0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=diZ88u3ZxFQ58IqLBXz51tvq1SqWjnN030zX1stF6QcoHPe3hjYIfA788AhC22vSr
         dp8GlVnCPE7b7fjTRcWYGFetuomLgB2VChUsIFLJunL5sECWpaPMJv0ALpXPUwHJXD
         AcB2BZtgKHs+Io2zdkgAhliAQxFNya8spJsrkQYg=
Received: from [100.100.33.167] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id F16096012F;
        Mon, 17 Apr 2023 15:54:13 +0800 (CST)
Message-ID: <6ca642a9-62a6-00e5-39ac-f14ef36f6bdb@xen0n.name>
Date:   Mon, 17 Apr 2023 15:54:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 0/2] LoongArch: Make bounds-checking instructions useful
To:     Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev
Cc:     WANG Xuerui <git@xen0n.name>, Huacai Chen <chenhuacai@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230416173326.3995295-1-kernel@xen0n.name>
 <e593541e7995cc46359da3dd4eb3a69094e969e2.camel@xry111.site>
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <e593541e7995cc46359da3dd4eb3a69094e969e2.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2023/4/17 14:47, Xi Ruoyao wrote:
> On Mon, 2023-04-17 at 01:33 +0800, WANG Xuerui wrote:
>> From: WANG Xuerui <git@xen0n.name>
>>
>> Hi,
>>
>> The LoongArch-64 base architecture is capable of performing
>> bounds-checking either before memory accesses or alone, with specialized
>> instructions generating BCEs (bounds-checking error) in case of failed
>> assertions (ISA manual Volume 1, Sections 2.2.6.1 [1] and 2.2.10.3 [2]).
>> This could be useful for managed runtimes, but the exception is not
>> being handled so far, resulting in SIGSYSes in these cases, which is
>> incorrect and warrants a fix in itself.
>>
>> During experimentation, it was discovered that there is already UAPI for
>> expressing such semantics: SIGSEGV with si_code=SEGV_BNDERR. This was
>> originally added for Intel MPX, and there is currently no user (!) after
>> the removal of MPX support a few years ago. Although the semantics is
>> not a 1:1 match to that of LoongArch, still it is better than
>> alternatives such as SIGTRAP or SIGBUS of BUS_OBJERR kind, due to being
>> able to convey both the value that failed assertion and the bound value.
>>
>> This patch series implements just this approach: translating BCEs into
>> SIGSEGVs with si_code=SEGV_BNDERR, si_value set to the offending value,
>> and si_lower and si_upper set to resemble a range with both lower and
>> upper bound while in fact there is only one.
>>
>> The instructions are not currently used anywhere yet in the fledgling
>> LoongArch ecosystem, so it's not very urgent and we could take the time
>> to figure out the best way forward (should SEGV_BNDERR turn out not
>> suitable).
> 
> I don't think these instructions can be used in any systematic way
> within a Linux userspace in 2023.  IMO they should not exist in
> LoongArch at all because they have all the same disadvantages of Intel
> MPX; MPX has been removed by Intel in 2019, and LoongArch is designed
> after 2019.

Well, the difference is IMO significant enough to make LoongArch 
bounds-checking more useful, at least for certain use cases. For 
example, the bounds were a separate register bank in Intel MPX, but in 
LoongArch they are just values in GPRs. This fits naturally into 
JIT-ting or other managed runtimes (e.g. Go) whose slice indexing ops 
already bounds-check with a temporary register per bound anyway, so it's 
just a matter of this snippet (or something like it)

- calculate element address
- if address < base: goto fail
- load/calculate upper bound
- if address >= upper bound: goto fail
- access memory

becoming

- calculate element address
- asrtgt address, base - 1
- load/calculate upper bound
- {ld,st}le address, upper bound

then in SIGSEGV handler, check PC to associate the signal back with the 
exact access op; in this case, the only big problem is that LoongArch 
doesn't provide idiomatic "lower <= val" and "val < upper" semantics for 
the checked loads/stores. I've not benchmarked such memory accesses 
against plain unchecked variants, though, but I guess latency should not 
get too bad (just an extra comparison and an unlikely trap per op).

I've also looked at the other limitations described in the Wikipedia 
page for Intel MPX, and it seems majority of them are due to its use of 
a new register bank (i.e. ISA state). So I'd say the LoongArch feature 
is probably better in that regard. Other than that, I agree they are 
less useful for general memory safety that doesn't require 
application-level cooperation.

> 
> If we need some hardware assisted memory safety facility, an extension
> similar to ARM TBI or Intel LAM would be much more useful.
> 
> 
> Back in the old MIPS-based Loongson CPUs, similar instructions (GSLE,
> GSGT, etc.) were included in LoongISA extension and the manual says they
> raises "address error" when assert fails.  So SIGSEGV seems the
> "backward compatible" (quoted because we absolutely don't need to
> maintain any backward compatibility with old MIPS-based implementations)
> thing to do.

IMO we don't need to even try to keep consistency between Loongson/MIPS 
and Loongson/LoongArch UAPIs. Loongson/MIPS is effectively "on life 
support" due to non-technical reasons we have zero influence, so there's 
no reason ISVs would put out new software for it. And SIGSEGV is IMO 
appropriate no matter what the arch is (the HW exception indicates a 
real/supposed *access to the wrong location* after all), and it's 
important that we do the right thing for a new architecture.

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

