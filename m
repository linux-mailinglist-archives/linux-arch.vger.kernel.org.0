Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4D92307C4
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 12:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgG1Khm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jul 2020 06:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbgG1Khl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jul 2020 06:37:41 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A18CC061794;
        Tue, 28 Jul 2020 03:37:41 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d1so9663158plr.8;
        Tue, 28 Jul 2020 03:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=5++a4qUoGvTtmbS8cBbdYfFdi2BqF+dka2SzgddlKxI=;
        b=reUkHy/upDbi7FrzED0Yyk31NO19ZwYH83HIqIY7wQwbr3E4ahJNvkEJNa4WDNMcD0
         6q66usnWreJz0RKRzJCtHjN/C+VbRWC/gYcAjYB7jznoR5c3xtCqGvCllJhroqxrWEK8
         WU0ktdcGCI9+ujV6pdxUITAu6o5prhxZ/T3kLUzdo1Bw+kJ7QyEBMu/yyCZujHpwR1Gk
         lugSa9uEIHuJ3n/VO7PV5MisQt4bHQ6Oc5T+KAPYfhZSHq1+VBpmpDelpeo9HsM2E+yZ
         tG/gLwi3Y4Ooxoguret5gRQKA4VLZMVMkyYBHthlIreQxOaQViK8XL0sc/khjVM2/P6G
         vgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=5++a4qUoGvTtmbS8cBbdYfFdi2BqF+dka2SzgddlKxI=;
        b=hybbwWH0bbVnQDRFk+8udA39PdA5bYp2kP2juXjiKAZHfD+V2z8gB040cuErSBIUu2
         D8Li1DlIE2m3yasgSkEueFlkKLjjuZxgfXpsLUklj+8cVYqMbnNR5n5inNU0259iBOzc
         d2Kh2k8UpY+szNOWcTlJLEa+IOWgJeEjdh7q1Thalc/M/yu1bysPaujCTmSg8XVHZaez
         lBxyl7rSRUAOks/DHqMci82MSimoDtpAJJki6nPy1etl9gxtvHk5G98puRFObBIc9LBg
         LMyLV0JJHsyvXWjA8mRDUCcFmGAZbJmpkkeCTyAEejGKJm1Tzhz605jKFNoyUA4j2WTM
         IK7g==
X-Gm-Message-State: AOAM532qM+qURwSWqc2nb+74fmbPhh22V+mvwmMMcbWRZdqDKwc3Mc+9
        fKCIP10sLtrGjxEzWm2utxnJL2C8
X-Google-Smtp-Source: ABdhPJwVrLwph50FIXRt5B+ywFoKZvGGyXpS2YKkXOReJgJvV2vg6ygDdt0e1KPG7SDjhDzEBQVaAQ==
X-Received: by 2002:a17:90a:6946:: with SMTP id j6mr3340756pjm.223.1595932660968;
        Tue, 28 Jul 2020 03:37:40 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id x8sm5987747pfp.101.2020.07.28.03.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 03:37:40 -0700 (PDT)
Date:   Tue, 28 Jul 2020 20:37:34 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 01/24] asm-generic: add generic versions of mmu context
 functions
To:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20200728033405.78469-1-npiggin@gmail.com>
        <20200728033405.78469-2-npiggin@gmail.com>
        <12ac3789-71a5-2756-6a9e-769302c7b3c6@synopsys.com>
In-Reply-To: <12ac3789-71a5-2756-6a9e-769302c7b3c6@synopsys.com>
MIME-Version: 1.0
Message-Id: <1595931748.6mal1nph7g.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Vineet Gupta's message of July 28, 2020 2:01 pm:
> On 7/27/20 8:33 PM, Nicholas Piggin wrote:
>> Many of these are no-ops on many architectures, so extend mmu_context.h
>> to cover MMU and NOMMU, and split the NOMMU bits out to nommu_context.h
>>=20
>=20
>> -static inline void switch_mm(struct mm_struct *prev,
>> -			struct mm_struct *next,
>> -			struct task_struct *tsk)
>> +/**
>> + * activate_mm - called after exec switches the current task to a new m=
m, to switch to it
>> + * @prev_mm: previous mm of this task
>> + * @next_mm: new mm
>> + */
>> +#ifndef activate_mm
>> +static inline void activate_mm(struct mm_struct *prev_mm,
>> +			       struct mm_struct *next_mm)
>>  {
>> +	switch_mm(prev_mm, next_mm, current);
>>  }
>> +#endif
>=20
> Is activate_mm() really needed now. It seems most arches have
>    activate_mm(p, n) -> switch_mm(p, n, NULL)
>=20
> And if we are passing current, that can be pushed inside switch_mm()

Thanks for taking a look, I think there may be more consolidation
like this possible, and certainly some of the arch patches could
have gone a bit further.

I wanted to be fairly careful to make only quite trivial changes
(only the obvious no-ops) for the first iteration, but once this
is in the tree it should become a fair bit easier to do some
of your suggestions.

There's a few things that make activate_mm->switch_mm not quite
simple - alpha, nios2, parisc, s390, maybe x86.

Thanks,
Nick
