Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B508B30DC87
	for <lists+linux-arch@lfdr.de>; Wed,  3 Feb 2021 15:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhBCOUT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 09:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbhBCOUQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Feb 2021 09:20:16 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F09FC0613D6
        for <linux-arch@vger.kernel.org>; Wed,  3 Feb 2021 06:19:36 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id y9so3307919wmi.8
        for <linux-arch@vger.kernel.org>; Wed, 03 Feb 2021 06:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=2YqmStJHtmDLb9ca8pHnXTtS9p5W2yatBMAuEkk2twc=;
        b=swt8i8oh/CahxjCm1i2LWz1PAhEJPYcgCpXP0sqxpm2LUsKOEQR/Tv0qTZc/ayZXro
         fM/xy/OMrvadN/XfZfFqE9II1fKG4oA2GlksIBodsSYBYT2mQdY2QmCpAWh+A33rzzL5
         GBiuyPnm5s8VHkJgbxLVNkw+yIUI3Zicnnyitub/KQvWRFCUrkmL+zNaLx2zGrWCUXaC
         VxvambATQYjvSZI9oXIdrBvrKIuvZMvY2pdDM60IB/BE1kKNHUXBK29B6uGPOMVY+nc5
         fvb5tienhYATycUO0iLqHIzDap95urS27UIbmZIvUgzX0u7Xs21ZzMPJLuQDzcL3a4Gs
         0Hwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=2YqmStJHtmDLb9ca8pHnXTtS9p5W2yatBMAuEkk2twc=;
        b=J90PHAChEOEyE2gDP2RTVBoA0M5vnBWVWM0SSmu94Wnqo81cZ5m204t18aXDQ9Vvwh
         3TMRuYngVAmC1KvQ5+Q1fdlHgVnO2eVEdmdUu2lI/lbqcggha1cw695I2y4GEho5kal/
         2y6ejwun1iM39IXh/OwoQIw97r6suqMTfpo20KRRiDbJTxt+OrGlkU73jeQLalNRN/oQ
         Sy45QmPAartFTWr4y0GD7WdQE7nhBHkkJW9ov5tFUo2HPc7I0Oyew3v2Uzitzb+Mbmkr
         n75aRJPYhNLIIAbZeEmlRLnXYfrAHPLLwBpVG1agPgt8Srbfwk6rToNDsQfcHozAxeDY
         oCfA==
X-Gm-Message-State: AOAM5321ro8J5f96/s7rf0uPDRRmi5m6HFrmOYNSX0IMsL2lDJwBhpor
        qv5U3ijsWmY23sgd0wIO93+49K3PPl+5
X-Google-Smtp-Source: ABdhPJzQ47fLWpATF9oviOBeGLZ6a+5wZlOoYomkHouoJDdnNHFlCRVtBHfc0HOJyC8UgG5y/ze+CK1Gxa5x
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:4303:: with SMTP id
 q3mr3048441wma.3.1612361974461; Wed, 03 Feb 2021 06:19:34 -0800 (PST)
Date:   Wed,  3 Feb 2021 14:19:29 +0000
Message-Id: <20210203141931.615898-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH 0/2] KVM: arm64: Stub exports in nvhe code
From:   Quentin Perret <qperret@google.com>
To:     arnd@arndb.de, maz@kernel.org, catalin.marinas@arm.com,
        will@kernel.org
Cc:     james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com, ardb@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kernel-team@android.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

In the context of the currently ongoing work to remove the host kernel
from the TCB under KVM/arm64, I have been trying to wrap the host kernel
with a stage 2 page-table -- see [1].

Using this infrastructure, I attempted to unmap the .hyp. sections from
the host stage 2 as it really shouldn't need to access them. But by
doing so, I realized quickly the module loader was getting very confused
by the usage of EXPORT_SYMBOL() macros in library functions that have
been pulled into the EL2 object, and that we end up linking modules
against the EL2 copy of e.g. memset. And so, this series essentially
tries to fix this.

 - Patch 01 changes asm-generic/export.h to ensure we respect
   __DISABLE_EXPORTS even for asm exports;

 - and patch 02 makes use of it for all of the nVHE EL2 code.

This was tested on aml-s905x-cc, which now successfully loads kernel
modules with .hyp.text unmapped from the host.

Thanks,
Quentin

[1] https://lore.kernel.org/kvmarm/20210108121524.656872-1-qperret@google.com/

Quentin Perret (2):
  asm-generic: export: Stub EXPORT_SYMBOL with __DISABLE_EXPORTS
  KVM: arm64: Stub EXPORT_SYMBOL for nVHE EL2 code

 arch/arm64/kvm/hyp/nvhe/Makefile | 4 ++--
 include/asm-generic/export.h     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.30.0.365.g02bc693789-goog

