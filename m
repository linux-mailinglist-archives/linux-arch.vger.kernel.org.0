Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB6C535180
	for <lists+linux-arch@lfdr.de>; Thu, 26 May 2022 17:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347967AbiEZPdt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 May 2022 11:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346486AbiEZPdr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 May 2022 11:33:47 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C12E6899E
        for <linux-arch@vger.kernel.org>; Thu, 26 May 2022 08:33:46 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k30so2605541wrd.5
        for <linux-arch@vger.kernel.org>; Thu, 26 May 2022 08:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=pcOIqjfOGD4mtjARe3uelHp7io5D0VG5aulAy4XSsSE=;
        b=OyaRzhiBGq19hx91ypN3/Is9e83mqOXLZx5qRmAnt9wJXFDBkel6oX7OZhuAey3yv8
         dBUH6oZxDP+T4Jw2KCPGiRkPpEELgbqJtbMyUaFrcx/sCUazNduCCOuzRO4aCr12kFEc
         TmnUEMKCfpamtxsLuO5tixC4NpQcMx0qUrZWD0Stz0EpIRiE6flY+o6K4svj+V+8T034
         Qz9P5rNVaI0s04Z/aUTdLu7slAUfrh4R/WDQH9J/bo7ARZlWUCCxroQk4RZnCEMnrCvH
         HGbY5QP0coimTZZ5eXDlO6UGWrH/4TpdhIYTbQvcSkP77Pest3z/aJPwkZbeO3d3ek5+
         19kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=pcOIqjfOGD4mtjARe3uelHp7io5D0VG5aulAy4XSsSE=;
        b=K+ymIJeXgJhhSGuqqjQ7Swzg4Jwi8OlB5BGo076BlLwpzjIxoq4aW1AC7upVVJidqQ
         WfAs1/ncnVSopIaz8mJAzOt8VOw1qBJftvvPh7BrV6MFAQhBwsmNlvzpbsY6RK9NUYm0
         kq3bwrzNWzeb2v1/pxoHdRD7WZx35gpkT7goKEb9JpknbGlSvLpp7ozabPd/uu/gSOzR
         oUAg1K8VI4O0wNjBhfx4nQVYrE3SeVmhXLoiYDqJO6vW6TGMZtj+jwB+OkdSTsZ4FHG4
         wJhxKo+NxIcnz4NuSnYCUFezgJ9ULbPXwqFg5JpyQew6KYrJGAk5Of1avtUoFMZCnp19
         6UeQ==
X-Gm-Message-State: AOAM53370wZYPvoZEnBDwkKFEyLaPOVX3d9roD5E31I77b5l1viu9S5v
        Jk3oJ+jcIzYVXq5ZHg6rVy42kWofzZE/Xx1VuOM=
X-Google-Smtp-Source: ABdhPJz4ymsfpZ6XE9nNt+dQEXfMcgEAWohhEJk5D1aVJE7siDYkIb9/O6pw09BM31g5F5i7nVQgAqKRkiMjZDBMmhE=
X-Received: by 2002:a5d:4892:0:b0:20c:d4eb:1886 with SMTP id
 g18-20020a5d4892000000b0020cd4eb1886mr33156092wrq.96.1653579224973; Thu, 26
 May 2022 08:33:44 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mr.a.manga99@gmail.com
Sender: arnettdavid1991@gmail.com
Received: by 2002:adf:c98a:0:0:0:0:0 with HTTP; Thu, 26 May 2022 08:33:44
 -0700 (PDT)
From:   "Mr. Amos Manga" <mr.a.manga99@gmail.com>
Date:   Thu, 26 May 2022 08:33:44 -0700
X-Google-Sender-Auth: ykbJWHFNl0fEWNmMObs8GR2XEBA
Message-ID: <CAPpYQmnBp-S_EEAy1G=syNfWGj5_teDNsmSREFGJKOBrUhoW6w@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORM_FRAUD_5,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FORM_SHORT,MONEY_FRAUD_5,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Good day,

I know this means of communication may not be morally right to you as
a person but I also have had a great thought about it and I have come
to conclusion which I am about to share with you.

INTRODUCTION: I am a banker; I hope you will cooperate with me as a
partner in a project of transferring an abandoned fund of late
customer of the bank worth $18,000,000 (Eighteen Million Dollars
only).

This will be disbursed or shared between the both of us in these
percentages, 55% for me and 45% for you. Contact me immediately if
that is alright for you so that we can enter into an agreement before
we start processing for the transfer of the funds. If you are
satisfied with this proposal, please provide the below details for the
Mutual Confidentiality Agreement

1. Full Name and Address

2. Occupation and Country of Origin

3. Telephone Number

I wait for your response so that we can commence on this transaction
as soon as possible.

Regards,

Mr.Amos Manga.
