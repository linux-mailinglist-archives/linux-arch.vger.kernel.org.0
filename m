Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334DC70DE8B
	for <lists+linux-arch@lfdr.de>; Tue, 23 May 2023 16:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237209AbjEWOH0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 May 2023 10:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237139AbjEWOHN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 May 2023 10:07:13 -0400
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B58919B
        for <linux-arch@vger.kernel.org>; Tue, 23 May 2023 07:06:53 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4f4b0a0b557so2514525e87.1
        for <linux-arch@vger.kernel.org>; Tue, 23 May 2023 07:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684850751; x=1687442751;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AahUWbcM1gd1dIKV3ajpbH14PSzhJ7702+mo4mqS4bw=;
        b=suXLt6rUWNL44vDNr6SS/EymOZ59hQEEGR2ZTXjDAx/AQp8nmKRLdaV2gUtIwvhf1t
         K/tAq8Z9ZeMTJQOstwd3dQeZhusrHSkrzN26dMfjKZk7yFZpGGO12BPMNBl2tvDMBfau
         g1zZ2x6JYoE8G1O6v87j/M1aKi8OQ0BwKQlzHWXj2LMSLUmsooYNVOxWag2uMhjdMbMO
         cWdFAnbyaQzYQHH2jmdzSe8LmY7bWDBbmxV219wusGP7c6T2/7oOh6ZhoSHiNVm9tLUm
         nypNbf4j0yWVIS8C0Jk1OKF5sOw3pb2FjFioOqx47SpRH6sLccmqgHJKbm5qp2ED/llI
         S7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684850751; x=1687442751;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AahUWbcM1gd1dIKV3ajpbH14PSzhJ7702+mo4mqS4bw=;
        b=AyZteiX8IqGWJJG4y+IH2prypp1nrkrAmfG4dEl7bT8dKS9pesMQp5mystjqoPklBr
         2jd88NPUM7peof3cgCyjK0qeAwiZvPcs4ymUhCtB52ZPI7PIhSKN8SBjiH/S95JC2291
         udnPg7Qz2pRnjqTVNXaiT3CFdjhbr/nA/6vlagpBqmv66l0xc838lRYTxBTzWJfIr1p0
         dq04ZaJnEPxi6mwD2I28xaZ3E8+4ZgSdx3pW11mIb8/aUAZQQzI3BpNl0QX9ls4hAWum
         61iQirLIoAx1bGT73LyjZnjMvpVRopIqP9k8bVrxDKP9Z3VZCyhbGxSnU5Eq0t7I/yq+
         IaQQ==
X-Gm-Message-State: AC+VfDwidL2vn/KKKvVVp2VhARooisv26MbEGE0bZFzop8IK6txZryop
        P5ApzkZeWz3yPWfeMakbPKpUyg==
X-Google-Smtp-Source: ACHHUZ4Heo+Mm/MZodpjJ/spmtQbla212mLAYM+FLuHrRCfUH/Fsho3ChrpMik0Ns6Cxqj0IZ64E6g==
X-Received: by 2002:a05:6512:908:b0:4ef:f11c:f5b0 with SMTP id e8-20020a056512090800b004eff11cf5b0mr4377803lft.54.1684850751226;
        Tue, 23 May 2023 07:05:51 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id h28-20020ac2597c000000b004e9bf853c27sm1346562lfp.70.2023.05.23.07.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 07:05:50 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 May 2023 16:05:30 +0200
Subject: [PATCH v3 06/12] cifs: Pass a pointer to virt_to_page() in
 cifsglob
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-virt-to-pfn-v6-4-rc1-v3-6-a16c19c03583@linaro.org>
References: <20230503-virt-to-pfn-v6-4-rc1-v3-0-a16c19c03583@linaro.org>
In-Reply-To: <20230503-virt-to-pfn-v6-4-rc1-v3-0-a16c19c03583@linaro.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-mm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org,
        linux-snps-arc@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Tom Talpey <tom@talpey.com>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Like the other calls in this function virt_to_page() expects
a pointer, not an integer.

However since many architectures implement virt_to_pfn() as
a macro, this function becomes polymorphic and accepts both a
(unsigned long) and a (void *).

Fix this up with an explicit cast.

Acked-by: Tom Talpey <tom@talpey.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 fs/cifs/cifsglob.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 414685c5d530..3d29a4bbbc40 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -2218,7 +2218,7 @@ static inline void cifs_sg_set_buf(struct sg_table *sgtable,
 		} while (buflen);
 	} else {
 		sg_set_page(&sgtable->sgl[sgtable->nents++],
-			    virt_to_page(addr), buflen, off);
+			    virt_to_page((void *)addr), buflen, off);
 	}
 }
 

-- 
2.34.1

