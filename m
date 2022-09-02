Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE435AB657
	for <lists+linux-arch@lfdr.de>; Fri,  2 Sep 2022 18:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236776AbiIBQOm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Sep 2022 12:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236790AbiIBQO1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Sep 2022 12:14:27 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D30F8F50
        for <linux-arch@vger.kernel.org>; Fri,  2 Sep 2022 09:11:07 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id bx38so2710356ljb.10
        for <linux-arch@vger.kernel.org>; Fri, 02 Sep 2022 09:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=iKyePjMR6JcMP1Qj4RmLCNhzZ5yfJFqs4bJprEY0TCg=;
        b=qhSNLJjRMxysvHptfCB10Bdau4LQ4gY3UTea5aysX1+MAMAfuWo1Sl/XqTh5pR8A4n
         8CKb6dsm0VSk7vVAnzvQWinU0/i2HU+g2lXi6aBXC4wQARAYIXE3xbGWdQ+m3yy4yayI
         ziBGFILnfWIjYCOB+0Z+Lxl+jdRjCuqLGwSlpNZufzsE8F4vTlE7iswUBqx2C17EZVhs
         0RgLoU3IVKIXY/EfIOs+Uu9XFMo8eshc2IU41fPrbaw0IN+/1MPz3iMWN8BPJ0XQVIUk
         nyoILHFNnrV+yS16iWtEMG1ogY1+WPPS+dCOZdiUm9NkIqyhT18NtZ7SprNChZID9NpP
         GPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=iKyePjMR6JcMP1Qj4RmLCNhzZ5yfJFqs4bJprEY0TCg=;
        b=17ld3IPV7tXNyiPtURCjn6YZ9UK/ZG2ArOc0LzmSh/aV8UAY+slU8NtpCPayISOBd3
         JvlpzXUyKetR26vnTW/DPWh95MYqNB4aYK5dE1I1xm0Welev+6qtVoVZjdPqudBlIaKE
         2WMgirZxXxGkqX8Fi0ovt/vL/05P9DbEC1xRQFXTyHRdsjoDotdg1+q6EsQmp8PgZgQf
         Z7sPrGchbxB98IQqZ09ipsNQniLhFHp+PFp7H7L8SlCTPLhW8PG7ICjza25peL7JRSme
         5CIhhc6JpshyYwk1+nsbnO92IfWtev8bP3lBZJLH6R/LR0CaGa474dlbz36dwhJ2O4Zc
         fhAg==
X-Gm-Message-State: ACgBeo24H16ofaSfpoAApLMq/0w1HXPlhI58cDALX/VBgeGAAaUXGLDG
        sLWD2GRnTgKT88B4ofSHXOZWNWzCss7aa8KcpyM=
X-Google-Smtp-Source: AA6agR54UTsfMtEuL/UIbOvs+2mtYJiY6gT2XdeAPWASH2ryPDT/KQOEdGGd+NSmKKpC/rYjCbpqABY0W8qFgHkvJjI=
X-Received: by 2002:a05:651c:150b:b0:25f:e204:9b99 with SMTP id
 e11-20020a05651c150b00b0025fe2049b99mr11096995ljf.498.1662135065910; Fri, 02
 Sep 2022 09:11:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:168a:b0:211:8661:64c3 with HTTP; Fri, 2 Sep 2022
 09:11:05 -0700 (PDT)
Reply-To: santanderbanking@gmx.co.uk
From:   Santander Bank UK <bonahis.firm1000@gmail.com>
Date:   Fri, 2 Sep 2022 09:11:05 -0700
Message-ID: <CAFM2_iQXbiVtHam3FRFxG4TMwMWjMX5BrzZwrzJbfWk8tjDfqw@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        FILL_THIS_FORM_LONG,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        LOTS_OF_MONEY,MONEY_FORM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_LOAN,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Dear Customer

This is to bring to your notice that your UN-cashed ATM VISA CARD with
the amount of ($900,000.00) United State Dollars which your pertiner
prepare and gave to you have been credited as cash by Our Santander
Bank office here and to be transferred to you through Our Santander
Bank .Our Santander Bank office have also been directed that the cash
will be transferred to you bit by bit. However you are requested to
contact our Santander Bank MONEY TRANSFER here in UK and also send us
your bellow information.

FULL NAME__________________
FULL CONTACT ADDRESS____________________
OCCUPATION_____________________
MOBILE PHONE____________________

Contact person: . . Mr. Thomas Taylor
Email: santanderbanking@gmx.co.uk
Thanks,
Director Santander Bank UK
Head Office London.England
