Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450803D4C8F
	for <lists+linux-arch@lfdr.de>; Sun, 25 Jul 2021 09:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhGYHD7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 25 Jul 2021 03:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhGYHDs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 25 Jul 2021 03:03:48 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D570C061757
        for <linux-arch@vger.kernel.org>; Sun, 25 Jul 2021 00:44:18 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso15213974pjb.1
        for <linux-arch@vger.kernel.org>; Sun, 25 Jul 2021 00:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=+1CbdclIXuS1P33C/qOefRO4xRhZbvNeuMXF7mLBa/s=;
        b=aDPvLHd+7NX40ZNQoGa9jAavZjPCXEHcyA0+ZqYOnaoHL7F9A2v23PivByt1lM9TGw
         /sYZQYl1JbQ8W9iV87dr6PT5hHAhgtgTjpyx1SnCmYdZ6FtAdno5HHkSVAcKArF+tU6w
         9WjVKMGvngbXXW/dHwpDHRCWPp7h/TF0Eb9Y4ymzTH7pjd3wZ1vM5wpONu0I2Wkbj3Tl
         IsSjL6nzLXH8we71PbgxBA6wN9IxthU8bTFCZXecolnbDoVu7LUOzAMyy2ads3ODka3c
         ia7ZHadxoJsUSJO1W2MbdwG147tagPaJOeEdvzb/w5k3AeMau01wI9vk5oiGqQXxPIEO
         l+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=+1CbdclIXuS1P33C/qOefRO4xRhZbvNeuMXF7mLBa/s=;
        b=gDxX2abRynFIxLyXSKpPUWDvlFe6uXxDPU9fEeyJoD8IZETOAUdQ2RADa6HXKNPIvU
         f8x9AexwYS6glRSXDmBCdWf9SFr1HSjbsYQ/s0szJRD416yAK0Jpt8jIkR1Z8snVeY+i
         3blgkXwZzeglq1XBBeimA90BPpOtghJDOV50cqZY6Y2SHG9q/eMn21tOsL4WsgXcuhMW
         8liSETSGbpRr0j6jczTNHjXPPwv9b7uk6hYaQvLyLJduaUTTDm+IONXcJlo3kDhnkqRD
         BEb263D42zql6xDLGpXQemNH41awEjChDqALVxETQVG0wN6NTMmknX1dx8tePrfVhH1M
         OxTA==
X-Gm-Message-State: AOAM533E3Zm+/mbpMzqfg5Hy6tAaqT1qSPMphXbIJH/RdLChjUTlUBH4
        FXw1ybplWDu8ZGRv82UE+QU=
X-Google-Smtp-Source: ABdhPJxttcbg9hC5V+iz0fNwTi+hh/7+6jW7G99v9FTUrNl20QgnDLuW3tGew4ZkT9Vqe7bBUjXYRg==
X-Received: by 2002:a17:90b:209:: with SMTP id fy9mr11546856pjb.187.1627199057549;
        Sun, 25 Jul 2021 00:44:17 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-37-fibre.sparkbb.co.nz. [222.152.189.37])
        by smtp.gmail.com with ESMTPSA id f11sm45050500pga.61.2021.07.25.00.44.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Jul 2021 00:44:17 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] m68k: Improved switch stack handling
To:     Andreas Schwab <schwab@linux-m68k.org>
References: <1624407696-20180-1-git-send-email-schmitzmic@gmail.com>
 <87zgunzovm.fsf@disp2133> <3b4f287b-7be2-0e7b-ae5a-6c11972601fb@gmail.com>
 <1b656c02-925c-c4ba-03d3-f56075cdfac5@gmail.com> <8735scvklk.fsf@disp2133>
 <e9009e13-cfec-c494-0b3b-f334f75cd1e4@gmail.com>
 <af434994-5c61-0e3a-c7bc-3ed966ccb44f@gmail.com> <87h7gopvz2.fsf@disp2133>
 <328e59fb-3e8c-e4cd-06b4-1975ce98614a@gmail.com> <877dhio13t.fsf@disp2133>
 <12992a3c-0740-f90e-aa4e-1ec1d8ea38f6@gmail.com> <87tukkk6h3.fsf@disp2133>
 <df6618bf-d1bc-4759-2d14-934c22d54a83@gmail.com> <87eebn7w7y.fsf@igel.home>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>, geert@linux-m68k.org,
        linux-arch@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        torvalds@linux-foundation.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <db43bef1-7938-4fc1-853d-c20d66521329@gmail.com>
Date:   Sun, 25 Jul 2021 19:44:11 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <87eebn7w7y.fsf@igel.home>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Andreas,

Am 25.07.2021 um 00:05 schrieb Andreas Schwab:
> On Jul 24 2021, Michael Schmitz wrote:
>
>> According to my understanding, you can't get a F-line exception on
>> 68040.
>
> The F-line exeception vector is used for all FPU illegal and
> unimplemented insns.

Thanks - now from my reading of the fpsp040 code (which has mislead me 
in the past), it would seem that operations like sin() and exp() ought 
to raise that exception then. I don't see that in ARAnyM.
Is there any emulator that correctly emulates the 68040 FPU in that regard?

Cheers,

	Michael

