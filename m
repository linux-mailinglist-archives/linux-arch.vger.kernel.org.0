Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001163DE0C5
	for <lists+linux-arch@lfdr.de>; Mon,  2 Aug 2021 22:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhHBUiY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Aug 2021 16:38:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231316AbhHBUiY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 2 Aug 2021 16:38:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C46960F35;
        Mon,  2 Aug 2021 20:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627936694;
        bh=0VmdKvA8h8RP4yq/0aC4aMgJKVh9W7XMpNRewkm2IHY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KSs52CPhyjgzdkS2pj8j6jlHZnaz09GSP05cfei9xqwdJlI28XnYWwn+MwssNomfQ
         fY07EVWBJ8DSbi1z+0mfd29/kYkuDVWnAUku4AC8c+J4SR/5d5YSFxhcfq6s4kmRIW
         M7Us9AY7ouLRn8Tdr3trF/rKf8l3S5ixUbaLJmP8iNqw8sH5+TPr9aIKhXl30Bi8Sg
         mQZpM3m+sHE9Fak1vNfedOKIdEoK/Il62rNAQ/hMdjUSjYVlailf5m2ZpIXtt2zp20
         DUoykYF27/2h1YQXE5JH2wAm7vTDAKJHBinWvgHjqVtlvHuL4lyx39Q7snjC07NwAI
         WOpzFIBhp1HTQ==
Subject: Re: [PATCH 3/3] isystem: delete global -isystem compile option
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, masahiroy@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
References: <20210801201336.2224111-1-adobriyan@gmail.com>
 <20210801201336.2224111-3-adobriyan@gmail.com>
 <YQg2+C4Z98BMFucg@archlinux-ax161> <YQhWQkbN+pe354RW@localhost.localdomain>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <3b2d77db-9bed-2535-87df-a2280f3228a3@kernel.org>
Date:   Mon, 2 Aug 2021 13:38:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQhWQkbN+pe354RW@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/2/2021 1:32 PM, Alexey Dobriyan wrote:
> On Mon, Aug 02, 2021 at 11:18:32AM -0700, Nathan Chancellor wrote:
>> On Sun, Aug 01, 2021 at 11:13:36PM +0300, Alexey Dobriyan wrote:
>>> In theory, it enables "leakage" of userspace headers into kernel which
>>> may present licensing problem.
>>>
>>> In practice, only stdarg.h was used, stdbool.h is trivial and SIMD
>>> intrinsics are contained to a few architectures and aren't global
>>> problem.
>>>
>>> In general, kernel is very self contained code and -isystem removal
>>> will further isolate it from Ring Threeland influence.
>>>
>>> nds32 keeps -isystem globally due to intrisics used in entrenched header.
>>>
>>> -isystem is selectively reenabled for some files.
>>>
>>> Not compile tested on hexagon.
>>
>> With this series on top of v5.14-rc4 and a tangential patch to fix
>> another issue, ARCH=hexagon defconfig and allmodconfig show no issues.
>>
>> Tested-by: Nathan Chancellor <nathan@kernel> # build (hexagon)
> 
> Oh wow, small miracle. Thank you!
> 
> Where can I find a cross-compiler? This link doesn't seem to have one
> https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/11.1.0/

Hexagon only builds with LLVM now because of the bump to require gcc 
4.9: https://lore.kernel.org/r/20210623141854.GA32155@lst.de/

Brian Cain has a link in that thread to an LLVM toolchain that works 
well for defconfig (allmodconfig requires LLVM 13/14 from git). 
Otherwise, https://apt.llvm.org or LLVM from your package manager should 
be sufficient for the same targets.

$ make -skj"$(nproc)" ARCH=hexagon CROSS_COMPILE=hexagon-linux-musl- 
LLVM=1 LLVM_IAS=1 defconfig all

should work fine as long as the bin folder for whatever toolchain you 
download is in your PATH.

Cheers,
Nathan
