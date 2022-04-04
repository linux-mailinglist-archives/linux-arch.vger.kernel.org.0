Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264664F204A
	for <lists+linux-arch@lfdr.de>; Tue,  5 Apr 2022 01:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbiDDXep (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 19:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbiDDXei (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 19:34:38 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A0B53E10
        for <linux-arch@vger.kernel.org>; Mon,  4 Apr 2022 16:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649115159; x=1680651159;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pLgGUw+vPL0f2qNaYJgXPaqC3PncPyo5PXkVMywvCnI=;
  b=BZX3CP8/F9tCg8RWMFhixNUiNEXWzX3TlCDgU98H4l+vZC6ickL+aFLq
   dtBGGeiB164WMJ/A8odW3/pwrn+yOoseSJOGdm4uX06/QVFUCMJ/ELJkv
   ySDNUQkqFMCVgvtVTyAWdO+eC9tlrt4LsMyay5iV3tCqPtjZLbchPaDeG
   paGoSdVJHTIrtyIVkaXnzae/gshgvhWsAoYn2Md/wQAHc7wlEKZFzvT2S
   Jaz9wXk6opsYZX2akiTdP7k2PQk27zxGrdDWv1WfyfhIaEKxiITBXFY36
   kd1U1ptqTzZJCJr6GSmEijBskKJkubSqpHZLPELpBAxnbUxMGsMn28GUO
   g==;
X-IronPort-AV: E=Sophos;i="5.90,235,1643644800"; 
   d="scan'208";a="197083899"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Apr 2022 07:32:39 +0800
IronPort-SDR: 1kkWDmFXZhmaYC8aUHw/Q86s+x4QGlJB4Zt4ouHpChZp0V39y3Ha65FiUNVWNuNIn5tLEAlfe1
 pVcAJZp8tiK6n+XuTRnn9c9IbJ2F/J89iUxKo6rFs9C6xpmswwYMdjBfxZfALNps6mrs/bLEmY
 G/Ert6OfOcy03/SbYEaYJTYRbdMmz37HwRjeYroPRxw1Oo07wz2OQ9ZgSi9qmcCJ0Jk+fTEKXj
 mEfF4Eym/szYKLfkgXhFCQcBujI9tOUjODSEQu2KeQ9YZROhEpsbrxPBDpcmcfNpCt3mCd9wIX
 I0AiSZMYPD2DikxqUokvefAY
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Apr 2022 16:04:13 -0700
IronPort-SDR: iYyA2JKWYvNcPdKoMU6yjlBZXZashTf+8MP+5Jvdjz7s1PUDS18vKCYvaQWv6FTgGYgEZl3FQ6
 1tcSc7DazW6fMXxkkcfnlQ3YKZ8u+xa53V9YxRcBjGlPVLOvqw5Kwj7apeLG8jXv5wqn+AMf8o
 D6kAeA971k9Ik+9tKQD9jQfpKjiOjnwtyyGdrVcajdW86fHJHfj5Kg144HTi9hDsKxzhDtdaIz
 NI9htkYJ1p7EGQZf1CxF/TaFfh7I6GY3urm/fjj1Vog8ShJFVXpbDrKyAypLqJvJEptbH1Wmq+
 IDY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Apr 2022 16:32:40 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KXRs336L5z1SVp2
        for <linux-arch@vger.kernel.org>; Mon,  4 Apr 2022 16:32:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649115158; x=1651707159; bh=pLgGUw+vPL0f2qNaYJgXPaqC3PncPyo5PXk
        VMywvCnI=; b=DsQwEUOHxmoyYjbqt0O4dSEqkX6mn74teU8i5hG7gGn19np5Ssm
        GIE656sjlT9QTO3LfPnL96yX2h8GQmo+jZkabPUKMYyiiamMchLR0GjFhoTnbt7g
        oIbfU5S45I5mjqIj61A0TuY78vyQxp1vqMtubbVkB1juisa1031oQi7wbhIxApAP
        PAG5Yx1VSgEoWuALJtCtcayHafDyEFR7YD5eTEJWmU5Zgj3mZHTH6jhqQd6FYPZD
        9a6e2IhJLN5XGMJ3eK+8g5G1VN/EUfgvifjiux9bfsgE6vdYi3pLEjjvCVIGM7+X
        i6X8v1nLKnVL1NVU/Sr+/ilU+zfNKL956BA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eQTId0sJgeV0 for <linux-arch@vger.kernel.org>;
        Mon,  4 Apr 2022 16:32:38 -0700 (PDT)
Received: from [10.225.163.2] (unknown [10.225.163.2])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KXRs01Sxyz1Rvlx;
        Mon,  4 Apr 2022 16:32:36 -0700 (PDT)
Message-ID: <ff20532f-7399-5fcb-d867-772a3e0fc8f1@opensource.wdc.com>
Date:   Tue, 5 Apr 2022 08:32:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PULL] remove arch/h8300
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAK8P3a0QdFOJbM72geYTWOKumeKPSCVD8Nje5pBpZWazX0GEnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/4/22 22:07, Arnd Bergmann wrote:
> On Sun, Apr 3, 2022 at 2:43 PM Christoph Hellwig <hch@infradead.org> wrote:
>>
>> On Tue, Mar 08, 2022 at 09:19:16AM +0100, Arnd Bergmann wrote:
>>> If there are no other objections, I'll just queue this up for 5.18 in
>>> the asm-generic
>>> tree along with the nds32 removal.
>>
>> So it is the last day of te merge window and arch/h8300 is till there.
>> And checking nw the removal has also not made it to linux-next.  Looks
>> like it is so stale that even the removal gets ignored :(
> 
> I was really hoping that someone else would at least comment.
> I've queued it up now for 5.19.
> 
> Should we garbage-collect some of the other nommu platforms where
> we're here? Some of them are just as stale:
> 
> 1. xtensa nommu has does not compile in mainline and as far as I can
> tell never did
>    (there was https://github.com/jcmvbkbc/linux-xtensa/tree/xtensa-5.6-esp32,
> which
>    worked at some point, but I don't think there was enough interest
> to get in merged)
> 
> 2. arch/sh Hitachi/Renesas sh2 (non-j2) support appears to be in a similar state
>     to h8300, I don't think anyone would miss it
> 
> 8<----- This may we where we want to draw the line ----
> 
> 3. arch/sh j2 support was added in 2016 and doesn't see a lot of
> changes, but I think
>     Rich still cares about it and wants to add J32 support (with MMU)
> in the future
> 
> 4. m68k Dragonball, Coldfire v2 and Coldfire v3 are just as obsolete as SH2 as
>    hardware is concerned, but Greg Ungerer keeps maintaining it, along with the
>    newer Coldfire v4 (with MMU)
> 
> 5. K210 was added in 2020. I assume you still want to keep it.

Still working on this one, I would like to keep it.

> 
> 7. Arm32 has several Cortex-M based platforms that are mainly kept for
>     legacy users (in particular stm32) or educational value.
> 
> 
>        Arnd
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


-- 
Damien Le Moal
Western Digital Research
