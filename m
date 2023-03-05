Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B686AB240
	for <lists+linux-arch@lfdr.de>; Sun,  5 Mar 2023 21:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCEU5J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Mar 2023 15:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjCEU5E (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Mar 2023 15:57:04 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52E4196BF;
        Sun,  5 Mar 2023 12:57:02 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id a25so31041307edb.0;
        Sun, 05 Mar 2023 12:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678049821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKMdOBSHNrQUgSWU9KR0ogbHUm36R1MCQj8zVPpN6EQ=;
        b=mU214HoBD9PhosOri5UfMQjRIEUU9I7ZxXJTaKzr9RcaKrtgXfOrYoiIrC1H/cgukR
         nGR3h38W8sHvMacW4UFXHQQDKZCvOloFPDQjKO9O//zDviZ9mQzevFeYU88TK71GZ7Yl
         D/k8cQsg+q4J+35dqG/OlVnh0MnVnhlAufeVmyjxTwVhOBT0LoXY5y0X7PCib/wU0Eyx
         +QpOr0musHR7lTYq7pSl2aAa1WKY3GvzHvpUUY9s2BqBAo6O2o2u90yeCuiEiCaWos8D
         58spoyzzG9c6tD9JstLQOIUhjogJWxBR9MJwe+mON+OA4NcDB3DdTwAuF12GKQUZRS1z
         /wOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678049821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKMdOBSHNrQUgSWU9KR0ogbHUm36R1MCQj8zVPpN6EQ=;
        b=NUTCrgA6Y8AP1gRMzkIZI6/gscvplIMblC30lYXe6WJbZ5GoLpKBviAPdt/VYOMebs
         XyJO5txaJawtw4O1is96ll9irTe3GV6KJIUSX4lrNUB0d7YndStN0ZFold8n1Kbyy+TO
         dQ7ADu17XQANy5nJ7KCkG6hh6GtutquDcYrSEjXkRJhuQNpDaZUurncH9V+wbkPJyOtM
         micOZVUA/PUW5uihlHKGD/upQSZoDNYBoGLHtez162naQTlZaASqAiezxBkSz+/ZgCIb
         Q4u6oPROQfVt28YDdG+5Y4N8+bXlkbNnd/LL4sOJ++VUxsPhJJdQjW1EV2pd7gYcc9Nk
         J5Kg==
X-Gm-Message-State: AO0yUKWwSn2QFuErEIFz4opcnuKSc1JPmrBnQ+YgzklI1/mZJcwW/+Xb
        LLPPITwdScmLLlisqSZOKTU0+Q8oLDbxrn2k
X-Google-Smtp-Source: AK7set9JmkSQG/Vtrq8HSHi055snSsQ75iU15X3bC3GR1ZZPzMtMJBUaiieJD+9Jtu7PbJHJEQIXfg==
X-Received: by 2002:a17:907:1c1d:b0:8b1:3a8e:232 with SMTP id nc29-20020a1709071c1d00b008b13a8e0232mr10822778ejc.74.1678049820999;
        Sun, 05 Mar 2023 12:57:00 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ay24-20020a170906d29800b0090953b9da51sm3615436ejb.194.2023.03.05.12.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 12:57:00 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 05/10] locking/mips: Wire up local_try_cmpxchg
Date:   Sun,  5 Mar 2023 21:56:23 +0100
Message-Id: <20230305205628.27385-6-ubizjak@gmail.com>
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

Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/mips/include/asm/local.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/local.h b/arch/mips/include/asm/local.h
index 08366b1fd273..b611361a760b 100644
--- a/arch/mips/include/asm/local.h
+++ b/arch/mips/include/asm/local.h
@@ -96,6 +96,8 @@ static __inline__ long local_sub_return(long i, local_t * l)
 
 #define local_cmpxchg(l, o, n) \
 	((long)cmpxchg_local(&((l)->a.counter), (o), (n)))
+#define local_try_cmpxchg(l, po, n) \
+	(try_cmpxchg_local(&((l)->a.counter), (po), (n)))
 #define local_xchg(l, n) (atomic_long_xchg((&(l)->a), (n)))
 
 /**
-- 
2.39.2

