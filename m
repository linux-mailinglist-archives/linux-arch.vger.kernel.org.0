Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6B8369C8D
	for <lists+linux-arch@lfdr.de>; Sat, 24 Apr 2021 00:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbhDWW1l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Apr 2021 18:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbhDWW1k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Apr 2021 18:27:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82989C061574;
        Fri, 23 Apr 2021 15:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=9p+f2yEK4EX631yr0nLf67Yo+8aAuwLas6USm3q+guE=; b=VUsIIiWaXRIitxr+LIP/9TRx/a
        oq7jC/A3vVfw8DgbkA34V4c2wxPT1SBd93piZo51HTgdM5tCOxBTDrNtxg47d24d0OakSa2UkQrV0
        0oxqFuFn5G5OrsJNiGvazc3aCc3q3wE6oz/rls3qmvTJc/FV87lROU9pYxUv2VaotyGgJVzzuEOy4
        CG1W99HbLWakwMa4MK7z9YkATKCaccnYdylCs0G860wOFLDnGG7XqeVitcHcl7rXTFJYlVHm7NgmJ
        F0eim+xuMuNpgQVFKazrBI7DezgINd1d0zEV+leI74tfG29HJsBBp4BDp5iQE6p79sHgtyjd11L/3
        RAXIiLew==;
Received: from [2601:1c0:6280:3f0::6d64]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1la4GL-002VV4-9G; Fri, 23 Apr 2021 22:27:01 +0000
Subject: Re: ARCH=hexagon unsupported?
To:     bcain@codeaurora.org, 'Arnd Bergmann' <arnd@kernel.org>
Cc:     'Nick Desaulniers' <ndesaulniers@google.com>,
        "'open list:QUALCOMM HEXAGON...'" <linux-hexagon@vger.kernel.org>,
        'clang-built-linux' <clang-built-linux@googlegroups.com>,
        'linux-arch' <linux-arch@vger.kernel.org>,
        'Guenter Roeck' <linux@roeck-us.net>
References: <CAKwvOdngSxXGYAykAbC=GLE_uWGap220=k1zOSxe1ntuC=0wjA@mail.gmail.com>
 <CAK8P3a2DCCjOq+sB+9sRM7XrtnkromCs_+znv3dehqLiYFDQag@mail.gmail.com>
 <fa0bed95-5ddf-ecad-0613-2f13837578c3@infradead.org>
 <CAK8P3a0ttLxzP0J-mocxB2TkfEYJYj37TdW=uM65fB4giC_qeg@mail.gmail.com>
 <026d01d73877$386a1920$a93e4b60$@codeaurora.org>
 <027401d7387e$f5630120$e0290360$@codeaurora.org>
 <24da08a4-e055-d8ac-8214-97d86cdcfd3d@infradead.org>
 <02a501d7388f$8dfb3b90$a9f1b2b0$@codeaurora.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <42ab3057-3b43-7f98-6387-6e79761d2d3f@infradead.org>
Date:   Fri, 23 Apr 2021 15:26:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <02a501d7388f$8dfb3b90$a9f1b2b0$@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/23/21 3:25 PM, Brian Cain wrote:
>> -----Original Message-----
>> From: Randy Dunlap <rdunlap@infradead.org>
> ...
>>> It's published as a container in the Gitlab Container Registry.  You can use
>> docker/podman to pull "registry.gitlab.com/qemu-
>> project/qemu/qemu/debian-hexagon-cross" in order to use it.
>>
>> Hi Brian,
>>
>> Maybe that will be useful to someone.
>>
>> However, I am looking for something like a tarball that I can download and
>> deploy locally, like one can find at these locations:
>>
>> https://toolchains.bootlin.com/
>> https://download.01.org/0day-ci/cross-package/
>> https://mirrors.edge.kernel.org/pub/tools/crosstool/
> 
> Randy,
> 
> 	I 100% agree, I would prefer a tarball myself.  I have been working with the team to produce the tarball and we haven't been able to deliver that yet.  No good excuses here, only bad ones: somewhat tied up in process bureaucracy.
> 
> I can share the recipe that was used to build the toolchain in the container.  No Dockerfile required, just a shell script w/mostly cmake + make commands.  All of the sources are public, but musl is a downstream-public repo because we haven't landed the hexagon support in upstream musl yet.

Hi Brian,
I can wait. :)

Thanks.

