Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED55651BF17
	for <lists+linux-arch@lfdr.de>; Thu,  5 May 2022 14:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbiEEMVK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 May 2022 08:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345650AbiEEMVE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 May 2022 08:21:04 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBD74579F;
        Thu,  5 May 2022 05:17:24 -0700 (PDT)
Received: from mail-lj1-f181.google.com ([209.85.208.181]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M3mHT-1nllTN1Qhv-000ueJ; Thu, 05 May 2022 14:17:22 +0200
Received: by mail-lj1-f181.google.com with SMTP id v4so5329525ljd.10;
        Thu, 05 May 2022 05:17:22 -0700 (PDT)
X-Gm-Message-State: AOAM532QXtV6eyBDUyLwo3AXCvmgCT/pj5rTsaBrjIUlAlmgl8iCQnRh
        v9I3y9GSNK/alYOT0AprnJd30jnb8DjDfV2H45o=
X-Google-Smtp-Source: ABdhPJy3sZItdcfe17y+S/VnaEhqFhXcQF66aoZmv1r68aZfE+8weQM2Hae0G8znhhQS8eBb/xXeQCqA+DvrYRMKHic=
X-Received: by 2002:a5d:49cb:0:b0:20a:cee3:54fc with SMTP id
 t11-20020a5d49cb000000b0020acee354fcmr19600892wrs.12.1651749002633; Thu, 05
 May 2022 04:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220430153626.30660-1-palmer@rivosinc.com>
In-Reply-To: <20220430153626.30660-1-palmer@rivosinc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 5 May 2022 13:09:46 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1VjunJE5zAm96pkQX7EvVDcN6VGT8usedeO709KQnB_g@mail.gmail.com>
Message-ID: <CAK8P3a1VjunJE5zAm96pkQX7EvVDcN6VGT8usedeO709KQnB_g@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Generic Ticket Spinlocks
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Jisheng Zhang <jszhang@kernel.org>, linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:zB4VnhoqNXL/nqhjNWrffEGmaNCkl4+RjjuVSdsUnx7ledjEVva
 29lCpcjvZhlokpSdpC4w23ChFmJGaKrKujOc1R2+5I+MS1vRmppVPjUKp/Y2XzGX6ZbsPfv
 tif7+pJFsUy6sx4qpulJOF2Y+PaHnTVvzpslRabEuKPc+3zq3Rsn2wrHLp+yoisR5WbtoBY
 4wrqFu/YHBeNCmVwAftIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+jqQtsJYVtg=:o3/LyFpB0n6xgvN3F2E/KQ
 j+JpvwlgtArpmsrBjK3h9xQFbWeoMaztyDAA0+6ET4QjWn9lws1FNDoUoXGwPtMP7oSjY4QCd
 WBfQtrf6MsdPNFm4pA1OL5f9K/cjC2wwOzVIVAFSXBt0bGU3QRjNqOdzTTioaOWI9QcmlaFNN
 61dUTiK9Nq44hy5xSxy1H9Hl33a3XqAg9ly+h3QMEFI+d0isJa3jPL35AQpZi4xIrNtXnzHHV
 smVCGTVpyU4BhBOmi5WrzyBiq6itdm1v6eBCf6ri3gi90zyx+maytdZicpx+B0QZTGL11F73q
 JgaYzJ11Jpo0GqNQCNKRmN+h9HAzjLq8bgIpswH9Z76aEUqM8gX9ZJSmGxSG8qRSLHjuvkeV1
 FCFKdMzmeJ9JpW23PPdqzprvTW+sCxkLyP/eg7LeUvIHo4edBbx3hpnVkgmJxbLmr6U8ezpPR
 Me8XVLc5cW6CWUnxSjNg6yVv/JhKAEabZZbyw6jpnS47BxrBK8YRzP0XxyU6bw0+P000M8Qt9
 WkyP1Dqdx1xkLgM/DjSeUxHmwE523yhET0dPS22HmyB/g/+XtEowha+Wm+I8JhgukNNfjh00S
 II4im5YbczRm6FSpB5wwonMmRbAA3FD8zsaI/gQHzHJgbBsJ2ob2LI+oDS8IyjyKYabissUPO
 +2NV/c6AvH9nXtWAtr85rj9YBKYyHQeoNMkbwTcqJ68nq8Af1p/u+6vu0nSYSBE88PJiOOY6H
 du+AmW29hB2zg1hzGyZdXB1dT7GtOfdGqkBmzIdWHw/Hj2f3q7GKLA1AXxFIxMwSfGXkRM+nO
 FBr2cL8bAoEsQsNvT/vryItUUegkf9oSdJaeGeZUuAHX67g6qo=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Apr 30, 2022 at 5:36 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> Comments on the v3 looked pretty straight-forward, essentially just that
> RCsc issue I'd missed from the v2 and some cleanups.  A part of the
> discussion some additional possible cleanups came up related to the
> qrwlock headers, but I hadn't looked at those yet and I had already
> handled everything else.  This went on the back burner, but given that
> LoongArch appears to want to use it for their new port I think it's best
> to just run with this and defer the other cleanups until later.
>
> I've placed the whole patch set at palmer/tspinlock-v4, and also tagged
> the asm-generic bits as generic-ticket-spinlocks-v4.  Ideally I'd like
> to take that, along with the RISC-V patches, into my tree as there's
> some RISC-V specific testing before things land in linux-next.  This
> passes all my testing, but I'll hold off until merging things anywhere
> else to make sure everyone has time to look.  There's no rush on my end
> for this one, but I don't want to block LoongArch so I'll try to stay a
> bit more on top of this one.

I took another look as well and everything seems fine. I had expected
that I would merge it into the asm-generic tree first and did not bother
sending a separate Reviewed-by tag, but I agree that it's best if you
create the branch.

Can you add 'Reviewed-by: Arnd Bergmann <arnd@arndb.de>'
to each patch and send me a pull request for a v5 tag so we can
merge that into both the riscv and the asm-generic trees?

       Arnd
