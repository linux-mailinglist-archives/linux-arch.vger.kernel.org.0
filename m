Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A319B2AEF28
	for <lists+linux-arch@lfdr.de>; Wed, 11 Nov 2020 12:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgKKLHd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Nov 2020 06:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgKKLHc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Nov 2020 06:07:32 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D97C0613D1;
        Wed, 11 Nov 2020 03:07:32 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id u2so789131pls.10;
        Wed, 11 Nov 2020 03:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N9WOVOySLT6I3GdZDGmxLF1+D/YdBUYGAyOrinwGECY=;
        b=oZZajbZk62T0v6JILfrOwxWZwMHOQG80TMDS1INiNWCLQw6jEKqaFxs9ChXDprHVP4
         gxa6et9kKWcofGqXNIV6Pj3mAqT6OvDNYMjUgevZ7YIp12por+sUFx+bupfb6yGREP9u
         keh+ZRu+wRD2T40CMF/4fcH3KakueNJM+Aj+kJnpjGZKJy3c7RtAdkqBCSxsVzT5LZVo
         rpjZpE0bQYC50BU/ubd+FEmKXZYys3/6V2k1aATD8cQ2O+0D6tN0VdnarHEQ6oWC5uop
         djN8jpAPp10HtB862qnCYRnvOkKZbjmjVkEWzH2PRegzPiuJQre6kZgWVvMzazzu/K9t
         k/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N9WOVOySLT6I3GdZDGmxLF1+D/YdBUYGAyOrinwGECY=;
        b=TUHQwxOOnnebCOAK2wR4IKl4fpPjbifPD1eGEQEP5w0B1F/fZLLSpl3Mt0OzF571YE
         NpyfNWX7TMtU5qEJ1+9Q8uQs6e+MHsANc7Aq85OZZc/qyJfVk1B/sMZ0WaKQWR4XCK84
         eLxw+vhGDvKv1yaQt45QXjrRjmQVksiHD/SZYxV8wzXKTjZkGAnMBCMoJn/PiryX7DxG
         8verXN4n3eauCXW69eHD/I7H/mmx2WWaiF3bkr/LaS3K6O39W+YpqwuJ1ixAyDR6bVhQ
         1gdB+nHWZYX4vhwHjDBUKrG9gARqZGwUedbyaS9DH2872Te2iAcnIgv0nnrd5MYcLhvO
         0vVA==
X-Gm-Message-State: AOAM5330utaGEzhXexNkvXxjwrJ07IL/0jy55eFm+5G+qJ6zkDmNZ8ol
        iQ0Z6laTq2+4SSu7iQKfLiU=
X-Google-Smtp-Source: ABdhPJyDttk9RAk/tJT2toeUMROv7QB4mIAfIhexx29xo3detoty5pzLTTKNL9F+EqpZxj3mDDzBjg==
X-Received: by 2002:a17:90a:f691:: with SMTP id cl17mr3337938pjb.231.1605092852045;
        Wed, 11 Nov 2020 03:07:32 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (27-32-36-31.tpgi.com.au. [27.32.36.31])
        by smtp.gmail.com with ESMTPSA id 9sm2154943pfp.102.2020.11.11.03.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 03:07:31 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 0/3] powerpc: convert to use ARCH_ATOMIC
Date:   Wed, 11 Nov 2020 21:07:20 +1000
Message-Id: <20201111110723.3148665-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This conversion seems to require generic atomic64 changes, looks
like nothing else uses ARCH_ATOMIC and GENERIC_ATOMIC64 yet.

Thanks,
Nick

Nicholas Piggin (3):
  asm-generic/atomic64: Add support for ARCH_ATOMIC
  powerpc/64s/iommu: don't use atomic_ function on atomic64_t type
  powerpc: rewrite atomics to use ARCH_ATOMIC

 arch/powerpc/include/asm/atomic.h    | 681 ++++++++++-----------------
 arch/powerpc/include/asm/cmpxchg.h   |  62 +--
 arch/powerpc/mm/book3s64/iommu_api.c |   2 +-
 include/asm-generic/atomic64.h       |  70 ++-
 lib/atomic64.c                       |  36 +-
 5 files changed, 324 insertions(+), 527 deletions(-)

-- 
2.23.0

