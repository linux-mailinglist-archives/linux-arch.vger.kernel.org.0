Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E30E36D0EB
	for <lists+linux-arch@lfdr.de>; Wed, 28 Apr 2021 05:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbhD1DgL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Apr 2021 23:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhD1DgG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Apr 2021 23:36:06 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2A9C061574
        for <linux-arch@vger.kernel.org>; Tue, 27 Apr 2021 20:35:22 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id h7so3471577plt.1
        for <linux-arch@vger.kernel.org>; Tue, 27 Apr 2021 20:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=pkolduBNLLIr5vIIXbQQOt2wpdaq8aKiRXOt5tHWv0k=;
        b=AQ8FCd36kKveqrMIgf7gDWhpb3Z2GF9RhV+CpYRyHF3aTCzjysEv4uLA3Nc/ctIMr1
         FPYLA4bAcRcw0su3LPEK77MXyoAK1/Y0Kawr+7hLLF5oY+4FkGXkSEvuPhWoN40Lw7pj
         MF0NKPcfpE+yM+YAm1UFH3Rh4SP/4nCVjmtJqeruOH2yFL67Pxcxu1nnAPBX227IDRen
         tfG9YMFGLaLIFrKrkCHETFFYXO3IS/QADhw2OmI1EnYSlDeeji820daFlYUT6Kni+/dw
         2I/AOw8spRHZRiip3Gq186c8GufOHoaHt45x0NqHXlU3DHaIFkR4frwxh405j4erOK2O
         ftEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=pkolduBNLLIr5vIIXbQQOt2wpdaq8aKiRXOt5tHWv0k=;
        b=irqV3oXw6I+pOnmu/4ByNyShqpxkexP7WlfFHoJXDjZrbJSHjG9LKr8T/TTv9p4bQG
         B16r0f8pJNURF2MgJudIV1XouxQG3syNm0soLrUYzHBdznu0MadZWyhUUb7VxNe93Wyo
         zigG9WaEXUcfL6EXc4YhXO6eWEDA2xghlxlLiNa5oc8ogv2su8l1SAoOVVfZ4Qr5aB+x
         kIctTOX11VT/L4GiMithyAA5UIsJB6GRYRQ1J5gUkS2yXqiwMTAtXb6mk6slJ/ca/vci
         hSFqmhd5vFkCOMZI7zCGrcQWCG+ZXWJEZxk3eSPTX63pyRbhsM4qmj4umA9E9gt67qtr
         wHNg==
X-Gm-Message-State: AOAM530eZ3fkNAbjAX1Bz6/t6q9pzTN3wKzkoUiu9eQK6oDw3bYH2Vfd
        xJzMbzz8FVnEqGU7UChnj9gm9g==
X-Google-Smtp-Source: ABdhPJwMgSQQE79CAJ3VE3v1uID2azdmj5M/8eezAiYtjefmEN0N+WVUz8Ar2sct5D1D7zmhD50G2w==
X-Received: by 2002:a17:902:6b4c:b029:ec:a55f:f4e7 with SMTP id g12-20020a1709026b4cb02900eca55ff4e7mr28397654plt.72.1619580921559;
        Tue, 27 Apr 2021 20:35:21 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id b4sm3260291pfv.188.2021.04.27.20.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 20:35:21 -0700 (PDT)
Date:   Tue, 27 Apr 2021 20:35:21 -0700 (PDT)
X-Google-Original-Date: Tue, 27 Apr 2021 20:35:19 PDT (-0700)
Subject:     Re: [PATCH v8] RISC-V: enable XIP
In-Reply-To: <20210428030824.GA196954@roeck-us.net>
CC:     alex@ghiti.fr, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, vitaly.wool@konsulko.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     linux@roeck-us.net
Message-ID: <mhng-6764680f-437c-4733-8569-6f76d9c3aa4f@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 27 Apr 2021 20:08:24 PDT (-0700), linux@roeck-us.net wrote:
> On Tue, Apr 13, 2021 at 02:35:14AM -0400, Alexandre Ghiti wrote:
>> From: Vitaly Wool <vitaly.wool@konsulko.com>
>>
>> Introduce XIP (eXecute In Place) support for RISC-V platforms.
>> It allows code to be executed directly from non-volatile storage
>> directly addressable by the CPU, such as QSPI NOR flash which can
>> be found on many RISC-V platforms. This makes way for significant
>> optimization of RAM footprint. The XIP kernel is not compressed
>> since it has to run directly from flash, so it will occupy more
>> space on the non-volatile storage. The physical flash address used
>> to link the kernel object files and for storing it has to be known
>> at compile time and is represented by a Kconfig option.
>>
>> XIP on RISC-V will for the time being only work on MMU-enabled
>> kernels.
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr> [ Rebase on top of "Move
>> kernel mapping outside the linear mapping" ]
>> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
>> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>
> In next-20210426, when building riscv:allnoconfig or riscv:tinyconfig:
>
> arch/riscv/kernel/setup.c: In function 'setup_arch':
> arch/riscv/kernel/setup.c:284:32: error: implicit declaration of function 'XIP_FIXUP'

Sorry about that.  I thought I'd fixed the last build, but I guess I 
managed to just miss these build failures in a spew of successes.  I 
just sent out a patch to fix it.
