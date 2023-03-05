Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555966AB23C
	for <lists+linux-arch@lfdr.de>; Sun,  5 Mar 2023 21:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjCEU5I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Mar 2023 15:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjCEU5E (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Mar 2023 15:57:04 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6085217CE4;
        Sun,  5 Mar 2023 12:57:03 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id i34so30763259eda.7;
        Sun, 05 Mar 2023 12:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678049822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25TOpB6uAuDptlCHYXnw8K0sBZK8F7O48wtvqw46Fco=;
        b=cNd8YqsFIPxe+JP9zRF39U9LVtgmwfXjcFbHH84MFejyyz+WXmA51xlzYADH9AC01W
         lEszc02CudZI42k7pYdy16Vf4WI6WjE1DZx56EjyaZpyY7FvA1+pVY1RSyjgr+NlrGpr
         yFwug2e2C37vzQDmuS5CJX+8dF3kzqMWXP62SO1BV9+XSfgAJAzZ1JEkQPQMUXgK2qm4
         0hyBNzM1O3Kv/jPXAGYRtlnLBj1s1v9YygYUST1D+zx9Ey2ipnETSfTUq5UPh138ocjy
         r6cJKI1TIKvZxYHHrTVVuJQaSsFt81JXXkjl01KWi2F25uQE45bvL71Q902loyxf7ehM
         /C8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678049822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25TOpB6uAuDptlCHYXnw8K0sBZK8F7O48wtvqw46Fco=;
        b=7dKYci2a8/L5ceXnYJj2/Z0LHjvmnKrJ/Dgm/Iw6QIekMdA383B4JwpbVGfPYB/BiS
         gpATTuYBiCP8WqeyyXgEPWI57AfNWJpcr8gKOElwhCFWMeDnM4AwKcjXmPXysJlBzMbZ
         6BulcUNCqUYgteP6cjnAgvLI8+F2L3GZugcgsMjNstfs1eJBH4po5PpL/rxohfe/bV16
         uFF88vMcf46Zd7+b6R2mho52i6E3U3wTpl5EWuozBt+ba5YzNVdfwmSjniR5m5Q0tcZG
         HMfnE/3GRJOhGbMgJ0lkM7foCoRDEGlPTxGuuZ5DTEfFFMBDE/JrMvI0yBAXAEfdIIPL
         uvMQ==
X-Gm-Message-State: AO0yUKUFJssSCOAWFWh0VF0QDLO6PLYhAflQwr49ydodhfhVVT3N9GEg
        prZLWKhssCnC18yc2iP0ItPgbYcFoWlZfz/L
X-Google-Smtp-Source: AK7set9H+42xPHqyPW7jGUPzVIpjv1MvOVftLDcjvJIUsaEDkzaQZ+a/sQDSm0+Tof/iIVl2G2SuVg==
X-Received: by 2002:a17:906:f18a:b0:887:8f6:c1d7 with SMTP id gs10-20020a170906f18a00b0088708f6c1d7mr8937367ejb.38.1678049822541;
        Sun, 05 Mar 2023 12:57:02 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ay24-20020a170906d29800b0090953b9da51sm3615436ejb.194.2023.03.05.12.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 12:57:02 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 06/10] locking/powerpc: Wire up local_try_cmpxchg
Date:   Sun,  5 Mar 2023 21:56:24 +0100
Message-Id: <20230305205628.27385-7-ubizjak@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230305205628.27385-1-ubizjak@gmail.com>
References: <20230305205628.27385-1-ubizjak@gmail.com>
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

Implement target specific support for local_try_cmpxchg.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/powerpc/include/asm/local.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/powerpc/include/asm/local.h b/arch/powerpc/include/asm/local.h
index bc4bd19b7fc2..45492fb5bf22 100644
--- a/arch/powerpc/include/asm/local.h
+++ b/arch/powerpc/include/asm/local.h
@@ -90,6 +90,17 @@ static __inline__ long local_cmpxchg(local_t *l, long o, long n)
 	return t;
 }
 
+static __inline__ bool local_try_cmpxchg(local_t *l, long *po, long n)
+{
+	long o = *po, r;
+
+	r = local_cmpxchg(l, o, n);
+	if (unlikely(r != o))
+		*po = r;
+
+	return likely(r == o);
+}
+
 static __inline__ long local_xchg(local_t *l, long n)
 {
 	long t;
-- 
2.39.2

