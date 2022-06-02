Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D550953B32E
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jun 2022 07:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiFBF5b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jun 2022 01:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiFBF5X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jun 2022 01:57:23 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A632198
        for <linux-arch@vger.kernel.org>; Wed,  1 Jun 2022 22:57:22 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id s68so3870707pgs.10
        for <linux-arch@vger.kernel.org>; Wed, 01 Jun 2022 22:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=VFWeG644WShe6PAr0++BRYn8vwLeuQyjnw1rk2Dl1AE=;
        b=hfczKw6u5Btpk32HLuwq4DKU+M8kfeFqX2j1vX6AHZuFsGTQrJsSE3UQXD3fD29WfL
         zBCATyY9a9SY9g9FfcojlOgJ8stUsONu8AVgKIzmOHPYOvUEuQaiqM4Ae98E1rV8ny8P
         P5Xf3WWpF0HrHEYDfcZz6OhypzAg9gfb696QsA7jdXmcJHOcc84GM8rTZTT2+/mzKtFv
         oNVgfNo+xaf1EBMuu0rabG+N3k+OijR5bbzJYRHY5DpZluS/lTVGCyyGYgkHnVxLABod
         Y0ynwuZ60piT+R1oD+sVtz8qimgMLwCusYHA0ffT3TFHWiZCmsjU94Zq8DpXeUy5YoW2
         DNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=VFWeG644WShe6PAr0++BRYn8vwLeuQyjnw1rk2Dl1AE=;
        b=sJrFiZSOWt0I4rNHs0Y0gfsYA69E09N3+CEfsNuZNgHgtkbPMng6oxSsIsEv1YLN/i
         tl9X4+Sr3hv0+Fmtrajo4riiPMH1ZjP5oPHsYk8Xx1hzSYOr6cW4UQSC3NVOdz/svoT1
         sUXrO7+mJ5lA0wsuO3oYorYQ4/zDF53ISlANe1FMdTLnY3bnbW68gCtbxHhkNnoAvt+e
         kOJsakLTXSGtWCY1BZBk6T98lleJ41D9B/cYvNuqvKw0FPIlnwRjxpx3LXA4ZohQUYum
         Z1KO9ytJJq2vLUdH2hxW8ZoEl789mC70OuX7r62j3GazsUw3AjG84tE4hNp0fFiE5HAP
         8oMQ==
X-Gm-Message-State: AOAM533L0OXrPPoH7S5d3XlzksWpWN+T20Sn0eCSwI8aaXob5y+2DsHi
        CbAlSExXXJ2tVdrpopi7+Sx+4A==
X-Google-Smtp-Source: ABdhPJz/kyWYFoe1u7JVPf4ygsdjVGUNEco+49t39KDhgK0h2ZMyf+r/hpu+i4F1V0IeR/2iqD34Ug==
X-Received: by 2002:a63:28c:0:b0:3c1:6f72:7288 with SMTP id 134-20020a63028c000000b003c16f727288mr2775117pgc.564.1654149441686;
        Wed, 01 Jun 2022 22:57:21 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id gq20-20020a17090b105400b001e26da0d28csm2343380pjb.32.2022.06.01.22.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 22:57:21 -0700 (PDT)
Date:   Wed, 01 Jun 2022 22:57:21 -0700 (PDT)
X-Google-Original-Date: Wed, 01 Jun 2022 21:50:23 PDT (-0700)
Subject:     Re: [PATCH] riscv: Wire up memfd_secret in UAPI header
In-Reply-To: <20220505084611.tut66faep5r37r6c@distanz.ch>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        rppt@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     tklauser@distanz.ch, tklauser@distanz.ch
Message-ID: <mhng-671a8d6b-c318-431b-b209-c6bde465a420@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 05 May 2022 01:46:11 PDT (-0700), tklauser@distanz.ch wrote:
> On 2022-05-05 at 10:18:15 +0200, Tobias Klauser <tklauser@distanz.ch> wrote:
>> Move the __ARCH_WANT_MEMFD_SECRET define added in commit 7bb7f2ac24a0
>> ("arch, mm: wire up memfd_secret system call where relevant") to
>> <uapi/asm/unistd.h> so __NR_memfd_secret is defined when including
>> <unistd.h> in userspace.
>>
>> This allows the memds_secret selftest to pass on riscv.
>                   ^- this should say memfd_secret
>
> I can fix it up in a v2 if needed.

No big deal, I don't mind squashing stuff like that.  This is on 
for-next (no fixes, I'm still on 5.19).  I added

Fixes: 7bb7f2ac24a0 ("arch, mm: wire up memfd_secret system call where relevant")
Cc: stable@vger.kernel.org

but LMK if you think that's wrong for some reason.

Thanks!
