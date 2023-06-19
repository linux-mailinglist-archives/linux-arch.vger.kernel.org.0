Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58893735FBD
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jun 2023 00:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjFSWGe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Jun 2023 18:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjFSWGe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Jun 2023 18:06:34 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7940F134
        for <linux-arch@vger.kernel.org>; Mon, 19 Jun 2023 15:06:32 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-460eb67244eso1285868e0c.1
        for <linux-arch@vger.kernel.org>; Mon, 19 Jun 2023 15:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1687212391; x=1689804391;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=epHaUjkubRomEjpu/oKPC+kOjwKS/BUbVDRooU3Z4so=;
        b=Clc4AYB6+dKRBg/IDg+ygozDHkBJRNn61FpjM6RVMm18cdgtaWY0cX5rcr9WOoyL5f
         m7u70nYbAuk2kaAZCxpqaLxARlP2YJoS64wUCYS+vmIGiqgwXTBcSll6d9X/2eD/SOng
         bnvSuhu3b16BWuqmdkF7tHs0c3d9r0mv4QvUGsldx7qxTme7ArCAoNuiCIBOokrzdVRE
         epGhqtrFxDpd0gMY9anaTfl+z9wKFgnv3qJSw5Snx0PtIhSGlt/z5JfEPVnEFHlTZ2gR
         oME2kHMtBN2/kFhbqPIZph5uY1swSYpVqA1TrM1J6JuowBy2eLA6cv0zprikuBxbJBIP
         JgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687212391; x=1689804391;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epHaUjkubRomEjpu/oKPC+kOjwKS/BUbVDRooU3Z4so=;
        b=EiXb5f1UchYtCO4BHuMDuQ5NuGnI89dxIeQ0wraKg38K1cFJ6MyLUaRfN+lIzPZT77
         +noBz9N4Pb9e2zGTvOV2JhPXO61hL+rQukdv4ng+oLrmloPrM94Qjq+5wZFNSzqz3i4W
         Rioqh2GXc6rZtksGQPAo/jqmxL4laWcrTWxORfFBRKLfdS9mr9w75Zab4JbjnfAqRuOD
         hylq2Cz6QGxrEWsoEdLq6dSvvIXhgNX2wblRYqIz085r1buqcBlr4lp/NBIQfPm70OtA
         zo8yKimGIWNr4sYOzDbLtawmn4cxldOfmmNTIawu42KLjQeHm00eQyO/Y2+tApens6BU
         7suw==
X-Gm-Message-State: AC+VfDyXBIkIZksGJzHG9T6AiAz5+BkmBC2NOYBenuQSvDsdJfo69z4m
        wnrZDZdGwM1pWi1VGna+hp9c8w==
X-Google-Smtp-Source: ACHHUZ7DIN/jiAGa9oBPkCoLh+LmqcRVR1Lpn9QSUwCOEnPyWLgfT+5eGZP6x9+3N0protXz72Kx0w==
X-Received: by 2002:a1f:3d11:0:b0:465:fa30:d633 with SMTP id k17-20020a1f3d11000000b00465fa30d633mr2844926vka.0.1687212391496;
        Mon, 19 Jun 2023 15:06:31 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id g7-20020a635207000000b00528db73ed70sm165781pgb.3.2023.06.19.15.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 15:06:30 -0700 (PDT)
Date:   Mon, 19 Jun 2023 15:06:30 -0700 (PDT)
X-Google-Original-Date: Mon, 19 Jun 2023 15:06:25 PDT (-0700)
Subject:     Re: [PATCH v2 0/4] riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
In-Reply-To: <mhng-41a06775-95dc-4747-aaab-2c5c83fd6422@palmer-ri-x1c9>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang@kernel.org, llvm@lists.linux.dev
Message-ID: <mhng-57559277-afaa-4a85-a3ad-b9be6dba737f@palmer-ri-x1c9>
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

On Thu, 15 Jun 2023 06:54:33 PDT (-0700), Palmer Dabbelt wrote:
> On Wed, 14 Jun 2023 09:25:49 PDT (-0700), jszhang@kernel.org wrote:
>>
>> On Wed, Jun 14, 2023 at 07:49:17AM -0700, Palmer Dabbelt wrote:
>>> On Tue, 23 May 2023 09:54:58 PDT (-0700), jszhang@kernel.org wrote:
>>> > When trying to run linux with various opensource riscv core on
>>> > resource limited FPGA platforms, for example, those FPGAs with less
>>> > than 16MB SDRAM, I want to save mem as much as possible. One of the
>>> > major technologies is kernel size optimizations, I found that riscv
>>> > does not currently support HAVE_LD_DEAD_CODE_DATA_ELIMINATION, which
>>> > passes -fdata-sections, -ffunction-sections to CFLAGS and passes the
>>> > --gc-sections flag to the linker.
>>> >
>>> > This not only benefits my case on FPGA but also benefits defconfigs.
>>> > Here are some notable improvements from enabling this with defconfigs:
>>> >
>>> > nommu_k210_defconfig:
>>> >    text    data     bss     dec     hex
>>> > 1112009  410288   59837 1582134  182436     before
>>> >  962838  376656   51285 1390779  1538bb     after
>>> >
>>> > rv32_defconfig:
>>> >    text    data     bss     dec     hex
>>> > 8804455 2816544  290577 11911576 b5c198     before
>>> > 8692295 2779872  288977 11761144 b375f8     after
>>> >
>>> > defconfig:
>>> >    text    data     bss     dec     hex
>>> > 9438267 3391332  485333 13314932 cb2b74     before
>>> > 9285914 3350052  483349 13119315 c82f53     after
>>> >
>>> > patch1 and patch2 are clean ups.
>>> > patch3 fixes a typo.
>>> > patch4 finally enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION for riscv.
>>> >
>>> > NOTE: Zhangjin Wu firstly sent out a patch to enable dead code
>>> > elimination for riscv several months ago, I didn't notice it until
>>> > yesterday. Although it missed some preparations and some sections's
>>> > keeping, he is the first person to enable this feature for riscv. To
>>> > ease merging, this series take his patch into my entire series and
>>> > makes patch4 authored by him after getting his ack to reflect
>>> > the above fact.
>>> >
>>> > Since v1:
>>> >   - collect Reviewed-by, Tested-by tag
>>> >   - Make patch4 authored by Zhangjin Wu, add my co-developed-by tag
>>> >
>>> > Jisheng Zhang (3):
>>> >   riscv: move options to keep entries sorted
>>> >   riscv: vmlinux-xip.lds.S: remove .alternative section
>>> >   vmlinux.lds.h: use correct .init.data.* section name
>>> >
>>> > Zhangjin Wu (1):
>>> >   riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
>>> >
>>> >  arch/riscv/Kconfig                  |  13 +-
>>> >  arch/riscv/kernel/vmlinux-xip.lds.S |   6 -
>>> >  arch/riscv/kernel/vmlinux.lds.S     |   6 +-
>>> >  include/asm-generic/vmlinux.lds.h   |   2 +-
>>> >  4 files changed, 11 insertions(+), 16 deletions(-)
>>>
>>> Do you have a base commit for this?  It's not applying to 6.4-rc1 and the
>>> patchwork bot couldn't find one either.
>>
>> Hi Palmer,
>>
>> Commit 3b90b09af5be ("riscv: Fix orphan section warnings caused by
>> kernel/pi") touches vmlinux.lds.S, so to make the merge easy, this
>> series is based on 6.4-rc2.
>
> Thanks.

Sorry to be so slow here, but I think this is causing LLD to hang on 
allmodconfig.  I'm still getting to the bottom of it, there's a few 
other things I have in flight still.

>
>>
>> Thanks
