Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575F0651CBC
	for <lists+linux-arch@lfdr.de>; Tue, 20 Dec 2022 10:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbiLTJBL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Dec 2022 04:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiLTJBK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Dec 2022 04:01:10 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C312410BE
        for <linux-arch@vger.kernel.org>; Tue, 20 Dec 2022 01:01:07 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id c7so10428869qtw.8
        for <linux-arch@vger.kernel.org>; Tue, 20 Dec 2022 01:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17lwyaobo4ALTWAGFxuIVjrbJr75GEZe9syusnIHje4=;
        b=RoRG0JBIfocSvhSMtndzceixrcMt+9BKDiLeM+25siFyutclDm/ws6yqVQpY+K4IRQ
         gMlXdhdVTD2L+rSUvEuWW/WOZxylvALzE3g2k61aZSqcBiK1Y9pGPpptsg3UwbKtByvv
         7z0P+DmTC8azcOnBjAeT8Hp2XdNG8BO6B9eohtZCsqufTkK0SBWwSW2Xl97xSyCaHStW
         tvSus0/sLp19pqXRhznbvsFFE5yAHIVviNDByrjLO//BBplgoQkxNJkXLwSDLeLD28Wv
         oOlC51T93dmchbKFQensziKA9if/T49jdZ/yJsIKTHjWEaldwLCGAhSr16bVuR+nOIFg
         ZaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=17lwyaobo4ALTWAGFxuIVjrbJr75GEZe9syusnIHje4=;
        b=c/EI/w7tHuSIjSBJdH6P15n53MldIkm6HyW/JuP70koqpLn2/HPkL0rbsEmD/u8OSY
         7INdGdsphU3nAubFOLElT0JszGsV19u8kTeWnhmoNvmvFpzWm5JYaxPzIr6CxXlxOHzA
         9LsylW/Tm9UUnMV0GuiFYPcgzy0Kax1SFULMAruabfnU8Vb0BCJ4JmcGNpjc+As3WrA7
         ZWHwQTbORuK9FbnLYsQViAtQxbW9WTSWbRaQVRoGneH8qYOBTM4nX7ECACPqHPHnAzsc
         1mjcSRFFmUdl0Q2S+enW1IRHzoTtYl2deJ5cFqUoFEF9BesDx4nW856ZJkqt2u3G6Rbx
         9xhw==
X-Gm-Message-State: ANoB5plgcW42Qkao0uhwAvsKuXbvCxR+l9dkZSoYbnFyLux47qQde9Q1
        NgdbO6FPwamGmT+ob+P/ntRq2kU/DBedZQLGgTk=
X-Google-Smtp-Source: AA0mqf7PYvgPO7bILDzqaSZgG4L6JdAOycnO48PSE+5SVUG8k0lb2qzcahZqWrXMXVNkmnXwqUZqyFhwmPMSfIwtvXk=
X-Received: by 2002:a05:622a:5c99:b0:3a7:f546:4445 with SMTP id
 ge25-20020a05622a5c9900b003a7f5464445mr6199345qtb.550.1671526866846; Tue, 20
 Dec 2022 01:01:06 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ad4:580a:0:b0:513:fbfd:e4e0 with HTTP; Tue, 20 Dec 2022
 01:01:06 -0800 (PST)
Reply-To: scott.morgan6219@firemail.de
From:   Scott morgan <morganscott554@gmail.com>
Date:   Tue, 20 Dec 2022 10:01:06 +0100
Message-ID: <CADEYJL8uuZpbqiEhXD3q+yPA1jqLXZ7=hBa1EtKwctJQ=-kzvQ@mail.gmail.com>
Subject: RESPONSE..
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.7 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_80,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,LOTTO_DEPT,
        MILLION_HUNDRED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:844 listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8983]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [morganscott554[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [morganscott554[at]gmail.com]
        *  0.0 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.2 LOTTO_DEPT Claims Department
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

-- 
I am  Scott Morgan, director of  claims department with a bank here in
London,  United kingdom. I wish to notify you that you are clear to
claim the total sum of Twenty Million Five Hundred Thousand British
pounds (GBP20.5M)in the codicil and last statement of a Deceased
Customer  (Name now withheld for security reasons). Kindly contact me
for more details.

Yours faithfully.
Scott Morgan.
