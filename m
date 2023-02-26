Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47726A3228
	for <lists+linux-arch@lfdr.de>; Sun, 26 Feb 2023 16:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjBZPYS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 26 Feb 2023 10:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjBZPYC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Feb 2023 10:24:02 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B9A976A
        for <linux-arch@vger.kernel.org>; Sun, 26 Feb 2023 07:17:13 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id p16so2732797wmq.5
        for <linux-arch@vger.kernel.org>; Sun, 26 Feb 2023 07:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=00BrJtQYUm2ctanqeELqxST7ownlOAdQkcEkYX1TRIY=;
        b=DNtNgHrKHGXDrwr0dIP1O02KBWNU47s76Dn5SZDAb6npnbDtIsEz+mG0/q+/q8ZXvp
         JhwhVmePdBDUiYTFoluF34vUTAT1Xkia/4id2ET6dSqcD6DYeZR5doLS0XBCH0HhPNUI
         +M4PjPkoe1xrs6QJkY+MLyskbQZ+AeZMRoyM8sWVd9XzjkEQsqCZK61iS8PLEPOkPY3Q
         sUfaAXMxzCA6tn02IrcfmaQsprjTwQDTuzw3O8oN+jOtT+B/k33erSWdkJqG9Ar7CCxi
         GKAqqcnQ4H+ul7vKeu+UB6RiazneG1GS+KvcWbKNEvXSL+pKzy/txhmacIG6YkFWrvSW
         HWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=00BrJtQYUm2ctanqeELqxST7ownlOAdQkcEkYX1TRIY=;
        b=sLTtSIbVJPSr/1tBuaWJNUm+y68cNER1Ki/+Y15e0HQsvtxsb+vU0RAJ3J2078inTW
         x/i57RaSeat4nfMPXVVMl+sf2fXUHpZo+O4252IbYn4681gerzxUPlUM9WS65mPNoLTq
         YOKI+frBRjeeUROJv0CyDSMR3+PLAT3Me8ncW5XRAzAsrK9kX7xJR4IJULvB+p3UBGRc
         3yR7uKMskrh+c9vEho79QwlFWl3xIxP4cj2jmbQtF6HX7CPbnNS+IAw0UpSywnpQUJno
         oE8Fnjzd7WwO/Cs9ObdTr1JfYNrl7HzhOZwalWBACbp93iUQ4GUXGwj6LtUHsiHmwe4O
         1F+g==
X-Gm-Message-State: AO0yUKWdHo5WyuMSClKnyPvKvZSLYcHDjezJXoP6dBuUuGt9iKbkO1sN
        MB/ftlKq2PbJNjLxWuV0MUQKkII7QWJknBcjuxs=
X-Google-Smtp-Source: AK7set8F9McGCBvWUbZ8pqypNd9y272tlLBLu/PzUd1t2mSBj/bDCrHtHZv9kX6OSJHVK/frmc2mTA==
X-Received: by 2002:ac2:5383:0:b0:4dc:4c53:4460 with SMTP id g3-20020ac25383000000b004dc4c534460mr6907072lfh.16.1677423720441;
        Sun, 26 Feb 2023 07:02:00 -0800 (PST)
Received: from localhost.localdomain ([5.188.167.245])
        by smtp.googlemail.com with ESMTPSA id z7-20020ac25de7000000b004db44dfd888sm580715lfq.30.2023.02.26.07.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 07:01:59 -0800 (PST)
From:   Sergey Matyukevich <geomatsi@gmail.com>
To:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Zong Li <zong.li@sifive.com>, Guo Ren <guoren@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH 0/2] riscv: asid: switch to alternative way to fix stale TLB entries
Date:   Sun, 26 Feb 2023 18:01:35 +0300
Message-Id: <20230226150137.1919750-1-geomatsi@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

Some time ago two different patches have been posted to fix stale TLB
entries that caused applications crashes.

The patch [0] suggested 'aggregating' mm_cpumask, i.e. current cpu is not
cleared for the switched-out task in switch_mm function. For additional
explanations see the commit message by Guo Ren. The same approach is
used by arc architecture, so another good comment is for switch_mm
in arch/arc/include/asm/mmu_context.h.

The patch [1] attempted to reduce the number of TLB flushes by deferring
(and possibly avoiding) them for CPUs not running the task.

Patch [1] has been merged. However we already have two bug reports from
different vendors. So apparently something is missing in the approach
suggested in [1]. In both cases the patch [0] fixed the issue.

This patch series reverts [1] and replaces it by [0].

Regards,
Sergey

[0] https://lore.kernel.org/linux-riscv/20221111075902.798571-1-guoren@kernel.org/
[1] https://lore.kernel.org/linux-riscv/20220829205219.283543-1-geomatsi@gmail.com/


Guo Ren (1):
  riscv: asid: Fixup stale TLB entry cause application crash

Sergey Matyukevich (1):
  Revert "riscv: mm: notify remote harts about mmu cache updates"

 arch/riscv/include/asm/mmu.h      |  2 --
 arch/riscv/include/asm/tlbflush.h | 18 --------------
 arch/riscv/mm/context.c           | 40 +++++++++++++++----------------
 arch/riscv/mm/tlbflush.c          | 28 +++++++++++++---------
 4 files changed, 37 insertions(+), 51 deletions(-)

-- 
2.39.2

