Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5443515EBA
	for <lists+linux-arch@lfdr.de>; Sat, 30 Apr 2022 17:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242866AbiD3PlQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Apr 2022 11:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242748AbiD3PlQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Apr 2022 11:41:16 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802A7A0BC8
        for <linux-arch@vger.kernel.org>; Sat, 30 Apr 2022 08:37:53 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r83so8668922pgr.2
        for <linux-arch@vger.kernel.org>; Sat, 30 Apr 2022 08:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=np4HtbwGSB6iapeRruj8GZIUHuBuKuckcGYZnwyb7bo=;
        b=InNn+tkdTs6CYKbpqgE/Kt+T2kH9K4dNAnuziT6CNc1awAKVpLsBeXBEdSF55QM/8k
         udH4gEcsFOVPawephKUVFL/54PfXCMPmAorXXpszoBfjsIKvSI3jL3yHoCz/uqq1IJn+
         kVWFjf9c9lRBSJV5yXZBkvE8w4q0dL/oOu8lTnq28UsvEJQY0CH45LEYkuv+wRNYsTLP
         Eyvd+DTwR/Od3TwiXZX3NEqkZmEX32Za9+ZkVKeQEHjNlAk+KM4nrwQUJ54ndJvbu69L
         pGF/VGp+Zznm318sUZMvZlp/aR/nsxWR0vlR5TvJIrQjJvM+dt17gI1NbWJzGbD5zNqR
         3vVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=np4HtbwGSB6iapeRruj8GZIUHuBuKuckcGYZnwyb7bo=;
        b=E/gbgTOjhmKXN7rl+r+REKtDIUNNYX3XRwIgRt7LhUFRA13MiGNLE/hspePxvszdak
         qCW/afE8FrUXQKfsZ9thDkZaWe4WMfOlkNsKvVcy/cAI7j7ejKA9vDZ0fOtTytGW4f0U
         7nCz7X+GAc3E7j/vdGcoERq4oj/dAVc+vEwYsa7d1VRjAbuZxJXPsNfd4RnsFG0etIJU
         VTfsd+1OGv43lTuZuUbjxkhp5mJb6Exyo9qdXaJyhIkLwUvYaAHrhWU9gZ9BvBnKDGHO
         FyH5FlnlD5VqhyNIlVHEmdSofQQSEEojdA6AT6RqU0qwqiy2a2uQ+r/4WXN6gB229s39
         xLBw==
X-Gm-Message-State: AOAM531DoVo2i6g3pVk4xfYq4PdWoX8PA0SMqLr4h1iEcIF1OtAlQ94E
        ltIQbSws8ccBXmhQcl4TPcqh9g==
X-Google-Smtp-Source: ABdhPJyY6PFEoD09nOYm4tiKmrVzmrmKd1omAejHwAiMVanwvGm+TKpg7gHnHCqyfyt/42onKskybA==
X-Received: by 2002:a63:5606:0:b0:3ab:84d3:cfbe with SMTP id k6-20020a635606000000b003ab84d3cfbemr3521738pgb.191.1651333072975;
        Sat, 30 Apr 2022 08:37:52 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id p2-20020a17090ad30200b001cd4989feb7sm17264343pju.3.2022.04.30.08.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 08:37:52 -0700 (PDT)
Subject: [PATCH v4 0/7] Generic Ticket Spinlocks
Date:   Sat, 30 Apr 2022 08:36:19 -0700
Message-Id: <20220430153626.30660-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     guoren@kernel.org, peterz@infradead.org, mingo@redhat.com,
        Will Deacon <will@kernel.org>, longman@redhat.com,
        boqun.feng@gmail.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        sudipm.mukherjee@gmail.com, macro@orcam.me.uk, jszhang@kernel.org,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        openrisc@lists.librecores.org, linux-riscv@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Comments on the v3 looked pretty straight-forward, essentially just that
RCsc issue I'd missed from the v2 and some cleanups.  A part of the
discussion some additional possible cleanups came up related to the
qrwlock headers, but I hadn't looked at those yet and I had already
handled everything else.  This went on the back burner, but given that
LoongArch appears to want to use it for their new port I think it's best
to just run with this and defer the other cleanups until later.

I've placed the whole patch set at palmer/tspinlock-v4, and also tagged
the asm-generic bits as generic-ticket-spinlocks-v4.  Ideally I'd like
to take that, along with the RISC-V patches, into my tree as there's
some RISC-V specific testing before things land in linux-next.  This
passes all my testing, but I'll hold off until merging things anywhere
else to make sure everyone has time to look.  There's no rush on my end
for this one, but I don't want to block LoongArch so I'll try to stay a
bit more on top of this one.

Changes since v3 <20220414220214.24556-1-palmer@rivosinc.com>:
* Added a smp_mb() in the lock slow-path, to make sure that is RCsc.
* Fixed the header guards.

Changes since v2 <20220319035457.2214979-1-guoren@kernel.org>:
* Picked up Peter's SOBs, which were posted on the v1.
* Re-ordered the first two patches, as they
* Re-worded the RISC-V qrwlock patch, as it was a bit mushy.  I also
  added a blurb in the qrwlock's top comment about this dependency.
* Picked up Stafford's fix for big-endian systems, which I have not
  tested as I don't have one (at least easily availiable, I think the BE
  MIPS systems are still in that pile in my garage).
* Call the generic version <asm-genenic/spinlock{_types}.h>, as there's
  really no utility to the version that only errors out.

Changes since v1 <20220316232600.20419-1-palmer@rivosinc.com>:
* Follow Arnd suggestion to make the patch series more generic.
* Add csky in the series.
* Combine RISC-V's two patches into one.
* Modify openrisc's patch to suit the new generic version.


