Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D2A3CCC8D
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jul 2021 05:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbhGSDSw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 18 Jul 2021 23:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbhGSDSv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 18 Jul 2021 23:18:51 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3886C061762
        for <linux-arch@vger.kernel.org>; Sun, 18 Jul 2021 20:15:52 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id my10so10532176pjb.1
        for <linux-arch@vger.kernel.org>; Sun, 18 Jul 2021 20:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=A0RwgPQGJrc23vgBFxOPp4E1hoFr61XtuLyv5X/G1b4=;
        b=r3SJ8BZWR20u9aJjNmUQ5SDbgL4Y24EtCIr/jbWPjsCb8PgpBTpL+wJ4/7OVx0mXRi
         Cekir0U8s+VReASNOnWajbYpy5VUjV4Lqa6Q/DlRd12ud4HBGxZcptLLjLBXxoiLTxKx
         X9PARsWeen3Wkk1SAtoxcFdLNm/uX+AcX3GCLiWdSc+THshSUoOuKw2I34RujkbAN1iE
         CYaHupXR1tW5io/uDKVB6tfbHWfHcx443tLZFeduB3o/rLcmiwmLAVJp6ciAfCELEdgm
         2DohpVL28HDFtQX/hojilfxySfTZiuytFzk5YhvmA5nEbQpSMSp8f9iBMoxfYIADX3LW
         yKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=A0RwgPQGJrc23vgBFxOPp4E1hoFr61XtuLyv5X/G1b4=;
        b=mlfRfgCjlz+2Dl0tn9RnIpDB1uxqupAZN++02DHIcoXmBXs6Pxbtf3IwugI3XzXxCH
         lXkVyLwy5jbKieyC4DbRh2mkUNBL7OEJxxfCUHBDXcS6Ir9nfgcVe/aM1FnaHlQR48S4
         3yeKkp24mA3tLchCcg1nJuJTgONI1d655dCTJAuQsIUhJzjdD3Ag1rZGlrWMM9cWvXgT
         9chtf0uL1wERbfP/R+ppBkwOG8+y2Cgg0yN9sAvjkLkTh3Ep/OXAGmEQG6DSCVrYKz4x
         2FYN2LPEmyN2m0woNU7rSEn4Nsu6wYxRUpygqq4mrrpavTufgAenWYTOi+ZEK7RSW0No
         TsRw==
X-Gm-Message-State: AOAM532kmh18wek0PAt45bnUAdFsjSI0BuqMUdUmp7n/HOsTnyeoUBlj
        KED54lX5kDUanQAu7hu5XnU=
X-Google-Smtp-Source: ABdhPJwxQVnbf6De3mHEV80Kfnfk/WVI0UOwdDLQxwgZEyZQ7W31qteUxNBBqSYWWsrAl1TnEaoa7A==
X-Received: by 2002:a17:90a:642:: with SMTP id q2mr27991332pje.205.1626664552208;
        Sun, 18 Jul 2021 20:15:52 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-37-fibre.sparkbb.co.nz. [222.152.189.37])
        by smtp.gmail.com with ESMTPSA id g27sm19150222pgl.19.2021.07.18.20.15.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Jul 2021 20:15:51 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] m68k: Improved switch stack handling
To:     Brad Boyer <flar@allandria.com>
References: <1624407696-20180-1-git-send-email-schmitzmic@gmail.com>
 <87zgunzovm.fsf@disp2133> <3b4f287b-7be2-0e7b-ae5a-6c11972601fb@gmail.com>
 <1b656c02-925c-c4ba-03d3-f56075cdfac5@gmail.com> <8735scvklk.fsf@disp2133>
 <e9009e13-cfec-c494-0b3b-f334f75cd1e4@gmail.com>
 <af434994-5c61-0e3a-c7bc-3ed966ccb44f@gmail.com> <87a6mj99vf.fsf@igel.home>
 <1ebfb9de-de16-d05c-ea15-a110857fe284@gmail.com>
 <20210718205956.GA802@allandria.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, geert@linux-m68k.org,
        linux-arch@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        torvalds@linux-foundation.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <47fb6c7e-30e2-0525-9b2a-c8430a9bfa38@gmail.com>
Date:   Mon, 19 Jul 2021 15:15:44 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <20210718205956.GA802@allandria.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Brad,

Am 19.07.2021 um 08:59 schrieb Brad Boyer:
> On Mon, Jul 19, 2021 at 07:47:19AM +1200, Michael Schmitz wrote:
>> Somewhere in entry.S is
>>
>> addql   #8,%sp
>> addql   #4,%sp
>>
>> - is that faster than
>>
>> lea     12(%sp),%sp ?
>
> On the 68040 the timing can depend on the other instructions around
> it. Each of those addql instructions is listed as 1 and 1 for
> fetch/execute, while that lea is listed as 2 and 1L+1 meaning that
> it could potentially be faster depending on the behavior of the
> instruction that preceded it thorough the execute stage. That one
> free cycle if the stage is busy (due to the 1L) could make it
> effectively faster since the first addql would have to wait that
> extra cycle in that case.
>
> On the 68060, it looks like the lea version is the clear winner,
> although the timing description is obviously much more complicated
> and thus I might have missed something. From a quick look, it
> seems that lea takes the same time as just the first addql.
>
> On CPU32, the lea version loses due to the extra 3 cycles from
> the addressing mode, even though the base cycles of lea are the
> same as for addql (2 cycles each). The lea might be even worse
> if it can't take advantage of overlapping the surrounding
> instructions (1 cycle before and 1 after).
>
> Those are the only ones I already have the documentation in my
> hands. I haven't checked older classic cores or coldfire, but
> it does seem like it is specific to each chip which is faster.
>
> Obviously both versions would be the same size (2 words).

Thanks, best leave it as is then.

Cheers,

	Michael
