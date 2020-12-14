Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9112D9303
	for <lists+linux-arch@lfdr.de>; Mon, 14 Dec 2020 06:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405889AbgLNFyg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Dec 2020 00:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406070AbgLNFy1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Dec 2020 00:54:27 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27373C0613CF;
        Sun, 13 Dec 2020 21:53:47 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id p21so4331724pjv.0;
        Sun, 13 Dec 2020 21:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=NqlRmCcPn1hL++OXjNViT5mh7QFqv3t1WGYe29FT4N0=;
        b=OU2rJ+vKQqYkt0zKH+mic4jtuIu5GNnbiOiORyCT+A09h9fwQVJL2rUCwqMLf/iuvX
         9ZevRGt+gw00mt8IToXd9T4cMAxsajKDwuMJ3rHqXjunXGxeic1yFQN6+BViqPc3jG7q
         EHj/gFwO3qj7id91+Aj8fVSteXlSH1WbD3B2ObgpDbyX8867Mu/Zc/nZkwqf3u3MeTWQ
         GUeAIzmYgifLuP+jbiHnVevOjjad1G3brEZa0Wsx/7D97e94816uenMsagjZ4YzhON5a
         kRKy8l2UgGjX8qjPTJPf7BQTJmLavUTfJA2Wx7MZfep/q6BF6KkbSj6Q3l16mESODtcO
         iBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=NqlRmCcPn1hL++OXjNViT5mh7QFqv3t1WGYe29FT4N0=;
        b=ShmvmuBd0/4q349HXDI8yRIxn4N5aMv7gisZrwKsG4FZCPeqDUTMV5tdlQX/ybiCC1
         kE3saPlMBsSRtfU3BLe77r1Gnd5e5vwjybzpAmbL1UKF0Xq427mocJlx0BYqXiwaBrsS
         Cliq5B17Bk6w5zxFgyjbAKG8Kh4fNb61SLyCs6vrqSFPdoKmw5vkw083b8OdpGf/GYBZ
         qc/86XZipWlkO2pi9zBno7BKaB7RNh9A7fy7+ou48WkT6ov9AhW33ROwJjztVev0k88S
         sEUaUB3m3b1WJ2IsvM0smpJDG+dnfHUQUsQUTSd31K8Yg23IIEA1qEOpkK+0AzBSmw08
         ol9A==
X-Gm-Message-State: AOAM5327PZUnpFxzpXqfL6MgaT2gBfqudDERrkD4BS1w5Udw9fPGS/OU
        +4B70DiVHOsRrHAM7EC+MU4sTFDgDvk=
X-Google-Smtp-Source: ABdhPJwf3b9TbWiNhAad5JT/pHJRZTvkOiZpc3S6PMZHL+xFsjBjgGypaMaAxP447A+pDMg1mPexiA==
X-Received: by 2002:a17:90a:fb92:: with SMTP id cp18mr23372071pjb.203.1607925226593;
        Sun, 13 Dec 2020 21:53:46 -0800 (PST)
Received: from localhost ([220.240.228.148])
        by smtp.gmail.com with ESMTPSA id v126sm17639802pfb.137.2020.12.13.21.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 21:53:45 -0800 (PST)
Date:   Mon, 14 Dec 2020 15:53:40 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/8] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>
References: <1607152918.fkgmomgfw9.astroid@bobo.none>
        <116A6B40-C77B-4B6A-897B-18342CD62CEC@amacapital.net>
        <1607209402.fogfsh8ov4.astroid@bobo.none>
        <CALCETrWFjOXAd5=ctX3tzgUbyfwM+bT-f8WY_QWOeuDdFxhWbg@mail.gmail.com>
        <1607224014.8xeujbleij.astroid@bobo.none>
        <CALCETrV5BzXuUYm5YAoEKPZZPfLrbHckvwBHzWKrxZS8hqzHEg@mail.gmail.com>
        <1607918323.6muyu2l982.astroid@bobo.none>
In-Reply-To: <1607918323.6muyu2l982.astroid@bobo.none>
MIME-Version: 1.0
Message-Id: <1607924970.hd6nln4qe5.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Nicholas Piggin's message of December 14, 2020 2:07 pm:
> Excerpts from Andy Lutomirski's message of December 11, 2020 10:11 am:
>>> On Dec 5, 2020, at 7:59 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
>>>
>>=20
>>> I'm still going to persue shoot-lazies for the merge window. As you
>>> see it's about a dozen lines and a if (IS_ENABLED(... in core code.
>>> Your change is common code, but a significant complexity (which
>>> affects all archs) so needs a lot more review and testing at this
>>> point.
>>=20
>> I don't think it's ready for this merge window.
>=20
> Yes next one I meant (aka this one for development perspective :)).
>=20
>> I read the early
>> patches again, and I think they make the membarrier code worse, not
>> better.
>=20
> Mathieu and I disagree, so we are at an impasse.

Well actually not really, I went and cut out the exit_lazy_tlb stuff
from the patch series, those are better to be untangled anyway. I think=20
an earlier version had something in exit_lazy_tlb for the mm refcounting=20
change but it's not required now anyway.

I'll split them out and just work on the shoot lazies series for now, I
might revisit exit_lazy_tlb after the dust settles from that and the
current membarrier changes. I'll test and repost shortly.

Thanks,
Nick
