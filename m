Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52134F1D45
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 23:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357274AbiDDVai (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 17:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380675AbiDDU6p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 16:58:45 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C62430F6D;
        Mon,  4 Apr 2022 13:56:49 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bg10so22574945ejb.4;
        Mon, 04 Apr 2022 13:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bVlKvULZm2JgZ5AGytzLrLB0CSLrK0ggDRTo65+yxyA=;
        b=ku1Mni2YP6skEb4UzKwM1qgc933zwKLIlMM21YZAd7k4Ios0mzpOc/rIaiQVjhFQSY
         G+txssoqd3A6QKy5AZVACJTlGPSO1le+tQYos/vc/E2PB8bCCueGVPQ5Scvt5bZZ0s2f
         I52BoNzvPo67Aqv6eXqqyFzU1vQDqrs2VWVcVapC6o/pGzwkb1H3txizNNHwVD4d6ScG
         2eIDS0ScxBnD2FZzrF1d1lKbTPDJ8/l3KKd8gewI19+L9UviMfXxa0WaQTj9+PHYcB7I
         7cJb+/UH9X0jvg07Ut3LmEkLNSOS7IFE/S9dHP7d26coaZhJq40PwzaU1UKeGEFNTonV
         YiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bVlKvULZm2JgZ5AGytzLrLB0CSLrK0ggDRTo65+yxyA=;
        b=ADpGwSD2J3Ly+6ODxHl337T+g8oWZTx2PZ3zU49l6o/xvzRODv9nx9nQV+abr+jPK1
         4QgB1M0hR+TJfiCil8X6v+le+V+njcTlHPlXbj+nA6716xVsQTlEXW1j8GrE1Ex7hmXV
         BAqxTavkO759OTbrW6hw66hWZqz6TfRQiCpm0pCwfOkyLWd+NAg1RmFs0WFGi9tnyLBk
         sT4Y/dHaPudG7t/kX1chw8OURNqnuWm8lX3n8Z8WmBPRsXL2Qrg7tetTEz58Cz3o+VqN
         HjQ12vjDbhJpdR61SLFixyEd31HkkoberI2vJKeVogTwj0QkUk3+T7xGOOTZLrOVrCx1
         9N6g==
X-Gm-Message-State: AOAM532p0QLx0Om0oA3qug+ZlJ/gCGkAqDEjIGu6xPgI3hcu5ix33ik9
        X65GOOYNZ8mAVMLJISe0Kde6e+u6wL4RnYTQ/ClAfvlb7Vc=
X-Google-Smtp-Source: ABdhPJxR6ykDRFXeBPhlCfq09GQEDxUi37N3Qk4mgFJMv7QLL7sMtSVvzSM8nSllVj9W6nUE0impfg7PMyukPyB4+IQ=
X-Received: by 2002:a17:906:f75a:b0:6e6:e3f1:c946 with SMTP id
 jp26-20020a170906f75a00b006e6e3f1c946mr67964ejb.676.1649105807881; Mon, 04
 Apr 2022 13:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <Yib9F5SqKda/nH9c@infradead.org> <CAK8P3a1dUVsZzhAe81usLSkvH29zHgiV9fhEkWdq7_W+nQBWbg@mail.gmail.com>
 <YkmWh2tss8nXKqc5@infradead.org> <CAK8P3a0QdFOJbM72geYTWOKumeKPSCVD8Nje5pBpZWazX0GEnQ@mail.gmail.com>
 <CAMo8BfKgn0T5RtUTb89fPvygNJJYLy7r1=RZTmTTm=jiDfx1hQ@mail.gmail.com>
 <CAK8P3a0J1--WSyWY+TptFa0nn5d-mOxapadCE1csGRkfhSPbVw@mail.gmail.com>
 <CAMo8BfLT8vMw3aGQPs1+9ry7W63SQphmDc4Tt4A3JvADHJhxiQ@mail.gmail.com>
 <CAK8P3a3iFb+ZacZ40d8PC_xcJpLVFXT0Qc-oYEZNkFqXdsfNZw@mail.gmail.com> <CAK8P3a1goN3c772xiFtz13kHZs0XEDSxfXX=ub7OH3S98Mddsw@mail.gmail.com>
In-Reply-To: <CAK8P3a1goN3c772xiFtz13kHZs0XEDSxfXX=ub7OH3S98Mddsw@mail.gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 4 Apr 2022 13:56:36 -0700
Message-ID: <CAMo8BfJ5oqq3DXGf31uy8ab01EXqfzsO8hA2Tia=F1fBGiznKw@mail.gmail.com>
Subject: Re: [RFC PULL] remove arch/h8300
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 4, 2022 at 12:44 PM Arnd Bergmann <arnd@arndb.de> wrote:
> Let me know if I need to enable additional options to get a compiler
> that works for all xtensa targets. Usually the --enable-targets=all
> is meant to be sufficient.

This is not possible with the current design of the xtensa toolchain port.
There's an effort to make switching between the core configurations easy
(without the whole toolchain rebuild:
 https://github.com/jcmvbkbc/xtensa-dynconfig
 https://github.com/jcmvbkbc/gcc-xtensa/tree/xtensa-dynconfig
 https://github.com/jcmvbkbc/binutils-gdb-xtensa/tree/xtensa-plugin-env ),
but it still involves building plugins for the parts of the toolchain
for each new xtensa core.

-- 
Thanks.
-- Max
