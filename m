Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098AA3694D9
	for <lists+linux-arch@lfdr.de>; Fri, 23 Apr 2021 16:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239066AbhDWOhe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Apr 2021 10:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbhDWOhZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Apr 2021 10:37:25 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D07C06174A
        for <linux-arch@vger.kernel.org>; Fri, 23 Apr 2021 07:36:47 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id p12so35330014pgj.10
        for <linux-arch@vger.kernel.org>; Fri, 23 Apr 2021 07:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=uoOkccNDSms2R4LZsMg1sjMsmp7WtuEiZhaADKTqPMM=;
        b=a2X1O2GpUB1cmeStoxoytRyRwXSNa9srsnr2FVr6ocsOYkrx2cLMRNhSJr6gh4gE1M
         FUsr3/5t9rC1a/a3tZXV5ZJirxH/b4E5fKUz1sFdyjKZ7Dc8dj69fq9eC4GWfLn5lKI3
         0rssI18e+zs58t30w3bgVMnel8Ajs+IQ+dWcJcloeu2ooFOiOOjhpr6Pvg2+dqhBvHRO
         zptbyjoKv57PWMkAgoje2QcsVsiPTf3HLmNs5PhIPor+2FmNLa06Jxe8S7LDtZjm/Zzz
         eKASbMAgXAu9V9cbtUxjGlxXSVcUV0oCig4JsmtECZlmM1zMKE6rIOOJ86HQNCT5Tq77
         tyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=uoOkccNDSms2R4LZsMg1sjMsmp7WtuEiZhaADKTqPMM=;
        b=mOUwMMRWVrBXt0L3EM1B89Do4cO6Gph/AXlu/ovfvTgUWXNdbvWWgW2m1/2QoJ33hM
         QunK3njW4MTyW9JGIhl51a3h6GgOQX3wnMWIM6bMGsjsyytxXpXjmDmNXTGsjAgdphfX
         H+CtCs5yoaoaY1jpG6X/H82+L9fBGaorP/ksy+T1AxhvNpzQlu6Itv/ok+hAT6SgXv/o
         52mpOcycB1QMHlWR3vuETPkh1EwYiJwoBhdDZuOwtjj1TkFVHECOp6g4GzduhyXrv4eq
         g/abpA8lZG6OrdCeYawjqDXJoSdKjWvjp/IdcHVXaGgPIrk3Ap0KvRGM5d88hROdxgcw
         gKhQ==
X-Gm-Message-State: AOAM5322YxEtQwDhf9HLPqD0jpzvVYWRaJ2dL1p0+rUOJ2qwYtQp51nZ
        4m2UyJEi4v0rzIFAGIvJJ7sENN+Zzc5BIDj9
X-Google-Smtp-Source: ABdhPJxskERFqYIiVdaP/G0GpZFz42BGMcnIgrol0YG2i6ZSO+jJ7FOg1Lu5RjPTfKHv1TBAWs2s5Q==
X-Received: by 2002:a63:2204:: with SMTP id i4mr4098426pgi.76.1619188606622;
        Fri, 23 Apr 2021 07:36:46 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id u20sm5417753pgl.27.2021.04.23.07.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:36:45 -0700 (PDT)
Date:   Fri, 23 Apr 2021 07:36:45 -0700 (PDT)
X-Google-Original-Date: Fri, 23 Apr 2021 07:36:44 PDT (-0700)
Subject:     Re: [PATCH] asm-generic: Remove asm/setup.h from the UABI.
In-Reply-To: <CAK8P3a2+yCYm22g-r7aWE4RT7ZLcZn89aiWGcDhgFh_ZU3fSfQ@mail.gmail.com>
CC:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Arnd Bergmann <arnd@arndb.de>
Message-ID: <mhng-1f6be9fb-cb82-4a66-b23b-59b0c0d33b42@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 23 Apr 2021 02:09:46 PDT (-0700), Arnd Bergmann wrote:
> On Fri, Apr 23, 2021 at 4:57 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> From: Palmer Dabbelt <palmerdabbelt@google.com>
>>
>> I honestly have no idea if this is sane.
>>
>> This all came up in the context of increasing COMMAND_LINE_SIZE in the
>> RISC-V port.  In theory that's a UABI break, as COMMAND_LINE_SIZE is the
>> maximum length of /proc/cmdline and userspace could staticly rely on
>> that to be correct.
>>
>> Usually I wouldn't mess around with changing this sort of thing, but
>> PowerPC increased it with a5980d064fe2 ("powerpc: Bump COMMAND_LINE_SIZE
>> to 2048").  There are also a handful of examples of COMMAND_LINE_SIZE
>> increasing, but they're from before the UAPI split so I'm not quite sure
>> what that means: e5a6a1c90948 ("powerpc: derive COMMAND_LINE_SIZE from
>> asm-generic"), 684d2fd48e71 ("[S390] kernel: Append scpdata to kernel
>> boot command line"), 22242681cff5 ("MIPS: Extend COMMAND_LINE_SIZE"),
>> and 2b74b85693c7 ("sh: Derive COMMAND_LINE_SIZE from
>> asm-generic/setup.h.").
>>
>> It seems to me like COMMAND_LINE_SIZE really just shouldn't have been
>> part of the UABI to begin with, and userspace should be able to handle
>> /proc/cmdline of whatever length it turns out to be.  I don't see any
>> references to COMMAND_LINE_SIZE anywhere but Linux via a quick Google
>> search, but that's not really enough to consider it unused on my end.
>>
>> I couldn't think of a better way to ask about this then just sending the
>> patch.
>
> I think removing asm/setup.h from the uapi headers makes sense,
> but then we should do it consistently for all architectures as far
> as possible.
>
> Most architectures either use the generic file or they provide their
> own one-line version, so if we move them back, I would do it
> for all.

Ya, makes sense.  I just wanted to see if anyone had a reason for things 
being this way before I chased everything around.

> The architectures that have additional contents in this file
> are alpha, arm, and ia64. We I would leave those unchanged
> in that case.
