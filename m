Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3D4269C1A
	for <lists+linux-arch@lfdr.de>; Tue, 15 Sep 2020 04:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgIOCtZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Sep 2020 22:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgIOCtY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Sep 2020 22:49:24 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0508EC06174A;
        Mon, 14 Sep 2020 19:49:24 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id jw11so987945pjb.0;
        Mon, 14 Sep 2020 19:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=KwNAiWJRGAv99MLMgUjio/0RK3rO7RqLOWZGiQVH4cs=;
        b=HQMAsT5Cpi3ZVvE6aUzwNqCmoc+hJimdldWrYhjJnMo9GKThwYcs1ehJDOOYUfEVs+
         c3uIHv0eSV+/Z0EaTKGSN0/InpbN2a43KUp1UjVs/p7ytQ7/12/TwpUe89rkbOk+ztk2
         AUq6aYP4vM4W7iGIdlRtk5H29sBPyvTJ75Ftk5ae7rJuwT/W0LfBGl4ZV1Tt8923pp/l
         HPpe+vFnBMkWjZDyhcV9oiimti8Jj8XBzVm/TyprP09Q10iZ8r/fmMdMT2tJI7f0n/tx
         yF1uXbmYMJgORI4On7seltzHM8cbKJ3TjFjEKo+7e1XSTCybLnV0SAiFtd/DS4DwiSjq
         9wAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=KwNAiWJRGAv99MLMgUjio/0RK3rO7RqLOWZGiQVH4cs=;
        b=INlhVHAM0963k+ZIBU+v+yEbrz8Uli+/V7yikwQRe7XHCl58zF7H7SI7TYmBGl+mkS
         gnTAWoyxaclnpYWaDYnkjYxl0teh+gnZG2fyGYZJvYraUaF1UelzUlQO3t+uWga7G4Yn
         bqDiYdDR3ZVxqYPkfRWAnbPXm3Jf0VCMUIzpunvUSZcAfMuiUKIH71W74HOnGGk6ED0l
         Lq2xwrrvO+74n2E1OXJrucU6ic7UsRV5mxqizMrFKZUj8YlxS2FuUDIO/EGRa2t0jpAi
         V7+LM3H7q0Nt6sedtCkAntQ6d4J/c7QUDs2acBkG2f5YTqS2SI7Pqdubi/alOsCNXYQ3
         /wxA==
X-Gm-Message-State: AOAM532HQ2Ab8tBzOM5nZ8QaMkGGPdEoGCtkQM5caGyKk0MHO11DaYoB
        +HwUnEKuz2cRQcmyZlC59Lg=
X-Google-Smtp-Source: ABdhPJyTc6EOwxZ5jsKaWPo8x1RkVddn24PJQuDSbAXRaYhCLAyTFVl/PXqlACqvjkAx8OXV2NSCxw==
X-Received: by 2002:a17:90b:793:: with SMTP id l19mr2206291pjz.154.1600138163637;
        Mon, 14 Sep 2020 19:49:23 -0700 (PDT)
Received: from localhost ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id a9sm10556060pjm.40.2020.09.14.19.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 19:49:23 -0700 (PDT)
Date:   Tue, 15 Sep 2020 12:49:17 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 3/4] sparc64: remove mm_cpumask clearing to fix
 kthread_use_mm race
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>,
        "David S . Miller" <davem@davemloft.net>,
        linux-arch@vger.kernel.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>
References: <20200914045219.3736466-1-npiggin@gmail.com>
        <20200914045219.3736466-4-npiggin@gmail.com>
        <1600066040.vnmz9nxhwt.astroid@bobo.none>
        <CADxRZqxkB9tzO+nf56vFfvdYBooo1rqEbst=QGZQJA3jWhKLYw@mail.gmail.com>
In-Reply-To: <CADxRZqxkB9tzO+nf56vFfvdYBooo1rqEbst=QGZQJA3jWhKLYw@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1600138100.0flxk0qjzs.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Anatoly Pugachev's message of September 14, 2020 8:23 pm:
> On Mon, Sep 14, 2020 at 10:00 AM Nicholas Piggin <npiggin@gmail.com> wrot=
e:
>>
>> Excerpts from Nicholas Piggin's message of September 14, 2020 2:52 pm:
>>
>> [...]
>>
>> > The basic fix for sparc64 is to remove its mm_cpumask clearing code. T=
he
>> > optimisation could be effectively restored by sending IPIs to mm_cpuma=
sk
>> > members and having them remove themselves from mm_cpumask. This is mor=
e
>> > tricky so I leave it as an exercise for someone with a sparc64 SMP.
>> > powerpc has a (currently similarly broken) example.
>>
>> So this compiles and boots on qemu, but qemu does not support any
>> sparc64 machines with SMP. Attempting some simple hacks doesn't get
>> me far because openbios isn't populating an SMP device tree, which
>> blows up everywhere.
>>
>> The patch is _relatively_ simple, hopefully it shouldn't explode, so
>> it's probably ready for testing on real SMP hardware, if someone has
>> a few cycles.
>=20
> Nick,
>=20
> applied this patch to over 'v5.9-rc5' tag , used my test VM (ldom)
> with 32 vcpus.
> Machine boot, stress-ng test ( run as
> "stress-ng --cpu 8 --io 8 --vm 8 --vm-bytes 2G --fork 8 --timeout 15m" )
> finishes without errors.
>=20

Thank you very much Anatoly.

Thanks,
Nick
