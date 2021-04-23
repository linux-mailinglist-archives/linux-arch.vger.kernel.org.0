Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DE8369C32
	for <lists+linux-arch@lfdr.de>; Fri, 23 Apr 2021 23:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243974AbhDWVsQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Apr 2021 17:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbhDWVsL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Apr 2021 17:48:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E90C061574;
        Fri, 23 Apr 2021 14:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=9SDxtZJGQ1vsrHdafRND0IxuvMBmwHOT0zn6oXkRby4=; b=RtQfEAMItnCyiK9Kx0x33SBu+X
        OSrBbfHudGlqZfJaAyhBJx1X9MZD6xeZLR0qVlqYKtiyd04GT6FAK/5ziTRnJkx2AQ58yNWrvSRY5
        Qop/h/g7FrzEiRYwDaMYRgOSznahEqKubzAuOdJlTGZ5kMWHx0GD0108el7ZWOJWhB/e71uv6JdWs
        LQoUCZKPgDG2D6cbtN+tgfaY5U4HtKKKs6mPlOBGuqnFqvIGRTd9BTLjjo1vwFLY62Y1Xp2jrEk6H
        qQDgP8cSFFLGoSh/0IcbXvEwL8lUxdxVD6NZ1ovtXfvK4ciBNH4cDDoOPC3xTYQtc0bK8LUUzFLcO
        LtjS1wcw==;
Received: from [2601:1c0:6280:3f0::df68]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1la3e7-002Rx4-6A; Fri, 23 Apr 2021 21:47:31 +0000
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
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <24da08a4-e055-d8ac-8214-97d86cdcfd3d@infradead.org>
Date:   Fri, 23 Apr 2021 14:47:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <027401d7387e$f5630120$e0290360$@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/23/21 1:26 PM, Brian Cain wrote:
>> -----Original Message-----
>> From: bcain=codeaurora.org@codeaurora.org
> ... 
>> There is a hexagon cross toolchain used for testing QEMU (userspace) guest
>> code test cases.  This same toolchain can be used to build the kernel.  I will
>> share a reference to that toolchain, standby.
> 
> It's published as a container in the Gitlab Container Registry.  You can use docker/podman to pull "registry.gitlab.com/qemu-project/qemu/qemu/debian-hexagon-cross" in order to use it.

Hi Brian,

Maybe that will be useful to someone.

However, I am looking for something like a tarball that I can download
and deploy locally, like one can find at these locations:

https://toolchains.bootlin.com/
https://download.01.org/0day-ci/cross-package/
https://mirrors.edge.kernel.org/pub/tools/crosstool/


thanks.
-- 
~Randy

