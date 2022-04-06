Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA41A4F54A8
	for <lists+linux-arch@lfdr.de>; Wed,  6 Apr 2022 07:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343574AbiDFE7p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Apr 2022 00:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2360983AbiDFDoG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Apr 2022 23:44:06 -0400
Received: from gateway34.websitewelcome.com (gateway34.websitewelcome.com [192.185.148.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8FC296D2D
        for <linux-arch@vger.kernel.org>; Tue,  5 Apr 2022 17:12:14 -0700 (PDT)
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 0851D11889BB
        for <linux-arch@vger.kernel.org>; Tue,  5 Apr 2022 19:12:14 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id btHRnNn7pdx86btHRnnZaH; Tue, 05 Apr 2022 19:12:14 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=V34eNda++WlmGe+ZWCeqNhmRnpIlO8Tl6u7MFmXbztQ=; b=EbiyndnK4uoLFl5VhRQPS09z1S
        /yRo1ynqYNlThAxczGu1FqKJTEXcc6AlPe6vEEB8L3UVFwZAS9dtqH7Jnyvy/mwSfokN2SkZGR/WH
        A9JnbadYt3+rk4viOgIydnS0VTdSrBCt1CQFKo+FlZTvhcxjmneFzuATMeBe2BP4IpqDXacIFqK3W
        lzKjDTRgLJaD+jht1thLujSL4f3L5cH29a1ZqfO6TsXeNhqkAMo1tfbdhxVkjzJ5Bs4XamjDKoC4G
        QJzf5JMTZ9GE9dR2FWF4iun9VTKFbPPCAGFbHWTKAHHkNrt0BqRy2St1XGwRQlzmHx6Xr01d9Jpev
        Ot3jyP4A==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54732)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nbtHR-000mos-4N; Wed, 06 Apr 2022 00:12:13 +0000
Message-ID: <53e24114-fe48-91aa-1b76-78b12dfcdf4e@roeck-us.net>
Date:   Tue, 5 Apr 2022 17:12:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Max Filippov <jcmvbkbc@gmail.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
References: <Yib9F5SqKda/nH9c@infradead.org>
 <CAK8P3a1dUVsZzhAe81usLSkvH29zHgiV9fhEkWdq7_W+nQBWbg@mail.gmail.com>
 <YkmWh2tss8nXKqc5@infradead.org>
 <CAK8P3a0QdFOJbM72geYTWOKumeKPSCVD8Nje5pBpZWazX0GEnQ@mail.gmail.com>
 <20220405212653.GA2482665@roeck-us.net>
 <CAK8P3a396EkfQtmkwo80eB9i7F37S=mvrHtCLXhGDhHBczYK3g@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC PULL] remove arch/h8300
In-Reply-To: <CAK8P3a396EkfQtmkwo80eB9i7F37S=mvrHtCLXhGDhHBczYK3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nbtHR-000mos-4N
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54732
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 9
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/5/22 15:01, Arnd Bergmann wrote:
> On Tue, Apr 5, 2022 at 11:26 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> On Mon, Apr 04, 2022 at 03:07:06PM +0200, Arnd Bergmann wrote:
>>>
>>> Should we garbage-collect some of the other nommu platforms where
>>> we're here? Some of them are just as stale:
>>>
>>> 1. xtensa nommu has does not compile in mainline and as far as I can
>>> tell never did
>>>     (there was https://github.com/jcmvbkbc/linux-xtensa/tree/xtensa-5.6-esp32,
>>> which
>>>     worked at some point, but I don't think there was enough interest
>>> to get in merged)
>>
>> Hmm, I build and test nommu_kc705_defconfig in my test system.
> 
> What toolchain do you use for this? Max already pointed out my mistake
> regarding xtensa, which I thought does not build at all, but just needs
> a toolchain specific to the cpu.
> 

Home-built using buildroot. I have three different xtensa toolchains
(de212, dc232b, and dc233c). The toolchain for kc705_nommu needs the
de212 overlay; I think Max pointed to to the information needed
to build the compiler. Buildroot has the "XTENSA_OVERLAY_FILE"
option to specify the compiler overlay file for the target.

Guenter
