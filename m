Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF666B658D
	for <lists+linux-arch@lfdr.de>; Sun, 12 Mar 2023 12:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjCLLgB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Mar 2023 07:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjCLLf4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Mar 2023 07:35:56 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F058811148
        for <linux-arch@vger.kernel.org>; Sun, 12 Mar 2023 04:35:37 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1755e639b65so11011007fac.3
        for <linux-arch@vger.kernel.org>; Sun, 12 Mar 2023 04:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678620934;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XjcDtI1pwVRGAPewN/AuluWv6QfCVbMYyve36OMm9hg=;
        b=li8qghEZ448TUwXSv98tglrk8qZWcA+acl1EBrZ8uax01xLEy5tDf12KqUZydt0yNe
         z8wvG+AzxJGyO1HTTcxz4jkwmK5HS6GpJfrfdR+obetGDAm0T3uaZx240Q6AE43i+vcD
         WGxpW+/bYVlndtVJvRhMV1ht2jHBziCz+edW3P074HPaagUOqjACcKeLaPlW87k3RHkc
         ufPGODvPEFWXtHpzjGVII6YBfvpUFespnUlQqXQQv4HCd87bOcP37bVzAimzt7K8g665
         Lfmr5u3rN8MrI9E/A1tRmNXBfJG8o/U5txF8DlM5hCUjOPU+qjBCYcdcSNmN6chLqvPK
         A1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678620934;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjcDtI1pwVRGAPewN/AuluWv6QfCVbMYyve36OMm9hg=;
        b=vxe92YEIJZarFH3kbm/Eam+Tu9UxxqWY+666Tvzibol5eULsKj9KJd3Y3TyBVGUWGT
         ot7kFL115Q2j7eaAdNO+D0S0gwLgZ6X32RcpMybtECHrKZuYuwHqnSHnXThpnFKeBCOc
         zY7/sddKvHCHe+GAJAl47LGz4nzKNMCI768LZzsCkjqkltt7qfcoXpO4ht3ShVFRmOMV
         eN1d6gM9gTb8cPft9/RPEONhqYuNN9qQrveAyYKbQ1CTqKuSVI/MVlO4yLkvLonVq4mP
         GIwnRt6Vic0Dn3tFAg+Kh8En3mmKvsmQu/qvfCQInQob4O3i/dDNpw/tlV3ZwD8bhXuQ
         rinw==
X-Gm-Message-State: AO0yUKVy7H9eNMPyAMjHrNxKQ/BXXN9z0eDVxdME1dM+iEkGJUnpZVhK
        XNTngVYN9gmeJjb82qGoqXANol8zx6xWKmV742o=
X-Google-Smtp-Source: AK7set9M2JkexVHtoB1+qnK+W4cR8aKp+NQi5THp+t521cRGzAjL6a4x/w3u365bc/3jUmM0+4mkwt8dETfx3cLQNHQ=
X-Received: by 2002:a05:6870:954b:b0:176:207d:59c with SMTP id
 v11-20020a056870954b00b00176207d059cmr11029254oal.5.1678620934313; Sun, 12
 Mar 2023 04:35:34 -0700 (PDT)
MIME-Version: 1.0
Reply-To: eng.kelly103@gmail.com
Sender: peterfuller301@gmail.com
Received: by 2002:a05:6359:4b93:b0:f6:58a2:343a with HTTP; Sun, 12 Mar 2023
 04:35:33 -0700 (PDT)
From:   "Eng. Kelly Williams" <eng.kelly103@gmail.com>
Date:   Sun, 12 Mar 2023 04:35:33 -0700
X-Google-Sender-Auth: B7yeAUBe9osJGyBLljvkpkmYpf0
Message-ID: <CACzHKnfd1cw+nS-J+6F5yVdOZaOLCoXGWLORDgVDz_g+y4CC1A@mail.gmail.com>
Subject: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.0 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,RISK_FREE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:2f listed in]
        [list.dnswl.org]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [peterfuller301[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [eng.kelly103[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [eng.kelly103[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  1.0 RISK_FREE No risk!
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello


My name is Eng. Kelly Williams I work with Texas oil and gas
Association USA. I need your honest cooperation to partner with me to
invest in your company or in any other viable business opportunity in
your country under mutual interest benefits. Our partnership will be
absolutely risk free, please I will also like to know the laws as it
concerns foreign investors like me.

I look forward to your cordial response



My Regards
Eng. Kelly Williams
