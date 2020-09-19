Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3283270FF8
	for <lists+linux-arch@lfdr.de>; Sat, 19 Sep 2020 20:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgISSRP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Sep 2020 14:17:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48053 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgISSRP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Sep 2020 14:17:15 -0400
X-Greylist: delayed 3714 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Sep 2020 14:17:15 EDT
Received: from [IPv6:2601:646:8600:3281:3892:da5e:7968:73ae] ([IPv6:2601:646:8600:3281:3892:da5e:7968:73ae])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 08JHEM9L2313785
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sat, 19 Sep 2020 10:14:23 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 08JHEM9L2313785
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020082401; t=1600535664;
        bh=TomeH5PNcgCZORugcfr47WwuZ6caRoe13lS8klRI7FE=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=RVdbsWF0vN/r1byPIFa+D4/5xhRqE5r5iFnS9koO9lEmqPLZuHRSQffS6Fa8JP1Sh
         O9ah5EJazBZMEzz68apZaO0d54DX4jsb0qkjZQKjSAbFdXoZHhQSevkbjwIjA0NJkl
         I8ioFyQFROS0bYKb/YpZ6+r4gkfiXQpEpUyNXhM7Qx4g9SxJg+LDavWV98Hg3xPKUr
         gKzZm+f5SnmGR4pwSY+CGoLXzD3AlcAWlNuW0DZmjyL+I8wj2r+YYFWTYlClTh+GCm
         /ln/hVW0Ju5cvNREPAAwdvDcCpvc0aH2Xvj2p2LzdQYeTrrSsbjierhVMGddz7uVeR
         TC9s0a40rK/kg==
Date:   Sat, 19 Sep 2020 10:14:13 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CALCETrVDqHG2chDsLWBHF39SXh6vjzE_xcEs+AWgOg5531BLuQ@mail.gmail.com>
References: <20200918132439.1475479-1-arnd@arndb.de> <20200918132439.1475479-2-arnd@arndb.de> <20200919053514.GI30063@infradead.org> <CALCETrVDqHG2chDsLWBHF39SXh6vjzE_xcEs+AWgOg5531BLuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/4] x86: add __X32_COND_SYSCALL() macro
To:     Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, kexec@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>, Brian Gerst <brgerst@gmail.com>
From:   hpa@zytor.com
Message-ID: <85F32523-4E9E-443A-A150-10A9E5EB0CE3@zytor.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On September 19, 2020 9:23:22 AM PDT, Andy Lutomirski <luto@kernel=2Eorg> w=
rote:
>On Fri, Sep 18, 2020 at 10:35 PM Christoph Hellwig <hch@infradead=2Eorg>
>wrote:
>>
>> On Fri, Sep 18, 2020 at 03:24:36PM +0200, Arnd Bergmann wrote:
>> > sys_move_pages() is an optional syscall, and once we remove
>> > the compat version of it in favor of the native one with an
>> > in_compat_syscall() check, the x32 syscall table refers to
>> > a __x32_sys_move_pages symbol that may not exist when the
>> > syscall is disabled=2E
>> >
>> > Change the COND_SYSCALL() definition on x86 to also include
>> > the redirection for x32=2E
>> >
>> > Signed-off-by: Arnd Bergmann <arnd@arndb=2Ede>
>>
>> Adding the x86 maintainers and Brian Gerst=2E  Brian proposed another
>> problem to the mess that most of the compat syscall handlers used by
>> x32 here:
>>
>>    https://lkml=2Eorg/lkml/2020/6/16/664
>>
>> hpa didn't particularly like it, but with your and my pending series
>> we'll soon use more native than compat syscalls for x32, so something
>> will need to change=2E=2E
>
>I'm fine with either solution=2E

My main objection was naming=2E x64 is a widely used synonym for x86-64, a=
nd so that is confusing=2E

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
