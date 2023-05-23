Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77B470DE98
	for <lists+linux-arch@lfdr.de>; Tue, 23 May 2023 16:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236815AbjEWOHs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 May 2023 10:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237148AbjEWOHN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 May 2023 10:07:13 -0400
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09631A8
        for <linux-arch@vger.kernel.org>; Tue, 23 May 2023 07:06:53 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4f3b9c88af8so3675859e87.2
        for <linux-arch@vger.kernel.org>; Tue, 23 May 2023 07:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684850752; x=1687442752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cbjvTSrc7JXib/jYCtsnbT8Pj+twUmj4f7HYrh8lbjo=;
        b=sbGtpTGQuKoJbgxbzRVNan0g3ud99MIRZSa7psCYWoBO5Gd4ngiT8ZH12iPBec4b/f
         sv3wsOpDUcgyEoNSv9DLn8MhriBoP7mFWJrbwaXvmmnHPiHxtLFssiTqg1+3y3/CC9Ng
         5q2rgJSMArU+a9KH/zpDgU6xvBjhPfINAqbfFlUmU6jcGaflnUqrxGDRKWin1C7+6kod
         w8BvwYrZ7iBnRg/rTBiAeldXSsgcYri6iPf4e7gY99RgCsDpQFTetppSyZ4a9pLmLesB
         A3f0/o/eDj5XUSN3Ow0r5byyVkJLGeP9SLaqg9YZ9I4EfNu99apZyryJofgUt+kGvN56
         2QFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684850752; x=1687442752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbjvTSrc7JXib/jYCtsnbT8Pj+twUmj4f7HYrh8lbjo=;
        b=PE7f5NS8twee2Vw5PbNMhjKn5Xfmzagz6kWIcH8kr/N7QTE+XKNghHMd68SQNSmJZF
         /3JF6ntSQs6TyBswL6vj/RsI5KYTCmvlS/NFWvKfsBONyOyZx/N2bXntebJkkMUVSwUQ
         BJp88mcg+HPnq6XIxc6iDtpXP9OEfIBTDRBb+2SCiLnLFnTR8ZTfwCUC3bgSZyTbMuLr
         nggIusEFTnpaWeILIKQiYbK/lXT6syA8Uc6a9rMXCf42td06c4tPaLXb7+1a2Mk9Wfky
         VmyH0RBD2cNd9HtaVpkHvqnwb4zDUmyZyxirup61qbaNFi52Pr+sp9Dy04okUrM0H1G1
         ME0g==
X-Gm-Message-State: AC+VfDwwi46iqW8kvvJW4s0s+nwA4eUkdn+0rNB/ERtz6UVXnOceNwsk
        QZr6/3g4bdPotR6VMIwFlY6sBw==
X-Google-Smtp-Source: ACHHUZ4dmn/sACren4W8D9ctT/gUYEfrO13/MXkcJGmecSW4AoiisQlk/HfzEBoneU9O1M8vm4LnAg==
X-Received: by 2002:a05:6512:4cd:b0:4f2:62aa:986a with SMTP id w13-20020a05651204cd00b004f262aa986amr4590844lfq.21.1684850752229;
        Tue, 23 May 2023 07:05:52 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id h28-20020ac2597c000000b004e9bf853c27sm1346562lfp.70.2023.05.23.07.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 07:05:51 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 May 2023 16:05:31 +0200
Subject: [PATCH v3 07/12] netfs: Pass a pointer to virt_to_page()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-virt-to-pfn-v6-4-rc1-v3-7-a16c19c03583@linaro.org>
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
        Linus Walleij <linus.walleij@linaro.org>
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

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 fs/netfs/iterator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
index 8a4c86687429..0431ec4a7298 100644
--- a/fs/netfs/iterator.c
+++ b/fs/netfs/iterator.c
@@ -240,7 +240,7 @@ static ssize_t netfs_extract_kvec_to_sg(struct iov_iter *iter,
 			if (is_vmalloc_or_module_addr((void *)kaddr))
 				page = vmalloc_to_page((void *)kaddr);
 			else
-				page = virt_to_page(kaddr);
+				page = virt_to_page((void *)kaddr);
 
 			sg_set_page(sg, page, len, off);
 			sgtable->nents++;

-- 
2.34.1

